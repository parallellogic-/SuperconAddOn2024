   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _api_counter:
  16  0000 00000000      	dc.l	0
  17  0004               _pwm_sleep_remaining:
  18  0004 0000          	dc.w	0
  19  0006               _pwm_visible_index:
  20  0006 00            	dc.b	0
  21  0007               _pwm_state:
  22  0007 00            	dc.b	0
  23  0008               _temp_delete_me:
  24  0008 0000          	dc.w	0
  25  000a               _temp3_delete_me:
  26  000a 0000          	dc.w	0
 119                     .const:	section	.text
 120  0000               L6:
 121  0000 00000100      	dc.l	256
 122  0004               L21:
 123  0004 00010000      	dc.l	65536
 124  0008               L41:
 125  0008 00000002      	dc.l	2
 126                     ; 31 void hello_world()
 126                     ; 32 {//basic program that blinks the debug LED ON/OFF
 127                     	scross	off
 128                     	switch	.text
 129  0000               _hello_world:
 131  0000 5207          	subw	sp,#7
 132       00000007      OFST:	set	7
 135                     ; 35 	bool is_high=0;
 137                     ; 36 	long frame=0;
 139  0002 ae0000        	ldw	x,#0
 140  0005 1f04          	ldw	(OFST-3,sp),x
 141  0007 ae0000        	ldw	x,#0
 142  000a 1f02          	ldw	(OFST-5,sp),x
 144  000c               L35:
 145                     ; 40 		frame++;
 147  000c 96            	ldw	x,sp
 148  000d 1c0002        	addw	x,#OFST-5
 149  0010 a601          	ld	a,#1
 150  0012 cd0000        	call	c_lgadc
 153                     ; 41 		if(frame%256==0)
 155  0015 96            	ldw	x,sp
 156  0016 1c0002        	addw	x,#OFST-5
 157  0019 cd0000        	call	c_ltor
 159  001c ae0000        	ldw	x,#L6
 160  001f cd0000        	call	c_lmod
 162  0022 cd0000        	call	c_lrzmp
 164  0025 26e5          	jrne	L35
 165                     ; 44 			temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
 167  0027 96            	ldw	x,sp
 168  0028 1c0002        	addw	x,#OFST-5
 169  002b cd0000        	call	c_ltor
 171  002e ae0004        	ldw	x,#L21
 172  0031 cd0000        	call	c_ldiv
 174  0034 ae0008        	ldw	x,#L41
 175  0037 cd0000        	call	c_lmod
 177  003a cd0000        	call	c_lrzmp
 179  003d 2717          	jreq	L01
 180  003f 96            	ldw	x,sp
 181  0040 1c0002        	addw	x,#OFST-5
 182  0043 cd0000        	call	c_ltor
 184  0046 ae0000        	ldw	x,#L6
 185  0049 cd0000        	call	c_ldiv
 187  004c 3303          	cpl	c_lreg+3
 188  004e 3302          	cpl	c_lreg+2
 189  0050 3301          	cpl	c_lreg+1
 190  0052 3300          	cpl	c_lreg
 191  0054 200d          	jra	L61
 192  0056               L01:
 193  0056 96            	ldw	x,sp
 194  0057 1c0002        	addw	x,#OFST-5
 195  005a cd0000        	call	c_ltor
 197  005d ae0000        	ldw	x,#L6
 198  0060 cd0000        	call	c_ldiv
 200  0063               L61:
 201  0063 3f02          	clr	c_lreg+2
 202  0065 3f01          	clr	c_lreg+1
 203  0067 3f00          	clr	c_lreg
 204  0069 be02          	ldw	x,c_lreg+2
 205  006b 1f06          	ldw	(OFST-1,sp),x
 207                     ; 45 			temp2_delete_me=temp2_delete_me*temp2_delete_me;
 209  006d 1e06          	ldw	x,(OFST-1,sp)
 210  006f 1606          	ldw	y,(OFST-1,sp)
 211  0071 cd0000        	call	c_imul
 213  0074 1f06          	ldw	(OFST-1,sp),x
 215                     ; 46 			temp2_delete_me=temp2_delete_me>>6;
 217  0076 a606          	ld	a,#6
 218  0078               L02:
 219  0078 0406          	srl	(OFST-1,sp)
 220  007a 0607          	rrc	(OFST+0,sp)
 221  007c 4a            	dec	a
 222  007d 26f9          	jrne	L02
 224                     ; 47 			temp_delete_me=temp2_delete_me;
 226  007f 1e06          	ldw	x,(OFST-1,sp)
 227  0081 bf08          	ldw	_temp_delete_me,x
 228                     ; 48 			temp4_delete_me=0x00FF&((frame/256/256)%2?((frame/256)):(~frame/256));
 230  0083 96            	ldw	x,sp
 231  0084 1c0002        	addw	x,#OFST-5
 232  0087 cd0000        	call	c_ltor
 234  008a ae0004        	ldw	x,#L21
 235  008d cd0000        	call	c_ldiv
 237  0090 ae0008        	ldw	x,#L41
 238  0093 cd0000        	call	c_lmod
 240  0096 cd0000        	call	c_lrzmp
 242  0099 270f          	jreq	L22
 243  009b 96            	ldw	x,sp
 244  009c 1c0002        	addw	x,#OFST-5
 245  009f cd0000        	call	c_ltor
 247  00a2 ae0000        	ldw	x,#L6
 248  00a5 cd0000        	call	c_ldiv
 250  00a8 2015          	jra	L42
 251  00aa               L22:
 252  00aa 96            	ldw	x,sp
 253  00ab 1c0002        	addw	x,#OFST-5
 254  00ae cd0000        	call	c_ltor
 256  00b1 3303          	cpl	c_lreg+3
 257  00b3 3302          	cpl	c_lreg+2
 258  00b5 3301          	cpl	c_lreg+1
 259  00b7 3300          	cpl	c_lreg
 260  00b9 ae0000        	ldw	x,#L6
 261  00bc cd0000        	call	c_ldiv
 263  00bf               L42:
 264  00bf 3f02          	clr	c_lreg+2
 265  00c1 3f01          	clr	c_lreg+1
 266  00c3 3f00          	clr	c_lreg
 267  00c5 be02          	ldw	x,c_lreg+2
 268  00c7 1f06          	ldw	(OFST-1,sp),x
 270                     ; 49 			temp4_delete_me=temp4_delete_me*temp4_delete_me;
 272  00c9 1e06          	ldw	x,(OFST-1,sp)
 273  00cb 1606          	ldw	y,(OFST-1,sp)
 274  00cd cd0000        	call	c_imul
 276  00d0 1f06          	ldw	(OFST-1,sp),x
 278                     ; 50 			temp4_delete_me=temp4_delete_me>>6;
 280  00d2 a606          	ld	a,#6
 281  00d4               L62:
 282  00d4 0406          	srl	(OFST-1,sp)
 283  00d6 0607          	rrc	(OFST+0,sp)
 284  00d8 4a            	dec	a
 285  00d9 26f9          	jrne	L62
 287                     ; 51 			temp3_delete_me=(temp4_delete_me%2)<<9;
 289  00db 7b06          	ld	a,(OFST-1,sp)
 290  00dd 97            	ld	xl,a
 291  00de 7b07          	ld	a,(OFST+0,sp)
 292  00e0 a401          	and	a,#1
 293  00e2 5f            	clrw	x
 294  00e3 02            	rlwa	x,a
 295  00e4 4f            	clr	a
 296  00e5 02            	rlwa	x,a
 297  00e6 58            	sllw	x
 298  00e7 bf0a          	ldw	_temp3_delete_me,x
 299                     ; 53 			set_debug(temp_delete_me);
 301  00e9 b609          	ld	a,_temp_delete_me+1
 302  00eb cd0642        	call	_set_debug
 304                     ; 54 			set_white(0,temp3_delete_me);
 306  00ee b60b          	ld	a,_temp3_delete_me+1
 307  00f0 5f            	clrw	x
 308  00f1 97            	ld	xl,a
 309  00f2 cd0638        	call	_set_white
 311                     ; 55 			flush_leds(7);
 313  00f5 a607          	ld	a,#7
 314  00f7 cd048c        	call	_flush_leds
 316  00fa ac0c000c      	jpf	L35
 368                     ; 60 u16 get_random(u16 x)
 368                     ; 61 {
 369                     	switch	.text
 370  00fe               _get_random:
 372  00fe 5204          	subw	sp,#4
 373       00000004      OFST:	set	4
 376                     ; 62 	u16 a=1664525;
 378                     ; 63 	u16 c=1013904223;
 380                     ; 64 	return a * x + c;
 382  0100 90ae660d      	ldw	y,#26125
 383  0104 cd0000        	call	c_imul
 385  0107 1cf35f        	addw	x,#62303
 388  010a 5b04          	addw	sp,#4
 389  010c 81            	ret
 438                     	switch	.const
 439  000c               L04:
 440  000c 000f4240      	dc.l	1000000
 441                     ; 67 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 441                     ; 68 {
 442                     	switch	.text
 443  010d               _setup_serial:
 445  010d 89            	pushw	x
 446       00000000      OFST:	set	0
 449                     ; 69 	if(is_enabled)
 451  010e 9e            	ld	a,xh
 452  010f 4d            	tnz	a
 453  0110 2747          	jreq	L131
 454                     ; 71 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 456  0112 4bf0          	push	#240
 457  0114 4b20          	push	#32
 458  0116 ae500f        	ldw	x,#20495
 459  0119 cd0000        	call	_GPIO_Init
 461  011c 85            	popw	x
 462                     ; 72 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 464  011d 4b40          	push	#64
 465  011f 4b40          	push	#64
 466  0121 ae500f        	ldw	x,#20495
 467  0124 cd0000        	call	_GPIO_Init
 469  0127 85            	popw	x
 470                     ; 73 		UART1_DeInit();
 472  0128 cd0000        	call	_UART1_DeInit
 474                     ; 74 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 476  012b 4b0c          	push	#12
 477  012d 4b80          	push	#128
 478  012f 4b00          	push	#0
 479  0131 4b00          	push	#0
 480  0133 4b00          	push	#0
 481  0135 0d07          	tnz	(OFST+7,sp)
 482  0137 2708          	jreq	L43
 483  0139 ae2580        	ldw	x,#9600
 484  013c cd0000        	call	c_itolx
 486  013f 2006          	jra	L63
 487  0141               L43:
 488  0141 ae000c        	ldw	x,#L04
 489  0144 cd0000        	call	c_ltor
 491  0147               L63:
 492  0147 be02          	ldw	x,c_lreg+2
 493  0149 89            	pushw	x
 494  014a be00          	ldw	x,c_lreg
 495  014c 89            	pushw	x
 496  014d cd0000        	call	_UART1_Init
 498  0150 5b09          	addw	sp,#9
 499                     ; 75 		UART1_Cmd(ENABLE);
 501  0152 a601          	ld	a,#1
 502  0154 cd0000        	call	_UART1_Cmd
 505  0157 201d          	jra	L331
 506  0159               L131:
 507                     ; 77 		UART1_Cmd(DISABLE);
 509  0159 4f            	clr	a
 510  015a cd0000        	call	_UART1_Cmd
 512                     ; 78 		UART1_DeInit();
 514  015d cd0000        	call	_UART1_DeInit
 516                     ; 79 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 518  0160 4b40          	push	#64
 519  0162 4b20          	push	#32
 520  0164 ae500f        	ldw	x,#20495
 521  0167 cd0000        	call	_GPIO_Init
 523  016a 85            	popw	x
 524                     ; 80 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 526  016b 4b40          	push	#64
 527  016d 4b40          	push	#64
 528  016f ae500f        	ldw	x,#20495
 529  0172 cd0000        	call	_GPIO_Init
 531  0175 85            	popw	x
 532  0176               L331:
 533                     ; 82 }
 536  0176 85            	popw	x
 537  0177 81            	ret
 564                     ; 85 bool is_application_valid()
 564                     ; 86 {
 565                     	switch	.text
 566  0178               _is_application_valid:
 570                     ; 87 	return !is_button_down(2) && !get_button_event(0,1);
 572  0178 a602          	ld	a,#2
 573  017a cd02af        	call	_is_button_down
 575  017d 4d            	tnz	a
 576  017e 260d          	jrne	L44
 577  0180 ae0001        	ldw	x,#1
 578  0183 cd0260        	call	_get_button_event
 580  0186 4d            	tnz	a
 581  0187 2604          	jrne	L44
 582  0189 a601          	ld	a,#1
 583  018b 2001          	jra	L64
 584  018d               L44:
 585  018d 4f            	clr	a
 586  018e               L64:
 589  018e 81            	ret
 615                     ; 91 bool is_developer_valid()
 615                     ; 92 {
 616                     	switch	.text
 617  018f               _is_developer_valid:
 621                     ; 93 	return is_button_down(2) && !get_button_event(0,1);
 623  018f a602          	ld	a,#2
 624  0191 cd02af        	call	_is_button_down
 626  0194 4d            	tnz	a
 627  0195 270d          	jreq	L25
 628  0197 ae0001        	ldw	x,#1
 629  019a cd0260        	call	_get_button_event
 631  019d 4d            	tnz	a
 632  019e 2604          	jrne	L25
 633  01a0 a601          	ld	a,#1
 634  01a2 2001          	jra	L45
 635  01a4               L25:
 636  01a4 4f            	clr	a
 637  01a5               L45:
 640  01a5 81            	ret
 665                     ; 96 void setup_main()
 665                     ; 97 {
 666                     	switch	.text
 667  01a6               _setup_main:
 671                     ; 98 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 673  01a6 c650c6        	ld	a,20678
 674  01a9 a4e7          	and	a,#231
 675  01ab c750c6        	ld	20678,a
 676                     ; 100 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 678  01ae 4b40          	push	#64
 679  01b0 4b02          	push	#2
 680  01b2 ae500f        	ldw	x,#20495
 681  01b5 cd0000        	call	_GPIO_Init
 683  01b8 85            	popw	x
 684                     ; 103 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 686  01b9 725f5311      	clr	21265
 687                     ; 104 	TIM2->PSCR= 4;// init divider register 16MHz/2^X
 689  01bd 3504530e      	mov	21262,#4
 690                     ; 105 	TIM2->ARRH= 16;// init auto reload register
 692  01c1 3510530f      	mov	21263,#16
 693                     ; 106 	TIM2->ARRL= 255;// init auto reload register
 695  01c5 35ff5310      	mov	21264,#255
 696                     ; 108 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 698  01c9 c65300        	ld	a,21248
 699  01cc aa05          	or	a,#5
 700  01ce c75300        	ld	21248,a
 701                     ; 110 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 703  01d1 35015303      	mov	21251,#1
 704                     ; 111 	enableInterrupts();
 707  01d5 9a            rim
 709                     ; 113 }
 713  01d6 81            	ret
 737                     ; 115 u32 millis()
 737                     ; 116 {
 738                     	switch	.text
 739  01d7               _millis:
 743                     ; 117 	return api_counter>>10;
 745  01d7 ae0000        	ldw	x,#_api_counter
 746  01da cd0000        	call	c_ltor
 748  01dd a60a          	ld	a,#10
 749  01df cd0000        	call	c_lursh
 753  01e2 81            	ret
 811                     ; 123 void update_buttons()
 811                     ; 124 {
 812                     	switch	.text
 813  01e3               _update_buttons:
 815  01e3 5208          	subw	sp,#8
 816       00000008      OFST:	set	8
 819                     ; 125 	bool is_any_down=0;
 821  01e5 0f05          	clr	(OFST-3,sp)
 823                     ; 127 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 825  01e7 be06          	ldw	x,_button_start_ms+2
 826  01e9 cd0000        	call	c_uitolx
 828  01ec 96            	ldw	x,sp
 829  01ed 1c0001        	addw	x,#OFST-7
 830  01f0 cd0000        	call	c_rtol
 833  01f3 ade2          	call	_millis
 835  01f5 96            	ldw	x,sp
 836  01f6 1c0001        	addw	x,#OFST-7
 837  01f9 cd0000        	call	c_lsub
 839  01fc be02          	ldw	x,c_lreg+2
 840  01fe 1f06          	ldw	(OFST-2,sp),x
 842                     ; 128 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 844  0200 0f08          	clr	(OFST+0,sp)
 846  0202               L322:
 847                     ; 130 		if(is_button_down(button_index))
 849  0202 7b08          	ld	a,(OFST+0,sp)
 850  0204 cd02af        	call	_is_button_down
 852  0207 4d            	tnz	a
 853  0208 271b          	jreq	L132
 854                     ; 132 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 856  020a ae0004        	ldw	x,#_button_start_ms
 857  020d cd0000        	call	c_lzmp
 859  0210 2608          	jrne	L332
 862  0212 adc3          	call	_millis
 864  0214 ae0004        	ldw	x,#_button_start_ms
 865  0217 cd0000        	call	c_rtol
 867  021a               L332:
 868                     ; 133 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 870  021a a6ff          	ld	a,#255
 871  021c cd0642        	call	_set_debug
 873                     ; 134 			is_any_down=1;
 875  021f a601          	ld	a,#1
 876  0221 6b05          	ld	(OFST-3,sp),a
 879  0223 2022          	jra	L532
 880  0225               L132:
 881                     ; 136 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 883  0225 1e06          	ldw	x,(OFST-2,sp)
 884  0227 a30201        	cpw	x,#513
 885  022a 250b          	jrult	L732
 888  022c 7b08          	ld	a,(OFST+0,sp)
 889  022e 5f            	clrw	x
 890  022f 97            	ld	xl,a
 891  0230 58            	sllw	x
 892  0231 a601          	ld	a,#1
 893  0233 e701          	ld	(_button_pressed_event+1,x),a
 895  0235 2010          	jra	L532
 896  0237               L732:
 897                     ; 137 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 899  0237 1e06          	ldw	x,(OFST-2,sp)
 900  0239 a30033        	cpw	x,#51
 901  023c 2509          	jrult	L532
 904  023e 7b08          	ld	a,(OFST+0,sp)
 905  0240 5f            	clrw	x
 906  0241 97            	ld	xl,a
 907  0242 58            	sllw	x
 908  0243 a601          	ld	a,#1
 909  0245 e700          	ld	(_button_pressed_event,x),a
 910  0247               L532:
 911                     ; 128 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 913  0247 0c08          	inc	(OFST+0,sp)
 917  0249 7b08          	ld	a,(OFST+0,sp)
 918  024b a102          	cp	a,#2
 919  024d 25b3          	jrult	L322
 920                     ; 141 	if(!is_any_down) button_start_ms=0;
 922  024f 0d05          	tnz	(OFST-3,sp)
 923  0251 260a          	jrne	L542
 926  0253 ae0000        	ldw	x,#0
 927  0256 bf06          	ldw	_button_start_ms+2,x
 928  0258 ae0000        	ldw	x,#0
 929  025b bf04          	ldw	_button_start_ms,x
 930  025d               L542:
 931                     ; 142 }
 934  025d 5b08          	addw	sp,#8
 935  025f 81            	ret
 981                     ; 145 bool get_button_event(u8 button_index,bool is_long)
 981                     ; 146 { return button_pressed_event[button_index][is_long]; }
 982                     	switch	.text
 983  0260               _get_button_event:
 985  0260 89            	pushw	x
 986       00000000      OFST:	set	0
 991  0261 9e            	ld	a,xh
 992  0262 5f            	clrw	x
 993  0263 97            	ld	xl,a
 994  0264 58            	sllw	x
 995  0265 01            	rrwa	x,a
 996  0266 1b02          	add	a,(OFST+2,sp)
 997  0268 2401          	jrnc	L66
 998  026a 5c            	incw	x
 999  026b               L66:
1000  026b 02            	rlwa	x,a
1001  026c e600          	ld	a,(_button_pressed_event,x)
1004  026e 85            	popw	x
1005  026f 81            	ret
1061                     ; 149 bool clear_button_event(u8 button_index,bool is_long)
1061                     ; 150 {
1062                     	switch	.text
1063  0270               _clear_button_event:
1065  0270 89            	pushw	x
1066  0271 88            	push	a
1067       00000001      OFST:	set	1
1070                     ; 151 	bool out=button_pressed_event[button_index][is_long];
1072  0272 9e            	ld	a,xh
1073  0273 5f            	clrw	x
1074  0274 97            	ld	xl,a
1075  0275 58            	sllw	x
1076  0276 01            	rrwa	x,a
1077  0277 1b03          	add	a,(OFST+2,sp)
1078  0279 2401          	jrnc	L27
1079  027b 5c            	incw	x
1080  027c               L27:
1081  027c 02            	rlwa	x,a
1082  027d e600          	ld	a,(_button_pressed_event,x)
1083  027f 6b01          	ld	(OFST+0,sp),a
1085                     ; 152 	button_pressed_event[button_index][is_long]=0;
1087  0281 7b02          	ld	a,(OFST+1,sp)
1088  0283 5f            	clrw	x
1089  0284 97            	ld	xl,a
1090  0285 58            	sllw	x
1091  0286 01            	rrwa	x,a
1092  0287 1b03          	add	a,(OFST+2,sp)
1093  0289 2401          	jrnc	L47
1094  028b 5c            	incw	x
1095  028c               L47:
1096  028c 02            	rlwa	x,a
1097  028d 6f00          	clr	(_button_pressed_event,x)
1098                     ; 153 	return out;
1100  028f 7b01          	ld	a,(OFST+0,sp)
1103  0291 5b03          	addw	sp,#3
1104  0293 81            	ret
1140                     ; 156 void clear_button_events()
1140                     ; 157 {
1141                     	switch	.text
1142  0294               _clear_button_events:
1144  0294 88            	push	a
1145       00000001      OFST:	set	1
1148                     ; 159 	for(iter=0;iter<BUTTON_COUNT;iter++)
1150  0295 0f01          	clr	(OFST+0,sp)
1152  0297               L533:
1153                     ; 161 		clear_button_event(iter,0);
1155  0297 7b01          	ld	a,(OFST+0,sp)
1156  0299 5f            	clrw	x
1157  029a 95            	ld	xh,a
1158  029b add3          	call	_clear_button_event
1160                     ; 162 		clear_button_event(iter,1);
1162  029d 7b01          	ld	a,(OFST+0,sp)
1163  029f ae0001        	ldw	x,#1
1164  02a2 95            	ld	xh,a
1165  02a3 adcb          	call	_clear_button_event
1167                     ; 159 	for(iter=0;iter<BUTTON_COUNT;iter++)
1169  02a5 0c01          	inc	(OFST+0,sp)
1173  02a7 7b01          	ld	a,(OFST+0,sp)
1174  02a9 a102          	cp	a,#2
1175  02ab 25ea          	jrult	L533
1176                     ; 164 }
1179  02ad 84            	pop	a
1180  02ae 81            	ret
1216                     ; 167 bool is_button_down(u8 index)
1216                     ; 168 {
1217                     	switch	.text
1218  02af               _is_button_down:
1222                     ; 169 	switch(index)
1225                     ; 173 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1227  02af 4d            	tnz	a
1228  02b0 2708          	jreq	L343
1229  02b2 4a            	dec	a
1230  02b3 2718          	jreq	L543
1231  02b5 4a            	dec	a
1232  02b6 2728          	jreq	L743
1233  02b8 2039          	jra	L173
1234  02ba               L343:
1235                     ; 171 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1237  02ba 4b20          	push	#32
1238  02bc ae500f        	ldw	x,#20495
1239  02bf cd0000        	call	_GPIO_ReadInputPin
1241  02c2 5b01          	addw	sp,#1
1242  02c4 4d            	tnz	a
1243  02c5 2604          	jrne	L201
1244  02c7 a601          	ld	a,#1
1245  02c9 2001          	jra	L401
1246  02cb               L201:
1247  02cb 4f            	clr	a
1248  02cc               L401:
1251  02cc 81            	ret
1252  02cd               L543:
1253                     ; 172 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1256  02cd 4b40          	push	#64
1257  02cf ae500f        	ldw	x,#20495
1258  02d2 cd0000        	call	_GPIO_ReadInputPin
1260  02d5 5b01          	addw	sp,#1
1261  02d7 4d            	tnz	a
1262  02d8 2604          	jrne	L601
1263  02da a601          	ld	a,#1
1264  02dc 2001          	jra	L011
1265  02de               L601:
1266  02de 4f            	clr	a
1267  02df               L011:
1270  02df 81            	ret
1271  02e0               L743:
1272                     ; 173 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1275  02e0 4b02          	push	#2
1276  02e2 ae500f        	ldw	x,#20495
1277  02e5 cd0000        	call	_GPIO_ReadInputPin
1279  02e8 5b01          	addw	sp,#1
1280  02ea 4d            	tnz	a
1281  02eb 2604          	jrne	L211
1282  02ed a601          	ld	a,#1
1283  02ef 2001          	jra	L411
1284  02f1               L211:
1285  02f1 4f            	clr	a
1286  02f2               L411:
1289  02f2 81            	ret
1290  02f3               L173:
1291                     ; 175 	return 0;
1293  02f3 4f            	clr	a
1296  02f4 81            	ret
1357                     ; 179 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1359                     	switch	.text
1360  02f5               f_TIM2_UPD_OVF_IRQHandler:
1362  02f5 8a            	push	cc
1363  02f6 84            	pop	a
1364  02f7 a4bf          	and	a,#191
1365  02f9 88            	push	a
1366  02fa 86            	pop	cc
1367       00000004      OFST:	set	4
1368  02fb 3b0002        	push	c_x+2
1369  02fe be00          	ldw	x,c_x
1370  0300 89            	pushw	x
1371  0301 3b0002        	push	c_y+2
1372  0304 be00          	ldw	x,c_y
1373  0306 89            	pushw	x
1374  0307 be02          	ldw	x,c_lreg+2
1375  0309 89            	pushw	x
1376  030a be00          	ldw	x,c_lreg
1377  030c 89            	pushw	x
1378  030d 5204          	subw	sp,#4
1381                     ; 180 	u16 this_sleep=temp_delete_me;
1383  030f be08          	ldw	x,_temp_delete_me
1384  0311 1f03          	ldw	(OFST-1,sp),x
1386                     ; 181 	bool is_debug_led=0;
1388  0313 0f01          	clr	(OFST-3,sp)
1390                     ; 182 	bool is_other_led=0;
1392  0315 0f02          	clr	(OFST-2,sp)
1394                     ; 184 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1396  0317 c6500d        	ld	a,20493
1397  031a a407          	and	a,#7
1398  031c c7500d        	ld	20493,a
1399                     ; 185 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1401  031f 72155012      	bres	20498,#2
1402                     ; 186 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1404  0323 72175003      	bres	20483,#3
1405                     ; 187   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1407  0327 72115300      	bres	21248,#0
1408                     ; 188 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1410  032b 72115304      	bres	21252,#0
1411                     ; 189 	pwm_visible_index++;
1413  032f 3c06          	inc	_pwm_visible_index
1414                     ; 190 	if(pwm_visible_index>6) pwm_visible_index=0;
1416  0331 b606          	ld	a,_pwm_visible_index
1417  0333 a107          	cp	a,#7
1418  0335 2502          	jrult	L124
1421  0337 3f06          	clr	_pwm_visible_index
1422  0339               L124:
1423                     ; 192 	if(pwm_visible_index==0)//simulate other LEDs ON
1425  0339 3d06          	tnz	_pwm_visible_index
1426  033b 260d          	jrne	L324
1427                     ; 194 		is_debug_led=this_sleep>0;
1429  033d 1e03          	ldw	x,(OFST-1,sp)
1430  033f 2704          	jreq	L021
1431  0341 a601          	ld	a,#1
1432  0343 2001          	jra	L221
1433  0345               L021:
1434  0345 4f            	clr	a
1435  0346               L221:
1436  0346 6b01          	ld	(OFST-3,sp),a
1439  0348 201c          	jra	L524
1440  034a               L324:
1441                     ; 195 	}else if(pwm_visible_index==1){
1443  034a b606          	ld	a,_pwm_visible_index
1444  034c a101          	cp	a,#1
1445  034e 2611          	jrne	L724
1446                     ; 196 		this_sleep=temp3_delete_me;
1448  0350 be0a          	ldw	x,_temp3_delete_me
1449  0352 1f03          	ldw	(OFST-1,sp),x
1451                     ; 197 		is_other_led=this_sleep>0;
1453  0354 1e03          	ldw	x,(OFST-1,sp)
1454  0356 2704          	jreq	L421
1455  0358 a601          	ld	a,#1
1456  035a 2001          	jra	L621
1457  035c               L421:
1458  035c 4f            	clr	a
1459  035d               L621:
1460  035d 6b02          	ld	(OFST-2,sp),a
1463  035f 2005          	jra	L524
1464  0361               L724:
1465                     ; 199 		this_sleep=0x400;
1467  0361 ae0400        	ldw	x,#1024
1468  0364 1f03          	ldw	(OFST-1,sp),x
1470  0366               L524:
1471                     ; 201 	if(this_sleep<1) this_sleep=1;
1473  0366 1e03          	ldw	x,(OFST-1,sp)
1474  0368 2605          	jrne	L334
1477  036a ae0001        	ldw	x,#1
1478  036d 1f03          	ldw	(OFST-1,sp),x
1480  036f               L334:
1481                     ; 204   TIM2->CNTRH = 0;// Set the high byte of the counter
1483  036f 725f530c      	clr	21260
1484                     ; 205   TIM2->CNTRL = 0;// Set the low byte of the counter
1486  0373 725f530d      	clr	21261
1487                     ; 206 	TIM2->ARRH= this_sleep>>8;// init auto reload register
1489  0377 7b03          	ld	a,(OFST-1,sp)
1490  0379 c7530f        	ld	21263,a
1491                     ; 207 	TIM2->ARRL= this_sleep&0x00FF;// init auto reload register
1493  037c 7b04          	ld	a,(OFST+0,sp)
1494  037e a4ff          	and	a,#255
1495  0380 c75310        	ld	21264,a
1496                     ; 208 	api_counter+=this_sleep;
1498  0383 1e03          	ldw	x,(OFST-1,sp)
1499  0385 cd0000        	call	c_uitolx
1501  0388 ae0000        	ldw	x,#_api_counter
1502  038b cd0000        	call	c_lgadd
1504                     ; 210 	pwm_state&=0xFD;//DELETE ME TEMP, clear buffer flag
1506  038e 72130007      	bres	_pwm_state,#1
1507                     ; 212 	if(is_debug_led)
1509  0392 0d01          	tnz	(OFST-3,sp)
1510  0394 2704          	jreq	L534
1511                     ; 214 		set_led(DEBUG_LED);
1513  0396 a612          	ld	a,#18
1514  0398 ad21          	call	_set_led
1516  039a               L534:
1517                     ; 215 	if(is_other_led)
1519  039a 0d02          	tnz	(OFST-2,sp)
1520  039c 2704          	jreq	L734
1521                     ; 217 		set_led(1);
1523  039e a601          	ld	a,#1
1524  03a0 ad19          	call	_set_led
1526  03a2               L734:
1527                     ; 221   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1529  03a2 72105300      	bset	21248,#0
1530                     ; 222 }
1533  03a6 5b04          	addw	sp,#4
1534  03a8 85            	popw	x
1535  03a9 bf00          	ldw	c_lreg,x
1536  03ab 85            	popw	x
1537  03ac bf02          	ldw	c_lreg+2,x
1538  03ae 85            	popw	x
1539  03af bf00          	ldw	c_y,x
1540  03b1 320002        	pop	c_y+2
1541  03b4 85            	popw	x
1542  03b5 bf00          	ldw	c_x,x
1543  03b7 320002        	pop	c_x+2
1544  03ba 80            	iret
1546                     	switch	.const
1547  0010               L144_led_lookup:
1548  0010 00            	dc.b	0
1549  0011 03            	dc.b	3
1550  0012 01            	dc.b	1
1551  0013 03            	dc.b	3
1552  0014 02            	dc.b	2
1553  0015 03            	dc.b	3
1554  0016 03            	dc.b	3
1555  0017 00            	dc.b	0
1556  0018 04            	dc.b	4
1557  0019 00            	dc.b	0
1558  001a 05            	dc.b	5
1559  001b 00            	dc.b	0
1560  001c 00            	dc.b	0
1561  001d 04            	dc.b	4
1562  001e 01            	dc.b	1
1563  001f 04            	dc.b	4
1564  0020 02            	dc.b	2
1565  0021 04            	dc.b	4
1566  0022 03            	dc.b	3
1567  0023 01            	dc.b	1
1568  0024 04            	dc.b	4
1569  0025 01            	dc.b	1
1570  0026 05            	dc.b	5
1571  0027 01            	dc.b	1
1572  0028 00            	dc.b	0
1573  0029 05            	dc.b	5
1574  002a 01            	dc.b	1
1575  002b 05            	dc.b	5
1576  002c 02            	dc.b	2
1577  002d 05            	dc.b	5
1578  002e 03            	dc.b	3
1579  002f 02            	dc.b	2
1580  0030 04            	dc.b	4
1581  0031 02            	dc.b	2
1582  0032 05            	dc.b	5
1583  0033 02            	dc.b	2
1584  0034 06            	dc.b	6
1585  0035 06            	dc.b	6
1586  0036 01            	dc.b	1
1587  0037 00            	dc.b	0
1588  0038 02            	dc.b	2
1589  0039 00            	dc.b	0
1590  003a 00            	dc.b	0
1591  003b 01            	dc.b	1
1592  003c 02            	dc.b	2
1593  003d 01            	dc.b	1
1594  003e 00            	dc.b	0
1595  003f 02            	dc.b	2
1596  0040 01            	dc.b	1
1597  0041 02            	dc.b	2
1598  0042 04            	dc.b	4
1599  0043 03            	dc.b	3
1600  0044 05            	dc.b	5
1601  0045 03            	dc.b	3
1602  0046 03            	dc.b	3
1603  0047 04            	dc.b	4
1604  0048 05            	dc.b	5
1605  0049 04            	dc.b	4
1606  004a 03            	dc.b	3
1607  004b 05            	dc.b	5
1608  004c 04            	dc.b	4
1609  004d 05            	dc.b	5
1653                     ; 225 void set_led(u8 led_index)
1653                     ; 226 {
1655                     	switch	.text
1656  03bb               _set_led:
1658  03bb 88            	push	a
1659  03bc 5240          	subw	sp,#64
1660       00000040      OFST:	set	64
1663                     ; 227 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1663                     ; 228 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1663                     ; 229 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1663                     ; 230 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1663                     ; 231 		{6,6},//debug; GND is tied low, no charlieplexing involved
1663                     ; 232 		{1,0},//LED7
1663                     ; 233 		{2,0},//LED8
1663                     ; 234 		{0,1},//LED9
1663                     ; 235 		{2,1},//LED10
1663                     ; 236 		{0,2},//LED11
1663                     ; 237 		{1,2},//LED12
1663                     ; 238 		{4,3},//LED13
1663                     ; 239 		{5,3},//LED14
1663                     ; 240 		{3,4},//LED15
1663                     ; 241 		{5,4},//LED16
1663                     ; 242 		{3,5},//LED17
1663                     ; 243 		{4,5} //LED18
1663                     ; 244 	};
1665  03be 96            	ldw	x,sp
1666  03bf 1c0003        	addw	x,#OFST-61
1667  03c2 90ae0010      	ldw	y,#L144_led_lookup
1668  03c6 a63e          	ld	a,#62
1669  03c8 cd0000        	call	c_xymov
1671                     ; 245 	set_mat(led_lookup[led_index][0],1);
1673  03cb 96            	ldw	x,sp
1674  03cc 1c0003        	addw	x,#OFST-61
1675  03cf 1f01          	ldw	(OFST-63,sp),x
1677  03d1 7b41          	ld	a,(OFST+1,sp)
1678  03d3 5f            	clrw	x
1679  03d4 97            	ld	xl,a
1680  03d5 58            	sllw	x
1681  03d6 72fb01        	addw	x,(OFST-63,sp)
1682  03d9 f6            	ld	a,(x)
1683  03da ae0001        	ldw	x,#1
1684  03dd 95            	ld	xh,a
1685  03de ad1c          	call	_set_mat
1687                     ; 246 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1689  03e0 7b41          	ld	a,(OFST+1,sp)
1690  03e2 a112          	cp	a,#18
1691  03e4 2713          	jreq	L564
1694  03e6 96            	ldw	x,sp
1695  03e7 1c0004        	addw	x,#OFST-60
1696  03ea 1f01          	ldw	(OFST-63,sp),x
1698  03ec 7b41          	ld	a,(OFST+1,sp)
1699  03ee 5f            	clrw	x
1700  03ef 97            	ld	xl,a
1701  03f0 58            	sllw	x
1702  03f1 72fb01        	addw	x,(OFST-63,sp)
1703  03f4 f6            	ld	a,(x)
1704  03f5 5f            	clrw	x
1705  03f6 95            	ld	xh,a
1706  03f7 ad03          	call	_set_mat
1708  03f9               L564:
1709                     ; 247 }
1712  03f9 5b41          	addw	sp,#65
1713  03fb 81            	ret
1914                     ; 250 void set_mat(u8 mat_index,bool is_high)
1914                     ; 251 {
1915                     	switch	.text
1916  03fc               _set_mat:
1918  03fc 89            	pushw	x
1919  03fd 5203          	subw	sp,#3
1920       00000003      OFST:	set	3
1923                     ; 254 	if(mat_index==0)
1925  03ff 9e            	ld	a,xh
1926  0400 4d            	tnz	a
1927  0401 2609          	jrne	L506
1928                     ; 256 		GPIOx=GPIOC;
1930  0403 ae500a        	ldw	x,#20490
1931  0406 1f01          	ldw	(OFST-2,sp),x
1933                     ; 257 		GPIO_Pin=GPIO_PIN_3;
1935  0408 a608          	ld	a,#8
1936  040a 6b03          	ld	(OFST+0,sp),a
1938  040c               L506:
1939                     ; 259 	if(mat_index==1)
1941  040c 7b04          	ld	a,(OFST+1,sp)
1942  040e a101          	cp	a,#1
1943  0410 2609          	jrne	L706
1944                     ; 261 		GPIOx=GPIOC;
1946  0412 ae500a        	ldw	x,#20490
1947  0415 1f01          	ldw	(OFST-2,sp),x
1949                     ; 262 		GPIO_Pin=GPIO_PIN_4;
1951  0417 a610          	ld	a,#16
1952  0419 6b03          	ld	(OFST+0,sp),a
1954  041b               L706:
1955                     ; 264 	if(mat_index==2)
1957  041b 7b04          	ld	a,(OFST+1,sp)
1958  041d a102          	cp	a,#2
1959  041f 2609          	jrne	L116
1960                     ; 266 		GPIOx=GPIOC;
1962  0421 ae500a        	ldw	x,#20490
1963  0424 1f01          	ldw	(OFST-2,sp),x
1965                     ; 267 		GPIO_Pin=GPIO_PIN_5;
1967  0426 a620          	ld	a,#32
1968  0428 6b03          	ld	(OFST+0,sp),a
1970  042a               L116:
1971                     ; 269 	if(mat_index==3)
1973  042a 7b04          	ld	a,(OFST+1,sp)
1974  042c a103          	cp	a,#3
1975  042e 2609          	jrne	L316
1976                     ; 271 		GPIOx=GPIOC;
1978  0430 ae500a        	ldw	x,#20490
1979  0433 1f01          	ldw	(OFST-2,sp),x
1981                     ; 272 		GPIO_Pin=GPIO_PIN_6;
1983  0435 a640          	ld	a,#64
1984  0437 6b03          	ld	(OFST+0,sp),a
1986  0439               L316:
1987                     ; 274 	if(mat_index==4)
1989  0439 7b04          	ld	a,(OFST+1,sp)
1990  043b a104          	cp	a,#4
1991  043d 2609          	jrne	L516
1992                     ; 276 		GPIOx=GPIOC;
1994  043f ae500a        	ldw	x,#20490
1995  0442 1f01          	ldw	(OFST-2,sp),x
1997                     ; 277 		GPIO_Pin=GPIO_PIN_7;
1999  0444 a680          	ld	a,#128
2000  0446 6b03          	ld	(OFST+0,sp),a
2002  0448               L516:
2003                     ; 279 	if(mat_index==5)
2005  0448 7b04          	ld	a,(OFST+1,sp)
2006  044a a105          	cp	a,#5
2007  044c 2609          	jrne	L716
2008                     ; 281 		GPIOx=GPIOD;
2010  044e ae500f        	ldw	x,#20495
2011  0451 1f01          	ldw	(OFST-2,sp),x
2013                     ; 282 		GPIO_Pin=GPIO_PIN_2;
2015  0453 a604          	ld	a,#4
2016  0455 6b03          	ld	(OFST+0,sp),a
2018  0457               L716:
2019                     ; 284 	if(mat_index==6)
2021  0457 7b04          	ld	a,(OFST+1,sp)
2022  0459 a106          	cp	a,#6
2023  045b 2609          	jrne	L126
2024                     ; 286 		GPIOx=GPIOA;
2026  045d ae5000        	ldw	x,#20480
2027  0460 1f01          	ldw	(OFST-2,sp),x
2029                     ; 287 		GPIO_Pin=GPIO_PIN_3;
2031  0462 a608          	ld	a,#8
2032  0464 6b03          	ld	(OFST+0,sp),a
2034  0466               L126:
2035                     ; 289 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2037  0466 0d05          	tnz	(OFST+2,sp)
2038  0468 2708          	jreq	L326
2041  046a 1e01          	ldw	x,(OFST-2,sp)
2042  046c f6            	ld	a,(x)
2043  046d 1a03          	or	a,(OFST+0,sp)
2044  046f f7            	ld	(x),a
2046  0470 2007          	jra	L526
2047  0472               L326:
2048                     ; 290 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2050  0472 1e01          	ldw	x,(OFST-2,sp)
2051  0474 7b03          	ld	a,(OFST+0,sp)
2052  0476 43            	cpl	a
2053  0477 f4            	and	a,(x)
2054  0478 f7            	ld	(x),a
2055  0479               L526:
2056                     ; 291 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2058  0479 1e01          	ldw	x,(OFST-2,sp)
2059  047b e602          	ld	a,(2,x)
2060  047d 1a03          	or	a,(OFST+0,sp)
2061  047f e702          	ld	(2,x),a
2062                     ; 292 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2064  0481 1e01          	ldw	x,(OFST-2,sp)
2065  0483 e603          	ld	a,(3,x)
2066  0485 1a03          	or	a,(OFST+0,sp)
2067  0487 e703          	ld	(3,x),a
2068                     ; 293 }
2071  0489 5b05          	addw	sp,#5
2072  048b 81            	ret
2139                     ; 303 void flush_leds(u8 led_count)
2139                     ; 304 {
2140                     	switch	.text
2141  048c               _flush_leds:
2143  048c 88            	push	a
2144  048d 5205          	subw	sp,#5
2145       00000005      OFST:	set	5
2148                     ; 305 	u8 led_read_index=0,led_write_index=0;
2152  048f 0f04          	clr	(OFST-1,sp)
2155  0491               L566:
2156                     ; 307 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2158  0491 b607          	ld	a,_pwm_state
2159  0493 a502          	bcp	a,#2
2160  0495 26fa          	jrne	L566
2161                     ; 308 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2163  0497 b607          	ld	a,_pwm_state
2164  0499 a401          	and	a,#1
2165  049b a801          	xor	a,#1
2166  049d 6b03          	ld	(OFST-2,sp),a
2168                     ; 310 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2170  049f 7b06          	ld	a,(OFST+1,sp)
2171  04a1 5f            	clrw	x
2172  04a2 97            	ld	xl,a
2173  04a3 4f            	clr	a
2174  04a4 02            	rlwa	x,a
2175  04a5 58            	sllw	x
2176  04a6 58            	sllw	x
2177  04a7 7b03          	ld	a,(OFST-2,sp)
2178  04a9 905f          	clrw	y
2179  04ab 9097          	ld	yl,a
2180  04ad 9058          	sllw	y
2181  04af 90ef0a        	ldw	(_pwm_sleep,y),x
2182                     ; 312 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
2184  04b2 0f05          	clr	(OFST+0,sp)
2187  04b4 ac570557      	jpf	L576
2188  04b8               L176:
2189                     ; 314 		if(pwm_brightness_buffer[led_read_index]!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2191  04b8 7b05          	ld	a,(OFST+0,sp)
2192  04ba 5f            	clrw	x
2193  04bb 97            	ld	xl,a
2194  04bc 6d0e          	tnz	(_pwm_brightness_buffer,x)
2195  04be 2603cc054f    	jreq	L107
2196                     ; 316 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2198  04c3 7b04          	ld	a,(OFST-1,sp)
2199  04c5 5f            	clrw	x
2200  04c6 97            	ld	xl,a
2201  04c7 58            	sllw	x
2202  04c8 01            	rrwa	x,a
2203  04c9 1b03          	add	a,(OFST-2,sp)
2204  04cb 2401          	jrnc	L631
2205  04cd 5c            	incw	x
2206  04ce               L631:
2207  04ce 02            	rlwa	x,a
2208  04cf 7b05          	ld	a,(OFST+0,sp)
2209  04d1 e72d          	ld	(_pwm_brightness_index,x),a
2210                     ; 317 			pwm_brightness[led_write_index][buffer_index]=(pwm_brightness_buffer[led_read_index]*pwm_brightness_buffer[led_read_index])>>6;//square 8-bit brightness and then clip to 10 bits
2212  04d3 7b05          	ld	a,(OFST+0,sp)
2213  04d5 5f            	clrw	x
2214  04d6 97            	ld	xl,a
2215  04d7 7b05          	ld	a,(OFST+0,sp)
2216  04d9 905f          	clrw	y
2217  04db 9097          	ld	yl,a
2218  04dd 90e60e        	ld	a,(_pwm_brightness_buffer,y)
2219  04e0 88            	push	a
2220  04e1 e60e          	ld	a,(_pwm_brightness_buffer,x)
2221  04e3 97            	ld	xl,a
2222  04e4 84            	pop	a
2223  04e5 42            	mul	x,a
2224  04e6 57            	sraw	x
2225  04e7 57            	sraw	x
2226  04e8 57            	sraw	x
2227  04e9 57            	sraw	x
2228  04ea 57            	sraw	x
2229  04eb 57            	sraw	x
2230  04ec 7b03          	ld	a,(OFST-2,sp)
2231  04ee 905f          	clrw	y
2232  04f0 9097          	ld	yl,a
2233  04f2 9058          	sllw	y
2234  04f4 1701          	ldw	(OFST-4,sp),y
2236  04f6 7b04          	ld	a,(OFST-1,sp)
2237  04f8 905f          	clrw	y
2238  04fa 9097          	ld	yl,a
2239  04fc 9058          	sllw	y
2240  04fe 9058          	sllw	y
2241  0500 72f901        	addw	y,(OFST-4,sp)
2242  0503 90ef6b        	ldw	(_pwm_brightness,y),x
2243                     ; 318 			pwm_brightness[led_write_index][buffer_index]++;//values <8 are rounded to 0, so round that up to avoid zero-length display states
2245  0506 7b03          	ld	a,(OFST-2,sp)
2246  0508 5f            	clrw	x
2247  0509 97            	ld	xl,a
2248  050a 58            	sllw	x
2249  050b 1f01          	ldw	(OFST-4,sp),x
2251  050d 7b04          	ld	a,(OFST-1,sp)
2252  050f 97            	ld	xl,a
2253  0510 a604          	ld	a,#4
2254  0512 42            	mul	x,a
2255  0513 72fb01        	addw	x,(OFST-4,sp)
2256  0516 9093          	ldw	y,x
2257  0518 ee6b          	ldw	x,(_pwm_brightness,x)
2258  051a 1c0001        	addw	x,#1
2259  051d 90ef6b        	ldw	(_pwm_brightness,y),x
2260                     ; 319 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2262  0520 7b03          	ld	a,(OFST-2,sp)
2263  0522 5f            	clrw	x
2264  0523 97            	ld	xl,a
2265  0524 58            	sllw	x
2266  0525 7b03          	ld	a,(OFST-2,sp)
2267  0527 905f          	clrw	y
2268  0529 9097          	ld	yl,a
2269  052b 9058          	sllw	y
2270  052d 1701          	ldw	(OFST-4,sp),y
2272  052f 7b04          	ld	a,(OFST-1,sp)
2273  0531 905f          	clrw	y
2274  0533 9097          	ld	yl,a
2275  0535 9058          	sllw	y
2276  0537 9058          	sllw	y
2277  0539 72f901        	addw	y,(OFST-4,sp)
2278  053c 90ee6b        	ldw	y,(_pwm_brightness,y)
2279  053f 9001          	rrwa	y,a
2280  0541 e00b          	sub	a,(_pwm_sleep+1,x)
2281  0543 9001          	rrwa	y,a
2282  0545 e20a          	sbc	a,(_pwm_sleep,x)
2283  0547 9001          	rrwa	y,a
2284  0549 9050          	negw	y
2285  054b ef0a          	ldw	(_pwm_sleep,x),y
2286                     ; 320 			led_write_index++;
2288  054d 0c04          	inc	(OFST-1,sp)
2290  054f               L107:
2291                     ; 322 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2293  054f 7b05          	ld	a,(OFST+0,sp)
2294  0551 5f            	clrw	x
2295  0552 97            	ld	xl,a
2296  0553 6f0e          	clr	(_pwm_brightness_buffer,x)
2297                     ; 312 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
2299  0555 0c05          	inc	(OFST+0,sp)
2301  0557               L576:
2304  0557 7b05          	ld	a,(OFST+0,sp)
2305  0559 a11f          	cp	a,#31
2306  055b 2409          	jruge	L307
2308  055d 7b04          	ld	a,(OFST-1,sp)
2309  055f 1106          	cp	a,(OFST+1,sp)
2310  0561 2403          	jruge	L041
2311  0563 cc04b8        	jp	L176
2312  0566               L041:
2313  0566               L307:
2314                     ; 324 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2316  0566 7b03          	ld	a,(OFST-2,sp)
2317  0568 5f            	clrw	x
2318  0569 97            	ld	xl,a
2319  056a 7b04          	ld	a,(OFST-1,sp)
2320  056c e708          	ld	(_pwm_led_count,x),a
2321                     ; 327 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2323  056e 72120007      	bset	_pwm_state,#1
2324                     ; 328 }
2327  0572 5b06          	addw	sp,#6
2328  0574 81            	ret
2426                     ; 331 void set_hue_max(u8 index,u16 color)
2426                     ; 332 {
2427                     	switch	.text
2428  0575               _set_hue_max:
2430  0575 88            	push	a
2431  0576 5207          	subw	sp,#7
2432       00000007      OFST:	set	7
2435                     ; 333 	const u8 brightness=255;
2437  0578 a6ff          	ld	a,#255
2438  057a 6b07          	ld	(OFST+0,sp),a
2440                     ; 334 	u8 red=0,green=0,blue=0;
2442  057c 0f04          	clr	(OFST-3,sp)
2446  057e 0f05          	clr	(OFST-2,sp)
2450  0580 0f06          	clr	(OFST-1,sp)
2452                     ; 335 	u16 residual_16=color%(0x2AAB);
2454  0582 1e0b          	ldw	x,(OFST+4,sp)
2455  0584 90ae2aab      	ldw	y,#10923
2456  0588 65            	divw	x,y
2457  0589 51            	exgw	x,y
2458  058a 1f01          	ldw	(OFST-6,sp),x
2460                     ; 336 	u8 residual_8=(residual_16<<8)/0x2AAB;
2462  058c 1e01          	ldw	x,(OFST-6,sp)
2463  058e 4f            	clr	a
2464  058f 02            	rlwa	x,a
2465  0590 90ae2aab      	ldw	y,#10923
2466  0594 65            	divw	x,y
2467  0595 01            	rrwa	x,a
2468  0596 6b03          	ld	(OFST-4,sp),a
2469  0598 02            	rlwa	x,a
2471                     ; 337 	switch(color/(0x2AAB))
2473  0599 1e0b          	ldw	x,(OFST+4,sp)
2474  059b 90ae2aab      	ldw	y,#10923
2475  059f 65            	divw	x,y
2477                     ; 368 			break;
2478  05a0 5d            	tnzw	x
2479  05a1 2711          	jreq	L507
2480  05a3 5a            	decw	x
2481  05a4 271a          	jreq	L707
2482  05a6 5a            	decw	x
2483  05a7 2725          	jreq	L117
2484  05a9 5a            	decw	x
2485  05aa 272e          	jreq	L317
2486  05ac 5a            	decw	x
2487  05ad 2739          	jreq	L517
2488  05af 5a            	decw	x
2489  05b0 2742          	jreq	L717
2490  05b2 204c          	jra	L777
2491  05b4               L507:
2492                     ; 340 			red=brightness;
2494  05b4 7b07          	ld	a,(OFST+0,sp)
2495  05b6 6b04          	ld	(OFST-3,sp),a
2497                     ; 341 			green=residual_8;
2499  05b8 7b03          	ld	a,(OFST-4,sp)
2500  05ba 6b05          	ld	(OFST-2,sp),a
2502                     ; 342 			blue=0;
2504  05bc 0f06          	clr	(OFST-1,sp)
2506                     ; 343 			break;
2508  05be 2040          	jra	L777
2509  05c0               L707:
2510                     ; 345 			red=brightness-residual_8;
2512  05c0 7b07          	ld	a,(OFST+0,sp)
2513  05c2 1003          	sub	a,(OFST-4,sp)
2514  05c4 6b04          	ld	(OFST-3,sp),a
2516                     ; 346 			green=brightness;
2518  05c6 7b07          	ld	a,(OFST+0,sp)
2519  05c8 6b05          	ld	(OFST-2,sp),a
2521                     ; 347 			blue=0;
2523  05ca 0f06          	clr	(OFST-1,sp)
2525                     ; 348 			break;
2527  05cc 2032          	jra	L777
2528  05ce               L117:
2529                     ; 350 			red=0;
2531  05ce 0f04          	clr	(OFST-3,sp)
2533                     ; 351 			green=brightness;
2535  05d0 7b07          	ld	a,(OFST+0,sp)
2536  05d2 6b05          	ld	(OFST-2,sp),a
2538                     ; 352 			blue=residual_8;
2540  05d4 7b03          	ld	a,(OFST-4,sp)
2541  05d6 6b06          	ld	(OFST-1,sp),a
2543                     ; 353 			break;
2545  05d8 2026          	jra	L777
2546  05da               L317:
2547                     ; 355 			red=0;
2549  05da 0f04          	clr	(OFST-3,sp)
2551                     ; 356 			green=brightness-residual_8;
2553  05dc 7b07          	ld	a,(OFST+0,sp)
2554  05de 1003          	sub	a,(OFST-4,sp)
2555  05e0 6b05          	ld	(OFST-2,sp),a
2557                     ; 357 			blue=brightness;
2559  05e2 7b07          	ld	a,(OFST+0,sp)
2560  05e4 6b06          	ld	(OFST-1,sp),a
2562                     ; 358 			break;
2564  05e6 2018          	jra	L777
2565  05e8               L517:
2566                     ; 360 			red=residual_8;
2568  05e8 7b03          	ld	a,(OFST-4,sp)
2569  05ea 6b04          	ld	(OFST-3,sp),a
2571                     ; 361 			green=0;
2573  05ec 0f05          	clr	(OFST-2,sp)
2575                     ; 362 			blue=brightness;
2577  05ee 7b07          	ld	a,(OFST+0,sp)
2578  05f0 6b06          	ld	(OFST-1,sp),a
2580                     ; 363 			break;
2582  05f2 200c          	jra	L777
2583  05f4               L717:
2584                     ; 365 			red=brightness;
2586  05f4 7b07          	ld	a,(OFST+0,sp)
2587  05f6 6b04          	ld	(OFST-3,sp),a
2589                     ; 366 			green=0;
2591  05f8 0f05          	clr	(OFST-2,sp)
2593                     ; 367 			blue=brightness-residual_8;
2595  05fa 7b07          	ld	a,(OFST+0,sp)
2596  05fc 1003          	sub	a,(OFST-4,sp)
2597  05fe 6b06          	ld	(OFST-1,sp),a
2599                     ; 368 			break;
2601  0600               L777:
2602                     ; 371 	set_rgb(index,0,red);
2604  0600 7b04          	ld	a,(OFST-3,sp)
2605  0602 88            	push	a
2606  0603 7b09          	ld	a,(OFST+2,sp)
2607  0605 5f            	clrw	x
2608  0606 95            	ld	xh,a
2609  0607 ad1c          	call	_set_rgb
2611  0609 84            	pop	a
2612                     ; 372 	set_rgb(index,1,green);
2614  060a 7b05          	ld	a,(OFST-2,sp)
2615  060c 88            	push	a
2616  060d 7b09          	ld	a,(OFST+2,sp)
2617  060f ae0001        	ldw	x,#1
2618  0612 95            	ld	xh,a
2619  0613 ad10          	call	_set_rgb
2621  0615 84            	pop	a
2622                     ; 373 	set_rgb(index,2,blue);
2624  0616 7b06          	ld	a,(OFST-1,sp)
2625  0618 88            	push	a
2626  0619 7b09          	ld	a,(OFST+2,sp)
2627  061b ae0002        	ldw	x,#2
2628  061e 95            	ld	xh,a
2629  061f ad04          	call	_set_rgb
2631  0621 84            	pop	a
2632                     ; 374 }
2635  0622 5b08          	addw	sp,#8
2636  0624 81            	ret
2689                     ; 376 void set_rgb(u8 index,u8 color,u8 brightness)
2689                     ; 377 {
2690                     	switch	.text
2691  0625               _set_rgb:
2693  0625 89            	pushw	x
2694       00000000      OFST:	set	0
2697                     ; 378 	pwm_brightness_buffer[index*3+color]=brightness;
2699  0626 9e            	ld	a,xh
2700  0627 97            	ld	xl,a
2701  0628 a603          	ld	a,#3
2702  062a 42            	mul	x,a
2703  062b 01            	rrwa	x,a
2704  062c 1b02          	add	a,(OFST+2,sp)
2705  062e 2401          	jrnc	L051
2706  0630 5c            	incw	x
2707  0631               L051:
2708  0631 02            	rlwa	x,a
2709  0632 7b05          	ld	a,(OFST+5,sp)
2710  0634 e70e          	ld	(_pwm_brightness_buffer,x),a
2711                     ; 379 }
2714  0636 85            	popw	x
2715  0637 81            	ret
2759                     ; 381 void set_white(u8 index,u8 brightness)
2759                     ; 382 {
2760                     	switch	.text
2761  0638               _set_white:
2763  0638 89            	pushw	x
2764       00000000      OFST:	set	0
2767                     ; 383 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2769  0639 9e            	ld	a,xh
2770  063a 5f            	clrw	x
2771  063b 97            	ld	xl,a
2772  063c 7b02          	ld	a,(OFST+2,sp)
2773  063e e721          	ld	(_pwm_brightness_buffer+19,x),a
2774                     ; 384 }
2777  0640 85            	popw	x
2778  0641 81            	ret
2813                     ; 387 void set_debug(u8 brightness)
2813                     ; 388 {
2814                     	switch	.text
2815  0642               _set_debug:
2819                     ; 389 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2821  0642 b720          	ld	_pwm_brightness_buffer+18,a
2822                     ; 390 }
2825  0644 81            	ret
2848                     ; 392 void set_matrix_high_z()
2848                     ; 393 {
2849                     	switch	.text
2850  0645               _set_matrix_high_z:
2854                     ; 394 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2856  0645 c6500d        	ld	a,20493
2857  0648 a407          	and	a,#7
2858  064a c7500d        	ld	20493,a
2859                     ; 395 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2861  064d 72155012      	bres	20498,#2
2862                     ; 396 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2864  0651 72175003      	bres	20483,#3
2865                     ; 397 }
2868  0655 81            	ret
2902                     ; 399 u8 get_eeprom_byte(u16 eeprom_address)
2902                     ; 400 {
2903                     	switch	.text
2904  0656               _get_eeprom_byte:
2908                     ; 401 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2910  0656 d64000        	ld	a,(16384,x)
2913  0659 81            	ret
3060                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3061                     	xdef	_temp3_delete_me
3062                     	xdef	_temp_delete_me
3063                     	switch	.ubsct
3064  0000               _button_pressed_event:
3065  0000 00000000      	ds.b	4
3066                     	xdef	_button_pressed_event
3067  0004               _button_start_ms:
3068  0004 00000000      	ds.b	4
3069                     	xdef	_button_start_ms
3070                     	xdef	_pwm_state
3071                     	xdef	_pwm_visible_index
3072                     	xdef	_pwm_sleep_remaining
3073  0008               _pwm_led_count:
3074  0008 0000          	ds.b	2
3075                     	xdef	_pwm_led_count
3076  000a               _pwm_sleep:
3077  000a 00000000      	ds.b	4
3078                     	xdef	_pwm_sleep
3079  000e               _pwm_brightness_buffer:
3080  000e 000000000000  	ds.b	31
3081                     	xdef	_pwm_brightness_buffer
3082  002d               _pwm_brightness_index:
3083  002d 000000000000  	ds.b	62
3084                     	xdef	_pwm_brightness_index
3085  006b               _pwm_brightness:
3086  006b 000000000000  	ds.b	124
3087                     	xdef	_pwm_brightness
3088                     	xdef	_api_counter
3089                     	xref	_UART1_Cmd
3090                     	xref	_UART1_Init
3091                     	xref	_UART1_DeInit
3092                     	xref	_GPIO_ReadInputPin
3093                     	xref	_GPIO_Init
3094                     	xdef	_set_led
3095                     	xdef	_set_mat
3096                     	xdef	_get_eeprom_byte
3097                     	xdef	_get_random
3098                     	xdef	_is_button_down
3099                     	xdef	_clear_button_events
3100                     	xdef	_clear_button_event
3101                     	xdef	_get_button_event
3102                     	xdef	_update_buttons
3103                     	xdef	_is_developer_valid
3104                     	xdef	_set_hue_max
3105                     	xdef	_flush_leds
3106                     	xdef	_set_debug
3107                     	xdef	_set_white
3108                     	xdef	_set_rgb
3109                     	xdef	_set_matrix_high_z
3110                     	xdef	_millis
3111                     	xdef	_setup_main
3112                     	xdef	_is_application_valid
3113                     	xdef	_setup_serial
3114                     	xdef	_hello_world
3115                     	xref.b	c_lreg
3116                     	xref.b	c_x
3117                     	xref.b	c_y
3137                     	xref	c_xymov
3138                     	xref	c_lgadd
3139                     	xref	c_lzmp
3140                     	xref	c_lsub
3141                     	xref	c_rtol
3142                     	xref	c_uitolx
3143                     	xref	c_lursh
3144                     	xref	c_itolx
3145                     	xref	c_imul
3146                     	xref	c_ldiv
3147                     	xref	c_lrzmp
3148                     	xref	c_lmod
3149                     	xref	c_ltor
3150                     	xref	c_lgadc
3151                     	end
