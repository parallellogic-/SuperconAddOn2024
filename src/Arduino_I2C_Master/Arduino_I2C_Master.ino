//the following code is an example i2c master that demonstrates how to write to the LEDs and read the button states
//will print "START" to the terminal and then will be begin one of the two demos included:
//loop_slow() will use one-byte-at-a-time transactions to set each LED
//loop_fast() will use a multi-byte transaction to set and flush all LEDs at once (and will wait for frame to finish before immediatley sending another one), ~80 FPS

//connections: SDA, SCL, 3V3, GND.  For loop_fast(), connect the SAO RX pin, (SAO GPIO1) to FRAME_INTERRUPT_PIN on the ARDINO
//NOTE: GPIO0 and GPIO1 are floating by default.  Events will only be flagged (output from SAO36) once a valid I2C transaction has been received

#include <Wire.h>
#define SLAVE_ADDRESS 0x30  // SAO slave address

uint8_t buff[257];//array to hold data going to /fram the SAO
uint8_t buff_len=0;//length of array
int frame=0;//frame counter tracking how many frames have been sent to the SAO
const int FRAME_INTERRUPT_PIN=3;

void setup()
{
    Wire.begin();          // Initialize I2C as master
    Serial.begin(1000000);    // Initialize Serial for debug output, note that low-end processors may need a lower speed baud rate
    delay(4000);//ensure PC has serial monitor visible
    Serial.println("START");
    pinMode(LED_BUILTIN,OUTPUT);
    pinMode(FRAME_INTERRUPT_PIN,INPUT);//monitor frame-done interrupt (HIGH when SAO is busy, LOW when frame hrendering has completed)
}

void loop()
{//choose which demo to see
  //loop_slow();//toggles between 3 red LEDs ON, and 3 green LEDs ON, every second
  loop_fast();//fades all 6 red LEDs in/out, then fades green in/out, then blue, then repeats
}

void loop_fast()
{
  digitalWrite(LED_BUILTIN,0);
  api_write_leds_continuous();
  digitalWrite(LED_BUILTIN,1);
}

void loop_slow()
{
  digitalWrite(LED_BUILTIN,0);
  api_write_leds_slow();
  delay(500);  // Wait before repeating
  digitalWrite(LED_BUILTIN,1);
  delay(500);  // Wait before repeating
}

void api_read_buttons()
{
  uint8_t set_button_interrupts=4;//apriori invalid value, will be set to valid value later.  This is the button interrupt config register value
  uint8_t read_reg=7;//read button state from this register
  if(Serial.available())
  {//user command to clear events
    read_reg=8;//if a serial command is seen, then read buttons from one address high, which clears the button event flags (clear short/long press event flags)
    switch(Serial.read())
    {
      case '0': set_button_interrupts=0; break;//nothing triggers button interrupt
      case '1': set_button_interrupts=1; break;//interrupt only echos instantaneous button state (low for no presses, high for any press)
      case '2': set_button_interrupts=2; break;//interrupt only is high when there is a complete event (short or long on either button) ready
      case '3': set_button_interrupts=3; break;//combo of 1 and 2 above (high for either instantanous or event-ready)
    }
    if(set_button_interrupts<4)
    {//if there is a valid command to change the button interrupt behavior, execute the request here
      buff[0]=set_button_interrupts;//new button interrupt setting
      buff_len=1;
      writeToRegister(6);//register that holds the interrupt setting
    }
  }
  readFromRegister(read_reg,1);//query SAO for button state (and clear events if desired)
  
  Serial.print("Read Device: 0x");
  Serial.print(SLAVE_ADDRESS, HEX);
  Serial.print(" | Read Register: 0x");
  Serial.print(read_reg, HEX);
  Serial.print(" | Read value:");
  for(int iter=0;iter<buff_len;iter++)
  {
    Serial.print(" 0b");
    for (int rep = 7; rep >= 0; rep--) {
      Serial.print((buff[iter] >> rep) & 1);
      //bit 0 (LSB) is left button instantaneous state
      //bit 1 is right button
      //bit 2 is SWIM pin state
      //bit 3 is unused
      //bit 4 is left button short press event flag
      //bit 5 is right button short press flag
      //bit 6 is left button long press flag
      //bit 7 (MSB) is right button long press flag
    }
  }
  Serial.println();
}

void api_write_leds_continuous()
{
  if(digitalRead(FRAME_INTERRUPT_PIN)) return;//wait while SAO is still working on last command (let it finish rendering the last frame to avoid overwriting data)
  frame++;
  uint8_t write_reg=3;//register where to stream LED info to
  long tms=millis()>>2;//for demo purposes, use time as a state machine to determine what pattern to display
  int count=0;//LED index
  int loop_count=6;//number of LED LEDs to light up
  int color_offset=((tms>>9)%3)*6;//cycle through each of the three colors in RGB
  for(int iter=0;iter<loop_count;iter++)
  {
    buff[iter*2]=iter+color_offset;//after each fade in/out, proceed to the next RGB color
    buff[iter*2+1]=((tms>>8)&0x01?~tms:tms)&0x000000FF;//fade in/out the LED brightness - all LEDs are given the same brightness in this demo
    if(buff[iter*2+1]) count++;//count up the number of LEDs iluminated
  }
  buff[loop_count*2]=loop_count;//last byte of transaction is the number of LEDs (transaction must be an odd number of bytes to auto-trigger the led_flush function)
  buff_len=loop_count*2+1;
  writeToRegister(write_reg);
  api_read_buttons();
  Serial.print("Frame: ");
  Serial.println(frame);
}

//alternately illuminate red LEDs ad different rbightenesses, or green LEDs
void api_write_leds_slow()
{//this appraoch is slow because it entails a different transaction for each LED index, brightness, and flush operation.  The stream operation performed in the api_write_leds_continuous() method above is faster because all data is written and set in a single i2c transaction
  buff_len=1;
  uint8_t rg=0;
  if(millis()%2000>1000) rg=6;//every other second, change between green and red
  //write 
  buff[0]=0+rg; writeToRegister(3); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(3, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);//first LED index
  buff[0]=255;  writeToRegister(4); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(4, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);//first LED brightness
  buff[0]=1+rg; writeToRegister(3); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(3, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);
  buff[0]=147;  writeToRegister(4); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(4, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);
  buff[0]=2+rg; writeToRegister(3); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(3, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);//last LED index
  buff[0]=32;   writeToRegister(4); Serial.print("Write Device: 0x"); Serial.print(SLAVE_ADDRESS, HEX); Serial.print(" | Write Register: 0x"); Serial.print(4, HEX); Serial.print(" | Write value:"); Serial.println(buff[0], HEX);//last LED brightness
  buff[0]=3;    writeToRegister(5);//number of effective LEDs illuminated.  writing this value to the SAO flushes the LED buffer to the live display.  writing this multiple times will flush the display multiple times, leading to a blank display
  Serial.println();
}

void api_toggle_debug()
{
  uint8_t write_reg=0;//the first register is a place for dummy read/writes (will echo back the data written to it when read), and will toggle the debug LED on each read or write operation
  uint8_t read_reg=1;//registers 1 and 2 are a counter of the number of read and write operations performed (note 255 roll-over)
  buff[0]='a';//dummy data to write
  buff_len=1;
  writeToRegister(write_reg);
  delayMicroseconds(150);//allow a gap to separate the i2c transactions on the oscope
  readFromRegister(read_reg,2);//read 2 bytes: the number of read and write operations performed.  Note: a write transaction contails of one write (setting the address) and read (reading the data back)
  // Print the written and read-back values to the serial monitor
  Serial.print("Write Device: 0x");
  Serial.print(SLAVE_ADDRESS, HEX);
  Serial.print(" | Write Register: 0x");
  Serial.print(write_reg, HEX);
  Serial.print(" | Write value:");
  for(int iter=0;iter<buff_len;iter++)
  {
    Serial.print(" 0x");
    Serial.print(buff[iter], HEX);
  }
  Serial.println();
  Serial.print("Read Device: 0x");
  Serial.print(SLAVE_ADDRESS, HEX);
  Serial.print(" | Read Register: 0x");
  Serial.print(read_reg, HEX);
  Serial.print(" | Read value:");
  for(int iter=0;iter<buff_len;iter++)
  {
    Serial.print(" 0x");
    Serial.print(buff[iter], HEX);
  }
  Serial.println();
}

void writeToRegister(uint8_t registerAddress)
{
    Wire.beginTransmission(SLAVE_ADDRESS);  // Begin transmission to the STM8
    Wire.write(registerAddress);            // Specify the register to write to
    for(int iter=0;iter<buff_len;iter++) Wire.write(buff[iter]); // Write the data bytes
    Wire.endTransmission();                 // End the transmission
}

void readFromRegister(uint8_t reg,uint8_t byte_count) {
    Wire.beginTransmission(SLAVE_ADDRESS);  // Start communication with the sensor
    Wire.write(reg);                       // Send the register address
    Wire.endTransmission();                // End transmission, but keep the connection alive

    Wire.requestFrom(SLAVE_ADDRESS, byte_count);     // Request X byte(s) from the sensor
    uint8_t out=0;
    while(Wire.available()==0){}//wait for data to be available
    buff_len=0;
    while (Wire.available()) {
        buff[buff_len]=Wire.read();
        buff_len++;
    }
}