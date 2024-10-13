#include "STM8s.h"
#include "application.h"
#include "api.h"

#define SCREENSAVER_COUNT 7

void run_application()
{
	u8 new_game_state=0,old_game_state=255;
	u8 iter;
	bool is_new_state=1;
	u32 game_state_start_ms;
	u32 game_state_elapsed_ms;
	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
	u8 target_pattern[RGB_LED_COUNT];//generate a random pattern.  value is the level (order) each element appears in 0-5
	u8 level_fractional_progress;//how many leds have been lit up in the current level
	u8 cursor;
	u8 game_level;
	u8 submenu_index;
	bool is_target_element_placed;//for cycle, is_reverse_direction
	//setup_application();
	setup_serial(0,0);
	get_button_event(0xFF,0xFF,1);//clear_button_events();
	while(is_application_valid())
	{
		effective_led_count=1;//default empty list
		is_new_state=0;//flag to signify a new state has been entered
		if(new_game_state!=old_game_state)
		{
			is_new_state=1;
			game_state_start_ms=millis();
			old_game_state=new_game_state;
		}
		game_state_elapsed_ms=millis()-game_state_start_ms;
		//flush_leds(set_frame_rainbow()+1);
		//flush_leds(set_sparkles(1));
		//flush_leds(set_sparkles(1)+set_frame_rainbow()-1);
		//flush_leds(set_frame_rainbow()+set_white_test()-1);
		switch(new_game_state)
		{
			case 0:{//Idle waiting for user input...
				game_level=0;//restart game
				effective_led_count=set_sparkles(0);
				if(get_button_event(0xFF,0,1))
				{//start simon says game by short pressing the buttons
					//compute on exit from main screen so the millis() is sufficiently randomized
					new_game_state=1;
					do{
						for(iter=0;iter<RGB_LED_COUNT;iter++) target_pattern[iter]=0;//clear initial state for repeat play
						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
						{
							is_target_element_placed=0;
							while(!is_target_element_placed)//beware infinite loop...
							{
								level_fractional_progress=get_random(millis()-iter)%RGB_LED_COUNT;//using time to resolve infinite loop instability :/
								if(target_pattern[level_fractional_progress]==0)
								{
									is_target_element_placed=1;
									target_pattern[level_fractional_progress]=iter;
								}
							}
							//target_pattern[iter]=(iter+1)%RGB_LED_COUNT;//deterministic in-order target pattern (without the first element at 0)
						}
					}while(target_pattern[0]==0);//avoid case where first goal is at the start, confusing the user about how the device operates
				}
				if(get_button_event(0xFF,1,1)) new_game_state=6;//start cyclone game by long pressing the buttons
			}break;
			case 1:{//show the target pattern, standby for user input
				//display the target pattern to the user
				for(iter=0;iter<RGB_LED_COUNT;iter++)
				{
					if(target_pattern[iter]<=(u8)(game_state_elapsed_ms>>9) && target_pattern[iter]<=game_level)
					{//this element is visible at this level
						set_element_hue(iter,iter);
					}
				}
				effective_led_count=6;
				//effective_led_count=set_frame_rainbow();
				if(get_button_event(0xFF,0,1)) new_game_state=2;
				if(get_button_event(0xFF,1,1)) new_game_state=6;
			}break;
			case 2:{//show user cursor and show selections the user has made.  mini-win if fraction_progress<win_length, else full win
				if(is_new_state)
				{
					cursor=0;
					level_fractional_progress=0;
				}
				for(iter=0;iter<RGB_LED_COUNT;iter++)
				{//display the leds the user has (correctly) selected so far
					if(target_pattern[iter]<level_fractional_progress)
					{//this element is visible at this level
						set_element_hue(iter,iter);
					}
				}
				if(game_state_elapsed_ms&0x0100) set_element_hue(cursor,cursor);
				if(get_button_event(1,0,1) || target_pattern[cursor]<level_fractional_progress)
				{//user pressed button to advance cursor (short or long press).  OR user entered the last element correctly and cursor needs to advance one place
					do{
						cursor=(cursor+1)%RGB_LED_COUNT;
					}while(target_pattern[cursor]<level_fractional_progress);//skip over indexes that have already been selected
				}
				if(get_button_event(0,0,1))
				{//user pressed button to select the current position (short or long press)
					if(target_pattern[cursor]==level_fractional_progress)//correctly selected the proper led
					{
						level_fractional_progress++;
						if(level_fractional_progress>=RGB_LED_COUNT) new_game_state=5;//full win
						else if(level_fractional_progress>game_level){ new_game_state=4; game_level++; }//level win
					}else{
						new_game_state=3;//lose
					}
				}
				effective_led_count=RGB_LED_COUNT;
				if(get_button_event(0xFF,1,1)) new_game_state=6;
			}break;
			case 3:{//lose
				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1); new_game_state=0; }//restart game after timeout, and clear any button pushes registered during lose
				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,0,255);//flash red LEDs
				effective_led_count=RGB_LED_COUNT;
			}break;
			case 4:{//mini-win
				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1);  new_game_state=1; }//go to next level, clear any button pushse during transition
				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,1,255);//flash green LEDs
				effective_led_count=RGB_LED_COUNT;
			}break;
			case 5:{//win
				if(is_new_state) submenu_index=0;
				effective_led_count=show_screensaver(submenu_index);
				if(get_button_event(0xFF,0,1)) submenu_index++;//allow user to cycle through winning screensavers
				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press to get back to idle screen
			}break;
			case 6:{//cyclone
				set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
				cursor=(((u16)game_state_elapsed_ms>>8)+(game_level>1?(((u16)game_state_elapsed_ms+(2<<6))>>8):0)
									 			  								     +(game_level>3?(((u16)game_state_elapsed_ms+(3<<6))>>8):0))%RGB_LED_COUNT;//player position
				if(is_target_element_placed) cursor=RGB_LED_COUNT-cursor-1;//reverse direction
				set_element_hue(cursor,game_level);
				if(get_button_event(0xFF,0,1)) new_game_state=7;//show user evaluation of performance
				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
				effective_led_count=2;
			}break;
			case 7:{//evaluate cyclone after user interaction
				if(get_button_event(0xFF,0,1))
				{//short press: determine if displayed state is win or lose
					is_target_element_placed=!is_target_element_placed;//flip direction
					if(cursor==(RGB_LED_COUNT-1)) game_level++;
					if(game_level==RGB_LED_COUNT) new_game_state=5;//win after all levels
					else new_game_state=6; //go to next level, clear any button pushse during transition
				}
				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
				if(game_state_elapsed_ms&0x80)
				{//blinking
					set_element_hue(cursor,game_level);//cursor
					if(cursor!=(RGB_LED_COUNT-1)) set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);//goal post
				}else{
					if(cursor==(RGB_LED_COUNT-1))
					{//if cursor landed on goal post, blink either side of goal post
						set_element_hue(RGB_LED_COUNT-2,RGB_LED_COUNT-1);
						set_element_hue(0,RGB_LED_COUNT-1);
					}else{//goal post is solid since user missed it
						set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
					}
				}
				effective_led_count=RGB_LED_COUNT;
				effective_led_count=3;
			}break;
		}
		flush_leds(effective_led_count);
	}
}

void set_element_hue(u8 led_index,u8 color_index)
{
	u16 color;
	switch(color_index){
		case 5: set_rgb(led_index,0,146);//dirty white
						set_rgb(led_index,1,146);//146**2 *3 = 255**2
						set_rgb(led_index,2,146);
						return;
		case 0: color=0x2AAA; break;//yellow 
		case 1: color=0x5555; break;//green
	  case 2: color=0x0; break;//red
	  case 3: color=0xAAAA; break;//blue
	  default: color=0xD555; break;//purple
	}
	set_hue_max(led_index,color);
}

u8 show_screensaver(u8 screensaver_index)
{
	switch(screensaver_index%SCREENSAVER_COUNT)
	{
		case 1: return set_frame_rainbow(0)+set_sparkles(0);
		case 2: return set_frame_rainbow(0)+set_sparkles(1);
		case 3: return set_sparkles(1);
		case 4: return set_frame_rainbow(1);
		case 5: return set_frame_rainbow(1)+set_sparkles(0);
		case 6: return set_frame_rainbow(1)+set_sparkles(1);
	}
	return set_frame_rainbow(0);
}

u8 set_frame_rainbow(bool is_circular)
{
	u8 iter;
	u16 offset=0;
	for(iter=0;iter<RGB_LED_COUNT;iter++)
	{
		set_hue_max(iter,(u16)(millis()<<5)+offset);
		if(is_circular) offset+=0x2AAB;
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
		//if(!((state>>11)&(is_fireworks?0x01:0x03)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
		if(!(state&(is_fireworks?0x0800:0x1800)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
		{
			//set_white(iter,(state>>10)&0x01?(~(state>>2)):(state>>2));//symmetric brighten and darken
			if(is_fireworks)
				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
			else
				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
		}
	}
	return WHITE_LED_COUNT/4;
}

/*u8 set_white_test()
{
	set_white((millis()>>6)%WHITE_LED_COUNT,0xFF);
	return 1;
}*/

/*u8 set_debug_buttons()
{//light up leds based on button states
	set_white(0,is_button_down(0)?0xFF:0);
	set_white(1,is_button_down(1)?0xFF:0);
	set_white(2,is_button_down(2)?0xFF:0);
	//set_white(3,get_button_event(u8 button_index,bool is_long));
	set_white(3,get_button_event(0,0,0)?0xFF:0);
	set_white(4,get_button_event(0,1,0)?0xFF:0);
	set_white(5,get_button_event(1,0,0)?0xFF:0);
	set_white(6,get_button_event(1,1,0)?0xFF:0);
	return 7;
}*/