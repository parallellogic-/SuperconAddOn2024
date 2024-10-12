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
 115                     ; 11 void run_application()
 115                     ; 12 {
 116                     	switch	.text
 117  0008               _run_application:
 119  0008 5205          	subw	sp,#5
 120       00000005      OFST:	set	5
 123                     ; 15 	u32 show_top_menu_since_ms=0;
 125                     ; 16 	setup_application();
 127  000a adf4          	call	_setup_application
 130  000c 2028          	jra	L35
 131  000e               L15:
 132                     ; 20 		if(is_button_down(0)) show_top_menu_since_ms=millis();
 134  000e 4f            	clr	a
 135  000f cd0000        	call	_is_button_down
 137  0012 4d            	tnz	a
 138  0013 2703          	jreq	L75
 141  0015 cd0000        	call	_millis
 143  0018               L75:
 144                     ; 24 			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs and the status LED to give feedback about the button push to the user
 146  0018 a60b          	ld	a,#11
 147  001a cd0000        	call	_flush_leds
 149                     ; 26 			show_top_menu_since_ms=0;
 151                     ; 27 			switch(submenu_index)
 153  001d 7b01          	ld	a,(OFST-4,sp)
 155                     ; 31 				case 2:{ show_puzzle(); }break;
 156  001f 4d            	tnz	a
 157  0020 2708          	jreq	L12
 158  0022 4a            	dec	a
 159  0023 2709          	jreq	L32
 160  0025 4a            	dec	a
 161  0026 270b          	jreq	L52
 162  0028 200c          	jra	L35
 163  002a               L12:
 164                     ; 29 				case 0:{ show_screen_savers(); }break;
 166  002a ad26          	call	_show_screen_savers
 170  002c 2008          	jra	L35
 171  002e               L32:
 172                     ; 30 				case 1:{ show_cyclone(); }break;
 174  002e cd010f        	call	_show_cyclone
 178  0031 2003          	jra	L35
 179  0033               L52:
 180                     ; 31 				case 2:{ show_puzzle(); }break;
 182  0033 cd0116        	call	_show_puzzle
 186  0036               L36:
 187  0036               L35:
 188                     ; 17 	while(is_application_valid())
 190  0036 cd0000        	call	_is_application_valid
 192  0039 4d            	tnz	a
 193  003a 26d2          	jrne	L15
 194                     ; 35 }
 197  003c 5b05          	addw	sp,#5
 198  003e 81            	ret
 244                     ; 37 bool is_submenu_valid()
 244                     ; 38 {
 245                     	switch	.text
 246  003f               _is_submenu_valid:
 250                     ; 39 	return is_application_valid()&&!is_button_down(0);
 252  003f cd0000        	call	_is_application_valid
 254  0042 4d            	tnz	a
 255  0043 270b          	jreq	L21
 256  0045 4f            	clr	a
 257  0046 cd0000        	call	_is_button_down
 259  0049 4d            	tnz	a
 260  004a 2604          	jrne	L21
 261  004c a601          	ld	a,#1
 262  004e 2001          	jra	L41
 263  0050               L21:
 264  0050 4f            	clr	a
 265  0051               L41:
 268  0051 81            	ret
 316                     ; 42 void show_screen_savers()
 316                     ; 43 {
 317                     	switch	.text
 318  0052               _show_screen_savers:
 320  0052 89            	pushw	x
 321       00000002      OFST:	set	2
 324                     ; 44 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 326  0053 a601          	ld	a,#1
 327  0055 6b02          	ld	(OFST+0,sp),a
 329                     ; 45 	u8 screen_saver_index=0;
 331  0057 0f01          	clr	(OFST-1,sp)
 334  0059 2042          	jra	L341
 335  005b               L141:
 336                     ; 48 		if(is_auto_cycle)
 338  005b 0d02          	tnz	(OFST+0,sp)
 339  005d 270d          	jreq	L741
 340                     ; 51 			if(clear_button_event(1,1)) is_auto_cycle=0;
 342  005f ae0101        	ldw	x,#257
 343  0062 cd0000        	call	_clear_button_event
 345  0065 4d            	tnz	a
 346  0066 271c          	jreq	L351
 349  0068 0f02          	clr	(OFST+0,sp)
 351  006a 2018          	jra	L351
 352  006c               L741:
 353                     ; 53 			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
 355  006c ae0100        	ldw	x,#256
 356  006f cd0000        	call	_clear_button_event
 358  0072 4d            	tnz	a
 359  0073 2702          	jreq	L551
 362  0075 0c01          	inc	(OFST-1,sp)
 364  0077               L551:
 365                     ; 54 			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
 367  0077 ae0101        	ldw	x,#257
 368  007a cd0000        	call	_clear_button_event
 370  007d 4d            	tnz	a
 371  007e 2704          	jreq	L351
 374  0080 a601          	ld	a,#1
 375  0082 6b02          	ld	(OFST+0,sp),a
 377  0084               L351:
 378                     ; 57 		switch(screen_saver_index)
 380  0084 7b01          	ld	a,(OFST-1,sp)
 382                     ; 63 			case 4:{  }break;
 383  0086 4d            	tnz	a
 384  0087 270e          	jreq	L501
 385  0089 4a            	dec	a
 386  008a 270f          	jreq	L701
 387  008c 4a            	dec	a
 388  008d 270e          	jreq	L341
 389  008f 4a            	dec	a
 390  0090 270b          	jreq	L341
 391  0092 4a            	dec	a
 392  0093 2708          	jreq	L341
 393  0095 2006          	jra	L341
 394  0097               L501:
 395                     ; 59 			case 0:{ set_frame_rainbow(); }break;
 397  0097 ad0b          	call	_set_frame_rainbow
 401  0099 2002          	jra	L341
 402  009b               L701:
 403                     ; 60 			case 1:{ set_frame_blink(); }break;
 405  009b ad0d          	call	_set_frame_blink
 409  009d               L361:
 410  009d               L341:
 411                     ; 46 	while(is_submenu_valid())
 413  009d ada0          	call	_is_submenu_valid
 415  009f 4d            	tnz	a
 416  00a0 26b9          	jrne	L141
 417                     ; 66 }
 420  00a2 85            	popw	x
 421  00a3 81            	ret
 445                     ; 68 void set_frame_rainbow()
 445                     ; 69 {
 446                     	switch	.text
 447  00a4               _set_frame_rainbow:
 451                     ; 72 	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
 453  00a4 a615          	ld	a,#21
 454  00a6 cd0000        	call	_flush_leds
 456                     ; 73 }
 459  00a9 81            	ret
 552                     ; 75 void set_frame_blink()
 552                     ; 76 {
 553                     	switch	.text
 554  00aa               _set_frame_blink:
 556  00aa 5209          	subw	sp,#9
 557       00000009      OFST:	set	9
 560                     ; 78 	u8 LED_WHITE_COUNT=12;
 562                     ; 79 	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
 564  00ac a61e          	ld	a,#30
 565  00ae 6b02          	ld	(OFST-7,sp),a
 567                     ; 80 	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
 569  00b0 a604          	ld	a,#4
 570  00b2 6b05          	ld	(OFST-4,sp),a
 572                     ; 81 	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
 574  00b4 ae002a        	ldw	x,#42
 575  00b7 1f03          	ldw	(OFST-6,sp),x
 577                     ; 82 	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
 579  00b9 cd0000        	call	_millis
 581  00bc a607          	ld	a,#7
 582  00be cd0000        	call	c_lursh
 584  00c1 be02          	ldw	x,c_lreg+2
 585  00c3 1f07          	ldw	(OFST-2,sp),x
 587                     ; 85 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 589  00c5 0f06          	clr	(OFST-3,sp)
 592  00c7 2037          	jra	L742
 593  00c9               L342:
 594                     ; 87 		x=get_random(x);
 596  00c9 1e07          	ldw	x,(OFST-2,sp)
 597  00cb cd0000        	call	_get_random
 599  00ce 1f07          	ldw	(OFST-2,sp),x
 601                     ; 88 		led_index=x%m;
 603  00d0 1e07          	ldw	x,(OFST-2,sp)
 604  00d2 1603          	ldw	y,(OFST-6,sp)
 605  00d4 65            	divw	x,y
 606  00d5 51            	exgw	x,y
 607  00d6 01            	rrwa	x,a
 608  00d7 6b09          	ld	(OFST+0,sp),a
 609  00d9 02            	rlwa	x,a
 611                     ; 89 		if(led_index>=RGB_ELEMENT_COUNT)
 613  00da 7b09          	ld	a,(OFST+0,sp)
 614  00dc 1102          	cp	a,(OFST-7,sp)
 615  00de 241e          	jruge	L552
 617                     ; 93 			set_rgb(led_index/3,led_index%3,255);
 619  00e0 4bff          	push	#255
 620  00e2 7b0a          	ld	a,(OFST+1,sp)
 621  00e4 5f            	clrw	x
 622  00e5 97            	ld	xl,a
 623  00e6 a603          	ld	a,#3
 624  00e8 62            	div	x,a
 625  00e9 5f            	clrw	x
 626  00ea 97            	ld	xl,a
 627  00eb 9f            	ld	a,xl
 628  00ec 97            	ld	xl,a
 629  00ed 7b0a          	ld	a,(OFST+1,sp)
 630  00ef 905f          	clrw	y
 631  00f1 9097          	ld	yl,a
 632  00f3 a603          	ld	a,#3
 633  00f5 9062          	div	y,a
 634  00f7 909f          	ld	a,yl
 635  00f9 95            	ld	xh,a
 636  00fa cd0000        	call	_set_rgb
 638  00fd 84            	pop	a
 639  00fe               L552:
 640                     ; 85 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 642  00fe 0c06          	inc	(OFST-3,sp)
 644  0100               L742:
 647  0100 7b06          	ld	a,(OFST-3,sp)
 648  0102 1105          	cp	a,(OFST-4,sp)
 649  0104 25c3          	jrult	L342
 650                     ; 96 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
 652  0106 7b05          	ld	a,(OFST-4,sp)
 653  0108 4c            	inc	a
 654  0109 cd0000        	call	_flush_leds
 656                     ; 97 }
 659  010c 5b09          	addw	sp,#9
 660  010e 81            	ret
 684                     ; 100 void show_cyclone()
 684                     ; 101 {
 685                     	switch	.text
 686  010f               _show_cyclone:
 690  010f               L172:
 691                     ; 102 	while(is_submenu_valid())
 693  010f cd003f        	call	_is_submenu_valid
 695  0112 4d            	tnz	a
 696  0113 26fa          	jrne	L172
 697                     ; 106 }
 700  0115 81            	ret
 724                     ; 108 void show_puzzle()
 724                     ; 109 {
 725                     	switch	.text
 726  0116               _show_puzzle:
 730  0116               L703:
 731                     ; 110 	while(is_submenu_valid())
 733  0116 cd003f        	call	_is_submenu_valid
 735  0119 4d            	tnz	a
 736  011a 26fa          	jrne	L703
 737                     ; 114 }
 740  011c 81            	ret
 753                     	xdef	_set_frame_blink
 754                     	xdef	_set_frame_rainbow
 755                     	xdef	_is_submenu_valid
 756                     	xdef	_show_puzzle
 757                     	xdef	_show_cyclone
 758                     	xdef	_show_screen_savers
 759                     	xdef	_run_application
 760                     	xdef	_setup_application
 761                     	xref	_get_random
 762                     	xref	_is_button_down
 763                     	xref	_clear_button_events
 764                     	xref	_clear_button_event
 765                     	xref	_flush_leds
 766                     	xref	_set_rgb
 767                     	xref	_millis
 768                     	xref	_is_application_valid
 769                     	xref	_setup_serial
 770                     	xref.b	c_lreg
 789                     	xref	c_lursh
 790                     	end
