# Luna Says Supercon Add-On Overview

This repo contains the project files for a Supercon Add-On (SAO) Printed Circuit Board (PCB) for Hackaday Supercon 2024, held November 1-3rd in Pasadena.

<img src="/img/front.png" width="420"><img src="/img/back.png" width="420">

# User Guide

By default, when the unit is powered ON, the LEDs will display a random screen-saver display pattern on the white LEDs.

Pressing either button enters into a "Luna Says" game:
- Luna will highlight one of the Elements of Harmony
- Your job is to highlight the same harmony gem.  Use the right button to change the gem selected.  Use the left button to make your selection
- When you correctly highlight the correct gem, Luna's mane will sparkle and she will then highlight one more gem than before.
- You must then highlight the same gems in the same order
- If you fail to do so, the LEDs will flash red and the game will reset from the beginning.
- The game is won by highlighting all the Elements of Harmony

# Examples

Random screen-scaver display pattern
.gif

Luna highlights an element
.gif

You must enter the same Element of Harmony as her
.gif

# API

I2C
- Echo
- Write with effect (dummy register that holds value and reads back)
- Debug LED ON/OFF
- White LED ON/OFF
- RGB LED ON/OFF
- RGB hue (get/set)
- Any LED brightness
- Full screen get/set
- enable UART, baud rate

GPIO / UART
By default on boot-up the GPIO pins are inputs to the SAO.  They can be configured as a UART pair by issuing the following command over I2C:

EEPROM

# Resources

- Artwork by hotglwed.com
- JLCPCB Multi Color Silkscreen Specification https://jlcpcb.com/help/article/How-to-design-multi-color-silkscreen-using-EasyEDA
- Contest Specifications https://hackaday.io/contest/197237-supercon-8-add-on-contest/details
- SAO Standard https://hackaday.io/project/175182-simple-add-ons-sao
