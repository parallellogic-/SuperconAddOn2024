# Luna Says Supercon Add-On Overview

This repo contains the project files for a Supercon Add-On (SAO) Printed Circuit Board (PCB) for Hackaday Supercon 2024, held November 1-3rd in Pasadena.

<img src="/doc/front.png" width="420"><img src="/doc/back.png" width="420">

# User Guide

By default, when the unit is powered ON, the LEDs will display a random screen-saver display pattern on the white LEDs.

Pressing either button enters into a "Luna Says" game:
- Luna will highlight one of the Elements of Harmony (RGB LEDs)
- You must repeat the pattern that Luna has shown.  Press the right button to move the cursor and the left button to select the same Element of Harmony.
- When you highlight the correct gem, Luna's mane will flash green and she will then highlight one more gem than before.
- You must then highlight the same gems in the same order with progressively longer patterns.
- If you fail to repeat the pattern correctly, the LEDs will flash red and the game will reset from the beginning.
- The game is won by highlighting all the Elements of Harmony

Long pressing either button will enter in a Cyclone game:
- The Element of Harmony will spin in a circle
- You must press either button the moment the element passes the white marker
- When timed correctly, the central marker and two neighboring LEDs will alternately blink.  Pressing the button again will start the next (faster) level
- Failing to time the press accurately will flash the LED where the cursor landed.  Pressing the button again will restart the current level.
- The game is won by clearing all 6 levels

# Examples

## Idle

Random screen-saver idle display pattern

<img src="/doc/idle.gif" width="420">


## Luna Says

Luna highlights the Elements of Harmony in a specific order.  You must repeat her pattern.

<img src="/doc/simon.gif" width="420">

## Cyclone

The Elements of Harmony spin and you must catch each one at the right moment

<img src="/doc/cyclone.gif" width="420">

# Design

The state of the SAO may be read (buttons) and written (LEDs) using the I2C serial connection.

There are 6 pins on the SAO interface.  Two are used for 3V3 and GND power input.  Two are used for I2C.  The remaining two serve as SAO output event flags for button and frame-render-complete events.

<img src="/doc/sao_pinout.png" width="420">

| Pinout |     |     |
|--------|-----|-----|
| GPIO1  | SDA | 3V3 |
| GPIO0  | SCL | GND |

The routing of the interface signals on the SAO header may be re-directed by cutting the associated trace and soldering jumper wires to the desired configuration.  The example below shows cutting (ex. with an exacto knife) the SDA and SCL traces (red) and then soldering jumper wires to swap the SDA and SCL lines (green and blue) on the I2C bus.

<img src="/doc/sao_swap_traces.png" width="420">

Soldering the "PWR" jumper closed will permanently turn ON the dedicated power LED.

The I2C data and clock lines each have a 10kohm pull up resistor to 3V3 connected.  This can be disabled by cutting the traces here:

<img src="/doc/sao_i2c_pullups.png" width="420">

There are two buttons and 31 LEDs (the RGB LED consists of three colors each that can be individually controlled).  30 of the LEDs are driven by 6 pins in a charlieplexed configuration.  The remaining debug LED, buttons, and serial interface are assigned dedicated pins on the processor.

|          |        0 |        1 |        2 |        3 |        4 |        5 | Positive |
|----------|---------:|---------:|---------:|---------:|---------:|---------:|----------|
|        0 |          | 20 (w7)  | 21 (w8)  | 4 (r4)   | 5 (r5)   | 6 (r6)   |          |
|        1 | 22 (w9)  |          | 23 (w10) | 10 (g4)  | 11 (g5)  | 12 (g6)  |          |
|        2 | 24 (w11) | 25 (w12) |          | 16 (b4)  | 17 (b5)  | 18 (b6)  |          |
|        3 | 1 (r1)   | 2 (r2)   | 3 (r3)   |          | 26 (w13) | 27 (w14) |          |
|        4 | 7 (g1)   | 8 (g2)   | 9 (g3)   | 28 (w15) |          | 29 (w16) |          |
|        5 | 13 (b1)  | 14 (b2)  | 15 (b3)  | 30 (w17) | 31 (w18) |          |          |
| Negative |          |          |          |          |          |          |          |

|       | PORT | PIN |
|-------|------|-----|
| MAT0  | C    |   3 |
| MAT1  | C    |   4 |
| MAT2  | C    |   5 |
| MAT3  | C    |   6 |
| MAT4  | C    |   7 |
| MAT5  | D    |   2 |
| DEBUG | A    |   3 |
| BTN0  | D    |   3 |
| BTN1  | D    |   4 |
| SWIM  | D    |   1 |

# API

An example program that interfaces with the SAO over I2C (reading button state and setting LEDs) can be found [here](/src/Arduino_I2C_Master/Arduino_I2C_Master.ino)

SAO device 7-bit address is 0x30.  The baud rate is 100 kHz.

| Register Map | R/W |                   Title                  | Default | Range, Inclusive |                                                                                                                                                                                                                Notes                                                                                                                                                                                                                |
|:------------:|:---:|:----------------------------------------:|:-------:|:----------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| 0            | R/W | Dummy                                    | 0       | 0x00-0xFF        | Values written here will echo back the same when read.  Reading this register will toggle the state of the debug LED.                                                                                                                                                                                                                                                                                                               |
| 1            | R/W | Write Count                              | 0       | 0x00-0xFF        | Counter of the number of I2C write transactions since power ON, value will roll-over above 0xFF.  Each read consists of 2 operations: a write (setting the register address) and a read (fetching the register contents)                                                                                                                                                                                                            |
| 2            | R/W | Read Count                               | 0       | 0x00-0xFF        | Number of I2C read transactions since power ON                                                                                                                                                                                                                                                                                                                                                                                      |
| 3            | W   | LED Index                                | 0       | 0x00-0x1F        | Writing an odd (>2) number of bytes to this register in single transaction is the same as writing alternately to registers 3 and 4,  with the final byte being written to register 5                                                                                                                                                                                                                                                |
| 4            | W   | LED Brightness                           | 0       | 0x00-0xFF        | 0 is OFF, 0xFF is max                                                                                                                                                                                                                                                                                                                                                                                                               |
| 5            | W   | Effective LED Count and LED Buffer Flush | 0       | 0x00-0x10        | Higher values are possible, but cause LED flickering and latency with button events                                                                                                                                                                                                                                                                                                                                                 |
| 6            | R/W | Button Interrupt Config                  | 0x03    | 0x00-0x03        | 0x01 (LSB) set to 1 means GPIO0 will be HIGH the moment the buttons are pressed (instantaneous), 0x02 set to 1 means GPIO0 will go high any  time there is a button event ready (short or long on the left or right  button).  0x03 sets GPIO0 HIGH any time either condition is true. If no  interrupt is triggered, then the pin is driven LOW.  Note: on first  power ON, until a valid I2C command is received, this pin floats |
| 7            | R   | Peek button events                       | 0       | 0x00-0xF7        | 0x01 (LSB) is left button instantaneously down (0 is unpressed), 0x02 is right button instantaneously down, 0x04 is SWIM pin, 0x08 is unused, 0x10 is short press event flag on left button, 0x20 is short press on right button flag, 0x40 is long press on left button flag, 0x80 is long press on right button event flag                                                                                                        |
| 8            | R   | Pop button events                        | 0       | 0x00-0xF7        | Same as above, but upon read, the event flags (most significant nibble) are cleared                                                                                                                                                                                                                                                                                                                                                 |

## Buttons

Each button is monitored for short (>50 ms, <500 ms) and long (>500 ms) button presses.  These events are flagged when the button is released.  Only one event is flagged upon button release (a long press does NOT raise a short press flag).

GPIO0 acts as a button interrupt output.  The pin floats on power-ON.  After a valid I2C command is received GPIO0 is pulled low until an event occurs at which point it is pulled high until the event is resolved.  The configuration of the interrupt behavior can be set in the Button Interrupt Config register

| Function         | Direction  | STM8 | PCB | SAO   |
|------------------|------------|------|-----|-------|
| Button Interrupt | SAO Output | PD5  | TXD | GPIO0 |
| Frame Flag       | SAO Output | PD6  | RXD | GPIO1 |

## LEDs

LEDs are indexed 0 to 31 per the below mapping.  Generally, RGB LEDs are indexed in a clockwise pattern, while white LEDs are numbered top-to-bottom and left-to-right.  The debug LED is located near the bottom

<img src="/doc/led_indexing.png" width="420">

### LED operation

Note: The 8-bit LED brightness value is squared inside the SAO and then shifted down to a 10-bit value to better match the sensitivity of the human eye.  As such, some neighboring brightness values below 32 are non-unique and map to identical brightnesses.


Setting of an LED always requires two steps: one (or more) commands to set the brightness of the target LED(s), followed by one command to flush the LED buffer to the update interrupt routine.

Setting the brightness of one LED requires two bytes: one to specify the index (0 to 31 inclusive) and a second to set the brightness (0 to 255, inclusive, 255 is max brightness)

Producing a frame can be achieved in two ways:

1. Writing the LED index to register 3, writing the brightness to index 4, then sending additional writes to 3 and 4 for additional LEDs.  Finally a write is sent to register 5 with the effective number of LEDs.  This is a simpler approach but requires additional overhead on the I2C serial link

<img src="/doc/timing_v2.png">

2. Performing a multi-byte write to register 3.  Since the index-brightness-index-brightness... bytes alternate and are followed by a single byte for the effective number of LEDs, there will always be an odd number of bytes in a compelte multi-byte transaction.

<img src="/doc/timing_v3.png">

Note: Because the writing of a new frame may be completed faster than the time to illuminate the LEDs in the frame, and the SAO has only a single-frame buffer, GPIO1 is used as a busy flag: raised HIGH when a frame begins display and driven LOW when the frame has completed and the SAO is ready for a new frame.  To avoid shearing mid-frame, it is recommended to monitor GPIO1 to be in a LOW state before sending a new frame of data to the SAO.

<img src="/doc/timing.png">

Note: In the absense of an external command, the SAO will continue looping, showing the last frame flushed.

Note: Because the brightness is squared and because brightness is based on the time each LED spends ON, one LED at brightness 255 is equivalent to two LEDs at 180 brightness (255<sup>2</sup> ~= 2 * 180<sup>2</sup>).  This can be extended further, ex. to three LEDs at 147 brightness (255<sup>2</sup> ~= 3 * 147<sup>2</sup>) or in fractional combinations (ex. when shifting through a rainbow hue).  Rather than sleeping during the unused brightness period (to stablize the brightness regardless of whatever brightness each LED is configured to frame-to-frame), the sleep time can be skipped or reduced by setting an "effective" number of LEDs when flushing the frame buffer (on the supposition that the cumulative time each LED will spend ON will not exceed the equivalent amount of time a smaller number of LEDs would be ON for).  Thus, when some LEDs are displayed at partial brighntess, it may be possible to flush the display with an effecitve number of LEDs that is lower than the physcial number of LEDs being illuminated.

# Resources

- Artwork by http://hotglewd.com
- JLCPCB Multi Color Silkscreen Specification https://jlcpcb.com/help/article/How-to-design-multi-color-silkscreen-using-EasyEDA
- Contest Specifications https://hackaday.io/contest/197237-supercon-8-add-on-contest/details
- SAO Standard https://hackaday.io/project/175182-simple-add-ons-sao
- Schematic:

<img src="/doc/schematic.png">