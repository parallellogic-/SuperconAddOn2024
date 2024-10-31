//interface with the hardware
#include "STM8s.h"
#include "api.h"
#include "stm8s_i2c.h"
#include "stm8s_gpio.h"

//time state
u32 atomic_counter=0;

//LED pwm control state machine
u16 pwm_brightness[LED_COUNT][2]={{1,1}};//array index, [A vs B side live]
u8 pwm_brightness_index[LED_COUNT][2];//led index, [A vs B side live]
u8 pwm_brightness_buffer[LED_COUNT];//hold LED values before flushing
u16 pwm_sleep[2]={1,1};//[A vs B side live], how many LED LSBs to wait with LEDs OFF before putting LEDs back ON
u8 pwm_led_count[2]={1,1};//how many visible LEDs to cycle through
u8 pwm_visible_index=0;//which led is visible this moment in time
u8 pwm_state=0;//LSB (bit 0) is index of pwm_brightness to pull pwm info from.  bit 1 is a flag the application layer raises for the API layer to clear requesting a switch
bool is_valid_i2c_received=0;//stay in application state until a valid i2c command is received, at which point drop out of application into developer mode

//buttons
#define BUTTON_COUNT 2
u32 button_start_ms=0;
bool is_right_button_down=0;
bool button_pressed_event[BUTTON_COUNT][2];//event flag registering a button push
#define BUTTON_LONG_PRESS_MS 512 //number of millisconds to consititue a long press rather than a short press
#define BUTTON_MINIMUM_PRESS_MS 50 //minimum time a button needs to be pressed down to be registered as a complete button press

//I2C
#define ADDRESS_COUNT_WRITE 7//amount of RAM to allocate to I2C read/writable registers
#define ADDRESS_COUNT_READ 9//number of registers that can be read from
u8 u8_My_Buffer[ADDRESS_COUNT_WRITE];//the I2C registers
u8 *u8_MyBuffp;//this is the pointer to the register being read/written to
u8 MessageBegin;//flag to signal if the first byte of the I2C message has been read
u8 this_addr;//similar in function to u8_MyBuffp, but not a pointer
bool is_developer_debug=1;//hold state of the debug LED so taht each time the user writes to it, the LED toggles
u8 developer_flag=0;//can't call flush_leds within I2C service routine because flush waits for the LED interrupt to finish, which can't happen when inside another interrupt
//so raise flag for developer to service interrupt.  The value is the effective number of LEDs to flush
u8 i2c_transaction_byte_count=0;//if there are multiple bytes written to the LED input register, then respond accordingly (if off, flush the LEDs)

void hello_world()
{//basic program that verifies LEDs are working correctly
	const u8 cycle_speed=10;//larger=faster
	const u8 white_speed=2;//smaller=faster
	u16 frame=0;
	while(1)
	{
		frame++;
		set_hue_max(0,(frame<<cycle_speed));
		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
		set_hue_max(2,(frame<<cycle_speed)+0x5556);
		set_hue_max(3,(frame<<cycle_speed)+0x8000);
		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
		set_hue_max(5,(frame<<cycle_speed)+0xD554);//each of the 6 LEDs is 1/6th of the way further along the rainbow
		set_white((frame>>(white_speed+1))%12,0xFF);//set one of the 12 LEDs pure white
		flush_leds(7);
	}
}

bool is_application()
{//if an i2c command is received, exit the application and drop into developer mode to respond to i2c content only
	return !is_valid_i2c_received;
}

u16 get_random(u16 x)
{//choose random Simon Says secret code
	u16 a=1664525;
	u16 c=1013904223;
	return a * x + c;
}

void setup_main()
{
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
	
	//configure LED interrupt on TIM2
	//run pwm interrupt at ~2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	TIM2->PSCR= 5;// init divider register 16MHz/2^X
	TIM2->ARRH= 0;// init auto reload register
	TIM2->ARRL= 255;// init auto reload register
	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt

	//enable user input buttons
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
	
	//setup I2C
	I2C_DeInit();
	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);//100kHz I2C
	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
	I2C_Cmd(ENABLE);
	u8_My_Buffer[6]=0x03;//setup the default behavior of the button output interrupt to be HIGH when either button is pushed (PRECON: valid I2C command received)
	enableInterrupts();  // Enable global interrupts
}

u32 millis()
{
	return atomic_counter>>9;//TIM2->PSCR + shift = 14
}

void update_developer_gpio()
{//if a valid i2c command has been received, output the button event on the gpio
	bool is_instantaneous=(u8_My_Buffer[6]&0x01)&&(is_button_down(1) | is_button_down(0));//if LSB on button event register is 1, then output HIGH on GPIO
	bool is_event        =(u8_My_Buffer[6]&0x02)&&(get_button_event(0xFF,0xFF,0));//if 0x02 is HIGH on button event register, output HIGH
	if(is_valid_i2c_received)
		GPIO_Init(GPIOD, GPIO_PIN_5, ( is_instantaneous | is_event )?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
}

//log short or long press button events for application layer to use as user input
//PRECON: don't press buttons at the same time (state machine gets confused, behavior is undefined).  Leveraging just one u32 to store timestamp of button press start to conserve memory
void update_buttons()
{
	u32 elapsed_pressed_ms;
	u8 button_index;
	update_developer_gpio();
	if(button_start_ms)
	{
		set_debug(255);
		if(!is_button_down(is_right_button_down))
		{
			elapsed_pressed_ms=millis()-button_start_ms;
			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
			button_start_ms=0;
		}
	}else{
		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
		{
			if(is_button_down(button_index))
			{
				is_right_button_down=button_index;
				button_start_ms=millis();
			}
		}
	}
}

//returns true if the API has registered the requested type of event
//use 0xFF for u8 parmaeter to apply to all (all buttons and/or all types of events: long/shrot) - result will be OR'd together
//get one button or many, get short or long press, clear from event queue (pop() behavior) or not (peek() behavior)
bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
{
	u8 iter;
	bool out=0;
	for(iter=0;iter<BUTTON_COUNT;iter++)
	{
		if(button_index==iter || button_index==0xFF)
		{
			if(is_long==0 || is_long==0xFF)
			{
				out|=button_pressed_event[iter][0];
				if(is_clear) button_pressed_event[iter][0]=0;
			}
			if(is_long==1 || is_long==0xFF)
			{
				out|=button_pressed_event[iter][1];
				if(is_clear) button_pressed_event[iter][1]=0;
			}
		}
	}
	return out;
}

//instantaneous check to see if button is pressed (grounded)
bool is_button_down(u8 index)
{
	switch(index)
	{
		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button
		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
	}
	return 0;
}

u8 get_developer_flag(){ return developer_flag; }//the effective number of LEDs to flush
void set_developer_flag(u8 value)//set the frame_complete GPIO event flag when requesting to flush LEDs or to clear that request
{
	if(value!=0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_SLOW);//frame_buffer_pin
	developer_flag=value;
	if(value==0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_SLOW);
}

void I2C_transaction_begin(void)
{//ready to read address byte next
	MessageBegin = TRUE;
}
void I2C_transaction_end(bool is_slave_txd)
{//perform specified action now that write (or read) operation is done
	is_valid_i2c_received=1;
	if(is_slave_txd)
	{//master read from slave
		u8_My_Buffer[2]=u8_My_Buffer[2]+1;
	}else{//master write to slave
		u8_My_Buffer[1]=u8_My_Buffer[1]+1;
		switch(this_addr)
		{
			case 0:{
				is_developer_debug=!is_developer_debug;
				set_debug(is_developer_debug?0xFF:0);
				set_developer_flag(1);
			}break;
			case 3:{//started at 3 and got an odd number of bytes, so last recevied byte is effective led count
					if(i2c_transaction_byte_count>1 && u8_MyBuffp==&u8_My_Buffer[4])
					{
						set_developer_flag(u8_My_Buffer[3]);
						u8_My_Buffer[3]=0;//reset the led_index register to default state
					}
			}break;
			case 4:{//if did nothing but write to index 4, then set that one led (BUT NOT flush)
				if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
			}break;
			case 5:{//if did nothing but write to 5, then only flush
				set_developer_flag(u8_My_Buffer[5]);//note: an excessively high value here (>>10) will cause the LEDs on the SAO to flicker notably
			}break;
			default: break;
		}
	}
	i2c_transaction_byte_count=0;
}
void I2C_byte_received(u8 u8_RxData)
{
	if (MessageBegin == TRUE  &&  u8_RxData < ADDRESS_COUNT_READ) {
		u8_MyBuffp= &u8_My_Buffer[u8_RxData];
		MessageBegin = FALSE;
		this_addr=u8_RxData;//easier to work with than u8_MyBuffp
	}
	else
	{
		i2c_transaction_byte_count++;//remember if this is a multi-byte transactions
		if(u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE]) *(u8_MyBuffp++) = u8_RxData;//stream data from user into the buffer
		if(this_addr==3 && u8_MyBuffp==&u8_My_Buffer[5])
		{//started at 3 and got up to 5, so push one LED out into buffer and then step back two indexes, ready to start again
			if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
			u8_MyBuffp-=2;
		}
	}
}
u8 I2C_byte_write(void)
{
	if (u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE])
		return *(u8_MyBuffp++);
	else if(this_addr==7 || this_addr==8)
	{
		update_developer_gpio();
		return //button state
			get_button_event(1,1,this_addr==8)<<7 | //MSB: 1 is long event has been raised, right button
			get_button_event(0,1,this_addr==8)<<6 | //long left button
			get_button_event(1,0,this_addr==8)<<5 | //short right button
			get_button_event(0,0,this_addr==8)<<4 | //short left button
			is_button_down(2)<<2 |//returns 1 if the SWIM pin is grounded
			is_button_down(1)<<1 | //1 is right button down
			is_button_down(0); //LSB is left button down
	}
	else
		return 0x00;
}

//interrupt to enable the next LED ON
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
  TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
	{
		sleep_counts=pwm_sleep[buffer_index];
	}
	if(pwm_visible_index>pwm_led_count[buffer_index])
	{//reached end of frame, including wait period
		pwm_visible_index=0;//formally start new frame
		update_buttons();//read buttons once per frame, every ~10 ms
		if(pwm_state&0x02)
		{
			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
		}
	}
	if(pwm_visible_index<pwm_led_count[buffer_index])
	{//valid LED is ready for display
		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep the LED ON for
		if(sleep_counts==0)
		{//catch dummy case if all LEDs are OFF and need to have one LED "ON"
			sleep_counts=1<<10;
		}else{
			set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
		}
	}
	pwm_visible_index++;//prepare for the next LED to be ON
	atomic_counter+=sleep_counts;//increment time based on interrupt command (ignores time spent within the interrupt routine)
	
  TIM2->CNTRH = 0;// Set the high byte of the counter
  TIM2->CNTRL = 0;// Set the low byte of the counter
	TIM2->ARRH= sleep_counts>>8;// init auto reload register
	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
  // Re-enable TIM2 after setting the counter value
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
  TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
}

@far @interrupt void I2C_EventHandler(void)
{
	static u8 sr1;					
	static u8 sr2;
	static u8 sr3;
	
	// save the I2C registers configuration
	sr1 = I2C->SR1;
	sr2 = I2C->SR2;
	sr3 = I2C->SR3;

/* Communication error? */
  if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
  {		
    I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
    I2C->SR2= 0;					    // clear all error flags
	}
/* More bytes received ? */
  if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
  {
    I2C_byte_received(I2C->DR);
  }
/* Byte received ? */
  if (sr1 & I2C_SR1_RXNE)
  {
    I2C_byte_received(I2C->DR);
  }
/* NAK? (=end of slave transmit comm) */
  if (sr2 & I2C_SR2_AF)
  {	
    I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
		I2C_transaction_end(1);
	}
/* Stop bit from Master  (= end of slave receive comm) */
  if (sr1 & I2C_SR1_STOPF) 
  {
    I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
		I2C_transaction_end(0);
	}
/* Slave address matched (= Start Comm) */
  if (sr1 & I2C_SR1_ADDR)
  {	 
		I2C_transaction_begin();
	}
/* More bytes to transmit ? */
  if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
  {
		I2C->DR = I2C_byte_write();
  }
/* Byte to transmit ? */
  if (sr1 & I2C_SR1_TXE)
  {
		I2C->DR = I2C_byte_write();
  }	
	GPIOD->ODR^=1;
}

//enable one led to be visible: physically emit light
void set_led_on(u8 led_index)
{
	const u8 led_lookup[LED_COUNT][2]={//index [0] is HIGH mat, [1] is LOW mat
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
	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0);
}

//enable the high or low side of an LED
//both ends needed to enable charliplexed LED
//except for single-sided debug led
void set_mat(u8 mat_index,bool is_high)
{
	GPIO_TypeDef* GPIOx;
	GPIO_Pin_TypeDef GPIO_Pin;
	switch(mat_index)
	{
		case 0:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
		case 1:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
		case 5:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
	}
	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
	GPIOx->DDR |= (uint8_t)GPIO_Pin;
	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
}

//led_count is the effective number of LEDs that are visible (ex. red at 128 + blue at 128  = 1 led_count)
void flush_leds(u8 led_count)
{//take the index-brightness values in the buffer and push them into the live buffer (to be serviced by the LED interrupt routine)
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
	{//no non-zero LEDs found, so fill in default values
		led_write_index=1;
		pwm_sleep[buffer_index]=1<<10;
		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
		pwm_brightness[0][buffer_index]=0;
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
	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
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
	switch(iter)
	{//less sram than a pile of if() statements
	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
	}
	set_rgb(index,0,red);
	set_rgb(index,1,green);
	set_rgb(index,2,blue);
}

//set the brightness of individual LEDs
//  to be made visible in the next frame after calling flush_leds()
void set_rgb(u8 index,u8 color,u8 brightness)
{ pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
void set_white(u8 index,u8 brightness)
{ pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
void set_debug(u8 brightness)
{ pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
