   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _frame_counter:
  16  0000 00            	dc.b	0
  17  0001               _pwm_brightness:
  18  0001 0001          	dc.w	1
  19  0003 0001          	dc.w	1
  20  0005 000000000000  	ds.b	124
  21  0081               _pwm_sleep:
  22  0081 0001          	dc.w	1
  23  0083 0001          	dc.w	1
  24  0085               _pwm_led_count:
  25  0085 01            	dc.b	1
  26  0086 01            	dc.b	1
  27  0087               _pwm_visible_index:
  28  0087 00            	dc.b	0
  29  0088               _pwm_state:
  30  0088 00            	dc.b	0
  74                     ; 31 void hello_world()
  74                     ; 32 {//basic program that blinks the debug LED ON/OFF
  76                     	switch	.text
  77  0000               _hello_world:
  79  0000 89            	pushw	x
  80       00000002      OFST:	set	2
  83                     ; 33 	u16 frame=0;
  85  0001 5f            	clrw	x
  86  0002 1f01          	ldw	(OFST-1,sp),x
  88  0004               L72:
  89                     ; 36 		frame++;
  91  0004 1e01          	ldw	x,(OFST-1,sp)
  92  0006 1c0001        	addw	x,#1
  93  0009 1f01          	ldw	(OFST-1,sp),x
  95                     ; 37 		set_hue_max(0,(frame<<10));
  97  000b 1e01          	ldw	x,(OFST-1,sp)
  98  000d 4f            	clr	a
  99  000e 02            	rlwa	x,a
 100  000f 58            	sllw	x
 101  0010 58            	sllw	x
 102  0011 89            	pushw	x
 103  0012 4f            	clr	a
 104  0013 cd051f        	call	_set_hue_max
 106  0016 85            	popw	x
 107                     ; 38 		set_hue_max(5,(frame<<10)+0x2AAB);
 109  0017 1e01          	ldw	x,(OFST-1,sp)
 110  0019 4f            	clr	a
 111  001a 02            	rlwa	x,a
 112  001b 58            	sllw	x
 113  001c 58            	sllw	x
 114  001d 1c2aab        	addw	x,#10923
 115  0020 89            	pushw	x
 116  0021 a605          	ld	a,#5
 117  0023 cd051f        	call	_set_hue_max
 119  0026 85            	popw	x
 120                     ; 39 		set_hue_max(6,(frame<<10)+0x5556);
 122  0027 1e01          	ldw	x,(OFST-1,sp)
 123  0029 4f            	clr	a
 124  002a 02            	rlwa	x,a
 125  002b 58            	sllw	x
 126  002c 58            	sllw	x
 127  002d 1c5556        	addw	x,#21846
 128  0030 89            	pushw	x
 129  0031 a606          	ld	a,#6
 130  0033 cd051f        	call	_set_hue_max
 132  0036 85            	popw	x
 133                     ; 40 		set_hue_max(7,(frame<<10)+0x8000);
 135  0037 1e01          	ldw	x,(OFST-1,sp)
 136  0039 4f            	clr	a
 137  003a 02            	rlwa	x,a
 138  003b 58            	sllw	x
 139  003c 58            	sllw	x
 140  003d 1c8000        	addw	x,#32768
 141  0040 89            	pushw	x
 142  0041 a607          	ld	a,#7
 143  0043 cd051f        	call	_set_hue_max
 145  0046 85            	popw	x
 146                     ; 41 		set_hue_max(8,(frame<<10)+0xAAAB);
 148  0047 1e01          	ldw	x,(OFST-1,sp)
 149  0049 4f            	clr	a
 150  004a 02            	rlwa	x,a
 151  004b 58            	sllw	x
 152  004c 58            	sllw	x
 153  004d 1caaab        	addw	x,#43691
 154  0050 89            	pushw	x
 155  0051 a608          	ld	a,#8
 156  0053 cd051f        	call	_set_hue_max
 158  0056 85            	popw	x
 159                     ; 42 		set_hue_max(9,(frame<<10)+0xD554);
 161  0057 1e01          	ldw	x,(OFST-1,sp)
 162  0059 4f            	clr	a
 163  005a 02            	rlwa	x,a
 164  005b 58            	sllw	x
 165  005c 58            	sllw	x
 166  005d 1cd554        	addw	x,#54612
 167  0060 89            	pushw	x
 168  0061 a609          	ld	a,#9
 169  0063 cd051f        	call	_set_hue_max
 171  0066 85            	popw	x
 172                     ; 43 		set_white(0,(frame>>6)&0x01?(frame<<2):(~(frame<<2)));
 174  0067 7b02          	ld	a,(OFST+0,sp)
 175  0069 4e            	swap	a
 176  006a 44            	srl	a
 177  006b 44            	srl	a
 178  006c a403          	and	a,#3
 179  006e 5f            	clrw	x
 180  006f a401          	and	a,#1
 181  0071 5f            	clrw	x
 182  0072 5f            	clrw	x
 183  0073 97            	ld	xl,a
 184  0074 a30000        	cpw	x,#0
 185  0077 2706          	jreq	L6
 186  0079 7b02          	ld	a,(OFST+0,sp)
 187  007b 48            	sll	a
 188  007c 48            	sll	a
 189  007d 2005          	jra	L01
 190  007f               L6:
 191  007f 7b02          	ld	a,(OFST+0,sp)
 192  0081 48            	sll	a
 193  0082 48            	sll	a
 194  0083 43            	cpl	a
 195  0084               L01:
 196  0084 5f            	clrw	x
 197  0085 97            	ld	xl,a
 198  0086 cd05dd        	call	_set_white
 200                     ; 44 		set_debug(  (frame>>6)&0x01?(~(frame<<2)):(frame<<2));
 202  0089 7b02          	ld	a,(OFST+0,sp)
 203  008b 4e            	swap	a
 204  008c 44            	srl	a
 205  008d 44            	srl	a
 206  008e a403          	and	a,#3
 207  0090 5f            	clrw	x
 208  0091 a401          	and	a,#1
 209  0093 5f            	clrw	x
 210  0094 5f            	clrw	x
 211  0095 97            	ld	xl,a
 212  0096 a30000        	cpw	x,#0
 213  0099 2707          	jreq	L21
 214  009b 7b02          	ld	a,(OFST+0,sp)
 215  009d 48            	sll	a
 216  009e 48            	sll	a
 217  009f 43            	cpl	a
 218  00a0 2004          	jra	L41
 219  00a2               L21:
 220  00a2 7b02          	ld	a,(OFST+0,sp)
 221  00a4 48            	sll	a
 222  00a5 48            	sll	a
 223  00a6               L41:
 224  00a6 cd05e7        	call	_set_debug
 226                     ; 45 		flush_leds(10);
 228  00a9 a60a          	ld	a,#10
 229  00ab cd0457        	call	_flush_leds
 232  00ae ac040004      	jpf	L72
 284                     ; 49 u16 get_random(u16 x)
 284                     ; 50 {
 285                     	switch	.text
 286  00b2               _get_random:
 288  00b2 5204          	subw	sp,#4
 289       00000004      OFST:	set	4
 292                     ; 51 	u16 a=1664525;
 294                     ; 52 	u16 c=1013904223;
 296                     ; 53 	return a * x + c;
 298  00b4 90ae660d      	ldw	y,#26125
 299  00b8 cd0000        	call	c_imul
 301  00bb 1cf35f        	addw	x,#62303
 304  00be 5b04          	addw	sp,#4
 305  00c0 81            	ret
 374                     .const:	section	.text
 375  0000               L42:
 376  0000 0000e100      	dc.l	57600
 377                     ; 56 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 377                     ; 57 {
 378                     	switch	.text
 379  00c1               _setup_serial:
 381  00c1 89            	pushw	x
 382       00000000      OFST:	set	0
 385                     ; 58 	if(is_enabled)
 387  00c2 9e            	ld	a,xh
 388  00c3 4d            	tnz	a
 389  00c4 2747          	jreq	L311
 390                     ; 60 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 392  00c6 4bf0          	push	#240
 393  00c8 4b20          	push	#32
 394  00ca ae500f        	ldw	x,#20495
 395  00cd cd0000        	call	_GPIO_Init
 397  00d0 85            	popw	x
 398                     ; 61 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 400  00d1 4b40          	push	#64
 401  00d3 4b40          	push	#64
 402  00d5 ae500f        	ldw	x,#20495
 403  00d8 cd0000        	call	_GPIO_Init
 405  00db 85            	popw	x
 406                     ; 62 		UART1_DeInit();
 408  00dc cd0000        	call	_UART1_DeInit
 410                     ; 63 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 412  00df 4b0c          	push	#12
 413  00e1 4b80          	push	#128
 414  00e3 4b00          	push	#0
 415  00e5 4b00          	push	#0
 416  00e7 4b00          	push	#0
 417  00e9 0d07          	tnz	(OFST+7,sp)
 418  00eb 2708          	jreq	L22
 419  00ed ae0000        	ldw	x,#L42
 420  00f0 cd0000        	call	c_ltor
 422  00f3 2006          	jra	L62
 423  00f5               L22:
 424  00f5 ae2580        	ldw	x,#9600
 425  00f8 cd0000        	call	c_itolx
 427  00fb               L62:
 428  00fb be02          	ldw	x,c_lreg+2
 429  00fd 89            	pushw	x
 430  00fe be00          	ldw	x,c_lreg
 431  0100 89            	pushw	x
 432  0101 cd0000        	call	_UART1_Init
 434  0104 5b09          	addw	sp,#9
 435                     ; 64 		UART1_Cmd(ENABLE);
 437  0106 a601          	ld	a,#1
 438  0108 cd0000        	call	_UART1_Cmd
 441  010b 201d          	jra	L511
 442  010d               L311:
 443                     ; 66 		UART1_Cmd(DISABLE);
 445  010d 4f            	clr	a
 446  010e cd0000        	call	_UART1_Cmd
 448                     ; 67 		UART1_DeInit();
 450  0111 cd0000        	call	_UART1_DeInit
 452                     ; 68 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 454  0114 4b40          	push	#64
 455  0116 4b20          	push	#32
 456  0118 ae500f        	ldw	x,#20495
 457  011b cd0000        	call	_GPIO_Init
 459  011e 85            	popw	x
 460                     ; 69 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 462  011f 4b40          	push	#64
 463  0121 4b40          	push	#64
 464  0123 ae500f        	ldw	x,#20495
 465  0126 cd0000        	call	_GPIO_Init
 467  0129 85            	popw	x
 468  012a               L511:
 469                     ; 71 }
 472  012a 85            	popw	x
 473  012b 81            	ret
 500                     ; 74 bool is_application_valid()
 500                     ; 75 {
 501                     	switch	.text
 502  012c               _is_application_valid:
 506                     ; 76 	return !is_button_down(2) && !get_button_event(0,1);
 508  012c a602          	ld	a,#2
 509  012e cd025e        	call	_is_button_down
 511  0131 4d            	tnz	a
 512  0132 260d          	jrne	L23
 513  0134 ae0001        	ldw	x,#1
 514  0137 cd020f        	call	_get_button_event
 516  013a 4d            	tnz	a
 517  013b 2604          	jrne	L23
 518  013d a601          	ld	a,#1
 519  013f 2001          	jra	L43
 520  0141               L23:
 521  0141 4f            	clr	a
 522  0142               L43:
 525  0142 81            	ret
 551                     ; 80 bool is_developer_valid()
 551                     ; 81 {
 552                     	switch	.text
 553  0143               _is_developer_valid:
 557                     ; 82 	return is_button_down(2) && !get_button_event(0,1);
 559  0143 a602          	ld	a,#2
 560  0145 cd025e        	call	_is_button_down
 562  0148 4d            	tnz	a
 563  0149 270d          	jreq	L04
 564  014b ae0001        	ldw	x,#1
 565  014e cd020f        	call	_get_button_event
 567  0151 4d            	tnz	a
 568  0152 2604          	jrne	L04
 569  0154 a601          	ld	a,#1
 570  0156 2001          	jra	L24
 571  0158               L04:
 572  0158 4f            	clr	a
 573  0159               L24:
 576  0159 81            	ret
 601                     ; 85 void setup_main()
 601                     ; 86 {
 602                     	switch	.text
 603  015a               _setup_main:
 607                     ; 87 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 609  015a c650c6        	ld	a,20678
 610  015d a4e7          	and	a,#231
 611  015f c750c6        	ld	20678,a
 612                     ; 89 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 614  0162 4b40          	push	#64
 615  0164 4b02          	push	#2
 616  0166 ae500f        	ldw	x,#20495
 617  0169 cd0000        	call	_GPIO_Init
 619  016c 85            	popw	x
 620                     ; 93 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 622  016d 3505530e      	mov	21262,#5
 623                     ; 94 	TIM2->ARRH= 0;// init auto reload register
 625  0171 725f530f      	clr	21263
 626                     ; 95 	TIM2->ARRL= 255;// init auto reload register
 628  0175 35ff5310      	mov	21264,#255
 629                     ; 97 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 631  0179 c65300        	ld	a,21248
 632  017c aa05          	or	a,#5
 633  017e c75300        	ld	21248,a
 634                     ; 99 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 636  0181 35015303      	mov	21251,#1
 637                     ; 100 	enableInterrupts();
 640  0185 9a            rim
 642                     ; 101 }
 646  0186 81            	ret
 669                     ; 103 u32 millis()
 669                     ; 104 {
 670                     	switch	.text
 671  0187               _millis:
 675                     ; 105 	return 0;//api_counter>>10;
 677  0187 ae0000        	ldw	x,#0
 678  018a bf02          	ldw	c_lreg+2,x
 679  018c ae0000        	ldw	x,#0
 680  018f bf00          	ldw	c_lreg,x
 683  0191 81            	ret
 741                     ; 111 void update_buttons()
 741                     ; 112 {
 742                     	switch	.text
 743  0192               _update_buttons:
 745  0192 5208          	subw	sp,#8
 746       00000008      OFST:	set	8
 749                     ; 113 	bool is_any_down=0;
 751  0194 0f05          	clr	(OFST-3,sp)
 753                     ; 115 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 755  0196 be06          	ldw	x,_button_start_ms+2
 756  0198 cd0000        	call	c_uitolx
 758  019b 96            	ldw	x,sp
 759  019c 1c0001        	addw	x,#OFST-7
 760  019f cd0000        	call	c_rtol
 763  01a2 ade3          	call	_millis
 765  01a4 96            	ldw	x,sp
 766  01a5 1c0001        	addw	x,#OFST-7
 767  01a8 cd0000        	call	c_lsub
 769  01ab be02          	ldw	x,c_lreg+2
 770  01ad 1f06          	ldw	(OFST-2,sp),x
 772                     ; 116 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 774  01af 0f08          	clr	(OFST+0,sp)
 776  01b1               L502:
 777                     ; 118 		if(is_button_down(button_index))
 779  01b1 7b08          	ld	a,(OFST+0,sp)
 780  01b3 cd025e        	call	_is_button_down
 782  01b6 4d            	tnz	a
 783  01b7 271b          	jreq	L312
 784                     ; 120 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 786  01b9 ae0004        	ldw	x,#_button_start_ms
 787  01bc cd0000        	call	c_lzmp
 789  01bf 2608          	jrne	L512
 792  01c1 adc4          	call	_millis
 794  01c3 ae0004        	ldw	x,#_button_start_ms
 795  01c6 cd0000        	call	c_rtol
 797  01c9               L512:
 798                     ; 121 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 800  01c9 a6ff          	ld	a,#255
 801  01cb cd05e7        	call	_set_debug
 803                     ; 122 			is_any_down=1;
 805  01ce a601          	ld	a,#1
 806  01d0 6b05          	ld	(OFST-3,sp),a
 809  01d2 2022          	jra	L712
 810  01d4               L312:
 811                     ; 124 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 813  01d4 1e06          	ldw	x,(OFST-2,sp)
 814  01d6 a30201        	cpw	x,#513
 815  01d9 250b          	jrult	L122
 818  01db 7b08          	ld	a,(OFST+0,sp)
 819  01dd 5f            	clrw	x
 820  01de 97            	ld	xl,a
 821  01df 58            	sllw	x
 822  01e0 a601          	ld	a,#1
 823  01e2 e701          	ld	(_button_pressed_event+1,x),a
 825  01e4 2010          	jra	L712
 826  01e6               L122:
 827                     ; 125 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 829  01e6 1e06          	ldw	x,(OFST-2,sp)
 830  01e8 a30033        	cpw	x,#51
 831  01eb 2509          	jrult	L712
 834  01ed 7b08          	ld	a,(OFST+0,sp)
 835  01ef 5f            	clrw	x
 836  01f0 97            	ld	xl,a
 837  01f1 58            	sllw	x
 838  01f2 a601          	ld	a,#1
 839  01f4 e700          	ld	(_button_pressed_event,x),a
 840  01f6               L712:
 841                     ; 116 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 843  01f6 0c08          	inc	(OFST+0,sp)
 847  01f8 7b08          	ld	a,(OFST+0,sp)
 848  01fa a102          	cp	a,#2
 849  01fc 25b3          	jrult	L502
 850                     ; 129 	if(!is_any_down) button_start_ms=0;
 852  01fe 0d05          	tnz	(OFST-3,sp)
 853  0200 260a          	jrne	L722
 856  0202 ae0000        	ldw	x,#0
 857  0205 bf06          	ldw	_button_start_ms+2,x
 858  0207 ae0000        	ldw	x,#0
 859  020a bf04          	ldw	_button_start_ms,x
 860  020c               L722:
 861                     ; 130 }
 864  020c 5b08          	addw	sp,#8
 865  020e 81            	ret
 911                     ; 133 bool get_button_event(u8 button_index,bool is_long)
 911                     ; 134 { return button_pressed_event[button_index][is_long]; }
 912                     	switch	.text
 913  020f               _get_button_event:
 915  020f 89            	pushw	x
 916       00000000      OFST:	set	0
 921  0210 9e            	ld	a,xh
 922  0211 5f            	clrw	x
 923  0212 97            	ld	xl,a
 924  0213 58            	sllw	x
 925  0214 01            	rrwa	x,a
 926  0215 1b02          	add	a,(OFST+2,sp)
 927  0217 2401          	jrnc	L45
 928  0219 5c            	incw	x
 929  021a               L45:
 930  021a 02            	rlwa	x,a
 931  021b e600          	ld	a,(_button_pressed_event,x)
 934  021d 85            	popw	x
 935  021e 81            	ret
 991                     ; 137 bool clear_button_event(u8 button_index,bool is_long)
 991                     ; 138 {
 992                     	switch	.text
 993  021f               _clear_button_event:
 995  021f 89            	pushw	x
 996  0220 88            	push	a
 997       00000001      OFST:	set	1
1000                     ; 139 	bool out=button_pressed_event[button_index][is_long];
1002  0221 9e            	ld	a,xh
1003  0222 5f            	clrw	x
1004  0223 97            	ld	xl,a
1005  0224 58            	sllw	x
1006  0225 01            	rrwa	x,a
1007  0226 1b03          	add	a,(OFST+2,sp)
1008  0228 2401          	jrnc	L06
1009  022a 5c            	incw	x
1010  022b               L06:
1011  022b 02            	rlwa	x,a
1012  022c e600          	ld	a,(_button_pressed_event,x)
1013  022e 6b01          	ld	(OFST+0,sp),a
1015                     ; 140 	button_pressed_event[button_index][is_long]=0;
1017  0230 7b02          	ld	a,(OFST+1,sp)
1018  0232 5f            	clrw	x
1019  0233 97            	ld	xl,a
1020  0234 58            	sllw	x
1021  0235 01            	rrwa	x,a
1022  0236 1b03          	add	a,(OFST+2,sp)
1023  0238 2401          	jrnc	L26
1024  023a 5c            	incw	x
1025  023b               L26:
1026  023b 02            	rlwa	x,a
1027  023c 6f00          	clr	(_button_pressed_event,x)
1028                     ; 141 	return out;
1030  023e 7b01          	ld	a,(OFST+0,sp)
1033  0240 5b03          	addw	sp,#3
1034  0242 81            	ret
1070                     ; 144 void clear_button_events()
1070                     ; 145 {
1071                     	switch	.text
1072  0243               _clear_button_events:
1074  0243 88            	push	a
1075       00000001      OFST:	set	1
1078                     ; 147 	for(iter=0;iter<BUTTON_COUNT;iter++)
1080  0244 0f01          	clr	(OFST+0,sp)
1082  0246               L713:
1083                     ; 149 		clear_button_event(iter,0);
1085  0246 7b01          	ld	a,(OFST+0,sp)
1086  0248 5f            	clrw	x
1087  0249 95            	ld	xh,a
1088  024a add3          	call	_clear_button_event
1090                     ; 150 		clear_button_event(iter,1);
1092  024c 7b01          	ld	a,(OFST+0,sp)
1093  024e ae0001        	ldw	x,#1
1094  0251 95            	ld	xh,a
1095  0252 adcb          	call	_clear_button_event
1097                     ; 147 	for(iter=0;iter<BUTTON_COUNT;iter++)
1099  0254 0c01          	inc	(OFST+0,sp)
1103  0256 7b01          	ld	a,(OFST+0,sp)
1104  0258 a102          	cp	a,#2
1105  025a 25ea          	jrult	L713
1106                     ; 152 }
1109  025c 84            	pop	a
1110  025d 81            	ret
1146                     ; 155 bool is_button_down(u8 index)
1146                     ; 156 {
1147                     	switch	.text
1148  025e               _is_button_down:
1152                     ; 157 	switch(index)
1155                     ; 161 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1157  025e 4d            	tnz	a
1158  025f 2708          	jreq	L523
1159  0261 4a            	dec	a
1160  0262 2718          	jreq	L723
1161  0264 4a            	dec	a
1162  0265 2728          	jreq	L133
1163  0267 2039          	jra	L353
1164  0269               L523:
1165                     ; 159 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1167  0269 4b20          	push	#32
1168  026b ae500f        	ldw	x,#20495
1169  026e cd0000        	call	_GPIO_ReadInputPin
1171  0271 5b01          	addw	sp,#1
1172  0273 4d            	tnz	a
1173  0274 2604          	jrne	L07
1174  0276 a601          	ld	a,#1
1175  0278 2001          	jra	L27
1176  027a               L07:
1177  027a 4f            	clr	a
1178  027b               L27:
1181  027b 81            	ret
1182  027c               L723:
1183                     ; 160 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1186  027c 4b40          	push	#64
1187  027e ae500f        	ldw	x,#20495
1188  0281 cd0000        	call	_GPIO_ReadInputPin
1190  0284 5b01          	addw	sp,#1
1191  0286 4d            	tnz	a
1192  0287 2604          	jrne	L47
1193  0289 a601          	ld	a,#1
1194  028b 2001          	jra	L67
1195  028d               L47:
1196  028d 4f            	clr	a
1197  028e               L67:
1200  028e 81            	ret
1201  028f               L133:
1202                     ; 161 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1205  028f 4b02          	push	#2
1206  0291 ae500f        	ldw	x,#20495
1207  0294 cd0000        	call	_GPIO_ReadInputPin
1209  0297 5b01          	addw	sp,#1
1210  0299 4d            	tnz	a
1211  029a 2604          	jrne	L001
1212  029c a601          	ld	a,#1
1213  029e 2001          	jra	L201
1214  02a0               L001:
1215  02a0 4f            	clr	a
1216  02a1               L201:
1219  02a1 81            	ret
1220  02a2               L353:
1221                     ; 163 	return 0;
1223  02a2 4f            	clr	a
1226  02a3 81            	ret
1279                     ; 167 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1281                     	switch	.text
1282  02a4               f_TIM2_UPD_OVF_IRQHandler:
1284  02a4 8a            	push	cc
1285  02a5 84            	pop	a
1286  02a6 a4bf          	and	a,#191
1287  02a8 88            	push	a
1288  02a9 86            	pop	cc
1289       00000005      OFST:	set	5
1290  02aa 3b0002        	push	c_x+2
1291  02ad be00          	ldw	x,c_x
1292  02af 89            	pushw	x
1293  02b0 3b0002        	push	c_y+2
1294  02b3 be00          	ldw	x,c_y
1295  02b5 89            	pushw	x
1296  02b6 5205          	subw	sp,#5
1299                     ; 168 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1301  02b8 b688          	ld	a,_pwm_state
1302  02ba a401          	and	a,#1
1303  02bc 6b05          	ld	(OFST+0,sp),a
1305                     ; 169 	u16 sleep_counts=1;
1307  02be ae0001        	ldw	x,#1
1308  02c1 1f03          	ldw	(OFST-2,sp),x
1310                     ; 171 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1312  02c3 c6500c        	ld	a,20492
1313  02c6 a407          	and	a,#7
1314  02c8 c7500c        	ld	20492,a
1315                     ; 172 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1317  02cb 72155011      	bres	20497,#2
1318                     ; 173 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1320  02cf 72175002      	bres	20482,#3
1321                     ; 174 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1323  02d3 c6500d        	ld	a,20493
1324  02d6 a407          	and	a,#7
1325  02d8 c7500d        	ld	20493,a
1326                     ; 175 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1328  02db 72155012      	bres	20498,#2
1329                     ; 176 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1331  02df 72175003      	bres	20483,#3
1332                     ; 178 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1334  02e3 72195011      	bres	20497,#4
1335                     ; 179 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//TEMP
1337  02e7 72195012      	bres	20498,#4
1338                     ; 181   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1340  02eb 72115300      	bres	21248,#0
1341                     ; 182 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1343  02ef 7b05          	ld	a,(OFST+0,sp)
1344  02f1 5f            	clrw	x
1345  02f2 97            	ld	xl,a
1346  02f3 e685          	ld	a,(_pwm_led_count,x)
1347  02f5 b187          	cp	a,_pwm_visible_index
1348  02f7 2609          	jrne	L773
1349                     ; 184 		sleep_counts=pwm_sleep[buffer_index];
1351  02f9 7b05          	ld	a,(OFST+0,sp)
1352  02fb 5f            	clrw	x
1353  02fc 97            	ld	xl,a
1354  02fd 58            	sllw	x
1355  02fe ee81          	ldw	x,(_pwm_sleep,x)
1356  0300 1f03          	ldw	(OFST-2,sp),x
1358  0302               L773:
1359                     ; 186 	if(pwm_visible_index>pwm_led_count[buffer_index])
1361  0302 7b05          	ld	a,(OFST+0,sp)
1362  0304 5f            	clrw	x
1363  0305 97            	ld	xl,a
1364  0306 e685          	ld	a,(_pwm_led_count,x)
1365  0308 b187          	cp	a,_pwm_visible_index
1366  030a 2416          	jruge	L104
1367                     ; 188 		frame_counter++;
1369  030c 3c00          	inc	_frame_counter
1370                     ; 189 		pwm_visible_index=0;//formally start new frame
1372  030e 3f87          	clr	_pwm_visible_index
1373                     ; 190 		if(pwm_state&0x02)
1375  0310 b688          	ld	a,_pwm_state
1376  0312 a502          	bcp	a,#2
1377  0314 270c          	jreq	L104
1378                     ; 192 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1380  0316 b688          	ld	a,_pwm_state
1381  0318 a803          	xor	a,#3
1382  031a b788          	ld	_pwm_state,a
1383                     ; 193 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1385  031c b688          	ld	a,_pwm_state
1386  031e a401          	and	a,#1
1387  0320 6b05          	ld	(OFST+0,sp),a
1389  0322               L104:
1390                     ; 196 	if(pwm_visible_index<pwm_led_count[buffer_index])
1392  0322 7b05          	ld	a,(OFST+0,sp)
1393  0324 5f            	clrw	x
1394  0325 97            	ld	xl,a
1395  0326 e685          	ld	a,(_pwm_led_count,x)
1396  0328 b187          	cp	a,_pwm_visible_index
1397  032a 2324          	jrule	L504
1398                     ; 198 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1400  032c 7b05          	ld	a,(OFST+0,sp)
1401  032e 5f            	clrw	x
1402  032f 97            	ld	xl,a
1403  0330 58            	sllw	x
1404  0331 1f01          	ldw	(OFST-4,sp),x
1406  0333 b687          	ld	a,_pwm_visible_index
1407  0335 97            	ld	xl,a
1408  0336 a604          	ld	a,#4
1409  0338 42            	mul	x,a
1410  0339 72fb01        	addw	x,(OFST-4,sp)
1411  033c ee01          	ldw	x,(_pwm_brightness,x)
1412  033e 1f03          	ldw	(OFST-2,sp),x
1414                     ; 199 		set_led(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1416  0340 b687          	ld	a,_pwm_visible_index
1417  0342 5f            	clrw	x
1418  0343 97            	ld	xl,a
1419  0344 58            	sllw	x
1420  0345 01            	rrwa	x,a
1421  0346 1b05          	add	a,(OFST+0,sp)
1422  0348 2401          	jrnc	L601
1423  034a 5c            	incw	x
1424  034b               L601:
1425  034b 02            	rlwa	x,a
1426  034c e628          	ld	a,(_pwm_brightness_index,x)
1427  034e ad2d          	call	_set_led
1429  0350               L504:
1430                     ; 201 	pwm_visible_index++;
1432  0350 3c87          	inc	_pwm_visible_index
1433                     ; 203   TIM2->CNTRH = 0;// Set the high byte of the counter
1435  0352 725f530c      	clr	21260
1436                     ; 204   TIM2->CNTRL = 0;// Set the low byte of the counter
1438  0356 725f530d      	clr	21261
1439                     ; 205 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1441  035a 7b03          	ld	a,(OFST-2,sp)
1442  035c c7530f        	ld	21263,a
1443                     ; 206 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1445  035f 7b04          	ld	a,(OFST-1,sp)
1446  0361 a4ff          	and	a,#255
1447  0363 c75310        	ld	21264,a
1448                     ; 208 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1450  0366 72115304      	bres	21252,#0
1451                     ; 209   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1453  036a 72105300      	bset	21248,#0
1454                     ; 210 }
1457  036e 5b05          	addw	sp,#5
1458  0370 85            	popw	x
1459  0371 bf00          	ldw	c_y,x
1460  0373 320002        	pop	c_y+2
1461  0376 85            	popw	x
1462  0377 bf00          	ldw	c_x,x
1463  0379 320002        	pop	c_x+2
1464  037c 80            	iret
1466                     	switch	.const
1467  0004               L704_led_lookup:
1468  0004 00            	dc.b	0
1469  0005 01            	dc.b	1
1470  0006 01            	dc.b	1
1471  0007 00            	dc.b	0
1472  0008 05            	dc.b	5
1473  0009 00            	dc.b	0
1474  000a 06            	dc.b	6
1475  000b 00            	dc.b	0
1476  000c 06            	dc.b	6
1477  000d 05            	dc.b	5
1478  000e 04            	dc.b	4
1479  000f 03            	dc.b	3
1480  0010 03            	dc.b	3
1481  0011 04            	dc.b	4
1482  0012 00            	dc.b	0
1483  0013 05            	dc.b	5
1484  0014 00            	dc.b	0
1485  0015 04            	dc.b	4
1486  0016 00            	dc.b	0
1487  0017 03            	dc.b	3
1488  0018 00            	dc.b	0
1489  0019 02            	dc.b	2
1490  001a 02            	dc.b	2
1491  001b 00            	dc.b	0
1492  001c 05            	dc.b	5
1493  001d 01            	dc.b	1
1494  001e 06            	dc.b	6
1495  001f 01            	dc.b	1
1496  0020 06            	dc.b	6
1497  0021 04            	dc.b	4
1498  0022 05            	dc.b	5
1499  0023 03            	dc.b	3
1500  0024 03            	dc.b	3
1501  0025 05            	dc.b	5
1502  0026 00            	dc.b	0
1503  0027 06            	dc.b	6
1504  0028 01            	dc.b	1
1505  0029 04            	dc.b	4
1506  002a 01            	dc.b	1
1507  002b 03            	dc.b	3
1508  002c 01            	dc.b	1
1509  002d 02            	dc.b	2
1510  002e 02            	dc.b	2
1511  002f 01            	dc.b	1
1512  0030 05            	dc.b	5
1513  0031 02            	dc.b	2
1514  0032 06            	dc.b	6
1515  0033 02            	dc.b	2
1516  0034 05            	dc.b	5
1517  0035 04            	dc.b	4
1518  0036 06            	dc.b	6
1519  0037 03            	dc.b	3
1520  0038 03            	dc.b	3
1521  0039 06            	dc.b	6
1522  003a 01            	dc.b	1
1523  003b 06            	dc.b	6
1524  003c 02            	dc.b	2
1525  003d 04            	dc.b	4
1526  003e 02            	dc.b	2
1527  003f 03            	dc.b	3
1528  0040 03            	dc.b	3
1529  0041 00            	dc.b	0
1530  0042 03            	dc.b	3
1531  0043 01            	dc.b	1
1575                     ; 213 void set_led(u8 led_index)
1575                     ; 214 {
1577                     	switch	.text
1578  037d               _set_led:
1580  037d 88            	push	a
1581  037e 5242          	subw	sp,#66
1582       00000042      OFST:	set	66
1585                     ; 233 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1585                     ; 234 		{0,1},{1,0},{5,0},{6,0},{6,5},{4,3},{3,4},{0,5},{0,4},{0,3},//reds
1585                     ; 235 		{0,2},{2,0},{5,1},{6,1},{6,4},{5,3},{3,5},{0,6},{1,4},{1,3},//greens
1585                     ; 236 		{1,2},{2,1},{5,2},{6,2},{5,4},{6,3},{3,6},{1,6},{2,4},{2,3},//blues
1585                     ; 237 		//{7,7},//debug; GND is tied low, no charlieplexing involved
1585                     ; 238 		{3,0},//LED6
1585                     ; 239 		{3,1},//LED4
1585                     ; 240 		/*{3,2},//LED5
1585                     ; 241 		{4,0},//LED14
1585                     ; 242 		{1,5},//LED8
1585                     ; 243 		{2,5},//LED9
1585                     ; 244 		{4,1},//LED10
1585                     ; 245 		{4,2},//LED16
1585                     ; 246 		{2,6},//LED17
1585                     ; 247 		{4,6},//LED12
1585                     ; 248 		{4,5},//LED13
1585                     ; 249 		{5,6}*/ //LED11
1585                     ; 250 	};
1587  0380 96            	ldw	x,sp
1588  0381 1c0003        	addw	x,#OFST-63
1589  0384 90ae0004      	ldw	y,#L704_led_lookup
1590  0388 a640          	ld	a,#64
1591  038a cd0000        	call	c_xymov
1593                     ; 251 	set_mat(led_lookup[led_index][0],1);
1595  038d 96            	ldw	x,sp
1596  038e 1c0003        	addw	x,#OFST-63
1597  0391 1f01          	ldw	(OFST-65,sp),x
1599  0393 7b43          	ld	a,(OFST+1,sp)
1600  0395 5f            	clrw	x
1601  0396 97            	ld	xl,a
1602  0397 58            	sllw	x
1603  0398 72fb01        	addw	x,(OFST-65,sp)
1604  039b f6            	ld	a,(x)
1605  039c ae0001        	ldw	x,#1
1606  039f 95            	ld	xh,a
1607  03a0 ad16          	call	_set_mat
1609                     ; 254 	set_mat(led_lookup[led_index][1],0);
1611  03a2 96            	ldw	x,sp
1612  03a3 1c0004        	addw	x,#OFST-62
1613  03a6 1f01          	ldw	(OFST-65,sp),x
1615  03a8 7b43          	ld	a,(OFST+1,sp)
1616  03aa 5f            	clrw	x
1617  03ab 97            	ld	xl,a
1618  03ac 58            	sllw	x
1619  03ad 72fb01        	addw	x,(OFST-65,sp)
1620  03b0 f6            	ld	a,(x)
1621  03b1 5f            	clrw	x
1622  03b2 95            	ld	xh,a
1623  03b3 ad03          	call	_set_mat
1625                     ; 255 }
1628  03b5 5b43          	addw	sp,#67
1629  03b7 81            	ret
1830                     ; 258 void set_mat(u8 mat_index,bool is_high)
1830                     ; 259 {
1831                     	switch	.text
1832  03b8               _set_mat:
1834  03b8 89            	pushw	x
1835  03b9 5203          	subw	sp,#3
1836       00000003      OFST:	set	3
1839                     ; 297 	if(mat_index==0)
1841  03bb 9e            	ld	a,xh
1842  03bc 4d            	tnz	a
1843  03bd 2609          	jrne	L155
1844                     ; 299 		GPIOx=GPIOD;
1846  03bf ae500f        	ldw	x,#20495
1847  03c2 1f01          	ldw	(OFST-2,sp),x
1849                     ; 300 		GPIO_Pin=GPIO_PIN_4;
1851  03c4 a610          	ld	a,#16
1852  03c6 6b03          	ld	(OFST+0,sp),a
1854  03c8               L155:
1855                     ; 302 	if(mat_index==1)
1857  03c8 7b04          	ld	a,(OFST+1,sp)
1858  03ca a101          	cp	a,#1
1859  03cc 2609          	jrne	L355
1860                     ; 304 		GPIOx=GPIOD;
1862  03ce ae500f        	ldw	x,#20495
1863  03d1 1f01          	ldw	(OFST-2,sp),x
1865                     ; 305 		GPIO_Pin=GPIO_PIN_2;
1867  03d3 a604          	ld	a,#4
1868  03d5 6b03          	ld	(OFST+0,sp),a
1870  03d7               L355:
1871                     ; 307 	if(mat_index==2)
1873  03d7 7b04          	ld	a,(OFST+1,sp)
1874  03d9 a102          	cp	a,#2
1875  03db 2609          	jrne	L555
1876                     ; 309 		GPIOx=GPIOC;
1878  03dd ae500a        	ldw	x,#20490
1879  03e0 1f01          	ldw	(OFST-2,sp),x
1881                     ; 310 		GPIO_Pin=GPIO_PIN_7;
1883  03e2 a680          	ld	a,#128
1884  03e4 6b03          	ld	(OFST+0,sp),a
1886  03e6               L555:
1887                     ; 312 	if(mat_index==3)
1889  03e6 7b04          	ld	a,(OFST+1,sp)
1890  03e8 a103          	cp	a,#3
1891  03ea 2609          	jrne	L755
1892                     ; 314 		GPIOx=GPIOC;
1894  03ec ae500a        	ldw	x,#20490
1895  03ef 1f01          	ldw	(OFST-2,sp),x
1897                     ; 315 		GPIO_Pin=GPIO_PIN_6;
1899  03f1 a640          	ld	a,#64
1900  03f3 6b03          	ld	(OFST+0,sp),a
1902  03f5               L755:
1903                     ; 317 	if(mat_index==4)
1905  03f5 7b04          	ld	a,(OFST+1,sp)
1906  03f7 a104          	cp	a,#4
1907  03f9 2609          	jrne	L165
1908                     ; 319 		GPIOx=GPIOC;
1910  03fb ae500a        	ldw	x,#20490
1911  03fe 1f01          	ldw	(OFST-2,sp),x
1913                     ; 320 		GPIO_Pin=GPIO_PIN_5;
1915  0400 a620          	ld	a,#32
1916  0402 6b03          	ld	(OFST+0,sp),a
1918  0404               L165:
1919                     ; 322 	if(mat_index==5)
1921  0404 7b04          	ld	a,(OFST+1,sp)
1922  0406 a105          	cp	a,#5
1923  0408 2609          	jrne	L365
1924                     ; 324 		GPIOx=GPIOC;
1926  040a ae500a        	ldw	x,#20490
1927  040d 1f01          	ldw	(OFST-2,sp),x
1929                     ; 325 		GPIO_Pin=GPIO_PIN_4;
1931  040f a610          	ld	a,#16
1932  0411 6b03          	ld	(OFST+0,sp),a
1934  0413               L365:
1935                     ; 327 	if(mat_index==6)
1937  0413 7b04          	ld	a,(OFST+1,sp)
1938  0415 a106          	cp	a,#6
1939  0417 2609          	jrne	L565
1940                     ; 329 		GPIOx=GPIOC;
1942  0419 ae500a        	ldw	x,#20490
1943  041c 1f01          	ldw	(OFST-2,sp),x
1945                     ; 330 		GPIO_Pin=GPIO_PIN_3;
1947  041e a608          	ld	a,#8
1948  0420 6b03          	ld	(OFST+0,sp),a
1950  0422               L565:
1951                     ; 332 	if(mat_index==7)
1953  0422 7b04          	ld	a,(OFST+1,sp)
1954  0424 a107          	cp	a,#7
1955  0426 2609          	jrne	L765
1956                     ; 334 		GPIOx=GPIOA;
1958  0428 ae5000        	ldw	x,#20480
1959  042b 1f01          	ldw	(OFST-2,sp),x
1961                     ; 335 		GPIO_Pin=GPIO_PIN_3;
1963  042d a608          	ld	a,#8
1964  042f 6b03          	ld	(OFST+0,sp),a
1966  0431               L765:
1967                     ; 337 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1969  0431 0d05          	tnz	(OFST+2,sp)
1970  0433 2708          	jreq	L175
1973  0435 1e01          	ldw	x,(OFST-2,sp)
1974  0437 f6            	ld	a,(x)
1975  0438 1a03          	or	a,(OFST+0,sp)
1976  043a f7            	ld	(x),a
1978  043b 2007          	jra	L375
1979  043d               L175:
1980                     ; 338 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1982  043d 1e01          	ldw	x,(OFST-2,sp)
1983  043f 7b03          	ld	a,(OFST+0,sp)
1984  0441 43            	cpl	a
1985  0442 f4            	and	a,(x)
1986  0443 f7            	ld	(x),a
1987  0444               L375:
1988                     ; 339 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
1990  0444 1e01          	ldw	x,(OFST-2,sp)
1991  0446 e602          	ld	a,(2,x)
1992  0448 1a03          	or	a,(OFST+0,sp)
1993  044a e702          	ld	(2,x),a
1994                     ; 340 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1996  044c 1e01          	ldw	x,(OFST-2,sp)
1997  044e e603          	ld	a,(3,x)
1998  0450 1a03          	or	a,(OFST+0,sp)
1999  0452 e703          	ld	(3,x),a
2000                     ; 341 }
2003  0454 5b05          	addw	sp,#5
2004  0456 81            	ret
2080                     ; 344 void flush_leds(u8 led_count)
2080                     ; 345 {
2081                     	switch	.text
2082  0457               _flush_leds:
2084  0457 88            	push	a
2085  0458 5207          	subw	sp,#7
2086       00000007      OFST:	set	7
2089                     ; 346 	u8 led_read_index=0,led_write_index=0;
2093  045a 0f05          	clr	(OFST-2,sp)
2096  045c               L736:
2097                     ; 349 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2099  045c b688          	ld	a,_pwm_state
2100  045e a502          	bcp	a,#2
2101  0460 26fa          	jrne	L736
2102                     ; 350 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2104  0462 b688          	ld	a,_pwm_state
2105  0464 a401          	and	a,#1
2106  0466 a801          	xor	a,#1
2107  0468 6b07          	ld	(OFST+0,sp),a
2109                     ; 352 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2111  046a 7b08          	ld	a,(OFST+1,sp)
2112  046c 5f            	clrw	x
2113  046d 97            	ld	xl,a
2114  046e 4f            	clr	a
2115  046f 02            	rlwa	x,a
2116  0470 58            	sllw	x
2117  0471 58            	sllw	x
2118  0472 7b07          	ld	a,(OFST+0,sp)
2119  0474 905f          	clrw	y
2120  0476 9097          	ld	yl,a
2121  0478 9058          	sllw	y
2122  047a 90ef81        	ldw	(_pwm_sleep,y),x
2123                     ; 354 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2125  047d 0f06          	clr	(OFST-1,sp)
2127  047f               L346:
2128                     ; 356 		read_brightness=pwm_brightness_buffer[led_read_index];
2130  047f 7b06          	ld	a,(OFST-1,sp)
2131  0481 5f            	clrw	x
2132  0482 97            	ld	xl,a
2133  0483 e608          	ld	a,(_pwm_brightness_buffer,x)
2134  0485 5f            	clrw	x
2135  0486 97            	ld	xl,a
2136  0487 1f03          	ldw	(OFST-4,sp),x
2138                     ; 357 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2140  0489 1e03          	ldw	x,(OFST-4,sp)
2141  048b 2767          	jreq	L156
2142                     ; 359 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2144  048d 7b05          	ld	a,(OFST-2,sp)
2145  048f 5f            	clrw	x
2146  0490 97            	ld	xl,a
2147  0491 58            	sllw	x
2148  0492 01            	rrwa	x,a
2149  0493 1b07          	add	a,(OFST+0,sp)
2150  0495 2401          	jrnc	L611
2151  0497 5c            	incw	x
2152  0498               L611:
2153  0498 02            	rlwa	x,a
2154  0499 7b06          	ld	a,(OFST-1,sp)
2155  049b e728          	ld	(_pwm_brightness_index,x),a
2156                     ; 360 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2158  049d 1e03          	ldw	x,(OFST-4,sp)
2159  049f 1603          	ldw	y,(OFST-4,sp)
2160  04a1 cd0000        	call	c_imul
2162  04a4 a606          	ld	a,#6
2163  04a6               L021:
2164  04a6 54            	srlw	x
2165  04a7 4a            	dec	a
2166  04a8 26fc          	jrne	L021
2167  04aa 5c            	incw	x
2168  04ab 7b07          	ld	a,(OFST+0,sp)
2169  04ad 905f          	clrw	y
2170  04af 9097          	ld	yl,a
2171  04b1 9058          	sllw	y
2172  04b3 1701          	ldw	(OFST-6,sp),y
2174  04b5 7b05          	ld	a,(OFST-2,sp)
2175  04b7 905f          	clrw	y
2176  04b9 9097          	ld	yl,a
2177  04bb 9058          	sllw	y
2178  04bd 9058          	sllw	y
2179  04bf 72f901        	addw	y,(OFST-6,sp)
2180  04c2 90ef01        	ldw	(_pwm_brightness,y),x
2181                     ; 361 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2183  04c5 7b07          	ld	a,(OFST+0,sp)
2184  04c7 5f            	clrw	x
2185  04c8 97            	ld	xl,a
2186  04c9 58            	sllw	x
2187  04ca 7b07          	ld	a,(OFST+0,sp)
2188  04cc 905f          	clrw	y
2189  04ce 9097          	ld	yl,a
2190  04d0 9058          	sllw	y
2191  04d2 1701          	ldw	(OFST-6,sp),y
2193  04d4 7b05          	ld	a,(OFST-2,sp)
2194  04d6 905f          	clrw	y
2195  04d8 9097          	ld	yl,a
2196  04da 9058          	sllw	y
2197  04dc 9058          	sllw	y
2198  04de 72f901        	addw	y,(OFST-6,sp)
2199  04e1 90ee01        	ldw	y,(_pwm_brightness,y)
2200  04e4 9001          	rrwa	y,a
2201  04e6 e082          	sub	a,(_pwm_sleep+1,x)
2202  04e8 9001          	rrwa	y,a
2203  04ea e281          	sbc	a,(_pwm_sleep,x)
2204  04ec 9001          	rrwa	y,a
2205  04ee 9050          	negw	y
2206  04f0 ef81          	ldw	(_pwm_sleep,x),y
2207                     ; 362 			led_write_index++;
2209  04f2 0c05          	inc	(OFST-2,sp)
2211  04f4               L156:
2212                     ; 364 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2214  04f4 7b06          	ld	a,(OFST-1,sp)
2215  04f6 5f            	clrw	x
2216  04f7 97            	ld	xl,a
2217  04f8 6f08          	clr	(_pwm_brightness_buffer,x)
2218                     ; 354 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2220  04fa 0c06          	inc	(OFST-1,sp)
2224  04fc 7b06          	ld	a,(OFST-1,sp)
2225  04fe a120          	cp	a,#32
2226  0500 2403cc047f    	jrult	L346
2227                     ; 366 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2229  0505 7b07          	ld	a,(OFST+0,sp)
2230  0507 5f            	clrw	x
2231  0508 97            	ld	xl,a
2232  0509 58            	sllw	x
2233  050a 90ae0001      	ldw	y,#1
2234  050e ef81          	ldw	(_pwm_sleep,x),y
2235                     ; 368 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2237  0510 7b07          	ld	a,(OFST+0,sp)
2238  0512 5f            	clrw	x
2239  0513 97            	ld	xl,a
2240  0514 7b05          	ld	a,(OFST-2,sp)
2241  0516 e785          	ld	(_pwm_led_count,x),a
2242                     ; 371 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2244  0518 72120088      	bset	_pwm_state,#1
2245                     ; 372 }
2248  051c 5b08          	addw	sp,#8
2249  051e 81            	ret
2338                     ; 375 void set_hue_max(u8 index,u16 color)
2338                     ; 376 {
2339                     	switch	.text
2340  051f               _set_hue_max:
2342  051f 88            	push	a
2343  0520 5205          	subw	sp,#5
2344       00000005      OFST:	set	5
2347                     ; 377 	u8 red=0,green=0,blue=0;
2349  0522 0f01          	clr	(OFST-4,sp)
2353  0524 0f02          	clr	(OFST-3,sp)
2357  0526 0f03          	clr	(OFST-2,sp)
2359                     ; 378 	u8 residual=0;
2361  0528 0f04          	clr	(OFST-1,sp)
2363                     ; 380 	for(iter=0;iter<6;iter++)
2365  052a 0f05          	clr	(OFST+0,sp)
2367  052c               L127:
2368                     ; 382 		if(color<0x2AAB)
2370  052c 1e09          	ldw	x,(OFST+4,sp)
2371  052e a32aab        	cpw	x,#10923
2372  0531 240b          	jruge	L727
2373                     ; 384 			residual=color/43;
2375  0533 1e09          	ldw	x,(OFST+4,sp)
2376  0535 a62b          	ld	a,#43
2377  0537 62            	div	x,a
2378  0538 01            	rrwa	x,a
2379  0539 6b04          	ld	(OFST-1,sp),a
2380  053b 02            	rlwa	x,a
2382                     ; 385 			break;
2384  053c 200f          	jra	L527
2385  053e               L727:
2386                     ; 387 		color-=0x2AAB;
2388  053e 1e09          	ldw	x,(OFST+4,sp)
2389  0540 1d2aab        	subw	x,#10923
2390  0543 1f09          	ldw	(OFST+4,sp),x
2391                     ; 380 	for(iter=0;iter<6;iter++)
2393  0545 0c05          	inc	(OFST+0,sp)
2397  0547 7b05          	ld	a,(OFST+0,sp)
2398  0549 a106          	cp	a,#6
2399  054b 25df          	jrult	L127
2400  054d               L527:
2401                     ; 389 	if(iter==0){ red=255; green=residual; }
2403  054d 0d05          	tnz	(OFST+0,sp)
2404  054f 2608          	jrne	L137
2407  0551 a6ff          	ld	a,#255
2408  0553 6b01          	ld	(OFST-4,sp),a
2412  0555 7b04          	ld	a,(OFST-1,sp)
2413  0557 6b02          	ld	(OFST-3,sp),a
2415  0559               L137:
2416                     ; 390 	if(iter==1){ green=255; red=255-residual; }
2418  0559 7b05          	ld	a,(OFST+0,sp)
2419  055b a101          	cp	a,#1
2420  055d 260a          	jrne	L337
2423  055f a6ff          	ld	a,#255
2424  0561 6b02          	ld	(OFST-3,sp),a
2428  0563 a6ff          	ld	a,#255
2429  0565 1004          	sub	a,(OFST-1,sp)
2430  0567 6b01          	ld	(OFST-4,sp),a
2432  0569               L337:
2433                     ; 391 	if(iter==2){ green=255; blue=residual; }
2435  0569 7b05          	ld	a,(OFST+0,sp)
2436  056b a102          	cp	a,#2
2437  056d 2608          	jrne	L537
2440  056f a6ff          	ld	a,#255
2441  0571 6b02          	ld	(OFST-3,sp),a
2445  0573 7b04          	ld	a,(OFST-1,sp)
2446  0575 6b03          	ld	(OFST-2,sp),a
2448  0577               L537:
2449                     ; 392 	if(iter==3){ blue=255; green=255-residual; }
2451  0577 7b05          	ld	a,(OFST+0,sp)
2452  0579 a103          	cp	a,#3
2453  057b 260a          	jrne	L737
2456  057d a6ff          	ld	a,#255
2457  057f 6b03          	ld	(OFST-2,sp),a
2461  0581 a6ff          	ld	a,#255
2462  0583 1004          	sub	a,(OFST-1,sp)
2463  0585 6b02          	ld	(OFST-3,sp),a
2465  0587               L737:
2466                     ; 393 	if(iter==4){ blue=255; red=residual; }
2468  0587 7b05          	ld	a,(OFST+0,sp)
2469  0589 a104          	cp	a,#4
2470  058b 2608          	jrne	L147
2473  058d a6ff          	ld	a,#255
2474  058f 6b03          	ld	(OFST-2,sp),a
2478  0591 7b04          	ld	a,(OFST-1,sp)
2479  0593 6b01          	ld	(OFST-4,sp),a
2481  0595               L147:
2482                     ; 394 	if(iter==5){ red=255; blue=255-residual; }
2484  0595 7b05          	ld	a,(OFST+0,sp)
2485  0597 a105          	cp	a,#5
2486  0599 260a          	jrne	L347
2489  059b a6ff          	ld	a,#255
2490  059d 6b01          	ld	(OFST-4,sp),a
2494  059f a6ff          	ld	a,#255
2495  05a1 1004          	sub	a,(OFST-1,sp)
2496  05a3 6b03          	ld	(OFST-2,sp),a
2498  05a5               L347:
2499                     ; 395 	set_rgb(index,0,red);
2501  05a5 7b01          	ld	a,(OFST-4,sp)
2502  05a7 88            	push	a
2503  05a8 7b07          	ld	a,(OFST+2,sp)
2504  05aa 5f            	clrw	x
2505  05ab 95            	ld	xh,a
2506  05ac ad1c          	call	_set_rgb
2508  05ae 84            	pop	a
2509                     ; 396 	set_rgb(index,1,green);
2511  05af 7b02          	ld	a,(OFST-3,sp)
2512  05b1 88            	push	a
2513  05b2 7b07          	ld	a,(OFST+2,sp)
2514  05b4 ae0001        	ldw	x,#1
2515  05b7 95            	ld	xh,a
2516  05b8 ad10          	call	_set_rgb
2518  05ba 84            	pop	a
2519                     ; 397 	set_rgb(index,2,blue);
2521  05bb 7b03          	ld	a,(OFST-2,sp)
2522  05bd 88            	push	a
2523  05be 7b07          	ld	a,(OFST+2,sp)
2524  05c0 ae0002        	ldw	x,#2
2525  05c3 95            	ld	xh,a
2526  05c4 ad04          	call	_set_rgb
2528  05c6 84            	pop	a
2529                     ; 398 }
2532  05c7 5b06          	addw	sp,#6
2533  05c9 81            	ret
2586                     ; 400 void set_rgb(u8 index,u8 color,u8 brightness)
2586                     ; 401 {
2587                     	switch	.text
2588  05ca               _set_rgb:
2590  05ca 89            	pushw	x
2591       00000000      OFST:	set	0
2594                     ; 402 	pwm_brightness_buffer[index+color*RGB_COUNT]=brightness;
2596  05cb 9f            	ld	a,xl
2597  05cc 97            	ld	xl,a
2598  05cd a60a          	ld	a,#10
2599  05cf 42            	mul	x,a
2600  05d0 01            	rrwa	x,a
2601  05d1 1b01          	add	a,(OFST+1,sp)
2602  05d3 2401          	jrnc	L621
2603  05d5 5c            	incw	x
2604  05d6               L621:
2605  05d6 02            	rlwa	x,a
2606  05d7 7b05          	ld	a,(OFST+5,sp)
2607  05d9 e708          	ld	(_pwm_brightness_buffer,x),a
2608                     ; 403 }
2611  05db 85            	popw	x
2612  05dc 81            	ret
2656                     ; 405 void set_white(u8 index,u8 brightness)
2656                     ; 406 {
2657                     	switch	.text
2658  05dd               _set_white:
2660  05dd 89            	pushw	x
2661       00000000      OFST:	set	0
2664                     ; 407 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2666  05de 9e            	ld	a,xh
2667  05df 5f            	clrw	x
2668  05e0 97            	ld	xl,a
2669  05e1 7b02          	ld	a,(OFST+2,sp)
2670  05e3 e727          	ld	(_pwm_brightness_buffer+31,x),a
2671                     ; 408 }
2674  05e5 85            	popw	x
2675  05e6 81            	ret
2710                     ; 411 void set_debug(u8 brightness)
2710                     ; 412 {
2711                     	switch	.text
2712  05e7               _set_debug:
2716                     ; 413 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2718  05e7 b726          	ld	_pwm_brightness_buffer+30,a
2719                     ; 414 }
2722  05e9 81            	ret
2745                     ; 416 void set_matrix_high_z()
2745                     ; 417 {
2746                     	switch	.text
2747  05ea               _set_matrix_high_z:
2751                     ; 418 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2753  05ea c6500d        	ld	a,20493
2754  05ed a407          	and	a,#7
2755  05ef c7500d        	ld	20493,a
2756                     ; 419 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2758  05f2 72155012      	bres	20498,#2
2759                     ; 420 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2761  05f6 72175003      	bres	20483,#3
2762                     ; 423 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_3));//TEMP
2764  05fa 72175012      	bres	20498,#3
2765                     ; 424 }
2768  05fe 81            	ret
2802                     ; 426 u8 get_eeprom_byte(u16 eeprom_address)
2802                     ; 427 {
2803                     	switch	.text
2804  05ff               _get_eeprom_byte:
2808                     ; 428 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2810  05ff d64000        	ld	a,(16384,x)
2813  0602 81            	ret
2932                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2933                     	switch	.ubsct
2934  0000               _button_pressed_event:
2935  0000 00000000      	ds.b	4
2936                     	xdef	_button_pressed_event
2937  0004               _button_start_ms:
2938  0004 00000000      	ds.b	4
2939                     	xdef	_button_start_ms
2940                     	xdef	_pwm_state
2941                     	xdef	_pwm_visible_index
2942                     	xdef	_pwm_led_count
2943                     	xdef	_pwm_sleep
2944  0008               _pwm_brightness_buffer:
2945  0008 000000000000  	ds.b	32
2946                     	xdef	_pwm_brightness_buffer
2947  0028               _pwm_brightness_index:
2948  0028 000000000000  	ds.b	64
2949                     	xdef	_pwm_brightness_index
2950                     	xdef	_pwm_brightness
2951                     	xdef	_frame_counter
2952                     	xref	_UART1_Cmd
2953                     	xref	_UART1_Init
2954                     	xref	_UART1_DeInit
2955                     	xref	_GPIO_ReadInputPin
2956                     	xref	_GPIO_Init
2957                     	xdef	_set_led
2958                     	xdef	_set_mat
2959                     	xdef	_get_eeprom_byte
2960                     	xdef	_get_random
2961                     	xdef	_is_button_down
2962                     	xdef	_clear_button_events
2963                     	xdef	_clear_button_event
2964                     	xdef	_get_button_event
2965                     	xdef	_update_buttons
2966                     	xdef	_is_developer_valid
2967                     	xdef	_set_hue_max
2968                     	xdef	_flush_leds
2969                     	xdef	_set_debug
2970                     	xdef	_set_white
2971                     	xdef	_set_rgb
2972                     	xdef	_set_matrix_high_z
2973                     	xdef	_millis
2974                     	xdef	_setup_main
2975                     	xdef	_is_application_valid
2976                     	xdef	_setup_serial
2977                     	xdef	_hello_world
2978                     	xref.b	c_lreg
2979                     	xref.b	c_x
2980                     	xref.b	c_y
3000                     	xref	c_xymov
3001                     	xref	c_lzmp
3002                     	xref	c_lsub
3003                     	xref	c_rtol
3004                     	xref	c_uitolx
3005                     	xref	c_itolx
3006                     	xref	c_ltor
3007                     	xref	c_imul
3008                     	end
