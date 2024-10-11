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
 120                     	switch	.const
 121  0001               L01:
 122  0001 00010000      	dc.l	65536
 123  0005               L21:
 124  0005 00000002      	dc.l	2
 125  0009               L41:
 126  0009 00000100      	dc.l	256
 127                     ; 32 void hello_world()
 127                     ; 33 {//basic program that blinks the debug LED ON/OFF
 128                     	scross	off
 129                     	switch	.text
 130  0000               _hello_world:
 132  0000 5207          	subw	sp,#7
 133       00000007      OFST:	set	7
 136                     ; 36 	bool is_high=0;
 138                     ; 37 	long frame=0;
 140  0002 ae0000        	ldw	x,#0
 141  0005 1f04          	ldw	(OFST-3,sp),x
 142  0007 ae0000        	ldw	x,#0
 143  000a 1f02          	ldw	(OFST-5,sp),x
 145  000c               L35:
 146                     ; 41 		frame++;
 148  000c 96            	ldw	x,sp
 149  000d 1c0002        	addw	x,#OFST-5
 150  0010 a601          	ld	a,#1
 151  0012 cd0000        	call	c_lgadc
 154                     ; 43 		temp2_delete_me=0x00FF&((frame/256/256)%2?(~(frame/256)):(frame/256));
 156  0015 96            	ldw	x,sp
 157  0016 1c0002        	addw	x,#OFST-5
 158  0019 cd0000        	call	c_ltor
 160  001c ae0001        	ldw	x,#L01
 161  001f cd0000        	call	c_ldiv
 163  0022 ae0005        	ldw	x,#L21
 164  0025 cd0000        	call	c_lmod
 166  0028 cd0000        	call	c_lrzmp
 168  002b 2717          	jreq	L6
 169  002d 96            	ldw	x,sp
 170  002e 1c0002        	addw	x,#OFST-5
 171  0031 cd0000        	call	c_ltor
 173  0034 ae0009        	ldw	x,#L41
 174  0037 cd0000        	call	c_ldiv
 176  003a 3303          	cpl	c_lreg+3
 177  003c 3302          	cpl	c_lreg+2
 178  003e 3301          	cpl	c_lreg+1
 179  0040 3300          	cpl	c_lreg
 180  0042 200d          	jra	L61
 181  0044               L6:
 182  0044 96            	ldw	x,sp
 183  0045 1c0002        	addw	x,#OFST-5
 184  0048 cd0000        	call	c_ltor
 186  004b ae0009        	ldw	x,#L41
 187  004e cd0000        	call	c_ldiv
 189  0051               L61:
 190  0051 3f02          	clr	c_lreg+2
 191  0053 3f01          	clr	c_lreg+1
 192  0055 3f00          	clr	c_lreg
 193  0057 be02          	ldw	x,c_lreg+2
 194  0059 1f06          	ldw	(OFST-1,sp),x
 196                     ; 44 		temp2_delete_me=temp2_delete_me*temp2_delete_me;
 198  005b 1e06          	ldw	x,(OFST-1,sp)
 199  005d 1606          	ldw	y,(OFST-1,sp)
 200  005f cd0000        	call	c_imul
 202  0062 1f06          	ldw	(OFST-1,sp),x
 204                     ; 45 		temp2_delete_me=temp2_delete_me>>6;
 206  0064 a606          	ld	a,#6
 207  0066               L02:
 208  0066 0406          	srl	(OFST-1,sp)
 209  0068 0607          	rrc	(OFST+0,sp)
 210  006a 4a            	dec	a
 211  006b 26f9          	jrne	L02
 213                     ; 46 		temp_delete_me=temp2_delete_me;
 215  006d 1e06          	ldw	x,(OFST-1,sp)
 216  006f bf08          	ldw	_temp_delete_me,x
 217                     ; 47 		temp4_delete_me=0x00FF&((frame/256/256)%2?((frame/256)):(~frame/256));
 219  0071 96            	ldw	x,sp
 220  0072 1c0002        	addw	x,#OFST-5
 221  0075 cd0000        	call	c_ltor
 223  0078 ae0001        	ldw	x,#L01
 224  007b cd0000        	call	c_ldiv
 226  007e ae0005        	ldw	x,#L21
 227  0081 cd0000        	call	c_lmod
 229  0084 cd0000        	call	c_lrzmp
 231  0087 270f          	jreq	L22
 232  0089 96            	ldw	x,sp
 233  008a 1c0002        	addw	x,#OFST-5
 234  008d cd0000        	call	c_ltor
 236  0090 ae0009        	ldw	x,#L41
 237  0093 cd0000        	call	c_ldiv
 239  0096 2015          	jra	L42
 240  0098               L22:
 241  0098 96            	ldw	x,sp
 242  0099 1c0002        	addw	x,#OFST-5
 243  009c cd0000        	call	c_ltor
 245  009f 3303          	cpl	c_lreg+3
 246  00a1 3302          	cpl	c_lreg+2
 247  00a3 3301          	cpl	c_lreg+1
 248  00a5 3300          	cpl	c_lreg
 249  00a7 ae0009        	ldw	x,#L41
 250  00aa cd0000        	call	c_ldiv
 252  00ad               L42:
 253  00ad 3f02          	clr	c_lreg+2
 254  00af 3f01          	clr	c_lreg+1
 255  00b1 3f00          	clr	c_lreg
 256  00b3 be02          	ldw	x,c_lreg+2
 257  00b5 1f06          	ldw	(OFST-1,sp),x
 259                     ; 48 		temp4_delete_me=temp4_delete_me*temp4_delete_me;
 261  00b7 1e06          	ldw	x,(OFST-1,sp)
 262  00b9 1606          	ldw	y,(OFST-1,sp)
 263  00bb cd0000        	call	c_imul
 265  00be 1f06          	ldw	(OFST-1,sp),x
 267                     ; 49 		temp4_delete_me=temp4_delete_me>>6;
 269  00c0 a606          	ld	a,#6
 270  00c2               L62:
 271  00c2 0406          	srl	(OFST-1,sp)
 272  00c4 0607          	rrc	(OFST+0,sp)
 273  00c6 4a            	dec	a
 274  00c7 26f9          	jrne	L62
 276                     ; 50 		temp3_delete_me=(temp4_delete_me%2)<<9;
 278  00c9 7b06          	ld	a,(OFST-1,sp)
 279  00cb 97            	ld	xl,a
 280  00cc 7b07          	ld	a,(OFST+0,sp)
 281  00ce a401          	and	a,#1
 282  00d0 5f            	clrw	x
 283  00d1 02            	rlwa	x,a
 284  00d2 4f            	clr	a
 285  00d3 02            	rlwa	x,a
 286  00d4 58            	sllw	x
 287  00d5 bf0a          	ldw	_temp3_delete_me,x
 289  00d7 ac0c000c      	jpf	L35
 341                     ; 55 u16 get_random(u16 x)
 341                     ; 56 {
 342                     	switch	.text
 343  00db               _get_random:
 345  00db 5204          	subw	sp,#4
 346       00000004      OFST:	set	4
 349                     ; 57 	u16 a=1664525;
 351                     ; 58 	u16 c=1013904223;
 353                     ; 59 	return a * x + c;
 355  00dd 90ae660d      	ldw	y,#26125
 356  00e1 cd0000        	call	c_imul
 358  00e4 1cf35f        	addw	x,#62303
 361  00e7 5b04          	addw	sp,#4
 362  00e9 81            	ret
 411                     	switch	.const
 412  000d               L04:
 413  000d 000f4240      	dc.l	1000000
 414                     ; 62 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 414                     ; 63 {
 415                     	switch	.text
 416  00ea               _setup_serial:
 418  00ea 89            	pushw	x
 419       00000000      OFST:	set	0
 422                     ; 64 	if(is_enabled)
 424  00eb 9e            	ld	a,xh
 425  00ec 4d            	tnz	a
 426  00ed 2747          	jreq	L721
 427                     ; 66 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 429  00ef 4bf0          	push	#240
 430  00f1 4b20          	push	#32
 431  00f3 ae500f        	ldw	x,#20495
 432  00f6 cd0000        	call	_GPIO_Init
 434  00f9 85            	popw	x
 435                     ; 67 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 437  00fa 4b40          	push	#64
 438  00fc 4b40          	push	#64
 439  00fe ae500f        	ldw	x,#20495
 440  0101 cd0000        	call	_GPIO_Init
 442  0104 85            	popw	x
 443                     ; 68 		UART1_DeInit();
 445  0105 cd0000        	call	_UART1_DeInit
 447                     ; 69 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 449  0108 4b0c          	push	#12
 450  010a 4b80          	push	#128
 451  010c 4b00          	push	#0
 452  010e 4b00          	push	#0
 453  0110 4b00          	push	#0
 454  0112 0d07          	tnz	(OFST+7,sp)
 455  0114 2708          	jreq	L43
 456  0116 ae2580        	ldw	x,#9600
 457  0119 cd0000        	call	c_itolx
 459  011c 2006          	jra	L63
 460  011e               L43:
 461  011e ae000d        	ldw	x,#L04
 462  0121 cd0000        	call	c_ltor
 464  0124               L63:
 465  0124 be02          	ldw	x,c_lreg+2
 466  0126 89            	pushw	x
 467  0127 be00          	ldw	x,c_lreg
 468  0129 89            	pushw	x
 469  012a cd0000        	call	_UART1_Init
 471  012d 5b09          	addw	sp,#9
 472                     ; 70 		UART1_Cmd(ENABLE);
 474  012f a601          	ld	a,#1
 475  0131 cd0000        	call	_UART1_Cmd
 478  0134 201d          	jra	L131
 479  0136               L721:
 480                     ; 72 		UART1_Cmd(DISABLE);
 482  0136 4f            	clr	a
 483  0137 cd0000        	call	_UART1_Cmd
 485                     ; 73 		UART1_DeInit();
 487  013a cd0000        	call	_UART1_DeInit
 489                     ; 74 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 491  013d 4b40          	push	#64
 492  013f 4b20          	push	#32
 493  0141 ae500f        	ldw	x,#20495
 494  0144 cd0000        	call	_GPIO_Init
 496  0147 85            	popw	x
 497                     ; 75 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 499  0148 4b40          	push	#64
 500  014a 4b40          	push	#64
 501  014c ae500f        	ldw	x,#20495
 502  014f cd0000        	call	_GPIO_Init
 504  0152 85            	popw	x
 505  0153               L131:
 506                     ; 77 }
 509  0153 85            	popw	x
 510  0154 81            	ret
 537                     ; 80 bool is_application_valid()
 537                     ; 81 {
 538                     	switch	.text
 539  0155               _is_application_valid:
 543                     ; 82 	return !is_button_down(2) && !get_button_event(0,1);
 545  0155 a602          	ld	a,#2
 546  0157 cd028c        	call	_is_button_down
 548  015a 4d            	tnz	a
 549  015b 260d          	jrne	L44
 550  015d ae0001        	ldw	x,#1
 551  0160 cd023d        	call	_get_button_event
 553  0163 4d            	tnz	a
 554  0164 2604          	jrne	L44
 555  0166 a601          	ld	a,#1
 556  0168 2001          	jra	L64
 557  016a               L44:
 558  016a 4f            	clr	a
 559  016b               L64:
 562  016b 81            	ret
 588                     ; 86 bool is_developer_valid()
 588                     ; 87 {
 589                     	switch	.text
 590  016c               _is_developer_valid:
 594                     ; 88 	return is_button_down(2) && !get_button_event(0,1);
 596  016c a602          	ld	a,#2
 597  016e cd028c        	call	_is_button_down
 599  0171 4d            	tnz	a
 600  0172 270d          	jreq	L25
 601  0174 ae0001        	ldw	x,#1
 602  0177 cd023d        	call	_get_button_event
 604  017a 4d            	tnz	a
 605  017b 2604          	jrne	L25
 606  017d a601          	ld	a,#1
 607  017f 2001          	jra	L45
 608  0181               L25:
 609  0181 4f            	clr	a
 610  0182               L45:
 613  0182 81            	ret
 638                     ; 91 void setup_main()
 638                     ; 92 {
 639                     	switch	.text
 640  0183               _setup_main:
 644                     ; 93 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 646  0183 c650c6        	ld	a,20678
 647  0186 a4e7          	and	a,#231
 648  0188 c750c6        	ld	20678,a
 649                     ; 95 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 651  018b 4b40          	push	#64
 652  018d 4b02          	push	#2
 653  018f ae500f        	ldw	x,#20495
 654  0192 cd0000        	call	_GPIO_Init
 656  0195 85            	popw	x
 657                     ; 98 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 659  0196 725f5311      	clr	21265
 660                     ; 99 	TIM2->PSCR= 4;// init divider register 16MHz/2^X
 662  019a 3504530e      	mov	21262,#4
 663                     ; 100 	TIM2->ARRH= 16;// init auto reload register
 665  019e 3510530f      	mov	21263,#16
 666                     ; 101 	TIM2->ARRL= 255;// init auto reload register
 668  01a2 35ff5310      	mov	21264,#255
 669                     ; 103 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 671  01a6 c65300        	ld	a,21248
 672  01a9 aa05          	or	a,#5
 673  01ab c75300        	ld	21248,a
 674                     ; 105 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 676  01ae 35015303      	mov	21251,#1
 677                     ; 106 	enableInterrupts();
 680  01b2 9a            rim
 682                     ; 108 }
 686  01b3 81            	ret
 710                     ; 110 u32 millis()
 710                     ; 111 {
 711                     	switch	.text
 712  01b4               _millis:
 716                     ; 112 	return api_counter>>10;
 718  01b4 ae0000        	ldw	x,#_api_counter
 719  01b7 cd0000        	call	c_ltor
 721  01ba a60a          	ld	a,#10
 722  01bc cd0000        	call	c_lursh
 726  01bf 81            	ret
 784                     ; 118 void update_buttons()
 784                     ; 119 {
 785                     	switch	.text
 786  01c0               _update_buttons:
 788  01c0 5208          	subw	sp,#8
 789       00000008      OFST:	set	8
 792                     ; 120 	bool is_any_down=0;
 794  01c2 0f05          	clr	(OFST-3,sp)
 796                     ; 122 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 798  01c4 be06          	ldw	x,_button_start_ms+2
 799  01c6 cd0000        	call	c_uitolx
 801  01c9 96            	ldw	x,sp
 802  01ca 1c0001        	addw	x,#OFST-7
 803  01cd cd0000        	call	c_rtol
 806  01d0 ade2          	call	_millis
 808  01d2 96            	ldw	x,sp
 809  01d3 1c0001        	addw	x,#OFST-7
 810  01d6 cd0000        	call	c_lsub
 812  01d9 be02          	ldw	x,c_lreg+2
 813  01db 1f06          	ldw	(OFST-2,sp),x
 815                     ; 123 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 817  01dd 0f08          	clr	(OFST+0,sp)
 819  01df               L122:
 820                     ; 125 		if(is_button_down(button_index))
 822  01df 7b08          	ld	a,(OFST+0,sp)
 823  01e1 cd028c        	call	_is_button_down
 825  01e4 4d            	tnz	a
 826  01e5 271b          	jreq	L722
 827                     ; 127 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 829  01e7 ae0004        	ldw	x,#_button_start_ms
 830  01ea cd0000        	call	c_lzmp
 832  01ed 2608          	jrne	L132
 835  01ef adc3          	call	_millis
 837  01f1 ae0004        	ldw	x,#_button_start_ms
 838  01f4 cd0000        	call	c_rtol
 840  01f7               L132:
 841                     ; 128 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 843  01f7 a6ff          	ld	a,#255
 844  01f9 cd053a        	call	_set_debug
 846                     ; 129 			is_any_down=1;
 848  01fc a601          	ld	a,#1
 849  01fe 6b05          	ld	(OFST-3,sp),a
 852  0200 2022          	jra	L332
 853  0202               L722:
 854                     ; 131 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 856  0202 1e06          	ldw	x,(OFST-2,sp)
 857  0204 a30201        	cpw	x,#513
 858  0207 250b          	jrult	L532
 861  0209 7b08          	ld	a,(OFST+0,sp)
 862  020b 5f            	clrw	x
 863  020c 97            	ld	xl,a
 864  020d 58            	sllw	x
 865  020e a601          	ld	a,#1
 866  0210 e701          	ld	(_button_pressed_event+1,x),a
 868  0212 2010          	jra	L332
 869  0214               L532:
 870                     ; 132 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 872  0214 1e06          	ldw	x,(OFST-2,sp)
 873  0216 a30033        	cpw	x,#51
 874  0219 2509          	jrult	L332
 877  021b 7b08          	ld	a,(OFST+0,sp)
 878  021d 5f            	clrw	x
 879  021e 97            	ld	xl,a
 880  021f 58            	sllw	x
 881  0220 a601          	ld	a,#1
 882  0222 e700          	ld	(_button_pressed_event,x),a
 883  0224               L332:
 884                     ; 123 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 886  0224 0c08          	inc	(OFST+0,sp)
 890  0226 7b08          	ld	a,(OFST+0,sp)
 891  0228 a102          	cp	a,#2
 892  022a 25b3          	jrult	L122
 893                     ; 136 	if(!is_any_down) button_start_ms=0;
 895  022c 0d05          	tnz	(OFST-3,sp)
 896  022e 260a          	jrne	L342
 899  0230 ae0000        	ldw	x,#0
 900  0233 bf06          	ldw	_button_start_ms+2,x
 901  0235 ae0000        	ldw	x,#0
 902  0238 bf04          	ldw	_button_start_ms,x
 903  023a               L342:
 904                     ; 137 }
 907  023a 5b08          	addw	sp,#8
 908  023c 81            	ret
 954                     ; 140 bool get_button_event(u8 button_index,bool is_long)
 954                     ; 141 { return button_pressed_event[button_index][is_long]; }
 955                     	switch	.text
 956  023d               _get_button_event:
 958  023d 89            	pushw	x
 959       00000000      OFST:	set	0
 964  023e 9e            	ld	a,xh
 965  023f 5f            	clrw	x
 966  0240 97            	ld	xl,a
 967  0241 58            	sllw	x
 968  0242 01            	rrwa	x,a
 969  0243 1b02          	add	a,(OFST+2,sp)
 970  0245 2401          	jrnc	L66
 971  0247 5c            	incw	x
 972  0248               L66:
 973  0248 02            	rlwa	x,a
 974  0249 e600          	ld	a,(_button_pressed_event,x)
 977  024b 85            	popw	x
 978  024c 81            	ret
1034                     ; 144 bool clear_button_event(u8 button_index,bool is_long)
1034                     ; 145 {
1035                     	switch	.text
1036  024d               _clear_button_event:
1038  024d 89            	pushw	x
1039  024e 88            	push	a
1040       00000001      OFST:	set	1
1043                     ; 146 	bool out=button_pressed_event[button_index][is_long];
1045  024f 9e            	ld	a,xh
1046  0250 5f            	clrw	x
1047  0251 97            	ld	xl,a
1048  0252 58            	sllw	x
1049  0253 01            	rrwa	x,a
1050  0254 1b03          	add	a,(OFST+2,sp)
1051  0256 2401          	jrnc	L27
1052  0258 5c            	incw	x
1053  0259               L27:
1054  0259 02            	rlwa	x,a
1055  025a e600          	ld	a,(_button_pressed_event,x)
1056  025c 6b01          	ld	(OFST+0,sp),a
1058                     ; 147 	button_pressed_event[button_index][is_long]=0;
1060  025e 7b02          	ld	a,(OFST+1,sp)
1061  0260 5f            	clrw	x
1062  0261 97            	ld	xl,a
1063  0262 58            	sllw	x
1064  0263 01            	rrwa	x,a
1065  0264 1b03          	add	a,(OFST+2,sp)
1066  0266 2401          	jrnc	L47
1067  0268 5c            	incw	x
1068  0269               L47:
1069  0269 02            	rlwa	x,a
1070  026a 6f00          	clr	(_button_pressed_event,x)
1071                     ; 148 	return out;
1073  026c 7b01          	ld	a,(OFST+0,sp)
1076  026e 5b03          	addw	sp,#3
1077  0270 81            	ret
1113                     ; 151 void clear_button_events()
1113                     ; 152 {
1114                     	switch	.text
1115  0271               _clear_button_events:
1117  0271 88            	push	a
1118       00000001      OFST:	set	1
1121                     ; 154 	for(iter=0;iter<BUTTON_COUNT;iter++)
1123  0272 0f01          	clr	(OFST+0,sp)
1125  0274               L333:
1126                     ; 156 		clear_button_event(iter,0);
1128  0274 7b01          	ld	a,(OFST+0,sp)
1129  0276 5f            	clrw	x
1130  0277 95            	ld	xh,a
1131  0278 add3          	call	_clear_button_event
1133                     ; 157 		clear_button_event(iter,1);
1135  027a 7b01          	ld	a,(OFST+0,sp)
1136  027c ae0001        	ldw	x,#1
1137  027f 95            	ld	xh,a
1138  0280 adcb          	call	_clear_button_event
1140                     ; 154 	for(iter=0;iter<BUTTON_COUNT;iter++)
1142  0282 0c01          	inc	(OFST+0,sp)
1146  0284 7b01          	ld	a,(OFST+0,sp)
1147  0286 a102          	cp	a,#2
1148  0288 25ea          	jrult	L333
1149                     ; 159 }
1152  028a 84            	pop	a
1153  028b 81            	ret
1189                     ; 162 bool is_button_down(u8 index)
1189                     ; 163 {
1190                     	switch	.text
1191  028c               _is_button_down:
1195                     ; 164 	switch(index)
1198                     ; 168 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1200  028c 4d            	tnz	a
1201  028d 2708          	jreq	L143
1202  028f 4a            	dec	a
1203  0290 2718          	jreq	L343
1204  0292 4a            	dec	a
1205  0293 2728          	jreq	L543
1206  0295 2039          	jra	L763
1207  0297               L143:
1208                     ; 166 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1210  0297 4b20          	push	#32
1211  0299 ae500f        	ldw	x,#20495
1212  029c cd0000        	call	_GPIO_ReadInputPin
1214  029f 5b01          	addw	sp,#1
1215  02a1 4d            	tnz	a
1216  02a2 2604          	jrne	L201
1217  02a4 a601          	ld	a,#1
1218  02a6 2001          	jra	L401
1219  02a8               L201:
1220  02a8 4f            	clr	a
1221  02a9               L401:
1224  02a9 81            	ret
1225  02aa               L343:
1226                     ; 167 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1229  02aa 4b40          	push	#64
1230  02ac ae500f        	ldw	x,#20495
1231  02af cd0000        	call	_GPIO_ReadInputPin
1233  02b2 5b01          	addw	sp,#1
1234  02b4 4d            	tnz	a
1235  02b5 2604          	jrne	L601
1236  02b7 a601          	ld	a,#1
1237  02b9 2001          	jra	L011
1238  02bb               L601:
1239  02bb 4f            	clr	a
1240  02bc               L011:
1243  02bc 81            	ret
1244  02bd               L543:
1245                     ; 168 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1248  02bd 4b02          	push	#2
1249  02bf ae500f        	ldw	x,#20495
1250  02c2 cd0000        	call	_GPIO_ReadInputPin
1252  02c5 5b01          	addw	sp,#1
1253  02c7 4d            	tnz	a
1254  02c8 2604          	jrne	L211
1255  02ca a601          	ld	a,#1
1256  02cc 2001          	jra	L411
1257  02ce               L211:
1258  02ce 4f            	clr	a
1259  02cf               L411:
1262  02cf 81            	ret
1263  02d0               L763:
1264                     ; 170 	return 0;
1266  02d0 4f            	clr	a
1269  02d1 81            	ret
1330                     ; 174 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1332                     	switch	.text
1333  02d2               f_TIM2_UPD_OVF_IRQHandler:
1335  02d2 8a            	push	cc
1336  02d3 84            	pop	a
1337  02d4 a4bf          	and	a,#191
1338  02d6 88            	push	a
1339  02d7 86            	pop	cc
1340       00000004      OFST:	set	4
1341  02d8 3b0002        	push	c_x+2
1342  02db be00          	ldw	x,c_x
1343  02dd 89            	pushw	x
1344  02de 3b0002        	push	c_y+2
1345  02e1 be00          	ldw	x,c_y
1346  02e3 89            	pushw	x
1347  02e4 be02          	ldw	x,c_lreg+2
1348  02e6 89            	pushw	x
1349  02e7 be00          	ldw	x,c_lreg
1350  02e9 89            	pushw	x
1351  02ea 5204          	subw	sp,#4
1354                     ; 175 	u16 this_sleep=temp_delete_me;
1356  02ec be08          	ldw	x,_temp_delete_me
1357  02ee 1f03          	ldw	(OFST-1,sp),x
1359                     ; 176 	bool is_debug_led=0;
1361  02f0 0f01          	clr	(OFST-3,sp)
1363                     ; 177 	bool is_other_led=0;
1365  02f2 0f02          	clr	(OFST-2,sp)
1367                     ; 179 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1369  02f4 c6500d        	ld	a,20493
1370  02f7 a407          	and	a,#7
1371  02f9 c7500d        	ld	20493,a
1372                     ; 180 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1374  02fc 72155012      	bres	20498,#2
1375                     ; 181 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1377  0300 72175003      	bres	20483,#3
1378                     ; 182   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1380  0304 72115300      	bres	21248,#0
1381                     ; 183 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1383  0308 72115304      	bres	21252,#0
1384                     ; 184 	pwm_visible_index++;
1386  030c 3c06          	inc	_pwm_visible_index
1387                     ; 185 	if(pwm_visible_index>6) pwm_visible_index=0;
1389  030e b606          	ld	a,_pwm_visible_index
1390  0310 a107          	cp	a,#7
1391  0312 2502          	jrult	L714
1394  0314 3f06          	clr	_pwm_visible_index
1395  0316               L714:
1396                     ; 188 	if(pwm_visible_index==0)//simulate other LEDs ON
1398  0316 3d06          	tnz	_pwm_visible_index
1399  0318 260d          	jrne	L124
1400                     ; 190 		is_debug_led=this_sleep>0;
1402  031a 1e03          	ldw	x,(OFST-1,sp)
1403  031c 2704          	jreq	L021
1404  031e a601          	ld	a,#1
1405  0320 2001          	jra	L221
1406  0322               L021:
1407  0322 4f            	clr	a
1408  0323               L221:
1409  0323 6b01          	ld	(OFST-3,sp),a
1412  0325 201c          	jra	L324
1413  0327               L124:
1414                     ; 191 	}else if(pwm_visible_index==1){
1416  0327 b606          	ld	a,_pwm_visible_index
1417  0329 a101          	cp	a,#1
1418  032b 2611          	jrne	L524
1419                     ; 192 		this_sleep=temp3_delete_me;
1421  032d be0a          	ldw	x,_temp3_delete_me
1422  032f 1f03          	ldw	(OFST-1,sp),x
1424                     ; 193 		is_other_led=this_sleep>0;
1426  0331 1e03          	ldw	x,(OFST-1,sp)
1427  0333 2704          	jreq	L421
1428  0335 a601          	ld	a,#1
1429  0337 2001          	jra	L621
1430  0339               L421:
1431  0339 4f            	clr	a
1432  033a               L621:
1433  033a 6b02          	ld	(OFST-2,sp),a
1436  033c 2005          	jra	L324
1437  033e               L524:
1438                     ; 195 		this_sleep=0x400;
1440  033e ae0400        	ldw	x,#1024
1441  0341 1f03          	ldw	(OFST-1,sp),x
1443  0343               L324:
1444                     ; 197 	if(this_sleep<1) this_sleep=1;
1446  0343 1e03          	ldw	x,(OFST-1,sp)
1447  0345 2605          	jrne	L134
1450  0347 ae0001        	ldw	x,#1
1451  034a 1f03          	ldw	(OFST-1,sp),x
1453  034c               L134:
1454                     ; 200   TIM2->CNTRH = 0;// Set the high byte of the counter
1456  034c 725f530c      	clr	21260
1457                     ; 201   TIM2->CNTRL = 0;// Set the low byte of the counter
1459  0350 725f530d      	clr	21261
1460                     ; 204 	TIM2->ARRH= this_sleep>>8;// init auto reload register
1462  0354 7b03          	ld	a,(OFST-1,sp)
1463  0356 c7530f        	ld	21263,a
1464                     ; 205 	TIM2->ARRL= this_sleep&0x00FF;// init auto reload register
1466  0359 7b04          	ld	a,(OFST+0,sp)
1467  035b a4ff          	and	a,#255
1468  035d c75310        	ld	21264,a
1469                     ; 206 	api_counter+=this_sleep;
1471  0360 1e03          	ldw	x,(OFST-1,sp)
1472  0362 cd0000        	call	c_uitolx
1474  0365 ae0000        	ldw	x,#_api_counter
1475  0368 cd0000        	call	c_lgadd
1477                     ; 208 	if(is_debug_led)
1479  036b 0d01          	tnz	(OFST-3,sp)
1480  036d 270b          	jreq	L334
1481                     ; 209 		GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
1483  036f 4bd0          	push	#208
1484  0371 4b08          	push	#8
1485  0373 ae5000        	ldw	x,#20480
1486  0376 cd0000        	call	_GPIO_Init
1488  0379 85            	popw	x
1489  037a               L334:
1490                     ; 210 	if(is_other_led)
1492  037a 0d02          	tnz	(OFST-2,sp)
1493  037c 2704          	jreq	L534
1494                     ; 220 		set_led(1);
1496  037e a601          	ld	a,#1
1497  0380 ad19          	call	_set_led
1499  0382               L534:
1500                     ; 224   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1502  0382 72105300      	bset	21248,#0
1503                     ; 225 }
1506  0386 5b04          	addw	sp,#4
1507  0388 85            	popw	x
1508  0389 bf00          	ldw	c_lreg,x
1509  038b 85            	popw	x
1510  038c bf02          	ldw	c_lreg+2,x
1511  038e 85            	popw	x
1512  038f bf00          	ldw	c_y,x
1513  0391 320002        	pop	c_y+2
1514  0394 85            	popw	x
1515  0395 bf00          	ldw	c_x,x
1516  0397 320002        	pop	c_x+2
1517  039a 80            	iret
1519                     	switch	.const
1520  0011               L734_led_lookup:
1521  0011 00            	dc.b	0
1522  0012 03            	dc.b	3
1523  0013 01            	dc.b	1
1524  0014 03            	dc.b	3
1525  0015 02            	dc.b	2
1526  0016 03            	dc.b	3
1527  0017 03            	dc.b	3
1528  0018 00            	dc.b	0
1529  0019 04            	dc.b	4
1530  001a 00            	dc.b	0
1531  001b 05            	dc.b	5
1532  001c 00            	dc.b	0
1533  001d 00            	dc.b	0
1534  001e 04            	dc.b	4
1535  001f 01            	dc.b	1
1536  0020 04            	dc.b	4
1537  0021 02            	dc.b	2
1538  0022 04            	dc.b	4
1539  0023 03            	dc.b	3
1540  0024 01            	dc.b	1
1541  0025 04            	dc.b	4
1542  0026 01            	dc.b	1
1543  0027 05            	dc.b	5
1544  0028 01            	dc.b	1
1545  0029 00            	dc.b	0
1546  002a 05            	dc.b	5
1547  002b 01            	dc.b	1
1548  002c 05            	dc.b	5
1549  002d 02            	dc.b	2
1550  002e 05            	dc.b	5
1551  002f 03            	dc.b	3
1552  0030 02            	dc.b	2
1553  0031 04            	dc.b	4
1554  0032 02            	dc.b	2
1555  0033 05            	dc.b	5
1556  0034 02            	dc.b	2
1557  0035 06            	dc.b	6
1558  0036 06            	dc.b	6
1559  0037 01            	dc.b	1
1560  0038 00            	dc.b	0
1561  0039 02            	dc.b	2
1562  003a 00            	dc.b	0
1563  003b 00            	dc.b	0
1564  003c 01            	dc.b	1
1565  003d 02            	dc.b	2
1566  003e 01            	dc.b	1
1567  003f 00            	dc.b	0
1568  0040 02            	dc.b	2
1569  0041 01            	dc.b	1
1570  0042 02            	dc.b	2
1571  0043 04            	dc.b	4
1572  0044 03            	dc.b	3
1573  0045 05            	dc.b	5
1574  0046 03            	dc.b	3
1575  0047 03            	dc.b	3
1576  0048 04            	dc.b	4
1577  0049 05            	dc.b	5
1578  004a 04            	dc.b	4
1579  004b 03            	dc.b	3
1580  004c 05            	dc.b	5
1581  004d 04            	dc.b	4
1582  004e 05            	dc.b	5
1626                     ; 227 void set_led(u8 led_index)
1626                     ; 228 {
1628                     	switch	.text
1629  039b               _set_led:
1631  039b 88            	push	a
1632  039c 5240          	subw	sp,#64
1633       00000040      OFST:	set	64
1636                     ; 229 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1636                     ; 230 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
1636                     ; 231 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
1636                     ; 232 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
1636                     ; 233 		{6,6},//debug; GND is tied low, no charlieplexing involved
1636                     ; 234 		{1,0},//LED7
1636                     ; 235 		{2,0},//LED8
1636                     ; 236 		{0,1},//LED9
1636                     ; 237 		{2,1},//LED10
1636                     ; 238 		{0,2},//LED11
1636                     ; 239 		{1,2},//LED12
1636                     ; 240 		{4,3},//LED13
1636                     ; 241 		{5,3},//LED14
1636                     ; 242 		{3,4},//LED15
1636                     ; 243 		{5,4},//LED16
1636                     ; 244 		{3,5},//LED17
1636                     ; 245 		{4,5} //LED18
1636                     ; 246 	};
1638  039e 96            	ldw	x,sp
1639  039f 1c0003        	addw	x,#OFST-61
1640  03a2 90ae0011      	ldw	y,#L734_led_lookup
1641  03a6 a63e          	ld	a,#62
1642  03a8 cd0000        	call	c_xymov
1644                     ; 247 	set_mat(led_lookup[led_index][0],1);
1646  03ab 96            	ldw	x,sp
1647  03ac 1c0003        	addw	x,#OFST-61
1648  03af 1f01          	ldw	(OFST-63,sp),x
1650  03b1 7b41          	ld	a,(OFST+1,sp)
1651  03b3 5f            	clrw	x
1652  03b4 97            	ld	xl,a
1653  03b5 58            	sllw	x
1654  03b6 72fb01        	addw	x,(OFST-63,sp)
1655  03b9 f6            	ld	a,(x)
1656  03ba ae0001        	ldw	x,#1
1657  03bd 95            	ld	xh,a
1658  03be ad1c          	call	_set_mat
1660                     ; 248 	if(led_index!=DEBUG_LED) set_mat(led_lookup[led_index][1],0);
1662  03c0 7b41          	ld	a,(OFST+1,sp)
1663  03c2 a106          	cp	a,#6
1664  03c4 2713          	jreq	L364
1667  03c6 96            	ldw	x,sp
1668  03c7 1c0004        	addw	x,#OFST-60
1669  03ca 1f01          	ldw	(OFST-63,sp),x
1671  03cc 7b41          	ld	a,(OFST+1,sp)
1672  03ce 5f            	clrw	x
1673  03cf 97            	ld	xl,a
1674  03d0 58            	sllw	x
1675  03d1 72fb01        	addw	x,(OFST-63,sp)
1676  03d4 f6            	ld	a,(x)
1677  03d5 5f            	clrw	x
1678  03d6 95            	ld	xh,a
1679  03d7 ad03          	call	_set_mat
1681  03d9               L364:
1682                     ; 249 }
1685  03d9 5b41          	addw	sp,#65
1686  03db 81            	ret
1887                     ; 251 void set_mat(u8 mat_index,bool is_high)
1887                     ; 252 {
1888                     	switch	.text
1889  03dc               _set_mat:
1891  03dc 89            	pushw	x
1892  03dd 5203          	subw	sp,#3
1893       00000003      OFST:	set	3
1896                     ; 255 	if(mat_index==0)
1898  03df 9e            	ld	a,xh
1899  03e0 4d            	tnz	a
1900  03e1 2609          	jrne	L306
1901                     ; 257 		GPIOx=GPIOC;
1903  03e3 ae500a        	ldw	x,#20490
1904  03e6 1f01          	ldw	(OFST-2,sp),x
1906                     ; 258 		GPIO_Pin=GPIO_PIN_3;
1908  03e8 a608          	ld	a,#8
1909  03ea 6b03          	ld	(OFST+0,sp),a
1911  03ec               L306:
1912                     ; 260 	if(mat_index==1)
1914  03ec 7b04          	ld	a,(OFST+1,sp)
1915  03ee a101          	cp	a,#1
1916  03f0 2609          	jrne	L506
1917                     ; 262 		GPIOx=GPIOC;
1919  03f2 ae500a        	ldw	x,#20490
1920  03f5 1f01          	ldw	(OFST-2,sp),x
1922                     ; 263 		GPIO_Pin=GPIO_PIN_4;
1924  03f7 a610          	ld	a,#16
1925  03f9 6b03          	ld	(OFST+0,sp),a
1927  03fb               L506:
1928                     ; 265 	if(mat_index==2)
1930  03fb 7b04          	ld	a,(OFST+1,sp)
1931  03fd a102          	cp	a,#2
1932  03ff 2609          	jrne	L706
1933                     ; 267 		GPIOx=GPIOC;
1935  0401 ae500a        	ldw	x,#20490
1936  0404 1f01          	ldw	(OFST-2,sp),x
1938                     ; 268 		GPIO_Pin=GPIO_PIN_5;
1940  0406 a620          	ld	a,#32
1941  0408 6b03          	ld	(OFST+0,sp),a
1943  040a               L706:
1944                     ; 270 	if(mat_index==3)
1946  040a 7b04          	ld	a,(OFST+1,sp)
1947  040c a103          	cp	a,#3
1948  040e 2609          	jrne	L116
1949                     ; 272 		GPIOx=GPIOC;
1951  0410 ae500a        	ldw	x,#20490
1952  0413 1f01          	ldw	(OFST-2,sp),x
1954                     ; 273 		GPIO_Pin=GPIO_PIN_6;
1956  0415 a640          	ld	a,#64
1957  0417 6b03          	ld	(OFST+0,sp),a
1959  0419               L116:
1960                     ; 275 	if(mat_index==4)
1962  0419 7b04          	ld	a,(OFST+1,sp)
1963  041b a104          	cp	a,#4
1964  041d 2609          	jrne	L316
1965                     ; 277 		GPIOx=GPIOC;
1967  041f ae500a        	ldw	x,#20490
1968  0422 1f01          	ldw	(OFST-2,sp),x
1970                     ; 278 		GPIO_Pin=GPIO_PIN_7;
1972  0424 a680          	ld	a,#128
1973  0426 6b03          	ld	(OFST+0,sp),a
1975  0428               L316:
1976                     ; 280 	if(mat_index==5)
1978  0428 7b04          	ld	a,(OFST+1,sp)
1979  042a a105          	cp	a,#5
1980  042c 2609          	jrne	L516
1981                     ; 282 		GPIOx=GPIOD;
1983  042e ae500f        	ldw	x,#20495
1984  0431 1f01          	ldw	(OFST-2,sp),x
1986                     ; 283 		GPIO_Pin=GPIO_PIN_2;
1988  0433 a604          	ld	a,#4
1989  0435 6b03          	ld	(OFST+0,sp),a
1991  0437               L516:
1992                     ; 285 	if(mat_index==6)
1994  0437 7b04          	ld	a,(OFST+1,sp)
1995  0439 a106          	cp	a,#6
1996  043b 2609          	jrne	L716
1997                     ; 287 		GPIOx=GPIOA;
1999  043d ae5000        	ldw	x,#20480
2000  0440 1f01          	ldw	(OFST-2,sp),x
2002                     ; 288 		GPIO_Pin=GPIO_PIN_3;
2004  0442 a608          	ld	a,#8
2005  0444 6b03          	ld	(OFST+0,sp),a
2007  0446               L716:
2008                     ; 290 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2010  0446 0d05          	tnz	(OFST+2,sp)
2011  0448 2708          	jreq	L126
2014  044a 1e01          	ldw	x,(OFST-2,sp)
2015  044c f6            	ld	a,(x)
2016  044d 1a03          	or	a,(OFST+0,sp)
2017  044f f7            	ld	(x),a
2019  0450 2007          	jra	L326
2020  0452               L126:
2021                     ; 291 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2023  0452 1e01          	ldw	x,(OFST-2,sp)
2024  0454 7b03          	ld	a,(OFST+0,sp)
2025  0456 43            	cpl	a
2026  0457 f4            	and	a,(x)
2027  0458 f7            	ld	(x),a
2028  0459               L326:
2029                     ; 292 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2031  0459 1e01          	ldw	x,(OFST-2,sp)
2032  045b e602          	ld	a,(2,x)
2033  045d 1a03          	or	a,(OFST+0,sp)
2034  045f e702          	ld	(2,x),a
2035                     ; 293 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2037  0461 1e01          	ldw	x,(OFST-2,sp)
2038  0463 e603          	ld	a,(3,x)
2039  0465 1a03          	or	a,(OFST+0,sp)
2040  0467 e703          	ld	(3,x),a
2041                     ; 294 }
2044  0469 5b05          	addw	sp,#5
2045  046b 81            	ret
2079                     ; 303 void flush_leds(u8 led_count)
2079                     ; 304 {
2080                     	switch	.text
2081  046c               _flush_leds:
2085                     ; 327 }
2088  046c 81            	ret
2177                     ; 329 void set_hue(u8 index,u16 color,u8 brightness)
2177                     ; 330 {
2178                     	switch	.text
2179  046d               _set_hue:
2181  046d 88            	push	a
2182  046e 5205          	subw	sp,#5
2183       00000005      OFST:	set	5
2186                     ; 331 	u8 red=0,green=0,blue=0;
2188  0470 0f01          	clr	(OFST-4,sp)
2192  0472 0f02          	clr	(OFST-3,sp)
2196  0474 0f03          	clr	(OFST-2,sp)
2198                     ; 332 	u16 residual=color%(0x2AAB);
2200  0476 1e09          	ldw	x,(OFST+4,sp)
2201  0478 90ae2aab      	ldw	y,#10923
2202  047c 65            	divw	x,y
2203  047d 51            	exgw	x,y
2204  047e 1f04          	ldw	(OFST-1,sp),x
2206                     ; 333 	residual=(u8)(residual*brightness/0x2AAB);
2208  0480 1e04          	ldw	x,(OFST-1,sp)
2209  0482 7b0b          	ld	a,(OFST+6,sp)
2210  0484 cd0000        	call	c_bmulx
2212  0487 90ae2aab      	ldw	y,#10923
2213  048b 65            	divw	x,y
2214  048c 9f            	ld	a,xl
2215  048d 5f            	clrw	x
2216  048e 97            	ld	xl,a
2217  048f 1f04          	ldw	(OFST-1,sp),x
2219                     ; 334 	switch(color/(0x2AAB))//0xFFFF/6
2221  0491 1e09          	ldw	x,(OFST+4,sp)
2222  0493 90ae2aab      	ldw	y,#10923
2223  0497 65            	divw	x,y
2225                     ; 365 			break;
2226  0498 5d            	tnzw	x
2227  0499 2711          	jreq	L346
2228  049b 5a            	decw	x
2229  049c 271a          	jreq	L546
2230  049e 5a            	decw	x
2231  049f 2725          	jreq	L746
2232  04a1 5a            	decw	x
2233  04a2 272e          	jreq	L156
2234  04a4 5a            	decw	x
2235  04a5 2739          	jreq	L356
2236  04a7 5a            	decw	x
2237  04a8 2742          	jreq	L556
2238  04aa 204c          	jra	L137
2239  04ac               L346:
2240                     ; 337 			red=brightness;
2242  04ac 7b0b          	ld	a,(OFST+6,sp)
2243  04ae 6b01          	ld	(OFST-4,sp),a
2245                     ; 338 			green=residual;
2247  04b0 7b05          	ld	a,(OFST+0,sp)
2248  04b2 6b02          	ld	(OFST-3,sp),a
2250                     ; 339 			blue=0;
2252  04b4 0f03          	clr	(OFST-2,sp)
2254                     ; 340 			break;
2256  04b6 2040          	jra	L137
2257  04b8               L546:
2258                     ; 342 			red=brightness-residual;
2260  04b8 7b0b          	ld	a,(OFST+6,sp)
2261  04ba 1005          	sub	a,(OFST+0,sp)
2262  04bc 6b01          	ld	(OFST-4,sp),a
2264                     ; 343 			green=brightness;
2266  04be 7b0b          	ld	a,(OFST+6,sp)
2267  04c0 6b02          	ld	(OFST-3,sp),a
2269                     ; 344 			blue=0;
2271  04c2 0f03          	clr	(OFST-2,sp)
2273                     ; 345 			break;
2275  04c4 2032          	jra	L137
2276  04c6               L746:
2277                     ; 347 			red=0;
2279  04c6 0f01          	clr	(OFST-4,sp)
2281                     ; 348 			green=brightness;
2283  04c8 7b0b          	ld	a,(OFST+6,sp)
2284  04ca 6b02          	ld	(OFST-3,sp),a
2286                     ; 349 			blue=residual;
2288  04cc 7b05          	ld	a,(OFST+0,sp)
2289  04ce 6b03          	ld	(OFST-2,sp),a
2291                     ; 350 			break;
2293  04d0 2026          	jra	L137
2294  04d2               L156:
2295                     ; 352 			red=0;
2297  04d2 0f01          	clr	(OFST-4,sp)
2299                     ; 353 			green=brightness-residual;
2301  04d4 7b0b          	ld	a,(OFST+6,sp)
2302  04d6 1005          	sub	a,(OFST+0,sp)
2303  04d8 6b02          	ld	(OFST-3,sp),a
2305                     ; 354 			blue=brightness;
2307  04da 7b0b          	ld	a,(OFST+6,sp)
2308  04dc 6b03          	ld	(OFST-2,sp),a
2310                     ; 355 			break;
2312  04de 2018          	jra	L137
2313  04e0               L356:
2314                     ; 357 			red=residual;
2316  04e0 7b05          	ld	a,(OFST+0,sp)
2317  04e2 6b01          	ld	(OFST-4,sp),a
2319                     ; 358 			green=0;
2321  04e4 0f02          	clr	(OFST-3,sp)
2323                     ; 359 			blue=brightness;
2325  04e6 7b0b          	ld	a,(OFST+6,sp)
2326  04e8 6b03          	ld	(OFST-2,sp),a
2328                     ; 360 			break;
2330  04ea 200c          	jra	L137
2331  04ec               L556:
2332                     ; 362 			red=brightness;
2334  04ec 7b0b          	ld	a,(OFST+6,sp)
2335  04ee 6b01          	ld	(OFST-4,sp),a
2337                     ; 363 			green=0;
2339  04f0 0f02          	clr	(OFST-3,sp)
2341                     ; 364 			blue=brightness-residual;
2343  04f2 7b0b          	ld	a,(OFST+6,sp)
2344  04f4 1005          	sub	a,(OFST+0,sp)
2345  04f6 6b03          	ld	(OFST-2,sp),a
2347                     ; 365 			break;
2349  04f8               L137:
2350                     ; 368 	set_rgb(index,0,red);
2352  04f8 7b01          	ld	a,(OFST-4,sp)
2353  04fa 88            	push	a
2354  04fb 7b07          	ld	a,(OFST+2,sp)
2355  04fd 5f            	clrw	x
2356  04fe 95            	ld	xh,a
2357  04ff ad1c          	call	_set_rgb
2359  0501 84            	pop	a
2360                     ; 369 	set_rgb(index,1,green);
2362  0502 7b02          	ld	a,(OFST-3,sp)
2363  0504 88            	push	a
2364  0505 7b07          	ld	a,(OFST+2,sp)
2365  0507 ae0001        	ldw	x,#1
2366  050a 95            	ld	xh,a
2367  050b ad10          	call	_set_rgb
2369  050d 84            	pop	a
2370                     ; 370 	set_rgb(index,2,blue);
2372  050e 7b03          	ld	a,(OFST-2,sp)
2373  0510 88            	push	a
2374  0511 7b07          	ld	a,(OFST+2,sp)
2375  0513 ae0002        	ldw	x,#2
2376  0516 95            	ld	xh,a
2377  0517 ad04          	call	_set_rgb
2379  0519 84            	pop	a
2380                     ; 371 }
2383  051a 5b06          	addw	sp,#6
2384  051c 81            	ret
2437                     ; 373 void set_rgb(u8 index,u8 color,u8 brightness)
2437                     ; 374 {
2438                     	switch	.text
2439  051d               _set_rgb:
2441  051d 89            	pushw	x
2442       00000000      OFST:	set	0
2445                     ; 375 	pwm_brightness_buffer[index*3+color]=brightness;
2447  051e 9e            	ld	a,xh
2448  051f 97            	ld	xl,a
2449  0520 a603          	ld	a,#3
2450  0522 42            	mul	x,a
2451  0523 01            	rrwa	x,a
2452  0524 1b02          	add	a,(OFST+2,sp)
2453  0526 2401          	jrnc	L441
2454  0528 5c            	incw	x
2455  0529               L441:
2456  0529 02            	rlwa	x,a
2457  052a 7b05          	ld	a,(OFST+5,sp)
2458  052c e70e          	ld	(_pwm_brightness_buffer,x),a
2459                     ; 376 }
2462  052e 85            	popw	x
2463  052f 81            	ret
2507                     ; 378 void set_white(u8 index,u8 brightness)
2507                     ; 379 {
2508                     	switch	.text
2509  0530               _set_white:
2511  0530 89            	pushw	x
2512       00000000      OFST:	set	0
2515                     ; 380 	pwm_brightness_buffer[DEBUG_LED+1+index]=brightness;
2517  0531 9e            	ld	a,xh
2518  0532 5f            	clrw	x
2519  0533 97            	ld	xl,a
2520  0534 7b02          	ld	a,(OFST+2,sp)
2521  0536 e715          	ld	(_pwm_brightness_buffer+7,x),a
2522                     ; 381 }
2525  0538 85            	popw	x
2526  0539 81            	ret
2561                     ; 384 void set_debug(u8 brightness)
2561                     ; 385 {
2562                     	switch	.text
2563  053a               _set_debug:
2567                     ; 386 	pwm_brightness_buffer[DEBUG_LED]=brightness;
2569  053a b714          	ld	_pwm_brightness_buffer+6,a
2570                     ; 387 }
2573  053c 81            	ret
2596                     ; 389 void set_matrix_high_z()
2596                     ; 390 {
2597                     	switch	.text
2598  053d               _set_matrix_high_z:
2602                     ; 394 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
2604  053d c6500d        	ld	a,20493
2605  0540 a407          	and	a,#7
2606  0542 c7500d        	ld	20493,a
2607                     ; 395 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
2609  0545 72155012      	bres	20498,#2
2610                     ; 396 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
2612  0549 72175003      	bres	20483,#3
2613                     ; 397 }
2616  054d 81            	ret
2650                     ; 399 u8 get_eeprom_byte(u16 eeprom_address)
2650                     ; 400 {
2651                     	switch	.text
2652  054e               _get_eeprom_byte:
2656                     ; 401 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2658  054e d64000        	ld	a,(16384,x)
2661  0551 81            	ret
2817                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2818                     	xdef	_temp3_delete_me
2819                     	xdef	_temp_delete_me
2820                     	switch	.ubsct
2821  0000               _button_pressed_event:
2822  0000 00000000      	ds.b	4
2823                     	xdef	_button_pressed_event
2824  0004               _button_start_ms:
2825  0004 00000000      	ds.b	4
2826                     	xdef	_button_start_ms
2827                     	xdef	_pwm_state
2828                     	xdef	_pwm_visible_index
2829                     	xdef	_pwm_sleep_remaining
2830  0008               _pwm_led_count:
2831  0008 0000          	ds.b	2
2832                     	xdef	_pwm_led_count
2833  000a               _pwm_sleep:
2834  000a 00000000      	ds.b	4
2835                     	xdef	_pwm_sleep
2836  000e               _pwm_brightness_buffer:
2837  000e 000000000000  	ds.b	31
2838                     	xdef	_pwm_brightness_buffer
2839  002d               _pwm_brightness_index:
2840  002d 000000000000  	ds.b	62
2841                     	xdef	_pwm_brightness_index
2842  006b               _pwm_brightness:
2843  006b 000000000000  	ds.b	124
2844                     	xdef	_pwm_brightness
2845                     	xdef	_PWM_MAX_PERIOD
2846                     	xdef	_api_counter
2847                     	xref	_UART1_Cmd
2848                     	xref	_UART1_Init
2849                     	xref	_UART1_DeInit
2850                     	xref	_GPIO_ReadInputPin
2851                     	xref	_GPIO_Init
2852                     	xdef	_set_led
2853                     	xdef	_set_mat
2854                     	xdef	_get_eeprom_byte
2855                     	xdef	_get_random
2856                     	xdef	_is_button_down
2857                     	xdef	_clear_button_events
2858                     	xdef	_clear_button_event
2859                     	xdef	_get_button_event
2860                     	xdef	_update_buttons
2861                     	xdef	_is_developer_valid
2862                     	xdef	_set_hue
2863                     	xdef	_flush_leds
2864                     	xdef	_set_debug
2865                     	xdef	_set_white
2866                     	xdef	_set_rgb
2867                     	xdef	_set_matrix_high_z
2868                     	xdef	_millis
2869                     	xdef	_setup_main
2870                     	xdef	_is_application_valid
2871                     	xdef	_setup_serial
2872                     	xdef	_hello_world
2873                     	xref.b	c_lreg
2874                     	xref.b	c_x
2875                     	xref.b	c_y
2895                     	xref	c_bmulx
2896                     	xref	c_xymov
2897                     	xref	c_lgadd
2898                     	xref	c_lzmp
2899                     	xref	c_lsub
2900                     	xref	c_rtol
2901                     	xref	c_uitolx
2902                     	xref	c_lursh
2903                     	xref	c_itolx
2904                     	xref	c_imul
2905                     	xref	c_lrzmp
2906                     	xref	c_lmod
2907                     	xref	c_ldiv
2908                     	xref	c_ltor
2909                     	xref	c_lgadc
2910                     	end
