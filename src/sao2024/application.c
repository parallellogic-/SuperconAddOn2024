#include "STM8s.h"
#include "application.h"
#include "api.h"

void setup_application()
{
	setup_serial(0,0);
	clear_button_events();
}

void run_application()
{
	u8 submenu_index;
	u8 iter;
	u32 show_top_menu_since_ms=0;
	setup_application();
	while(is_application_valid())
	{
		//flush_leds(set_frame_rainbow()+1);
		//flush_leds(set_sparkles(1));
		flush_leds(set_sparkles(1)+set_frame_rainbow()-1);
		//flush_leds(set_frame_rainbow()+set_white_test()-1);
	}
}

u8 set_frame_rainbow()
{
	u8 iter;
	u16 offset=0;
	for(iter=0;iter<RGB_LED_COUNT;iter++)
	{
		set_hue_max(iter,(u16)(millis()<<5)+offset);
		offset+=0x2AAB;
	}
	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
}

u8 set_sparkles(bool is_fireworks)
{
	u8 iter;
	u16 state;
	for(iter=0;iter<WHITE_LED_COUNT;iter++)
	{
		//set_white(iter,(millis()>>(8+iter))&0x01?0xFF:0);
		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
		state+=millis()>>(2+((iter>>2)&0x02));
		if(!((state>>11)&(is_fireworks?0x01:0x03)))//only ON 25% of the time
		{
			//set_white(iter,(state>>10)&0x01?(~(state>>2)):(state>>2));//symmetric
			if(is_fireworks)
				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
			else
				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
		}
	}
	return WHITE_LED_COUNT/4;
}

u8 set_white_test()
{
	set_white((millis()>>6)%WHITE_LED_COUNT,0xFF);
	return 1;
}