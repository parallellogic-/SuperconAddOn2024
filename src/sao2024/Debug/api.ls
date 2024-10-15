   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  19                     	bsct
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
  36  0088               _button_start_ms:
  37  0088 00000000      	dc.l	0
  38  008c               _is_right_button_down:
  39  008c 00            	dc.b	0
 101                     ; 28 void hello_world()
 101                     ; 29 {//basic program that blinks the debug LED ON/OFF
 103                     	switch	.text
 104  0000               _hello_world:
 106  0000 5204          	subw	sp,#4
 107       00000004      OFST:	set	4
 110                     ; 30 	const u8 cycle_speed=8;//larger=faster
 112  0002 a608          	ld	a,#8
 113  0004 6b02          	ld	(OFST-2,sp),a
 115                     ; 31 	const u8 white_speed=5;//smaller=faster
 117  0006 a605          	ld	a,#5
 118  0008 6b01          	ld	(OFST-3,sp),a
 120                     ; 33 	while(0)
 123  000a 5f            	clrw	x
 125  000b               L73:
 126                     ; 41 		frame++;
 128  000b 5c            	incw	x
 129  000c 1f03          	ldw	(OFST-1,sp),x
 131                     ; 42 		set_hue_max(0,(frame<<cycle_speed));
 133  000e 7b02          	ld	a,(OFST-2,sp)
 134  0010 2704          	jreq	L01
 135  0012               L21:
 136  0012 58            	sllw	x
 137  0013 4a            	dec	a
 138  0014 26fc          	jrne	L21
 139  0016               L01:
 140  0016 89            	pushw	x
 141  0017 4f            	clr	a
 142  0018 cd0604        	call	_set_hue_max
 144  001b 85            	popw	x
 145                     ; 43 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
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
 158  002c cd0604        	call	_set_hue_max
 160  002f 85            	popw	x
 161                     ; 44 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
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
 174  0040 cd0604        	call	_set_hue_max
 176  0043 85            	popw	x
 177                     ; 45 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
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
 190  0054 cd0604        	call	_set_hue_max
 192  0057 85            	popw	x
 193                     ; 46 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
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
 206  0068 cd0604        	call	_set_hue_max
 208  006b 85            	popw	x
 209                     ; 47 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
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
 222  007c cd0604        	call	_set_hue_max
 224  007f 85            	popw	x
 225                     ; 50 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
 227  0080 1e03          	ldw	x,(OFST-1,sp)
 228  0082 7b01          	ld	a,(OFST-3,sp)
 229  0084 2704          	jreq	L65
 230  0086               L06:
 231  0086 54            	srlw	x
 232  0087 4a            	dec	a
 233  0088 26fc          	jrne	L06
 234  008a               L65:
 235  008a 01            	rrwa	x,a
 236  008b a501          	bcp	a,#1
 237  008d 2712          	jreq	L45
 238  008f a608          	ld	a,#8
 239  0091 1001          	sub	a,(OFST-3,sp)
 240  0093 5f            	clrw	x
 241  0094 97            	ld	xl,a
 242  0095 7b04          	ld	a,(OFST+0,sp)
 243  0097 5d            	tnzw	x
 244  0098 2704          	jreq	L26
 245  009a               L46:
 246  009a 48            	sll	a
 247  009b 5a            	decw	x
 248  009c 26fc          	jrne	L46
 249  009e               L26:
 250  009e 43            	cpl	a
 251  009f 200f          	jra	L07
 252  00a1               L45:
 253  00a1 a608          	ld	a,#8
 254  00a3 1001          	sub	a,(OFST-3,sp)
 255  00a5 5f            	clrw	x
 256  00a6 97            	ld	xl,a
 257  00a7 7b04          	ld	a,(OFST+0,sp)
 258  00a9 5d            	tnzw	x
 259  00aa 2704          	jreq	L07
 260  00ac               L27:
 261  00ac 48            	sll	a
 262  00ad 5a            	decw	x
 263  00ae 26fc          	jrne	L27
 264  00b0               L07:
 265  00b0 97            	ld	xl,a
 266  00b1 1603          	ldw	y,(OFST-1,sp)
 267  00b3 7b01          	ld	a,(OFST-3,sp)
 268  00b5 4c            	inc	a
 269  00b6 2705          	jreq	L47
 270  00b8               L67:
 271  00b8 9054          	srlw	y
 272  00ba 4a            	dec	a
 273  00bb 26fb          	jrne	L67
 274  00bd               L47:
 275  00bd a60c          	ld	a,#12
 276  00bf 9062          	div	y,a
 277  00c1 95            	ld	xh,a
 278  00c2 cd06ae        	call	_set_white
 280                     ; 51 		flush_leds(7);
 282  00c5 a607          	ld	a,#7
 283  00c7 cd0510        	call	_flush_leds
 286  00ca 1e03          	ldw	x,(OFST-1,sp)
 287  00cc cc000b        	jra	L73
 339                     ; 55 u16 get_random(u16 x)
 339                     ; 56 {
 340                     	switch	.text
 341  00cf               _get_random:
 343       00000004      OFST:	set	4
 346                     ; 57 	u16 a=1664525;
 348                     ; 58 	u16 c=1013904223;
 350                     ; 59 	return a * x + c;
 352  00cf 90ae660d      	ldw	y,#26125
 353  00d3 cd0000        	call	c_imul
 355  00d6 1cf35f        	addw	x,#62303
 358  00d9 81            	ret	
 427                     .const:	section	.text
 428  0000               L021:
 429  0000 0000e100      	dc.l	57600
 430                     ; 62 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 430                     ; 63 {
 431                     	switch	.text
 432  00da               _setup_serial:
 434  00da 89            	pushw	x
 435       00000000      OFST:	set	0
 438                     ; 64 	if(is_enabled)
 440  00db 9e            	ld	a,xh
 441  00dc 4d            	tnz	a
 442  00dd 273e          	jreq	L321
 443                     ; 66 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 445  00df 4bf0          	push	#240
 446  00e1 4b20          	push	#32
 447  00e3 ae500f        	ldw	x,#20495
 448  00e6 cd0000        	call	_GPIO_Init
 450  00e9 85            	popw	x
 451                     ; 67 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 453  00ea ad46          	call	LC001
 454                     ; 68 		UART1_DeInit();
 456  00ec cd0000        	call	_UART1_DeInit
 458                     ; 69 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 460  00ef 4b0c          	push	#12
 461  00f1 4b80          	push	#128
 462  00f3 4b00          	push	#0
 463  00f5 4b00          	push	#0
 464  00f7 4b00          	push	#0
 465  00f9 7b07          	ld	a,(OFST+7,sp)
 466  00fb 2708          	jreq	L611
 467  00fd ae0000        	ldw	x,#L021
 468  0100 cd0000        	call	c_ltor
 470  0103 2006          	jra	L221
 471  0105               L611:
 472  0105 ae2580        	ldw	x,#9600
 473  0108 cd0000        	call	c_itolx
 475  010b               L221:
 476  010b be02          	ldw	x,c_lreg+2
 477  010d 89            	pushw	x
 478  010e be00          	ldw	x,c_lreg
 479  0110 89            	pushw	x
 480  0111 cd0000        	call	_UART1_Init
 482  0114 5b09          	addw	sp,#9
 483                     ; 70 		UART1_Cmd(ENABLE);
 485  0116 a601          	ld	a,#1
 486  0118 cd0000        	call	_UART1_Cmd
 489  011b 2013          	jra	L521
 490  011d               L321:
 491                     ; 72 		UART1_Cmd(DISABLE);
 493  011d cd0000        	call	_UART1_Cmd
 495                     ; 73 		UART1_DeInit();
 497  0120 cd0000        	call	_UART1_DeInit
 499                     ; 74 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 501  0123 4b40          	push	#64
 502  0125 4b20          	push	#32
 503  0127 ae500f        	ldw	x,#20495
 504  012a cd0000        	call	_GPIO_Init
 506  012d 85            	popw	x
 507                     ; 75 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 509  012e ad02          	call	LC001
 510  0130               L521:
 511                     ; 77 }
 514  0130 85            	popw	x
 515  0131 81            	ret	
 516  0132               LC001:
 517  0132 4b40          	push	#64
 518  0134 4b40          	push	#64
 519  0136 ae500f        	ldw	x,#20495
 520  0139 cd0000        	call	_GPIO_Init
 522  013c 85            	popw	x
 523  013d 81            	ret	
 553                     ; 79 void setup_main()
 553                     ; 80 {
 554                     	switch	.text
 555  013e               _setup_main:
 559                     ; 81 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 561  013e c650c6        	ld	a,20678
 562  0141 a4e7          	and	a,#231
 563  0143 c750c6        	ld	20678,a
 564                     ; 90 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 566  0146 3505530e      	mov	21262,#5
 567                     ; 91 	TIM2->ARRH= 0;// init auto reload register
 569  014a 725f530f      	clr	21263
 570                     ; 92 	TIM2->ARRL= 255;// init auto reload register
 572  014e 35ff5310      	mov	21264,#255
 573                     ; 94 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 575  0152 c65300        	ld	a,21248
 576  0155 aa05          	or	a,#5
 577  0157 c75300        	ld	21248,a
 578                     ; 96 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 580  015a 35015303      	mov	21251,#1
 581                     ; 98 	setup_serial(0,0);//disable UART
 583  015e 5f            	clrw	x
 584  015f cd00da        	call	_setup_serial
 586                     ; 101 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 588  0162 4b40          	push	#64
 589  0164 4b08          	push	#8
 590  0166 ae500f        	ldw	x,#20495
 591  0169 cd0000        	call	_GPIO_Init
 593  016c 85            	popw	x
 594                     ; 102 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
 596  016d 4b40          	push	#64
 597  016f 4b10          	push	#16
 598  0171 ae500f        	ldw	x,#20495
 599  0174 cd0000        	call	_GPIO_Init
 601  0177 85            	popw	x
 602                     ; 105 	I2C_DeInit();
 604  0178 cd0000        	call	_I2C_DeInit
 606                     ; 106 	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
 608  017b 4b10          	push	#16
 609  017d 4b00          	push	#0
 610  017f 4b01          	push	#1
 611  0181 4b00          	push	#0
 612  0183 ae0060        	ldw	x,#96
 613  0186 89            	pushw	x
 614  0187 ae86a0        	ldw	x,#34464
 615  018a 89            	pushw	x
 616  018b ae0001        	ldw	x,#1
 617  018e 89            	pushw	x
 618  018f cd0000        	call	_I2C_Init
 620  0192 5b0a          	addw	sp,#10
 621                     ; 107 	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
 623  0194 ae0701        	ldw	x,#1793
 624  0197 cd0000        	call	_I2C_ITConfig
 626                     ; 108 	I2C_Cmd(ENABLE);
 628  019a a601          	ld	a,#1
 629  019c cd0000        	call	_I2C_Cmd
 631                     ; 109 	enableInterrupts();  // Enable global interrupts
 634  019f 9a            	rim	
 636                     ; 110 }
 640  01a0 81            	ret	
 664                     ; 112 u32 millis()
 664                     ; 113 {
 665                     	switch	.text
 666  01a1               _millis:
 670                     ; 114 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 672  01a1 ae0000        	ldw	x,#_atomic_counter
 673  01a4 cd0000        	call	c_ltor
 675  01a7 a609          	ld	a,#9
 679  01a9 cc0000        	jp	c_lursh
 728                     	switch	.const
 729  0004               L071:
 730  0004 00000201      	dc.l	513
 731  0008               L271:
 732  0008 00000033      	dc.l	51
 733                     ; 119 void update_buttons()
 733                     ; 120 {
 734                     	switch	.text
 735  01ac               _update_buttons:
 737  01ac 5205          	subw	sp,#5
 738       00000005      OFST:	set	5
 741                     ; 123 	if(button_start_ms)
 743  01ae ae0088        	ldw	x,#_button_start_ms
 744  01b1 cd0000        	call	c_lzmp
 746  01b4 274f          	jreq	L171
 747                     ; 125 		set_debug(255);
 749  01b6 a6ff          	ld	a,#255
 750  01b8 cd06b8        	call	_set_debug
 752                     ; 126 		if(!is_button_down(is_right_button_down))
 754  01bb b68c          	ld	a,_is_right_button_down
 755  01bd cd027d        	call	_is_button_down
 757  01c0 4d            	tnz	a
 758  01c1 2669          	jrne	L302
 759                     ; 128 			elapsed_pressed_ms=millis()-button_start_ms;
 761  01c3 addc          	call	_millis
 763  01c5 ae0088        	ldw	x,#_button_start_ms
 764  01c8 cd0000        	call	c_lsub
 766  01cb 96            	ldw	x,sp
 767  01cc 5c            	incw	x
 768  01cd cd0000        	call	c_rtol
 771                     ; 129 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 773  01d0 96            	ldw	x,sp
 774  01d1 5c            	incw	x
 775  01d2 cd0000        	call	c_ltor
 777  01d5 ae0004        	ldw	x,#L071
 778  01d8 cd0000        	call	c_lcmp
 780  01db 250b          	jrult	L571
 783  01dd b68c          	ld	a,_is_right_button_down
 784  01df 5f            	clrw	x
 785  01e0 97            	ld	xl,a
 786  01e1 58            	sllw	x
 787  01e2 a601          	ld	a,#1
 788  01e4 e708          	ld	(_button_pressed_event+1,x),a
 790  01e6 2016          	jra	L771
 791  01e8               L571:
 792                     ; 130 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 794  01e8 96            	ldw	x,sp
 795  01e9 5c            	incw	x
 796  01ea cd0000        	call	c_ltor
 798  01ed ae0008        	ldw	x,#L271
 799  01f0 cd0000        	call	c_lcmp
 801  01f3 2509          	jrult	L771
 804  01f5 b68c          	ld	a,_is_right_button_down
 805  01f7 5f            	clrw	x
 806  01f8 97            	ld	xl,a
 807  01f9 58            	sllw	x
 808  01fa a601          	ld	a,#1
 809  01fc e707          	ld	(_button_pressed_event,x),a
 810  01fe               L771:
 811                     ; 131 			button_start_ms=0;
 813  01fe 5f            	clrw	x
 814  01ff bf8a          	ldw	_button_start_ms+2,x
 815  0201 bf88          	ldw	_button_start_ms,x
 816  0203 2027          	jra	L302
 817  0205               L171:
 818                     ; 134 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 820  0205 0f05          	clr	(OFST+0,sp)
 823  0207 2015          	jra	L112
 824  0209               L502:
 825                     ; 136 			if(is_button_down(button_index))
 827  0209 7b05          	ld	a,(OFST+0,sp)
 828  020b ad70          	call	_is_button_down
 830  020d 4d            	tnz	a
 831  020e 270c          	jreq	L512
 832                     ; 138 				is_right_button_down=button_index;
 834  0210 7b05          	ld	a,(OFST+0,sp)
 835  0212 b78c          	ld	_is_right_button_down,a
 836                     ; 139 				button_start_ms=millis();
 838  0214 ad8b          	call	_millis
 840  0216 ae0088        	ldw	x,#_button_start_ms
 841  0219 cd0000        	call	c_rtol
 843  021c               L512:
 844                     ; 134 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 846  021c 0c05          	inc	(OFST+0,sp)
 848  021e               L112:
 851  021e 7b05          	ld	a,(OFST+0,sp)
 852  0220 a102          	cp	a,#2
 853  0222 2408          	jruge	L302
 855  0224 ae0088        	ldw	x,#_button_start_ms
 856  0227 cd0000        	call	c_lzmp
 858  022a 27dd          	jreq	L502
 859  022c               L302:
 860                     ; 143 }
 863  022c 5b05          	addw	sp,#5
 864  022e 81            	ret	
 938                     ; 148 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 938                     ; 149 {
 939                     	switch	.text
 940  022f               _get_button_event:
 942  022f 89            	pushw	x
 943  0230 89            	pushw	x
 944       00000002      OFST:	set	2
 947                     ; 151 	bool out=0;
 949  0231 0f01          	clr	(OFST-1,sp)
 951                     ; 152 	for(iter=0;iter<BUTTON_COUNT;iter++)
 953  0233 0f02          	clr	(OFST+0,sp)
 955  0235               L752:
 956                     ; 154 		if(button_index==iter || button_index==0xFF)
 958  0235 7b03          	ld	a,(OFST+1,sp)
 959  0237 1102          	cp	a,(OFST+0,sp)
 960  0239 2703          	jreq	L762
 962  023b 4c            	inc	a
 963  023c 2632          	jrne	L562
 964  023e               L762:
 965                     ; 156 			if(is_long==0 || is_long==0xFF)
 967  023e 7b04          	ld	a,(OFST+2,sp)
 968  0240 2703          	jreq	L372
 970  0242 4c            	inc	a
 971  0243 2611          	jrne	L172
 972  0245               L372:
 973                     ; 158 				out|=button_pressed_event[iter][0];
 975  0245 7b02          	ld	a,(OFST+0,sp)
 976  0247 5f            	clrw	x
 977  0248 97            	ld	xl,a
 978  0249 58            	sllw	x
 979  024a 7b01          	ld	a,(OFST-1,sp)
 980  024c ea07          	or	a,(_button_pressed_event,x)
 981  024e 6b01          	ld	(OFST-1,sp),a
 983                     ; 159 				if(is_clear) button_pressed_event[iter][0]=0;
 985  0250 7b07          	ld	a,(OFST+5,sp)
 986  0252 2702          	jreq	L172
 989  0254 6f07          	clr	(_button_pressed_event,x)
 990  0256               L172:
 991                     ; 161 			if(is_long==1 || is_long==0xFF)
 993  0256 7b04          	ld	a,(OFST+2,sp)
 994  0258 a101          	cp	a,#1
 995  025a 2703          	jreq	L103
 997  025c 4c            	inc	a
 998  025d 2611          	jrne	L562
 999  025f               L103:
1000                     ; 163 				out|=button_pressed_event[iter][1];
1002  025f 7b02          	ld	a,(OFST+0,sp)
1003  0261 5f            	clrw	x
1004  0262 97            	ld	xl,a
1005  0263 58            	sllw	x
1006  0264 7b01          	ld	a,(OFST-1,sp)
1007  0266 ea08          	or	a,(_button_pressed_event+1,x)
1008  0268 6b01          	ld	(OFST-1,sp),a
1010                     ; 164 				if(is_clear) button_pressed_event[iter][1]=0;
1012  026a 7b07          	ld	a,(OFST+5,sp)
1013  026c 2702          	jreq	L562
1016  026e 6f08          	clr	(_button_pressed_event+1,x)
1017  0270               L562:
1018                     ; 152 	for(iter=0;iter<BUTTON_COUNT;iter++)
1020  0270 0c02          	inc	(OFST+0,sp)
1024  0272 7b02          	ld	a,(OFST+0,sp)
1025  0274 a102          	cp	a,#2
1026  0276 25bd          	jrult	L752
1027                     ; 168 	return out;
1029  0278 7b01          	ld	a,(OFST-1,sp)
1032  027a 5b04          	addw	sp,#4
1033  027c 81            	ret	
1069                     ; 172 bool is_button_down(u8 index)
1069                     ; 173 {
1070                     	switch	.text
1071  027d               _is_button_down:
1075                     ; 174 	switch(index)
1078                     ; 180 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1079  027d 4d            	tnz	a
1080  027e 2708          	jreq	L503
1081  0280 4a            	dec	a
1082  0281 2716          	jreq	L703
1083  0283 4a            	dec	a
1084  0284 2724          	jreq	L113
1085  0286 2033          	jra	L333
1086  0288               L503:
1087                     ; 176 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button //DEBUG_BROKEN
1089  0288 4b08          	push	#8
1090  028a ae500f        	ldw	x,#20495
1091  028d cd0000        	call	_GPIO_ReadInputPin
1093  0290 5b01          	addw	sp,#1
1094  0292 4d            	tnz	a
1095  0293 2602          	jrne	L402
1096  0295 4c            	inc	a
1098  0296 81            	ret	
1099  0297               L402:
1100  0297 4f            	clr	a
1103  0298 81            	ret	
1104  0299               L703:
1105                     ; 177 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
1108  0299 4b10          	push	#16
1109  029b ae500f        	ldw	x,#20495
1110  029e cd0000        	call	_GPIO_ReadInputPin
1112  02a1 5b01          	addw	sp,#1
1113  02a3 4d            	tnz	a
1114  02a4 2602          	jrne	L212
1115  02a6 4c            	inc	a
1117  02a7 81            	ret	
1118  02a8               L212:
1119  02a8 4f            	clr	a
1122  02a9 81            	ret	
1123  02aa               L113:
1124                     ; 180 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1127  02aa 4b02          	push	#2
1128  02ac ae500f        	ldw	x,#20495
1129  02af cd0000        	call	_GPIO_ReadInputPin
1131  02b2 5b01          	addw	sp,#1
1132  02b4 4d            	tnz	a
1133  02b5 2602          	jrne	L022
1134  02b7 4c            	inc	a
1136  02b8 81            	ret	
1137  02b9               L022:
1138  02b9 4f            	clr	a
1141  02ba 81            	ret	
1142  02bb               L333:
1143                     ; 182 	return 0;
1145  02bb 4f            	clr	a
1148  02bc 81            	ret	
1173                     ; 196 	void I2C_transaction_begin(void)
1173                     ; 197 	{
1174                     	switch	.text
1175  02bd               _I2C_transaction_begin:
1179                     ; 198 		MessageBegin = TRUE;
1181  02bd 35010003      	mov	_MessageBegin,#1
1182                     ; 199 	}
1185  02c1 81            	ret	
1209                     ; 200 	void I2C_transaction_end(void)
1209                     ; 201 	{
1210                     	switch	.text
1211  02c2               _I2C_transaction_end:
1215                     ; 203 	}
1218  02c2 81            	ret	
1255                     ; 204 	void I2C_byte_received(u8 u8_RxData)
1255                     ; 205 	{
1256                     	switch	.text
1257  02c3               _I2C_byte_received:
1259  02c3 88            	push	a
1260       00000000      OFST:	set	0
1263                     ; 206 		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
1265  02c4 b603          	ld	a,_MessageBegin
1266  02c6 4a            	dec	a
1267  02c7 260e          	jrne	L373
1269  02c9 7b01          	ld	a,(OFST+1,sp)
1270  02cb 260a          	jrne	L373
1271                     ; 207 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
1273  02cd ab06          	add	a,#_u8_My_Buffer
1274  02cf 5f            	clrw	x
1275  02d0 97            	ld	xl,a
1276  02d1 bf04          	ldw	_u8_MyBuffp,x
1277                     ; 208 			MessageBegin = FALSE;
1279  02d3 3f03          	clr	_MessageBegin
1281  02d5 200d          	jra	L573
1282  02d7               L373:
1283                     ; 210     else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
1285  02d7 be04          	ldw	x,_u8_MyBuffp
1286  02d9 a30007        	cpw	x,#_u8_My_Buffer+1
1287  02dc 2406          	jruge	L573
1288                     ; 211       *(u8_MyBuffp++) = u8_RxData;
1290  02de 7b01          	ld	a,(OFST+1,sp)
1291  02e0 f7            	ld	(x),a
1292  02e1 5c            	incw	x
1293  02e2 bf04          	ldw	_u8_MyBuffp,x
1294  02e4               L573:
1295                     ; 212 	}
1298  02e4 84            	pop	a
1299  02e5 81            	ret	
1324                     ; 213 	u8 I2C_byte_write(void)
1324                     ; 214 	{
1325                     	switch	.text
1326  02e6               _I2C_byte_write:
1330                     ; 215 		return 0xDE;
1332  02e6 a6de          	ld	a,#222
1335  02e8 81            	ret	
1389                     ; 223 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1391                     	switch	.text
1392  02e9               f_TIM2_UPD_OVF_IRQHandler:
1394  02e9 8a            	push	cc
1395  02ea 84            	pop	a
1396  02eb a4bf          	and	a,#191
1397  02ed 88            	push	a
1398  02ee 86            	pop	cc
1399       00000005      OFST:	set	5
1400  02ef 3b0002        	push	c_x+2
1401  02f2 be00          	ldw	x,c_x
1402  02f4 89            	pushw	x
1403  02f5 3b0002        	push	c_y+2
1404  02f8 be00          	ldw	x,c_y
1405  02fa 89            	pushw	x
1406  02fb be02          	ldw	x,c_lreg+2
1407  02fd 89            	pushw	x
1408  02fe be00          	ldw	x,c_lreg
1409  0300 89            	pushw	x
1410  0301 5205          	subw	sp,#5
1413                     ; 224 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1415  0303 b687          	ld	a,_pwm_state
1416  0305 a401          	and	a,#1
1417  0307 6b05          	ld	(OFST+0,sp),a
1419                     ; 225 	u16 sleep_counts=1;
1421  0309 ae0001        	ldw	x,#1
1422  030c 1f03          	ldw	(OFST-2,sp),x
1424                     ; 227 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1426  030e c6500c        	ld	a,20492
1427  0311 a407          	and	a,#7
1428  0313 c7500c        	ld	20492,a
1429                     ; 228 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1431  0316 72155011      	bres	20497,#2
1432                     ; 229 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1434  031a 72175002      	bres	20482,#3
1435                     ; 230 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1437  031e c6500d        	ld	a,20493
1438  0321 a407          	and	a,#7
1439  0323 c7500d        	ld	20493,a
1440                     ; 231 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1442  0326 72155012      	bres	20498,#2
1443                     ; 232 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1445  032a 72175003      	bres	20483,#3
1446                     ; 237   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1448  032e 72115300      	bres	21248,#0
1449                     ; 238 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1451  0332 7b05          	ld	a,(OFST+0,sp)
1452  0334 8dc803c8      	callf	LC002
1453  0338 2609          	jrne	L334
1454                     ; 240 		sleep_counts=pwm_sleep[buffer_index];
1456  033a 7b05          	ld	a,(OFST+0,sp)
1457  033c 5f            	clrw	x
1458  033d 97            	ld	xl,a
1459  033e 58            	sllw	x
1460  033f ee80          	ldw	x,(_pwm_sleep,x)
1461  0341 1f03          	ldw	(OFST-2,sp),x
1463  0343               L334:
1464                     ; 242 	if(pwm_visible_index>pwm_led_count[buffer_index])
1466  0343 7b05          	ld	a,(OFST+0,sp)
1467  0345 8dc803c8      	callf	LC002
1468  0349 2414          	jruge	L534
1469                     ; 244 		pwm_visible_index=0;//formally start new frame
1471  034b 3f86          	clr	_pwm_visible_index
1472                     ; 245 		update_buttons();
1474  034d cd01ac        	call	_update_buttons
1476                     ; 246 		if(pwm_state&0x02)
1478  0350 720300870a    	btjf	_pwm_state,#1,L534
1479                     ; 248 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1481  0355 b687          	ld	a,_pwm_state
1482  0357 a803          	xor	a,#3
1483  0359 b787          	ld	_pwm_state,a
1484                     ; 249 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1486  035b a401          	and	a,#1
1487  035d 6b05          	ld	(OFST+0,sp),a
1489  035f               L534:
1490                     ; 252 	if(pwm_visible_index<pwm_led_count[buffer_index])
1492  035f 7b05          	ld	a,(OFST+0,sp)
1493  0361 8dc803c8      	callf	LC002
1494  0365 2325          	jrule	L144
1495                     ; 254 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1497  0367 7b05          	ld	a,(OFST+0,sp)
1498  0369 5f            	clrw	x
1499  036a 97            	ld	xl,a
1500  036b 58            	sllw	x
1501  036c 1f01          	ldw	(OFST-4,sp),x
1503  036e b686          	ld	a,_pwm_visible_index
1504  0370 97            	ld	xl,a
1505  0371 a604          	ld	a,#4
1506  0373 42            	mul	x,a
1507  0374 72fb01        	addw	x,(OFST-4,sp)
1508  0377 ee04          	ldw	x,(_pwm_brightness,x)
1509  0379 1f03          	ldw	(OFST-2,sp),x
1511                     ; 255 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1513  037b 5f            	clrw	x
1514  037c b686          	ld	a,_pwm_visible_index
1515  037e 97            	ld	xl,a
1516  037f 58            	sllw	x
1517  0380 01            	rrwa	x,a
1518  0381 1b05          	add	a,(OFST+0,sp)
1519  0383 2401          	jrnc	L442
1520  0385 5c            	incw	x
1521  0386               L442:
1522  0386 02            	rlwa	x,a
1523  0387 e62a          	ld	a,(_pwm_brightness_index,x)
1524  0389 cd0461        	call	_set_led_on
1526  038c               L144:
1527                     ; 257 	pwm_visible_index++;
1529  038c 3c86          	inc	_pwm_visible_index
1530                     ; 258 	atomic_counter+=sleep_counts;
1532  038e 1e03          	ldw	x,(OFST-2,sp)
1533  0390 cd0000        	call	c_uitolx
1535  0393 ae0000        	ldw	x,#_atomic_counter
1536  0396 cd0000        	call	c_lgadd
1538                     ; 260   TIM2->CNTRH = 0;// Set the high byte of the counter
1540  0399 725f530c      	clr	21260
1541                     ; 261   TIM2->CNTRL = 0;// Set the low byte of the counter
1543  039d 725f530d      	clr	21261
1544                     ; 262 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1546  03a1 7b03          	ld	a,(OFST-2,sp)
1547  03a3 c7530f        	ld	21263,a
1548                     ; 263 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1550  03a6 7b04          	ld	a,(OFST-1,sp)
1551  03a8 c75310        	ld	21264,a
1552                     ; 265 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1554  03ab 72115304      	bres	21252,#0
1555                     ; 266   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1557  03af 72105300      	bset	21248,#0
1558                     ; 267 }
1561  03b3 5b05          	addw	sp,#5
1562  03b5 85            	popw	x
1563  03b6 bf00          	ldw	c_lreg,x
1564  03b8 85            	popw	x
1565  03b9 bf02          	ldw	c_lreg+2,x
1566  03bb 85            	popw	x
1567  03bc bf00          	ldw	c_y,x
1568  03be 320002        	pop	c_y+2
1569  03c1 85            	popw	x
1570  03c2 bf00          	ldw	c_x,x
1571  03c4 320002        	pop	c_x+2
1572  03c7 80            	iret	
1573  03c8               LC002:
1574  03c8 5f            	clrw	x
1575  03c9 97            	ld	xl,a
1576  03ca e684          	ld	a,(_pwm_led_count,x)
1577  03cc b186          	cp	a,_pwm_visible_index
1578  03ce 87            	retf	
1580                     	switch	.ubsct
1581  0000               L344_sr1:
1582  0000 00            	ds.b	1
1583  0001               L544_sr2:
1584  0001 00            	ds.b	1
1585  0002               L744_sr3:
1586  0002 00            	ds.b	1
1640                     ; 269 @far @interrupt void I2C_EventHandler(void)
1640                     ; 270 {
1641                     	switch	.text
1642  03cf               f_I2C_EventHandler:
1644  03cf 8a            	push	cc
1645  03d0 84            	pop	a
1646  03d1 a4bf          	and	a,#191
1647  03d3 88            	push	a
1648  03d4 86            	pop	cc
1649  03d5 3b0002        	push	c_x+2
1650  03d8 be00          	ldw	x,c_x
1651  03da 89            	pushw	x
1652  03db 3b0002        	push	c_y+2
1653  03de be00          	ldw	x,c_y
1654  03e0 89            	pushw	x
1657                     ; 276 sr1 = I2C->SR1;
1659  03e1 5552170000    	mov	L344_sr1,21015
1660                     ; 277 sr2 = I2C->SR2;
1662  03e6 5552180001    	mov	L544_sr2,21016
1663                     ; 278 sr3 = I2C->SR3;
1665  03eb 5552190002    	mov	L744_sr3,21017
1666                     ; 281   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1668  03f0 b601          	ld	a,L544_sr2
1669  03f2 a52b          	bcp	a,#43
1670  03f4 2708          	jreq	L774
1671                     ; 283     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1673  03f6 72125211      	bset	21009,#1
1674                     ; 284     I2C->SR2= 0;					    // clear all error flags
1676  03fa 725f5218      	clr	21016
1677  03fe               L774:
1678                     ; 287   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1680  03fe b600          	ld	a,L344_sr1
1681  0400 a444          	and	a,#68
1682  0402 a144          	cp	a,#68
1683  0404 2606          	jrne	L105
1684                     ; 289     I2C_byte_received(I2C->DR);
1686  0406 c65216        	ld	a,21014
1687  0409 cd02c3        	call	_I2C_byte_received
1689  040c               L105:
1690                     ; 292   if (sr1 & I2C_SR1_RXNE)
1692  040c 720d000006    	btjf	L344_sr1,#6,L305
1693                     ; 294     I2C_byte_received(I2C->DR);
1695  0411 c65216        	ld	a,21014
1696  0414 cd02c3        	call	_I2C_byte_received
1698  0417               L305:
1699                     ; 297   if (sr2 & I2C_SR2_AF)
1701  0417 7205000107    	btjf	L544_sr2,#2,L505
1702                     ; 299     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1704  041c 72155218      	bres	21016,#2
1705                     ; 300 		I2C_transaction_end();
1707  0420 cd02c2        	call	_I2C_transaction_end
1709  0423               L505:
1710                     ; 303   if (sr1 & I2C_SR1_STOPF) 
1712  0423 7209000007    	btjf	L344_sr1,#4,L705
1713                     ; 305     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1715  0428 72145211      	bset	21009,#2
1716                     ; 306 		I2C_transaction_end();
1718  042c cd02c2        	call	_I2C_transaction_end
1720  042f               L705:
1721                     ; 309   if (sr1 & I2C_SR1_ADDR)
1723  042f 7203000003    	btjf	L344_sr1,#1,L115
1724                     ; 311 		I2C_transaction_begin();
1726  0434 cd02bd        	call	_I2C_transaction_begin
1728  0437               L115:
1729                     ; 314   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1731  0437 b600          	ld	a,L344_sr1
1732  0439 a484          	and	a,#132
1733  043b a184          	cp	a,#132
1734  043d 2606          	jrne	L315
1735                     ; 316 		I2C->DR = I2C_byte_write();
1737  043f cd02e6        	call	_I2C_byte_write
1739  0442 c75216        	ld	21014,a
1740  0445               L315:
1741                     ; 319   if (sr1 & I2C_SR1_TXE)
1743  0445 720f000006    	btjf	L344_sr1,#7,L515
1744                     ; 321 		I2C->DR = I2C_byte_write();
1746  044a cd02e6        	call	_I2C_byte_write
1748  044d c75216        	ld	21014,a
1749  0450               L515:
1750                     ; 323 	GPIOD->ODR^=1;
1752  0450 9010500f      	bcpl	20495,#0
1753                     ; 324 }
1756  0454 85            	popw	x
1757  0455 bf00          	ldw	c_y,x
1758  0457 320002        	pop	c_y+2
1759  045a 85            	popw	x
1760  045b bf00          	ldw	c_x,x
1761  045d 320002        	pop	c_x+2
1762  0460 80            	iret	
1764                     	switch	.const
1765  000c               L715_led_lookup:
1766  000c 00            	dc.b	0
1767  000d 03            	dc.b	3
1768  000e 01            	dc.b	1
1769  000f 03            	dc.b	3
1770  0010 02            	dc.b	2
1771  0011 03            	dc.b	3
1772  0012 03            	dc.b	3
1773  0013 00            	dc.b	0
1774  0014 04            	dc.b	4
1775  0015 00            	dc.b	0
1776  0016 05            	dc.b	5
1777  0017 00            	dc.b	0
1778  0018 00            	dc.b	0
1779  0019 04            	dc.b	4
1780  001a 01            	dc.b	1
1781  001b 04            	dc.b	4
1782  001c 02            	dc.b	2
1783  001d 04            	dc.b	4
1784  001e 03            	dc.b	3
1785  001f 01            	dc.b	1
1786  0020 04            	dc.b	4
1787  0021 01            	dc.b	1
1788  0022 05            	dc.b	5
1789  0023 01            	dc.b	1
1790  0024 00            	dc.b	0
1791  0025 05            	dc.b	5
1792  0026 01            	dc.b	1
1793  0027 05            	dc.b	5
1794  0028 02            	dc.b	2
1795  0029 05            	dc.b	5
1796  002a 03            	dc.b	3
1797  002b 02            	dc.b	2
1798  002c 04            	dc.b	4
1799  002d 02            	dc.b	2
1800  002e 05            	dc.b	5
1801  002f 02            	dc.b	2
1802  0030 06            	dc.b	6
1803  0031 06            	dc.b	6
1804  0032 01            	dc.b	1
1805  0033 00            	dc.b	0
1806  0034 02            	dc.b	2
1807  0035 00            	dc.b	0
1808  0036 00            	dc.b	0
1809  0037 01            	dc.b	1
1810  0038 02            	dc.b	2
1811  0039 01            	dc.b	1
1812  003a 00            	dc.b	0
1813  003b 02            	dc.b	2
1814  003c 01            	dc.b	1
1815  003d 02            	dc.b	2
1816  003e 04            	dc.b	4
1817  003f 03            	dc.b	3
1818  0040 05            	dc.b	5
1819  0041 03            	dc.b	3
1820  0042 03            	dc.b	3
1821  0043 04            	dc.b	4
1822  0044 05            	dc.b	5
1823  0045 04            	dc.b	4
1824  0046 03            	dc.b	3
1825  0047 05            	dc.b	5
1826  0048 04            	dc.b	4
1827  0049 05            	dc.b	5
1871                     ; 328 void set_led_on(u8 led_index)
1871                     ; 329 {
1873                     	switch	.text
1874  0461               _set_led_on:
1876  0461 88            	push	a
1877  0462 5240          	subw	sp,#64
1878       00000040      OFST:	set	64
1881                     ; 330 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1881                     ; 331 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1881                     ; 332 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1881                     ; 333 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1881                     ; 334 		{6,6},//debug; GND is tied low, no charlieplexing involved
1881                     ; 335 		{1,0},//LED7
1881                     ; 336 		{2,0},//LED8
1881                     ; 337 		{0,1},//LED9
1881                     ; 338 		{2,1},//LED10
1881                     ; 339 		{0,2},//LED11
1881                     ; 340 		{1,2},//LED12
1881                     ; 341 		{4,3},//LED13
1881                     ; 342 		{5,3},//LED14
1881                     ; 343 		{3,4},//LED15
1881                     ; 344 		{5,4},//LED16
1881                     ; 345 		{3,5},//LED17
1881                     ; 346 		{4,5} //LED18
1881                     ; 347 	};
1883  0464 96            	ldw	x,sp
1884  0465 1c0003        	addw	x,#OFST-61
1885  0468 90ae000c      	ldw	y,#L715_led_lookup
1886  046c a63e          	ld	a,#62
1887  046e cd0000        	call	c_xymov
1889                     ; 384 	set_mat(led_lookup[led_index][0],1);
1891  0471 96            	ldw	x,sp
1892  0472 1c0003        	addw	x,#OFST-61
1893  0475 1f01          	ldw	(OFST-63,sp),x
1895  0477 5f            	clrw	x
1896  0478 7b41          	ld	a,(OFST+1,sp)
1897  047a 97            	ld	xl,a
1898  047b 58            	sllw	x
1899  047c 72fb01        	addw	x,(OFST-63,sp)
1900  047f f6            	ld	a,(x)
1901  0480 ae0001        	ldw	x,#1
1902  0483 95            	ld	xh,a
1903  0484 ad1a          	call	_set_mat
1905                     ; 386 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1907  0486 7b41          	ld	a,(OFST+1,sp)
1908  0488 a112          	cp	a,#18
1909  048a 2711          	jreq	L345
1912  048c 96            	ldw	x,sp
1913  048d 1c0004        	addw	x,#OFST-60
1914  0490 1f01          	ldw	(OFST-63,sp),x
1916  0492 5f            	clrw	x
1917  0493 97            	ld	xl,a
1918  0494 58            	sllw	x
1919  0495 72fb01        	addw	x,(OFST-63,sp)
1920  0498 f6            	ld	a,(x)
1921  0499 5f            	clrw	x
1922  049a 95            	ld	xh,a
1923  049b ad03          	call	_set_mat
1925  049d               L345:
1926                     ; 388 }
1929  049d 5b41          	addw	sp,#65
1930  049f 81            	ret	
2131                     ; 393 void set_mat(u8 mat_index,bool is_high)
2131                     ; 394 {
2132                     	switch	.text
2133  04a0               _set_mat:
2135  04a0 89            	pushw	x
2136  04a1 5203          	subw	sp,#3
2137       00000003      OFST:	set	3
2140                     ; 397 	if(mat_index==0)
2142                     ; 399 		GPIOx=GPIOC;
2144                     ; 400 		GPIO_Pin=GPIO_PIN_3;
2146                     ; 402 	if(mat_index==1)
2148                     ; 404 		GPIOx=GPIOC;
2150                     ; 405 		GPIO_Pin=GPIO_PIN_4;
2152                     ; 407 	if(mat_index==2)
2154                     ; 409 		GPIOx=GPIOC;
2156                     ; 410 		GPIO_Pin=GPIO_PIN_5;
2158                     ; 412 	if(mat_index==3)
2160                     ; 414 		GPIOx=GPIOC;
2162                     ; 415 		GPIO_Pin=GPIO_PIN_6;
2164                     ; 417 	if(mat_index==4)
2166                     ; 419 		GPIOx=GPIOC;
2168                     ; 420 		GPIO_Pin=GPIO_PIN_7;
2170                     ; 422 	if(mat_index==5)
2172                     ; 424 		GPIOx=GPIOD;
2174                     ; 425 		GPIO_Pin=GPIO_PIN_2;
2176                     ; 427 	if(mat_index==6)
2178                     ; 429 		GPIOx=GPIOA;
2180                     ; 430 		GPIO_Pin=GPIO_PIN_3;
2182                     ; 432 	switch(mat_index)//DEBUG_BROKEN
2184  04a3 7b04          	ld	a,(OFST+1,sp)
2186                     ; 440 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
2187  04a5 2718          	jreq	L545
2188  04a7 4a            	dec	a
2189  04a8 271e          	jreq	L745
2190  04aa 4a            	dec	a
2191  04ab 2724          	jreq	L155
2192  04ad 4a            	dec	a
2193  04ae 272a          	jreq	L355
2194  04b0 4a            	dec	a
2195  04b1 2730          	jreq	L555
2196  04b3 4a            	dec	a
2197  04b4 2736          	jreq	L755
2200  04b6 ae5000        	ldw	x,#20480
2201  04b9 1f01          	ldw	(OFST-2,sp),x
2205  04bb a608          	ld	a,#8
2208  04bd 2034          	jra	L127
2209  04bf               L545:
2210                     ; 434 		case 0:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
2212  04bf ae500a        	ldw	x,#20490
2213  04c2 1f01          	ldw	(OFST-2,sp),x
2217  04c4 a608          	ld	a,#8
2220  04c6 202b          	jra	L127
2221  04c8               L745:
2222                     ; 435 		case 1:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
2224  04c8 ae500a        	ldw	x,#20490
2225  04cb 1f01          	ldw	(OFST-2,sp),x
2229  04cd a610          	ld	a,#16
2232  04cf 2022          	jra	L127
2233  04d1               L155:
2234                     ; 436 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
2236  04d1 ae500a        	ldw	x,#20490
2237  04d4 1f01          	ldw	(OFST-2,sp),x
2241  04d6 a620          	ld	a,#32
2244  04d8 2019          	jra	L127
2245  04da               L355:
2246                     ; 437 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
2248  04da ae500a        	ldw	x,#20490
2249  04dd 1f01          	ldw	(OFST-2,sp),x
2253  04df a640          	ld	a,#64
2256  04e1 2010          	jra	L127
2257  04e3               L555:
2258                     ; 438 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
2260  04e3 ae500a        	ldw	x,#20490
2261  04e6 1f01          	ldw	(OFST-2,sp),x
2265  04e8 a680          	ld	a,#128
2268  04ea 2007          	jra	L127
2269  04ec               L755:
2270                     ; 439 		case 5:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
2272  04ec ae500f        	ldw	x,#20495
2273  04ef 1f01          	ldw	(OFST-2,sp),x
2277  04f1 a604          	ld	a,#4
2280  04f3               L127:
2281  04f3 6b03          	ld	(OFST+0,sp),a
2283                     ; 453 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2285  04f5 0d05          	tnz	(OFST+2,sp)
2286  04f7 2705          	jreq	L327
2289  04f9 f6            	ld	a,(x)
2290  04fa 1a03          	or	a,(OFST+0,sp)
2292  04fc 2002          	jra	L527
2293  04fe               L327:
2294                     ; 454 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2296  04fe 43            	cpl	a
2297  04ff f4            	and	a,(x)
2298  0500               L527:
2299  0500 f7            	ld	(x),a
2300                     ; 455 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2302  0501 e602          	ld	a,(2,x)
2303  0503 1a03          	or	a,(OFST+0,sp)
2304  0505 e702          	ld	(2,x),a
2305                     ; 456 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2307  0507 e603          	ld	a,(3,x)
2308  0509 1a03          	or	a,(OFST+0,sp)
2309  050b e703          	ld	(3,x),a
2310                     ; 457 }
2313  050d 5b05          	addw	sp,#5
2314  050f 81            	ret	
2390                     ; 460 void flush_leds(u8 led_count)
2390                     ; 461 {
2391                     	switch	.text
2392  0510               _flush_leds:
2394  0510 88            	push	a
2395  0511 5207          	subw	sp,#7
2396       00000007      OFST:	set	7
2399                     ; 462 	u8 led_read_index=0,led_write_index=0;
2403  0513 0f05          	clr	(OFST-2,sp)
2406  0515               L177:
2407                     ; 465 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2409  0515 72020087fb    	btjt	_pwm_state,#1,L177
2410                     ; 466 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2412  051a b687          	ld	a,_pwm_state
2413  051c a401          	and	a,#1
2414  051e a801          	xor	a,#1
2415  0520 6b07          	ld	(OFST+0,sp),a
2417                     ; 468 	if(led_count==0) led_count=1;//min value
2419  0522 7b08          	ld	a,(OFST+1,sp)
2420  0524 2603          	jrne	L577
2423  0526 4c            	inc	a
2424  0527 6b08          	ld	(OFST+1,sp),a
2425  0529               L577:
2426                     ; 469 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2428  0529 97            	ld	xl,a
2429  052a 4f            	clr	a
2430  052b 02            	rlwa	x,a
2431  052c 58            	sllw	x
2432  052d 58            	sllw	x
2433  052e 7b07          	ld	a,(OFST+0,sp)
2434  0530 cd05fd        	call	LC003
2435                     ; 471 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2437  0533 4f            	clr	a
2438  0534 90ef80        	ldw	(_pwm_sleep,y),x
2439  0537 6b06          	ld	(OFST-1,sp),a
2441  0539               L777:
2442                     ; 473 		read_brightness=pwm_brightness_buffer[led_read_index];
2444  0539 5f            	clrw	x
2445  053a 97            	ld	xl,a
2446  053b e60b          	ld	a,(_pwm_brightness_buffer,x)
2447  053d 5f            	clrw	x
2448  053e 97            	ld	xl,a
2449  053f 1f03          	ldw	(OFST-4,sp),x
2451                     ; 474 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2453  0541 275e          	jreq	L5001
2454                     ; 476 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2456  0543 7b05          	ld	a,(OFST-2,sp)
2457  0545 5f            	clrw	x
2458  0546 97            	ld	xl,a
2459  0547 58            	sllw	x
2460  0548 01            	rrwa	x,a
2461  0549 1b07          	add	a,(OFST+0,sp)
2462  054b 2401          	jrnc	L003
2463  054d 5c            	incw	x
2464  054e               L003:
2465  054e 02            	rlwa	x,a
2466  054f 7b06          	ld	a,(OFST-1,sp)
2467  0551 e72a          	ld	(_pwm_brightness_index,x),a
2468                     ; 477 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2470  0553 1e03          	ldw	x,(OFST-4,sp)
2471  0555 9093          	ldw	y,x
2472  0557 cd0000        	call	c_imul
2474  055a a606          	ld	a,#6
2475  055c               L203:
2476  055c 54            	srlw	x
2477  055d 4a            	dec	a
2478  055e 26fc          	jrne	L203
2479  0560 5c            	incw	x
2480  0561 7b07          	ld	a,(OFST+0,sp)
2481  0563 cd05fd        	call	LC003
2482  0566 1701          	ldw	(OFST-6,sp),y
2484  0568 905f          	clrw	y
2485  056a 7b05          	ld	a,(OFST-2,sp)
2486  056c 9097          	ld	yl,a
2487  056e 9058          	sllw	y
2488  0570 9058          	sllw	y
2489  0572 72f901        	addw	y,(OFST-6,sp)
2490  0575 90ef04        	ldw	(_pwm_brightness,y),x
2491                     ; 478 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2493  0578 5f            	clrw	x
2494  0579 7b07          	ld	a,(OFST+0,sp)
2495  057b 97            	ld	xl,a
2496  057c 58            	sllw	x
2497  057d ad7e          	call	LC003
2498  057f 1701          	ldw	(OFST-6,sp),y
2500  0581 905f          	clrw	y
2501  0583 7b05          	ld	a,(OFST-2,sp)
2502  0585 9097          	ld	yl,a
2503  0587 9058          	sllw	y
2504  0589 9058          	sllw	y
2505  058b 72f901        	addw	y,(OFST-6,sp)
2506  058e 90ee04        	ldw	y,(_pwm_brightness,y)
2507  0591 9001          	rrwa	y,a
2508  0593 e081          	sub	a,(_pwm_sleep+1,x)
2509  0595 9001          	rrwa	y,a
2510  0597 e280          	sbc	a,(_pwm_sleep,x)
2511  0599 9001          	rrwa	y,a
2512  059b 9050          	negw	y
2513  059d ef80          	ldw	(_pwm_sleep,x),y
2514                     ; 479 			led_write_index++;
2516  059f 0c05          	inc	(OFST-2,sp)
2518  05a1               L5001:
2519                     ; 481 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2521  05a1 7b06          	ld	a,(OFST-1,sp)
2522  05a3 5f            	clrw	x
2523  05a4 97            	ld	xl,a
2524  05a5 6f0b          	clr	(_pwm_brightness_buffer,x)
2525                     ; 471 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2527  05a7 0c06          	inc	(OFST-1,sp)
2531  05a9 7b06          	ld	a,(OFST-1,sp)
2532  05ab a11f          	cp	a,#31
2533  05ad 258a          	jrult	L777
2534                     ; 483 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2536  05af 7b07          	ld	a,(OFST+0,sp)
2537  05b1 5f            	clrw	x
2538  05b2 97            	ld	xl,a
2539  05b3 58            	sllw	x
2540  05b4 9093          	ldw	y,x
2541  05b6 90ee80        	ldw	y,(_pwm_sleep,y)
2542  05b9 90a37c01      	cpw	y,#31745
2543  05bd 2406          	jruge	L1101
2545  05bf e681          	ld	a,(_pwm_sleep+1,x)
2546  05c1 ea80          	or	a,(_pwm_sleep,x)
2547  05c3 2606          	jrne	L7001
2548  05c5               L1101:
2551  05c5 90ae0001      	ldw	y,#1
2552  05c9 ef80          	ldw	(_pwm_sleep,x),y
2553  05cb               L7001:
2554                     ; 484 	if(led_write_index==0)
2556  05cb 7b05          	ld	a,(OFST-2,sp)
2557  05cd 261f          	jrne	L3101
2558                     ; 486 		led_write_index=1;
2560  05cf 4c            	inc	a
2561  05d0 6b05          	ld	(OFST-2,sp),a
2563                     ; 487 		pwm_sleep[buffer_index]=6<<10;
2565  05d2 5f            	clrw	x
2566  05d3 7b07          	ld	a,(OFST+0,sp)
2567  05d5 97            	ld	xl,a
2568  05d6 58            	sllw	x
2569  05d7 90ae1800      	ldw	y,#6144
2570  05db ef80          	ldw	(_pwm_sleep,x),y
2571                     ; 488 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2573  05dd 5f            	clrw	x
2574  05de 97            	ld	xl,a
2575  05df a612          	ld	a,#18
2576  05e1 e72a          	ld	(_pwm_brightness_index,x),a
2577                     ; 489 		pwm_brightness[0][buffer_index]=1;
2579  05e3 5f            	clrw	x
2580  05e4 7b07          	ld	a,(OFST+0,sp)
2581  05e6 97            	ld	xl,a
2582  05e7 58            	sllw	x
2583  05e8 90ae0001      	ldw	y,#1
2584  05ec ef04          	ldw	(_pwm_brightness,x),y
2585  05ee               L3101:
2586                     ; 491 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2588  05ee 7b07          	ld	a,(OFST+0,sp)
2589  05f0 5f            	clrw	x
2590  05f1 97            	ld	xl,a
2591  05f2 7b05          	ld	a,(OFST-2,sp)
2592  05f4 e784          	ld	(_pwm_led_count,x),a
2593                     ; 494 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2595  05f6 72120087      	bset	_pwm_state,#1
2596                     ; 495 }
2599  05fa 5b08          	addw	sp,#8
2600  05fc 81            	ret	
2601  05fd               LC003:
2602  05fd 905f          	clrw	y
2603  05ff 9097          	ld	yl,a
2604  0601 9058          	sllw	y
2605  0603 81            	ret	
2712                     ; 498 void set_hue_max(u8 index,u16 color)
2712                     ; 499 {
2713                     	switch	.text
2714  0604               _set_hue_max:
2716  0604 88            	push	a
2717  0605 5207          	subw	sp,#7
2718       00000007      OFST:	set	7
2721                     ; 502 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2723  0607 a6b4          	ld	a,#180
2724  0609 6b06          	ld	(OFST-1,sp),a
2726                     ; 503 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2728  060b a63d          	ld	a,#61
2729  060d 6b01          	ld	(OFST-6,sp),a
2731                     ; 504 	u8 red=0,green=0,blue=0;
2733  060f 0f02          	clr	(OFST-5,sp)
2737  0611 0f03          	clr	(OFST-4,sp)
2741  0613 0f04          	clr	(OFST-3,sp)
2743                     ; 505 	u8 residual=0;
2745  0615 0f07          	clr	(OFST+0,sp)
2747                     ; 507 	for(iter=0;iter<6;iter++)
2749  0617 0f05          	clr	(OFST-2,sp)
2751  0619               L7011:
2752                     ; 509 		if(color<0x2AAB)
2754  0619 1e0b          	ldw	x,(OFST+4,sp)
2755  061b a32aab        	cpw	x,#10923
2756  061e 2408          	jruge	L5111
2757                     ; 511 			residual=color/BRIGHTNESS_STEP;
2759  0620 7b01          	ld	a,(OFST-6,sp)
2760  0622 62            	div	x,a
2761  0623 01            	rrwa	x,a
2762  0624 6b07          	ld	(OFST+0,sp),a
2764                     ; 512 			break;
2766  0626 200d          	jra	L3111
2767  0628               L5111:
2768                     ; 514 		color-=0x2AAB;
2770  0628 1d2aab        	subw	x,#10923
2771  062b 1f0b          	ldw	(OFST+4,sp),x
2772                     ; 507 	for(iter=0;iter<6;iter++)
2774  062d 0c05          	inc	(OFST-2,sp)
2778  062f 7b05          	ld	a,(OFST-2,sp)
2779  0631 a106          	cp	a,#6
2780  0633 25e4          	jrult	L7011
2781  0635               L3111:
2782                     ; 516 	switch(iter)
2784  0635 7b05          	ld	a,(OFST-2,sp)
2786                     ; 523 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
2787  0637 2714          	jreq	L5101
2788  0639 4a            	dec	a
2789  063a 2719          	jreq	L7101
2790  063c 4a            	dec	a
2791  063d 271e          	jreq	L1201
2792  063f 4a            	dec	a
2793  0640 2725          	jreq	L3201
2794  0642 4a            	dec	a
2795  0643 272c          	jreq	L5201
2798  0645 7b06          	ld	a,(OFST-1,sp)
2799  0647 6b02          	ld	(OFST-5,sp),a
2803  0649 1007          	sub	a,(OFST+0,sp)
2806  064b 2016          	jp	LC005
2807  064d               L5101:
2808                     ; 518 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
2810  064d 7b06          	ld	a,(OFST-1,sp)
2811  064f 6b02          	ld	(OFST-5,sp),a
2815  0651 7b07          	ld	a,(OFST+0,sp)
2818  0653 2018          	jp	LC006
2819  0655               L7101:
2820                     ; 519 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
2822  0655 7b06          	ld	a,(OFST-1,sp)
2823  0657 6b03          	ld	(OFST-4,sp),a
2827  0659 1007          	sub	a,(OFST+0,sp)
2830  065b 201a          	jp	LC004
2831  065d               L1201:
2832                     ; 520 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
2834  065d 7b06          	ld	a,(OFST-1,sp)
2835  065f 6b03          	ld	(OFST-4,sp),a
2839  0661 7b07          	ld	a,(OFST+0,sp)
2840  0663               LC005:
2841  0663 6b04          	ld	(OFST-3,sp),a
2845  0665 2012          	jra	L1211
2846  0667               L3201:
2847                     ; 521 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
2849  0667 7b06          	ld	a,(OFST-1,sp)
2850  0669 6b04          	ld	(OFST-3,sp),a
2854  066b 1007          	sub	a,(OFST+0,sp)
2855  066d               LC006:
2856  066d 6b03          	ld	(OFST-4,sp),a
2860  066f 2008          	jra	L1211
2861  0671               L5201:
2862                     ; 522 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
2864  0671 7b06          	ld	a,(OFST-1,sp)
2865  0673 6b04          	ld	(OFST-3,sp),a
2869  0675 7b07          	ld	a,(OFST+0,sp)
2870  0677               LC004:
2871  0677 6b02          	ld	(OFST-5,sp),a
2875  0679               L1211:
2876                     ; 525 	set_rgb(index,0,red);
2878  0679 7b02          	ld	a,(OFST-5,sp)
2879  067b 88            	push	a
2880  067c 7b09          	ld	a,(OFST+2,sp)
2881  067e 5f            	clrw	x
2882  067f 95            	ld	xh,a
2883  0680 ad1b          	call	_set_rgb
2885  0682 84            	pop	a
2886                     ; 526 	set_rgb(index,1,green);
2888  0683 7b03          	ld	a,(OFST-4,sp)
2889  0685 88            	push	a
2890  0686 7b09          	ld	a,(OFST+2,sp)
2891  0688 ae0001        	ldw	x,#1
2892  068b 95            	ld	xh,a
2893  068c ad0f          	call	_set_rgb
2895  068e 84            	pop	a
2896                     ; 527 	set_rgb(index,2,blue);
2898  068f 7b04          	ld	a,(OFST-3,sp)
2899  0691 88            	push	a
2900  0692 7b09          	ld	a,(OFST+2,sp)
2901  0694 ae0002        	ldw	x,#2
2902  0697 95            	ld	xh,a
2903  0698 ad03          	call	_set_rgb
2905  069a 5b09          	addw	sp,#9
2906                     ; 528 }
2909  069c 81            	ret	
2962                     ; 532 void set_rgb(u8 index,u8 color,u8 brightness)
2962                     ; 533 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
2963                     	switch	.text
2964  069d               _set_rgb:
2966  069d 89            	pushw	x
2967       00000000      OFST:	set	0
2972  069e a606          	ld	a,#6
2973  06a0 42            	mul	x,a
2974  06a1 01            	rrwa	x,a
2975  06a2 1b01          	add	a,(OFST+1,sp)
2976  06a4 2401          	jrnc	L613
2977  06a6 5c            	incw	x
2978  06a7               L613:
2979  06a7 02            	rlwa	x,a
2980  06a8 7b05          	ld	a,(OFST+5,sp)
2981  06aa e70b          	ld	(_pwm_brightness_buffer,x),a
2985  06ac 85            	popw	x
2986  06ad 81            	ret	
3030                     ; 534 void set_white(u8 index,u8 brightness)
3030                     ; 535 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
3031                     	switch	.text
3032  06ae               _set_white:
3034  06ae 89            	pushw	x
3035       00000000      OFST:	set	0
3040  06af 9e            	ld	a,xh
3041  06b0 5f            	clrw	x
3042  06b1 97            	ld	xl,a
3043  06b2 7b02          	ld	a,(OFST+2,sp)
3044  06b4 e71e          	ld	(_pwm_brightness_buffer+19,x),a
3048  06b6 85            	popw	x
3049  06b7 81            	ret	
3084                     ; 536 void set_debug(u8 brightness)
3084                     ; 537 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
3085                     	switch	.text
3086  06b8               _set_debug:
3092  06b8 b71d          	ld	_pwm_brightness_buffer+18,a
3096  06ba 81            	ret	
3255                     	xdef	f_I2C_EventHandler
3256                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3257                     	switch	.ubsct
3258  0003               _MessageBegin:
3259  0003 00            	ds.b	1
3260                     	xdef	_MessageBegin
3261  0004               _u8_MyBuffp:
3262  0004 0000          	ds.b	2
3263                     	xdef	_u8_MyBuffp
3264  0006               _u8_My_Buffer:
3265  0006 00            	ds.b	1
3266                     	xdef	_u8_My_Buffer
3267  0007               _button_pressed_event:
3268  0007 00000000      	ds.b	4
3269                     	xdef	_button_pressed_event
3270                     	xdef	_is_right_button_down
3271                     	xdef	_button_start_ms
3272                     	xdef	_pwm_state
3273                     	xdef	_pwm_visible_index
3274                     	xdef	_pwm_led_count
3275                     	xdef	_pwm_sleep
3276  000b               _pwm_brightness_buffer:
3277  000b 000000000000  	ds.b	31
3278                     	xdef	_pwm_brightness_buffer
3279  002a               _pwm_brightness_index:
3280  002a 000000000000  	ds.b	62
3281                     	xdef	_pwm_brightness_index
3282                     	xdef	_pwm_brightness
3283                     	xdef	_atomic_counter
3284                     	xref	_UART1_Cmd
3285                     	xref	_UART1_Init
3286                     	xref	_UART1_DeInit
3287                     	xref	_GPIO_ReadInputPin
3288                     	xref	_GPIO_Init
3289                     	xref	_I2C_ITConfig
3290                     	xref	_I2C_Cmd
3291                     	xref	_I2C_Init
3292                     	xref	_I2C_DeInit
3293                     	xdef	_I2C_byte_write
3294                     	xdef	_I2C_byte_received
3295                     	xdef	_I2C_transaction_end
3296                     	xdef	_I2C_transaction_begin
3297                     	xdef	_set_led_on
3298                     	xdef	_set_mat
3299                     	xdef	_get_random
3300                     	xdef	_is_button_down
3301                     	xdef	_get_button_event
3302                     	xdef	_update_buttons
3303                     	xdef	_set_hue_max
3304                     	xdef	_flush_leds
3305                     	xdef	_set_debug
3306                     	xdef	_set_white
3307                     	xdef	_set_rgb
3308                     	xdef	_millis
3309                     	xdef	_setup_main
3310                     	xdef	_setup_serial
3311                     	xdef	_hello_world
3312                     	xref.b	c_lreg
3313                     	xref.b	c_x
3314                     	xref.b	c_y
3334                     	xref	c_xymov
3335                     	xref	c_lgadd
3336                     	xref	c_uitolx
3337                     	xref	c_lcmp
3338                     	xref	c_rtol
3339                     	xref	c_lsub
3340                     	xref	c_lzmp
3341                     	xref	c_lursh
3342                     	xref	c_itolx
3343                     	xref	c_ltor
3344                     	xref	c_imul
3345                     	end
