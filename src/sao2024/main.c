#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"

int main()
{
	setup_main();
	//hello_world();
	//if(0 || is_button_down(0) || is_button_down(1)) run_developer();//DEBUG_BROKEN default to developer mode
	run_application();
	run_developer();
	return 0;
}
