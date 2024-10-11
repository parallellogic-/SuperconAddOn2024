#include "STM8s.h"
#include "api.h"
#include "stm8s_gpio.h"
#include "stm8s_uart1.h"

//time state
u32 api_counter=0;//increments roughly every millisecond, give-or-take a factor of 2 based on clock divider settings, this is the basis of millis()

//application space settings
#define LED_COUNT 31 //10 RGB (3 LEDs each) + 12 white + 1 debug
#define DEBUG_LED 6 //index of the debug led
u8 pwm_brightness_buffer[LED_COUNT];

//LED pwm control state machine
const u8 PWM_MAX_PERIOD=255;//interrupt counter has max value, so delaying longer requires multiple interrupt triggers
u8 pwm_brightness[LED_COUNT][2][2];//array index, [led index, led pwm], [A vs B side live]
u16 pwm_sleep[2];//[A vs B side live], how many LED LSBs to wait with LEDs OFF before putting LEDs back ON
u8 pwm_led_count[2];//how many LEDs to cycle through
u16 pwm_sleep_remaining=0;
u8 pwm_led_index=0;
u8 pwm_state=0;//LSB (bit 0) is index of pwm_brightness to pull pwm info from.  bit 1 is a flag the application layer raises for the API layer to clear requesting a switch

//buttons
#define BUTTON_COUNT 2
u32 button_start_ms;//if 0, then button is unpressed.  if >0 then button si pressed and is waiting for release
bool button_pressed_event[BUTTON_COUNT][2];//event flag registering a button push
#define BUTTON_LONG_PRESS_MS 512 //number of millisconds to consititue a long press rather than a short press
#define BUTTON_MINIMUM_PRESS_MS 50 //minimum time a button needs to be pressed down to be registered as a complete button press

u8 temp_delete_me=0;

void hello_world()
{//basic program that blinks the debug LED ON/OFF
	u16 temp2_delete_me;
	bool is_high=0;
	long frame=0;
	//GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
	while(1)
	{
		frame++;
		//temp_delete_me=(frame/64/256)%2?(~(frame/64)):(frame/64);
		temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
		temp2_delete_me=temp2_delete_me*temp2_delete_me;
		temp2_delete_me=temp2_delete_me/256;
		temp_delete_me=temp2_delete_me;
		//temp_delete_me=(frame/256/256)%2?(~(frame/256)):(frame/256);
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

//exit sleep mode if any button is pushed
bool is_sleep_valid()
{
	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
}

void setup_main()
{
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
		
	//run pwm interrupt at 2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	TIM2->CCR1H=0;//this will always be zero based on application architecutre
	TIM2->PSCR= 5;// init divider register 16MHz/2^X
	TIM2->ARRH= 0;// init auto reload register
	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
	enableInterrupts();
	
}

u32 millis()
{
	return api_counter;
}

void set_millis(u32 new_time)
{
	api_counter=new_time;
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
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
	api_counter++;
	//read buttons (if in application mode), update state
	
	//read audio, update state
	if(api_counter%7==0 && temp_delete_me>0)//simulate other LEDs ON
		GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
	TIM2->CCR1L = temp_delete_me;//set wakeup alarm relative to current time
}

//LED interrupt (LED ON to OFF)
@far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
	//u16 brightness=temp_delete_me;
	//if(brightness>=250) brightness=250;
	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
	set_matrix_high_z();
}

void flush_leds(u8 led_count)
{
	u8 led_read_index=0,led_write_index=0;
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
}

void set_hue(u8 index,u16 color,u8 brightness)
{
	u8 red=0,green=0,blue=0;
	u16 residual=color%(0x2AAB);
	residual=(u8)(residual*brightness/0x2AAB);
	switch(color/(0x2AAB))//0xFFFF/6
	{
		case 0:{
			red=brightness;
			green=residual;
			blue=0;
			break;
		}case 1:{
			red=brightness-residual;
			green=brightness;
			blue=0;
			break;
		}case 2:{
			red=0;
			green=brightness;
			blue=residual;
			break;
		}case 3:{
			red=0;
			green=brightness-residual;
			blue=brightness;
			break;
		}case 4:{
			red=residual;
			green=0;
			blue=brightness;
			break;
		}case 5:{
			red=brightness;
			green=0;
			blue=brightness-residual;
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
	//GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
	//GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
}

u8 get_eeprom_byte(u16 eeprom_address)
{
	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
}

