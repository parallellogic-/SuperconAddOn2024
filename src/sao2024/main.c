#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"

int main()
{
	setup_main();
	if(is_button_down(0) || is_button_down(1) || is_button_down(2)) hello_world();
	run_application();
	run_developer();
	return 0;
}
