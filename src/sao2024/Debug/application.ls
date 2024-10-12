   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 5 void setup_application()
  44                     ; 6 {
  46                     	switch	.text
  47  0000               _setup_application:
  51                     ; 7 	setup_serial(0,0);
  53  0000 5f            	clrw	x
  54  0001 cd0000        	call	_setup_serial
  56                     ; 8 	clear_button_events();
  58  0004 cd0000        	call	_clear_button_events
  60                     ; 9 }
  63  0007 81            	ret
 102                     ; 11 void run_application()
 102                     ; 12 {
 103                     	switch	.text
 104  0008               _run_application:
 106  0008 5204          	subw	sp,#4
 107       00000004      OFST:	set	4
 110                     ; 15 	u32 show_top_menu_since_ms=0;
 112                     ; 16 	setup_application();
 114  000a adf4          	call	_setup_application
 117  000c 2005          	jra	L14
 118  000e               L73:
 119                     ; 19 		flush_leds(set_frame_rainbow());
 121  000e ad0c          	call	_set_frame_rainbow
 123  0010 cd0000        	call	_flush_leds
 125  0013               L14:
 126                     ; 17 	while(is_application_valid())
 128  0013 cd0000        	call	_is_application_valid
 130  0016 4d            	tnz	a
 131  0017 26f5          	jrne	L73
 132                     ; 21 }
 135  0019 5b04          	addw	sp,#4
 136  001b 81            	ret
 181                     ; 23 u8 set_frame_rainbow()
 181                     ; 24 {
 182                     	switch	.text
 183  001c               _set_frame_rainbow:
 185  001c 5203          	subw	sp,#3
 186       00000003      OFST:	set	3
 189                     ; 26 	u16 offset=0;
 191  001e 5f            	clrw	x
 192  001f 1f01          	ldw	(OFST-2,sp),x
 194                     ; 27 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 196  0021 0f03          	clr	(OFST+0,sp)
 198  0023               L76:
 199                     ; 29 		set_hue_max(iter,(u16)(millis()<<5)+offset);
 201  0023 cd0000        	call	_millis
 203  0026 a605          	ld	a,#5
 204  0028 cd0000        	call	c_llsh
 206  002b be02          	ldw	x,c_lreg+2
 207  002d 72fb01        	addw	x,(OFST-2,sp)
 208  0030 89            	pushw	x
 209  0031 7b05          	ld	a,(OFST+2,sp)
 210  0033 cd0000        	call	_set_hue_max
 212  0036 85            	popw	x
 213                     ; 30 		offset+=0x2AAB;
 215  0037 1e01          	ldw	x,(OFST-2,sp)
 216  0039 1c2aab        	addw	x,#10923
 217  003c 1f01          	ldw	(OFST-2,sp),x
 219                     ; 27 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 221  003e 0c03          	inc	(OFST+0,sp)
 225  0040 7b03          	ld	a,(OFST+0,sp)
 226  0042 a106          	cp	a,#6
 227  0044 25dd          	jrult	L76
 228                     ; 32 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
 230  0046 a606          	ld	a,#6
 233  0048 5b03          	addw	sp,#3
 234  004a 81            	ret
 257                     ; 35 u8 set_sparkles()
 257                     ; 36 {
 258                     	switch	.text
 259  004b               _set_sparkles:
 263                     ; 38 }
 266  004b 81            	ret
 279                     	xdef	_set_sparkles
 280                     	xdef	_set_frame_rainbow
 281                     	xdef	_run_application
 282                     	xdef	_setup_application
 283                     	xref	_clear_button_events
 284                     	xref	_set_hue_max
 285                     	xref	_flush_leds
 286                     	xref	_millis
 287                     	xref	_is_application_valid
 288                     	xref	_setup_serial
 289                     	xref.b	c_lreg
 308                     	xref	c_llsh
 309                     	end
