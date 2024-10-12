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
		flush_leds(set_frame_rainbow());
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

u8 set_sparkles()
{
	u8 iter;
	u16 state;
	for(iter=0;iter<WHITE_LED_COUNT;iter++)
	{
		state=get_random(iter+1)<<10+millis()+millis()>>(iter+2);//start with random state phase offset for each LED, and adjust for time
		
		set_white(iter,
	}
	return WHITE_LED_COUNT/4;
}