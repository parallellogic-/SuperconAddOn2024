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
 140  0018 cd0589        	call	_set_hue_max
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
 156  002c cd0589        	call	_set_hue_max
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
 172  0040 cd0589        	call	_set_hue_max
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
 188  0054 cd0589        	call	_set_hue_max
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
 204  0068 cd0589        	call	_set_hue_max
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
 220  007c cd0589        	call	_set_hue_max
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
 276  00c2 cd0633        	call	_set_white
 278                     ; 45 		flush_leds(7);
 280  00c5 a607          	ld	a,#7
 281  00c7 cd0495        	call	_flush_leds
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
 731  01a2 cd063d        	call	_set_debug
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
1322  034f cd03de        	call	_set_led_on
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
1400                     ; 224 @far @interrupt void I2C_EventHandler(void)
1400                     ; 225 {
1401                     	switch	.text
1402  0395               f_I2C_EventHandler:
1404  0395 8a            	push	cc
1405  0396 84            	pop	a
1406  0397 a4bf          	and	a,#191
1407  0399 88            	push	a
1408  039a 86            	pop	cc
1409  039b 3b0002        	push	c_x+2
1410  039e be00          	ldw	x,c_x
1411  03a0 89            	pushw	x
1412  03a1 3b0002        	push	c_y+2
1413  03a4 be00          	ldw	x,c_y
1414  03a6 89            	pushw	x
1417                     ; 227     if (I2C_CheckEvent(I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED))
1419  03a7 ae0202        	ldw	x,#514
1420  03aa cd0000        	call	_I2C_CheckEvent
1422  03ad 4d            	tnz	a
1423  03ae 2705          	jreq	L773
1424                     ; 230         I2C_AcknowledgeConfig(I2C_ACK_CURR);
1426  03b0 a601          	ld	a,#1
1427  03b2 cd0000        	call	_I2C_AcknowledgeConfig
1429  03b5               L773:
1430                     ; 234     if (I2C_CheckEvent(I2C_EVENT_SLAVE_BYTE_RECEIVED))
1432  03b5 ae0240        	ldw	x,#576
1433  03b8 cd0000        	call	_I2C_CheckEvent
1435  03bb 4d            	tnz	a
1436  03bc 2705          	jreq	L104
1437                     ; 244         I2C_AcknowledgeConfig(I2C_ACK_CURR);  // Send ACK
1439  03be a601          	ld	a,#1
1440  03c0 cd0000        	call	_I2C_AcknowledgeConfig
1442  03c3               L104:
1443                     ; 248     if (I2C_CheckEvent(I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED))
1445  03c3 ae0682        	ldw	x,#1666
1446  03c6 cd0000        	call	_I2C_CheckEvent
1448  03c9 4d            	tnz	a
1449                     ; 254     if (I2C_CheckEvent(I2C_EVENT_SLAVE_BYTE_TRANSMITTED))
1451  03ca ae0684        	ldw	x,#1668
1452  03cd cd0000        	call	_I2C_CheckEvent
1454  03d0 4d            	tnz	a
1455                     ; 265 }
1458  03d1 85            	popw	x
1459  03d2 bf00          	ldw	c_y,x
1460  03d4 320002        	pop	c_y+2
1461  03d7 85            	popw	x
1462  03d8 bf00          	ldw	c_x,x
1463  03da 320002        	pop	c_x+2
1464  03dd 80            	iret	
1466                     	switch	.const
1467  000c               L704_led_lookup:
1468  000c 04            	dc.b	4
1469  000d 03            	dc.b	3
1470  000e 03            	dc.b	3
1471  000f 04            	dc.b	4
1472  0010 00            	dc.b	0
1473  0011 05            	dc.b	5
1474  0012 00            	dc.b	0
1475  0013 04            	dc.b	4
1476  0014 00            	dc.b	0
1477  0015 03            	dc.b	3
1478  0016 00            	dc.b	0
1479  0017 01            	dc.b	1
1480  0018 05            	dc.b	5
1481  0019 03            	dc.b	3
1482  001a 03            	dc.b	3
1483  001b 05            	dc.b	5
1484  001c 00            	dc.b	0
1485  001d 06            	dc.b	6
1486  001e 01            	dc.b	1
1487  001f 04            	dc.b	4
1488  0020 01            	dc.b	1
1489  0021 03            	dc.b	3
1490  0022 00            	dc.b	0
1491  0023 02            	dc.b	2
1492  0024 06            	dc.b	6
1493  0025 03            	dc.b	3
1494  0026 03            	dc.b	3
1495  0027 06            	dc.b	6
1496  0028 01            	dc.b	1
1497  0029 06            	dc.b	6
1498  002a 02            	dc.b	2
1499  002b 04            	dc.b	4
1500  002c 02            	dc.b	2
1501  002d 03            	dc.b	3
1502  002e 01            	dc.b	1
1503  002f 02            	dc.b	2
1504  0030 07            	dc.b	7
1505  0031 07            	dc.b	7
1506  0032 03            	dc.b	3
1507  0033 00            	dc.b	0
1508  0034 03            	dc.b	3
1509  0035 01            	dc.b	1
1510  0036 03            	dc.b	3
1511  0037 02            	dc.b	2
1512  0038 04            	dc.b	4
1513  0039 00            	dc.b	0
1514  003a 01            	dc.b	1
1515  003b 05            	dc.b	5
1516  003c 02            	dc.b	2
1517  003d 05            	dc.b	5
1518  003e 04            	dc.b	4
1519  003f 01            	dc.b	1
1520  0040 04            	dc.b	4
1521  0041 02            	dc.b	2
1522  0042 02            	dc.b	2
1523  0043 06            	dc.b	6
1524  0044 04            	dc.b	4
1525  0045 06            	dc.b	6
1526  0046 04            	dc.b	4
1527  0047 05            	dc.b	5
1528  0048 05            	dc.b	5
1529  0049 06            	dc.b	6
1573                     ; 268 void set_led_on(u8 led_index)
1573                     ; 269 {
1575                     	switch	.text
1576  03de               _set_led_on:
1578  03de 88            	push	a
1579  03df 5240          	subw	sp,#64
1580       00000040      OFST:	set	64
1583                     ; 306 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1583                     ; 307 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1583                     ; 308 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1583                     ; 309 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1583                     ; 310 		{7,7},//debug; GND is tied low, no charlieplexing involved
1583                     ; 311 		{3,0},//LED6
1583                     ; 312 		{3,1},//LED4
1583                     ; 313 		{3,2},//LED5
1583                     ; 314 		{4,0},//LED14
1583                     ; 315 		{1,5},//LED8
1583                     ; 316 		{2,5},//LED9
1583                     ; 317 		{4,1},//LED10
1583                     ; 318 		{4,2},//LED16
1583                     ; 319 		{2,6},//LED17
1583                     ; 320 		{4,6},//LED12
1583                     ; 321 		{4,5},//LED13
1583                     ; 322 		{5,6} //LED11
1583                     ; 323 	};
1585  03e1 96            	ldw	x,sp
1586  03e2 1c0003        	addw	x,#OFST-61
1587  03e5 90ae000c      	ldw	y,#L704_led_lookup
1588  03e9 a63e          	ld	a,#62
1589  03eb cd0000        	call	c_xymov
1591                     ; 324 	set_mat(led_lookup[led_index][0],1);
1593  03ee 96            	ldw	x,sp
1594  03ef 1c0003        	addw	x,#OFST-61
1595  03f2 1f01          	ldw	(OFST-63,sp),x
1597  03f4 5f            	clrw	x
1598  03f5 7b41          	ld	a,(OFST+1,sp)
1599  03f7 97            	ld	xl,a
1600  03f8 58            	sllw	x
1601  03f9 72fb01        	addw	x,(OFST-63,sp)
1602  03fc f6            	ld	a,(x)
1603  03fd ae0001        	ldw	x,#1
1604  0400 95            	ld	xh,a
1605  0401 ad1a          	call	_set_mat
1607                     ; 326 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1609  0403 7b41          	ld	a,(OFST+1,sp)
1610  0405 a112          	cp	a,#18
1611  0407 2711          	jreq	L334
1614  0409 96            	ldw	x,sp
1615  040a 1c0004        	addw	x,#OFST-60
1616  040d 1f01          	ldw	(OFST-63,sp),x
1618  040f 5f            	clrw	x
1619  0410 97            	ld	xl,a
1620  0411 58            	sllw	x
1621  0412 72fb01        	addw	x,(OFST-63,sp)
1622  0415 f6            	ld	a,(x)
1623  0416 5f            	clrw	x
1624  0417 95            	ld	xh,a
1625  0418 ad03          	call	_set_mat
1627  041a               L334:
1628                     ; 328 }
1631  041a 5b41          	addw	sp,#65
1632  041c 81            	ret	
1833                     ; 333 void set_mat(u8 mat_index,bool is_high)
1833                     ; 334 {
1834                     	switch	.text
1835  041d               _set_mat:
1837  041d 89            	pushw	x
1838  041e 5203          	subw	sp,#3
1839       00000003      OFST:	set	3
1842                     ; 372 	switch(mat_index)//DEBUG_BROKEN
1844  0420 9e            	ld	a,xh
1846                     ; 381 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
1847  0421 4d            	tnz	a
1848  0422 2717          	jreq	L534
1849  0424 4a            	dec	a
1850  0425 271d          	jreq	L734
1851  0427 4a            	dec	a
1852  0428 2723          	jreq	L144
1853  042a 4a            	dec	a
1854  042b 2729          	jreq	L344
1855  042d 4a            	dec	a
1856  042e 272f          	jreq	L544
1857  0430 4a            	dec	a
1858  0431 2735          	jreq	L744
1859  0433 4a            	dec	a
1860  0434 273b          	jreq	L154
1863  0436 ae5000        	ldw	x,#20480
1867  0439 2039          	jp	LC003
1868  043b               L534:
1869                     ; 374 		case 0:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_4; break;
1871  043b ae500f        	ldw	x,#20495
1872  043e 1f01          	ldw	(OFST-2,sp),x
1876  0440 a610          	ld	a,#16
1879  0442 2034          	jra	L575
1880  0444               L734:
1881                     ; 375 		case 1:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
1883  0444 ae500f        	ldw	x,#20495
1884  0447 1f01          	ldw	(OFST-2,sp),x
1888  0449 a604          	ld	a,#4
1891  044b 202b          	jra	L575
1892  044d               L144:
1893                     ; 376 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
1895  044d ae500a        	ldw	x,#20490
1896  0450 1f01          	ldw	(OFST-2,sp),x
1900  0452 a680          	ld	a,#128
1903  0454 2022          	jra	L575
1904  0456               L344:
1905                     ; 377 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
1907  0456 ae500a        	ldw	x,#20490
1908  0459 1f01          	ldw	(OFST-2,sp),x
1912  045b a640          	ld	a,#64
1915  045d 2019          	jra	L575
1916  045f               L544:
1917                     ; 378 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
1919  045f ae500a        	ldw	x,#20490
1920  0462 1f01          	ldw	(OFST-2,sp),x
1924  0464 a620          	ld	a,#32
1927  0466 2010          	jra	L575
1928  0468               L744:
1929                     ; 379 		case 5:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
1931  0468 ae500a        	ldw	x,#20490
1932  046b 1f01          	ldw	(OFST-2,sp),x
1936  046d a610          	ld	a,#16
1939  046f 2007          	jra	L575
1940  0471               L154:
1941                     ; 380 		case 6:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
1943  0471 ae500a        	ldw	x,#20490
1946  0474               LC003:
1947  0474 1f01          	ldw	(OFST-2,sp),x
1950  0476 a608          	ld	a,#8
1953  0478               L575:
1954  0478 6b03          	ld	(OFST+0,sp),a
1956                     ; 423 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1958  047a 0d05          	tnz	(OFST+2,sp)
1959  047c 2705          	jreq	L775
1962  047e f6            	ld	a,(x)
1963  047f 1a03          	or	a,(OFST+0,sp)
1965  0481 2002          	jra	L106
1966  0483               L775:
1967                     ; 424 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1969  0483 43            	cpl	a
1970  0484 f4            	and	a,(x)
1971  0485               L106:
1972  0485 f7            	ld	(x),a
1973                     ; 425 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
1975  0486 e602          	ld	a,(2,x)
1976  0488 1a03          	or	a,(OFST+0,sp)
1977  048a e702          	ld	(2,x),a
1978                     ; 426 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1980  048c e603          	ld	a,(3,x)
1981  048e 1a03          	or	a,(OFST+0,sp)
1982  0490 e703          	ld	(3,x),a
1983                     ; 427 }
1986  0492 5b05          	addw	sp,#5
1987  0494 81            	ret	
2063                     ; 430 void flush_leds(u8 led_count)
2063                     ; 431 {
2064                     	switch	.text
2065  0495               _flush_leds:
2067  0495 88            	push	a
2068  0496 5207          	subw	sp,#7
2069       00000007      OFST:	set	7
2072                     ; 432 	u8 led_read_index=0,led_write_index=0;
2076  0498 0f05          	clr	(OFST-2,sp)
2079  049a               L546:
2080                     ; 435 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2082  049a 72020087fb    	btjt	_pwm_state,#1,L546
2083                     ; 436 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2085  049f b687          	ld	a,_pwm_state
2086  04a1 a401          	and	a,#1
2087  04a3 a801          	xor	a,#1
2088  04a5 6b07          	ld	(OFST+0,sp),a
2090                     ; 438 	if(led_count==0) led_count=1;//min value
2092  04a7 7b08          	ld	a,(OFST+1,sp)
2093  04a9 2603          	jrne	L156
2096  04ab 4c            	inc	a
2097  04ac 6b08          	ld	(OFST+1,sp),a
2098  04ae               L156:
2099                     ; 439 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2101  04ae 97            	ld	xl,a
2102  04af 4f            	clr	a
2103  04b0 02            	rlwa	x,a
2104  04b1 58            	sllw	x
2105  04b2 58            	sllw	x
2106  04b3 7b07          	ld	a,(OFST+0,sp)
2107  04b5 cd0582        	call	LC004
2108                     ; 441 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2110  04b8 4f            	clr	a
2111  04b9 90ef80        	ldw	(_pwm_sleep,y),x
2112  04bc 6b06          	ld	(OFST-1,sp),a
2114  04be               L356:
2115                     ; 443 		read_brightness=pwm_brightness_buffer[led_read_index];
2117  04be 5f            	clrw	x
2118  04bf 97            	ld	xl,a
2119  04c0 e604          	ld	a,(_pwm_brightness_buffer,x)
2120  04c2 5f            	clrw	x
2121  04c3 97            	ld	xl,a
2122  04c4 1f03          	ldw	(OFST-4,sp),x
2124                     ; 444 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2126  04c6 275e          	jreq	L166
2127                     ; 446 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2129  04c8 7b05          	ld	a,(OFST-2,sp)
2130  04ca 5f            	clrw	x
2131  04cb 97            	ld	xl,a
2132  04cc 58            	sllw	x
2133  04cd 01            	rrwa	x,a
2134  04ce 1b07          	add	a,(OFST+0,sp)
2135  04d0 2401          	jrnc	L262
2136  04d2 5c            	incw	x
2137  04d3               L262:
2138  04d3 02            	rlwa	x,a
2139  04d4 7b06          	ld	a,(OFST-1,sp)
2140  04d6 e723          	ld	(_pwm_brightness_index,x),a
2141                     ; 447 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2143  04d8 1e03          	ldw	x,(OFST-4,sp)
2144  04da 9093          	ldw	y,x
2145  04dc cd0000        	call	c_imul
2147  04df a606          	ld	a,#6
2148  04e1               L462:
2149  04e1 54            	srlw	x
2150  04e2 4a            	dec	a
2151  04e3 26fc          	jrne	L462
2152  04e5 5c            	incw	x
2153  04e6 7b07          	ld	a,(OFST+0,sp)
2154  04e8 cd0582        	call	LC004
2155  04eb 1701          	ldw	(OFST-6,sp),y
2157  04ed 905f          	clrw	y
2158  04ef 7b05          	ld	a,(OFST-2,sp)
2159  04f1 9097          	ld	yl,a
2160  04f3 9058          	sllw	y
2161  04f5 9058          	sllw	y
2162  04f7 72f901        	addw	y,(OFST-6,sp)
2163  04fa 90ef04        	ldw	(_pwm_brightness,y),x
2164                     ; 448 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2166  04fd 5f            	clrw	x
2167  04fe 7b07          	ld	a,(OFST+0,sp)
2168  0500 97            	ld	xl,a
2169  0501 58            	sllw	x
2170  0502 ad7e          	call	LC004
2171  0504 1701          	ldw	(OFST-6,sp),y
2173  0506 905f          	clrw	y
2174  0508 7b05          	ld	a,(OFST-2,sp)
2175  050a 9097          	ld	yl,a
2176  050c 9058          	sllw	y
2177  050e 9058          	sllw	y
2178  0510 72f901        	addw	y,(OFST-6,sp)
2179  0513 90ee04        	ldw	y,(_pwm_brightness,y)
2180  0516 9001          	rrwa	y,a
2181  0518 e081          	sub	a,(_pwm_sleep+1,x)
2182  051a 9001          	rrwa	y,a
2183  051c e280          	sbc	a,(_pwm_sleep,x)
2184  051e 9001          	rrwa	y,a
2185  0520 9050          	negw	y
2186  0522 ef80          	ldw	(_pwm_sleep,x),y
2187                     ; 449 			led_write_index++;
2189  0524 0c05          	inc	(OFST-2,sp)
2191  0526               L166:
2192                     ; 451 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2194  0526 7b06          	ld	a,(OFST-1,sp)
2195  0528 5f            	clrw	x
2196  0529 97            	ld	xl,a
2197  052a 6f04          	clr	(_pwm_brightness_buffer,x)
2198                     ; 441 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2200  052c 0c06          	inc	(OFST-1,sp)
2204  052e 7b06          	ld	a,(OFST-1,sp)
2205  0530 a11f          	cp	a,#31
2206  0532 258a          	jrult	L356
2207                     ; 453 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2209  0534 7b07          	ld	a,(OFST+0,sp)
2210  0536 5f            	clrw	x
2211  0537 97            	ld	xl,a
2212  0538 58            	sllw	x
2213  0539 9093          	ldw	y,x
2214  053b 90ee80        	ldw	y,(_pwm_sleep,y)
2215  053e 90a37c01      	cpw	y,#31745
2216  0542 2406          	jruge	L566
2218  0544 e681          	ld	a,(_pwm_sleep+1,x)
2219  0546 ea80          	or	a,(_pwm_sleep,x)
2220  0548 2606          	jrne	L366
2221  054a               L566:
2224  054a 90ae0001      	ldw	y,#1
2225  054e ef80          	ldw	(_pwm_sleep,x),y
2226  0550               L366:
2227                     ; 454 	if(led_write_index==0)
2229  0550 7b05          	ld	a,(OFST-2,sp)
2230  0552 261f          	jrne	L766
2231                     ; 456 		led_write_index=1;
2233  0554 4c            	inc	a
2234  0555 6b05          	ld	(OFST-2,sp),a
2236                     ; 457 		pwm_sleep[buffer_index]=6<<10;
2238  0557 5f            	clrw	x
2239  0558 7b07          	ld	a,(OFST+0,sp)
2240  055a 97            	ld	xl,a
2241  055b 58            	sllw	x
2242  055c 90ae1800      	ldw	y,#6144
2243  0560 ef80          	ldw	(_pwm_sleep,x),y
2244                     ; 458 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2246  0562 5f            	clrw	x
2247  0563 97            	ld	xl,a
2248  0564 a612          	ld	a,#18
2249  0566 e723          	ld	(_pwm_brightness_index,x),a
2250                     ; 459 		pwm_brightness[0][buffer_index]=1;
2252  0568 5f            	clrw	x
2253  0569 7b07          	ld	a,(OFST+0,sp)
2254  056b 97            	ld	xl,a
2255  056c 58            	sllw	x
2256  056d 90ae0001      	ldw	y,#1
2257  0571 ef04          	ldw	(_pwm_brightness,x),y
2258  0573               L766:
2259                     ; 461 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2261  0573 7b07          	ld	a,(OFST+0,sp)
2262  0575 5f            	clrw	x
2263  0576 97            	ld	xl,a
2264  0577 7b05          	ld	a,(OFST-2,sp)
2265  0579 e784          	ld	(_pwm_led_count,x),a
2266                     ; 464 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2268  057b 72120087      	bset	_pwm_state,#1
2269                     ; 465 }
2272  057f 5b08          	addw	sp,#8
2273  0581 81            	ret	
2274  0582               LC004:
2275  0582 905f          	clrw	y
2276  0584 9097          	ld	yl,a
2277  0586 9058          	sllw	y
2278  0588 81            	ret	
2385                     ; 468 void set_hue_max(u8 index,u16 color)
2385                     ; 469 {
2386                     	switch	.text
2387  0589               _set_hue_max:
2389  0589 88            	push	a
2390  058a 5207          	subw	sp,#7
2391       00000007      OFST:	set	7
2394                     ; 472 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2396  058c a6b4          	ld	a,#180
2397  058e 6b06          	ld	(OFST-1,sp),a
2399                     ; 473 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2401  0590 a63d          	ld	a,#61
2402  0592 6b01          	ld	(OFST-6,sp),a
2404                     ; 474 	u8 red=0,green=0,blue=0;
2406  0594 0f02          	clr	(OFST-5,sp)
2410  0596 0f03          	clr	(OFST-4,sp)
2414  0598 0f04          	clr	(OFST-3,sp)
2416                     ; 475 	u8 residual=0;
2418  059a 0f07          	clr	(OFST+0,sp)
2420                     ; 477 	for(iter=0;iter<6;iter++)
2422  059c 0f05          	clr	(OFST-2,sp)
2424  059e               L367:
2425                     ; 479 		if(color<0x2AAB)
2427  059e 1e0b          	ldw	x,(OFST+4,sp)
2428  05a0 a32aab        	cpw	x,#10923
2429  05a3 2408          	jruge	L177
2430                     ; 481 			residual=color/BRIGHTNESS_STEP;
2432  05a5 7b01          	ld	a,(OFST-6,sp)
2433  05a7 62            	div	x,a
2434  05a8 01            	rrwa	x,a
2435  05a9 6b07          	ld	(OFST+0,sp),a
2437                     ; 482 			break;
2439  05ab 200d          	jra	L767
2440  05ad               L177:
2441                     ; 484 		color-=0x2AAB;
2443  05ad 1d2aab        	subw	x,#10923
2444  05b0 1f0b          	ldw	(OFST+4,sp),x
2445                     ; 477 	for(iter=0;iter<6;iter++)
2447  05b2 0c05          	inc	(OFST-2,sp)
2451  05b4 7b05          	ld	a,(OFST-2,sp)
2452  05b6 a106          	cp	a,#6
2453  05b8 25e4          	jrult	L367
2454  05ba               L767:
2455                     ; 486 	switch(iter)
2457  05ba 7b05          	ld	a,(OFST-2,sp)
2459                     ; 493 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
2460  05bc 2714          	jreq	L176
2461  05be 4a            	dec	a
2462  05bf 2719          	jreq	L376
2463  05c1 4a            	dec	a
2464  05c2 271e          	jreq	L576
2465  05c4 4a            	dec	a
2466  05c5 2725          	jreq	L776
2467  05c7 4a            	dec	a
2468  05c8 272c          	jreq	L107
2471  05ca 7b06          	ld	a,(OFST-1,sp)
2472  05cc 6b02          	ld	(OFST-5,sp),a
2476  05ce 1007          	sub	a,(OFST+0,sp)
2479  05d0 2016          	jp	LC006
2480  05d2               L176:
2481                     ; 488 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
2483  05d2 7b06          	ld	a,(OFST-1,sp)
2484  05d4 6b02          	ld	(OFST-5,sp),a
2488  05d6 7b07          	ld	a,(OFST+0,sp)
2491  05d8 2018          	jp	LC007
2492  05da               L376:
2493                     ; 489 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
2495  05da 7b06          	ld	a,(OFST-1,sp)
2496  05dc 6b03          	ld	(OFST-4,sp),a
2500  05de 1007          	sub	a,(OFST+0,sp)
2503  05e0 201a          	jp	LC005
2504  05e2               L576:
2505                     ; 490 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
2507  05e2 7b06          	ld	a,(OFST-1,sp)
2508  05e4 6b03          	ld	(OFST-4,sp),a
2512  05e6 7b07          	ld	a,(OFST+0,sp)
2513  05e8               LC006:
2514  05e8 6b04          	ld	(OFST-3,sp),a
2518  05ea 2012          	jra	L577
2519  05ec               L776:
2520                     ; 491 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
2522  05ec 7b06          	ld	a,(OFST-1,sp)
2523  05ee 6b04          	ld	(OFST-3,sp),a
2527  05f0 1007          	sub	a,(OFST+0,sp)
2528  05f2               LC007:
2529  05f2 6b03          	ld	(OFST-4,sp),a
2533  05f4 2008          	jra	L577
2534  05f6               L107:
2535                     ; 492 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
2537  05f6 7b06          	ld	a,(OFST-1,sp)
2538  05f8 6b04          	ld	(OFST-3,sp),a
2542  05fa 7b07          	ld	a,(OFST+0,sp)
2543  05fc               LC005:
2544  05fc 6b02          	ld	(OFST-5,sp),a
2548  05fe               L577:
2549                     ; 501 	set_rgb(index,0,red);
2551  05fe 7b02          	ld	a,(OFST-5,sp)
2552  0600 88            	push	a
2553  0601 7b09          	ld	a,(OFST+2,sp)
2554  0603 5f            	clrw	x
2555  0604 95            	ld	xh,a
2556  0605 ad1b          	call	_set_rgb
2558  0607 84            	pop	a
2559                     ; 502 	set_rgb(index,1,green);
2561  0608 7b03          	ld	a,(OFST-4,sp)
2562  060a 88            	push	a
2563  060b 7b09          	ld	a,(OFST+2,sp)
2564  060d ae0001        	ldw	x,#1
2565  0610 95            	ld	xh,a
2566  0611 ad0f          	call	_set_rgb
2568  0613 84            	pop	a
2569                     ; 503 	set_rgb(index,2,blue);
2571  0614 7b04          	ld	a,(OFST-3,sp)
2572  0616 88            	push	a
2573  0617 7b09          	ld	a,(OFST+2,sp)
2574  0619 ae0002        	ldw	x,#2
2575  061c 95            	ld	xh,a
2576  061d ad03          	call	_set_rgb
2578  061f 5b09          	addw	sp,#9
2579                     ; 504 }
2582  0621 81            	ret	
2635                     ; 508 void set_rgb(u8 index,u8 color,u8 brightness)
2635                     ; 509 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
2636                     	switch	.text
2637  0622               _set_rgb:
2639  0622 89            	pushw	x
2640       00000000      OFST:	set	0
2645  0623 a606          	ld	a,#6
2646  0625 42            	mul	x,a
2647  0626 01            	rrwa	x,a
2648  0627 1b01          	add	a,(OFST+1,sp)
2649  0629 2401          	jrnc	L003
2650  062b 5c            	incw	x
2651  062c               L003:
2652  062c 02            	rlwa	x,a
2653  062d 7b05          	ld	a,(OFST+5,sp)
2654  062f e704          	ld	(_pwm_brightness_buffer,x),a
2658  0631 85            	popw	x
2659  0632 81            	ret	
2703                     ; 510 void set_white(u8 index,u8 brightness)
2703                     ; 511 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
2704                     	switch	.text
2705  0633               _set_white:
2707  0633 89            	pushw	x
2708       00000000      OFST:	set	0
2713  0634 9e            	ld	a,xh
2714  0635 5f            	clrw	x
2715  0636 97            	ld	xl,a
2716  0637 7b02          	ld	a,(OFST+2,sp)
2717  0639 e717          	ld	(_pwm_brightness_buffer+19,x),a
2721  063b 85            	popw	x
2722  063c 81            	ret	
2757                     ; 512 void set_debug(u8 brightness)
2757                     ; 513 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
2758                     	switch	.text
2759  063d               _set_debug:
2765  063d b716          	ld	_pwm_brightness_buffer+18,a
2769  063f 81            	ret	
2899                     	xdef	f_I2C_EventHandler
2900                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2901                     	switch	.ubsct
2902  0000               _button_pressed_event:
2903  0000 00000000      	ds.b	4
2904                     	xdef	_button_pressed_event
2905                     	xdef	_is_right_button_down
2906                     	xdef	_button_start_ms
2907                     	xdef	_pwm_state
2908                     	xdef	_pwm_visible_index
2909                     	xdef	_pwm_led_count
2910                     	xdef	_pwm_sleep
2911  0004               _pwm_brightness_buffer:
2912  0004 000000000000  	ds.b	31
2913                     	xdef	_pwm_brightness_buffer
2914  0023               _pwm_brightness_index:
2915  0023 000000000000  	ds.b	62
2916                     	xdef	_pwm_brightness_index
2917                     	xdef	_pwm_brightness
2918                     	xdef	_atomic_counter
2919                     	xref	_UART1_Cmd
2920                     	xref	_UART1_Init
2921                     	xref	_UART1_DeInit
2922                     	xref	_GPIO_ReadInputPin
2923                     	xref	_GPIO_Init
2924                     	xref	_I2C_CheckEvent
2925                     	xref	_I2C_ITConfig
2926                     	xref	_I2C_AcknowledgeConfig
2927                     	xref	_I2C_Cmd
2928                     	xref	_I2C_Init
2929                     	xref	_I2C_DeInit
2930                     	xdef	_set_led_on
2931                     	xdef	_set_mat
2932                     	xdef	_get_random
2933                     	xdef	_is_button_down
2934                     	xdef	_get_button_event
2935                     	xdef	_update_buttons
2936                     	xdef	_set_hue_max
2937                     	xdef	_flush_leds
2938                     	xdef	_set_debug
2939                     	xdef	_set_white
2940                     	xdef	_set_rgb
2941                     	xdef	_millis
2942                     	xdef	_setup_main
2943                     	xdef	_setup_serial
2944                     	xdef	_hello_world
2945                     	xref.b	c_lreg
2946                     	xref.b	c_x
2947                     	xref.b	c_y
2967                     	xref	c_xymov
2968                     	xref	c_lgadd
2969                     	xref	c_uitolx
2970                     	xref	c_lcmp
2971                     	xref	c_rtol
2972                     	xref	c_lsub
2973                     	xref	c_lzmp
2974                     	xref	c_lursh
2975                     	xref	c_itolx
2976                     	xref	c_ltor
2977                     	xref	c_imul
2978                     	end
