   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _hw_revision:
  16  0000 01            	dc.b	1
  17                     	bsct
  18  0000               _api_counter:
  19  0000 00000000      	dc.l	0
  20                     	switch	.const
  21  0001               _PWM_MAX_PERIOD:
  22  0001 fa            	dc.b	250
  23                     	bsct
  24  0004               _pwm_sleep_remaining:
  25  0004 0000          	dc.w	0
  26  0006               _pwm_led_index:
  27  0006 00            	dc.b	0
  28  0007               _pwm_state:
  29  0007 00            	dc.b	0
 100                     	switch	.const
 101  0002               L21:
 102  0002 000003e8      	dc.l	1000
 103                     ; 79 void hello_world()
 103                     ; 80 {//basic program that blinks the debug LED ON/OFF
 104                     	scross	off
 105                     	switch	.text
 106  0000               _hello_world:
 108  0000 5205          	subw	sp,#5
 109       00000005      OFST:	set	5
 112                     ; 81 	bool is_high=0;
 114  0002 0f05          	clr	(OFST+0,sp)
 116                     ; 82 	long frame=0;
 118  0004 ae0000        	ldw	x,#0
 119  0007 1f03          	ldw	(OFST-2,sp),x
 120  0009 ae0000        	ldw	x,#0
 121  000c 1f01          	ldw	(OFST-4,sp),x
 123                     ; 83 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 125  000e 4b40          	push	#64
 126  0010 4b08          	push	#8
 127  0012 ae5000        	ldw	x,#20480
 128  0015 cd0000        	call	_GPIO_Init
 130  0018 85            	popw	x
 131  0019               L34:
 132                     ; 86 		GPIO_Init(GPIOA, GPIO_PIN_3, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
 134  0019 0d05          	tnz	(OFST+0,sp)
 135  001b 2704          	jreq	L6
 136  001d a6d0          	ld	a,#208
 137  001f 2002          	jra	L01
 138  0021               L6:
 139  0021 a6c0          	ld	a,#192
 140  0023               L01:
 141  0023 88            	push	a
 142  0024 4b08          	push	#8
 143  0026 ae5000        	ldw	x,#20480
 144  0029 cd0000        	call	_GPIO_Init
 146  002c 85            	popw	x
 147                     ; 87 		frame++;
 149  002d 96            	ldw	x,sp
 150  002e 1c0001        	addw	x,#OFST-4
 151  0031 a601          	ld	a,#1
 152  0033 cd0000        	call	c_lgadc
 155                     ; 88 		if(frame%1000==0)
 157  0036 96            	ldw	x,sp
 158  0037 1c0001        	addw	x,#OFST-4
 159  003a cd0000        	call	c_ltor
 161  003d ae0002        	ldw	x,#L21
 162  0040 cd0000        	call	c_lmod
 164  0043 cd0000        	call	c_lrzmp
 166  0046 26d1          	jrne	L34
 167                     ; 90 			is_high=!is_high;
 169  0048 0d05          	tnz	(OFST+0,sp)
 170  004a 2604          	jrne	L41
 171  004c a601          	ld	a,#1
 172  004e 2001          	jra	L61
 173  0050               L41:
 174  0050 4f            	clr	a
 175  0051               L61:
 176  0051 6b05          	ld	(OFST+0,sp),a
 178  0053 20c4          	jra	L34
 230                     ; 95 u16 get_random(u16 x)
 230                     ; 96 {
 231                     	switch	.text
 232  0055               _get_random:
 234  0055 5204          	subw	sp,#4
 235       00000004      OFST:	set	4
 238                     ; 97 	u16 a=1664525;
 240                     ; 98 	u16 c=1013904223;
 242                     ; 99 	return a * x + c;
 244  0057 90ae660d      	ldw	y,#26125
 245  005b cd0000        	call	c_imul
 247  005e 1cf35f        	addw	x,#62303
 250  0061 5b04          	addw	sp,#4
 251  0063 81            	ret
 300                     	switch	.const
 301  0006               L03:
 302  0006 000f4240      	dc.l	1000000
 303                     ; 102 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 303                     ; 103 {
 304                     	switch	.text
 305  0064               _setup_serial:
 307  0064 89            	pushw	x
 308       00000000      OFST:	set	0
 311                     ; 104 	if(is_enabled)
 313  0065 9e            	ld	a,xh
 314  0066 4d            	tnz	a
 315  0067 2747          	jreq	L121
 316                     ; 106 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 318  0069 4bf0          	push	#240
 319  006b 4b20          	push	#32
 320  006d ae500f        	ldw	x,#20495
 321  0070 cd0000        	call	_GPIO_Init
 323  0073 85            	popw	x
 324                     ; 107 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 326  0074 4b40          	push	#64
 327  0076 4b40          	push	#64
 328  0078 ae500f        	ldw	x,#20495
 329  007b cd0000        	call	_GPIO_Init
 331  007e 85            	popw	x
 332                     ; 108 		UART1_DeInit();
 334  007f cd0000        	call	_UART1_DeInit
 336                     ; 109 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 338  0082 4b0c          	push	#12
 339  0084 4b80          	push	#128
 340  0086 4b00          	push	#0
 341  0088 4b00          	push	#0
 342  008a 4b00          	push	#0
 343  008c 0d07          	tnz	(OFST+7,sp)
 344  008e 2708          	jreq	L42
 345  0090 ae2580        	ldw	x,#9600
 346  0093 cd0000        	call	c_itolx
 348  0096 2006          	jra	L62
 349  0098               L42:
 350  0098 ae0006        	ldw	x,#L03
 351  009b cd0000        	call	c_ltor
 353  009e               L62:
 354  009e be02          	ldw	x,c_lreg+2
 355  00a0 89            	pushw	x
 356  00a1 be00          	ldw	x,c_lreg
 357  00a3 89            	pushw	x
 358  00a4 cd0000        	call	_UART1_Init
 360  00a7 5b09          	addw	sp,#9
 361                     ; 110 		UART1_Cmd(ENABLE);
 363  00a9 a601          	ld	a,#1
 364  00ab cd0000        	call	_UART1_Cmd
 367  00ae 201d          	jra	L321
 368  00b0               L121:
 369                     ; 112 		UART1_Cmd(DISABLE);
 371  00b0 4f            	clr	a
 372  00b1 cd0000        	call	_UART1_Cmd
 374                     ; 113 		UART1_DeInit();
 376  00b4 cd0000        	call	_UART1_DeInit
 378                     ; 114 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 380  00b7 4b40          	push	#64
 381  00b9 4b20          	push	#32
 382  00bb ae500f        	ldw	x,#20495
 383  00be cd0000        	call	_GPIO_Init
 385  00c1 85            	popw	x
 386                     ; 115 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 388  00c2 4b40          	push	#64
 389  00c4 4b40          	push	#64
 390  00c6 ae500f        	ldw	x,#20495
 391  00c9 cd0000        	call	_GPIO_Init
 393  00cc 85            	popw	x
 394  00cd               L321:
 395                     ; 117 }
 398  00cd 85            	popw	x
 399  00ce 81            	ret
 426                     ; 120 bool is_application_valid()
 426                     ; 121 {
 427                     	switch	.text
 428  00cf               _is_application_valid:
 432                     ; 122 	return !is_button_down(2) && !get_button_event(0,1);
 434  00cf a602          	ld	a,#2
 435  00d1 cd0232        	call	_is_button_down
 437  00d4 4d            	tnz	a
 438  00d5 260d          	jrne	L43
 439  00d7 ae0001        	ldw	x,#1
 440  00da cd01e3        	call	_get_button_event
 442  00dd 4d            	tnz	a
 443  00de 2604          	jrne	L43
 444  00e0 a601          	ld	a,#1
 445  00e2 2001          	jra	L63
 446  00e4               L43:
 447  00e4 4f            	clr	a
 448  00e5               L63:
 451  00e5 81            	ret
 477                     ; 126 bool is_developer_valid()
 477                     ; 127 {
 478                     	switch	.text
 479  00e6               _is_developer_valid:
 483                     ; 128 	return is_button_down(2) && !get_button_event(0,1);
 485  00e6 a602          	ld	a,#2
 486  00e8 cd0232        	call	_is_button_down
 488  00eb 4d            	tnz	a
 489  00ec 270d          	jreq	L24
 490  00ee ae0001        	ldw	x,#1
 491  00f1 cd01e3        	call	_get_button_event
 493  00f4 4d            	tnz	a
 494  00f5 2604          	jrne	L24
 495  00f7 a601          	ld	a,#1
 496  00f9 2001          	jra	L44
 497  00fb               L24:
 498  00fb 4f            	clr	a
 499  00fc               L44:
 502  00fc 81            	ret
 527                     ; 132 bool is_sleep_valid()
 527                     ; 133 {
 528                     	switch	.text
 529  00fd               _is_sleep_valid:
 533                     ; 134 	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
 535  00fd 5f            	clrw	x
 536  00fe cd01e3        	call	_get_button_event
 538  0101 4d            	tnz	a
 539  0102 261f          	jrne	L05
 540  0104 ae0100        	ldw	x,#256
 541  0107 cd01e3        	call	_get_button_event
 543  010a 4d            	tnz	a
 544  010b 2616          	jrne	L05
 545  010d ae0001        	ldw	x,#1
 546  0110 cd01e3        	call	_get_button_event
 548  0113 4d            	tnz	a
 549  0114 260d          	jrne	L05
 550  0116 ae0101        	ldw	x,#257
 551  0119 cd01e3        	call	_get_button_event
 553  011c 4d            	tnz	a
 554  011d 2604          	jrne	L05
 555  011f a601          	ld	a,#1
 556  0121 2001          	jra	L25
 557  0123               L05:
 558  0123 4f            	clr	a
 559  0124               L25:
 562  0124 81            	ret
 588                     ; 137 void setup_main()
 588                     ; 138 {
 589                     	switch	.text
 590  0125               _setup_main:
 594                     ; 139 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 596  0125 c650c6        	ld	a,20678
 597  0128 a4e7          	and	a,#231
 598  012a c750c6        	ld	20678,a
 599                     ; 141 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 601  012d 4b40          	push	#64
 602  012f 4b02          	push	#2
 603  0131 ae500f        	ldw	x,#20495
 604  0134 cd0000        	call	_GPIO_Init
 606  0137 85            	popw	x
 607                     ; 144 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 609  0138 725f5311      	clr	21265
 610                     ; 145 	TIM2->PSCR= 6;// init divider register 16MHz/2^X
 612  013c 3506530e      	mov	21262,#6
 613                     ; 146 	TIM2->ARRH= 0;// init auto reload register
 615  0140 725f530f      	clr	21263
 616                     ; 147 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 618  0144 35fa5310      	mov	21264,#250
 619                     ; 148 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 621  0148 c65300        	ld	a,21248
 622  014b aa85          	or	a,#133
 623  014d c75300        	ld	21248,a
 624                     ; 149 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 626  0150 35035303      	mov	21251,#3
 627                     ; 150 	enableInterrupts();
 630  0154 9a            rim
 632                     ; 152 }
 636  0155 81            	ret
 660                     ; 154 u32 millis()
 660                     ; 155 {
 661                     	switch	.text
 662  0156               _millis:
 666                     ; 156 	return api_counter;
 668  0156 ae0000        	ldw	x,#_api_counter
 669  0159 cd0000        	call	c_ltor
 673  015c 81            	ret
 708                     ; 159 void set_millis(u32 new_time)
 708                     ; 160 {
 709                     	switch	.text
 710  015d               _set_millis:
 712       00000000      OFST:	set	0
 715                     ; 161 	api_counter=new_time;
 717  015d 1e05          	ldw	x,(OFST+5,sp)
 718  015f bf02          	ldw	_api_counter+2,x
 719  0161 1e03          	ldw	x,(OFST+3,sp)
 720  0163 bf00          	ldw	_api_counter,x
 721                     ; 162 }
 724  0165 81            	ret
 782                     ; 167 void update_buttons()
 782                     ; 168 {
 783                     	switch	.text
 784  0166               _update_buttons:
 786  0166 5208          	subw	sp,#8
 787       00000008      OFST:	set	8
 790                     ; 169 	bool is_any_down=0;
 792  0168 0f05          	clr	(OFST-3,sp)
 794                     ; 171 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 796  016a be06          	ldw	x,_button_start_ms+2
 797  016c cd0000        	call	c_uitolx
 799  016f 96            	ldw	x,sp
 800  0170 1c0001        	addw	x,#OFST-7
 801  0173 cd0000        	call	c_rtol
 804  0176 adde          	call	_millis
 806  0178 96            	ldw	x,sp
 807  0179 1c0001        	addw	x,#OFST-7
 808  017c cd0000        	call	c_lsub
 810  017f be02          	ldw	x,c_lreg+2
 811  0181 1f06          	ldw	(OFST-2,sp),x
 813                     ; 172 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 815  0183 0f08          	clr	(OFST+0,sp)
 817  0185               L142:
 818                     ; 174 		if(is_button_down(button_index))
 820  0185 7b08          	ld	a,(OFST+0,sp)
 821  0187 cd0232        	call	_is_button_down
 823  018a 4d            	tnz	a
 824  018b 271b          	jreq	L742
 825                     ; 176 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 827  018d ae0004        	ldw	x,#_button_start_ms
 828  0190 cd0000        	call	c_lzmp
 830  0193 2608          	jrne	L152
 833  0195 adbf          	call	_millis
 835  0197 ae0004        	ldw	x,#_button_start_ms
 836  019a cd0000        	call	c_rtol
 838  019d               L152:
 839                     ; 177 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 841  019d a6ff          	ld	a,#255
 842  019f cd03fb        	call	_set_debug
 844                     ; 178 			is_any_down=1;
 846  01a2 a601          	ld	a,#1
 847  01a4 6b05          	ld	(OFST-3,sp),a
 850  01a6 2022          	jra	L352
 851  01a8               L742:
 852                     ; 180 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 854  01a8 1e06          	ldw	x,(OFST-2,sp)
 855  01aa a30201        	cpw	x,#513
 856  01ad 250b          	jrult	L552
 859  01af 7b08          	ld	a,(OFST+0,sp)
 860  01b1 5f            	clrw	x
 861  01b2 97            	ld	xl,a
 862  01b3 58            	sllw	x
 863  01b4 a601          	ld	a,#1
 864  01b6 e701          	ld	(_button_pressed_event+1,x),a
 866  01b8 2010          	jra	L352
 867  01ba               L552:
 868                     ; 181 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 870  01ba 1e06          	ldw	x,(OFST-2,sp)
 871  01bc a30033        	cpw	x,#51
 872  01bf 2509          	jrult	L352
 875  01c1 7b08          	ld	a,(OFST+0,sp)
 876  01c3 5f            	clrw	x
 877  01c4 97            	ld	xl,a
 878  01c5 58            	sllw	x
 879  01c6 a601          	ld	a,#1
 880  01c8 e700          	ld	(_button_pressed_event,x),a
 881  01ca               L352:
 882                     ; 172 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 884  01ca 0c08          	inc	(OFST+0,sp)
 888  01cc 7b08          	ld	a,(OFST+0,sp)
 889  01ce a102          	cp	a,#2
 890  01d0 25b3          	jrult	L142
 891                     ; 185 	if(!is_any_down) button_start_ms=0;
 893  01d2 0d05          	tnz	(OFST-3,sp)
 894  01d4 260a          	jrne	L362
 897  01d6 ae0000        	ldw	x,#0
 898  01d9 bf06          	ldw	_button_start_ms+2,x
 899  01db ae0000        	ldw	x,#0
 900  01de bf04          	ldw	_button_start_ms,x
 901  01e0               L362:
 902                     ; 186 }
 905  01e0 5b08          	addw	sp,#8
 906  01e2 81            	ret
 952                     ; 189 bool get_button_event(u8 button_index,bool is_long)
 952                     ; 190 { return button_pressed_event[button_index][is_long]; }
 953                     	switch	.text
 954  01e3               _get_button_event:
 956  01e3 89            	pushw	x
 957       00000000      OFST:	set	0
 962  01e4 9e            	ld	a,xh
 963  01e5 5f            	clrw	x
 964  01e6 97            	ld	xl,a
 965  01e7 58            	sllw	x
 966  01e8 01            	rrwa	x,a
 967  01e9 1b02          	add	a,(OFST+2,sp)
 968  01eb 2401          	jrnc	L66
 969  01ed 5c            	incw	x
 970  01ee               L66:
 971  01ee 02            	rlwa	x,a
 972  01ef e600          	ld	a,(_button_pressed_event,x)
 975  01f1 85            	popw	x
 976  01f2 81            	ret
1032                     ; 193 bool clear_button_event(u8 button_index,bool is_long)
1032                     ; 194 {
1033                     	switch	.text
1034  01f3               _clear_button_event:
1036  01f3 89            	pushw	x
1037  01f4 88            	push	a
1038       00000001      OFST:	set	1
1041                     ; 195 	bool out=button_pressed_event[button_index][is_long];
1043  01f5 9e            	ld	a,xh
1044  01f6 5f            	clrw	x
1045  01f7 97            	ld	xl,a
1046  01f8 58            	sllw	x
1047  01f9 01            	rrwa	x,a
1048  01fa 1b03          	add	a,(OFST+2,sp)
1049  01fc 2401          	jrnc	L27
1050  01fe 5c            	incw	x
1051  01ff               L27:
1052  01ff 02            	rlwa	x,a
1053  0200 e600          	ld	a,(_button_pressed_event,x)
1054  0202 6b01          	ld	(OFST+0,sp),a
1056                     ; 196 	button_pressed_event[button_index][is_long]=0;
1058  0204 7b02          	ld	a,(OFST+1,sp)
1059  0206 5f            	clrw	x
1060  0207 97            	ld	xl,a
1061  0208 58            	sllw	x
1062  0209 01            	rrwa	x,a
1063  020a 1b03          	add	a,(OFST+2,sp)
1064  020c 2401          	jrnc	L47
1065  020e 5c            	incw	x
1066  020f               L47:
1067  020f 02            	rlwa	x,a
1068  0210 6f00          	clr	(_button_pressed_event,x)
1069                     ; 197 	return out;
1071  0212 7b01          	ld	a,(OFST+0,sp)
1074  0214 5b03          	addw	sp,#3
1075  0216 81            	ret
1111                     ; 200 void clear_button_events()
1111                     ; 201 {
1112                     	switch	.text
1113  0217               _clear_button_events:
1115  0217 88            	push	a
1116       00000001      OFST:	set	1
1119                     ; 203 	for(iter=0;iter<BUTTON_COUNT;iter++)
1121  0218 0f01          	clr	(OFST+0,sp)
1123  021a               L353:
1124                     ; 205 		clear_button_event(iter,0);
1126  021a 7b01          	ld	a,(OFST+0,sp)
1127  021c 5f            	clrw	x
1128  021d 95            	ld	xh,a
1129  021e add3          	call	_clear_button_event
1131                     ; 206 		clear_button_event(iter,1);
1133  0220 7b01          	ld	a,(OFST+0,sp)
1134  0222 ae0001        	ldw	x,#1
1135  0225 95            	ld	xh,a
1136  0226 adcb          	call	_clear_button_event
1138                     ; 203 	for(iter=0;iter<BUTTON_COUNT;iter++)
1140  0228 0c01          	inc	(OFST+0,sp)
1144  022a 7b01          	ld	a,(OFST+0,sp)
1145  022c a102          	cp	a,#2
1146  022e 25ea          	jrult	L353
1147                     ; 208 }
1150  0230 84            	pop	a
1151  0231 81            	ret
1187                     ; 211 bool is_button_down(u8 index)
1187                     ; 212 {
1188                     	switch	.text
1189  0232               _is_button_down:
1193                     ; 213 	switch(index)
1196                     ; 217 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1198  0232 4d            	tnz	a
1199  0233 2708          	jreq	L163
1200  0235 4a            	dec	a
1201  0236 2718          	jreq	L363
1202  0238 4a            	dec	a
1203  0239 2728          	jreq	L563
1204  023b 2039          	jra	L704
1205  023d               L163:
1206                     ; 215 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1208  023d 4b20          	push	#32
1209  023f ae500f        	ldw	x,#20495
1210  0242 cd0000        	call	_GPIO_ReadInputPin
1212  0245 5b01          	addw	sp,#1
1213  0247 4d            	tnz	a
1214  0248 2604          	jrne	L201
1215  024a a601          	ld	a,#1
1216  024c 2001          	jra	L401
1217  024e               L201:
1218  024e 4f            	clr	a
1219  024f               L401:
1222  024f 81            	ret
1223  0250               L363:
1224                     ; 216 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1227  0250 4b40          	push	#64
1228  0252 ae500f        	ldw	x,#20495
1229  0255 cd0000        	call	_GPIO_ReadInputPin
1231  0258 5b01          	addw	sp,#1
1232  025a 4d            	tnz	a
1233  025b 2604          	jrne	L601
1234  025d a601          	ld	a,#1
1235  025f 2001          	jra	L011
1236  0261               L601:
1237  0261 4f            	clr	a
1238  0262               L011:
1241  0262 81            	ret
1242  0263               L563:
1243                     ; 217 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1246  0263 4b02          	push	#2
1247  0265 ae500f        	ldw	x,#20495
1248  0268 cd0000        	call	_GPIO_ReadInputPin
1250  026b 5b01          	addw	sp,#1
1251  026d 4d            	tnz	a
1252  026e 2604          	jrne	L211
1253  0270 a601          	ld	a,#1
1254  0272 2001          	jra	L411
1255  0274               L211:
1256  0274 4f            	clr	a
1257  0275               L411:
1260  0275 81            	ret
1261  0276               L704:
1262                     ; 219 	return 0;
1264  0276 4f            	clr	a
1267  0277 81            	ret
1292                     ; 223 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1294                     	switch	.text
1295  0278               f_TIM2_UPD_OVF_IRQHandler:
1299                     ; 224 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1301  0278 72115304      	bres	21252,#0
1302                     ; 225 	api_counter++;
1304  027c ae0000        	ldw	x,#_api_counter
1305  027f a601          	ld	a,#1
1306  0281 cd0000        	call	c_lgadc
1308                     ; 229 }
1311  0284 80            	iret
1334                     ; 232 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
1335                     	switch	.text
1336  0285               f_TIM2_CapComp_IRQ_Handler:
1340                     ; 233 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
1342  0285 72135304      	bres	21252,#1
1343                     ; 234 	TIM2->CCR1L = 50;//set wakeup alarm relative to current time
1345  0289 35325312      	mov	21266,#50
1346                     ; 235 }
1349  028d 80            	iret
1414                     ; 237 void flush_leds(u8 led_count)
1414                     ; 238 {
1416                     	switch	.text
1417  028e               _flush_leds:
1419  028e 88            	push	a
1420  028f 5203          	subw	sp,#3
1421       00000003      OFST:	set	3
1424                     ; 239 	u8 led_read_index=0,led_write_index=0;
1428  0291 0f02          	clr	(OFST-1,sp)
1431  0293               L764:
1432                     ; 241 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1434  0293 b607          	ld	a,_pwm_state
1435  0295 a502          	bcp	a,#2
1436  0297 26fa          	jrne	L764
1437                     ; 242 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1439  0299 b607          	ld	a,_pwm_state
1440  029b a401          	and	a,#1
1441  029d a801          	xor	a,#1
1442  029f 6b01          	ld	(OFST-2,sp),a
1444                     ; 243 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1446  02a1 7b04          	ld	a,(OFST+1,sp)
1447  02a3 5f            	clrw	x
1448  02a4 97            	ld	xl,a
1449  02a5 4f            	clr	a
1450  02a6 02            	rlwa	x,a
1451  02a7 7b01          	ld	a,(OFST-2,sp)
1452  02a9 905f          	clrw	y
1453  02ab 9097          	ld	yl,a
1454  02ad 9058          	sllw	y
1455  02af 90ef0a        	ldw	(_pwm_sleep,y),x
1456                     ; 245 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1458  02b2 0f03          	clr	(OFST+0,sp)
1461  02b4 205d          	jra	L774
1462  02b6               L374:
1463                     ; 247 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1465  02b6 7b03          	ld	a,(OFST+0,sp)
1466  02b8 5f            	clrw	x
1467  02b9 97            	ld	xl,a
1468  02ba e6ba          	ld	a,(_pwm_brightness_buffer,x)
1469  02bc a105          	cp	a,#5
1470  02be 254b          	jrult	L305
1471                     ; 249 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1473  02c0 7b02          	ld	a,(OFST-1,sp)
1474  02c2 97            	ld	xl,a
1475  02c3 a604          	ld	a,#4
1476  02c5 42            	mul	x,a
1477  02c6 01            	rrwa	x,a
1478  02c7 1b01          	add	a,(OFST-2,sp)
1479  02c9 2401          	jrnc	L421
1480  02cb 5c            	incw	x
1481  02cc               L421:
1482  02cc 02            	rlwa	x,a
1483  02cd 7b03          	ld	a,(OFST+0,sp)
1484  02cf e70e          	ld	(_pwm_brightness,x),a
1485                     ; 250 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1487  02d1 7b02          	ld	a,(OFST-1,sp)
1488  02d3 97            	ld	xl,a
1489  02d4 a604          	ld	a,#4
1490  02d6 42            	mul	x,a
1491  02d7 01            	rrwa	x,a
1492  02d8 1b01          	add	a,(OFST-2,sp)
1493  02da 2401          	jrnc	L621
1494  02dc 5c            	incw	x
1495  02dd               L621:
1496  02dd 02            	rlwa	x,a
1497  02de 7b03          	ld	a,(OFST+0,sp)
1498  02e0 905f          	clrw	y
1499  02e2 9097          	ld	yl,a
1500  02e4 90e6ba        	ld	a,(_pwm_brightness_buffer,y)
1501  02e7 e710          	ld	(_pwm_brightness+2,x),a
1502                     ; 251 			led_write_index++;
1504  02e9 0c02          	inc	(OFST-1,sp)
1506                     ; 252 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1508  02eb 7b01          	ld	a,(OFST-2,sp)
1509  02ed 5f            	clrw	x
1510  02ee 97            	ld	xl,a
1511  02ef 58            	sllw	x
1512  02f0 7b03          	ld	a,(OFST+0,sp)
1513  02f2 905f          	clrw	y
1514  02f4 9097          	ld	yl,a
1515  02f6 90e6ba        	ld	a,(_pwm_brightness_buffer,y)
1516  02f9 905f          	clrw	y
1517  02fb 9097          	ld	yl,a
1518  02fd 9001          	rrwa	y,a
1519  02ff e00b          	sub	a,(_pwm_sleep+1,x)
1520  0301 9001          	rrwa	y,a
1521  0303 e20a          	sbc	a,(_pwm_sleep,x)
1522  0305 9001          	rrwa	y,a
1523  0307 9050          	negw	y
1524  0309 ef0a          	ldw	(_pwm_sleep,x),y
1525  030b               L305:
1526                     ; 254 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1528  030b 7b03          	ld	a,(OFST+0,sp)
1529  030d 5f            	clrw	x
1530  030e 97            	ld	xl,a
1531  030f 6fba          	clr	(_pwm_brightness_buffer,x)
1532                     ; 245 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1534  0311 0c03          	inc	(OFST+0,sp)
1536  0313               L774:
1539  0313 7b03          	ld	a,(OFST+0,sp)
1540  0315 a12b          	cp	a,#43
1541  0317 2406          	jruge	L505
1543  0319 7b02          	ld	a,(OFST-1,sp)
1544  031b 1104          	cp	a,(OFST+1,sp)
1545  031d 2597          	jrult	L374
1546  031f               L505:
1547                     ; 256 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1549  031f 7b01          	ld	a,(OFST-2,sp)
1550  0321 5f            	clrw	x
1551  0322 97            	ld	xl,a
1552  0323 7b02          	ld	a,(OFST-1,sp)
1553  0325 e708          	ld	(_pwm_led_count,x),a
1554                     ; 259 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1556  0327 72120007      	bset	_pwm_state,#1
1557                     ; 260 }
1560  032b 5b04          	addw	sp,#4
1561  032d 81            	ret
1650                     ; 262 void set_hue(u8 index,u16 color,u8 brightness)
1650                     ; 263 {
1651                     	switch	.text
1652  032e               _set_hue:
1654  032e 88            	push	a
1655  032f 5205          	subw	sp,#5
1656       00000005      OFST:	set	5
1659                     ; 264 	u8 red=0,green=0,blue=0;
1661  0331 0f01          	clr	(OFST-4,sp)
1665  0333 0f02          	clr	(OFST-3,sp)
1669  0335 0f03          	clr	(OFST-2,sp)
1671                     ; 265 	u16 residual=color%(0x2AAB);
1673  0337 1e09          	ldw	x,(OFST+4,sp)
1674  0339 90ae2aab      	ldw	y,#10923
1675  033d 65            	divw	x,y
1676  033e 51            	exgw	x,y
1677  033f 1f04          	ldw	(OFST-1,sp),x
1679                     ; 266 	residual=(u8)(residual*brightness/0x2AAB);
1681  0341 1e04          	ldw	x,(OFST-1,sp)
1682  0343 7b0b          	ld	a,(OFST+6,sp)
1683  0345 cd0000        	call	c_bmulx
1685  0348 90ae2aab      	ldw	y,#10923
1686  034c 65            	divw	x,y
1687  034d 9f            	ld	a,xl
1688  034e 5f            	clrw	x
1689  034f 97            	ld	xl,a
1690  0350 1f04          	ldw	(OFST-1,sp),x
1692                     ; 267 	switch(color/(0x2AAB))//0xFFFF/6
1694  0352 1e09          	ldw	x,(OFST+4,sp)
1695  0354 90ae2aab      	ldw	y,#10923
1696  0358 65            	divw	x,y
1698                     ; 298 			break;
1699  0359 5d            	tnzw	x
1700  035a 2711          	jreq	L705
1701  035c 5a            	decw	x
1702  035d 271a          	jreq	L115
1703  035f 5a            	decw	x
1704  0360 2725          	jreq	L315
1705  0362 5a            	decw	x
1706  0363 272e          	jreq	L515
1707  0365 5a            	decw	x
1708  0366 2739          	jreq	L715
1709  0368 5a            	decw	x
1710  0369 2742          	jreq	L125
1711  036b 204c          	jra	L575
1712  036d               L705:
1713                     ; 270 			red=brightness;
1715  036d 7b0b          	ld	a,(OFST+6,sp)
1716  036f 6b01          	ld	(OFST-4,sp),a
1718                     ; 271 			green=residual;
1720  0371 7b05          	ld	a,(OFST+0,sp)
1721  0373 6b02          	ld	(OFST-3,sp),a
1723                     ; 272 			blue=0;
1725  0375 0f03          	clr	(OFST-2,sp)
1727                     ; 273 			break;
1729  0377 2040          	jra	L575
1730  0379               L115:
1731                     ; 275 			red=brightness-residual;
1733  0379 7b0b          	ld	a,(OFST+6,sp)
1734  037b 1005          	sub	a,(OFST+0,sp)
1735  037d 6b01          	ld	(OFST-4,sp),a
1737                     ; 276 			green=brightness;
1739  037f 7b0b          	ld	a,(OFST+6,sp)
1740  0381 6b02          	ld	(OFST-3,sp),a
1742                     ; 277 			blue=0;
1744  0383 0f03          	clr	(OFST-2,sp)
1746                     ; 278 			break;
1748  0385 2032          	jra	L575
1749  0387               L315:
1750                     ; 280 			red=0;
1752  0387 0f01          	clr	(OFST-4,sp)
1754                     ; 281 			green=brightness;
1756  0389 7b0b          	ld	a,(OFST+6,sp)
1757  038b 6b02          	ld	(OFST-3,sp),a
1759                     ; 282 			blue=residual;
1761  038d 7b05          	ld	a,(OFST+0,sp)
1762  038f 6b03          	ld	(OFST-2,sp),a
1764                     ; 283 			break;
1766  0391 2026          	jra	L575
1767  0393               L515:
1768                     ; 285 			red=0;
1770  0393 0f01          	clr	(OFST-4,sp)
1772                     ; 286 			green=brightness-residual;
1774  0395 7b0b          	ld	a,(OFST+6,sp)
1775  0397 1005          	sub	a,(OFST+0,sp)
1776  0399 6b02          	ld	(OFST-3,sp),a
1778                     ; 287 			blue=brightness;
1780  039b 7b0b          	ld	a,(OFST+6,sp)
1781  039d 6b03          	ld	(OFST-2,sp),a
1783                     ; 288 			break;
1785  039f 2018          	jra	L575
1786  03a1               L715:
1787                     ; 290 			red=residual;
1789  03a1 7b05          	ld	a,(OFST+0,sp)
1790  03a3 6b01          	ld	(OFST-4,sp),a
1792                     ; 291 			green=0;
1794  03a5 0f02          	clr	(OFST-3,sp)
1796                     ; 292 			blue=brightness;
1798  03a7 7b0b          	ld	a,(OFST+6,sp)
1799  03a9 6b03          	ld	(OFST-2,sp),a
1801                     ; 293 			break;
1803  03ab 200c          	jra	L575
1804  03ad               L125:
1805                     ; 295 			red=brightness;
1807  03ad 7b0b          	ld	a,(OFST+6,sp)
1808  03af 6b01          	ld	(OFST-4,sp),a
1810                     ; 296 			green=0;
1812  03b1 0f02          	clr	(OFST-3,sp)
1814                     ; 297 			blue=brightness-residual;
1816  03b3 7b0b          	ld	a,(OFST+6,sp)
1817  03b5 1005          	sub	a,(OFST+0,sp)
1818  03b7 6b03          	ld	(OFST-2,sp),a
1820                     ; 298 			break;
1822  03b9               L575:
1823                     ; 301 	set_rgb(index,0,red);
1825  03b9 7b01          	ld	a,(OFST-4,sp)
1826  03bb 88            	push	a
1827  03bc 7b07          	ld	a,(OFST+2,sp)
1828  03be 5f            	clrw	x
1829  03bf 95            	ld	xh,a
1830  03c0 ad1c          	call	_set_rgb
1832  03c2 84            	pop	a
1833                     ; 302 	set_rgb(index,1,green);
1835  03c3 7b02          	ld	a,(OFST-3,sp)
1836  03c5 88            	push	a
1837  03c6 7b07          	ld	a,(OFST+2,sp)
1838  03c8 ae0001        	ldw	x,#1
1839  03cb 95            	ld	xh,a
1840  03cc ad10          	call	_set_rgb
1842  03ce 84            	pop	a
1843                     ; 303 	set_rgb(index,2,blue);
1845  03cf 7b03          	ld	a,(OFST-2,sp)
1846  03d1 88            	push	a
1847  03d2 7b07          	ld	a,(OFST+2,sp)
1848  03d4 ae0002        	ldw	x,#2
1849  03d7 95            	ld	xh,a
1850  03d8 ad04          	call	_set_rgb
1852  03da 84            	pop	a
1853                     ; 304 }
1856  03db 5b06          	addw	sp,#6
1857  03dd 81            	ret
1910                     ; 306 void set_rgb(u8 index,u8 color,u8 brightness)
1910                     ; 307 {
1911                     	switch	.text
1912  03de               _set_rgb:
1914  03de 89            	pushw	x
1915       00000000      OFST:	set	0
1918                     ; 308 	pwm_brightness_buffer[index*3+color]=brightness;
1920  03df 9e            	ld	a,xh
1921  03e0 97            	ld	xl,a
1922  03e1 a603          	ld	a,#3
1923  03e3 42            	mul	x,a
1924  03e4 01            	rrwa	x,a
1925  03e5 1b02          	add	a,(OFST+2,sp)
1926  03e7 2401          	jrnc	L631
1927  03e9 5c            	incw	x
1928  03ea               L631:
1929  03ea 02            	rlwa	x,a
1930  03eb 7b05          	ld	a,(OFST+5,sp)
1931  03ed e7ba          	ld	(_pwm_brightness_buffer,x),a
1932                     ; 309 }
1935  03ef 85            	popw	x
1936  03f0 81            	ret
1980                     ; 311 void set_white(u8 index,u8 brightness)
1980                     ; 312 {
1981                     	switch	.text
1982  03f1               _set_white:
1984  03f1 89            	pushw	x
1985       00000000      OFST:	set	0
1988                     ; 313 	pwm_brightness_buffer[31+index]=brightness;
1990  03f2 9e            	ld	a,xh
1991  03f3 5f            	clrw	x
1992  03f4 97            	ld	xl,a
1993  03f5 7b02          	ld	a,(OFST+2,sp)
1994  03f7 e7d9          	ld	(_pwm_brightness_buffer+31,x),a
1995                     ; 314 }
1998  03f9 85            	popw	x
1999  03fa 81            	ret
2034                     ; 317 void set_debug(u8 brightness)
2034                     ; 318 {
2035                     	switch	.text
2036  03fb               _set_debug:
2040                     ; 319 	pwm_brightness_buffer[30]=brightness;
2042  03fb b7d8          	ld	_pwm_brightness_buffer+30,a
2043                     ; 320 }
2046  03fd 81            	ret
2071                     ; 322 void set_matrix_high_z()
2071                     ; 323 {
2072                     	switch	.text
2073  03fe               _set_matrix_high_z:
2077                     ; 326 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2079  03fe 4b00          	push	#0
2080  0400 4bf8          	push	#248
2081  0402 ae500a        	ldw	x,#20490
2082  0405 cd0000        	call	_GPIO_Init
2084  0408 85            	popw	x
2085                     ; 327 		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
2087  0409 4b00          	push	#0
2088  040b 4b0c          	push	#12
2089  040d ae500f        	ldw	x,#20495
2090  0410 cd0000        	call	_GPIO_Init
2092  0413 85            	popw	x
2093                     ; 328 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
2095  0414 4b00          	push	#0
2096  0416 4b08          	push	#8
2097  0418 ae5000        	ldw	x,#20480
2098  041b cd0000        	call	_GPIO_Init
2100  041e 85            	popw	x
2101                     ; 332 }
2104  041f 81            	ret
2107                     	switch	.const
2108  000a               L576_led_lookup:
2109  000a 00            	dc.b	0
2110  000b 01            	dc.b	1
2111  000c 00            	dc.b	0
2112  000d 02            	dc.b	2
2113  000e 01            	dc.b	1
2114  000f 02            	dc.b	2
2115  0010 01            	dc.b	1
2116  0011 00            	dc.b	0
2117  0012 02            	dc.b	2
2118  0013 00            	dc.b	0
2119  0014 02            	dc.b	2
2120  0015 01            	dc.b	1
2121  0016 05            	dc.b	5
2122  0017 00            	dc.b	0
2123  0018 05            	dc.b	5
2124  0019 01            	dc.b	1
2125  001a 05            	dc.b	5
2126  001b 02            	dc.b	2
2127  001c 06            	dc.b	6
2128  001d 00            	dc.b	0
2129  001e 06            	dc.b	6
2130  001f 01            	dc.b	1
2131  0020 06            	dc.b	6
2132  0021 02            	dc.b	2
2133  0022 06            	dc.b	6
2134  0023 05            	dc.b	5
2135  0024 06            	dc.b	6
2136  0025 04            	dc.b	4
2137  0026 05            	dc.b	5
2138  0027 04            	dc.b	4
2139  0028 04            	dc.b	4
2140  0029 03            	dc.b	3
2141  002a 05            	dc.b	5
2142  002b 03            	dc.b	3
2143  002c 06            	dc.b	6
2144  002d 03            	dc.b	3
2145  002e 03            	dc.b	3
2146  002f 04            	dc.b	4
2147  0030 03            	dc.b	3
2148  0031 05            	dc.b	5
2149  0032 03            	dc.b	3
2150  0033 06            	dc.b	6
2151  0034 00            	dc.b	0
2152  0035 05            	dc.b	5
2153  0036 00            	dc.b	0
2154  0037 06            	dc.b	6
2155  0038 01            	dc.b	1
2156  0039 06            	dc.b	6
2157  003a 00            	dc.b	0
2158  003b 04            	dc.b	4
2159  003c 01            	dc.b	1
2160  003d 04            	dc.b	4
2161  003e 02            	dc.b	2
2162  003f 04            	dc.b	4
2163  0040 00            	dc.b	0
2164  0041 03            	dc.b	3
2165  0042 01            	dc.b	1
2166  0043 03            	dc.b	3
2167  0044 02            	dc.b	2
2168  0045 03            	dc.b	3
2169  0046 07            	dc.b	7
2170  0047 07            	dc.b	7
2171  0048 03            	dc.b	3
2172  0049 00            	dc.b	0
2173  004a 03            	dc.b	3
2174  004b 01            	dc.b	1
2175  004c 03            	dc.b	3
2176  004d 02            	dc.b	2
2177  004e 04            	dc.b	4
2178  004f 00            	dc.b	0
2179  0050 01            	dc.b	1
2180  0051 05            	dc.b	5
2181  0052 02            	dc.b	2
2182  0053 05            	dc.b	5
2183  0054 04            	dc.b	4
2184  0055 01            	dc.b	1
2185  0056 04            	dc.b	4
2186  0057 02            	dc.b	2
2187  0058 02            	dc.b	2
2188  0059 06            	dc.b	6
2189  005a 04            	dc.b	4
2190  005b 06            	dc.b	6
2191  005c 04            	dc.b	4
2192  005d 05            	dc.b	5
2193  005e 05            	dc.b	5
2194  005f 06            	dc.b	6
2405                     ; 336 void set_led(u8 led_index)
2405                     ; 337 {
2406                     	switch	.text
2407  0420               _set_led:
2409  0420 88            	push	a
2410  0421 525c          	subw	sp,#92
2411       0000005c      OFST:	set	92
2414                     ; 341 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2414                     ; 342 		{0,1},{0,2},{1,2},//LED7  RGB
2414                     ; 343 		{1,0},{2,0},{2,1},//LED3  RGB
2414                     ; 344 		{5,0},{5,1},{5,2},//LED1  RGB
2414                     ; 345 		{6,0},{6,1},{6,2},//LED20 RGB
2414                     ; 346 		{6,5},{6,4},{5,4},//LED22 RGB
2414                     ; 347 		{4,3},{5,3},{6,3},//LED23 RGB
2414                     ; 348 		{3,4},{3,5},{3,6},//LED21 RGB
2414                     ; 349 		{0,5},{0,6},{1,6},//LED19 RGB
2414                     ; 350 		{0,4},{1,4},{2,4},//LED18 RGB
2414                     ; 351 		{0,3},{1,3},{2,3},//LED2  RGB
2414                     ; 352 		{7,7},//debug; GND is tied low, no charlieplexing involved
2414                     ; 353 		{3,0},//LED6
2414                     ; 354 		{3,1},//LED4
2414                     ; 355 		{3,2},//LED5
2414                     ; 356 		{4,0},//LED14
2414                     ; 357 		{1,5},//LED8
2414                     ; 358 		{2,5},//LED9
2414                     ; 359 		{4,1},//LED10
2414                     ; 360 		{4,2},//LED16
2414                     ; 361 		{2,6},//LED17
2414                     ; 362 		{4,6},//LED12
2414                     ; 363 		{4,5},//LED13
2414                     ; 364 		{5,6} //LED11
2414                     ; 365 	};
2416  0423 96            	ldw	x,sp
2417  0424 1c0006        	addw	x,#OFST-86
2418  0427 90ae000a      	ldw	y,#L576_led_lookup
2419  042b a656          	ld	a,#86
2420  042d cd0000        	call	c_xymov
2422                     ; 366 	bool is_high=0;
2424  0430 0f5c          	clr	(OFST+0,sp)
2426  0432               L3401:
2427                     ; 370 		switch(led_lookup[led_index][!is_high])
2429  0432 0d5c          	tnz	(OFST+0,sp)
2430  0434 2605          	jrne	L051
2431  0436 ae0001        	ldw	x,#1
2432  0439 2001          	jra	L251
2433  043b               L051:
2434  043b 5f            	clrw	x
2435  043c               L251:
2436  043c 9096          	ldw	y,sp
2437  043e 72a90006      	addw	y,#OFST-86
2438  0442 1701          	ldw	(OFST-91,sp),y
2440  0444 7b5d          	ld	a,(OFST+1,sp)
2441  0446 905f          	clrw	y
2442  0448 9097          	ld	yl,a
2443  044a 9058          	sllw	y
2444  044c 72f901        	addw	y,(OFST-91,sp)
2445  044f bf00          	ldw	c_y,x
2446  0451 51            	exgw	x,y
2447  0452 92d600        	ld	a,([c_y.w],x)
2448  0455 51            	exgw	x,y
2450                     ; 406 			}break;
2451  0456 4d            	tnz	a
2452  0457 2717          	jreq	L776
2453  0459 4a            	dec	a
2454  045a 271f          	jreq	L107
2455  045c 4a            	dec	a
2456  045d 2727          	jreq	L307
2457  045f 4a            	dec	a
2458  0460 272f          	jreq	L507
2459  0462 4a            	dec	a
2460  0463 2737          	jreq	L707
2461  0465 4a            	dec	a
2462  0466 273f          	jreq	L117
2463  0468 4a            	dec	a
2464  0469 2747          	jreq	L317
2465  046b 4a            	dec	a
2466  046c 274f          	jreq	L517
2467  046e 2056          	jra	L3501
2468  0470               L776:
2469                     ; 373 				GPIOx=GPIOD;
2471  0470 ae500f        	ldw	x,#20495
2472  0473 1f03          	ldw	(OFST-89,sp),x
2474                     ; 374 				PortPin=GPIO_PIN_3;
2476  0475 a608          	ld	a,#8
2477  0477 6b05          	ld	(OFST-87,sp),a
2479                     ; 375 			}break;
2481  0479 204b          	jra	L3501
2482  047b               L107:
2483                     ; 377 				GPIOx=GPIOD;
2485  047b ae500f        	ldw	x,#20495
2486  047e 1f03          	ldw	(OFST-89,sp),x
2488                     ; 378 				PortPin=GPIO_PIN_2;
2490  0480 a604          	ld	a,#4
2491  0482 6b05          	ld	(OFST-87,sp),a
2493                     ; 379 			}break;
2495  0484 2040          	jra	L3501
2496  0486               L307:
2497                     ; 381 				GPIOx=GPIOC;
2499  0486 ae500a        	ldw	x,#20490
2500  0489 1f03          	ldw	(OFST-89,sp),x
2502                     ; 382 				PortPin=GPIO_PIN_7;
2504  048b a680          	ld	a,#128
2505  048d 6b05          	ld	(OFST-87,sp),a
2507                     ; 383 			}break;
2509  048f 2035          	jra	L3501
2510  0491               L507:
2511                     ; 385 				GPIOx=GPIOC;
2513  0491 ae500a        	ldw	x,#20490
2514  0494 1f03          	ldw	(OFST-89,sp),x
2516                     ; 386 				PortPin=GPIO_PIN_6;
2518  0496 a640          	ld	a,#64
2519  0498 6b05          	ld	(OFST-87,sp),a
2521                     ; 387 			}break;
2523  049a 202a          	jra	L3501
2524  049c               L707:
2525                     ; 389 				GPIOx=GPIOC;
2527  049c ae500a        	ldw	x,#20490
2528  049f 1f03          	ldw	(OFST-89,sp),x
2530                     ; 390 				PortPin=GPIO_PIN_5;
2532  04a1 a620          	ld	a,#32
2533  04a3 6b05          	ld	(OFST-87,sp),a
2535                     ; 391 			}break;
2537  04a5 201f          	jra	L3501
2538  04a7               L117:
2539                     ; 393 				GPIOx=GPIOC;
2541  04a7 ae500a        	ldw	x,#20490
2542  04aa 1f03          	ldw	(OFST-89,sp),x
2544                     ; 394 				PortPin=GPIO_PIN_4;
2546  04ac a610          	ld	a,#16
2547  04ae 6b05          	ld	(OFST-87,sp),a
2549                     ; 395 			}break;
2551  04b0 2014          	jra	L3501
2552  04b2               L317:
2553                     ; 397 				GPIOx=GPIOC;
2555  04b2 ae500a        	ldw	x,#20490
2556  04b5 1f03          	ldw	(OFST-89,sp),x
2558                     ; 398 				PortPin=GPIO_PIN_3;
2560  04b7 a608          	ld	a,#8
2561  04b9 6b05          	ld	(OFST-87,sp),a
2563                     ; 399 			}break;
2565  04bb 2009          	jra	L3501
2566  04bd               L517:
2567                     ; 401 				GPIOx=GPIOA;
2569  04bd ae5000        	ldw	x,#20480
2570  04c0 1f03          	ldw	(OFST-89,sp),x
2572                     ; 402 				PortPin=GPIO_PIN_3;
2574  04c2 a608          	ld	a,#8
2575  04c4 6b05          	ld	(OFST-87,sp),a
2577                     ; 403 			}break;
2579  04c6               L3501:
2580                     ; 408 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
2582  04c6 0d5c          	tnz	(OFST+0,sp)
2583  04c8 2704          	jreq	L451
2584  04ca a6d0          	ld	a,#208
2585  04cc 2002          	jra	L651
2586  04ce               L451:
2587  04ce a6c0          	ld	a,#192
2588  04d0               L651:
2589  04d0 88            	push	a
2590  04d1 7b06          	ld	a,(OFST-86,sp)
2591  04d3 88            	push	a
2592  04d4 1e05          	ldw	x,(OFST-87,sp)
2593  04d6 cd0000        	call	_GPIO_Init
2595  04d9 85            	popw	x
2596                     ; 409 		is_high=!is_high;
2598  04da 0d5c          	tnz	(OFST+0,sp)
2599  04dc 2604          	jrne	L061
2600  04de a601          	ld	a,#1
2601  04e0 2001          	jra	L261
2602  04e2               L061:
2603  04e2 4f            	clr	a
2604  04e3               L261:
2605  04e3 6b5c          	ld	(OFST+0,sp),a
2607                     ; 410 	}while(is_high);
2609  04e5 0d5c          	tnz	(OFST+0,sp)
2610  04e7 2703          	jreq	L461
2611  04e9 cc0432        	jp	L3401
2612  04ec               L461:
2613                     ; 411 }
2616  04ec 5b5d          	addw	sp,#93
2617  04ee 81            	ret
2641                     ; 414 bool is_space_sao()
2641                     ; 415 {
2642                     	switch	.text
2643  04ef               _is_space_sao:
2647                     ; 416 	return 1;//TODO: implement EEPROM read
2649  04ef a601          	ld	a,#1
2652  04f1 81            	ret
2686                     ; 419 u8 get_eeprom_byte(u16 eeprom_address)
2686                     ; 420 {
2687                     	switch	.text
2688  04f2               _get_eeprom_byte:
2692                     ; 421 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2694  04f2 d64000        	ld	a,(16384,x)
2697  04f5 81            	ret
2833                     	xdef	f_TIM2_CapComp_IRQ_Handler
2834                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2835                     	switch	.ubsct
2836  0000               _button_pressed_event:
2837  0000 00000000      	ds.b	4
2838                     	xdef	_button_pressed_event
2839  0004               _button_start_ms:
2840  0004 00000000      	ds.b	4
2841                     	xdef	_button_start_ms
2842                     	xdef	_pwm_state
2843                     	xdef	_pwm_led_index
2844                     	xdef	_pwm_sleep_remaining
2845  0008               _pwm_led_count:
2846  0008 0000          	ds.b	2
2847                     	xdef	_pwm_led_count
2848  000a               _pwm_sleep:
2849  000a 00000000      	ds.b	4
2850                     	xdef	_pwm_sleep
2851  000e               _pwm_brightness:
2852  000e 000000000000  	ds.b	172
2853                     	xdef	_pwm_brightness
2854                     	xdef	_PWM_MAX_PERIOD
2855  00ba               _pwm_brightness_buffer:
2856  00ba 000000000000  	ds.b	43
2857                     	xdef	_pwm_brightness_buffer
2858                     	xdef	_api_counter
2859                     	xdef	_hw_revision
2860                     	xref	_UART1_Cmd
2861                     	xref	_UART1_Init
2862                     	xref	_UART1_DeInit
2863                     	xref	_GPIO_ReadInputPin
2864                     	xref	_GPIO_Init
2865                     	xdef	_get_eeprom_byte
2866                     	xdef	_set_millis
2867                     	xdef	_get_random
2868                     	xdef	_is_space_sao
2869                     	xdef	_is_button_down
2870                     	xdef	_clear_button_events
2871                     	xdef	_clear_button_event
2872                     	xdef	_get_button_event
2873                     	xdef	_update_buttons
2874                     	xdef	_is_sleep_valid
2875                     	xdef	_is_developer_valid
2876                     	xdef	_set_hue
2877                     	xdef	_flush_leds
2878                     	xdef	_set_led
2879                     	xdef	_set_debug
2880                     	xdef	_set_white
2881                     	xdef	_set_rgb
2882                     	xdef	_set_matrix_high_z
2883                     	xdef	_millis
2884                     	xdef	_setup_main
2885                     	xdef	_is_application_valid
2886                     	xdef	_setup_serial
2887                     	xdef	_hello_world
2888                     	xref.b	c_lreg
2889                     	xref.b	c_x
2890                     	xref.b	c_y
2910                     	xref	c_xymov
2911                     	xref	c_bmulx
2912                     	xref	c_lzmp
2913                     	xref	c_lsub
2914                     	xref	c_rtol
2915                     	xref	c_uitolx
2916                     	xref	c_itolx
2917                     	xref	c_imul
2918                     	xref	c_lrzmp
2919                     	xref	c_lmod
2920                     	xref	c_ltor
2921                     	xref	c_lgadc
2922                     	end
