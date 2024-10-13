
#define RGB_LED_COUNT 6
#define DEBUG_LED_INDEX RGB_LED_COUNT*3 //index of the debug led
#define WHITE_LED_COUNT 12
#define LED_COUNT DEBUG_LED_INDEX+WHITE_LED_COUNT+1 //6 RGB (3 LEDs each) + 12 white + 1 debug

void hello_world(void);
void setup_serial(bool is_enabled,bool is_fast_baud_rate);
bool is_application_valid(void);
void setup_main(void);
u32 millis(void);
//void set_matrix_high_z(void);
void set_rgb(u8 index,u8 color,u8 brightness);
void set_white(u8 index,u8 brightness);
void set_debug(u8 brightness);
void flush_leds(u8 led_count);
void set_hue_max(u8 index,u16 color);
bool is_application_valid(void);
bool is_developer_valid(void);
void update_buttons(void);
//bool get_button_event(u8 button_index,bool is_long);
//bool clear_button_event(u8 button_index,bool is_long);
//bool clear_button_events(void);
bool get_button_event(u8 button_index,u8 is_long,bool is_clear);
bool is_button_down(u8 index);
u16 get_random(u16 x);
void set_mat(u8 led_index,bool is_high);
void set_led_on(u8 led_index);