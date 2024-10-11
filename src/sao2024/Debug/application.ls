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
 139                     ; 17 void run_application()
 139                     ; 18 {
 140                     	switch	.text
 141  0008               _run_application:
 143  0008 5206          	subw	sp,#6
 144       00000006      OFST:	set	6
 147                     ; 21 	u32 show_top_menu_since_ms=0;
 149  000a ae0000        	ldw	x,#0
 150  000d 1f03          	ldw	(OFST-3,sp),x
 151  000f ae0000        	ldw	x,#0
 152  0012 1f01          	ldw	(OFST-5,sp),x
 154                     ; 22 	setup_application();
 156  0014 adea          	call	_setup_application
 159  0016 207b          	jra	L75
 160  0018               L55:
 161                     ; 25 		if(clear_button_event(0,0)) submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
 163  0018 5f            	clrw	x
 164  0019 cd0000        	call	_clear_button_event
 166  001c 4d            	tnz	a
 167  001d 270e          	jreq	L36
 170  001f 7b05          	ld	a,(OFST-1,sp)
 171  0021 5f            	clrw	x
 172  0022 97            	ld	xl,a
 173  0023 5c            	incw	x
 174  0024 a603          	ld	a,#3
 175  0026 cd0000        	call	c_smodx
 177  0029 01            	rrwa	x,a
 178  002a 6b05          	ld	(OFST-1,sp),a
 179  002c 02            	rlwa	x,a
 181  002d               L36:
 182                     ; 26 		if(is_button_down(0)) show_top_menu_since_ms=millis();
 184  002d 4f            	clr	a
 185  002e cd0000        	call	_is_button_down
 187  0031 4d            	tnz	a
 188  0032 270a          	jreq	L56
 191  0034 cd0000        	call	_millis
 193  0037 96            	ldw	x,sp
 194  0038 1c0001        	addw	x,#OFST-5
 195  003b cd0000        	call	c_rtol
 198  003e               L56:
 199                     ; 27 		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
 201  003e cd0000        	call	_millis
 203  0041 96            	ldw	x,sp
 204  0042 1c0001        	addw	x,#OFST-5
 205  0045 cd0000        	call	c_lcmp
 207  0048 2426          	jruge	L76
 208                     ; 29 			for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,submenu_index<<13,255);//set all LEDs to the same color
 210  004a 0f06          	clr	(OFST+0,sp)
 212  004c               L17:
 215  004c 4bff          	push	#255
 216  004e 7b06          	ld	a,(OFST+0,sp)
 217  0050 5f            	clrw	x
 218  0051 97            	ld	xl,a
 219  0052 9f            	ld	a,xl
 220  0053 4e            	swap	a
 221  0054 48            	sll	a
 222  0055 a4e0          	and	a,#224
 223  0057 5f            	clrw	x
 224  0058 95            	ld	xh,a
 225  0059 89            	pushw	x
 226  005a 7b09          	ld	a,(OFST+3,sp)
 227  005c cd0000        	call	_set_hue
 229  005f 5b03          	addw	sp,#3
 232  0061 0c06          	inc	(OFST+0,sp)
 236  0063 7b06          	ld	a,(OFST+0,sp)
 237  0065 a10a          	cp	a,#10
 238  0067 25e3          	jrult	L17
 239                     ; 30 			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs and the status LED to give feedback about the button push to the user
 241  0069 a60b          	ld	a,#11
 242  006b cd0000        	call	_flush_leds
 245  006e 2023          	jra	L75
 246  0070               L76:
 247                     ; 32 			show_top_menu_since_ms=0;
 249  0070 ae0000        	ldw	x,#0
 250  0073 1f03          	ldw	(OFST-3,sp),x
 251  0075 ae0000        	ldw	x,#0
 252  0078 1f01          	ldw	(OFST-5,sp),x
 254                     ; 33 			switch(submenu_index)
 256  007a 7b05          	ld	a,(OFST-1,sp)
 258                     ; 37 				case 2:{ show_puzzle(); }break;
 259  007c 4d            	tnz	a
 260  007d 2708          	jreq	L12
 261  007f 4a            	dec	a
 262  0080 2709          	jreq	L32
 263  0082 4a            	dec	a
 264  0083 270b          	jreq	L52
 265  0085 200c          	jra	L75
 266  0087               L12:
 267                     ; 35 				case 0:{ show_screen_savers(); }break;
 269  0087 ad29          	call	_show_screen_savers
 273  0089 2008          	jra	L75
 274  008b               L32:
 275                     ; 36 				case 1:{ show_cyclone(); }break;
 277  008b cd01b9        	call	_show_cyclone
 281  008e 2003          	jra	L75
 282  0090               L52:
 283                     ; 37 				case 2:{ show_puzzle(); }break;
 285  0090 cd01c0        	call	_show_puzzle
 289  0093               L301:
 290  0093               L75:
 291                     ; 23 	while(is_application_valid())
 293  0093 cd0000        	call	_is_application_valid
 295  0096 4d            	tnz	a
 296  0097 2703cc0018    	jrne	L55
 297                     ; 41 }
 300  009c 5b06          	addw	sp,#6
 301  009e 81            	ret
 347                     ; 43 bool is_submenu_valid()
 347                     ; 44 {
 348                     	switch	.text
 349  009f               _is_submenu_valid:
 353                     ; 45 	return is_application_valid()&&!is_button_down(0);
 355  009f cd0000        	call	_is_application_valid
 357  00a2 4d            	tnz	a
 358  00a3 270b          	jreq	L21
 359  00a5 4f            	clr	a
 360  00a6 cd0000        	call	_is_button_down
 362  00a9 4d            	tnz	a
 363  00aa 2604          	jrne	L21
 364  00ac a601          	ld	a,#1
 365  00ae 2001          	jra	L41
 366  00b0               L21:
 367  00b0 4f            	clr	a
 368  00b1               L41:
 371  00b1 81            	ret
 421                     ; 48 void show_screen_savers()
 421                     ; 49 {
 422                     	switch	.text
 423  00b2               _show_screen_savers:
 425  00b2 89            	pushw	x
 426       00000002      OFST:	set	2
 429                     ; 50 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 431  00b3 a601          	ld	a,#1
 432  00b5 6b01          	ld	(OFST-1,sp),a
 434                     ; 51 	u8 screen_saver_index=0;
 436  00b7 0f02          	clr	(OFST+0,sp)
 439  00b9 204e          	jra	L361
 440  00bb               L161:
 441                     ; 54 		if(is_auto_cycle)
 443  00bb 0d01          	tnz	(OFST-1,sp)
 444  00bd 2719          	jreq	L761
 445                     ; 56 			screen_saver_index=millis()/SCREEN_SAVER_DURATION_MS;
 447  00bf cd0000        	call	_millis
 449  00c2 a60f          	ld	a,#15
 450  00c4 cd0000        	call	c_lursh
 452  00c7 b603          	ld	a,c_lreg+3
 453  00c9 6b02          	ld	(OFST+0,sp),a
 455                     ; 57 			if(clear_button_event(1,1)) is_auto_cycle=0;
 457  00cb ae0101        	ldw	x,#257
 458  00ce cd0000        	call	_clear_button_event
 460  00d1 4d            	tnz	a
 461  00d2 271c          	jreq	L371
 464  00d4 0f01          	clr	(OFST-1,sp)
 466  00d6 2018          	jra	L371
 467  00d8               L761:
 468                     ; 59 			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
 470  00d8 ae0100        	ldw	x,#256
 471  00db cd0000        	call	_clear_button_event
 473  00de 4d            	tnz	a
 474  00df 2702          	jreq	L571
 477  00e1 0c02          	inc	(OFST+0,sp)
 479  00e3               L571:
 480                     ; 60 			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
 482  00e3 ae0101        	ldw	x,#257
 483  00e6 cd0000        	call	_clear_button_event
 485  00e9 4d            	tnz	a
 486  00ea 2704          	jreq	L371
 489  00ec a601          	ld	a,#1
 490  00ee 6b01          	ld	(OFST-1,sp),a
 492  00f0               L371:
 493                     ; 63 		switch(screen_saver_index)
 495  00f0 7b02          	ld	a,(OFST+0,sp)
 497                     ; 69 			case 4:{  }break;
 498  00f2 4d            	tnz	a
 499  00f3 270e          	jreq	L521
 500  00f5 4a            	dec	a
 501  00f6 270f          	jreq	L721
 502  00f8 4a            	dec	a
 503  00f9 270e          	jreq	L361
 504  00fb 4a            	dec	a
 505  00fc 270b          	jreq	L361
 506  00fe 4a            	dec	a
 507  00ff 2708          	jreq	L361
 508  0101 2006          	jra	L361
 509  0103               L521:
 510                     ; 65 			case 0:{ set_frame_rainbow(); }break;
 512  0103 ad0b          	call	_set_frame_rainbow
 516  0105 2002          	jra	L361
 517  0107               L721:
 518                     ; 66 			case 1:{ set_frame_blink(); }break;
 520  0107 ad4b          	call	_set_frame_blink
 524  0109               L302:
 525  0109               L361:
 526                     ; 52 	while(is_submenu_valid())
 528  0109 ad94          	call	_is_submenu_valid
 530  010b 4d            	tnz	a
 531  010c 26ad          	jrne	L161
 532                     ; 72 }
 535  010e 85            	popw	x
 536  010f 81            	ret
 573                     ; 74 void set_frame_rainbow()
 573                     ; 75 {
 574                     	switch	.text
 575  0110               _set_frame_rainbow:
 577  0110 5205          	subw	sp,#5
 578       00000005      OFST:	set	5
 581                     ; 77 	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,(u16)(millis()*32+(0xFFFF/10)*iter),255);
 583  0112 0f05          	clr	(OFST+0,sp)
 585  0114               L322:
 588  0114 4bff          	push	#255
 589  0116 7b06          	ld	a,(OFST+1,sp)
 590  0118 5f            	clrw	x
 591  0119 97            	ld	xl,a
 592  011a 90ae1999      	ldw	y,#6553
 593  011e cd0000        	call	c_imul
 595  0121 cd0000        	call	c_uitolx
 597  0124 96            	ldw	x,sp
 598  0125 1c0002        	addw	x,#OFST-3
 599  0128 cd0000        	call	c_rtol
 602  012b cd0000        	call	_millis
 604  012e a605          	ld	a,#5
 605  0130 cd0000        	call	c_llsh
 607  0133 96            	ldw	x,sp
 608  0134 1c0002        	addw	x,#OFST-3
 609  0137 cd0000        	call	c_ladd
 611  013a be02          	ldw	x,c_lreg+2
 612  013c 89            	pushw	x
 613  013d 7b08          	ld	a,(OFST+3,sp)
 614  013f cd0000        	call	_set_hue
 616  0142 5b03          	addw	sp,#3
 619  0144 0c05          	inc	(OFST+0,sp)
 623  0146 7b05          	ld	a,(OFST+0,sp)
 624  0148 a10a          	cp	a,#10
 625  014a 25c8          	jrult	L322
 626                     ; 78 	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
 628  014c a615          	ld	a,#21
 629  014e cd0000        	call	_flush_leds
 631                     ; 79 }
 634  0151 5b05          	addw	sp,#5
 635  0153 81            	ret
 728                     ; 81 void set_frame_blink()
 728                     ; 82 {
 729                     	switch	.text
 730  0154               _set_frame_blink:
 732  0154 5209          	subw	sp,#9
 733       00000009      OFST:	set	9
 736                     ; 84 	u8 LED_WHITE_COUNT=12;
 738                     ; 85 	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
 740  0156 a61e          	ld	a,#30
 741  0158 6b02          	ld	(OFST-7,sp),a
 743                     ; 86 	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
 745  015a a604          	ld	a,#4
 746  015c 6b05          	ld	(OFST-4,sp),a
 748                     ; 87 	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
 750  015e ae002a        	ldw	x,#42
 751  0161 1f03          	ldw	(OFST-6,sp),x
 753                     ; 88 	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
 755  0163 cd0000        	call	_millis
 757  0166 a607          	ld	a,#7
 758  0168 cd0000        	call	c_lursh
 760  016b be02          	ldw	x,c_lreg+2
 761  016d 1f07          	ldw	(OFST-2,sp),x
 763                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 765  016f 0f06          	clr	(OFST-3,sp)
 768  0171 2037          	jra	L303
 769  0173               L772:
 770                     ; 93 		x=get_random(x);
 772  0173 1e07          	ldw	x,(OFST-2,sp)
 773  0175 cd0000        	call	_get_random
 775  0178 1f07          	ldw	(OFST-2,sp),x
 777                     ; 94 		led_index=x%m;
 779  017a 1e07          	ldw	x,(OFST-2,sp)
 780  017c 1603          	ldw	y,(OFST-6,sp)
 781  017e 65            	divw	x,y
 782  017f 51            	exgw	x,y
 783  0180 01            	rrwa	x,a
 784  0181 6b09          	ld	(OFST+0,sp),a
 785  0183 02            	rlwa	x,a
 787                     ; 95 		if(led_index>=RGB_ELEMENT_COUNT)
 789  0184 7b09          	ld	a,(OFST+0,sp)
 790  0186 1102          	cp	a,(OFST-7,sp)
 791  0188 241e          	jruge	L113
 793                     ; 99 			set_rgb(led_index/3,led_index%3,255);
 795  018a 4bff          	push	#255
 796  018c 7b0a          	ld	a,(OFST+1,sp)
 797  018e 5f            	clrw	x
 798  018f 97            	ld	xl,a
 799  0190 a603          	ld	a,#3
 800  0192 62            	div	x,a
 801  0193 5f            	clrw	x
 802  0194 97            	ld	xl,a
 803  0195 9f            	ld	a,xl
 804  0196 97            	ld	xl,a
 805  0197 7b0a          	ld	a,(OFST+1,sp)
 806  0199 905f          	clrw	y
 807  019b 9097          	ld	yl,a
 808  019d a603          	ld	a,#3
 809  019f 9062          	div	y,a
 810  01a1 909f          	ld	a,yl
 811  01a3 95            	ld	xh,a
 812  01a4 cd0000        	call	_set_rgb
 814  01a7 84            	pop	a
 815  01a8               L113:
 816                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 818  01a8 0c06          	inc	(OFST-3,sp)
 820  01aa               L303:
 823  01aa 7b06          	ld	a,(OFST-3,sp)
 824  01ac 1105          	cp	a,(OFST-4,sp)
 825  01ae 25c3          	jrult	L772
 826                     ; 102 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
 828  01b0 7b05          	ld	a,(OFST-4,sp)
 829  01b2 4c            	inc	a
 830  01b3 cd0000        	call	_flush_leds
 832                     ; 103 }
 835  01b6 5b09          	addw	sp,#9
 836  01b8 81            	ret
 860                     ; 106 void show_cyclone()
 860                     ; 107 {
 861                     	switch	.text
 862  01b9               _show_cyclone:
 866  01b9               L523:
 867                     ; 108 	while(is_submenu_valid())
 869  01b9 cd009f        	call	_is_submenu_valid
 871  01bc 4d            	tnz	a
 872  01bd 26fa          	jrne	L523
 873                     ; 112 }
 876  01bf 81            	ret
 900                     ; 114 void show_puzzle()
 900                     ; 115 {
 901                     	switch	.text
 902  01c0               _show_puzzle:
 906  01c0               L343:
 907                     ; 116 	while(is_submenu_valid())
 909  01c0 cd009f        	call	_is_submenu_valid
 911  01c3 4d            	tnz	a
 912  01c4 26fa          	jrne	L343
 913                     ; 120 }
 916  01c6 81            	ret
 980                     	xdef	_SCREEN_SAVER_DURATION_MS
 981                     	xdef	_SCREEN_SAVER_COUNT_SPACE
 982                     	xdef	_SCREEN_SAVER_COUNT_PONY
 983                     	xdef	_SUBMENU_TIME_OUT_MS
 984                     	xdef	_SUBMENU_COUNT
 985                     	xdef	_set_frame_blink
 986                     	xdef	_set_frame_rainbow
 987                     	xdef	_is_submenu_valid
 988                     	xdef	_show_puzzle
 989                     	xdef	_show_cyclone
 990                     	xdef	_show_screen_savers
 991                     	xdef	_run_application
 992                     	xdef	_setup_application
 993                     	xref	_get_random
 994                     	xref	_is_button_down
 995                     	xref	_clear_button_events
 996                     	xref	_clear_button_event
 997                     	xref	_set_hue
 998                     	xref	_flush_leds
 999                     	xref	_set_rgb
1000                     	xref	_millis
1001                     	xref	_is_application_valid
1002                     	xref	_setup_serial
1003                     	xref.b	c_lreg
1004                     	xref.b	c_x
1023                     	xref	c_ladd
1024                     	xref	c_uitolx
1025                     	xref	c_imul
1026                     	xref	c_llsh
1027                     	xref	c_lursh
1028                     	xref	c_lcmp
1029                     	xref	c_rtol
1030                     	xref	c_smodx
1031                     	end
