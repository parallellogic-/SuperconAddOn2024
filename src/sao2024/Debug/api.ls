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
  23  0006               _pwm_led_index:
  24  0006 00            	dc.b	0
  25  0007               _pwm_state:
  26  0007 00            	dc.b	0
  27  0008               _temp_delete_me:
  28  0008 00            	dc.b	0
 108                     	switch	.const
 109  0001               L01:
 110  0001 00010000      	dc.l	65536
 111  0005               L21:
 112  0005 00000002      	dc.l	2
 113  0009               L41:
 114  0009 00000100      	dc.l	256
 115                     ; 32 void hello_world()
 115                     ; 33 {//basic program that blinks the debug LED ON/OFF
 116                     	scross	off
 117                     	switch	.text
 118  0000               _hello_world:
 120  0000 5207          	subw	sp,#7
 121       00000007      OFST:	set	7
 124                     ; 35 	bool is_high=0;
 126                     ; 36 	long frame=0;
 128  0002 ae0000        	ldw	x,#0
 129  0005 1f04          	ldw	(OFST-3,sp),x
 130  0007 ae0000        	ldw	x,#0
 131  000a 1f02          	ldw	(OFST-5,sp),x
 133  000c               L74:
 134                     ; 40 		frame++;
 136  000c 96            	ldw	x,sp
 137  000d 1c0002        	addw	x,#OFST-5
 138  0010 a601          	ld	a,#1
 139  0012 cd0000        	call	c_lgadc
 142                     ; 42 		temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
 144  0015 96            	ldw	x,sp
 145  0016 1c0002        	addw	x,#OFST-5
 146  0019 cd0000        	call	c_ltor
 148  001c ae0001        	ldw	x,#L01
 149  001f cd0000        	call	c_ldiv
 151  0022 ae0005        	ldw	x,#L21
 152  0025 cd0000        	call	c_lmod
 154  0028 cd0000        	call	c_lrzmp
 156  002b 2717          	jreq	L6
 157  002d 96            	ldw	x,sp
 158  002e 1c0002        	addw	x,#OFST-5
 159  0031 cd0000        	call	c_ltor
 161  0034 ae0009        	ldw	x,#L41
 162  0037 cd0000        	call	c_ldiv
 164  003a 3303          	cpl	c_lreg+3
 165  003c 3302          	cpl	c_lreg+2
 166  003e 3301          	cpl	c_lreg+1
 167  0040 3300          	cpl	c_lreg
 168  0042 200d          	jra	L61
 169  0044               L6:
 170  0044 96            	ldw	x,sp
 171  0045 1c0002        	addw	x,#OFST-5
 172  0048 cd0000        	call	c_ltor
 174  004b ae0009        	ldw	x,#L41
 175  004e cd0000        	call	c_ldiv
 177  0051               L61:
 178  0051 3f02          	clr	c_lreg+2
 179  0053 3f01          	clr	c_lreg+1
 180  0055 3f00          	clr	c_lreg
 181  0057 be02          	ldw	x,c_lreg+2
 182  0059 1f06          	ldw	(OFST-1,sp),x
 184                     ; 43 		temp2_delete_me=temp2_delete_me*temp2_delete_me;
 186  005b 1e06          	ldw	x,(OFST-1,sp)
 187  005d 1606          	ldw	y,(OFST-1,sp)
 188  005f cd0000        	call	c_imul
 190  0062 1f06          	ldw	(OFST-1,sp),x
 192                     ; 44 		temp2_delete_me=temp2_delete_me/256;
 194  0064 1e06          	ldw	x,(OFST-1,sp)
 195  0066 4f            	clr	a
 196  0067 01            	rrwa	x,a
 197  0068 1f06          	ldw	(OFST-1,sp),x
 199                     ; 45 		temp_delete_me=temp2_delete_me;
 201  006a 7b07          	ld	a,(OFST+0,sp)
 202  006c b708          	ld	_temp_delete_me,a
 204  006e 209c          	jra	L74
 256                     ; 50 u16 get_random(u16 x)
 256                     ; 51 {
 257                     	switch	.text
 258  0070               _get_random:
 260  0070 5204          	subw	sp,#4
 261       00000004      OFST:	set	4
 264                     ; 52 	u16 a=1664525;
 266                     ; 53 	u16 c=1013904223;
 268                     ; 54 	return a * x + c;
 270  0072 90ae660d      	ldw	y,#26125
 271  0076 cd0000        	call	c_imul
 273  0079 1cf35f        	addw	x,#62303
 276  007c 5b04          	addw	sp,#4
 277  007e 81            	ret
 326                     	switch	.const
 327  000d               L03:
 328  000d 000f4240      	dc.l	1000000
 329                     ; 57 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 329                     ; 58 {
 330                     	switch	.text
 331  007f               _setup_serial:
 333  007f 89            	pushw	x
 334       00000000      OFST:	set	0
 337                     ; 59 	if(is_enabled)
 339  0080 9e            	ld	a,xh
 340  0081 4d            	tnz	a
 341  0082 2747          	jreq	L321
 342                     ; 61 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 344  0084 4bf0          	push	#240
 345  0086 4b20          	push	#32
 346  0088 ae500f        	ldw	x,#20495
 347  008b cd0000        	call	_GPIO_Init
 349  008e 85            	popw	x
 350                     ; 62 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 352  008f 4b40          	push	#64
 353  0091 4b40          	push	#64
 354  0093 ae500f        	ldw	x,#20495
 355  0096 cd0000        	call	_GPIO_Init
 357  0099 85            	popw	x
 358                     ; 63 		UART1_DeInit();
 360  009a cd0000        	call	_UART1_DeInit
 362                     ; 64 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 364  009d 4b0c          	push	#12
 365  009f 4b80          	push	#128
 366  00a1 4b00          	push	#0
 367  00a3 4b00          	push	#0
 368  00a5 4b00          	push	#0
 369  00a7 0d07          	tnz	(OFST+7,sp)
 370  00a9 2708          	jreq	L42
 371  00ab ae2580        	ldw	x,#9600
 372  00ae cd0000        	call	c_itolx
 374  00b1 2006          	jra	L62
 375  00b3               L42:
 376  00b3 ae000d        	ldw	x,#L03
 377  00b6 cd0000        	call	c_ltor
 379  00b9               L62:
 380  00b9 be02          	ldw	x,c_lreg+2
 381  00bb 89            	pushw	x
 382  00bc be00          	ldw	x,c_lreg
 383  00be 89            	pushw	x
 384  00bf cd0000        	call	_UART1_Init
 386  00c2 5b09          	addw	sp,#9
 387                     ; 65 		UART1_Cmd(ENABLE);
 389  00c4 a601          	ld	a,#1
 390  00c6 cd0000        	call	_UART1_Cmd
 393  00c9 201d          	jra	L521
 394  00cb               L321:
 395                     ; 67 		UART1_Cmd(DISABLE);
 397  00cb 4f            	clr	a
 398  00cc cd0000        	call	_UART1_Cmd
 400                     ; 68 		UART1_DeInit();
 402  00cf cd0000        	call	_UART1_DeInit
 404                     ; 69 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 406  00d2 4b40          	push	#64
 407  00d4 4b20          	push	#32
 408  00d6 ae500f        	ldw	x,#20495
 409  00d9 cd0000        	call	_GPIO_Init
 411  00dc 85            	popw	x
 412                     ; 70 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 414  00dd 4b40          	push	#64
 415  00df 4b40          	push	#64
 416  00e1 ae500f        	ldw	x,#20495
 417  00e4 cd0000        	call	_GPIO_Init
 419  00e7 85            	popw	x
 420  00e8               L521:
 421                     ; 72 }
 424  00e8 85            	popw	x
 425  00e9 81            	ret
 452                     ; 75 bool is_application_valid()
 452                     ; 76 {
 453                     	switch	.text
 454  00ea               _is_application_valid:
 458                     ; 77 	return !is_button_down(2) && !get_button_event(0,1);
 460  00ea a602          	ld	a,#2
 461  00ec cd024d        	call	_is_button_down
 463  00ef 4d            	tnz	a
 464  00f0 260d          	jrne	L43
 465  00f2 ae0001        	ldw	x,#1
 466  00f5 cd01fe        	call	_get_button_event
 468  00f8 4d            	tnz	a
 469  00f9 2604          	jrne	L43
 470  00fb a601          	ld	a,#1
 471  00fd 2001          	jra	L63
 472  00ff               L43:
 473  00ff 4f            	clr	a
 474  0100               L63:
 477  0100 81            	ret
 503                     ; 81 bool is_developer_valid()
 503                     ; 82 {
 504                     	switch	.text
 505  0101               _is_developer_valid:
 509                     ; 83 	return is_button_down(2) && !get_button_event(0,1);
 511  0101 a602          	ld	a,#2
 512  0103 cd024d        	call	_is_button_down
 514  0106 4d            	tnz	a
 515  0107 270d          	jreq	L24
 516  0109 ae0001        	ldw	x,#1
 517  010c cd01fe        	call	_get_button_event
 519  010f 4d            	tnz	a
 520  0110 2604          	jrne	L24
 521  0112 a601          	ld	a,#1
 522  0114 2001          	jra	L44
 523  0116               L24:
 524  0116 4f            	clr	a
 525  0117               L44:
 528  0117 81            	ret
 553                     ; 87 bool is_sleep_valid()
 553                     ; 88 {
 554                     	switch	.text
 555  0118               _is_sleep_valid:
 559                     ; 89 	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
 561  0118 5f            	clrw	x
 562  0119 cd01fe        	call	_get_button_event
 564  011c 4d            	tnz	a
 565  011d 261f          	jrne	L05
 566  011f ae0100        	ldw	x,#256
 567  0122 cd01fe        	call	_get_button_event
 569  0125 4d            	tnz	a
 570  0126 2616          	jrne	L05
 571  0128 ae0001        	ldw	x,#1
 572  012b cd01fe        	call	_get_button_event
 574  012e 4d            	tnz	a
 575  012f 260d          	jrne	L05
 576  0131 ae0101        	ldw	x,#257
 577  0134 cd01fe        	call	_get_button_event
 579  0137 4d            	tnz	a
 580  0138 2604          	jrne	L05
 581  013a a601          	ld	a,#1
 582  013c 2001          	jra	L25
 583  013e               L05:
 584  013e 4f            	clr	a
 585  013f               L25:
 588  013f 81            	ret
 614                     ; 92 void setup_main()
 614                     ; 93 {
 615                     	switch	.text
 616  0140               _setup_main:
 620                     ; 94 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 622  0140 c650c6        	ld	a,20678
 623  0143 a4e7          	and	a,#231
 624  0145 c750c6        	ld	20678,a
 625                     ; 96 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 627  0148 4b40          	push	#64
 628  014a 4b02          	push	#2
 629  014c ae500f        	ldw	x,#20495
 630  014f cd0000        	call	_GPIO_Init
 632  0152 85            	popw	x
 633                     ; 99 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 635  0153 725f5311      	clr	21265
 636                     ; 100 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 638  0157 3505530e      	mov	21262,#5
 639                     ; 101 	TIM2->ARRH= 0;// init auto reload register
 641  015b 725f530f      	clr	21263
 642                     ; 102 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 644  015f 35ff5310      	mov	21264,#255
 645                     ; 103 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 647  0163 c65300        	ld	a,21248
 648  0166 aa85          	or	a,#133
 649  0168 c75300        	ld	21248,a
 650                     ; 104 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 652  016b 35035303      	mov	21251,#3
 653                     ; 105 	enableInterrupts();
 656  016f 9a            rim
 658                     ; 107 }
 662  0170 81            	ret
 686                     ; 109 u32 millis()
 686                     ; 110 {
 687                     	switch	.text
 688  0171               _millis:
 692                     ; 111 	return api_counter;
 694  0171 ae0000        	ldw	x,#_api_counter
 695  0174 cd0000        	call	c_ltor
 699  0177 81            	ret
 734                     ; 114 void set_millis(u32 new_time)
 734                     ; 115 {
 735                     	switch	.text
 736  0178               _set_millis:
 738       00000000      OFST:	set	0
 741                     ; 116 	api_counter=new_time;
 743  0178 1e05          	ldw	x,(OFST+5,sp)
 744  017a bf02          	ldw	_api_counter+2,x
 745  017c 1e03          	ldw	x,(OFST+3,sp)
 746  017e bf00          	ldw	_api_counter,x
 747                     ; 117 }
 750  0180 81            	ret
 808                     ; 122 void update_buttons()
 808                     ; 123 {
 809                     	switch	.text
 810  0181               _update_buttons:
 812  0181 5208          	subw	sp,#8
 813       00000008      OFST:	set	8
 816                     ; 124 	bool is_any_down=0;
 818  0183 0f05          	clr	(OFST-3,sp)
 820                     ; 126 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 822  0185 be06          	ldw	x,_button_start_ms+2
 823  0187 cd0000        	call	c_uitolx
 825  018a 96            	ldw	x,sp
 826  018b 1c0001        	addw	x,#OFST-7
 827  018e cd0000        	call	c_rtol
 830  0191 adde          	call	_millis
 832  0193 96            	ldw	x,sp
 833  0194 1c0001        	addw	x,#OFST-7
 834  0197 cd0000        	call	c_lsub
 836  019a be02          	ldw	x,c_lreg+2
 837  019c 1f06          	ldw	(OFST-2,sp),x
 839                     ; 127 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 841  019e 0f08          	clr	(OFST+0,sp)
 843  01a0               L342:
 844                     ; 129 		if(is_button_down(button_index))
 846  01a0 7b08          	ld	a,(OFST+0,sp)
 847  01a2 cd024d        	call	_is_button_down
 849  01a5 4d            	tnz	a
 850  01a6 271b          	jreq	L152
 851                     ; 131 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 853  01a8 ae0004        	ldw	x,#_button_start_ms
 854  01ab cd0000        	call	c_lzmp
 856  01ae 2608          	jrne	L352
 859  01b0 adbf          	call	_millis
 861  01b2 ae0004        	ldw	x,#_button_start_ms
 862  01b5 cd0000        	call	c_rtol
 864  01b8               L352:
 865                     ; 132 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 867  01b8 a6ff          	ld	a,#255
 868  01ba cd0482        	call	_set_debug
 870                     ; 133 			is_any_down=1;
 872  01bd a601          	ld	a,#1
 873  01bf 6b05          	ld	(OFST-3,sp),a
 876  01c1 2022          	jra	L552
 877  01c3               L152:
 878                     ; 135 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 880  01c3 1e06          	ldw	x,(OFST-2,sp)
 881  01c5 a30201        	cpw	x,#513
 882  01c8 250b          	jrult	L752
 885  01ca 7b08          	ld	a,(OFST+0,sp)
 886  01cc 5f            	clrw	x
 887  01cd 97            	ld	xl,a
 888  01ce 58            	sllw	x
 889  01cf a601          	ld	a,#1
 890  01d1 e701          	ld	(_button_pressed_event+1,x),a
 892  01d3 2010          	jra	L552
 893  01d5               L752:
 894                     ; 136 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 896  01d5 1e06          	ldw	x,(OFST-2,sp)
 897  01d7 a30033        	cpw	x,#51
 898  01da 2509          	jrult	L552
 901  01dc 7b08          	ld	a,(OFST+0,sp)
 902  01de 5f            	clrw	x
 903  01df 97            	ld	xl,a
 904  01e0 58            	sllw	x
 905  01e1 a601          	ld	a,#1
 906  01e3 e700          	ld	(_button_pressed_event,x),a
 907  01e5               L552:
 908                     ; 127 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 910  01e5 0c08          	inc	(OFST+0,sp)
 914  01e7 7b08          	ld	a,(OFST+0,sp)
 915  01e9 a102          	cp	a,#2
 916  01eb 25b3          	jrult	L342
 917                     ; 140 	if(!is_any_down) button_start_ms=0;
 919  01ed 0d05          	tnz	(OFST-3,sp)
 920  01ef 260a          	jrne	L562
 923  01f1 ae0000        	ldw	x,#0
 924  01f4 bf06          	ldw	_button_start_ms+2,x
 925  01f6 ae0000        	ldw	x,#0
 926  01f9 bf04          	ldw	_button_start_ms,x
 927  01fb               L562:
 928                     ; 141 }
 931  01fb 5b08          	addw	sp,#8
 932  01fd 81            	ret
 978                     ; 144 bool get_button_event(u8 button_index,bool is_long)
 978                     ; 145 { return button_pressed_event[button_index][is_long]; }
 979                     	switch	.text
 980  01fe               _get_button_event:
 982  01fe 89            	pushw	x
 983       00000000      OFST:	set	0
 988  01ff 9e            	ld	a,xh
 989  0200 5f            	clrw	x
 990  0201 97            	ld	xl,a
 991  0202 58            	sllw	x
 992  0203 01            	rrwa	x,a
 993  0204 1b02          	add	a,(OFST+2,sp)
 994  0206 2401          	jrnc	L66
 995  0208 5c            	incw	x
 996  0209               L66:
 997  0209 02            	rlwa	x,a
 998  020a e600          	ld	a,(_button_pressed_event,x)
1001  020c 85            	popw	x
1002  020d 81            	ret
1058                     ; 148 bool clear_button_event(u8 button_index,bool is_long)
1058                     ; 149 {
1059                     	switch	.text
1060  020e               _clear_button_event:
1062  020e 89            	pushw	x
1063  020f 88            	push	a
1064       00000001      OFST:	set	1
1067                     ; 150 	bool out=button_pressed_event[button_index][is_long];
1069  0210 9e            	ld	a,xh
1070  0211 5f            	clrw	x
1071  0212 97            	ld	xl,a
1072  0213 58            	sllw	x
1073  0214 01            	rrwa	x,a
1074  0215 1b03          	add	a,(OFST+2,sp)
1075  0217 2401          	jrnc	L27
1076  0219 5c            	incw	x
1077  021a               L27:
1078  021a 02            	rlwa	x,a
1079  021b e600          	ld	a,(_button_pressed_event,x)
1080  021d 6b01          	ld	(OFST+0,sp),a
1082                     ; 151 	button_pressed_event[button_index][is_long]=0;
1084  021f 7b02          	ld	a,(OFST+1,sp)
1085  0221 5f            	clrw	x
1086  0222 97            	ld	xl,a
1087  0223 58            	sllw	x
1088  0224 01            	rrwa	x,a
1089  0225 1b03          	add	a,(OFST+2,sp)
1090  0227 2401          	jrnc	L47
1091  0229 5c            	incw	x
1092  022a               L47:
1093  022a 02            	rlwa	x,a
1094  022b 6f00          	clr	(_button_pressed_event,x)
1095                     ; 152 	return out;
1097  022d 7b01          	ld	a,(OFST+0,sp)
1100  022f 5b03          	addw	sp,#3
1101  0231 81            	ret
1137                     ; 155 void clear_button_events()
1137                     ; 156 {
1138                     	switch	.text
1139  0232               _clear_button_events:
1141  0232 88            	push	a
1142       00000001      OFST:	set	1
1145                     ; 158 	for(iter=0;iter<BUTTON_COUNT;iter++)
1147  0233 0f01          	clr	(OFST+0,sp)
1149  0235               L553:
1150                     ; 160 		clear_button_event(iter,0);
1152  0235 7b01          	ld	a,(OFST+0,sp)
1153  0237 5f            	clrw	x
1154  0238 95            	ld	xh,a
1155  0239 add3          	call	_clear_button_event
1157                     ; 161 		clear_button_event(iter,1);
1159  023b 7b01          	ld	a,(OFST+0,sp)
1160  023d ae0001        	ldw	x,#1
1161  0240 95            	ld	xh,a
1162  0241 adcb          	call	_clear_button_event
1164                     ; 158 	for(iter=0;iter<BUTTON_COUNT;iter++)
1166  0243 0c01          	inc	(OFST+0,sp)
1170  0245 7b01          	ld	a,(OFST+0,sp)
1171  0247 a102          	cp	a,#2
1172  0249 25ea          	jrult	L553
1173                     ; 163 }
1176  024b 84            	pop	a
1177  024c 81            	ret
1213                     ; 166 bool is_button_down(u8 index)
1213                     ; 167 {
1214                     	switch	.text
1215  024d               _is_button_down:
1219                     ; 168 	switch(index)
1222                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1224  024d 4d            	tnz	a
1225  024e 2708          	jreq	L363
1226  0250 4a            	dec	a
1227  0251 2718          	jreq	L563
1228  0253 4a            	dec	a
1229  0254 2728          	jreq	L763
1230  0256 2039          	jra	L114
1231  0258               L363:
1232                     ; 170 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1234  0258 4b20          	push	#32
1235  025a ae500f        	ldw	x,#20495
1236  025d cd0000        	call	_GPIO_ReadInputPin
1238  0260 5b01          	addw	sp,#1
1239  0262 4d            	tnz	a
1240  0263 2604          	jrne	L201
1241  0265 a601          	ld	a,#1
1242  0267 2001          	jra	L401
1243  0269               L201:
1244  0269 4f            	clr	a
1245  026a               L401:
1248  026a 81            	ret
1249  026b               L563:
1250                     ; 171 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1253  026b 4b40          	push	#64
1254  026d ae500f        	ldw	x,#20495
1255  0270 cd0000        	call	_GPIO_ReadInputPin
1257  0273 5b01          	addw	sp,#1
1258  0275 4d            	tnz	a
1259  0276 2604          	jrne	L601
1260  0278 a601          	ld	a,#1
1261  027a 2001          	jra	L011
1262  027c               L601:
1263  027c 4f            	clr	a
1264  027d               L011:
1267  027d 81            	ret
1268  027e               L763:
1269                     ; 172 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1272  027e 4b02          	push	#2
1273  0280 ae500f        	ldw	x,#20495
1274  0283 cd0000        	call	_GPIO_ReadInputPin
1276  0286 5b01          	addw	sp,#1
1277  0288 4d            	tnz	a
1278  0289 2604          	jrne	L211
1279  028b a601          	ld	a,#1
1280  028d 2001          	jra	L411
1281  028f               L211:
1282  028f 4f            	clr	a
1283  0290               L411:
1286  0290 81            	ret
1287  0291               L114:
1288                     ; 174 	return 0;
1290  0291 4f            	clr	a
1293  0292 81            	ret
1320                     	switch	.const
1321  0011               L021:
1322  0011 00000007      	dc.l	7
1323                     ; 178 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1324                     	scross	on
1325                     	switch	.text
1326  0293               f_TIM2_UPD_OVF_IRQHandler:
1328  0293 8a            	push	cc
1329  0294 84            	pop	a
1330  0295 a4bf          	and	a,#191
1331  0297 88            	push	a
1332  0298 86            	pop	cc
1333  0299 3b0002        	push	c_x+2
1334  029c be00          	ldw	x,c_x
1335  029e 89            	pushw	x
1336  029f 3b0002        	push	c_y+2
1337  02a2 be00          	ldw	x,c_y
1338  02a4 89            	pushw	x
1339  02a5 be02          	ldw	x,c_lreg+2
1340  02a7 89            	pushw	x
1341  02a8 be00          	ldw	x,c_lreg
1342  02aa 89            	pushw	x
1345                     ; 179 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1347  02ab 72115304      	bres	21252,#0
1348                     ; 180 	api_counter++;
1350  02af ae0000        	ldw	x,#_api_counter
1351  02b2 a601          	ld	a,#1
1352  02b4 cd0000        	call	c_lgadc
1354                     ; 184 	if(api_counter%7==0 && temp_delete_me>0)//simulate other LEDs ON
1356  02b7 ae0000        	ldw	x,#_api_counter
1357  02ba cd0000        	call	c_ltor
1359  02bd ae0011        	ldw	x,#L021
1360  02c0 cd0000        	call	c_lumd
1362  02c3 cd0000        	call	c_lrzmp
1364  02c6 260f          	jrne	L324
1366  02c8 3d08          	tnz	_temp_delete_me
1367  02ca 270b          	jreq	L324
1368                     ; 185 		GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
1370  02cc 4bd0          	push	#208
1371  02ce 4b08          	push	#8
1372  02d0 ae5000        	ldw	x,#20480
1373  02d3 cd0000        	call	_GPIO_Init
1375  02d6 85            	popw	x
1376  02d7               L324:
1377                     ; 186 	TIM2->CCR1L = temp_delete_me;//set wakeup alarm relative to current time
1379  02d7 5500085312    	mov	21266,_temp_delete_me
1380                     ; 187 }
1383  02dc 85            	popw	x
1384  02dd bf00          	ldw	c_lreg,x
1385  02df 85            	popw	x
1386  02e0 bf02          	ldw	c_lreg+2,x
1387  02e2 85            	popw	x
1388  02e3 bf00          	ldw	c_y,x
1389  02e5 320002        	pop	c_y+2
1390  02e8 85            	popw	x
1391  02e9 bf00          	ldw	c_x,x
1392  02eb 320002        	pop	c_x+2
1393  02ee 80            	iret
1417                     ; 190 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
1418                     	switch	.text
1419  02ef               f_TIM2_CapComp_IRQ_Handler:
1421  02ef 8a            	push	cc
1422  02f0 84            	pop	a
1423  02f1 a4bf          	and	a,#191
1424  02f3 88            	push	a
1425  02f4 86            	pop	cc
1426  02f5 3b0002        	push	c_x+2
1427  02f8 be00          	ldw	x,c_x
1428  02fa 89            	pushw	x
1429  02fb 3b0002        	push	c_y+2
1430  02fe be00          	ldw	x,c_y
1431  0300 89            	pushw	x
1434                     ; 193 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
1436  0301 72135304      	bres	21252,#1
1437                     ; 194 	set_matrix_high_z();
1439  0305 cd0485        	call	_set_matrix_high_z
1441                     ; 195 }
1444  0308 85            	popw	x
1445  0309 bf00          	ldw	c_y,x
1446  030b 320002        	pop	c_y+2
1447  030e 85            	popw	x
1448  030f bf00          	ldw	c_x,x
1449  0311 320002        	pop	c_x+2
1450  0314 80            	iret
1515                     ; 197 void flush_leds(u8 led_count)
1515                     ; 198 {
1517                     	switch	.text
1518  0315               _flush_leds:
1520  0315 88            	push	a
1521  0316 5203          	subw	sp,#3
1522       00000003      OFST:	set	3
1525                     ; 199 	u8 led_read_index=0,led_write_index=0;
1529  0318 0f02          	clr	(OFST-1,sp)
1532  031a               L374:
1533                     ; 201 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1535  031a b607          	ld	a,_pwm_state
1536  031c a502          	bcp	a,#2
1537  031e 26fa          	jrne	L374
1538                     ; 202 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1540  0320 b607          	ld	a,_pwm_state
1541  0322 a401          	and	a,#1
1542  0324 a801          	xor	a,#1
1543  0326 6b01          	ld	(OFST-2,sp),a
1545                     ; 203 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1547  0328 7b04          	ld	a,(OFST+1,sp)
1548  032a 5f            	clrw	x
1549  032b 97            	ld	xl,a
1550  032c 4f            	clr	a
1551  032d 02            	rlwa	x,a
1552  032e 7b01          	ld	a,(OFST-2,sp)
1553  0330 905f          	clrw	y
1554  0332 9097          	ld	yl,a
1555  0334 9058          	sllw	y
1556  0336 90ef0a        	ldw	(_pwm_sleep,y),x
1557                     ; 205 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1559  0339 0f03          	clr	(OFST+0,sp)
1562  033b 205d          	jra	L305
1563  033d               L774:
1564                     ; 207 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1566  033d 7b03          	ld	a,(OFST+0,sp)
1567  033f 5f            	clrw	x
1568  0340 97            	ld	xl,a
1569  0341 e68a          	ld	a,(_pwm_brightness_buffer,x)
1570  0343 a105          	cp	a,#5
1571  0345 254b          	jrult	L705
1572                     ; 209 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1574  0347 7b02          	ld	a,(OFST-1,sp)
1575  0349 97            	ld	xl,a
1576  034a a604          	ld	a,#4
1577  034c 42            	mul	x,a
1578  034d 01            	rrwa	x,a
1579  034e 1b01          	add	a,(OFST-2,sp)
1580  0350 2401          	jrnc	L621
1581  0352 5c            	incw	x
1582  0353               L621:
1583  0353 02            	rlwa	x,a
1584  0354 7b03          	ld	a,(OFST+0,sp)
1585  0356 e70e          	ld	(_pwm_brightness,x),a
1586                     ; 210 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1588  0358 7b02          	ld	a,(OFST-1,sp)
1589  035a 97            	ld	xl,a
1590  035b a604          	ld	a,#4
1591  035d 42            	mul	x,a
1592  035e 01            	rrwa	x,a
1593  035f 1b01          	add	a,(OFST-2,sp)
1594  0361 2401          	jrnc	L031
1595  0363 5c            	incw	x
1596  0364               L031:
1597  0364 02            	rlwa	x,a
1598  0365 7b03          	ld	a,(OFST+0,sp)
1599  0367 905f          	clrw	y
1600  0369 9097          	ld	yl,a
1601  036b 90e68a        	ld	a,(_pwm_brightness_buffer,y)
1602  036e e710          	ld	(_pwm_brightness+2,x),a
1603                     ; 211 			led_write_index++;
1605  0370 0c02          	inc	(OFST-1,sp)
1607                     ; 212 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1609  0372 7b01          	ld	a,(OFST-2,sp)
1610  0374 5f            	clrw	x
1611  0375 97            	ld	xl,a
1612  0376 58            	sllw	x
1613  0377 7b03          	ld	a,(OFST+0,sp)
1614  0379 905f          	clrw	y
1615  037b 9097          	ld	yl,a
1616  037d 90e68a        	ld	a,(_pwm_brightness_buffer,y)
1617  0380 905f          	clrw	y
1618  0382 9097          	ld	yl,a
1619  0384 9001          	rrwa	y,a
1620  0386 e00b          	sub	a,(_pwm_sleep+1,x)
1621  0388 9001          	rrwa	y,a
1622  038a e20a          	sbc	a,(_pwm_sleep,x)
1623  038c 9001          	rrwa	y,a
1624  038e 9050          	negw	y
1625  0390 ef0a          	ldw	(_pwm_sleep,x),y
1626  0392               L705:
1627                     ; 214 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1629  0392 7b03          	ld	a,(OFST+0,sp)
1630  0394 5f            	clrw	x
1631  0395 97            	ld	xl,a
1632  0396 6f8a          	clr	(_pwm_brightness_buffer,x)
1633                     ; 205 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1635  0398 0c03          	inc	(OFST+0,sp)
1637  039a               L305:
1640  039a 7b03          	ld	a,(OFST+0,sp)
1641  039c a11f          	cp	a,#31
1642  039e 2406          	jruge	L115
1644  03a0 7b02          	ld	a,(OFST-1,sp)
1645  03a2 1104          	cp	a,(OFST+1,sp)
1646  03a4 2597          	jrult	L774
1647  03a6               L115:
1648                     ; 216 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1650  03a6 7b01          	ld	a,(OFST-2,sp)
1651  03a8 5f            	clrw	x
1652  03a9 97            	ld	xl,a
1653  03aa 7b02          	ld	a,(OFST-1,sp)
1654  03ac e708          	ld	(_pwm_led_count,x),a
1655                     ; 219 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1657  03ae 72120007      	bset	_pwm_state,#1
1658                     ; 220 }
1661  03b2 5b04          	addw	sp,#4
1662  03b4 81            	ret
1751                     ; 222 void set_hue(u8 index,u16 color,u8 brightness)
1751                     ; 223 {
1752                     	switch	.text
1753  03b5               _set_hue:
1755  03b5 88            	push	a
1756  03b6 5205          	subw	sp,#5
1757       00000005      OFST:	set	5
1760                     ; 224 	u8 red=0,green=0,blue=0;
1762  03b8 0f01          	clr	(OFST-4,sp)
1766  03ba 0f02          	clr	(OFST-3,sp)
1770  03bc 0f03          	clr	(OFST-2,sp)
1772                     ; 225 	u16 residual=color%(0x2AAB);
1774  03be 1e09          	ldw	x,(OFST+4,sp)
1775  03c0 90ae2aab      	ldw	y,#10923
1776  03c4 65            	divw	x,y
1777  03c5 51            	exgw	x,y
1778  03c6 1f04          	ldw	(OFST-1,sp),x
1780                     ; 226 	residual=(u8)(residual*brightness/0x2AAB);
1782  03c8 1e04          	ldw	x,(OFST-1,sp)
1783  03ca 7b0b          	ld	a,(OFST+6,sp)
1784  03cc cd0000        	call	c_bmulx
1786  03cf 90ae2aab      	ldw	y,#10923
1787  03d3 65            	divw	x,y
1788  03d4 9f            	ld	a,xl
1789  03d5 5f            	clrw	x
1790  03d6 97            	ld	xl,a
1791  03d7 1f04          	ldw	(OFST-1,sp),x
1793                     ; 227 	switch(color/(0x2AAB))//0xFFFF/6
1795  03d9 1e09          	ldw	x,(OFST+4,sp)
1796  03db 90ae2aab      	ldw	y,#10923
1797  03df 65            	divw	x,y
1799                     ; 258 			break;
1800  03e0 5d            	tnzw	x
1801  03e1 2711          	jreq	L315
1802  03e3 5a            	decw	x
1803  03e4 271a          	jreq	L515
1804  03e6 5a            	decw	x
1805  03e7 2725          	jreq	L715
1806  03e9 5a            	decw	x
1807  03ea 272e          	jreq	L125
1808  03ec 5a            	decw	x
1809  03ed 2739          	jreq	L325
1810  03ef 5a            	decw	x
1811  03f0 2742          	jreq	L525
1812  03f2 204c          	jra	L106
1813  03f4               L315:
1814                     ; 230 			red=brightness;
1816  03f4 7b0b          	ld	a,(OFST+6,sp)
1817  03f6 6b01          	ld	(OFST-4,sp),a
1819                     ; 231 			green=residual;
1821  03f8 7b05          	ld	a,(OFST+0,sp)
1822  03fa 6b02          	ld	(OFST-3,sp),a
1824                     ; 232 			blue=0;
1826  03fc 0f03          	clr	(OFST-2,sp)
1828                     ; 233 			break;
1830  03fe 2040          	jra	L106
1831  0400               L515:
1832                     ; 235 			red=brightness-residual;
1834  0400 7b0b          	ld	a,(OFST+6,sp)
1835  0402 1005          	sub	a,(OFST+0,sp)
1836  0404 6b01          	ld	(OFST-4,sp),a
1838                     ; 236 			green=brightness;
1840  0406 7b0b          	ld	a,(OFST+6,sp)
1841  0408 6b02          	ld	(OFST-3,sp),a
1843                     ; 237 			blue=0;
1845  040a 0f03          	clr	(OFST-2,sp)
1847                     ; 238 			break;
1849  040c 2032          	jra	L106
1850  040e               L715:
1851                     ; 240 			red=0;
1853  040e 0f01          	clr	(OFST-4,sp)
1855                     ; 241 			green=brightness;
1857  0410 7b0b          	ld	a,(OFST+6,sp)
1858  0412 6b02          	ld	(OFST-3,sp),a
1860                     ; 242 			blue=residual;
1862  0414 7b05          	ld	a,(OFST+0,sp)
1863  0416 6b03          	ld	(OFST-2,sp),a
1865                     ; 243 			break;
1867  0418 2026          	jra	L106
1868  041a               L125:
1869                     ; 245 			red=0;
1871  041a 0f01          	clr	(OFST-4,sp)
1873                     ; 246 			green=brightness-residual;
1875  041c 7b0b          	ld	a,(OFST+6,sp)
1876  041e 1005          	sub	a,(OFST+0,sp)
1877  0420 6b02          	ld	(OFST-3,sp),a
1879                     ; 247 			blue=brightness;
1881  0422 7b0b          	ld	a,(OFST+6,sp)
1882  0424 6b03          	ld	(OFST-2,sp),a
1884                     ; 248 			break;
1886  0426 2018          	jra	L106
1887  0428               L325:
1888                     ; 250 			red=residual;
1890  0428 7b05          	ld	a,(OFST+0,sp)
1891  042a 6b01          	ld	(OFST-4,sp),a
1893                     ; 251 			green=0;
1895  042c 0f02          	clr	(OFST-3,sp)
1897                     ; 252 			blue=brightness;
1899  042e 7b0b          	ld	a,(OFST+6,sp)
1900  0430 6b03          	ld	(OFST-2,sp),a
1902                     ; 253 			break;
1904  0432 200c          	jra	L106
1905  0434               L525:
1906                     ; 255 			red=brightness;
1908  0434 7b0b          	ld	a,(OFST+6,sp)
1909  0436 6b01          	ld	(OFST-4,sp),a
1911                     ; 256 			green=0;
1913  0438 0f02          	clr	(OFST-3,sp)
1915                     ; 257 			blue=brightness-residual;
1917  043a 7b0b          	ld	a,(OFST+6,sp)
1918  043c 1005          	sub	a,(OFST+0,sp)
1919  043e 6b03          	ld	(OFST-2,sp),a
1921                     ; 258 			break;
1923  0440               L106:
1924                     ; 261 	set_rgb(index,0,red);
1926  0440 7b01          	ld	a,(OFST-4,sp)
1927  0442 88            	push	a
1928  0443 7b07          	ld	a,(OFST+2,sp)
1929  0445 5f            	clrw	x
1930  0446 95            	ld	xh,a
1931  0447 ad1c          	call	_set_rgb
1933  0449 84            	pop	a
1934                     ; 262 	set_rgb(index,1,green);
1936  044a 7b02          	ld	a,(OFST-3,sp)
1937  044c 88            	push	a
1938  044d 7b07          	ld	a,(OFST+2,sp)
1939  044f ae0001        	ldw	x,#1
1940  0452 95            	ld	xh,a
1941  0453 ad10          	call	_set_rgb
1943  0455 84            	pop	a
1944                     ; 263 	set_rgb(index,2,blue);
1946  0456 7b03          	ld	a,(OFST-2,sp)
1947  0458 88            	push	a
1948  0459 7b07          	ld	a,(OFST+2,sp)
1949  045b ae0002        	ldw	x,#2
1950  045e 95            	ld	xh,a
1951  045f ad04          	call	_set_rgb
1953  0461 84            	pop	a
1954                     ; 264 }
1957  0462 5b06          	addw	sp,#6
1958  0464 81            	ret
2011                     ; 266 void set_rgb(u8 index,u8 color,u8 brightness)
2011                     ; 267 {
2012                     	switch	.text
2013  0465               _set_rgb:
2015  0465 89            	pushw	x
2016       00000000      OFST:	set	0
2019                     ; 268 	pwm_brightness_buffer[index*3+color]=brightness;
2021  0466 9e            	ld	a,xh
2022  0467 97            	ld	xl,a
2023  0468 a603          	ld	a,#3
2024  046a 42            	mul	x,a
2025  046b 01            	rrwa	x,a
2026  046c 1b02          	add	a,(OFST+2,sp)
2027  046e 2401          	jrnc	L041
2028  0470 5c            	incw	x
2029  0471               L041:
2030  0471 02            	rlwa	x,a
2031  0472 7b05          	ld	a,(OFST+5,sp)
2032  0474 e78a          	ld	(_pwm_brightness_buffer,x),a
2033                     ; 269 }
2036  0476 85            	popw	x
2037  0477 81            	ret
2081                     ; 271 void set_white(u8 index,u8 brightness)
2081                     ; 272 {
2082                     	switch	.text
2083  0478               _set_white:
2085  0478 89            	pushw	x
2086       00000000      OFST:	set	0
2089                     ; 273 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2091  0479 9e            	ld	a,xh
2092  047a 5f            	clrw	x
2093  047b 97            	ld	xl,a
2094  047c 7b02          	ld	a,(OFST+2,sp)
2095  047e e791          	ld	(_pwm_brightness_buffer+7,x),a
2096                     ; 274 }
2099  0480 85            	popw	x
2100  0481 81            	ret
2135                     ; 277 void set_debug(u8 brightness)
2135                     ; 278 {
2136                     	switch	.text
2137  0482               _set_debug:
2141                     ; 279 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2143  0482 b790          	ld	_pwm_brightness_buffer+6,a
2144                     ; 280 }
2147  0484 81            	ret
2170                     ; 282 void set_matrix_high_z()
2170                     ; 283 {
2171                     	switch	.text
2172  0485               _set_matrix_high_z:
2176                     ; 287 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2178  0485 c6500d        	ld	a,20493
2179  0488 a407          	and	a,#7
2180  048a c7500d        	ld	20493,a
2181                     ; 288 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2183  048d 72155012      	bres	20498,#2
2184                     ; 289 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2186  0491 72175003      	bres	20483,#3
2187                     ; 290 }
2190  0495 81            	ret
2224                     ; 292 u8 get_eeprom_byte(u16 eeprom_address)
2224                     ; 293 {
2225                     	switch	.text
2226  0496               _get_eeprom_byte:
2230                     ; 294 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2232  0496 d64000        	ld	a,(16384,x)
2235  0499 81            	ret
2371                     	xdef	f_TIM2_CapComp_IRQ_Handler
2372                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2373                     	xdef	_temp_delete_me
2374                     	switch	.ubsct
2375  0000               _button_pressed_event:
2376  0000 00000000      	ds.b	4
2377                     	xdef	_button_pressed_event
2378  0004               _button_start_ms:
2379  0004 00000000      	ds.b	4
2380                     	xdef	_button_start_ms
2381                     	xdef	_pwm_state
2382                     	xdef	_pwm_led_index
2383                     	xdef	_pwm_sleep_remaining
2384  0008               _pwm_led_count:
2385  0008 0000          	ds.b	2
2386                     	xdef	_pwm_led_count
2387  000a               _pwm_sleep:
2388  000a 00000000      	ds.b	4
2389                     	xdef	_pwm_sleep
2390  000e               _pwm_brightness:
2391  000e 000000000000  	ds.b	124
2392                     	xdef	_pwm_brightness
2393                     	xdef	_PWM_MAX_PERIOD
2394  008a               _pwm_brightness_buffer:
2395  008a 000000000000  	ds.b	31
2396                     	xdef	_pwm_brightness_buffer
2397                     	xdef	_api_counter
2398                     	xref	_UART1_Cmd
2399                     	xref	_UART1_Init
2400                     	xref	_UART1_DeInit
2401                     	xref	_GPIO_ReadInputPin
2402                     	xref	_GPIO_Init
2403                     	xdef	_get_eeprom_byte
2404                     	xdef	_set_millis
2405                     	xdef	_get_random
2406                     	xdef	_is_button_down
2407                     	xdef	_clear_button_events
2408                     	xdef	_clear_button_event
2409                     	xdef	_get_button_event
2410                     	xdef	_update_buttons
2411                     	xdef	_is_sleep_valid
2412                     	xdef	_is_developer_valid
2413                     	xdef	_set_hue
2414                     	xdef	_flush_leds
2415                     	xdef	_set_debug
2416                     	xdef	_set_white
2417                     	xdef	_set_rgb
2418                     	xdef	_set_matrix_high_z
2419                     	xdef	_millis
2420                     	xdef	_setup_main
2421                     	xdef	_is_application_valid
2422                     	xdef	_setup_serial
2423                     	xdef	_hello_world
2424                     	xref.b	c_lreg
2425                     	xref.b	c_x
2426                     	xref.b	c_y
2446                     	xref	c_bmulx
2447                     	xref	c_lumd
2448                     	xref	c_lzmp
2449                     	xref	c_lsub
2450                     	xref	c_rtol
2451                     	xref	c_uitolx
2452                     	xref	c_itolx
2453                     	xref	c_imul
2454                     	xref	c_lrzmp
2455                     	xref	c_lmod
2456                     	xref	c_ldiv
2457                     	xref	c_ltor
2458                     	xref	c_lgadc
2459                     	end
