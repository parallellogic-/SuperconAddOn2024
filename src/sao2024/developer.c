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
		start_ms=millis();
		set_debug(((start_ms>>8)&0x01)?0xFF:0);
		while(((millis()>>7)&0x01)==((start_ms>>7)&0x01)){}
		flush_leds(1);
	}
	/*while(1)
	{
		Serial_print_string("> ");
		get_terminal_command(&command,&parameters,&parameter_count);
		set_debug(255);//show only one debug led ON
		execute_terminal_command(command,&parameters,parameter_count);
		command=0;
		parameter_count=0;
	}*/
	
	//Serial_print_string("DONE");
	//Serial_newline();
}

void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	bool is_new_line=0;
	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
	char input_char;
	while(!is_new_line)
	{
		if(Serial_available())
		{
			input_char=Serial_read_char();
			if(input_char=='\n') is_new_line=1;//break on new line character found
			else if((*command)==0) (*command)=input_char;
			else{
				if('0'<=input_char && input_char<='9')
				{
					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
					is_any_input=1;
				}else{//spaces commas or any other inter-parameter spacing, ignore it, including multi-character spaces
					if(is_any_input)
					{
						(*parameter_count)++;
						is_any_input=0;
						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
					}
				}
			}
		}
	}
}

void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
{
	u8 iter;
	bool is_valid=0;
	switch(command)
	{
		case 'p':{ //simple ping/echo
			Serial_print_char(command);
			for(iter=0;iter<parameter_count;iter++)
			{
				Serial_print_char(' ');
				Serial_print_u32((*parameters)[iter]);
			}
			is_valid=1;
		}break;
		case 't':{ //if parameters>=1, then set time, else print time
			//if(parameter_count) set_millis((*parameters)[0]);
			//else Serial_print_u32(millis());
			is_valid=1;
		}break;
		case 'e':{ //eeprom interface
			if(parameter_count==1)
			{//read, 0-127
				//if((*parameters)[0]<128)
					//Serial_print_u32(FLASH_ReadByte(eeprom_address));
					//Serial_print_u32(get_eeprom_byte((*parameters)[0]));
			}/*else if(parameter_count==2)
			{//write
				if((*parameters)[1]<256)
				{
					FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
					FLASH_Unlock(FLASH_MEMTYPE_DATA);
					while(FLASH_GetFlagStatus(FLASH_FLAG_DUL)==RESET);
					FLASH_ProgramByte(FLASH_ReadByte((*parameters)[0]+0x4000),(*parameters)[1]);
					FLASH_Lock(FLASH_MEMTYPE_DATA);
				}
			}*/
		}break;
		case 'l':{ //l as in 'LED'
			is_valid=1;
			if(parameter_count<3) is_valid=0;
			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
			if((*parameters)[1]>=3) is_valid=0;
			if((*parameters)[2]>=255) is_valid=0;
			if(is_valid)
			{
				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
		case 'w':{ //set white led (only populated on space SAOs
			is_valid=1;
			if(parameter_count<2) is_valid=0;
			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
			if((*parameters)[1]>=255) is_valid=0;
			if(is_valid)
			{
				set_white((*parameters)[0],(*parameters)[1]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
	}
	if(!is_valid) Serial_print_string("Invalid. h");
	Serial_newline();
}