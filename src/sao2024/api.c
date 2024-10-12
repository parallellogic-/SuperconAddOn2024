#include "STM8s.h"
#include "api.h"
#include "stm8s_gpio.h"
#include "stm8s_uart1.h"

//time state
u16 frame_counter=0;//increments once all LEDs have physically been illuminated once
u32 atomic_counter=0;

//LED pwm control state machine
//TODO: DEBUG_BROKEN
u16 pwm_brightness[LED_COUNT][2]={{1,1}};//array index, [A vs B side live]
u8 pwm_brightness_index[LED_COUNT][2];//led index, [A vs B side live]
u8 pwm_brightness_buffer[LED_COUNT];//hold LED values before flushing
u16 pwm_sleep[2]={1,1};//[A vs B side live], how many LED LSBs to wait with LEDs OFF before putting LEDs back ON
u8 pwm_led_count[2]={1,1};//how many visible LEDs to cycle through
u8 pwm_visible_index=0;//which led is visible this moment in time
u8 pwm_state=0;//LSB (bit 0) is index of pwm_brightness to pull pwm info from.  bit 1 is a flag the application layer raises for the API layer to clear requesting a switch

//buttons
#define BUTTON_COUNT 2
u32 button_start_ms;//if 0, then button is unpressed.  if >0 then button si pressed and is waiting for release
bool button_pressed_event[BUTTON_COUNT][2];//event flag registering a button push
#define BUTTON_LONG_PRESS_MS 512 //number of millisconds to constitue a long press rather than a short press
#define BUTTON_MINIMUM_PRESS_MS 50 //minimum time a button needs to be pressed down to be registered as a complete button press

void hello_world()
{//basic program that blinks the debug LED ON/OFF
	const u8 cycle_speed=8;//larger=faster
	const u8 white_speed=5;//smaller=faster
	u16 frame=0;
	while(1)
	{
		frame++;
		set_hue_max(0,(frame<<cycle_speed));
		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
		set_hue_max(2,(frame<<cycle_speed)+0x5556);
		set_hue_max(3,(frame<<cycle_speed)+0x8000);
		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
		set_hue_max(5,(frame<<cycle_speed)+0xD554);
		//set_debug(  (frame>>6)&0x01?(~(frame<<2)):(frame<<2));
		//set_white((frame>>6)%12,(millis()/1024)&0x01?0xFF:0);
		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
		flush_leds(7);
	}
}

u16 get_random(u16 x)
{
	u16 a=1664525;
	u16 c=1013904223;
	return a * x + c;
}

void setup_serial(bool is_enabled,bool is_fast_baud_rate)
{
	if(is_enabled)
	{
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
		UART1_DeInit();
		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
		UART1_Cmd(ENABLE);
	}else{
		UART1_Cmd(DISABLE);
		UART1_DeInit();
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	}
}

//leave application mode if SWIM pin floats high or sleep mode is activated (long press on left button)
bool is_application_valid()
{
	return 1;//!is_button_down(2) && !get_button_event(0,1);
}

//exit developer mode if SWIM pin floats high
bool is_developer_valid()
{
	return 0;//is_button_down(2) && !get_button_event(0,1);
}

void setup_main()
{
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
		
	//run pwm interrupt at ~2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	//TIM2->CCR1H=0;//this will always be zero based on application architecutre
	TIM2->PSCR= 5;// init divider register 16MHz/2^X
	TIM2->ARRH= 0;// init auto reload register
	TIM2->ARRL= 255;// init auto reload register
	//TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	//TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
	enableInterrupts();
}

u32 millis()
{
	return atomic_counter>>9;//TIM2->PSCR + shift = 14
}

//log short or long press button events for application layer to use as user input
//PRECON: don't press buttons at the same time (state machine gets confused).  Leveraging just one u32 to store timestamp of button press start to conserve memory
//PRECON: assuming button is pressed less than ~1 minute (otherwise state machine gets confused)
void update_buttons()
{
	bool is_any_down=0;
	u8 button_index;
	u16 elapsed_pressed_ms=millis()-button_start_ms;
	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
	{
		if(is_button_down(button_index))
		{
			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
			is_any_down=1;
		}else{
			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
			//else ignore button press
		}
	}
	if(!is_any_down) button_start_ms=0;
}

//returns true if the API has registered the requested type of event (without clearning it, like peek())
bool get_button_event(u8 button_index,bool is_long)
{ return button_pressed_event[button_index][is_long]; }

//clears the specified type of event from the event queue, like pop()
bool clear_button_event(u8 button_index,bool is_long)
{
	bool out=button_pressed_event[button_index][is_long];
	button_pressed_event[button_index][is_long]=0;
	return out;
}

bool clear_button_events()
{
	u8 iter;
	bool out=0;
	for(iter=0;iter<BUTTON_COUNT;iter++)
	{
		out|=clear_button_event(iter,0);
		out|=clear_button_event(iter,1);
	}
	return out;
}

//instantaneous check to see if button is pressed (grounded)
bool is_button_down(u8 index)
{
	switch(index)
	{
		//case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button //DEBUG_BROKEN
		//case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
	}
	return 0;
}

//millisecond-ish interrupt and LED OFF to ON
@far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
	u16 sleep_counts=1;
	//turn OFF LEDs (float all matrix pins):
	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
	
	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
	
  TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
	{
		sleep_counts=pwm_sleep[buffer_index];
	}
	if(pwm_visible_index>pwm_led_count[buffer_index])
	{//reached end of frame, including wait period
		frame_counter++;
		pwm_visible_index=0;//formally start new frame
		update_buttons();
		if(pwm_state&0x02)
		{
			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
		}
	}
	if(pwm_visible_index<pwm_led_count[buffer_index])
	{
		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
	}
	pwm_visible_index++;
	atomic_counter+=sleep_counts;
	
  TIM2->CNTRH = 0;// Set the high byte of the counter
  TIM2->CNTRL = 0;// Set the low byte of the counter
	TIM2->ARRH= sleep_counts>>8;// init auto reload register
	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
  // Re-enable TIM2 after setting the counter value
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
  TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
}

//enable 1 led to be visible: emit light
void set_led_on(u8 led_index)
{
	/*const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
		{6,6},//debug; GND is tied low, no charlieplexing involved
		{1,0},//LED7
		{2,0},//LED8
		{0,1},//LED9
		{2,1},//LED10
		{0,2},//LED11
		{1,2},//LED12
		{4,3},//LED13
		{5,3},//LED14
		{3,4},//LED15
		{5,4},//LED16
		{3,5},//LED17
		{4,5} //LED18
	};*/
	//const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat //MAGIC
	//	{0,1},{1,0},{5,0},{6,0},{6,5},{4,3},{3,4},{0,5},{0,4},{0,3},//reds
	//	{0,2},{2,0},{5,1},{6,1},{6,4},{5,3},{3,5},{0,6},{1,4},{1,3},//greens
	//	{1,2},{2,1},{5,2},{6,2},{5,4},{6,3},{3,6},{1,6},{2,4},{2,3},//blues
	//	//{7,7},//debug; GND is tied low, no charlieplexing involved
	//	{3,0},//LED6
	//	{3,1},//LED4
		/*{3,2},//LED5
		{4,0},//LED14
		{1,5},//LED8
		{2,5},//LED9
		{4,1},//LED10
		{4,2},//LED16
		{2,6},//LED17
		{4,6},//LED12
		{4,5},//LED13
		{5,6}*/ //LED11
	//};
	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
		{7,7},//debug; GND is tied low, no charlieplexing involved
		{3,0},//LED6
		{3,1},//LED4
		{3,2},//LED5
		{4,0},//LED14
		{1,5},//LED8
		{2,5},//LED9
		{4,1},//LED10
		{4,2},//LED16
		{2,6},//LED17
		{4,6},//LED12
		{4,5},//LED13
		{5,6} //LED11
	};
	set_mat(led_lookup[led_index][0],1);
	//if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][0],1);
	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
	//set_mat(led_lookup[led_index][1],0);
}

//enable high or low side of an LED to form a complete circuit
void set_mat(u8 mat_index,bool is_high)
{
	GPIO_TypeDef* GPIOx;
	GPIO_Pin_TypeDef GPIO_Pin;
	/*if(mat_index==0)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_3;
	}
	if(mat_index==1)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_4;
	}
	if(mat_index==2)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_5;
	}
	if(mat_index==3)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_6;
	}
	if(mat_index==4)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_7;
	}
	if(mat_index==5)
	{
		GPIOx=GPIOD;
		GPIO_Pin=GPIO_PIN_2;
	}
	if(mat_index==6)
	{
		GPIOx=GPIOA;
		GPIO_Pin=GPIO_PIN_3;
	}*/
	if(mat_index==0)//DEBUG_BROKEN
	{
		GPIOx=GPIOD;
		GPIO_Pin=GPIO_PIN_4;
	}
	if(mat_index==1)
	{
		GPIOx=GPIOD;
		GPIO_Pin=GPIO_PIN_2;
	}
	if(mat_index==2)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_7;
	}
	if(mat_index==3)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_6;
	}
	if(mat_index==4)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_5;
	}
	if(mat_index==5)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_4;
	}
	if(mat_index==6)
	{
		GPIOx=GPIOC;
		GPIO_Pin=GPIO_PIN_3;
	}
	if(mat_index==7)
	{
		GPIOx=GPIOA;
		GPIO_Pin=GPIO_PIN_3;
	}
	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
	GPIOx->DDR |= (uint8_t)GPIO_Pin;
	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
}

//led_count is the effective number of LEDs that are visible (ex. red at 128 + blue at 128  = 1 led_count)
void flush_leds(u8 led_count)
{
	u8 led_read_index=0,led_write_index=0;
	u16 read_brightness;//needs to be u16 before square operation, otherwise returns errant value
	u8 buffer_index;//write to the buffer index that is NOT being used/volatile
	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
	
	if(led_count==0) led_count=1;//min value
	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
	//write application layer data (brightness values) into the pwm volatile memory
	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
	{
		read_brightness=pwm_brightness_buffer[led_read_index];
		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
		{//if these is an led with a non-zero brightness to be shown, then add it to the relevant list
			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
			led_write_index++;
		}
		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
	}
	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
	if(led_write_index==0)
	{//no non-zero LEDs, so fill in default values
		led_write_index=1;
		pwm_sleep[buffer_index]=6<<10;
		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
		pwm_brightness[0][buffer_index]=1;
	}
	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
	//note: user may have requeted more LEDs to be lit then are actually there, so use the found LED count (leds>0 brightness), led_write_index,
	//rather than user-specified value: led_count (effective time to be ON for each frame)
	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
}

//assumes max brightness
void set_hue_max(u8 index,u16 color)
{
	//const u8 MAX_BRIGHTNESS=255;//for >1 LED ON fully at a time
	//const u8 BRIGHTNESS_STEP=43;//CEIL(0x2AAB/MAX_BRIGHTNESS)
	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2
	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
	u8 red=0,green=0,blue=0;
	u8 residual=0;
	u8 iter;
	for(iter=0;iter<6;iter++)
	{
		if(color<0x2AAB)
		{
			residual=color/BRIGHTNESS_STEP;
			break;
		}
		color-=0x2AAB;
	}
	if(iter==0){ red=MAX_BRIGHTNESS; green=residual; }
	if(iter==1){ green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; }
	if(iter==2){ green=MAX_BRIGHTNESS; blue=residual; }
	if(iter==3){ blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; }
	if(iter==4){ blue=MAX_BRIGHTNESS; red=residual; }
	if(iter==5){ red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; }
	set_rgb(index,0,red);
	set_rgb(index,1,green);
	set_rgb(index,2,blue);
}

void set_rgb(u8 index,u8 color,u8 brightness)
{
	pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness;
}

void set_white(u8 index,u8 brightness)
{
	pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness;
}

//debug led status
void set_debug(u8 brightness)
{
	pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness;
}

void set_matrix_high_z()
{
	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
	
	
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_3));//DEBUG_BROKEN
}

u8 get_eeprom_byte(u16 eeprom_address)
{
	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
}