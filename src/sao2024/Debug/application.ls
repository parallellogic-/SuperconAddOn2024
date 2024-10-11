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
 277  008b cd01e8        	call	_show_cyclone
 281  008e 2003          	jra	L75
 282  0090               L52:
 283                     ; 37 				case 2:{ show_puzzle(); }break;
 285  0090 cd01ef        	call	_show_puzzle
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
 424                     ; 48 void show_screen_savers()
 424                     ; 49 {
 425                     	switch	.text
 426  00b2               _show_screen_savers:
 428  00b2 89            	pushw	x
 429       00000002      OFST:	set	2
 432                     ; 50 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 434  00b3 a601          	ld	a,#1
 435  00b5 6b01          	ld	(OFST-1,sp),a
 437                     ; 51 	u8 screen_saver_index=0;
 439  00b7 0f02          	clr	(OFST+0,sp)
 442  00b9 2069          	jra	L361
 443  00bb               L161:
 444                     ; 54 		if(is_auto_cycle)
 446  00bb 0d01          	tnz	(OFST-1,sp)
 447  00bd 2719          	jreq	L761
 448                     ; 56 			screen_saver_index=millis()/SCREEN_SAVER_DURATION_MS;
 450  00bf cd0000        	call	_millis
 452  00c2 a60f          	ld	a,#15
 453  00c4 cd0000        	call	c_lursh
 455  00c7 b603          	ld	a,c_lreg+3
 456  00c9 6b02          	ld	(OFST+0,sp),a
 458                     ; 57 			if(clear_button_event(1,1)) is_auto_cycle=0;
 460  00cb ae0101        	ldw	x,#257
 461  00ce cd0000        	call	_clear_button_event
 463  00d1 4d            	tnz	a
 464  00d2 271c          	jreq	L371
 467  00d4 0f01          	clr	(OFST-1,sp)
 469  00d6 2018          	jra	L371
 470  00d8               L761:
 471                     ; 59 			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
 473  00d8 ae0100        	ldw	x,#256
 474  00db cd0000        	call	_clear_button_event
 476  00de 4d            	tnz	a
 477  00df 2702          	jreq	L571
 480  00e1 0c02          	inc	(OFST+0,sp)
 482  00e3               L571:
 483                     ; 60 			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
 485  00e3 ae0101        	ldw	x,#257
 486  00e6 cd0000        	call	_clear_button_event
 488  00e9 4d            	tnz	a
 489  00ea 2704          	jreq	L371
 492  00ec a601          	ld	a,#1
 493  00ee 6b01          	ld	(OFST-1,sp),a
 495  00f0               L371:
 496                     ; 62 		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(is_space_sao()?SCREEN_SAVER_COUNT_SPACE:0);
 498  00f0 cd0000        	call	_is_space_sao
 500  00f3 4d            	tnz	a
 501  00f4 2708          	jreq	L02
 502  00f6 ae0005        	ldw	x,#5
 503  00f9 9f            	ld	a,xl
 504  00fa 5f            	clrw	x
 505  00fb 97            	ld	xl,a
 506  00fc 2003          	jra	L22
 507  00fe               L02:
 508  00fe ae0003        	ldw	x,#3
 509  0101               L22:
 510  0101 7b02          	ld	a,(OFST+0,sp)
 511  0103 51            	exgw	x,y
 512  0104 5f            	clrw	x
 513  0105 97            	ld	xl,a
 514  0106 65            	divw	x,y
 515  0107 909f          	ld	a,yl
 516  0109 6b02          	ld	(OFST+0,sp),a
 518                     ; 63 		switch(screen_saver_index)
 520  010b 7b02          	ld	a,(OFST+0,sp)
 522                     ; 69 			case 4:{  }break;
 523  010d 4d            	tnz	a
 524  010e 270e          	jreq	L521
 525  0110 4a            	dec	a
 526  0111 270f          	jreq	L721
 527  0113 4a            	dec	a
 528  0114 270e          	jreq	L361
 529  0116 4a            	dec	a
 530  0117 270b          	jreq	L361
 531  0119 4a            	dec	a
 532  011a 2708          	jreq	L361
 533  011c 2006          	jra	L361
 534  011e               L521:
 535                     ; 65 			case 0:{ set_frame_rainbow(); }break;
 537  011e ad0c          	call	_set_frame_rainbow
 541  0120 2002          	jra	L361
 542  0122               L721:
 543                     ; 66 			case 1:{ set_frame_blink(); }break;
 545  0122 ad4c          	call	_set_frame_blink
 549  0124               L302:
 550  0124               L361:
 551                     ; 52 	while(is_submenu_valid())
 553  0124 cd009f        	call	_is_submenu_valid
 555  0127 4d            	tnz	a
 556  0128 2691          	jrne	L161
 557                     ; 72 }
 560  012a 85            	popw	x
 561  012b 81            	ret
 598                     ; 74 void set_frame_rainbow()
 598                     ; 75 {
 599                     	switch	.text
 600  012c               _set_frame_rainbow:
 602  012c 5205          	subw	sp,#5
 603       00000005      OFST:	set	5
 606                     ; 77 	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,(u16)(millis()*32+(0xFFFF/10)*iter),255);
 608  012e 0f05          	clr	(OFST+0,sp)
 610  0130               L322:
 613  0130 4bff          	push	#255
 614  0132 7b06          	ld	a,(OFST+1,sp)
 615  0134 5f            	clrw	x
 616  0135 97            	ld	xl,a
 617  0136 90ae1999      	ldw	y,#6553
 618  013a cd0000        	call	c_imul
 620  013d cd0000        	call	c_uitolx
 622  0140 96            	ldw	x,sp
 623  0141 1c0002        	addw	x,#OFST-3
 624  0144 cd0000        	call	c_rtol
 627  0147 cd0000        	call	_millis
 629  014a a605          	ld	a,#5
 630  014c cd0000        	call	c_llsh
 632  014f 96            	ldw	x,sp
 633  0150 1c0002        	addw	x,#OFST-3
 634  0153 cd0000        	call	c_ladd
 636  0156 be02          	ldw	x,c_lreg+2
 637  0158 89            	pushw	x
 638  0159 7b08          	ld	a,(OFST+3,sp)
 639  015b cd0000        	call	_set_hue
 641  015e 5b03          	addw	sp,#3
 644  0160 0c05          	inc	(OFST+0,sp)
 648  0162 7b05          	ld	a,(OFST+0,sp)
 649  0164 a10a          	cp	a,#10
 650  0166 25c8          	jrult	L322
 651                     ; 78 	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
 653  0168 a615          	ld	a,#21
 654  016a cd0000        	call	_flush_leds
 656                     ; 79 }
 659  016d 5b05          	addw	sp,#5
 660  016f 81            	ret
 755                     ; 81 void set_frame_blink()
 755                     ; 82 {
 756                     	switch	.text
 757  0170               _set_frame_blink:
 759  0170 5209          	subw	sp,#9
 760       00000009      OFST:	set	9
 763                     ; 84 	u8 LED_WHITE_COUNT=12;
 765                     ; 85 	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
 767  0172 a61e          	ld	a,#30
 768  0174 6b05          	ld	(OFST-4,sp),a
 770                     ; 86 	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
 772  0176 a604          	ld	a,#4
 773  0178 6b04          	ld	(OFST-5,sp),a
 775                     ; 87 	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
 777  017a ae002a        	ldw	x,#42
 778  017d 1f02          	ldw	(OFST-7,sp),x
 780                     ; 88 	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
 782  017f cd0000        	call	_millis
 784  0182 a607          	ld	a,#7
 785  0184 cd0000        	call	c_lursh
 787  0187 be02          	ldw	x,c_lreg+2
 788  0189 1f07          	ldw	(OFST-2,sp),x
 790                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 792  018b 0f06          	clr	(OFST-3,sp)
 795  018d 204a          	jra	L303
 796  018f               L772:
 797                     ; 93 		x=get_random(x);
 799  018f 1e07          	ldw	x,(OFST-2,sp)
 800  0191 cd0000        	call	_get_random
 802  0194 1f07          	ldw	(OFST-2,sp),x
 804                     ; 94 		led_index=x%m;
 806  0196 1e07          	ldw	x,(OFST-2,sp)
 807  0198 1602          	ldw	y,(OFST-7,sp)
 808  019a 65            	divw	x,y
 809  019b 51            	exgw	x,y
 810  019c 01            	rrwa	x,a
 811  019d 6b09          	ld	(OFST+0,sp),a
 812  019f 02            	rlwa	x,a
 814                     ; 95 		if(led_index>=RGB_ELEMENT_COUNT)
 816  01a0 7b09          	ld	a,(OFST+0,sp)
 817  01a2 1105          	cp	a,(OFST-4,sp)
 818  01a4 2513          	jrult	L703
 819                     ; 97 			if(is_space_sao()) set_white(led_index-RGB_ELEMENT_COUNT,255);
 821  01a6 cd0000        	call	_is_space_sao
 823  01a9 4d            	tnz	a
 824  01aa 272b          	jreq	L313
 827  01ac 7b09          	ld	a,(OFST+0,sp)
 828  01ae 1005          	sub	a,(OFST-4,sp)
 829  01b0 ae00ff        	ldw	x,#255
 830  01b3 95            	ld	xh,a
 831  01b4 cd0000        	call	_set_white
 833  01b7 201e          	jra	L313
 834  01b9               L703:
 835                     ; 99 			set_rgb(led_index/3,led_index%3,255);
 837  01b9 4bff          	push	#255
 838  01bb 7b0a          	ld	a,(OFST+1,sp)
 839  01bd 5f            	clrw	x
 840  01be 97            	ld	xl,a
 841  01bf a603          	ld	a,#3
 842  01c1 62            	div	x,a
 843  01c2 5f            	clrw	x
 844  01c3 97            	ld	xl,a
 845  01c4 9f            	ld	a,xl
 846  01c5 97            	ld	xl,a
 847  01c6 7b0a          	ld	a,(OFST+1,sp)
 848  01c8 905f          	clrw	y
 849  01ca 9097          	ld	yl,a
 850  01cc a603          	ld	a,#3
 851  01ce 9062          	div	y,a
 852  01d0 909f          	ld	a,yl
 853  01d2 95            	ld	xh,a
 854  01d3 cd0000        	call	_set_rgb
 856  01d6 84            	pop	a
 857  01d7               L313:
 858                     ; 91 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 860  01d7 0c06          	inc	(OFST-3,sp)
 862  01d9               L303:
 865  01d9 7b06          	ld	a,(OFST-3,sp)
 866  01db 1104          	cp	a,(OFST-5,sp)
 867  01dd 25b0          	jrult	L772
 868                     ; 102 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
 870  01df 7b04          	ld	a,(OFST-5,sp)
 871  01e1 4c            	inc	a
 872  01e2 cd0000        	call	_flush_leds
 874                     ; 103 }
 877  01e5 5b09          	addw	sp,#9
 878  01e7 81            	ret
 902                     ; 106 void show_cyclone()
 902                     ; 107 {
 903                     	switch	.text
 904  01e8               _show_cyclone:
 908  01e8               L723:
 909                     ; 108 	while(is_submenu_valid())
 911  01e8 cd009f        	call	_is_submenu_valid
 913  01eb 4d            	tnz	a
 914  01ec 26fa          	jrne	L723
 915                     ; 112 }
 918  01ee 81            	ret
 942                     ; 114 void show_puzzle()
 942                     ; 115 {
 943                     	switch	.text
 944  01ef               _show_puzzle:
 948  01ef               L543:
 949                     ; 116 	while(is_submenu_valid())
 951  01ef cd009f        	call	_is_submenu_valid
 953  01f2 4d            	tnz	a
 954  01f3 26fa          	jrne	L543
 955                     ; 120 }
 958  01f5 81            	ret
1022                     	xdef	_SCREEN_SAVER_DURATION_MS
1023                     	xdef	_SCREEN_SAVER_COUNT_SPACE
1024                     	xdef	_SCREEN_SAVER_COUNT_PONY
1025                     	xdef	_SUBMENU_TIME_OUT_MS
1026                     	xdef	_SUBMENU_COUNT
1027                     	xdef	_set_frame_blink
1028                     	xdef	_set_frame_rainbow
1029                     	xdef	_is_submenu_valid
1030                     	xdef	_show_puzzle
1031                     	xdef	_show_cyclone
1032                     	xdef	_show_screen_savers
1033                     	xdef	_run_application
1034                     	xdef	_setup_application
1035                     	xref	_get_random
1036                     	xref	_is_space_sao
1037                     	xref	_is_button_down
1038                     	xref	_clear_button_events
1039                     	xref	_clear_button_event
1040                     	xref	_set_hue
1041                     	xref	_flush_leds
1042                     	xref	_set_white
1043                     	xref	_set_rgb
1044                     	xref	_millis
1045                     	xref	_is_application_valid
1046                     	xref	_setup_serial
1047                     	xref.b	c_lreg
1048                     	xref.b	c_x
1067                     	xref	c_ladd
1068                     	xref	c_uitolx
1069                     	xref	c_imul
1070                     	xref	c_llsh
1071                     	xref	c_lursh
1072                     	xref	c_lcmp
1073                     	xref	c_rtol
1074                     	xref	c_smodx
1075                     	end
