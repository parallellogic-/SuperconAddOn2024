   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _frame_counter:
  16  0000 00            	dc.b	0
  17  0001               _pwm_brightness:
  18  0001 0001          	dc.w	1
  19  0003 0001          	dc.w	1
  20  0005 000000000000  	ds.b	120
  21  007d               _pwm_sleep:
  22  007d 0001          	dc.w	1
  23  007f 0001          	dc.w	1
  24  0081               _pwm_led_count:
  25  0081 01            	dc.b	1
  26  0082 01            	dc.b	1
  27  0083               _pwm_visible_index:
  28  0083 00            	dc.b	0
  29  0084               _pwm_state:
  30  0084 00            	dc.b	0
  31  0085               _temp_delete_me:
  32  0085 0000          	dc.w	0
  33  0087               _temp3_delete_me:
  34  0087 0000          	dc.w	0
 109                     .const:	section	.text
 110  0000               L01:
 111  0000 00000010      	dc.l	16
 112  0004               L21:
 113  0004 00000002      	dc.l	2
 114  0008               L61:
 115  0008 00000200      	dc.l	512
 116  000c               L02:
 117  000c 00002aab      	dc.l	10923
 118  0010               L42:
 119  0010 00000100      	dc.l	256
 120                     ; 32 void hello_world()
 120                     ; 33 {//basic program that blinks the debug LED ON/OFF
 121                     	scross	off
 122                     	switch	.text
 123  0000               _hello_world:
 125  0000 5205          	subw	sp,#5
 126       00000005      OFST:	set	5
 129                     ; 36 	bool is_high=0;
 131                     ; 37 	long frame=0;
 133  0002 ae0000        	ldw	x,#0
 134  0005 1f04          	ldw	(OFST-1,sp),x
 135  0007 ae0000        	ldw	x,#0
 136  000a 1f02          	ldw	(OFST-3,sp),x
 138                     ; 38 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 140  000c 4b40          	push	#64
 141  000e 4b08          	push	#8
 142  0010 ae5000        	ldw	x,#20480
 143  0013 cd0000        	call	_GPIO_Init
 145  0016 85            	popw	x
 146  0017               L34:
 147                     ; 45 		frame++;
 149  0017 96            	ldw	x,sp
 150  0018 1c0002        	addw	x,#OFST-3
 151  001b a601          	ld	a,#1
 152  001d cd0000        	call	c_lgadc
 155                     ; 58 			set_debug(((frame/16)%2)?0xFF:0);
 157  0020 96            	ldw	x,sp
 158  0021 1c0002        	addw	x,#OFST-3
 159  0024 cd0000        	call	c_ltor
 161  0027 ae0000        	ldw	x,#L01
 162  002a cd0000        	call	c_ldiv
 164  002d ae0004        	ldw	x,#L21
 165  0030 cd0000        	call	c_lmod
 167  0033 cd0000        	call	c_lrzmp
 169  0036 2704          	jreq	L6
 170  0038 a6ff          	ld	a,#255
 171  003a 2001          	jra	L41
 172  003c               L6:
 173  003c 4f            	clr	a
 174  003d               L41:
 175  003d cd060f        	call	_set_debug
 177                     ; 63 			if((frame>>8)&0x01)
 179  0040 7b04          	ld	a,(OFST-1,sp)
 180  0042 a501          	bcp	a,#1
 181  0044 2717          	jreq	L74
 182                     ; 64 				set_hue_max(3,frame<<9);
 184  0046 96            	ldw	x,sp
 185  0047 1c0002        	addw	x,#OFST-3
 186  004a cd0000        	call	c_ltor
 188  004d a609          	ld	a,#9
 189  004f cd0000        	call	c_llsh
 191  0052 be02          	ldw	x,c_lreg+2
 192  0054 89            	pushw	x
 193  0055 a603          	ld	a,#3
 194  0057 cd0547        	call	_set_hue_max
 196  005a 85            	popw	x
 198  005b 2027          	jra	L15
 199  005d               L74:
 200                     ; 66 				set_hue_max(3,(((frame+1)<<9)/0x2aab)*0x2aab);
 202  005d 96            	ldw	x,sp
 203  005e 1c0002        	addw	x,#OFST-3
 204  0061 cd0000        	call	c_ltor
 206  0064 a609          	ld	a,#9
 207  0066 cd0000        	call	c_llsh
 209  0069 ae0008        	ldw	x,#L61
 210  006c cd0000        	call	c_ladd
 212  006f ae000c        	ldw	x,#L02
 213  0072 cd0000        	call	c_ldiv
 215  0075 ae000c        	ldw	x,#L02
 216  0078 cd0000        	call	c_lmul
 218  007b be02          	ldw	x,c_lreg+2
 219  007d 89            	pushw	x
 220  007e a603          	ld	a,#3
 221  0080 cd0547        	call	_set_hue_max
 223  0083 85            	popw	x
 224  0084               L15:
 225                     ; 69 			set_white(0,(frame/256)%2?(frame):(~frame));
 227  0084 96            	ldw	x,sp
 228  0085 1c0002        	addw	x,#OFST-3
 229  0088 cd0000        	call	c_ltor
 231  008b ae0010        	ldw	x,#L42
 232  008e cd0000        	call	c_ldiv
 234  0091 ae0004        	ldw	x,#L21
 235  0094 cd0000        	call	c_lmod
 237  0097 cd0000        	call	c_lrzmp
 239  009a 2704          	jreq	L22
 240  009c 7b05          	ld	a,(OFST+0,sp)
 241  009e 2003          	jra	L62
 242  00a0               L22:
 243  00a0 7b05          	ld	a,(OFST+0,sp)
 244  00a2 43            	cpl	a
 245  00a3               L62:
 246  00a3 5f            	clrw	x
 247  00a4 97            	ld	xl,a
 248  00a5 cd0605        	call	_set_white
 250                     ; 70 			set_white(1,(frame/256)%2?(~frame):(frame));
 252  00a8 96            	ldw	x,sp
 253  00a9 1c0002        	addw	x,#OFST-3
 254  00ac cd0000        	call	c_ltor
 256  00af ae0010        	ldw	x,#L42
 257  00b2 cd0000        	call	c_ldiv
 259  00b5 ae0004        	ldw	x,#L21
 260  00b8 cd0000        	call	c_lmod
 262  00bb cd0000        	call	c_lrzmp
 264  00be 2705          	jreq	L03
 265  00c0 7b05          	ld	a,(OFST+0,sp)
 266  00c2 43            	cpl	a
 267  00c3 2002          	jra	L23
 268  00c5               L03:
 269  00c5 7b05          	ld	a,(OFST+0,sp)
 270  00c7               L23:
 271  00c7 ae0100        	ldw	x,#256
 272  00ca 97            	ld	xl,a
 273  00cb cd0605        	call	_set_white
 275                     ; 83 			flush_leds(9);
 277  00ce a609          	ld	a,#9
 278  00d0 cd046f        	call	_flush_leds
 281  00d3 ac170017      	jpf	L34
 333                     ; 90 u16 get_random(u16 x)
 333                     ; 91 {
 334                     	switch	.text
 335  00d7               _get_random:
 337  00d7 5204          	subw	sp,#4
 338       00000004      OFST:	set	4
 341                     ; 92 	u16 a=1664525;
 343                     ; 93 	u16 c=1013904223;
 345                     ; 94 	return a * x + c;
 347  00d9 90ae660d      	ldw	y,#26125
 348  00dd cd0000        	call	c_imul
 350  00e0 1cf35f        	addw	x,#62303
 353  00e3 5b04          	addw	sp,#4
 354  00e5 81            	ret
 403                     	switch	.const
 404  0014               L44:
 405  0014 000f4240      	dc.l	1000000
 406                     ; 97 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 406                     ; 98 {
 407                     	switch	.text
 408  00e6               _setup_serial:
 410  00e6 89            	pushw	x
 411       00000000      OFST:	set	0
 414                     ; 99 	if(is_enabled)
 416  00e7 9e            	ld	a,xh
 417  00e8 4d            	tnz	a
 418  00e9 2747          	jreq	L321
 419                     ; 101 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 421  00eb 4bf0          	push	#240
 422  00ed 4b20          	push	#32
 423  00ef ae500f        	ldw	x,#20495
 424  00f2 cd0000        	call	_GPIO_Init
 426  00f5 85            	popw	x
 427                     ; 102 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 429  00f6 4b40          	push	#64
 430  00f8 4b40          	push	#64
 431  00fa ae500f        	ldw	x,#20495
 432  00fd cd0000        	call	_GPIO_Init
 434  0100 85            	popw	x
 435                     ; 103 		UART1_DeInit();
 437  0101 cd0000        	call	_UART1_DeInit
 439                     ; 104 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 441  0104 4b0c          	push	#12
 442  0106 4b80          	push	#128
 443  0108 4b00          	push	#0
 444  010a 4b00          	push	#0
 445  010c 4b00          	push	#0
 446  010e 0d07          	tnz	(OFST+7,sp)
 447  0110 2708          	jreq	L04
 448  0112 ae2580        	ldw	x,#9600
 449  0115 cd0000        	call	c_itolx
 451  0118 2006          	jra	L24
 452  011a               L04:
 453  011a ae0014        	ldw	x,#L44
 454  011d cd0000        	call	c_ltor
 456  0120               L24:
 457  0120 be02          	ldw	x,c_lreg+2
 458  0122 89            	pushw	x
 459  0123 be00          	ldw	x,c_lreg
 460  0125 89            	pushw	x
 461  0126 cd0000        	call	_UART1_Init
 463  0129 5b09          	addw	sp,#9
 464                     ; 105 		UART1_Cmd(ENABLE);
 466  012b a601          	ld	a,#1
 467  012d cd0000        	call	_UART1_Cmd
 470  0130 201d          	jra	L521
 471  0132               L321:
 472                     ; 107 		UART1_Cmd(DISABLE);
 474  0132 4f            	clr	a
 475  0133 cd0000        	call	_UART1_Cmd
 477                     ; 108 		UART1_DeInit();
 479  0136 cd0000        	call	_UART1_DeInit
 481                     ; 109 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 483  0139 4b40          	push	#64
 484  013b 4b20          	push	#32
 485  013d ae500f        	ldw	x,#20495
 486  0140 cd0000        	call	_GPIO_Init
 488  0143 85            	popw	x
 489                     ; 110 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 491  0144 4b40          	push	#64
 492  0146 4b40          	push	#64
 493  0148 ae500f        	ldw	x,#20495
 494  014b cd0000        	call	_GPIO_Init
 496  014e 85            	popw	x
 497  014f               L521:
 498                     ; 112 }
 501  014f 85            	popw	x
 502  0150 81            	ret
 529                     ; 115 bool is_application_valid()
 529                     ; 116 {
 530                     	switch	.text
 531  0151               _is_application_valid:
 535                     ; 117 	return !is_button_down(2) && !get_button_event(0,1);
 537  0151 a602          	ld	a,#2
 538  0153 cd0287        	call	_is_button_down
 540  0156 4d            	tnz	a
 541  0157 260d          	jrne	L05
 542  0159 ae0001        	ldw	x,#1
 543  015c cd0238        	call	_get_button_event
 545  015f 4d            	tnz	a
 546  0160 2604          	jrne	L05
 547  0162 a601          	ld	a,#1
 548  0164 2001          	jra	L25
 549  0166               L05:
 550  0166 4f            	clr	a
 551  0167               L25:
 554  0167 81            	ret
 580                     ; 121 bool is_developer_valid()
 580                     ; 122 {
 581                     	switch	.text
 582  0168               _is_developer_valid:
 586                     ; 123 	return is_button_down(2) && !get_button_event(0,1);
 588  0168 a602          	ld	a,#2
 589  016a cd0287        	call	_is_button_down
 591  016d 4d            	tnz	a
 592  016e 270d          	jreq	L65
 593  0170 ae0001        	ldw	x,#1
 594  0173 cd0238        	call	_get_button_event
 596  0176 4d            	tnz	a
 597  0177 2604          	jrne	L65
 598  0179 a601          	ld	a,#1
 599  017b 2001          	jra	L06
 600  017d               L65:
 601  017d 4f            	clr	a
 602  017e               L06:
 605  017e 81            	ret
 630                     ; 126 void setup_main()
 630                     ; 127 {
 631                     	switch	.text
 632  017f               _setup_main:
 636                     ; 128 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 638  017f c650c6        	ld	a,20678
 639  0182 a4e7          	and	a,#231
 640  0184 c750c6        	ld	20678,a
 641                     ; 130 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 643  0187 4b40          	push	#64
 644  0189 4b02          	push	#2
 645  018b ae500f        	ldw	x,#20495
 646  018e cd0000        	call	_GPIO_Init
 648  0191 85            	popw	x
 649                     ; 133 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 651  0192 725f5311      	clr	21265
 652                     ; 134 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 654  0196 3505530e      	mov	21262,#5
 655                     ; 135 	TIM2->ARRH= 16;// init auto reload register
 657  019a 3510530f      	mov	21263,#16
 658                     ; 136 	TIM2->ARRL= 255;// init auto reload register
 660  019e 35ff5310      	mov	21264,#255
 661                     ; 138 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 663  01a2 c65300        	ld	a,21248
 664  01a5 aa05          	or	a,#5
 665  01a7 c75300        	ld	21248,a
 666                     ; 140 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 668  01aa 35015303      	mov	21251,#1
 669                     ; 141 	enableInterrupts();
 672  01ae 9a            rim
 674                     ; 142 }
 678  01af 81            	ret
 701                     ; 144 u32 millis()
 701                     ; 145 {
 702                     	switch	.text
 703  01b0               _millis:
 707                     ; 146 	return 0;//api_counter>>10;
 709  01b0 ae0000        	ldw	x,#0
 710  01b3 bf02          	ldw	c_lreg+2,x
 711  01b5 ae0000        	ldw	x,#0
 712  01b8 bf00          	ldw	c_lreg,x
 715  01ba 81            	ret
 773                     ; 152 void update_buttons()
 773                     ; 153 {
 774                     	switch	.text
 775  01bb               _update_buttons:
 777  01bb 5208          	subw	sp,#8
 778       00000008      OFST:	set	8
 781                     ; 154 	bool is_any_down=0;
 783  01bd 0f05          	clr	(OFST-3,sp)
 785                     ; 156 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 787  01bf be06          	ldw	x,_button_start_ms+2
 788  01c1 cd0000        	call	c_uitolx
 790  01c4 96            	ldw	x,sp
 791  01c5 1c0001        	addw	x,#OFST-7
 792  01c8 cd0000        	call	c_rtol
 795  01cb ade3          	call	_millis
 797  01cd 96            	ldw	x,sp
 798  01ce 1c0001        	addw	x,#OFST-7
 799  01d1 cd0000        	call	c_lsub
 801  01d4 be02          	ldw	x,c_lreg+2
 802  01d6 1f06          	ldw	(OFST-2,sp),x
 804                     ; 157 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 806  01d8 0f08          	clr	(OFST+0,sp)
 808  01da               L512:
 809                     ; 159 		if(is_button_down(button_index))
 811  01da 7b08          	ld	a,(OFST+0,sp)
 812  01dc cd0287        	call	_is_button_down
 814  01df 4d            	tnz	a
 815  01e0 271b          	jreq	L322
 816                     ; 161 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 818  01e2 ae0004        	ldw	x,#_button_start_ms
 819  01e5 cd0000        	call	c_lzmp
 821  01e8 2608          	jrne	L522
 824  01ea adc4          	call	_millis
 826  01ec ae0004        	ldw	x,#_button_start_ms
 827  01ef cd0000        	call	c_rtol
 829  01f2               L522:
 830                     ; 162 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 832  01f2 a6ff          	ld	a,#255
 833  01f4 cd060f        	call	_set_debug
 835                     ; 163 			is_any_down=1;
 837  01f7 a601          	ld	a,#1
 838  01f9 6b05          	ld	(OFST-3,sp),a
 841  01fb 2022          	jra	L722
 842  01fd               L322:
 843                     ; 165 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 845  01fd 1e06          	ldw	x,(OFST-2,sp)
 846  01ff a30201        	cpw	x,#513
 847  0202 250b          	jrult	L132
 850  0204 7b08          	ld	a,(OFST+0,sp)
 851  0206 5f            	clrw	x
 852  0207 97            	ld	xl,a
 853  0208 58            	sllw	x
 854  0209 a601          	ld	a,#1
 855  020b e701          	ld	(_button_pressed_event+1,x),a
 857  020d 2010          	jra	L722
 858  020f               L132:
 859                     ; 166 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 861  020f 1e06          	ldw	x,(OFST-2,sp)
 862  0211 a30033        	cpw	x,#51
 863  0214 2509          	jrult	L722
 866  0216 7b08          	ld	a,(OFST+0,sp)
 867  0218 5f            	clrw	x
 868  0219 97            	ld	xl,a
 869  021a 58            	sllw	x
 870  021b a601          	ld	a,#1
 871  021d e700          	ld	(_button_pressed_event,x),a
 872  021f               L722:
 873                     ; 157 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 875  021f 0c08          	inc	(OFST+0,sp)
 879  0221 7b08          	ld	a,(OFST+0,sp)
 880  0223 a102          	cp	a,#2
 881  0225 25b3          	jrult	L512
 882                     ; 170 	if(!is_any_down) button_start_ms=0;
 884  0227 0d05          	tnz	(OFST-3,sp)
 885  0229 260a          	jrne	L732
 888  022b ae0000        	ldw	x,#0
 889  022e bf06          	ldw	_button_start_ms+2,x
 890  0230 ae0000        	ldw	x,#0
 891  0233 bf04          	ldw	_button_start_ms,x
 892  0235               L732:
 893                     ; 171 }
 896  0235 5b08          	addw	sp,#8
 897  0237 81            	ret
 943                     ; 174 bool get_button_event(u8 button_index,bool is_long)
 943                     ; 175 { return button_pressed_event[button_index][is_long]; }
 944                     	switch	.text
 945  0238               _get_button_event:
 947  0238 89            	pushw	x
 948       00000000      OFST:	set	0
 953  0239 9e            	ld	a,xh
 954  023a 5f            	clrw	x
 955  023b 97            	ld	xl,a
 956  023c 58            	sllw	x
 957  023d 01            	rrwa	x,a
 958  023e 1b02          	add	a,(OFST+2,sp)
 959  0240 2401          	jrnc	L27
 960  0242 5c            	incw	x
 961  0243               L27:
 962  0243 02            	rlwa	x,a
 963  0244 e600          	ld	a,(_button_pressed_event,x)
 966  0246 85            	popw	x
 967  0247 81            	ret
1023                     ; 178 bool clear_button_event(u8 button_index,bool is_long)
1023                     ; 179 {
1024                     	switch	.text
1025  0248               _clear_button_event:
1027  0248 89            	pushw	x
1028  0249 88            	push	a
1029       00000001      OFST:	set	1
1032                     ; 180 	bool out=button_pressed_event[button_index][is_long];
1034  024a 9e            	ld	a,xh
1035  024b 5f            	clrw	x
1036  024c 97            	ld	xl,a
1037  024d 58            	sllw	x
1038  024e 01            	rrwa	x,a
1039  024f 1b03          	add	a,(OFST+2,sp)
1040  0251 2401          	jrnc	L67
1041  0253 5c            	incw	x
1042  0254               L67:
1043  0254 02            	rlwa	x,a
1044  0255 e600          	ld	a,(_button_pressed_event,x)
1045  0257 6b01          	ld	(OFST+0,sp),a
1047                     ; 181 	button_pressed_event[button_index][is_long]=0;
1049  0259 7b02          	ld	a,(OFST+1,sp)
1050  025b 5f            	clrw	x
1051  025c 97            	ld	xl,a
1052  025d 58            	sllw	x
1053  025e 01            	rrwa	x,a
1054  025f 1b03          	add	a,(OFST+2,sp)
1055  0261 2401          	jrnc	L001
1056  0263 5c            	incw	x
1057  0264               L001:
1058  0264 02            	rlwa	x,a
1059  0265 6f00          	clr	(_button_pressed_event,x)
1060                     ; 182 	return out;
1062  0267 7b01          	ld	a,(OFST+0,sp)
1065  0269 5b03          	addw	sp,#3
1066  026b 81            	ret
1102                     ; 185 void clear_button_events()
1102                     ; 186 {
1103                     	switch	.text
1104  026c               _clear_button_events:
1106  026c 88            	push	a
1107       00000001      OFST:	set	1
1110                     ; 188 	for(iter=0;iter<BUTTON_COUNT;iter++)
1112  026d 0f01          	clr	(OFST+0,sp)
1114  026f               L723:
1115                     ; 190 		clear_button_event(iter,0);
1117  026f 7b01          	ld	a,(OFST+0,sp)
1118  0271 5f            	clrw	x
1119  0272 95            	ld	xh,a
1120  0273 add3          	call	_clear_button_event
1122                     ; 191 		clear_button_event(iter,1);
1124  0275 7b01          	ld	a,(OFST+0,sp)
1125  0277 ae0001        	ldw	x,#1
1126  027a 95            	ld	xh,a
1127  027b adcb          	call	_clear_button_event
1129                     ; 188 	for(iter=0;iter<BUTTON_COUNT;iter++)
1131  027d 0c01          	inc	(OFST+0,sp)
1135  027f 7b01          	ld	a,(OFST+0,sp)
1136  0281 a102          	cp	a,#2
1137  0283 25ea          	jrult	L723
1138                     ; 193 }
1141  0285 84            	pop	a
1142  0286 81            	ret
1178                     ; 196 bool is_button_down(u8 index)
1178                     ; 197 {
1179                     	switch	.text
1180  0287               _is_button_down:
1184                     ; 198 	switch(index)
1187                     ; 202 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1189  0287 4d            	tnz	a
1190  0288 2708          	jreq	L533
1191  028a 4a            	dec	a
1192  028b 2718          	jreq	L733
1193  028d 4a            	dec	a
1194  028e 2728          	jreq	L143
1195  0290 2039          	jra	L363
1196  0292               L533:
1197                     ; 200 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1199  0292 4b20          	push	#32
1200  0294 ae500f        	ldw	x,#20495
1201  0297 cd0000        	call	_GPIO_ReadInputPin
1203  029a 5b01          	addw	sp,#1
1204  029c 4d            	tnz	a
1205  029d 2604          	jrne	L601
1206  029f a601          	ld	a,#1
1207  02a1 2001          	jra	L011
1208  02a3               L601:
1209  02a3 4f            	clr	a
1210  02a4               L011:
1213  02a4 81            	ret
1214  02a5               L733:
1215                     ; 201 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1218  02a5 4b40          	push	#64
1219  02a7 ae500f        	ldw	x,#20495
1220  02aa cd0000        	call	_GPIO_ReadInputPin
1222  02ad 5b01          	addw	sp,#1
1223  02af 4d            	tnz	a
1224  02b0 2604          	jrne	L211
1225  02b2 a601          	ld	a,#1
1226  02b4 2001          	jra	L411
1227  02b6               L211:
1228  02b6 4f            	clr	a
1229  02b7               L411:
1232  02b7 81            	ret
1233  02b8               L143:
1234                     ; 202 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1237  02b8 4b02          	push	#2
1238  02ba ae500f        	ldw	x,#20495
1239  02bd cd0000        	call	_GPIO_ReadInputPin
1241  02c0 5b01          	addw	sp,#1
1242  02c2 4d            	tnz	a
1243  02c3 2604          	jrne	L611
1244  02c5 a601          	ld	a,#1
1245  02c7 2001          	jra	L021
1246  02c9               L611:
1247  02c9 4f            	clr	a
1248  02ca               L021:
1251  02ca 81            	ret
1252  02cb               L363:
1253                     ; 204 	return 0;
1255  02cb 4f            	clr	a
1258  02cc 81            	ret
1311                     ; 208 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1313                     	switch	.text
1314  02cd               f_TIM2_UPD_OVF_IRQHandler:
1316  02cd 8a            	push	cc
1317  02ce 84            	pop	a
1318  02cf a4bf          	and	a,#191
1319  02d1 88            	push	a
1320  02d2 86            	pop	cc
1321       00000005      OFST:	set	5
1322  02d3 3b0002        	push	c_x+2
1323  02d6 be00          	ldw	x,c_x
1324  02d8 89            	pushw	x
1325  02d9 3b0002        	push	c_y+2
1326  02dc be00          	ldw	x,c_y
1327  02de 89            	pushw	x
1328  02df 5205          	subw	sp,#5
1331                     ; 209 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1333  02e1 b684          	ld	a,_pwm_state
1334  02e3 a401          	and	a,#1
1335  02e5 6b05          	ld	(OFST+0,sp),a
1337                     ; 210 	u16 sleep_counts=1;
1339  02e7 ae0001        	ldw	x,#1
1340  02ea 1f03          	ldw	(OFST-2,sp),x
1342                     ; 212 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1344  02ec c6500c        	ld	a,20492
1345  02ef a407          	and	a,#7
1346  02f1 c7500c        	ld	20492,a
1347                     ; 213 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1349  02f4 72155011      	bres	20497,#2
1350                     ; 214 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1352  02f8 72175002      	bres	20482,#3
1353                     ; 215 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1355  02fc c6500d        	ld	a,20493
1356  02ff a407          	and	a,#7
1357  0301 c7500d        	ld	20493,a
1358                     ; 216 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1360  0304 72155012      	bres	20498,#2
1361                     ; 217 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1363  0308 72175003      	bres	20483,#3
1364                     ; 218   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1366  030c 72115300      	bres	21248,#0
1367                     ; 219 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1369  0310 7b05          	ld	a,(OFST+0,sp)
1370  0312 5f            	clrw	x
1371  0313 97            	ld	xl,a
1372  0314 e681          	ld	a,(_pwm_led_count,x)
1373  0316 b183          	cp	a,_pwm_visible_index
1374  0318 2609          	jrne	L704
1375                     ; 221 		sleep_counts=pwm_sleep[buffer_index];
1377  031a 7b05          	ld	a,(OFST+0,sp)
1378  031c 5f            	clrw	x
1379  031d 97            	ld	xl,a
1380  031e 58            	sllw	x
1381  031f ee7d          	ldw	x,(_pwm_sleep,x)
1382  0321 1f03          	ldw	(OFST-2,sp),x
1384  0323               L704:
1385                     ; 223 	if(pwm_visible_index>pwm_led_count[buffer_index])
1387  0323 7b05          	ld	a,(OFST+0,sp)
1388  0325 5f            	clrw	x
1389  0326 97            	ld	xl,a
1390  0327 e681          	ld	a,(_pwm_led_count,x)
1391  0329 b183          	cp	a,_pwm_visible_index
1392  032b 2416          	jruge	L114
1393                     ; 225 		frame_counter++;
1395  032d 3c00          	inc	_frame_counter
1396                     ; 226 		pwm_visible_index=0;//formally start new frame
1398  032f 3f83          	clr	_pwm_visible_index
1399                     ; 227 		if(pwm_state&0x02)
1401  0331 b684          	ld	a,_pwm_state
1402  0333 a502          	bcp	a,#2
1403  0335 270c          	jreq	L114
1404                     ; 229 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1406  0337 b684          	ld	a,_pwm_state
1407  0339 a803          	xor	a,#3
1408  033b b784          	ld	_pwm_state,a
1409                     ; 230 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1411  033d b684          	ld	a,_pwm_state
1412  033f a401          	and	a,#1
1413  0341 6b05          	ld	(OFST+0,sp),a
1415  0343               L114:
1416                     ; 233 	if(pwm_visible_index<pwm_led_count[buffer_index])
1418  0343 7b05          	ld	a,(OFST+0,sp)
1419  0345 5f            	clrw	x
1420  0346 97            	ld	xl,a
1421  0347 e681          	ld	a,(_pwm_led_count,x)
1422  0349 b183          	cp	a,_pwm_visible_index
1423  034b 2324          	jrule	L514
1424                     ; 235 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1426  034d 7b05          	ld	a,(OFST+0,sp)
1427  034f 5f            	clrw	x
1428  0350 97            	ld	xl,a
1429  0351 58            	sllw	x
1430  0352 1f01          	ldw	(OFST-4,sp),x
1432  0354 b683          	ld	a,_pwm_visible_index
1433  0356 97            	ld	xl,a
1434  0357 a604          	ld	a,#4
1435  0359 42            	mul	x,a
1436  035a 72fb01        	addw	x,(OFST-4,sp)
1437  035d ee01          	ldw	x,(_pwm_brightness,x)
1438  035f 1f03          	ldw	(OFST-2,sp),x
1440                     ; 236 		set_led(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1442  0361 b683          	ld	a,_pwm_visible_index
1443  0363 5f            	clrw	x
1444  0364 97            	ld	xl,a
1445  0365 58            	sllw	x
1446  0366 01            	rrwa	x,a
1447  0367 1b05          	add	a,(OFST+0,sp)
1448  0369 2401          	jrnc	L421
1449  036b 5c            	incw	x
1450  036c               L421:
1451  036c 02            	rlwa	x,a
1452  036d e627          	ld	a,(_pwm_brightness_index,x)
1453  036f ad2d          	call	_set_led
1455  0371               L514:
1456                     ; 238 	pwm_visible_index++;
1458  0371 3c83          	inc	_pwm_visible_index
1459                     ; 240   TIM2->CNTRH = 0;// Set the high byte of the counter
1461  0373 725f530c      	clr	21260
1462                     ; 241   TIM2->CNTRL = 0;// Set the low byte of the counter
1464  0377 725f530d      	clr	21261
1465                     ; 242 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1467  037b 7b03          	ld	a,(OFST-2,sp)
1468  037d c7530f        	ld	21263,a
1469                     ; 243 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1471  0380 7b04          	ld	a,(OFST-1,sp)
1472  0382 a4ff          	and	a,#255
1473  0384 c75310        	ld	21264,a
1474                     ; 245 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1476  0387 72115304      	bres	21252,#0
1477                     ; 246   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1479  038b 72105300      	bset	21248,#0
1480                     ; 247 }
1483  038f 5b05          	addw	sp,#5
1484  0391 85            	popw	x
1485  0392 bf00          	ldw	c_y,x
1486  0394 320002        	pop	c_y+2
1487  0397 85            	popw	x
1488  0398 bf00          	ldw	c_x,x
1489  039a 320002        	pop	c_x+2
1490  039d 80            	iret
1492                     	switch	.const
1493  0018               L714_led_lookup:
1494  0018 00            	dc.b	0
1495  0019 03            	dc.b	3
1496  001a 01            	dc.b	1
1497  001b 03            	dc.b	3
1498  001c 02            	dc.b	2
1499  001d 03            	dc.b	3
1500  001e 03            	dc.b	3
1501  001f 00            	dc.b	0
1502  0020 04            	dc.b	4
1503  0021 00            	dc.b	0
1504  0022 05            	dc.b	5
1505  0023 00            	dc.b	0
1506  0024 00            	dc.b	0
1507  0025 04            	dc.b	4
1508  0026 01            	dc.b	1
1509  0027 04            	dc.b	4
1510  0028 02            	dc.b	2
1511  0029 04            	dc.b	4
1512  002a 03            	dc.b	3
1513  002b 01            	dc.b	1
1514  002c 04            	dc.b	4
1515  002d 01            	dc.b	1
1516  002e 05            	dc.b	5
1517  002f 01            	dc.b	1
1518  0030 00            	dc.b	0
1519  0031 05            	dc.b	5
1520  0032 01            	dc.b	1
1521  0033 05            	dc.b	5
1522  0034 02            	dc.b	2
1523  0035 05            	dc.b	5
1524  0036 03            	dc.b	3
1525  0037 02            	dc.b	2
1526  0038 04            	dc.b	4
1527  0039 02            	dc.b	2
1528  003a 05            	dc.b	5
1529  003b 02            	dc.b	2
1530  003c 06            	dc.b	6
1531  003d 06            	dc.b	6
1532  003e 01            	dc.b	1
1533  003f 00            	dc.b	0
1534  0040 02            	dc.b	2
1535  0041 00            	dc.b	0
1536  0042 00            	dc.b	0
1537  0043 01            	dc.b	1
1538  0044 02            	dc.b	2
1539  0045 01            	dc.b	1
1540  0046 00            	dc.b	0
1541  0047 02            	dc.b	2
1542  0048 01            	dc.b	1
1543  0049 02            	dc.b	2
1544  004a 04            	dc.b	4
1545  004b 03            	dc.b	3
1546  004c 05            	dc.b	5
1547  004d 03            	dc.b	3
1548  004e 03            	dc.b	3
1549  004f 04            	dc.b	4
1550  0050 05            	dc.b	5
1551  0051 04            	dc.b	4
1552  0052 03            	dc.b	3
1553  0053 05            	dc.b	5
1554  0054 04            	dc.b	4
1555  0055 05            	dc.b	5
1599                     ; 250 void set_led(u8 led_index)
1599                     ; 251 {
1601                     	switch	.text
1602  039e               _set_led:
1604  039e 88            	push	a
1605  039f 5240          	subw	sp,#64
1606       00000040      OFST:	set	64
1609                     ; 252 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1609                     ; 253 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1609                     ; 254 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1609                     ; 255 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1609                     ; 256 		{6,6},//debug; GND is tied low, no charlieplexing involved
1609                     ; 257 		{1,0},//LED7
1609                     ; 258 		{2,0},//LED8
1609                     ; 259 		{0,1},//LED9
1609                     ; 260 		{2,1},//LED10
1609                     ; 261 		{0,2},//LED11
1609                     ; 262 		{1,2},//LED12
1609                     ; 263 		{4,3},//LED13
1609                     ; 264 		{5,3},//LED14
1609                     ; 265 		{3,4},//LED15
1609                     ; 266 		{5,4},//LED16
1609                     ; 267 		{3,5},//LED17
1609                     ; 268 		{4,5} //LED18
1609                     ; 269 	};
1611  03a1 96            	ldw	x,sp
1612  03a2 1c0003        	addw	x,#OFST-61
1613  03a5 90ae0018      	ldw	y,#L714_led_lookup
1614  03a9 a63e          	ld	a,#62
1615  03ab cd0000        	call	c_xymov
1617                     ; 270 	set_mat(led_lookup[led_index][0],1);
1619  03ae 96            	ldw	x,sp
1620  03af 1c0003        	addw	x,#OFST-61
1621  03b2 1f01          	ldw	(OFST-63,sp),x
1623  03b4 7b41          	ld	a,(OFST+1,sp)
1624  03b6 5f            	clrw	x
1625  03b7 97            	ld	xl,a
1626  03b8 58            	sllw	x
1627  03b9 72fb01        	addw	x,(OFST-63,sp)
1628  03bc f6            	ld	a,(x)
1629  03bd ae0001        	ldw	x,#1
1630  03c0 95            	ld	xh,a
1631  03c1 ad1c          	call	_set_mat
1633                     ; 272 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1635  03c3 7b41          	ld	a,(OFST+1,sp)
1636  03c5 a112          	cp	a,#18
1637  03c7 2713          	jreq	L344
1640  03c9 96            	ldw	x,sp
1641  03ca 1c0004        	addw	x,#OFST-60
1642  03cd 1f01          	ldw	(OFST-63,sp),x
1644  03cf 7b41          	ld	a,(OFST+1,sp)
1645  03d1 5f            	clrw	x
1646  03d2 97            	ld	xl,a
1647  03d3 58            	sllw	x
1648  03d4 72fb01        	addw	x,(OFST-63,sp)
1649  03d7 f6            	ld	a,(x)
1650  03d8 5f            	clrw	x
1651  03d9 95            	ld	xh,a
1652  03da ad03          	call	_set_mat
1654  03dc               L344:
1655                     ; 273 }
1658  03dc 5b41          	addw	sp,#65
1659  03de 81            	ret
1860                     ; 276 void set_mat(u8 mat_index,bool is_high)
1860                     ; 277 {
1861                     	switch	.text
1862  03df               _set_mat:
1864  03df 89            	pushw	x
1865  03e0 5203          	subw	sp,#3
1866       00000003      OFST:	set	3
1869                     ; 280 	if(mat_index==0)
1871  03e2 9e            	ld	a,xh
1872  03e3 4d            	tnz	a
1873  03e4 2609          	jrne	L365
1874                     ; 282 		GPIOx=GPIOC;
1876  03e6 ae500a        	ldw	x,#20490
1877  03e9 1f01          	ldw	(OFST-2,sp),x
1879                     ; 283 		GPIO_Pin=GPIO_PIN_3;
1881  03eb a608          	ld	a,#8
1882  03ed 6b03          	ld	(OFST+0,sp),a
1884  03ef               L365:
1885                     ; 285 	if(mat_index==1)
1887  03ef 7b04          	ld	a,(OFST+1,sp)
1888  03f1 a101          	cp	a,#1
1889  03f3 2609          	jrne	L565
1890                     ; 287 		GPIOx=GPIOC;
1892  03f5 ae500a        	ldw	x,#20490
1893  03f8 1f01          	ldw	(OFST-2,sp),x
1895                     ; 288 		GPIO_Pin=GPIO_PIN_4;
1897  03fa a610          	ld	a,#16
1898  03fc 6b03          	ld	(OFST+0,sp),a
1900  03fe               L565:
1901                     ; 290 	if(mat_index==2)
1903  03fe 7b04          	ld	a,(OFST+1,sp)
1904  0400 a102          	cp	a,#2
1905  0402 2609          	jrne	L765
1906                     ; 292 		GPIOx=GPIOC;
1908  0404 ae500a        	ldw	x,#20490
1909  0407 1f01          	ldw	(OFST-2,sp),x
1911                     ; 293 		GPIO_Pin=GPIO_PIN_5;
1913  0409 a620          	ld	a,#32
1914  040b 6b03          	ld	(OFST+0,sp),a
1916  040d               L765:
1917                     ; 295 	if(mat_index==3)
1919  040d 7b04          	ld	a,(OFST+1,sp)
1920  040f a103          	cp	a,#3
1921  0411 2609          	jrne	L175
1922                     ; 297 		GPIOx=GPIOC;
1924  0413 ae500a        	ldw	x,#20490
1925  0416 1f01          	ldw	(OFST-2,sp),x
1927                     ; 298 		GPIO_Pin=GPIO_PIN_6;
1929  0418 a640          	ld	a,#64
1930  041a 6b03          	ld	(OFST+0,sp),a
1932  041c               L175:
1933                     ; 300 	if(mat_index==4)
1935  041c 7b04          	ld	a,(OFST+1,sp)
1936  041e a104          	cp	a,#4
1937  0420 2609          	jrne	L375
1938                     ; 302 		GPIOx=GPIOC;
1940  0422 ae500a        	ldw	x,#20490
1941  0425 1f01          	ldw	(OFST-2,sp),x
1943                     ; 303 		GPIO_Pin=GPIO_PIN_7;
1945  0427 a680          	ld	a,#128
1946  0429 6b03          	ld	(OFST+0,sp),a
1948  042b               L375:
1949                     ; 305 	if(mat_index==5)
1951  042b 7b04          	ld	a,(OFST+1,sp)
1952  042d a105          	cp	a,#5
1953  042f 2609          	jrne	L575
1954                     ; 307 		GPIOx=GPIOD;
1956  0431 ae500f        	ldw	x,#20495
1957  0434 1f01          	ldw	(OFST-2,sp),x
1959                     ; 308 		GPIO_Pin=GPIO_PIN_2;
1961  0436 a604          	ld	a,#4
1962  0438 6b03          	ld	(OFST+0,sp),a
1964  043a               L575:
1965                     ; 310 	if(mat_index==6)
1967  043a 7b04          	ld	a,(OFST+1,sp)
1968  043c a106          	cp	a,#6
1969  043e 2609          	jrne	L775
1970                     ; 312 		GPIOx=GPIOA;
1972  0440 ae5000        	ldw	x,#20480
1973  0443 1f01          	ldw	(OFST-2,sp),x
1975                     ; 313 		GPIO_Pin=GPIO_PIN_3;
1977  0445 a608          	ld	a,#8
1978  0447 6b03          	ld	(OFST+0,sp),a
1980  0449               L775:
1981                     ; 315 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
1983  0449 0d05          	tnz	(OFST+2,sp)
1984  044b 2708          	jreq	L106
1987  044d 1e01          	ldw	x,(OFST-2,sp)
1988  044f f6            	ld	a,(x)
1989  0450 1a03          	or	a,(OFST+0,sp)
1990  0452 f7            	ld	(x),a
1992  0453 2007          	jra	L306
1993  0455               L106:
1994                     ; 316 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
1996  0455 1e01          	ldw	x,(OFST-2,sp)
1997  0457 7b03          	ld	a,(OFST+0,sp)
1998  0459 43            	cpl	a
1999  045a f4            	and	a,(x)
2000  045b f7            	ld	(x),a
2001  045c               L306:
2002                     ; 317 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2004  045c 1e01          	ldw	x,(OFST-2,sp)
2005  045e e602          	ld	a,(2,x)
2006  0460 1a03          	or	a,(OFST+0,sp)
2007  0462 e702          	ld	(2,x),a
2008                     ; 318 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2010  0464 1e01          	ldw	x,(OFST-2,sp)
2011  0466 e603          	ld	a,(3,x)
2012  0468 1a03          	or	a,(OFST+0,sp)
2013  046a e703          	ld	(3,x),a
2014                     ; 319 }
2017  046c 5b05          	addw	sp,#5
2018  046e 81            	ret
2094                     ; 322 void flush_leds(u8 led_count)
2094                     ; 323 {
2095                     	switch	.text
2096  046f               _flush_leds:
2098  046f 88            	push	a
2099  0470 5207          	subw	sp,#7
2100       00000007      OFST:	set	7
2103                     ; 324 	u8 led_read_index=0,led_write_index=0;
2107  0472 0f05          	clr	(OFST-2,sp)
2110  0474               L746:
2111                     ; 327 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2113  0474 b684          	ld	a,_pwm_state
2114  0476 a502          	bcp	a,#2
2115  0478 26fa          	jrne	L746
2116                     ; 328 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2118  047a b684          	ld	a,_pwm_state
2119  047c a401          	and	a,#1
2120  047e a801          	xor	a,#1
2121  0480 6b07          	ld	(OFST+0,sp),a
2123                     ; 330 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2125  0482 7b08          	ld	a,(OFST+1,sp)
2126  0484 5f            	clrw	x
2127  0485 97            	ld	xl,a
2128  0486 4f            	clr	a
2129  0487 02            	rlwa	x,a
2130  0488 58            	sllw	x
2131  0489 58            	sllw	x
2132  048a 7b07          	ld	a,(OFST+0,sp)
2133  048c 905f          	clrw	y
2134  048e 9097          	ld	yl,a
2135  0490 9058          	sllw	y
2136  0492 90ef7d        	ldw	(_pwm_sleep,y),x
2137                     ; 332 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2139  0495 0f06          	clr	(OFST-1,sp)
2141  0497               L356:
2142                     ; 334 		read_brightness=pwm_brightness_buffer[led_read_index];
2144  0497 7b06          	ld	a,(OFST-1,sp)
2145  0499 5f            	clrw	x
2146  049a 97            	ld	xl,a
2147  049b e608          	ld	a,(_pwm_brightness_buffer,x)
2148  049d 5f            	clrw	x
2149  049e 97            	ld	xl,a
2150  049f 1f03          	ldw	(OFST-4,sp),x
2152                     ; 335 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2154  04a1 1e03          	ldw	x,(OFST-4,sp)
2155  04a3 2767          	jreq	L166
2156                     ; 337 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2158  04a5 7b05          	ld	a,(OFST-2,sp)
2159  04a7 5f            	clrw	x
2160  04a8 97            	ld	xl,a
2161  04a9 58            	sllw	x
2162  04aa 01            	rrwa	x,a
2163  04ab 1b07          	add	a,(OFST+0,sp)
2164  04ad 2401          	jrnc	L431
2165  04af 5c            	incw	x
2166  04b0               L431:
2167  04b0 02            	rlwa	x,a
2168  04b1 7b06          	ld	a,(OFST-1,sp)
2169  04b3 e727          	ld	(_pwm_brightness_index,x),a
2170                     ; 338 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2172  04b5 1e03          	ldw	x,(OFST-4,sp)
2173  04b7 1603          	ldw	y,(OFST-4,sp)
2174  04b9 cd0000        	call	c_imul
2176  04bc a606          	ld	a,#6
2177  04be               L631:
2178  04be 54            	srlw	x
2179  04bf 4a            	dec	a
2180  04c0 26fc          	jrne	L631
2181  04c2 5c            	incw	x
2182  04c3 7b07          	ld	a,(OFST+0,sp)
2183  04c5 905f          	clrw	y
2184  04c7 9097          	ld	yl,a
2185  04c9 9058          	sllw	y
2186  04cb 1701          	ldw	(OFST-6,sp),y
2188  04cd 7b05          	ld	a,(OFST-2,sp)
2189  04cf 905f          	clrw	y
2190  04d1 9097          	ld	yl,a
2191  04d3 9058          	sllw	y
2192  04d5 9058          	sllw	y
2193  04d7 72f901        	addw	y,(OFST-6,sp)
2194  04da 90ef01        	ldw	(_pwm_brightness,y),x
2195                     ; 339 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2197  04dd 7b07          	ld	a,(OFST+0,sp)
2198  04df 5f            	clrw	x
2199  04e0 97            	ld	xl,a
2200  04e1 58            	sllw	x
2201  04e2 7b07          	ld	a,(OFST+0,sp)
2202  04e4 905f          	clrw	y
2203  04e6 9097          	ld	yl,a
2204  04e8 9058          	sllw	y
2205  04ea 1701          	ldw	(OFST-6,sp),y
2207  04ec 7b05          	ld	a,(OFST-2,sp)
2208  04ee 905f          	clrw	y
2209  04f0 9097          	ld	yl,a
2210  04f2 9058          	sllw	y
2211  04f4 9058          	sllw	y
2212  04f6 72f901        	addw	y,(OFST-6,sp)
2213  04f9 90ee01        	ldw	y,(_pwm_brightness,y)
2214  04fc 9001          	rrwa	y,a
2215  04fe e07e          	sub	a,(_pwm_sleep+1,x)
2216  0500 9001          	rrwa	y,a
2217  0502 e27d          	sbc	a,(_pwm_sleep,x)
2218  0504 9001          	rrwa	y,a
2219  0506 9050          	negw	y
2220  0508 ef7d          	ldw	(_pwm_sleep,x),y
2221                     ; 340 			led_write_index++;
2223  050a 0c05          	inc	(OFST-2,sp)
2225  050c               L166:
2226                     ; 342 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2228  050c 7b06          	ld	a,(OFST-1,sp)
2229  050e 5f            	clrw	x
2230  050f 97            	ld	xl,a
2231  0510 6f08          	clr	(_pwm_brightness_buffer,x)
2232                     ; 332 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2234  0512 0c06          	inc	(OFST-1,sp)
2238  0514 7b06          	ld	a,(OFST-1,sp)
2239  0516 a11f          	cp	a,#31
2240  0518 2403cc0497    	jrult	L356
2241                     ; 344 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2243  051d 7b07          	ld	a,(OFST+0,sp)
2244  051f 5f            	clrw	x
2245  0520 97            	ld	xl,a
2246  0521 58            	sllw	x
2247  0522 9093          	ldw	y,x
2248  0524 90ee7d        	ldw	y,(_pwm_sleep,y)
2249  0527 90a37c01      	cpw	y,#31745
2250  052b 250b          	jrult	L366
2253  052d 7b07          	ld	a,(OFST+0,sp)
2254  052f 5f            	clrw	x
2255  0530 97            	ld	xl,a
2256  0531 58            	sllw	x
2257  0532 90ae0001      	ldw	y,#1
2258  0536 ef7d          	ldw	(_pwm_sleep,x),y
2259  0538               L366:
2260                     ; 346 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2262  0538 7b07          	ld	a,(OFST+0,sp)
2263  053a 5f            	clrw	x
2264  053b 97            	ld	xl,a
2265  053c 7b05          	ld	a,(OFST-2,sp)
2266  053e e781          	ld	(_pwm_led_count,x),a
2267                     ; 365 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2269  0540 72120084      	bset	_pwm_state,#1
2270                     ; 366 }
2273  0544 5b08          	addw	sp,#8
2274  0546 81            	ret
2363                     ; 369 void set_hue_max(u8 index,u16 color)
2363                     ; 370 {
2364                     	switch	.text
2365  0547               _set_hue_max:
2367  0547 88            	push	a
2368  0548 5205          	subw	sp,#5
2369       00000005      OFST:	set	5
2372                     ; 371 	u8 red=0,green=0,blue=0;
2374  054a 0f01          	clr	(OFST-4,sp)
2378  054c 0f02          	clr	(OFST-3,sp)
2382  054e 0f03          	clr	(OFST-2,sp)
2384                     ; 372 	u8 residual=0;
2386  0550 0f04          	clr	(OFST-1,sp)
2388                     ; 374 	for(iter=0;iter<6;iter++)
2390  0552 0f05          	clr	(OFST+0,sp)
2392  0554               L337:
2393                     ; 376 		if(color<0x2AAB)
2395  0554 1e09          	ldw	x,(OFST+4,sp)
2396  0556 a32aab        	cpw	x,#10923
2397  0559 240b          	jruge	L147
2398                     ; 378 			residual=color/43;
2400  055b 1e09          	ldw	x,(OFST+4,sp)
2401  055d a62b          	ld	a,#43
2402  055f 62            	div	x,a
2403  0560 01            	rrwa	x,a
2404  0561 6b04          	ld	(OFST-1,sp),a
2405  0563 02            	rlwa	x,a
2407                     ; 379 			break;
2409  0564 200f          	jra	L737
2410  0566               L147:
2411                     ; 381 		color-=0x2AAB;
2413  0566 1e09          	ldw	x,(OFST+4,sp)
2414  0568 1d2aab        	subw	x,#10923
2415  056b 1f09          	ldw	(OFST+4,sp),x
2416                     ; 374 	for(iter=0;iter<6;iter++)
2418  056d 0c05          	inc	(OFST+0,sp)
2422  056f 7b05          	ld	a,(OFST+0,sp)
2423  0571 a106          	cp	a,#6
2424  0573 25df          	jrult	L337
2425  0575               L737:
2426                     ; 383 	if(iter==0){ red=255; green=residual; }
2428  0575 0d05          	tnz	(OFST+0,sp)
2429  0577 2608          	jrne	L347
2432  0579 a6ff          	ld	a,#255
2433  057b 6b01          	ld	(OFST-4,sp),a
2437  057d 7b04          	ld	a,(OFST-1,sp)
2438  057f 6b02          	ld	(OFST-3,sp),a
2440  0581               L347:
2441                     ; 384 	if(iter==1){ green=255; red=255-residual; }
2443  0581 7b05          	ld	a,(OFST+0,sp)
2444  0583 a101          	cp	a,#1
2445  0585 260a          	jrne	L547
2448  0587 a6ff          	ld	a,#255
2449  0589 6b02          	ld	(OFST-3,sp),a
2453  058b a6ff          	ld	a,#255
2454  058d 1004          	sub	a,(OFST-1,sp)
2455  058f 6b01          	ld	(OFST-4,sp),a
2457  0591               L547:
2458                     ; 385 	if(iter==2){ green=255; blue=residual; }
2460  0591 7b05          	ld	a,(OFST+0,sp)
2461  0593 a102          	cp	a,#2
2462  0595 2608          	jrne	L747
2465  0597 a6ff          	ld	a,#255
2466  0599 6b02          	ld	(OFST-3,sp),a
2470  059b 7b04          	ld	a,(OFST-1,sp)
2471  059d 6b03          	ld	(OFST-2,sp),a
2473  059f               L747:
2474                     ; 386 	if(iter==3){ blue=255; green=255-residual; }
2476  059f 7b05          	ld	a,(OFST+0,sp)
2477  05a1 a103          	cp	a,#3
2478  05a3 260a          	jrne	L157
2481  05a5 a6ff          	ld	a,#255
2482  05a7 6b03          	ld	(OFST-2,sp),a
2486  05a9 a6ff          	ld	a,#255
2487  05ab 1004          	sub	a,(OFST-1,sp)
2488  05ad 6b02          	ld	(OFST-3,sp),a
2490  05af               L157:
2491                     ; 387 	if(iter==4){ blue=255; red=residual; }
2493  05af 7b05          	ld	a,(OFST+0,sp)
2494  05b1 a104          	cp	a,#4
2495  05b3 2608          	jrne	L357
2498  05b5 a6ff          	ld	a,#255
2499  05b7 6b03          	ld	(OFST-2,sp),a
2503  05b9 7b04          	ld	a,(OFST-1,sp)
2504  05bb 6b01          	ld	(OFST-4,sp),a
2506  05bd               L357:
2507                     ; 388 	if(iter==5){ red=255; blue=255-residual; }
2509  05bd 7b05          	ld	a,(OFST+0,sp)
2510  05bf a105          	cp	a,#5
2511  05c1 260a          	jrne	L557
2514  05c3 a6ff          	ld	a,#255
2515  05c5 6b01          	ld	(OFST-4,sp),a
2519  05c7 a6ff          	ld	a,#255
2520  05c9 1004          	sub	a,(OFST-1,sp)
2521  05cb 6b03          	ld	(OFST-2,sp),a
2523  05cd               L557:
2524                     ; 428 	set_rgb(index,0,red);
2526  05cd 7b01          	ld	a,(OFST-4,sp)
2527  05cf 88            	push	a
2528  05d0 7b07          	ld	a,(OFST+2,sp)
2529  05d2 5f            	clrw	x
2530  05d3 95            	ld	xh,a
2531  05d4 ad1c          	call	_set_rgb
2533  05d6 84            	pop	a
2534                     ; 429 	set_rgb(index,1,green);
2536  05d7 7b02          	ld	a,(OFST-3,sp)
2537  05d9 88            	push	a
2538  05da 7b07          	ld	a,(OFST+2,sp)
2539  05dc ae0001        	ldw	x,#1
2540  05df 95            	ld	xh,a
2541  05e0 ad10          	call	_set_rgb
2543  05e2 84            	pop	a
2544                     ; 430 	set_rgb(index,2,blue);
2546  05e3 7b03          	ld	a,(OFST-2,sp)
2547  05e5 88            	push	a
2548  05e6 7b07          	ld	a,(OFST+2,sp)
2549  05e8 ae0002        	ldw	x,#2
2550  05eb 95            	ld	xh,a
2551  05ec ad04          	call	_set_rgb
2553  05ee 84            	pop	a
2554                     ; 431 }
2557  05ef 5b06          	addw	sp,#6
2558  05f1 81            	ret
2611                     ; 433 void set_rgb(u8 index,u8 color,u8 brightness)
2611                     ; 434 {
2612                     	switch	.text
2613  05f2               _set_rgb:
2615  05f2 89            	pushw	x
2616       00000000      OFST:	set	0
2619                     ; 435 	pwm_brightness_buffer[index+color*RGB_COUNT]=brightness;
2621  05f3 9f            	ld	a,xl
2622  05f4 97            	ld	xl,a
2623  05f5 a606          	ld	a,#6
2624  05f7 42            	mul	x,a
2625  05f8 01            	rrwa	x,a
2626  05f9 1b01          	add	a,(OFST+1,sp)
2627  05fb 2401          	jrnc	L441
2628  05fd 5c            	incw	x
2629  05fe               L441:
2630  05fe 02            	rlwa	x,a
2631  05ff 7b05          	ld	a,(OFST+5,sp)
2632  0601 e708          	ld	(_pwm_brightness_buffer,x),a
2633                     ; 436 }
2636  0603 85            	popw	x
2637  0604 81            	ret
2681                     ; 438 void set_white(u8 index,u8 brightness)
2681                     ; 439 {
2682                     	switch	.text
2683  0605               _set_white:
2685  0605 89            	pushw	x
2686       00000000      OFST:	set	0
2689                     ; 440 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2691  0606 9e            	ld	a,xh
2692  0607 5f            	clrw	x
2693  0608 97            	ld	xl,a
2694  0609 7b02          	ld	a,(OFST+2,sp)
2695  060b e71b          	ld	(_pwm_brightness_buffer+19,x),a
2696                     ; 441 }
2699  060d 85            	popw	x
2700  060e 81            	ret
2735                     ; 444 void set_debug(u8 brightness)
2735                     ; 445 {
2736                     	switch	.text
2737  060f               _set_debug:
2741                     ; 446 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2743  060f b71a          	ld	_pwm_brightness_buffer+18,a
2744                     ; 447 }
2747  0611 81            	ret
2770                     ; 449 void set_matrix_high_z()
2770                     ; 450 {
2771                     	switch	.text
2772  0612               _set_matrix_high_z:
2776                     ; 451 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2778  0612 c6500d        	ld	a,20493
2779  0615 a407          	and	a,#7
2780  0617 c7500d        	ld	20493,a
2781                     ; 452 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2783  061a 72155012      	bres	20498,#2
2784                     ; 453 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2786  061e 72175003      	bres	20483,#3
2787                     ; 454 }
2790  0622 81            	ret
2824                     ; 456 u8 get_eeprom_byte(u16 eeprom_address)
2824                     ; 457 {
2825                     	switch	.text
2826  0623               _get_eeprom_byte:
2830                     ; 458 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2832  0623 d64000        	ld	a,(16384,x)
2835  0626 81            	ret
2972                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2973                     	xdef	_temp3_delete_me
2974                     	xdef	_temp_delete_me
2975                     	switch	.ubsct
2976  0000               _button_pressed_event:
2977  0000 00000000      	ds.b	4
2978                     	xdef	_button_pressed_event
2979  0004               _button_start_ms:
2980  0004 00000000      	ds.b	4
2981                     	xdef	_button_start_ms
2982                     	xdef	_pwm_state
2983                     	xdef	_pwm_visible_index
2984                     	xdef	_pwm_led_count
2985                     	xdef	_pwm_sleep
2986  0008               _pwm_brightness_buffer:
2987  0008 000000000000  	ds.b	31
2988                     	xdef	_pwm_brightness_buffer
2989  0027               _pwm_brightness_index:
2990  0027 000000000000  	ds.b	62
2991                     	xdef	_pwm_brightness_index
2992                     	xdef	_pwm_brightness
2993                     	xdef	_frame_counter
2994                     	xref	_UART1_Cmd
2995                     	xref	_UART1_Init
2996                     	xref	_UART1_DeInit
2997                     	xref	_GPIO_ReadInputPin
2998                     	xref	_GPIO_Init
2999                     	xdef	_set_led
3000                     	xdef	_set_mat
3001                     	xdef	_get_eeprom_byte
3002                     	xdef	_get_random
3003                     	xdef	_is_button_down
3004                     	xdef	_clear_button_events
3005                     	xdef	_clear_button_event
3006                     	xdef	_get_button_event
3007                     	xdef	_update_buttons
3008                     	xdef	_is_developer_valid
3009                     	xdef	_set_hue_max
3010                     	xdef	_flush_leds
3011                     	xdef	_set_debug
3012                     	xdef	_set_white
3013                     	xdef	_set_rgb
3014                     	xdef	_set_matrix_high_z
3015                     	xdef	_millis
3016                     	xdef	_setup_main
3017                     	xdef	_is_application_valid
3018                     	xdef	_setup_serial
3019                     	xdef	_hello_world
3020                     	xref.b	c_lreg
3021                     	xref.b	c_x
3022                     	xref.b	c_y
3042                     	xref	c_xymov
3043                     	xref	c_lzmp
3044                     	xref	c_lsub
3045                     	xref	c_rtol
3046                     	xref	c_uitolx
3047                     	xref	c_itolx
3048                     	xref	c_imul
3049                     	xref	c_lmul
3050                     	xref	c_ladd
3051                     	xref	c_llsh
3052                     	xref	c_lrzmp
3053                     	xref	c_lmod
3054                     	xref	c_ldiv
3055                     	xref	c_ltor
3056                     	xref	c_lgadc
3057                     	end
