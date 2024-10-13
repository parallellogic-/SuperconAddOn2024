   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _atomic_counter:
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
  31  0088               _button_start_ms:
  32  0088 00000000      	dc.l	0
  33  008c               _is_right_button_down:
  34  008c 00            	dc.b	0
  95                     ; 27 void hello_world()
  95                     ; 28 {//basic program that blinks the debug LED ON/OFF
  97                     	switch	.text
  98  0000               _hello_world:
 100  0000 5204          	subw	sp,#4
 101       00000004      OFST:	set	4
 104                     ; 29 	const u8 cycle_speed=8;//larger=faster
 106  0002 a608          	ld	a,#8
 107  0004 6b02          	ld	(OFST-2,sp),a
 109                     ; 30 	const u8 white_speed=5;//smaller=faster
 111  0006 a605          	ld	a,#5
 112  0008 6b01          	ld	(OFST-3,sp),a
 114                     ; 31 	u16 frame=0;
 116  000a 5f            	clrw	x
 117  000b 1f03          	ldw	(OFST-1,sp),x
 119  000d               L73:
 120                     ; 34 		frame++;
 122  000d 1e03          	ldw	x,(OFST-1,sp)
 123  000f 1c0001        	addw	x,#1
 124  0012 1f03          	ldw	(OFST-1,sp),x
 126                     ; 35 		set_hue_max(0,(frame<<cycle_speed));
 128  0014 1e03          	ldw	x,(OFST-1,sp)
 129  0016 7b02          	ld	a,(OFST-2,sp)
 130  0018 4d            	tnz	a
 131  0019 2704          	jreq	L6
 132  001b               L01:
 133  001b 58            	sllw	x
 134  001c 4a            	dec	a
 135  001d 26fc          	jrne	L01
 136  001f               L6:
 137  001f 89            	pushw	x
 138  0020 4f            	clr	a
 139  0021 cd05ab        	call	_set_hue_max
 141  0024 85            	popw	x
 142                     ; 36 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 144  0025 1e03          	ldw	x,(OFST-1,sp)
 145  0027 7b02          	ld	a,(OFST-2,sp)
 146  0029 4d            	tnz	a
 147  002a 2704          	jreq	L21
 148  002c               L41:
 149  002c 58            	sllw	x
 150  002d 4a            	dec	a
 151  002e 26fc          	jrne	L41
 152  0030               L21:
 153  0030 1c2aab        	addw	x,#10923
 154  0033 89            	pushw	x
 155  0034 a601          	ld	a,#1
 156  0036 cd05ab        	call	_set_hue_max
 158  0039 85            	popw	x
 159                     ; 37 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 161  003a 1e03          	ldw	x,(OFST-1,sp)
 162  003c 7b02          	ld	a,(OFST-2,sp)
 163  003e 4d            	tnz	a
 164  003f 2704          	jreq	L61
 165  0041               L02:
 166  0041 58            	sllw	x
 167  0042 4a            	dec	a
 168  0043 26fc          	jrne	L02
 169  0045               L61:
 170  0045 1c5556        	addw	x,#21846
 171  0048 89            	pushw	x
 172  0049 a602          	ld	a,#2
 173  004b cd05ab        	call	_set_hue_max
 175  004e 85            	popw	x
 176                     ; 38 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 178  004f 1e03          	ldw	x,(OFST-1,sp)
 179  0051 7b02          	ld	a,(OFST-2,sp)
 180  0053 4d            	tnz	a
 181  0054 2704          	jreq	L22
 182  0056               L42:
 183  0056 58            	sllw	x
 184  0057 4a            	dec	a
 185  0058 26fc          	jrne	L42
 186  005a               L22:
 187  005a 1c8000        	addw	x,#32768
 188  005d 89            	pushw	x
 189  005e a603          	ld	a,#3
 190  0060 cd05ab        	call	_set_hue_max
 192  0063 85            	popw	x
 193                     ; 39 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 195  0064 1e03          	ldw	x,(OFST-1,sp)
 196  0066 7b02          	ld	a,(OFST-2,sp)
 197  0068 4d            	tnz	a
 198  0069 2704          	jreq	L62
 199  006b               L03:
 200  006b 58            	sllw	x
 201  006c 4a            	dec	a
 202  006d 26fc          	jrne	L03
 203  006f               L62:
 204  006f 1caaab        	addw	x,#43691
 205  0072 89            	pushw	x
 206  0073 a604          	ld	a,#4
 207  0075 cd05ab        	call	_set_hue_max
 209  0078 85            	popw	x
 210                     ; 40 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 212  0079 1e03          	ldw	x,(OFST-1,sp)
 213  007b 7b02          	ld	a,(OFST-2,sp)
 214  007d 4d            	tnz	a
 215  007e 2704          	jreq	L23
 216  0080               L43:
 217  0080 58            	sllw	x
 218  0081 4a            	dec	a
 219  0082 26fc          	jrne	L43
 220  0084               L23:
 221  0084 1cd554        	addw	x,#54612
 222  0087 89            	pushw	x
 223  0088 a605          	ld	a,#5
 224  008a cd05ab        	call	_set_hue_max
 226  008d 85            	popw	x
 227                     ; 43 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
 229  008e 1e03          	ldw	x,(OFST-1,sp)
 230  0090 7b01          	ld	a,(OFST-3,sp)
 231  0092 4d            	tnz	a
 232  0093 2704          	jreq	L04
 233  0095               L24:
 234  0095 54            	srlw	x
 235  0096 4a            	dec	a
 236  0097 26fc          	jrne	L24
 237  0099               L04:
 238  0099 01            	rrwa	x,a
 239  009a a501          	bcp	a,#1
 240  009c 2712          	jreq	L63
 241  009e a608          	ld	a,#8
 242  00a0 1001          	sub	a,(OFST-3,sp)
 243  00a2 5f            	clrw	x
 244  00a3 97            	ld	xl,a
 245  00a4 7b04          	ld	a,(OFST+0,sp)
 246  00a6 5d            	tnzw	x
 247  00a7 2704          	jreq	L44
 248  00a9               L64:
 249  00a9 48            	sll	a
 250  00aa 5a            	decw	x
 251  00ab 26fc          	jrne	L64
 252  00ad               L44:
 253  00ad 43            	cpl	a
 254  00ae 200f          	jra	L05
 255  00b0               L63:
 256  00b0 a608          	ld	a,#8
 257  00b2 1001          	sub	a,(OFST-3,sp)
 258  00b4 5f            	clrw	x
 259  00b5 97            	ld	xl,a
 260  00b6 7b04          	ld	a,(OFST+0,sp)
 261  00b8 5d            	tnzw	x
 262  00b9 2704          	jreq	L25
 263  00bb               L45:
 264  00bb 48            	sll	a
 265  00bc 5a            	decw	x
 266  00bd 26fc          	jrne	L45
 267  00bf               L25:
 268  00bf               L05:
 269  00bf 97            	ld	xl,a
 270  00c0 1603          	ldw	y,(OFST-1,sp)
 271  00c2 7b01          	ld	a,(OFST-3,sp)
 272  00c4 4c            	inc	a
 273  00c5 4d            	tnz	a
 274  00c6 2705          	jreq	L65
 275  00c8               L06:
 276  00c8 9054          	srlw	y
 277  00ca 4a            	dec	a
 278  00cb 26fb          	jrne	L06
 279  00cd               L65:
 280  00cd a60c          	ld	a,#12
 281  00cf 9062          	div	y,a
 282  00d1 905f          	clrw	y
 283  00d3 9097          	ld	yl,a
 284  00d5 909f          	ld	a,yl
 285  00d7 95            	ld	xh,a
 286  00d8 cd066a        	call	_set_white
 288                     ; 44 		flush_leds(7);
 290  00db a607          	ld	a,#7
 291  00dd cd049a        	call	_flush_leds
 294  00e0 ac0d000d      	jpf	L73
 346                     ; 48 u16 get_random(u16 x)
 346                     ; 49 {
 347                     	switch	.text
 348  00e4               _get_random:
 350  00e4 5204          	subw	sp,#4
 351       00000004      OFST:	set	4
 354                     ; 50 	u16 a=1664525;
 356                     ; 51 	u16 c=1013904223;
 358                     ; 52 	return a * x + c;
 360  00e6 90ae660d      	ldw	y,#26125
 361  00ea cd0000        	call	c_imul
 363  00ed 1cf35f        	addw	x,#62303
 366  00f0 5b04          	addw	sp,#4
 367  00f2 81            	ret
 436                     .const:	section	.text
 437  0000               L07:
 438  0000 0000e100      	dc.l	57600
 439                     ; 55 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 439                     ; 56 {
 440                     	switch	.text
 441  00f3               _setup_serial:
 443  00f3 89            	pushw	x
 444       00000000      OFST:	set	0
 447                     ; 57 	if(is_enabled)
 449  00f4 9e            	ld	a,xh
 450  00f5 4d            	tnz	a
 451  00f6 2747          	jreq	L321
 452                     ; 59 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 454  00f8 4bf0          	push	#240
 455  00fa 4b20          	push	#32
 456  00fc ae500f        	ldw	x,#20495
 457  00ff cd0000        	call	_GPIO_Init
 459  0102 85            	popw	x
 460                     ; 60 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 462  0103 4b40          	push	#64
 463  0105 4b40          	push	#64
 464  0107 ae500f        	ldw	x,#20495
 465  010a cd0000        	call	_GPIO_Init
 467  010d 85            	popw	x
 468                     ; 61 		UART1_DeInit();
 470  010e cd0000        	call	_UART1_DeInit
 472                     ; 62 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 474  0111 4b0c          	push	#12
 475  0113 4b80          	push	#128
 476  0115 4b00          	push	#0
 477  0117 4b00          	push	#0
 478  0119 4b00          	push	#0
 479  011b 0d07          	tnz	(OFST+7,sp)
 480  011d 2708          	jreq	L66
 481  011f ae0000        	ldw	x,#L07
 482  0122 cd0000        	call	c_ltor
 484  0125 2006          	jra	L27
 485  0127               L66:
 486  0127 ae2580        	ldw	x,#9600
 487  012a cd0000        	call	c_itolx
 489  012d               L27:
 490  012d be02          	ldw	x,c_lreg+2
 491  012f 89            	pushw	x
 492  0130 be00          	ldw	x,c_lreg
 493  0132 89            	pushw	x
 494  0133 cd0000        	call	_UART1_Init
 496  0136 5b09          	addw	sp,#9
 497                     ; 63 		UART1_Cmd(ENABLE);
 499  0138 a601          	ld	a,#1
 500  013a cd0000        	call	_UART1_Cmd
 503  013d 201d          	jra	L521
 504  013f               L321:
 505                     ; 65 		UART1_Cmd(DISABLE);
 507  013f 4f            	clr	a
 508  0140 cd0000        	call	_UART1_Cmd
 510                     ; 66 		UART1_DeInit();
 512  0143 cd0000        	call	_UART1_DeInit
 514                     ; 67 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 516  0146 4b40          	push	#64
 517  0148 4b20          	push	#32
 518  014a ae500f        	ldw	x,#20495
 519  014d cd0000        	call	_GPIO_Init
 521  0150 85            	popw	x
 522                     ; 68 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 524  0151 4b40          	push	#64
 525  0153 4b40          	push	#64
 526  0155 ae500f        	ldw	x,#20495
 527  0158 cd0000        	call	_GPIO_Init
 529  015b 85            	popw	x
 530  015c               L521:
 531                     ; 70 }
 534  015c 85            	popw	x
 535  015d 81            	ret
 560                     ; 73 bool is_application_valid()
 560                     ; 74 {
 561                     	switch	.text
 562  015e               _is_application_valid:
 566                     ; 75 	return 1;//!is_button_down(2) && !get_button_event(0,1);
 568  015e a601          	ld	a,#1
 571  0160 81            	ret
 595                     ; 79 bool is_developer_valid()
 595                     ; 80 {
 596                     	switch	.text
 597  0161               _is_developer_valid:
 601                     ; 81 	return 0;//is_button_down(2) && !get_button_event(0,1);
 603  0161 4f            	clr	a
 606  0162 81            	ret
 631                     ; 84 void setup_main()
 631                     ; 85 {
 632                     	switch	.text
 633  0163               _setup_main:
 637                     ; 86 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 639  0163 c650c6        	ld	a,20678
 640  0166 a4e7          	and	a,#231
 641  0168 c750c6        	ld	20678,a
 642                     ; 88 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 644  016b 4b40          	push	#64
 645  016d 4b02          	push	#2
 646  016f ae500f        	ldw	x,#20495
 647  0172 cd0000        	call	_GPIO_Init
 649  0175 85            	popw	x
 650                     ; 92 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 652  0176 3505530e      	mov	21262,#5
 653                     ; 93 	TIM2->ARRH= 0;// init auto reload register
 655  017a 725f530f      	clr	21263
 656                     ; 94 	TIM2->ARRL= 255;// init auto reload register
 658  017e 35ff5310      	mov	21264,#255
 659                     ; 96 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 661  0182 c65300        	ld	a,21248
 662  0185 aa05          	or	a,#5
 663  0187 c75300        	ld	21248,a
 664                     ; 98 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 666  018a 35015303      	mov	21251,#1
 667                     ; 99 	enableInterrupts();
 670  018e 9a            rim
 672                     ; 100 }
 676  018f 81            	ret
 700                     ; 102 u32 millis()
 700                     ; 103 {
 701                     	switch	.text
 702  0190               _millis:
 706                     ; 104 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 708  0190 ae0000        	ldw	x,#_atomic_counter
 709  0193 cd0000        	call	c_ltor
 711  0196 a609          	ld	a,#9
 712  0198 cd0000        	call	c_lursh
 716  019b 81            	ret
 765                     	switch	.const
 766  0004               L601:
 767  0004 00000201      	dc.l	513
 768  0008               L011:
 769  0008 00000033      	dc.l	51
 770                     ; 109 void update_buttons()
 770                     ; 110 {
 771                     	switch	.text
 772  019c               _update_buttons:
 774  019c 5205          	subw	sp,#5
 775       00000005      OFST:	set	5
 778                     ; 113 	if(button_start_ms)
 780  019e ae0088        	ldw	x,#_button_start_ms
 781  01a1 cd0000        	call	c_lzmp
 783  01a4 275a          	jreq	L112
 784                     ; 115 		set_debug(255);
 786  01a6 a6ff          	ld	a,#255
 787  01a8 cd0674        	call	_set_debug
 789                     ; 116 		if(!is_button_down(is_right_button_down))
 791  01ab b68c          	ld	a,_is_right_button_down
 792  01ad cd028d        	call	_is_button_down
 794  01b0 4d            	tnz	a
 795  01b1 2676          	jrne	L322
 796                     ; 118 			elapsed_pressed_ms=millis()-button_start_ms;
 798  01b3 addb          	call	_millis
 800  01b5 ae0088        	ldw	x,#_button_start_ms
 801  01b8 cd0000        	call	c_lsub
 803  01bb 96            	ldw	x,sp
 804  01bc 1c0001        	addw	x,#OFST-4
 805  01bf cd0000        	call	c_rtol
 808                     ; 119 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 810  01c2 96            	ldw	x,sp
 811  01c3 1c0001        	addw	x,#OFST-4
 812  01c6 cd0000        	call	c_ltor
 814  01c9 ae0004        	ldw	x,#L601
 815  01cc cd0000        	call	c_lcmp
 817  01cf 250b          	jrult	L512
 820  01d1 b68c          	ld	a,_is_right_button_down
 821  01d3 5f            	clrw	x
 822  01d4 97            	ld	xl,a
 823  01d5 58            	sllw	x
 824  01d6 a601          	ld	a,#1
 825  01d8 e701          	ld	(_button_pressed_event+1,x),a
 827  01da 2018          	jra	L712
 828  01dc               L512:
 829                     ; 120 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 831  01dc 96            	ldw	x,sp
 832  01dd 1c0001        	addw	x,#OFST-4
 833  01e0 cd0000        	call	c_ltor
 835  01e3 ae0008        	ldw	x,#L011
 836  01e6 cd0000        	call	c_lcmp
 838  01e9 2509          	jrult	L712
 841  01eb b68c          	ld	a,_is_right_button_down
 842  01ed 5f            	clrw	x
 843  01ee 97            	ld	xl,a
 844  01ef 58            	sllw	x
 845  01f0 a601          	ld	a,#1
 846  01f2 e700          	ld	(_button_pressed_event,x),a
 847  01f4               L712:
 848                     ; 121 			button_start_ms=0;
 850  01f4 ae0000        	ldw	x,#0
 851  01f7 bf8a          	ldw	_button_start_ms+2,x
 852  01f9 ae0000        	ldw	x,#0
 853  01fc bf88          	ldw	_button_start_ms,x
 854  01fe 2029          	jra	L322
 855  0200               L112:
 856                     ; 124 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 858  0200 0f05          	clr	(OFST+0,sp)
 861  0202 2017          	jra	L132
 862  0204               L522:
 863                     ; 126 			if(is_button_down(button_index))
 865  0204 7b05          	ld	a,(OFST+0,sp)
 866  0206 cd028d        	call	_is_button_down
 868  0209 4d            	tnz	a
 869  020a 270d          	jreq	L532
 870                     ; 128 				is_right_button_down=button_index;
 872  020c 7b05          	ld	a,(OFST+0,sp)
 873  020e b78c          	ld	_is_right_button_down,a
 874                     ; 129 				button_start_ms=millis();
 876  0210 cd0190        	call	_millis
 878  0213 ae0088        	ldw	x,#_button_start_ms
 879  0216 cd0000        	call	c_rtol
 881  0219               L532:
 882                     ; 124 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 884  0219 0c05          	inc	(OFST+0,sp)
 886  021b               L132:
 889  021b 7b05          	ld	a,(OFST+0,sp)
 890  021d a102          	cp	a,#2
 891  021f 2408          	jruge	L322
 893  0221 ae0088        	ldw	x,#_button_start_ms
 894  0224 cd0000        	call	c_lzmp
 896  0227 27db          	jreq	L522
 897  0229               L322:
 898                     ; 133 }
 901  0229 5b05          	addw	sp,#5
 902  022b 81            	ret
 976                     ; 138 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 976                     ; 139 {
 977                     	switch	.text
 978  022c               _get_button_event:
 980  022c 89            	pushw	x
 981  022d 89            	pushw	x
 982       00000002      OFST:	set	2
 985                     ; 141 	bool out=0;
 987  022e 0f01          	clr	(OFST-1,sp)
 989                     ; 142 	for(iter=0;iter<BUTTON_COUNT;iter++)
 991  0230 0f02          	clr	(OFST+0,sp)
 993  0232               L772:
 994                     ; 144 		if(button_index==iter || button_index==0xFF)
 996  0232 7b03          	ld	a,(OFST+1,sp)
 997  0234 1102          	cp	a,(OFST+0,sp)
 998  0236 2706          	jreq	L703
1000  0238 7b03          	ld	a,(OFST+1,sp)
1001  023a a1ff          	cp	a,#255
1002  023c 2642          	jrne	L503
1003  023e               L703:
1004                     ; 146 			if(is_long==0 || is_long==0xFF)
1006  023e 0d04          	tnz	(OFST+2,sp)
1007  0240 2706          	jreq	L313
1009  0242 7b04          	ld	a,(OFST+2,sp)
1010  0244 a1ff          	cp	a,#255
1011  0246 2616          	jrne	L113
1012  0248               L313:
1013                     ; 148 				out|=button_pressed_event[iter][0];
1015  0248 7b02          	ld	a,(OFST+0,sp)
1016  024a 5f            	clrw	x
1017  024b 97            	ld	xl,a
1018  024c 58            	sllw	x
1019  024d 7b01          	ld	a,(OFST-1,sp)
1020  024f ea00          	or	a,(_button_pressed_event,x)
1021  0251 6b01          	ld	(OFST-1,sp),a
1023                     ; 149 				if(is_clear) button_pressed_event[iter][0]=0;
1025  0253 0d07          	tnz	(OFST+5,sp)
1026  0255 2707          	jreq	L113
1029  0257 7b02          	ld	a,(OFST+0,sp)
1030  0259 5f            	clrw	x
1031  025a 97            	ld	xl,a
1032  025b 58            	sllw	x
1033  025c 6f00          	clr	(_button_pressed_event,x)
1034  025e               L113:
1035                     ; 151 			if(is_long==1 || is_long==0xFF)
1037  025e 7b04          	ld	a,(OFST+2,sp)
1038  0260 a101          	cp	a,#1
1039  0262 2706          	jreq	L123
1041  0264 7b04          	ld	a,(OFST+2,sp)
1042  0266 a1ff          	cp	a,#255
1043  0268 2616          	jrne	L503
1044  026a               L123:
1045                     ; 153 				out|=button_pressed_event[iter][1];
1047  026a 7b02          	ld	a,(OFST+0,sp)
1048  026c 5f            	clrw	x
1049  026d 97            	ld	xl,a
1050  026e 58            	sllw	x
1051  026f 7b01          	ld	a,(OFST-1,sp)
1052  0271 ea01          	or	a,(_button_pressed_event+1,x)
1053  0273 6b01          	ld	(OFST-1,sp),a
1055                     ; 154 				if(is_clear) button_pressed_event[iter][1]=0;
1057  0275 0d07          	tnz	(OFST+5,sp)
1058  0277 2707          	jreq	L503
1061  0279 7b02          	ld	a,(OFST+0,sp)
1062  027b 5f            	clrw	x
1063  027c 97            	ld	xl,a
1064  027d 58            	sllw	x
1065  027e 6f01          	clr	(_button_pressed_event+1,x)
1066  0280               L503:
1067                     ; 142 	for(iter=0;iter<BUTTON_COUNT;iter++)
1069  0280 0c02          	inc	(OFST+0,sp)
1073  0282 7b02          	ld	a,(OFST+0,sp)
1074  0284 a102          	cp	a,#2
1075  0286 25aa          	jrult	L772
1076                     ; 158 	return out;
1078  0288 7b01          	ld	a,(OFST-1,sp)
1081  028a 5b04          	addw	sp,#4
1082  028c 81            	ret
1118                     ; 162 bool is_button_down(u8 index)
1118                     ; 163 {
1119                     	switch	.text
1120  028d               _is_button_down:
1124                     ; 164 	switch(index)
1127                     ; 170 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1128  028d 4d            	tnz	a
1129  028e 2708          	jreq	L523
1130  0290 4a            	dec	a
1131  0291 2718          	jreq	L723
1132  0293 4a            	dec	a
1133  0294 2728          	jreq	L133
1134  0296 2039          	jra	L353
1135  0298               L523:
1136                     ; 168 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); }//left button
1138  0298 4b20          	push	#32
1139  029a ae500f        	ldw	x,#20495
1140  029d cd0000        	call	_GPIO_ReadInputPin
1142  02a0 5b01          	addw	sp,#1
1143  02a2 4d            	tnz	a
1144  02a3 2604          	jrne	L611
1145  02a5 a601          	ld	a,#1
1146  02a7 2001          	jra	L021
1147  02a9               L611:
1148  02a9 4f            	clr	a
1149  02aa               L021:
1152  02aa 81            	ret
1153  02ab               L723:
1154                     ; 169 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); }//right button
1156  02ab 4b40          	push	#64
1157  02ad ae500f        	ldw	x,#20495
1158  02b0 cd0000        	call	_GPIO_ReadInputPin
1160  02b3 5b01          	addw	sp,#1
1161  02b5 4d            	tnz	a
1162  02b6 2604          	jrne	L221
1163  02b8 a601          	ld	a,#1
1164  02ba 2001          	jra	L421
1165  02bc               L221:
1166  02bc 4f            	clr	a
1167  02bd               L421:
1170  02bd 81            	ret
1171  02be               L133:
1172                     ; 170 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1174  02be 4b02          	push	#2
1175  02c0 ae500f        	ldw	x,#20495
1176  02c3 cd0000        	call	_GPIO_ReadInputPin
1178  02c6 5b01          	addw	sp,#1
1179  02c8 4d            	tnz	a
1180  02c9 2604          	jrne	L621
1181  02cb a601          	ld	a,#1
1182  02cd 2001          	jra	L031
1183  02cf               L621:
1184  02cf 4f            	clr	a
1185  02d0               L031:
1188  02d0 81            	ret
1189  02d1               L353:
1190                     ; 172 	return 0;
1192  02d1 4f            	clr	a
1195  02d2 81            	ret
1249                     ; 176 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1251                     	switch	.text
1252  02d3               f_TIM2_UPD_OVF_IRQHandler:
1254  02d3 8a            	push	cc
1255  02d4 84            	pop	a
1256  02d5 a4bf          	and	a,#191
1257  02d7 88            	push	a
1258  02d8 86            	pop	cc
1259       00000005      OFST:	set	5
1260  02d9 3b0002        	push	c_x+2
1261  02dc be00          	ldw	x,c_x
1262  02de 89            	pushw	x
1263  02df 3b0002        	push	c_y+2
1264  02e2 be00          	ldw	x,c_y
1265  02e4 89            	pushw	x
1266  02e5 be02          	ldw	x,c_lreg+2
1267  02e7 89            	pushw	x
1268  02e8 be00          	ldw	x,c_lreg
1269  02ea 89            	pushw	x
1270  02eb 5205          	subw	sp,#5
1273                     ; 177 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1275  02ed b687          	ld	a,_pwm_state
1276  02ef a401          	and	a,#1
1277  02f1 6b05          	ld	(OFST+0,sp),a
1279                     ; 178 	u16 sleep_counts=1;
1281  02f3 ae0001        	ldw	x,#1
1282  02f6 1f03          	ldw	(OFST-2,sp),x
1284                     ; 180 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1286  02f8 c6500c        	ld	a,20492
1287  02fb a407          	and	a,#7
1288  02fd c7500c        	ld	20492,a
1289                     ; 181 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1291  0300 72155011      	bres	20497,#2
1292                     ; 182 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1294  0304 72175002      	bres	20482,#3
1295                     ; 183 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1297  0308 c6500d        	ld	a,20493
1298  030b a407          	and	a,#7
1299  030d c7500d        	ld	20493,a
1300                     ; 184 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1302  0310 72155012      	bres	20498,#2
1303                     ; 185 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1305  0314 72175003      	bres	20483,#3
1306                     ; 187 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1308  0318 72195011      	bres	20497,#4
1309                     ; 188 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1311  031c 72195012      	bres	20498,#4
1312                     ; 190   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1314  0320 72115300      	bres	21248,#0
1315                     ; 191 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1317  0324 7b05          	ld	a,(OFST+0,sp)
1318  0326 5f            	clrw	x
1319  0327 97            	ld	xl,a
1320  0328 e684          	ld	a,(_pwm_led_count,x)
1321  032a b186          	cp	a,_pwm_visible_index
1322  032c 2609          	jrne	L773
1323                     ; 193 		sleep_counts=pwm_sleep[buffer_index];
1325  032e 7b05          	ld	a,(OFST+0,sp)
1326  0330 5f            	clrw	x
1327  0331 97            	ld	xl,a
1328  0332 58            	sllw	x
1329  0333 ee80          	ldw	x,(_pwm_sleep,x)
1330  0335 1f03          	ldw	(OFST-2,sp),x
1332  0337               L773:
1333                     ; 195 	if(pwm_visible_index>pwm_led_count[buffer_index])
1335  0337 7b05          	ld	a,(OFST+0,sp)
1336  0339 5f            	clrw	x
1337  033a 97            	ld	xl,a
1338  033b e684          	ld	a,(_pwm_led_count,x)
1339  033d b186          	cp	a,_pwm_visible_index
1340  033f 2417          	jruge	L104
1341                     ; 197 		pwm_visible_index=0;//formally start new frame
1343  0341 3f86          	clr	_pwm_visible_index
1344                     ; 198 		update_buttons();
1346  0343 cd019c        	call	_update_buttons
1348                     ; 199 		if(pwm_state&0x02)
1350  0346 b687          	ld	a,_pwm_state
1351  0348 a502          	bcp	a,#2
1352  034a 270c          	jreq	L104
1353                     ; 201 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1355  034c b687          	ld	a,_pwm_state
1356  034e a803          	xor	a,#3
1357  0350 b787          	ld	_pwm_state,a
1358                     ; 202 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1360  0352 b687          	ld	a,_pwm_state
1361  0354 a401          	and	a,#1
1362  0356 6b05          	ld	(OFST+0,sp),a
1364  0358               L104:
1365                     ; 205 	if(pwm_visible_index<pwm_led_count[buffer_index])
1367  0358 7b05          	ld	a,(OFST+0,sp)
1368  035a 5f            	clrw	x
1369  035b 97            	ld	xl,a
1370  035c e684          	ld	a,(_pwm_led_count,x)
1371  035e b186          	cp	a,_pwm_visible_index
1372  0360 2324          	jrule	L504
1373                     ; 207 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1375  0362 7b05          	ld	a,(OFST+0,sp)
1376  0364 5f            	clrw	x
1377  0365 97            	ld	xl,a
1378  0366 58            	sllw	x
1379  0367 1f01          	ldw	(OFST-4,sp),x
1381  0369 b686          	ld	a,_pwm_visible_index
1382  036b 97            	ld	xl,a
1383  036c a604          	ld	a,#4
1384  036e 42            	mul	x,a
1385  036f 72fb01        	addw	x,(OFST-4,sp)
1386  0372 ee04          	ldw	x,(_pwm_brightness,x)
1387  0374 1f03          	ldw	(OFST-2,sp),x
1389                     ; 208 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1391  0376 b686          	ld	a,_pwm_visible_index
1392  0378 5f            	clrw	x
1393  0379 97            	ld	xl,a
1394  037a 58            	sllw	x
1395  037b 01            	rrwa	x,a
1396  037c 1b05          	add	a,(OFST+0,sp)
1397  037e 2401          	jrnc	L431
1398  0380 5c            	incw	x
1399  0381               L431:
1400  0381 02            	rlwa	x,a
1401  0382 e623          	ld	a,(_pwm_brightness_index,x)
1402  0384 ad3e          	call	_set_led_on
1404  0386               L504:
1405                     ; 210 	pwm_visible_index++;
1407  0386 3c86          	inc	_pwm_visible_index
1408                     ; 211 	atomic_counter+=sleep_counts;
1410  0388 1e03          	ldw	x,(OFST-2,sp)
1411  038a cd0000        	call	c_uitolx
1413  038d ae0000        	ldw	x,#_atomic_counter
1414  0390 cd0000        	call	c_lgadd
1416                     ; 213   TIM2->CNTRH = 0;// Set the high byte of the counter
1418  0393 725f530c      	clr	21260
1419                     ; 214   TIM2->CNTRL = 0;// Set the low byte of the counter
1421  0397 725f530d      	clr	21261
1422                     ; 215 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1424  039b 7b03          	ld	a,(OFST-2,sp)
1425  039d c7530f        	ld	21263,a
1426                     ; 216 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1428  03a0 7b04          	ld	a,(OFST-1,sp)
1429  03a2 a4ff          	and	a,#255
1430  03a4 c75310        	ld	21264,a
1431                     ; 218 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1433  03a7 72115304      	bres	21252,#0
1434                     ; 219   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1436  03ab 72105300      	bset	21248,#0
1437                     ; 220 }
1440  03af 5b05          	addw	sp,#5
1441  03b1 85            	popw	x
1442  03b2 bf00          	ldw	c_lreg,x
1443  03b4 85            	popw	x
1444  03b5 bf02          	ldw	c_lreg+2,x
1445  03b7 85            	popw	x
1446  03b8 bf00          	ldw	c_y,x
1447  03ba 320002        	pop	c_y+2
1448  03bd 85            	popw	x
1449  03be bf00          	ldw	c_x,x
1450  03c0 320002        	pop	c_x+2
1451  03c3 80            	iret
1453                     	switch	.const
1454  000c               L704_led_lookup:
1455  000c 04            	dc.b	4
1456  000d 03            	dc.b	3
1457  000e 03            	dc.b	3
1458  000f 04            	dc.b	4
1459  0010 00            	dc.b	0
1460  0011 05            	dc.b	5
1461  0012 00            	dc.b	0
1462  0013 04            	dc.b	4
1463  0014 00            	dc.b	0
1464  0015 03            	dc.b	3
1465  0016 00            	dc.b	0
1466  0017 01            	dc.b	1
1467  0018 05            	dc.b	5
1468  0019 03            	dc.b	3
1469  001a 03            	dc.b	3
1470  001b 05            	dc.b	5
1471  001c 00            	dc.b	0
1472  001d 06            	dc.b	6
1473  001e 01            	dc.b	1
1474  001f 04            	dc.b	4
1475  0020 01            	dc.b	1
1476  0021 03            	dc.b	3
1477  0022 00            	dc.b	0
1478  0023 02            	dc.b	2
1479  0024 06            	dc.b	6
1480  0025 03            	dc.b	3
1481  0026 03            	dc.b	3
1482  0027 06            	dc.b	6
1483  0028 01            	dc.b	1
1484  0029 06            	dc.b	6
1485  002a 02            	dc.b	2
1486  002b 04            	dc.b	4
1487  002c 02            	dc.b	2
1488  002d 03            	dc.b	3
1489  002e 01            	dc.b	1
1490  002f 02            	dc.b	2
1491  0030 07            	dc.b	7
1492  0031 07            	dc.b	7
1493  0032 03            	dc.b	3
1494  0033 00            	dc.b	0
1495  0034 03            	dc.b	3
1496  0035 01            	dc.b	1
1497  0036 03            	dc.b	3
1498  0037 02            	dc.b	2
1499  0038 04            	dc.b	4
1500  0039 00            	dc.b	0
1501  003a 01            	dc.b	1
1502  003b 05            	dc.b	5
1503  003c 02            	dc.b	2
1504  003d 05            	dc.b	5
1505  003e 04            	dc.b	4
1506  003f 01            	dc.b	1
1507  0040 04            	dc.b	4
1508  0041 02            	dc.b	2
1509  0042 02            	dc.b	2
1510  0043 06            	dc.b	6
1511  0044 04            	dc.b	4
1512  0045 06            	dc.b	6
1513  0046 04            	dc.b	4
1514  0047 05            	dc.b	5
1515  0048 05            	dc.b	5
1516  0049 06            	dc.b	6
1560                     ; 223 void set_led_on(u8 led_index)
1560                     ; 224 {
1562                     	switch	.text
1563  03c4               _set_led_on:
1565  03c4 88            	push	a
1566  03c5 5240          	subw	sp,#64
1567       00000040      OFST:	set	64
1570                     ; 261 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1570                     ; 262 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1570                     ; 263 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1570                     ; 264 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1570                     ; 265 		{7,7},//debug; GND is tied low, no charlieplexing involved
1570                     ; 266 		{3,0},//LED6
1570                     ; 267 		{3,1},//LED4
1570                     ; 268 		{3,2},//LED5
1570                     ; 269 		{4,0},//LED14
1570                     ; 270 		{1,5},//LED8
1570                     ; 271 		{2,5},//LED9
1570                     ; 272 		{4,1},//LED10
1570                     ; 273 		{4,2},//LED16
1570                     ; 274 		{2,6},//LED17
1570                     ; 275 		{4,6},//LED12
1570                     ; 276 		{4,5},//LED13
1570                     ; 277 		{5,6} //LED11
1570                     ; 278 	};
1572  03c7 96            	ldw	x,sp
1573  03c8 1c0003        	addw	x,#OFST-61
1574  03cb 90ae000c      	ldw	y,#L704_led_lookup
1575  03cf a63e          	ld	a,#62
1576  03d1 cd0000        	call	c_xymov
1578                     ; 279 	set_mat(led_lookup[led_index][0],1);
1580  03d4 96            	ldw	x,sp
1581  03d5 1c0003        	addw	x,#OFST-61
1582  03d8 1f01          	ldw	(OFST-63,sp),x
1584  03da 7b41          	ld	a,(OFST+1,sp)
1585  03dc 5f            	clrw	x
1586  03dd 97            	ld	xl,a
1587  03de 58            	sllw	x
1588  03df 72fb01        	addw	x,(OFST-63,sp)
1589  03e2 f6            	ld	a,(x)
1590  03e3 ae0001        	ldw	x,#1
1591  03e6 95            	ld	xh,a
1592  03e7 ad1c          	call	_set_mat
1594                     ; 281 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1596  03e9 7b41          	ld	a,(OFST+1,sp)
1597  03eb a112          	cp	a,#18
1598  03ed 2713          	jreq	L334
1601  03ef 96            	ldw	x,sp
1602  03f0 1c0004        	addw	x,#OFST-60
1603  03f3 1f01          	ldw	(OFST-63,sp),x
1605  03f5 7b41          	ld	a,(OFST+1,sp)
1606  03f7 5f            	clrw	x
1607  03f8 97            	ld	xl,a
1608  03f9 58            	sllw	x
1609  03fa 72fb01        	addw	x,(OFST-63,sp)
1610  03fd f6            	ld	a,(x)
1611  03fe 5f            	clrw	x
1612  03ff 95            	ld	xh,a
1613  0400 ad03          	call	_set_mat
1615  0402               L334:
1616                     ; 283 }
1619  0402 5b41          	addw	sp,#65
1620  0404 81            	ret
1821                     ; 288 void set_mat(u8 mat_index,bool is_high)
1821                     ; 289 {
1822                     	switch	.text
1823  0405               _set_mat:
1825  0405 89            	pushw	x
1826  0406 5203          	subw	sp,#3
1827       00000003      OFST:	set	3
1830                     ; 327 	switch(mat_index)//DEBUG_BROKEN
1832  0408 9e            	ld	a,xh
1834                     ; 336 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
1835  0409 4d            	tnz	a
1836  040a 271d          	jreq	L534
1837  040c 4a            	dec	a
1838  040d 2725          	jreq	L734
1839  040f 4a            	dec	a
1840  0410 272d          	jreq	L144
1841  0412 4a            	dec	a
1842  0413 2735          	jreq	L344
1843  0415 4a            	dec	a
1844  0416 273d          	jreq	L544
1845  0418 4a            	dec	a
1846  0419 2745          	jreq	L744
1847  041b 4a            	dec	a
1848  041c 274d          	jreq	L154
1849  041e               L354:
1852  041e ae5000        	ldw	x,#20480
1853  0421 1f01          	ldw	(OFST-2,sp),x
1857  0423 a608          	ld	a,#8
1858  0425 6b03          	ld	(OFST+0,sp),a
1862  0427 204b          	jra	L575
1863  0429               L534:
1864                     ; 329 		case 0:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_4; break;
1866  0429 ae500f        	ldw	x,#20495
1867  042c 1f01          	ldw	(OFST-2,sp),x
1871  042e a610          	ld	a,#16
1872  0430 6b03          	ld	(OFST+0,sp),a
1876  0432 2040          	jra	L575
1877  0434               L734:
1878                     ; 330 		case 1:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
1880  0434 ae500f        	ldw	x,#20495
1881  0437 1f01          	ldw	(OFST-2,sp),x
1885  0439 a604          	ld	a,#4
1886  043b 6b03          	ld	(OFST+0,sp),a
1890  043d 2035          	jra	L575
1891  043f               L144:
1892                     ; 331 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
1894  043f ae500a        	ldw	x,#20490
1895  0442 1f01          	ldw	(OFST-2,sp),x
1899  0444 a680          	ld	a,#128
1900  0446 6b03          	ld	(OFST+0,sp),a
1904  0448 202a          	jra	L575
1905  044a               L344:
1906                     ; 332 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
1908  044a ae500a        	ldw	x,#20490
1909  044d 1f01          	ldw	(OFST-2,sp),x
1913  044f a640          	ld	a,#64
1914  0451 6b03          	ld	(OFST+0,sp),a
1918  0453 201f          	jra	L575
1919  0455               L544:
1920                     ; 333 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
1922  0455 ae500a        	ldw	x,#20490
1923  0458 1f01          	ldw	(OFST-2,sp),x
1927  045a a620          	ld	a,#32
1928  045c 6b03          	ld	(OFST+0,sp),a
1932  045e 2014          	jra	L575
1933  0460               L744:
1934                     ; 334 		case 5:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
1936  0460 ae500a        	ldw	x,#20490
1937  0463 1f01          	ldw	(OFST-2,sp),x
1941  0465 a610          	ld	a,#16
1942  0467 6b03          	ld	(OFST+0,sp),a
1946  0469 2009          	jra	L575
1947  046b               L154:
1948                     ; 335 		case 6:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
1950  046b ae500a        	ldw	x,#20490
1951  046e 1f01          	ldw	(OFST-2,sp),x
1955  0470 a608          	ld	a,#8
1956  0472 6b03          	ld	(OFST+0,sp),a
1960  0474               L575:
1961                     ; 378 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1963  0474 0d05          	tnz	(OFST+2,sp)
1964  0476 2708          	jreq	L775
1967  0478 1e01          	ldw	x,(OFST-2,sp)
1968  047a f6            	ld	a,(x)
1969  047b 1a03          	or	a,(OFST+0,sp)
1970  047d f7            	ld	(x),a
1972  047e 2007          	jra	L106
1973  0480               L775:
1974                     ; 379 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1976  0480 1e01          	ldw	x,(OFST-2,sp)
1977  0482 7b03          	ld	a,(OFST+0,sp)
1978  0484 43            	cpl	a
1979  0485 f4            	and	a,(x)
1980  0486 f7            	ld	(x),a
1981  0487               L106:
1982                     ; 380 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
1984  0487 1e01          	ldw	x,(OFST-2,sp)
1985  0489 e602          	ld	a,(2,x)
1986  048b 1a03          	or	a,(OFST+0,sp)
1987  048d e702          	ld	(2,x),a
1988                     ; 381 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1990  048f 1e01          	ldw	x,(OFST-2,sp)
1991  0491 e603          	ld	a,(3,x)
1992  0493 1a03          	or	a,(OFST+0,sp)
1993  0495 e703          	ld	(3,x),a
1994                     ; 382 }
1997  0497 5b05          	addw	sp,#5
1998  0499 81            	ret
2074                     ; 385 void flush_leds(u8 led_count)
2074                     ; 386 {
2075                     	switch	.text
2076  049a               _flush_leds:
2078  049a 88            	push	a
2079  049b 5207          	subw	sp,#7
2080       00000007      OFST:	set	7
2083                     ; 387 	u8 led_read_index=0,led_write_index=0;
2087  049d 0f05          	clr	(OFST-2,sp)
2090  049f               L546:
2091                     ; 390 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2093  049f b687          	ld	a,_pwm_state
2094  04a1 a502          	bcp	a,#2
2095  04a3 26fa          	jrne	L546
2096                     ; 391 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2098  04a5 b687          	ld	a,_pwm_state
2099  04a7 a401          	and	a,#1
2100  04a9 a801          	xor	a,#1
2101  04ab 6b07          	ld	(OFST+0,sp),a
2103                     ; 393 	if(led_count==0) led_count=1;//min value
2105  04ad 0d08          	tnz	(OFST+1,sp)
2106  04af 2604          	jrne	L156
2109  04b1 a601          	ld	a,#1
2110  04b3 6b08          	ld	(OFST+1,sp),a
2111  04b5               L156:
2112                     ; 394 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2114  04b5 7b08          	ld	a,(OFST+1,sp)
2115  04b7 5f            	clrw	x
2116  04b8 97            	ld	xl,a
2117  04b9 4f            	clr	a
2118  04ba 02            	rlwa	x,a
2119  04bb 58            	sllw	x
2120  04bc 58            	sllw	x
2121  04bd 7b07          	ld	a,(OFST+0,sp)
2122  04bf 905f          	clrw	y
2123  04c1 9097          	ld	yl,a
2124  04c3 9058          	sllw	y
2125  04c5 90ef80        	ldw	(_pwm_sleep,y),x
2126                     ; 396 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2128  04c8 0f06          	clr	(OFST-1,sp)
2130  04ca               L356:
2131                     ; 398 		read_brightness=pwm_brightness_buffer[led_read_index];
2133  04ca 7b06          	ld	a,(OFST-1,sp)
2134  04cc 5f            	clrw	x
2135  04cd 97            	ld	xl,a
2136  04ce e604          	ld	a,(_pwm_brightness_buffer,x)
2137  04d0 5f            	clrw	x
2138  04d1 97            	ld	xl,a
2139  04d2 1f03          	ldw	(OFST-4,sp),x
2141                     ; 399 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2143  04d4 1e03          	ldw	x,(OFST-4,sp)
2144  04d6 2767          	jreq	L166
2145                     ; 401 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2147  04d8 7b05          	ld	a,(OFST-2,sp)
2148  04da 5f            	clrw	x
2149  04db 97            	ld	xl,a
2150  04dc 58            	sllw	x
2151  04dd 01            	rrwa	x,a
2152  04de 1b07          	add	a,(OFST+0,sp)
2153  04e0 2401          	jrnc	L441
2154  04e2 5c            	incw	x
2155  04e3               L441:
2156  04e3 02            	rlwa	x,a
2157  04e4 7b06          	ld	a,(OFST-1,sp)
2158  04e6 e723          	ld	(_pwm_brightness_index,x),a
2159                     ; 402 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2161  04e8 1e03          	ldw	x,(OFST-4,sp)
2162  04ea 1603          	ldw	y,(OFST-4,sp)
2163  04ec cd0000        	call	c_imul
2165  04ef a606          	ld	a,#6
2166  04f1               L641:
2167  04f1 54            	srlw	x
2168  04f2 4a            	dec	a
2169  04f3 26fc          	jrne	L641
2170  04f5 5c            	incw	x
2171  04f6 7b07          	ld	a,(OFST+0,sp)
2172  04f8 905f          	clrw	y
2173  04fa 9097          	ld	yl,a
2174  04fc 9058          	sllw	y
2175  04fe 1701          	ldw	(OFST-6,sp),y
2177  0500 7b05          	ld	a,(OFST-2,sp)
2178  0502 905f          	clrw	y
2179  0504 9097          	ld	yl,a
2180  0506 9058          	sllw	y
2181  0508 9058          	sllw	y
2182  050a 72f901        	addw	y,(OFST-6,sp)
2183  050d 90ef04        	ldw	(_pwm_brightness,y),x
2184                     ; 403 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2186  0510 7b07          	ld	a,(OFST+0,sp)
2187  0512 5f            	clrw	x
2188  0513 97            	ld	xl,a
2189  0514 58            	sllw	x
2190  0515 7b07          	ld	a,(OFST+0,sp)
2191  0517 905f          	clrw	y
2192  0519 9097          	ld	yl,a
2193  051b 9058          	sllw	y
2194  051d 1701          	ldw	(OFST-6,sp),y
2196  051f 7b05          	ld	a,(OFST-2,sp)
2197  0521 905f          	clrw	y
2198  0523 9097          	ld	yl,a
2199  0525 9058          	sllw	y
2200  0527 9058          	sllw	y
2201  0529 72f901        	addw	y,(OFST-6,sp)
2202  052c 90ee04        	ldw	y,(_pwm_brightness,y)
2203  052f 9001          	rrwa	y,a
2204  0531 e081          	sub	a,(_pwm_sleep+1,x)
2205  0533 9001          	rrwa	y,a
2206  0535 e280          	sbc	a,(_pwm_sleep,x)
2207  0537 9001          	rrwa	y,a
2208  0539 9050          	negw	y
2209  053b ef80          	ldw	(_pwm_sleep,x),y
2210                     ; 404 			led_write_index++;
2212  053d 0c05          	inc	(OFST-2,sp)
2214  053f               L166:
2215                     ; 406 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2217  053f 7b06          	ld	a,(OFST-1,sp)
2218  0541 5f            	clrw	x
2219  0542 97            	ld	xl,a
2220  0543 6f04          	clr	(_pwm_brightness_buffer,x)
2221                     ; 396 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2223  0545 0c06          	inc	(OFST-1,sp)
2227  0547 7b06          	ld	a,(OFST-1,sp)
2228  0549 a11f          	cp	a,#31
2229  054b 2403cc04ca    	jrult	L356
2230                     ; 408 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2232  0550 7b07          	ld	a,(OFST+0,sp)
2233  0552 5f            	clrw	x
2234  0553 97            	ld	xl,a
2235  0554 58            	sllw	x
2236  0555 9093          	ldw	y,x
2237  0557 90ee80        	ldw	y,(_pwm_sleep,y)
2238  055a 90a37c01      	cpw	y,#31745
2239  055e 240b          	jruge	L566
2241  0560 7b07          	ld	a,(OFST+0,sp)
2242  0562 5f            	clrw	x
2243  0563 97            	ld	xl,a
2244  0564 58            	sllw	x
2245  0565 e681          	ld	a,(_pwm_sleep+1,x)
2246  0567 ea80          	or	a,(_pwm_sleep,x)
2247  0569 260b          	jrne	L366
2248  056b               L566:
2251  056b 7b07          	ld	a,(OFST+0,sp)
2252  056d 5f            	clrw	x
2253  056e 97            	ld	xl,a
2254  056f 58            	sllw	x
2255  0570 90ae0001      	ldw	y,#1
2256  0574 ef80          	ldw	(_pwm_sleep,x),y
2257  0576               L366:
2258                     ; 409 	if(led_write_index==0)
2260  0576 0d05          	tnz	(OFST-2,sp)
2261  0578 2622          	jrne	L766
2262                     ; 411 		led_write_index=1;
2264  057a a601          	ld	a,#1
2265  057c 6b05          	ld	(OFST-2,sp),a
2267                     ; 412 		pwm_sleep[buffer_index]=6<<10;
2269  057e 7b07          	ld	a,(OFST+0,sp)
2270  0580 5f            	clrw	x
2271  0581 97            	ld	xl,a
2272  0582 58            	sllw	x
2273  0583 90ae1800      	ldw	y,#6144
2274  0587 ef80          	ldw	(_pwm_sleep,x),y
2275                     ; 413 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2277  0589 7b07          	ld	a,(OFST+0,sp)
2278  058b 5f            	clrw	x
2279  058c 97            	ld	xl,a
2280  058d a612          	ld	a,#18
2281  058f e723          	ld	(_pwm_brightness_index,x),a
2282                     ; 414 		pwm_brightness[0][buffer_index]=1;
2284  0591 7b07          	ld	a,(OFST+0,sp)
2285  0593 5f            	clrw	x
2286  0594 97            	ld	xl,a
2287  0595 58            	sllw	x
2288  0596 90ae0001      	ldw	y,#1
2289  059a ef04          	ldw	(_pwm_brightness,x),y
2290  059c               L766:
2291                     ; 416 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2293  059c 7b07          	ld	a,(OFST+0,sp)
2294  059e 5f            	clrw	x
2295  059f 97            	ld	xl,a
2296  05a0 7b05          	ld	a,(OFST-2,sp)
2297  05a2 e784          	ld	(_pwm_led_count,x),a
2298                     ; 419 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2300  05a4 72120087      	bset	_pwm_state,#1
2301                     ; 420 }
2304  05a8 5b08          	addw	sp,#8
2305  05aa 81            	ret
2412                     ; 423 void set_hue_max(u8 index,u16 color)
2412                     ; 424 {
2413                     	switch	.text
2414  05ab               _set_hue_max:
2416  05ab 88            	push	a
2417  05ac 5207          	subw	sp,#7
2418       00000007      OFST:	set	7
2421                     ; 427 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2423  05ae a6b4          	ld	a,#180
2424  05b0 6b06          	ld	(OFST-1,sp),a
2426                     ; 428 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2428  05b2 a63d          	ld	a,#61
2429  05b4 6b01          	ld	(OFST-6,sp),a
2431                     ; 429 	u8 red=0,green=0,blue=0;
2433  05b6 0f02          	clr	(OFST-5,sp)
2437  05b8 0f03          	clr	(OFST-4,sp)
2441  05ba 0f04          	clr	(OFST-3,sp)
2443                     ; 430 	u8 residual=0;
2445  05bc 0f07          	clr	(OFST+0,sp)
2447                     ; 432 	for(iter=0;iter<6;iter++)
2449  05be 0f05          	clr	(OFST-2,sp)
2451  05c0               L367:
2452                     ; 434 		if(color<0x2AAB)
2454  05c0 1e0b          	ldw	x,(OFST+4,sp)
2455  05c2 a32aab        	cpw	x,#10923
2456  05c5 240b          	jruge	L177
2457                     ; 436 			residual=color/BRIGHTNESS_STEP;
2459  05c7 1e0b          	ldw	x,(OFST+4,sp)
2460  05c9 7b01          	ld	a,(OFST-6,sp)
2461  05cb 62            	div	x,a
2462  05cc 01            	rrwa	x,a
2463  05cd 6b07          	ld	(OFST+0,sp),a
2464  05cf 02            	rlwa	x,a
2466                     ; 437 			break;
2468  05d0 200f          	jra	L767
2469  05d2               L177:
2470                     ; 439 		color-=0x2AAB;
2472  05d2 1e0b          	ldw	x,(OFST+4,sp)
2473  05d4 1d2aab        	subw	x,#10923
2474  05d7 1f0b          	ldw	(OFST+4,sp),x
2475                     ; 432 	for(iter=0;iter<6;iter++)
2477  05d9 0c05          	inc	(OFST-2,sp)
2481  05db 7b05          	ld	a,(OFST-2,sp)
2482  05dd a106          	cp	a,#6
2483  05df 25df          	jrult	L367
2484  05e1               L767:
2485                     ; 441 	switch(iter)
2487  05e1 7b05          	ld	a,(OFST-2,sp)
2489                     ; 448 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
2490  05e3 4d            	tnz	a
2491  05e4 2718          	jreq	L176
2492  05e6 4a            	dec	a
2493  05e7 271f          	jreq	L376
2494  05e9 4a            	dec	a
2495  05ea 2728          	jreq	L576
2496  05ec 4a            	dec	a
2497  05ed 272f          	jreq	L776
2498  05ef 4a            	dec	a
2499  05f0 2738          	jreq	L107
2500  05f2               L307:
2503  05f2 7b06          	ld	a,(OFST-1,sp)
2504  05f4 6b02          	ld	(OFST-5,sp),a
2508  05f6 7b06          	ld	a,(OFST-1,sp)
2509  05f8 1007          	sub	a,(OFST+0,sp)
2510  05fa 6b04          	ld	(OFST-3,sp),a
2514  05fc 2034          	jra	L577
2515  05fe               L176:
2516                     ; 443 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
2518  05fe 7b06          	ld	a,(OFST-1,sp)
2519  0600 6b02          	ld	(OFST-5,sp),a
2523  0602 7b07          	ld	a,(OFST+0,sp)
2524  0604 6b03          	ld	(OFST-4,sp),a
2528  0606 202a          	jra	L577
2529  0608               L376:
2530                     ; 444 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
2532  0608 7b06          	ld	a,(OFST-1,sp)
2533  060a 6b03          	ld	(OFST-4,sp),a
2537  060c 7b06          	ld	a,(OFST-1,sp)
2538  060e 1007          	sub	a,(OFST+0,sp)
2539  0610 6b02          	ld	(OFST-5,sp),a
2543  0612 201e          	jra	L577
2544  0614               L576:
2545                     ; 445 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
2547  0614 7b06          	ld	a,(OFST-1,sp)
2548  0616 6b03          	ld	(OFST-4,sp),a
2552  0618 7b07          	ld	a,(OFST+0,sp)
2553  061a 6b04          	ld	(OFST-3,sp),a
2557  061c 2014          	jra	L577
2558  061e               L776:
2559                     ; 446 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
2561  061e 7b06          	ld	a,(OFST-1,sp)
2562  0620 6b04          	ld	(OFST-3,sp),a
2566  0622 7b06          	ld	a,(OFST-1,sp)
2567  0624 1007          	sub	a,(OFST+0,sp)
2568  0626 6b03          	ld	(OFST-4,sp),a
2572  0628 2008          	jra	L577
2573  062a               L107:
2574                     ; 447 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
2576  062a 7b06          	ld	a,(OFST-1,sp)
2577  062c 6b04          	ld	(OFST-3,sp),a
2581  062e 7b07          	ld	a,(OFST+0,sp)
2582  0630 6b02          	ld	(OFST-5,sp),a
2586  0632               L577:
2587                     ; 456 	set_rgb(index,0,red);
2589  0632 7b02          	ld	a,(OFST-5,sp)
2590  0634 88            	push	a
2591  0635 7b09          	ld	a,(OFST+2,sp)
2592  0637 5f            	clrw	x
2593  0638 95            	ld	xh,a
2594  0639 ad1c          	call	_set_rgb
2596  063b 84            	pop	a
2597                     ; 457 	set_rgb(index,1,green);
2599  063c 7b03          	ld	a,(OFST-4,sp)
2600  063e 88            	push	a
2601  063f 7b09          	ld	a,(OFST+2,sp)
2602  0641 ae0001        	ldw	x,#1
2603  0644 95            	ld	xh,a
2604  0645 ad10          	call	_set_rgb
2606  0647 84            	pop	a
2607                     ; 458 	set_rgb(index,2,blue);
2609  0648 7b04          	ld	a,(OFST-3,sp)
2610  064a 88            	push	a
2611  064b 7b09          	ld	a,(OFST+2,sp)
2612  064d ae0002        	ldw	x,#2
2613  0650 95            	ld	xh,a
2614  0651 ad04          	call	_set_rgb
2616  0653 84            	pop	a
2617                     ; 459 }
2620  0654 5b08          	addw	sp,#8
2621  0656 81            	ret
2674                     ; 463 void set_rgb(u8 index,u8 color,u8 brightness)
2674                     ; 464 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
2675                     	switch	.text
2676  0657               _set_rgb:
2678  0657 89            	pushw	x
2679       00000000      OFST:	set	0
2684  0658 9f            	ld	a,xl
2685  0659 97            	ld	xl,a
2686  065a a606          	ld	a,#6
2687  065c 42            	mul	x,a
2688  065d 01            	rrwa	x,a
2689  065e 1b01          	add	a,(OFST+1,sp)
2690  0660 2401          	jrnc	L451
2691  0662 5c            	incw	x
2692  0663               L451:
2693  0663 02            	rlwa	x,a
2694  0664 7b05          	ld	a,(OFST+5,sp)
2695  0666 e704          	ld	(_pwm_brightness_buffer,x),a
2699  0668 85            	popw	x
2700  0669 81            	ret
2744                     ; 465 void set_white(u8 index,u8 brightness)
2744                     ; 466 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
2745                     	switch	.text
2746  066a               _set_white:
2748  066a 89            	pushw	x
2749       00000000      OFST:	set	0
2754  066b 9e            	ld	a,xh
2755  066c 5f            	clrw	x
2756  066d 97            	ld	xl,a
2757  066e 7b02          	ld	a,(OFST+2,sp)
2758  0670 e717          	ld	(_pwm_brightness_buffer+19,x),a
2762  0672 85            	popw	x
2763  0673 81            	ret
2798                     ; 467 void set_debug(u8 brightness)
2798                     ; 468 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
2799                     	switch	.text
2800  0674               _set_debug:
2806  0674 b716          	ld	_pwm_brightness_buffer+18,a
2810  0676 81            	ret
2940                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2941                     	switch	.ubsct
2942  0000               _button_pressed_event:
2943  0000 00000000      	ds.b	4
2944                     	xdef	_button_pressed_event
2945                     	xdef	_is_right_button_down
2946                     	xdef	_button_start_ms
2947                     	xdef	_pwm_state
2948                     	xdef	_pwm_visible_index
2949                     	xdef	_pwm_led_count
2950                     	xdef	_pwm_sleep
2951  0004               _pwm_brightness_buffer:
2952  0004 000000000000  	ds.b	31
2953                     	xdef	_pwm_brightness_buffer
2954  0023               _pwm_brightness_index:
2955  0023 000000000000  	ds.b	62
2956                     	xdef	_pwm_brightness_index
2957                     	xdef	_pwm_brightness
2958                     	xdef	_atomic_counter
2959                     	xref	_UART1_Cmd
2960                     	xref	_UART1_Init
2961                     	xref	_UART1_DeInit
2962                     	xref	_GPIO_ReadInputPin
2963                     	xref	_GPIO_Init
2964                     	xdef	_set_led_on
2965                     	xdef	_set_mat
2966                     	xdef	_get_random
2967                     	xdef	_is_button_down
2968                     	xdef	_get_button_event
2969                     	xdef	_update_buttons
2970                     	xdef	_is_developer_valid
2971                     	xdef	_set_hue_max
2972                     	xdef	_flush_leds
2973                     	xdef	_set_debug
2974                     	xdef	_set_white
2975                     	xdef	_set_rgb
2976                     	xdef	_millis
2977                     	xdef	_setup_main
2978                     	xdef	_is_application_valid
2979                     	xdef	_setup_serial
2980                     	xdef	_hello_world
2981                     	xref.b	c_lreg
2982                     	xref.b	c_x
2983                     	xref.b	c_y
3003                     	xref	c_xymov
3004                     	xref	c_lgadd
3005                     	xref	c_uitolx
3006                     	xref	c_lcmp
3007                     	xref	c_rtol
3008                     	xref	c_lsub
3009                     	xref	c_lzmp
3010                     	xref	c_lursh
3011                     	xref	c_itolx
3012                     	xref	c_ltor
3013                     	xref	c_imul
3014                     	end
