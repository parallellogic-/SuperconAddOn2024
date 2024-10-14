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
 140  0018 cd05b4        	call	_set_hue_max
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
 156  002c cd05b4        	call	_set_hue_max
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
 172  0040 cd05b4        	call	_set_hue_max
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
 188  0054 cd05b4        	call	_set_hue_max
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
 204  0068 cd05b4        	call	_set_hue_max
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
 220  007c cd05b4        	call	_set_hue_max
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
 276  00c2 cd065e        	call	_set_white
 278                     ; 45 		flush_leds(7);
 280  00c5 a607          	ld	a,#7
 281  00c7 cd04c0        	call	_flush_leds
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
 731  01a2 cd0668        	call	_set_debug
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
 769  01ce e701          	ld	(_button_pressed_event+1,x),a
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
 790  01e6 e700          	ld	(_button_pressed_event,x),a
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
 961  0236 ea00          	or	a,(_button_pressed_event,x)
 962  0238 6b01          	ld	(OFST-1,sp),a
 964                     ; 151 				if(is_clear) button_pressed_event[iter][0]=0;
 966  023a 7b07          	ld	a,(OFST+5,sp)
 967  023c 2702          	jreq	L172
 970  023e 6f00          	clr	(_button_pressed_event,x)
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
 988  0250 ea01          	or	a,(_button_pressed_event+1,x)
 989  0252 6b01          	ld	(OFST-1,sp),a
 991                     ; 156 				if(is_clear) button_pressed_event[iter][1]=0;
 993  0254 7b07          	ld	a,(OFST+5,sp)
 994  0256 2702          	jreq	L562
 997  0258 6f01          	clr	(_button_pressed_event+1,x)
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
1181                     ; 178 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1183                     	switch	.text
1184  02a7               f_TIM2_UPD_OVF_IRQHandler:
1186  02a7 8a            	push	cc
1187  02a8 84            	pop	a
1188  02a9 a4bf          	and	a,#191
1189  02ab 88            	push	a
1190  02ac 86            	pop	cc
1191       00000005      OFST:	set	5
1192  02ad 3b0002        	push	c_x+2
1193  02b0 be00          	ldw	x,c_x
1194  02b2 89            	pushw	x
1195  02b3 3b0002        	push	c_y+2
1196  02b6 be00          	ldw	x,c_y
1197  02b8 89            	pushw	x
1198  02b9 be02          	ldw	x,c_lreg+2
1199  02bb 89            	pushw	x
1200  02bc be00          	ldw	x,c_lreg
1201  02be 89            	pushw	x
1202  02bf 5205          	subw	sp,#5
1205                     ; 179 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1207  02c1 b687          	ld	a,_pwm_state
1208  02c3 a401          	and	a,#1
1209  02c5 6b05          	ld	(OFST+0,sp),a
1211                     ; 180 	u16 sleep_counts=1;
1213  02c7 ae0001        	ldw	x,#1
1214  02ca 1f03          	ldw	(OFST-2,sp),x
1216                     ; 182 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1218  02cc c6500c        	ld	a,20492
1219  02cf a407          	and	a,#7
1220  02d1 c7500c        	ld	20492,a
1221                     ; 183 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1223  02d4 72155011      	bres	20497,#2
1224                     ; 184 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1226  02d8 72175002      	bres	20482,#3
1227                     ; 185 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1229  02dc c6500d        	ld	a,20493
1230  02df a407          	and	a,#7
1231  02e1 c7500d        	ld	20493,a
1232                     ; 186 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1234  02e4 72155012      	bres	20498,#2
1235                     ; 187 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1237  02e8 72175003      	bres	20483,#3
1238                     ; 189 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1240  02ec 72195011      	bres	20497,#4
1241                     ; 190 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1243  02f0 72195012      	bres	20498,#4
1244                     ; 192   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1246  02f4 72115300      	bres	21248,#0
1247                     ; 193 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1249  02f8 7b05          	ld	a,(OFST+0,sp)
1250  02fa 8d8e038e      	callf	LC002
1251  02fe 2609          	jrne	L753
1252                     ; 195 		sleep_counts=pwm_sleep[buffer_index];
1254  0300 7b05          	ld	a,(OFST+0,sp)
1255  0302 5f            	clrw	x
1256  0303 97            	ld	xl,a
1257  0304 58            	sllw	x
1258  0305 ee80          	ldw	x,(_pwm_sleep,x)
1259  0307 1f03          	ldw	(OFST-2,sp),x
1261  0309               L753:
1262                     ; 197 	if(pwm_visible_index>pwm_led_count[buffer_index])
1264  0309 7b05          	ld	a,(OFST+0,sp)
1265  030b 8d8e038e      	callf	LC002
1266  030f 2414          	jruge	L163
1267                     ; 199 		pwm_visible_index=0;//formally start new frame
1269  0311 3f86          	clr	_pwm_visible_index
1270                     ; 200 		update_buttons();
1272  0313 cd0196        	call	_update_buttons
1274                     ; 201 		if(pwm_state&0x02)
1276  0316 720300870a    	btjf	_pwm_state,#1,L163
1277                     ; 203 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1279  031b b687          	ld	a,_pwm_state
1280  031d a803          	xor	a,#3
1281  031f b787          	ld	_pwm_state,a
1282                     ; 204 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1284  0321 a401          	and	a,#1
1285  0323 6b05          	ld	(OFST+0,sp),a
1287  0325               L163:
1288                     ; 207 	if(pwm_visible_index<pwm_led_count[buffer_index])
1290  0325 7b05          	ld	a,(OFST+0,sp)
1291  0327 8d8e038e      	callf	LC002
1292  032b 2325          	jrule	L563
1293                     ; 209 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1295  032d 7b05          	ld	a,(OFST+0,sp)
1296  032f 5f            	clrw	x
1297  0330 97            	ld	xl,a
1298  0331 58            	sllw	x
1299  0332 1f01          	ldw	(OFST-4,sp),x
1301  0334 b686          	ld	a,_pwm_visible_index
1302  0336 97            	ld	xl,a
1303  0337 a604          	ld	a,#4
1304  0339 42            	mul	x,a
1305  033a 72fb01        	addw	x,(OFST-4,sp)
1306  033d ee04          	ldw	x,(_pwm_brightness,x)
1307  033f 1f03          	ldw	(OFST-2,sp),x
1309                     ; 210 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1311  0341 5f            	clrw	x
1312  0342 b686          	ld	a,_pwm_visible_index
1313  0344 97            	ld	xl,a
1314  0345 58            	sllw	x
1315  0346 01            	rrwa	x,a
1316  0347 1b05          	add	a,(OFST+0,sp)
1317  0349 2401          	jrnc	L032
1318  034b 5c            	incw	x
1319  034c               L032:
1320  034c 02            	rlwa	x,a
1321  034d e623          	ld	a,(_pwm_brightness_index,x)
1322  034f cd0409        	call	_set_led_on
1324  0352               L563:
1325                     ; 212 	pwm_visible_index++;
1327  0352 3c86          	inc	_pwm_visible_index
1328                     ; 213 	atomic_counter+=sleep_counts;
1330  0354 1e03          	ldw	x,(OFST-2,sp)
1331  0356 cd0000        	call	c_uitolx
1333  0359 ae0000        	ldw	x,#_atomic_counter
1334  035c cd0000        	call	c_lgadd
1336                     ; 215   TIM2->CNTRH = 0;// Set the high byte of the counter
1338  035f 725f530c      	clr	21260
1339                     ; 216   TIM2->CNTRL = 0;// Set the low byte of the counter
1341  0363 725f530d      	clr	21261
1342                     ; 217 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1344  0367 7b03          	ld	a,(OFST-2,sp)
1345  0369 c7530f        	ld	21263,a
1346                     ; 218 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1348  036c 7b04          	ld	a,(OFST-1,sp)
1349  036e c75310        	ld	21264,a
1350                     ; 220 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1352  0371 72115304      	bres	21252,#0
1353                     ; 221   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1355  0375 72105300      	bset	21248,#0
1356                     ; 222 }
1359  0379 5b05          	addw	sp,#5
1360  037b 85            	popw	x
1361  037c bf00          	ldw	c_lreg,x
1362  037e 85            	popw	x
1363  037f bf02          	ldw	c_lreg+2,x
1364  0381 85            	popw	x
1365  0382 bf00          	ldw	c_y,x
1366  0384 320002        	pop	c_y+2
1367  0387 85            	popw	x
1368  0388 bf00          	ldw	c_x,x
1369  038a 320002        	pop	c_x+2
1370  038d 80            	iret	
1371  038e               LC002:
1372  038e 5f            	clrw	x
1373  038f 97            	ld	xl,a
1374  0390 e684          	ld	a,(_pwm_led_count,x)
1375  0392 b186          	cp	a,_pwm_visible_index
1376  0394 87            	retf	
1403                     ; 224 @far @interrupt void I2C_EventHandler(void)
1403                     ; 225 {
1404                     	switch	.text
1405  0395               f_I2C_EventHandler:
1407  0395 8a            	push	cc
1408  0396 84            	pop	a
1409  0397 a4bf          	and	a,#191
1410  0399 88            	push	a
1411  039a 86            	pop	cc
1412  039b 3b0002        	push	c_x+2
1413  039e be00          	ldw	x,c_x
1414  03a0 89            	pushw	x
1415  03a1 3b0002        	push	c_y+2
1416  03a4 be00          	ldw	x,c_y
1417  03a6 89            	pushw	x
1420                     ; 227     if (I2C_CheckEvent(I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED))
1422  03a7 ae0202        	ldw	x,#514
1423  03aa cd0000        	call	_I2C_CheckEvent
1425  03ad 4d            	tnz	a
1426  03ae 270b          	jreq	L773
1427                     ; 230         I2C_ClearITPendingBit(I2C_ITPENDINGBIT_ADDRESSSENTMATCHED);
1429  03b0 ae1202        	ldw	x,#4610
1430  03b3 cd0000        	call	_I2C_ClearITPendingBit
1432                     ; 231 				I2C_AcknowledgeConfig(I2C_ACK_CURR);
1434  03b6 a601          	ld	a,#1
1435  03b8 cd0000        	call	_I2C_AcknowledgeConfig
1437  03bb               L773:
1438                     ; 235     if (I2C_CheckEvent(I2C_EVENT_SLAVE_BYTE_RECEIVED))
1440  03bb ae0240        	ldw	x,#576
1441  03be cd0000        	call	_I2C_CheckEvent
1443  03c1 4d            	tnz	a
1444  03c2 2703          	jreq	L104
1445                     ; 238         /*received_data =*/I2C_ReceiveData();
1447  03c4 cd0000        	call	_I2C_ReceiveData
1449  03c7               L104:
1450                     ; 244     if (I2C_CheckEvent(I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED))
1452  03c7 ae0682        	ldw	x,#1666
1453  03ca cd0000        	call	_I2C_CheckEvent
1455  03cd 4d            	tnz	a
1456  03ce 2705          	jreq	L304
1457                     ; 247         I2C_SendData(0xAB);
1459  03d0 a6ab          	ld	a,#171
1460  03d2 cd0000        	call	_I2C_SendData
1462  03d5               L304:
1463                     ; 251     if (I2C_CheckEvent(I2C_EVENT_SLAVE_BYTE_TRANSMITTED))
1465  03d5 ae0684        	ldw	x,#1668
1466  03d8 cd0000        	call	_I2C_CheckEvent
1468  03db 4d            	tnz	a
1469  03dc 270a          	jreq	L504
1470                     ; 255         I2C_SendData(0xCD);  // Continue sending the same data
1472  03de a6cd          	ld	a,#205
1473  03e0 cd0000        	call	_I2C_SendData
1475                     ; 256 				I2C_AcknowledgeConfig(I2C_ACK_CURR);
1477  03e3 a601          	ld	a,#1
1478  03e5 cd0000        	call	_I2C_AcknowledgeConfig
1480  03e8               L504:
1481                     ; 260     if (I2C_CheckEvent(I2C_EVENT_SLAVE_STOP_DETECTED))
1483  03e8 ae0010        	ldw	x,#16
1484  03eb cd0000        	call	_I2C_CheckEvent
1486  03ee 4d            	tnz	a
1487  03ef 270b          	jreq	L704
1488                     ; 263         I2C_ClearITPendingBit(I2C_ITPENDINGBIT_STOPDETECTION);
1490  03f1 ae1210        	ldw	x,#4624
1491  03f4 cd0000        	call	_I2C_ClearITPendingBit
1493                     ; 264         I2C_AcknowledgeConfig(I2C_ACK_CURR);
1495  03f7 a601          	ld	a,#1
1496  03f9 cd0000        	call	_I2C_AcknowledgeConfig
1498  03fc               L704:
1499                     ; 267 }
1502  03fc 85            	popw	x
1503  03fd bf00          	ldw	c_y,x
1504  03ff 320002        	pop	c_y+2
1505  0402 85            	popw	x
1506  0403 bf00          	ldw	c_x,x
1507  0405 320002        	pop	c_x+2
1508  0408 80            	iret	
1510                     	switch	.const
1511  000c               L114_led_lookup:
1512  000c 04            	dc.b	4
1513  000d 03            	dc.b	3
1514  000e 03            	dc.b	3
1515  000f 04            	dc.b	4
1516  0010 00            	dc.b	0
1517  0011 05            	dc.b	5
1518  0012 00            	dc.b	0
1519  0013 04            	dc.b	4
1520  0014 00            	dc.b	0
1521  0015 03            	dc.b	3
1522  0016 00            	dc.b	0
1523  0017 01            	dc.b	1
1524  0018 05            	dc.b	5
1525  0019 03            	dc.b	3
1526  001a 03            	dc.b	3
1527  001b 05            	dc.b	5
1528  001c 00            	dc.b	0
1529  001d 06            	dc.b	6
1530  001e 01            	dc.b	1
1531  001f 04            	dc.b	4
1532  0020 01            	dc.b	1
1533  0021 03            	dc.b	3
1534  0022 00            	dc.b	0
1535  0023 02            	dc.b	2
1536  0024 06            	dc.b	6
1537  0025 03            	dc.b	3
1538  0026 03            	dc.b	3
1539  0027 06            	dc.b	6
1540  0028 01            	dc.b	1
1541  0029 06            	dc.b	6
1542  002a 02            	dc.b	2
1543  002b 04            	dc.b	4
1544  002c 02            	dc.b	2
1545  002d 03            	dc.b	3
1546  002e 01            	dc.b	1
1547  002f 02            	dc.b	2
1548  0030 07            	dc.b	7
1549  0031 07            	dc.b	7
1550  0032 03            	dc.b	3
1551  0033 00            	dc.b	0
1552  0034 03            	dc.b	3
1553  0035 01            	dc.b	1
1554  0036 03            	dc.b	3
1555  0037 02            	dc.b	2
1556  0038 04            	dc.b	4
1557  0039 00            	dc.b	0
1558  003a 01            	dc.b	1
1559  003b 05            	dc.b	5
1560  003c 02            	dc.b	2
1561  003d 05            	dc.b	5
1562  003e 04            	dc.b	4
1563  003f 01            	dc.b	1
1564  0040 04            	dc.b	4
1565  0041 02            	dc.b	2
1566  0042 02            	dc.b	2
1567  0043 06            	dc.b	6
1568  0044 04            	dc.b	4
1569  0045 06            	dc.b	6
1570  0046 04            	dc.b	4
1571  0047 05            	dc.b	5
1572  0048 05            	dc.b	5
1573  0049 06            	dc.b	6
1617                     ; 270 void set_led_on(u8 led_index)
1617                     ; 271 {
1619                     	switch	.text
1620  0409               _set_led_on:
1622  0409 88            	push	a
1623  040a 5240          	subw	sp,#64
1624       00000040      OFST:	set	64
1627                     ; 308 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1627                     ; 309 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1627                     ; 310 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1627                     ; 311 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1627                     ; 312 		{7,7},//debug; GND is tied low, no charlieplexing involved
1627                     ; 313 		{3,0},//LED6
1627                     ; 314 		{3,1},//LED4
1627                     ; 315 		{3,2},//LED5
1627                     ; 316 		{4,0},//LED14
1627                     ; 317 		{1,5},//LED8
1627                     ; 318 		{2,5},//LED9
1627                     ; 319 		{4,1},//LED10
1627                     ; 320 		{4,2},//LED16
1627                     ; 321 		{2,6},//LED17
1627                     ; 322 		{4,6},//LED12
1627                     ; 323 		{4,5},//LED13
1627                     ; 324 		{5,6} //LED11
1627                     ; 325 	};
1629  040c 96            	ldw	x,sp
1630  040d 1c0003        	addw	x,#OFST-61
1631  0410 90ae000c      	ldw	y,#L114_led_lookup
1632  0414 a63e          	ld	a,#62
1633  0416 cd0000        	call	c_xymov
1635                     ; 326 	set_mat(led_lookup[led_index][0],1);
1637  0419 96            	ldw	x,sp
1638  041a 1c0003        	addw	x,#OFST-61
1639  041d 1f01          	ldw	(OFST-63,sp),x
1641  041f 5f            	clrw	x
1642  0420 7b41          	ld	a,(OFST+1,sp)
1643  0422 97            	ld	xl,a
1644  0423 58            	sllw	x
1645  0424 72fb01        	addw	x,(OFST-63,sp)
1646  0427 f6            	ld	a,(x)
1647  0428 ae0001        	ldw	x,#1
1648  042b 95            	ld	xh,a
1649  042c ad1a          	call	_set_mat
1651                     ; 328 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1653  042e 7b41          	ld	a,(OFST+1,sp)
1654  0430 a112          	cp	a,#18
1655  0432 2711          	jreq	L534
1658  0434 96            	ldw	x,sp
1659  0435 1c0004        	addw	x,#OFST-60
1660  0438 1f01          	ldw	(OFST-63,sp),x
1662  043a 5f            	clrw	x
1663  043b 97            	ld	xl,a
1664  043c 58            	sllw	x
1665  043d 72fb01        	addw	x,(OFST-63,sp)
1666  0440 f6            	ld	a,(x)
1667  0441 5f            	clrw	x
1668  0442 95            	ld	xh,a
1669  0443 ad03          	call	_set_mat
1671  0445               L534:
1672                     ; 330 }
1675  0445 5b41          	addw	sp,#65
1676  0447 81            	ret	
1877                     ; 335 void set_mat(u8 mat_index,bool is_high)
1877                     ; 336 {
1878                     	switch	.text
1879  0448               _set_mat:
1881  0448 89            	pushw	x
1882  0449 5203          	subw	sp,#3
1883       00000003      OFST:	set	3
1886                     ; 374 	switch(mat_index)//DEBUG_BROKEN
1888  044b 9e            	ld	a,xh
1890                     ; 383 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
1891  044c 4d            	tnz	a
1892  044d 2717          	jreq	L734
1893  044f 4a            	dec	a
1894  0450 271d          	jreq	L144
1895  0452 4a            	dec	a
1896  0453 2723          	jreq	L344
1897  0455 4a            	dec	a
1898  0456 2729          	jreq	L544
1899  0458 4a            	dec	a
1900  0459 272f          	jreq	L744
1901  045b 4a            	dec	a
1902  045c 2735          	jreq	L154
1903  045e 4a            	dec	a
1904  045f 273b          	jreq	L354
1907  0461 ae5000        	ldw	x,#20480
1911  0464 2039          	jp	LC003
1912  0466               L734:
1913                     ; 376 		case 0:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_4; break;
1915  0466 ae500f        	ldw	x,#20495
1916  0469 1f01          	ldw	(OFST-2,sp),x
1920  046b a610          	ld	a,#16
1923  046d 2034          	jra	L775
1924  046f               L144:
1925                     ; 377 		case 1:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
1927  046f ae500f        	ldw	x,#20495
1928  0472 1f01          	ldw	(OFST-2,sp),x
1932  0474 a604          	ld	a,#4
1935  0476 202b          	jra	L775
1936  0478               L344:
1937                     ; 378 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
1939  0478 ae500a        	ldw	x,#20490
1940  047b 1f01          	ldw	(OFST-2,sp),x
1944  047d a680          	ld	a,#128
1947  047f 2022          	jra	L775
1948  0481               L544:
1949                     ; 379 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
1951  0481 ae500a        	ldw	x,#20490
1952  0484 1f01          	ldw	(OFST-2,sp),x
1956  0486 a640          	ld	a,#64
1959  0488 2019          	jra	L775
1960  048a               L744:
1961                     ; 380 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
1963  048a ae500a        	ldw	x,#20490
1964  048d 1f01          	ldw	(OFST-2,sp),x
1968  048f a620          	ld	a,#32
1971  0491 2010          	jra	L775
1972  0493               L154:
1973                     ; 381 		case 5:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
1975  0493 ae500a        	ldw	x,#20490
1976  0496 1f01          	ldw	(OFST-2,sp),x
1980  0498 a610          	ld	a,#16
1983  049a 2007          	jra	L775
1984  049c               L354:
1985                     ; 382 		case 6:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
1987  049c ae500a        	ldw	x,#20490
1990  049f               LC003:
1991  049f 1f01          	ldw	(OFST-2,sp),x
1994  04a1 a608          	ld	a,#8
1997  04a3               L775:
1998  04a3 6b03          	ld	(OFST+0,sp),a
2000                     ; 425 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2002  04a5 0d05          	tnz	(OFST+2,sp)
2003  04a7 2705          	jreq	L106
2006  04a9 f6            	ld	a,(x)
2007  04aa 1a03          	or	a,(OFST+0,sp)
2009  04ac 2002          	jra	L306
2010  04ae               L106:
2011                     ; 426 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2013  04ae 43            	cpl	a
2014  04af f4            	and	a,(x)
2015  04b0               L306:
2016  04b0 f7            	ld	(x),a
2017                     ; 427 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2019  04b1 e602          	ld	a,(2,x)
2020  04b3 1a03          	or	a,(OFST+0,sp)
2021  04b5 e702          	ld	(2,x),a
2022                     ; 428 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2024  04b7 e603          	ld	a,(3,x)
2025  04b9 1a03          	or	a,(OFST+0,sp)
2026  04bb e703          	ld	(3,x),a
2027                     ; 429 }
2030  04bd 5b05          	addw	sp,#5
2031  04bf 81            	ret	
2107                     ; 432 void flush_leds(u8 led_count)
2107                     ; 433 {
2108                     	switch	.text
2109  04c0               _flush_leds:
2111  04c0 88            	push	a
2112  04c1 5207          	subw	sp,#7
2113       00000007      OFST:	set	7
2116                     ; 434 	u8 led_read_index=0,led_write_index=0;
2120  04c3 0f05          	clr	(OFST-2,sp)
2123  04c5               L746:
2124                     ; 437 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2126  04c5 72020087fb    	btjt	_pwm_state,#1,L746
2127                     ; 438 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2129  04ca b687          	ld	a,_pwm_state
2130  04cc a401          	and	a,#1
2131  04ce a801          	xor	a,#1
2132  04d0 6b07          	ld	(OFST+0,sp),a
2134                     ; 440 	if(led_count==0) led_count=1;//min value
2136  04d2 7b08          	ld	a,(OFST+1,sp)
2137  04d4 2603          	jrne	L356
2140  04d6 4c            	inc	a
2141  04d7 6b08          	ld	(OFST+1,sp),a
2142  04d9               L356:
2143                     ; 441 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2145  04d9 97            	ld	xl,a
2146  04da 4f            	clr	a
2147  04db 02            	rlwa	x,a
2148  04dc 58            	sllw	x
2149  04dd 58            	sllw	x
2150  04de 7b07          	ld	a,(OFST+0,sp)
2151  04e0 cd05ad        	call	LC004
2152                     ; 443 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2154  04e3 4f            	clr	a
2155  04e4 90ef80        	ldw	(_pwm_sleep,y),x
2156  04e7 6b06          	ld	(OFST-1,sp),a
2158  04e9               L556:
2159                     ; 445 		read_brightness=pwm_brightness_buffer[led_read_index];
2161  04e9 5f            	clrw	x
2162  04ea 97            	ld	xl,a
2163  04eb e604          	ld	a,(_pwm_brightness_buffer,x)
2164  04ed 5f            	clrw	x
2165  04ee 97            	ld	xl,a
2166  04ef 1f03          	ldw	(OFST-4,sp),x
2168                     ; 446 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2170  04f1 275e          	jreq	L366
2171                     ; 448 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2173  04f3 7b05          	ld	a,(OFST-2,sp)
2174  04f5 5f            	clrw	x
2175  04f6 97            	ld	xl,a
2176  04f7 58            	sllw	x
2177  04f8 01            	rrwa	x,a
2178  04f9 1b07          	add	a,(OFST+0,sp)
2179  04fb 2401          	jrnc	L003
2180  04fd 5c            	incw	x
2181  04fe               L003:
2182  04fe 02            	rlwa	x,a
2183  04ff 7b06          	ld	a,(OFST-1,sp)
2184  0501 e723          	ld	(_pwm_brightness_index,x),a
2185                     ; 449 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2187  0503 1e03          	ldw	x,(OFST-4,sp)
2188  0505 9093          	ldw	y,x
2189  0507 cd0000        	call	c_imul
2191  050a a606          	ld	a,#6
2192  050c               L203:
2193  050c 54            	srlw	x
2194  050d 4a            	dec	a
2195  050e 26fc          	jrne	L203
2196  0510 5c            	incw	x
2197  0511 7b07          	ld	a,(OFST+0,sp)
2198  0513 cd05ad        	call	LC004
2199  0516 1701          	ldw	(OFST-6,sp),y
2201  0518 905f          	clrw	y
2202  051a 7b05          	ld	a,(OFST-2,sp)
2203  051c 9097          	ld	yl,a
2204  051e 9058          	sllw	y
2205  0520 9058          	sllw	y
2206  0522 72f901        	addw	y,(OFST-6,sp)
2207  0525 90ef04        	ldw	(_pwm_brightness,y),x
2208                     ; 450 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2210  0528 5f            	clrw	x
2211  0529 7b07          	ld	a,(OFST+0,sp)
2212  052b 97            	ld	xl,a
2213  052c 58            	sllw	x
2214  052d ad7e          	call	LC004
2215  052f 1701          	ldw	(OFST-6,sp),y
2217  0531 905f          	clrw	y
2218  0533 7b05          	ld	a,(OFST-2,sp)
2219  0535 9097          	ld	yl,a
2220  0537 9058          	sllw	y
2221  0539 9058          	sllw	y
2222  053b 72f901        	addw	y,(OFST-6,sp)
2223  053e 90ee04        	ldw	y,(_pwm_brightness,y)
2224  0541 9001          	rrwa	y,a
2225  0543 e081          	sub	a,(_pwm_sleep+1,x)
2226  0545 9001          	rrwa	y,a
2227  0547 e280          	sbc	a,(_pwm_sleep,x)
2228  0549 9001          	rrwa	y,a
2229  054b 9050          	negw	y
2230  054d ef80          	ldw	(_pwm_sleep,x),y
2231                     ; 451 			led_write_index++;
2233  054f 0c05          	inc	(OFST-2,sp)
2235  0551               L366:
2236                     ; 453 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2238  0551 7b06          	ld	a,(OFST-1,sp)
2239  0553 5f            	clrw	x
2240  0554 97            	ld	xl,a
2241  0555 6f04          	clr	(_pwm_brightness_buffer,x)
2242                     ; 443 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2244  0557 0c06          	inc	(OFST-1,sp)
2248  0559 7b06          	ld	a,(OFST-1,sp)
2249  055b a11f          	cp	a,#31
2250  055d 258a          	jrult	L556
2251                     ; 455 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2253  055f 7b07          	ld	a,(OFST+0,sp)
2254  0561 5f            	clrw	x
2255  0562 97            	ld	xl,a
2256  0563 58            	sllw	x
2257  0564 9093          	ldw	y,x
2258  0566 90ee80        	ldw	y,(_pwm_sleep,y)
2259  0569 90a37c01      	cpw	y,#31745
2260  056d 2406          	jruge	L766
2262  056f e681          	ld	a,(_pwm_sleep+1,x)
2263  0571 ea80          	or	a,(_pwm_sleep,x)
2264  0573 2606          	jrne	L566
2265  0575               L766:
2268  0575 90ae0001      	ldw	y,#1
2269  0579 ef80          	ldw	(_pwm_sleep,x),y
2270  057b               L566:
2271                     ; 456 	if(led_write_index==0)
2273  057b 7b05          	ld	a,(OFST-2,sp)
2274  057d 261f          	jrne	L176
2275                     ; 458 		led_write_index=1;
2277  057f 4c            	inc	a
2278  0580 6b05          	ld	(OFST-2,sp),a
2280                     ; 459 		pwm_sleep[buffer_index]=6<<10;
2282  0582 5f            	clrw	x
2283  0583 7b07          	ld	a,(OFST+0,sp)
2284  0585 97            	ld	xl,a
2285  0586 58            	sllw	x
2286  0587 90ae1800      	ldw	y,#6144
2287  058b ef80          	ldw	(_pwm_sleep,x),y
2288                     ; 460 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2290  058d 5f            	clrw	x
2291  058e 97            	ld	xl,a
2292  058f a612          	ld	a,#18
2293  0591 e723          	ld	(_pwm_brightness_index,x),a
2294                     ; 461 		pwm_brightness[0][buffer_index]=1;
2296  0593 5f            	clrw	x
2297  0594 7b07          	ld	a,(OFST+0,sp)
2298  0596 97            	ld	xl,a
2299  0597 58            	sllw	x
2300  0598 90ae0001      	ldw	y,#1
2301  059c ef04          	ldw	(_pwm_brightness,x),y
2302  059e               L176:
2303                     ; 463 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2305  059e 7b07          	ld	a,(OFST+0,sp)
2306  05a0 5f            	clrw	x
2307  05a1 97            	ld	xl,a
2308  05a2 7b05          	ld	a,(OFST-2,sp)
2309  05a4 e784          	ld	(_pwm_led_count,x),a
2310                     ; 466 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2312  05a6 72120087      	bset	_pwm_state,#1
2313                     ; 467 }
2316  05aa 5b08          	addw	sp,#8
2317  05ac 81            	ret	
2318  05ad               LC004:
2319  05ad 905f          	clrw	y
2320  05af 9097          	ld	yl,a
2321  05b1 9058          	sllw	y
2322  05b3 81            	ret	
2429                     ; 470 void set_hue_max(u8 index,u16 color)
2429                     ; 471 {
2430                     	switch	.text
2431  05b4               _set_hue_max:
2433  05b4 88            	push	a
2434  05b5 5207          	subw	sp,#7
2435       00000007      OFST:	set	7
2438                     ; 474 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2440  05b7 a6b4          	ld	a,#180
2441  05b9 6b06          	ld	(OFST-1,sp),a
2443                     ; 475 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2445  05bb a63d          	ld	a,#61
2446  05bd 6b01          	ld	(OFST-6,sp),a
2448                     ; 476 	u8 red=0,green=0,blue=0;
2450  05bf 0f02          	clr	(OFST-5,sp)
2454  05c1 0f03          	clr	(OFST-4,sp)
2458  05c3 0f04          	clr	(OFST-3,sp)
2460                     ; 477 	u8 residual=0;
2462  05c5 0f07          	clr	(OFST+0,sp)
2464                     ; 479 	for(iter=0;iter<6;iter++)
2466  05c7 0f05          	clr	(OFST-2,sp)
2468  05c9               L567:
2469                     ; 481 		if(color<0x2AAB)
2471  05c9 1e0b          	ldw	x,(OFST+4,sp)
2472  05cb a32aab        	cpw	x,#10923
2473  05ce 2408          	jruge	L377
2474                     ; 483 			residual=color/BRIGHTNESS_STEP;
2476  05d0 7b01          	ld	a,(OFST-6,sp)
2477  05d2 62            	div	x,a
2478  05d3 01            	rrwa	x,a
2479  05d4 6b07          	ld	(OFST+0,sp),a
2481                     ; 484 			break;
2483  05d6 200d          	jra	L177
2484  05d8               L377:
2485                     ; 486 		color-=0x2AAB;
2487  05d8 1d2aab        	subw	x,#10923
2488  05db 1f0b          	ldw	(OFST+4,sp),x
2489                     ; 479 	for(iter=0;iter<6;iter++)
2491  05dd 0c05          	inc	(OFST-2,sp)
2495  05df 7b05          	ld	a,(OFST-2,sp)
2496  05e1 a106          	cp	a,#6
2497  05e3 25e4          	jrult	L567
2498  05e5               L177:
2499                     ; 488 	switch(iter)
2501  05e5 7b05          	ld	a,(OFST-2,sp)
2503                     ; 495 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
2504  05e7 2714          	jreq	L376
2505  05e9 4a            	dec	a
2506  05ea 2719          	jreq	L576
2507  05ec 4a            	dec	a
2508  05ed 271e          	jreq	L776
2509  05ef 4a            	dec	a
2510  05f0 2725          	jreq	L107
2511  05f2 4a            	dec	a
2512  05f3 272c          	jreq	L307
2515  05f5 7b06          	ld	a,(OFST-1,sp)
2516  05f7 6b02          	ld	(OFST-5,sp),a
2520  05f9 1007          	sub	a,(OFST+0,sp)
2523  05fb 2016          	jp	LC006
2524  05fd               L376:
2525                     ; 490 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
2527  05fd 7b06          	ld	a,(OFST-1,sp)
2528  05ff 6b02          	ld	(OFST-5,sp),a
2532  0601 7b07          	ld	a,(OFST+0,sp)
2535  0603 2018          	jp	LC007
2536  0605               L576:
2537                     ; 491 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
2539  0605 7b06          	ld	a,(OFST-1,sp)
2540  0607 6b03          	ld	(OFST-4,sp),a
2544  0609 1007          	sub	a,(OFST+0,sp)
2547  060b 201a          	jp	LC005
2548  060d               L776:
2549                     ; 492 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
2551  060d 7b06          	ld	a,(OFST-1,sp)
2552  060f 6b03          	ld	(OFST-4,sp),a
2556  0611 7b07          	ld	a,(OFST+0,sp)
2557  0613               LC006:
2558  0613 6b04          	ld	(OFST-3,sp),a
2562  0615 2012          	jra	L777
2563  0617               L107:
2564                     ; 493 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
2566  0617 7b06          	ld	a,(OFST-1,sp)
2567  0619 6b04          	ld	(OFST-3,sp),a
2571  061b 1007          	sub	a,(OFST+0,sp)
2572  061d               LC007:
2573  061d 6b03          	ld	(OFST-4,sp),a
2577  061f 2008          	jra	L777
2578  0621               L307:
2579                     ; 494 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
2581  0621 7b06          	ld	a,(OFST-1,sp)
2582  0623 6b04          	ld	(OFST-3,sp),a
2586  0625 7b07          	ld	a,(OFST+0,sp)
2587  0627               LC005:
2588  0627 6b02          	ld	(OFST-5,sp),a
2592  0629               L777:
2593                     ; 503 	set_rgb(index,0,red);
2595  0629 7b02          	ld	a,(OFST-5,sp)
2596  062b 88            	push	a
2597  062c 7b09          	ld	a,(OFST+2,sp)
2598  062e 5f            	clrw	x
2599  062f 95            	ld	xh,a
2600  0630 ad1b          	call	_set_rgb
2602  0632 84            	pop	a
2603                     ; 504 	set_rgb(index,1,green);
2605  0633 7b03          	ld	a,(OFST-4,sp)
2606  0635 88            	push	a
2607  0636 7b09          	ld	a,(OFST+2,sp)
2608  0638 ae0001        	ldw	x,#1
2609  063b 95            	ld	xh,a
2610  063c ad0f          	call	_set_rgb
2612  063e 84            	pop	a
2613                     ; 505 	set_rgb(index,2,blue);
2615  063f 7b04          	ld	a,(OFST-3,sp)
2616  0641 88            	push	a
2617  0642 7b09          	ld	a,(OFST+2,sp)
2618  0644 ae0002        	ldw	x,#2
2619  0647 95            	ld	xh,a
2620  0648 ad03          	call	_set_rgb
2622  064a 5b09          	addw	sp,#9
2623                     ; 506 }
2626  064c 81            	ret	
2679                     ; 510 void set_rgb(u8 index,u8 color,u8 brightness)
2679                     ; 511 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
2680                     	switch	.text
2681  064d               _set_rgb:
2683  064d 89            	pushw	x
2684       00000000      OFST:	set	0
2689  064e a606          	ld	a,#6
2690  0650 42            	mul	x,a
2691  0651 01            	rrwa	x,a
2692  0652 1b01          	add	a,(OFST+1,sp)
2693  0654 2401          	jrnc	L613
2694  0656 5c            	incw	x
2695  0657               L613:
2696  0657 02            	rlwa	x,a
2697  0658 7b05          	ld	a,(OFST+5,sp)
2698  065a e704          	ld	(_pwm_brightness_buffer,x),a
2702  065c 85            	popw	x
2703  065d 81            	ret	
2747                     ; 512 void set_white(u8 index,u8 brightness)
2747                     ; 513 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
2748                     	switch	.text
2749  065e               _set_white:
2751  065e 89            	pushw	x
2752       00000000      OFST:	set	0
2757  065f 9e            	ld	a,xh
2758  0660 5f            	clrw	x
2759  0661 97            	ld	xl,a
2760  0662 7b02          	ld	a,(OFST+2,sp)
2761  0664 e717          	ld	(_pwm_brightness_buffer+19,x),a
2765  0666 85            	popw	x
2766  0667 81            	ret	
2801                     ; 514 void set_debug(u8 brightness)
2801                     ; 515 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
2802                     	switch	.text
2803  0668               _set_debug:
2809  0668 b716          	ld	_pwm_brightness_buffer+18,a
2813  066a 81            	ret	
2943                     	xdef	f_I2C_EventHandler
2944                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2945                     	switch	.ubsct
2946  0000               _button_pressed_event:
2947  0000 00000000      	ds.b	4
2948                     	xdef	_button_pressed_event
2949                     	xdef	_is_right_button_down
2950                     	xdef	_button_start_ms
2951                     	xdef	_pwm_state
2952                     	xdef	_pwm_visible_index
2953                     	xdef	_pwm_led_count
2954                     	xdef	_pwm_sleep
2955  0004               _pwm_brightness_buffer:
2956  0004 000000000000  	ds.b	31
2957                     	xdef	_pwm_brightness_buffer
2958  0023               _pwm_brightness_index:
2959  0023 000000000000  	ds.b	62
2960                     	xdef	_pwm_brightness_index
2961                     	xdef	_pwm_brightness
2962                     	xdef	_atomic_counter
2963                     	xref	_UART1_Cmd
2964                     	xref	_UART1_Init
2965                     	xref	_UART1_DeInit
2966                     	xref	_GPIO_ReadInputPin
2967                     	xref	_GPIO_Init
2968                     	xref	_I2C_ClearITPendingBit
2969                     	xref	_I2C_CheckEvent
2970                     	xref	_I2C_SendData
2971                     	xref	_I2C_ReceiveData
2972                     	xref	_I2C_ITConfig
2973                     	xref	_I2C_AcknowledgeConfig
2974                     	xref	_I2C_Cmd
2975                     	xref	_I2C_Init
2976                     	xref	_I2C_DeInit
2977                     	xdef	_set_led_on
2978                     	xdef	_set_mat
2979                     	xdef	_get_random
2980                     	xdef	_is_button_down
2981                     	xdef	_get_button_event
2982                     	xdef	_update_buttons
2983                     	xdef	_set_hue_max
2984                     	xdef	_flush_leds
2985                     	xdef	_set_debug
2986                     	xdef	_set_white
2987                     	xdef	_set_rgb
2988                     	xdef	_millis
2989                     	xdef	_setup_main
2990                     	xdef	_setup_serial
2991                     	xdef	_hello_world
2992                     	xref.b	c_lreg
2993                     	xref.b	c_x
2994                     	xref.b	c_y
3014                     	xref	c_xymov
3015                     	xref	c_lgadd
3016                     	xref	c_uitolx
3017                     	xref	c_lcmp
3018                     	xref	c_rtol
3019                     	xref	c_lsub
3020                     	xref	c_lzmp
3021                     	xref	c_lursh
3022                     	xref	c_itolx
3023                     	xref	c_ltor
3024                     	xref	c_imul
3025                     	end
