#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"

int main()
{
	setup_main();//setup GPIO, interrupts and I2C
	if(is_button_down(0) || is_button_down(1) || is_button_down(2)) hello_world();//if either button is pressed during boot, jump into an LED test mode
	run_application();//run application until a valid I2C command is received
	run_developer();//hold in developer mode
	return 0;
}
