#include <Wire.h>
#define SLAVE_ADDRESS 0x30  // STM8 slave address

uint8_t buff[257];
uint8_t buff_len=0;
int frame=0;

void setup()
{
    Wire.begin();          // Initialize I2C as master
    Serial.begin(1000000);    // Initialize Serial for debug output
    delay(4000);//ensure PC has serial monitor visible
    Serial.println("START");
    pinMode(LED_BUILTIN,OUTPUT);
    pinMode(3,INPUT);
}

void loop()
{
  loop_fast();
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
  api_write_leds();
  delay(500);  // Wait for a second before repeating
  digitalWrite(LED_BUILTIN,1);
  delay(500);  // Wait for a second before repeating
}

void api_read_buttons()
{
  uint8_t read_reg=6;
  if(Serial.available())
  {//user command to clear events
    read_reg=7;
    Serial.read();
  }
  readFromRegister(read_reg,1);
  
  Serial.print("Read Device: 0x");
  Serial.print(SLAVE_ADDRESS, HEX);
  Serial.print(" | Read Register: 0x");
  Serial.print(read_reg, HEX);
  Serial.print(" | Read value:");
  for(int iter=0;iter<buff_len;iter++)
  {
    Serial.print(" 0b");
    //Serial.print(buff[iter], BIN);
    for (int rep = 7; rep >= 0; rep--) {
    // Shift the bits to the right and mask with 1 to get the specific bit
    Serial.print((buff[iter] >> rep) & 1);
    }
  }
  Serial.println();
}

void api_write_leds_continuous()
{
  if(digitalRead(3)) return;//wait while SAO is still working on last command
  frame++;
  uint8_t write_reg=3;
  long tms=millis()>>2;
  int count=0;
  int loop_count=6;
  //int color_offset=6;
  //if((tms>>9)&0x01) color_offset=0;
  int color_offset=((tms>>9)%3)*6;
  for(int iter=0;iter<loop_count;iter++)
  {
    buff[iter*2]=iter+color_offset;
    //buff[iter*2+1]=(tms>>iter)&0x01?0xFF:0x00;
    buff[iter*2+1]=((tms>>8)&0x01?~tms:tms)&0x000000FF;//(frame%2)?0xFF:0x00;
    if(buff[iter*2+1]) count++;
  }
  buff[loop_count*2]=loop_count;
  buff_len=loop_count*2+1;
  writeToRegister(write_reg);
  //delayMicroseconds(1000);
  //delay(10);
  api_read_buttons();
  Serial.print("Frame: ");
  Serial.println(frame);
}

void api_write_leds()
{
  uint8_t write_reg=3;
  if(millis()%2000>1000)
  {
    buff[0]=0;
    buff[1]=255;//LED buff[0] brightness
    buff[2]=1;
    buff[3]=147;//LED buff[1] brightness
    buff[4]=2;
    buff[5]=32;//LED buff[2] brightness
    buff[6]=3;//effective number of LEDs illuminated
    buff_len=7;//number of bytes of above message
  }else{
    buff[0]=0+6;
    buff[1]=255;//LED buff[0] brightness
    buff[2]=1+6;
    buff[3]=147;//LED buff[1] brightness
    buff[4]=2+6;
    buff[5]=32;//LED buff[2] brightness
    buff[6]=3;//effective number of LEDs illuminated
    buff_len=7;//number of bytes of above message
  }
  writeToRegister(write_reg);
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
}

void api_toggle_debug()
{
  uint8_t write_reg=0;
  uint8_t read_reg=1;
  //uint8_t write_value='a';
  buff[0]='a';
  buff_len=1;
  writeToRegister(write_reg);
  delayMicroseconds(150);
  uint8_t readBackData = readFromRegister(read_reg,2);
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

/*void comm_test()
{
    uint8_t registerAddress = 0x0E;  // Example register address
    uint8_t dataToWrite = 0x55;      // Example data to write (0x55)

    // Write data to the register
    writeToRegister(registerAddress, dataToWrite);

    // Small delay to ensure the slave processes the write
    //delay(1);
    delayMicroseconds(100);

    // Read the data back from the same register
    uint8_t readBackData = readFromRegister(registerAddress);



    // Print the written and read-back values to the serial monitor
    Serial.print("Written Data: 0x");
    Serial.print(dataToWrite, HEX);
    Serial.print(" | Read Back Data: 0x");
    Serial.print(readBackData, HEX);
    Serial.println();

}*/

void writeToRegister(uint8_t registerAddress)
{
    Wire.beginTransmission(SLAVE_ADDRESS);  // Begin transmission to the STM8
    Wire.write(registerAddress);            // Specify the register to write to
    for(int iter=0;iter<buff_len;iter++)
    {
      Wire.write(buff[iter]);                       // Write the data byte
    }
    //Wire.write(data+1);                       // Write the data byte
    Wire.endTransmission();                 // End the transmission
}
/*uint8_t readFromRegister(uint8_t registerAddress)
{
    Wire.beginTransmission(SLAVE_ADDRESS);  // Begin transmission to the STM8
    Wire.write(registerAddress);            // Specify the register to read from
    //Wire.endTransmission(false);            // End transmission, but send a repeated start condition
    Wire.endTransmission();            // End transmission
    
    Wire.requestFrom(SLAVE_ADDRESS, 1);     // Request 1 byte of data from the slave
    while (Wire.available() == 0);          // Wait until data is available
    
    return Wire.read();                     // Read the data byte
}*/
/*void writeByteToSensor(uint8_t reg, uint8_t value) {
    Wire.beginTransmission(SENSOR_ADDR);  // Start communication with the sensor
    Wire.write(reg);                       // Send the register address
    Wire.write(value);                     // Send the value to write
    Wire.endTransmission();                // End the transmission
}*/

uint8_t readFromRegister(uint8_t reg,uint8_t byte_count) {
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
        //out=Wire.read();                // Read and return the received byte
    }
    return 0; // Return 0 if no data was received
}