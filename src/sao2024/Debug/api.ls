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
  42  008e               _is_developer_debug:
  43  008e 01            	dc.b	1
  44  008f               _developer_flag:
  45  008f 00            	dc.b	0
  46  0090               _i2c_transaction_byte_count:
  47  0090 00            	dc.b	0
 107                     ; 42 void hello_world()
 107                     ; 43 {//basic program that blinks the debug LED ON/OFF
 109                     	switch	.text
 110  0000               _hello_world:
 112  0000 5204          	subw	sp,#4
 113       00000004      OFST:	set	4
 116                     ; 44 	const u8 cycle_speed=10;//larger=faster
 118  0002 a60a          	ld	a,#10
 119  0004 6b02          	ld	(OFST-2,sp),a
 121                     ; 45 	const u8 white_speed=2;//smaller=faster
 123  0006 a602          	ld	a,#2
 124  0008 6b01          	ld	(OFST-3,sp),a
 126                     ; 47 	while(0)
 129  000a 5f            	clrw	x
 131  000b               L53:
 132                     ; 55 		frame++;
 134  000b 5c            	incw	x
 135  000c 1f03          	ldw	(OFST-1,sp),x
 137                     ; 56 		set_hue_max(0,(frame<<cycle_speed));
 139  000e 7b02          	ld	a,(OFST-2,sp)
 140  0010 2704          	jreq	L01
 141  0012               L21:
 142  0012 58            	sllw	x
 143  0013 4a            	dec	a
 144  0014 26fc          	jrne	L21
 145  0016               L01:
 146  0016 89            	pushw	x
 147  0017 4f            	clr	a
 148  0018 cd079f        	call	_set_hue_max
 150  001b 85            	popw	x
 151                     ; 57 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 153  001c 1e03          	ldw	x,(OFST-1,sp)
 154  001e 7b02          	ld	a,(OFST-2,sp)
 155  0020 2704          	jreq	L61
 156  0022               L02:
 157  0022 58            	sllw	x
 158  0023 4a            	dec	a
 159  0024 26fc          	jrne	L02
 160  0026               L61:
 161  0026 1c2aab        	addw	x,#10923
 162  0029 89            	pushw	x
 163  002a a601          	ld	a,#1
 164  002c cd079f        	call	_set_hue_max
 166  002f 85            	popw	x
 167                     ; 58 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 169  0030 1e03          	ldw	x,(OFST-1,sp)
 170  0032 7b02          	ld	a,(OFST-2,sp)
 171  0034 2704          	jreq	L42
 172  0036               L62:
 173  0036 58            	sllw	x
 174  0037 4a            	dec	a
 175  0038 26fc          	jrne	L62
 176  003a               L42:
 177  003a 1c5556        	addw	x,#21846
 178  003d 89            	pushw	x
 179  003e a602          	ld	a,#2
 180  0040 cd079f        	call	_set_hue_max
 182  0043 85            	popw	x
 183                     ; 59 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 185  0044 1e03          	ldw	x,(OFST-1,sp)
 186  0046 7b02          	ld	a,(OFST-2,sp)
 187  0048 2704          	jreq	L23
 188  004a               L43:
 189  004a 58            	sllw	x
 190  004b 4a            	dec	a
 191  004c 26fc          	jrne	L43
 192  004e               L23:
 193  004e 1c8000        	addw	x,#32768
 194  0051 89            	pushw	x
 195  0052 a603          	ld	a,#3
 196  0054 cd079f        	call	_set_hue_max
 198  0057 85            	popw	x
 199                     ; 60 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 201  0058 1e03          	ldw	x,(OFST-1,sp)
 202  005a 7b02          	ld	a,(OFST-2,sp)
 203  005c 2704          	jreq	L04
 204  005e               L24:
 205  005e 58            	sllw	x
 206  005f 4a            	dec	a
 207  0060 26fc          	jrne	L24
 208  0062               L04:
 209  0062 1caaab        	addw	x,#43691
 210  0065 89            	pushw	x
 211  0066 a604          	ld	a,#4
 212  0068 cd079f        	call	_set_hue_max
 214  006b 85            	popw	x
 215                     ; 61 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 217  006c 1e03          	ldw	x,(OFST-1,sp)
 218  006e 7b02          	ld	a,(OFST-2,sp)
 219  0070 2704          	jreq	L64
 220  0072               L05:
 221  0072 58            	sllw	x
 222  0073 4a            	dec	a
 223  0074 26fc          	jrne	L05
 224  0076               L64:
 225  0076 1cd554        	addw	x,#54612
 226  0079 89            	pushw	x
 227  007a a605          	ld	a,#5
 228  007c cd079f        	call	_set_hue_max
 230  007f 85            	popw	x
 231                     ; 65 		set_white((frame>>(white_speed+1))%12,0xFF);
 233  0080 1e03          	ldw	x,(OFST-1,sp)
 234  0082 7b01          	ld	a,(OFST-3,sp)
 235  0084 4c            	inc	a
 236  0085 2704          	jreq	L45
 237  0087               L65:
 238  0087 54            	srlw	x
 239  0088 4a            	dec	a
 240  0089 26fc          	jrne	L65
 241  008b               L45:
 242  008b a60c          	ld	a,#12
 243  008d 62            	div	x,a
 244  008e ae00ff        	ldw	x,#255
 245  0091 95            	ld	xh,a
 246  0092 cd084a        	call	_set_white
 248                     ; 66 		flush_leds(7);
 250  0095 a607          	ld	a,#7
 251  0097 cd0699        	call	_flush_leds
 254  009a 1e03          	ldw	x,(OFST-1,sp)
 255  009c cc000b        	jra	L53
 300                     ; 70 bool is_application()
 300                     ; 71 {
 301                     	switch	.text
 302  009f               _is_application:
 306                     ; 72 	return !is_valid_i2c_received;
 308  009f c60088        	ld	a,_is_valid_i2c_received
 309  00a2 2602          	jrne	L46
 310  00a4 4c            	inc	a
 312  00a5 81            	ret	
 313  00a6               L46:
 314  00a6 4f            	clr	a
 317  00a7 81            	ret	
 363                     ; 75 u16 get_random(u16 x)
 363                     ; 76 {
 364                     	switch	.text
 365  00a8               _get_random:
 367       00000004      OFST:	set	4
 370                     ; 77 	u16 a=1664525;
 372                     ; 78 	u16 c=1013904223;
 374                     ; 79 	return a * x + c;
 376  00a8 90ae660d      	ldw	y,#26125
 377  00ac cd0000        	call	c_imul
 379  00af 1cf35f        	addw	x,#62303
 382  00b2 81            	ret	
 412                     ; 99 void setup_main()
 412                     ; 100 {
 413                     	switch	.text
 414  00b3               _setup_main:
 418                     ; 101 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 420  00b3 c650c6        	ld	a,20678
 421  00b6 a4e7          	and	a,#231
 422  00b8 c750c6        	ld	20678,a
 423                     ; 105 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 425  00bb 4b40          	push	#64
 426  00bd 4b02          	push	#2
 427  00bf ae500f        	ldw	x,#20495
 428  00c2 cd0000        	call	_GPIO_Init
 430  00c5 3505530e      	mov	21262,#5
 431  00c9 725f530f      	clr	21263
 432  00cd 35ff5310      	mov	21264,#255
 433  00d1 c65300        	ld	a,21248
 434  00d4 aa05          	or	a,#5
 435  00d6 c75300        	ld	21248,a
 436  00d9 35015303      	mov	21251,#1
 437  00dd 85            	popw	x
 438                     ; 110 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 440                     ; 111 	TIM2->ARRH= 0;// init auto reload register
 442                     ; 112 	TIM2->ARRL= 255;// init auto reload register
 444                     ; 114 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 446                     ; 116 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 448                     ; 123 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 450  00de 4b40          	push	#64
 451  00e0 4b08          	push	#8
 452  00e2 ae500f        	ldw	x,#20495
 453  00e5 cd0000        	call	_GPIO_Init
 455  00e8 85            	popw	x
 456                     ; 124 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
 458  00e9 4b40          	push	#64
 459  00eb 4b10          	push	#16
 460  00ed ae500f        	ldw	x,#20495
 461  00f0 cd0000        	call	_GPIO_Init
 463  00f3 85            	popw	x
 464                     ; 127 	I2C_DeInit();
 466  00f4 cd0000        	call	_I2C_DeInit
 468                     ; 128 	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
 470  00f7 4b10          	push	#16
 471  00f9 4b00          	push	#0
 472  00fb 4b01          	push	#1
 473  00fd 4b00          	push	#0
 474  00ff ae0060        	ldw	x,#96
 475  0102 89            	pushw	x
 476  0103 ae86a0        	ldw	x,#34464
 477  0106 89            	pushw	x
 478  0107 ae0001        	ldw	x,#1
 479  010a 89            	pushw	x
 480  010b cd0000        	call	_I2C_Init
 482  010e 5b0a          	addw	sp,#10
 483                     ; 129 	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
 485  0110 ae0701        	ldw	x,#1793
 486  0113 cd0000        	call	_I2C_ITConfig
 488                     ; 130 	I2C_Cmd(ENABLE);
 490  0116 a601          	ld	a,#1
 491  0118 cd0000        	call	_I2C_Cmd
 493                     ; 131 	u8_My_Buffer[6]=0x03;//setup the default behavior of the button output interrupts
 495  011b 3503000d      	mov	_u8_My_Buffer+6,#3
 496                     ; 132 	enableInterrupts();  // Enable global interrupts
 499  011f 9a            	rim	
 501                     ; 133 }
 505  0120 81            	ret	
 529                     ; 135 u32 millis()
 529                     ; 136 {
 530                     	switch	.text
 531  0121               _millis:
 535                     ; 137 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 537  0121 ae0000        	ldw	x,#_atomic_counter
 538  0124 cd0000        	call	c_ltor
 540  0127 a609          	ld	a,#9
 544  0129 cc0000        	jp	c_lursh
 595                     ; 140 void update_developer_gpio()
 595                     ; 141 {
 596                     	switch	.text
 597  012c               _update_developer_gpio:
 599  012c 5203          	subw	sp,#3
 600       00000003      OFST:	set	3
 603                     ; 142 	bool is_instantaneous=(u8_My_Buffer[6]&0x01)&&(is_button_down(1) | is_button_down(0));
 605  012e c6000d        	ld	a,_u8_My_Buffer+6
 606  0131 a501          	bcp	a,#1
 607  0133 2714          	jreq	L611
 608  0135 4f            	clr	a
 609  0136 cd026b        	call	_is_button_down
 611  0139 6b01          	ld	(OFST-2,sp),a
 613  013b a601          	ld	a,#1
 614  013d cd026b        	call	_is_button_down
 616  0140 1a01          	or	a,(OFST-2,sp)
 617  0142 2705          	jreq	L611
 618  0144 ae0001        	ldw	x,#1
 619  0147 2001          	jra	L421
 620  0149               L611:
 621  0149 5f            	clrw	x
 622  014a               L421:
 623  014a 01            	rrwa	x,a
 624  014b 6b02          	ld	(OFST-1,sp),a
 626                     ; 143 	bool is_event        =(u8_My_Buffer[6]&0x02)&&(get_button_event(0xFF,0xFF,0));
 628  014d c6000d        	ld	a,_u8_My_Buffer+6
 629  0150 a502          	bcp	a,#2
 630  0152 2712          	jreq	L621
 631  0154 4b00          	push	#0
 632  0156 aeffff        	ldw	x,#65535
 633  0159 cd0217        	call	_get_button_event
 635  015c 5b01          	addw	sp,#1
 636  015e 4d            	tnz	a
 637  015f 2705          	jreq	L621
 638  0161 ae0001        	ldw	x,#1
 639  0164 2001          	jra	L231
 640  0166               L621:
 641  0166 5f            	clrw	x
 642  0167               L231:
 643  0167 01            	rrwa	x,a
 644  0168 6b03          	ld	(OFST+0,sp),a
 646                     ; 144 	if(is_valid_i2c_received)
 648  016a c60088        	ld	a,_is_valid_i2c_received
 649  016d 2716          	jreq	L341
 650                     ; 145 		GPIO_Init(GPIOD, GPIO_PIN_5, ( is_instantaneous | is_event )?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
 652  016f 7b02          	ld	a,(OFST-1,sp)
 653  0171 1a03          	or	a,(OFST+0,sp)
 654  0173 2704          	jreq	L631
 655  0175 a6d0          	ld	a,#208
 656  0177 2002          	jra	L041
 657  0179               L631:
 658  0179 a6c0          	ld	a,#192
 659  017b               L041:
 660  017b 88            	push	a
 661  017c 4b20          	push	#32
 662  017e ae500f        	ldw	x,#20495
 663  0181 cd0000        	call	_GPIO_Init
 665  0184 85            	popw	x
 666  0185               L341:
 667                     ; 146 }
 670  0185 5b03          	addw	sp,#3
 671  0187 81            	ret	
 717                     .const:	section	.text
 718  0000               L451:
 719  0000 00000201      	dc.l	513
 720  0004               L651:
 721  0004 00000033      	dc.l	51
 722                     ; 150 void update_buttons()
 722                     ; 151 {
 723                     	switch	.text
 724  0188               _update_buttons:
 726  0188 5205          	subw	sp,#5
 727       00000005      OFST:	set	5
 730                     ; 154 	update_developer_gpio();
 732  018a ada0          	call	_update_developer_gpio
 734                     ; 155 	if(button_start_ms)
 736  018c ae0089        	ldw	x,#_button_start_ms
 737  018f cd0000        	call	c_lzmp
 739  0192 2757          	jreq	L361
 740                     ; 157 		set_debug(255);
 742  0194 a6ff          	ld	a,#255
 743  0196 cd0855        	call	_set_debug
 745                     ; 158 		if(!is_button_down(is_right_button_down))
 747  0199 c6008d        	ld	a,_is_right_button_down
 748  019c cd026b        	call	_is_button_down
 750  019f 4d            	tnz	a
 751  01a0 2672          	jrne	L571
 752                     ; 160 			elapsed_pressed_ms=millis()-button_start_ms;
 754  01a2 cd0121        	call	_millis
 756  01a5 ae0089        	ldw	x,#_button_start_ms
 757  01a8 cd0000        	call	c_lsub
 759  01ab 96            	ldw	x,sp
 760  01ac 5c            	incw	x
 761  01ad cd0000        	call	c_rtol
 764                     ; 161 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 766  01b0 96            	ldw	x,sp
 767  01b1 5c            	incw	x
 768  01b2 cd0000        	call	c_ltor
 770  01b5 ae0000        	ldw	x,#L451
 771  01b8 cd0000        	call	c_lcmp
 773  01bb 250d          	jrult	L761
 776  01bd c6008d        	ld	a,_is_right_button_down
 777  01c0 5f            	clrw	x
 778  01c1 97            	ld	xl,a
 779  01c2 58            	sllw	x
 780  01c3 a601          	ld	a,#1
 781  01c5 d7000f        	ld	(_button_pressed_event+1,x),a
 783  01c8 2018          	jra	L171
 784  01ca               L761:
 785                     ; 162 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 787  01ca 96            	ldw	x,sp
 788  01cb 5c            	incw	x
 789  01cc cd0000        	call	c_ltor
 791  01cf ae0004        	ldw	x,#L651
 792  01d2 cd0000        	call	c_lcmp
 794  01d5 250b          	jrult	L171
 797  01d7 c6008d        	ld	a,_is_right_button_down
 798  01da 5f            	clrw	x
 799  01db 97            	ld	xl,a
 800  01dc 58            	sllw	x
 801  01dd a601          	ld	a,#1
 802  01df d7000e        	ld	(_button_pressed_event,x),a
 803  01e2               L171:
 804                     ; 163 			button_start_ms=0;
 806  01e2 5f            	clrw	x
 807  01e3 cf008b        	ldw	_button_start_ms+2,x
 808  01e6 cf0089        	ldw	_button_start_ms,x
 809  01e9 2029          	jra	L571
 810  01eb               L361:
 811                     ; 166 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 813  01eb 0f05          	clr	(OFST+0,sp)
 816  01ed 2017          	jra	L302
 817  01ef               L771:
 818                     ; 168 			if(is_button_down(button_index))
 820  01ef 7b05          	ld	a,(OFST+0,sp)
 821  01f1 ad78          	call	_is_button_down
 823  01f3 4d            	tnz	a
 824  01f4 270e          	jreq	L702
 825                     ; 170 				is_right_button_down=button_index;
 827  01f6 7b05          	ld	a,(OFST+0,sp)
 828  01f8 c7008d        	ld	_is_right_button_down,a
 829                     ; 171 				button_start_ms=millis();
 831  01fb cd0121        	call	_millis
 833  01fe ae0089        	ldw	x,#_button_start_ms
 834  0201 cd0000        	call	c_rtol
 836  0204               L702:
 837                     ; 166 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 839  0204 0c05          	inc	(OFST+0,sp)
 841  0206               L302:
 844  0206 7b05          	ld	a,(OFST+0,sp)
 845  0208 a102          	cp	a,#2
 846  020a 2408          	jruge	L571
 848  020c ae0089        	ldw	x,#_button_start_ms
 849  020f cd0000        	call	c_lzmp
 851  0212 27db          	jreq	L771
 852  0214               L571:
 853                     ; 175 }
 856  0214 5b05          	addw	sp,#5
 857  0216 81            	ret	
 925                     ; 180 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 925                     ; 181 {
 926                     	switch	.text
 927  0217               _get_button_event:
 929  0217 89            	pushw	x
 930  0218 89            	pushw	x
 931       00000002      OFST:	set	2
 934                     ; 183 	bool out=0;
 936  0219 0f01          	clr	(OFST-1,sp)
 938                     ; 184 	for(iter=0;iter<BUTTON_COUNT;iter++)
 940  021b 0f02          	clr	(OFST+0,sp)
 942  021d               L342:
 943                     ; 186 		if(button_index==iter || button_index==0xFF)
 945  021d 7b03          	ld	a,(OFST+1,sp)
 946  021f 1102          	cp	a,(OFST+0,sp)
 947  0221 2703          	jreq	L352
 949  0223 4c            	inc	a
 950  0224 2638          	jrne	L152
 951  0226               L352:
 952                     ; 188 			if(is_long==0 || is_long==0xFF)
 954  0226 7b04          	ld	a,(OFST+2,sp)
 955  0228 2703          	jreq	L752
 957  022a 4c            	inc	a
 958  022b 2614          	jrne	L552
 959  022d               L752:
 960                     ; 190 				out|=button_pressed_event[iter][0];
 962  022d 7b02          	ld	a,(OFST+0,sp)
 963  022f 5f            	clrw	x
 964  0230 97            	ld	xl,a
 965  0231 58            	sllw	x
 966  0232 7b01          	ld	a,(OFST-1,sp)
 967  0234 da000e        	or	a,(_button_pressed_event,x)
 968  0237 6b01          	ld	(OFST-1,sp),a
 970                     ; 191 				if(is_clear) button_pressed_event[iter][0]=0;
 972  0239 7b07          	ld	a,(OFST+5,sp)
 973  023b 2704          	jreq	L552
 976  023d 724f000e      	clr	(_button_pressed_event,x)
 977  0241               L552:
 978                     ; 193 			if(is_long==1 || is_long==0xFF)
 980  0241 7b04          	ld	a,(OFST+2,sp)
 981  0243 a101          	cp	a,#1
 982  0245 2703          	jreq	L562
 984  0247 4c            	inc	a
 985  0248 2614          	jrne	L152
 986  024a               L562:
 987                     ; 195 				out|=button_pressed_event[iter][1];
 989  024a 7b02          	ld	a,(OFST+0,sp)
 990  024c 5f            	clrw	x
 991  024d 97            	ld	xl,a
 992  024e 58            	sllw	x
 993  024f 7b01          	ld	a,(OFST-1,sp)
 994  0251 da000f        	or	a,(_button_pressed_event+1,x)
 995  0254 6b01          	ld	(OFST-1,sp),a
 997                     ; 196 				if(is_clear) button_pressed_event[iter][1]=0;
 999  0256 7b07          	ld	a,(OFST+5,sp)
1000  0258 2704          	jreq	L152
1003  025a 724f000f      	clr	(_button_pressed_event+1,x)
1004  025e               L152:
1005                     ; 184 	for(iter=0;iter<BUTTON_COUNT;iter++)
1007  025e 0c02          	inc	(OFST+0,sp)
1011  0260 7b02          	ld	a,(OFST+0,sp)
1012  0262 a102          	cp	a,#2
1013  0264 25b7          	jrult	L342
1014                     ; 200 	return out;
1016  0266 7b01          	ld	a,(OFST-1,sp)
1019  0268 5b04          	addw	sp,#4
1020  026a 81            	ret	
1054                     ; 204 bool is_button_down(u8 index)
1054                     ; 205 {
1055                     	switch	.text
1056  026b               _is_button_down:
1060                     ; 206 	switch(index)
1063                     ; 210 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1064  026b 4d            	tnz	a
1065  026c 2708          	jreq	L172
1066  026e 4a            	dec	a
1067  026f 2716          	jreq	L372
1068  0271 4a            	dec	a
1069  0272 2724          	jreq	L572
1070  0274 2033          	jra	L513
1071  0276               L172:
1072                     ; 208 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button
1074  0276 4b08          	push	#8
1075  0278 ae500f        	ldw	x,#20495
1076  027b cd0000        	call	_GPIO_ReadInputPin
1078  027e 5b01          	addw	sp,#1
1079  0280 4d            	tnz	a
1080  0281 2602          	jrne	L071
1081  0283 4c            	inc	a
1083  0284 81            	ret	
1084  0285               L071:
1085  0285 4f            	clr	a
1088  0286 81            	ret	
1089  0287               L372:
1090                     ; 209 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
1093  0287 4b10          	push	#16
1094  0289 ae500f        	ldw	x,#20495
1095  028c cd0000        	call	_GPIO_ReadInputPin
1097  028f 5b01          	addw	sp,#1
1098  0291 4d            	tnz	a
1099  0292 2602          	jrne	L671
1100  0294 4c            	inc	a
1102  0295 81            	ret	
1103  0296               L671:
1104  0296 4f            	clr	a
1107  0297 81            	ret	
1108  0298               L572:
1109                     ; 210 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1112  0298 4b02          	push	#2
1113  029a ae500f        	ldw	x,#20495
1114  029d cd0000        	call	_GPIO_ReadInputPin
1116  02a0 5b01          	addw	sp,#1
1117  02a2 4d            	tnz	a
1118  02a3 2602          	jrne	L402
1119  02a5 4c            	inc	a
1121  02a6 81            	ret	
1122  02a7               L402:
1123  02a7 4f            	clr	a
1126  02a8 81            	ret	
1127  02a9               L513:
1128                     ; 212 	return 0;
1130  02a9 4f            	clr	a
1133  02aa 81            	ret	
1157                     ; 215 u8 get_developer_flag(){ return developer_flag; }
1158                     	switch	.text
1159  02ab               _get_developer_flag:
1165  02ab c6008f        	ld	a,_developer_flag
1168  02ae 81            	ret	
1202                     ; 216 void set_developer_flag(u8 value)
1202                     ; 217 {
1203                     	switch	.text
1204  02af               _set_developer_flag:
1206  02af 88            	push	a
1207       00000000      OFST:	set	0
1210                     ; 218 	if(value!=0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_SLOW);//frame_buffer_pin
1212  02b0 4d            	tnz	a
1213  02b1 270b          	jreq	L343
1216  02b3 4bd0          	push	#208
1217  02b5 4b40          	push	#64
1218  02b7 ae500f        	ldw	x,#20495
1219  02ba cd0000        	call	_GPIO_Init
1221  02bd 85            	popw	x
1222  02be               L343:
1223                     ; 219 	developer_flag=value;
1225  02be 7b01          	ld	a,(OFST+1,sp)
1226  02c0 c7008f        	ld	_developer_flag,a
1227                     ; 220 	if(value==0) GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_SLOW);
1229  02c3 260b          	jrne	L543
1232  02c5 4bc0          	push	#192
1233  02c7 4b40          	push	#64
1234  02c9 ae500f        	ldw	x,#20495
1235  02cc cd0000        	call	_GPIO_Init
1237  02cf 85            	popw	x
1238  02d0               L543:
1239                     ; 221 }
1242  02d0 84            	pop	a
1243  02d1 81            	ret	
1268                     ; 228 	void I2C_transaction_begin(void)
1268                     ; 229 	{
1269                     	switch	.text
1270  02d2               _I2C_transaction_begin:
1274                     ; 230 		MessageBegin = TRUE;
1276  02d2 35010004      	mov	_MessageBegin,#1
1277                     ; 232 	}
1280  02d6 81            	ret	
1325                     ; 233 	void I2C_transaction_end(bool is_slave_txd)
1325                     ; 234 	{
1326                     	switch	.text
1327  02d7               _I2C_transaction_end:
1331                     ; 235 		is_valid_i2c_received=1;
1333  02d7 35010088      	mov	_is_valid_i2c_received,#1
1334                     ; 236 		if(is_slave_txd)
1336  02db 4d            	tnz	a
1337  02dc 2706          	jreq	L704
1338                     ; 238 			u8_My_Buffer[2]=u8_My_Buffer[2]+1;
1340  02de 725c0009      	inc	_u8_My_Buffer+2
1342  02e2 202d          	jra	L114
1343  02e4               L704:
1344                     ; 240 			u8_My_Buffer[1]=u8_My_Buffer[1]+1;
1346  02e4 725c0008      	inc	_u8_My_Buffer+1
1347                     ; 241 			switch(this_addr)
1349  02e8 c60003        	ld	a,_this_addr
1351                     ; 261 				default: break;
1352  02eb 270c          	jreq	L753
1353  02ed a003          	sub	a,#3
1354  02ef 2725          	jreq	L163
1355  02f1 4a            	dec	a
1356  02f2 273c          	jreq	L363
1357  02f4 4a            	dec	a
1358  02f5 274a          	jreq	L563
1359  02f7 2018          	jra	L114
1360  02f9               L753:
1361                     ; 244 					is_developer_debug=!is_developer_debug;
1363  02f9 725d008e      	tnz	_is_developer_debug
1364  02fd 2603          	jrne	L622
1365  02ff 4c            	inc	a
1366  0300 2001          	jra	L032
1367  0302               L622:
1368  0302 4f            	clr	a
1369  0303               L032:
1370  0303 c7008e        	ld	_is_developer_debug,a
1371                     ; 245 					set_debug(is_developer_debug?0xFF:0);
1373  0306 2702          	jreq	L432
1374  0308 a6ff          	ld	a,#255
1375  030a               L432:
1376  030a cd0855        	call	_set_debug
1378                     ; 246 					set_developer_flag(1);
1380  030d a601          	ld	a,#1
1381  030f               LC001:
1382  030f ad9e          	call	_set_developer_flag
1384                     ; 247 				}break;
1385  0311               L114:
1386                     ; 264 		i2c_transaction_byte_count=0;
1388  0311 725f0090      	clr	_i2c_transaction_byte_count
1389                     ; 265 	}
1392  0315 81            	ret	
1393  0316               L163:
1394                     ; 249 						if(i2c_transaction_byte_count>1 && u8_MyBuffp==&u8_My_Buffer[4])
1396  0316 c60090        	ld	a,_i2c_transaction_byte_count
1397  0319 a102          	cp	a,#2
1398  031b 25f4          	jrult	L114
1400  031d ce0005        	ldw	x,_u8_MyBuffp
1401  0320 a3000b        	cpw	x,#_u8_My_Buffer+4
1402  0323 26ec          	jrne	L114
1403                     ; 251 							set_developer_flag(u8_My_Buffer[3]);
1405  0325 c6000a        	ld	a,_u8_My_Buffer+3
1406  0328 ad85          	call	_set_developer_flag
1408                     ; 252 							u8_My_Buffer[3]=0;//reset the led_index register to default state
1410  032a 725f000a      	clr	_u8_My_Buffer+3
1411  032e 20e1          	jra	L114
1412  0330               L363:
1413                     ; 256 					if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1415  0330 c6000a        	ld	a,_u8_My_Buffer+3
1416  0333 a11f          	cp	a,#31
1417  0335 24da          	jruge	L114
1420  0337 5f            	clrw	x
1421  0338 97            	ld	xl,a
1422  0339 c6000b        	ld	a,_u8_My_Buffer+4
1423  033c d70012        	ld	(_pwm_brightness_buffer,x),a
1424  033f 20d0          	jra	L114
1425  0341               L563:
1426                     ; 259 					set_developer_flag(u8_My_Buffer[5]);//note: an excessively high value here (>>10) will cause the LEDs on the SAO to flicker notably
1428  0341 c6000c        	ld	a,_u8_My_Buffer+5
1430                     ; 260 				}break;
1432  0344 20c9          	jp	LC001
1433                     ; 261 				default: break;
1472                     ; 266 	void I2C_byte_received(u8 u8_RxData)
1472                     ; 267 	{
1473                     	switch	.text
1474  0346               _I2C_byte_received:
1476  0346 88            	push	a
1477       00000000      OFST:	set	0
1480                     ; 268 		if (MessageBegin == TRUE  &&  u8_RxData < ADDRESS_COUNT_READ) {
1482  0347 c60004        	ld	a,_MessageBegin
1483  034a 4a            	dec	a
1484  034b 2617          	jrne	L734
1486  034d 7b01          	ld	a,(OFST+1,sp)
1487  034f a109          	cp	a,#9
1488  0351 2411          	jruge	L734
1489                     ; 269 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
1491  0353 5f            	clrw	x
1492  0354 97            	ld	xl,a
1493  0355 1c0007        	addw	x,#_u8_My_Buffer
1494  0358 cf0005        	ldw	_u8_MyBuffp,x
1495                     ; 270 			MessageBegin = FALSE;
1497  035b 725f0004      	clr	_MessageBegin
1498                     ; 271 			this_addr=u8_RxData;
1500  035f c70003        	ld	_this_addr,a
1502  0362 2037          	jra	L144
1503  0364               L734:
1504                     ; 275 			i2c_transaction_byte_count++;
1506  0364 725c0090      	inc	_i2c_transaction_byte_count
1507                     ; 276       if(u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE]) *(u8_MyBuffp++) = u8_RxData;
1509  0368 ce0005        	ldw	x,_u8_MyBuffp
1510  036b a3000e        	cpw	x,#_u8_My_Buffer+7
1511  036e 2407          	jruge	L344
1514  0370 7b01          	ld	a,(OFST+1,sp)
1515  0372 f7            	ld	(x),a
1516  0373 5c            	incw	x
1517  0374 cf0005        	ldw	_u8_MyBuffp,x
1518  0377               L344:
1519                     ; 277 			if(this_addr==3 && u8_MyBuffp==&u8_My_Buffer[5])
1521  0377 c60003        	ld	a,_this_addr
1522  037a a103          	cp	a,#3
1523  037c 261d          	jrne	L144
1525  037e a3000c        	cpw	x,#_u8_My_Buffer+5
1526  0381 2618          	jrne	L144
1527                     ; 279 				if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1529  0383 c6000a        	ld	a,_u8_My_Buffer+3
1530  0386 a11f          	cp	a,#31
1531  0388 240b          	jruge	L744
1534  038a 5f            	clrw	x
1535  038b 97            	ld	xl,a
1536  038c c6000b        	ld	a,_u8_My_Buffer+4
1537  038f d70012        	ld	(_pwm_brightness_buffer,x),a
1538  0392 ce0005        	ldw	x,_u8_MyBuffp
1539  0395               L744:
1540                     ; 280 				u8_MyBuffp-=2;
1542  0395 1d0002        	subw	x,#2
1543  0398 cf0005        	ldw	_u8_MyBuffp,x
1544  039b               L144:
1545                     ; 283 	}
1548  039b 84            	pop	a
1549  039c 81            	ret	
1578                     ; 284 	u8 I2C_byte_write(void)
1578                     ; 285 	{
1579                     	switch	.text
1580  039d               _I2C_byte_write:
1582  039d 5206          	subw	sp,#6
1583       00000006      OFST:	set	6
1586                     ; 286 		if (u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE])
1588  039f ce0005        	ldw	x,_u8_MyBuffp
1589  03a2 a3000e        	cpw	x,#_u8_My_Buffer+7
1590  03a5 2408          	jruge	L164
1591                     ; 287 			return *(u8_MyBuffp++);
1593  03a7 f6            	ld	a,(x)
1594  03a8 5c            	incw	x
1595  03a9 cf0005        	ldw	_u8_MyBuffp,x
1597  03ac cc044f        	jra	L213
1598  03af               L164:
1599                     ; 288 		else if(this_addr==7 || this_addr==8)
1601  03af c60003        	ld	a,_this_addr
1602  03b2 a107          	cp	a,#7
1603  03b4 2707          	jreq	L764
1605  03b6 a108          	cp	a,#8
1606  03b8 2703cc0452    	jrne	L564
1607  03bd               L764:
1608                     ; 290 			update_developer_gpio();
1610  03bd cd012c        	call	_update_developer_gpio
1612                     ; 291 			return
1612                     ; 292 				get_button_event(1,1,this_addr==8)<<7 |
1612                     ; 293 				get_button_event(0,1,this_addr==8)<<6 |
1612                     ; 294 				get_button_event(1,0,this_addr==8)<<5 |
1612                     ; 295 				get_button_event(0,0,this_addr==8)<<4 |
1612                     ; 296 				is_button_down(2)<<2 |//returns 1 if the SWIM pin is grounded
1612                     ; 297 				is_button_down(1)<<1 |
1612                     ; 298 				is_button_down(0);
1614  03c0 4f            	clr	a
1615  03c1 cd026b        	call	_is_button_down
1617  03c4 6b06          	ld	(OFST+0,sp),a
1619  03c6 a601          	ld	a,#1
1620  03c8 cd026b        	call	_is_button_down
1622  03cb 48            	sll	a
1623  03cc 6b05          	ld	(OFST-1,sp),a
1625  03ce a602          	ld	a,#2
1626  03d0 cd026b        	call	_is_button_down
1628  03d3 48            	sll	a
1629  03d4 48            	sll	a
1630  03d5 6b04          	ld	(OFST-2,sp),a
1632  03d7 c60003        	ld	a,_this_addr
1633  03da a108          	cp	a,#8
1634  03dc 2604          	jrne	L462
1635  03de a601          	ld	a,#1
1636  03e0 2001          	jra	L662
1637  03e2               L462:
1638  03e2 4f            	clr	a
1639  03e3               L662:
1640  03e3 88            	push	a
1641  03e4 5f            	clrw	x
1642  03e5 cd0217        	call	_get_button_event
1644  03e8 5b01          	addw	sp,#1
1645  03ea 97            	ld	xl,a
1646  03eb a610          	ld	a,#16
1647  03ed 42            	mul	x,a
1648  03ee 9f            	ld	a,xl
1649  03ef 6b03          	ld	(OFST-3,sp),a
1651  03f1 c60003        	ld	a,_this_addr
1652  03f4 a108          	cp	a,#8
1653  03f6 2604          	jrne	L272
1654  03f8 a601          	ld	a,#1
1655  03fa 2001          	jra	L472
1656  03fc               L272:
1657  03fc 4f            	clr	a
1658  03fd               L472:
1659  03fd 88            	push	a
1660  03fe ae0100        	ldw	x,#256
1661  0401 cd0217        	call	_get_button_event
1663  0404 5b01          	addw	sp,#1
1664  0406 97            	ld	xl,a
1665  0407 a620          	ld	a,#32
1666  0409 42            	mul	x,a
1667  040a 9f            	ld	a,xl
1668  040b 6b02          	ld	(OFST-4,sp),a
1670  040d c60003        	ld	a,_this_addr
1671  0410 a108          	cp	a,#8
1672  0412 2604          	jrne	L003
1673  0414 a601          	ld	a,#1
1674  0416 2001          	jra	L203
1675  0418               L003:
1676  0418 4f            	clr	a
1677  0419               L203:
1678  0419 88            	push	a
1679  041a ae0001        	ldw	x,#1
1680  041d cd0217        	call	_get_button_event
1682  0420 5b01          	addw	sp,#1
1683  0422 97            	ld	xl,a
1684  0423 a640          	ld	a,#64
1685  0425 42            	mul	x,a
1686  0426 9f            	ld	a,xl
1687  0427 6b01          	ld	(OFST-5,sp),a
1689  0429 c60003        	ld	a,_this_addr
1690  042c a108          	cp	a,#8
1691  042e 2604          	jrne	L603
1692  0430 a601          	ld	a,#1
1693  0432 2001          	jra	L013
1694  0434               L603:
1695  0434 4f            	clr	a
1696  0435               L013:
1697  0435 88            	push	a
1698  0436 ae0101        	ldw	x,#257
1699  0439 cd0217        	call	_get_button_event
1701  043c 5b01          	addw	sp,#1
1702  043e 97            	ld	xl,a
1703  043f a680          	ld	a,#128
1704  0441 42            	mul	x,a
1705  0442 9f            	ld	a,xl
1706  0443 1a01          	or	a,(OFST-5,sp)
1707  0445 1a02          	or	a,(OFST-4,sp)
1708  0447 1a03          	or	a,(OFST-3,sp)
1709  0449 1a04          	or	a,(OFST-2,sp)
1710  044b 1a05          	or	a,(OFST-1,sp)
1711  044d 1a06          	or	a,(OFST+0,sp)
1713  044f               L213:
1715  044f 5b06          	addw	sp,#6
1716  0451 81            	ret	
1717  0452               L564:
1718                     ; 301 			return 0x00;
1720  0452 4f            	clr	a
1722  0453 20fa          	jra	L213
1774                     ; 305 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1776                     	switch	.text
1777  0455               f_TIM2_UPD_OVF_IRQHandler:
1779  0455 8a            	push	cc
1780  0456 84            	pop	a
1781  0457 a4bf          	and	a,#191
1782  0459 88            	push	a
1783  045a 86            	pop	cc
1784       00000005      OFST:	set	5
1785  045b 3b0002        	push	c_x+2
1786  045e be00          	ldw	x,c_x
1787  0460 89            	pushw	x
1788  0461 3b0002        	push	c_y+2
1789  0464 be00          	ldw	x,c_y
1790  0466 89            	pushw	x
1791  0467 be02          	ldw	x,c_lreg+2
1792  0469 89            	pushw	x
1793  046a be00          	ldw	x,c_lreg
1794  046c 89            	pushw	x
1795  046d 5205          	subw	sp,#5
1798                     ; 306 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1800  046f c60087        	ld	a,_pwm_state
1801  0472 a401          	and	a,#1
1802  0474 6b03          	ld	(OFST-2,sp),a
1804                     ; 307 	u16 sleep_counts=1;
1806  0476 ae0001        	ldw	x,#1
1807  0479 1f04          	ldw	(OFST-1,sp),x
1809                     ; 309 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1811  047b c6500c        	ld	a,20492
1812  047e a407          	and	a,#7
1813  0480 c7500c        	ld	20492,a
1814                     ; 310 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1816  0483 72155011      	bres	20497,#2
1817                     ; 311 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1819  0487 72175002      	bres	20482,#3
1820                     ; 312 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1822  048b c6500d        	ld	a,20493
1823  048e a407          	and	a,#7
1824  0490 c7500d        	ld	20493,a
1825                     ; 313 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1827  0493 72155012      	bres	20498,#2
1828                     ; 314 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1830  0497 72175003      	bres	20483,#3
1831                     ; 315   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1833  049b 72115300      	bres	21248,#0
1834                     ; 316 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1836  049f 7b03          	ld	a,(OFST-2,sp)
1837  04a1 8d490549      	callf	LC002
1838  04a5 260a          	jrne	L315
1839                     ; 318 		sleep_counts=pwm_sleep[buffer_index];
1841  04a7 7b03          	ld	a,(OFST-2,sp)
1842  04a9 5f            	clrw	x
1843  04aa 97            	ld	xl,a
1844  04ab 58            	sllw	x
1845  04ac de0080        	ldw	x,(_pwm_sleep,x)
1846  04af 1f04          	ldw	(OFST-1,sp),x
1848  04b1               L315:
1849                     ; 320 	if(pwm_visible_index>pwm_led_count[buffer_index])
1851  04b1 7b03          	ld	a,(OFST-2,sp)
1852  04b3 8d490549      	callf	LC002
1853  04b7 2418          	jruge	L515
1854                     ; 322 		pwm_visible_index=0;//formally start new frame
1856  04b9 725f0086      	clr	_pwm_visible_index
1857                     ; 323 		update_buttons();
1859  04bd cd0188        	call	_update_buttons
1861                     ; 324 		if(pwm_state&0x02)
1863  04c0 720300870c    	btjf	_pwm_state,#1,L515
1864                     ; 326 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1866  04c5 c60087        	ld	a,_pwm_state
1867  04c8 a803          	xor	a,#3
1868  04ca c70087        	ld	_pwm_state,a
1869                     ; 327 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1871  04cd a401          	and	a,#1
1872  04cf 6b03          	ld	(OFST-2,sp),a
1874  04d1               L515:
1875                     ; 330 	if(pwm_visible_index<pwm_led_count[buffer_index])
1877  04d1 7b03          	ld	a,(OFST-2,sp)
1878  04d3 8d490549      	callf	LC002
1879  04d7 2332          	jrule	L125
1880                     ; 332 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1882  04d9 7b03          	ld	a,(OFST-2,sp)
1883  04db 5f            	clrw	x
1884  04dc 97            	ld	xl,a
1885  04dd 58            	sllw	x
1886  04de 1f01          	ldw	(OFST-4,sp),x
1888  04e0 c60086        	ld	a,_pwm_visible_index
1889  04e3 97            	ld	xl,a
1890  04e4 a604          	ld	a,#4
1891  04e6 42            	mul	x,a
1892  04e7 72fb01        	addw	x,(OFST-4,sp)
1893  04ea de0004        	ldw	x,(_pwm_brightness,x)
1894  04ed 1f04          	ldw	(OFST-1,sp),x
1896                     ; 333 		if(sleep_counts==0)
1898  04ef 2607          	jrne	L325
1899                     ; 335 			sleep_counts=1<<10;
1901  04f1 ae0400        	ldw	x,#1024
1902  04f4 1f04          	ldw	(OFST-1,sp),x
1905  04f6 2013          	jra	L125
1906  04f8               L325:
1907                     ; 337 			set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1909  04f8 c60086        	ld	a,_pwm_visible_index
1910  04fb 5f            	clrw	x
1911  04fc 97            	ld	xl,a
1912  04fd 58            	sllw	x
1913  04fe 01            	rrwa	x,a
1914  04ff 1b03          	add	a,(OFST-2,sp)
1915  0501 2401          	jrnc	L223
1916  0503 5c            	incw	x
1917  0504               L223:
1918  0504 02            	rlwa	x,a
1919  0505 d60031        	ld	a,(_pwm_brightness_index,x)
1920  0508 cd05ea        	call	_set_led_on
1922  050b               L125:
1923                     ; 340 	pwm_visible_index++;
1925  050b 725c0086      	inc	_pwm_visible_index
1926                     ; 341 	atomic_counter+=sleep_counts;
1928  050f 1e04          	ldw	x,(OFST-1,sp)
1929  0511 cd0000        	call	c_uitolx
1931  0514 ae0000        	ldw	x,#_atomic_counter
1932  0517 cd0000        	call	c_lgadd
1934                     ; 343   TIM2->CNTRH = 0;// Set the high byte of the counter
1936  051a 725f530c      	clr	21260
1937                     ; 344   TIM2->CNTRL = 0;// Set the low byte of the counter
1939  051e 725f530d      	clr	21261
1940                     ; 345 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1942  0522 7b04          	ld	a,(OFST-1,sp)
1943  0524 c7530f        	ld	21263,a
1944                     ; 346 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1946  0527 7b05          	ld	a,(OFST+0,sp)
1947  0529 c75310        	ld	21264,a
1948                     ; 348 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1950  052c 72115304      	bres	21252,#0
1951                     ; 349   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1953  0530 72105300      	bset	21248,#0
1954                     ; 350 }
1957  0534 5b05          	addw	sp,#5
1958  0536 85            	popw	x
1959  0537 bf00          	ldw	c_lreg,x
1960  0539 85            	popw	x
1961  053a bf02          	ldw	c_lreg+2,x
1962  053c 85            	popw	x
1963  053d bf00          	ldw	c_y,x
1964  053f 320002        	pop	c_y+2
1965  0542 85            	popw	x
1966  0543 bf00          	ldw	c_x,x
1967  0545 320002        	pop	c_x+2
1968  0548 80            	iret	
1969  0549               LC002:
1970  0549 5f            	clrw	x
1971  054a 97            	ld	xl,a
1972  054b d60084        	ld	a,(_pwm_led_count,x)
1973  054e c10086        	cp	a,_pwm_visible_index
1974  0551 87            	retf	
1976                     	switch	.bss
1977  0000               L725_sr1:
1978  0000 00            	ds.b	1
1979  0001               L135_sr2:
1980  0001 00            	ds.b	1
1981  0002               L335_sr3:
1982  0002 00            	ds.b	1
2030                     ; 352 @far @interrupt void I2C_EventHandler(void)
2030                     ; 353 {
2031                     	switch	.text
2032  0552               f_I2C_EventHandler:
2034  0552 8a            	push	cc
2035  0553 84            	pop	a
2036  0554 a4bf          	and	a,#191
2037  0556 88            	push	a
2038  0557 86            	pop	cc
2039  0558 3b0002        	push	c_x+2
2040  055b be00          	ldw	x,c_x
2041  055d 89            	pushw	x
2042  055e 3b0002        	push	c_y+2
2043  0561 be00          	ldw	x,c_y
2044  0563 89            	pushw	x
2047                     ; 359 sr1 = I2C->SR1;
2049  0564 5552170000    	mov	L725_sr1,21015
2050                     ; 360 sr2 = I2C->SR2;
2052  0569 5552180001    	mov	L135_sr2,21016
2053                     ; 361 sr3 = I2C->SR3;
2055  056e 5552190002    	mov	L335_sr3,21017
2056                     ; 364   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
2058  0573 c60001        	ld	a,L135_sr2
2059  0576 a52b          	bcp	a,#43
2060  0578 2708          	jreq	L555
2061                     ; 366     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
2063  057a 72125211      	bset	21009,#1
2064                     ; 367     I2C->SR2= 0;					    // clear all error flags
2066  057e 725f5218      	clr	21016
2067  0582               L555:
2068                     ; 370   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
2070  0582 c60000        	ld	a,L725_sr1
2071  0585 a444          	and	a,#68
2072  0587 a144          	cp	a,#68
2073  0589 2606          	jrne	L755
2074                     ; 372     I2C_byte_received(I2C->DR);
2076  058b c65216        	ld	a,21014
2077  058e cd0346        	call	_I2C_byte_received
2079  0591               L755:
2080                     ; 375   if (sr1 & I2C_SR1_RXNE)
2082  0591 720d000006    	btjf	L725_sr1,#6,L165
2083                     ; 377     I2C_byte_received(I2C->DR);
2085  0596 c65216        	ld	a,21014
2086  0599 cd0346        	call	_I2C_byte_received
2088  059c               L165:
2089                     ; 380   if (sr2 & I2C_SR2_AF)
2091  059c 7205000109    	btjf	L135_sr2,#2,L365
2092                     ; 382     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
2094  05a1 72155218      	bres	21016,#2
2095                     ; 383 		I2C_transaction_end(1);
2097  05a5 a601          	ld	a,#1
2098  05a7 cd02d7        	call	_I2C_transaction_end
2100  05aa               L365:
2101                     ; 386   if (sr1 & I2C_SR1_STOPF) 
2103  05aa 7209000008    	btjf	L725_sr1,#4,L565
2104                     ; 388     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
2106  05af 72145211      	bset	21009,#2
2107                     ; 389 		I2C_transaction_end(0);
2109  05b3 4f            	clr	a
2110  05b4 cd02d7        	call	_I2C_transaction_end
2112  05b7               L565:
2113                     ; 392   if (sr1 & I2C_SR1_ADDR)
2115  05b7 7203000003    	btjf	L725_sr1,#1,L765
2116                     ; 394 		I2C_transaction_begin();
2118  05bc cd02d2        	call	_I2C_transaction_begin
2120  05bf               L765:
2121                     ; 397   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
2123  05bf c60000        	ld	a,L725_sr1
2124  05c2 a484          	and	a,#132
2125  05c4 a184          	cp	a,#132
2126  05c6 2606          	jrne	L175
2127                     ; 399 		I2C->DR = I2C_byte_write();
2129  05c8 cd039d        	call	_I2C_byte_write
2131  05cb c75216        	ld	21014,a
2132  05ce               L175:
2133                     ; 402   if (sr1 & I2C_SR1_TXE)
2135  05ce 720f000006    	btjf	L725_sr1,#7,L375
2136                     ; 404 		I2C->DR = I2C_byte_write();
2138  05d3 cd039d        	call	_I2C_byte_write
2140  05d6 c75216        	ld	21014,a
2141  05d9               L375:
2142                     ; 406 	GPIOD->ODR^=1;
2144  05d9 9010500f      	bcpl	20495,#0
2145                     ; 407 }
2148  05dd 85            	popw	x
2149  05de bf00          	ldw	c_y,x
2150  05e0 320002        	pop	c_y+2
2151  05e3 85            	popw	x
2152  05e4 bf00          	ldw	c_x,x
2153  05e6 320002        	pop	c_x+2
2154  05e9 80            	iret	
2156                     	switch	.const
2157  0008               L575_led_lookup:
2158  0008 00            	dc.b	0
2159  0009 03            	dc.b	3
2160  000a 01            	dc.b	1
2161  000b 03            	dc.b	3
2162  000c 02            	dc.b	2
2163  000d 03            	dc.b	3
2164  000e 03            	dc.b	3
2165  000f 00            	dc.b	0
2166  0010 04            	dc.b	4
2167  0011 00            	dc.b	0
2168  0012 05            	dc.b	5
2169  0013 00            	dc.b	0
2170  0014 00            	dc.b	0
2171  0015 04            	dc.b	4
2172  0016 01            	dc.b	1
2173  0017 04            	dc.b	4
2174  0018 02            	dc.b	2
2175  0019 04            	dc.b	4
2176  001a 03            	dc.b	3
2177  001b 01            	dc.b	1
2178  001c 04            	dc.b	4
2179  001d 01            	dc.b	1
2180  001e 05            	dc.b	5
2181  001f 01            	dc.b	1
2182  0020 00            	dc.b	0
2183  0021 05            	dc.b	5
2184  0022 01            	dc.b	1
2185  0023 05            	dc.b	5
2186  0024 02            	dc.b	2
2187  0025 05            	dc.b	5
2188  0026 03            	dc.b	3
2189  0027 02            	dc.b	2
2190  0028 04            	dc.b	4
2191  0029 02            	dc.b	2
2192  002a 05            	dc.b	5
2193  002b 02            	dc.b	2
2194  002c 06            	dc.b	6
2195  002d 06            	dc.b	6
2196  002e 01            	dc.b	1
2197  002f 00            	dc.b	0
2198  0030 02            	dc.b	2
2199  0031 00            	dc.b	0
2200  0032 00            	dc.b	0
2201  0033 01            	dc.b	1
2202  0034 02            	dc.b	2
2203  0035 01            	dc.b	1
2204  0036 00            	dc.b	0
2205  0037 02            	dc.b	2
2206  0038 01            	dc.b	1
2207  0039 02            	dc.b	2
2208  003a 04            	dc.b	4
2209  003b 03            	dc.b	3
2210  003c 05            	dc.b	5
2211  003d 03            	dc.b	3
2212  003e 03            	dc.b	3
2213  003f 04            	dc.b	4
2214  0040 05            	dc.b	5
2215  0041 04            	dc.b	4
2216  0042 03            	dc.b	3
2217  0043 05            	dc.b	5
2218  0044 04            	dc.b	4
2219  0045 05            	dc.b	5
2261                     ; 411 void set_led_on(u8 led_index)
2261                     ; 412 {
2263                     	switch	.text
2264  05ea               _set_led_on:
2266  05ea 88            	push	a
2267  05eb 5240          	subw	sp,#64
2268       00000040      OFST:	set	64
2271                     ; 413 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2271                     ; 414 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
2271                     ; 415 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
2271                     ; 416 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
2271                     ; 417 		{6,6},//debug; GND is tied low, no charlieplexing involved
2271                     ; 418 		{1,0},//LED7
2271                     ; 419 		{2,0},//LED8
2271                     ; 420 		{0,1},//LED9
2271                     ; 421 		{2,1},//LED10
2271                     ; 422 		{0,2},//LED11
2271                     ; 423 		{1,2},//LED12
2271                     ; 424 		{4,3},//LED13
2271                     ; 425 		{5,3},//LED14
2271                     ; 426 		{3,4},//LED15
2271                     ; 427 		{5,4},//LED16
2271                     ; 428 		{3,5},//LED17
2271                     ; 429 		{4,5} //LED18
2271                     ; 430 	};
2273  05ed 96            	ldw	x,sp
2274  05ee 1c0003        	addw	x,#OFST-61
2275  05f1 90ae0008      	ldw	y,#L575_led_lookup
2276  05f5 a63e          	ld	a,#62
2277  05f7 cd0000        	call	c_xymov
2279                     ; 431 	set_mat(led_lookup[led_index][0],1);
2281  05fa 96            	ldw	x,sp
2282  05fb 1c0003        	addw	x,#OFST-61
2283  05fe 1f01          	ldw	(OFST-63,sp),x
2285  0600 5f            	clrw	x
2286  0601 7b41          	ld	a,(OFST+1,sp)
2287  0603 97            	ld	xl,a
2288  0604 58            	sllw	x
2289  0605 72fb01        	addw	x,(OFST-63,sp)
2290  0608 f6            	ld	a,(x)
2291  0609 ae0001        	ldw	x,#1
2292  060c 95            	ld	xh,a
2293  060d ad1a          	call	_set_mat
2295                     ; 432 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0);
2297  060f 7b41          	ld	a,(OFST+1,sp)
2298  0611 a112          	cp	a,#18
2299  0613 2711          	jreq	L716
2302  0615 96            	ldw	x,sp
2303  0616 1c0004        	addw	x,#OFST-60
2304  0619 1f01          	ldw	(OFST-63,sp),x
2306  061b 5f            	clrw	x
2307  061c 97            	ld	xl,a
2308  061d 58            	sllw	x
2309  061e 72fb01        	addw	x,(OFST-63,sp)
2310  0621 f6            	ld	a,(x)
2311  0622 5f            	clrw	x
2312  0623 95            	ld	xh,a
2313  0624 ad03          	call	_set_mat
2315  0626               L716:
2316                     ; 433 }
2319  0626 5b41          	addw	sp,#65
2320  0628 81            	ret	
2519                     ; 438 void set_mat(u8 mat_index,bool is_high)
2519                     ; 439 {
2520                     	switch	.text
2521  0629               _set_mat:
2523  0629 89            	pushw	x
2524  062a 5203          	subw	sp,#3
2525       00000003      OFST:	set	3
2528                     ; 442 	switch(mat_index)
2530  062c 9e            	ld	a,xh
2532                     ; 450 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
2533  062d 4d            	tnz	a
2534  062e 2718          	jreq	L126
2535  0630 4a            	dec	a
2536  0631 271e          	jreq	L326
2537  0633 4a            	dec	a
2538  0634 2724          	jreq	L526
2539  0636 4a            	dec	a
2540  0637 272a          	jreq	L726
2541  0639 4a            	dec	a
2542  063a 2730          	jreq	L136
2543  063c 4a            	dec	a
2544  063d 2736          	jreq	L336
2547  063f ae5000        	ldw	x,#20480
2548  0642 1f01          	ldw	(OFST-2,sp),x
2552  0644 a608          	ld	a,#8
2555  0646 2034          	jra	L557
2556  0648               L126:
2557                     ; 444 		case 0:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
2559  0648 ae500a        	ldw	x,#20490
2560  064b 1f01          	ldw	(OFST-2,sp),x
2564  064d a608          	ld	a,#8
2567  064f 202b          	jra	L557
2568  0651               L326:
2569                     ; 445 		case 1:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
2571  0651 ae500a        	ldw	x,#20490
2572  0654 1f01          	ldw	(OFST-2,sp),x
2576  0656 a610          	ld	a,#16
2579  0658 2022          	jra	L557
2580  065a               L526:
2581                     ; 446 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
2583  065a ae500a        	ldw	x,#20490
2584  065d 1f01          	ldw	(OFST-2,sp),x
2588  065f a620          	ld	a,#32
2591  0661 2019          	jra	L557
2592  0663               L726:
2593                     ; 447 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
2595  0663 ae500a        	ldw	x,#20490
2596  0666 1f01          	ldw	(OFST-2,sp),x
2600  0668 a640          	ld	a,#64
2603  066a 2010          	jra	L557
2604  066c               L136:
2605                     ; 448 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
2607  066c ae500a        	ldw	x,#20490
2608  066f 1f01          	ldw	(OFST-2,sp),x
2612  0671 a680          	ld	a,#128
2615  0673 2007          	jra	L557
2616  0675               L336:
2617                     ; 449 		case 5:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
2619  0675 ae500f        	ldw	x,#20495
2620  0678 1f01          	ldw	(OFST-2,sp),x
2624  067a a604          	ld	a,#4
2627  067c               L557:
2628  067c 6b03          	ld	(OFST+0,sp),a
2630                     ; 452 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2632  067e 0d05          	tnz	(OFST+2,sp)
2633  0680 2705          	jreq	L757
2636  0682 f6            	ld	a,(x)
2637  0683 1a03          	or	a,(OFST+0,sp)
2639  0685 2002          	jra	L167
2640  0687               L757:
2641                     ; 453 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2643  0687 43            	cpl	a
2644  0688 f4            	and	a,(x)
2645  0689               L167:
2646  0689 f7            	ld	(x),a
2647                     ; 454 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2649  068a e602          	ld	a,(2,x)
2650  068c 1a03          	or	a,(OFST+0,sp)
2651  068e e702          	ld	(2,x),a
2652                     ; 455 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2654  0690 e603          	ld	a,(3,x)
2655  0692 1a03          	or	a,(OFST+0,sp)
2656  0694 e703          	ld	(3,x),a
2657                     ; 456 }
2660  0696 5b05          	addw	sp,#5
2661  0698 81            	ret	
2727                     ; 459 void flush_leds(u8 led_count)
2727                     ; 460 {
2728                     	switch	.text
2729  0699               _flush_leds:
2731  0699 88            	push	a
2732  069a 5207          	subw	sp,#7
2733       00000007      OFST:	set	7
2736                     ; 461 	u8 led_read_index=0,led_write_index=0;
2740  069c 0f05          	clr	(OFST-2,sp)
2743  069e               L3101:
2744                     ; 464 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2746  069e 72020087fb    	btjt	_pwm_state,#1,L3101
2747                     ; 465 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2749  06a3 c60087        	ld	a,_pwm_state
2750  06a6 a401          	and	a,#1
2751  06a8 a801          	xor	a,#1
2752  06aa 6b07          	ld	(OFST+0,sp),a
2754                     ; 467 	if(led_count==0) led_count=1;//min value
2756  06ac 7b08          	ld	a,(OFST+1,sp)
2757  06ae 2603          	jrne	L7101
2760  06b0 4c            	inc	a
2761  06b1 6b08          	ld	(OFST+1,sp),a
2762  06b3               L7101:
2763                     ; 468 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2765  06b3 97            	ld	xl,a
2766  06b4 4f            	clr	a
2767  06b5 02            	rlwa	x,a
2768  06b6 58            	sllw	x
2769  06b7 58            	sllw	x
2770  06b8 7b07          	ld	a,(OFST+0,sp)
2771  06ba cd0798        	call	LC003
2772                     ; 470 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2774  06bd 4f            	clr	a
2775  06be 90df0080      	ldw	(_pwm_sleep,y),x
2776  06c2 6b06          	ld	(OFST-1,sp),a
2778  06c4               L1201:
2779                     ; 472 		read_brightness=pwm_brightness_buffer[led_read_index];
2781  06c4 5f            	clrw	x
2782  06c5 97            	ld	xl,a
2783  06c6 d60012        	ld	a,(_pwm_brightness_buffer,x)
2784  06c9 5f            	clrw	x
2785  06ca 97            	ld	xl,a
2786  06cb 1f03          	ldw	(OFST-4,sp),x
2788                     ; 473 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2790  06cd 2765          	jreq	L7201
2791                     ; 475 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2793  06cf 7b05          	ld	a,(OFST-2,sp)
2794  06d1 5f            	clrw	x
2795  06d2 97            	ld	xl,a
2796  06d3 58            	sllw	x
2797  06d4 01            	rrwa	x,a
2798  06d5 1b07          	add	a,(OFST+0,sp)
2799  06d7 2401          	jrnc	L653
2800  06d9 5c            	incw	x
2801  06da               L653:
2802  06da 02            	rlwa	x,a
2803  06db 7b06          	ld	a,(OFST-1,sp)
2804  06dd d70031        	ld	(_pwm_brightness_index,x),a
2805                     ; 476 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2807  06e0 1e03          	ldw	x,(OFST-4,sp)
2808  06e2 9093          	ldw	y,x
2809  06e4 cd0000        	call	c_imul
2811  06e7 a606          	ld	a,#6
2812  06e9               L063:
2813  06e9 54            	srlw	x
2814  06ea 4a            	dec	a
2815  06eb 26fc          	jrne	L063
2816  06ed 5c            	incw	x
2817  06ee 7b07          	ld	a,(OFST+0,sp)
2818  06f0 cd0798        	call	LC003
2819  06f3 1701          	ldw	(OFST-6,sp),y
2821  06f5 905f          	clrw	y
2822  06f7 7b05          	ld	a,(OFST-2,sp)
2823  06f9 9097          	ld	yl,a
2824  06fb 9058          	sllw	y
2825  06fd 9058          	sllw	y
2826  06ff 72f901        	addw	y,(OFST-6,sp)
2827  0702 90df0004      	ldw	(_pwm_brightness,y),x
2828                     ; 477 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2830  0706 5f            	clrw	x
2831  0707 7b07          	ld	a,(OFST+0,sp)
2832  0709 97            	ld	xl,a
2833  070a 58            	sllw	x
2834  070b cd0798        	call	LC003
2835  070e 1701          	ldw	(OFST-6,sp),y
2837  0710 905f          	clrw	y
2838  0712 7b05          	ld	a,(OFST-2,sp)
2839  0714 9097          	ld	yl,a
2840  0716 9058          	sllw	y
2841  0718 9058          	sllw	y
2842  071a 72f901        	addw	y,(OFST-6,sp)
2843  071d 90de0004      	ldw	y,(_pwm_brightness,y)
2844  0721 9001          	rrwa	y,a
2845  0723 d00081        	sub	a,(_pwm_sleep+1,x)
2846  0726 9001          	rrwa	y,a
2847  0728 d20080        	sbc	a,(_pwm_sleep,x)
2848  072b 9001          	rrwa	y,a
2849  072d 9050          	negw	y
2850  072f df0080        	ldw	(_pwm_sleep,x),y
2851                     ; 478 			led_write_index++;
2853  0732 0c05          	inc	(OFST-2,sp)
2855  0734               L7201:
2856                     ; 480 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2858  0734 7b06          	ld	a,(OFST-1,sp)
2859  0736 5f            	clrw	x
2860  0737 97            	ld	xl,a
2861  0738 724f0012      	clr	(_pwm_brightness_buffer,x)
2862                     ; 470 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2864  073c 0c06          	inc	(OFST-1,sp)
2868  073e 7b06          	ld	a,(OFST-1,sp)
2869  0740 a11f          	cp	a,#31
2870  0742 2580          	jrult	L1201
2871                     ; 482 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2873  0744 7b07          	ld	a,(OFST+0,sp)
2874  0746 5f            	clrw	x
2875  0747 97            	ld	xl,a
2876  0748 58            	sllw	x
2877  0749 9093          	ldw	y,x
2878  074b 90de0080      	ldw	y,(_pwm_sleep,y)
2879  074f 90a37c01      	cpw	y,#31745
2880  0753 2408          	jruge	L3301
2882  0755 d60081        	ld	a,(_pwm_sleep+1,x)
2883  0758 da0080        	or	a,(_pwm_sleep,x)
2884  075b 2607          	jrne	L1301
2885  075d               L3301:
2888  075d 90ae0001      	ldw	y,#1
2889  0761 df0080        	ldw	(_pwm_sleep,x),y
2890  0764               L1301:
2891                     ; 483 	if(led_write_index==0)
2893  0764 7b05          	ld	a,(OFST-2,sp)
2894  0766 2620          	jrne	L5301
2895                     ; 485 		led_write_index=1;
2897  0768 4c            	inc	a
2898  0769 6b05          	ld	(OFST-2,sp),a
2900                     ; 486 		pwm_sleep[buffer_index]=1<<10;
2902  076b 5f            	clrw	x
2903  076c 7b07          	ld	a,(OFST+0,sp)
2904  076e 97            	ld	xl,a
2905  076f 58            	sllw	x
2906  0770 90ae0400      	ldw	y,#1024
2907  0774 df0080        	ldw	(_pwm_sleep,x),y
2908                     ; 487 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2910  0777 5f            	clrw	x
2911  0778 97            	ld	xl,a
2912  0779 a612          	ld	a,#18
2913  077b d70031        	ld	(_pwm_brightness_index,x),a
2914                     ; 488 		pwm_brightness[0][buffer_index]=0;
2916  077e 5f            	clrw	x
2917  077f 7b07          	ld	a,(OFST+0,sp)
2918  0781 97            	ld	xl,a
2919  0782 58            	sllw	x
2920  0783 905f          	clrw	y
2921  0785 df0004        	ldw	(_pwm_brightness,x),y
2922  0788               L5301:
2923                     ; 490 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2925  0788 7b07          	ld	a,(OFST+0,sp)
2926  078a 5f            	clrw	x
2927  078b 97            	ld	xl,a
2928  078c 7b05          	ld	a,(OFST-2,sp)
2929  078e d70084        	ld	(_pwm_led_count,x),a
2930                     ; 493 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2932  0791 72120087      	bset	_pwm_state,#1
2933                     ; 494 }
2936  0795 5b08          	addw	sp,#8
2937  0797 81            	ret	
2938  0798               LC003:
2939  0798 905f          	clrw	y
2940  079a 9097          	ld	yl,a
2941  079c 9058          	sllw	y
2942  079e 81            	ret	
3035                     ; 497 void set_hue_max(u8 index,u16 color)
3035                     ; 498 {
3036                     	switch	.text
3037  079f               _set_hue_max:
3039  079f 88            	push	a
3040  07a0 5207          	subw	sp,#7
3041       00000007      OFST:	set	7
3044                     ; 501 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
3046  07a2 a6b4          	ld	a,#180
3047  07a4 6b06          	ld	(OFST-1,sp),a
3049                     ; 502 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
3051  07a6 a63d          	ld	a,#61
3052  07a8 6b01          	ld	(OFST-6,sp),a
3054                     ; 503 	u8 red=0,green=0,blue=0;
3056  07aa 0f02          	clr	(OFST-5,sp)
3060  07ac 0f03          	clr	(OFST-4,sp)
3064  07ae 0f04          	clr	(OFST-3,sp)
3066                     ; 504 	u8 residual=0;
3068  07b0 0f07          	clr	(OFST+0,sp)
3070                     ; 506 	for(iter=0;iter<6;iter++)
3072  07b2 0f05          	clr	(OFST-2,sp)
3074  07b4               L3111:
3075                     ; 508 		if(color<0x2AAB)
3077  07b4 1e0b          	ldw	x,(OFST+4,sp)
3078  07b6 a32aab        	cpw	x,#10923
3079  07b9 2408          	jruge	L1211
3080                     ; 510 			residual=color/BRIGHTNESS_STEP;
3082  07bb 7b01          	ld	a,(OFST-6,sp)
3083  07bd 62            	div	x,a
3084  07be 01            	rrwa	x,a
3085  07bf 6b07          	ld	(OFST+0,sp),a
3087                     ; 511 			break;
3089  07c1 200d          	jra	L7111
3090  07c3               L1211:
3091                     ; 513 		color-=0x2AAB;
3093  07c3 1d2aab        	subw	x,#10923
3094  07c6 1f0b          	ldw	(OFST+4,sp),x
3095                     ; 506 	for(iter=0;iter<6;iter++)
3097  07c8 0c05          	inc	(OFST-2,sp)
3101  07ca 7b05          	ld	a,(OFST-2,sp)
3102  07cc a106          	cp	a,#6
3103  07ce 25e4          	jrult	L3111
3104  07d0               L7111:
3105                     ; 515 	switch(iter)
3107  07d0 7b05          	ld	a,(OFST-2,sp)
3109                     ; 522 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
3110  07d2 2714          	jreq	L7301
3111  07d4 4a            	dec	a
3112  07d5 2719          	jreq	L1401
3113  07d7 4a            	dec	a
3114  07d8 271e          	jreq	L3401
3115  07da 4a            	dec	a
3116  07db 2725          	jreq	L5401
3117  07dd 4a            	dec	a
3118  07de 272c          	jreq	L7401
3121  07e0 7b06          	ld	a,(OFST-1,sp)
3122  07e2 6b02          	ld	(OFST-5,sp),a
3126  07e4 1007          	sub	a,(OFST+0,sp)
3129  07e6 2016          	jp	LC005
3130  07e8               L7301:
3131                     ; 517 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
3133  07e8 7b06          	ld	a,(OFST-1,sp)
3134  07ea 6b02          	ld	(OFST-5,sp),a
3138  07ec 7b07          	ld	a,(OFST+0,sp)
3141  07ee 2018          	jp	LC006
3142  07f0               L1401:
3143                     ; 518 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
3145  07f0 7b06          	ld	a,(OFST-1,sp)
3146  07f2 6b03          	ld	(OFST-4,sp),a
3150  07f4 1007          	sub	a,(OFST+0,sp)
3153  07f6 201a          	jp	LC004
3154  07f8               L3401:
3155                     ; 519 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
3157  07f8 7b06          	ld	a,(OFST-1,sp)
3158  07fa 6b03          	ld	(OFST-4,sp),a
3162  07fc 7b07          	ld	a,(OFST+0,sp)
3163  07fe               LC005:
3164  07fe 6b04          	ld	(OFST-3,sp),a
3168  0800 2012          	jra	L5211
3169  0802               L5401:
3170                     ; 520 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
3172  0802 7b06          	ld	a,(OFST-1,sp)
3173  0804 6b04          	ld	(OFST-3,sp),a
3177  0806 1007          	sub	a,(OFST+0,sp)
3178  0808               LC006:
3179  0808 6b03          	ld	(OFST-4,sp),a
3183  080a 2008          	jra	L5211
3184  080c               L7401:
3185                     ; 521 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
3187  080c 7b06          	ld	a,(OFST-1,sp)
3188  080e 6b04          	ld	(OFST-3,sp),a
3192  0810 7b07          	ld	a,(OFST+0,sp)
3193  0812               LC004:
3194  0812 6b02          	ld	(OFST-5,sp),a
3198  0814               L5211:
3199                     ; 524 	set_rgb(index,0,red);
3201  0814 7b02          	ld	a,(OFST-5,sp)
3202  0816 88            	push	a
3203  0817 7b09          	ld	a,(OFST+2,sp)
3204  0819 5f            	clrw	x
3205  081a 95            	ld	xh,a
3206  081b ad1b          	call	_set_rgb
3208  081d 84            	pop	a
3209                     ; 525 	set_rgb(index,1,green);
3211  081e 7b03          	ld	a,(OFST-4,sp)
3212  0820 88            	push	a
3213  0821 7b09          	ld	a,(OFST+2,sp)
3214  0823 ae0001        	ldw	x,#1
3215  0826 95            	ld	xh,a
3216  0827 ad0f          	call	_set_rgb
3218  0829 84            	pop	a
3219                     ; 526 	set_rgb(index,2,blue);
3221  082a 7b04          	ld	a,(OFST-3,sp)
3222  082c 88            	push	a
3223  082d 7b09          	ld	a,(OFST+2,sp)
3224  082f ae0002        	ldw	x,#2
3225  0832 95            	ld	xh,a
3226  0833 ad03          	call	_set_rgb
3228  0835 5b09          	addw	sp,#9
3229                     ; 527 }
3232  0837 81            	ret	
3279                     ; 531 void set_rgb(u8 index,u8 color,u8 brightness)
3279                     ; 532 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
3280                     	switch	.text
3281  0838               _set_rgb:
3283  0838 89            	pushw	x
3284       00000000      OFST:	set	0
3289  0839 a606          	ld	a,#6
3290  083b 42            	mul	x,a
3291  083c 01            	rrwa	x,a
3292  083d 1b01          	add	a,(OFST+1,sp)
3293  083f 2401          	jrnc	L473
3294  0841 5c            	incw	x
3295  0842               L473:
3296  0842 02            	rlwa	x,a
3297  0843 7b05          	ld	a,(OFST+5,sp)
3298  0845 d70012        	ld	(_pwm_brightness_buffer,x),a
3302  0848 85            	popw	x
3303  0849 81            	ret	
3343                     ; 533 void set_white(u8 index,u8 brightness)
3343                     ; 534 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
3344                     	switch	.text
3345  084a               _set_white:
3347  084a 89            	pushw	x
3348       00000000      OFST:	set	0
3353  084b 9e            	ld	a,xh
3354  084c 5f            	clrw	x
3355  084d 97            	ld	xl,a
3356  084e 7b02          	ld	a,(OFST+2,sp)
3357  0850 d70025        	ld	(_pwm_brightness_buffer+19,x),a
3361  0853 85            	popw	x
3362  0854 81            	ret	
3395                     ; 535 void set_debug(u8 brightness)
3395                     ; 536 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
3396                     	switch	.text
3397  0855               _set_debug:
3403  0855 c70024        	ld	_pwm_brightness_buffer+18,a
3407  0858 81            	ret	
3599                     	xdef	f_I2C_EventHandler
3600                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3601                     	xdef	_i2c_transaction_byte_count
3602                     	xdef	_developer_flag
3603                     	xdef	_is_developer_debug
3604                     	switch	.bss
3605  0003               _this_addr:
3606  0003 00            	ds.b	1
3607                     	xdef	_this_addr
3608  0004               _MessageBegin:
3609  0004 00            	ds.b	1
3610                     	xdef	_MessageBegin
3611  0005               _u8_MyBuffp:
3612  0005 0000          	ds.b	2
3613                     	xdef	_u8_MyBuffp
3614  0007               _u8_My_Buffer:
3615  0007 000000000000  	ds.b	7
3616                     	xdef	_u8_My_Buffer
3617  000e               _button_pressed_event:
3618  000e 00000000      	ds.b	4
3619                     	xdef	_button_pressed_event
3620                     	xdef	_is_right_button_down
3621                     	xdef	_button_start_ms
3622                     	xdef	_is_valid_i2c_received
3623                     	xdef	_pwm_state
3624                     	xdef	_pwm_visible_index
3625                     	xdef	_pwm_led_count
3626                     	xdef	_pwm_sleep
3627  0012               _pwm_brightness_buffer:
3628  0012 000000000000  	ds.b	31
3629                     	xdef	_pwm_brightness_buffer
3630  0031               _pwm_brightness_index:
3631  0031 000000000000  	ds.b	62
3632                     	xdef	_pwm_brightness_index
3633                     	xdef	_pwm_brightness
3634                     	xdef	_atomic_counter
3635                     	xref	_GPIO_ReadInputPin
3636                     	xref	_GPIO_Init
3637                     	xref	_I2C_ITConfig
3638                     	xref	_I2C_Cmd
3639                     	xref	_I2C_Init
3640                     	xref	_I2C_DeInit
3641                     	xdef	_update_developer_gpio
3642                     	xdef	_set_developer_flag
3643                     	xdef	_get_developer_flag
3644                     	xdef	_is_application
3645                     	xdef	_I2C_byte_write
3646                     	xdef	_I2C_byte_received
3647                     	xdef	_I2C_transaction_end
3648                     	xdef	_I2C_transaction_begin
3649                     	xdef	_set_led_on
3650                     	xdef	_set_mat
3651                     	xdef	_get_random
3652                     	xdef	_is_button_down
3653                     	xdef	_get_button_event
3654                     	xdef	_update_buttons
3655                     	xdef	_set_hue_max
3656                     	xdef	_flush_leds
3657                     	xdef	_set_debug
3658                     	xdef	_set_white
3659                     	xdef	_set_rgb
3660                     	xdef	_millis
3661                     	xdef	_setup_main
3662                     	xdef	_hello_world
3663                     	xref.b	c_lreg
3664                     	xref.b	c_x
3665                     	xref.b	c_y
3685                     	xref	c_xymov
3686                     	xref	c_lgadd
3687                     	xref	c_uitolx
3688                     	xref	c_lcmp
3689                     	xref	c_rtol
3690                     	xref	c_lsub
3691                     	xref	c_lzmp
3692                     	xref	c_lursh
3693                     	xref	c_ltor
3694                     	xref	c_imul
3695                     	end
