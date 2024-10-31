#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"

void setup_developer()
{
	get_button_event(0xFF,0xFF,1);//clear_button_events
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
		if(get_developer_flag())
		{//whenever the i2c interrupt gets a command to set the leds, service that request here (to the LED interrupt) to avoid contention between interrupts)
			flush_leds(get_developer_flag());
			set_developer_flag(0);//now ready for next frame of LED commands
		}
	}
}

