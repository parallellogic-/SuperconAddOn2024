#include "STM8s.h"
#include "api.h"
#include "stm8s_gpio.h"
#include "stm8s_uart1.h"

//time state
u32 api_counter=0;//counting the amount of sleep each led has taken

//LED pwm control state machine
#define LED_COUNT 31 //6 RGB (3 LEDs each) + 12 white + 1 debug
#define DEBUG_LED 18 //index of the debug led
u16 pwm_brightness[LED_COUNT][2];//array index, [A vs B side live]
u8 pwm_brightness_index[LED_COUNT][2];//led index, [A vs B side live]
u8 pwm_brightness_buffer[LED_COUNT];//hold LED values before flushing
u16 pwm_sleep[2];//[A vs B side live], how many LED LSBs to wait with LEDs OFF before putting LEDs back ON
u8 pwm_led_count[2];//how many visible LEDs to cycle through
u16 pwm_sleep_remaining=0;
u8 pwm_visible_index=0;//which led is visible this moment in time
u8 pwm_state=0;//LSB (bit 0) is index of pwm_brightness to pull pwm info from.  bit 1 is a flag the application layer raises for the API layer to clear requesting a switch

//buttons
#define BUTTON_COUNT 2
u32 button_start_ms;//if 0, then button is unpressed.  if >0 then button si pressed and is waiting for release
bool button_pressed_event[BUTTON_COUNT][2];//event flag registering a button push
#define BUTTON_LONG_PRESS_MS 512 //number of millisconds to consititue a long press rather than a short press
#define BUTTON_MINIMUM_PRESS_MS 50 //minimum time a button needs to be pressed down to be registered as a complete button press

u16 temp_delete_me=0;
u16 temp3_delete_me=0;

void hello_world()
{//basic program that blinks the debug LED ON/OFF
	u16 temp2_delete_me;
	u16 temp4_delete_me;
	bool is_high=0;
	long frame=0;
	//GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
	while(1)
	{
		frame++;
		if(frame%256==0)
		{
			//temp_delete_me=(frame/64/256)%2?(~(frame/64)):(frame/64);
			temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
			temp2_delete_me=temp2_delete_me*temp2_delete_me;
			temp2_delete_me=temp2_delete_me>>6;
			temp_delete_me=temp2_delete_me;
			temp4_delete_me=0x00FF&((frame/256/256)%2?((frame/256)):(~frame/256));
			temp4_delete_me=temp4_delete_me*temp4_delete_me;
			temp4_delete_me=temp4_delete_me>>6;
			temp3_delete_me=(temp4_delete_me%2)<<9;
			//temp_delete_me=(frame/256/256)%2?(~(frame/256)):(frame/256);
			flush_leds(7);
		}
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
		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
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
	return !is_button_down(2) && !get_button_event(0,1);
}

//exit developer mode if SWIM pin floats high
bool is_developer_valid()
{
	return is_button_down(2) && !get_button_event(0,1);
}

void setup_main()
{
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
		
	//run pwm interrupt at 2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	TIM2->CCR1H=0;//this will always be zero based on application architecutre
	TIM2->PSCR= 4;// init divider register 16MHz/2^X
	TIM2->ARRH= 16;// init auto reload register
	TIM2->ARRL= 255;// init auto reload register
	//TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	//TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
	enableInterrupts();
	
}

u32 millis()
{
	return api_counter>>10;
}

//log short or long rpess button events for applicatio layer to use as user input
//PRECON: don't press buttons at the same time (state machine gets confused).  Leveraging just one u32 to store timestamp of button press start to conserve memory
//PRECON: assuming button is pressed less than 1 minute (otherwise state machine gets confused)
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

//returns true if the API has registered the requested type of event
bool get_button_event(u8 button_index,bool is_long)
{ return button_pressed_event[button_index][is_long]; }

//clears the specified type of event from the event queue
bool clear_button_event(u8 button_index,bool is_long)
{
	bool out=button_pressed_event[button_index][is_long];
	button_pressed_event[button_index][is_long]=0;
	return out;
}

void clear_button_events()
{
	u8 iter;
	for(iter=0;iter<BUTTON_COUNT;iter++)
	{
		clear_button_event(iter,0);
		clear_button_event(iter,1);
	}
}

//instantaneous check to see if button is pressed (grounded)
bool is_button_down(u8 index)
{
	switch(index)
	{
		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
	}
	return 0;
}

//millisecond-ish interrupt and LED OFF to ON
@far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
	u16 this_sleep=temp_delete_me;
	bool is_debug_led=0;
	bool is_other_led=0;
	//turn OFF LEDs
	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
  TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
	pwm_visible_index++;
	if(pwm_visible_index>6) pwm_visible_index=0;
	
	if(pwm_visible_index==0)//simulate other LEDs ON
	{
		is_debug_led=this_sleep>0;
	}else if(pwm_visible_index==1){
		this_sleep=temp3_delete_me;
		is_other_led=this_sleep>0;
	}else{
		this_sleep=0x400;
	}
	if(this_sleep<1) this_sleep=1;
	// Disable TIM2 to ensure a consistent write operation
	
  TIM2->CNTRH = 0;// Set the high byte of the counter
  TIM2->CNTRL = 0;// Set the low byte of the counter
	TIM2->ARRH= this_sleep>>8;// init auto reload register
	TIM2->ARRL= this_sleep&0x00FF;// init auto reload register
	api_counter+=this_sleep;
	
	if(is_debug_led)
		//GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
		set_led(DEBUG_LED);
	if(is_other_led)
	{
		set_led(1);
	}
	
  // Re-enable TIM2 after setting the counter value
  TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
}

//enable 1 led to be visible: emit light
void set_led(u8 led_index)
{
	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
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
	};
	set_mat(led_lookup[led_index][0],1);
	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
}

//enable high or low side of an LED to form a complete circuit
void set_mat(u8 mat_index,bool is_high)
{
	GPIO_TypeDef* GPIOx;
	GPIO_Pin_TypeDef GPIO_Pin;
	if(mat_index==0)
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
	}
	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
	GPIOx->DDR |= (uint8_t)GPIO_Pin;
	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
}

//LED interrupt (LED ON to OFF)
/*@far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
	//u16 brightness=temp_delete_me;
	//if(brightness>=250) brightness=250;
	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
}*/

void flush_leds(u8 led_count)
{
	
	/*u8 led_read_index=0,led_write_index=0;
	u8 buffer_index;//write to the buffer index that is NOT being used/volatile
	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
	//write application layer data (brightness values) into the pwm volatile memory
	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
	{
		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
		{//if these is an led with a non-zero brightness to be shown, then add it to the relevant list
			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
			led_write_index++;
			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
		}
		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
	}
	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
	//note: user may ahve requeted more LEDs to be lit then are actually there, so use as-written LED count, led_write_index,
	//rather than user-specified value: led_count
	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
	*/
}

//assumes max brightness
void set_hue_max(u8 index,u16 color)
{
	const u8 brightness=255;
	u8 red=0,green=0,blue=0;
	u16 residual_16=color%(0x2AAB);
	u8 residual_8=(residual_16<<8)/0x2AAB;
	switch(color/(0x2AAB))
	{
		case 0:{
			red=brightness;
			green=residual_8;
			blue=0;
			break;
		}case 1:{
			red=brightness-residual_8;
			green=brightness;
			blue=0;
			break;
		}case 2:{
			red=0;
			green=brightness;
			blue=residual_8;
			break;
		}case 3:{
			red=0;
			green=brightness-residual_8;
			blue=brightness;
			break;
		}case 4:{
			red=residual_8;
			green=0;
			blue=brightness;
			break;
		}case 5:{
			red=brightness;
			green=0;
			blue=brightness-residual_8;
			break;
		}default:{}
	}
	set_rgb(index,0,red);
	set_rgb(index,1,green);
	set_rgb(index,2,blue);
}

void set_rgb(u8 index,u8 color,u8 brightness)
{
	pwm_brightness_buffer[index*3+color]=brightness;
}

void set_white(u8 index,u8 brightness)
{
	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
}

//debug led status
void set_debug(u8 brightness)
{
	pwm_brightness_buffer[DEBUG_LED]=brightness;
}

void set_matrix_high_z()
{
	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
}

u8 get_eeprom_byte(u16 eeprom_address)
{
	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
}

