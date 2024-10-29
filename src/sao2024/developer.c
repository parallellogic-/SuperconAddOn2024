#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"

//setup Tx/Rx
//char terminal_command;
//u32 terminal_parameters[3];

void setup_developer()
{
	//setup_serial(1,1);//enabled, 0: 9600 baud, 1: at high speed (1MBaud)
	get_button_event(0xFF,0xFF,1);//clear_button_events();
	//flush_leds(0);//clear outstanding led buffer
	set_debug(255);//show only one debug led ON
	flush_leds(1);
}

void run_developer()
{
	char command;
	u8 parameter_count;//number of parameters recevied
	u32 parameters[MAX_TERMINAL_PARAMETERS];
	u32 start_ms;
	setup_developer();
	while(1)
	{
		/*start_ms=millis();
		set_debug(((start_ms>>8)&0x01)?0xFF:0);
		while(((millis()>>7)&0x01)==((start_ms>>7)&0x01)){}
		flush_leds(1);*/
		if(get_developer_flag())
		{
			flush_leds(get_developer_flag());
			set_developer_flag(0);
		}
	}
}

