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
 100                     ; 28 void hello_world()
 100                     ; 29 {//basic program that blinks the debug LED ON/OFF
 102                     	switch	.text
 103  0000               _hello_world:
 105  0000 5204          	subw	sp,#4
 106       00000004      OFST:	set	4
 109                     ; 30 	const u8 cycle_speed=8;//larger=faster
 111  0002 a608          	ld	a,#8
 112  0004 6b02          	ld	(OFST-2,sp),a
 114                     ; 31 	const u8 white_speed=5;//smaller=faster
 116  0006 a605          	ld	a,#5
 117  0008 6b01          	ld	(OFST-3,sp),a
 119                     ; 32 	u16 frame=0;
 121  000a 5f            	clrw	x
 123  000b               L73:
 124                     ; 35 		frame++;
 126  000b 5c            	incw	x
 127  000c 1f03          	ldw	(OFST-1,sp),x
 129                     ; 36 		set_hue_max(0,(frame<<cycle_speed));
 131  000e 7b02          	ld	a,(OFST-2,sp)
 132  0010 2704          	jreq	L01
 133  0012               L21:
 134  0012 58            	sllw	x
 135  0013 4a            	dec	a
 136  0014 26fc          	jrne	L21
 137  0016               L01:
 138  0016 89            	pushw	x
 139  0017 4f            	clr	a
 140  0018 cd05fe        	call	_set_hue_max
 142  001b 85            	popw	x
 143                     ; 37 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 145  001c 1e03          	ldw	x,(OFST-1,sp)
 146  001e 7b02          	ld	a,(OFST-2,sp)
 147  0020 2704          	jreq	L61
 148  0022               L02:
 149  0022 58            	sllw	x
 150  0023 4a            	dec	a
 151  0024 26fc          	jrne	L02
 152  0026               L61:
 153  0026 1c2aab        	addw	x,#10923
 154  0029 89            	pushw	x
 155  002a a601          	ld	a,#1
 156  002c cd05fe        	call	_set_hue_max
 158  002f 85            	popw	x
 159                     ; 38 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 161  0030 1e03          	ldw	x,(OFST-1,sp)
 162  0032 7b02          	ld	a,(OFST-2,sp)
 163  0034 2704          	jreq	L42
 164  0036               L62:
 165  0036 58            	sllw	x
 166  0037 4a            	dec	a
 167  0038 26fc          	jrne	L62
 168  003a               L42:
 169  003a 1c5556        	addw	x,#21846
 170  003d 89            	pushw	x
 171  003e a602          	ld	a,#2
 172  0040 cd05fe        	call	_set_hue_max
 174  0043 85            	popw	x
 175                     ; 39 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 177  0044 1e03          	ldw	x,(OFST-1,sp)
 178  0046 7b02          	ld	a,(OFST-2,sp)
 179  0048 2704          	jreq	L23
 180  004a               L43:
 181  004a 58            	sllw	x
 182  004b 4a            	dec	a
 183  004c 26fc          	jrne	L43
 184  004e               L23:
 185  004e 1c8000        	addw	x,#32768
 186  0051 89            	pushw	x
 187  0052 a603          	ld	a,#3
 188  0054 cd05fe        	call	_set_hue_max
 190  0057 85            	popw	x
 191                     ; 40 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 193  0058 1e03          	ldw	x,(OFST-1,sp)
 194  005a 7b02          	ld	a,(OFST-2,sp)
 195  005c 2704          	jreq	L04
 196  005e               L24:
 197  005e 58            	sllw	x
 198  005f 4a            	dec	a
 199  0060 26fc          	jrne	L24
 200  0062               L04:
 201  0062 1caaab        	addw	x,#43691
 202  0065 89            	pushw	x
 203  0066 a604          	ld	a,#4
 204  0068 cd05fe        	call	_set_hue_max
 206  006b 85            	popw	x
 207                     ; 41 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 209  006c 1e03          	ldw	x,(OFST-1,sp)
 210  006e 7b02          	ld	a,(OFST-2,sp)
 211  0070 2704          	jreq	L64
 212  0072               L05:
 213  0072 58            	sllw	x
 214  0073 4a            	dec	a
 215  0074 26fc          	jrne	L05
 216  0076               L64:
 217  0076 1cd554        	addw	x,#54612
 218  0079 89            	pushw	x
 219  007a a605          	ld	a,#5
 220  007c cd05fe        	call	_set_hue_max
 222  007f 85            	popw	x
 223                     ; 44 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
 225  0080 1e03          	ldw	x,(OFST-1,sp)
 226  0082 7b01          	ld	a,(OFST-3,sp)
 227  0084 2704          	jreq	L65
 228  0086               L06:
 229  0086 54            	srlw	x
 230  0087 4a            	dec	a
 231  0088 26fc          	jrne	L06
 232  008a               L65:
 233  008a 01            	rrwa	x,a
 234  008b a501          	bcp	a,#1
 235  008d 2712          	jreq	L45
 236  008f a608          	ld	a,#8
 237  0091 1001          	sub	a,(OFST-3,sp)
 238  0093 5f            	clrw	x
 239  0094 97            	ld	xl,a
 240  0095 7b04          	ld	a,(OFST+0,sp)
 241  0097 5d            	tnzw	x
 242  0098 2704          	jreq	L26
 243  009a               L46:
 244  009a 48            	sll	a
 245  009b 5a            	decw	x
 246  009c 26fc          	jrne	L46
 247  009e               L26:
 248  009e 43            	cpl	a
 249  009f 200f          	jra	L07
 250  00a1               L45:
 251  00a1 a608          	ld	a,#8
 252  00a3 1001          	sub	a,(OFST-3,sp)
 253  00a5 5f            	clrw	x
 254  00a6 97            	ld	xl,a
 255  00a7 7b04          	ld	a,(OFST+0,sp)
 256  00a9 5d            	tnzw	x
 257  00aa 2704          	jreq	L07
 258  00ac               L27:
 259  00ac 48            	sll	a
 260  00ad 5a            	decw	x
 261  00ae 26fc          	jrne	L27
 262  00b0               L07:
 263  00b0 97            	ld	xl,a
 264  00b1 1603          	ldw	y,(OFST-1,sp)
 265  00b3 7b01          	ld	a,(OFST-3,sp)
 266  00b5 4c            	inc	a
 267  00b6 2705          	jreq	L47
 268  00b8               L67:
 269  00b8 9054          	srlw	y
 270  00ba 4a            	dec	a
 271  00bb 26fb          	jrne	L67
 272  00bd               L47:
 273  00bd a60c          	ld	a,#12
 274  00bf 9062          	div	y,a
 275  00c1 95            	ld	xh,a
 276  00c2 cd06a8        	call	_set_white
 278                     ; 45 		flush_leds(7);
 280  00c5 a607          	ld	a,#7
 281  00c7 cd050a        	call	_flush_leds
 284  00ca 1e03          	ldw	x,(OFST-1,sp)
 285  00cc cc000b        	jra	L73
 337                     ; 49 u16 get_random(u16 x)
 337                     ; 50 {
 338                     	switch	.text
 339  00cf               _get_random:
 341       00000004      OFST:	set	4
 344                     ; 51 	u16 a=1664525;
 346                     ; 52 	u16 c=1013904223;
 348                     ; 53 	return a * x + c;
 350  00cf 90ae660d      	ldw	y,#26125
 351  00d3 cd0000        	call	c_imul
 353  00d6 1cf35f        	addw	x,#62303
 356  00d9 81            	ret	
 425                     .const:	section	.text
 426  0000               L021:
 427  0000 0000e100      	dc.l	57600
 428                     ; 56 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 428                     ; 57 {
 429                     	switch	.text
 430  00da               _setup_serial:
 432  00da 89            	pushw	x
 433       00000000      OFST:	set	0
 436                     ; 58 	if(is_enabled)
 438  00db 9e            	ld	a,xh
 439  00dc 4d            	tnz	a
 440  00dd 273e          	jreq	L321
 441                     ; 60 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 443  00df 4bf0          	push	#240
 444  00e1 4b20          	push	#32
 445  00e3 ae500f        	ldw	x,#20495
 446  00e6 cd0000        	call	_GPIO_Init
 448  00e9 85            	popw	x
 449                     ; 61 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 451  00ea ad46          	call	LC001
 452                     ; 62 		UART1_DeInit();
 454  00ec cd0000        	call	_UART1_DeInit
 456                     ; 63 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 458  00ef 4b0c          	push	#12
 459  00f1 4b80          	push	#128
 460  00f3 4b00          	push	#0
 461  00f5 4b00          	push	#0
 462  00f7 4b00          	push	#0
 463  00f9 7b07          	ld	a,(OFST+7,sp)
 464  00fb 2708          	jreq	L611
 465  00fd ae0000        	ldw	x,#L021
 466  0100 cd0000        	call	c_ltor
 468  0103 2006          	jra	L221
 469  0105               L611:
 470  0105 ae2580        	ldw	x,#9600
 471  0108 cd0000        	call	c_itolx
 473  010b               L221:
 474  010b be02          	ldw	x,c_lreg+2
 475  010d 89            	pushw	x
 476  010e be00          	ldw	x,c_lreg
 477  0110 89            	pushw	x
 478  0111 cd0000        	call	_UART1_Init
 480  0114 5b09          	addw	sp,#9
 481                     ; 64 		UART1_Cmd(ENABLE);
 483  0116 a601          	ld	a,#1
 484  0118 cd0000        	call	_UART1_Cmd
 487  011b 2013          	jra	L521
 488  011d               L321:
 489                     ; 66 		UART1_Cmd(DISABLE);
 491  011d cd0000        	call	_UART1_Cmd
 493                     ; 67 		UART1_DeInit();
 495  0120 cd0000        	call	_UART1_DeInit
 497                     ; 68 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 499  0123 4b40          	push	#64
 500  0125 4b20          	push	#32
 501  0127 ae500f        	ldw	x,#20495
 502  012a cd0000        	call	_GPIO_Init
 504  012d 85            	popw	x
 505                     ; 69 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 507  012e ad02          	call	LC001
 508  0130               L521:
 509                     ; 71 }
 512  0130 85            	popw	x
 513  0131 81            	ret	
 514  0132               LC001:
 515  0132 4b40          	push	#64
 516  0134 4b40          	push	#64
 517  0136 ae500f        	ldw	x,#20495
 518  0139 cd0000        	call	_GPIO_Init
 520  013c 85            	popw	x
 521  013d 81            	ret	
 550                     ; 73 void setup_main()
 550                     ; 74 {
 551                     	switch	.text
 552  013e               _setup_main:
 556                     ; 75 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 558  013e c650c6        	ld	a,20678
 559  0141 a4e7          	and	a,#231
 560  0143 c750c6        	ld	20678,a
 561                     ; 84 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 563  0146 3505530e      	mov	21262,#5
 564                     ; 85 	TIM2->ARRH= 0;// init auto reload register
 566  014a 725f530f      	clr	21263
 567                     ; 86 	TIM2->ARRL= 255;// init auto reload register
 569  014e 35ff5310      	mov	21264,#255
 570                     ; 88 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 572  0152 c65300        	ld	a,21248
 573  0155 aa05          	or	a,#5
 574  0157 c75300        	ld	21248,a
 575                     ; 90 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 577  015a 35015303      	mov	21251,#1
 578                     ; 92 	setup_serial(0,0);//disable UART
 580  015e 5f            	clrw	x
 581  015f cd00da        	call	_setup_serial
 583                     ; 97 	I2C_DeInit();
 585  0162 cd0000        	call	_I2C_DeInit
 587                     ; 98 	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
 589  0165 4b10          	push	#16
 590  0167 4b00          	push	#0
 591  0169 4b01          	push	#1
 592  016b 4b00          	push	#0
 593  016d ae0060        	ldw	x,#96
 594  0170 89            	pushw	x
 595  0171 ae86a0        	ldw	x,#34464
 596  0174 89            	pushw	x
 597  0175 ae0001        	ldw	x,#1
 598  0178 89            	pushw	x
 599  0179 cd0000        	call	_I2C_Init
 601  017c 5b0a          	addw	sp,#10
 602                     ; 99 	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
 604  017e ae0701        	ldw	x,#1793
 605  0181 cd0000        	call	_I2C_ITConfig
 607                     ; 100 	I2C_Cmd(ENABLE);
 609  0184 a601          	ld	a,#1
 610  0186 cd0000        	call	_I2C_Cmd
 612                     ; 101 	enableInterrupts();  // Enable global interrupts
 615  0189 9a            	rim	
 617                     ; 102 }
 621  018a 81            	ret	
 645                     ; 104 u32 millis()
 645                     ; 105 {
 646                     	switch	.text
 647  018b               _millis:
 651                     ; 106 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 653  018b ae0000        	ldw	x,#_atomic_counter
 654  018e cd0000        	call	c_ltor
 656  0191 a609          	ld	a,#9
 660  0193 cc0000        	jp	c_lursh
 709                     	switch	.const
 710  0004               L461:
 711  0004 00000201      	dc.l	513
 712  0008               L661:
 713  0008 00000033      	dc.l	51
 714                     ; 111 void update_buttons()
 714                     ; 112 {
 715                     	switch	.text
 716  0196               _update_buttons:
 718  0196 5205          	subw	sp,#5
 719       00000005      OFST:	set	5
 722                     ; 115 	if(button_start_ms)
 724  0198 ae0088        	ldw	x,#_button_start_ms
 725  019b cd0000        	call	c_lzmp
 727  019e 274f          	jreq	L171
 728                     ; 117 		set_debug(255);
 730  01a0 a6ff          	ld	a,#255
 731  01a2 cd06b2        	call	_set_debug
 733                     ; 118 		if(!is_button_down(is_right_button_down))
 735  01a5 b68c          	ld	a,_is_right_button_down
 736  01a7 cd0267        	call	_is_button_down
 738  01aa 4d            	tnz	a
 739  01ab 2669          	jrne	L302
 740                     ; 120 			elapsed_pressed_ms=millis()-button_start_ms;
 742  01ad addc          	call	_millis
 744  01af ae0088        	ldw	x,#_button_start_ms
 745  01b2 cd0000        	call	c_lsub
 747  01b5 96            	ldw	x,sp
 748  01b6 5c            	incw	x
 749  01b7 cd0000        	call	c_rtol
 752                     ; 121 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 754  01ba 96            	ldw	x,sp
 755  01bb 5c            	incw	x
 756  01bc cd0000        	call	c_ltor
 758  01bf ae0004        	ldw	x,#L461
 759  01c2 cd0000        	call	c_lcmp
 761  01c5 250b          	jrult	L571
 764  01c7 b68c          	ld	a,_is_right_button_down
 765  01c9 5f            	clrw	x
 766  01ca 97            	ld	xl,a
 767  01cb 58            	sllw	x
 768  01cc a601          	ld	a,#1
 769  01ce e708          	ld	(_button_pressed_event+1,x),a
 771  01d0 2016          	jra	L771
 772  01d2               L571:
 773                     ; 122 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 775  01d2 96            	ldw	x,sp
 776  01d3 5c            	incw	x
 777  01d4 cd0000        	call	c_ltor
 779  01d7 ae0008        	ldw	x,#L661
 780  01da cd0000        	call	c_lcmp
 782  01dd 2509          	jrult	L771
 785  01df b68c          	ld	a,_is_right_button_down
 786  01e1 5f            	clrw	x
 787  01e2 97            	ld	xl,a
 788  01e3 58            	sllw	x
 789  01e4 a601          	ld	a,#1
 790  01e6 e707          	ld	(_button_pressed_event,x),a
 791  01e8               L771:
 792                     ; 123 			button_start_ms=0;
 794  01e8 5f            	clrw	x
 795  01e9 bf8a          	ldw	_button_start_ms+2,x
 796  01eb bf88          	ldw	_button_start_ms,x
 797  01ed 2027          	jra	L302
 798  01ef               L171:
 799                     ; 126 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 801  01ef 0f05          	clr	(OFST+0,sp)
 804  01f1 2015          	jra	L112
 805  01f3               L502:
 806                     ; 128 			if(is_button_down(button_index))
 808  01f3 7b05          	ld	a,(OFST+0,sp)
 809  01f5 ad70          	call	_is_button_down
 811  01f7 4d            	tnz	a
 812  01f8 270c          	jreq	L512
 813                     ; 130 				is_right_button_down=button_index;
 815  01fa 7b05          	ld	a,(OFST+0,sp)
 816  01fc b78c          	ld	_is_right_button_down,a
 817                     ; 131 				button_start_ms=millis();
 819  01fe ad8b          	call	_millis
 821  0200 ae0088        	ldw	x,#_button_start_ms
 822  0203 cd0000        	call	c_rtol
 824  0206               L512:
 825                     ; 126 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 827  0206 0c05          	inc	(OFST+0,sp)
 829  0208               L112:
 832  0208 7b05          	ld	a,(OFST+0,sp)
 833  020a a102          	cp	a,#2
 834  020c 2408          	jruge	L302
 836  020e ae0088        	ldw	x,#_button_start_ms
 837  0211 cd0000        	call	c_lzmp
 839  0214 27dd          	jreq	L502
 840  0216               L302:
 841                     ; 135 }
 844  0216 5b05          	addw	sp,#5
 845  0218 81            	ret	
 919                     ; 140 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 919                     ; 141 {
 920                     	switch	.text
 921  0219               _get_button_event:
 923  0219 89            	pushw	x
 924  021a 89            	pushw	x
 925       00000002      OFST:	set	2
 928                     ; 143 	bool out=0;
 930  021b 0f01          	clr	(OFST-1,sp)
 932                     ; 144 	for(iter=0;iter<BUTTON_COUNT;iter++)
 934  021d 0f02          	clr	(OFST+0,sp)
 936  021f               L752:
 937                     ; 146 		if(button_index==iter || button_index==0xFF)
 939  021f 7b03          	ld	a,(OFST+1,sp)
 940  0221 1102          	cp	a,(OFST+0,sp)
 941  0223 2703          	jreq	L762
 943  0225 4c            	inc	a
 944  0226 2632          	jrne	L562
 945  0228               L762:
 946                     ; 148 			if(is_long==0 || is_long==0xFF)
 948  0228 7b04          	ld	a,(OFST+2,sp)
 949  022a 2703          	jreq	L372
 951  022c 4c            	inc	a
 952  022d 2611          	jrne	L172
 953  022f               L372:
 954                     ; 150 				out|=button_pressed_event[iter][0];
 956  022f 7b02          	ld	a,(OFST+0,sp)
 957  0231 5f            	clrw	x
 958  0232 97            	ld	xl,a
 959  0233 58            	sllw	x
 960  0234 7b01          	ld	a,(OFST-1,sp)
 961  0236 ea07          	or	a,(_button_pressed_event,x)
 962  0238 6b01          	ld	(OFST-1,sp),a
 964                     ; 151 				if(is_clear) button_pressed_event[iter][0]=0;
 966  023a 7b07          	ld	a,(OFST+5,sp)
 967  023c 2702          	jreq	L172
 970  023e 6f07          	clr	(_button_pressed_event,x)
 971  0240               L172:
 972                     ; 153 			if(is_long==1 || is_long==0xFF)
 974  0240 7b04          	ld	a,(OFST+2,sp)
 975  0242 a101          	cp	a,#1
 976  0244 2703          	jreq	L103
 978  0246 4c            	inc	a
 979  0247 2611          	jrne	L562
 980  0249               L103:
 981                     ; 155 				out|=button_pressed_event[iter][1];
 983  0249 7b02          	ld	a,(OFST+0,sp)
 984  024b 5f            	clrw	x
 985  024c 97            	ld	xl,a
 986  024d 58            	sllw	x
 987  024e 7b01          	ld	a,(OFST-1,sp)
 988  0250 ea08          	or	a,(_button_pressed_event+1,x)
 989  0252 6b01          	ld	(OFST-1,sp),a
 991                     ; 156 				if(is_clear) button_pressed_event[iter][1]=0;
 993  0254 7b07          	ld	a,(OFST+5,sp)
 994  0256 2702          	jreq	L562
 997  0258 6f08          	clr	(_button_pressed_event+1,x)
 998  025a               L562:
 999                     ; 144 	for(iter=0;iter<BUTTON_COUNT;iter++)
1001  025a 0c02          	inc	(OFST+0,sp)
1005  025c 7b02          	ld	a,(OFST+0,sp)
1006  025e a102          	cp	a,#2
1007  0260 25bd          	jrult	L752
1008                     ; 160 	return out;
1010  0262 7b01          	ld	a,(OFST-1,sp)
1013  0264 5b04          	addw	sp,#4
1014  0266 81            	ret	
1050                     ; 164 bool is_button_down(u8 index)
1050                     ; 165 {
1051                     	switch	.text
1052  0267               _is_button_down:
1056                     ; 166 	switch(index)
1059                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1060  0267 4d            	tnz	a
1061  0268 2708          	jreq	L503
1062  026a 4a            	dec	a
1063  026b 2716          	jreq	L703
1064  026d 4a            	dec	a
1065  026e 2724          	jreq	L113
1066  0270 2033          	jra	L333
1067  0272               L503:
1068                     ; 170 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); }//left button
1070  0272 4b20          	push	#32
1071  0274 ae500f        	ldw	x,#20495
1072  0277 cd0000        	call	_GPIO_ReadInputPin
1074  027a 5b01          	addw	sp,#1
1075  027c 4d            	tnz	a
1076  027d 2602          	jrne	L002
1077  027f 4c            	inc	a
1079  0280 81            	ret	
1080  0281               L002:
1081  0281 4f            	clr	a
1084  0282 81            	ret	
1085  0283               L703:
1086                     ; 171 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); }//right button
1088  0283 4b40          	push	#64
1089  0285 ae500f        	ldw	x,#20495
1090  0288 cd0000        	call	_GPIO_ReadInputPin
1092  028b 5b01          	addw	sp,#1
1093  028d 4d            	tnz	a
1094  028e 2602          	jrne	L602
1095  0290 4c            	inc	a
1097  0291 81            	ret	
1098  0292               L602:
1099  0292 4f            	clr	a
1102  0293 81            	ret	
1103  0294               L113:
1104                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1106  0294 4b02          	push	#2
1107  0296 ae500f        	ldw	x,#20495
1108  0299 cd0000        	call	_GPIO_ReadInputPin
1110  029c 5b01          	addw	sp,#1
1111  029e 4d            	tnz	a
1112  029f 2602          	jrne	L412
1113  02a1 4c            	inc	a
1115  02a2 81            	ret	
1116  02a3               L412:
1117  02a3 4f            	clr	a
1120  02a4 81            	ret	
1121  02a5               L333:
1122                     ; 174 	return 0;
1124  02a5 4f            	clr	a
1127  02a6 81            	ret	
1152                     ; 188 	void I2C_transaction_begin(void)
1152                     ; 189 	{
1153                     	switch	.text
1154  02a7               _I2C_transaction_begin:
1158                     ; 190 		MessageBegin = TRUE;
1160  02a7 35010003      	mov	_MessageBegin,#1
1161                     ; 191 	}
1164  02ab 81            	ret	
1188                     ; 192 	void I2C_transaction_end(void)
1188                     ; 193 	{
1189                     	switch	.text
1190  02ac               _I2C_transaction_end:
1194                     ; 195 	}
1197  02ac 81            	ret	
1234                     ; 196 	void I2C_byte_received(u8 u8_RxData)
1234                     ; 197 	{
1235                     	switch	.text
1236  02ad               _I2C_byte_received:
1238  02ad 88            	push	a
1239       00000000      OFST:	set	0
1242                     ; 198 		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
1244  02ae b603          	ld	a,_MessageBegin
1245  02b0 4a            	dec	a
1246  02b1 260e          	jrne	L373
1248  02b3 7b01          	ld	a,(OFST+1,sp)
1249  02b5 260a          	jrne	L373
1250                     ; 199 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
1252  02b7 ab06          	add	a,#_u8_My_Buffer
1253  02b9 5f            	clrw	x
1254  02ba 97            	ld	xl,a
1255  02bb bf04          	ldw	_u8_MyBuffp,x
1256                     ; 200 			MessageBegin = FALSE;
1258  02bd 3f03          	clr	_MessageBegin
1260  02bf 200d          	jra	L573
1261  02c1               L373:
1262                     ; 202     else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
1264  02c1 be04          	ldw	x,_u8_MyBuffp
1265  02c3 a30007        	cpw	x,#_u8_My_Buffer+1
1266  02c6 2406          	jruge	L573
1267                     ; 203       *(u8_MyBuffp++) = u8_RxData;
1269  02c8 7b01          	ld	a,(OFST+1,sp)
1270  02ca f7            	ld	(x),a
1271  02cb 5c            	incw	x
1272  02cc bf04          	ldw	_u8_MyBuffp,x
1273  02ce               L573:
1274                     ; 204 	}
1277  02ce 84            	pop	a
1278  02cf 81            	ret	
1303                     ; 205 	u8 I2C_byte_write(void)
1303                     ; 206 	{
1304                     	switch	.text
1305  02d0               _I2C_byte_write:
1309                     ; 207 		return 0xDE;
1311  02d0 a6de          	ld	a,#222
1314  02d2 81            	ret	
1368                     ; 215 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1370                     	switch	.text
1371  02d3               f_TIM2_UPD_OVF_IRQHandler:
1373  02d3 8a            	push	cc
1374  02d4 84            	pop	a
1375  02d5 a4bf          	and	a,#191
1376  02d7 88            	push	a
1377  02d8 86            	pop	cc
1378       00000005      OFST:	set	5
1379  02d9 3b0002        	push	c_x+2
1380  02dc be00          	ldw	x,c_x
1381  02de 89            	pushw	x
1382  02df 3b0002        	push	c_y+2
1383  02e2 be00          	ldw	x,c_y
1384  02e4 89            	pushw	x
1385  02e5 be02          	ldw	x,c_lreg+2
1386  02e7 89            	pushw	x
1387  02e8 be00          	ldw	x,c_lreg
1388  02ea 89            	pushw	x
1389  02eb 5205          	subw	sp,#5
1392                     ; 216 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1394  02ed b687          	ld	a,_pwm_state
1395  02ef a401          	and	a,#1
1396  02f1 6b05          	ld	(OFST+0,sp),a
1398                     ; 217 	u16 sleep_counts=1;
1400  02f3 ae0001        	ldw	x,#1
1401  02f6 1f03          	ldw	(OFST-2,sp),x
1403                     ; 219 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1405  02f8 c6500c        	ld	a,20492
1406  02fb a407          	and	a,#7
1407  02fd c7500c        	ld	20492,a
1408                     ; 220 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1410  0300 72155011      	bres	20497,#2
1411                     ; 221 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1413  0304 72175002      	bres	20482,#3
1414                     ; 222 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1416  0308 c6500d        	ld	a,20493
1417  030b a407          	and	a,#7
1418  030d c7500d        	ld	20493,a
1419                     ; 223 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1421  0310 72155012      	bres	20498,#2
1422                     ; 224 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1424  0314 72175003      	bres	20483,#3
1425                     ; 226 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1427  0318 72195011      	bres	20497,#4
1428                     ; 227 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1430  031c 72195012      	bres	20498,#4
1431                     ; 229   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1433  0320 72115300      	bres	21248,#0
1434                     ; 230 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1436  0324 7b05          	ld	a,(OFST+0,sp)
1437  0326 8dba03ba      	callf	LC002
1438  032a 2609          	jrne	L334
1439                     ; 232 		sleep_counts=pwm_sleep[buffer_index];
1441  032c 7b05          	ld	a,(OFST+0,sp)
1442  032e 5f            	clrw	x
1443  032f 97            	ld	xl,a
1444  0330 58            	sllw	x
1445  0331 ee80          	ldw	x,(_pwm_sleep,x)
1446  0333 1f03          	ldw	(OFST-2,sp),x
1448  0335               L334:
1449                     ; 234 	if(pwm_visible_index>pwm_led_count[buffer_index])
1451  0335 7b05          	ld	a,(OFST+0,sp)
1452  0337 8dba03ba      	callf	LC002
1453  033b 2414          	jruge	L534
1454                     ; 236 		pwm_visible_index=0;//formally start new frame
1456  033d 3f86          	clr	_pwm_visible_index
1457                     ; 237 		update_buttons();
1459  033f cd0196        	call	_update_buttons
1461                     ; 238 		if(pwm_state&0x02)
1463  0342 720300870a    	btjf	_pwm_state,#1,L534
1464                     ; 240 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1466  0347 b687          	ld	a,_pwm_state
1467  0349 a803          	xor	a,#3
1468  034b b787          	ld	_pwm_state,a
1469                     ; 241 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1471  034d a401          	and	a,#1
1472  034f 6b05          	ld	(OFST+0,sp),a
1474  0351               L534:
1475                     ; 244 	if(pwm_visible_index<pwm_led_count[buffer_index])
1477  0351 7b05          	ld	a,(OFST+0,sp)
1478  0353 8dba03ba      	callf	LC002
1479  0357 2325          	jrule	L144
1480                     ; 246 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1482  0359 7b05          	ld	a,(OFST+0,sp)
1483  035b 5f            	clrw	x
1484  035c 97            	ld	xl,a
1485  035d 58            	sllw	x
1486  035e 1f01          	ldw	(OFST-4,sp),x
1488  0360 b686          	ld	a,_pwm_visible_index
1489  0362 97            	ld	xl,a
1490  0363 a604          	ld	a,#4
1491  0365 42            	mul	x,a
1492  0366 72fb01        	addw	x,(OFST-4,sp)
1493  0369 ee04          	ldw	x,(_pwm_brightness,x)
1494  036b 1f03          	ldw	(OFST-2,sp),x
1496                     ; 247 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1498  036d 5f            	clrw	x
1499  036e b686          	ld	a,_pwm_visible_index
1500  0370 97            	ld	xl,a
1501  0371 58            	sllw	x
1502  0372 01            	rrwa	x,a
1503  0373 1b05          	add	a,(OFST+0,sp)
1504  0375 2401          	jrnc	L042
1505  0377 5c            	incw	x
1506  0378               L042:
1507  0378 02            	rlwa	x,a
1508  0379 e62a          	ld	a,(_pwm_brightness_index,x)
1509  037b cd0453        	call	_set_led_on
1511  037e               L144:
1512                     ; 249 	pwm_visible_index++;
1514  037e 3c86          	inc	_pwm_visible_index
1515                     ; 250 	atomic_counter+=sleep_counts;
1517  0380 1e03          	ldw	x,(OFST-2,sp)
1518  0382 cd0000        	call	c_uitolx
1520  0385 ae0000        	ldw	x,#_atomic_counter
1521  0388 cd0000        	call	c_lgadd
1523                     ; 252   TIM2->CNTRH = 0;// Set the high byte of the counter
1525  038b 725f530c      	clr	21260
1526                     ; 253   TIM2->CNTRL = 0;// Set the low byte of the counter
1528  038f 725f530d      	clr	21261
1529                     ; 254 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1531  0393 7b03          	ld	a,(OFST-2,sp)
1532  0395 c7530f        	ld	21263,a
1533                     ; 255 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1535  0398 7b04          	ld	a,(OFST-1,sp)
1536  039a c75310        	ld	21264,a
1537                     ; 257 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1539  039d 72115304      	bres	21252,#0
1540                     ; 258   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1542  03a1 72105300      	bset	21248,#0
1543                     ; 259 }
1546  03a5 5b05          	addw	sp,#5
1547  03a7 85            	popw	x
1548  03a8 bf00          	ldw	c_lreg,x
1549  03aa 85            	popw	x
1550  03ab bf02          	ldw	c_lreg+2,x
1551  03ad 85            	popw	x
1552  03ae bf00          	ldw	c_y,x
1553  03b0 320002        	pop	c_y+2
1554  03b3 85            	popw	x
1555  03b4 bf00          	ldw	c_x,x
1556  03b6 320002        	pop	c_x+2
1557  03b9 80            	iret	
1558  03ba               LC002:
1559  03ba 5f            	clrw	x
1560  03bb 97            	ld	xl,a
1561  03bc e684          	ld	a,(_pwm_led_count,x)
1562  03be b186          	cp	a,_pwm_visible_index
1563  03c0 87            	retf	
1565                     	switch	.ubsct
1566  0000               L344_sr1:
1567  0000 00            	ds.b	1
1568  0001               L544_sr2:
1569  0001 00            	ds.b	1
1570  0002               L744_sr3:
1571  0002 00            	ds.b	1
1625                     ; 261 @far @interrupt void I2C_EventHandler(void)
1625                     ; 262 {
1626                     	switch	.text
1627  03c1               f_I2C_EventHandler:
1629  03c1 8a            	push	cc
1630  03c2 84            	pop	a
1631  03c3 a4bf          	and	a,#191
1632  03c5 88            	push	a
1633  03c6 86            	pop	cc
1634  03c7 3b0002        	push	c_x+2
1635  03ca be00          	ldw	x,c_x
1636  03cc 89            	pushw	x
1637  03cd 3b0002        	push	c_y+2
1638  03d0 be00          	ldw	x,c_y
1639  03d2 89            	pushw	x
1642                     ; 268 sr1 = I2C->SR1;
1644  03d3 5552170000    	mov	L344_sr1,21015
1645                     ; 269 sr2 = I2C->SR2;
1647  03d8 5552180001    	mov	L544_sr2,21016
1648                     ; 270 sr3 = I2C->SR3;
1650  03dd 5552190002    	mov	L744_sr3,21017
1651                     ; 273   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1653  03e2 b601          	ld	a,L544_sr2
1654  03e4 a52b          	bcp	a,#43
1655  03e6 2708          	jreq	L774
1656                     ; 275     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1658  03e8 72125211      	bset	21009,#1
1659                     ; 276     I2C->SR2= 0;					    // clear all error flags
1661  03ec 725f5218      	clr	21016
1662  03f0               L774:
1663                     ; 279   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1665  03f0 b600          	ld	a,L344_sr1
1666  03f2 a444          	and	a,#68
1667  03f4 a144          	cp	a,#68
1668  03f6 2606          	jrne	L105
1669                     ; 281     I2C_byte_received(I2C->DR);
1671  03f8 c65216        	ld	a,21014
1672  03fb cd02ad        	call	_I2C_byte_received
1674  03fe               L105:
1675                     ; 284   if (sr1 & I2C_SR1_RXNE)
1677  03fe 720d000006    	btjf	L344_sr1,#6,L305
1678                     ; 286     I2C_byte_received(I2C->DR);
1680  0403 c65216        	ld	a,21014
1681  0406 cd02ad        	call	_I2C_byte_received
1683  0409               L305:
1684                     ; 289   if (sr2 & I2C_SR2_AF)
1686  0409 7205000107    	btjf	L544_sr2,#2,L505
1687                     ; 291     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1689  040e 72155218      	bres	21016,#2
1690                     ; 292 		I2C_transaction_end();
1692  0412 cd02ac        	call	_I2C_transaction_end
1694  0415               L505:
1695                     ; 295   if (sr1 & I2C_SR1_STOPF) 
1697  0415 7209000007    	btjf	L344_sr1,#4,L705
1698                     ; 297     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1700  041a 72145211      	bset	21009,#2
1701                     ; 298 		I2C_transaction_end();
1703  041e cd02ac        	call	_I2C_transaction_end
1705  0421               L705:
1706                     ; 301   if (sr1 & I2C_SR1_ADDR)
1708  0421 7203000003    	btjf	L344_sr1,#1,L115
1709                     ; 303 		I2C_transaction_begin();
1711  0426 cd02a7        	call	_I2C_transaction_begin
1713  0429               L115:
1714                     ; 306   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1716  0429 b600          	ld	a,L344_sr1
1717  042b a484          	and	a,#132
1718  042d a184          	cp	a,#132
1719  042f 2606          	jrne	L315
1720                     ; 308 		I2C->DR = I2C_byte_write();
1722  0431 cd02d0        	call	_I2C_byte_write
1724  0434 c75216        	ld	21014,a
1725  0437               L315:
1726                     ; 311   if (sr1 & I2C_SR1_TXE)
1728  0437 720f000006    	btjf	L344_sr1,#7,L515
1729                     ; 313 		I2C->DR = I2C_byte_write();
1731  043c cd02d0        	call	_I2C_byte_write
1733  043f c75216        	ld	21014,a
1734  0442               L515:
1735                     ; 315 	GPIOD->ODR^=1;
1737  0442 9010500f      	bcpl	20495,#0
1738                     ; 316 }
1741  0446 85            	popw	x
1742  0447 bf00          	ldw	c_y,x
1743  0449 320002        	pop	c_y+2
1744  044c 85            	popw	x
1745  044d bf00          	ldw	c_x,x
1746  044f 320002        	pop	c_x+2
1747  0452 80            	iret	
1749                     	switch	.const
1750  000c               L715_led_lookup:
1751  000c 04            	dc.b	4
1752  000d 03            	dc.b	3
1753  000e 03            	dc.b	3
1754  000f 04            	dc.b	4
1755  0010 00            	dc.b	0
1756  0011 05            	dc.b	5
1757  0012 00            	dc.b	0
1758  0013 04            	dc.b	4
1759  0014 00            	dc.b	0
1760  0015 03            	dc.b	3
1761  0016 00            	dc.b	0
1762  0017 01            	dc.b	1
1763  0018 05            	dc.b	5
1764  0019 03            	dc.b	3
1765  001a 03            	dc.b	3
1766  001b 05            	dc.b	5
1767  001c 00            	dc.b	0
1768  001d 06            	dc.b	6
1769  001e 01            	dc.b	1
1770  001f 04            	dc.b	4
1771  0020 01            	dc.b	1
1772  0021 03            	dc.b	3
1773  0022 00            	dc.b	0
1774  0023 02            	dc.b	2
1775  0024 06            	dc.b	6
1776  0025 03            	dc.b	3
1777  0026 03            	dc.b	3
1778  0027 06            	dc.b	6
1779  0028 01            	dc.b	1
1780  0029 06            	dc.b	6
1781  002a 02            	dc.b	2
1782  002b 04            	dc.b	4
1783  002c 02            	dc.b	2
1784  002d 03            	dc.b	3
1785  002e 01            	dc.b	1
1786  002f 02            	dc.b	2
1787  0030 07            	dc.b	7
1788  0031 07            	dc.b	7
1789  0032 03            	dc.b	3
1790  0033 00            	dc.b	0
1791  0034 03            	dc.b	3
1792  0035 01            	dc.b	1
1793  0036 03            	dc.b	3
1794  0037 02            	dc.b	2
1795  0038 04            	dc.b	4
1796  0039 00            	dc.b	0
1797  003a 01            	dc.b	1
1798  003b 05            	dc.b	5
1799  003c 02            	dc.b	2
1800  003d 05            	dc.b	5
1801  003e 04            	dc.b	4
1802  003f 01            	dc.b	1
1803  0040 04            	dc.b	4
1804  0041 02            	dc.b	2
1805  0042 02            	dc.b	2
1806  0043 06            	dc.b	6
1807  0044 04            	dc.b	4
1808  0045 06            	dc.b	6
1809  0046 04            	dc.b	4
1810  0047 05            	dc.b	5
1811  0048 05            	dc.b	5
1812  0049 06            	dc.b	6
1856                     ; 320 void set_led_on(u8 led_index)
1856                     ; 321 {
1858                     	switch	.text
1859  0453               _set_led_on:
1861  0453 88            	push	a
1862  0454 5240          	subw	sp,#64
1863       00000040      OFST:	set	64
1866                     ; 358 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1866                     ; 359 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1866                     ; 360 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1866                     ; 361 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1866                     ; 362 		{7,7},//debug; GND is tied low, no charlieplexing involved
1866                     ; 363 		{3,0},//LED6
1866                     ; 364 		{3,1},//LED4
1866                     ; 365 		{3,2},//LED5
1866                     ; 366 		{4,0},//LED14
1866                     ; 367 		{1,5},//LED8
1866                     ; 368 		{2,5},//LED9
1866                     ; 369 		{4,1},//LED10
1866                     ; 370 		{4,2},//LED16
1866                     ; 371 		{2,6},//LED17
1866                     ; 372 		{4,6},//LED12
1866                     ; 373 		{4,5},//LED13
1866                     ; 374 		{5,6} //LED11
1866                     ; 375 	};
1868  0456 96            	ldw	x,sp
1869  0457 1c0003        	addw	x,#OFST-61
1870  045a 90ae000c      	ldw	y,#L715_led_lookup
1871  045e a63e          	ld	a,#62
1872  0460 cd0000        	call	c_xymov
1874                     ; 376 	set_mat(led_lookup[led_index][0],1);
1876  0463 96            	ldw	x,sp
1877  0464 1c0003        	addw	x,#OFST-61
1878  0467 1f01          	ldw	(OFST-63,sp),x
1880  0469 5f            	clrw	x
1881  046a 7b41          	ld	a,(OFST+1,sp)
1882  046c 97            	ld	xl,a
1883  046d 58            	sllw	x
1884  046e 72fb01        	addw	x,(OFST-63,sp)
1885  0471 f6            	ld	a,(x)
1886  0472 ae0001        	ldw	x,#1
1887  0475 95            	ld	xh,a
1888  0476 ad1a          	call	_set_mat
1890                     ; 378 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1892  0478 7b41          	ld	a,(OFST+1,sp)
1893  047a a112          	cp	a,#18
1894  047c 2711          	jreq	L345
1897  047e 96            	ldw	x,sp
1898  047f 1c0004        	addw	x,#OFST-60
1899  0482 1f01          	ldw	(OFST-63,sp),x
1901  0484 5f            	clrw	x
1902  0485 97            	ld	xl,a
1903  0486 58            	sllw	x
1904  0487 72fb01        	addw	x,(OFST-63,sp)
1905  048a f6            	ld	a,(x)
1906  048b 5f            	clrw	x
1907  048c 95            	ld	xh,a
1908  048d ad03          	call	_set_mat
1910  048f               L345:
1911                     ; 380 }
1914  048f 5b41          	addw	sp,#65
1915  0491 81            	ret	
2116                     ; 385 void set_mat(u8 mat_index,bool is_high)
2116                     ; 386 {
2117                     	switch	.text
2118  0492               _set_mat:
2120  0492 89            	pushw	x
2121  0493 5203          	subw	sp,#3
2122       00000003      OFST:	set	3
2125                     ; 424 	switch(mat_index)//DEBUG_BROKEN
2127  0495 9e            	ld	a,xh
2129                     ; 433 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
2130  0496 4d            	tnz	a
2131  0497 2717          	jreq	L545
2132  0499 4a            	dec	a
2133  049a 271d          	jreq	L745
2134  049c 4a            	dec	a
2135  049d 2723          	jreq	L155
2136  049f 4a            	dec	a
2137  04a0 2729          	jreq	L355
2138  04a2 4a            	dec	a
2139  04a3 272f          	jreq	L555
2140  04a5 4a            	dec	a
2141  04a6 2735          	jreq	L755
2142  04a8 4a            	dec	a
2143  04a9 273b          	jreq	L165
2146  04ab ae5000        	ldw	x,#20480
2150  04ae 2039          	jp	LC003
2151  04b0               L545:
2152                     ; 426 		case 0:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_4; break;
2154  04b0 ae500f        	ldw	x,#20495
2155  04b3 1f01          	ldw	(OFST-2,sp),x
2159  04b5 a610          	ld	a,#16
2162  04b7 2034          	jra	L507
2163  04b9               L745:
2164                     ; 427 		case 1:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
2166  04b9 ae500f        	ldw	x,#20495
2167  04bc 1f01          	ldw	(OFST-2,sp),x
2171  04be a604          	ld	a,#4
2174  04c0 202b          	jra	L507
2175  04c2               L155:
2176                     ; 428 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
2178  04c2 ae500a        	ldw	x,#20490
2179  04c5 1f01          	ldw	(OFST-2,sp),x
2183  04c7 a680          	ld	a,#128
2186  04c9 2022          	jra	L507
2187  04cb               L355:
2188                     ; 429 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
2190  04cb ae500a        	ldw	x,#20490
2191  04ce 1f01          	ldw	(OFST-2,sp),x
2195  04d0 a640          	ld	a,#64
2198  04d2 2019          	jra	L507
2199  04d4               L555:
2200                     ; 430 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
2202  04d4 ae500a        	ldw	x,#20490
2203  04d7 1f01          	ldw	(OFST-2,sp),x
2207  04d9 a620          	ld	a,#32
2210  04db 2010          	jra	L507
2211  04dd               L755:
2212                     ; 431 		case 5:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
2214  04dd ae500a        	ldw	x,#20490
2215  04e0 1f01          	ldw	(OFST-2,sp),x
2219  04e2 a610          	ld	a,#16
2222  04e4 2007          	jra	L507
2223  04e6               L165:
2224                     ; 432 		case 6:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
2226  04e6 ae500a        	ldw	x,#20490
2229  04e9               LC003:
2230  04e9 1f01          	ldw	(OFST-2,sp),x
2233  04eb a608          	ld	a,#8
2236  04ed               L507:
2237  04ed 6b03          	ld	(OFST+0,sp),a
2239                     ; 475 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2241  04ef 0d05          	tnz	(OFST+2,sp)
2242  04f1 2705          	jreq	L707
2245  04f3 f6            	ld	a,(x)
2246  04f4 1a03          	or	a,(OFST+0,sp)
2248  04f6 2002          	jra	L117
2249  04f8               L707:
2250                     ; 476 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2252  04f8 43            	cpl	a
2253  04f9 f4            	and	a,(x)
2254  04fa               L117:
2255  04fa f7            	ld	(x),a
2256                     ; 477 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2258  04fb e602          	ld	a,(2,x)
2259  04fd 1a03          	or	a,(OFST+0,sp)
2260  04ff e702          	ld	(2,x),a
2261                     ; 478 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2263  0501 e603          	ld	a,(3,x)
2264  0503 1a03          	or	a,(OFST+0,sp)
2265  0505 e703          	ld	(3,x),a
2266                     ; 479 }
2269  0507 5b05          	addw	sp,#5
2270  0509 81            	ret	
2346                     ; 482 void flush_leds(u8 led_count)
2346                     ; 483 {
2347                     	switch	.text
2348  050a               _flush_leds:
2350  050a 88            	push	a
2351  050b 5207          	subw	sp,#7
2352       00000007      OFST:	set	7
2355                     ; 484 	u8 led_read_index=0,led_write_index=0;
2359  050d 0f05          	clr	(OFST-2,sp)
2362  050f               L557:
2363                     ; 487 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2365  050f 72020087fb    	btjt	_pwm_state,#1,L557
2366                     ; 488 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2368  0514 b687          	ld	a,_pwm_state
2369  0516 a401          	and	a,#1
2370  0518 a801          	xor	a,#1
2371  051a 6b07          	ld	(OFST+0,sp),a
2373                     ; 490 	if(led_count==0) led_count=1;//min value
2375  051c 7b08          	ld	a,(OFST+1,sp)
2376  051e 2603          	jrne	L167
2379  0520 4c            	inc	a
2380  0521 6b08          	ld	(OFST+1,sp),a
2381  0523               L167:
2382                     ; 491 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2384  0523 97            	ld	xl,a
2385  0524 4f            	clr	a
2386  0525 02            	rlwa	x,a
2387  0526 58            	sllw	x
2388  0527 58            	sllw	x
2389  0528 7b07          	ld	a,(OFST+0,sp)
2390  052a cd05f7        	call	LC004
2391                     ; 493 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2393  052d 4f            	clr	a
2394  052e 90ef80        	ldw	(_pwm_sleep,y),x
2395  0531 6b06          	ld	(OFST-1,sp),a
2397  0533               L367:
2398                     ; 495 		read_brightness=pwm_brightness_buffer[led_read_index];
2400  0533 5f            	clrw	x
2401  0534 97            	ld	xl,a
2402  0535 e60b          	ld	a,(_pwm_brightness_buffer,x)
2403  0537 5f            	clrw	x
2404  0538 97            	ld	xl,a
2405  0539 1f03          	ldw	(OFST-4,sp),x
2407                     ; 496 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2409  053b 275e          	jreq	L177
2410                     ; 498 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2412  053d 7b05          	ld	a,(OFST-2,sp)
2413  053f 5f            	clrw	x
2414  0540 97            	ld	xl,a
2415  0541 58            	sllw	x
2416  0542 01            	rrwa	x,a
2417  0543 1b07          	add	a,(OFST+0,sp)
2418  0545 2401          	jrnc	L472
2419  0547 5c            	incw	x
2420  0548               L472:
2421  0548 02            	rlwa	x,a
2422  0549 7b06          	ld	a,(OFST-1,sp)
2423  054b e72a          	ld	(_pwm_brightness_index,x),a
2424                     ; 499 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2426  054d 1e03          	ldw	x,(OFST-4,sp)
2427  054f 9093          	ldw	y,x
2428  0551 cd0000        	call	c_imul
2430  0554 a606          	ld	a,#6
2431  0556               L672:
2432  0556 54            	srlw	x
2433  0557 4a            	dec	a
2434  0558 26fc          	jrne	L672
2435  055a 5c            	incw	x
2436  055b 7b07          	ld	a,(OFST+0,sp)
2437  055d cd05f7        	call	LC004
2438  0560 1701          	ldw	(OFST-6,sp),y
2440  0562 905f          	clrw	y
2441  0564 7b05          	ld	a,(OFST-2,sp)
2442  0566 9097          	ld	yl,a
2443  0568 9058          	sllw	y
2444  056a 9058          	sllw	y
2445  056c 72f901        	addw	y,(OFST-6,sp)
2446  056f 90ef04        	ldw	(_pwm_brightness,y),x
2447                     ; 500 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2449  0572 5f            	clrw	x
2450  0573 7b07          	ld	a,(OFST+0,sp)
2451  0575 97            	ld	xl,a
2452  0576 58            	sllw	x
2453  0577 ad7e          	call	LC004
2454  0579 1701          	ldw	(OFST-6,sp),y
2456  057b 905f          	clrw	y
2457  057d 7b05          	ld	a,(OFST-2,sp)
2458  057f 9097          	ld	yl,a
2459  0581 9058          	sllw	y
2460  0583 9058          	sllw	y
2461  0585 72f901        	addw	y,(OFST-6,sp)
2462  0588 90ee04        	ldw	y,(_pwm_brightness,y)
2463  058b 9001          	rrwa	y,a
2464  058d e081          	sub	a,(_pwm_sleep+1,x)
2465  058f 9001          	rrwa	y,a
2466  0591 e280          	sbc	a,(_pwm_sleep,x)
2467  0593 9001          	rrwa	y,a
2468  0595 9050          	negw	y
2469  0597 ef80          	ldw	(_pwm_sleep,x),y
2470                     ; 501 			led_write_index++;
2472  0599 0c05          	inc	(OFST-2,sp)
2474  059b               L177:
2475                     ; 503 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2477  059b 7b06          	ld	a,(OFST-1,sp)
2478  059d 5f            	clrw	x
2479  059e 97            	ld	xl,a
2480  059f 6f0b          	clr	(_pwm_brightness_buffer,x)
2481                     ; 493 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2483  05a1 0c06          	inc	(OFST-1,sp)
2487  05a3 7b06          	ld	a,(OFST-1,sp)
2488  05a5 a11f          	cp	a,#31
2489  05a7 258a          	jrult	L367
2490                     ; 505 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2492  05a9 7b07          	ld	a,(OFST+0,sp)
2493  05ab 5f            	clrw	x
2494  05ac 97            	ld	xl,a
2495  05ad 58            	sllw	x
2496  05ae 9093          	ldw	y,x
2497  05b0 90ee80        	ldw	y,(_pwm_sleep,y)
2498  05b3 90a37c01      	cpw	y,#31745
2499  05b7 2406          	jruge	L577
2501  05b9 e681          	ld	a,(_pwm_sleep+1,x)
2502  05bb ea80          	or	a,(_pwm_sleep,x)
2503  05bd 2606          	jrne	L377
2504  05bf               L577:
2507  05bf 90ae0001      	ldw	y,#1
2508  05c3 ef80          	ldw	(_pwm_sleep,x),y
2509  05c5               L377:
2510                     ; 506 	if(led_write_index==0)
2512  05c5 7b05          	ld	a,(OFST-2,sp)
2513  05c7 261f          	jrne	L777
2514                     ; 508 		led_write_index=1;
2516  05c9 4c            	inc	a
2517  05ca 6b05          	ld	(OFST-2,sp),a
2519                     ; 509 		pwm_sleep[buffer_index]=6<<10;
2521  05cc 5f            	clrw	x
2522  05cd 7b07          	ld	a,(OFST+0,sp)
2523  05cf 97            	ld	xl,a
2524  05d0 58            	sllw	x
2525  05d1 90ae1800      	ldw	y,#6144
2526  05d5 ef80          	ldw	(_pwm_sleep,x),y
2527                     ; 510 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2529  05d7 5f            	clrw	x
2530  05d8 97            	ld	xl,a
2531  05d9 a612          	ld	a,#18
2532  05db e72a          	ld	(_pwm_brightness_index,x),a
2533                     ; 511 		pwm_brightness[0][buffer_index]=1;
2535  05dd 5f            	clrw	x
2536  05de 7b07          	ld	a,(OFST+0,sp)
2537  05e0 97            	ld	xl,a
2538  05e1 58            	sllw	x
2539  05e2 90ae0001      	ldw	y,#1
2540  05e6 ef04          	ldw	(_pwm_brightness,x),y
2541  05e8               L777:
2542                     ; 513 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2544  05e8 7b07          	ld	a,(OFST+0,sp)
2545  05ea 5f            	clrw	x
2546  05eb 97            	ld	xl,a
2547  05ec 7b05          	ld	a,(OFST-2,sp)
2548  05ee e784          	ld	(_pwm_led_count,x),a
2549                     ; 516 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2551  05f0 72120087      	bset	_pwm_state,#1
2552                     ; 517 }
2555  05f4 5b08          	addw	sp,#8
2556  05f6 81            	ret	
2557  05f7               LC004:
2558  05f7 905f          	clrw	y
2559  05f9 9097          	ld	yl,a
2560  05fb 9058          	sllw	y
2561  05fd 81            	ret	
2668                     ; 520 void set_hue_max(u8 index,u16 color)
2668                     ; 521 {
2669                     	switch	.text
2670  05fe               _set_hue_max:
2672  05fe 88            	push	a
2673  05ff 5207          	subw	sp,#7
2674       00000007      OFST:	set	7
2677                     ; 524 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2679  0601 a6b4          	ld	a,#180
2680  0603 6b06          	ld	(OFST-1,sp),a
2682                     ; 525 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2684  0605 a63d          	ld	a,#61
2685  0607 6b01          	ld	(OFST-6,sp),a
2687                     ; 526 	u8 red=0,green=0,blue=0;
2689  0609 0f02          	clr	(OFST-5,sp)
2693  060b 0f03          	clr	(OFST-4,sp)
2697  060d 0f04          	clr	(OFST-3,sp)
2699                     ; 527 	u8 residual=0;
2701  060f 0f07          	clr	(OFST+0,sp)
2703                     ; 529 	for(iter=0;iter<6;iter++)
2705  0611 0f05          	clr	(OFST-2,sp)
2707  0613               L3701:
2708                     ; 531 		if(color<0x2AAB)
2710  0613 1e0b          	ldw	x,(OFST+4,sp)
2711  0615 a32aab        	cpw	x,#10923
2712  0618 2408          	jruge	L1011
2713                     ; 533 			residual=color/BRIGHTNESS_STEP;
2715  061a 7b01          	ld	a,(OFST-6,sp)
2716  061c 62            	div	x,a
2717  061d 01            	rrwa	x,a
2718  061e 6b07          	ld	(OFST+0,sp),a
2720                     ; 534 			break;
2722  0620 200d          	jra	L7701
2723  0622               L1011:
2724                     ; 536 		color-=0x2AAB;
2726  0622 1d2aab        	subw	x,#10923
2727  0625 1f0b          	ldw	(OFST+4,sp),x
2728                     ; 529 	for(iter=0;iter<6;iter++)
2730  0627 0c05          	inc	(OFST-2,sp)
2734  0629 7b05          	ld	a,(OFST-2,sp)
2735  062b a106          	cp	a,#6
2736  062d 25e4          	jrult	L3701
2737  062f               L7701:
2738                     ; 538 	switch(iter)
2740  062f 7b05          	ld	a,(OFST-2,sp)
2742                     ; 545 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
2743  0631 2714          	jreq	L1001
2744  0633 4a            	dec	a
2745  0634 2719          	jreq	L3001
2746  0636 4a            	dec	a
2747  0637 271e          	jreq	L5001
2748  0639 4a            	dec	a
2749  063a 2725          	jreq	L7001
2750  063c 4a            	dec	a
2751  063d 272c          	jreq	L1101
2754  063f 7b06          	ld	a,(OFST-1,sp)
2755  0641 6b02          	ld	(OFST-5,sp),a
2759  0643 1007          	sub	a,(OFST+0,sp)
2762  0645 2016          	jp	LC006
2763  0647               L1001:
2764                     ; 540 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
2766  0647 7b06          	ld	a,(OFST-1,sp)
2767  0649 6b02          	ld	(OFST-5,sp),a
2771  064b 7b07          	ld	a,(OFST+0,sp)
2774  064d 2018          	jp	LC007
2775  064f               L3001:
2776                     ; 541 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
2778  064f 7b06          	ld	a,(OFST-1,sp)
2779  0651 6b03          	ld	(OFST-4,sp),a
2783  0653 1007          	sub	a,(OFST+0,sp)
2786  0655 201a          	jp	LC005
2787  0657               L5001:
2788                     ; 542 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
2790  0657 7b06          	ld	a,(OFST-1,sp)
2791  0659 6b03          	ld	(OFST-4,sp),a
2795  065b 7b07          	ld	a,(OFST+0,sp)
2796  065d               LC006:
2797  065d 6b04          	ld	(OFST-3,sp),a
2801  065f 2012          	jra	L5011
2802  0661               L7001:
2803                     ; 543 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
2805  0661 7b06          	ld	a,(OFST-1,sp)
2806  0663 6b04          	ld	(OFST-3,sp),a
2810  0665 1007          	sub	a,(OFST+0,sp)
2811  0667               LC007:
2812  0667 6b03          	ld	(OFST-4,sp),a
2816  0669 2008          	jra	L5011
2817  066b               L1101:
2818                     ; 544 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
2820  066b 7b06          	ld	a,(OFST-1,sp)
2821  066d 6b04          	ld	(OFST-3,sp),a
2825  066f 7b07          	ld	a,(OFST+0,sp)
2826  0671               LC005:
2827  0671 6b02          	ld	(OFST-5,sp),a
2831  0673               L5011:
2832                     ; 553 	set_rgb(index,0,red);
2834  0673 7b02          	ld	a,(OFST-5,sp)
2835  0675 88            	push	a
2836  0676 7b09          	ld	a,(OFST+2,sp)
2837  0678 5f            	clrw	x
2838  0679 95            	ld	xh,a
2839  067a ad1b          	call	_set_rgb
2841  067c 84            	pop	a
2842                     ; 554 	set_rgb(index,1,green);
2844  067d 7b03          	ld	a,(OFST-4,sp)
2845  067f 88            	push	a
2846  0680 7b09          	ld	a,(OFST+2,sp)
2847  0682 ae0001        	ldw	x,#1
2848  0685 95            	ld	xh,a
2849  0686 ad0f          	call	_set_rgb
2851  0688 84            	pop	a
2852                     ; 555 	set_rgb(index,2,blue);
2854  0689 7b04          	ld	a,(OFST-3,sp)
2855  068b 88            	push	a
2856  068c 7b09          	ld	a,(OFST+2,sp)
2857  068e ae0002        	ldw	x,#2
2858  0691 95            	ld	xh,a
2859  0692 ad03          	call	_set_rgb
2861  0694 5b09          	addw	sp,#9
2862                     ; 556 }
2865  0696 81            	ret	
2918                     ; 560 void set_rgb(u8 index,u8 color,u8 brightness)
2918                     ; 561 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
2919                     	switch	.text
2920  0697               _set_rgb:
2922  0697 89            	pushw	x
2923       00000000      OFST:	set	0
2928  0698 a606          	ld	a,#6
2929  069a 42            	mul	x,a
2930  069b 01            	rrwa	x,a
2931  069c 1b01          	add	a,(OFST+1,sp)
2932  069e 2401          	jrnc	L213
2933  06a0 5c            	incw	x
2934  06a1               L213:
2935  06a1 02            	rlwa	x,a
2936  06a2 7b05          	ld	a,(OFST+5,sp)
2937  06a4 e70b          	ld	(_pwm_brightness_buffer,x),a
2941  06a6 85            	popw	x
2942  06a7 81            	ret	
2986                     ; 562 void set_white(u8 index,u8 brightness)
2986                     ; 563 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
2987                     	switch	.text
2988  06a8               _set_white:
2990  06a8 89            	pushw	x
2991       00000000      OFST:	set	0
2996  06a9 9e            	ld	a,xh
2997  06aa 5f            	clrw	x
2998  06ab 97            	ld	xl,a
2999  06ac 7b02          	ld	a,(OFST+2,sp)
3000  06ae e71e          	ld	(_pwm_brightness_buffer+19,x),a
3004  06b0 85            	popw	x
3005  06b1 81            	ret	
3040                     ; 564 void set_debug(u8 brightness)
3040                     ; 565 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
3041                     	switch	.text
3042  06b2               _set_debug:
3048  06b2 b71d          	ld	_pwm_brightness_buffer+18,a
3052  06b4 81            	ret	
3211                     	xdef	f_I2C_EventHandler
3212                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3213                     	switch	.ubsct
3214  0003               _MessageBegin:
3215  0003 00            	ds.b	1
3216                     	xdef	_MessageBegin
3217  0004               _u8_MyBuffp:
3218  0004 0000          	ds.b	2
3219                     	xdef	_u8_MyBuffp
3220  0006               _u8_My_Buffer:
3221  0006 00            	ds.b	1
3222                     	xdef	_u8_My_Buffer
3223  0007               _button_pressed_event:
3224  0007 00000000      	ds.b	4
3225                     	xdef	_button_pressed_event
3226                     	xdef	_is_right_button_down
3227                     	xdef	_button_start_ms
3228                     	xdef	_pwm_state
3229                     	xdef	_pwm_visible_index
3230                     	xdef	_pwm_led_count
3231                     	xdef	_pwm_sleep
3232  000b               _pwm_brightness_buffer:
3233  000b 000000000000  	ds.b	31
3234                     	xdef	_pwm_brightness_buffer
3235  002a               _pwm_brightness_index:
3236  002a 000000000000  	ds.b	62
3237                     	xdef	_pwm_brightness_index
3238                     	xdef	_pwm_brightness
3239                     	xdef	_atomic_counter
3240                     	xref	_UART1_Cmd
3241                     	xref	_UART1_Init
3242                     	xref	_UART1_DeInit
3243                     	xref	_GPIO_ReadInputPin
3244                     	xref	_GPIO_Init
3245                     	xref	_I2C_ITConfig
3246                     	xref	_I2C_Cmd
3247                     	xref	_I2C_Init
3248                     	xref	_I2C_DeInit
3249                     	xdef	_I2C_byte_write
3250                     	xdef	_I2C_byte_received
3251                     	xdef	_I2C_transaction_end
3252                     	xdef	_I2C_transaction_begin
3253                     	xdef	_set_led_on
3254                     	xdef	_set_mat
3255                     	xdef	_get_random
3256                     	xdef	_is_button_down
3257                     	xdef	_get_button_event
3258                     	xdef	_update_buttons
3259                     	xdef	_set_hue_max
3260                     	xdef	_flush_leds
3261                     	xdef	_set_debug
3262                     	xdef	_set_white
3263                     	xdef	_set_rgb
3264                     	xdef	_millis
3265                     	xdef	_setup_main
3266                     	xdef	_setup_serial
3267                     	xdef	_hello_world
3268                     	xref.b	c_lreg
3269                     	xref.b	c_x
3270                     	xref.b	c_y
3290                     	xref	c_xymov
3291                     	xref	c_lgadd
3292                     	xref	c_uitolx
3293                     	xref	c_lcmp
3294                     	xref	c_rtol
3295                     	xref	c_lsub
3296                     	xref	c_lzmp
3297                     	xref	c_lursh
3298                     	xref	c_itolx
3299                     	xref	c_ltor
3300                     	xref	c_imul
3301                     	end
