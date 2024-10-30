   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  19                     	switch	.data
  20  0000               _atomic_counter:
  21  0000 00000000      	dc.l	0
  22  0004               _pwm_brightness:
  23  0004 0001          	dc.w	1
  24  0006 0001          	dc.w	1
  25  0008 000000000000  	ds.b	120
  26  0080               _pwm_sleep:
  27  0080 0001          	dc.w	1
  28  0082 0001          	dc.w	1
  29  0084               _pwm_led_count:
  30  0084 01            	dc.b	1
  31  0085 01            	dc.b	1
  32  0086               _pwm_visible_index:
  33  0086 00            	dc.b	0
  34  0087               _pwm_state:
  35  0087 00            	dc.b	0
  36  0088               _is_valid_i2c_received:
  37  0088 00            	dc.b	0
  38  0089               _button_start_ms:
  39  0089 00000000      	dc.l	0
  40  008d               _is_right_button_down:
  41  008d 00            	dc.b	0
 101                     ; 29 void hello_world()
 101                     ; 30 {//basic program that blinks the debug LED ON/OFF
 103                     	switch	.text
 104  0000               _hello_world:
 106  0000 5204          	subw	sp,#4
 107       00000004      OFST:	set	4
 110                     ; 31 	const u8 cycle_speed=10;//larger=faster
 112  0002 a60a          	ld	a,#10
 113  0004 6b02          	ld	(OFST-2,sp),a
 115                     ; 32 	const u8 white_speed=2;//smaller=faster
 117  0006 a602          	ld	a,#2
 118  0008 6b01          	ld	(OFST-3,sp),a
 120                     ; 34 	while(0)
 123  000a 5f            	clrw	x
 125  000b               L53:
 126                     ; 42 		frame++;
 128  000b 5c            	incw	x
 129  000c 1f03          	ldw	(OFST-1,sp),x
 131                     ; 43 		set_hue_max(0,(frame<<cycle_speed));
 133  000e 7b02          	ld	a,(OFST-2,sp)
 134  0010 2704          	jreq	L01
 135  0012               L21:
 136  0012 58            	sllw	x
 137  0013 4a            	dec	a
 138  0014 26fc          	jrne	L21
 139  0016               L01:
 140  0016 89            	pushw	x
 141  0017 4f            	clr	a
 142  0018 cd0773        	call	_set_hue_max
 144  001b 85            	popw	x
 145                     ; 44 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 147  001c 1e03          	ldw	x,(OFST-1,sp)
 148  001e 7b02          	ld	a,(OFST-2,sp)
 149  0020 2704          	jreq	L61
 150  0022               L02:
 151  0022 58            	sllw	x
 152  0023 4a            	dec	a
 153  0024 26fc          	jrne	L02
 154  0026               L61:
 155  0026 1c2aab        	addw	x,#10923
 156  0029 89            	pushw	x
 157  002a a601          	ld	a,#1
 158  002c cd0773        	call	_set_hue_max
 160  002f 85            	popw	x
 161                     ; 45 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 163  0030 1e03          	ldw	x,(OFST-1,sp)
 164  0032 7b02          	ld	a,(OFST-2,sp)
 165  0034 2704          	jreq	L42
 166  0036               L62:
 167  0036 58            	sllw	x
 168  0037 4a            	dec	a
 169  0038 26fc          	jrne	L62
 170  003a               L42:
 171  003a 1c5556        	addw	x,#21846
 172  003d 89            	pushw	x
 173  003e a602          	ld	a,#2
 174  0040 cd0773        	call	_set_hue_max
 176  0043 85            	popw	x
 177                     ; 46 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 179  0044 1e03          	ldw	x,(OFST-1,sp)
 180  0046 7b02          	ld	a,(OFST-2,sp)
 181  0048 2704          	jreq	L23
 182  004a               L43:
 183  004a 58            	sllw	x
 184  004b 4a            	dec	a
 185  004c 26fc          	jrne	L43
 186  004e               L23:
 187  004e 1c8000        	addw	x,#32768
 188  0051 89            	pushw	x
 189  0052 a603          	ld	a,#3
 190  0054 cd0773        	call	_set_hue_max
 192  0057 85            	popw	x
 193                     ; 47 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 195  0058 1e03          	ldw	x,(OFST-1,sp)
 196  005a 7b02          	ld	a,(OFST-2,sp)
 197  005c 2704          	jreq	L04
 198  005e               L24:
 199  005e 58            	sllw	x
 200  005f 4a            	dec	a
 201  0060 26fc          	jrne	L24
 202  0062               L04:
 203  0062 1caaab        	addw	x,#43691
 204  0065 89            	pushw	x
 205  0066 a604          	ld	a,#4
 206  0068 cd0773        	call	_set_hue_max
 208  006b 85            	popw	x
 209                     ; 48 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 211  006c 1e03          	ldw	x,(OFST-1,sp)
 212  006e 7b02          	ld	a,(OFST-2,sp)
 213  0070 2704          	jreq	L64
 214  0072               L05:
 215  0072 58            	sllw	x
 216  0073 4a            	dec	a
 217  0074 26fc          	jrne	L05
 218  0076               L64:
 219  0076 1cd554        	addw	x,#54612
 220  0079 89            	pushw	x
 221  007a a605          	ld	a,#5
 222  007c cd0773        	call	_set_hue_max
 224  007f 85            	popw	x
 225                     ; 52 		set_white((frame>>(white_speed+1))%12,0xFF);
 227  0080 1e03          	ldw	x,(OFST-1,sp)
 228  0082 7b01          	ld	a,(OFST-3,sp)
 229  0084 4c            	inc	a
 230  0085 2704          	jreq	L45
 231  0087               L65:
 232  0087 54            	srlw	x
 233  0088 4a            	dec	a
 234  0089 26fc          	jrne	L65
 235  008b               L45:
 236  008b a60c          	ld	a,#12
 237  008d 62            	div	x,a
 238  008e ae00ff        	ldw	x,#255
 239  0091 95            	ld	xh,a
 240  0092 cd081e        	call	_set_white
 242                     ; 53 		flush_leds(7);
 244  0095 a607          	ld	a,#7
 245  0097 cd066d        	call	_flush_leds
 248  009a 1e03          	ldw	x,(OFST-1,sp)
 249  009c cc000b        	jra	L53
 294                     ; 57 bool is_application()
 294                     ; 58 {
 295                     	switch	.text
 296  009f               _is_application:
 300                     ; 59 	return !is_valid_i2c_received;
 302  009f c60088        	ld	a,_is_valid_i2c_received
 303  00a2 2602          	jrne	L46
 304  00a4 4c            	inc	a
 306  00a5 81            	ret	
 307  00a6               L46:
 308  00a6 4f            	clr	a
 311  00a7 81            	ret	
 357                     ; 62 u16 get_random(u16 x)
 357                     ; 63 {
 358                     	switch	.text
 359  00a8               _get_random:
 361       00000004      OFST:	set	4
 364                     ; 64 	u16 a=1664525;
 366                     ; 65 	u16 c=1013904223;
 368                     ; 66 	return a * x + c;
 370  00a8 90ae660d      	ldw	y,#26125
 371  00ac cd0000        	call	c_imul
 373  00af 1cf35f        	addw	x,#62303
 376  00b2 81            	ret	
 405                     ; 86 void setup_main()
 405                     ; 87 {
 406                     	switch	.text
 407  00b3               _setup_main:
 411                     ; 88 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 413  00b3 c650c6        	ld	a,20678
 414  00b6 a4e7          	and	a,#231
 415  00b8 c750c6        	ld	20678,a
 416                     ; 92 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 418  00bb 4b40          	push	#64
 419  00bd 4b02          	push	#2
 420  00bf ae500f        	ldw	x,#20495
 421  00c2 cd0000        	call	_GPIO_Init
 423  00c5 3505530e      	mov	21262,#5
 424  00c9 725f530f      	clr	21263
 425  00cd 35ff5310      	mov	21264,#255
 426  00d1 c65300        	ld	a,21248
 427  00d4 aa05          	or	a,#5
 428  00d6 c75300        	ld	21248,a
 429  00d9 35015303      	mov	21251,#1
 430  00dd 85            	popw	x
 431                     ; 97 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 433                     ; 98 	TIM2->ARRH= 0;// init auto reload register
 435                     ; 99 	TIM2->ARRL= 255;// init auto reload register
 437                     ; 101 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 439                     ; 103 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 441                     ; 110 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 443  00de 4b40          	push	#64
 444  00e0 4b08          	push	#8
 445  00e2 ae500f        	ldw	x,#20495
 446  00e5 cd0000        	call	_GPIO_Init
 448  00e8 85            	popw	x
 449                     ; 111 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
 451  00e9 4b40          	push	#64
 452  00eb 4b10          	push	#16
 453  00ed ae500f        	ldw	x,#20495
 454  00f0 cd0000        	call	_GPIO_Init
 456  00f3 85            	popw	x
 457                     ; 114 	I2C_DeInit();
 459  00f4 cd0000        	call	_I2C_DeInit
 461                     ; 115 	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
 463  00f7 4b10          	push	#16
 464  00f9 4b00          	push	#0
 465  00fb 4b01          	push	#1
 466  00fd 4b00          	push	#0
 467  00ff ae0060        	ldw	x,#96
 468  0102 89            	pushw	x
 469  0103 ae86a0        	ldw	x,#34464
 470  0106 89            	pushw	x
 471  0107 ae0001        	ldw	x,#1
 472  010a 89            	pushw	x
 473  010b cd0000        	call	_I2C_Init
 475  010e 5b0a          	addw	sp,#10
 476                     ; 116 	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
 478  0110 ae0701        	ldw	x,#1793
 479  0113 cd0000        	call	_I2C_ITConfig
 481                     ; 117 	I2C_Cmd(ENABLE);
 483  0116 a601          	ld	a,#1
 484  0118 cd0000        	call	_I2C_Cmd
 486                     ; 118 	enableInterrupts();  // Enable global interrupts
 489  011b 9a            	rim	
 491                     ; 119 }
 495  011c 81            	ret	
 519                     ; 121 u32 millis()
 519                     ; 122 {
 520                     	switch	.text
 521  011d               _millis:
 525                     ; 123 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 527  011d ae0000        	ldw	x,#_atomic_counter
 528  0120 cd0000        	call	c_ltor
 530  0123 a609          	ld	a,#9
 534  0125 cc0000        	jp	c_lursh
 562                     ; 126 void update_developer_gpio()
 562                     ; 127 {
 563                     	switch	.text
 564  0128               _update_developer_gpio:
 566  0128 89            	pushw	x
 567       00000002      OFST:	set	2
 570                     ; 128 	if(is_valid_i2c_received)
 572  0129 c60088        	ld	a,_is_valid_i2c_received
 573  012c 272d          	jreq	L131
 574                     ; 129 		GPIO_Init(GPIOD, GPIO_PIN_5, (
 574                     ; 130 				get_button_event(0xFF,0xFF,0) |
 574                     ; 131 				is_button_down(1) |
 574                     ; 132 				is_button_down(0)
 574                     ; 133 			)?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
 576  012e 4f            	clr	a
 577  012f cd023f        	call	_is_button_down
 579  0132 6b02          	ld	(OFST+0,sp),a
 581  0134 a601          	ld	a,#1
 582  0136 cd023f        	call	_is_button_down
 584  0139 6b01          	ld	(OFST-1,sp),a
 586  013b 4b00          	push	#0
 587  013d aeffff        	ldw	x,#65535
 588  0140 cd01eb        	call	_get_button_event
 590  0143 5b01          	addw	sp,#1
 591  0145 1a01          	or	a,(OFST-1,sp)
 592  0147 1a02          	or	a,(OFST+0,sp)
 593  0149 2704          	jreq	L021
 594  014b a6d0          	ld	a,#208
 595  014d 2002          	jra	L031
 596  014f               L021:
 597  014f a6c0          	ld	a,#192
 598  0151               L031:
 599  0151 88            	push	a
 600  0152 4b20          	push	#32
 601  0154 ae500f        	ldw	x,#20495
 602  0157 cd0000        	call	_GPIO_Init
 604  015a 85            	popw	x
 605  015b               L131:
 606                     ; 134 }
 609  015b 85            	popw	x
 610  015c 81            	ret	
 656                     .const:	section	.text
 657  0000               L441:
 658  0000 00000201      	dc.l	513
 659  0004               L641:
 660  0004 00000033      	dc.l	51
 661                     ; 138 void update_buttons()
 661                     ; 139 {
 662                     	switch	.text
 663  015d               _update_buttons:
 665  015d 5205          	subw	sp,#5
 666       00000005      OFST:	set	5
 669                     ; 142 	update_developer_gpio();
 671  015f adc7          	call	_update_developer_gpio
 673                     ; 143 	if(button_start_ms)
 675  0161 ae0089        	ldw	x,#_button_start_ms
 676  0164 cd0000        	call	c_lzmp
 678  0167 2756          	jreq	L151
 679                     ; 145 		set_debug(255);
 681  0169 a6ff          	ld	a,#255
 682  016b cd0829        	call	_set_debug
 684                     ; 146 		if(!is_button_down(is_right_button_down))
 686  016e c6008d        	ld	a,_is_right_button_down
 687  0171 cd023f        	call	_is_button_down
 689  0174 4d            	tnz	a
 690  0175 2671          	jrne	L361
 691                     ; 148 			elapsed_pressed_ms=millis()-button_start_ms;
 693  0177 ada4          	call	_millis
 695  0179 ae0089        	ldw	x,#_button_start_ms
 696  017c cd0000        	call	c_lsub
 698  017f 96            	ldw	x,sp
 699  0180 5c            	incw	x
 700  0181 cd0000        	call	c_rtol
 703                     ; 149 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 705  0184 96            	ldw	x,sp
 706  0185 5c            	incw	x
 707  0186 cd0000        	call	c_ltor
 709  0189 ae0000        	ldw	x,#L441
 710  018c cd0000        	call	c_lcmp
 712  018f 250d          	jrult	L551
 715  0191 c6008d        	ld	a,_is_right_button_down
 716  0194 5f            	clrw	x
 717  0195 97            	ld	xl,a
 718  0196 58            	sllw	x
 719  0197 a601          	ld	a,#1
 720  0199 d7000e        	ld	(_button_pressed_event+1,x),a
 722  019c 2018          	jra	L751
 723  019e               L551:
 724                     ; 150 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 726  019e 96            	ldw	x,sp
 727  019f 5c            	incw	x
 728  01a0 cd0000        	call	c_ltor
 730  01a3 ae0004        	ldw	x,#L641
 731  01a6 cd0000        	call	c_lcmp
 733  01a9 250b          	jrult	L751
 736  01ab c6008d        	ld	a,_is_right_button_down
 737  01ae 5f            	clrw	x
 738  01af 97            	ld	xl,a
 739  01b0 58            	sllw	x
 740  01b1 a601          	ld	a,#1
 741  01b3 d7000d        	ld	(_button_pressed_event,x),a
 742  01b6               L751:
 743                     ; 151 			button_start_ms=0;
 745  01b6 5f            	clrw	x
 746  01b7 cf008b        	ldw	_button_start_ms+2,x
 747  01ba cf0089        	ldw	_button_start_ms,x
 748  01bd 2029          	jra	L361
 749  01bf               L151:
 750                     ; 154 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 752  01bf 0f05          	clr	(OFST+0,sp)
 755  01c1 2017          	jra	L171
 756  01c3               L561:
 757                     ; 156 			if(is_button_down(button_index))
 759  01c3 7b05          	ld	a,(OFST+0,sp)
 760  01c5 ad78          	call	_is_button_down
 762  01c7 4d            	tnz	a
 763  01c8 270e          	jreq	L571
 764                     ; 158 				is_right_button_down=button_index;
 766  01ca 7b05          	ld	a,(OFST+0,sp)
 767  01cc c7008d        	ld	_is_right_button_down,a
 768                     ; 159 				button_start_ms=millis();
 770  01cf cd011d        	call	_millis
 772  01d2 ae0089        	ldw	x,#_button_start_ms
 773  01d5 cd0000        	call	c_rtol
 775  01d8               L571:
 776                     ; 154 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 778  01d8 0c05          	inc	(OFST+0,sp)
 780  01da               L171:
 783  01da 7b05          	ld	a,(OFST+0,sp)
 784  01dc a102          	cp	a,#2
 785  01de 2408          	jruge	L361
 787  01e0 ae0089        	ldw	x,#_button_start_ms
 788  01e3 cd0000        	call	c_lzmp
 790  01e6 27db          	jreq	L561
 791  01e8               L361:
 792                     ; 163 }
 795  01e8 5b05          	addw	sp,#5
 796  01ea 81            	ret	
 864                     ; 168 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 864                     ; 169 {
 865                     	switch	.text
 866  01eb               _get_button_event:
 868  01eb 89            	pushw	x
 869  01ec 89            	pushw	x
 870       00000002      OFST:	set	2
 873                     ; 171 	bool out=0;
 875  01ed 0f01          	clr	(OFST-1,sp)
 877                     ; 172 	for(iter=0;iter<BUTTON_COUNT;iter++)
 879  01ef 0f02          	clr	(OFST+0,sp)
 881  01f1               L132:
 882                     ; 174 		if(button_index==iter || button_index==0xFF)
 884  01f1 7b03          	ld	a,(OFST+1,sp)
 885  01f3 1102          	cp	a,(OFST+0,sp)
 886  01f5 2703          	jreq	L142
 888  01f7 4c            	inc	a
 889  01f8 2638          	jrne	L732
 890  01fa               L142:
 891                     ; 176 			if(is_long==0 || is_long==0xFF)
 893  01fa 7b04          	ld	a,(OFST+2,sp)
 894  01fc 2703          	jreq	L542
 896  01fe 4c            	inc	a
 897  01ff 2614          	jrne	L342
 898  0201               L542:
 899                     ; 178 				out|=button_pressed_event[iter][0];
 901  0201 7b02          	ld	a,(OFST+0,sp)
 902  0203 5f            	clrw	x
 903  0204 97            	ld	xl,a
 904  0205 58            	sllw	x
 905  0206 7b01          	ld	a,(OFST-1,sp)
 906  0208 da000d        	or	a,(_button_pressed_event,x)
 907  020b 6b01          	ld	(OFST-1,sp),a
 909                     ; 179 				if(is_clear) button_pressed_event[iter][0]=0;
 911  020d 7b07          	ld	a,(OFST+5,sp)
 912  020f 2704          	jreq	L342
 915  0211 724f000d      	clr	(_button_pressed_event,x)
 916  0215               L342:
 917                     ; 181 			if(is_long==1 || is_long==0xFF)
 919  0215 7b04          	ld	a,(OFST+2,sp)
 920  0217 a101          	cp	a,#1
 921  0219 2703          	jreq	L352
 923  021b 4c            	inc	a
 924  021c 2614          	jrne	L732
 925  021e               L352:
 926                     ; 183 				out|=button_pressed_event[iter][1];
 928  021e 7b02          	ld	a,(OFST+0,sp)
 929  0220 5f            	clrw	x
 930  0221 97            	ld	xl,a
 931  0222 58            	sllw	x
 932  0223 7b01          	ld	a,(OFST-1,sp)
 933  0225 da000e        	or	a,(_button_pressed_event+1,x)
 934  0228 6b01          	ld	(OFST-1,sp),a
 936                     ; 184 				if(is_clear) button_pressed_event[iter][1]=0;
 938  022a 7b07          	ld	a,(OFST+5,sp)
 939  022c 2704          	jreq	L732
 942  022e 724f000e      	clr	(_button_pressed_event+1,x)
 943  0232               L732:
 944                     ; 172 	for(iter=0;iter<BUTTON_COUNT;iter++)
 946  0232 0c02          	inc	(OFST+0,sp)
 950  0234 7b02          	ld	a,(OFST+0,sp)
 951  0236 a102          	cp	a,#2
 952  0238 25b7          	jrult	L132
 953                     ; 188 	return out;
 955  023a 7b01          	ld	a,(OFST-1,sp)
 958  023c 5b04          	addw	sp,#4
 959  023e 81            	ret	
 993                     ; 192 bool is_button_down(u8 index)
 993                     ; 193 {
 994                     	switch	.text
 995  023f               _is_button_down:
 999                     ; 194 	switch(index)
1002                     ; 198 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1003  023f 4d            	tnz	a
1004  0240 2708          	jreq	L752
1005  0242 4a            	dec	a
1006  0243 2716          	jreq	L162
1007  0245 4a            	dec	a
1008  0246 2724          	jreq	L362
1009  0248 2033          	jra	L303
1010  024a               L752:
1011                     ; 196 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button
1013  024a 4b08          	push	#8
1014  024c ae500f        	ldw	x,#20495
1015  024f cd0000        	call	_GPIO_ReadInputPin
1017  0252 5b01          	addw	sp,#1
1018  0254 4d            	tnz	a
1019  0255 2602          	jrne	L061
1020  0257 4c            	inc	a
1022  0258 81            	ret	
1023  0259               L061:
1024  0259 4f            	clr	a
1027  025a 81            	ret	
1028  025b               L162:
1029                     ; 197 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
1032  025b 4b10          	push	#16
1033  025d ae500f        	ldw	x,#20495
1034  0260 cd0000        	call	_GPIO_ReadInputPin
1036  0263 5b01          	addw	sp,#1
1037  0265 4d            	tnz	a
1038  0266 2602          	jrne	L661
1039  0268 4c            	inc	a
1041  0269 81            	ret	
1042  026a               L661:
1043  026a 4f            	clr	a
1046  026b 81            	ret	
1047  026c               L362:
1048                     ; 198 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1051  026c 4b02          	push	#2
1052  026e ae500f        	ldw	x,#20495
1053  0271 cd0000        	call	_GPIO_ReadInputPin
1055  0274 5b01          	addw	sp,#1
1056  0276 4d            	tnz	a
1057  0277 2602          	jrne	L471
1058  0279 4c            	inc	a
1060  027a 81            	ret	
1061  027b               L471:
1062  027b 4f            	clr	a
1065  027c 81            	ret	
1066  027d               L303:
1067                     ; 200 	return 0;
1069  027d 4f            	clr	a
1072  027e 81            	ret	
1075                     	switch	.data
1076  008e               _is_developer_debug:
1077  008e 01            	dc.b	1
1078  008f               _developer_flag:
1079  008f 00            	dc.b	0
1080  0090               _i2c_transaction_byte_count:
1081  0090 00            	dc.b	0
1103                     ; 216 u8 get_developer_flag(){ return developer_flag; }
1104                     	switch	.text
1105  027f               _get_developer_flag:
1111  027f c6008f        	ld	a,_developer_flag
1114  0282 81            	ret	
1148                     ; 217 void set_developer_flag(u8 value)
1148                     ; 218 {
1149                     	switch	.text
1150  0283               _set_developer_flag:
1152  0283 88            	push	a
1153       00000000      OFST:	set	0
1156                     ; 219 	if(value!=0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_SLOW);//frame_buffer_pin
1158  0284 4d            	tnz	a
1159  0285 270b          	jreq	L133
1162  0287 4bd0          	push	#208
1163  0289 4b40          	push	#64
1164  028b ae500f        	ldw	x,#20495
1165  028e cd0000        	call	_GPIO_Init
1167  0291 85            	popw	x
1168  0292               L133:
1169                     ; 220 	developer_flag=value;
1171  0292 7b01          	ld	a,(OFST+1,sp)
1172  0294 c7008f        	ld	_developer_flag,a
1173                     ; 221 	if(value==0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_SLOW);
1175  0297 260b          	jrne	L333
1178  0299 4bc0          	push	#192
1179  029b 4b40          	push	#64
1180  029d ae500f        	ldw	x,#20495
1181  02a0 cd0000        	call	_GPIO_Init
1183  02a3 85            	popw	x
1184  02a4               L333:
1185                     ; 222 }
1188  02a4 84            	pop	a
1189  02a5 81            	ret	
1214                     ; 229 	void I2C_transaction_begin(void)
1214                     ; 230 	{
1215                     	switch	.text
1216  02a6               _I2C_transaction_begin:
1220                     ; 231 		MessageBegin = TRUE;
1222  02a6 35010004      	mov	_MessageBegin,#1
1223                     ; 233 	}
1226  02aa 81            	ret	
1271                     ; 234 	void I2C_transaction_end(bool is_slave_txd)
1271                     ; 235 	{
1272                     	switch	.text
1273  02ab               _I2C_transaction_end:
1277                     ; 236 		is_valid_i2c_received=1;
1279  02ab 35010088      	mov	_is_valid_i2c_received,#1
1280                     ; 237 		if(is_slave_txd)
1282  02af 4d            	tnz	a
1283  02b0 2706          	jreq	L573
1284                     ; 239 			u8_My_Buffer[2]=u8_My_Buffer[2]+1;
1286  02b2 725c0009      	inc	_u8_My_Buffer+2
1288  02b6 202d          	jra	L773
1289  02b8               L573:
1290                     ; 241 			u8_My_Buffer[1]=u8_My_Buffer[1]+1;
1292  02b8 725c0008      	inc	_u8_My_Buffer+1
1293                     ; 242 			switch(this_addr)
1295  02bc c60003        	ld	a,_this_addr
1297                     ; 262 				default: break;
1298  02bf 270c          	jreq	L543
1299  02c1 a003          	sub	a,#3
1300  02c3 2725          	jreq	L743
1301  02c5 4a            	dec	a
1302  02c6 273c          	jreq	L153
1303  02c8 4a            	dec	a
1304  02c9 274a          	jreq	L353
1305  02cb 2018          	jra	L773
1306  02cd               L543:
1307                     ; 245 					is_developer_debug=!is_developer_debug;
1309  02cd 725d008e      	tnz	_is_developer_debug
1310  02d1 2603          	jrne	L612
1311  02d3 4c            	inc	a
1312  02d4 2001          	jra	L022
1313  02d6               L612:
1314  02d6 4f            	clr	a
1315  02d7               L022:
1316  02d7 c7008e        	ld	_is_developer_debug,a
1317                     ; 246 					set_debug(is_developer_debug?0xFF:0);
1319  02da 2702          	jreq	L422
1320  02dc a6ff          	ld	a,#255
1321  02de               L422:
1322  02de cd0829        	call	_set_debug
1324                     ; 247 					set_developer_flag(1);
1326  02e1 a601          	ld	a,#1
1327  02e3               LC001:
1328  02e3 ad9e          	call	_set_developer_flag
1330                     ; 248 				}break;
1331  02e5               L773:
1332                     ; 265 		i2c_transaction_byte_count=0;
1334  02e5 725f0090      	clr	_i2c_transaction_byte_count
1335                     ; 266 	}
1338  02e9 81            	ret	
1339  02ea               L743:
1340                     ; 250 						if(i2c_transaction_byte_count>1 && u8_MyBuffp==&u8_My_Buffer[4])
1342  02ea c60090        	ld	a,_i2c_transaction_byte_count
1343  02ed a102          	cp	a,#2
1344  02ef 25f4          	jrult	L773
1346  02f1 ce0005        	ldw	x,_u8_MyBuffp
1347  02f4 a3000b        	cpw	x,#_u8_My_Buffer+4
1348  02f7 26ec          	jrne	L773
1349                     ; 252 							set_developer_flag(u8_My_Buffer[3]);
1351  02f9 c6000a        	ld	a,_u8_My_Buffer+3
1352  02fc ad85          	call	_set_developer_flag
1354                     ; 253 							u8_My_Buffer[3]=0;//reset the led_index register to default state
1356  02fe 725f000a      	clr	_u8_My_Buffer+3
1357  0302 20e1          	jra	L773
1358  0304               L153:
1359                     ; 257 					if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1361  0304 c6000a        	ld	a,_u8_My_Buffer+3
1362  0307 a11f          	cp	a,#31
1363  0309 24da          	jruge	L773
1366  030b 5f            	clrw	x
1367  030c 97            	ld	xl,a
1368  030d c6000b        	ld	a,_u8_My_Buffer+4
1369  0310 d70011        	ld	(_pwm_brightness_buffer,x),a
1370  0313 20d0          	jra	L773
1371  0315               L353:
1372                     ; 260 					set_developer_flag(u8_My_Buffer[5]);//note: an excessively high value here (>>10) will cause the LEDs on the SAO to flicker notably
1374  0315 c6000c        	ld	a,_u8_My_Buffer+5
1376                     ; 261 				}break;
1378  0318 20c9          	jp	LC001
1379                     ; 262 				default: break;
1418                     ; 267 	void I2C_byte_received(u8 u8_RxData)
1418                     ; 268 	{
1419                     	switch	.text
1420  031a               _I2C_byte_received:
1422  031a 88            	push	a
1423       00000000      OFST:	set	0
1426                     ; 269 		if (MessageBegin == TRUE  &&  u8_RxData < ADDRESS_COUNT_READ) {
1428  031b c60004        	ld	a,_MessageBegin
1429  031e 4a            	dec	a
1430  031f 2617          	jrne	L524
1432  0321 7b01          	ld	a,(OFST+1,sp)
1433  0323 a108          	cp	a,#8
1434  0325 2411          	jruge	L524
1435                     ; 270 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
1437  0327 5f            	clrw	x
1438  0328 97            	ld	xl,a
1439  0329 1c0007        	addw	x,#_u8_My_Buffer
1440  032c cf0005        	ldw	_u8_MyBuffp,x
1441                     ; 271 			MessageBegin = FALSE;
1443  032f 725f0004      	clr	_MessageBegin
1444                     ; 272 			this_addr=u8_RxData;
1446  0333 c70003        	ld	_this_addr,a
1448  0336 2037          	jra	L724
1449  0338               L524:
1450                     ; 276 			i2c_transaction_byte_count++;
1452  0338 725c0090      	inc	_i2c_transaction_byte_count
1453                     ; 277       if(u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE]) *(u8_MyBuffp++) = u8_RxData;
1455  033c ce0005        	ldw	x,_u8_MyBuffp
1456  033f a3000d        	cpw	x,#_u8_My_Buffer+6
1457  0342 2407          	jruge	L134
1460  0344 7b01          	ld	a,(OFST+1,sp)
1461  0346 f7            	ld	(x),a
1462  0347 5c            	incw	x
1463  0348 cf0005        	ldw	_u8_MyBuffp,x
1464  034b               L134:
1465                     ; 278 			if(this_addr==3 && u8_MyBuffp==&u8_My_Buffer[5])
1467  034b c60003        	ld	a,_this_addr
1468  034e a103          	cp	a,#3
1469  0350 261d          	jrne	L724
1471  0352 a3000c        	cpw	x,#_u8_My_Buffer+5
1472  0355 2618          	jrne	L724
1473                     ; 280 				if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1475  0357 c6000a        	ld	a,_u8_My_Buffer+3
1476  035a a11f          	cp	a,#31
1477  035c 240b          	jruge	L534
1480  035e 5f            	clrw	x
1481  035f 97            	ld	xl,a
1482  0360 c6000b        	ld	a,_u8_My_Buffer+4
1483  0363 d70011        	ld	(_pwm_brightness_buffer,x),a
1484  0366 ce0005        	ldw	x,_u8_MyBuffp
1485  0369               L534:
1486                     ; 281 				u8_MyBuffp-=2;
1488  0369 1d0002        	subw	x,#2
1489  036c cf0005        	ldw	_u8_MyBuffp,x
1490  036f               L724:
1491                     ; 284 	}
1494  036f 84            	pop	a
1495  0370 81            	ret	
1524                     ; 285 	u8 I2C_byte_write(void)
1524                     ; 286 	{
1525                     	switch	.text
1526  0371               _I2C_byte_write:
1528  0371 5206          	subw	sp,#6
1529       00000006      OFST:	set	6
1532                     ; 287 		if (u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE])
1534  0373 ce0005        	ldw	x,_u8_MyBuffp
1535  0376 a3000d        	cpw	x,#_u8_My_Buffer+6
1536  0379 2408          	jruge	L744
1537                     ; 288 			return *(u8_MyBuffp++);
1539  037b f6            	ld	a,(x)
1540  037c 5c            	incw	x
1541  037d cf0005        	ldw	_u8_MyBuffp,x
1543  0380 cc0423        	jra	L203
1544  0383               L744:
1545                     ; 289 		else if(this_addr==6 || this_addr==7)
1547  0383 c60003        	ld	a,_this_addr
1548  0386 a106          	cp	a,#6
1549  0388 2707          	jreq	L554
1551  038a a107          	cp	a,#7
1552  038c 2703cc0426    	jrne	L354
1553  0391               L554:
1554                     ; 291 			update_developer_gpio();
1556  0391 cd0128        	call	_update_developer_gpio
1558                     ; 292 			return
1558                     ; 293 				get_button_event(1,1,this_addr==7)<<7 |
1558                     ; 294 				get_button_event(0,1,this_addr==7)<<6 |
1558                     ; 295 				get_button_event(1,0,this_addr==7)<<5 |
1558                     ; 296 				get_button_event(0,0,this_addr==7)<<4 |
1558                     ; 297 				is_button_down(2)<<2 |
1558                     ; 298 				is_button_down(1)<<1 |
1558                     ; 299 				is_button_down(0);
1560  0394 4f            	clr	a
1561  0395 cd023f        	call	_is_button_down
1563  0398 6b06          	ld	(OFST+0,sp),a
1565  039a a601          	ld	a,#1
1566  039c cd023f        	call	_is_button_down
1568  039f 48            	sll	a
1569  03a0 6b05          	ld	(OFST-1,sp),a
1571  03a2 a602          	ld	a,#2
1572  03a4 cd023f        	call	_is_button_down
1574  03a7 48            	sll	a
1575  03a8 48            	sll	a
1576  03a9 6b04          	ld	(OFST-2,sp),a
1578  03ab c60003        	ld	a,_this_addr
1579  03ae a107          	cp	a,#7
1580  03b0 2604          	jrne	L452
1581  03b2 a601          	ld	a,#1
1582  03b4 2001          	jra	L652
1583  03b6               L452:
1584  03b6 4f            	clr	a
1585  03b7               L652:
1586  03b7 88            	push	a
1587  03b8 5f            	clrw	x
1588  03b9 cd01eb        	call	_get_button_event
1590  03bc 5b01          	addw	sp,#1
1591  03be 97            	ld	xl,a
1592  03bf a610          	ld	a,#16
1593  03c1 42            	mul	x,a
1594  03c2 9f            	ld	a,xl
1595  03c3 6b03          	ld	(OFST-3,sp),a
1597  03c5 c60003        	ld	a,_this_addr
1598  03c8 a107          	cp	a,#7
1599  03ca 2604          	jrne	L262
1600  03cc a601          	ld	a,#1
1601  03ce 2001          	jra	L462
1602  03d0               L262:
1603  03d0 4f            	clr	a
1604  03d1               L462:
1605  03d1 88            	push	a
1606  03d2 ae0100        	ldw	x,#256
1607  03d5 cd01eb        	call	_get_button_event
1609  03d8 5b01          	addw	sp,#1
1610  03da 97            	ld	xl,a
1611  03db a620          	ld	a,#32
1612  03dd 42            	mul	x,a
1613  03de 9f            	ld	a,xl
1614  03df 6b02          	ld	(OFST-4,sp),a
1616  03e1 c60003        	ld	a,_this_addr
1617  03e4 a107          	cp	a,#7
1618  03e6 2604          	jrne	L072
1619  03e8 a601          	ld	a,#1
1620  03ea 2001          	jra	L272
1621  03ec               L072:
1622  03ec 4f            	clr	a
1623  03ed               L272:
1624  03ed 88            	push	a
1625  03ee ae0001        	ldw	x,#1
1626  03f1 cd01eb        	call	_get_button_event
1628  03f4 5b01          	addw	sp,#1
1629  03f6 97            	ld	xl,a
1630  03f7 a640          	ld	a,#64
1631  03f9 42            	mul	x,a
1632  03fa 9f            	ld	a,xl
1633  03fb 6b01          	ld	(OFST-5,sp),a
1635  03fd c60003        	ld	a,_this_addr
1636  0400 a107          	cp	a,#7
1637  0402 2604          	jrne	L672
1638  0404 a601          	ld	a,#1
1639  0406 2001          	jra	L003
1640  0408               L672:
1641  0408 4f            	clr	a
1642  0409               L003:
1643  0409 88            	push	a
1644  040a ae0101        	ldw	x,#257
1645  040d cd01eb        	call	_get_button_event
1647  0410 5b01          	addw	sp,#1
1648  0412 97            	ld	xl,a
1649  0413 a680          	ld	a,#128
1650  0415 42            	mul	x,a
1651  0416 9f            	ld	a,xl
1652  0417 1a01          	or	a,(OFST-5,sp)
1653  0419 1a02          	or	a,(OFST-4,sp)
1654  041b 1a03          	or	a,(OFST-3,sp)
1655  041d 1a04          	or	a,(OFST-2,sp)
1656  041f 1a05          	or	a,(OFST-1,sp)
1657  0421 1a06          	or	a,(OFST+0,sp)
1659  0423               L203:
1661  0423 5b06          	addw	sp,#6
1662  0425 81            	ret	
1663  0426               L354:
1664                     ; 302 			return 0x00;
1666  0426 4f            	clr	a
1668  0427 20fa          	jra	L203
1720                     ; 306 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1722                     	switch	.text
1723  0429               f_TIM2_UPD_OVF_IRQHandler:
1725  0429 8a            	push	cc
1726  042a 84            	pop	a
1727  042b a4bf          	and	a,#191
1728  042d 88            	push	a
1729  042e 86            	pop	cc
1730       00000005      OFST:	set	5
1731  042f 3b0002        	push	c_x+2
1732  0432 be00          	ldw	x,c_x
1733  0434 89            	pushw	x
1734  0435 3b0002        	push	c_y+2
1735  0438 be00          	ldw	x,c_y
1736  043a 89            	pushw	x
1737  043b be02          	ldw	x,c_lreg+2
1738  043d 89            	pushw	x
1739  043e be00          	ldw	x,c_lreg
1740  0440 89            	pushw	x
1741  0441 5205          	subw	sp,#5
1744                     ; 307 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1746  0443 c60087        	ld	a,_pwm_state
1747  0446 a401          	and	a,#1
1748  0448 6b03          	ld	(OFST-2,sp),a
1750                     ; 308 	u16 sleep_counts=1;
1752  044a ae0001        	ldw	x,#1
1753  044d 1f04          	ldw	(OFST-1,sp),x
1755                     ; 310 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1757  044f c6500c        	ld	a,20492
1758  0452 a407          	and	a,#7
1759  0454 c7500c        	ld	20492,a
1760                     ; 311 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1762  0457 72155011      	bres	20497,#2
1763                     ; 312 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1765  045b 72175002      	bres	20482,#3
1766                     ; 313 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1768  045f c6500d        	ld	a,20493
1769  0462 a407          	and	a,#7
1770  0464 c7500d        	ld	20493,a
1771                     ; 314 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1773  0467 72155012      	bres	20498,#2
1774                     ; 315 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1776  046b 72175003      	bres	20483,#3
1777                     ; 316   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1779  046f 72115300      	bres	21248,#0
1780                     ; 317 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1782  0473 7b03          	ld	a,(OFST-2,sp)
1783  0475 8d1d051d      	callf	LC002
1784  0479 260a          	jrne	L105
1785                     ; 319 		sleep_counts=pwm_sleep[buffer_index];
1787  047b 7b03          	ld	a,(OFST-2,sp)
1788  047d 5f            	clrw	x
1789  047e 97            	ld	xl,a
1790  047f 58            	sllw	x
1791  0480 de0080        	ldw	x,(_pwm_sleep,x)
1792  0483 1f04          	ldw	(OFST-1,sp),x
1794  0485               L105:
1795                     ; 321 	if(pwm_visible_index>pwm_led_count[buffer_index])
1797  0485 7b03          	ld	a,(OFST-2,sp)
1798  0487 8d1d051d      	callf	LC002
1799  048b 2418          	jruge	L305
1800                     ; 323 		pwm_visible_index=0;//formally start new frame
1802  048d 725f0086      	clr	_pwm_visible_index
1803                     ; 324 		update_buttons();
1805  0491 cd015d        	call	_update_buttons
1807                     ; 325 		if(pwm_state&0x02)
1809  0494 720300870c    	btjf	_pwm_state,#1,L305
1810                     ; 327 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1812  0499 c60087        	ld	a,_pwm_state
1813  049c a803          	xor	a,#3
1814  049e c70087        	ld	_pwm_state,a
1815                     ; 328 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1817  04a1 a401          	and	a,#1
1818  04a3 6b03          	ld	(OFST-2,sp),a
1820  04a5               L305:
1821                     ; 331 	if(pwm_visible_index<pwm_led_count[buffer_index])
1823  04a5 7b03          	ld	a,(OFST-2,sp)
1824  04a7 8d1d051d      	callf	LC002
1825  04ab 2332          	jrule	L705
1826                     ; 333 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1828  04ad 7b03          	ld	a,(OFST-2,sp)
1829  04af 5f            	clrw	x
1830  04b0 97            	ld	xl,a
1831  04b1 58            	sllw	x
1832  04b2 1f01          	ldw	(OFST-4,sp),x
1834  04b4 c60086        	ld	a,_pwm_visible_index
1835  04b7 97            	ld	xl,a
1836  04b8 a604          	ld	a,#4
1837  04ba 42            	mul	x,a
1838  04bb 72fb01        	addw	x,(OFST-4,sp)
1839  04be de0004        	ldw	x,(_pwm_brightness,x)
1840  04c1 1f04          	ldw	(OFST-1,sp),x
1842                     ; 334 		if(sleep_counts==0)
1844  04c3 2607          	jrne	L115
1845                     ; 336 			sleep_counts=1<<10;
1847  04c5 ae0400        	ldw	x,#1024
1848  04c8 1f04          	ldw	(OFST-1,sp),x
1851  04ca 2013          	jra	L705
1852  04cc               L115:
1853                     ; 338 			set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1855  04cc c60086        	ld	a,_pwm_visible_index
1856  04cf 5f            	clrw	x
1857  04d0 97            	ld	xl,a
1858  04d1 58            	sllw	x
1859  04d2 01            	rrwa	x,a
1860  04d3 1b03          	add	a,(OFST-2,sp)
1861  04d5 2401          	jrnc	L213
1862  04d7 5c            	incw	x
1863  04d8               L213:
1864  04d8 02            	rlwa	x,a
1865  04d9 d60030        	ld	a,(_pwm_brightness_index,x)
1866  04dc cd05be        	call	_set_led_on
1868  04df               L705:
1869                     ; 341 	pwm_visible_index++;
1871  04df 725c0086      	inc	_pwm_visible_index
1872                     ; 342 	atomic_counter+=sleep_counts;
1874  04e3 1e04          	ldw	x,(OFST-1,sp)
1875  04e5 cd0000        	call	c_uitolx
1877  04e8 ae0000        	ldw	x,#_atomic_counter
1878  04eb cd0000        	call	c_lgadd
1880                     ; 344   TIM2->CNTRH = 0;// Set the high byte of the counter
1882  04ee 725f530c      	clr	21260
1883                     ; 345   TIM2->CNTRL = 0;// Set the low byte of the counter
1885  04f2 725f530d      	clr	21261
1886                     ; 346 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1888  04f6 7b04          	ld	a,(OFST-1,sp)
1889  04f8 c7530f        	ld	21263,a
1890                     ; 347 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1892  04fb 7b05          	ld	a,(OFST+0,sp)
1893  04fd c75310        	ld	21264,a
1894                     ; 349 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1896  0500 72115304      	bres	21252,#0
1897                     ; 350   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1899  0504 72105300      	bset	21248,#0
1900                     ; 351 }
1903  0508 5b05          	addw	sp,#5
1904  050a 85            	popw	x
1905  050b bf00          	ldw	c_lreg,x
1906  050d 85            	popw	x
1907  050e bf02          	ldw	c_lreg+2,x
1908  0510 85            	popw	x
1909  0511 bf00          	ldw	c_y,x
1910  0513 320002        	pop	c_y+2
1911  0516 85            	popw	x
1912  0517 bf00          	ldw	c_x,x
1913  0519 320002        	pop	c_x+2
1914  051c 80            	iret	
1915  051d               LC002:
1916  051d 5f            	clrw	x
1917  051e 97            	ld	xl,a
1918  051f d60084        	ld	a,(_pwm_led_count,x)
1919  0522 c10086        	cp	a,_pwm_visible_index
1920  0525 87            	retf	
1922                     	switch	.bss
1923  0000               L515_sr1:
1924  0000 00            	ds.b	1
1925  0001               L715_sr2:
1926  0001 00            	ds.b	1
1927  0002               L125_sr3:
1928  0002 00            	ds.b	1
1976                     ; 353 @far @interrupt void I2C_EventHandler(void)
1976                     ; 354 {
1977                     	switch	.text
1978  0526               f_I2C_EventHandler:
1980  0526 8a            	push	cc
1981  0527 84            	pop	a
1982  0528 a4bf          	and	a,#191
1983  052a 88            	push	a
1984  052b 86            	pop	cc
1985  052c 3b0002        	push	c_x+2
1986  052f be00          	ldw	x,c_x
1987  0531 89            	pushw	x
1988  0532 3b0002        	push	c_y+2
1989  0535 be00          	ldw	x,c_y
1990  0537 89            	pushw	x
1993                     ; 360 sr1 = I2C->SR1;
1995  0538 5552170000    	mov	L515_sr1,21015
1996                     ; 361 sr2 = I2C->SR2;
1998  053d 5552180001    	mov	L715_sr2,21016
1999                     ; 362 sr3 = I2C->SR3;
2001  0542 5552190002    	mov	L125_sr3,21017
2002                     ; 365   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
2004  0547 c60001        	ld	a,L715_sr2
2005  054a a52b          	bcp	a,#43
2006  054c 2708          	jreq	L345
2007                     ; 367     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
2009  054e 72125211      	bset	21009,#1
2010                     ; 368     I2C->SR2= 0;					    // clear all error flags
2012  0552 725f5218      	clr	21016
2013  0556               L345:
2014                     ; 371   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
2016  0556 c60000        	ld	a,L515_sr1
2017  0559 a444          	and	a,#68
2018  055b a144          	cp	a,#68
2019  055d 2606          	jrne	L545
2020                     ; 373     I2C_byte_received(I2C->DR);
2022  055f c65216        	ld	a,21014
2023  0562 cd031a        	call	_I2C_byte_received
2025  0565               L545:
2026                     ; 376   if (sr1 & I2C_SR1_RXNE)
2028  0565 720d000006    	btjf	L515_sr1,#6,L745
2029                     ; 378     I2C_byte_received(I2C->DR);
2031  056a c65216        	ld	a,21014
2032  056d cd031a        	call	_I2C_byte_received
2034  0570               L745:
2035                     ; 381   if (sr2 & I2C_SR2_AF)
2037  0570 7205000109    	btjf	L715_sr2,#2,L155
2038                     ; 383     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
2040  0575 72155218      	bres	21016,#2
2041                     ; 384 		I2C_transaction_end(1);
2043  0579 a601          	ld	a,#1
2044  057b cd02ab        	call	_I2C_transaction_end
2046  057e               L155:
2047                     ; 387   if (sr1 & I2C_SR1_STOPF) 
2049  057e 7209000008    	btjf	L515_sr1,#4,L355
2050                     ; 389     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
2052  0583 72145211      	bset	21009,#2
2053                     ; 390 		I2C_transaction_end(0);
2055  0587 4f            	clr	a
2056  0588 cd02ab        	call	_I2C_transaction_end
2058  058b               L355:
2059                     ; 393   if (sr1 & I2C_SR1_ADDR)
2061  058b 7203000003    	btjf	L515_sr1,#1,L555
2062                     ; 395 		I2C_transaction_begin();
2064  0590 cd02a6        	call	_I2C_transaction_begin
2066  0593               L555:
2067                     ; 398   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
2069  0593 c60000        	ld	a,L515_sr1
2070  0596 a484          	and	a,#132
2071  0598 a184          	cp	a,#132
2072  059a 2606          	jrne	L755
2073                     ; 400 		I2C->DR = I2C_byte_write();
2075  059c cd0371        	call	_I2C_byte_write
2077  059f c75216        	ld	21014,a
2078  05a2               L755:
2079                     ; 403   if (sr1 & I2C_SR1_TXE)
2081  05a2 720f000006    	btjf	L515_sr1,#7,L165
2082                     ; 405 		I2C->DR = I2C_byte_write();
2084  05a7 cd0371        	call	_I2C_byte_write
2086  05aa c75216        	ld	21014,a
2087  05ad               L165:
2088                     ; 407 	GPIOD->ODR^=1;
2090  05ad 9010500f      	bcpl	20495,#0
2091                     ; 408 }
2094  05b1 85            	popw	x
2095  05b2 bf00          	ldw	c_y,x
2096  05b4 320002        	pop	c_y+2
2097  05b7 85            	popw	x
2098  05b8 bf00          	ldw	c_x,x
2099  05ba 320002        	pop	c_x+2
2100  05bd 80            	iret	
2102                     	switch	.const
2103  0008               L365_led_lookup:
2104  0008 00            	dc.b	0
2105  0009 03            	dc.b	3
2106  000a 01            	dc.b	1
2107  000b 03            	dc.b	3
2108  000c 02            	dc.b	2
2109  000d 03            	dc.b	3
2110  000e 03            	dc.b	3
2111  000f 00            	dc.b	0
2112  0010 04            	dc.b	4
2113  0011 00            	dc.b	0
2114  0012 05            	dc.b	5
2115  0013 00            	dc.b	0
2116  0014 00            	dc.b	0
2117  0015 04            	dc.b	4
2118  0016 01            	dc.b	1
2119  0017 04            	dc.b	4
2120  0018 02            	dc.b	2
2121  0019 04            	dc.b	4
2122  001a 03            	dc.b	3
2123  001b 01            	dc.b	1
2124  001c 04            	dc.b	4
2125  001d 01            	dc.b	1
2126  001e 05            	dc.b	5
2127  001f 01            	dc.b	1
2128  0020 00            	dc.b	0
2129  0021 05            	dc.b	5
2130  0022 01            	dc.b	1
2131  0023 05            	dc.b	5
2132  0024 02            	dc.b	2
2133  0025 05            	dc.b	5
2134  0026 03            	dc.b	3
2135  0027 02            	dc.b	2
2136  0028 04            	dc.b	4
2137  0029 02            	dc.b	2
2138  002a 05            	dc.b	5
2139  002b 02            	dc.b	2
2140  002c 06            	dc.b	6
2141  002d 06            	dc.b	6
2142  002e 01            	dc.b	1
2143  002f 00            	dc.b	0
2144  0030 02            	dc.b	2
2145  0031 00            	dc.b	0
2146  0032 00            	dc.b	0
2147  0033 01            	dc.b	1
2148  0034 02            	dc.b	2
2149  0035 01            	dc.b	1
2150  0036 00            	dc.b	0
2151  0037 02            	dc.b	2
2152  0038 01            	dc.b	1
2153  0039 02            	dc.b	2
2154  003a 04            	dc.b	4
2155  003b 03            	dc.b	3
2156  003c 05            	dc.b	5
2157  003d 03            	dc.b	3
2158  003e 03            	dc.b	3
2159  003f 04            	dc.b	4
2160  0040 05            	dc.b	5
2161  0041 04            	dc.b	4
2162  0042 03            	dc.b	3
2163  0043 05            	dc.b	5
2164  0044 04            	dc.b	4
2165  0045 05            	dc.b	5
2207                     ; 412 void set_led_on(u8 led_index)
2207                     ; 413 {
2209                     	switch	.text
2210  05be               _set_led_on:
2212  05be 88            	push	a
2213  05bf 5240          	subw	sp,#64
2214       00000040      OFST:	set	64
2217                     ; 414 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2217                     ; 415 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
2217                     ; 416 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
2217                     ; 417 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
2217                     ; 418 		{6,6},//debug; GND is tied low, no charlieplexing involved
2217                     ; 419 		{1,0},//LED7
2217                     ; 420 		{2,0},//LED8
2217                     ; 421 		{0,1},//LED9
2217                     ; 422 		{2,1},//LED10
2217                     ; 423 		{0,2},//LED11
2217                     ; 424 		{1,2},//LED12
2217                     ; 425 		{4,3},//LED13
2217                     ; 426 		{5,3},//LED14
2217                     ; 427 		{3,4},//LED15
2217                     ; 428 		{5,4},//LED16
2217                     ; 429 		{3,5},//LED17
2217                     ; 430 		{4,5} //LED18
2217                     ; 431 	};
2219  05c1 96            	ldw	x,sp
2220  05c2 1c0003        	addw	x,#OFST-61
2221  05c5 90ae0008      	ldw	y,#L365_led_lookup
2222  05c9 a63e          	ld	a,#62
2223  05cb cd0000        	call	c_xymov
2225                     ; 432 	set_mat(led_lookup[led_index][0],1);
2227  05ce 96            	ldw	x,sp
2228  05cf 1c0003        	addw	x,#OFST-61
2229  05d2 1f01          	ldw	(OFST-63,sp),x
2231  05d4 5f            	clrw	x
2232  05d5 7b41          	ld	a,(OFST+1,sp)
2233  05d7 97            	ld	xl,a
2234  05d8 58            	sllw	x
2235  05d9 72fb01        	addw	x,(OFST-63,sp)
2236  05dc f6            	ld	a,(x)
2237  05dd ae0001        	ldw	x,#1
2238  05e0 95            	ld	xh,a
2239  05e1 ad1a          	call	_set_mat
2241                     ; 433 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0);
2243  05e3 7b41          	ld	a,(OFST+1,sp)
2244  05e5 a112          	cp	a,#18
2245  05e7 2711          	jreq	L506
2248  05e9 96            	ldw	x,sp
2249  05ea 1c0004        	addw	x,#OFST-60
2250  05ed 1f01          	ldw	(OFST-63,sp),x
2252  05ef 5f            	clrw	x
2253  05f0 97            	ld	xl,a
2254  05f1 58            	sllw	x
2255  05f2 72fb01        	addw	x,(OFST-63,sp)
2256  05f5 f6            	ld	a,(x)
2257  05f6 5f            	clrw	x
2258  05f7 95            	ld	xh,a
2259  05f8 ad03          	call	_set_mat
2261  05fa               L506:
2262                     ; 434 }
2265  05fa 5b41          	addw	sp,#65
2266  05fc 81            	ret	
2465                     ; 439 void set_mat(u8 mat_index,bool is_high)
2465                     ; 440 {
2466                     	switch	.text
2467  05fd               _set_mat:
2469  05fd 89            	pushw	x
2470  05fe 5203          	subw	sp,#3
2471       00000003      OFST:	set	3
2474                     ; 443 	switch(mat_index)
2476  0600 9e            	ld	a,xh
2478                     ; 451 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
2479  0601 4d            	tnz	a
2480  0602 2718          	jreq	L706
2481  0604 4a            	dec	a
2482  0605 271e          	jreq	L116
2483  0607 4a            	dec	a
2484  0608 2724          	jreq	L316
2485  060a 4a            	dec	a
2486  060b 272a          	jreq	L516
2487  060d 4a            	dec	a
2488  060e 2730          	jreq	L716
2489  0610 4a            	dec	a
2490  0611 2736          	jreq	L126
2493  0613 ae5000        	ldw	x,#20480
2494  0616 1f01          	ldw	(OFST-2,sp),x
2498  0618 a608          	ld	a,#8
2501  061a 2034          	jra	L347
2502  061c               L706:
2503                     ; 445 		case 0:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
2505  061c ae500a        	ldw	x,#20490
2506  061f 1f01          	ldw	(OFST-2,sp),x
2510  0621 a608          	ld	a,#8
2513  0623 202b          	jra	L347
2514  0625               L116:
2515                     ; 446 		case 1:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
2517  0625 ae500a        	ldw	x,#20490
2518  0628 1f01          	ldw	(OFST-2,sp),x
2522  062a a610          	ld	a,#16
2525  062c 2022          	jra	L347
2526  062e               L316:
2527                     ; 447 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
2529  062e ae500a        	ldw	x,#20490
2530  0631 1f01          	ldw	(OFST-2,sp),x
2534  0633 a620          	ld	a,#32
2537  0635 2019          	jra	L347
2538  0637               L516:
2539                     ; 448 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
2541  0637 ae500a        	ldw	x,#20490
2542  063a 1f01          	ldw	(OFST-2,sp),x
2546  063c a640          	ld	a,#64
2549  063e 2010          	jra	L347
2550  0640               L716:
2551                     ; 449 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
2553  0640 ae500a        	ldw	x,#20490
2554  0643 1f01          	ldw	(OFST-2,sp),x
2558  0645 a680          	ld	a,#128
2561  0647 2007          	jra	L347
2562  0649               L126:
2563                     ; 450 		case 5:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
2565  0649 ae500f        	ldw	x,#20495
2566  064c 1f01          	ldw	(OFST-2,sp),x
2570  064e a604          	ld	a,#4
2573  0650               L347:
2574  0650 6b03          	ld	(OFST+0,sp),a
2576                     ; 453 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2578  0652 0d05          	tnz	(OFST+2,sp)
2579  0654 2705          	jreq	L547
2582  0656 f6            	ld	a,(x)
2583  0657 1a03          	or	a,(OFST+0,sp)
2585  0659 2002          	jra	L747
2586  065b               L547:
2587                     ; 454 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2589  065b 43            	cpl	a
2590  065c f4            	and	a,(x)
2591  065d               L747:
2592  065d f7            	ld	(x),a
2593                     ; 455 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2595  065e e602          	ld	a,(2,x)
2596  0660 1a03          	or	a,(OFST+0,sp)
2597  0662 e702          	ld	(2,x),a
2598                     ; 456 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2600  0664 e603          	ld	a,(3,x)
2601  0666 1a03          	or	a,(OFST+0,sp)
2602  0668 e703          	ld	(3,x),a
2603                     ; 457 }
2606  066a 5b05          	addw	sp,#5
2607  066c 81            	ret	
2673                     ; 460 void flush_leds(u8 led_count)
2673                     ; 461 {
2674                     	switch	.text
2675  066d               _flush_leds:
2677  066d 88            	push	a
2678  066e 5207          	subw	sp,#7
2679       00000007      OFST:	set	7
2682                     ; 462 	u8 led_read_index=0,led_write_index=0;
2686  0670 0f05          	clr	(OFST-2,sp)
2689  0672               L1001:
2690                     ; 465 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2692  0672 72020087fb    	btjt	_pwm_state,#1,L1001
2693                     ; 466 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2695  0677 c60087        	ld	a,_pwm_state
2696  067a a401          	and	a,#1
2697  067c a801          	xor	a,#1
2698  067e 6b07          	ld	(OFST+0,sp),a
2700                     ; 468 	if(led_count==0) led_count=1;//min value
2702  0680 7b08          	ld	a,(OFST+1,sp)
2703  0682 2603          	jrne	L5001
2706  0684 4c            	inc	a
2707  0685 6b08          	ld	(OFST+1,sp),a
2708  0687               L5001:
2709                     ; 469 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2711  0687 97            	ld	xl,a
2712  0688 4f            	clr	a
2713  0689 02            	rlwa	x,a
2714  068a 58            	sllw	x
2715  068b 58            	sllw	x
2716  068c 7b07          	ld	a,(OFST+0,sp)
2717  068e cd076c        	call	LC003
2718                     ; 471 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2720  0691 4f            	clr	a
2721  0692 90df0080      	ldw	(_pwm_sleep,y),x
2722  0696 6b06          	ld	(OFST-1,sp),a
2724  0698               L7001:
2725                     ; 473 		read_brightness=pwm_brightness_buffer[led_read_index];
2727  0698 5f            	clrw	x
2728  0699 97            	ld	xl,a
2729  069a d60011        	ld	a,(_pwm_brightness_buffer,x)
2730  069d 5f            	clrw	x
2731  069e 97            	ld	xl,a
2732  069f 1f03          	ldw	(OFST-4,sp),x
2734                     ; 474 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2736  06a1 2765          	jreq	L5101
2737                     ; 476 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2739  06a3 7b05          	ld	a,(OFST-2,sp)
2740  06a5 5f            	clrw	x
2741  06a6 97            	ld	xl,a
2742  06a7 58            	sllw	x
2743  06a8 01            	rrwa	x,a
2744  06a9 1b07          	add	a,(OFST+0,sp)
2745  06ab 2401          	jrnc	L643
2746  06ad 5c            	incw	x
2747  06ae               L643:
2748  06ae 02            	rlwa	x,a
2749  06af 7b06          	ld	a,(OFST-1,sp)
2750  06b1 d70030        	ld	(_pwm_brightness_index,x),a
2751                     ; 477 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2753  06b4 1e03          	ldw	x,(OFST-4,sp)
2754  06b6 9093          	ldw	y,x
2755  06b8 cd0000        	call	c_imul
2757  06bb a606          	ld	a,#6
2758  06bd               L053:
2759  06bd 54            	srlw	x
2760  06be 4a            	dec	a
2761  06bf 26fc          	jrne	L053
2762  06c1 5c            	incw	x
2763  06c2 7b07          	ld	a,(OFST+0,sp)
2764  06c4 cd076c        	call	LC003
2765  06c7 1701          	ldw	(OFST-6,sp),y
2767  06c9 905f          	clrw	y
2768  06cb 7b05          	ld	a,(OFST-2,sp)
2769  06cd 9097          	ld	yl,a
2770  06cf 9058          	sllw	y
2771  06d1 9058          	sllw	y
2772  06d3 72f901        	addw	y,(OFST-6,sp)
2773  06d6 90df0004      	ldw	(_pwm_brightness,y),x
2774                     ; 478 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2776  06da 5f            	clrw	x
2777  06db 7b07          	ld	a,(OFST+0,sp)
2778  06dd 97            	ld	xl,a
2779  06de 58            	sllw	x
2780  06df cd076c        	call	LC003
2781  06e2 1701          	ldw	(OFST-6,sp),y
2783  06e4 905f          	clrw	y
2784  06e6 7b05          	ld	a,(OFST-2,sp)
2785  06e8 9097          	ld	yl,a
2786  06ea 9058          	sllw	y
2787  06ec 9058          	sllw	y
2788  06ee 72f901        	addw	y,(OFST-6,sp)
2789  06f1 90de0004      	ldw	y,(_pwm_brightness,y)
2790  06f5 9001          	rrwa	y,a
2791  06f7 d00081        	sub	a,(_pwm_sleep+1,x)
2792  06fa 9001          	rrwa	y,a
2793  06fc d20080        	sbc	a,(_pwm_sleep,x)
2794  06ff 9001          	rrwa	y,a
2795  0701 9050          	negw	y
2796  0703 df0080        	ldw	(_pwm_sleep,x),y
2797                     ; 479 			led_write_index++;
2799  0706 0c05          	inc	(OFST-2,sp)
2801  0708               L5101:
2802                     ; 481 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2804  0708 7b06          	ld	a,(OFST-1,sp)
2805  070a 5f            	clrw	x
2806  070b 97            	ld	xl,a
2807  070c 724f0011      	clr	(_pwm_brightness_buffer,x)
2808                     ; 471 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2810  0710 0c06          	inc	(OFST-1,sp)
2814  0712 7b06          	ld	a,(OFST-1,sp)
2815  0714 a11f          	cp	a,#31
2816  0716 2580          	jrult	L7001
2817                     ; 483 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2819  0718 7b07          	ld	a,(OFST+0,sp)
2820  071a 5f            	clrw	x
2821  071b 97            	ld	xl,a
2822  071c 58            	sllw	x
2823  071d 9093          	ldw	y,x
2824  071f 90de0080      	ldw	y,(_pwm_sleep,y)
2825  0723 90a37c01      	cpw	y,#31745
2826  0727 2408          	jruge	L1201
2828  0729 d60081        	ld	a,(_pwm_sleep+1,x)
2829  072c da0080        	or	a,(_pwm_sleep,x)
2830  072f 2607          	jrne	L7101
2831  0731               L1201:
2834  0731 90ae0001      	ldw	y,#1
2835  0735 df0080        	ldw	(_pwm_sleep,x),y
2836  0738               L7101:
2837                     ; 484 	if(led_write_index==0)
2839  0738 7b05          	ld	a,(OFST-2,sp)
2840  073a 2620          	jrne	L3201
2841                     ; 486 		led_write_index=1;
2843  073c 4c            	inc	a
2844  073d 6b05          	ld	(OFST-2,sp),a
2846                     ; 487 		pwm_sleep[buffer_index]=1<<10;
2848  073f 5f            	clrw	x
2849  0740 7b07          	ld	a,(OFST+0,sp)
2850  0742 97            	ld	xl,a
2851  0743 58            	sllw	x
2852  0744 90ae0400      	ldw	y,#1024
2853  0748 df0080        	ldw	(_pwm_sleep,x),y
2854                     ; 488 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2856  074b 5f            	clrw	x
2857  074c 97            	ld	xl,a
2858  074d a612          	ld	a,#18
2859  074f d70030        	ld	(_pwm_brightness_index,x),a
2860                     ; 489 		pwm_brightness[0][buffer_index]=0;
2862  0752 5f            	clrw	x
2863  0753 7b07          	ld	a,(OFST+0,sp)
2864  0755 97            	ld	xl,a
2865  0756 58            	sllw	x
2866  0757 905f          	clrw	y
2867  0759 df0004        	ldw	(_pwm_brightness,x),y
2868  075c               L3201:
2869                     ; 491 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2871  075c 7b07          	ld	a,(OFST+0,sp)
2872  075e 5f            	clrw	x
2873  075f 97            	ld	xl,a
2874  0760 7b05          	ld	a,(OFST-2,sp)
2875  0762 d70084        	ld	(_pwm_led_count,x),a
2876                     ; 494 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2878  0765 72120087      	bset	_pwm_state,#1
2879                     ; 495 }
2882  0769 5b08          	addw	sp,#8
2883  076b 81            	ret	
2884  076c               LC003:
2885  076c 905f          	clrw	y
2886  076e 9097          	ld	yl,a
2887  0770 9058          	sllw	y
2888  0772 81            	ret	
2981                     ; 498 void set_hue_max(u8 index,u16 color)
2981                     ; 499 {
2982                     	switch	.text
2983  0773               _set_hue_max:
2985  0773 88            	push	a
2986  0774 5207          	subw	sp,#7
2987       00000007      OFST:	set	7
2990                     ; 502 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2992  0776 a6b4          	ld	a,#180
2993  0778 6b06          	ld	(OFST-1,sp),a
2995                     ; 503 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2997  077a a63d          	ld	a,#61
2998  077c 6b01          	ld	(OFST-6,sp),a
3000                     ; 504 	u8 red=0,green=0,blue=0;
3002  077e 0f02          	clr	(OFST-5,sp)
3006  0780 0f03          	clr	(OFST-4,sp)
3010  0782 0f04          	clr	(OFST-3,sp)
3012                     ; 505 	u8 residual=0;
3014  0784 0f07          	clr	(OFST+0,sp)
3016                     ; 507 	for(iter=0;iter<6;iter++)
3018  0786 0f05          	clr	(OFST-2,sp)
3020  0788               L1011:
3021                     ; 509 		if(color<0x2AAB)
3023  0788 1e0b          	ldw	x,(OFST+4,sp)
3024  078a a32aab        	cpw	x,#10923
3025  078d 2408          	jruge	L7011
3026                     ; 511 			residual=color/BRIGHTNESS_STEP;
3028  078f 7b01          	ld	a,(OFST-6,sp)
3029  0791 62            	div	x,a
3030  0792 01            	rrwa	x,a
3031  0793 6b07          	ld	(OFST+0,sp),a
3033                     ; 512 			break;
3035  0795 200d          	jra	L5011
3036  0797               L7011:
3037                     ; 514 		color-=0x2AAB;
3039  0797 1d2aab        	subw	x,#10923
3040  079a 1f0b          	ldw	(OFST+4,sp),x
3041                     ; 507 	for(iter=0;iter<6;iter++)
3043  079c 0c05          	inc	(OFST-2,sp)
3047  079e 7b05          	ld	a,(OFST-2,sp)
3048  07a0 a106          	cp	a,#6
3049  07a2 25e4          	jrult	L1011
3050  07a4               L5011:
3051                     ; 516 	switch(iter)
3053  07a4 7b05          	ld	a,(OFST-2,sp)
3055                     ; 523 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
3056  07a6 2714          	jreq	L5201
3057  07a8 4a            	dec	a
3058  07a9 2719          	jreq	L7201
3059  07ab 4a            	dec	a
3060  07ac 271e          	jreq	L1301
3061  07ae 4a            	dec	a
3062  07af 2725          	jreq	L3301
3063  07b1 4a            	dec	a
3064  07b2 272c          	jreq	L5301
3067  07b4 7b06          	ld	a,(OFST-1,sp)
3068  07b6 6b02          	ld	(OFST-5,sp),a
3072  07b8 1007          	sub	a,(OFST+0,sp)
3075  07ba 2016          	jp	LC005
3076  07bc               L5201:
3077                     ; 518 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
3079  07bc 7b06          	ld	a,(OFST-1,sp)
3080  07be 6b02          	ld	(OFST-5,sp),a
3084  07c0 7b07          	ld	a,(OFST+0,sp)
3087  07c2 2018          	jp	LC006
3088  07c4               L7201:
3089                     ; 519 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
3091  07c4 7b06          	ld	a,(OFST-1,sp)
3092  07c6 6b03          	ld	(OFST-4,sp),a
3096  07c8 1007          	sub	a,(OFST+0,sp)
3099  07ca 201a          	jp	LC004
3100  07cc               L1301:
3101                     ; 520 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
3103  07cc 7b06          	ld	a,(OFST-1,sp)
3104  07ce 6b03          	ld	(OFST-4,sp),a
3108  07d0 7b07          	ld	a,(OFST+0,sp)
3109  07d2               LC005:
3110  07d2 6b04          	ld	(OFST-3,sp),a
3114  07d4 2012          	jra	L3111
3115  07d6               L3301:
3116                     ; 521 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
3118  07d6 7b06          	ld	a,(OFST-1,sp)
3119  07d8 6b04          	ld	(OFST-3,sp),a
3123  07da 1007          	sub	a,(OFST+0,sp)
3124  07dc               LC006:
3125  07dc 6b03          	ld	(OFST-4,sp),a
3129  07de 2008          	jra	L3111
3130  07e0               L5301:
3131                     ; 522 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
3133  07e0 7b06          	ld	a,(OFST-1,sp)
3134  07e2 6b04          	ld	(OFST-3,sp),a
3138  07e4 7b07          	ld	a,(OFST+0,sp)
3139  07e6               LC004:
3140  07e6 6b02          	ld	(OFST-5,sp),a
3144  07e8               L3111:
3145                     ; 525 	set_rgb(index,0,red);
3147  07e8 7b02          	ld	a,(OFST-5,sp)
3148  07ea 88            	push	a
3149  07eb 7b09          	ld	a,(OFST+2,sp)
3150  07ed 5f            	clrw	x
3151  07ee 95            	ld	xh,a
3152  07ef ad1b          	call	_set_rgb
3154  07f1 84            	pop	a
3155                     ; 526 	set_rgb(index,1,green);
3157  07f2 7b03          	ld	a,(OFST-4,sp)
3158  07f4 88            	push	a
3159  07f5 7b09          	ld	a,(OFST+2,sp)
3160  07f7 ae0001        	ldw	x,#1
3161  07fa 95            	ld	xh,a
3162  07fb ad0f          	call	_set_rgb
3164  07fd 84            	pop	a
3165                     ; 527 	set_rgb(index,2,blue);
3167  07fe 7b04          	ld	a,(OFST-3,sp)
3168  0800 88            	push	a
3169  0801 7b09          	ld	a,(OFST+2,sp)
3170  0803 ae0002        	ldw	x,#2
3171  0806 95            	ld	xh,a
3172  0807 ad03          	call	_set_rgb
3174  0809 5b09          	addw	sp,#9
3175                     ; 528 }
3178  080b 81            	ret	
3225                     ; 532 void set_rgb(u8 index,u8 color,u8 brightness)
3225                     ; 533 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
3226                     	switch	.text
3227  080c               _set_rgb:
3229  080c 89            	pushw	x
3230       00000000      OFST:	set	0
3235  080d a606          	ld	a,#6
3236  080f 42            	mul	x,a
3237  0810 01            	rrwa	x,a
3238  0811 1b01          	add	a,(OFST+1,sp)
3239  0813 2401          	jrnc	L463
3240  0815 5c            	incw	x
3241  0816               L463:
3242  0816 02            	rlwa	x,a
3243  0817 7b05          	ld	a,(OFST+5,sp)
3244  0819 d70011        	ld	(_pwm_brightness_buffer,x),a
3248  081c 85            	popw	x
3249  081d 81            	ret	
3289                     ; 534 void set_white(u8 index,u8 brightness)
3289                     ; 535 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
3290                     	switch	.text
3291  081e               _set_white:
3293  081e 89            	pushw	x
3294       00000000      OFST:	set	0
3299  081f 9e            	ld	a,xh
3300  0820 5f            	clrw	x
3301  0821 97            	ld	xl,a
3302  0822 7b02          	ld	a,(OFST+2,sp)
3303  0824 d70024        	ld	(_pwm_brightness_buffer+19,x),a
3307  0827 85            	popw	x
3308  0828 81            	ret	
3341                     ; 536 void set_debug(u8 brightness)
3341                     ; 537 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
3342                     	switch	.text
3343  0829               _set_debug:
3349  0829 c70023        	ld	_pwm_brightness_buffer+18,a
3353  082c 81            	ret	
3545                     	xdef	f_I2C_EventHandler
3546                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3547                     	xdef	_i2c_transaction_byte_count
3548                     	xdef	_developer_flag
3549                     	xdef	_is_developer_debug
3550                     	switch	.bss
3551  0003               _this_addr:
3552  0003 00            	ds.b	1
3553                     	xdef	_this_addr
3554  0004               _MessageBegin:
3555  0004 00            	ds.b	1
3556                     	xdef	_MessageBegin
3557  0005               _u8_MyBuffp:
3558  0005 0000          	ds.b	2
3559                     	xdef	_u8_MyBuffp
3560  0007               _u8_My_Buffer:
3561  0007 000000000000  	ds.b	6
3562                     	xdef	_u8_My_Buffer
3563  000d               _button_pressed_event:
3564  000d 00000000      	ds.b	4
3565                     	xdef	_button_pressed_event
3566                     	xdef	_is_right_button_down
3567                     	xdef	_button_start_ms
3568                     	xdef	_is_valid_i2c_received
3569                     	xdef	_pwm_state
3570                     	xdef	_pwm_visible_index
3571                     	xdef	_pwm_led_count
3572                     	xdef	_pwm_sleep
3573  0011               _pwm_brightness_buffer:
3574  0011 000000000000  	ds.b	31
3575                     	xdef	_pwm_brightness_buffer
3576  0030               _pwm_brightness_index:
3577  0030 000000000000  	ds.b	62
3578                     	xdef	_pwm_brightness_index
3579                     	xdef	_pwm_brightness
3580                     	xdef	_atomic_counter
3581                     	xref	_GPIO_ReadInputPin
3582                     	xref	_GPIO_Init
3583                     	xref	_I2C_ITConfig
3584                     	xref	_I2C_Cmd
3585                     	xref	_I2C_Init
3586                     	xref	_I2C_DeInit
3587                     	xdef	_update_developer_gpio
3588                     	xdef	_set_developer_flag
3589                     	xdef	_get_developer_flag
3590                     	xdef	_is_application
3591                     	xdef	_I2C_byte_write
3592                     	xdef	_I2C_byte_received
3593                     	xdef	_I2C_transaction_end
3594                     	xdef	_I2C_transaction_begin
3595                     	xdef	_set_led_on
3596                     	xdef	_set_mat
3597                     	xdef	_get_random
3598                     	xdef	_is_button_down
3599                     	xdef	_get_button_event
3600                     	xdef	_update_buttons
3601                     	xdef	_set_hue_max
3602                     	xdef	_flush_leds
3603                     	xdef	_set_debug
3604                     	xdef	_set_white
3605                     	xdef	_set_rgb
3606                     	xdef	_millis
3607                     	xdef	_setup_main
3608                     	xdef	_hello_world
3609                     	xref.b	c_lreg
3610                     	xref.b	c_x
3611                     	xref.b	c_y
3631                     	xref	c_xymov
3632                     	xref	c_lgadd
3633                     	xref	c_uitolx
3634                     	xref	c_lcmp
3635                     	xref	c_rtol
3636                     	xref	c_lsub
3637                     	xref	c_lzmp
3638                     	xref	c_lursh
3639                     	xref	c_ltor
3640                     	xref	c_imul
3641                     	end
