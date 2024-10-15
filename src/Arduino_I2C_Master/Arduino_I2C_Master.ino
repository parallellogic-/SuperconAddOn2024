#include <Wire.h>
#define SLAVE_ADDRESS 0x30  // STM8 slave address

void setup()
{
    Wire.begin();          // Initialize I2C as master
    Serial.begin(115200);    // Initialize Serial for debug output
    delay(4000);
    Serial.println("START");
}

void loop()
{
    uint8_t registerAddress = 0x01;  // Example register address
    uint8_t dataToWrite = 0x55;      // Example data to write (0x55)

    // Write data to the register
    writeToRegister(registerAddress, dataToWrite);

    // Small delay to ensure the slave processes the write
    delay(1);

    // Read the data back from the same register
    uint8_t readBackData = readFromRegister(registerAddress);



    // Print the written and read-back values to the serial monitor
    Serial.print("Written Data: 0x");
    Serial.print(dataToWrite, HEX);
    Serial.print(" | Read Back Data: 0x");
    Serial.print(readBackData, HEX);
    Serial.println();

    delay(1000);  // Wait for a second before repeating
}

void writeToRegister(uint8_t registerAddress, uint8_t data)
{
    Wire.beginTransmission(SLAVE_ADDRESS);  // Begin transmission to the STM8
    Wire.write(registerAddress);            // Specify the register to write to
    Wire.write(data);                       // Write the data byte
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

uint8_t readFromRegister(uint8_t reg) {
    Wire.beginTransmission(SLAVE_ADDRESS);  // Start communication with the sensor
    Wire.write(reg);                       // Send the register address
    Wire.endTransmission();                // End transmission, but keep the connection alive

    Wire.requestFrom(SLAVE_ADDRESS, 2);     // Request 1 byte from the sensor
    if (Wire.available()) {
        return Wire.read();                // Read and return the received byte
    }
    return 0; // Return 0 if no data was received
}