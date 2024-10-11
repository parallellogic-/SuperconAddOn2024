   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _visible_index:
  16  0000 00            	dc.b	0
  17  0001               _micros_counter:
  18  0001 0000          	dc.w	0
  19  0003               _millis_counter:
  20  0003 0000          	dc.w	0
  21                     .const:	section	.text
  22  0000               _PWM_MAX_PERIOD:
  23  0000 ff            	dc.b	255
  24                     	bsct
  25  0005               _pwm_sleep_remaining:
  26  0005 0000          	dc.w	0
  27  0007               _pwm_led_index:
  28  0007 00            	dc.b	0
  29  0008               _pwm_state:
  30  0008 00            	dc.b	0
  31  0009               _temp_delete_me:
  32  0009 0000          	dc.w	0
  33  000b               _temp3_delete_me:
  34  000b 0000          	dc.w	0
 124                     	switch	.const
 125  0001               L01:
 126  0001 00010000      	dc.l	65536
 127  0005               L21:
 128  0005 00000002      	dc.l	2
 129  0009               L41:
 130  0009 00000100      	dc.l	256
 131                     ; 35 void hello_world()
 131                     ; 36 {//basic program that blinks the debug LED ON/OFF
 132                     	scross	off
 133                     	switch	.text
 134  0000               _hello_world:
 136  0000 5207          	subw	sp,#7
 137       00000007      OFST:	set	7
 140                     ; 39 	bool is_high=0;
 142                     ; 40 	long frame=0;
 144  0002 ae0000        	ldw	x,#0
 145  0005 1f04          	ldw	(OFST-3,sp),x
 146  0007 ae0000        	ldw	x,#0
 147  000a 1f02          	ldw	(OFST-5,sp),x
 149  000c               L35:
 150                     ; 44 		frame++;
 152  000c 96            	ldw	x,sp
 153  000d 1c0002        	addw	x,#OFST-5
 154  0010 a601          	ld	a,#1
 155  0012 cd0000        	call	c_lgadc
 158                     ; 46 		temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
 160  0015 96            	ldw	x,sp
 161  0016 1c0002        	addw	x,#OFST-5
 162  0019 cd0000        	call	c_ltor
 164  001c ae0001        	ldw	x,#L01
 165  001f cd0000        	call	c_ldiv
 167  0022 ae0005        	ldw	x,#L21
 168  0025 cd0000        	call	c_lmod
 170  0028 cd0000        	call	c_lrzmp
 172  002b 2717          	jreq	L6
 173  002d 96            	ldw	x,sp
 174  002e 1c0002        	addw	x,#OFST-5
 175  0031 cd0000        	call	c_ltor
 177  0034 ae0009        	ldw	x,#L41
 178  0037 cd0000        	call	c_ldiv
 180  003a 3303          	cpl	c_lreg+3
 181  003c 3302          	cpl	c_lreg+2
 182  003e 3301          	cpl	c_lreg+1
 183  0040 3300          	cpl	c_lreg
 184  0042 200d          	jra	L61
 185  0044               L6:
 186  0044 96            	ldw	x,sp
 187  0045 1c0002        	addw	x,#OFST-5
 188  0048 cd0000        	call	c_ltor
 190  004b ae0009        	ldw	x,#L41
 191  004e cd0000        	call	c_ldiv
 193  0051               L61:
 194  0051 3f02          	clr	c_lreg+2
 195  0053 3f01          	clr	c_lreg+1
 196  0055 3f00          	clr	c_lreg
 197  0057 be02          	ldw	x,c_lreg+2
 198  0059 1f06          	ldw	(OFST-1,sp),x
 200                     ; 47 		temp2_delete_me=temp2_delete_me*temp2_delete_me;
 202  005b 1e06          	ldw	x,(OFST-1,sp)
 203  005d 1606          	ldw	y,(OFST-1,sp)
 204  005f cd0000        	call	c_imul
 206  0062 1f06          	ldw	(OFST-1,sp),x
 208                     ; 48 		temp2_delete_me=temp2_delete_me>>6;
 210  0064 a606          	ld	a,#6
 211  0066               L02:
 212  0066 0406          	srl	(OFST-1,sp)
 213  0068 0607          	rrc	(OFST+0,sp)
 214  006a 4a            	dec	a
 215  006b 26f9          	jrne	L02
 217                     ; 49 		temp_delete_me=temp2_delete_me;
 219  006d 1e06          	ldw	x,(OFST-1,sp)
 220  006f bf09          	ldw	_temp_delete_me,x
 221                     ; 50 		temp4_delete_me=0x00FF&((frame/256/256)%2?((frame/256)):(~frame/256));
 223  0071 96            	ldw	x,sp
 224  0072 1c0002        	addw	x,#OFST-5
 225  0075 cd0000        	call	c_ltor
 227  0078 ae0001        	ldw	x,#L01
 228  007b cd0000        	call	c_ldiv
 230  007e ae0005        	ldw	x,#L21
 231  0081 cd0000        	call	c_lmod
 233  0084 cd0000        	call	c_lrzmp
 235  0087 270f          	jreq	L22
 236  0089 96            	ldw	x,sp
 237  008a 1c0002        	addw	x,#OFST-5
 238  008d cd0000        	call	c_ltor
 240  0090 ae0009        	ldw	x,#L41
 241  0093 cd0000        	call	c_ldiv
 243  0096 2015          	jra	L42
 244  0098               L22:
 245  0098 96            	ldw	x,sp
 246  0099 1c0002        	addw	x,#OFST-5
 247  009c cd0000        	call	c_ltor
 249  009f 3303          	cpl	c_lreg+3
 250  00a1 3302          	cpl	c_lreg+2
 251  00a3 3301          	cpl	c_lreg+1
 252  00a5 3300          	cpl	c_lreg
 253  00a7 ae0009        	ldw	x,#L41
 254  00aa cd0000        	call	c_ldiv
 256  00ad               L42:
 257  00ad 3f02          	clr	c_lreg+2
 258  00af 3f01          	clr	c_lreg+1
 259  00b1 3f00          	clr	c_lreg
 260  00b3 be02          	ldw	x,c_lreg+2
 261  00b5 1f06          	ldw	(OFST-1,sp),x
 263                     ; 51 		temp4_delete_me=temp4_delete_me*temp4_delete_me;
 265  00b7 1e06          	ldw	x,(OFST-1,sp)
 266  00b9 1606          	ldw	y,(OFST-1,sp)
 267  00bb cd0000        	call	c_imul
 269  00be 1f06          	ldw	(OFST-1,sp),x
 271                     ; 52 		temp4_delete_me=temp4_delete_me>>6;
 273  00c0 a606          	ld	a,#6
 274  00c2               L62:
 275  00c2 0406          	srl	(OFST-1,sp)
 276  00c4 0607          	rrc	(OFST+0,sp)
 277  00c6 4a            	dec	a
 278  00c7 26f9          	jrne	L62
 280                     ; 53 		temp3_delete_me=(temp4_delete_me%2)<<9;
 282  00c9 7b06          	ld	a,(OFST-1,sp)
 283  00cb 97            	ld	xl,a
 284  00cc 7b07          	ld	a,(OFST+0,sp)
 285  00ce a401          	and	a,#1
 286  00d0 5f            	clrw	x
 287  00d1 02            	rlwa	x,a
 288  00d2 4f            	clr	a
 289  00d3 02            	rlwa	x,a
 290  00d4 58            	sllw	x
 291  00d5 bf0b          	ldw	_temp3_delete_me,x
 293  00d7 ac0c000c      	jpf	L35
 345                     ; 58 u16 get_random(u16 x)
 345                     ; 59 {
 346                     	switch	.text
 347  00db               _get_random:
 349  00db 5204          	subw	sp,#4
 350       00000004      OFST:	set	4
 353                     ; 60 	u16 a=1664525;
 355                     ; 61 	u16 c=1013904223;
 357                     ; 62 	return a * x + c;
 359  00dd 90ae660d      	ldw	y,#26125
 360  00e1 cd0000        	call	c_imul
 362  00e4 1cf35f        	addw	x,#62303
 365  00e7 5b04          	addw	sp,#4
 366  00e9 81            	ret
 415                     	switch	.const
 416  000d               L04:
 417  000d 000f4240      	dc.l	1000000
 418                     ; 65 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 418                     ; 66 {
 419                     	switch	.text
 420  00ea               _setup_serial:
 422  00ea 89            	pushw	x
 423       00000000      OFST:	set	0
 426                     ; 67 	if(is_enabled)
 428  00eb 9e            	ld	a,xh
 429  00ec 4d            	tnz	a
 430  00ed 2747          	jreq	L721
 431                     ; 69 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 433  00ef 4bf0          	push	#240
 434  00f1 4b20          	push	#32
 435  00f3 ae500f        	ldw	x,#20495
 436  00f6 cd0000        	call	_GPIO_Init
 438  00f9 85            	popw	x
 439                     ; 70 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 441  00fa 4b40          	push	#64
 442  00fc 4b40          	push	#64
 443  00fe ae500f        	ldw	x,#20495
 444  0101 cd0000        	call	_GPIO_Init
 446  0104 85            	popw	x
 447                     ; 71 		UART1_DeInit();
 449  0105 cd0000        	call	_UART1_DeInit
 451                     ; 72 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 453  0108 4b0c          	push	#12
 454  010a 4b80          	push	#128
 455  010c 4b00          	push	#0
 456  010e 4b00          	push	#0
 457  0110 4b00          	push	#0
 458  0112 0d07          	tnz	(OFST+7,sp)
 459  0114 2708          	jreq	L43
 460  0116 ae2580        	ldw	x,#9600
 461  0119 cd0000        	call	c_itolx
 463  011c 2006          	jra	L63
 464  011e               L43:
 465  011e ae000d        	ldw	x,#L04
 466  0121 cd0000        	call	c_ltor
 468  0124               L63:
 469  0124 be02          	ldw	x,c_lreg+2
 470  0126 89            	pushw	x
 471  0127 be00          	ldw	x,c_lreg
 472  0129 89            	pushw	x
 473  012a cd0000        	call	_UART1_Init
 475  012d 5b09          	addw	sp,#9
 476                     ; 73 		UART1_Cmd(ENABLE);
 478  012f a601          	ld	a,#1
 479  0131 cd0000        	call	_UART1_Cmd
 482  0134 201d          	jra	L131
 483  0136               L721:
 484                     ; 75 		UART1_Cmd(DISABLE);
 486  0136 4f            	clr	a
 487  0137 cd0000        	call	_UART1_Cmd
 489                     ; 76 		UART1_DeInit();
 491  013a cd0000        	call	_UART1_DeInit
 493                     ; 77 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 495  013d 4b40          	push	#64
 496  013f 4b20          	push	#32
 497  0141 ae500f        	ldw	x,#20495
 498  0144 cd0000        	call	_GPIO_Init
 500  0147 85            	popw	x
 501                     ; 78 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 503  0148 4b40          	push	#64
 504  014a 4b40          	push	#64
 505  014c ae500f        	ldw	x,#20495
 506  014f cd0000        	call	_GPIO_Init
 508  0152 85            	popw	x
 509  0153               L131:
 510                     ; 80 }
 513  0153 85            	popw	x
 514  0154 81            	ret
 541                     ; 83 bool is_application_valid()
 541                     ; 84 {
 542                     	switch	.text
 543  0155               _is_application_valid:
 547                     ; 85 	return !is_button_down(2) && !get_button_event(0,1);
 549  0155 a602          	ld	a,#2
 550  0157 cd02b3        	call	_is_button_down
 552  015a 4d            	tnz	a
 553  015b 260d          	jrne	L44
 554  015d ae0001        	ldw	x,#1
 555  0160 cd0264        	call	_get_button_event
 557  0163 4d            	tnz	a
 558  0164 2604          	jrne	L44
 559  0166 a601          	ld	a,#1
 560  0168 2001          	jra	L64
 561  016a               L44:
 562  016a 4f            	clr	a
 563  016b               L64:
 566  016b 81            	ret
 592                     ; 89 bool is_developer_valid()
 592                     ; 90 {
 593                     	switch	.text
 594  016c               _is_developer_valid:
 598                     ; 91 	return is_button_down(2) && !get_button_event(0,1);
 600  016c a602          	ld	a,#2
 601  016e cd02b3        	call	_is_button_down
 603  0171 4d            	tnz	a
 604  0172 270d          	jreq	L25
 605  0174 ae0001        	ldw	x,#1
 606  0177 cd0264        	call	_get_button_event
 608  017a 4d            	tnz	a
 609  017b 2604          	jrne	L25
 610  017d a601          	ld	a,#1
 611  017f 2001          	jra	L45
 612  0181               L25:
 613  0181 4f            	clr	a
 614  0182               L45:
 617  0182 81            	ret
 642                     ; 95 bool is_sleep_valid()
 642                     ; 96 {
 643                     	switch	.text
 644  0183               _is_sleep_valid:
 648                     ; 97 	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
 650  0183 5f            	clrw	x
 651  0184 cd0264        	call	_get_button_event
 653  0187 4d            	tnz	a
 654  0188 261f          	jrne	L06
 655  018a ae0100        	ldw	x,#256
 656  018d cd0264        	call	_get_button_event
 658  0190 4d            	tnz	a
 659  0191 2616          	jrne	L06
 660  0193 ae0001        	ldw	x,#1
 661  0196 cd0264        	call	_get_button_event
 663  0199 4d            	tnz	a
 664  019a 260d          	jrne	L06
 665  019c ae0101        	ldw	x,#257
 666  019f cd0264        	call	_get_button_event
 668  01a2 4d            	tnz	a
 669  01a3 2604          	jrne	L06
 670  01a5 a601          	ld	a,#1
 671  01a7 2001          	jra	L26
 672  01a9               L06:
 673  01a9 4f            	clr	a
 674  01aa               L26:
 677  01aa 81            	ret
 702                     ; 100 void setup_main()
 702                     ; 101 {
 703                     	switch	.text
 704  01ab               _setup_main:
 708                     ; 102 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 710  01ab c650c6        	ld	a,20678
 711  01ae a4e7          	and	a,#231
 712  01b0 c750c6        	ld	20678,a
 713                     ; 104 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 715  01b3 4b40          	push	#64
 716  01b5 4b02          	push	#2
 717  01b7 ae500f        	ldw	x,#20495
 718  01ba cd0000        	call	_GPIO_Init
 720  01bd 85            	popw	x
 721                     ; 107 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 723  01be 725f5311      	clr	21265
 724                     ; 108 	TIM2->PSCR= 4;// init divider register 16MHz/2^X
 726  01c2 3504530e      	mov	21262,#4
 727                     ; 109 	TIM2->ARRH= 16;// init auto reload register
 729  01c6 3510530f      	mov	21263,#16
 730                     ; 110 	TIM2->ARRL= 255;// init auto reload register
 732  01ca 35ff5310      	mov	21264,#255
 733                     ; 112 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 735  01ce c65300        	ld	a,21248
 736  01d1 aa05          	or	a,#5
 737  01d3 c75300        	ld	21248,a
 738                     ; 114 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 740  01d6 35015303      	mov	21251,#1
 741                     ; 115 	enableInterrupts();
 744  01da 9a            rim
 746                     ; 117 }
 750  01db 81            	ret
 774                     ; 119 u32 millis()
 774                     ; 120 {
 775                     	switch	.text
 776  01dc               _millis:
 780                     ; 121 	return millis_counter;
 782  01dc be03          	ldw	x,_millis_counter
 783  01de cd0000        	call	c_uitolx
 787  01e1 81            	ret
 822                     ; 124 void set_millis(u32 new_time)
 822                     ; 125 {
 823                     	switch	.text
 824  01e2               _set_millis:
 826       00000000      OFST:	set	0
 829                     ; 126 	millis_counter=new_time;
 831  01e2 1e05          	ldw	x,(OFST+5,sp)
 832  01e4 bf03          	ldw	_millis_counter,x
 833                     ; 127 }
 836  01e6 81            	ret
 894                     ; 132 void update_buttons()
 894                     ; 133 {
 895                     	switch	.text
 896  01e7               _update_buttons:
 898  01e7 5208          	subw	sp,#8
 899       00000008      OFST:	set	8
 902                     ; 134 	bool is_any_down=0;
 904  01e9 0f05          	clr	(OFST-3,sp)
 906                     ; 136 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 908  01eb be06          	ldw	x,_button_start_ms+2
 909  01ed cd0000        	call	c_uitolx
 911  01f0 96            	ldw	x,sp
 912  01f1 1c0001        	addw	x,#OFST-7
 913  01f4 cd0000        	call	c_rtol
 916  01f7 ade3          	call	_millis
 918  01f9 96            	ldw	x,sp
 919  01fa 1c0001        	addw	x,#OFST-7
 920  01fd cd0000        	call	c_lsub
 922  0200 be02          	ldw	x,c_lreg+2
 923  0202 1f06          	ldw	(OFST-2,sp),x
 925                     ; 137 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 927  0204 0f08          	clr	(OFST+0,sp)
 929  0206               L742:
 930                     ; 139 		if(is_button_down(button_index))
 932  0206 7b08          	ld	a,(OFST+0,sp)
 933  0208 cd02b3        	call	_is_button_down
 935  020b 4d            	tnz	a
 936  020c 271b          	jreq	L552
 937                     ; 141 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 939  020e ae0004        	ldw	x,#_button_start_ms
 940  0211 cd0000        	call	c_lzmp
 942  0214 2608          	jrne	L752
 945  0216 adc4          	call	_millis
 947  0218 ae0004        	ldw	x,#_button_start_ms
 948  021b cd0000        	call	c_rtol
 950  021e               L752:
 951                     ; 142 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 953  021e a6ff          	ld	a,#255
 954  0220 cd0543        	call	_set_debug
 956                     ; 143 			is_any_down=1;
 958  0223 a601          	ld	a,#1
 959  0225 6b05          	ld	(OFST-3,sp),a
 962  0227 2022          	jra	L162
 963  0229               L552:
 964                     ; 145 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 966  0229 1e06          	ldw	x,(OFST-2,sp)
 967  022b a30201        	cpw	x,#513
 968  022e 250b          	jrult	L362
 971  0230 7b08          	ld	a,(OFST+0,sp)
 972  0232 5f            	clrw	x
 973  0233 97            	ld	xl,a
 974  0234 58            	sllw	x
 975  0235 a601          	ld	a,#1
 976  0237 e701          	ld	(_button_pressed_event+1,x),a
 978  0239 2010          	jra	L162
 979  023b               L362:
 980                     ; 146 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 982  023b 1e06          	ldw	x,(OFST-2,sp)
 983  023d a30033        	cpw	x,#51
 984  0240 2509          	jrult	L162
 987  0242 7b08          	ld	a,(OFST+0,sp)
 988  0244 5f            	clrw	x
 989  0245 97            	ld	xl,a
 990  0246 58            	sllw	x
 991  0247 a601          	ld	a,#1
 992  0249 e700          	ld	(_button_pressed_event,x),a
 993  024b               L162:
 994                     ; 137 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 996  024b 0c08          	inc	(OFST+0,sp)
1000  024d 7b08          	ld	a,(OFST+0,sp)
1001  024f a102          	cp	a,#2
1002  0251 25b3          	jrult	L742
1003                     ; 150 	if(!is_any_down) button_start_ms=0;
1005  0253 0d05          	tnz	(OFST-3,sp)
1006  0255 260a          	jrne	L172
1009  0257 ae0000        	ldw	x,#0
1010  025a bf06          	ldw	_button_start_ms+2,x
1011  025c ae0000        	ldw	x,#0
1012  025f bf04          	ldw	_button_start_ms,x
1013  0261               L172:
1014                     ; 151 }
1017  0261 5b08          	addw	sp,#8
1018  0263 81            	ret
1064                     ; 154 bool get_button_event(u8 button_index,bool is_long)
1064                     ; 155 { return button_pressed_event[button_index][is_long]; }
1065                     	switch	.text
1066  0264               _get_button_event:
1068  0264 89            	pushw	x
1069       00000000      OFST:	set	0
1074  0265 9e            	ld	a,xh
1075  0266 5f            	clrw	x
1076  0267 97            	ld	xl,a
1077  0268 58            	sllw	x
1078  0269 01            	rrwa	x,a
1079  026a 1b02          	add	a,(OFST+2,sp)
1080  026c 2401          	jrnc	L67
1081  026e 5c            	incw	x
1082  026f               L67:
1083  026f 02            	rlwa	x,a
1084  0270 e600          	ld	a,(_button_pressed_event,x)
1087  0272 85            	popw	x
1088  0273 81            	ret
1144                     ; 158 bool clear_button_event(u8 button_index,bool is_long)
1144                     ; 159 {
1145                     	switch	.text
1146  0274               _clear_button_event:
1148  0274 89            	pushw	x
1149  0275 88            	push	a
1150       00000001      OFST:	set	1
1153                     ; 160 	bool out=button_pressed_event[button_index][is_long];
1155  0276 9e            	ld	a,xh
1156  0277 5f            	clrw	x
1157  0278 97            	ld	xl,a
1158  0279 58            	sllw	x
1159  027a 01            	rrwa	x,a
1160  027b 1b03          	add	a,(OFST+2,sp)
1161  027d 2401          	jrnc	L201
1162  027f 5c            	incw	x
1163  0280               L201:
1164  0280 02            	rlwa	x,a
1165  0281 e600          	ld	a,(_button_pressed_event,x)
1166  0283 6b01          	ld	(OFST+0,sp),a
1168                     ; 161 	button_pressed_event[button_index][is_long]=0;
1170  0285 7b02          	ld	a,(OFST+1,sp)
1171  0287 5f            	clrw	x
1172  0288 97            	ld	xl,a
1173  0289 58            	sllw	x
1174  028a 01            	rrwa	x,a
1175  028b 1b03          	add	a,(OFST+2,sp)
1176  028d 2401          	jrnc	L401
1177  028f 5c            	incw	x
1178  0290               L401:
1179  0290 02            	rlwa	x,a
1180  0291 6f00          	clr	(_button_pressed_event,x)
1181                     ; 162 	return out;
1183  0293 7b01          	ld	a,(OFST+0,sp)
1186  0295 5b03          	addw	sp,#3
1187  0297 81            	ret
1223                     ; 165 void clear_button_events()
1223                     ; 166 {
1224                     	switch	.text
1225  0298               _clear_button_events:
1227  0298 88            	push	a
1228       00000001      OFST:	set	1
1231                     ; 168 	for(iter=0;iter<BUTTON_COUNT;iter++)
1233  0299 0f01          	clr	(OFST+0,sp)
1235  029b               L163:
1236                     ; 170 		clear_button_event(iter,0);
1238  029b 7b01          	ld	a,(OFST+0,sp)
1239  029d 5f            	clrw	x
1240  029e 95            	ld	xh,a
1241  029f add3          	call	_clear_button_event
1243                     ; 171 		clear_button_event(iter,1);
1245  02a1 7b01          	ld	a,(OFST+0,sp)
1246  02a3 ae0001        	ldw	x,#1
1247  02a6 95            	ld	xh,a
1248  02a7 adcb          	call	_clear_button_event
1250                     ; 168 	for(iter=0;iter<BUTTON_COUNT;iter++)
1252  02a9 0c01          	inc	(OFST+0,sp)
1256  02ab 7b01          	ld	a,(OFST+0,sp)
1257  02ad a102          	cp	a,#2
1258  02af 25ea          	jrult	L163
1259                     ; 173 }
1262  02b1 84            	pop	a
1263  02b2 81            	ret
1299                     ; 176 bool is_button_down(u8 index)
1299                     ; 177 {
1300                     	switch	.text
1301  02b3               _is_button_down:
1305                     ; 178 	switch(index)
1308                     ; 182 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1310  02b3 4d            	tnz	a
1311  02b4 2708          	jreq	L763
1312  02b6 4a            	dec	a
1313  02b7 2718          	jreq	L173
1314  02b9 4a            	dec	a
1315  02ba 2728          	jreq	L373
1316  02bc 2039          	jra	L514
1317  02be               L763:
1318                     ; 180 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1320  02be 4b20          	push	#32
1321  02c0 ae500f        	ldw	x,#20495
1322  02c3 cd0000        	call	_GPIO_ReadInputPin
1324  02c6 5b01          	addw	sp,#1
1325  02c8 4d            	tnz	a
1326  02c9 2604          	jrne	L211
1327  02cb a601          	ld	a,#1
1328  02cd 2001          	jra	L411
1329  02cf               L211:
1330  02cf 4f            	clr	a
1331  02d0               L411:
1334  02d0 81            	ret
1335  02d1               L173:
1336                     ; 181 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1339  02d1 4b40          	push	#64
1340  02d3 ae500f        	ldw	x,#20495
1341  02d6 cd0000        	call	_GPIO_ReadInputPin
1343  02d9 5b01          	addw	sp,#1
1344  02db 4d            	tnz	a
1345  02dc 2604          	jrne	L611
1346  02de a601          	ld	a,#1
1347  02e0 2001          	jra	L021
1348  02e2               L611:
1349  02e2 4f            	clr	a
1350  02e3               L021:
1353  02e3 81            	ret
1354  02e4               L373:
1355                     ; 182 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1358  02e4 4b02          	push	#2
1359  02e6 ae500f        	ldw	x,#20495
1360  02e9 cd0000        	call	_GPIO_ReadInputPin
1362  02ec 5b01          	addw	sp,#1
1363  02ee 4d            	tnz	a
1364  02ef 2604          	jrne	L221
1365  02f1 a601          	ld	a,#1
1366  02f3 2001          	jra	L421
1367  02f5               L221:
1368  02f5 4f            	clr	a
1369  02f6               L421:
1372  02f6 81            	ret
1373  02f7               L514:
1374                     ; 184 	return 0;
1376  02f7 4f            	clr	a
1379  02f8 81            	ret
1440                     ; 188 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1442                     	switch	.text
1443  02f9               f_TIM2_UPD_OVF_IRQHandler:
1445  02f9 8a            	push	cc
1446  02fa 84            	pop	a
1447  02fb a4bf          	and	a,#191
1448  02fd 88            	push	a
1449  02fe 86            	pop	cc
1450       00000004      OFST:	set	4
1451  02ff 3b0002        	push	c_x+2
1452  0302 be00          	ldw	x,c_x
1453  0304 89            	pushw	x
1454  0305 3b0002        	push	c_y+2
1455  0308 be00          	ldw	x,c_y
1456  030a 89            	pushw	x
1457  030b 5204          	subw	sp,#4
1460                     ; 189 	u16 this_sleep=temp_delete_me;
1462  030d be09          	ldw	x,_temp_delete_me
1463  030f 1f03          	ldw	(OFST-1,sp),x
1465                     ; 190 	bool is_debug_led=0;
1467  0311 0f01          	clr	(OFST-3,sp)
1469                     ; 191 	bool is_other_led=0;
1471  0313 0f02          	clr	(OFST-2,sp)
1473                     ; 193 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1475  0315 c6500d        	ld	a,20493
1476  0318 a407          	and	a,#7
1477  031a c7500d        	ld	20493,a
1478                     ; 194 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1480  031d 72155012      	bres	20498,#2
1481                     ; 195 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1483  0321 72175003      	bres	20483,#3
1484                     ; 196   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1486  0325 72115300      	bres	21248,#0
1487                     ; 197 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1489  0329 72115304      	bres	21252,#0
1490                     ; 198 	visible_index++;
1492  032d 3c00          	inc	_visible_index
1493                     ; 199 	if(visible_index>6) visible_index=0;
1495  032f b600          	ld	a,_visible_index
1496  0331 a107          	cp	a,#7
1497  0333 2502          	jrult	L544
1500  0335 3f00          	clr	_visible_index
1501  0337               L544:
1502                     ; 202 	if(visible_index==0)//simulate other LEDs ON
1504  0337 3d00          	tnz	_visible_index
1505  0339 260d          	jrne	L744
1506                     ; 204 		is_debug_led=this_sleep>0;
1508  033b 1e03          	ldw	x,(OFST-1,sp)
1509  033d 2704          	jreq	L031
1510  033f a601          	ld	a,#1
1511  0341 2001          	jra	L231
1512  0343               L031:
1513  0343 4f            	clr	a
1514  0344               L231:
1515  0344 6b01          	ld	(OFST-3,sp),a
1518  0346 201c          	jra	L154
1519  0348               L744:
1520                     ; 205 	}else if(visible_index==1){
1522  0348 b600          	ld	a,_visible_index
1523  034a a101          	cp	a,#1
1524  034c 2611          	jrne	L354
1525                     ; 206 		this_sleep=temp3_delete_me;
1527  034e be0b          	ldw	x,_temp3_delete_me
1528  0350 1f03          	ldw	(OFST-1,sp),x
1530                     ; 207 		is_other_led=this_sleep>0;
1532  0352 1e03          	ldw	x,(OFST-1,sp)
1533  0354 2704          	jreq	L431
1534  0356 a601          	ld	a,#1
1535  0358 2001          	jra	L631
1536  035a               L431:
1537  035a 4f            	clr	a
1538  035b               L631:
1539  035b 6b02          	ld	(OFST-2,sp),a
1542  035d 2005          	jra	L154
1543  035f               L354:
1544                     ; 209 		this_sleep=0x400;
1546  035f ae0400        	ldw	x,#1024
1547  0362 1f03          	ldw	(OFST-1,sp),x
1549  0364               L154:
1550                     ; 211 	if(this_sleep<1) this_sleep=1;
1552  0364 1e03          	ldw	x,(OFST-1,sp)
1553  0366 2605          	jrne	L754
1556  0368 ae0001        	ldw	x,#1
1557  036b 1f03          	ldw	(OFST-1,sp),x
1559  036d               L754:
1560                     ; 214   TIM2->CNTRH = 0;// Set the high byte of the counter
1562  036d 725f530c      	clr	21260
1563                     ; 215   TIM2->CNTRL = 0;// Set the low byte of the counter
1565  0371 725f530d      	clr	21261
1566                     ; 218 	TIM2->ARRH= this_sleep>>8;// init auto reload register
1568  0375 7b03          	ld	a,(OFST-1,sp)
1569  0377 c7530f        	ld	21263,a
1570                     ; 219 	TIM2->ARRL= this_sleep&0x00FF;// init auto reload register
1572  037a 7b04          	ld	a,(OFST+0,sp)
1573  037c a4ff          	and	a,#255
1574  037e c75310        	ld	21264,a
1575                     ; 220 	micros_counter+=this_sleep;
1577  0381 be01          	ldw	x,_micros_counter
1578  0383 72fb03        	addw	x,(OFST-1,sp)
1579  0386 bf01          	ldw	_micros_counter,x
1580                     ; 221 	millis_counter+=micros_counter>>10;
1582  0388 be01          	ldw	x,_micros_counter
1583  038a 4f            	clr	a
1584  038b 01            	rrwa	x,a
1585  038c 54            	srlw	x
1586  038d 54            	srlw	x
1587  038e 72bb0003      	addw	x,_millis_counter
1588  0392 bf03          	ldw	_millis_counter,x
1589                     ; 222 	micros_counter&=0x03FF;
1591  0394 b601          	ld	a,_micros_counter
1592  0396 a403          	and	a,#3
1593  0398 b701          	ld	_micros_counter,a
1594                     ; 224 	if(is_debug_led)
1596  039a 0d01          	tnz	(OFST-3,sp)
1597  039c 270b          	jreq	L164
1598                     ; 225 		GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
1600  039e 4bd0          	push	#208
1601  03a0 4b08          	push	#8
1602  03a2 ae5000        	ldw	x,#20480
1603  03a5 cd0000        	call	_GPIO_Init
1605  03a8 85            	popw	x
1606  03a9               L164:
1607                     ; 226 	if(is_other_led)
1609  03a9 0d02          	tnz	(OFST-2,sp)
1610  03ab 2716          	jreq	L364
1611                     ; 228 		GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
1613  03ad 4bd0          	push	#208
1614  03af 4b08          	push	#8
1615  03b1 ae500a        	ldw	x,#20490
1616  03b4 cd0000        	call	_GPIO_Init
1618  03b7 85            	popw	x
1619                     ; 229 		GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_SLOW);
1621  03b8 4bc0          	push	#192
1622  03ba 4b40          	push	#64
1623  03bc ae500a        	ldw	x,#20490
1624  03bf cd0000        	call	_GPIO_Init
1626  03c2 85            	popw	x
1627  03c3               L364:
1628                     ; 233   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1630  03c3 72105300      	bset	21248,#0
1631                     ; 234 }
1634  03c7 5b04          	addw	sp,#4
1635  03c9 85            	popw	x
1636  03ca bf00          	ldw	c_y,x
1637  03cc 320002        	pop	c_y+2
1638  03cf 85            	popw	x
1639  03d0 bf00          	ldw	c_x,x
1640  03d2 320002        	pop	c_x+2
1641  03d5 80            	iret
1706                     ; 243 void flush_leds(u8 led_count)
1706                     ; 244 {
1708                     	switch	.text
1709  03d6               _flush_leds:
1711  03d6 88            	push	a
1712  03d7 5203          	subw	sp,#3
1713       00000003      OFST:	set	3
1716                     ; 245 	u8 led_read_index=0,led_write_index=0;
1720  03d9 0f02          	clr	(OFST-1,sp)
1723  03db               L325:
1724                     ; 247 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1726  03db b608          	ld	a,_pwm_state
1727  03dd a502          	bcp	a,#2
1728  03df 26fa          	jrne	L325
1729                     ; 248 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1731  03e1 b608          	ld	a,_pwm_state
1732  03e3 a401          	and	a,#1
1733  03e5 a801          	xor	a,#1
1734  03e7 6b01          	ld	(OFST-2,sp),a
1736                     ; 249 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1738  03e9 7b04          	ld	a,(OFST+1,sp)
1739  03eb 5f            	clrw	x
1740  03ec 97            	ld	xl,a
1741  03ed 4f            	clr	a
1742  03ee 02            	rlwa	x,a
1743  03ef 7b01          	ld	a,(OFST-2,sp)
1744  03f1 905f          	clrw	y
1745  03f3 9097          	ld	yl,a
1746  03f5 9058          	sllw	y
1747  03f7 90ef0a        	ldw	(_pwm_sleep,y),x
1748                     ; 251 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1750  03fa 0f03          	clr	(OFST+0,sp)
1753  03fc 205d          	jra	L335
1754  03fe               L725:
1755                     ; 253 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1757  03fe 7b03          	ld	a,(OFST+0,sp)
1758  0400 5f            	clrw	x
1759  0401 97            	ld	xl,a
1760  0402 e68a          	ld	a,(_pwm_brightness_buffer,x)
1761  0404 a105          	cp	a,#5
1762  0406 254b          	jrult	L735
1763                     ; 255 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1765  0408 7b02          	ld	a,(OFST-1,sp)
1766  040a 97            	ld	xl,a
1767  040b a604          	ld	a,#4
1768  040d 42            	mul	x,a
1769  040e 01            	rrwa	x,a
1770  040f 1b01          	add	a,(OFST-2,sp)
1771  0411 2401          	jrnc	L241
1772  0413 5c            	incw	x
1773  0414               L241:
1774  0414 02            	rlwa	x,a
1775  0415 7b03          	ld	a,(OFST+0,sp)
1776  0417 e70e          	ld	(_pwm_brightness,x),a
1777                     ; 256 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1779  0419 7b02          	ld	a,(OFST-1,sp)
1780  041b 97            	ld	xl,a
1781  041c a604          	ld	a,#4
1782  041e 42            	mul	x,a
1783  041f 01            	rrwa	x,a
1784  0420 1b01          	add	a,(OFST-2,sp)
1785  0422 2401          	jrnc	L441
1786  0424 5c            	incw	x
1787  0425               L441:
1788  0425 02            	rlwa	x,a
1789  0426 7b03          	ld	a,(OFST+0,sp)
1790  0428 905f          	clrw	y
1791  042a 9097          	ld	yl,a
1792  042c 90e68a        	ld	a,(_pwm_brightness_buffer,y)
1793  042f e710          	ld	(_pwm_brightness+2,x),a
1794                     ; 257 			led_write_index++;
1796  0431 0c02          	inc	(OFST-1,sp)
1798                     ; 258 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1800  0433 7b01          	ld	a,(OFST-2,sp)
1801  0435 5f            	clrw	x
1802  0436 97            	ld	xl,a
1803  0437 58            	sllw	x
1804  0438 7b03          	ld	a,(OFST+0,sp)
1805  043a 905f          	clrw	y
1806  043c 9097          	ld	yl,a
1807  043e 90e68a        	ld	a,(_pwm_brightness_buffer,y)
1808  0441 905f          	clrw	y
1809  0443 9097          	ld	yl,a
1810  0445 9001          	rrwa	y,a
1811  0447 e00b          	sub	a,(_pwm_sleep+1,x)
1812  0449 9001          	rrwa	y,a
1813  044b e20a          	sbc	a,(_pwm_sleep,x)
1814  044d 9001          	rrwa	y,a
1815  044f 9050          	negw	y
1816  0451 ef0a          	ldw	(_pwm_sleep,x),y
1817  0453               L735:
1818                     ; 260 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1820  0453 7b03          	ld	a,(OFST+0,sp)
1821  0455 5f            	clrw	x
1822  0456 97            	ld	xl,a
1823  0457 6f8a          	clr	(_pwm_brightness_buffer,x)
1824                     ; 251 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1826  0459 0c03          	inc	(OFST+0,sp)
1828  045b               L335:
1831  045b 7b03          	ld	a,(OFST+0,sp)
1832  045d a11f          	cp	a,#31
1833  045f 2406          	jruge	L145
1835  0461 7b02          	ld	a,(OFST-1,sp)
1836  0463 1104          	cp	a,(OFST+1,sp)
1837  0465 2597          	jrult	L725
1838  0467               L145:
1839                     ; 262 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1841  0467 7b01          	ld	a,(OFST-2,sp)
1842  0469 5f            	clrw	x
1843  046a 97            	ld	xl,a
1844  046b 7b02          	ld	a,(OFST-1,sp)
1845  046d e708          	ld	(_pwm_led_count,x),a
1846                     ; 265 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1848  046f 72120008      	bset	_pwm_state,#1
1849                     ; 266 }
1852  0473 5b04          	addw	sp,#4
1853  0475 81            	ret
1942                     ; 268 void set_hue(u8 index,u16 color,u8 brightness)
1942                     ; 269 {
1943                     	switch	.text
1944  0476               _set_hue:
1946  0476 88            	push	a
1947  0477 5205          	subw	sp,#5
1948       00000005      OFST:	set	5
1951                     ; 270 	u8 red=0,green=0,blue=0;
1953  0479 0f01          	clr	(OFST-4,sp)
1957  047b 0f02          	clr	(OFST-3,sp)
1961  047d 0f03          	clr	(OFST-2,sp)
1963                     ; 271 	u16 residual=color%(0x2AAB);
1965  047f 1e09          	ldw	x,(OFST+4,sp)
1966  0481 90ae2aab      	ldw	y,#10923
1967  0485 65            	divw	x,y
1968  0486 51            	exgw	x,y
1969  0487 1f04          	ldw	(OFST-1,sp),x
1971                     ; 272 	residual=(u8)(residual*brightness/0x2AAB);
1973  0489 1e04          	ldw	x,(OFST-1,sp)
1974  048b 7b0b          	ld	a,(OFST+6,sp)
1975  048d cd0000        	call	c_bmulx
1977  0490 90ae2aab      	ldw	y,#10923
1978  0494 65            	divw	x,y
1979  0495 9f            	ld	a,xl
1980  0496 5f            	clrw	x
1981  0497 97            	ld	xl,a
1982  0498 1f04          	ldw	(OFST-1,sp),x
1984                     ; 273 	switch(color/(0x2AAB))//0xFFFF/6
1986  049a 1e09          	ldw	x,(OFST+4,sp)
1987  049c 90ae2aab      	ldw	y,#10923
1988  04a0 65            	divw	x,y
1990                     ; 304 			break;
1991  04a1 5d            	tnzw	x
1992  04a2 2711          	jreq	L345
1993  04a4 5a            	decw	x
1994  04a5 271a          	jreq	L545
1995  04a7 5a            	decw	x
1996  04a8 2725          	jreq	L745
1997  04aa 5a            	decw	x
1998  04ab 272e          	jreq	L155
1999  04ad 5a            	decw	x
2000  04ae 2739          	jreq	L355
2001  04b0 5a            	decw	x
2002  04b1 2742          	jreq	L555
2003  04b3 204c          	jra	L136
2004  04b5               L345:
2005                     ; 276 			red=brightness;
2007  04b5 7b0b          	ld	a,(OFST+6,sp)
2008  04b7 6b01          	ld	(OFST-4,sp),a
2010                     ; 277 			green=residual;
2012  04b9 7b05          	ld	a,(OFST+0,sp)
2013  04bb 6b02          	ld	(OFST-3,sp),a
2015                     ; 278 			blue=0;
2017  04bd 0f03          	clr	(OFST-2,sp)
2019                     ; 279 			break;
2021  04bf 2040          	jra	L136
2022  04c1               L545:
2023                     ; 281 			red=brightness-residual;
2025  04c1 7b0b          	ld	a,(OFST+6,sp)
2026  04c3 1005          	sub	a,(OFST+0,sp)
2027  04c5 6b01          	ld	(OFST-4,sp),a
2029                     ; 282 			green=brightness;
2031  04c7 7b0b          	ld	a,(OFST+6,sp)
2032  04c9 6b02          	ld	(OFST-3,sp),a
2034                     ; 283 			blue=0;
2036  04cb 0f03          	clr	(OFST-2,sp)
2038                     ; 284 			break;
2040  04cd 2032          	jra	L136
2041  04cf               L745:
2042                     ; 286 			red=0;
2044  04cf 0f01          	clr	(OFST-4,sp)
2046                     ; 287 			green=brightness;
2048  04d1 7b0b          	ld	a,(OFST+6,sp)
2049  04d3 6b02          	ld	(OFST-3,sp),a
2051                     ; 288 			blue=residual;
2053  04d5 7b05          	ld	a,(OFST+0,sp)
2054  04d7 6b03          	ld	(OFST-2,sp),a
2056                     ; 289 			break;
2058  04d9 2026          	jra	L136
2059  04db               L155:
2060                     ; 291 			red=0;
2062  04db 0f01          	clr	(OFST-4,sp)
2064                     ; 292 			green=brightness-residual;
2066  04dd 7b0b          	ld	a,(OFST+6,sp)
2067  04df 1005          	sub	a,(OFST+0,sp)
2068  04e1 6b02          	ld	(OFST-3,sp),a
2070                     ; 293 			blue=brightness;
2072  04e3 7b0b          	ld	a,(OFST+6,sp)
2073  04e5 6b03          	ld	(OFST-2,sp),a
2075                     ; 294 			break;
2077  04e7 2018          	jra	L136
2078  04e9               L355:
2079                     ; 296 			red=residual;
2081  04e9 7b05          	ld	a,(OFST+0,sp)
2082  04eb 6b01          	ld	(OFST-4,sp),a
2084                     ; 297 			green=0;
2086  04ed 0f02          	clr	(OFST-3,sp)
2088                     ; 298 			blue=brightness;
2090  04ef 7b0b          	ld	a,(OFST+6,sp)
2091  04f1 6b03          	ld	(OFST-2,sp),a
2093                     ; 299 			break;
2095  04f3 200c          	jra	L136
2096  04f5               L555:
2097                     ; 301 			red=brightness;
2099  04f5 7b0b          	ld	a,(OFST+6,sp)
2100  04f7 6b01          	ld	(OFST-4,sp),a
2102                     ; 302 			green=0;
2104  04f9 0f02          	clr	(OFST-3,sp)
2106                     ; 303 			blue=brightness-residual;
2108  04fb 7b0b          	ld	a,(OFST+6,sp)
2109  04fd 1005          	sub	a,(OFST+0,sp)
2110  04ff 6b03          	ld	(OFST-2,sp),a
2112                     ; 304 			break;
2114  0501               L136:
2115                     ; 307 	set_rgb(index,0,red);
2117  0501 7b01          	ld	a,(OFST-4,sp)
2118  0503 88            	push	a
2119  0504 7b07          	ld	a,(OFST+2,sp)
2120  0506 5f            	clrw	x
2121  0507 95            	ld	xh,a
2122  0508 ad1c          	call	_set_rgb
2124  050a 84            	pop	a
2125                     ; 308 	set_rgb(index,1,green);
2127  050b 7b02          	ld	a,(OFST-3,sp)
2128  050d 88            	push	a
2129  050e 7b07          	ld	a,(OFST+2,sp)
2130  0510 ae0001        	ldw	x,#1
2131  0513 95            	ld	xh,a
2132  0514 ad10          	call	_set_rgb
2134  0516 84            	pop	a
2135                     ; 309 	set_rgb(index,2,blue);
2137  0517 7b03          	ld	a,(OFST-2,sp)
2138  0519 88            	push	a
2139  051a 7b07          	ld	a,(OFST+2,sp)
2140  051c ae0002        	ldw	x,#2
2141  051f 95            	ld	xh,a
2142  0520 ad04          	call	_set_rgb
2144  0522 84            	pop	a
2145                     ; 310 }
2148  0523 5b06          	addw	sp,#6
2149  0525 81            	ret
2202                     ; 312 void set_rgb(u8 index,u8 color,u8 brightness)
2202                     ; 313 {
2203                     	switch	.text
2204  0526               _set_rgb:
2206  0526 89            	pushw	x
2207       00000000      OFST:	set	0
2210                     ; 314 	pwm_brightness_buffer[index*3+color]=brightness;
2212  0527 9e            	ld	a,xh
2213  0528 97            	ld	xl,a
2214  0529 a603          	ld	a,#3
2215  052b 42            	mul	x,a
2216  052c 01            	rrwa	x,a
2217  052d 1b02          	add	a,(OFST+2,sp)
2218  052f 2401          	jrnc	L451
2219  0531 5c            	incw	x
2220  0532               L451:
2221  0532 02            	rlwa	x,a
2222  0533 7b05          	ld	a,(OFST+5,sp)
2223  0535 e78a          	ld	(_pwm_brightness_buffer,x),a
2224                     ; 315 }
2227  0537 85            	popw	x
2228  0538 81            	ret
2272                     ; 317 void set_white(u8 index,u8 brightness)
2272                     ; 318 {
2273                     	switch	.text
2274  0539               _set_white:
2276  0539 89            	pushw	x
2277       00000000      OFST:	set	0
2280                     ; 319 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2282  053a 9e            	ld	a,xh
2283  053b 5f            	clrw	x
2284  053c 97            	ld	xl,a
2285  053d 7b02          	ld	a,(OFST+2,sp)
2286  053f e791          	ld	(_pwm_brightness_buffer+7,x),a
2287                     ; 320 }
2290  0541 85            	popw	x
2291  0542 81            	ret
2326                     ; 323 void set_debug(u8 brightness)
2326                     ; 324 {
2327                     	switch	.text
2328  0543               _set_debug:
2332                     ; 325 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2334  0543 b790          	ld	_pwm_brightness_buffer+6,a
2335                     ; 326 }
2338  0545 81            	ret
2361                     ; 328 void set_matrix_high_z()
2361                     ; 329 {
2362                     	switch	.text
2363  0546               _set_matrix_high_z:
2367                     ; 333 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2369  0546 c6500d        	ld	a,20493
2370  0549 a407          	and	a,#7
2371  054b c7500d        	ld	20493,a
2372                     ; 334 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2374  054e 72155012      	bres	20498,#2
2375                     ; 335 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2377  0552 72175003      	bres	20483,#3
2378                     ; 336 }
2381  0556 81            	ret
2415                     ; 338 u8 get_eeprom_byte(u16 eeprom_address)
2415                     ; 339 {
2416                     	switch	.text
2417  0557               _get_eeprom_byte:
2421                     ; 340 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2423  0557 d64000        	ld	a,(16384,x)
2426  055a 81            	ret
2589                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2590                     	xdef	_temp3_delete_me
2591                     	xdef	_temp_delete_me
2592                     	switch	.ubsct
2593  0000               _button_pressed_event:
2594  0000 00000000      	ds.b	4
2595                     	xdef	_button_pressed_event
2596  0004               _button_start_ms:
2597  0004 00000000      	ds.b	4
2598                     	xdef	_button_start_ms
2599                     	xdef	_pwm_state
2600                     	xdef	_pwm_led_index
2601                     	xdef	_pwm_sleep_remaining
2602  0008               _pwm_led_count:
2603  0008 0000          	ds.b	2
2604                     	xdef	_pwm_led_count
2605  000a               _pwm_sleep:
2606  000a 00000000      	ds.b	4
2607                     	xdef	_pwm_sleep
2608  000e               _pwm_brightness:
2609  000e 000000000000  	ds.b	124
2610                     	xdef	_pwm_brightness
2611                     	xdef	_PWM_MAX_PERIOD
2612  008a               _pwm_brightness_buffer:
2613  008a 000000000000  	ds.b	31
2614                     	xdef	_pwm_brightness_buffer
2615                     	xdef	_millis_counter
2616                     	xdef	_micros_counter
2617                     	xdef	_visible_index
2618                     	xref	_UART1_Cmd
2619                     	xref	_UART1_Init
2620                     	xref	_UART1_DeInit
2621                     	xref	_GPIO_ReadInputPin
2622                     	xref	_GPIO_Init
2623                     	xdef	_get_eeprom_byte
2624                     	xdef	_set_millis
2625                     	xdef	_get_random
2626                     	xdef	_is_button_down
2627                     	xdef	_clear_button_events
2628                     	xdef	_clear_button_event
2629                     	xdef	_get_button_event
2630                     	xdef	_update_buttons
2631                     	xdef	_is_sleep_valid
2632                     	xdef	_is_developer_valid
2633                     	xdef	_set_hue
2634                     	xdef	_flush_leds
2635                     	xdef	_set_debug
2636                     	xdef	_set_white
2637                     	xdef	_set_rgb
2638                     	xdef	_set_matrix_high_z
2639                     	xdef	_millis
2640                     	xdef	_setup_main
2641                     	xdef	_is_application_valid
2642                     	xdef	_setup_serial
2643                     	xdef	_hello_world
2644                     	xref.b	c_lreg
2645                     	xref.b	c_x
2646                     	xref.b	c_y
2666                     	xref	c_bmulx
2667                     	xref	c_lzmp
2668                     	xref	c_lsub
2669                     	xref	c_rtol
2670                     	xref	c_uitolx
2671                     	xref	c_itolx
2672                     	xref	c_imul
2673                     	xref	c_lrzmp
2674                     	xref	c_lmod
2675                     	xref	c_ldiv
2676                     	xref	c_ltor
2677                     	xref	c_lgadc
2678                     	end
