# Luna Says Supercon Add-On Overview

This repo contains the project files for a Supercon Add-On (SAO) Printed Circuit Board (PCB) for Hackaday Supercon 2024, held November 1-3rd in Pasadena.

<img src="/img/front.png" width="420"><img src="/img/back.png" width="420">

# User Guide

By default, when the unit is powered ON, the LEDs will display a random screen-saver display pattern on the white LEDs.

Pressing either button enters into a "Luna Says" game:
- Luna will highlight one of the Elements of Harmony (RGB LEDs)
- You must press the right button to move the cursor and left-click to select the same Element of Harmony.
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

Random screen-scaver display pattern
<img src="/img/idle.gif" width="420">

Luna highlights the Elements of Harmony is a specific order.  You must repeat her pattern.
<img src="/img/simon.gif" width="420">

The Elements of Harmony spin and you must catch each one at the right moment
<img src="/img/cyclone.gif" width="420">

# Design

The state of the SAO may be read (buttons) and written (LEDs) using the I2C serial connection at 100 kHz.

There are 6 pins on the SAO interface.  Two are used for 3V3 and GND power input.  Two are used for I2C.  The remaining two serve as SAO output event flags for button and frame-render-complete events.

<img src="/img/sao_pinout.png" width="420">

The routing of the interface signals on the SAO header may be re-directed by cutting the associated trace and soldering jumper wires to the desired configuration.  The example below shows cutting (ex. with an exacto knife) the SDA and SCL traces (red) and then soldering jumper wires to swap the SDA and SCL lines (green and blue) on the I2C bus.

<img src="sao_swap_traces.png" width="420">

Soldering the "PWR" jumper closed will permanently turn ON the dedicated power LED.

The I2C data and clock lines each have a 10kohm pull up resistor to 3V3 connected.  This can be disable by cutting the traces here:

<img src="/img/sao_i2c_pullups.png" width="420">

There are two buttons and 31 LEDs (the RGB LED consists of three colors each that can be individually controlled).  30 of the LEDs are driven by 6 pins in a charlieplexed configuration.  The remaining debug LED, buttons, and serial interface are assigned dedicated pins on the processor.

**example timing diagram of led 3 and 13 ON then sleep, then again display, then change frame (set brightness vs flush)

The above shows how the brightnesses for each LED are set in a buffer nd then colectively flushed to the visible display.

# API

| Register Map |   |   |   |   |   |
|--------------|---|---|---|---|---|
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |
|              |   |   |   |   |   |

## Buttons

Each button is monitored for short (>50 ms, <500 ms) and long (>500 ms) button presses.  These events are flagged (and processed) when the button is released.  Only one event is flagged upon button release (a long press does NOT raise a short press flag).



## LEDs

LEDs are indexed 0 to 31 per the below.  Generally, RGB LEDs are inexed in a clockwise pattern, while white LEDs are numbered top-to-bottom and left-to-right.  The debug LED is lcoated near the bottom

<img src="/img/led_indexing.png" width="420">

LED operation 

# Resources

- Artwork by hotglewd.com
- JLCPCB Multi Color Silkscreen Specification https://jlcpcb.com/help/article/How-to-design-multi-color-silkscreen-using-EasyEDA
- Contest Specifications https://hackaday.io/contest/197237-supercon-8-add-on-contest/details
- SAO Standard https://hackaday.io/project/175182-simple-add-ons-sao
