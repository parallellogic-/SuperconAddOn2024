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
 137  0021 cd056a        	call	_set_hue_max
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
 154  0036 cd056a        	call	_set_hue_max
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
 171  004b cd056a        	call	_set_hue_max
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
 188  0060 cd056a        	call	_set_hue_max
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
 205  0075 cd056a        	call	_set_hue_max
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
 222  008a cd056a        	call	_set_hue_max
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
 284  00d8 cd0630        	call	_set_white
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
 832  01d5 cd063a        	call	_set_debug
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
1209                     ; 162 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1211  0274 4d            	tnz	a
1212  0275 2708          	jreq	L143
1213  0277 4a            	dec	a
1214  0278 2718          	jreq	L343
1215  027a 4a            	dec	a
1216  027b 2728          	jreq	L543
1217  027d 2039          	jra	L763
1218  027f               L143:
1219                     ; 160 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1221  027f 4b20          	push	#32
1222  0281 ae500f        	ldw	x,#20495
1223  0284 cd0000        	call	_GPIO_ReadInputPin
1225  0287 5b01          	addw	sp,#1
1226  0289 4d            	tnz	a
1227  028a 2604          	jrne	L421
1228  028c a601          	ld	a,#1
1229  028e 2001          	jra	L621
1230  0290               L421:
1231  0290 4f            	clr	a
1232  0291               L621:
1235  0291 81            	ret
1236  0292               L343:
1237                     ; 161 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1240  0292 4b40          	push	#64
1241  0294 ae500f        	ldw	x,#20495
1242  0297 cd0000        	call	_GPIO_ReadInputPin
1244  029a 5b01          	addw	sp,#1
1245  029c 4d            	tnz	a
1246  029d 2604          	jrne	L031
1247  029f a601          	ld	a,#1
1248  02a1 2001          	jra	L231
1249  02a3               L031:
1250  02a3 4f            	clr	a
1251  02a4               L231:
1254  02a4 81            	ret
1255  02a5               L543:
1256                     ; 162 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1259  02a5 4b02          	push	#2
1260  02a7 ae500f        	ldw	x,#20495
1261  02aa cd0000        	call	_GPIO_ReadInputPin
1263  02ad 5b01          	addw	sp,#1
1264  02af 4d            	tnz	a
1265  02b0 2604          	jrne	L431
1266  02b2 a601          	ld	a,#1
1267  02b4 2001          	jra	L631
1268  02b6               L431:
1269  02b6 4f            	clr	a
1270  02b7               L631:
1273  02b7 81            	ret
1274  02b8               L763:
1275                     ; 164 	return 0;
1277  02b8 4f            	clr	a
1280  02b9 81            	ret
1335                     ; 168 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1337                     	switch	.text
1338  02ba               f_TIM2_UPD_OVF_IRQHandler:
1340  02ba 8a            	push	cc
1341  02bb 84            	pop	a
1342  02bc a4bf          	and	a,#191
1343  02be 88            	push	a
1344  02bf 86            	pop	cc
1345       00000005      OFST:	set	5
1346  02c0 3b0002        	push	c_x+2
1347  02c3 be00          	ldw	x,c_x
1348  02c5 89            	pushw	x
1349  02c6 3b0002        	push	c_y+2
1350  02c9 be00          	ldw	x,c_y
1351  02cb 89            	pushw	x
1352  02cc be02          	ldw	x,c_lreg+2
1353  02ce 89            	pushw	x
1354  02cf be00          	ldw	x,c_lreg
1355  02d1 89            	pushw	x
1356  02d2 5205          	subw	sp,#5
1359                     ; 169 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1361  02d4 b689          	ld	a,_pwm_state
1362  02d6 a401          	and	a,#1
1363  02d8 6b05          	ld	(OFST+0,sp),a
1365                     ; 170 	u16 sleep_counts=1;
1367  02da ae0001        	ldw	x,#1
1368  02dd 1f03          	ldw	(OFST-2,sp),x
1370                     ; 172 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1372  02df c6500c        	ld	a,20492
1373  02e2 a407          	and	a,#7
1374  02e4 c7500c        	ld	20492,a
1375                     ; 173 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1377  02e7 72155011      	bres	20497,#2
1378                     ; 174 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1380  02eb 72175002      	bres	20482,#3
1381                     ; 175 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1383  02ef c6500d        	ld	a,20493
1384  02f2 a407          	and	a,#7
1385  02f4 c7500d        	ld	20493,a
1386                     ; 176 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1388  02f7 72155012      	bres	20498,#2
1389                     ; 177 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1391  02fb 72175003      	bres	20483,#3
1392                     ; 179 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_4));
1394  02ff 72195011      	bres	20497,#4
1395                     ; 180 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_4));//DEBUG_BROKEN
1397  0303 72195012      	bres	20498,#4
1398                     ; 182   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1400  0307 72115300      	bres	21248,#0
1401                     ; 183 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1403  030b 7b05          	ld	a,(OFST+0,sp)
1404  030d 5f            	clrw	x
1405  030e 97            	ld	xl,a
1406  030f e686          	ld	a,(_pwm_led_count,x)
1407  0311 b188          	cp	a,_pwm_visible_index
1408  0313 2609          	jrne	L314
1409                     ; 185 		sleep_counts=pwm_sleep[buffer_index];
1411  0315 7b05          	ld	a,(OFST+0,sp)
1412  0317 5f            	clrw	x
1413  0318 97            	ld	xl,a
1414  0319 58            	sllw	x
1415  031a ee82          	ldw	x,(_pwm_sleep,x)
1416  031c 1f03          	ldw	(OFST-2,sp),x
1418  031e               L314:
1419                     ; 187 	if(pwm_visible_index>pwm_led_count[buffer_index])
1421  031e 7b05          	ld	a,(OFST+0,sp)
1422  0320 5f            	clrw	x
1423  0321 97            	ld	xl,a
1424  0322 e686          	ld	a,(_pwm_led_count,x)
1425  0324 b188          	cp	a,_pwm_visible_index
1426  0326 241e          	jruge	L514
1427                     ; 189 		frame_counter++;
1429  0328 be00          	ldw	x,_frame_counter
1430  032a 1c0001        	addw	x,#1
1431  032d bf00          	ldw	_frame_counter,x
1432                     ; 190 		pwm_visible_index=0;//formally start new frame
1434  032f 3f88          	clr	_pwm_visible_index
1435                     ; 191 		update_buttons();
1437  0331 cd019c        	call	_update_buttons
1439                     ; 192 		if(pwm_state&0x02)
1441  0334 b689          	ld	a,_pwm_state
1442  0336 a502          	bcp	a,#2
1443  0338 270c          	jreq	L514
1444                     ; 194 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1446  033a b689          	ld	a,_pwm_state
1447  033c a803          	xor	a,#3
1448  033e b789          	ld	_pwm_state,a
1449                     ; 195 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1451  0340 b689          	ld	a,_pwm_state
1452  0342 a401          	and	a,#1
1453  0344 6b05          	ld	(OFST+0,sp),a
1455  0346               L514:
1456                     ; 198 	if(pwm_visible_index<pwm_led_count[buffer_index])
1458  0346 7b05          	ld	a,(OFST+0,sp)
1459  0348 5f            	clrw	x
1460  0349 97            	ld	xl,a
1461  034a e686          	ld	a,(_pwm_led_count,x)
1462  034c b188          	cp	a,_pwm_visible_index
1463  034e 2324          	jrule	L124
1464                     ; 200 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1466  0350 7b05          	ld	a,(OFST+0,sp)
1467  0352 5f            	clrw	x
1468  0353 97            	ld	xl,a
1469  0354 58            	sllw	x
1470  0355 1f01          	ldw	(OFST-4,sp),x
1472  0357 b688          	ld	a,_pwm_visible_index
1473  0359 97            	ld	xl,a
1474  035a a604          	ld	a,#4
1475  035c 42            	mul	x,a
1476  035d 72fb01        	addw	x,(OFST-4,sp)
1477  0360 ee06          	ldw	x,(_pwm_brightness,x)
1478  0362 1f03          	ldw	(OFST-2,sp),x
1480                     ; 201 		set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1482  0364 b688          	ld	a,_pwm_visible_index
1483  0366 5f            	clrw	x
1484  0367 97            	ld	xl,a
1485  0368 58            	sllw	x
1486  0369 01            	rrwa	x,a
1487  036a 1b05          	add	a,(OFST+0,sp)
1488  036c 2401          	jrnc	L241
1489  036e 5c            	incw	x
1490  036f               L241:
1491  036f 02            	rlwa	x,a
1492  0370 e627          	ld	a,(_pwm_brightness_index,x)
1493  0372 ad3e          	call	_set_led_on
1495  0374               L124:
1496                     ; 203 	pwm_visible_index++;
1498  0374 3c88          	inc	_pwm_visible_index
1499                     ; 204 	atomic_counter+=sleep_counts;
1501  0376 1e03          	ldw	x,(OFST-2,sp)
1502  0378 cd0000        	call	c_uitolx
1504  037b ae0002        	ldw	x,#_atomic_counter
1505  037e cd0000        	call	c_lgadd
1507                     ; 206   TIM2->CNTRH = 0;// Set the high byte of the counter
1509  0381 725f530c      	clr	21260
1510                     ; 207   TIM2->CNTRL = 0;// Set the low byte of the counter
1512  0385 725f530d      	clr	21261
1513                     ; 208 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1515  0389 7b03          	ld	a,(OFST-2,sp)
1516  038b c7530f        	ld	21263,a
1517                     ; 209 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1519  038e 7b04          	ld	a,(OFST-1,sp)
1520  0390 a4ff          	and	a,#255
1521  0392 c75310        	ld	21264,a
1522                     ; 211 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1524  0395 72115304      	bres	21252,#0
1525                     ; 212   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1527  0399 72105300      	bset	21248,#0
1528                     ; 213 }
1531  039d 5b05          	addw	sp,#5
1532  039f 85            	popw	x
1533  03a0 bf00          	ldw	c_lreg,x
1534  03a2 85            	popw	x
1535  03a3 bf02          	ldw	c_lreg+2,x
1536  03a5 85            	popw	x
1537  03a6 bf00          	ldw	c_y,x
1538  03a8 320002        	pop	c_y+2
1539  03ab 85            	popw	x
1540  03ac bf00          	ldw	c_x,x
1541  03ae 320002        	pop	c_x+2
1542  03b1 80            	iret
1544                     	switch	.const
1545  0004               L324_led_lookup:
1546  0004 04            	dc.b	4
1547  0005 03            	dc.b	3
1548  0006 03            	dc.b	3
1549  0007 04            	dc.b	4
1550  0008 00            	dc.b	0
1551  0009 05            	dc.b	5
1552  000a 00            	dc.b	0
1553  000b 04            	dc.b	4
1554  000c 00            	dc.b	0
1555  000d 03            	dc.b	3
1556  000e 00            	dc.b	0
1557  000f 01            	dc.b	1
1558  0010 05            	dc.b	5
1559  0011 03            	dc.b	3
1560  0012 03            	dc.b	3
1561  0013 05            	dc.b	5
1562  0014 00            	dc.b	0
1563  0015 06            	dc.b	6
1564  0016 01            	dc.b	1
1565  0017 04            	dc.b	4
1566  0018 01            	dc.b	1
1567  0019 03            	dc.b	3
1568  001a 00            	dc.b	0
1569  001b 02            	dc.b	2
1570  001c 06            	dc.b	6
1571  001d 03            	dc.b	3
1572  001e 03            	dc.b	3
1573  001f 06            	dc.b	6
1574  0020 01            	dc.b	1
1575  0021 06            	dc.b	6
1576  0022 02            	dc.b	2
1577  0023 04            	dc.b	4
1578  0024 02            	dc.b	2
1579  0025 03            	dc.b	3
1580  0026 01            	dc.b	1
1581  0027 02            	dc.b	2
1582  0028 07            	dc.b	7
1583  0029 07            	dc.b	7
1584  002a 03            	dc.b	3
1585  002b 00            	dc.b	0
1586  002c 03            	dc.b	3
1587  002d 01            	dc.b	1
1588  002e 03            	dc.b	3
1589  002f 02            	dc.b	2
1590  0030 04            	dc.b	4
1591  0031 00            	dc.b	0
1592  0032 01            	dc.b	1
1593  0033 05            	dc.b	5
1594  0034 02            	dc.b	2
1595  0035 05            	dc.b	5
1596  0036 04            	dc.b	4
1597  0037 01            	dc.b	1
1598  0038 04            	dc.b	4
1599  0039 02            	dc.b	2
1600  003a 02            	dc.b	2
1601  003b 06            	dc.b	6
1602  003c 04            	dc.b	4
1603  003d 06            	dc.b	6
1604  003e 04            	dc.b	4
1605  003f 05            	dc.b	5
1606  0040 05            	dc.b	5
1607  0041 06            	dc.b	6
1651                     ; 216 void set_led_on(u8 led_index)
1651                     ; 217 {
1653                     	switch	.text
1654  03b2               _set_led_on:
1656  03b2 88            	push	a
1657  03b3 5240          	subw	sp,#64
1658       00000040      OFST:	set	64
1661                     ; 254 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat ////DEBUG_BROKEN
1661                     ; 255 		{4,3},{3,4},{0,5},{0,4},{0,3},{0,1},//reds
1661                     ; 256 		{5,3},{3,5},{0,6},{1,4},{1,3},{0,2},//greens
1661                     ; 257 		{6,3},{3,6},{1,6},{2,4},{2,3},{1,2},//blues
1661                     ; 258 		{7,7},//debug; GND is tied low, no charlieplexing involved
1661                     ; 259 		{3,0},//LED6
1661                     ; 260 		{3,1},//LED4
1661                     ; 261 		{3,2},//LED5
1661                     ; 262 		{4,0},//LED14
1661                     ; 263 		{1,5},//LED8
1661                     ; 264 		{2,5},//LED9
1661                     ; 265 		{4,1},//LED10
1661                     ; 266 		{4,2},//LED16
1661                     ; 267 		{2,6},//LED17
1661                     ; 268 		{4,6},//LED12
1661                     ; 269 		{4,5},//LED13
1661                     ; 270 		{5,6} //LED11
1661                     ; 271 	};
1663  03b5 96            	ldw	x,sp
1664  03b6 1c0003        	addw	x,#OFST-61
1665  03b9 90ae0004      	ldw	y,#L324_led_lookup
1666  03bd a63e          	ld	a,#62
1667  03bf cd0000        	call	c_xymov
1669                     ; 272 	set_mat(led_lookup[led_index][0],1);
1671  03c2 96            	ldw	x,sp
1672  03c3 1c0003        	addw	x,#OFST-61
1673  03c6 1f01          	ldw	(OFST-63,sp),x
1675  03c8 7b41          	ld	a,(OFST+1,sp)
1676  03ca 5f            	clrw	x
1677  03cb 97            	ld	xl,a
1678  03cc 58            	sllw	x
1679  03cd 72fb01        	addw	x,(OFST-63,sp)
1680  03d0 f6            	ld	a,(x)
1681  03d1 ae0001        	ldw	x,#1
1682  03d4 95            	ld	xh,a
1683  03d5 ad1c          	call	_set_mat
1685                     ; 274 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0); //DEBUG_BROKEN
1687  03d7 7b41          	ld	a,(OFST+1,sp)
1688  03d9 a112          	cp	a,#18
1689  03db 2713          	jreq	L744
1692  03dd 96            	ldw	x,sp
1693  03de 1c0004        	addw	x,#OFST-60
1694  03e1 1f01          	ldw	(OFST-63,sp),x
1696  03e3 7b41          	ld	a,(OFST+1,sp)
1697  03e5 5f            	clrw	x
1698  03e6 97            	ld	xl,a
1699  03e7 58            	sllw	x
1700  03e8 72fb01        	addw	x,(OFST-63,sp)
1701  03eb f6            	ld	a,(x)
1702  03ec 5f            	clrw	x
1703  03ed 95            	ld	xh,a
1704  03ee ad03          	call	_set_mat
1706  03f0               L744:
1707                     ; 276 }
1710  03f0 5b41          	addw	sp,#65
1711  03f2 81            	ret
1912                     ; 279 void set_mat(u8 mat_index,bool is_high)
1912                     ; 280 {
1913                     	switch	.text
1914  03f3               _set_mat:
1916  03f3 89            	pushw	x
1917  03f4 5203          	subw	sp,#3
1918       00000003      OFST:	set	3
1921                     ; 318 	if(mat_index==0)//DEBUG_BROKEN
1923  03f6 9e            	ld	a,xh
1924  03f7 4d            	tnz	a
1925  03f8 2609          	jrne	L765
1926                     ; 320 		GPIOx=GPIOD;
1928  03fa ae500f        	ldw	x,#20495
1929  03fd 1f01          	ldw	(OFST-2,sp),x
1931                     ; 321 		GPIO_Pin=GPIO_PIN_4;
1933  03ff a610          	ld	a,#16
1934  0401 6b03          	ld	(OFST+0,sp),a
1936  0403               L765:
1937                     ; 323 	if(mat_index==1)
1939  0403 7b04          	ld	a,(OFST+1,sp)
1940  0405 a101          	cp	a,#1
1941  0407 2609          	jrne	L175
1942                     ; 325 		GPIOx=GPIOD;
1944  0409 ae500f        	ldw	x,#20495
1945  040c 1f01          	ldw	(OFST-2,sp),x
1947                     ; 326 		GPIO_Pin=GPIO_PIN_2;
1949  040e a604          	ld	a,#4
1950  0410 6b03          	ld	(OFST+0,sp),a
1952  0412               L175:
1953                     ; 328 	if(mat_index==2)
1955  0412 7b04          	ld	a,(OFST+1,sp)
1956  0414 a102          	cp	a,#2
1957  0416 2609          	jrne	L375
1958                     ; 330 		GPIOx=GPIOC;
1960  0418 ae500a        	ldw	x,#20490
1961  041b 1f01          	ldw	(OFST-2,sp),x
1963                     ; 331 		GPIO_Pin=GPIO_PIN_7;
1965  041d a680          	ld	a,#128
1966  041f 6b03          	ld	(OFST+0,sp),a
1968  0421               L375:
1969                     ; 333 	if(mat_index==3)
1971  0421 7b04          	ld	a,(OFST+1,sp)
1972  0423 a103          	cp	a,#3
1973  0425 2609          	jrne	L575
1974                     ; 335 		GPIOx=GPIOC;
1976  0427 ae500a        	ldw	x,#20490
1977  042a 1f01          	ldw	(OFST-2,sp),x
1979                     ; 336 		GPIO_Pin=GPIO_PIN_6;
1981  042c a640          	ld	a,#64
1982  042e 6b03          	ld	(OFST+0,sp),a
1984  0430               L575:
1985                     ; 338 	if(mat_index==4)
1987  0430 7b04          	ld	a,(OFST+1,sp)
1988  0432 a104          	cp	a,#4
1989  0434 2609          	jrne	L775
1990                     ; 340 		GPIOx=GPIOC;
1992  0436 ae500a        	ldw	x,#20490
1993  0439 1f01          	ldw	(OFST-2,sp),x
1995                     ; 341 		GPIO_Pin=GPIO_PIN_5;
1997  043b a620          	ld	a,#32
1998  043d 6b03          	ld	(OFST+0,sp),a
2000  043f               L775:
2001                     ; 343 	if(mat_index==5)
2003  043f 7b04          	ld	a,(OFST+1,sp)
2004  0441 a105          	cp	a,#5
2005  0443 2609          	jrne	L106
2006                     ; 345 		GPIOx=GPIOC;
2008  0445 ae500a        	ldw	x,#20490
2009  0448 1f01          	ldw	(OFST-2,sp),x
2011                     ; 346 		GPIO_Pin=GPIO_PIN_4;
2013  044a a610          	ld	a,#16
2014  044c 6b03          	ld	(OFST+0,sp),a
2016  044e               L106:
2017                     ; 348 	if(mat_index==6)
2019  044e 7b04          	ld	a,(OFST+1,sp)
2020  0450 a106          	cp	a,#6
2021  0452 2609          	jrne	L306
2022                     ; 350 		GPIOx=GPIOC;
2024  0454 ae500a        	ldw	x,#20490
2025  0457 1f01          	ldw	(OFST-2,sp),x
2027                     ; 351 		GPIO_Pin=GPIO_PIN_3;
2029  0459 a608          	ld	a,#8
2030  045b 6b03          	ld	(OFST+0,sp),a
2032  045d               L306:
2033                     ; 353 	if(mat_index==7)
2035  045d 7b04          	ld	a,(OFST+1,sp)
2036  045f a107          	cp	a,#7
2037  0461 2609          	jrne	L506
2038                     ; 355 		GPIOx=GPIOA;
2040  0463 ae5000        	ldw	x,#20480
2041  0466 1f01          	ldw	(OFST-2,sp),x
2043                     ; 356 		GPIO_Pin=GPIO_PIN_3;
2045  0468 a608          	ld	a,#8
2046  046a 6b03          	ld	(OFST+0,sp),a
2048  046c               L506:
2049                     ; 358 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2051  046c 0d05          	tnz	(OFST+2,sp)
2052  046e 2708          	jreq	L706
2055  0470 1e01          	ldw	x,(OFST-2,sp)
2056  0472 f6            	ld	a,(x)
2057  0473 1a03          	or	a,(OFST+0,sp)
2058  0475 f7            	ld	(x),a
2060  0476 2007          	jra	L116
2061  0478               L706:
2062                     ; 359 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2064  0478 1e01          	ldw	x,(OFST-2,sp)
2065  047a 7b03          	ld	a,(OFST+0,sp)
2066  047c 43            	cpl	a
2067  047d f4            	and	a,(x)
2068  047e f7            	ld	(x),a
2069  047f               L116:
2070                     ; 360 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2072  047f 1e01          	ldw	x,(OFST-2,sp)
2073  0481 e602          	ld	a,(2,x)
2074  0483 1a03          	or	a,(OFST+0,sp)
2075  0485 e702          	ld	(2,x),a
2076                     ; 361 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2078  0487 1e01          	ldw	x,(OFST-2,sp)
2079  0489 e603          	ld	a,(3,x)
2080  048b 1a03          	or	a,(OFST+0,sp)
2081  048d e703          	ld	(3,x),a
2082                     ; 362 }
2085  048f 5b05          	addw	sp,#5
2086  0491 81            	ret
2162                     ; 365 void flush_leds(u8 led_count)
2162                     ; 366 {
2163                     	switch	.text
2164  0492               _flush_leds:
2166  0492 88            	push	a
2167  0493 5207          	subw	sp,#7
2168       00000007      OFST:	set	7
2171                     ; 367 	u8 led_read_index=0,led_write_index=0;
2175  0495 0f05          	clr	(OFST-2,sp)
2178  0497               L556:
2179                     ; 370 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2181  0497 b689          	ld	a,_pwm_state
2182  0499 a502          	bcp	a,#2
2183  049b 26fa          	jrne	L556
2184                     ; 371 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2186  049d b689          	ld	a,_pwm_state
2187  049f a401          	and	a,#1
2188  04a1 a801          	xor	a,#1
2189  04a3 6b07          	ld	(OFST+0,sp),a
2191                     ; 373 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2193  04a5 7b08          	ld	a,(OFST+1,sp)
2194  04a7 5f            	clrw	x
2195  04a8 97            	ld	xl,a
2196  04a9 4f            	clr	a
2197  04aa 02            	rlwa	x,a
2198  04ab 58            	sllw	x
2199  04ac 58            	sllw	x
2200  04ad 7b07          	ld	a,(OFST+0,sp)
2201  04af 905f          	clrw	y
2202  04b1 9097          	ld	yl,a
2203  04b3 9058          	sllw	y
2204  04b5 90ef82        	ldw	(_pwm_sleep,y),x
2205                     ; 375 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2207  04b8 0f06          	clr	(OFST-1,sp)
2209  04ba               L166:
2210                     ; 377 		read_brightness=pwm_brightness_buffer[led_read_index];
2212  04ba 7b06          	ld	a,(OFST-1,sp)
2213  04bc 5f            	clrw	x
2214  04bd 97            	ld	xl,a
2215  04be e608          	ld	a,(_pwm_brightness_buffer,x)
2216  04c0 5f            	clrw	x
2217  04c1 97            	ld	xl,a
2218  04c2 1f03          	ldw	(OFST-4,sp),x
2220                     ; 378 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2222  04c4 1e03          	ldw	x,(OFST-4,sp)
2223  04c6 2767          	jreq	L766
2224                     ; 380 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2226  04c8 7b05          	ld	a,(OFST-2,sp)
2227  04ca 5f            	clrw	x
2228  04cb 97            	ld	xl,a
2229  04cc 58            	sllw	x
2230  04cd 01            	rrwa	x,a
2231  04ce 1b07          	add	a,(OFST+0,sp)
2232  04d0 2401          	jrnc	L251
2233  04d2 5c            	incw	x
2234  04d3               L251:
2235  04d3 02            	rlwa	x,a
2236  04d4 7b06          	ld	a,(OFST-1,sp)
2237  04d6 e727          	ld	(_pwm_brightness_index,x),a
2238                     ; 381 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2240  04d8 1e03          	ldw	x,(OFST-4,sp)
2241  04da 1603          	ldw	y,(OFST-4,sp)
2242  04dc cd0000        	call	c_imul
2244  04df a606          	ld	a,#6
2245  04e1               L451:
2246  04e1 54            	srlw	x
2247  04e2 4a            	dec	a
2248  04e3 26fc          	jrne	L451
2249  04e5 5c            	incw	x
2250  04e6 7b07          	ld	a,(OFST+0,sp)
2251  04e8 905f          	clrw	y
2252  04ea 9097          	ld	yl,a
2253  04ec 9058          	sllw	y
2254  04ee 1701          	ldw	(OFST-6,sp),y
2256  04f0 7b05          	ld	a,(OFST-2,sp)
2257  04f2 905f          	clrw	y
2258  04f4 9097          	ld	yl,a
2259  04f6 9058          	sllw	y
2260  04f8 9058          	sllw	y
2261  04fa 72f901        	addw	y,(OFST-6,sp)
2262  04fd 90ef06        	ldw	(_pwm_brightness,y),x
2263                     ; 382 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2265  0500 7b07          	ld	a,(OFST+0,sp)
2266  0502 5f            	clrw	x
2267  0503 97            	ld	xl,a
2268  0504 58            	sllw	x
2269  0505 7b07          	ld	a,(OFST+0,sp)
2270  0507 905f          	clrw	y
2271  0509 9097          	ld	yl,a
2272  050b 9058          	sllw	y
2273  050d 1701          	ldw	(OFST-6,sp),y
2275  050f 7b05          	ld	a,(OFST-2,sp)
2276  0511 905f          	clrw	y
2277  0513 9097          	ld	yl,a
2278  0515 9058          	sllw	y
2279  0517 9058          	sllw	y
2280  0519 72f901        	addw	y,(OFST-6,sp)
2281  051c 90ee06        	ldw	y,(_pwm_brightness,y)
2282  051f 9001          	rrwa	y,a
2283  0521 e083          	sub	a,(_pwm_sleep+1,x)
2284  0523 9001          	rrwa	y,a
2285  0525 e282          	sbc	a,(_pwm_sleep,x)
2286  0527 9001          	rrwa	y,a
2287  0529 9050          	negw	y
2288  052b ef82          	ldw	(_pwm_sleep,x),y
2289                     ; 383 			led_write_index++;
2291  052d 0c05          	inc	(OFST-2,sp)
2293  052f               L766:
2294                     ; 385 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2296  052f 7b06          	ld	a,(OFST-1,sp)
2297  0531 5f            	clrw	x
2298  0532 97            	ld	xl,a
2299  0533 6f08          	clr	(_pwm_brightness_buffer,x)
2300                     ; 375 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2302  0535 0c06          	inc	(OFST-1,sp)
2306  0537 7b06          	ld	a,(OFST-1,sp)
2307  0539 a11f          	cp	a,#31
2308  053b 2403cc04ba    	jrult	L166
2309                     ; 387 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2311  0540 7b07          	ld	a,(OFST+0,sp)
2312  0542 5f            	clrw	x
2313  0543 97            	ld	xl,a
2314  0544 58            	sllw	x
2315  0545 9093          	ldw	y,x
2316  0547 90ee82        	ldw	y,(_pwm_sleep,y)
2317  054a 90a37c01      	cpw	y,#31745
2318  054e 250b          	jrult	L176
2321  0550 7b07          	ld	a,(OFST+0,sp)
2322  0552 5f            	clrw	x
2323  0553 97            	ld	xl,a
2324  0554 58            	sllw	x
2325  0555 90ae0001      	ldw	y,#1
2326  0559 ef82          	ldw	(_pwm_sleep,x),y
2327  055b               L176:
2328                     ; 389 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2330  055b 7b07          	ld	a,(OFST+0,sp)
2331  055d 5f            	clrw	x
2332  055e 97            	ld	xl,a
2333  055f 7b05          	ld	a,(OFST-2,sp)
2334  0561 e786          	ld	(_pwm_led_count,x),a
2335                     ; 392 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2337  0563 72120089      	bset	_pwm_state,#1
2338                     ; 393 }
2341  0567 5b08          	addw	sp,#8
2342  0569 81            	ret
2449                     ; 396 void set_hue_max(u8 index,u16 color)
2449                     ; 397 {
2450                     	switch	.text
2451  056a               _set_hue_max:
2453  056a 88            	push	a
2454  056b 5207          	subw	sp,#7
2455       00000007      OFST:	set	7
2458                     ; 400 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2
2460  056d a6b4          	ld	a,#180
2461  056f 6b05          	ld	(OFST-2,sp),a
2463                     ; 401 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2465  0571 a63d          	ld	a,#61
2466  0573 6b01          	ld	(OFST-6,sp),a
2468                     ; 402 	u8 red=0,green=0,blue=0;
2470  0575 0f02          	clr	(OFST-5,sp)
2474  0577 0f03          	clr	(OFST-4,sp)
2478  0579 0f04          	clr	(OFST-3,sp)
2480                     ; 403 	u8 residual=0;
2482  057b 0f06          	clr	(OFST-1,sp)
2484                     ; 405 	for(iter=0;iter<6;iter++)
2486  057d 0f07          	clr	(OFST+0,sp)
2488  057f               L157:
2489                     ; 407 		if(color<0x2AAB)
2491  057f 1e0b          	ldw	x,(OFST+4,sp)
2492  0581 a32aab        	cpw	x,#10923
2493  0584 240b          	jruge	L757
2494                     ; 409 			residual=color/BRIGHTNESS_STEP;
2496  0586 1e0b          	ldw	x,(OFST+4,sp)
2497  0588 7b01          	ld	a,(OFST-6,sp)
2498  058a 62            	div	x,a
2499  058b 01            	rrwa	x,a
2500  058c 6b06          	ld	(OFST-1,sp),a
2501  058e 02            	rlwa	x,a
2503                     ; 410 			break;
2505  058f 200f          	jra	L557
2506  0591               L757:
2507                     ; 412 		color-=0x2AAB;
2509  0591 1e0b          	ldw	x,(OFST+4,sp)
2510  0593 1d2aab        	subw	x,#10923
2511  0596 1f0b          	ldw	(OFST+4,sp),x
2512                     ; 405 	for(iter=0;iter<6;iter++)
2514  0598 0c07          	inc	(OFST+0,sp)
2518  059a 7b07          	ld	a,(OFST+0,sp)
2519  059c a106          	cp	a,#6
2520  059e 25df          	jrult	L157
2521  05a0               L557:
2522                     ; 414 	if(iter==0){ red=MAX_BRIGHTNESS; green=residual; }
2524  05a0 0d07          	tnz	(OFST+0,sp)
2525  05a2 2608          	jrne	L167
2528  05a4 7b05          	ld	a,(OFST-2,sp)
2529  05a6 6b02          	ld	(OFST-5,sp),a
2533  05a8 7b06          	ld	a,(OFST-1,sp)
2534  05aa 6b03          	ld	(OFST-4,sp),a
2536  05ac               L167:
2537                     ; 415 	if(iter==1){ green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; }
2539  05ac 7b07          	ld	a,(OFST+0,sp)
2540  05ae a101          	cp	a,#1
2541  05b0 260a          	jrne	L367
2544  05b2 7b05          	ld	a,(OFST-2,sp)
2545  05b4 6b03          	ld	(OFST-4,sp),a
2549  05b6 7b05          	ld	a,(OFST-2,sp)
2550  05b8 1006          	sub	a,(OFST-1,sp)
2551  05ba 6b02          	ld	(OFST-5,sp),a
2553  05bc               L367:
2554                     ; 416 	if(iter==2){ green=MAX_BRIGHTNESS; blue=residual; }
2556  05bc 7b07          	ld	a,(OFST+0,sp)
2557  05be a102          	cp	a,#2
2558  05c0 2608          	jrne	L567
2561  05c2 7b05          	ld	a,(OFST-2,sp)
2562  05c4 6b03          	ld	(OFST-4,sp),a
2566  05c6 7b06          	ld	a,(OFST-1,sp)
2567  05c8 6b04          	ld	(OFST-3,sp),a
2569  05ca               L567:
2570                     ; 417 	if(iter==3){ blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; }
2572  05ca 7b07          	ld	a,(OFST+0,sp)
2573  05cc a103          	cp	a,#3
2574  05ce 260a          	jrne	L767
2577  05d0 7b05          	ld	a,(OFST-2,sp)
2578  05d2 6b04          	ld	(OFST-3,sp),a
2582  05d4 7b05          	ld	a,(OFST-2,sp)
2583  05d6 1006          	sub	a,(OFST-1,sp)
2584  05d8 6b03          	ld	(OFST-4,sp),a
2586  05da               L767:
2587                     ; 418 	if(iter==4){ blue=MAX_BRIGHTNESS; red=residual; }
2589  05da 7b07          	ld	a,(OFST+0,sp)
2590  05dc a104          	cp	a,#4
2591  05de 2608          	jrne	L177
2594  05e0 7b05          	ld	a,(OFST-2,sp)
2595  05e2 6b04          	ld	(OFST-3,sp),a
2599  05e4 7b06          	ld	a,(OFST-1,sp)
2600  05e6 6b02          	ld	(OFST-5,sp),a
2602  05e8               L177:
2603                     ; 419 	if(iter==5){ red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; }
2605  05e8 7b07          	ld	a,(OFST+0,sp)
2606  05ea a105          	cp	a,#5
2607  05ec 260a          	jrne	L377
2610  05ee 7b05          	ld	a,(OFST-2,sp)
2611  05f0 6b02          	ld	(OFST-5,sp),a
2615  05f2 7b05          	ld	a,(OFST-2,sp)
2616  05f4 1006          	sub	a,(OFST-1,sp)
2617  05f6 6b04          	ld	(OFST-3,sp),a
2619  05f8               L377:
2620                     ; 420 	set_rgb(index,0,red);
2622  05f8 7b02          	ld	a,(OFST-5,sp)
2623  05fa 88            	push	a
2624  05fb 7b09          	ld	a,(OFST+2,sp)
2625  05fd 5f            	clrw	x
2626  05fe 95            	ld	xh,a
2627  05ff ad1c          	call	_set_rgb
2629  0601 84            	pop	a
2630                     ; 421 	set_rgb(index,1,green);
2632  0602 7b03          	ld	a,(OFST-4,sp)
2633  0604 88            	push	a
2634  0605 7b09          	ld	a,(OFST+2,sp)
2635  0607 ae0001        	ldw	x,#1
2636  060a 95            	ld	xh,a
2637  060b ad10          	call	_set_rgb
2639  060d 84            	pop	a
2640                     ; 422 	set_rgb(index,2,blue);
2642  060e 7b04          	ld	a,(OFST-3,sp)
2643  0610 88            	push	a
2644  0611 7b09          	ld	a,(OFST+2,sp)
2645  0613 ae0002        	ldw	x,#2
2646  0616 95            	ld	xh,a
2647  0617 ad04          	call	_set_rgb
2649  0619 84            	pop	a
2650                     ; 423 }
2653  061a 5b08          	addw	sp,#8
2654  061c 81            	ret
2707                     ; 425 void set_rgb(u8 index,u8 color,u8 brightness)
2707                     ; 426 {
2708                     	switch	.text
2709  061d               _set_rgb:
2711  061d 89            	pushw	x
2712       00000000      OFST:	set	0
2715                     ; 427 	pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness;
2717  061e 9f            	ld	a,xl
2718  061f 97            	ld	xl,a
2719  0620 a606          	ld	a,#6
2720  0622 42            	mul	x,a
2721  0623 01            	rrwa	x,a
2722  0624 1b01          	add	a,(OFST+1,sp)
2723  0626 2401          	jrnc	L261
2724  0628 5c            	incw	x
2725  0629               L261:
2726  0629 02            	rlwa	x,a
2727  062a 7b05          	ld	a,(OFST+5,sp)
2728  062c e708          	ld	(_pwm_brightness_buffer,x),a
2729                     ; 428 }
2732  062e 85            	popw	x
2733  062f 81            	ret
2777                     ; 430 void set_white(u8 index,u8 brightness)
2777                     ; 431 {
2778                     	switch	.text
2779  0630               _set_white:
2781  0630 89            	pushw	x
2782       00000000      OFST:	set	0
2785                     ; 432 	pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness;
2787  0631 9e            	ld	a,xh
2788  0632 5f            	clrw	x
2789  0633 97            	ld	xl,a
2790  0634 7b02          	ld	a,(OFST+2,sp)
2791  0636 e71b          	ld	(_pwm_brightness_buffer+19,x),a
2792                     ; 433 }
2795  0638 85            	popw	x
2796  0639 81            	ret
2831                     ; 436 void set_debug(u8 brightness)
2831                     ; 437 {
2832                     	switch	.text
2833  063a               _set_debug:
2837                     ; 438 	pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness;
2839  063a b71a          	ld	_pwm_brightness_buffer+18,a
2840                     ; 439 }
2843  063c 81            	ret
2866                     ; 441 void set_matrix_high_z()
2866                     ; 442 {
2867                     	switch	.text
2868  063d               _set_matrix_high_z:
2872                     ; 443 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2874  063d c6500d        	ld	a,20493
2875  0640 a407          	and	a,#7
2876  0642 c7500d        	ld	20493,a
2877                     ; 444 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2879  0645 72155012      	bres	20498,#2
2880                     ; 445 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2882  0649 72175003      	bres	20483,#3
2883                     ; 448 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_3));//DEBUG_BROKEN
2885  064d 72175012      	bres	20498,#3
2886                     ; 449 }
2889  0651 81            	ret
2923                     ; 451 u8 get_eeprom_byte(u16 eeprom_address)
2923                     ; 452 {
2924                     	switch	.text
2925  0652               _get_eeprom_byte:
2929                     ; 453 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2931  0652 d64000        	ld	a,(16384,x)
2934  0655 81            	ret
3062                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3063                     	switch	.ubsct
3064  0000               _button_pressed_event:
3065  0000 00000000      	ds.b	4
3066                     	xdef	_button_pressed_event
3067  0004               _button_start_ms:
3068  0004 00000000      	ds.b	4
3069                     	xdef	_button_start_ms
3070                     	xdef	_pwm_state
3071                     	xdef	_pwm_visible_index
3072                     	xdef	_pwm_led_count
3073                     	xdef	_pwm_sleep
3074  0008               _pwm_brightness_buffer:
3075  0008 000000000000  	ds.b	31
3076                     	xdef	_pwm_brightness_buffer
3077  0027               _pwm_brightness_index:
3078  0027 000000000000  	ds.b	62
3079                     	xdef	_pwm_brightness_index
3080                     	xdef	_pwm_brightness
3081                     	xdef	_atomic_counter
3082                     	xdef	_frame_counter
3083                     	xref	_UART1_Cmd
3084                     	xref	_UART1_Init
3085                     	xref	_UART1_DeInit
3086                     	xref	_GPIO_ReadInputPin
3087                     	xref	_GPIO_Init
3088                     	xdef	_set_led_on
3089                     	xdef	_set_mat
3090                     	xdef	_get_eeprom_byte
3091                     	xdef	_get_random
3092                     	xdef	_is_button_down
3093                     	xdef	_clear_button_events
3094                     	xdef	_clear_button_event
3095                     	xdef	_get_button_event
3096                     	xdef	_update_buttons
3097                     	xdef	_is_developer_valid
3098                     	xdef	_set_hue_max
3099                     	xdef	_flush_leds
3100                     	xdef	_set_debug
3101                     	xdef	_set_white
3102                     	xdef	_set_rgb
3103                     	xdef	_set_matrix_high_z
3104                     	xdef	_millis
3105                     	xdef	_setup_main
3106                     	xdef	_is_application_valid
3107                     	xdef	_setup_serial
3108                     	xdef	_hello_world
3109                     	xref.b	c_lreg
3110                     	xref.b	c_x
3111                     	xref.b	c_y
3131                     	xref	c_xymov
3132                     	xref	c_lgadd
3133                     	xref	c_lzmp
3134                     	xref	c_lsub
3135                     	xref	c_rtol
3136                     	xref	c_uitolx
3137                     	xref	c_lursh
3138                     	xref	c_itolx
3139                     	xref	c_ltor
3140                     	xref	c_imul
3141                     	end
