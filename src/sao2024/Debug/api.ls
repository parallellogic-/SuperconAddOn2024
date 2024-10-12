   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _api_counter:
  16  0000 00000000      	dc.l	0
  17  0004               _pwm_brightness:
  18  0004 0001          	dc.w	1
  19  0006 0001          	dc.w	1
  20  0008 000000000000  	ds.b	120
  21  0080               _pwm_sleep:
  22  0080 0001          	dc.w	1
  23  0082 0001          	dc.w	1
  24  0084               _pwm_led_count:
  25  0084 01            	dc.b	1
  26  0085 01            	dc.b	1
  27  0086               _pwm_visible_index:
  28  0086 00            	dc.b	0
  29  0087               _pwm_state:
  30  0087 00            	dc.b	0
  31  0088               _temp_delete_me:
  32  0088 0000          	dc.w	0
  33  008a               _temp3_delete_me:
  34  008a 0000          	dc.w	0
 109                     .const:	section	.text
 110  0000               L6:
 111  0000 00000100      	dc.l	256
 112                     ; 32 void hello_world()
 112                     ; 33 {//basic program that blinks the debug LED ON/OFF
 113                     	scross	off
 114                     	switch	.text
 115  0000               _hello_world:
 117  0000 5205          	subw	sp,#5
 118       00000005      OFST:	set	5
 121                     ; 36 	bool is_high=0;
 123                     ; 37 	long frame=0;
 125  0002 ae0000        	ldw	x,#0
 126  0005 1f04          	ldw	(OFST-1,sp),x
 127  0007 ae0000        	ldw	x,#0
 128  000a 1f02          	ldw	(OFST-3,sp),x
 130                     ; 38 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 132  000c 4b40          	push	#64
 133  000e 4b08          	push	#8
 134  0010 ae5000        	ldw	x,#20480
 135  0013 cd0000        	call	_GPIO_Init
 137  0016 85            	popw	x
 138                     ; 39 set_debug(0xFF);
 140  0017 a6ff          	ld	a,#255
 141  0019 cd056e        	call	_set_debug
 143                     ; 40 set_white(1,0xFF);
 145  001c ae01ff        	ldw	x,#511
 146  001f cd0564        	call	_set_white
 148                     ; 41 set_rgb(1,1,0xFF);
 150  0022 4bff          	push	#255
 151  0024 ae0101        	ldw	x,#257
 152  0027 cd0551        	call	_set_rgb
 154  002a 84            	pop	a
 155                     ; 42 flush_leds(7);
 157  002b a607          	ld	a,#7
 158  002d cd03e4        	call	_flush_leds
 160  0030               L34:
 161                     ; 45 		frame++;
 163  0030 96            	ldw	x,sp
 164  0031 1c0002        	addw	x,#OFST-3
 165  0034 a601          	ld	a,#1
 166  0036 cd0000        	call	c_lgadc
 169                     ; 46 		if(frame%256==0)
 171  0039 96            	ldw	x,sp
 172  003a 1c0002        	addw	x,#OFST-3
 173  003d cd0000        	call	c_ltor
 175  0040 ae0000        	ldw	x,#L6
 176  0043 cd0000        	call	c_lmod
 178  0046 cd0000        	call	c_lrzmp
 180  0049 26e5          	jrne	L34
 181  004b 20e3          	jra	L34
 233                     ; 69 u16 get_random(u16 x)
 233                     ; 70 {
 234                     	switch	.text
 235  004d               _get_random:
 237  004d 5204          	subw	sp,#4
 238       00000004      OFST:	set	4
 241                     ; 71 	u16 a=1664525;
 243                     ; 72 	u16 c=1013904223;
 245                     ; 73 	return a * x + c;
 247  004f 90ae660d      	ldw	y,#26125
 248  0053 cd0000        	call	c_imul
 250  0056 1cf35f        	addw	x,#62303
 253  0059 5b04          	addw	sp,#4
 254  005b 81            	ret
 303                     	switch	.const
 304  0004               L02:
 305  0004 000f4240      	dc.l	1000000
 306                     ; 76 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 306                     ; 77 {
 307                     	switch	.text
 308  005c               _setup_serial:
 310  005c 89            	pushw	x
 311       00000000      OFST:	set	0
 314                     ; 78 	if(is_enabled)
 316  005d 9e            	ld	a,xh
 317  005e 4d            	tnz	a
 318  005f 2747          	jreq	L121
 319                     ; 80 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 321  0061 4bf0          	push	#240
 322  0063 4b20          	push	#32
 323  0065 ae500f        	ldw	x,#20495
 324  0068 cd0000        	call	_GPIO_Init
 326  006b 85            	popw	x
 327                     ; 81 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 329  006c 4b40          	push	#64
 330  006e 4b40          	push	#64
 331  0070 ae500f        	ldw	x,#20495
 332  0073 cd0000        	call	_GPIO_Init
 334  0076 85            	popw	x
 335                     ; 82 		UART1_DeInit();
 337  0077 cd0000        	call	_UART1_DeInit
 339                     ; 83 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 341  007a 4b0c          	push	#12
 342  007c 4b80          	push	#128
 343  007e 4b00          	push	#0
 344  0080 4b00          	push	#0
 345  0082 4b00          	push	#0
 346  0084 0d07          	tnz	(OFST+7,sp)
 347  0086 2708          	jreq	L41
 348  0088 ae2580        	ldw	x,#9600
 349  008b cd0000        	call	c_itolx
 351  008e 2006          	jra	L61
 352  0090               L41:
 353  0090 ae0004        	ldw	x,#L02
 354  0093 cd0000        	call	c_ltor
 356  0096               L61:
 357  0096 be02          	ldw	x,c_lreg+2
 358  0098 89            	pushw	x
 359  0099 be00          	ldw	x,c_lreg
 360  009b 89            	pushw	x
 361  009c cd0000        	call	_UART1_Init
 363  009f 5b09          	addw	sp,#9
 364                     ; 84 		UART1_Cmd(ENABLE);
 366  00a1 a601          	ld	a,#1
 367  00a3 cd0000        	call	_UART1_Cmd
 370  00a6 201d          	jra	L321
 371  00a8               L121:
 372                     ; 86 		UART1_Cmd(DISABLE);
 374  00a8 4f            	clr	a
 375  00a9 cd0000        	call	_UART1_Cmd
 377                     ; 87 		UART1_DeInit();
 379  00ac cd0000        	call	_UART1_DeInit
 381                     ; 88 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 383  00af 4b40          	push	#64
 384  00b1 4b20          	push	#32
 385  00b3 ae500f        	ldw	x,#20495
 386  00b6 cd0000        	call	_GPIO_Init
 388  00b9 85            	popw	x
 389                     ; 89 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 391  00ba 4b40          	push	#64
 392  00bc 4b40          	push	#64
 393  00be ae500f        	ldw	x,#20495
 394  00c1 cd0000        	call	_GPIO_Init
 396  00c4 85            	popw	x
 397  00c5               L321:
 398                     ; 91 }
 401  00c5 85            	popw	x
 402  00c6 81            	ret
 429                     ; 94 bool is_application_valid()
 429                     ; 95 {
 430                     	switch	.text
 431  00c7               _is_application_valid:
 435                     ; 96 	return !is_button_down(2) && !get_button_event(0,1);
 437  00c7 a602          	ld	a,#2
 438  00c9 cd01fe        	call	_is_button_down
 440  00cc 4d            	tnz	a
 441  00cd 260d          	jrne	L42
 442  00cf ae0001        	ldw	x,#1
 443  00d2 cd01af        	call	_get_button_event
 445  00d5 4d            	tnz	a
 446  00d6 2604          	jrne	L42
 447  00d8 a601          	ld	a,#1
 448  00da 2001          	jra	L62
 449  00dc               L42:
 450  00dc 4f            	clr	a
 451  00dd               L62:
 454  00dd 81            	ret
 480                     ; 100 bool is_developer_valid()
 480                     ; 101 {
 481                     	switch	.text
 482  00de               _is_developer_valid:
 486                     ; 102 	return is_button_down(2) && !get_button_event(0,1);
 488  00de a602          	ld	a,#2
 489  00e0 cd01fe        	call	_is_button_down
 491  00e3 4d            	tnz	a
 492  00e4 270d          	jreq	L23
 493  00e6 ae0001        	ldw	x,#1
 494  00e9 cd01af        	call	_get_button_event
 496  00ec 4d            	tnz	a
 497  00ed 2604          	jrne	L23
 498  00ef a601          	ld	a,#1
 499  00f1 2001          	jra	L43
 500  00f3               L23:
 501  00f3 4f            	clr	a
 502  00f4               L43:
 505  00f4 81            	ret
 530                     ; 105 void setup_main()
 530                     ; 106 {
 531                     	switch	.text
 532  00f5               _setup_main:
 536                     ; 107 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 538  00f5 c650c6        	ld	a,20678
 539  00f8 a4e7          	and	a,#231
 540  00fa c750c6        	ld	20678,a
 541                     ; 109 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 543  00fd 4b40          	push	#64
 544  00ff 4b02          	push	#2
 545  0101 ae500f        	ldw	x,#20495
 546  0104 cd0000        	call	_GPIO_Init
 548  0107 85            	popw	x
 549                     ; 112 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 551  0108 725f5311      	clr	21265
 552                     ; 113 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 554  010c 3505530e      	mov	21262,#5
 555                     ; 114 	TIM2->ARRH= 16;// init auto reload register
 557  0110 3510530f      	mov	21263,#16
 558                     ; 115 	TIM2->ARRL= 255;// init auto reload register
 560  0114 35ff5310      	mov	21264,#255
 561                     ; 117 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 563  0118 c65300        	ld	a,21248
 564  011b aa05          	or	a,#5
 565  011d c75300        	ld	21248,a
 566                     ; 119 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 568  0120 35015303      	mov	21251,#1
 569                     ; 120 	enableInterrupts();
 572  0124 9a            rim
 574                     ; 121 }
 578  0125 81            	ret
 602                     ; 123 u32 millis()
 602                     ; 124 {
 603                     	switch	.text
 604  0126               _millis:
 608                     ; 125 	return api_counter>>10;
 610  0126 ae0000        	ldw	x,#_api_counter
 611  0129 cd0000        	call	c_ltor
 613  012c a60a          	ld	a,#10
 614  012e cd0000        	call	c_lursh
 618  0131 81            	ret
 676                     ; 131 void update_buttons()
 676                     ; 132 {
 677                     	switch	.text
 678  0132               _update_buttons:
 680  0132 5208          	subw	sp,#8
 681       00000008      OFST:	set	8
 684                     ; 133 	bool is_any_down=0;
 686  0134 0f05          	clr	(OFST-3,sp)
 688                     ; 135 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 690  0136 be06          	ldw	x,_button_start_ms+2
 691  0138 cd0000        	call	c_uitolx
 693  013b 96            	ldw	x,sp
 694  013c 1c0001        	addw	x,#OFST-7
 695  013f cd0000        	call	c_rtol
 698  0142 ade2          	call	_millis
 700  0144 96            	ldw	x,sp
 701  0145 1c0001        	addw	x,#OFST-7
 702  0148 cd0000        	call	c_lsub
 704  014b be02          	ldw	x,c_lreg+2
 705  014d 1f06          	ldw	(OFST-2,sp),x
 707                     ; 136 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 709  014f 0f08          	clr	(OFST+0,sp)
 711  0151               L312:
 712                     ; 138 		if(is_button_down(button_index))
 714  0151 7b08          	ld	a,(OFST+0,sp)
 715  0153 cd01fe        	call	_is_button_down
 717  0156 4d            	tnz	a
 718  0157 271b          	jreq	L122
 719                     ; 140 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 721  0159 ae0004        	ldw	x,#_button_start_ms
 722  015c cd0000        	call	c_lzmp
 724  015f 2608          	jrne	L322
 727  0161 adc3          	call	_millis
 729  0163 ae0004        	ldw	x,#_button_start_ms
 730  0166 cd0000        	call	c_rtol
 732  0169               L322:
 733                     ; 141 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 735  0169 a6ff          	ld	a,#255
 736  016b cd056e        	call	_set_debug
 738                     ; 142 			is_any_down=1;
 740  016e a601          	ld	a,#1
 741  0170 6b05          	ld	(OFST-3,sp),a
 744  0172 2022          	jra	L522
 745  0174               L122:
 746                     ; 144 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 748  0174 1e06          	ldw	x,(OFST-2,sp)
 749  0176 a30201        	cpw	x,#513
 750  0179 250b          	jrult	L722
 753  017b 7b08          	ld	a,(OFST+0,sp)
 754  017d 5f            	clrw	x
 755  017e 97            	ld	xl,a
 756  017f 58            	sllw	x
 757  0180 a601          	ld	a,#1
 758  0182 e701          	ld	(_button_pressed_event+1,x),a
 760  0184 2010          	jra	L522
 761  0186               L722:
 762                     ; 145 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 764  0186 1e06          	ldw	x,(OFST-2,sp)
 765  0188 a30033        	cpw	x,#51
 766  018b 2509          	jrult	L522
 769  018d 7b08          	ld	a,(OFST+0,sp)
 770  018f 5f            	clrw	x
 771  0190 97            	ld	xl,a
 772  0191 58            	sllw	x
 773  0192 a601          	ld	a,#1
 774  0194 e700          	ld	(_button_pressed_event,x),a
 775  0196               L522:
 776                     ; 136 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 778  0196 0c08          	inc	(OFST+0,sp)
 782  0198 7b08          	ld	a,(OFST+0,sp)
 783  019a a102          	cp	a,#2
 784  019c 25b3          	jrult	L312
 785                     ; 149 	if(!is_any_down) button_start_ms=0;
 787  019e 0d05          	tnz	(OFST-3,sp)
 788  01a0 260a          	jrne	L532
 791  01a2 ae0000        	ldw	x,#0
 792  01a5 bf06          	ldw	_button_start_ms+2,x
 793  01a7 ae0000        	ldw	x,#0
 794  01aa bf04          	ldw	_button_start_ms,x
 795  01ac               L532:
 796                     ; 150 }
 799  01ac 5b08          	addw	sp,#8
 800  01ae 81            	ret
 846                     ; 153 bool get_button_event(u8 button_index,bool is_long)
 846                     ; 154 { return button_pressed_event[button_index][is_long]; }
 847                     	switch	.text
 848  01af               _get_button_event:
 850  01af 89            	pushw	x
 851       00000000      OFST:	set	0
 856  01b0 9e            	ld	a,xh
 857  01b1 5f            	clrw	x
 858  01b2 97            	ld	xl,a
 859  01b3 58            	sllw	x
 860  01b4 01            	rrwa	x,a
 861  01b5 1b02          	add	a,(OFST+2,sp)
 862  01b7 2401          	jrnc	L64
 863  01b9 5c            	incw	x
 864  01ba               L64:
 865  01ba 02            	rlwa	x,a
 866  01bb e600          	ld	a,(_button_pressed_event,x)
 869  01bd 85            	popw	x
 870  01be 81            	ret
 926                     ; 157 bool clear_button_event(u8 button_index,bool is_long)
 926                     ; 158 {
 927                     	switch	.text
 928  01bf               _clear_button_event:
 930  01bf 89            	pushw	x
 931  01c0 88            	push	a
 932       00000001      OFST:	set	1
 935                     ; 159 	bool out=button_pressed_event[button_index][is_long];
 937  01c1 9e            	ld	a,xh
 938  01c2 5f            	clrw	x
 939  01c3 97            	ld	xl,a
 940  01c4 58            	sllw	x
 941  01c5 01            	rrwa	x,a
 942  01c6 1b03          	add	a,(OFST+2,sp)
 943  01c8 2401          	jrnc	L25
 944  01ca 5c            	incw	x
 945  01cb               L25:
 946  01cb 02            	rlwa	x,a
 947  01cc e600          	ld	a,(_button_pressed_event,x)
 948  01ce 6b01          	ld	(OFST+0,sp),a
 950                     ; 160 	button_pressed_event[button_index][is_long]=0;
 952  01d0 7b02          	ld	a,(OFST+1,sp)
 953  01d2 5f            	clrw	x
 954  01d3 97            	ld	xl,a
 955  01d4 58            	sllw	x
 956  01d5 01            	rrwa	x,a
 957  01d6 1b03          	add	a,(OFST+2,sp)
 958  01d8 2401          	jrnc	L45
 959  01da 5c            	incw	x
 960  01db               L45:
 961  01db 02            	rlwa	x,a
 962  01dc 6f00          	clr	(_button_pressed_event,x)
 963                     ; 161 	return out;
 965  01de 7b01          	ld	a,(OFST+0,sp)
 968  01e0 5b03          	addw	sp,#3
 969  01e2 81            	ret
1005                     ; 164 void clear_button_events()
1005                     ; 165 {
1006                     	switch	.text
1007  01e3               _clear_button_events:
1009  01e3 88            	push	a
1010       00000001      OFST:	set	1
1013                     ; 167 	for(iter=0;iter<BUTTON_COUNT;iter++)
1015  01e4 0f01          	clr	(OFST+0,sp)
1017  01e6               L523:
1018                     ; 169 		clear_button_event(iter,0);
1020  01e6 7b01          	ld	a,(OFST+0,sp)
1021  01e8 5f            	clrw	x
1022  01e9 95            	ld	xh,a
1023  01ea add3          	call	_clear_button_event
1025                     ; 170 		clear_button_event(iter,1);
1027  01ec 7b01          	ld	a,(OFST+0,sp)
1028  01ee ae0001        	ldw	x,#1
1029  01f1 95            	ld	xh,a
1030  01f2 adcb          	call	_clear_button_event
1032                     ; 167 	for(iter=0;iter<BUTTON_COUNT;iter++)
1034  01f4 0c01          	inc	(OFST+0,sp)
1038  01f6 7b01          	ld	a,(OFST+0,sp)
1039  01f8 a102          	cp	a,#2
1040  01fa 25ea          	jrult	L523
1041                     ; 172 }
1044  01fc 84            	pop	a
1045  01fd 81            	ret
1081                     ; 175 bool is_button_down(u8 index)
1081                     ; 176 {
1082                     	switch	.text
1083  01fe               _is_button_down:
1087                     ; 177 	switch(index)
1090                     ; 181 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1092  01fe 4d            	tnz	a
1093  01ff 2708          	jreq	L333
1094  0201 4a            	dec	a
1095  0202 2718          	jreq	L533
1096  0204 4a            	dec	a
1097  0205 2728          	jreq	L733
1098  0207 2039          	jra	L163
1099  0209               L333:
1100                     ; 179 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1102  0209 4b20          	push	#32
1103  020b ae500f        	ldw	x,#20495
1104  020e cd0000        	call	_GPIO_ReadInputPin
1106  0211 5b01          	addw	sp,#1
1107  0213 4d            	tnz	a
1108  0214 2604          	jrne	L26
1109  0216 a601          	ld	a,#1
1110  0218 2001          	jra	L46
1111  021a               L26:
1112  021a 4f            	clr	a
1113  021b               L46:
1116  021b 81            	ret
1117  021c               L533:
1118                     ; 180 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1121  021c 4b40          	push	#64
1122  021e ae500f        	ldw	x,#20495
1123  0221 cd0000        	call	_GPIO_ReadInputPin
1125  0224 5b01          	addw	sp,#1
1126  0226 4d            	tnz	a
1127  0227 2604          	jrne	L66
1128  0229 a601          	ld	a,#1
1129  022b 2001          	jra	L07
1130  022d               L66:
1131  022d 4f            	clr	a
1132  022e               L07:
1135  022e 81            	ret
1136  022f               L733:
1137                     ; 181 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1140  022f 4b02          	push	#2
1141  0231 ae500f        	ldw	x,#20495
1142  0234 cd0000        	call	_GPIO_ReadInputPin
1144  0237 5b01          	addw	sp,#1
1145  0239 4d            	tnz	a
1146  023a 2604          	jrne	L27
1147  023c a601          	ld	a,#1
1148  023e 2001          	jra	L47
1149  0240               L27:
1150  0240 4f            	clr	a
1151  0241               L47:
1154  0241 81            	ret
1155  0242               L163:
1156                     ; 183 	return 0;
1158  0242 4f            	clr	a
1161  0243 81            	ret
1213                     ; 187 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1215                     	switch	.text
1216  0244               f_TIM2_UPD_OVF_IRQHandler:
1218  0244 8a            	push	cc
1219  0245 84            	pop	a
1220  0246 a4bf          	and	a,#191
1221  0248 88            	push	a
1222  0249 86            	pop	cc
1223       00000005      OFST:	set	5
1224  024a 3b0002        	push	c_x+2
1225  024d be00          	ldw	x,c_x
1226  024f 89            	pushw	x
1227  0250 3b0002        	push	c_y+2
1228  0253 be00          	ldw	x,c_y
1229  0255 89            	pushw	x
1230  0256 5205          	subw	sp,#5
1233                     ; 188 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1235  0258 b687          	ld	a,_pwm_state
1236  025a a401          	and	a,#1
1237  025c 6b05          	ld	(OFST+0,sp),a
1239                     ; 189 	u16 sleep_counts=1;
1241  025e ae0001        	ldw	x,#1
1242  0261 1f03          	ldw	(OFST-2,sp),x
1244                     ; 191 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1246  0263 c6500c        	ld	a,20492
1247  0266 a407          	and	a,#7
1248  0268 c7500c        	ld	20492,a
1249                     ; 192 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1251  026b 72155011      	bres	20497,#2
1252                     ; 193 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1254  026f 72175002      	bres	20482,#3
1255                     ; 194 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1257  0273 c6500d        	ld	a,20493
1258  0276 a407          	and	a,#7
1259  0278 c7500d        	ld	20493,a
1260                     ; 195 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1262  027b 72155012      	bres	20498,#2
1263                     ; 196 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1265  027f 72175003      	bres	20483,#3
1266                     ; 197   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1268  0283 72115300      	bres	21248,#0
1269                     ; 198 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1271  0287 7b05          	ld	a,(OFST+0,sp)
1272  0289 5f            	clrw	x
1273  028a 97            	ld	xl,a
1274  028b e684          	ld	a,(_pwm_led_count,x)
1275  028d b186          	cp	a,_pwm_visible_index
1276  028f 2609          	jrne	L504
1277                     ; 200 		sleep_counts=pwm_sleep[buffer_index];
1279  0291 7b05          	ld	a,(OFST+0,sp)
1280  0293 5f            	clrw	x
1281  0294 97            	ld	xl,a
1282  0295 58            	sllw	x
1283  0296 ee80          	ldw	x,(_pwm_sleep,x)
1284  0298 1f03          	ldw	(OFST-2,sp),x
1286  029a               L504:
1287                     ; 202 	if(pwm_visible_index>pwm_led_count[buffer_index])
1289  029a 7b05          	ld	a,(OFST+0,sp)
1290  029c 5f            	clrw	x
1291  029d 97            	ld	xl,a
1292  029e e684          	ld	a,(_pwm_led_count,x)
1293  02a0 b186          	cp	a,_pwm_visible_index
1294  02a2 2414          	jruge	L704
1295                     ; 204 		pwm_visible_index=0;//formally start new frame
1297  02a4 3f86          	clr	_pwm_visible_index
1298                     ; 205 		if(pwm_state&0x02)
1300  02a6 b687          	ld	a,_pwm_state
1301  02a8 a502          	bcp	a,#2
1302  02aa 270c          	jreq	L704
1303                     ; 207 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1305  02ac b687          	ld	a,_pwm_state
1306  02ae a803          	xor	a,#3
1307  02b0 b787          	ld	_pwm_state,a
1308                     ; 208 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1310  02b2 b687          	ld	a,_pwm_state
1311  02b4 a401          	and	a,#1
1312  02b6 6b05          	ld	(OFST+0,sp),a
1314  02b8               L704:
1315                     ; 211 	if(pwm_visible_index<pwm_led_count[buffer_index])
1317  02b8 7b05          	ld	a,(OFST+0,sp)
1318  02ba 5f            	clrw	x
1319  02bb 97            	ld	xl,a
1320  02bc e684          	ld	a,(_pwm_led_count,x)
1321  02be b186          	cp	a,_pwm_visible_index
1322  02c0 2324          	jrule	L314
1323                     ; 213 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1325  02c2 7b05          	ld	a,(OFST+0,sp)
1326  02c4 5f            	clrw	x
1327  02c5 97            	ld	xl,a
1328  02c6 58            	sllw	x
1329  02c7 1f01          	ldw	(OFST-4,sp),x
1331  02c9 b686          	ld	a,_pwm_visible_index
1332  02cb 97            	ld	xl,a
1333  02cc a604          	ld	a,#4
1334  02ce 42            	mul	x,a
1335  02cf 72fb01        	addw	x,(OFST-4,sp)
1336  02d2 ee04          	ldw	x,(_pwm_brightness,x)
1337  02d4 1f03          	ldw	(OFST-2,sp),x
1339                     ; 214 		set_led(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1341  02d6 b686          	ld	a,_pwm_visible_index
1342  02d8 5f            	clrw	x
1343  02d9 97            	ld	xl,a
1344  02da 58            	sllw	x
1345  02db 01            	rrwa	x,a
1346  02dc 1b05          	add	a,(OFST+0,sp)
1347  02de 2401          	jrnc	L001
1348  02e0 5c            	incw	x
1349  02e1               L001:
1350  02e1 02            	rlwa	x,a
1351  02e2 e627          	ld	a,(_pwm_brightness_index,x)
1352  02e4 ad2d          	call	_set_led
1354  02e6               L314:
1355                     ; 216 	pwm_visible_index++;
1357  02e6 3c86          	inc	_pwm_visible_index
1358                     ; 218   TIM2->CNTRH = 0;// Set the high byte of the counter
1360  02e8 725f530c      	clr	21260
1361                     ; 219   TIM2->CNTRL = 0;// Set the low byte of the counter
1363  02ec 725f530d      	clr	21261
1364                     ; 220 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1366  02f0 7b03          	ld	a,(OFST-2,sp)
1367  02f2 c7530f        	ld	21263,a
1368                     ; 221 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1370  02f5 7b04          	ld	a,(OFST-1,sp)
1371  02f7 a4ff          	and	a,#255
1372  02f9 c75310        	ld	21264,a
1373                     ; 223 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1375  02fc 72115304      	bres	21252,#0
1376                     ; 224   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1378  0300 72105300      	bset	21248,#0
1379                     ; 225 }
1382  0304 5b05          	addw	sp,#5
1383  0306 85            	popw	x
1384  0307 bf00          	ldw	c_y,x
1385  0309 320002        	pop	c_y+2
1386  030c 85            	popw	x
1387  030d bf00          	ldw	c_x,x
1388  030f 320002        	pop	c_x+2
1389  0312 80            	iret
1391                     	switch	.const
1392  0008               L514_led_lookup:
1393  0008 00            	dc.b	0
1394  0009 03            	dc.b	3
1395  000a 01            	dc.b	1
1396  000b 03            	dc.b	3
1397  000c 02            	dc.b	2
1398  000d 03            	dc.b	3
1399  000e 03            	dc.b	3
1400  000f 00            	dc.b	0
1401  0010 04            	dc.b	4
1402  0011 00            	dc.b	0
1403  0012 05            	dc.b	5
1404  0013 00            	dc.b	0
1405  0014 00            	dc.b	0
1406  0015 04            	dc.b	4
1407  0016 01            	dc.b	1
1408  0017 04            	dc.b	4
1409  0018 02            	dc.b	2
1410  0019 04            	dc.b	4
1411  001a 03            	dc.b	3
1412  001b 01            	dc.b	1
1413  001c 04            	dc.b	4
1414  001d 01            	dc.b	1
1415  001e 05            	dc.b	5
1416  001f 01            	dc.b	1
1417  0020 00            	dc.b	0
1418  0021 05            	dc.b	5
1419  0022 01            	dc.b	1
1420  0023 05            	dc.b	5
1421  0024 02            	dc.b	2
1422  0025 05            	dc.b	5
1423  0026 03            	dc.b	3
1424  0027 02            	dc.b	2
1425  0028 04            	dc.b	4
1426  0029 02            	dc.b	2
1427  002a 05            	dc.b	5
1428  002b 02            	dc.b	2
1429  002c 06            	dc.b	6
1430  002d 06            	dc.b	6
1431  002e 01            	dc.b	1
1432  002f 00            	dc.b	0
1433  0030 02            	dc.b	2
1434  0031 00            	dc.b	0
1435  0032 00            	dc.b	0
1436  0033 01            	dc.b	1
1437  0034 02            	dc.b	2
1438  0035 01            	dc.b	1
1439  0036 00            	dc.b	0
1440  0037 02            	dc.b	2
1441  0038 01            	dc.b	1
1442  0039 02            	dc.b	2
1443  003a 04            	dc.b	4
1444  003b 03            	dc.b	3
1445  003c 05            	dc.b	5
1446  003d 03            	dc.b	3
1447  003e 03            	dc.b	3
1448  003f 04            	dc.b	4
1449  0040 05            	dc.b	5
1450  0041 04            	dc.b	4
1451  0042 03            	dc.b	3
1452  0043 05            	dc.b	5
1453  0044 04            	dc.b	4
1454  0045 05            	dc.b	5
1498                     ; 228 void set_led(u8 led_index)
1498                     ; 229 {
1500                     	switch	.text
1501  0313               _set_led:
1503  0313 88            	push	a
1504  0314 5240          	subw	sp,#64
1505       00000040      OFST:	set	64
1508                     ; 230 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1508                     ; 231 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1508                     ; 232 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1508                     ; 233 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1508                     ; 234 		{6,6},//debug; GND is tied low, no charlieplexing involved
1508                     ; 235 		{1,0},//LED7
1508                     ; 236 		{2,0},//LED8
1508                     ; 237 		{0,1},//LED9
1508                     ; 238 		{2,1},//LED10
1508                     ; 239 		{0,2},//LED11
1508                     ; 240 		{1,2},//LED12
1508                     ; 241 		{4,3},//LED13
1508                     ; 242 		{5,3},//LED14
1508                     ; 243 		{3,4},//LED15
1508                     ; 244 		{5,4},//LED16
1508                     ; 245 		{3,5},//LED17
1508                     ; 246 		{4,5} //LED18
1508                     ; 247 	};
1510  0316 96            	ldw	x,sp
1511  0317 1c0003        	addw	x,#OFST-61
1512  031a 90ae0008      	ldw	y,#L514_led_lookup
1513  031e a63e          	ld	a,#62
1514  0320 cd0000        	call	c_xymov
1516                     ; 248 	set_mat(led_lookup[led_index][0],1);
1518  0323 96            	ldw	x,sp
1519  0324 1c0003        	addw	x,#OFST-61
1520  0327 1f01          	ldw	(OFST-63,sp),x
1522  0329 7b41          	ld	a,(OFST+1,sp)
1523  032b 5f            	clrw	x
1524  032c 97            	ld	xl,a
1525  032d 58            	sllw	x
1526  032e 72fb01        	addw	x,(OFST-63,sp)
1527  0331 f6            	ld	a,(x)
1528  0332 ae0001        	ldw	x,#1
1529  0335 95            	ld	xh,a
1530  0336 ad1c          	call	_set_mat
1532                     ; 250 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1534  0338 7b41          	ld	a,(OFST+1,sp)
1535  033a a112          	cp	a,#18
1536  033c 2713          	jreq	L144
1539  033e 96            	ldw	x,sp
1540  033f 1c0004        	addw	x,#OFST-60
1541  0342 1f01          	ldw	(OFST-63,sp),x
1543  0344 7b41          	ld	a,(OFST+1,sp)
1544  0346 5f            	clrw	x
1545  0347 97            	ld	xl,a
1546  0348 58            	sllw	x
1547  0349 72fb01        	addw	x,(OFST-63,sp)
1548  034c f6            	ld	a,(x)
1549  034d 5f            	clrw	x
1550  034e 95            	ld	xh,a
1551  034f ad03          	call	_set_mat
1553  0351               L144:
1554                     ; 251 }
1557  0351 5b41          	addw	sp,#65
1558  0353 81            	ret
1759                     ; 254 void set_mat(u8 mat_index,bool is_high)
1759                     ; 255 {
1760                     	switch	.text
1761  0354               _set_mat:
1763  0354 89            	pushw	x
1764  0355 5203          	subw	sp,#3
1765       00000003      OFST:	set	3
1768                     ; 258 	if(mat_index==0)
1770  0357 9e            	ld	a,xh
1771  0358 4d            	tnz	a
1772  0359 2609          	jrne	L165
1773                     ; 260 		GPIOx=GPIOC;
1775  035b ae500a        	ldw	x,#20490
1776  035e 1f01          	ldw	(OFST-2,sp),x
1778                     ; 261 		GPIO_Pin=GPIO_PIN_3;
1780  0360 a608          	ld	a,#8
1781  0362 6b03          	ld	(OFST+0,sp),a
1783  0364               L165:
1784                     ; 263 	if(mat_index==1)
1786  0364 7b04          	ld	a,(OFST+1,sp)
1787  0366 a101          	cp	a,#1
1788  0368 2609          	jrne	L365
1789                     ; 265 		GPIOx=GPIOC;
1791  036a ae500a        	ldw	x,#20490
1792  036d 1f01          	ldw	(OFST-2,sp),x
1794                     ; 266 		GPIO_Pin=GPIO_PIN_4;
1796  036f a610          	ld	a,#16
1797  0371 6b03          	ld	(OFST+0,sp),a
1799  0373               L365:
1800                     ; 268 	if(mat_index==2)
1802  0373 7b04          	ld	a,(OFST+1,sp)
1803  0375 a102          	cp	a,#2
1804  0377 2609          	jrne	L565
1805                     ; 270 		GPIOx=GPIOC;
1807  0379 ae500a        	ldw	x,#20490
1808  037c 1f01          	ldw	(OFST-2,sp),x
1810                     ; 271 		GPIO_Pin=GPIO_PIN_5;
1812  037e a620          	ld	a,#32
1813  0380 6b03          	ld	(OFST+0,sp),a
1815  0382               L565:
1816                     ; 273 	if(mat_index==3)
1818  0382 7b04          	ld	a,(OFST+1,sp)
1819  0384 a103          	cp	a,#3
1820  0386 2609          	jrne	L765
1821                     ; 275 		GPIOx=GPIOC;
1823  0388 ae500a        	ldw	x,#20490
1824  038b 1f01          	ldw	(OFST-2,sp),x
1826                     ; 276 		GPIO_Pin=GPIO_PIN_6;
1828  038d a640          	ld	a,#64
1829  038f 6b03          	ld	(OFST+0,sp),a
1831  0391               L765:
1832                     ; 278 	if(mat_index==4)
1834  0391 7b04          	ld	a,(OFST+1,sp)
1835  0393 a104          	cp	a,#4
1836  0395 2609          	jrne	L175
1837                     ; 280 		GPIOx=GPIOC;
1839  0397 ae500a        	ldw	x,#20490
1840  039a 1f01          	ldw	(OFST-2,sp),x
1842                     ; 281 		GPIO_Pin=GPIO_PIN_7;
1844  039c a680          	ld	a,#128
1845  039e 6b03          	ld	(OFST+0,sp),a
1847  03a0               L175:
1848                     ; 283 	if(mat_index==5)
1850  03a0 7b04          	ld	a,(OFST+1,sp)
1851  03a2 a105          	cp	a,#5
1852  03a4 2609          	jrne	L375
1853                     ; 285 		GPIOx=GPIOD;
1855  03a6 ae500f        	ldw	x,#20495
1856  03a9 1f01          	ldw	(OFST-2,sp),x
1858                     ; 286 		GPIO_Pin=GPIO_PIN_2;
1860  03ab a604          	ld	a,#4
1861  03ad 6b03          	ld	(OFST+0,sp),a
1863  03af               L375:
1864                     ; 288 	if(mat_index==6)
1866  03af 7b04          	ld	a,(OFST+1,sp)
1867  03b1 a106          	cp	a,#6
1868  03b3 2609          	jrne	L575
1869                     ; 290 		GPIOx=GPIOA;
1871  03b5 ae5000        	ldw	x,#20480
1872  03b8 1f01          	ldw	(OFST-2,sp),x
1874                     ; 291 		GPIO_Pin=GPIO_PIN_3;
1876  03ba a608          	ld	a,#8
1877  03bc 6b03          	ld	(OFST+0,sp),a
1879  03be               L575:
1880                     ; 293 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1882  03be 0d05          	tnz	(OFST+2,sp)
1883  03c0 2708          	jreq	L775
1886  03c2 1e01          	ldw	x,(OFST-2,sp)
1887  03c4 f6            	ld	a,(x)
1888  03c5 1a03          	or	a,(OFST+0,sp)
1889  03c7 f7            	ld	(x),a
1891  03c8 2007          	jra	L106
1892  03ca               L775:
1893                     ; 294 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1895  03ca 1e01          	ldw	x,(OFST-2,sp)
1896  03cc 7b03          	ld	a,(OFST+0,sp)
1897  03ce 43            	cpl	a
1898  03cf f4            	and	a,(x)
1899  03d0 f7            	ld	(x),a
1900  03d1               L106:
1901                     ; 295 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
1903  03d1 1e01          	ldw	x,(OFST-2,sp)
1904  03d3 e602          	ld	a,(2,x)
1905  03d5 1a03          	or	a,(OFST+0,sp)
1906  03d7 e702          	ld	(2,x),a
1907                     ; 296 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1909  03d9 1e01          	ldw	x,(OFST-2,sp)
1910  03db e603          	ld	a,(3,x)
1911  03dd 1a03          	or	a,(OFST+0,sp)
1912  03df e703          	ld	(3,x),a
1913                     ; 297 }
1916  03e1 5b05          	addw	sp,#5
1917  03e3 81            	ret
1993                     ; 300 void flush_leds(u8 led_count)
1993                     ; 301 {
1994                     	switch	.text
1995  03e4               _flush_leds:
1997  03e4 88            	push	a
1998  03e5 5207          	subw	sp,#7
1999       00000007      OFST:	set	7
2002                     ; 302 	u8 led_read_index=0,led_write_index=0;
2006  03e7 0f05          	clr	(OFST-2,sp)
2009  03e9               L546:
2010                     ; 305 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2012  03e9 b687          	ld	a,_pwm_state
2013  03eb a502          	bcp	a,#2
2014  03ed 26fa          	jrne	L546
2015                     ; 306 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2017  03ef b687          	ld	a,_pwm_state
2018  03f1 a401          	and	a,#1
2019  03f3 a801          	xor	a,#1
2020  03f5 6b06          	ld	(OFST-1,sp),a
2022                     ; 308 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2024  03f7 7b08          	ld	a,(OFST+1,sp)
2025  03f9 5f            	clrw	x
2026  03fa 97            	ld	xl,a
2027  03fb 4f            	clr	a
2028  03fc 02            	rlwa	x,a
2029  03fd 58            	sllw	x
2030  03fe 58            	sllw	x
2031  03ff 7b06          	ld	a,(OFST-1,sp)
2032  0401 905f          	clrw	y
2033  0403 9097          	ld	yl,a
2034  0405 9058          	sllw	y
2035  0407 90ef80        	ldw	(_pwm_sleep,y),x
2036                     ; 310 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2038  040a 0f07          	clr	(OFST+0,sp)
2040  040c               L156:
2041                     ; 312 		read_brightness=pwm_brightness_buffer[led_read_index];
2043  040c 7b07          	ld	a,(OFST+0,sp)
2044  040e 5f            	clrw	x
2045  040f 97            	ld	xl,a
2046  0410 e608          	ld	a,(_pwm_brightness_buffer,x)
2047  0412 5f            	clrw	x
2048  0413 97            	ld	xl,a
2049  0414 1f03          	ldw	(OFST-4,sp),x
2051                     ; 313 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2053  0416 1e03          	ldw	x,(OFST-4,sp)
2054  0418 2767          	jreq	L756
2055                     ; 315 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2057  041a 7b05          	ld	a,(OFST-2,sp)
2058  041c 5f            	clrw	x
2059  041d 97            	ld	xl,a
2060  041e 58            	sllw	x
2061  041f 01            	rrwa	x,a
2062  0420 1b06          	add	a,(OFST-1,sp)
2063  0422 2401          	jrnc	L011
2064  0424 5c            	incw	x
2065  0425               L011:
2066  0425 02            	rlwa	x,a
2067  0426 7b07          	ld	a,(OFST+0,sp)
2068  0428 e727          	ld	(_pwm_brightness_index,x),a
2069                     ; 316 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2071  042a 1e03          	ldw	x,(OFST-4,sp)
2072  042c 1603          	ldw	y,(OFST-4,sp)
2073  042e cd0000        	call	c_imul
2075  0431 a606          	ld	a,#6
2076  0433               L211:
2077  0433 54            	srlw	x
2078  0434 4a            	dec	a
2079  0435 26fc          	jrne	L211
2080  0437 5c            	incw	x
2081  0438 7b06          	ld	a,(OFST-1,sp)
2082  043a 905f          	clrw	y
2083  043c 9097          	ld	yl,a
2084  043e 9058          	sllw	y
2085  0440 1701          	ldw	(OFST-6,sp),y
2087  0442 7b05          	ld	a,(OFST-2,sp)
2088  0444 905f          	clrw	y
2089  0446 9097          	ld	yl,a
2090  0448 9058          	sllw	y
2091  044a 9058          	sllw	y
2092  044c 72f901        	addw	y,(OFST-6,sp)
2093  044f 90ef04        	ldw	(_pwm_brightness,y),x
2094                     ; 317 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2096  0452 7b06          	ld	a,(OFST-1,sp)
2097  0454 5f            	clrw	x
2098  0455 97            	ld	xl,a
2099  0456 58            	sllw	x
2100  0457 7b06          	ld	a,(OFST-1,sp)
2101  0459 905f          	clrw	y
2102  045b 9097          	ld	yl,a
2103  045d 9058          	sllw	y
2104  045f 1701          	ldw	(OFST-6,sp),y
2106  0461 7b05          	ld	a,(OFST-2,sp)
2107  0463 905f          	clrw	y
2108  0465 9097          	ld	yl,a
2109  0467 9058          	sllw	y
2110  0469 9058          	sllw	y
2111  046b 72f901        	addw	y,(OFST-6,sp)
2112  046e 90ee04        	ldw	y,(_pwm_brightness,y)
2113  0471 9001          	rrwa	y,a
2114  0473 e081          	sub	a,(_pwm_sleep+1,x)
2115  0475 9001          	rrwa	y,a
2116  0477 e280          	sbc	a,(_pwm_sleep,x)
2117  0479 9001          	rrwa	y,a
2118  047b 9050          	negw	y
2119  047d ef80          	ldw	(_pwm_sleep,x),y
2120                     ; 318 			led_write_index++;
2122  047f 0c05          	inc	(OFST-2,sp)
2124  0481               L756:
2125                     ; 320 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2127  0481 7b07          	ld	a,(OFST+0,sp)
2128  0483 5f            	clrw	x
2129  0484 97            	ld	xl,a
2130  0485 6f08          	clr	(_pwm_brightness_buffer,x)
2131                     ; 310 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2133  0487 0c07          	inc	(OFST+0,sp)
2137  0489 7b07          	ld	a,(OFST+0,sp)
2138  048b a11f          	cp	a,#31
2139  048d 2403cc040c    	jrult	L156
2140                     ; 322 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2142  0492 7b06          	ld	a,(OFST-1,sp)
2143  0494 5f            	clrw	x
2144  0495 97            	ld	xl,a
2145  0496 7b05          	ld	a,(OFST-2,sp)
2146  0498 e784          	ld	(_pwm_led_count,x),a
2147                     ; 341 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2149  049a 72120087      	bset	_pwm_state,#1
2150                     ; 342 }
2153  049e 5b08          	addw	sp,#8
2154  04a0 81            	ret
2252                     ; 345 void set_hue_max(u8 index,u16 color)
2252                     ; 346 {
2253                     	switch	.text
2254  04a1               _set_hue_max:
2256  04a1 88            	push	a
2257  04a2 5207          	subw	sp,#7
2258       00000007      OFST:	set	7
2261                     ; 347 	const u8 brightness=255;
2263  04a4 a6ff          	ld	a,#255
2264  04a6 6b07          	ld	(OFST+0,sp),a
2266                     ; 348 	u8 red=0,green=0,blue=0;
2268  04a8 0f04          	clr	(OFST-3,sp)
2272  04aa 0f05          	clr	(OFST-2,sp)
2276  04ac 0f06          	clr	(OFST-1,sp)
2278                     ; 349 	u16 residual_16=color%(0x2AAB);
2280  04ae 1e0b          	ldw	x,(OFST+4,sp)
2281  04b0 90ae2aab      	ldw	y,#10923
2282  04b4 65            	divw	x,y
2283  04b5 51            	exgw	x,y
2284  04b6 1f01          	ldw	(OFST-6,sp),x
2286                     ; 350 	u8 residual_8=(residual_16<<8)/0x2AAB;
2288  04b8 1e01          	ldw	x,(OFST-6,sp)
2289  04ba 4f            	clr	a
2290  04bb 02            	rlwa	x,a
2291  04bc 90ae2aab      	ldw	y,#10923
2292  04c0 65            	divw	x,y
2293  04c1 01            	rrwa	x,a
2294  04c2 6b03          	ld	(OFST-4,sp),a
2295  04c4 02            	rlwa	x,a
2297                     ; 351 	switch(color/(0x2AAB))
2299  04c5 1e0b          	ldw	x,(OFST+4,sp)
2300  04c7 90ae2aab      	ldw	y,#10923
2301  04cb 65            	divw	x,y
2303                     ; 382 			break;
2304  04cc 5d            	tnzw	x
2305  04cd 2711          	jreq	L166
2306  04cf 5a            	decw	x
2307  04d0 271a          	jreq	L366
2308  04d2 5a            	decw	x
2309  04d3 2725          	jreq	L566
2310  04d5 5a            	decw	x
2311  04d6 272e          	jreq	L766
2312  04d8 5a            	decw	x
2313  04d9 2739          	jreq	L176
2314  04db 5a            	decw	x
2315  04dc 2742          	jreq	L376
2316  04de 204c          	jra	L357
2317  04e0               L166:
2318                     ; 354 			red=brightness;
2320  04e0 7b07          	ld	a,(OFST+0,sp)
2321  04e2 6b04          	ld	(OFST-3,sp),a
2323                     ; 355 			green=residual_8;
2325  04e4 7b03          	ld	a,(OFST-4,sp)
2326  04e6 6b05          	ld	(OFST-2,sp),a
2328                     ; 356 			blue=0;
2330  04e8 0f06          	clr	(OFST-1,sp)
2332                     ; 357 			break;
2334  04ea 2040          	jra	L357
2335  04ec               L366:
2336                     ; 359 			red=brightness-residual_8;
2338  04ec 7b07          	ld	a,(OFST+0,sp)
2339  04ee 1003          	sub	a,(OFST-4,sp)
2340  04f0 6b04          	ld	(OFST-3,sp),a
2342                     ; 360 			green=brightness;
2344  04f2 7b07          	ld	a,(OFST+0,sp)
2345  04f4 6b05          	ld	(OFST-2,sp),a
2347                     ; 361 			blue=0;
2349  04f6 0f06          	clr	(OFST-1,sp)
2351                     ; 362 			break;
2353  04f8 2032          	jra	L357
2354  04fa               L566:
2355                     ; 364 			red=0;
2357  04fa 0f04          	clr	(OFST-3,sp)
2359                     ; 365 			green=brightness;
2361  04fc 7b07          	ld	a,(OFST+0,sp)
2362  04fe 6b05          	ld	(OFST-2,sp),a
2364                     ; 366 			blue=residual_8;
2366  0500 7b03          	ld	a,(OFST-4,sp)
2367  0502 6b06          	ld	(OFST-1,sp),a
2369                     ; 367 			break;
2371  0504 2026          	jra	L357
2372  0506               L766:
2373                     ; 369 			red=0;
2375  0506 0f04          	clr	(OFST-3,sp)
2377                     ; 370 			green=brightness-residual_8;
2379  0508 7b07          	ld	a,(OFST+0,sp)
2380  050a 1003          	sub	a,(OFST-4,sp)
2381  050c 6b05          	ld	(OFST-2,sp),a
2383                     ; 371 			blue=brightness;
2385  050e 7b07          	ld	a,(OFST+0,sp)
2386  0510 6b06          	ld	(OFST-1,sp),a
2388                     ; 372 			break;
2390  0512 2018          	jra	L357
2391  0514               L176:
2392                     ; 374 			red=residual_8;
2394  0514 7b03          	ld	a,(OFST-4,sp)
2395  0516 6b04          	ld	(OFST-3,sp),a
2397                     ; 375 			green=0;
2399  0518 0f05          	clr	(OFST-2,sp)
2401                     ; 376 			blue=brightness;
2403  051a 7b07          	ld	a,(OFST+0,sp)
2404  051c 6b06          	ld	(OFST-1,sp),a
2406                     ; 377 			break;
2408  051e 200c          	jra	L357
2409  0520               L376:
2410                     ; 379 			red=brightness;
2412  0520 7b07          	ld	a,(OFST+0,sp)
2413  0522 6b04          	ld	(OFST-3,sp),a
2415                     ; 380 			green=0;
2417  0524 0f05          	clr	(OFST-2,sp)
2419                     ; 381 			blue=brightness-residual_8;
2421  0526 7b07          	ld	a,(OFST+0,sp)
2422  0528 1003          	sub	a,(OFST-4,sp)
2423  052a 6b06          	ld	(OFST-1,sp),a
2425                     ; 382 			break;
2427  052c               L357:
2428                     ; 385 	set_rgb(index,0,red);
2430  052c 7b04          	ld	a,(OFST-3,sp)
2431  052e 88            	push	a
2432  052f 7b09          	ld	a,(OFST+2,sp)
2433  0531 5f            	clrw	x
2434  0532 95            	ld	xh,a
2435  0533 ad1c          	call	_set_rgb
2437  0535 84            	pop	a
2438                     ; 386 	set_rgb(index,1,green);
2440  0536 7b05          	ld	a,(OFST-2,sp)
2441  0538 88            	push	a
2442  0539 7b09          	ld	a,(OFST+2,sp)
2443  053b ae0001        	ldw	x,#1
2444  053e 95            	ld	xh,a
2445  053f ad10          	call	_set_rgb
2447  0541 84            	pop	a
2448                     ; 387 	set_rgb(index,2,blue);
2450  0542 7b06          	ld	a,(OFST-1,sp)
2451  0544 88            	push	a
2452  0545 7b09          	ld	a,(OFST+2,sp)
2453  0547 ae0002        	ldw	x,#2
2454  054a 95            	ld	xh,a
2455  054b ad04          	call	_set_rgb
2457  054d 84            	pop	a
2458                     ; 388 }
2461  054e 5b08          	addw	sp,#8
2462  0550 81            	ret
2515                     ; 390 void set_rgb(u8 index,u8 color,u8 brightness)
2515                     ; 391 {
2516                     	switch	.text
2517  0551               _set_rgb:
2519  0551 89            	pushw	x
2520       00000000      OFST:	set	0
2523                     ; 392 	pwm_brightness_buffer[index+color*RGB_COUNT]=brightness;
2525  0552 9f            	ld	a,xl
2526  0553 97            	ld	xl,a
2527  0554 a606          	ld	a,#6
2528  0556 42            	mul	x,a
2529  0557 01            	rrwa	x,a
2530  0558 1b01          	add	a,(OFST+1,sp)
2531  055a 2401          	jrnc	L221
2532  055c 5c            	incw	x
2533  055d               L221:
2534  055d 02            	rlwa	x,a
2535  055e 7b05          	ld	a,(OFST+5,sp)
2536  0560 e708          	ld	(_pwm_brightness_buffer,x),a
2537                     ; 393 }
2540  0562 85            	popw	x
2541  0563 81            	ret
2585                     ; 395 void set_white(u8 index,u8 brightness)
2585                     ; 396 {
2586                     	switch	.text
2587  0564               _set_white:
2589  0564 89            	pushw	x
2590       00000000      OFST:	set	0
2593                     ; 397 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2595  0565 9e            	ld	a,xh
2596  0566 5f            	clrw	x
2597  0567 97            	ld	xl,a
2598  0568 7b02          	ld	a,(OFST+2,sp)
2599  056a e71b          	ld	(_pwm_brightness_buffer+19,x),a
2600                     ; 398 }
2603  056c 85            	popw	x
2604  056d 81            	ret
2639                     ; 401 void set_debug(u8 brightness)
2639                     ; 402 {
2640                     	switch	.text
2641  056e               _set_debug:
2645                     ; 403 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2647  056e b71a          	ld	_pwm_brightness_buffer+18,a
2648                     ; 404 }
2651  0570 81            	ret
2674                     ; 406 void set_matrix_high_z()
2674                     ; 407 {
2675                     	switch	.text
2676  0571               _set_matrix_high_z:
2680                     ; 408 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2682  0571 c6500d        	ld	a,20493
2683  0574 a407          	and	a,#7
2684  0576 c7500d        	ld	20493,a
2685                     ; 409 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2687  0579 72155012      	bres	20498,#2
2688                     ; 410 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2690  057d 72175003      	bres	20483,#3
2691                     ; 411 }
2694  0581 81            	ret
2728                     ; 413 u8 get_eeprom_byte(u16 eeprom_address)
2728                     ; 414 {
2729                     	switch	.text
2730  0582               _get_eeprom_byte:
2734                     ; 415 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2736  0582 d64000        	ld	a,(16384,x)
2739  0585 81            	ret
2876                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2877                     	xdef	_temp3_delete_me
2878                     	xdef	_temp_delete_me
2879                     	switch	.ubsct
2880  0000               _button_pressed_event:
2881  0000 00000000      	ds.b	4
2882                     	xdef	_button_pressed_event
2883  0004               _button_start_ms:
2884  0004 00000000      	ds.b	4
2885                     	xdef	_button_start_ms
2886                     	xdef	_pwm_state
2887                     	xdef	_pwm_visible_index
2888                     	xdef	_pwm_led_count
2889                     	xdef	_pwm_sleep
2890  0008               _pwm_brightness_buffer:
2891  0008 000000000000  	ds.b	31
2892                     	xdef	_pwm_brightness_buffer
2893  0027               _pwm_brightness_index:
2894  0027 000000000000  	ds.b	62
2895                     	xdef	_pwm_brightness_index
2896                     	xdef	_pwm_brightness
2897                     	xdef	_api_counter
2898                     	xref	_UART1_Cmd
2899                     	xref	_UART1_Init
2900                     	xref	_UART1_DeInit
2901                     	xref	_GPIO_ReadInputPin
2902                     	xref	_GPIO_Init
2903                     	xdef	_set_led
2904                     	xdef	_set_mat
2905                     	xdef	_get_eeprom_byte
2906                     	xdef	_get_random
2907                     	xdef	_is_button_down
2908                     	xdef	_clear_button_events
2909                     	xdef	_clear_button_event
2910                     	xdef	_get_button_event
2911                     	xdef	_update_buttons
2912                     	xdef	_is_developer_valid
2913                     	xdef	_set_hue_max
2914                     	xdef	_flush_leds
2915                     	xdef	_set_debug
2916                     	xdef	_set_white
2917                     	xdef	_set_rgb
2918                     	xdef	_set_matrix_high_z
2919                     	xdef	_millis
2920                     	xdef	_setup_main
2921                     	xdef	_is_application_valid
2922                     	xdef	_setup_serial
2923                     	xdef	_hello_world
2924                     	xref.b	c_lreg
2925                     	xref.b	c_x
2926                     	xref.b	c_y
2946                     	xref	c_xymov
2947                     	xref	c_lzmp
2948                     	xref	c_lsub
2949                     	xref	c_rtol
2950                     	xref	c_uitolx
2951                     	xref	c_lursh
2952                     	xref	c_itolx
2953                     	xref	c_imul
2954                     	xref	c_lrzmp
2955                     	xref	c_lmod
2956                     	xref	c_ltor
2957                     	xref	c_lgadc
2958                     	end
