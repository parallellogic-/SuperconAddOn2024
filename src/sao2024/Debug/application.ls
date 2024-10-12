   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _SUBMENU_COUNT:
  16  0000 03            	dc.b	3
  17  0001               _SUBMENU_TIME_OUT_MS:
  18  0001 00            	dc.b	0
  19  0002               _SCREEN_SAVER_COUNT_PONY:
  20  0002 03            	dc.b	3
  21  0003               _SCREEN_SAVER_COUNT_SPACE:
  22  0003 02            	dc.b	2
  23  0004               _SCREEN_SAVER_DURATION_MS:
  24  0004 8000          	dc.w	-32768
  55                     ; 11 void setup_application()
  55                     ; 12 {
  57                     	switch	.text
  58  0000               _setup_application:
  62                     ; 13 	setup_serial(0,0);
  64  0000 5f            	clrw	x
  65  0001 cd0000        	call	_setup_serial
  67                     ; 14 	clear_button_events();
  69  0004 cd0000        	call	_clear_button_events
  71                     ; 15 }
  74  0007 81            	ret
 129                     ; 17 void run_application()
 129                     ; 18 {
 130                     	switch	.text
 131  0008               _run_application:
 133  0008 5205          	subw	sp,#5
 134       00000005      OFST:	set	5
 137                     ; 21 	u32 show_top_menu_since_ms=0;
 139  000a ae0000        	ldw	x,#0
 140  000d 1f04          	ldw	(OFST-1,sp),x
 141  000f ae0000        	ldw	x,#0
 142  0012 1f02          	ldw	(OFST-3,sp),x
 144                     ; 22 	setup_application();
 146  0014 adea          	call	_setup_application
 149  0016 205c          	jra	L35
 150  0018               L15:
 151                     ; 25 		if(clear_button_event(0,0)) submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
 153  0018 5f            	clrw	x
 154  0019 cd0000        	call	_clear_button_event
 156  001c 4d            	tnz	a
 157  001d 270e          	jreq	L75
 160  001f 7b01          	ld	a,(OFST-4,sp)
 161  0021 5f            	clrw	x
 162  0022 97            	ld	xl,a
 163  0023 5c            	incw	x
 164  0024 a603          	ld	a,#3
 165  0026 cd0000        	call	c_smodx
 167  0029 01            	rrwa	x,a
 168  002a 6b01          	ld	(OFST-4,sp),a
 169  002c 02            	rlwa	x,a
 171  002d               L75:
 172                     ; 26 		if(is_button_down(0)) show_top_menu_since_ms=millis();
 174  002d 4f            	clr	a
 175  002e cd0000        	call	_is_button_down
 177  0031 4d            	tnz	a
 178  0032 270a          	jreq	L16
 181  0034 cd0000        	call	_millis
 183  0037 96            	ldw	x,sp
 184  0038 1c0002        	addw	x,#OFST-3
 185  003b cd0000        	call	c_rtol
 188  003e               L16:
 189                     ; 27 		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
 191  003e cd0000        	call	_millis
 193  0041 96            	ldw	x,sp
 194  0042 1c0002        	addw	x,#OFST-3
 195  0045 cd0000        	call	c_lcmp
 197  0048 2407          	jruge	L36
 198                     ; 30 			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs and the status LED to give feedback about the button push to the user
 200  004a a60b          	ld	a,#11
 201  004c cd0000        	call	_flush_leds
 204  004f 2023          	jra	L35
 205  0051               L36:
 206                     ; 32 			show_top_menu_since_ms=0;
 208  0051 ae0000        	ldw	x,#0
 209  0054 1f04          	ldw	(OFST-1,sp),x
 210  0056 ae0000        	ldw	x,#0
 211  0059 1f02          	ldw	(OFST-3,sp),x
 213                     ; 33 			switch(submenu_index)
 215  005b 7b01          	ld	a,(OFST-4,sp)
 217                     ; 37 				case 2:{ show_puzzle(); }break;
 218  005d 4d            	tnz	a
 219  005e 2708          	jreq	L12
 220  0060 4a            	dec	a
 221  0061 2709          	jreq	L32
 222  0063 4a            	dec	a
 223  0064 270b          	jreq	L52
 224  0066 200c          	jra	L35
 225  0068               L12:
 226                     ; 35 				case 0:{ show_screen_savers(); }break;
 228  0068 ad26          	call	_show_screen_savers
 232  006a 2008          	jra	L35
 233  006c               L32:
 234                     ; 36 				case 1:{ show_cyclone(); }break;
 236  006c cd0159        	call	_show_cyclone
 240  006f 2003          	jra	L35
 241  0071               L52:
 242                     ; 37 				case 2:{ show_puzzle(); }break;
 244  0071 cd0160        	call	_show_puzzle
 248  0074               L17:
 249  0074               L35:
 250                     ; 23 	while(is_application_valid())
 252  0074 cd0000        	call	_is_application_valid
 254  0077 4d            	tnz	a
 255  0078 269e          	jrne	L15
 256                     ; 41 }
 259  007a 5b05          	addw	sp,#5
 260  007c 81            	ret
 306                     ; 43 bool is_submenu_valid()
 306                     ; 44 {
 307                     	switch	.text
 308  007d               _is_submenu_valid:
 312                     ; 45 	return is_application_valid()&&!is_button_down(0);
 314  007d cd0000        	call	_is_application_valid
 316  0080 4d            	tnz	a
 317  0081 270b          	jreq	L21
 318  0083 4f            	clr	a
 319  0084 cd0000        	call	_is_button_down
 321  0087 4d            	tnz	a
 322  0088 2604          	jrne	L21
 323  008a a601          	ld	a,#1
 324  008c 2001          	jra	L41
 325  008e               L21:
 326  008e 4f            	clr	a
 327  008f               L41:
 330  008f 81            	ret
 380                     ; 48 void show_screen_savers()
 380                     ; 49 {
 381                     	switch	.text
 382  0090               _show_screen_savers:
 384  0090 89            	pushw	x
 385       00000002      OFST:	set	2
 388                     ; 50 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 390  0091 a601          	ld	a,#1
 391  0093 6b01          	ld	(OFST-1,sp),a
 393                     ; 51 	u8 screen_saver_index=0;
 395  0095 0f02          	clr	(OFST+0,sp)
 398  0097 204e          	jra	L151
 399  0099               L741:
 400                     ; 54 		if(is_auto_cycle)
 402  0099 0d01          	tnz	(OFST-1,sp)
 403  009b 2719          	jreq	L551
 404                     ; 56 			screen_saver_index=millis()/SCREEN_SAVER_DURATION_MS;
 406  009d cd0000        	call	_millis
 408  00a0 a60f          	ld	a,#15
 409  00a2 cd0000        	call	c_lursh
 411  00a5 b603          	ld	a,c_lreg+3
 412  00a7 6b02          	ld	(OFST+0,sp),a
 414                     ; 57 			if(clear_button_event(1,1)) is_auto_cycle=0;
 416  00a9 ae0101        	ldw	x,#257
 417  00ac cd0000        	call	_clear_button_event
 419  00af 4d            	tnz	a
 420  00b0 271c          	jreq	L161
 423  00b2 0f01          	clr	(OFST-1,sp)
 425  00b4 2018          	jra	L161
 426  00b6               L551:
 427                     ; 59 			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
 429  00b6 ae0100        	ldw	x,#256
 430  00b9 cd0000        	call	_clear_button_event
 432  00bc 4d            	tnz	a
 433  00bd 2702          	jreq	L361
 436  00bf 0c02          	inc	(OFST+0,sp)
 438  00c1               L361:
 439                     ; 60 			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
 441  00c1 ae0101        	ldw	x,#257
 442  00c4 cd0000        	call	_clear_button_event
 444  00c7 4d            	tnz	a
 445  00c8 2704          	jreq	L161
 448  00ca a601          	ld	a,#1
 449  00cc 6b01          	ld	(OFST-1,sp),a
 451  00ce               L161:
 452                     ; 63 		switch(screen_saver_index)
 454  00ce 7b02          	ld	a,(OFST+0,sp)
 456                     ; 69 			case 4:{  }break;
 457  00d0 4d            	tnz	a
 458  00d1 270e          	jreq	L311
 459  00d3 4a            	dec	a
 460  00d4 270f          	jreq	L511
 461  00d6 4a            	dec	a
 462  00d7 270e          	jreq	L151
 463  00d9 4a            	dec	a
 464  00da 270b          	jreq	L151
 465  00dc 4a            	dec	a
 466  00dd 2708          	jreq	L151
 467  00df 2006          	jra	L151
 468  00e1               L311:
 469                     ; 65 			case 0:{ set_frame_rainbow(); }break;
 471  00e1 ad0b          	call	_set_frame_rainbow
 475  00e3 2002          	jra	L151
 476  00e5               L511:
 477                     ; 66 			case 1:{ set_frame_blink(); }break;
 479  00e5 ad0d          	call	_set_frame_blink
 483  00e7               L171:
 484  00e7               L151:
 485                     ; 52 	while(is_submenu_valid())
 487  00e7 ad94          	call	_is_submenu_valid
 489  00e9 4d            	tnz	a
 490  00ea 26ad          	jrne	L741
 491                     ; 72 }
 494  00ec 85            	popw	x
 495  00ed 81            	ret
 519                     ; 74 void set_frame_rainbow()
 519                     ; 75 {
 520                     	switch	.text
 521  00ee               _set_frame_rainbow:
 525                     ; 78 	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
 527  00ee a615          	ld	a,#21
 528  00f0 cd0000        	call	_flush_leds
 530                     ; 79 }
 533  00f3 81            	ret
 626                     ; 81 void set_frame_blink()
 626                     ; 82 {
 627                     	switch	.text
 628  00f4               _set_frame_blink:
 630  00f4 5209          	subw	sp,#9
 631       00000009      OFST:	set	9
 634                     ; 84 	u8 LED_WHITE_COUNT=12;
 636                     ; 85 	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
 638  00f6 a61e          	ld	a,#30
 639  00f8 6b02          	ld	(OFST-7,sp),a
 641                     ; 86 	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
 643  00fa a604          	ld	a,#4
 644  00fc 6b05          	ld	(OFST-4,sp),a
 646                     ; 87 	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
 648  00fe ae002a        	ldw	x,#42
 649  0101 1f03          	ldw	(OFST-6,sp),x
 651                     ; 88 	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
 653  0103 cd0000        	call	_millis
 655  0106 a607          	ld	a,#7
 656  0108 cd0000        	call	c_lursh
 658  010b be02          	ldw	x,c_lreg+2
 659  010d 1f07          	ldw	(OFST-2,sp),x
 661                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 663  010f 0f06          	clr	(OFST-3,sp)
 666  0111 2037          	jra	L552
 667  0113               L152:
 668                     ; 93 		x=get_random(x);
 670  0113 1e07          	ldw	x,(OFST-2,sp)
 671  0115 cd0000        	call	_get_random
 673  0118 1f07          	ldw	(OFST-2,sp),x
 675                     ; 94 		led_index=x%m;
 677  011a 1e07          	ldw	x,(OFST-2,sp)
 678  011c 1603          	ldw	y,(OFST-6,sp)
 679  011e 65            	divw	x,y
 680  011f 51            	exgw	x,y
 681  0120 01            	rrwa	x,a
 682  0121 6b09          	ld	(OFST+0,sp),a
 683  0123 02            	rlwa	x,a
 685                     ; 95 		if(led_index>=RGB_ELEMENT_COUNT)
 687  0124 7b09          	ld	a,(OFST+0,sp)
 688  0126 1102          	cp	a,(OFST-7,sp)
 689  0128 241e          	jruge	L362
 691                     ; 99 			set_rgb(led_index/3,led_index%3,255);
 693  012a 4bff          	push	#255
 694  012c 7b0a          	ld	a,(OFST+1,sp)
 695  012e 5f            	clrw	x
 696  012f 97            	ld	xl,a
 697  0130 a603          	ld	a,#3
 698  0132 62            	div	x,a
 699  0133 5f            	clrw	x
 700  0134 97            	ld	xl,a
 701  0135 9f            	ld	a,xl
 702  0136 97            	ld	xl,a
 703  0137 7b0a          	ld	a,(OFST+1,sp)
 704  0139 905f          	clrw	y
 705  013b 9097          	ld	yl,a
 706  013d a603          	ld	a,#3
 707  013f 9062          	div	y,a
 708  0141 909f          	ld	a,yl
 709  0143 95            	ld	xh,a
 710  0144 cd0000        	call	_set_rgb
 712  0147 84            	pop	a
 713  0148               L362:
 714                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 716  0148 0c06          	inc	(OFST-3,sp)
 718  014a               L552:
 721  014a 7b06          	ld	a,(OFST-3,sp)
 722  014c 1105          	cp	a,(OFST-4,sp)
 723  014e 25c3          	jrult	L152
 724                     ; 102 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
 726  0150 7b05          	ld	a,(OFST-4,sp)
 727  0152 4c            	inc	a
 728  0153 cd0000        	call	_flush_leds
 730                     ; 103 }
 733  0156 5b09          	addw	sp,#9
 734  0158 81            	ret
 758                     ; 106 void show_cyclone()
 758                     ; 107 {
 759                     	switch	.text
 760  0159               _show_cyclone:
 764  0159               L772:
 765                     ; 108 	while(is_submenu_valid())
 767  0159 cd007d        	call	_is_submenu_valid
 769  015c 4d            	tnz	a
 770  015d 26fa          	jrne	L772
 771                     ; 112 }
 774  015f 81            	ret
 798                     ; 114 void show_puzzle()
 798                     ; 115 {
 799                     	switch	.text
 800  0160               _show_puzzle:
 804  0160               L513:
 805                     ; 116 	while(is_submenu_valid())
 807  0160 cd007d        	call	_is_submenu_valid
 809  0163 4d            	tnz	a
 810  0164 26fa          	jrne	L513
 811                     ; 120 }
 814  0166 81            	ret
 878                     	xdef	_SCREEN_SAVER_DURATION_MS
 879                     	xdef	_SCREEN_SAVER_COUNT_SPACE
 880                     	xdef	_SCREEN_SAVER_COUNT_PONY
 881                     	xdef	_SUBMENU_TIME_OUT_MS
 882                     	xdef	_SUBMENU_COUNT
 883                     	xdef	_set_frame_blink
 884                     	xdef	_set_frame_rainbow
 885                     	xdef	_is_submenu_valid
 886                     	xdef	_show_puzzle
 887                     	xdef	_show_cyclone
 888                     	xdef	_show_screen_savers
 889                     	xdef	_run_application
 890                     	xdef	_setup_application
 891                     	xref	_get_random
 892                     	xref	_is_button_down
 893                     	xref	_clear_button_events
 894                     	xref	_clear_button_event
 895                     	xref	_flush_leds
 896                     	xref	_set_rgb
 897                     	xref	_millis
 898                     	xref	_is_application_valid
 899                     	xref	_setup_serial
 900                     	xref.b	c_lreg
 901                     	xref.b	c_x
 920                     	xref	c_lursh
 921                     	xref	c_lcmp
 922                     	xref	c_rtol
 923                     	xref	c_smodx
 924                     	end
