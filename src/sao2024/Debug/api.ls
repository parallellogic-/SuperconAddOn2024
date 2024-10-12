   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _frame_counter:
  16  0000 0000          	dc.w	0
  17  0002               _atomic_counter:
  18  0002 00000000      	dc.l	0
  19  0006               _pwm_brightness:
  20  0006 0001          	dc.w	1
  21  0008 0001          	dc.w	1
  22  000a 000000000000  	ds.b	120
  23  0082               _pwm_sleep:
  24  0082 0001          	dc.w	1
  25  0084 0001          	dc.w	1
  26  0086               _pwm_led_count:
  27  0086 01            	dc.b	1
  28  0087 01            	dc.b	1
  29  0088               _pwm_visible_index:
  30  0088 00            	dc.b	0
  31  0089               _pwm_state:
  32  0089 00            	dc.b	0
  93                     ; 27 void hello_world()
  93                     ; 28 {//basic program that blinks the debug LED ON/OFF
  95                     	switch	.text
  96  0000               _hello_world:
  98  0000 5204          	subw	sp,#4
  99       00000004      OFST:	set	4
 102                     ; 29 	const u8 cycle_speed=8;//larger=faster
 104  0002 a608          	ld	a,#8
 105  0004 6b02          	ld	(OFST-2,sp),a
 107                     ; 30 	const u8 white_speed=5;//smaller=faster
 109  0006 a605          	ld	a,#5
 110  0008 6b01          	ld	(OFST-3,sp),a
 112                     ; 31 	u16 frame=0;
 114  000a 5f            	clrw	x
 115  000b 1f03          	ldw	(OFST-1,sp),x
 117  000d               L73:
 118                     ; 34 		frame++;
 120  000d 1e03          	ldw	x,(OFST-1,sp)
 121  000f 1c0001        	addw	x,#1
 122  0012 1f03          	ldw	(OFST-1,sp),x
 124                     ; 35 		set_hue_max(0,(frame<<cycle_speed));
 126  0014 1e03          	ldw	x,(OFST-1,sp)
 127  0016 7b02          	ld	a,(OFST-2,sp)
 128  0018 4d            	tnz	a
 129  0019 2704          	jreq	L6
 130  001b               L01:
 131  001b 58            	sllw	x
 132  001c 4a            	dec	a
 133  001d 26fc          	jrne	L01
 134  001f               L6:
 135  001f 89            	pushw	x
 136  0020 4f            	clr	a
 137  0021 cd05a3        	call	_set_hue_max
 139  0024 85            	popw	x
 140                     ; 36 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 142  0025 1e03          	ldw	x,(OFST-1,sp)
 143  0027 7b02          	ld	a,(OFST-2,sp)
 144  0029 4d            	tnz	a
 145  002a 2704          	jreq	L21
 146  002c               L41:
 147  002c 58            	sllw	x
 148  002d 4a            	dec	a
 149  002e 26fc          	jrne	L41
 150  0030               L21:
 151  0030 1c2aab        	addw	x,#10923
 152  0033 89            	pushw	x
 153  0034 a601          	ld	a,#1
 154  0036 cd05a3        	call	_set_hue_max
 156  0039 85            	popw	x
 157                     ; 37 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 159  003a 1e03          	ldw	x,(OFST-1,sp)
 160  003c 7b02          	ld	a,(OFST-2,sp)
 161  003e 4d            	tnz	a
 162  003f 2704          	jreq	L61
 163  0041               L02:
 164  0041 58            	sllw	x
 165  0042 4a            	dec	a
 166  0043 26fc          	jrne	L02
 167  0045               L61:
 168  0045 1c5556        	addw	x,#21846
 169  0048 89            	pushw	x
 170  0049 a602          	ld	a,#2
 171  004b cd05a3        	call	_set_hue_max
 173  004e 85            	popw	x
 174                     ; 38 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 176  004f 1e03          	ldw	x,(OFST-1,sp)
 177  0051 7b02          	ld	a,(OFST-2,sp)
 178  0053 4d            	tnz	a
 179  0054 2704          	jreq	L22
 180  0056               L42:
 181  0056 58            	sllw	x
 182  0057 4a            	dec	a
 183  0058 26fc          	jrne	L42
 184  005a               L22:
 185  005a 1c8000        	addw	x,#32768
 186  005d 89            	pushw	x
 187  005e a603          	ld	a,#3
 188  0060 cd05a3        	call	_set_hue_max
 190  0063 85            	popw	x
 191                     ; 39 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 193  0064 1e03          	ldw	x,(OFST-1,sp)
 194  0066 7b02          	ld	a,(OFST-2,sp)
 195  0068 4d            	tnz	a
 196  0069 2704          	jreq	L62
 197  006b               L03:
 198  006b 58            	sllw	x
 199  006c 4a            	dec	a
 200  006d 26fc          	jrne	L03
 201  006f               L62:
 202  006f 1caaab        	addw	x,#43691
 203  0072 89            	pushw	x
 204  0073 a604          	ld	a,#4
 205  0075 cd05a3        	call	_set_hue_max
 207  0078 85            	popw	x
 208                     ; 40 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 210  0079 1e03          	ldw	x,(OFST-1,sp)
 211  007b 7b02          	ld	a,(OFST-2,sp)
 212  007d 4d            	tnz	a
 213  007e 2704          	jreq	L23
 214  0080               L43:
 215  0080 58            	sllw	x
 216  0081 4a            	dec	a
 217  0082 26fc          	jrne	L43
 218  0084               L23:
 219  0084 1cd554        	addw	x,#54612
 220  0087 89            	pushw	x
 221  0088 a605          	ld	a,#5
 222  008a cd05a3        	call	_set_hue_max
 224  008d 85            	popw	x
 225                     ; 43 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
 227  008e 1e03          	ldw	x,(OFST-1,sp)
 228  0090 7b01          	ld	a,(OFST-3,sp)
 229  0092 4d            	tnz	a
 230  0093 2704          	jreq	L04
 231  0095               L24:
 232  0095 54            	srlw	x
 233  0096 4a            	dec	a
 234  0097 26fc          	jrne	L24
 235  0099               L04:
 236  0099 01            	rrwa	x,a
 237  009a a501          	bcp	a,#1
 238  009c 2712          	jreq	L63
 239  009e a608          	ld	a,#8
 240  00a0 1001          	sub	a,(OFST-3,sp)
 241  00a2 5f            	clrw	x
 242  00a3 97            	ld	xl,a
 243  00a4 7b04          	ld	a,(OFST+0,sp)
 244  00a6 5d            	tnzw	x
 245  00a7 2704          	jreq	L44
 246  00a9               L64:
 247  00a9 48            	sll	a
 248  00aa 5a            	decw	x
 249  00ab 26fc          	jrne	L64
 250  00ad               L44:
 251  00ad 43            	cpl	a
 252  00ae 200f          	jra	L05
 253  00b0               L63:
 254  00b0 a608          	ld	a,#8
 255  00b2 1001          	sub	a,(OFST-3,sp)
 256  00b4 5f            	clrw	x
 257  00b5 97            	ld	xl,a
 258  00b6 7b04          	ld	a,(OFST+0,sp)
 259  00b8 5d            	tnzw	x
 260  00b9 2704          	jreq	L25
 261  00bb               L45:
 262  00bb 48            	sll	a
 263  00bc 5a            	decw	x
 264  00bd 26fc          	jrne	L45
 265  00bf               L25:
 266  00bf               L05:
 267  00bf 97            	ld	xl,a
 268  00c0 1603          	ldw	y,(OFST-1,sp)
 269  00c2 7b01          	ld	a,(OFST-3,sp)
 270  00c4 4c            	inc	a
 271  00c5 4d            	tnz	a
 272  00c6 2705          	jreq	L65
 273  00c8               L06:
 274  00c8 9054          	srlw	y
 275  00ca 4a            	dec	a
 276  00cb 26fb          	jrne	L06
 277  00cd               L65:
 278  00cd a60c          	ld	a,#12
 279  00cf 9062          	div	y,a
 280  00d1 905f          	clrw	y
 281  00d3 9097          	ld	yl,a
 282  00d5 909f          	ld	a,yl
 283  00d7 95            	ld	xh,a
 284  00d8 cd0669        	call	_set_white
 286                     ; 44 		flush_leds(7);
 288  00db a607          	ld	a,#7
 289  00dd cd0492        	call	_flush_leds
 292  00e0 ac0d000d      	jpf	L73
 344                     ; 48 u16 get_random(u16 x)
 344                     ; 49 {
 345                     	switch	.text
 346  00e4               _get_random:
 348  00e4 5204          	subw	sp,#4
 349       00000004      OFST:	set	4
 352                     ; 50 	u16 a=1664525;
 354                     ; 51 	u16 c=1013904223;
 356                     ; 52 	return a * x + c;
 358  00e6 90ae660d      	ldw	y,#26125
 359  00ea cd0000        	call	c_imul
 361  00ed 1cf35f        	addw	x,#62303
 364  00f0 5b04          	addw	sp,#4
 365  00f2 81            	ret
 434                     .const:	section	.text
 435  0000               L07:
 436  0000 0000e100      	dc.l	57600
 437                     ; 55 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 437                     ; 56 {
 438                     	switch	.text
 439  00f3               _setup_serial:
 441  00f3 89            	pushw	x
 442       00000000      OFST:	set	0
 445                     ; 57 	if(is_enabled)
 447  00f4 9e            	ld	a,xh
 448  00f5 4d            	tnz	a
 449  00f6 2747          	jreq	L321
 450                     ; 59 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 452  00f8 4bf0          	push	#240
 453  00fa 4b20          	push	#32
 454  00fc ae500f        	ldw	x,#20495
 455  00ff cd0000        	call	_GPIO_Init
 457  0102 85            	popw	x
 458                     ; 60 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 460  0103 4b40          	push	#64
 461  0105 4b40          	push	#64
 462  0107 ae500f        	ldw	x,#20495
 463  010a cd0000        	call	_GPIO_Init
 465  010d 85            	popw	x
 466                     ; 61 		UART1_DeInit();
 468  010e cd0000        	call	_UART1_DeInit
 470                     ; 62 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 472  0111 4b0c          	push	#12
 473  0113 4b80          	push	#128
 474  0115 4b00          	push	#0
 475  0117 4b00          	push	#0
 476  0119 4b00          	push	#0
 477  011b 0d07          	tnz	(OFST+7,sp)
 478  011d 2708          	jreq	L66
 479  011f ae0000        	ldw	x,#L07
 480  0122 cd0000        	call	c_ltor
 482  0125 2006          	jra	L27
 483  0127               L66:
 484  0127 ae2580        	ldw	x,#9600
 485  012a cd0000        	call	c_itolx
 487  012d               L27:
 488  012d be02          	ldw	x,c_lreg+2
 489  012f 89            	pushw	x
 490  0130 be00          	ldw	x,c_lreg
 491  0132 89            	pushw	x
 492  0133 cd0000        	call	_UART1_Init
 494  0136 5b09          	addw	sp,#9
 495                     ; 63 		UART1_Cmd(ENABLE);
 497  0138 a601          	ld	a,#1
 498  013a cd0000        	call	_UART1_Cmd
 501  013d 201d          	jra	L521
 502  013f               L321:
 503                     ; 65 		UART1_Cmd(DISABLE);
 505  013f 4f            	clr	a
 506  0140 cd0000        	call	_UART1_Cmd
 508                     ; 66 		UART1_DeInit();
 510  0143 cd0000        	call	_UART1_DeInit
 512                     ; 67 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 514  0146 4b40          	push	#64
 515  0148 4b20          	push	#32
 516  014a ae500f        	ldw	x,#20495
 517  014d cd0000        	call	_GPIO_Init
 519  0150 85            	popw	x
 520                     ; 68 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 522  0151 4b40          	push	#64
 523  0153 4b40          	push	#64
 524  0155 ae500f        	ldw	x,#20495
 525  0158 cd0000        	call	_GPIO_Init
 527  015b 85            	popw	x
 528  015c               L521:
 529                     ; 70 }
 532  015c 85            	popw	x
 533  015d 81            	ret
 558                     ; 73 bool is_application_valid()
 558                     ; 74 {
 559                     	switch	.text
 560  015e               _is_application_valid:
 564                     ; 75 	return 1;//!is_button_down(2) && !get_button_event(0,1);
 566  015e a601          	ld	a,#1
 569  0160 81            	ret
 593                     ; 79 bool is_developer_valid()
 593                     ; 80 {
 594                     	switch	.text
 595  0161               _is_developer_valid:
 599                     ; 81 	return 0;//is_button_down(2) && !get_button_event(0,1);
 601  0161 4f            	clr	a
 604  0162 81            	ret
 629                     ; 84 void setup_main()
 629                     ; 85 {
 630                     	switch	.text
 631  0163               _setup_main:
 635                     ; 86 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 637  0163 c650c6        	ld	a,20678
 638  0166 a4e7          	and	a,#231
 639  0168 c750c6        	ld	20678,a
 640                     ; 88 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 642  016b 4b40          	push	#64
 643  016d 4b02          	push	#2
 644  016f ae500f        	ldw	x,#20495
 645  0172 cd0000        	call	_GPIO_Init
 647  0175 85            	popw	x
 648                     ; 92 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 650  0176 3505530e      	mov	21262,#5
 651                     ; 93 	TIM2->ARRH= 0;// init auto reload register
 653  017a 725f530f      	clr	21263
 654                     ; 94 	TIM2->ARRL= 255;// init auto reload register
 656  017e 35ff5310      	mov	21264,#255
 657                     ; 96 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 659  0182 c65300        	ld	a,21248
 660  0185 aa05          	or	a,#5
 661  0187 c75300        	ld	21248,a
 662                     ; 98 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 664  018a 35015303      	mov	21251,#1
 665                     ; 99 	enableInterrupts();
 668  018e 9a            rim
 670                     ; 100 }
 674  018f 81            	ret
 698                     ; 102 u32 millis()
 698                     ; 103 {
 699                     	switch	.text
 700  0190               _millis:
 704                     ; 104 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 706  0190 ae0002        	ldw	x,#_atomic_counter
 707  0193 cd0000        	call	c_ltor
 709  0196 a609          	ld	a,#9
 710  0198 cd0000        	call	c_lursh
 714  019b 81            	ret
 772                     ; 110 void update_buttons()
 772                     ; 111 {
 773                     	switch	.text
 774  019c               _update_buttons:
 776  019c 5208          	subw	sp,#8
 777       00000008      OFST:	set	8
 780                     ; 112 	bool is_any_down=0;
 782  019e 0f05          	clr	(OFST-3,sp)
 784                     ; 114 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 786  01a0 be06          	ldw	x,_button_start_ms+2
 787  01a2 cd0000        	call	c_uitolx
 789  01a5 96            	ldw	x,sp
 790  01a6 1c0001        	addw	x,#OFST-7
 791  01a9 cd0000        	call	c_rtol
 794  01ac ade2          	call	_millis
 796  01ae 96            	ldw	x,sp
 797  01af 1c0001        	addw	x,#OFST-7
 798  01b2 cd0000        	call	c_lsub
 800  01b5 be02          	ldw	x,c_lreg+2
 801  01b7 1f06          	ldw	(OFST-2,sp),x
 803                     ; 115 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 805  01b9 0f08          	clr	(OFST+0,sp)
 807  01bb               L512:
 808                     ; 117 		if(is_button_down(button_index))
 810  01bb 7b08          	ld	a,(OFST+0,sp)
 811  01bd cd0274        	call	_is_button_down
 813  01c0 4d            	tnz	a
 814  01c1 271b          	jreq	L322
 815                     ; 119 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 817  01c3 ae0004        	ldw	x,#_button_start_ms
 818  01c6 cd0000        	call	c_lzmp
 820  01c9 2608          	jrne	L522
 823  01cb adc3          	call	_millis
 825  01cd ae0004        	ldw	x,#_button_start_ms
 826  01d0 cd0000        	call	c_rtol
 828  01d3               L522:
 829                     ; 120 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 831  01d3 a6ff          	ld	a,#255
 832  01d5 cd0673        	call	_set_debug
 834                     ; 121 			is_any_down=1;
 836  01d8 a601          	ld	a,#1
 837  01da 6b05          	ld	(OFST-3,sp),a
 840  01dc 2022          	jra	L722
 841  01de               L322:
 842                     ; 123 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 844  01de 1e06          	ldw	x,(OFST-2,sp)
 845  01e0 a30201        	cpw	x,#513
 846  01e3 250b          	jrult	L132
 849  01e5 7b08          	ld	a,(OFST+0,sp)
 850  01e7 5f            	clrw	x
 851  01e8 97            	ld	xl,a
 852  01e9 58            	sllw	x
 853  01ea a601          	ld	a,#1
 854  01ec e701          	ld	(_button_pressed_event+1,x),a
 856  01ee 2010          	jra	L722
 857  01f0               L132:
 858                     ; 124 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 860  01f0 1e06          	ldw	x,(OFST-2,sp)
 861  01f2 a30033        	cpw	x,#51
 862  01f5 2509          	jrult	L722
 865  01f7 7b08          	ld	a,(OFST+0,sp)
 866  01f9 5f            	clrw	x
 867  01fa 97            	ld	xl,a
 868  01fb 58            	sllw	x
 869  01fc a601          	ld	a,#1
 870  01fe e700          	ld	(_button_pressed_event,x),a
 871  0200               L722:
 872                     ; 115 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 874  0200 0c08          	inc	(OFST+0,sp)
 878  0202 7b08          	ld	a,(OFST+0,sp)
 879  0204 a102          	cp	a,#2
 880  0206 25b3          	jrult	L512
 881                     ; 128 	if(!is_any_down) button_start_ms=0;
 883  0208 0d05          	tnz	(OFST-3,sp)
 884  020a 260a          	jrne	L732
 887  020c ae0000        	ldw	x,#0
 888  020f bf06          	ldw	_button_start_ms+2,x
 889  0211 ae0000        	ldw	x,#0
 890  0214 bf04          	ldw	_button_start_ms,x
 891  0216               L732:
 892                     ; 129 }
 895  0216 5b08          	addw	sp,#8
 896  0218 81            	ret
 942                     ; 132 bool get_button_event(u8 button_index,bool is_long)
 942                     ; 133 { return button_pressed_event[button_index][is_long]; }
 943                     	switch	.text
 944  0219               _get_button_event:
 946  0219 89            	pushw	x
 947       00000000      OFST:	set	0
 952  021a 9e            	ld	a,xh
 953  021b 5f            	clrw	x
 954  021c 97            	ld	xl,a
 955  021d 58            	sllw	x
 956  021e 01            	rrwa	x,a
 957  021f 1b02          	add	a,(OFST+2,sp)
 958  0221 2401          	jrnc	L011
 959  0223 5c            	incw	x
 960  0224               L011:
 961  0224 02            	rlwa	x,a
 962  0225 e600          	ld	a,(_button_pressed_event,x)
 965  0227 85            	popw	x
 966  0228 81            	ret
1022                     ; 136 bool clear_button_event(u8 button_index,bool is_long)
1022                     ; 137 {
1023                     	switch	.text
1024  0229               _clear_button_event:
1026  0229 89            	pushw	x
1027  022a 88            	push	a
1028       00000001      OFST:	set	1
1031                     ; 138 	bool out=button_pressed_event[button_index][is_long];
1033  022b 9e            	ld	a,xh
1034  022c 5f            	clrw	x
1035  022d 97            	ld	xl,a
1036  022e 58            	sllw	x
1037  022f 01            	rrwa	x,a
1038  0230 1b03          	add	a,(OFST+2,sp)
1039  0232 2401          	jrnc	L411
1040  0234 5c            	incw	x
1041  0235               L411:
1042  0235 02            	rlwa	x,a
1043  0236 e600          	ld	a,(_button_pressed_event,x)
1044  0238 6b01          	ld	(OFST+0,sp),a
1046                     ; 139 	button_pressed_event[button_index][is_long]=0;
1048  023a 7b02          	ld	a,(OFST+1,sp)
1049  023c 5f            	clrw	x
1050  023d 97            	ld	xl,a
1051  023e 58            	sllw	x
1052  023f 01            	rrwa	x,a
1053  0240 1b03          	add	a,(OFST+2,sp)
1054  0242 2401          	jrnc	L611
1055  0244 5c            	incw	x
1056  0245               L611:
1057  0245 02            	rlwa	x,a
1058  0246 6f00          	clr	(_button_pressed_event,x)
1059                     ; 140 	return out;
1061  0248 7b01          	ld	a,(OFST+0,sp)
1064  024a 5b03          	addw	sp,#3
1065  024c 81            	ret
1112                     ; 143 bool clear_button_events()
1112                     ; 144 {
1113                     	switch	.text
1114  024d               _clear_button_events:
1116  024d 89            	pushw	x
1117       00000002      OFST:	set	2
1120                     ; 146 	bool out=0;
1122  024e 0f01          	clr	(OFST-1,sp)
1124                     ; 147 	for(iter=0;iter<BUTTON_COUNT;iter++)
1126  0250 0f02          	clr	(OFST+0,sp)
1128  0252               L333:
1129                     ; 149 		out|=clear_button_event(iter,0);
1131  0252 7b02          	ld	a,(OFST+0,sp)
1132  0254 5f            	clrw	x
1133  0255 95            	ld	xh,a
1134  0256 add1          	call	_clear_button_event
1136  0258 1a01          	or	a,(OFST-1,sp)
1137  025a 6b01          	ld	(OFST-1,sp),a
1139                     ; 150 		out|=clear_button_event(iter,1);
1141  025c 7b02          	ld	a,(OFST+0,sp)
1142  025e ae0001        	ldw	x,#1
1143  0261 95            	ld	xh,a
1144  0262 adc5          	call	_clear_button_event
1146  0264 1a01          	or	a,(OFST-1,sp)
1147  0266 6b01          	ld	(OFST-1,sp),a
1149                     ; 147 	for(iter=0;iter<BUTTON_COUNT;iter++)
1151  0268 0c02          	inc	(OFST+0,sp)
1155  026a 7b02          	ld	a,(OFST+0,sp)
1156  026c a102          	cp	a,#2
1157  026e 25e2          	jrult	L333
1158                     ; 152 	return out;
1160  0270 7b01          	ld	a,(OFST-1,sp)
1163  0272 85            	popw	x
1164  0273 81            	ret
1200                     ; 156 bool is_button_down(u8 index)
1200                     ; 157 {
1201                     	switch	.text
1202  0274               _is_button_down:
1206                     ; 158 	switch(index)
1209                     ; 164 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1210  0274 4d            	tnz	a
1211  0275 2708          	jreq	L143
1212  0277 4a            	dec	a
1213  0278 2718          	jreq	L343
1214  027a 4a            	dec	a
1215  027b 2728          	jreq	L543
1216  027d 2039          	jra	L763
1217  027f               L143:
1218                     ; 162 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); }//left button
1220  027f 4b20          	push	#32
1221  0281 ae500f        	ldw	x,#20495
1222  0284 cd0000        	call	_GPIO_ReadInputPin
1224  0287 5b01          	addw	sp,#1
1225  0289 4d            	tnz	a
1226  028a 2604          	jrne	L421
1227  028c a601          	ld	a,#1
1228  028e 2001          	jra	L621
1229  0290               L421:
1230  0290 4f            	clr	a
1231  0291               L621:
1234  0291 81            	ret
1235  0292               L343:
1236                     ; 163 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); }//right button
1238  0292 4b40          	push	#64
1239  0294 ae500f        	ldw	x,#20495
1240  0297 cd0000        	call	_GPIO_ReadInputPin
1242  029a 5b01          	addw	sp,#1
1243  029c 4d            	tnz	a
1244  029d 2604          	jrne	L031
1245  029f a601          	ld	a,#1
1246  02a1 2001          	jra	L231
1247  02a3               L031:
1248  02a3 4f            	clr	a
1249  02a4               L231:
1252  02a4 81            	ret
1253  02a5               L543:
1254                     ; 164 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); }//SWIM IO input
1256  02a5 4b02          	push	#2
1257  02a7 ae500f        	ldw	x,#20495
1258  02aa cd0000        	call	_GPIO_ReadInputPin
1260  02ad 5b01          	addw	sp,#1
1261  02af 4d            	tnz	a
1262  02b0 2604          	jrne	L431
1263  02b2 a601          	ld	a,#1
1264  02b4 2001          	jra	L631
1265  02b6               L431:
1266  02b6 4f            	clr	a
1267  02b7               L631:
1270  02b7 81            	ret
1271  02b8               L763:
1272                     ; 166 	return 0;
1274  02b8 4f            	clr	a
1277  02b9 81            	ret
1332                     ; 170 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1334                     	switch	.text
1335  02ba               f_TIM2_UPD_OVF_IRQHandler:
1337  02ba 8a            	push	cc
1338  02bb 84            	pop	a
1339  02bc a4bf          	and	a,#191
1340  02be 88            	push	a
1341  02bf 86            	pop	cc
1342       00000005      OFST:	set	5
1343  02c0 3b0002        	push	c_x+2
1344  02c3 be00          	ldw	x,c_x
1345  02c5 89            	pushw	x
1346  02c6 3b0002        	push	c_y+2
1347  02c9 be00          	ldw	x,c_y
1348  02cb 89            	pushw	x
1349  02cc be02          	ldw	x,c_lreg+2
1350  02ce 89            	pushw	x
1351  02cf be00          	ldw	x,c_lreg
1352  02d1 89            	pushw	x
1353  02d2 5205          	subw	sp,#5
1356                     ; 171 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1358  02d4 b689          	ld	a,_pwm_state
1359  02d6 a401          	and	a,#1
1360  02d8 6b05          	ld	(OFST+0,sp),a
1362                     ; 172 	u16 sleep_counts=1;
1364  02da ae0001        	ldw	x,#1
1365  02dd 1f03          	ldw	(OFST-2,sp),x
1367                     ; 174 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1369  02df c6500c        	ld	a,20492
1370  02e2 a407          	and	a,#7
1371  02e4 c7500c        	ld	20492,a
1372                     ; 175 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1374  02e7 72155011      	bres	20497,#2
1375                     ; 176 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1377  02eb 72175002      	bres	20482,#3
1378                     ; 177 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1380  02ef c6500d        	ld	a,20493
1381  02f2 a407          	and	a,#7
1382  02f4 c7500d        	ld	20493,a
1383                     ; 178 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1385  02f7 72155012      	bres	20498,#2
1386                     ; 179 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1388  02fb 72175003      	bres	20483,#3
1389                     ; 181 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1391  02ff 72195011      	bres	20497,#4
1392                     ; 182 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1394  0303 72195012      	bres	20498,#4
1395                     ; 184   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1397  0307 72115300      	bres	21248,#0
1398                     ; 185 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1400  030b 7b05          	ld	a,(OFST+0,sp)
1401  030d 5f            	clrw	x
1402  030e 97            	ld	xl,a
1403  030f e686          	ld	a,(_pwm_led_count,x)
1404  0311 b188          	cp	a,_pwm_visible_index
1405  0313 2609          	jrne	L314
1406                     ; 187 		sleep_counts=pwm_sleep[buffer_index];
1408  0315 7b05          	ld	a,(OFST+0,sp)
1409  0317 5f            	clrw	x
1410  0318 97            	ld	xl,a
1411  0319 58            	sllw	x
1412  031a ee82          	ldw	x,(_pwm_sleep,x)
1413  031c 1f03          	ldw	(OFST-2,sp),x
1415  031e               L314:
1416                     ; 189 	if(pwm_visible_index>pwm_led_count[buffer_index])
1418  031e 7b05          	ld	a,(OFST+0,sp)
1419  0320 5f            	clrw	x
1420  0321 97            	ld	xl,a
1421  0322 e686          	ld	a,(_pwm_led_count,x)
1422  0324 b188          	cp	a,_pwm_visible_index
1423  0326 241e          	jruge	L514
1424                     ; 191 		frame_counter++;
1426  0328 be00          	ldw	x,_frame_counter
1427  032a 1c0001        	addw	x,#1
1428  032d bf00          	ldw	_frame_counter,x
1429                     ; 192 		pwm_visible_index=0;//formally start new frame
1431  032f 3f88          	clr	_pwm_visible_index
1432                     ; 193 		update_buttons();
1434  0331 cd019c        	call	_update_buttons
1436                     ; 194 		if(pwm_state&0x02)
1438  0334 b689          	ld	a,_pwm_state
1439  0336 a502          	bcp	a,#2
1440  0338 270c          	jreq	L514
1441                     ; 196 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1443  033a b689          	ld	a,_pwm_state
1444  033c a803          	xor	a,#3
1445  033e b789          	ld	_pwm_state,a
1446                     ; 197 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1448  0340 b689          	ld	a,_pwm_state
1449  0342 a401          	and	a,#1
1450  0344 6b05          	ld	(OFST+0,sp),a
1452  0346               L514:
1453                     ; 200 	if(pwm_visible_index<pwm_led_count[buffer_index])
1455  0346 7b05          	ld	a,(OFST+0,sp)
1456  0348 5f            	clrw	x
1457  0349 97            	ld	xl,a
1458  034a e686          	ld	a,(_pwm_led_count,x)
1459  034c b188          	cp	a,_pwm_visible_index
1460  034e 2324          	jrule	L124
1461                     ; 202 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1463  0350 7b05          	ld	a,(OFST+0,sp)
1464  0352 5f            	clrw	x
1465  0353 97            	ld	xl,a
1466  0354 58            	sllw	x
1467  0355 1f01          	ldw	(OFST-4,sp),x
1469  0357 b688          	ld	a,_pwm_visible_index
1470  0359 97            	ld	xl,a
1471  035a a604          	ld	a,#4
1472  035c 42            	mul	x,a
1473  035d 72fb01        	addw	x,(OFST-4,sp)
1474  0360 ee06          	ldw	x,(_pwm_brightness,x)
1475  0362 1f03          	ldw	(OFST-2,sp),x
1477                     ; 203 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1479  0364 b688          	ld	a,_pwm_visible_index
1480  0366 5f            	clrw	x
1481  0367 97            	ld	xl,a
1482  0368 58            	sllw	x
1483  0369 01            	rrwa	x,a
1484  036a 1b05          	add	a,(OFST+0,sp)
1485  036c 2401          	jrnc	L241
1486  036e 5c            	incw	x
1487  036f               L241:
1488  036f 02            	rlwa	x,a
1489  0370 e627          	ld	a,(_pwm_brightness_index,x)
1490  0372 ad3e          	call	_set_led_on
1492  0374               L124:
1493                     ; 205 	pwm_visible_index++;
1495  0374 3c88          	inc	_pwm_visible_index
1496                     ; 206 	atomic_counter+=sleep_counts;
1498  0376 1e03          	ldw	x,(OFST-2,sp)
1499  0378 cd0000        	call	c_uitolx
1501  037b ae0002        	ldw	x,#_atomic_counter
1502  037e cd0000        	call	c_lgadd
1504                     ; 208   TIM2->CNTRH = 0;// Set the high byte of the counter
1506  0381 725f530c      	clr	21260
1507                     ; 209   TIM2->CNTRL = 0;// Set the low byte of the counter
1509  0385 725f530d      	clr	21261
1510                     ; 210 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1512  0389 7b03          	ld	a,(OFST-2,sp)
1513  038b c7530f        	ld	21263,a
1514                     ; 211 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1516  038e 7b04          	ld	a,(OFST-1,sp)
1517  0390 a4ff          	and	a,#255
1518  0392 c75310        	ld	21264,a
1519                     ; 213 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1521  0395 72115304      	bres	21252,#0
1522                     ; 214   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1524  0399 72105300      	bset	21248,#0
1525                     ; 215 }
1528  039d 5b05          	addw	sp,#5
1529  039f 85            	popw	x
1530  03a0 bf00          	ldw	c_lreg,x
1531  03a2 85            	popw	x
1532  03a3 bf02          	ldw	c_lreg+2,x
1533  03a5 85            	popw	x
1534  03a6 bf00          	ldw	c_y,x
1535  03a8 320002        	pop	c_y+2
1536  03ab 85            	popw	x
1537  03ac bf00          	ldw	c_x,x
1538  03ae 320002        	pop	c_x+2
1539  03b1 80            	iret
1541                     	switch	.const
1542  0004               L324_led_lookup:
1543  0004 04            	dc.b	4
1544  0005 03            	dc.b	3
1545  0006 03            	dc.b	3
1546  0007 04            	dc.b	4
1547  0008 00            	dc.b	0
1548  0009 05            	dc.b	5
1549  000a 00            	dc.b	0
1550  000b 04            	dc.b	4
1551  000c 00            	dc.b	0
1552  000d 03            	dc.b	3
1553  000e 00            	dc.b	0
1554  000f 01            	dc.b	1
1555  0010 05            	dc.b	5
1556  0011 03            	dc.b	3
1557  0012 03            	dc.b	3
1558  0013 05            	dc.b	5
1559  0014 00            	dc.b	0
1560  0015 06            	dc.b	6
1561  0016 01            	dc.b	1
1562  0017 04            	dc.b	4
1563  0018 01            	dc.b	1
1564  0019 03            	dc.b	3
1565  001a 00            	dc.b	0
1566  001b 02            	dc.b	2
1567  001c 06            	dc.b	6
1568  001d 03            	dc.b	3
1569  001e 03            	dc.b	3
1570  001f 06            	dc.b	6
1571  0020 01            	dc.b	1
1572  0021 06            	dc.b	6
1573  0022 02            	dc.b	2
1574  0023 04            	dc.b	4
1575  0024 02            	dc.b	2
1576  0025 03            	dc.b	3
1577  0026 01            	dc.b	1
1578  0027 02            	dc.b	2
1579  0028 07            	dc.b	7
1580  0029 07            	dc.b	7
1581  002a 03            	dc.b	3
1582  002b 00            	dc.b	0
1583  002c 03            	dc.b	3
1584  002d 01            	dc.b	1
1585  002e 03            	dc.b	3
1586  002f 02            	dc.b	2
1587  0030 04            	dc.b	4
1588  0031 00            	dc.b	0
1589  0032 01            	dc.b	1
1590  0033 05            	dc.b	5
1591  0034 02            	dc.b	2
1592  0035 05            	dc.b	5
1593  0036 04            	dc.b	4
1594  0037 01            	dc.b	1
1595  0038 04            	dc.b	4
1596  0039 02            	dc.b	2
1597  003a 02            	dc.b	2
1598  003b 06            	dc.b	6
1599  003c 04            	dc.b	4
1600  003d 06            	dc.b	6
1601  003e 04            	dc.b	4
1602  003f 05            	dc.b	5
1603  0040 05            	dc.b	5
1604  0041 06            	dc.b	6
1648                     ; 218 void set_led_on(u8 led_index)
1648                     ; 219 {
1650                     	switch	.text
1651  03b2               _set_led_on:
1653  03b2 88            	push	a
1654  03b3 5240          	subw	sp,#64
1655       00000040      OFST:	set	64
1658                     ; 256 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1658                     ; 257 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1658                     ; 258 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1658                     ; 259 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1658                     ; 260 		{7,7},//debug; GND is tied low, no charlieplexing involved
1658                     ; 261 		{3,0},//LED6
1658                     ; 262 		{3,1},//LED4
1658                     ; 263 		{3,2},//LED5
1658                     ; 264 		{4,0},//LED14
1658                     ; 265 		{1,5},//LED8
1658                     ; 266 		{2,5},//LED9
1658                     ; 267 		{4,1},//LED10
1658                     ; 268 		{4,2},//LED16
1658                     ; 269 		{2,6},//LED17
1658                     ; 270 		{4,6},//LED12
1658                     ; 271 		{4,5},//LED13
1658                     ; 272 		{5,6} //LED11
1658                     ; 273 	};
1660  03b5 96            	ldw	x,sp
1661  03b6 1c0003        	addw	x,#OFST-61
1662  03b9 90ae0004      	ldw	y,#L324_led_lookup
1663  03bd a63e          	ld	a,#62
1664  03bf cd0000        	call	c_xymov
1666                     ; 274 	set_mat(led_lookup[led_index][0],1);
1668  03c2 96            	ldw	x,sp
1669  03c3 1c0003        	addw	x,#OFST-61
1670  03c6 1f01          	ldw	(OFST-63,sp),x
1672  03c8 7b41          	ld	a,(OFST+1,sp)
1673  03ca 5f            	clrw	x
1674  03cb 97            	ld	xl,a
1675  03cc 58            	sllw	x
1676  03cd 72fb01        	addw	x,(OFST-63,sp)
1677  03d0 f6            	ld	a,(x)
1678  03d1 ae0001        	ldw	x,#1
1679  03d4 95            	ld	xh,a
1680  03d5 ad1c          	call	_set_mat
1682                     ; 276 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1684  03d7 7b41          	ld	a,(OFST+1,sp)
1685  03d9 a112          	cp	a,#18
1686  03db 2713          	jreq	L744
1689  03dd 96            	ldw	x,sp
1690  03de 1c0004        	addw	x,#OFST-60
1691  03e1 1f01          	ldw	(OFST-63,sp),x
1693  03e3 7b41          	ld	a,(OFST+1,sp)
1694  03e5 5f            	clrw	x
1695  03e6 97            	ld	xl,a
1696  03e7 58            	sllw	x
1697  03e8 72fb01        	addw	x,(OFST-63,sp)
1698  03eb f6            	ld	a,(x)
1699  03ec 5f            	clrw	x
1700  03ed 95            	ld	xh,a
1701  03ee ad03          	call	_set_mat
1703  03f0               L744:
1704                     ; 278 }
1707  03f0 5b41          	addw	sp,#65
1708  03f2 81            	ret
1909                     ; 283 void set_mat(u8 mat_index,bool is_high)
1909                     ; 284 {
1910                     	switch	.text
1911  03f3               _set_mat:
1913  03f3 89            	pushw	x
1914  03f4 5203          	subw	sp,#3
1915       00000003      OFST:	set	3
1918                     ; 322 	if(mat_index==0)//DEBUG_BROKEN
1920  03f6 9e            	ld	a,xh
1921  03f7 4d            	tnz	a
1922  03f8 2609          	jrne	L765
1923                     ; 324 		GPIOx=GPIOD;
1925  03fa ae500f        	ldw	x,#20495
1926  03fd 1f01          	ldw	(OFST-2,sp),x
1928                     ; 325 		GPIO_Pin=GPIO_PIN_4;
1930  03ff a610          	ld	a,#16
1931  0401 6b03          	ld	(OFST+0,sp),a
1933  0403               L765:
1934                     ; 327 	if(mat_index==1)
1936  0403 7b04          	ld	a,(OFST+1,sp)
1937  0405 a101          	cp	a,#1
1938  0407 2609          	jrne	L175
1939                     ; 329 		GPIOx=GPIOD;
1941  0409 ae500f        	ldw	x,#20495
1942  040c 1f01          	ldw	(OFST-2,sp),x
1944                     ; 330 		GPIO_Pin=GPIO_PIN_2;
1946  040e a604          	ld	a,#4
1947  0410 6b03          	ld	(OFST+0,sp),a
1949  0412               L175:
1950                     ; 332 	if(mat_index==2)
1952  0412 7b04          	ld	a,(OFST+1,sp)
1953  0414 a102          	cp	a,#2
1954  0416 2609          	jrne	L375
1955                     ; 334 		GPIOx=GPIOC;
1957  0418 ae500a        	ldw	x,#20490
1958  041b 1f01          	ldw	(OFST-2,sp),x
1960                     ; 335 		GPIO_Pin=GPIO_PIN_7;
1962  041d a680          	ld	a,#128
1963  041f 6b03          	ld	(OFST+0,sp),a
1965  0421               L375:
1966                     ; 337 	if(mat_index==3)
1968  0421 7b04          	ld	a,(OFST+1,sp)
1969  0423 a103          	cp	a,#3
1970  0425 2609          	jrne	L575
1971                     ; 339 		GPIOx=GPIOC;
1973  0427 ae500a        	ldw	x,#20490
1974  042a 1f01          	ldw	(OFST-2,sp),x
1976                     ; 340 		GPIO_Pin=GPIO_PIN_6;
1978  042c a640          	ld	a,#64
1979  042e 6b03          	ld	(OFST+0,sp),a
1981  0430               L575:
1982                     ; 342 	if(mat_index==4)
1984  0430 7b04          	ld	a,(OFST+1,sp)
1985  0432 a104          	cp	a,#4
1986  0434 2609          	jrne	L775
1987                     ; 344 		GPIOx=GPIOC;
1989  0436 ae500a        	ldw	x,#20490
1990  0439 1f01          	ldw	(OFST-2,sp),x
1992                     ; 345 		GPIO_Pin=GPIO_PIN_5;
1994  043b a620          	ld	a,#32
1995  043d 6b03          	ld	(OFST+0,sp),a
1997  043f               L775:
1998                     ; 347 	if(mat_index==5)
2000  043f 7b04          	ld	a,(OFST+1,sp)
2001  0441 a105          	cp	a,#5
2002  0443 2609          	jrne	L106
2003                     ; 349 		GPIOx=GPIOC;
2005  0445 ae500a        	ldw	x,#20490
2006  0448 1f01          	ldw	(OFST-2,sp),x
2008                     ; 350 		GPIO_Pin=GPIO_PIN_4;
2010  044a a610          	ld	a,#16
2011  044c 6b03          	ld	(OFST+0,sp),a
2013  044e               L106:
2014                     ; 352 	if(mat_index==6)
2016  044e 7b04          	ld	a,(OFST+1,sp)
2017  0450 a106          	cp	a,#6
2018  0452 2609          	jrne	L306
2019                     ; 354 		GPIOx=GPIOC;
2021  0454 ae500a        	ldw	x,#20490
2022  0457 1f01          	ldw	(OFST-2,sp),x
2024                     ; 355 		GPIO_Pin=GPIO_PIN_3;
2026  0459 a608          	ld	a,#8
2027  045b 6b03          	ld	(OFST+0,sp),a
2029  045d               L306:
2030                     ; 357 	if(mat_index==7)
2032  045d 7b04          	ld	a,(OFST+1,sp)
2033  045f a107          	cp	a,#7
2034  0461 2609          	jrne	L506
2035                     ; 359 		GPIOx=GPIOA;
2037  0463 ae5000        	ldw	x,#20480
2038  0466 1f01          	ldw	(OFST-2,sp),x
2040                     ; 360 		GPIO_Pin=GPIO_PIN_3;
2042  0468 a608          	ld	a,#8
2043  046a 6b03          	ld	(OFST+0,sp),a
2045  046c               L506:
2046                     ; 362 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2048  046c 0d05          	tnz	(OFST+2,sp)
2049  046e 2708          	jreq	L706
2052  0470 1e01          	ldw	x,(OFST-2,sp)
2053  0472 f6            	ld	a,(x)
2054  0473 1a03          	or	a,(OFST+0,sp)
2055  0475 f7            	ld	(x),a
2057  0476 2007          	jra	L116
2058  0478               L706:
2059                     ; 363 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2061  0478 1e01          	ldw	x,(OFST-2,sp)
2062  047a 7b03          	ld	a,(OFST+0,sp)
2063  047c 43            	cpl	a
2064  047d f4            	and	a,(x)
2065  047e f7            	ld	(x),a
2066  047f               L116:
2067                     ; 364 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2069  047f 1e01          	ldw	x,(OFST-2,sp)
2070  0481 e602          	ld	a,(2,x)
2071  0483 1a03          	or	a,(OFST+0,sp)
2072  0485 e702          	ld	(2,x),a
2073                     ; 365 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2075  0487 1e01          	ldw	x,(OFST-2,sp)
2076  0489 e603          	ld	a,(3,x)
2077  048b 1a03          	or	a,(OFST+0,sp)
2078  048d e703          	ld	(3,x),a
2079                     ; 366 }
2082  048f 5b05          	addw	sp,#5
2083  0491 81            	ret
2159                     ; 369 void flush_leds(u8 led_count)
2159                     ; 370 {
2160                     	switch	.text
2161  0492               _flush_leds:
2163  0492 88            	push	a
2164  0493 5207          	subw	sp,#7
2165       00000007      OFST:	set	7
2168                     ; 371 	u8 led_read_index=0,led_write_index=0;
2172  0495 0f05          	clr	(OFST-2,sp)
2175  0497               L556:
2176                     ; 374 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2178  0497 b689          	ld	a,_pwm_state
2179  0499 a502          	bcp	a,#2
2180  049b 26fa          	jrne	L556
2181                     ; 375 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2183  049d b689          	ld	a,_pwm_state
2184  049f a401          	and	a,#1
2185  04a1 a801          	xor	a,#1
2186  04a3 6b07          	ld	(OFST+0,sp),a
2188                     ; 377 	if(led_count==0) led_count=1;//min value
2190  04a5 0d08          	tnz	(OFST+1,sp)
2191  04a7 2604          	jrne	L166
2194  04a9 a601          	ld	a,#1
2195  04ab 6b08          	ld	(OFST+1,sp),a
2196  04ad               L166:
2197                     ; 378 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2199  04ad 7b08          	ld	a,(OFST+1,sp)
2200  04af 5f            	clrw	x
2201  04b0 97            	ld	xl,a
2202  04b1 4f            	clr	a
2203  04b2 02            	rlwa	x,a
2204  04b3 58            	sllw	x
2205  04b4 58            	sllw	x
2206  04b5 7b07          	ld	a,(OFST+0,sp)
2207  04b7 905f          	clrw	y
2208  04b9 9097          	ld	yl,a
2209  04bb 9058          	sllw	y
2210  04bd 90ef82        	ldw	(_pwm_sleep,y),x
2211                     ; 380 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2213  04c0 0f06          	clr	(OFST-1,sp)
2215  04c2               L366:
2216                     ; 382 		read_brightness=pwm_brightness_buffer[led_read_index];
2218  04c2 7b06          	ld	a,(OFST-1,sp)
2219  04c4 5f            	clrw	x
2220  04c5 97            	ld	xl,a
2221  04c6 e608          	ld	a,(_pwm_brightness_buffer,x)
2222  04c8 5f            	clrw	x
2223  04c9 97            	ld	xl,a
2224  04ca 1f03          	ldw	(OFST-4,sp),x
2226                     ; 383 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2228  04cc 1e03          	ldw	x,(OFST-4,sp)
2229  04ce 2767          	jreq	L176
2230                     ; 385 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2232  04d0 7b05          	ld	a,(OFST-2,sp)
2233  04d2 5f            	clrw	x
2234  04d3 97            	ld	xl,a
2235  04d4 58            	sllw	x
2236  04d5 01            	rrwa	x,a
2237  04d6 1b07          	add	a,(OFST+0,sp)
2238  04d8 2401          	jrnc	L251
2239  04da 5c            	incw	x
2240  04db               L251:
2241  04db 02            	rlwa	x,a
2242  04dc 7b06          	ld	a,(OFST-1,sp)
2243  04de e727          	ld	(_pwm_brightness_index,x),a
2244                     ; 386 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2246  04e0 1e03          	ldw	x,(OFST-4,sp)
2247  04e2 1603          	ldw	y,(OFST-4,sp)
2248  04e4 cd0000        	call	c_imul
2250  04e7 a606          	ld	a,#6
2251  04e9               L451:
2252  04e9 54            	srlw	x
2253  04ea 4a            	dec	a
2254  04eb 26fc          	jrne	L451
2255  04ed 5c            	incw	x
2256  04ee 7b07          	ld	a,(OFST+0,sp)
2257  04f0 905f          	clrw	y
2258  04f2 9097          	ld	yl,a
2259  04f4 9058          	sllw	y
2260  04f6 1701          	ldw	(OFST-6,sp),y
2262  04f8 7b05          	ld	a,(OFST-2,sp)
2263  04fa 905f          	clrw	y
2264  04fc 9097          	ld	yl,a
2265  04fe 9058          	sllw	y
2266  0500 9058          	sllw	y
2267  0502 72f901        	addw	y,(OFST-6,sp)
2268  0505 90ef06        	ldw	(_pwm_brightness,y),x
2269                     ; 387 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2271  0508 7b07          	ld	a,(OFST+0,sp)
2272  050a 5f            	clrw	x
2273  050b 97            	ld	xl,a
2274  050c 58            	sllw	x
2275  050d 7b07          	ld	a,(OFST+0,sp)
2276  050f 905f          	clrw	y
2277  0511 9097          	ld	yl,a
2278  0513 9058          	sllw	y
2279  0515 1701          	ldw	(OFST-6,sp),y
2281  0517 7b05          	ld	a,(OFST-2,sp)
2282  0519 905f          	clrw	y
2283  051b 9097          	ld	yl,a
2284  051d 9058          	sllw	y
2285  051f 9058          	sllw	y
2286  0521 72f901        	addw	y,(OFST-6,sp)
2287  0524 90ee06        	ldw	y,(_pwm_brightness,y)
2288  0527 9001          	rrwa	y,a
2289  0529 e083          	sub	a,(_pwm_sleep+1,x)
2290  052b 9001          	rrwa	y,a
2291  052d e282          	sbc	a,(_pwm_sleep,x)
2292  052f 9001          	rrwa	y,a
2293  0531 9050          	negw	y
2294  0533 ef82          	ldw	(_pwm_sleep,x),y
2295                     ; 388 			led_write_index++;
2297  0535 0c05          	inc	(OFST-2,sp)
2299  0537               L176:
2300                     ; 390 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2302  0537 7b06          	ld	a,(OFST-1,sp)
2303  0539 5f            	clrw	x
2304  053a 97            	ld	xl,a
2305  053b 6f08          	clr	(_pwm_brightness_buffer,x)
2306                     ; 380 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2308  053d 0c06          	inc	(OFST-1,sp)
2312  053f 7b06          	ld	a,(OFST-1,sp)
2313  0541 a11f          	cp	a,#31
2314  0543 2403cc04c2    	jrult	L366
2315                     ; 392 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2317  0548 7b07          	ld	a,(OFST+0,sp)
2318  054a 5f            	clrw	x
2319  054b 97            	ld	xl,a
2320  054c 58            	sllw	x
2321  054d 9093          	ldw	y,x
2322  054f 90ee82        	ldw	y,(_pwm_sleep,y)
2323  0552 90a37c01      	cpw	y,#31745
2324  0556 240b          	jruge	L576
2326  0558 7b07          	ld	a,(OFST+0,sp)
2327  055a 5f            	clrw	x
2328  055b 97            	ld	xl,a
2329  055c 58            	sllw	x
2330  055d e683          	ld	a,(_pwm_sleep+1,x)
2331  055f ea82          	or	a,(_pwm_sleep,x)
2332  0561 260b          	jrne	L376
2333  0563               L576:
2336  0563 7b07          	ld	a,(OFST+0,sp)
2337  0565 5f            	clrw	x
2338  0566 97            	ld	xl,a
2339  0567 58            	sllw	x
2340  0568 90ae0001      	ldw	y,#1
2341  056c ef82          	ldw	(_pwm_sleep,x),y
2342  056e               L376:
2343                     ; 393 	if(led_write_index==0)
2345  056e 0d05          	tnz	(OFST-2,sp)
2346  0570 2622          	jrne	L776
2347                     ; 395 		led_write_index=1;
2349  0572 a601          	ld	a,#1
2350  0574 6b05          	ld	(OFST-2,sp),a
2352                     ; 396 		pwm_sleep[buffer_index]=6<<10;
2354  0576 7b07          	ld	a,(OFST+0,sp)
2355  0578 5f            	clrw	x
2356  0579 97            	ld	xl,a
2357  057a 58            	sllw	x
2358  057b 90ae1800      	ldw	y,#6144
2359  057f ef82          	ldw	(_pwm_sleep,x),y
2360                     ; 397 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2362  0581 7b07          	ld	a,(OFST+0,sp)
2363  0583 5f            	clrw	x
2364  0584 97            	ld	xl,a
2365  0585 a612          	ld	a,#18
2366  0587 e727          	ld	(_pwm_brightness_index,x),a
2367                     ; 398 		pwm_brightness[0][buffer_index]=1;
2369  0589 7b07          	ld	a,(OFST+0,sp)
2370  058b 5f            	clrw	x
2371  058c 97            	ld	xl,a
2372  058d 58            	sllw	x
2373  058e 90ae0001      	ldw	y,#1
2374  0592 ef06          	ldw	(_pwm_brightness,x),y
2375  0594               L776:
2376                     ; 400 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2378  0594 7b07          	ld	a,(OFST+0,sp)
2379  0596 5f            	clrw	x
2380  0597 97            	ld	xl,a
2381  0598 7b05          	ld	a,(OFST-2,sp)
2382  059a e786          	ld	(_pwm_led_count,x),a
2383                     ; 403 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2385  059c 72120089      	bset	_pwm_state,#1
2386                     ; 404 }
2389  05a0 5b08          	addw	sp,#8
2390  05a2 81            	ret
2497                     ; 407 void set_hue_max(u8 index,u16 color)
2497                     ; 408 {
2498                     	switch	.text
2499  05a3               _set_hue_max:
2501  05a3 88            	push	a
2502  05a4 5207          	subw	sp,#7
2503       00000007      OFST:	set	7
2506                     ; 411 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2508  05a6 a6b4          	ld	a,#180
2509  05a8 6b05          	ld	(OFST-2,sp),a
2511                     ; 412 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2513  05aa a63d          	ld	a,#61
2514  05ac 6b01          	ld	(OFST-6,sp),a
2516                     ; 413 	u8 red=0,green=0,blue=0;
2518  05ae 0f02          	clr	(OFST-5,sp)
2522  05b0 0f03          	clr	(OFST-4,sp)
2526  05b2 0f04          	clr	(OFST-3,sp)
2528                     ; 414 	u8 residual=0;
2530  05b4 0f06          	clr	(OFST-1,sp)
2532                     ; 416 	for(iter=0;iter<6;iter++)
2534  05b6 0f07          	clr	(OFST+0,sp)
2536  05b8               L757:
2537                     ; 418 		if(color<0x2AAB)
2539  05b8 1e0b          	ldw	x,(OFST+4,sp)
2540  05ba a32aab        	cpw	x,#10923
2541  05bd 240b          	jruge	L567
2542                     ; 420 			residual=color/BRIGHTNESS_STEP;
2544  05bf 1e0b          	ldw	x,(OFST+4,sp)
2545  05c1 7b01          	ld	a,(OFST-6,sp)
2546  05c3 62            	div	x,a
2547  05c4 01            	rrwa	x,a
2548  05c5 6b06          	ld	(OFST-1,sp),a
2549  05c7 02            	rlwa	x,a
2551                     ; 421 			break;
2553  05c8 200f          	jra	L367
2554  05ca               L567:
2555                     ; 423 		color-=0x2AAB;
2557  05ca 1e0b          	ldw	x,(OFST+4,sp)
2558  05cc 1d2aab        	subw	x,#10923
2559  05cf 1f0b          	ldw	(OFST+4,sp),x
2560                     ; 416 	for(iter=0;iter<6;iter++)
2562  05d1 0c07          	inc	(OFST+0,sp)
2566  05d3 7b07          	ld	a,(OFST+0,sp)
2567  05d5 a106          	cp	a,#6
2568  05d7 25df          	jrult	L757
2569  05d9               L367:
2570                     ; 425 	if(iter==0){ red=MAX_BRIGHTNESS; green=residual; }
2572  05d9 0d07          	tnz	(OFST+0,sp)
2573  05db 2608          	jrne	L767
2576  05dd 7b05          	ld	a,(OFST-2,sp)
2577  05df 6b02          	ld	(OFST-5,sp),a
2581  05e1 7b06          	ld	a,(OFST-1,sp)
2582  05e3 6b03          	ld	(OFST-4,sp),a
2584  05e5               L767:
2585                     ; 426 	if(iter==1){ green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; }
2587  05e5 7b07          	ld	a,(OFST+0,sp)
2588  05e7 a101          	cp	a,#1
2589  05e9 260a          	jrne	L177
2592  05eb 7b05          	ld	a,(OFST-2,sp)
2593  05ed 6b03          	ld	(OFST-4,sp),a
2597  05ef 7b05          	ld	a,(OFST-2,sp)
2598  05f1 1006          	sub	a,(OFST-1,sp)
2599  05f3 6b02          	ld	(OFST-5,sp),a
2601  05f5               L177:
2602                     ; 427 	if(iter==2){ green=MAX_BRIGHTNESS; blue=residual; }
2604  05f5 7b07          	ld	a,(OFST+0,sp)
2605  05f7 a102          	cp	a,#2
2606  05f9 2608          	jrne	L377
2609  05fb 7b05          	ld	a,(OFST-2,sp)
2610  05fd 6b03          	ld	(OFST-4,sp),a
2614  05ff 7b06          	ld	a,(OFST-1,sp)
2615  0601 6b04          	ld	(OFST-3,sp),a
2617  0603               L377:
2618                     ; 428 	if(iter==3){ blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; }
2620  0603 7b07          	ld	a,(OFST+0,sp)
2621  0605 a103          	cp	a,#3
2622  0607 260a          	jrne	L577
2625  0609 7b05          	ld	a,(OFST-2,sp)
2626  060b 6b04          	ld	(OFST-3,sp),a
2630  060d 7b05          	ld	a,(OFST-2,sp)
2631  060f 1006          	sub	a,(OFST-1,sp)
2632  0611 6b03          	ld	(OFST-4,sp),a
2634  0613               L577:
2635                     ; 429 	if(iter==4){ blue=MAX_BRIGHTNESS; red=residual; }
2637  0613 7b07          	ld	a,(OFST+0,sp)
2638  0615 a104          	cp	a,#4
2639  0617 2608          	jrne	L777
2642  0619 7b05          	ld	a,(OFST-2,sp)
2643  061b 6b04          	ld	(OFST-3,sp),a
2647  061d 7b06          	ld	a,(OFST-1,sp)
2648  061f 6b02          	ld	(OFST-5,sp),a
2650  0621               L777:
2651                     ; 430 	if(iter==5){ red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; }
2653  0621 7b07          	ld	a,(OFST+0,sp)
2654  0623 a105          	cp	a,#5
2655  0625 260a          	jrne	L1001
2658  0627 7b05          	ld	a,(OFST-2,sp)
2659  0629 6b02          	ld	(OFST-5,sp),a
2663  062b 7b05          	ld	a,(OFST-2,sp)
2664  062d 1006          	sub	a,(OFST-1,sp)
2665  062f 6b04          	ld	(OFST-3,sp),a
2667  0631               L1001:
2668                     ; 431 	set_rgb(index,0,red);
2670  0631 7b02          	ld	a,(OFST-5,sp)
2671  0633 88            	push	a
2672  0634 7b09          	ld	a,(OFST+2,sp)
2673  0636 5f            	clrw	x
2674  0637 95            	ld	xh,a
2675  0638 ad1c          	call	_set_rgb
2677  063a 84            	pop	a
2678                     ; 432 	set_rgb(index,1,green);
2680  063b 7b03          	ld	a,(OFST-4,sp)
2681  063d 88            	push	a
2682  063e 7b09          	ld	a,(OFST+2,sp)
2683  0640 ae0001        	ldw	x,#1
2684  0643 95            	ld	xh,a
2685  0644 ad10          	call	_set_rgb
2687  0646 84            	pop	a
2688                     ; 433 	set_rgb(index,2,blue);
2690  0647 7b04          	ld	a,(OFST-3,sp)
2691  0649 88            	push	a
2692  064a 7b09          	ld	a,(OFST+2,sp)
2693  064c ae0002        	ldw	x,#2
2694  064f 95            	ld	xh,a
2695  0650 ad04          	call	_set_rgb
2697  0652 84            	pop	a
2698                     ; 434 }
2701  0653 5b08          	addw	sp,#8
2702  0655 81            	ret
2755                     ; 438 void set_rgb(u8 index,u8 color,u8 brightness)
2755                     ; 439 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }
2756                     	switch	.text
2757  0656               _set_rgb:
2759  0656 89            	pushw	x
2760       00000000      OFST:	set	0
2765  0657 9f            	ld	a,xl
2766  0658 97            	ld	xl,a
2767  0659 a606          	ld	a,#6
2768  065b 42            	mul	x,a
2769  065c 01            	rrwa	x,a
2770  065d 1b01          	add	a,(OFST+1,sp)
2771  065f 2401          	jrnc	L261
2772  0661 5c            	incw	x
2773  0662               L261:
2774  0662 02            	rlwa	x,a
2775  0663 7b05          	ld	a,(OFST+5,sp)
2776  0665 e708          	ld	(_pwm_brightness_buffer,x),a
2780  0667 85            	popw	x
2781  0668 81            	ret
2825                     ; 440 void set_white(u8 index,u8 brightness)
2825                     ; 441 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
2826                     	switch	.text
2827  0669               _set_white:
2829  0669 89            	pushw	x
2830       00000000      OFST:	set	0
2835  066a 9e            	ld	a,xh
2836  066b 5f            	clrw	x
2837  066c 97            	ld	xl,a
2838  066d 7b02          	ld	a,(OFST+2,sp)
2839  066f e71b          	ld	(_pwm_brightness_buffer+19,x),a
2843  0671 85            	popw	x
2844  0672 81            	ret
2879                     ; 442 void set_debug(u8 brightness)
2879                     ; 443 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
2880                     	switch	.text
2881  0673               _set_debug:
2887  0673 b71a          	ld	_pwm_brightness_buffer+18,a
2891  0675 81            	ret
3019                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3020                     	switch	.ubsct
3021  0000               _button_pressed_event:
3022  0000 00000000      	ds.b	4
3023                     	xdef	_button_pressed_event
3024  0004               _button_start_ms:
3025  0004 00000000      	ds.b	4
3026                     	xdef	_button_start_ms
3027                     	xdef	_pwm_state
3028                     	xdef	_pwm_visible_index
3029                     	xdef	_pwm_led_count
3030                     	xdef	_pwm_sleep
3031  0008               _pwm_brightness_buffer:
3032  0008 000000000000  	ds.b	31
3033                     	xdef	_pwm_brightness_buffer
3034  0027               _pwm_brightness_index:
3035  0027 000000000000  	ds.b	62
3036                     	xdef	_pwm_brightness_index
3037                     	xdef	_pwm_brightness
3038                     	xdef	_atomic_counter
3039                     	xdef	_frame_counter
3040                     	xref	_UART1_Cmd
3041                     	xref	_UART1_Init
3042                     	xref	_UART1_DeInit
3043                     	xref	_GPIO_ReadInputPin
3044                     	xref	_GPIO_Init
3045                     	xdef	_set_led_on
3046                     	xdef	_set_mat
3047                     	xdef	_get_random
3048                     	xdef	_is_button_down
3049                     	xdef	_clear_button_events
3050                     	xdef	_clear_button_event
3051                     	xdef	_get_button_event
3052                     	xdef	_update_buttons
3053                     	xdef	_is_developer_valid
3054                     	xdef	_set_hue_max
3055                     	xdef	_flush_leds
3056                     	xdef	_set_debug
3057                     	xdef	_set_white
3058                     	xdef	_set_rgb
3059                     	xdef	_millis
3060                     	xdef	_setup_main
3061                     	xdef	_is_application_valid
3062                     	xdef	_setup_serial
3063                     	xdef	_hello_world
3064                     	xref.b	c_lreg
3065                     	xref.b	c_x
3066                     	xref.b	c_y
3086                     	xref	c_xymov
3087                     	xref	c_lgadd
3088                     	xref	c_lzmp
3089                     	xref	c_lsub
3090                     	xref	c_rtol
3091                     	xref	c_uitolx
3092                     	xref	c_lursh
3093                     	xref	c_itolx
3094                     	xref	c_ltor
3095                     	xref	c_imul
3096                     	end
