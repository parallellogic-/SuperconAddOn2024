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
  31  0089               _temp_delete_me:
  32  0089 0000          	dc.w	0
  33  008b               _temp3_delete_me:
  34  008b 0000          	dc.w	0
 107                     .const:	section	.text
 108  0000               L6:
 109  0000 00005556      	dc.l	21846
 110  0004               L01:
 111  0004 0000aaab      	dc.l	43691
 112  0008               L21:
 113  0008 0000d554      	dc.l	54612
 114  000c               L41:
 115  000c 00002aab      	dc.l	10923
 116                     ; 34 void hello_world()
 116                     ; 35 {//basic program that blinks the debug LED ON/OFF
 117                     	scross	off
 118                     	switch	.text
 119  0000               _hello_world:
 121  0000 5205          	subw	sp,#5
 122       00000005      OFST:	set	5
 125                     ; 38 	bool is_high=0;
 127                     ; 39 	long frame=0;
 129  0002 ae0000        	ldw	x,#0
 130  0005 1f04          	ldw	(OFST-1,sp),x
 131  0007 ae0000        	ldw	x,#0
 132  000a 1f02          	ldw	(OFST-3,sp),x
 134                     ; 40 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 136  000c 4b40          	push	#64
 137  000e 4b08          	push	#8
 138  0010 ae5000        	ldw	x,#20480
 139  0013 cd0000        	call	_GPIO_Init
 141  0016 85            	popw	x
 142  0017               L34:
 143                     ; 47 		frame++;
 145  0017 96            	ldw	x,sp
 146  0018 1c0002        	addw	x,#OFST-3
 147  001b a601          	ld	a,#1
 148  001d cd0000        	call	c_lgadc
 151                     ; 65 			set_hue_max(4,(frame<<8));
 153  0020 96            	ldw	x,sp
 154  0021 1c0002        	addw	x,#OFST-3
 155  0024 cd0000        	call	c_ltor
 157  0027 a608          	ld	a,#8
 158  0029 cd0000        	call	c_llsh
 160  002c be02          	ldw	x,c_lreg+2
 161  002e 89            	pushw	x
 162  002f a604          	ld	a,#4
 163  0031 cd0533        	call	_set_hue_max
 165  0034 85            	popw	x
 166                     ; 66 			set_hue_max(5,(frame<<8)+0x5556);
 168  0035 96            	ldw	x,sp
 169  0036 1c0002        	addw	x,#OFST-3
 170  0039 cd0000        	call	c_ltor
 172  003c a608          	ld	a,#8
 173  003e cd0000        	call	c_llsh
 175  0041 ae0000        	ldw	x,#L6
 176  0044 cd0000        	call	c_ladd
 178  0047 be02          	ldw	x,c_lreg+2
 179  0049 89            	pushw	x
 180  004a a605          	ld	a,#5
 181  004c cd0533        	call	_set_hue_max
 183  004f 85            	popw	x
 184                     ; 67 			set_hue_max(6,(frame<<8)+0xAAAB);
 186  0050 96            	ldw	x,sp
 187  0051 1c0002        	addw	x,#OFST-3
 188  0054 cd0000        	call	c_ltor
 190  0057 a608          	ld	a,#8
 191  0059 cd0000        	call	c_llsh
 193  005c ae0004        	ldw	x,#L01
 194  005f cd0000        	call	c_ladd
 196  0062 be02          	ldw	x,c_lreg+2
 197  0064 89            	pushw	x
 198  0065 a606          	ld	a,#6
 199  0067 cd0533        	call	_set_hue_max
 201  006a 85            	popw	x
 202                     ; 68 			set_hue_max(9,(frame<<8)+0xAAAB);
 204  006b 96            	ldw	x,sp
 205  006c 1c0002        	addw	x,#OFST-3
 206  006f cd0000        	call	c_ltor
 208  0072 a608          	ld	a,#8
 209  0074 cd0000        	call	c_llsh
 211  0077 ae0004        	ldw	x,#L01
 212  007a cd0000        	call	c_ladd
 214  007d be02          	ldw	x,c_lreg+2
 215  007f 89            	pushw	x
 216  0080 a609          	ld	a,#9
 217  0082 cd0533        	call	_set_hue_max
 219  0085 85            	popw	x
 220                     ; 69 			set_hue_max(0,(frame<<8)+0xD554);
 222  0086 96            	ldw	x,sp
 223  0087 1c0002        	addw	x,#OFST-3
 224  008a cd0000        	call	c_ltor
 226  008d a608          	ld	a,#8
 227  008f cd0000        	call	c_llsh
 229  0092 ae0008        	ldw	x,#L21
 230  0095 cd0000        	call	c_ladd
 232  0098 be02          	ldw	x,c_lreg+2
 233  009a 89            	pushw	x
 234  009b 4f            	clr	a
 235  009c cd0533        	call	_set_hue_max
 237  009f 85            	popw	x
 238                     ; 70 			set_hue_max(1,(frame<<8)+0x2AAB);
 240  00a0 96            	ldw	x,sp
 241  00a1 1c0002        	addw	x,#OFST-3
 242  00a4 cd0000        	call	c_ltor
 244  00a7 a608          	ld	a,#8
 245  00a9 cd0000        	call	c_llsh
 247  00ac ae000c        	ldw	x,#L41
 248  00af cd0000        	call	c_ladd
 250  00b2 be02          	ldw	x,c_lreg+2
 251  00b4 89            	pushw	x
 252  00b5 a601          	ld	a,#1
 253  00b7 cd0533        	call	_set_hue_max
 255  00ba 85            	popw	x
 256                     ; 88 			flush_leds(10);
 258  00bb a60a          	ld	a,#10
 259  00bd cd046b        	call	_flush_leds
 262  00c0 ac170017      	jpf	L34
 314                     ; 95 u16 get_random(u16 x)
 314                     ; 96 {
 315                     	switch	.text
 316  00c4               _get_random:
 318  00c4 5204          	subw	sp,#4
 319       00000004      OFST:	set	4
 322                     ; 97 	u16 a=1664525;
 324                     ; 98 	u16 c=1013904223;
 326                     ; 99 	return a * x + c;
 328  00c6 90ae660d      	ldw	y,#26125
 329  00ca cd0000        	call	c_imul
 331  00cd 1cf35f        	addw	x,#62303
 334  00d0 5b04          	addw	sp,#4
 335  00d2 81            	ret
 384                     	switch	.const
 385  0010               L62:
 386  0010 000f4240      	dc.l	1000000
 387                     ; 102 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 387                     ; 103 {
 388                     	switch	.text
 389  00d3               _setup_serial:
 391  00d3 89            	pushw	x
 392       00000000      OFST:	set	0
 395                     ; 104 	if(is_enabled)
 397  00d4 9e            	ld	a,xh
 398  00d5 4d            	tnz	a
 399  00d6 2747          	jreq	L711
 400                     ; 106 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 402  00d8 4bf0          	push	#240
 403  00da 4b20          	push	#32
 404  00dc ae500f        	ldw	x,#20495
 405  00df cd0000        	call	_GPIO_Init
 407  00e2 85            	popw	x
 408                     ; 107 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 410  00e3 4b40          	push	#64
 411  00e5 4b40          	push	#64
 412  00e7 ae500f        	ldw	x,#20495
 413  00ea cd0000        	call	_GPIO_Init
 415  00ed 85            	popw	x
 416                     ; 108 		UART1_DeInit();
 418  00ee cd0000        	call	_UART1_DeInit
 420                     ; 109 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 422  00f1 4b0c          	push	#12
 423  00f3 4b80          	push	#128
 424  00f5 4b00          	push	#0
 425  00f7 4b00          	push	#0
 426  00f9 4b00          	push	#0
 427  00fb 0d07          	tnz	(OFST+7,sp)
 428  00fd 2708          	jreq	L22
 429  00ff ae2580        	ldw	x,#9600
 430  0102 cd0000        	call	c_itolx
 432  0105 2006          	jra	L42
 433  0107               L22:
 434  0107 ae0010        	ldw	x,#L62
 435  010a cd0000        	call	c_ltor
 437  010d               L42:
 438  010d be02          	ldw	x,c_lreg+2
 439  010f 89            	pushw	x
 440  0110 be00          	ldw	x,c_lreg
 441  0112 89            	pushw	x
 442  0113 cd0000        	call	_UART1_Init
 444  0116 5b09          	addw	sp,#9
 445                     ; 110 		UART1_Cmd(ENABLE);
 447  0118 a601          	ld	a,#1
 448  011a cd0000        	call	_UART1_Cmd
 451  011d 201d          	jra	L121
 452  011f               L711:
 453                     ; 112 		UART1_Cmd(DISABLE);
 455  011f 4f            	clr	a
 456  0120 cd0000        	call	_UART1_Cmd
 458                     ; 113 		UART1_DeInit();
 460  0123 cd0000        	call	_UART1_DeInit
 462                     ; 114 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 464  0126 4b40          	push	#64
 465  0128 4b20          	push	#32
 466  012a ae500f        	ldw	x,#20495
 467  012d cd0000        	call	_GPIO_Init
 469  0130 85            	popw	x
 470                     ; 115 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 472  0131 4b40          	push	#64
 473  0133 4b40          	push	#64
 474  0135 ae500f        	ldw	x,#20495
 475  0138 cd0000        	call	_GPIO_Init
 477  013b 85            	popw	x
 478  013c               L121:
 479                     ; 117 }
 482  013c 85            	popw	x
 483  013d 81            	ret
 510                     ; 120 bool is_application_valid()
 510                     ; 121 {
 511                     	switch	.text
 512  013e               _is_application_valid:
 516                     ; 122 	return !is_button_down(2) && !get_button_event(0,1);
 518  013e a602          	ld	a,#2
 519  0140 cd0274        	call	_is_button_down
 521  0143 4d            	tnz	a
 522  0144 260d          	jrne	L23
 523  0146 ae0001        	ldw	x,#1
 524  0149 cd0225        	call	_get_button_event
 526  014c 4d            	tnz	a
 527  014d 2604          	jrne	L23
 528  014f a601          	ld	a,#1
 529  0151 2001          	jra	L43
 530  0153               L23:
 531  0153 4f            	clr	a
 532  0154               L43:
 535  0154 81            	ret
 561                     ; 126 bool is_developer_valid()
 561                     ; 127 {
 562                     	switch	.text
 563  0155               _is_developer_valid:
 567                     ; 128 	return is_button_down(2) && !get_button_event(0,1);
 569  0155 a602          	ld	a,#2
 570  0157 cd0274        	call	_is_button_down
 572  015a 4d            	tnz	a
 573  015b 270d          	jreq	L04
 574  015d ae0001        	ldw	x,#1
 575  0160 cd0225        	call	_get_button_event
 577  0163 4d            	tnz	a
 578  0164 2604          	jrne	L04
 579  0166 a601          	ld	a,#1
 580  0168 2001          	jra	L24
 581  016a               L04:
 582  016a 4f            	clr	a
 583  016b               L24:
 586  016b 81            	ret
 611                     ; 131 void setup_main()
 611                     ; 132 {
 612                     	switch	.text
 613  016c               _setup_main:
 617                     ; 133 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 619  016c c650c6        	ld	a,20678
 620  016f a4e7          	and	a,#231
 621  0171 c750c6        	ld	20678,a
 622                     ; 135 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 624  0174 4b40          	push	#64
 625  0176 4b02          	push	#2
 626  0178 ae500f        	ldw	x,#20495
 627  017b cd0000        	call	_GPIO_Init
 629  017e 85            	popw	x
 630                     ; 138 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 632  017f 725f5311      	clr	21265
 633                     ; 139 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 635  0183 3505530e      	mov	21262,#5
 636                     ; 140 	TIM2->ARRH= 16;// init auto reload register
 638  0187 3510530f      	mov	21263,#16
 639                     ; 141 	TIM2->ARRL= 255;// init auto reload register
 641  018b 35ff5310      	mov	21264,#255
 642                     ; 143 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 644  018f c65300        	ld	a,21248
 645  0192 aa05          	or	a,#5
 646  0194 c75300        	ld	21248,a
 647                     ; 145 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 649  0197 35015303      	mov	21251,#1
 650                     ; 146 	enableInterrupts();
 653  019b 9a            rim
 655                     ; 147 }
 659  019c 81            	ret
 682                     ; 149 u32 millis()
 682                     ; 150 {
 683                     	switch	.text
 684  019d               _millis:
 688                     ; 151 	return 0;//api_counter>>10;
 690  019d ae0000        	ldw	x,#0
 691  01a0 bf02          	ldw	c_lreg+2,x
 692  01a2 ae0000        	ldw	x,#0
 693  01a5 bf00          	ldw	c_lreg,x
 696  01a7 81            	ret
 754                     ; 157 void update_buttons()
 754                     ; 158 {
 755                     	switch	.text
 756  01a8               _update_buttons:
 758  01a8 5208          	subw	sp,#8
 759       00000008      OFST:	set	8
 762                     ; 159 	bool is_any_down=0;
 764  01aa 0f05          	clr	(OFST-3,sp)
 766                     ; 161 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 768  01ac be06          	ldw	x,_button_start_ms+2
 769  01ae cd0000        	call	c_uitolx
 771  01b1 96            	ldw	x,sp
 772  01b2 1c0001        	addw	x,#OFST-7
 773  01b5 cd0000        	call	c_rtol
 776  01b8 ade3          	call	_millis
 778  01ba 96            	ldw	x,sp
 779  01bb 1c0001        	addw	x,#OFST-7
 780  01be cd0000        	call	c_lsub
 782  01c1 be02          	ldw	x,c_lreg+2
 783  01c3 1f06          	ldw	(OFST-2,sp),x
 785                     ; 162 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 787  01c5 0f08          	clr	(OFST+0,sp)
 789  01c7               L112:
 790                     ; 164 		if(is_button_down(button_index))
 792  01c7 7b08          	ld	a,(OFST+0,sp)
 793  01c9 cd0274        	call	_is_button_down
 795  01cc 4d            	tnz	a
 796  01cd 271b          	jreq	L712
 797                     ; 166 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 799  01cf ae0004        	ldw	x,#_button_start_ms
 800  01d2 cd0000        	call	c_lzmp
 802  01d5 2608          	jrne	L122
 805  01d7 adc4          	call	_millis
 807  01d9 ae0004        	ldw	x,#_button_start_ms
 808  01dc cd0000        	call	c_rtol
 810  01df               L122:
 811                     ; 167 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 813  01df a6ff          	ld	a,#255
 814  01e1 cd05fb        	call	_set_debug
 816                     ; 168 			is_any_down=1;
 818  01e4 a601          	ld	a,#1
 819  01e6 6b05          	ld	(OFST-3,sp),a
 822  01e8 2022          	jra	L322
 823  01ea               L712:
 824                     ; 170 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 826  01ea 1e06          	ldw	x,(OFST-2,sp)
 827  01ec a30201        	cpw	x,#513
 828  01ef 250b          	jrult	L522
 831  01f1 7b08          	ld	a,(OFST+0,sp)
 832  01f3 5f            	clrw	x
 833  01f4 97            	ld	xl,a
 834  01f5 58            	sllw	x
 835  01f6 a601          	ld	a,#1
 836  01f8 e701          	ld	(_button_pressed_event+1,x),a
 838  01fa 2010          	jra	L322
 839  01fc               L522:
 840                     ; 171 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 842  01fc 1e06          	ldw	x,(OFST-2,sp)
 843  01fe a30033        	cpw	x,#51
 844  0201 2509          	jrult	L322
 847  0203 7b08          	ld	a,(OFST+0,sp)
 848  0205 5f            	clrw	x
 849  0206 97            	ld	xl,a
 850  0207 58            	sllw	x
 851  0208 a601          	ld	a,#1
 852  020a e700          	ld	(_button_pressed_event,x),a
 853  020c               L322:
 854                     ; 162 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 856  020c 0c08          	inc	(OFST+0,sp)
 860  020e 7b08          	ld	a,(OFST+0,sp)
 861  0210 a102          	cp	a,#2
 862  0212 25b3          	jrult	L112
 863                     ; 175 	if(!is_any_down) button_start_ms=0;
 865  0214 0d05          	tnz	(OFST-3,sp)
 866  0216 260a          	jrne	L332
 869  0218 ae0000        	ldw	x,#0
 870  021b bf06          	ldw	_button_start_ms+2,x
 871  021d ae0000        	ldw	x,#0
 872  0220 bf04          	ldw	_button_start_ms,x
 873  0222               L332:
 874                     ; 176 }
 877  0222 5b08          	addw	sp,#8
 878  0224 81            	ret
 924                     ; 179 bool get_button_event(u8 button_index,bool is_long)
 924                     ; 180 { return button_pressed_event[button_index][is_long]; }
 925                     	switch	.text
 926  0225               _get_button_event:
 928  0225 89            	pushw	x
 929       00000000      OFST:	set	0
 934  0226 9e            	ld	a,xh
 935  0227 5f            	clrw	x
 936  0228 97            	ld	xl,a
 937  0229 58            	sllw	x
 938  022a 01            	rrwa	x,a
 939  022b 1b02          	add	a,(OFST+2,sp)
 940  022d 2401          	jrnc	L45
 941  022f 5c            	incw	x
 942  0230               L45:
 943  0230 02            	rlwa	x,a
 944  0231 e600          	ld	a,(_button_pressed_event,x)
 947  0233 85            	popw	x
 948  0234 81            	ret
1004                     ; 183 bool clear_button_event(u8 button_index,bool is_long)
1004                     ; 184 {
1005                     	switch	.text
1006  0235               _clear_button_event:
1008  0235 89            	pushw	x
1009  0236 88            	push	a
1010       00000001      OFST:	set	1
1013                     ; 185 	bool out=button_pressed_event[button_index][is_long];
1015  0237 9e            	ld	a,xh
1016  0238 5f            	clrw	x
1017  0239 97            	ld	xl,a
1018  023a 58            	sllw	x
1019  023b 01            	rrwa	x,a
1020  023c 1b03          	add	a,(OFST+2,sp)
1021  023e 2401          	jrnc	L06
1022  0240 5c            	incw	x
1023  0241               L06:
1024  0241 02            	rlwa	x,a
1025  0242 e600          	ld	a,(_button_pressed_event,x)
1026  0244 6b01          	ld	(OFST+0,sp),a
1028                     ; 186 	button_pressed_event[button_index][is_long]=0;
1030  0246 7b02          	ld	a,(OFST+1,sp)
1031  0248 5f            	clrw	x
1032  0249 97            	ld	xl,a
1033  024a 58            	sllw	x
1034  024b 01            	rrwa	x,a
1035  024c 1b03          	add	a,(OFST+2,sp)
1036  024e 2401          	jrnc	L26
1037  0250 5c            	incw	x
1038  0251               L26:
1039  0251 02            	rlwa	x,a
1040  0252 6f00          	clr	(_button_pressed_event,x)
1041                     ; 187 	return out;
1043  0254 7b01          	ld	a,(OFST+0,sp)
1046  0256 5b03          	addw	sp,#3
1047  0258 81            	ret
1083                     ; 190 void clear_button_events()
1083                     ; 191 {
1084                     	switch	.text
1085  0259               _clear_button_events:
1087  0259 88            	push	a
1088       00000001      OFST:	set	1
1091                     ; 193 	for(iter=0;iter<BUTTON_COUNT;iter++)
1093  025a 0f01          	clr	(OFST+0,sp)
1095  025c               L323:
1096                     ; 195 		clear_button_event(iter,0);
1098  025c 7b01          	ld	a,(OFST+0,sp)
1099  025e 5f            	clrw	x
1100  025f 95            	ld	xh,a
1101  0260 add3          	call	_clear_button_event
1103                     ; 196 		clear_button_event(iter,1);
1105  0262 7b01          	ld	a,(OFST+0,sp)
1106  0264 ae0001        	ldw	x,#1
1107  0267 95            	ld	xh,a
1108  0268 adcb          	call	_clear_button_event
1110                     ; 193 	for(iter=0;iter<BUTTON_COUNT;iter++)
1112  026a 0c01          	inc	(OFST+0,sp)
1116  026c 7b01          	ld	a,(OFST+0,sp)
1117  026e a102          	cp	a,#2
1118  0270 25ea          	jrult	L323
1119                     ; 198 }
1122  0272 84            	pop	a
1123  0273 81            	ret
1159                     ; 201 bool is_button_down(u8 index)
1159                     ; 202 {
1160                     	switch	.text
1161  0274               _is_button_down:
1165                     ; 203 	switch(index)
1168                     ; 207 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1170  0274 4d            	tnz	a
1171  0275 2708          	jreq	L133
1172  0277 4a            	dec	a
1173  0278 2718          	jreq	L333
1174  027a 4a            	dec	a
1175  027b 2728          	jreq	L533
1176  027d 2039          	jra	L753
1177  027f               L133:
1178                     ; 205 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1180  027f 4b20          	push	#32
1181  0281 ae500f        	ldw	x,#20495
1182  0284 cd0000        	call	_GPIO_ReadInputPin
1184  0287 5b01          	addw	sp,#1
1185  0289 4d            	tnz	a
1186  028a 2604          	jrne	L07
1187  028c a601          	ld	a,#1
1188  028e 2001          	jra	L27
1189  0290               L07:
1190  0290 4f            	clr	a
1191  0291               L27:
1194  0291 81            	ret
1195  0292               L333:
1196                     ; 206 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1199  0292 4b40          	push	#64
1200  0294 ae500f        	ldw	x,#20495
1201  0297 cd0000        	call	_GPIO_ReadInputPin
1203  029a 5b01          	addw	sp,#1
1204  029c 4d            	tnz	a
1205  029d 2604          	jrne	L47
1206  029f a601          	ld	a,#1
1207  02a1 2001          	jra	L67
1208  02a3               L47:
1209  02a3 4f            	clr	a
1210  02a4               L67:
1213  02a4 81            	ret
1214  02a5               L533:
1215                     ; 207 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1218  02a5 4b02          	push	#2
1219  02a7 ae500f        	ldw	x,#20495
1220  02aa cd0000        	call	_GPIO_ReadInputPin
1222  02ad 5b01          	addw	sp,#1
1223  02af 4d            	tnz	a
1224  02b0 2604          	jrne	L001
1225  02b2 a601          	ld	a,#1
1226  02b4 2001          	jra	L201
1227  02b6               L001:
1228  02b6 4f            	clr	a
1229  02b7               L201:
1232  02b7 81            	ret
1233  02b8               L753:
1234                     ; 209 	return 0;
1236  02b8 4f            	clr	a
1239  02b9 81            	ret
1292                     ; 213 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1294                     	switch	.text
1295  02ba               f_TIM2_UPD_OVF_IRQHandler:
1297  02ba 8a            	push	cc
1298  02bb 84            	pop	a
1299  02bc a4bf          	and	a,#191
1300  02be 88            	push	a
1301  02bf 86            	pop	cc
1302       00000005      OFST:	set	5
1303  02c0 3b0002        	push	c_x+2
1304  02c3 be00          	ldw	x,c_x
1305  02c5 89            	pushw	x
1306  02c6 3b0002        	push	c_y+2
1307  02c9 be00          	ldw	x,c_y
1308  02cb 89            	pushw	x
1309  02cc 5205          	subw	sp,#5
1312                     ; 214 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1314  02ce b688          	ld	a,_pwm_state
1315  02d0 a401          	and	a,#1
1316  02d2 6b05          	ld	(OFST+0,sp),a
1318                     ; 215 	u16 sleep_counts=1;
1320  02d4 ae0001        	ldw	x,#1
1321  02d7 1f03          	ldw	(OFST-2,sp),x
1323                     ; 217 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1325  02d9 c6500c        	ld	a,20492
1326  02dc a407          	and	a,#7
1327  02de c7500c        	ld	20492,a
1328                     ; 218 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1330  02e1 72155011      	bres	20497,#2
1331                     ; 219 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1333  02e5 72175002      	bres	20482,#3
1334                     ; 220 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1336  02e9 c6500d        	ld	a,20493
1337  02ec a407          	and	a,#7
1338  02ee c7500d        	ld	20493,a
1339                     ; 221 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1341  02f1 72155012      	bres	20498,#2
1342                     ; 222 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1344  02f5 72175003      	bres	20483,#3
1345                     ; 223   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1347  02f9 72115300      	bres	21248,#0
1348                     ; 224 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1350  02fd 7b05          	ld	a,(OFST+0,sp)
1351  02ff 5f            	clrw	x
1352  0300 97            	ld	xl,a
1353  0301 e685          	ld	a,(_pwm_led_count,x)
1354  0303 b187          	cp	a,_pwm_visible_index
1355  0305 2609          	jrne	L304
1356                     ; 226 		sleep_counts=pwm_sleep[buffer_index];
1358  0307 7b05          	ld	a,(OFST+0,sp)
1359  0309 5f            	clrw	x
1360  030a 97            	ld	xl,a
1361  030b 58            	sllw	x
1362  030c ee81          	ldw	x,(_pwm_sleep,x)
1363  030e 1f03          	ldw	(OFST-2,sp),x
1365  0310               L304:
1366                     ; 228 	if(pwm_visible_index>pwm_led_count[buffer_index])
1368  0310 7b05          	ld	a,(OFST+0,sp)
1369  0312 5f            	clrw	x
1370  0313 97            	ld	xl,a
1371  0314 e685          	ld	a,(_pwm_led_count,x)
1372  0316 b187          	cp	a,_pwm_visible_index
1373  0318 2416          	jruge	L504
1374                     ; 230 		frame_counter++;
1376  031a 3c00          	inc	_frame_counter
1377                     ; 231 		pwm_visible_index=0;//formally start new frame
1379  031c 3f87          	clr	_pwm_visible_index
1380                     ; 232 		if(pwm_state&0x02)
1382  031e b688          	ld	a,_pwm_state
1383  0320 a502          	bcp	a,#2
1384  0322 270c          	jreq	L504
1385                     ; 234 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1387  0324 b688          	ld	a,_pwm_state
1388  0326 a803          	xor	a,#3
1389  0328 b788          	ld	_pwm_state,a
1390                     ; 235 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1392  032a b688          	ld	a,_pwm_state
1393  032c a401          	and	a,#1
1394  032e 6b05          	ld	(OFST+0,sp),a
1396  0330               L504:
1397                     ; 238 	if(pwm_visible_index<pwm_led_count[buffer_index])
1399  0330 7b05          	ld	a,(OFST+0,sp)
1400  0332 5f            	clrw	x
1401  0333 97            	ld	xl,a
1402  0334 e685          	ld	a,(_pwm_led_count,x)
1403  0336 b187          	cp	a,_pwm_visible_index
1404  0338 2324          	jrule	L114
1405                     ; 240 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1407  033a 7b05          	ld	a,(OFST+0,sp)
1408  033c 5f            	clrw	x
1409  033d 97            	ld	xl,a
1410  033e 58            	sllw	x
1411  033f 1f01          	ldw	(OFST-4,sp),x
1413  0341 b687          	ld	a,_pwm_visible_index
1414  0343 97            	ld	xl,a
1415  0344 a604          	ld	a,#4
1416  0346 42            	mul	x,a
1417  0347 72fb01        	addw	x,(OFST-4,sp)
1418  034a ee01          	ldw	x,(_pwm_brightness,x)
1419  034c 1f03          	ldw	(OFST-2,sp),x
1421                     ; 241 		set_led(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1423  034e b687          	ld	a,_pwm_visible_index
1424  0350 5f            	clrw	x
1425  0351 97            	ld	xl,a
1426  0352 58            	sllw	x
1427  0353 01            	rrwa	x,a
1428  0354 1b05          	add	a,(OFST+0,sp)
1429  0356 2401          	jrnc	L601
1430  0358 5c            	incw	x
1431  0359               L601:
1432  0359 02            	rlwa	x,a
1433  035a e628          	ld	a,(_pwm_brightness_index,x)
1434  035c ad2d          	call	_set_led
1436  035e               L114:
1437                     ; 243 	pwm_visible_index++;
1439  035e 3c87          	inc	_pwm_visible_index
1440                     ; 245   TIM2->CNTRH = 0;// Set the high byte of the counter
1442  0360 725f530c      	clr	21260
1443                     ; 246   TIM2->CNTRL = 0;// Set the low byte of the counter
1445  0364 725f530d      	clr	21261
1446                     ; 247 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1448  0368 7b03          	ld	a,(OFST-2,sp)
1449  036a c7530f        	ld	21263,a
1450                     ; 248 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1452  036d 7b04          	ld	a,(OFST-1,sp)
1453  036f a4ff          	and	a,#255
1454  0371 c75310        	ld	21264,a
1455                     ; 250 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1457  0374 72115304      	bres	21252,#0
1458                     ; 251   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1460  0378 72105300      	bset	21248,#0
1461                     ; 252 }
1464  037c 5b05          	addw	sp,#5
1465  037e 85            	popw	x
1466  037f bf00          	ldw	c_y,x
1467  0381 320002        	pop	c_y+2
1468  0384 85            	popw	x
1469  0385 bf00          	ldw	c_x,x
1470  0387 320002        	pop	c_x+2
1471  038a 80            	iret
1473                     	switch	.const
1474  0014               L314_led_lookup:
1475  0014 00            	dc.b	0
1476  0015 01            	dc.b	1
1477  0016 01            	dc.b	1
1478  0017 00            	dc.b	0
1479  0018 05            	dc.b	5
1480  0019 00            	dc.b	0
1481  001a 06            	dc.b	6
1482  001b 00            	dc.b	0
1483  001c 06            	dc.b	6
1484  001d 05            	dc.b	5
1485  001e 04            	dc.b	4
1486  001f 03            	dc.b	3
1487  0020 03            	dc.b	3
1488  0021 04            	dc.b	4
1489  0022 00            	dc.b	0
1490  0023 05            	dc.b	5
1491  0024 00            	dc.b	0
1492  0025 04            	dc.b	4
1493  0026 00            	dc.b	0
1494  0027 03            	dc.b	3
1495  0028 00            	dc.b	0
1496  0029 02            	dc.b	2
1497  002a 02            	dc.b	2
1498  002b 00            	dc.b	0
1499  002c 05            	dc.b	5
1500  002d 01            	dc.b	1
1501  002e 06            	dc.b	6
1502  002f 01            	dc.b	1
1503  0030 06            	dc.b	6
1504  0031 04            	dc.b	4
1505  0032 05            	dc.b	5
1506  0033 03            	dc.b	3
1507  0034 03            	dc.b	3
1508  0035 05            	dc.b	5
1509  0036 00            	dc.b	0
1510  0037 06            	dc.b	6
1511  0038 01            	dc.b	1
1512  0039 04            	dc.b	4
1513  003a 01            	dc.b	1
1514  003b 03            	dc.b	3
1515  003c 01            	dc.b	1
1516  003d 02            	dc.b	2
1517  003e 02            	dc.b	2
1518  003f 01            	dc.b	1
1519  0040 05            	dc.b	5
1520  0041 02            	dc.b	2
1521  0042 06            	dc.b	6
1522  0043 02            	dc.b	2
1523  0044 05            	dc.b	5
1524  0045 04            	dc.b	4
1525  0046 06            	dc.b	6
1526  0047 03            	dc.b	3
1527  0048 03            	dc.b	3
1528  0049 06            	dc.b	6
1529  004a 01            	dc.b	1
1530  004b 06            	dc.b	6
1531  004c 02            	dc.b	2
1532  004d 04            	dc.b	4
1533  004e 02            	dc.b	2
1534  004f 03            	dc.b	3
1535  0050 07            	dc.b	7
1536  0051 07            	dc.b	7
1537  0052 03            	dc.b	3
1538  0053 01            	dc.b	1
1582                     ; 255 void set_led(u8 led_index)
1582                     ; 256 {
1584                     	switch	.text
1585  038b               _set_led:
1587  038b 88            	push	a
1588  038c 5242          	subw	sp,#66
1589       00000042      OFST:	set	66
1592                     ; 275 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1592                     ; 276 		{0,1},{1,0},{5,0},{6,0},{6,5},{4,3},{3,4},{0,5},{0,4},{0,3},//reds
1592                     ; 277 		{0,2},{2,0},{5,1},{6,1},{6,4},{5,3},{3,5},{0,6},{1,4},{1,3},//greens
1592                     ; 278 		{1,2},{2,1},{5,2},{6,2},{5,4},{6,3},{3,6},{1,6},{2,4},{2,3},//blues
1592                     ; 279 		{7,7},//debug; GND is tied low, no charlieplexing involved
1592                     ; 280 		{3,1},//LED6
1592                     ; 281 		/*{3,1},//LED4
1592                     ; 282 		{3,2},//LED5
1592                     ; 283 		{4,0},//LED14
1592                     ; 284 		{1,5},//LED8
1592                     ; 285 		{2,5},//LED9
1592                     ; 286 		{4,1},//LED10
1592                     ; 287 		{4,2},//LED16
1592                     ; 288 		{2,6},//LED17
1592                     ; 289 		{4,6},//LED12
1592                     ; 290 		{4,5},//LED13
1592                     ; 291 		{5,6}*/ //LED11
1592                     ; 292 	};
1594  038e 96            	ldw	x,sp
1595  038f 1c0003        	addw	x,#OFST-63
1596  0392 90ae0014      	ldw	y,#L314_led_lookup
1597  0396 a640          	ld	a,#64
1598  0398 cd0000        	call	c_xymov
1600                     ; 293 	set_mat(led_lookup[led_index][0],1);
1602  039b 96            	ldw	x,sp
1603  039c 1c0003        	addw	x,#OFST-63
1604  039f 1f01          	ldw	(OFST-65,sp),x
1606  03a1 7b43          	ld	a,(OFST+1,sp)
1607  03a3 5f            	clrw	x
1608  03a4 97            	ld	xl,a
1609  03a5 58            	sllw	x
1610  03a6 72fb01        	addw	x,(OFST-65,sp)
1611  03a9 f6            	ld	a,(x)
1612  03aa ae0001        	ldw	x,#1
1613  03ad 95            	ld	xh,a
1614  03ae ad1c          	call	_set_mat
1616                     ; 295 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1618  03b0 7b43          	ld	a,(OFST+1,sp)
1619  03b2 a11e          	cp	a,#30
1620  03b4 2713          	jreq	L734
1623  03b6 96            	ldw	x,sp
1624  03b7 1c0004        	addw	x,#OFST-62
1625  03ba 1f01          	ldw	(OFST-65,sp),x
1627  03bc 7b43          	ld	a,(OFST+1,sp)
1628  03be 5f            	clrw	x
1629  03bf 97            	ld	xl,a
1630  03c0 58            	sllw	x
1631  03c1 72fb01        	addw	x,(OFST-65,sp)
1632  03c4 f6            	ld	a,(x)
1633  03c5 5f            	clrw	x
1634  03c6 95            	ld	xh,a
1635  03c7 ad03          	call	_set_mat
1637  03c9               L734:
1638                     ; 296 }
1641  03c9 5b43          	addw	sp,#67
1642  03cb 81            	ret
1843                     ; 299 void set_mat(u8 mat_index,bool is_high)
1843                     ; 300 {
1844                     	switch	.text
1845  03cc               _set_mat:
1847  03cc 89            	pushw	x
1848  03cd 5203          	subw	sp,#3
1849       00000003      OFST:	set	3
1852                     ; 338 	if(mat_index==0)
1854  03cf 9e            	ld	a,xh
1855  03d0 4d            	tnz	a
1856  03d1 2609          	jrne	L755
1857                     ; 340 		GPIOx=GPIOD;
1859  03d3 ae500f        	ldw	x,#20495
1860  03d6 1f01          	ldw	(OFST-2,sp),x
1862                     ; 341 		GPIO_Pin=GPIO_PIN_3;
1864  03d8 a608          	ld	a,#8
1865  03da 6b03          	ld	(OFST+0,sp),a
1867  03dc               L755:
1868                     ; 343 	if(mat_index==1)
1870  03dc 7b04          	ld	a,(OFST+1,sp)
1871  03de a101          	cp	a,#1
1872  03e0 2609          	jrne	L165
1873                     ; 345 		GPIOx=GPIOD;
1875  03e2 ae500f        	ldw	x,#20495
1876  03e5 1f01          	ldw	(OFST-2,sp),x
1878                     ; 346 		GPIO_Pin=GPIO_PIN_2;
1880  03e7 a604          	ld	a,#4
1881  03e9 6b03          	ld	(OFST+0,sp),a
1883  03eb               L165:
1884                     ; 348 	if(mat_index==2)
1886  03eb 7b04          	ld	a,(OFST+1,sp)
1887  03ed a102          	cp	a,#2
1888  03ef 2609          	jrne	L365
1889                     ; 350 		GPIOx=GPIOC;
1891  03f1 ae500a        	ldw	x,#20490
1892  03f4 1f01          	ldw	(OFST-2,sp),x
1894                     ; 351 		GPIO_Pin=GPIO_PIN_7;
1896  03f6 a680          	ld	a,#128
1897  03f8 6b03          	ld	(OFST+0,sp),a
1899  03fa               L365:
1900                     ; 353 	if(mat_index==3)
1902  03fa 7b04          	ld	a,(OFST+1,sp)
1903  03fc a103          	cp	a,#3
1904  03fe 2609          	jrne	L565
1905                     ; 355 		GPIOx=GPIOC;
1907  0400 ae500a        	ldw	x,#20490
1908  0403 1f01          	ldw	(OFST-2,sp),x
1910                     ; 356 		GPIO_Pin=GPIO_PIN_6;
1912  0405 a640          	ld	a,#64
1913  0407 6b03          	ld	(OFST+0,sp),a
1915  0409               L565:
1916                     ; 358 	if(mat_index==4)
1918  0409 7b04          	ld	a,(OFST+1,sp)
1919  040b a104          	cp	a,#4
1920  040d 2609          	jrne	L765
1921                     ; 360 		GPIOx=GPIOC;
1923  040f ae500a        	ldw	x,#20490
1924  0412 1f01          	ldw	(OFST-2,sp),x
1926                     ; 361 		GPIO_Pin=GPIO_PIN_5;
1928  0414 a620          	ld	a,#32
1929  0416 6b03          	ld	(OFST+0,sp),a
1931  0418               L765:
1932                     ; 363 	if(mat_index==5)
1934  0418 7b04          	ld	a,(OFST+1,sp)
1935  041a a105          	cp	a,#5
1936  041c 2609          	jrne	L175
1937                     ; 365 		GPIOx=GPIOC;
1939  041e ae500a        	ldw	x,#20490
1940  0421 1f01          	ldw	(OFST-2,sp),x
1942                     ; 366 		GPIO_Pin=GPIO_PIN_4;
1944  0423 a610          	ld	a,#16
1945  0425 6b03          	ld	(OFST+0,sp),a
1947  0427               L175:
1948                     ; 368 	if(mat_index==6)
1950  0427 7b04          	ld	a,(OFST+1,sp)
1951  0429 a106          	cp	a,#6
1952  042b 2609          	jrne	L375
1953                     ; 370 		GPIOx=GPIOC;
1955  042d ae500a        	ldw	x,#20490
1956  0430 1f01          	ldw	(OFST-2,sp),x
1958                     ; 371 		GPIO_Pin=GPIO_PIN_3;
1960  0432 a608          	ld	a,#8
1961  0434 6b03          	ld	(OFST+0,sp),a
1963  0436               L375:
1964                     ; 373 	if(mat_index==7)
1966  0436 7b04          	ld	a,(OFST+1,sp)
1967  0438 a107          	cp	a,#7
1968  043a 2609          	jrne	L575
1969                     ; 375 		GPIOx=GPIOA;
1971  043c ae5000        	ldw	x,#20480
1972  043f 1f01          	ldw	(OFST-2,sp),x
1974                     ; 376 		GPIO_Pin=GPIO_PIN_3;
1976  0441 a608          	ld	a,#8
1977  0443 6b03          	ld	(OFST+0,sp),a
1979  0445               L575:
1980                     ; 378 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1982  0445 0d05          	tnz	(OFST+2,sp)
1983  0447 2708          	jreq	L775
1986  0449 1e01          	ldw	x,(OFST-2,sp)
1987  044b f6            	ld	a,(x)
1988  044c 1a03          	or	a,(OFST+0,sp)
1989  044e f7            	ld	(x),a
1991  044f 2007          	jra	L106
1992  0451               L775:
1993                     ; 379 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1995  0451 1e01          	ldw	x,(OFST-2,sp)
1996  0453 7b03          	ld	a,(OFST+0,sp)
1997  0455 43            	cpl	a
1998  0456 f4            	and	a,(x)
1999  0457 f7            	ld	(x),a
2000  0458               L106:
2001                     ; 380 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2003  0458 1e01          	ldw	x,(OFST-2,sp)
2004  045a e602          	ld	a,(2,x)
2005  045c 1a03          	or	a,(OFST+0,sp)
2006  045e e702          	ld	(2,x),a
2007                     ; 381 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2009  0460 1e01          	ldw	x,(OFST-2,sp)
2010  0462 e603          	ld	a,(3,x)
2011  0464 1a03          	or	a,(OFST+0,sp)
2012  0466 e703          	ld	(3,x),a
2013                     ; 382 }
2016  0468 5b05          	addw	sp,#5
2017  046a 81            	ret
2093                     ; 385 void flush_leds(u8 led_count)
2093                     ; 386 {
2094                     	switch	.text
2095  046b               _flush_leds:
2097  046b 88            	push	a
2098  046c 5207          	subw	sp,#7
2099       00000007      OFST:	set	7
2102                     ; 387 	u8 led_read_index=0,led_write_index=0;
2106  046e 0f05          	clr	(OFST-2,sp)
2109  0470               L546:
2110                     ; 390 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2112  0470 b688          	ld	a,_pwm_state
2113  0472 a502          	bcp	a,#2
2114  0474 26fa          	jrne	L546
2115                     ; 391 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2117  0476 b688          	ld	a,_pwm_state
2118  0478 a401          	and	a,#1
2119  047a a801          	xor	a,#1
2120  047c 6b07          	ld	(OFST+0,sp),a
2122                     ; 393 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2124  047e 7b08          	ld	a,(OFST+1,sp)
2125  0480 5f            	clrw	x
2126  0481 97            	ld	xl,a
2127  0482 4f            	clr	a
2128  0483 02            	rlwa	x,a
2129  0484 58            	sllw	x
2130  0485 58            	sllw	x
2131  0486 7b07          	ld	a,(OFST+0,sp)
2132  0488 905f          	clrw	y
2133  048a 9097          	ld	yl,a
2134  048c 9058          	sllw	y
2135  048e 90ef81        	ldw	(_pwm_sleep,y),x
2136                     ; 395 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2138  0491 0f06          	clr	(OFST-1,sp)
2140  0493               L156:
2141                     ; 397 		read_brightness=pwm_brightness_buffer[led_read_index];
2143  0493 7b06          	ld	a,(OFST-1,sp)
2144  0495 5f            	clrw	x
2145  0496 97            	ld	xl,a
2146  0497 e608          	ld	a,(_pwm_brightness_buffer,x)
2147  0499 5f            	clrw	x
2148  049a 97            	ld	xl,a
2149  049b 1f03          	ldw	(OFST-4,sp),x
2151                     ; 398 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2153  049d 1e03          	ldw	x,(OFST-4,sp)
2154  049f 2767          	jreq	L756
2155                     ; 400 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2157  04a1 7b05          	ld	a,(OFST-2,sp)
2158  04a3 5f            	clrw	x
2159  04a4 97            	ld	xl,a
2160  04a5 58            	sllw	x
2161  04a6 01            	rrwa	x,a
2162  04a7 1b07          	add	a,(OFST+0,sp)
2163  04a9 2401          	jrnc	L611
2164  04ab 5c            	incw	x
2165  04ac               L611:
2166  04ac 02            	rlwa	x,a
2167  04ad 7b06          	ld	a,(OFST-1,sp)
2168  04af e728          	ld	(_pwm_brightness_index,x),a
2169                     ; 401 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2171  04b1 1e03          	ldw	x,(OFST-4,sp)
2172  04b3 1603          	ldw	y,(OFST-4,sp)
2173  04b5 cd0000        	call	c_imul
2175  04b8 a606          	ld	a,#6
2176  04ba               L021:
2177  04ba 54            	srlw	x
2178  04bb 4a            	dec	a
2179  04bc 26fc          	jrne	L021
2180  04be 5c            	incw	x
2181  04bf 7b07          	ld	a,(OFST+0,sp)
2182  04c1 905f          	clrw	y
2183  04c3 9097          	ld	yl,a
2184  04c5 9058          	sllw	y
2185  04c7 1701          	ldw	(OFST-6,sp),y
2187  04c9 7b05          	ld	a,(OFST-2,sp)
2188  04cb 905f          	clrw	y
2189  04cd 9097          	ld	yl,a
2190  04cf 9058          	sllw	y
2191  04d1 9058          	sllw	y
2192  04d3 72f901        	addw	y,(OFST-6,sp)
2193  04d6 90ef01        	ldw	(_pwm_brightness,y),x
2194                     ; 402 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2196  04d9 7b07          	ld	a,(OFST+0,sp)
2197  04db 5f            	clrw	x
2198  04dc 97            	ld	xl,a
2199  04dd 58            	sllw	x
2200  04de 7b07          	ld	a,(OFST+0,sp)
2201  04e0 905f          	clrw	y
2202  04e2 9097          	ld	yl,a
2203  04e4 9058          	sllw	y
2204  04e6 1701          	ldw	(OFST-6,sp),y
2206  04e8 7b05          	ld	a,(OFST-2,sp)
2207  04ea 905f          	clrw	y
2208  04ec 9097          	ld	yl,a
2209  04ee 9058          	sllw	y
2210  04f0 9058          	sllw	y
2211  04f2 72f901        	addw	y,(OFST-6,sp)
2212  04f5 90ee01        	ldw	y,(_pwm_brightness,y)
2213  04f8 9001          	rrwa	y,a
2214  04fa e082          	sub	a,(_pwm_sleep+1,x)
2215  04fc 9001          	rrwa	y,a
2216  04fe e281          	sbc	a,(_pwm_sleep,x)
2217  0500 9001          	rrwa	y,a
2218  0502 9050          	negw	y
2219  0504 ef81          	ldw	(_pwm_sleep,x),y
2220                     ; 403 			led_write_index++;
2222  0506 0c05          	inc	(OFST-2,sp)
2224  0508               L756:
2225                     ; 405 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2227  0508 7b06          	ld	a,(OFST-1,sp)
2228  050a 5f            	clrw	x
2229  050b 97            	ld	xl,a
2230  050c 6f08          	clr	(_pwm_brightness_buffer,x)
2231                     ; 395 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2233  050e 0c06          	inc	(OFST-1,sp)
2237  0510 7b06          	ld	a,(OFST-1,sp)
2238  0512 a120          	cp	a,#32
2239  0514 2403cc0493    	jrult	L156
2240                     ; 407 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2242  0519 7b07          	ld	a,(OFST+0,sp)
2243  051b 5f            	clrw	x
2244  051c 97            	ld	xl,a
2245  051d 58            	sllw	x
2246  051e 90ae0001      	ldw	y,#1
2247  0522 ef81          	ldw	(_pwm_sleep,x),y
2248                     ; 409 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2250  0524 7b07          	ld	a,(OFST+0,sp)
2251  0526 5f            	clrw	x
2252  0527 97            	ld	xl,a
2253  0528 7b05          	ld	a,(OFST-2,sp)
2254  052a e785          	ld	(_pwm_led_count,x),a
2255                     ; 412 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2257  052c 72120088      	bset	_pwm_state,#1
2258                     ; 413 }
2261  0530 5b08          	addw	sp,#8
2262  0532 81            	ret
2351                     ; 416 void set_hue_max(u8 index,u16 color)
2351                     ; 417 {
2352                     	switch	.text
2353  0533               _set_hue_max:
2355  0533 88            	push	a
2356  0534 5205          	subw	sp,#5
2357       00000005      OFST:	set	5
2360                     ; 418 	u8 red=0,green=0,blue=0;
2362  0536 0f01          	clr	(OFST-4,sp)
2366  0538 0f02          	clr	(OFST-3,sp)
2370  053a 0f03          	clr	(OFST-2,sp)
2372                     ; 419 	u8 residual=0;
2374  053c 0f04          	clr	(OFST-1,sp)
2376                     ; 421 	for(iter=0;iter<6;iter++)
2378  053e 0f05          	clr	(OFST+0,sp)
2380  0540               L727:
2381                     ; 423 		if(color<0x2AAB)
2383  0540 1e09          	ldw	x,(OFST+4,sp)
2384  0542 a32aab        	cpw	x,#10923
2385  0545 240b          	jruge	L537
2386                     ; 425 			residual=color/43;
2388  0547 1e09          	ldw	x,(OFST+4,sp)
2389  0549 a62b          	ld	a,#43
2390  054b 62            	div	x,a
2391  054c 01            	rrwa	x,a
2392  054d 6b04          	ld	(OFST-1,sp),a
2393  054f 02            	rlwa	x,a
2395                     ; 426 			break;
2397  0550 200f          	jra	L337
2398  0552               L537:
2399                     ; 428 		color-=0x2AAB;
2401  0552 1e09          	ldw	x,(OFST+4,sp)
2402  0554 1d2aab        	subw	x,#10923
2403  0557 1f09          	ldw	(OFST+4,sp),x
2404                     ; 421 	for(iter=0;iter<6;iter++)
2406  0559 0c05          	inc	(OFST+0,sp)
2410  055b 7b05          	ld	a,(OFST+0,sp)
2411  055d a106          	cp	a,#6
2412  055f 25df          	jrult	L727
2413  0561               L337:
2414                     ; 430 	if(iter==0){ red=255; green=residual; }
2416  0561 0d05          	tnz	(OFST+0,sp)
2417  0563 2608          	jrne	L737
2420  0565 a6ff          	ld	a,#255
2421  0567 6b01          	ld	(OFST-4,sp),a
2425  0569 7b04          	ld	a,(OFST-1,sp)
2426  056b 6b02          	ld	(OFST-3,sp),a
2428  056d               L737:
2429                     ; 431 	if(iter==1){ green=255; red=255-residual; }
2431  056d 7b05          	ld	a,(OFST+0,sp)
2432  056f a101          	cp	a,#1
2433  0571 260a          	jrne	L147
2436  0573 a6ff          	ld	a,#255
2437  0575 6b02          	ld	(OFST-3,sp),a
2441  0577 a6ff          	ld	a,#255
2442  0579 1004          	sub	a,(OFST-1,sp)
2443  057b 6b01          	ld	(OFST-4,sp),a
2445  057d               L147:
2446                     ; 432 	if(iter==2){ green=255; blue=residual; }
2448  057d 7b05          	ld	a,(OFST+0,sp)
2449  057f a102          	cp	a,#2
2450  0581 2608          	jrne	L347
2453  0583 a6ff          	ld	a,#255
2454  0585 6b02          	ld	(OFST-3,sp),a
2458  0587 7b04          	ld	a,(OFST-1,sp)
2459  0589 6b03          	ld	(OFST-2,sp),a
2461  058b               L347:
2462                     ; 433 	if(iter==3){ blue=255; green=255-residual; }
2464  058b 7b05          	ld	a,(OFST+0,sp)
2465  058d a103          	cp	a,#3
2466  058f 260a          	jrne	L547
2469  0591 a6ff          	ld	a,#255
2470  0593 6b03          	ld	(OFST-2,sp),a
2474  0595 a6ff          	ld	a,#255
2475  0597 1004          	sub	a,(OFST-1,sp)
2476  0599 6b02          	ld	(OFST-3,sp),a
2478  059b               L547:
2479                     ; 434 	if(iter==4){ blue=255; red=residual; }
2481  059b 7b05          	ld	a,(OFST+0,sp)
2482  059d a104          	cp	a,#4
2483  059f 2608          	jrne	L747
2486  05a1 a6ff          	ld	a,#255
2487  05a3 6b03          	ld	(OFST-2,sp),a
2491  05a5 7b04          	ld	a,(OFST-1,sp)
2492  05a7 6b01          	ld	(OFST-4,sp),a
2494  05a9               L747:
2495                     ; 435 	if(iter==5){ red=255; blue=255-residual; }
2497  05a9 7b05          	ld	a,(OFST+0,sp)
2498  05ab a105          	cp	a,#5
2499  05ad 260a          	jrne	L157
2502  05af a6ff          	ld	a,#255
2503  05b1 6b01          	ld	(OFST-4,sp),a
2507  05b3 a6ff          	ld	a,#255
2508  05b5 1004          	sub	a,(OFST-1,sp)
2509  05b7 6b03          	ld	(OFST-2,sp),a
2511  05b9               L157:
2512                     ; 436 	set_rgb(index,0,red);
2514  05b9 7b01          	ld	a,(OFST-4,sp)
2515  05bb 88            	push	a
2516  05bc 7b07          	ld	a,(OFST+2,sp)
2517  05be 5f            	clrw	x
2518  05bf 95            	ld	xh,a
2519  05c0 ad1c          	call	_set_rgb
2521  05c2 84            	pop	a
2522                     ; 437 	set_rgb(index,1,green);
2524  05c3 7b02          	ld	a,(OFST-3,sp)
2525  05c5 88            	push	a
2526  05c6 7b07          	ld	a,(OFST+2,sp)
2527  05c8 ae0001        	ldw	x,#1
2528  05cb 95            	ld	xh,a
2529  05cc ad10          	call	_set_rgb
2531  05ce 84            	pop	a
2532                     ; 438 	set_rgb(index,2,blue);
2534  05cf 7b03          	ld	a,(OFST-2,sp)
2535  05d1 88            	push	a
2536  05d2 7b07          	ld	a,(OFST+2,sp)
2537  05d4 ae0002        	ldw	x,#2
2538  05d7 95            	ld	xh,a
2539  05d8 ad04          	call	_set_rgb
2541  05da 84            	pop	a
2542                     ; 439 }
2545  05db 5b06          	addw	sp,#6
2546  05dd 81            	ret
2599                     ; 441 void set_rgb(u8 index,u8 color,u8 brightness)
2599                     ; 442 {
2600                     	switch	.text
2601  05de               _set_rgb:
2603  05de 89            	pushw	x
2604       00000000      OFST:	set	0
2607                     ; 443 	pwm_brightness_buffer[index+color*RGB_COUNT]=brightness;
2609  05df 9f            	ld	a,xl
2610  05e0 97            	ld	xl,a
2611  05e1 a60a          	ld	a,#10
2612  05e3 42            	mul	x,a
2613  05e4 01            	rrwa	x,a
2614  05e5 1b01          	add	a,(OFST+1,sp)
2615  05e7 2401          	jrnc	L621
2616  05e9 5c            	incw	x
2617  05ea               L621:
2618  05ea 02            	rlwa	x,a
2619  05eb 7b05          	ld	a,(OFST+5,sp)
2620  05ed e708          	ld	(_pwm_brightness_buffer,x),a
2621                     ; 444 }
2624  05ef 85            	popw	x
2625  05f0 81            	ret
2669                     ; 446 void set_white(u8 index,u8 brightness)
2669                     ; 447 {
2670                     	switch	.text
2671  05f1               _set_white:
2673  05f1 89            	pushw	x
2674       00000000      OFST:	set	0
2677                     ; 448 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2679  05f2 9e            	ld	a,xh
2680  05f3 5f            	clrw	x
2681  05f4 97            	ld	xl,a
2682  05f5 7b02          	ld	a,(OFST+2,sp)
2683  05f7 e727          	ld	(_pwm_brightness_buffer+31,x),a
2684                     ; 449 }
2687  05f9 85            	popw	x
2688  05fa 81            	ret
2723                     ; 452 void set_debug(u8 brightness)
2723                     ; 453 {
2724                     	switch	.text
2725  05fb               _set_debug:
2729                     ; 454 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2731  05fb b726          	ld	_pwm_brightness_buffer+30,a
2732                     ; 455 }
2735  05fd 81            	ret
2758                     ; 457 void set_matrix_high_z()
2758                     ; 458 {
2759                     	switch	.text
2760  05fe               _set_matrix_high_z:
2764                     ; 459 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2766  05fe c6500d        	ld	a,20493
2767  0601 a407          	and	a,#7
2768  0603 c7500d        	ld	20493,a
2769                     ; 460 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2771  0606 72155012      	bres	20498,#2
2772                     ; 461 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2774  060a 72175003      	bres	20483,#3
2775                     ; 462 }
2778  060e 81            	ret
2812                     ; 464 u8 get_eeprom_byte(u16 eeprom_address)
2812                     ; 465 {
2813                     	switch	.text
2814  060f               _get_eeprom_byte:
2818                     ; 466 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2820  060f d64000        	ld	a,(16384,x)
2823  0612 81            	ret
2960                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2961                     	xdef	_temp3_delete_me
2962                     	xdef	_temp_delete_me
2963                     	switch	.ubsct
2964  0000               _button_pressed_event:
2965  0000 00000000      	ds.b	4
2966                     	xdef	_button_pressed_event
2967  0004               _button_start_ms:
2968  0004 00000000      	ds.b	4
2969                     	xdef	_button_start_ms
2970                     	xdef	_pwm_state
2971                     	xdef	_pwm_visible_index
2972                     	xdef	_pwm_led_count
2973                     	xdef	_pwm_sleep
2974  0008               _pwm_brightness_buffer:
2975  0008 000000000000  	ds.b	32
2976                     	xdef	_pwm_brightness_buffer
2977  0028               _pwm_brightness_index:
2978  0028 000000000000  	ds.b	64
2979                     	xdef	_pwm_brightness_index
2980                     	xdef	_pwm_brightness
2981                     	xdef	_frame_counter
2982                     	xref	_UART1_Cmd
2983                     	xref	_UART1_Init
2984                     	xref	_UART1_DeInit
2985                     	xref	_GPIO_ReadInputPin
2986                     	xref	_GPIO_Init
2987                     	xdef	_set_led
2988                     	xdef	_set_mat
2989                     	xdef	_get_eeprom_byte
2990                     	xdef	_get_random
2991                     	xdef	_is_button_down
2992                     	xdef	_clear_button_events
2993                     	xdef	_clear_button_event
2994                     	xdef	_get_button_event
2995                     	xdef	_update_buttons
2996                     	xdef	_is_developer_valid
2997                     	xdef	_set_hue_max
2998                     	xdef	_flush_leds
2999                     	xdef	_set_debug
3000                     	xdef	_set_white
3001                     	xdef	_set_rgb
3002                     	xdef	_set_matrix_high_z
3003                     	xdef	_millis
3004                     	xdef	_setup_main
3005                     	xdef	_is_application_valid
3006                     	xdef	_setup_serial
3007                     	xdef	_hello_world
3008                     	xref.b	c_lreg
3009                     	xref.b	c_x
3010                     	xref.b	c_y
3030                     	xref	c_xymov
3031                     	xref	c_lzmp
3032                     	xref	c_lsub
3033                     	xref	c_rtol
3034                     	xref	c_uitolx
3035                     	xref	c_itolx
3036                     	xref	c_imul
3037                     	xref	c_ladd
3038                     	xref	c_llsh
3039                     	xref	c_ltor
3040                     	xref	c_lgadc
3041                     	end
