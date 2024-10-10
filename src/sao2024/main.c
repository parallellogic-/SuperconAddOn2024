#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"

int main()
{
	setup_main();
	hello_world();
	while(1)
	{
		if(is_application_valid()) run_application();
		if(is_developer_valid()) run_developer();
	}
	return 0;
}
