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
  93                     ; 31 void hello_world()
  93                     ; 32 {//basic program that blinks the debug LED ON/OFF
  95                     	switch	.text
  96  0000               _hello_world:
  98  0000 5204          	subw	sp,#4
  99       00000004      OFST:	set	4
 102                     ; 33 	const u8 cycle_speed=8;//larger=faster
 104  0002 a608          	ld	a,#8
 105  0004 6b02          	ld	(OFST-2,sp),a
 107                     ; 34 	const u8 white_speed=5;//smaller=faster
 109  0006 a605          	ld	a,#5
 110  0008 6b01          	ld	(OFST-3,sp),a
 112                     ; 35 	u16 frame=0;
 114  000a 5f            	clrw	x
 115  000b 1f03          	ldw	(OFST-1,sp),x
 117  000d               L73:
 118                     ; 38 		frame++;
 120  000d 1e03          	ldw	x,(OFST-1,sp)
 121  000f 1c0001        	addw	x,#1
 122  0012 1f03          	ldw	(OFST-1,sp),x
 124                     ; 39 		set_hue_max(0,(frame<<cycle_speed));
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
 137  0021 cd055b        	call	_set_hue_max
 139  0024 85            	popw	x
 140                     ; 40 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
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
 154  0036 cd055b        	call	_set_hue_max
 156  0039 85            	popw	x
 157                     ; 41 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
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
 171  004b cd055b        	call	_set_hue_max
 173  004e 85            	popw	x
 174                     ; 42 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
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
 188  0060 cd055b        	call	_set_hue_max
 190  0063 85            	popw	x
 191                     ; 43 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
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
 205  0075 cd055b        	call	_set_hue_max
 207  0078 85            	popw	x
 208                     ; 44 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
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
 222  008a cd055b        	call	_set_hue_max
 224  008d 85            	popw	x
 225                     ; 47 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
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
 284  00d8 cd0621        	call	_set_white
 286                     ; 48 		flush_leds(7);
 288  00db a607          	ld	a,#7
 289  00dd cd0483        	call	_flush_leds
 292  00e0 ac0d000d      	jpf	L73
 344                     ; 52 u16 get_random(u16 x)
 344                     ; 53 {
 345                     	switch	.text
 346  00e4               _get_random:
 348  00e4 5204          	subw	sp,#4
 349       00000004      OFST:	set	4
 352                     ; 54 	u16 a=1664525;
 354                     ; 55 	u16 c=1013904223;
 356                     ; 56 	return a * x + c;
 358  00e6 90ae660d      	ldw	y,#26125
 359  00ea cd0000        	call	c_imul
 361  00ed 1cf35f        	addw	x,#62303
 364  00f0 5b04          	addw	sp,#4
 365  00f2 81            	ret
 434                     .const:	section	.text
 435  0000               L07:
 436  0000 0000e100      	dc.l	57600
 437                     ; 59 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 437                     ; 60 {
 438                     	switch	.text
 439  00f3               _setup_serial:
 441  00f3 89            	pushw	x
 442       00000000      OFST:	set	0
 445                     ; 61 	if(is_enabled)
 447  00f4 9e            	ld	a,xh
 448  00f5 4d            	tnz	a
 449  00f6 2747          	jreq	L321
 450                     ; 63 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 452  00f8 4bf0          	push	#240
 453  00fa 4b20          	push	#32
 454  00fc ae500f        	ldw	x,#20495
 455  00ff cd0000        	call	_GPIO_Init
 457  0102 85            	popw	x
 458                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 460  0103 4b40          	push	#64
 461  0105 4b40          	push	#64
 462  0107 ae500f        	ldw	x,#20495
 463  010a cd0000        	call	_GPIO_Init
 465  010d 85            	popw	x
 466                     ; 65 		UART1_DeInit();
 468  010e cd0000        	call	_UART1_DeInit
 470                     ; 66 		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
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
 495                     ; 67 		UART1_Cmd(ENABLE);
 497  0138 a601          	ld	a,#1
 498  013a cd0000        	call	_UART1_Cmd
 501  013d 201d          	jra	L521
 502  013f               L321:
 503                     ; 69 		UART1_Cmd(DISABLE);
 505  013f 4f            	clr	a
 506  0140 cd0000        	call	_UART1_Cmd
 508                     ; 70 		UART1_DeInit();
 510  0143 cd0000        	call	_UART1_DeInit
 512                     ; 71 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 514  0146 4b40          	push	#64
 515  0148 4b20          	push	#32
 516  014a ae500f        	ldw	x,#20495
 517  014d cd0000        	call	_GPIO_Init
 519  0150 85            	popw	x
 520                     ; 72 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 522  0151 4b40          	push	#64
 523  0153 4b40          	push	#64
 524  0155 ae500f        	ldw	x,#20495
 525  0158 cd0000        	call	_GPIO_Init
 527  015b 85            	popw	x
 528  015c               L521:
 529                     ; 74 }
 532  015c 85            	popw	x
 533  015d 81            	ret
 558                     ; 77 bool is_application_valid()
 558                     ; 78 {
 559                     	switch	.text
 560  015e               _is_application_valid:
 564                     ; 79 	return 1;//!is_button_down(2) && !get_button_event(0,1);
 566  015e a601          	ld	a,#1
 569  0160 81            	ret
 593                     ; 83 bool is_developer_valid()
 593                     ; 84 {
 594                     	switch	.text
 595  0161               _is_developer_valid:
 599                     ; 85 	return 0;//is_button_down(2) && !get_button_event(0,1);
 601  0161 4f            	clr	a
 604  0162 81            	ret
 629                     ; 88 void setup_main()
 629                     ; 89 {
 630                     	switch	.text
 631  0163               _setup_main:
 635                     ; 90 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 637  0163 c650c6        	ld	a,20678
 638  0166 a4e7          	and	a,#231
 639  0168 c750c6        	ld	20678,a
 640                     ; 92 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 642  016b 4b40          	push	#64
 643  016d 4b02          	push	#2
 644  016f ae500f        	ldw	x,#20495
 645  0172 cd0000        	call	_GPIO_Init
 647  0175 85            	popw	x
 648                     ; 96 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 650  0176 3505530e      	mov	21262,#5
 651                     ; 97 	TIM2->ARRH= 0;// init auto reload register
 653  017a 725f530f      	clr	21263
 654                     ; 98 	TIM2->ARRL= 255;// init auto reload register
 656  017e 35ff5310      	mov	21264,#255
 657                     ; 100 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 659  0182 c65300        	ld	a,21248
 660  0185 aa05          	or	a,#5
 661  0187 c75300        	ld	21248,a
 662                     ; 102 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 664  018a 35015303      	mov	21251,#1
 665                     ; 103 	enableInterrupts();
 668  018e 9a            rim
 670                     ; 104 }
 674  018f 81            	ret
 698                     ; 106 u32 millis()
 698                     ; 107 {
 699                     	switch	.text
 700  0190               _millis:
 704                     ; 108 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 706  0190 ae0002        	ldw	x,#_atomic_counter
 707  0193 cd0000        	call	c_ltor
 709  0196 a609          	ld	a,#9
 710  0198 cd0000        	call	c_lursh
 714  019b 81            	ret
 772                     ; 114 void update_buttons()
 772                     ; 115 {
 773                     	switch	.text
 774  019c               _update_buttons:
 776  019c 5208          	subw	sp,#8
 777       00000008      OFST:	set	8
 780                     ; 116 	bool is_any_down=0;
 782  019e 0f05          	clr	(OFST-3,sp)
 784                     ; 118 	u16 elapsed_pressed_ms=millis()-button_start_ms;
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
 803                     ; 119 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 805  01b9 0f08          	clr	(OFST+0,sp)
 807  01bb               L512:
 808                     ; 121 		if(is_button_down(button_index))
 810  01bb 7b08          	ld	a,(OFST+0,sp)
 811  01bd cd0268        	call	_is_button_down
 813  01c0 4d            	tnz	a
 814  01c1 271b          	jreq	L322
 815                     ; 123 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 817  01c3 ae0004        	ldw	x,#_button_start_ms
 818  01c6 cd0000        	call	c_lzmp
 820  01c9 2608          	jrne	L522
 823  01cb adc3          	call	_millis
 825  01cd ae0004        	ldw	x,#_button_start_ms
 826  01d0 cd0000        	call	c_rtol
 828  01d3               L522:
 829                     ; 124 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 831  01d3 a6ff          	ld	a,#255
 832  01d5 cd062b        	call	_set_debug
 834                     ; 125 			is_any_down=1;
 836  01d8 a601          	ld	a,#1
 837  01da 6b05          	ld	(OFST-3,sp),a
 840  01dc 2022          	jra	L722
 841  01de               L322:
 842                     ; 127 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
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
 858                     ; 128 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
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
 872                     ; 119 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 874  0200 0c08          	inc	(OFST+0,sp)
 878  0202 7b08          	ld	a,(OFST+0,sp)
 879  0204 a102          	cp	a,#2
 880  0206 25b3          	jrult	L512
 881                     ; 132 	if(!is_any_down) button_start_ms=0;
 883  0208 0d05          	tnz	(OFST-3,sp)
 884  020a 260a          	jrne	L732
 887  020c ae0000        	ldw	x,#0
 888  020f bf06          	ldw	_button_start_ms+2,x
 889  0211 ae0000        	ldw	x,#0
 890  0214 bf04          	ldw	_button_start_ms,x
 891  0216               L732:
 892                     ; 133 }
 895  0216 5b08          	addw	sp,#8
 896  0218 81            	ret
 942                     ; 136 bool get_button_event(u8 button_index,bool is_long)
 942                     ; 137 { return button_pressed_event[button_index][is_long]; }
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
1022                     ; 140 bool clear_button_event(u8 button_index,bool is_long)
1022                     ; 141 {
1023                     	switch	.text
1024  0229               _clear_button_event:
1026  0229 89            	pushw	x
1027  022a 88            	push	a
1028       00000001      OFST:	set	1
1031                     ; 142 	bool out=button_pressed_event[button_index][is_long];
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
1046                     ; 143 	button_pressed_event[button_index][is_long]=0;
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
1059                     ; 144 	return out;
1061  0248 7b01          	ld	a,(OFST+0,sp)
1064  024a 5b03          	addw	sp,#3
1065  024c 81            	ret
1101                     ; 147 void clear_button_events()
1101                     ; 148 {
1102                     	switch	.text
1103  024d               _clear_button_events:
1105  024d 88            	push	a
1106       00000001      OFST:	set	1
1109                     ; 150 	for(iter=0;iter<BUTTON_COUNT;iter++)
1111  024e 0f01          	clr	(OFST+0,sp)
1113  0250               L723:
1114                     ; 152 		clear_button_event(iter,0);
1116  0250 7b01          	ld	a,(OFST+0,sp)
1117  0252 5f            	clrw	x
1118  0253 95            	ld	xh,a
1119  0254 add3          	call	_clear_button_event
1121                     ; 153 		clear_button_event(iter,1);
1123  0256 7b01          	ld	a,(OFST+0,sp)
1124  0258 ae0001        	ldw	x,#1
1125  025b 95            	ld	xh,a
1126  025c adcb          	call	_clear_button_event
1128                     ; 150 	for(iter=0;iter<BUTTON_COUNT;iter++)
1130  025e 0c01          	inc	(OFST+0,sp)
1134  0260 7b01          	ld	a,(OFST+0,sp)
1135  0262 a102          	cp	a,#2
1136  0264 25ea          	jrult	L723
1137                     ; 155 }
1140  0266 84            	pop	a
1141  0267 81            	ret
1177                     ; 158 bool is_button_down(u8 index)
1177                     ; 159 {
1178                     	switch	.text
1179  0268               _is_button_down:
1183                     ; 160 	switch(index)
1186                     ; 164 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1188  0268 4d            	tnz	a
1189  0269 2708          	jreq	L533
1190  026b 4a            	dec	a
1191  026c 2718          	jreq	L733
1192  026e 4a            	dec	a
1193  026f 2728          	jreq	L143
1194  0271 2039          	jra	L363
1195  0273               L533:
1196                     ; 162 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1198  0273 4b20          	push	#32
1199  0275 ae500f        	ldw	x,#20495
1200  0278 cd0000        	call	_GPIO_ReadInputPin
1202  027b 5b01          	addw	sp,#1
1203  027d 4d            	tnz	a
1204  027e 2604          	jrne	L421
1205  0280 a601          	ld	a,#1
1206  0282 2001          	jra	L621
1207  0284               L421:
1208  0284 4f            	clr	a
1209  0285               L621:
1212  0285 81            	ret
1213  0286               L733:
1214                     ; 163 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1217  0286 4b40          	push	#64
1218  0288 ae500f        	ldw	x,#20495
1219  028b cd0000        	call	_GPIO_ReadInputPin
1221  028e 5b01          	addw	sp,#1
1222  0290 4d            	tnz	a
1223  0291 2604          	jrne	L031
1224  0293 a601          	ld	a,#1
1225  0295 2001          	jra	L231
1226  0297               L031:
1227  0297 4f            	clr	a
1228  0298               L231:
1231  0298 81            	ret
1232  0299               L143:
1233                     ; 164 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1236  0299 4b02          	push	#2
1237  029b ae500f        	ldw	x,#20495
1238  029e cd0000        	call	_GPIO_ReadInputPin
1240  02a1 5b01          	addw	sp,#1
1241  02a3 4d            	tnz	a
1242  02a4 2604          	jrne	L431
1243  02a6 a601          	ld	a,#1
1244  02a8 2001          	jra	L631
1245  02aa               L431:
1246  02aa 4f            	clr	a
1247  02ab               L631:
1250  02ab 81            	ret
1251  02ac               L363:
1252                     ; 166 	return 0;
1254  02ac 4f            	clr	a
1257  02ad 81            	ret
1311                     ; 170 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1313                     	switch	.text
1314  02ae               f_TIM2_UPD_OVF_IRQHandler:
1316  02ae 8a            	push	cc
1317  02af 84            	pop	a
1318  02b0 a4bf          	and	a,#191
1319  02b2 88            	push	a
1320  02b3 86            	pop	cc
1321       00000005      OFST:	set	5
1322  02b4 3b0002        	push	c_x+2
1323  02b7 be00          	ldw	x,c_x
1324  02b9 89            	pushw	x
1325  02ba 3b0002        	push	c_y+2
1326  02bd be00          	ldw	x,c_y
1327  02bf 89            	pushw	x
1328  02c0 be02          	ldw	x,c_lreg+2
1329  02c2 89            	pushw	x
1330  02c3 be00          	ldw	x,c_lreg
1331  02c5 89            	pushw	x
1332  02c6 5205          	subw	sp,#5
1335                     ; 171 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1337  02c8 b689          	ld	a,_pwm_state
1338  02ca a401          	and	a,#1
1339  02cc 6b05          	ld	(OFST+0,sp),a
1341                     ; 172 	u16 sleep_counts=1;
1343  02ce ae0001        	ldw	x,#1
1344  02d1 1f03          	ldw	(OFST-2,sp),x
1346                     ; 174 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1348  02d3 c6500c        	ld	a,20492
1349  02d6 a407          	and	a,#7
1350  02d8 c7500c        	ld	20492,a
1351                     ; 175 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1353  02db 72155011      	bres	20497,#2
1354                     ; 176 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1356  02df 72175002      	bres	20482,#3
1357                     ; 177 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1359  02e3 c6500d        	ld	a,20493
1360  02e6 a407          	and	a,#7
1361  02e8 c7500d        	ld	20493,a
1362                     ; 178 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1364  02eb 72155012      	bres	20498,#2
1365                     ; 179 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1367  02ef 72175003      	bres	20483,#3
1368                     ; 181 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1370  02f3 72195011      	bres	20497,#4
1371                     ; 182 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1373  02f7 72195012      	bres	20498,#4
1374                     ; 184   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1376  02fb 72115300      	bres	21248,#0
1377                     ; 185 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1379  02ff 7b05          	ld	a,(OFST+0,sp)
1380  0301 5f            	clrw	x
1381  0302 97            	ld	xl,a
1382  0303 e686          	ld	a,(_pwm_led_count,x)
1383  0305 b188          	cp	a,_pwm_visible_index
1384  0307 2609          	jrne	L704
1385                     ; 187 		sleep_counts=pwm_sleep[buffer_index];
1387  0309 7b05          	ld	a,(OFST+0,sp)
1388  030b 5f            	clrw	x
1389  030c 97            	ld	xl,a
1390  030d 58            	sllw	x
1391  030e ee82          	ldw	x,(_pwm_sleep,x)
1392  0310 1f03          	ldw	(OFST-2,sp),x
1394  0312               L704:
1395                     ; 189 	if(pwm_visible_index>pwm_led_count[buffer_index])
1397  0312 7b05          	ld	a,(OFST+0,sp)
1398  0314 5f            	clrw	x
1399  0315 97            	ld	xl,a
1400  0316 e686          	ld	a,(_pwm_led_count,x)
1401  0318 b188          	cp	a,_pwm_visible_index
1402  031a 241b          	jruge	L114
1403                     ; 191 		frame_counter++;
1405  031c be00          	ldw	x,_frame_counter
1406  031e 1c0001        	addw	x,#1
1407  0321 bf00          	ldw	_frame_counter,x
1408                     ; 192 		pwm_visible_index=0;//formally start new frame
1410  0323 3f88          	clr	_pwm_visible_index
1411                     ; 193 		if(pwm_state&0x02)
1413  0325 b689          	ld	a,_pwm_state
1414  0327 a502          	bcp	a,#2
1415  0329 270c          	jreq	L114
1416                     ; 195 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1418  032b b689          	ld	a,_pwm_state
1419  032d a803          	xor	a,#3
1420  032f b789          	ld	_pwm_state,a
1421                     ; 196 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1423  0331 b689          	ld	a,_pwm_state
1424  0333 a401          	and	a,#1
1425  0335 6b05          	ld	(OFST+0,sp),a
1427  0337               L114:
1428                     ; 199 	if(pwm_visible_index<pwm_led_count[buffer_index])
1430  0337 7b05          	ld	a,(OFST+0,sp)
1431  0339 5f            	clrw	x
1432  033a 97            	ld	xl,a
1433  033b e686          	ld	a,(_pwm_led_count,x)
1434  033d b188          	cp	a,_pwm_visible_index
1435  033f 2324          	jrule	L514
1436                     ; 201 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1438  0341 7b05          	ld	a,(OFST+0,sp)
1439  0343 5f            	clrw	x
1440  0344 97            	ld	xl,a
1441  0345 58            	sllw	x
1442  0346 1f01          	ldw	(OFST-4,sp),x
1444  0348 b688          	ld	a,_pwm_visible_index
1445  034a 97            	ld	xl,a
1446  034b a604          	ld	a,#4
1447  034d 42            	mul	x,a
1448  034e 72fb01        	addw	x,(OFST-4,sp)
1449  0351 ee06          	ldw	x,(_pwm_brightness,x)
1450  0353 1f03          	ldw	(OFST-2,sp),x
1452                     ; 202 		set_led(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1454  0355 b688          	ld	a,_pwm_visible_index
1455  0357 5f            	clrw	x
1456  0358 97            	ld	xl,a
1457  0359 58            	sllw	x
1458  035a 01            	rrwa	x,a
1459  035b 1b05          	add	a,(OFST+0,sp)
1460  035d 2401          	jrnc	L241
1461  035f 5c            	incw	x
1462  0360               L241:
1463  0360 02            	rlwa	x,a
1464  0361 e627          	ld	a,(_pwm_brightness_index,x)
1465  0363 ad3e          	call	_set_led
1467  0365               L514:
1468                     ; 204 	pwm_visible_index++;
1470  0365 3c88          	inc	_pwm_visible_index
1471                     ; 205 	atomic_counter+=sleep_counts;
1473  0367 1e03          	ldw	x,(OFST-2,sp)
1474  0369 cd0000        	call	c_uitolx
1476  036c ae0002        	ldw	x,#_atomic_counter
1477  036f cd0000        	call	c_lgadd
1479                     ; 207   TIM2->CNTRH = 0;// Set the high byte of the counter
1481  0372 725f530c      	clr	21260
1482                     ; 208   TIM2->CNTRL = 0;// Set the low byte of the counter
1484  0376 725f530d      	clr	21261
1485                     ; 209 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1487  037a 7b03          	ld	a,(OFST-2,sp)
1488  037c c7530f        	ld	21263,a
1489                     ; 210 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1491  037f 7b04          	ld	a,(OFST-1,sp)
1492  0381 a4ff          	and	a,#255
1493  0383 c75310        	ld	21264,a
1494                     ; 212 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1496  0386 72115304      	bres	21252,#0
1497                     ; 213   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1499  038a 72105300      	bset	21248,#0
1500                     ; 214 }
1503  038e 5b05          	addw	sp,#5
1504  0390 85            	popw	x
1505  0391 bf00          	ldw	c_lreg,x
1506  0393 85            	popw	x
1507  0394 bf02          	ldw	c_lreg+2,x
1508  0396 85            	popw	x
1509  0397 bf00          	ldw	c_y,x
1510  0399 320002        	pop	c_y+2
1511  039c 85            	popw	x
1512  039d bf00          	ldw	c_x,x
1513  039f 320002        	pop	c_x+2
1514  03a2 80            	iret
1516                     	switch	.const
1517  0004               L714_led_lookup:
1518  0004 04            	dc.b	4
1519  0005 03            	dc.b	3
1520  0006 03            	dc.b	3
1521  0007 04            	dc.b	4
1522  0008 00            	dc.b	0
1523  0009 05            	dc.b	5
1524  000a 00            	dc.b	0
1525  000b 04            	dc.b	4
1526  000c 00            	dc.b	0
1527  000d 03            	dc.b	3
1528  000e 00            	dc.b	0
1529  000f 01            	dc.b	1
1530  0010 05            	dc.b	5
1531  0011 03            	dc.b	3
1532  0012 03            	dc.b	3
1533  0013 05            	dc.b	5
1534  0014 00            	dc.b	0
1535  0015 06            	dc.b	6
1536  0016 01            	dc.b	1
1537  0017 04            	dc.b	4
1538  0018 01            	dc.b	1
1539  0019 03            	dc.b	3
1540  001a 00            	dc.b	0
1541  001b 02            	dc.b	2
1542  001c 06            	dc.b	6
1543  001d 03            	dc.b	3
1544  001e 03            	dc.b	3
1545  001f 06            	dc.b	6
1546  0020 01            	dc.b	1
1547  0021 06            	dc.b	6
1548  0022 02            	dc.b	2
1549  0023 04            	dc.b	4
1550  0024 02            	dc.b	2
1551  0025 03            	dc.b	3
1552  0026 01            	dc.b	1
1553  0027 02            	dc.b	2
1554  0028 07            	dc.b	7
1555  0029 07            	dc.b	7
1556  002a 03            	dc.b	3
1557  002b 00            	dc.b	0
1558  002c 03            	dc.b	3
1559  002d 01            	dc.b	1
1560  002e 03            	dc.b	3
1561  002f 02            	dc.b	2
1562  0030 04            	dc.b	4
1563  0031 00            	dc.b	0
1564  0032 01            	dc.b	1
1565  0033 05            	dc.b	5
1566  0034 02            	dc.b	2
1567  0035 05            	dc.b	5
1568  0036 04            	dc.b	4
1569  0037 01            	dc.b	1
1570  0038 04            	dc.b	4
1571  0039 02            	dc.b	2
1572  003a 02            	dc.b	2
1573  003b 06            	dc.b	6
1574  003c 04            	dc.b	4
1575  003d 06            	dc.b	6
1576  003e 04            	dc.b	4
1577  003f 05            	dc.b	5
1578  0040 05            	dc.b	5
1579  0041 06            	dc.b	6
1623                     ; 217 void set_led(u8 led_index)
1623                     ; 218 {
1625                     	switch	.text
1626  03a3               _set_led:
1628  03a3 88            	push	a
1629  03a4 5240          	subw	sp,#64
1630       00000040      OFST:	set	64
1633                     ; 255 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1633                     ; 256 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1633                     ; 257 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1633                     ; 258 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1633                     ; 259 		{7,7},//debug; GND is tied low, no charlieplexing involved
1633                     ; 260 		{3,0},//LED6
1633                     ; 261 		{3,1},//LED4
1633                     ; 262 		{3,2},//LED5
1633                     ; 263 		{4,0},//LED14
1633                     ; 264 		{1,5},//LED8
1633                     ; 265 		{2,5},//LED9
1633                     ; 266 		{4,1},//LED10
1633                     ; 267 		{4,2},//LED16
1633                     ; 268 		{2,6},//LED17
1633                     ; 269 		{4,6},//LED12
1633                     ; 270 		{4,5},//LED13
1633                     ; 271 		{5,6} //LED11
1633                     ; 272 	};
1635  03a6 96            	ldw	x,sp
1636  03a7 1c0003        	addw	x,#OFST-61
1637  03aa 90ae0004      	ldw	y,#L714_led_lookup
1638  03ae a63e          	ld	a,#62
1639  03b0 cd0000        	call	c_xymov
1641                     ; 273 	set_mat(led_lookup[led_index][0],1);
1643  03b3 96            	ldw	x,sp
1644  03b4 1c0003        	addw	x,#OFST-61
1645  03b7 1f01          	ldw	(OFST-63,sp),x
1647  03b9 7b41          	ld	a,(OFST+1,sp)
1648  03bb 5f            	clrw	x
1649  03bc 97            	ld	xl,a
1650  03bd 58            	sllw	x
1651  03be 72fb01        	addw	x,(OFST-63,sp)
1652  03c1 f6            	ld	a,(x)
1653  03c2 ae0001        	ldw	x,#1
1654  03c5 95            	ld	xh,a
1655  03c6 ad1c          	call	_set_mat
1657                     ; 275 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1659  03c8 7b41          	ld	a,(OFST+1,sp)
1660  03ca a112          	cp	a,#18
1661  03cc 2713          	jreq	L344
1664  03ce 96            	ldw	x,sp
1665  03cf 1c0004        	addw	x,#OFST-60
1666  03d2 1f01          	ldw	(OFST-63,sp),x
1668  03d4 7b41          	ld	a,(OFST+1,sp)
1669  03d6 5f            	clrw	x
1670  03d7 97            	ld	xl,a
1671  03d8 58            	sllw	x
1672  03d9 72fb01        	addw	x,(OFST-63,sp)
1673  03dc f6            	ld	a,(x)
1674  03dd 5f            	clrw	x
1675  03de 95            	ld	xh,a
1676  03df ad03          	call	_set_mat
1678  03e1               L344:
1679                     ; 277 }
1682  03e1 5b41          	addw	sp,#65
1683  03e3 81            	ret
1884                     ; 280 void set_mat(u8 mat_index,bool is_high)
1884                     ; 281 {
1885                     	switch	.text
1886  03e4               _set_mat:
1888  03e4 89            	pushw	x
1889  03e5 5203          	subw	sp,#3
1890       00000003      OFST:	set	3
1893                     ; 319 	if(mat_index==0)//DEBUG_BROKEN
1895  03e7 9e            	ld	a,xh
1896  03e8 4d            	tnz	a
1897  03e9 2609          	jrne	L365
1898                     ; 321 		GPIOx=GPIOD;
1900  03eb ae500f        	ldw	x,#20495
1901  03ee 1f01          	ldw	(OFST-2,sp),x
1903                     ; 322 		GPIO_Pin=GPIO_PIN_4;
1905  03f0 a610          	ld	a,#16
1906  03f2 6b03          	ld	(OFST+0,sp),a
1908  03f4               L365:
1909                     ; 324 	if(mat_index==1)
1911  03f4 7b04          	ld	a,(OFST+1,sp)
1912  03f6 a101          	cp	a,#1
1913  03f8 2609          	jrne	L565
1914                     ; 326 		GPIOx=GPIOD;
1916  03fa ae500f        	ldw	x,#20495
1917  03fd 1f01          	ldw	(OFST-2,sp),x
1919                     ; 327 		GPIO_Pin=GPIO_PIN_2;
1921  03ff a604          	ld	a,#4
1922  0401 6b03          	ld	(OFST+0,sp),a
1924  0403               L565:
1925                     ; 329 	if(mat_index==2)
1927  0403 7b04          	ld	a,(OFST+1,sp)
1928  0405 a102          	cp	a,#2
1929  0407 2609          	jrne	L765
1930                     ; 331 		GPIOx=GPIOC;
1932  0409 ae500a        	ldw	x,#20490
1933  040c 1f01          	ldw	(OFST-2,sp),x
1935                     ; 332 		GPIO_Pin=GPIO_PIN_7;
1937  040e a680          	ld	a,#128
1938  0410 6b03          	ld	(OFST+0,sp),a
1940  0412               L765:
1941                     ; 334 	if(mat_index==3)
1943  0412 7b04          	ld	a,(OFST+1,sp)
1944  0414 a103          	cp	a,#3
1945  0416 2609          	jrne	L175
1946                     ; 336 		GPIOx=GPIOC;
1948  0418 ae500a        	ldw	x,#20490
1949  041b 1f01          	ldw	(OFST-2,sp),x
1951                     ; 337 		GPIO_Pin=GPIO_PIN_6;
1953  041d a640          	ld	a,#64
1954  041f 6b03          	ld	(OFST+0,sp),a
1956  0421               L175:
1957                     ; 339 	if(mat_index==4)
1959  0421 7b04          	ld	a,(OFST+1,sp)
1960  0423 a104          	cp	a,#4
1961  0425 2609          	jrne	L375
1962                     ; 341 		GPIOx=GPIOC;
1964  0427 ae500a        	ldw	x,#20490
1965  042a 1f01          	ldw	(OFST-2,sp),x
1967                     ; 342 		GPIO_Pin=GPIO_PIN_5;
1969  042c a620          	ld	a,#32
1970  042e 6b03          	ld	(OFST+0,sp),a
1972  0430               L375:
1973                     ; 344 	if(mat_index==5)
1975  0430 7b04          	ld	a,(OFST+1,sp)
1976  0432 a105          	cp	a,#5
1977  0434 2609          	jrne	L575
1978                     ; 346 		GPIOx=GPIOC;
1980  0436 ae500a        	ldw	x,#20490
1981  0439 1f01          	ldw	(OFST-2,sp),x
1983                     ; 347 		GPIO_Pin=GPIO_PIN_4;
1985  043b a610          	ld	a,#16
1986  043d 6b03          	ld	(OFST+0,sp),a
1988  043f               L575:
1989                     ; 349 	if(mat_index==6)
1991  043f 7b04          	ld	a,(OFST+1,sp)
1992  0441 a106          	cp	a,#6
1993  0443 2609          	jrne	L775
1994                     ; 351 		GPIOx=GPIOC;
1996  0445 ae500a        	ldw	x,#20490
1997  0448 1f01          	ldw	(OFST-2,sp),x
1999                     ; 352 		GPIO_Pin=GPIO_PIN_3;
2001  044a a608          	ld	a,#8
2002  044c 6b03          	ld	(OFST+0,sp),a
2004  044e               L775:
2005                     ; 354 	if(mat_index==7)
2007  044e 7b04          	ld	a,(OFST+1,sp)
2008  0450 a107          	cp	a,#7
2009  0452 2609          	jrne	L106
2010                     ; 356 		GPIOx=GPIOA;
2012  0454 ae5000        	ldw	x,#20480
2013  0457 1f01          	ldw	(OFST-2,sp),x
2015                     ; 357 		GPIO_Pin=GPIO_PIN_3;
2017  0459 a608          	ld	a,#8
2018  045b 6b03          	ld	(OFST+0,sp),a
2020  045d               L106:
2021                     ; 359 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2023  045d 0d05          	tnz	(OFST+2,sp)
2024  045f 2708          	jreq	L306
2027  0461 1e01          	ldw	x,(OFST-2,sp)
2028  0463 f6            	ld	a,(x)
2029  0464 1a03          	or	a,(OFST+0,sp)
2030  0466 f7            	ld	(x),a
2032  0467 2007          	jra	L506
2033  0469               L306:
2034                     ; 360 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2036  0469 1e01          	ldw	x,(OFST-2,sp)
2037  046b 7b03          	ld	a,(OFST+0,sp)
2038  046d 43            	cpl	a
2039  046e f4            	and	a,(x)
2040  046f f7            	ld	(x),a
2041  0470               L506:
2042                     ; 361 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2044  0470 1e01          	ldw	x,(OFST-2,sp)
2045  0472 e602          	ld	a,(2,x)
2046  0474 1a03          	or	a,(OFST+0,sp)
2047  0476 e702          	ld	(2,x),a
2048                     ; 362 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2050  0478 1e01          	ldw	x,(OFST-2,sp)
2051  047a e603          	ld	a,(3,x)
2052  047c 1a03          	or	a,(OFST+0,sp)
2053  047e e703          	ld	(3,x),a
2054                     ; 363 }
2057  0480 5b05          	addw	sp,#5
2058  0482 81            	ret
2134                     ; 366 void flush_leds(u8 led_count)
2134                     ; 367 {
2135                     	switch	.text
2136  0483               _flush_leds:
2138  0483 88            	push	a
2139  0484 5207          	subw	sp,#7
2140       00000007      OFST:	set	7
2143                     ; 368 	u8 led_read_index=0,led_write_index=0;
2147  0486 0f05          	clr	(OFST-2,sp)
2150  0488               L156:
2151                     ; 371 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2153  0488 b689          	ld	a,_pwm_state
2154  048a a502          	bcp	a,#2
2155  048c 26fa          	jrne	L156
2156                     ; 372 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2158  048e b689          	ld	a,_pwm_state
2159  0490 a401          	and	a,#1
2160  0492 a801          	xor	a,#1
2161  0494 6b07          	ld	(OFST+0,sp),a
2163                     ; 374 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2165  0496 7b08          	ld	a,(OFST+1,sp)
2166  0498 5f            	clrw	x
2167  0499 97            	ld	xl,a
2168  049a 4f            	clr	a
2169  049b 02            	rlwa	x,a
2170  049c 58            	sllw	x
2171  049d 58            	sllw	x
2172  049e 7b07          	ld	a,(OFST+0,sp)
2173  04a0 905f          	clrw	y
2174  04a2 9097          	ld	yl,a
2175  04a4 9058          	sllw	y
2176  04a6 90ef82        	ldw	(_pwm_sleep,y),x
2177                     ; 376 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2179  04a9 0f06          	clr	(OFST-1,sp)
2181  04ab               L556:
2182                     ; 378 		read_brightness=pwm_brightness_buffer[led_read_index];
2184  04ab 7b06          	ld	a,(OFST-1,sp)
2185  04ad 5f            	clrw	x
2186  04ae 97            	ld	xl,a
2187  04af e608          	ld	a,(_pwm_brightness_buffer,x)
2188  04b1 5f            	clrw	x
2189  04b2 97            	ld	xl,a
2190  04b3 1f03          	ldw	(OFST-4,sp),x
2192                     ; 379 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2194  04b5 1e03          	ldw	x,(OFST-4,sp)
2195  04b7 2767          	jreq	L366
2196                     ; 381 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2198  04b9 7b05          	ld	a,(OFST-2,sp)
2199  04bb 5f            	clrw	x
2200  04bc 97            	ld	xl,a
2201  04bd 58            	sllw	x
2202  04be 01            	rrwa	x,a
2203  04bf 1b07          	add	a,(OFST+0,sp)
2204  04c1 2401          	jrnc	L251
2205  04c3 5c            	incw	x
2206  04c4               L251:
2207  04c4 02            	rlwa	x,a
2208  04c5 7b06          	ld	a,(OFST-1,sp)
2209  04c7 e727          	ld	(_pwm_brightness_index,x),a
2210                     ; 382 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2212  04c9 1e03          	ldw	x,(OFST-4,sp)
2213  04cb 1603          	ldw	y,(OFST-4,sp)
2214  04cd cd0000        	call	c_imul
2216  04d0 a606          	ld	a,#6
2217  04d2               L451:
2218  04d2 54            	srlw	x
2219  04d3 4a            	dec	a
2220  04d4 26fc          	jrne	L451
2221  04d6 5c            	incw	x
2222  04d7 7b07          	ld	a,(OFST+0,sp)
2223  04d9 905f          	clrw	y
2224  04db 9097          	ld	yl,a
2225  04dd 9058          	sllw	y
2226  04df 1701          	ldw	(OFST-6,sp),y
2228  04e1 7b05          	ld	a,(OFST-2,sp)
2229  04e3 905f          	clrw	y
2230  04e5 9097          	ld	yl,a
2231  04e7 9058          	sllw	y
2232  04e9 9058          	sllw	y
2233  04eb 72f901        	addw	y,(OFST-6,sp)
2234  04ee 90ef06        	ldw	(_pwm_brightness,y),x
2235                     ; 383 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2237  04f1 7b07          	ld	a,(OFST+0,sp)
2238  04f3 5f            	clrw	x
2239  04f4 97            	ld	xl,a
2240  04f5 58            	sllw	x
2241  04f6 7b07          	ld	a,(OFST+0,sp)
2242  04f8 905f          	clrw	y
2243  04fa 9097          	ld	yl,a
2244  04fc 9058          	sllw	y
2245  04fe 1701          	ldw	(OFST-6,sp),y
2247  0500 7b05          	ld	a,(OFST-2,sp)
2248  0502 905f          	clrw	y
2249  0504 9097          	ld	yl,a
2250  0506 9058          	sllw	y
2251  0508 9058          	sllw	y
2252  050a 72f901        	addw	y,(OFST-6,sp)
2253  050d 90ee06        	ldw	y,(_pwm_brightness,y)
2254  0510 9001          	rrwa	y,a
2255  0512 e083          	sub	a,(_pwm_sleep+1,x)
2256  0514 9001          	rrwa	y,a
2257  0516 e282          	sbc	a,(_pwm_sleep,x)
2258  0518 9001          	rrwa	y,a
2259  051a 9050          	negw	y
2260  051c ef82          	ldw	(_pwm_sleep,x),y
2261                     ; 384 			led_write_index++;
2263  051e 0c05          	inc	(OFST-2,sp)
2265  0520               L366:
2266                     ; 386 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2268  0520 7b06          	ld	a,(OFST-1,sp)
2269  0522 5f            	clrw	x
2270  0523 97            	ld	xl,a
2271  0524 6f08          	clr	(_pwm_brightness_buffer,x)
2272                     ; 376 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2274  0526 0c06          	inc	(OFST-1,sp)
2278  0528 7b06          	ld	a,(OFST-1,sp)
2279  052a a11f          	cp	a,#31
2280  052c 2403cc04ab    	jrult	L556
2281                     ; 388 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2283  0531 7b07          	ld	a,(OFST+0,sp)
2284  0533 5f            	clrw	x
2285  0534 97            	ld	xl,a
2286  0535 58            	sllw	x
2287  0536 9093          	ldw	y,x
2288  0538 90ee82        	ldw	y,(_pwm_sleep,y)
2289  053b 90a37c01      	cpw	y,#31745
2290  053f 250b          	jrult	L566
2293  0541 7b07          	ld	a,(OFST+0,sp)
2294  0543 5f            	clrw	x
2295  0544 97            	ld	xl,a
2296  0545 58            	sllw	x
2297  0546 90ae0001      	ldw	y,#1
2298  054a ef82          	ldw	(_pwm_sleep,x),y
2299  054c               L566:
2300                     ; 390 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2302  054c 7b07          	ld	a,(OFST+0,sp)
2303  054e 5f            	clrw	x
2304  054f 97            	ld	xl,a
2305  0550 7b05          	ld	a,(OFST-2,sp)
2306  0552 e786          	ld	(_pwm_led_count,x),a
2307                     ; 393 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2309  0554 72120089      	bset	_pwm_state,#1
2310                     ; 394 }
2313  0558 5b08          	addw	sp,#8
2314  055a 81            	ret
2421                     ; 397 void set_hue_max(u8 index,u16 color)
2421                     ; 398 {
2422                     	switch	.text
2423  055b               _set_hue_max:
2425  055b 88            	push	a
2426  055c 5207          	subw	sp,#7
2427       00000007      OFST:	set	7
2430                     ; 401 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2
2432  055e a6b4          	ld	a,#180
2433  0560 6b05          	ld	(OFST-2,sp),a
2435                     ; 402 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2437  0562 a63d          	ld	a,#61
2438  0564 6b01          	ld	(OFST-6,sp),a
2440                     ; 403 	u8 red=0,green=0,blue=0;
2442  0566 0f02          	clr	(OFST-5,sp)
2446  0568 0f03          	clr	(OFST-4,sp)
2450  056a 0f04          	clr	(OFST-3,sp)
2452                     ; 404 	u8 residual=0;
2454  056c 0f06          	clr	(OFST-1,sp)
2456                     ; 406 	for(iter=0;iter<6;iter++)
2458  056e 0f07          	clr	(OFST+0,sp)
2460  0570               L547:
2461                     ; 408 		if(color<0x2AAB)
2463  0570 1e0b          	ldw	x,(OFST+4,sp)
2464  0572 a32aab        	cpw	x,#10923
2465  0575 240b          	jruge	L357
2466                     ; 410 			residual=color/BRIGHTNESS_STEP;
2468  0577 1e0b          	ldw	x,(OFST+4,sp)
2469  0579 7b01          	ld	a,(OFST-6,sp)
2470  057b 62            	div	x,a
2471  057c 01            	rrwa	x,a
2472  057d 6b06          	ld	(OFST-1,sp),a
2473  057f 02            	rlwa	x,a
2475                     ; 411 			break;
2477  0580 200f          	jra	L157
2478  0582               L357:
2479                     ; 413 		color-=0x2AAB;
2481  0582 1e0b          	ldw	x,(OFST+4,sp)
2482  0584 1d2aab        	subw	x,#10923
2483  0587 1f0b          	ldw	(OFST+4,sp),x
2484                     ; 406 	for(iter=0;iter<6;iter++)
2486  0589 0c07          	inc	(OFST+0,sp)
2490  058b 7b07          	ld	a,(OFST+0,sp)
2491  058d a106          	cp	a,#6
2492  058f 25df          	jrult	L547
2493  0591               L157:
2494                     ; 415 	if(iter==0){ red=MAX_BRIGHTNESS; green=residual; }
2496  0591 0d07          	tnz	(OFST+0,sp)
2497  0593 2608          	jrne	L557
2500  0595 7b05          	ld	a,(OFST-2,sp)
2501  0597 6b02          	ld	(OFST-5,sp),a
2505  0599 7b06          	ld	a,(OFST-1,sp)
2506  059b 6b03          	ld	(OFST-4,sp),a
2508  059d               L557:
2509                     ; 416 	if(iter==1){ green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; }
2511  059d 7b07          	ld	a,(OFST+0,sp)
2512  059f a101          	cp	a,#1
2513  05a1 260a          	jrne	L757
2516  05a3 7b05          	ld	a,(OFST-2,sp)
2517  05a5 6b03          	ld	(OFST-4,sp),a
2521  05a7 7b05          	ld	a,(OFST-2,sp)
2522  05a9 1006          	sub	a,(OFST-1,sp)
2523  05ab 6b02          	ld	(OFST-5,sp),a
2525  05ad               L757:
2526                     ; 417 	if(iter==2){ green=MAX_BRIGHTNESS; blue=residual; }
2528  05ad 7b07          	ld	a,(OFST+0,sp)
2529  05af a102          	cp	a,#2
2530  05b1 2608          	jrne	L167
2533  05b3 7b05          	ld	a,(OFST-2,sp)
2534  05b5 6b03          	ld	(OFST-4,sp),a
2538  05b7 7b06          	ld	a,(OFST-1,sp)
2539  05b9 6b04          	ld	(OFST-3,sp),a
2541  05bb               L167:
2542                     ; 418 	if(iter==3){ blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; }
2544  05bb 7b07          	ld	a,(OFST+0,sp)
2545  05bd a103          	cp	a,#3
2546  05bf 260a          	jrne	L367
2549  05c1 7b05          	ld	a,(OFST-2,sp)
2550  05c3 6b04          	ld	(OFST-3,sp),a
2554  05c5 7b05          	ld	a,(OFST-2,sp)
2555  05c7 1006          	sub	a,(OFST-1,sp)
2556  05c9 6b03          	ld	(OFST-4,sp),a
2558  05cb               L367:
2559                     ; 419 	if(iter==4){ blue=MAX_BRIGHTNESS; red=residual; }
2561  05cb 7b07          	ld	a,(OFST+0,sp)
2562  05cd a104          	cp	a,#4
2563  05cf 2608          	jrne	L567
2566  05d1 7b05          	ld	a,(OFST-2,sp)
2567  05d3 6b04          	ld	(OFST-3,sp),a
2571  05d5 7b06          	ld	a,(OFST-1,sp)
2572  05d7 6b02          	ld	(OFST-5,sp),a
2574  05d9               L567:
2575                     ; 420 	if(iter==5){ red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; }
2577  05d9 7b07          	ld	a,(OFST+0,sp)
2578  05db a105          	cp	a,#5
2579  05dd 260a          	jrne	L767
2582  05df 7b05          	ld	a,(OFST-2,sp)
2583  05e1 6b02          	ld	(OFST-5,sp),a
2587  05e3 7b05          	ld	a,(OFST-2,sp)
2588  05e5 1006          	sub	a,(OFST-1,sp)
2589  05e7 6b04          	ld	(OFST-3,sp),a
2591  05e9               L767:
2592                     ; 421 	set_rgb(index,0,red);
2594  05e9 7b02          	ld	a,(OFST-5,sp)
2595  05eb 88            	push	a
2596  05ec 7b09          	ld	a,(OFST+2,sp)
2597  05ee 5f            	clrw	x
2598  05ef 95            	ld	xh,a
2599  05f0 ad1c          	call	_set_rgb
2601  05f2 84            	pop	a
2602                     ; 422 	set_rgb(index,1,green);
2604  05f3 7b03          	ld	a,(OFST-4,sp)
2605  05f5 88            	push	a
2606  05f6 7b09          	ld	a,(OFST+2,sp)
2607  05f8 ae0001        	ldw	x,#1
2608  05fb 95            	ld	xh,a
2609  05fc ad10          	call	_set_rgb
2611  05fe 84            	pop	a
2612                     ; 423 	set_rgb(index,2,blue);
2614  05ff 7b04          	ld	a,(OFST-3,sp)
2615  0601 88            	push	a
2616  0602 7b09          	ld	a,(OFST+2,sp)
2617  0604 ae0002        	ldw	x,#2
2618  0607 95            	ld	xh,a
2619  0608 ad04          	call	_set_rgb
2621  060a 84            	pop	a
2622                     ; 424 }
2625  060b 5b08          	addw	sp,#8
2626  060d 81            	ret
2679                     ; 426 void set_rgb(u8 index,u8 color,u8 brightness)
2679                     ; 427 {
2680                     	switch	.text
2681  060e               _set_rgb:
2683  060e 89            	pushw	x
2684       00000000      OFST:	set	0
2687                     ; 428 	pwm_brightness_buffer[index+color*RGB_COUNT]=brightness;
2689  060f 9f            	ld	a,xl
2690  0610 97            	ld	xl,a
2691  0611 a606          	ld	a,#6
2692  0613 42            	mul	x,a
2693  0614 01            	rrwa	x,a
2694  0615 1b01          	add	a,(OFST+1,sp)
2695  0617 2401          	jrnc	L261
2696  0619 5c            	incw	x
2697  061a               L261:
2698  061a 02            	rlwa	x,a
2699  061b 7b05          	ld	a,(OFST+5,sp)
2700  061d e708          	ld	(_pwm_brightness_buffer,x),a
2701                     ; 429 }
2704  061f 85            	popw	x
2705  0620 81            	ret
2749                     ; 431 void set_white(u8 index,u8 brightness)
2749                     ; 432 {
2750                     	switch	.text
2751  0621               _set_white:
2753  0621 89            	pushw	x
2754       00000000      OFST:	set	0
2757                     ; 433 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2759  0622 9e            	ld	a,xh
2760  0623 5f            	clrw	x
2761  0624 97            	ld	xl,a
2762  0625 7b02          	ld	a,(OFST+2,sp)
2763  0627 e71b          	ld	(_pwm_brightness_buffer+19,x),a
2764                     ; 434 }
2767  0629 85            	popw	x
2768  062a 81            	ret
2803                     ; 437 void set_debug(u8 brightness)
2803                     ; 438 {
2804                     	switch	.text
2805  062b               _set_debug:
2809                     ; 439 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2811  062b b71a          	ld	_pwm_brightness_buffer+18,a
2812                     ; 440 }
2815  062d 81            	ret
2838                     ; 442 void set_matrix_high_z()
2838                     ; 443 {
2839                     	switch	.text
2840  062e               _set_matrix_high_z:
2844                     ; 444 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2846  062e c6500d        	ld	a,20493
2847  0631 a407          	and	a,#7
2848  0633 c7500d        	ld	20493,a
2849                     ; 445 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2851  0636 72155012      	bres	20498,#2
2852                     ; 446 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2854  063a 72175003      	bres	20483,#3
2855                     ; 449 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_3));//DEBUG_BROKEN
2857  063e 72175012      	bres	20498,#3
2858                     ; 450 }
2861  0642 81            	ret
2895                     ; 452 u8 get_eeprom_byte(u16 eeprom_address)
2895                     ; 453 {
2896                     	switch	.text
2897  0643               _get_eeprom_byte:
2901                     ; 454 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2903  0643 d64000        	ld	a,(16384,x)
2906  0646 81            	ret
3034                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3035                     	switch	.ubsct
3036  0000               _button_pressed_event:
3037  0000 00000000      	ds.b	4
3038                     	xdef	_button_pressed_event
3039  0004               _button_start_ms:
3040  0004 00000000      	ds.b	4
3041                     	xdef	_button_start_ms
3042                     	xdef	_pwm_state
3043                     	xdef	_pwm_visible_index
3044                     	xdef	_pwm_led_count
3045                     	xdef	_pwm_sleep
3046  0008               _pwm_brightness_buffer:
3047  0008 000000000000  	ds.b	31
3048                     	xdef	_pwm_brightness_buffer
3049  0027               _pwm_brightness_index:
3050  0027 000000000000  	ds.b	62
3051                     	xdef	_pwm_brightness_index
3052                     	xdef	_pwm_brightness
3053                     	xdef	_atomic_counter
3054                     	xdef	_frame_counter
3055                     	xref	_UART1_Cmd
3056                     	xref	_UART1_Init
3057                     	xref	_UART1_DeInit
3058                     	xref	_GPIO_ReadInputPin
3059                     	xref	_GPIO_Init
3060                     	xdef	_set_led
3061                     	xdef	_set_mat
3062                     	xdef	_get_eeprom_byte
3063                     	xdef	_get_random
3064                     	xdef	_is_button_down
3065                     	xdef	_clear_button_events
3066                     	xdef	_clear_button_event
3067                     	xdef	_get_button_event
3068                     	xdef	_update_buttons
3069                     	xdef	_is_developer_valid
3070                     	xdef	_set_hue_max
3071                     	xdef	_flush_leds
3072                     	xdef	_set_debug
3073                     	xdef	_set_white
3074                     	xdef	_set_rgb
3075                     	xdef	_set_matrix_high_z
3076                     	xdef	_millis
3077                     	xdef	_setup_main
3078                     	xdef	_is_application_valid
3079                     	xdef	_setup_serial
3080                     	xdef	_hello_world
3081                     	xref.b	c_lreg
3082                     	xref.b	c_x
3083                     	xref.b	c_y
3103                     	xref	c_xymov
3104                     	xref	c_lgadd
3105                     	xref	c_lzmp
3106                     	xref	c_lsub
3107                     	xref	c_rtol
3108                     	xref	c_uitolx
3109                     	xref	c_lursh
3110                     	xref	c_itolx
3111                     	xref	c_ltor
3112                     	xref	c_imul
3113                     	end
