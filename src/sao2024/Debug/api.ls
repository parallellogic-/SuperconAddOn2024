   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _api_counter:
  16  0000 00000000      	dc.l	0
  17                     .const:	section	.text
  18  0000               _PWM_MAX_PERIOD:
  19  0000 ff            	dc.b	255
  20                     	bsct
  21  0004               _pwm_sleep_remaining:
  22  0004 0000          	dc.w	0
  23  0006               _pwm_visible_index:
  24  0006 00            	dc.b	0
  25  0007               _pwm_state:
  26  0007 00            	dc.b	0
  27  0008               _temp_delete_me:
  28  0008 0000          	dc.w	0
  29  000a               _temp3_delete_me:
  30  000a 0000          	dc.w	0
 121                     	switch	.const
 122  0001               L6:
 123  0001 00000100      	dc.l	256
 124  0005               L21:
 125  0005 00010000      	dc.l	65536
 126  0009               L41:
 127  0009 00000002      	dc.l	2
 128                     ; 32 void hello_world()
 128                     ; 33 {//basic program that blinks the debug LED ON/OFF
 129                     	scross	off
 130                     	switch	.text
 131  0000               _hello_world:
 133  0000 5207          	subw	sp,#7
 134       00000007      OFST:	set	7
 137                     ; 36 	bool is_high=0;
 139                     ; 37 	long frame=0;
 141  0002 ae0000        	ldw	x,#0
 142  0005 1f04          	ldw	(OFST-3,sp),x
 143  0007 ae0000        	ldw	x,#0
 144  000a 1f02          	ldw	(OFST-5,sp),x
 146  000c               L35:
 147                     ; 41 		frame++;
 149  000c 96            	ldw	x,sp
 150  000d 1c0002        	addw	x,#OFST-5
 151  0010 a601          	ld	a,#1
 152  0012 cd0000        	call	c_lgadc
 155                     ; 42 		if(frame%256==0)
 157  0015 96            	ldw	x,sp
 158  0016 1c0002        	addw	x,#OFST-5
 159  0019 cd0000        	call	c_ltor
 161  001c ae0001        	ldw	x,#L6
 162  001f cd0000        	call	c_lmod
 164  0022 cd0000        	call	c_lrzmp
 166  0025 26e5          	jrne	L35
 167                     ; 45 			temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
 169  0027 96            	ldw	x,sp
 170  0028 1c0002        	addw	x,#OFST-5
 171  002b cd0000        	call	c_ltor
 173  002e ae0005        	ldw	x,#L21
 174  0031 cd0000        	call	c_ldiv
 176  0034 ae0009        	ldw	x,#L41
 177  0037 cd0000        	call	c_lmod
 179  003a cd0000        	call	c_lrzmp
 181  003d 2717          	jreq	L01
 182  003f 96            	ldw	x,sp
 183  0040 1c0002        	addw	x,#OFST-5
 184  0043 cd0000        	call	c_ltor
 186  0046 ae0001        	ldw	x,#L6
 187  0049 cd0000        	call	c_ldiv
 189  004c 3303          	cpl	c_lreg+3
 190  004e 3302          	cpl	c_lreg+2
 191  0050 3301          	cpl	c_lreg+1
 192  0052 3300          	cpl	c_lreg
 193  0054 200d          	jra	L61
 194  0056               L01:
 195  0056 96            	ldw	x,sp
 196  0057 1c0002        	addw	x,#OFST-5
 197  005a cd0000        	call	c_ltor
 199  005d ae0001        	ldw	x,#L6
 200  0060 cd0000        	call	c_ldiv
 202  0063               L61:
 203  0063 3f02          	clr	c_lreg+2
 204  0065 3f01          	clr	c_lreg+1
 205  0067 3f00          	clr	c_lreg
 206  0069 be02          	ldw	x,c_lreg+2
 207  006b 1f06          	ldw	(OFST-1,sp),x
 209                     ; 46 			temp2_delete_me=temp2_delete_me*temp2_delete_me;
 211  006d 1e06          	ldw	x,(OFST-1,sp)
 212  006f 1606          	ldw	y,(OFST-1,sp)
 213  0071 cd0000        	call	c_imul
 215  0074 1f06          	ldw	(OFST-1,sp),x
 217                     ; 47 			temp2_delete_me=temp2_delete_me>>6;
 219  0076 a606          	ld	a,#6
 220  0078               L02:
 221  0078 0406          	srl	(OFST-1,sp)
 222  007a 0607          	rrc	(OFST+0,sp)
 223  007c 4a            	dec	a
 224  007d 26f9          	jrne	L02
 226                     ; 48 			temp_delete_me=temp2_delete_me;
 228  007f 1e06          	ldw	x,(OFST-1,sp)
 229  0081 bf08          	ldw	_temp_delete_me,x
 230                     ; 49 			temp4_delete_me=0x00FF&((frame/256/256)%2?((frame/256)):(~frame/256));
 232  0083 96            	ldw	x,sp
 233  0084 1c0002        	addw	x,#OFST-5
 234  0087 cd0000        	call	c_ltor
 236  008a ae0005        	ldw	x,#L21
 237  008d cd0000        	call	c_ldiv
 239  0090 ae0009        	ldw	x,#L41
 240  0093 cd0000        	call	c_lmod
 242  0096 cd0000        	call	c_lrzmp
 244  0099 270f          	jreq	L22
 245  009b 96            	ldw	x,sp
 246  009c 1c0002        	addw	x,#OFST-5
 247  009f cd0000        	call	c_ltor
 249  00a2 ae0001        	ldw	x,#L6
 250  00a5 cd0000        	call	c_ldiv
 252  00a8 2015          	jra	L42
 253  00aa               L22:
 254  00aa 96            	ldw	x,sp
 255  00ab 1c0002        	addw	x,#OFST-5
 256  00ae cd0000        	call	c_ltor
 258  00b1 3303          	cpl	c_lreg+3
 259  00b3 3302          	cpl	c_lreg+2
 260  00b5 3301          	cpl	c_lreg+1
 261  00b7 3300          	cpl	c_lreg
 262  00b9 ae0001        	ldw	x,#L6
 263  00bc cd0000        	call	c_ldiv
 265  00bf               L42:
 266  00bf 3f02          	clr	c_lreg+2
 267  00c1 3f01          	clr	c_lreg+1
 268  00c3 3f00          	clr	c_lreg
 269  00c5 be02          	ldw	x,c_lreg+2
 270  00c7 1f06          	ldw	(OFST-1,sp),x
 272                     ; 50 			temp4_delete_me=temp4_delete_me*temp4_delete_me;
 274  00c9 1e06          	ldw	x,(OFST-1,sp)
 275  00cb 1606          	ldw	y,(OFST-1,sp)
 276  00cd cd0000        	call	c_imul
 278  00d0 1f06          	ldw	(OFST-1,sp),x
 280                     ; 51 			temp4_delete_me=temp4_delete_me>>6;
 282  00d2 a606          	ld	a,#6
 283  00d4               L62:
 284  00d4 0406          	srl	(OFST-1,sp)
 285  00d6 0607          	rrc	(OFST+0,sp)
 286  00d8 4a            	dec	a
 287  00d9 26f9          	jrne	L62
 289                     ; 52 			temp3_delete_me=(temp4_delete_me%2)<<9;
 291  00db 7b06          	ld	a,(OFST-1,sp)
 292  00dd 97            	ld	xl,a
 293  00de 7b07          	ld	a,(OFST+0,sp)
 294  00e0 a401          	and	a,#1
 295  00e2 5f            	clrw	x
 296  00e3 02            	rlwa	x,a
 297  00e4 4f            	clr	a
 298  00e5 02            	rlwa	x,a
 299  00e6 58            	sllw	x
 300  00e7 bf0a          	ldw	_temp3_delete_me,x
 301                     ; 54 			flush_leds(7);
 303  00e9 a607          	ld	a,#7
 304  00eb cd047c        	call	_flush_leds
 306  00ee ac0c000c      	jpf	L35
 358                     ; 59 u16 get_random(u16 x)
 358                     ; 60 {
 359                     	switch	.text
 360  00f2               _get_random:
 362  00f2 5204          	subw	sp,#4
 363       00000004      OFST:	set	4
 366                     ; 61 	u16 a=1664525;
 368                     ; 62 	u16 c=1013904223;
 370                     ; 63 	return a * x + c;
 372  00f4 90ae660d      	ldw	y,#26125
 373  00f8 cd0000        	call	c_imul
 375  00fb 1cf35f        	addw	x,#62303
 378  00fe 5b04          	addw	sp,#4
 379  0100 81            	ret
 428                     	switch	.const
 429  000d               L04:
 430  000d 000f4240      	dc.l	1000000
 431                     ; 66 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 431                     ; 67 {
 432                     	switch	.text
 433  0101               _setup_serial:
 435  0101 89            	pushw	x
 436       00000000      OFST:	set	0
 439                     ; 68 	if(is_enabled)
 441  0102 9e            	ld	a,xh
 442  0103 4d            	tnz	a
 443  0104 2747          	jreq	L131
 444                     ; 70 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 446  0106 4bf0          	push	#240
 447  0108 4b20          	push	#32
 448  010a ae500f        	ldw	x,#20495
 449  010d cd0000        	call	_GPIO_Init
 451  0110 85            	popw	x
 452                     ; 71 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 454  0111 4b40          	push	#64
 455  0113 4b40          	push	#64
 456  0115 ae500f        	ldw	x,#20495
 457  0118 cd0000        	call	_GPIO_Init
 459  011b 85            	popw	x
 460                     ; 72 		UART1_DeInit();
 462  011c cd0000        	call	_UART1_DeInit
 464                     ; 73 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 466  011f 4b0c          	push	#12
 467  0121 4b80          	push	#128
 468  0123 4b00          	push	#0
 469  0125 4b00          	push	#0
 470  0127 4b00          	push	#0
 471  0129 0d07          	tnz	(OFST+7,sp)
 472  012b 2708          	jreq	L43
 473  012d ae2580        	ldw	x,#9600
 474  0130 cd0000        	call	c_itolx
 476  0133 2006          	jra	L63
 477  0135               L43:
 478  0135 ae000d        	ldw	x,#L04
 479  0138 cd0000        	call	c_ltor
 481  013b               L63:
 482  013b be02          	ldw	x,c_lreg+2
 483  013d 89            	pushw	x
 484  013e be00          	ldw	x,c_lreg
 485  0140 89            	pushw	x
 486  0141 cd0000        	call	_UART1_Init
 488  0144 5b09          	addw	sp,#9
 489                     ; 74 		UART1_Cmd(ENABLE);
 491  0146 a601          	ld	a,#1
 492  0148 cd0000        	call	_UART1_Cmd
 495  014b 201d          	jra	L331
 496  014d               L131:
 497                     ; 76 		UART1_Cmd(DISABLE);
 499  014d 4f            	clr	a
 500  014e cd0000        	call	_UART1_Cmd
 502                     ; 77 		UART1_DeInit();
 504  0151 cd0000        	call	_UART1_DeInit
 506                     ; 78 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 508  0154 4b40          	push	#64
 509  0156 4b20          	push	#32
 510  0158 ae500f        	ldw	x,#20495
 511  015b cd0000        	call	_GPIO_Init
 513  015e 85            	popw	x
 514                     ; 79 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 516  015f 4b40          	push	#64
 517  0161 4b40          	push	#64
 518  0163 ae500f        	ldw	x,#20495
 519  0166 cd0000        	call	_GPIO_Init
 521  0169 85            	popw	x
 522  016a               L331:
 523                     ; 81 }
 526  016a 85            	popw	x
 527  016b 81            	ret
 554                     ; 84 bool is_application_valid()
 554                     ; 85 {
 555                     	switch	.text
 556  016c               _is_application_valid:
 560                     ; 86 	return !is_button_down(2) && !get_button_event(0,1);
 562  016c a602          	ld	a,#2
 563  016e cd02a3        	call	_is_button_down
 565  0171 4d            	tnz	a
 566  0172 260d          	jrne	L44
 567  0174 ae0001        	ldw	x,#1
 568  0177 cd0254        	call	_get_button_event
 570  017a 4d            	tnz	a
 571  017b 2604          	jrne	L44
 572  017d a601          	ld	a,#1
 573  017f 2001          	jra	L64
 574  0181               L44:
 575  0181 4f            	clr	a
 576  0182               L64:
 579  0182 81            	ret
 605                     ; 90 bool is_developer_valid()
 605                     ; 91 {
 606                     	switch	.text
 607  0183               _is_developer_valid:
 611                     ; 92 	return is_button_down(2) && !get_button_event(0,1);
 613  0183 a602          	ld	a,#2
 614  0185 cd02a3        	call	_is_button_down
 616  0188 4d            	tnz	a
 617  0189 270d          	jreq	L25
 618  018b ae0001        	ldw	x,#1
 619  018e cd0254        	call	_get_button_event
 621  0191 4d            	tnz	a
 622  0192 2604          	jrne	L25
 623  0194 a601          	ld	a,#1
 624  0196 2001          	jra	L45
 625  0198               L25:
 626  0198 4f            	clr	a
 627  0199               L45:
 630  0199 81            	ret
 655                     ; 95 void setup_main()
 655                     ; 96 {
 656                     	switch	.text
 657  019a               _setup_main:
 661                     ; 97 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 663  019a c650c6        	ld	a,20678
 664  019d a4e7          	and	a,#231
 665  019f c750c6        	ld	20678,a
 666                     ; 99 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 668  01a2 4b40          	push	#64
 669  01a4 4b02          	push	#2
 670  01a6 ae500f        	ldw	x,#20495
 671  01a9 cd0000        	call	_GPIO_Init
 673  01ac 85            	popw	x
 674                     ; 102 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 676  01ad 725f5311      	clr	21265
 677                     ; 103 	TIM2->PSCR= 4;// init divider register 16MHz/2^X
 679  01b1 3504530e      	mov	21262,#4
 680                     ; 104 	TIM2->ARRH= 16;// init auto reload register
 682  01b5 3510530f      	mov	21263,#16
 683                     ; 105 	TIM2->ARRL= 255;// init auto reload register
 685  01b9 35ff5310      	mov	21264,#255
 686                     ; 107 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 688  01bd c65300        	ld	a,21248
 689  01c0 aa05          	or	a,#5
 690  01c2 c75300        	ld	21248,a
 691                     ; 109 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 693  01c5 35015303      	mov	21251,#1
 694                     ; 110 	enableInterrupts();
 697  01c9 9a            rim
 699                     ; 112 }
 703  01ca 81            	ret
 727                     ; 114 u32 millis()
 727                     ; 115 {
 728                     	switch	.text
 729  01cb               _millis:
 733                     ; 116 	return api_counter>>10;
 735  01cb ae0000        	ldw	x,#_api_counter
 736  01ce cd0000        	call	c_ltor
 738  01d1 a60a          	ld	a,#10
 739  01d3 cd0000        	call	c_lursh
 743  01d6 81            	ret
 801                     ; 122 void update_buttons()
 801                     ; 123 {
 802                     	switch	.text
 803  01d7               _update_buttons:
 805  01d7 5208          	subw	sp,#8
 806       00000008      OFST:	set	8
 809                     ; 124 	bool is_any_down=0;
 811  01d9 0f05          	clr	(OFST-3,sp)
 813                     ; 126 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 815  01db be06          	ldw	x,_button_start_ms+2
 816  01dd cd0000        	call	c_uitolx
 818  01e0 96            	ldw	x,sp
 819  01e1 1c0001        	addw	x,#OFST-7
 820  01e4 cd0000        	call	c_rtol
 823  01e7 ade2          	call	_millis
 825  01e9 96            	ldw	x,sp
 826  01ea 1c0001        	addw	x,#OFST-7
 827  01ed cd0000        	call	c_lsub
 829  01f0 be02          	ldw	x,c_lreg+2
 830  01f2 1f06          	ldw	(OFST-2,sp),x
 832                     ; 127 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 834  01f4 0f08          	clr	(OFST+0,sp)
 836  01f6               L322:
 837                     ; 129 		if(is_button_down(button_index))
 839  01f6 7b08          	ld	a,(OFST+0,sp)
 840  01f8 cd02a3        	call	_is_button_down
 842  01fb 4d            	tnz	a
 843  01fc 271b          	jreq	L132
 844                     ; 131 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 846  01fe ae0004        	ldw	x,#_button_start_ms
 847  0201 cd0000        	call	c_lzmp
 849  0204 2608          	jrne	L332
 852  0206 adc3          	call	_millis
 854  0208 ae0004        	ldw	x,#_button_start_ms
 855  020b cd0000        	call	c_rtol
 857  020e               L332:
 858                     ; 132 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 860  020e a6ff          	ld	a,#255
 861  0210 cd054a        	call	_set_debug
 863                     ; 133 			is_any_down=1;
 865  0213 a601          	ld	a,#1
 866  0215 6b05          	ld	(OFST-3,sp),a
 869  0217 2022          	jra	L532
 870  0219               L132:
 871                     ; 135 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 873  0219 1e06          	ldw	x,(OFST-2,sp)
 874  021b a30201        	cpw	x,#513
 875  021e 250b          	jrult	L732
 878  0220 7b08          	ld	a,(OFST+0,sp)
 879  0222 5f            	clrw	x
 880  0223 97            	ld	xl,a
 881  0224 58            	sllw	x
 882  0225 a601          	ld	a,#1
 883  0227 e701          	ld	(_button_pressed_event+1,x),a
 885  0229 2010          	jra	L532
 886  022b               L732:
 887                     ; 136 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 889  022b 1e06          	ldw	x,(OFST-2,sp)
 890  022d a30033        	cpw	x,#51
 891  0230 2509          	jrult	L532
 894  0232 7b08          	ld	a,(OFST+0,sp)
 895  0234 5f            	clrw	x
 896  0235 97            	ld	xl,a
 897  0236 58            	sllw	x
 898  0237 a601          	ld	a,#1
 899  0239 e700          	ld	(_button_pressed_event,x),a
 900  023b               L532:
 901                     ; 127 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 903  023b 0c08          	inc	(OFST+0,sp)
 907  023d 7b08          	ld	a,(OFST+0,sp)
 908  023f a102          	cp	a,#2
 909  0241 25b3          	jrult	L322
 910                     ; 140 	if(!is_any_down) button_start_ms=0;
 912  0243 0d05          	tnz	(OFST-3,sp)
 913  0245 260a          	jrne	L542
 916  0247 ae0000        	ldw	x,#0
 917  024a bf06          	ldw	_button_start_ms+2,x
 918  024c ae0000        	ldw	x,#0
 919  024f bf04          	ldw	_button_start_ms,x
 920  0251               L542:
 921                     ; 141 }
 924  0251 5b08          	addw	sp,#8
 925  0253 81            	ret
 971                     ; 144 bool get_button_event(u8 button_index,bool is_long)
 971                     ; 145 { return button_pressed_event[button_index][is_long]; }
 972                     	switch	.text
 973  0254               _get_button_event:
 975  0254 89            	pushw	x
 976       00000000      OFST:	set	0
 981  0255 9e            	ld	a,xh
 982  0256 5f            	clrw	x
 983  0257 97            	ld	xl,a
 984  0258 58            	sllw	x
 985  0259 01            	rrwa	x,a
 986  025a 1b02          	add	a,(OFST+2,sp)
 987  025c 2401          	jrnc	L66
 988  025e 5c            	incw	x
 989  025f               L66:
 990  025f 02            	rlwa	x,a
 991  0260 e600          	ld	a,(_button_pressed_event,x)
 994  0262 85            	popw	x
 995  0263 81            	ret
1051                     ; 148 bool clear_button_event(u8 button_index,bool is_long)
1051                     ; 149 {
1052                     	switch	.text
1053  0264               _clear_button_event:
1055  0264 89            	pushw	x
1056  0265 88            	push	a
1057       00000001      OFST:	set	1
1060                     ; 150 	bool out=button_pressed_event[button_index][is_long];
1062  0266 9e            	ld	a,xh
1063  0267 5f            	clrw	x
1064  0268 97            	ld	xl,a
1065  0269 58            	sllw	x
1066  026a 01            	rrwa	x,a
1067  026b 1b03          	add	a,(OFST+2,sp)
1068  026d 2401          	jrnc	L27
1069  026f 5c            	incw	x
1070  0270               L27:
1071  0270 02            	rlwa	x,a
1072  0271 e600          	ld	a,(_button_pressed_event,x)
1073  0273 6b01          	ld	(OFST+0,sp),a
1075                     ; 151 	button_pressed_event[button_index][is_long]=0;
1077  0275 7b02          	ld	a,(OFST+1,sp)
1078  0277 5f            	clrw	x
1079  0278 97            	ld	xl,a
1080  0279 58            	sllw	x
1081  027a 01            	rrwa	x,a
1082  027b 1b03          	add	a,(OFST+2,sp)
1083  027d 2401          	jrnc	L47
1084  027f 5c            	incw	x
1085  0280               L47:
1086  0280 02            	rlwa	x,a
1087  0281 6f00          	clr	(_button_pressed_event,x)
1088                     ; 152 	return out;
1090  0283 7b01          	ld	a,(OFST+0,sp)
1093  0285 5b03          	addw	sp,#3
1094  0287 81            	ret
1130                     ; 155 void clear_button_events()
1130                     ; 156 {
1131                     	switch	.text
1132  0288               _clear_button_events:
1134  0288 88            	push	a
1135       00000001      OFST:	set	1
1138                     ; 158 	for(iter=0;iter<BUTTON_COUNT;iter++)
1140  0289 0f01          	clr	(OFST+0,sp)
1142  028b               L533:
1143                     ; 160 		clear_button_event(iter,0);
1145  028b 7b01          	ld	a,(OFST+0,sp)
1146  028d 5f            	clrw	x
1147  028e 95            	ld	xh,a
1148  028f add3          	call	_clear_button_event
1150                     ; 161 		clear_button_event(iter,1);
1152  0291 7b01          	ld	a,(OFST+0,sp)
1153  0293 ae0001        	ldw	x,#1
1154  0296 95            	ld	xh,a
1155  0297 adcb          	call	_clear_button_event
1157                     ; 158 	for(iter=0;iter<BUTTON_COUNT;iter++)
1159  0299 0c01          	inc	(OFST+0,sp)
1163  029b 7b01          	ld	a,(OFST+0,sp)
1164  029d a102          	cp	a,#2
1165  029f 25ea          	jrult	L533
1166                     ; 163 }
1169  02a1 84            	pop	a
1170  02a2 81            	ret
1206                     ; 166 bool is_button_down(u8 index)
1206                     ; 167 {
1207                     	switch	.text
1208  02a3               _is_button_down:
1212                     ; 168 	switch(index)
1215                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1217  02a3 4d            	tnz	a
1218  02a4 2708          	jreq	L343
1219  02a6 4a            	dec	a
1220  02a7 2718          	jreq	L543
1221  02a9 4a            	dec	a
1222  02aa 2728          	jreq	L743
1223  02ac 2039          	jra	L173
1224  02ae               L343:
1225                     ; 170 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1227  02ae 4b20          	push	#32
1228  02b0 ae500f        	ldw	x,#20495
1229  02b3 cd0000        	call	_GPIO_ReadInputPin
1231  02b6 5b01          	addw	sp,#1
1232  02b8 4d            	tnz	a
1233  02b9 2604          	jrne	L201
1234  02bb a601          	ld	a,#1
1235  02bd 2001          	jra	L401
1236  02bf               L201:
1237  02bf 4f            	clr	a
1238  02c0               L401:
1241  02c0 81            	ret
1242  02c1               L543:
1243                     ; 171 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1246  02c1 4b40          	push	#64
1247  02c3 ae500f        	ldw	x,#20495
1248  02c6 cd0000        	call	_GPIO_ReadInputPin
1250  02c9 5b01          	addw	sp,#1
1251  02cb 4d            	tnz	a
1252  02cc 2604          	jrne	L601
1253  02ce a601          	ld	a,#1
1254  02d0 2001          	jra	L011
1255  02d2               L601:
1256  02d2 4f            	clr	a
1257  02d3               L011:
1260  02d3 81            	ret
1261  02d4               L743:
1262                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1265  02d4 4b02          	push	#2
1266  02d6 ae500f        	ldw	x,#20495
1267  02d9 cd0000        	call	_GPIO_ReadInputPin
1269  02dc 5b01          	addw	sp,#1
1270  02de 4d            	tnz	a
1271  02df 2604          	jrne	L211
1272  02e1 a601          	ld	a,#1
1273  02e3 2001          	jra	L411
1274  02e5               L211:
1275  02e5 4f            	clr	a
1276  02e6               L411:
1279  02e6 81            	ret
1280  02e7               L173:
1281                     ; 174 	return 0;
1283  02e7 4f            	clr	a
1286  02e8 81            	ret
1346                     ; 178 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1348                     	switch	.text
1349  02e9               f_TIM2_UPD_OVF_IRQHandler:
1351  02e9 8a            	push	cc
1352  02ea 84            	pop	a
1353  02eb a4bf          	and	a,#191
1354  02ed 88            	push	a
1355  02ee 86            	pop	cc
1356       00000004      OFST:	set	4
1357  02ef 3b0002        	push	c_x+2
1358  02f2 be00          	ldw	x,c_x
1359  02f4 89            	pushw	x
1360  02f5 3b0002        	push	c_y+2
1361  02f8 be00          	ldw	x,c_y
1362  02fa 89            	pushw	x
1363  02fb be02          	ldw	x,c_lreg+2
1364  02fd 89            	pushw	x
1365  02fe be00          	ldw	x,c_lreg
1366  0300 89            	pushw	x
1367  0301 5204          	subw	sp,#4
1370                     ; 179 	u16 this_sleep=temp_delete_me;
1372  0303 be08          	ldw	x,_temp_delete_me
1373  0305 1f03          	ldw	(OFST-1,sp),x
1375                     ; 180 	bool is_debug_led=0;
1377  0307 0f01          	clr	(OFST-3,sp)
1379                     ; 181 	bool is_other_led=0;
1381  0309 0f02          	clr	(OFST-2,sp)
1383                     ; 183 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1385  030b c6500d        	ld	a,20493
1386  030e a407          	and	a,#7
1387  0310 c7500d        	ld	20493,a
1388                     ; 184 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1390  0313 72155012      	bres	20498,#2
1391                     ; 185 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1393  0317 72175003      	bres	20483,#3
1394                     ; 186   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1396  031b 72115300      	bres	21248,#0
1397                     ; 187 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1399  031f 72115304      	bres	21252,#0
1400                     ; 188 	pwm_visible_index++;
1402  0323 3c06          	inc	_pwm_visible_index
1403                     ; 189 	if(pwm_visible_index>6) pwm_visible_index=0;
1405  0325 b606          	ld	a,_pwm_visible_index
1406  0327 a107          	cp	a,#7
1407  0329 2502          	jrult	L124
1410  032b 3f06          	clr	_pwm_visible_index
1411  032d               L124:
1412                     ; 191 	if(pwm_visible_index==0)//simulate other LEDs ON
1414  032d 3d06          	tnz	_pwm_visible_index
1415  032f 260d          	jrne	L324
1416                     ; 193 		is_debug_led=this_sleep>0;
1418  0331 1e03          	ldw	x,(OFST-1,sp)
1419  0333 2704          	jreq	L021
1420  0335 a601          	ld	a,#1
1421  0337 2001          	jra	L221
1422  0339               L021:
1423  0339 4f            	clr	a
1424  033a               L221:
1425  033a 6b01          	ld	(OFST-3,sp),a
1428  033c 201c          	jra	L524
1429  033e               L324:
1430                     ; 194 	}else if(pwm_visible_index==1){
1432  033e b606          	ld	a,_pwm_visible_index
1433  0340 a101          	cp	a,#1
1434  0342 2611          	jrne	L724
1435                     ; 195 		this_sleep=temp3_delete_me;
1437  0344 be0a          	ldw	x,_temp3_delete_me
1438  0346 1f03          	ldw	(OFST-1,sp),x
1440                     ; 196 		is_other_led=this_sleep>0;
1442  0348 1e03          	ldw	x,(OFST-1,sp)
1443  034a 2704          	jreq	L421
1444  034c a601          	ld	a,#1
1445  034e 2001          	jra	L621
1446  0350               L421:
1447  0350 4f            	clr	a
1448  0351               L621:
1449  0351 6b02          	ld	(OFST-2,sp),a
1452  0353 2005          	jra	L524
1453  0355               L724:
1454                     ; 198 		this_sleep=0x400;
1456  0355 ae0400        	ldw	x,#1024
1457  0358 1f03          	ldw	(OFST-1,sp),x
1459  035a               L524:
1460                     ; 200 	if(this_sleep<1) this_sleep=1;
1462  035a 1e03          	ldw	x,(OFST-1,sp)
1463  035c 2605          	jrne	L334
1466  035e ae0001        	ldw	x,#1
1467  0361 1f03          	ldw	(OFST-1,sp),x
1469  0363               L334:
1470                     ; 203   TIM2->CNTRH = 0;// Set the high byte of the counter
1472  0363 725f530c      	clr	21260
1473                     ; 204   TIM2->CNTRL = 0;// Set the low byte of the counter
1475  0367 725f530d      	clr	21261
1476                     ; 205 	TIM2->ARRH= this_sleep>>8;// init auto reload register
1478  036b 7b03          	ld	a,(OFST-1,sp)
1479  036d c7530f        	ld	21263,a
1480                     ; 206 	TIM2->ARRL= this_sleep&0x00FF;// init auto reload register
1482  0370 7b04          	ld	a,(OFST+0,sp)
1483  0372 a4ff          	and	a,#255
1484  0374 c75310        	ld	21264,a
1485                     ; 207 	api_counter+=this_sleep;
1487  0377 1e03          	ldw	x,(OFST-1,sp)
1488  0379 cd0000        	call	c_uitolx
1490  037c ae0000        	ldw	x,#_api_counter
1491  037f cd0000        	call	c_lgadd
1493                     ; 209 	if(is_debug_led)
1495  0382 0d01          	tnz	(OFST-3,sp)
1496  0384 2704          	jreq	L534
1497                     ; 211 		set_led(DEBUG_LED);
1499  0386 a612          	ld	a,#18
1500  0388 ad21          	call	_set_led
1502  038a               L534:
1503                     ; 212 	if(is_other_led)
1505  038a 0d02          	tnz	(OFST-2,sp)
1506  038c 2704          	jreq	L734
1507                     ; 214 		set_led(1);
1509  038e a601          	ld	a,#1
1510  0390 ad19          	call	_set_led
1512  0392               L734:
1513                     ; 218   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1515  0392 72105300      	bset	21248,#0
1516                     ; 219 }
1519  0396 5b04          	addw	sp,#4
1520  0398 85            	popw	x
1521  0399 bf00          	ldw	c_lreg,x
1522  039b 85            	popw	x
1523  039c bf02          	ldw	c_lreg+2,x
1524  039e 85            	popw	x
1525  039f bf00          	ldw	c_y,x
1526  03a1 320002        	pop	c_y+2
1527  03a4 85            	popw	x
1528  03a5 bf00          	ldw	c_x,x
1529  03a7 320002        	pop	c_x+2
1530  03aa 80            	iret
1532                     	switch	.const
1533  0011               L144_led_lookup:
1534  0011 00            	dc.b	0
1535  0012 03            	dc.b	3
1536  0013 01            	dc.b	1
1537  0014 03            	dc.b	3
1538  0015 02            	dc.b	2
1539  0016 03            	dc.b	3
1540  0017 03            	dc.b	3
1541  0018 00            	dc.b	0
1542  0019 04            	dc.b	4
1543  001a 00            	dc.b	0
1544  001b 05            	dc.b	5
1545  001c 00            	dc.b	0
1546  001d 00            	dc.b	0
1547  001e 04            	dc.b	4
1548  001f 01            	dc.b	1
1549  0020 04            	dc.b	4
1550  0021 02            	dc.b	2
1551  0022 04            	dc.b	4
1552  0023 03            	dc.b	3
1553  0024 01            	dc.b	1
1554  0025 04            	dc.b	4
1555  0026 01            	dc.b	1
1556  0027 05            	dc.b	5
1557  0028 01            	dc.b	1
1558  0029 00            	dc.b	0
1559  002a 05            	dc.b	5
1560  002b 01            	dc.b	1
1561  002c 05            	dc.b	5
1562  002d 02            	dc.b	2
1563  002e 05            	dc.b	5
1564  002f 03            	dc.b	3
1565  0030 02            	dc.b	2
1566  0031 04            	dc.b	4
1567  0032 02            	dc.b	2
1568  0033 05            	dc.b	5
1569  0034 02            	dc.b	2
1570  0035 06            	dc.b	6
1571  0036 06            	dc.b	6
1572  0037 01            	dc.b	1
1573  0038 00            	dc.b	0
1574  0039 02            	dc.b	2
1575  003a 00            	dc.b	0
1576  003b 00            	dc.b	0
1577  003c 01            	dc.b	1
1578  003d 02            	dc.b	2
1579  003e 01            	dc.b	1
1580  003f 00            	dc.b	0
1581  0040 02            	dc.b	2
1582  0041 01            	dc.b	1
1583  0042 02            	dc.b	2
1584  0043 04            	dc.b	4
1585  0044 03            	dc.b	3
1586  0045 05            	dc.b	5
1587  0046 03            	dc.b	3
1588  0047 03            	dc.b	3
1589  0048 04            	dc.b	4
1590  0049 05            	dc.b	5
1591  004a 04            	dc.b	4
1592  004b 03            	dc.b	3
1593  004c 05            	dc.b	5
1594  004d 04            	dc.b	4
1595  004e 05            	dc.b	5
1639                     ; 222 void set_led(u8 led_index)
1639                     ; 223 {
1641                     	switch	.text
1642  03ab               _set_led:
1644  03ab 88            	push	a
1645  03ac 5240          	subw	sp,#64
1646       00000040      OFST:	set	64
1649                     ; 224 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1649                     ; 225 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1649                     ; 226 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1649                     ; 227 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1649                     ; 228 		{6,6},//debug; GND is tied low, no charlieplexing involved
1649                     ; 229 		{1,0},//LED7
1649                     ; 230 		{2,0},//LED8
1649                     ; 231 		{0,1},//LED9
1649                     ; 232 		{2,1},//LED10
1649                     ; 233 		{0,2},//LED11
1649                     ; 234 		{1,2},//LED12
1649                     ; 235 		{4,3},//LED13
1649                     ; 236 		{5,3},//LED14
1649                     ; 237 		{3,4},//LED15
1649                     ; 238 		{5,4},//LED16
1649                     ; 239 		{3,5},//LED17
1649                     ; 240 		{4,5} //LED18
1649                     ; 241 	};
1651  03ae 96            	ldw	x,sp
1652  03af 1c0003        	addw	x,#OFST-61
1653  03b2 90ae0011      	ldw	y,#L144_led_lookup
1654  03b6 a63e          	ld	a,#62
1655  03b8 cd0000        	call	c_xymov
1657                     ; 242 	set_mat(led_lookup[led_index][0],1);
1659  03bb 96            	ldw	x,sp
1660  03bc 1c0003        	addw	x,#OFST-61
1661  03bf 1f01          	ldw	(OFST-63,sp),x
1663  03c1 7b41          	ld	a,(OFST+1,sp)
1664  03c3 5f            	clrw	x
1665  03c4 97            	ld	xl,a
1666  03c5 58            	sllw	x
1667  03c6 72fb01        	addw	x,(OFST-63,sp)
1668  03c9 f6            	ld	a,(x)
1669  03ca ae0001        	ldw	x,#1
1670  03cd 95            	ld	xh,a
1671  03ce ad1c          	call	_set_mat
1673                     ; 243 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1675  03d0 7b41          	ld	a,(OFST+1,sp)
1676  03d2 a112          	cp	a,#18
1677  03d4 2713          	jreq	L564
1680  03d6 96            	ldw	x,sp
1681  03d7 1c0004        	addw	x,#OFST-60
1682  03da 1f01          	ldw	(OFST-63,sp),x
1684  03dc 7b41          	ld	a,(OFST+1,sp)
1685  03de 5f            	clrw	x
1686  03df 97            	ld	xl,a
1687  03e0 58            	sllw	x
1688  03e1 72fb01        	addw	x,(OFST-63,sp)
1689  03e4 f6            	ld	a,(x)
1690  03e5 5f            	clrw	x
1691  03e6 95            	ld	xh,a
1692  03e7 ad03          	call	_set_mat
1694  03e9               L564:
1695                     ; 244 }
1698  03e9 5b41          	addw	sp,#65
1699  03eb 81            	ret
1900                     ; 247 void set_mat(u8 mat_index,bool is_high)
1900                     ; 248 {
1901                     	switch	.text
1902  03ec               _set_mat:
1904  03ec 89            	pushw	x
1905  03ed 5203          	subw	sp,#3
1906       00000003      OFST:	set	3
1909                     ; 251 	if(mat_index==0)
1911  03ef 9e            	ld	a,xh
1912  03f0 4d            	tnz	a
1913  03f1 2609          	jrne	L506
1914                     ; 253 		GPIOx=GPIOC;
1916  03f3 ae500a        	ldw	x,#20490
1917  03f6 1f01          	ldw	(OFST-2,sp),x
1919                     ; 254 		GPIO_Pin=GPIO_PIN_3;
1921  03f8 a608          	ld	a,#8
1922  03fa 6b03          	ld	(OFST+0,sp),a
1924  03fc               L506:
1925                     ; 256 	if(mat_index==1)
1927  03fc 7b04          	ld	a,(OFST+1,sp)
1928  03fe a101          	cp	a,#1
1929  0400 2609          	jrne	L706
1930                     ; 258 		GPIOx=GPIOC;
1932  0402 ae500a        	ldw	x,#20490
1933  0405 1f01          	ldw	(OFST-2,sp),x
1935                     ; 259 		GPIO_Pin=GPIO_PIN_4;
1937  0407 a610          	ld	a,#16
1938  0409 6b03          	ld	(OFST+0,sp),a
1940  040b               L706:
1941                     ; 261 	if(mat_index==2)
1943  040b 7b04          	ld	a,(OFST+1,sp)
1944  040d a102          	cp	a,#2
1945  040f 2609          	jrne	L116
1946                     ; 263 		GPIOx=GPIOC;
1948  0411 ae500a        	ldw	x,#20490
1949  0414 1f01          	ldw	(OFST-2,sp),x
1951                     ; 264 		GPIO_Pin=GPIO_PIN_5;
1953  0416 a620          	ld	a,#32
1954  0418 6b03          	ld	(OFST+0,sp),a
1956  041a               L116:
1957                     ; 266 	if(mat_index==3)
1959  041a 7b04          	ld	a,(OFST+1,sp)
1960  041c a103          	cp	a,#3
1961  041e 2609          	jrne	L316
1962                     ; 268 		GPIOx=GPIOC;
1964  0420 ae500a        	ldw	x,#20490
1965  0423 1f01          	ldw	(OFST-2,sp),x
1967                     ; 269 		GPIO_Pin=GPIO_PIN_6;
1969  0425 a640          	ld	a,#64
1970  0427 6b03          	ld	(OFST+0,sp),a
1972  0429               L316:
1973                     ; 271 	if(mat_index==4)
1975  0429 7b04          	ld	a,(OFST+1,sp)
1976  042b a104          	cp	a,#4
1977  042d 2609          	jrne	L516
1978                     ; 273 		GPIOx=GPIOC;
1980  042f ae500a        	ldw	x,#20490
1981  0432 1f01          	ldw	(OFST-2,sp),x
1983                     ; 274 		GPIO_Pin=GPIO_PIN_7;
1985  0434 a680          	ld	a,#128
1986  0436 6b03          	ld	(OFST+0,sp),a
1988  0438               L516:
1989                     ; 276 	if(mat_index==5)
1991  0438 7b04          	ld	a,(OFST+1,sp)
1992  043a a105          	cp	a,#5
1993  043c 2609          	jrne	L716
1994                     ; 278 		GPIOx=GPIOD;
1996  043e ae500f        	ldw	x,#20495
1997  0441 1f01          	ldw	(OFST-2,sp),x
1999                     ; 279 		GPIO_Pin=GPIO_PIN_2;
2001  0443 a604          	ld	a,#4
2002  0445 6b03          	ld	(OFST+0,sp),a
2004  0447               L716:
2005                     ; 281 	if(mat_index==6)
2007  0447 7b04          	ld	a,(OFST+1,sp)
2008  0449 a106          	cp	a,#6
2009  044b 2609          	jrne	L126
2010                     ; 283 		GPIOx=GPIOA;
2012  044d ae5000        	ldw	x,#20480
2013  0450 1f01          	ldw	(OFST-2,sp),x
2015                     ; 284 		GPIO_Pin=GPIO_PIN_3;
2017  0452 a608          	ld	a,#8
2018  0454 6b03          	ld	(OFST+0,sp),a
2020  0456               L126:
2021                     ; 286 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2023  0456 0d05          	tnz	(OFST+2,sp)
2024  0458 2708          	jreq	L326
2027  045a 1e01          	ldw	x,(OFST-2,sp)
2028  045c f6            	ld	a,(x)
2029  045d 1a03          	or	a,(OFST+0,sp)
2030  045f f7            	ld	(x),a
2032  0460 2007          	jra	L526
2033  0462               L326:
2034                     ; 287 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2036  0462 1e01          	ldw	x,(OFST-2,sp)
2037  0464 7b03          	ld	a,(OFST+0,sp)
2038  0466 43            	cpl	a
2039  0467 f4            	and	a,(x)
2040  0468 f7            	ld	(x),a
2041  0469               L526:
2042                     ; 288 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2044  0469 1e01          	ldw	x,(OFST-2,sp)
2045  046b e602          	ld	a,(2,x)
2046  046d 1a03          	or	a,(OFST+0,sp)
2047  046f e702          	ld	(2,x),a
2048                     ; 289 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2050  0471 1e01          	ldw	x,(OFST-2,sp)
2051  0473 e603          	ld	a,(3,x)
2052  0475 1a03          	or	a,(OFST+0,sp)
2053  0477 e703          	ld	(3,x),a
2054                     ; 290 }
2057  0479 5b05          	addw	sp,#5
2058  047b 81            	ret
2092                     ; 299 void flush_leds(u8 led_count)
2092                     ; 300 {
2093                     	switch	.text
2094  047c               _flush_leds:
2098                     ; 324 }
2101  047c 81            	ret
2199                     ; 327 void set_hue_max(u8 index,u16 color)
2199                     ; 328 {
2200                     	switch	.text
2201  047d               _set_hue_max:
2203  047d 88            	push	a
2204  047e 5207          	subw	sp,#7
2205       00000007      OFST:	set	7
2208                     ; 329 	const u8 brightness=255;
2210  0480 a6ff          	ld	a,#255
2211  0482 6b07          	ld	(OFST+0,sp),a
2213                     ; 330 	u8 red=0,green=0,blue=0;
2215  0484 0f04          	clr	(OFST-3,sp)
2219  0486 0f05          	clr	(OFST-2,sp)
2223  0488 0f06          	clr	(OFST-1,sp)
2225                     ; 331 	u16 residual_16=color%(0x2AAB);
2227  048a 1e0b          	ldw	x,(OFST+4,sp)
2228  048c 90ae2aab      	ldw	y,#10923
2229  0490 65            	divw	x,y
2230  0491 51            	exgw	x,y
2231  0492 1f01          	ldw	(OFST-6,sp),x
2233                     ; 332 	u8 residual_8=(residual_16<<8)/0x2AAB;
2235  0494 1e01          	ldw	x,(OFST-6,sp)
2236  0496 4f            	clr	a
2237  0497 02            	rlwa	x,a
2238  0498 90ae2aab      	ldw	y,#10923
2239  049c 65            	divw	x,y
2240  049d 01            	rrwa	x,a
2241  049e 6b03          	ld	(OFST-4,sp),a
2242  04a0 02            	rlwa	x,a
2244                     ; 333 	switch(color/(0x2AAB))
2246  04a1 1e0b          	ldw	x,(OFST+4,sp)
2247  04a3 90ae2aab      	ldw	y,#10923
2248  04a7 65            	divw	x,y
2250                     ; 364 			break;
2251  04a8 5d            	tnzw	x
2252  04a9 2711          	jreq	L546
2253  04ab 5a            	decw	x
2254  04ac 271a          	jreq	L746
2255  04ae 5a            	decw	x
2256  04af 2725          	jreq	L156
2257  04b1 5a            	decw	x
2258  04b2 272e          	jreq	L356
2259  04b4 5a            	decw	x
2260  04b5 2739          	jreq	L556
2261  04b7 5a            	decw	x
2262  04b8 2742          	jreq	L756
2263  04ba 204c          	jra	L737
2264  04bc               L546:
2265                     ; 336 			red=brightness;
2267  04bc 7b07          	ld	a,(OFST+0,sp)
2268  04be 6b04          	ld	(OFST-3,sp),a
2270                     ; 337 			green=residual_8;
2272  04c0 7b03          	ld	a,(OFST-4,sp)
2273  04c2 6b05          	ld	(OFST-2,sp),a
2275                     ; 338 			blue=0;
2277  04c4 0f06          	clr	(OFST-1,sp)
2279                     ; 339 			break;
2281  04c6 2040          	jra	L737
2282  04c8               L746:
2283                     ; 341 			red=brightness-residual_8;
2285  04c8 7b07          	ld	a,(OFST+0,sp)
2286  04ca 1003          	sub	a,(OFST-4,sp)
2287  04cc 6b04          	ld	(OFST-3,sp),a
2289                     ; 342 			green=brightness;
2291  04ce 7b07          	ld	a,(OFST+0,sp)
2292  04d0 6b05          	ld	(OFST-2,sp),a
2294                     ; 343 			blue=0;
2296  04d2 0f06          	clr	(OFST-1,sp)
2298                     ; 344 			break;
2300  04d4 2032          	jra	L737
2301  04d6               L156:
2302                     ; 346 			red=0;
2304  04d6 0f04          	clr	(OFST-3,sp)
2306                     ; 347 			green=brightness;
2308  04d8 7b07          	ld	a,(OFST+0,sp)
2309  04da 6b05          	ld	(OFST-2,sp),a
2311                     ; 348 			blue=residual_8;
2313  04dc 7b03          	ld	a,(OFST-4,sp)
2314  04de 6b06          	ld	(OFST-1,sp),a
2316                     ; 349 			break;
2318  04e0 2026          	jra	L737
2319  04e2               L356:
2320                     ; 351 			red=0;
2322  04e2 0f04          	clr	(OFST-3,sp)
2324                     ; 352 			green=brightness-residual_8;
2326  04e4 7b07          	ld	a,(OFST+0,sp)
2327  04e6 1003          	sub	a,(OFST-4,sp)
2328  04e8 6b05          	ld	(OFST-2,sp),a
2330                     ; 353 			blue=brightness;
2332  04ea 7b07          	ld	a,(OFST+0,sp)
2333  04ec 6b06          	ld	(OFST-1,sp),a
2335                     ; 354 			break;
2337  04ee 2018          	jra	L737
2338  04f0               L556:
2339                     ; 356 			red=residual_8;
2341  04f0 7b03          	ld	a,(OFST-4,sp)
2342  04f2 6b04          	ld	(OFST-3,sp),a
2344                     ; 357 			green=0;
2346  04f4 0f05          	clr	(OFST-2,sp)
2348                     ; 358 			blue=brightness;
2350  04f6 7b07          	ld	a,(OFST+0,sp)
2351  04f8 6b06          	ld	(OFST-1,sp),a
2353                     ; 359 			break;
2355  04fa 200c          	jra	L737
2356  04fc               L756:
2357                     ; 361 			red=brightness;
2359  04fc 7b07          	ld	a,(OFST+0,sp)
2360  04fe 6b04          	ld	(OFST-3,sp),a
2362                     ; 362 			green=0;
2364  0500 0f05          	clr	(OFST-2,sp)
2366                     ; 363 			blue=brightness-residual_8;
2368  0502 7b07          	ld	a,(OFST+0,sp)
2369  0504 1003          	sub	a,(OFST-4,sp)
2370  0506 6b06          	ld	(OFST-1,sp),a
2372                     ; 364 			break;
2374  0508               L737:
2375                     ; 367 	set_rgb(index,0,red);
2377  0508 7b04          	ld	a,(OFST-3,sp)
2378  050a 88            	push	a
2379  050b 7b09          	ld	a,(OFST+2,sp)
2380  050d 5f            	clrw	x
2381  050e 95            	ld	xh,a
2382  050f ad1c          	call	_set_rgb
2384  0511 84            	pop	a
2385                     ; 368 	set_rgb(index,1,green);
2387  0512 7b05          	ld	a,(OFST-2,sp)
2388  0514 88            	push	a
2389  0515 7b09          	ld	a,(OFST+2,sp)
2390  0517 ae0001        	ldw	x,#1
2391  051a 95            	ld	xh,a
2392  051b ad10          	call	_set_rgb
2394  051d 84            	pop	a
2395                     ; 369 	set_rgb(index,2,blue);
2397  051e 7b06          	ld	a,(OFST-1,sp)
2398  0520 88            	push	a
2399  0521 7b09          	ld	a,(OFST+2,sp)
2400  0523 ae0002        	ldw	x,#2
2401  0526 95            	ld	xh,a
2402  0527 ad04          	call	_set_rgb
2404  0529 84            	pop	a
2405                     ; 370 }
2408  052a 5b08          	addw	sp,#8
2409  052c 81            	ret
2462                     ; 372 void set_rgb(u8 index,u8 color,u8 brightness)
2462                     ; 373 {
2463                     	switch	.text
2464  052d               _set_rgb:
2466  052d 89            	pushw	x
2467       00000000      OFST:	set	0
2470                     ; 374 	pwm_brightness_buffer[index*3+color]=brightness;
2472  052e 9e            	ld	a,xh
2473  052f 97            	ld	xl,a
2474  0530 a603          	ld	a,#3
2475  0532 42            	mul	x,a
2476  0533 01            	rrwa	x,a
2477  0534 1b02          	add	a,(OFST+2,sp)
2478  0536 2401          	jrnc	L441
2479  0538 5c            	incw	x
2480  0539               L441:
2481  0539 02            	rlwa	x,a
2482  053a 7b05          	ld	a,(OFST+5,sp)
2483  053c e70e          	ld	(_pwm_brightness_buffer,x),a
2484                     ; 375 }
2487  053e 85            	popw	x
2488  053f 81            	ret
2532                     ; 377 void set_white(u8 index,u8 brightness)
2532                     ; 378 {
2533                     	switch	.text
2534  0540               _set_white:
2536  0540 89            	pushw	x
2537       00000000      OFST:	set	0
2540                     ; 379 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2542  0541 9e            	ld	a,xh
2543  0542 5f            	clrw	x
2544  0543 97            	ld	xl,a
2545  0544 7b02          	ld	a,(OFST+2,sp)
2546  0546 e721          	ld	(_pwm_brightness_buffer+19,x),a
2547                     ; 380 }
2550  0548 85            	popw	x
2551  0549 81            	ret
2586                     ; 383 void set_debug(u8 brightness)
2586                     ; 384 {
2587                     	switch	.text
2588  054a               _set_debug:
2592                     ; 385 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2594  054a b720          	ld	_pwm_brightness_buffer+18,a
2595                     ; 386 }
2598  054c 81            	ret
2621                     ; 388 void set_matrix_high_z()
2621                     ; 389 {
2622                     	switch	.text
2623  054d               _set_matrix_high_z:
2627                     ; 390 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2629  054d c6500d        	ld	a,20493
2630  0550 a407          	and	a,#7
2631  0552 c7500d        	ld	20493,a
2632                     ; 391 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2634  0555 72155012      	bres	20498,#2
2635                     ; 392 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2637  0559 72175003      	bres	20483,#3
2638                     ; 393 }
2641  055d 81            	ret
2675                     ; 395 u8 get_eeprom_byte(u16 eeprom_address)
2675                     ; 396 {
2676                     	switch	.text
2677  055e               _get_eeprom_byte:
2681                     ; 397 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2683  055e d64000        	ld	a,(16384,x)
2686  0561 81            	ret
2842                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2843                     	xdef	_temp3_delete_me
2844                     	xdef	_temp_delete_me
2845                     	switch	.ubsct
2846  0000               _button_pressed_event:
2847  0000 00000000      	ds.b	4
2848                     	xdef	_button_pressed_event
2849  0004               _button_start_ms:
2850  0004 00000000      	ds.b	4
2851                     	xdef	_button_start_ms
2852                     	xdef	_pwm_state
2853                     	xdef	_pwm_visible_index
2854                     	xdef	_pwm_sleep_remaining
2855  0008               _pwm_led_count:
2856  0008 0000          	ds.b	2
2857                     	xdef	_pwm_led_count
2858  000a               _pwm_sleep:
2859  000a 00000000      	ds.b	4
2860                     	xdef	_pwm_sleep
2861  000e               _pwm_brightness_buffer:
2862  000e 000000000000  	ds.b	31
2863                     	xdef	_pwm_brightness_buffer
2864  002d               _pwm_brightness_index:
2865  002d 000000000000  	ds.b	62
2866                     	xdef	_pwm_brightness_index
2867  006b               _pwm_brightness:
2868  006b 000000000000  	ds.b	124
2869                     	xdef	_pwm_brightness
2870                     	xdef	_PWM_MAX_PERIOD
2871                     	xdef	_api_counter
2872                     	xref	_UART1_Cmd
2873                     	xref	_UART1_Init
2874                     	xref	_UART1_DeInit
2875                     	xref	_GPIO_ReadInputPin
2876                     	xref	_GPIO_Init
2877                     	xdef	_set_led
2878                     	xdef	_set_mat
2879                     	xdef	_get_eeprom_byte
2880                     	xdef	_get_random
2881                     	xdef	_is_button_down
2882                     	xdef	_clear_button_events
2883                     	xdef	_clear_button_event
2884                     	xdef	_get_button_event
2885                     	xdef	_update_buttons
2886                     	xdef	_is_developer_valid
2887                     	xdef	_set_hue_max
2888                     	xdef	_flush_leds
2889                     	xdef	_set_debug
2890                     	xdef	_set_white
2891                     	xdef	_set_rgb
2892                     	xdef	_set_matrix_high_z
2893                     	xdef	_millis
2894                     	xdef	_setup_main
2895                     	xdef	_is_application_valid
2896                     	xdef	_setup_serial
2897                     	xdef	_hello_world
2898                     	xref.b	c_lreg
2899                     	xref.b	c_x
2900                     	xref.b	c_y
2920                     	xref	c_xymov
2921                     	xref	c_lgadd
2922                     	xref	c_lzmp
2923                     	xref	c_lsub
2924                     	xref	c_rtol
2925                     	xref	c_uitolx
2926                     	xref	c_lursh
2927                     	xref	c_itolx
2928                     	xref	c_imul
2929                     	xref	c_ldiv
2930                     	xref	c_lrzmp
2931                     	xref	c_lmod
2932                     	xref	c_ltor
2933                     	xref	c_lgadc
2934                     	end
