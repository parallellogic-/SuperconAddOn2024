   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _hw_revision:
  16  0000 01            	dc.b	1
  17                     	bsct
  18  0000               _api_counter:
  19  0000 00000000      	dc.l	0
  20                     	switch	.const
  21  0001               _PWM_MAX_PERIOD:
  22  0001 fa            	dc.b	250
  23                     	bsct
  24  0004               _pwm_sleep_remaining:
  25  0004 0000          	dc.w	0
  26  0006               _pwm_led_index:
  27  0006 00            	dc.b	0
  28  0007               _pwm_state:
  29  0007 00            	dc.b	0
  30  0008               _audio_measurement_count:
  31  0008 00            	dc.b	0
 102                     	switch	.const
 103  0002               L21:
 104  0002 000003e8      	dc.l	1000
 105                     ; 87 void hello_world()
 105                     ; 88 {//basic program that blinks the debug LED ON/OFF
 106                     	scross	off
 107                     	switch	.text
 108  0000               _hello_world:
 110  0000 5205          	subw	sp,#5
 111       00000005      OFST:	set	5
 114                     ; 89 	bool is_high=0;
 116  0002 0f05          	clr	(OFST+0,sp)
 118                     ; 90 	long frame=0;
 120  0004 ae0000        	ldw	x,#0
 121  0007 1f03          	ldw	(OFST-2,sp),x
 122  0009 ae0000        	ldw	x,#0
 123  000c 1f01          	ldw	(OFST-4,sp),x
 125                     ; 91 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 127  000e 4b40          	push	#64
 128  0010 4b08          	push	#8
 129  0012 ae5000        	ldw	x,#20480
 130  0015 cd0000        	call	_GPIO_Init
 132  0018 85            	popw	x
 133  0019               L34:
 134                     ; 94 		GPIO_Init(GPIOA, GPIO_PIN_3, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
 136  0019 0d05          	tnz	(OFST+0,sp)
 137  001b 2704          	jreq	L6
 138  001d a6d0          	ld	a,#208
 139  001f 2002          	jra	L01
 140  0021               L6:
 141  0021 a6c0          	ld	a,#192
 142  0023               L01:
 143  0023 88            	push	a
 144  0024 4b08          	push	#8
 145  0026 ae5000        	ldw	x,#20480
 146  0029 cd0000        	call	_GPIO_Init
 148  002c 85            	popw	x
 149                     ; 95 		frame++;
 151  002d 96            	ldw	x,sp
 152  002e 1c0001        	addw	x,#OFST-4
 153  0031 a601          	ld	a,#1
 154  0033 cd0000        	call	c_lgadc
 157                     ; 96 		if(frame%1000==0)
 159  0036 96            	ldw	x,sp
 160  0037 1c0001        	addw	x,#OFST-4
 161  003a cd0000        	call	c_ltor
 163  003d ae0002        	ldw	x,#L21
 164  0040 cd0000        	call	c_lmod
 166  0043 cd0000        	call	c_lrzmp
 168  0046 26d1          	jrne	L34
 169                     ; 98 			is_high=!is_high;
 171  0048 0d05          	tnz	(OFST+0,sp)
 172  004a 2604          	jrne	L41
 173  004c a601          	ld	a,#1
 174  004e 2001          	jra	L61
 175  0050               L41:
 176  0050 4f            	clr	a
 177  0051               L61:
 178  0051 6b05          	ld	(OFST+0,sp),a
 180  0053 20c4          	jra	L34
 232                     ; 103 u16 get_random(u16 x)
 232                     ; 104 {
 233                     	switch	.text
 234  0055               _get_random:
 236  0055 5204          	subw	sp,#4
 237       00000004      OFST:	set	4
 240                     ; 105 	u16 a=1664525;
 242                     ; 106 	u16 c=1013904223;
 244                     ; 107 	return a * x + c;
 246  0057 90ae660d      	ldw	y,#26125
 247  005b cd0000        	call	c_imul
 249  005e 1cf35f        	addw	x,#62303
 252  0061 5b04          	addw	sp,#4
 253  0063 81            	ret
 302                     	switch	.const
 303  0006               L03:
 304  0006 000f4240      	dc.l	1000000
 305                     ; 110 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 305                     ; 111 {
 306                     	switch	.text
 307  0064               _setup_serial:
 309  0064 89            	pushw	x
 310       00000000      OFST:	set	0
 313                     ; 112 	if(is_enabled)
 315  0065 9e            	ld	a,xh
 316  0066 4d            	tnz	a
 317  0067 2747          	jreq	L121
 318                     ; 114 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 320  0069 4bf0          	push	#240
 321  006b 4b20          	push	#32
 322  006d ae500f        	ldw	x,#20495
 323  0070 cd0000        	call	_GPIO_Init
 325  0073 85            	popw	x
 326                     ; 115 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 328  0074 4b40          	push	#64
 329  0076 4b40          	push	#64
 330  0078 ae500f        	ldw	x,#20495
 331  007b cd0000        	call	_GPIO_Init
 333  007e 85            	popw	x
 334                     ; 116 		UART1_DeInit();
 336  007f cd0000        	call	_UART1_DeInit
 338                     ; 117 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 340  0082 4b0c          	push	#12
 341  0084 4b80          	push	#128
 342  0086 4b00          	push	#0
 343  0088 4b00          	push	#0
 344  008a 4b00          	push	#0
 345  008c 0d07          	tnz	(OFST+7,sp)
 346  008e 2708          	jreq	L42
 347  0090 ae2580        	ldw	x,#9600
 348  0093 cd0000        	call	c_itolx
 350  0096 2006          	jra	L62
 351  0098               L42:
 352  0098 ae0006        	ldw	x,#L03
 353  009b cd0000        	call	c_ltor
 355  009e               L62:
 356  009e be02          	ldw	x,c_lreg+2
 357  00a0 89            	pushw	x
 358  00a1 be00          	ldw	x,c_lreg
 359  00a3 89            	pushw	x
 360  00a4 cd0000        	call	_UART1_Init
 362  00a7 5b09          	addw	sp,#9
 363                     ; 118 		UART1_Cmd(ENABLE);
 365  00a9 a601          	ld	a,#1
 366  00ab cd0000        	call	_UART1_Cmd
 369  00ae 201d          	jra	L321
 370  00b0               L121:
 371                     ; 120 		UART1_Cmd(DISABLE);
 373  00b0 4f            	clr	a
 374  00b1 cd0000        	call	_UART1_Cmd
 376                     ; 121 		UART1_DeInit();
 378  00b4 cd0000        	call	_UART1_DeInit
 380                     ; 122 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 382  00b7 4b40          	push	#64
 383  00b9 4b20          	push	#32
 384  00bb ae500f        	ldw	x,#20495
 385  00be cd0000        	call	_GPIO_Init
 387  00c1 85            	popw	x
 388                     ; 123 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 390  00c2 4b40          	push	#64
 391  00c4 4b40          	push	#64
 392  00c6 ae500f        	ldw	x,#20495
 393  00c9 cd0000        	call	_GPIO_Init
 395  00cc 85            	popw	x
 396  00cd               L321:
 397                     ; 125 }
 400  00cd 85            	popw	x
 401  00ce 81            	ret
 428                     ; 128 bool is_application_valid()
 428                     ; 129 {
 429                     	switch	.text
 430  00cf               _is_application_valid:
 434                     ; 130 	return !is_button_down(2) && !get_button_event(0,1);
 436  00cf a602          	ld	a,#2
 437  00d1 cd0232        	call	_is_button_down
 439  00d4 4d            	tnz	a
 440  00d5 260d          	jrne	L43
 441  00d7 ae0001        	ldw	x,#1
 442  00da cd01e3        	call	_get_button_event
 444  00dd 4d            	tnz	a
 445  00de 2604          	jrne	L43
 446  00e0 a601          	ld	a,#1
 447  00e2 2001          	jra	L63
 448  00e4               L43:
 449  00e4 4f            	clr	a
 450  00e5               L63:
 453  00e5 81            	ret
 479                     ; 134 bool is_developer_valid()
 479                     ; 135 {
 480                     	switch	.text
 481  00e6               _is_developer_valid:
 485                     ; 136 	return is_button_down(2) && !get_button_event(0,1);
 487  00e6 a602          	ld	a,#2
 488  00e8 cd0232        	call	_is_button_down
 490  00eb 4d            	tnz	a
 491  00ec 270d          	jreq	L24
 492  00ee ae0001        	ldw	x,#1
 493  00f1 cd01e3        	call	_get_button_event
 495  00f4 4d            	tnz	a
 496  00f5 2604          	jrne	L24
 497  00f7 a601          	ld	a,#1
 498  00f9 2001          	jra	L44
 499  00fb               L24:
 500  00fb 4f            	clr	a
 501  00fc               L44:
 504  00fc 81            	ret
 529                     ; 140 bool is_sleep_valid()
 529                     ; 141 {
 530                     	switch	.text
 531  00fd               _is_sleep_valid:
 535                     ; 142 	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
 537  00fd 5f            	clrw	x
 538  00fe cd01e3        	call	_get_button_event
 540  0101 4d            	tnz	a
 541  0102 261f          	jrne	L05
 542  0104 ae0100        	ldw	x,#256
 543  0107 cd01e3        	call	_get_button_event
 545  010a 4d            	tnz	a
 546  010b 2616          	jrne	L05
 547  010d ae0001        	ldw	x,#1
 548  0110 cd01e3        	call	_get_button_event
 550  0113 4d            	tnz	a
 551  0114 260d          	jrne	L05
 552  0116 ae0101        	ldw	x,#257
 553  0119 cd01e3        	call	_get_button_event
 555  011c 4d            	tnz	a
 556  011d 2604          	jrne	L05
 557  011f a601          	ld	a,#1
 558  0121 2001          	jra	L25
 559  0123               L05:
 560  0123 4f            	clr	a
 561  0124               L25:
 564  0124 81            	ret
 590                     ; 145 void setup_main()
 590                     ; 146 {
 591                     	switch	.text
 592  0125               _setup_main:
 596                     ; 147 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 598  0125 c650c6        	ld	a,20678
 599  0128 a4e7          	and	a,#231
 600  012a c750c6        	ld	20678,a
 601                     ; 149 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 603  012d 4b40          	push	#64
 604  012f 4b02          	push	#2
 605  0131 ae500f        	ldw	x,#20495
 606  0134 cd0000        	call	_GPIO_Init
 608  0137 85            	popw	x
 609                     ; 152 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 611  0138 725f5311      	clr	21265
 612                     ; 153 	TIM2->PSCR= 6;// init divider register 16MHz/2^X
 614  013c 3506530e      	mov	21262,#6
 615                     ; 154 	TIM2->ARRH= 0;// init auto reload register
 617  0140 725f530f      	clr	21263
 618                     ; 155 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 620  0144 35fa5310      	mov	21264,#250
 621                     ; 156 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 623  0148 c65300        	ld	a,21248
 624  014b aa85          	or	a,#133
 625  014d c75300        	ld	21248,a
 626                     ; 157 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 628  0150 35035303      	mov	21251,#3
 629                     ; 158 	enableInterrupts();
 632  0154 9a            rim
 634                     ; 160 }
 638  0155 81            	ret
 662                     ; 162 u32 millis()
 662                     ; 163 {
 663                     	switch	.text
 664  0156               _millis:
 668                     ; 164 	return api_counter;
 670  0156 ae0000        	ldw	x,#_api_counter
 671  0159 cd0000        	call	c_ltor
 675  015c 81            	ret
 710                     ; 167 void set_millis(u32 new_time)
 710                     ; 168 {
 711                     	switch	.text
 712  015d               _set_millis:
 714       00000000      OFST:	set	0
 717                     ; 169 	api_counter=new_time;
 719  015d 1e05          	ldw	x,(OFST+5,sp)
 720  015f bf02          	ldw	_api_counter+2,x
 721  0161 1e03          	ldw	x,(OFST+3,sp)
 722  0163 bf00          	ldw	_api_counter,x
 723                     ; 170 }
 726  0165 81            	ret
 784                     ; 175 void update_buttons()
 784                     ; 176 {
 785                     	switch	.text
 786  0166               _update_buttons:
 788  0166 5208          	subw	sp,#8
 789       00000008      OFST:	set	8
 792                     ; 177 	bool is_any_down=0;
 794  0168 0f05          	clr	(OFST-3,sp)
 796                     ; 179 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 798  016a be0c          	ldw	x,_button_start_ms+2
 799  016c cd0000        	call	c_uitolx
 801  016f 96            	ldw	x,sp
 802  0170 1c0001        	addw	x,#OFST-7
 803  0173 cd0000        	call	c_rtol
 806  0176 adde          	call	_millis
 808  0178 96            	ldw	x,sp
 809  0179 1c0001        	addw	x,#OFST-7
 810  017c cd0000        	call	c_lsub
 812  017f be02          	ldw	x,c_lreg+2
 813  0181 1f06          	ldw	(OFST-2,sp),x
 815                     ; 180 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 817  0183 0f08          	clr	(OFST+0,sp)
 819  0185               L142:
 820                     ; 182 		if(is_button_down(button_index))
 822  0185 7b08          	ld	a,(OFST+0,sp)
 823  0187 cd0232        	call	_is_button_down
 825  018a 4d            	tnz	a
 826  018b 271b          	jreq	L742
 827                     ; 184 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 829  018d ae000a        	ldw	x,#_button_start_ms
 830  0190 cd0000        	call	c_lzmp
 832  0193 2608          	jrne	L152
 835  0195 adbf          	call	_millis
 837  0197 ae000a        	ldw	x,#_button_start_ms
 838  019a cd0000        	call	c_rtol
 840  019d               L152:
 841                     ; 185 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 843  019d a6ff          	ld	a,#255
 844  019f cd03fe        	call	_set_debug
 846                     ; 186 			is_any_down=1;
 848  01a2 a601          	ld	a,#1
 849  01a4 6b05          	ld	(OFST-3,sp),a
 852  01a6 2022          	jra	L352
 853  01a8               L742:
 854                     ; 188 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 856  01a8 1e06          	ldw	x,(OFST-2,sp)
 857  01aa a30201        	cpw	x,#513
 858  01ad 250b          	jrult	L552
 861  01af 7b08          	ld	a,(OFST+0,sp)
 862  01b1 5f            	clrw	x
 863  01b2 97            	ld	xl,a
 864  01b3 58            	sllw	x
 865  01b4 a601          	ld	a,#1
 866  01b6 e707          	ld	(_button_pressed_event+1,x),a
 868  01b8 2010          	jra	L352
 869  01ba               L552:
 870                     ; 189 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 872  01ba 1e06          	ldw	x,(OFST-2,sp)
 873  01bc a30033        	cpw	x,#51
 874  01bf 2509          	jrult	L352
 877  01c1 7b08          	ld	a,(OFST+0,sp)
 878  01c3 5f            	clrw	x
 879  01c4 97            	ld	xl,a
 880  01c5 58            	sllw	x
 881  01c6 a601          	ld	a,#1
 882  01c8 e706          	ld	(_button_pressed_event,x),a
 883  01ca               L352:
 884                     ; 180 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 886  01ca 0c08          	inc	(OFST+0,sp)
 890  01cc 7b08          	ld	a,(OFST+0,sp)
 891  01ce a102          	cp	a,#2
 892  01d0 25b3          	jrult	L142
 893                     ; 193 	if(!is_any_down) button_start_ms=0;
 895  01d2 0d05          	tnz	(OFST-3,sp)
 896  01d4 260a          	jrne	L362
 899  01d6 ae0000        	ldw	x,#0
 900  01d9 bf0c          	ldw	_button_start_ms+2,x
 901  01db ae0000        	ldw	x,#0
 902  01de bf0a          	ldw	_button_start_ms,x
 903  01e0               L362:
 904                     ; 194 }
 907  01e0 5b08          	addw	sp,#8
 908  01e2 81            	ret
 954                     ; 197 bool get_button_event(u8 button_index,bool is_long)
 954                     ; 198 { return button_pressed_event[button_index][is_long]; }
 955                     	switch	.text
 956  01e3               _get_button_event:
 958  01e3 89            	pushw	x
 959       00000000      OFST:	set	0
 964  01e4 9e            	ld	a,xh
 965  01e5 5f            	clrw	x
 966  01e6 97            	ld	xl,a
 967  01e7 58            	sllw	x
 968  01e8 01            	rrwa	x,a
 969  01e9 1b02          	add	a,(OFST+2,sp)
 970  01eb 2401          	jrnc	L66
 971  01ed 5c            	incw	x
 972  01ee               L66:
 973  01ee 02            	rlwa	x,a
 974  01ef e606          	ld	a,(_button_pressed_event,x)
 977  01f1 85            	popw	x
 978  01f2 81            	ret
1034                     ; 201 bool clear_button_event(u8 button_index,bool is_long)
1034                     ; 202 {
1035                     	switch	.text
1036  01f3               _clear_button_event:
1038  01f3 89            	pushw	x
1039  01f4 88            	push	a
1040       00000001      OFST:	set	1
1043                     ; 203 	bool out=button_pressed_event[button_index][is_long];
1045  01f5 9e            	ld	a,xh
1046  01f6 5f            	clrw	x
1047  01f7 97            	ld	xl,a
1048  01f8 58            	sllw	x
1049  01f9 01            	rrwa	x,a
1050  01fa 1b03          	add	a,(OFST+2,sp)
1051  01fc 2401          	jrnc	L27
1052  01fe 5c            	incw	x
1053  01ff               L27:
1054  01ff 02            	rlwa	x,a
1055  0200 e606          	ld	a,(_button_pressed_event,x)
1056  0202 6b01          	ld	(OFST+0,sp),a
1058                     ; 204 	button_pressed_event[button_index][is_long]=0;
1060  0204 7b02          	ld	a,(OFST+1,sp)
1061  0206 5f            	clrw	x
1062  0207 97            	ld	xl,a
1063  0208 58            	sllw	x
1064  0209 01            	rrwa	x,a
1065  020a 1b03          	add	a,(OFST+2,sp)
1066  020c 2401          	jrnc	L47
1067  020e 5c            	incw	x
1068  020f               L47:
1069  020f 02            	rlwa	x,a
1070  0210 6f06          	clr	(_button_pressed_event,x)
1071                     ; 205 	return out;
1073  0212 7b01          	ld	a,(OFST+0,sp)
1076  0214 5b03          	addw	sp,#3
1077  0216 81            	ret
1113                     ; 208 void clear_button_events()
1113                     ; 209 {
1114                     	switch	.text
1115  0217               _clear_button_events:
1117  0217 88            	push	a
1118       00000001      OFST:	set	1
1121                     ; 211 	for(iter=0;iter<BUTTON_COUNT;iter++)
1123  0218 0f01          	clr	(OFST+0,sp)
1125  021a               L353:
1126                     ; 213 		clear_button_event(iter,0);
1128  021a 7b01          	ld	a,(OFST+0,sp)
1129  021c 5f            	clrw	x
1130  021d 95            	ld	xh,a
1131  021e add3          	call	_clear_button_event
1133                     ; 214 		clear_button_event(iter,1);
1135  0220 7b01          	ld	a,(OFST+0,sp)
1136  0222 ae0001        	ldw	x,#1
1137  0225 95            	ld	xh,a
1138  0226 adcb          	call	_clear_button_event
1140                     ; 211 	for(iter=0;iter<BUTTON_COUNT;iter++)
1142  0228 0c01          	inc	(OFST+0,sp)
1146  022a 7b01          	ld	a,(OFST+0,sp)
1147  022c a102          	cp	a,#2
1148  022e 25ea          	jrult	L353
1149                     ; 216 }
1152  0230 84            	pop	a
1153  0231 81            	ret
1189                     ; 219 bool is_button_down(u8 index)
1189                     ; 220 {
1190                     	switch	.text
1191  0232               _is_button_down:
1195                     ; 221 	switch(index)
1198                     ; 225 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1200  0232 4d            	tnz	a
1201  0233 2708          	jreq	L163
1202  0235 4a            	dec	a
1203  0236 2718          	jreq	L363
1204  0238 4a            	dec	a
1205  0239 2728          	jreq	L563
1206  023b 2039          	jra	L704
1207  023d               L163:
1208                     ; 223 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1210  023d 4b20          	push	#32
1211  023f ae500f        	ldw	x,#20495
1212  0242 cd0000        	call	_GPIO_ReadInputPin
1214  0245 5b01          	addw	sp,#1
1215  0247 4d            	tnz	a
1216  0248 2604          	jrne	L201
1217  024a a601          	ld	a,#1
1218  024c 2001          	jra	L401
1219  024e               L201:
1220  024e 4f            	clr	a
1221  024f               L401:
1224  024f 81            	ret
1225  0250               L363:
1226                     ; 224 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1229  0250 4b40          	push	#64
1230  0252 ae500f        	ldw	x,#20495
1231  0255 cd0000        	call	_GPIO_ReadInputPin
1233  0258 5b01          	addw	sp,#1
1234  025a 4d            	tnz	a
1235  025b 2604          	jrne	L601
1236  025d a601          	ld	a,#1
1237  025f 2001          	jra	L011
1238  0261               L601:
1239  0261 4f            	clr	a
1240  0262               L011:
1243  0262 81            	ret
1244  0263               L563:
1245                     ; 225 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1248  0263 4b02          	push	#2
1249  0265 ae500f        	ldw	x,#20495
1250  0268 cd0000        	call	_GPIO_ReadInputPin
1252  026b 5b01          	addw	sp,#1
1253  026d 4d            	tnz	a
1254  026e 2604          	jrne	L211
1255  0270 a601          	ld	a,#1
1256  0272 2001          	jra	L411
1257  0274               L211:
1258  0274 4f            	clr	a
1259  0275               L411:
1262  0275 81            	ret
1263  0276               L704:
1264                     ; 227 	return 0;
1266  0276 4f            	clr	a
1269  0277 81            	ret
1293                     ; 230 u8 get_audio_level()
1293                     ; 231 { return audio_std; }
1294                     	switch	.text
1295  0278               _get_audio_level:
1301  0278 b604          	ld	a,_audio_std
1304  027a 81            	ret
1329                     ; 234 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1331                     	switch	.text
1332  027b               f_TIM2_UPD_OVF_IRQHandler:
1336                     ; 235 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1338  027b 72115304      	bres	21252,#0
1339                     ; 236 	api_counter++;
1341  027f ae0000        	ldw	x,#_api_counter
1342  0282 a601          	ld	a,#1
1343  0284 cd0000        	call	c_lgadc
1345                     ; 240 }
1348  0287 80            	iret
1371                     ; 243 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
1372                     	switch	.text
1373  0288               f_TIM2_CapComp_IRQ_Handler:
1377                     ; 244 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
1379  0288 72135304      	bres	21252,#1
1380                     ; 245 	TIM2->CCR1L = 50;//set wakeup alarm relative to current time
1382  028c 35325312      	mov	21266,#50
1383                     ; 246 }
1386  0290 80            	iret
1451                     ; 248 void flush_leds(u8 led_count)
1451                     ; 249 {
1453                     	switch	.text
1454  0291               _flush_leds:
1456  0291 88            	push	a
1457  0292 5203          	subw	sp,#3
1458       00000003      OFST:	set	3
1461                     ; 250 	u8 led_read_index=0,led_write_index=0;
1465  0294 0f02          	clr	(OFST-1,sp)
1468  0296               L774:
1469                     ; 252 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1471  0296 b607          	ld	a,_pwm_state
1472  0298 a502          	bcp	a,#2
1473  029a 26fa          	jrne	L774
1474                     ; 253 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1476  029c b607          	ld	a,_pwm_state
1477  029e a401          	and	a,#1
1478  02a0 a801          	xor	a,#1
1479  02a2 6b01          	ld	(OFST-2,sp),a
1481                     ; 254 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1483  02a4 7b04          	ld	a,(OFST+1,sp)
1484  02a6 5f            	clrw	x
1485  02a7 97            	ld	xl,a
1486  02a8 4f            	clr	a
1487  02a9 02            	rlwa	x,a
1488  02aa 7b01          	ld	a,(OFST-2,sp)
1489  02ac 905f          	clrw	y
1490  02ae 9097          	ld	yl,a
1491  02b0 9058          	sllw	y
1492  02b2 90ef10        	ldw	(_pwm_sleep,y),x
1493                     ; 256 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1495  02b5 0f03          	clr	(OFST+0,sp)
1498  02b7 205d          	jra	L705
1499  02b9               L305:
1500                     ; 258 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1502  02b9 7b03          	ld	a,(OFST+0,sp)
1503  02bb 5f            	clrw	x
1504  02bc 97            	ld	xl,a
1505  02bd e6c0          	ld	a,(_pwm_brightness_buffer,x)
1506  02bf a105          	cp	a,#5
1507  02c1 254b          	jrult	L315
1508                     ; 260 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1510  02c3 7b02          	ld	a,(OFST-1,sp)
1511  02c5 97            	ld	xl,a
1512  02c6 a604          	ld	a,#4
1513  02c8 42            	mul	x,a
1514  02c9 01            	rrwa	x,a
1515  02ca 1b01          	add	a,(OFST-2,sp)
1516  02cc 2401          	jrnc	L621
1517  02ce 5c            	incw	x
1518  02cf               L621:
1519  02cf 02            	rlwa	x,a
1520  02d0 7b03          	ld	a,(OFST+0,sp)
1521  02d2 e714          	ld	(_pwm_brightness,x),a
1522                     ; 261 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1524  02d4 7b02          	ld	a,(OFST-1,sp)
1525  02d6 97            	ld	xl,a
1526  02d7 a604          	ld	a,#4
1527  02d9 42            	mul	x,a
1528  02da 01            	rrwa	x,a
1529  02db 1b01          	add	a,(OFST-2,sp)
1530  02dd 2401          	jrnc	L031
1531  02df 5c            	incw	x
1532  02e0               L031:
1533  02e0 02            	rlwa	x,a
1534  02e1 7b03          	ld	a,(OFST+0,sp)
1535  02e3 905f          	clrw	y
1536  02e5 9097          	ld	yl,a
1537  02e7 90e6c0        	ld	a,(_pwm_brightness_buffer,y)
1538  02ea e716          	ld	(_pwm_brightness+2,x),a
1539                     ; 262 			led_write_index++;
1541  02ec 0c02          	inc	(OFST-1,sp)
1543                     ; 263 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1545  02ee 7b01          	ld	a,(OFST-2,sp)
1546  02f0 5f            	clrw	x
1547  02f1 97            	ld	xl,a
1548  02f2 58            	sllw	x
1549  02f3 7b03          	ld	a,(OFST+0,sp)
1550  02f5 905f          	clrw	y
1551  02f7 9097          	ld	yl,a
1552  02f9 90e6c0        	ld	a,(_pwm_brightness_buffer,y)
1553  02fc 905f          	clrw	y
1554  02fe 9097          	ld	yl,a
1555  0300 9001          	rrwa	y,a
1556  0302 e011          	sub	a,(_pwm_sleep+1,x)
1557  0304 9001          	rrwa	y,a
1558  0306 e210          	sbc	a,(_pwm_sleep,x)
1559  0308 9001          	rrwa	y,a
1560  030a 9050          	negw	y
1561  030c ef10          	ldw	(_pwm_sleep,x),y
1562  030e               L315:
1563                     ; 265 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1565  030e 7b03          	ld	a,(OFST+0,sp)
1566  0310 5f            	clrw	x
1567  0311 97            	ld	xl,a
1568  0312 6fc0          	clr	(_pwm_brightness_buffer,x)
1569                     ; 256 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1571  0314 0c03          	inc	(OFST+0,sp)
1573  0316               L705:
1576  0316 7b03          	ld	a,(OFST+0,sp)
1577  0318 a12b          	cp	a,#43
1578  031a 2406          	jruge	L515
1580  031c 7b02          	ld	a,(OFST-1,sp)
1581  031e 1104          	cp	a,(OFST+1,sp)
1582  0320 2597          	jrult	L305
1583  0322               L515:
1584                     ; 267 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1586  0322 7b01          	ld	a,(OFST-2,sp)
1587  0324 5f            	clrw	x
1588  0325 97            	ld	xl,a
1589  0326 7b02          	ld	a,(OFST-1,sp)
1590  0328 e70e          	ld	(_pwm_led_count,x),a
1591                     ; 270 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1593  032a 72120007      	bset	_pwm_state,#1
1594                     ; 271 }
1597  032e 5b04          	addw	sp,#4
1598  0330 81            	ret
1687                     ; 273 void set_hue(u8 index,u16 color,u8 brightness)
1687                     ; 274 {
1688                     	switch	.text
1689  0331               _set_hue:
1691  0331 88            	push	a
1692  0332 5205          	subw	sp,#5
1693       00000005      OFST:	set	5
1696                     ; 275 	u8 red=0,green=0,blue=0;
1698  0334 0f01          	clr	(OFST-4,sp)
1702  0336 0f02          	clr	(OFST-3,sp)
1706  0338 0f03          	clr	(OFST-2,sp)
1708                     ; 276 	u16 residual=color%(0x2AAB);
1710  033a 1e09          	ldw	x,(OFST+4,sp)
1711  033c 90ae2aab      	ldw	y,#10923
1712  0340 65            	divw	x,y
1713  0341 51            	exgw	x,y
1714  0342 1f04          	ldw	(OFST-1,sp),x
1716                     ; 277 	residual=(u8)(residual*brightness/0x2AAB);
1718  0344 1e04          	ldw	x,(OFST-1,sp)
1719  0346 7b0b          	ld	a,(OFST+6,sp)
1720  0348 cd0000        	call	c_bmulx
1722  034b 90ae2aab      	ldw	y,#10923
1723  034f 65            	divw	x,y
1724  0350 9f            	ld	a,xl
1725  0351 5f            	clrw	x
1726  0352 97            	ld	xl,a
1727  0353 1f04          	ldw	(OFST-1,sp),x
1729                     ; 278 	switch(color/(0x2AAB))//0xFFFF/6
1731  0355 1e09          	ldw	x,(OFST+4,sp)
1732  0357 90ae2aab      	ldw	y,#10923
1733  035b 65            	divw	x,y
1735                     ; 309 			break;
1736  035c 5d            	tnzw	x
1737  035d 2711          	jreq	L715
1738  035f 5a            	decw	x
1739  0360 271a          	jreq	L125
1740  0362 5a            	decw	x
1741  0363 2725          	jreq	L325
1742  0365 5a            	decw	x
1743  0366 272e          	jreq	L525
1744  0368 5a            	decw	x
1745  0369 2739          	jreq	L725
1746  036b 5a            	decw	x
1747  036c 2742          	jreq	L135
1748  036e 204c          	jra	L506
1749  0370               L715:
1750                     ; 281 			red=brightness;
1752  0370 7b0b          	ld	a,(OFST+6,sp)
1753  0372 6b01          	ld	(OFST-4,sp),a
1755                     ; 282 			green=residual;
1757  0374 7b05          	ld	a,(OFST+0,sp)
1758  0376 6b02          	ld	(OFST-3,sp),a
1760                     ; 283 			blue=0;
1762  0378 0f03          	clr	(OFST-2,sp)
1764                     ; 284 			break;
1766  037a 2040          	jra	L506
1767  037c               L125:
1768                     ; 286 			red=brightness-residual;
1770  037c 7b0b          	ld	a,(OFST+6,sp)
1771  037e 1005          	sub	a,(OFST+0,sp)
1772  0380 6b01          	ld	(OFST-4,sp),a
1774                     ; 287 			green=brightness;
1776  0382 7b0b          	ld	a,(OFST+6,sp)
1777  0384 6b02          	ld	(OFST-3,sp),a
1779                     ; 288 			blue=0;
1781  0386 0f03          	clr	(OFST-2,sp)
1783                     ; 289 			break;
1785  0388 2032          	jra	L506
1786  038a               L325:
1787                     ; 291 			red=0;
1789  038a 0f01          	clr	(OFST-4,sp)
1791                     ; 292 			green=brightness;
1793  038c 7b0b          	ld	a,(OFST+6,sp)
1794  038e 6b02          	ld	(OFST-3,sp),a
1796                     ; 293 			blue=residual;
1798  0390 7b05          	ld	a,(OFST+0,sp)
1799  0392 6b03          	ld	(OFST-2,sp),a
1801                     ; 294 			break;
1803  0394 2026          	jra	L506
1804  0396               L525:
1805                     ; 296 			red=0;
1807  0396 0f01          	clr	(OFST-4,sp)
1809                     ; 297 			green=brightness-residual;
1811  0398 7b0b          	ld	a,(OFST+6,sp)
1812  039a 1005          	sub	a,(OFST+0,sp)
1813  039c 6b02          	ld	(OFST-3,sp),a
1815                     ; 298 			blue=brightness;
1817  039e 7b0b          	ld	a,(OFST+6,sp)
1818  03a0 6b03          	ld	(OFST-2,sp),a
1820                     ; 299 			break;
1822  03a2 2018          	jra	L506
1823  03a4               L725:
1824                     ; 301 			red=residual;
1826  03a4 7b05          	ld	a,(OFST+0,sp)
1827  03a6 6b01          	ld	(OFST-4,sp),a
1829                     ; 302 			green=0;
1831  03a8 0f02          	clr	(OFST-3,sp)
1833                     ; 303 			blue=brightness;
1835  03aa 7b0b          	ld	a,(OFST+6,sp)
1836  03ac 6b03          	ld	(OFST-2,sp),a
1838                     ; 304 			break;
1840  03ae 200c          	jra	L506
1841  03b0               L135:
1842                     ; 306 			red=brightness;
1844  03b0 7b0b          	ld	a,(OFST+6,sp)
1845  03b2 6b01          	ld	(OFST-4,sp),a
1847                     ; 307 			green=0;
1849  03b4 0f02          	clr	(OFST-3,sp)
1851                     ; 308 			blue=brightness-residual;
1853  03b6 7b0b          	ld	a,(OFST+6,sp)
1854  03b8 1005          	sub	a,(OFST+0,sp)
1855  03ba 6b03          	ld	(OFST-2,sp),a
1857                     ; 309 			break;
1859  03bc               L506:
1860                     ; 312 	set_rgb(index,0,red);
1862  03bc 7b01          	ld	a,(OFST-4,sp)
1863  03be 88            	push	a
1864  03bf 7b07          	ld	a,(OFST+2,sp)
1865  03c1 5f            	clrw	x
1866  03c2 95            	ld	xh,a
1867  03c3 ad1c          	call	_set_rgb
1869  03c5 84            	pop	a
1870                     ; 313 	set_rgb(index,1,green);
1872  03c6 7b02          	ld	a,(OFST-3,sp)
1873  03c8 88            	push	a
1874  03c9 7b07          	ld	a,(OFST+2,sp)
1875  03cb ae0001        	ldw	x,#1
1876  03ce 95            	ld	xh,a
1877  03cf ad10          	call	_set_rgb
1879  03d1 84            	pop	a
1880                     ; 314 	set_rgb(index,2,blue);
1882  03d2 7b03          	ld	a,(OFST-2,sp)
1883  03d4 88            	push	a
1884  03d5 7b07          	ld	a,(OFST+2,sp)
1885  03d7 ae0002        	ldw	x,#2
1886  03da 95            	ld	xh,a
1887  03db ad04          	call	_set_rgb
1889  03dd 84            	pop	a
1890                     ; 315 }
1893  03de 5b06          	addw	sp,#6
1894  03e0 81            	ret
1947                     ; 317 void set_rgb(u8 index,u8 color,u8 brightness)
1947                     ; 318 {
1948                     	switch	.text
1949  03e1               _set_rgb:
1951  03e1 89            	pushw	x
1952       00000000      OFST:	set	0
1955                     ; 319 	pwm_brightness_buffer[index*3+color]=brightness;
1957  03e2 9e            	ld	a,xh
1958  03e3 97            	ld	xl,a
1959  03e4 a603          	ld	a,#3
1960  03e6 42            	mul	x,a
1961  03e7 01            	rrwa	x,a
1962  03e8 1b02          	add	a,(OFST+2,sp)
1963  03ea 2401          	jrnc	L041
1964  03ec 5c            	incw	x
1965  03ed               L041:
1966  03ed 02            	rlwa	x,a
1967  03ee 7b05          	ld	a,(OFST+5,sp)
1968  03f0 e7c0          	ld	(_pwm_brightness_buffer,x),a
1969                     ; 320 }
1972  03f2 85            	popw	x
1973  03f3 81            	ret
2017                     ; 322 void set_white(u8 index,u8 brightness)
2017                     ; 323 {
2018                     	switch	.text
2019  03f4               _set_white:
2021  03f4 89            	pushw	x
2022       00000000      OFST:	set	0
2025                     ; 324 	pwm_brightness_buffer[31+index]=brightness;
2027  03f5 9e            	ld	a,xh
2028  03f6 5f            	clrw	x
2029  03f7 97            	ld	xl,a
2030  03f8 7b02          	ld	a,(OFST+2,sp)
2031  03fa e7df          	ld	(_pwm_brightness_buffer+31,x),a
2032                     ; 325 }
2035  03fc 85            	popw	x
2036  03fd 81            	ret
2071                     ; 328 void set_debug(u8 brightness)
2071                     ; 329 {
2072                     	switch	.text
2073  03fe               _set_debug:
2077                     ; 330 	pwm_brightness_buffer[30]=brightness;
2079  03fe b7de          	ld	_pwm_brightness_buffer+30,a
2080                     ; 331 }
2083  0400 81            	ret
2108                     ; 333 void set_matrix_high_z()
2108                     ; 334 {
2109                     	switch	.text
2110  0401               _set_matrix_high_z:
2114                     ; 337 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2116  0401 4b00          	push	#0
2117  0403 4bf8          	push	#248
2118  0405 ae500a        	ldw	x,#20490
2119  0408 cd0000        	call	_GPIO_Init
2121  040b 85            	popw	x
2122                     ; 338 		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
2124  040c 4b00          	push	#0
2125  040e 4b0c          	push	#12
2126  0410 ae500f        	ldw	x,#20495
2127  0413 cd0000        	call	_GPIO_Init
2129  0416 85            	popw	x
2130                     ; 339 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
2132  0417 4b00          	push	#0
2133  0419 4b08          	push	#8
2134  041b ae5000        	ldw	x,#20480
2135  041e cd0000        	call	_GPIO_Init
2137  0421 85            	popw	x
2138                     ; 343 }
2141  0422 81            	ret
2165                     ; 346 u8 get_audio_sample()
2165                     ; 347 {
2166                     	switch	.text
2167  0423               _get_audio_sample:
2171                     ; 353 	return 0;//revision 1 hw misrouted this connection, made it un-readable
2173  0423 4f            	clr	a
2176  0424 81            	ret
2179                     	switch	.const
2180  000a               L517_led_lookup:
2181  000a 00            	dc.b	0
2182  000b 01            	dc.b	1
2183  000c 00            	dc.b	0
2184  000d 02            	dc.b	2
2185  000e 01            	dc.b	1
2186  000f 02            	dc.b	2
2187  0010 01            	dc.b	1
2188  0011 00            	dc.b	0
2189  0012 02            	dc.b	2
2190  0013 00            	dc.b	0
2191  0014 02            	dc.b	2
2192  0015 01            	dc.b	1
2193  0016 05            	dc.b	5
2194  0017 00            	dc.b	0
2195  0018 05            	dc.b	5
2196  0019 01            	dc.b	1
2197  001a 05            	dc.b	5
2198  001b 02            	dc.b	2
2199  001c 06            	dc.b	6
2200  001d 00            	dc.b	0
2201  001e 06            	dc.b	6
2202  001f 01            	dc.b	1
2203  0020 06            	dc.b	6
2204  0021 02            	dc.b	2
2205  0022 06            	dc.b	6
2206  0023 05            	dc.b	5
2207  0024 06            	dc.b	6
2208  0025 04            	dc.b	4
2209  0026 05            	dc.b	5
2210  0027 04            	dc.b	4
2211  0028 04            	dc.b	4
2212  0029 03            	dc.b	3
2213  002a 05            	dc.b	5
2214  002b 03            	dc.b	3
2215  002c 06            	dc.b	6
2216  002d 03            	dc.b	3
2217  002e 03            	dc.b	3
2218  002f 04            	dc.b	4
2219  0030 03            	dc.b	3
2220  0031 05            	dc.b	5
2221  0032 03            	dc.b	3
2222  0033 06            	dc.b	6
2223  0034 00            	dc.b	0
2224  0035 05            	dc.b	5
2225  0036 00            	dc.b	0
2226  0037 06            	dc.b	6
2227  0038 01            	dc.b	1
2228  0039 06            	dc.b	6
2229  003a 00            	dc.b	0
2230  003b 04            	dc.b	4
2231  003c 01            	dc.b	1
2232  003d 04            	dc.b	4
2233  003e 02            	dc.b	2
2234  003f 04            	dc.b	4
2235  0040 00            	dc.b	0
2236  0041 03            	dc.b	3
2237  0042 01            	dc.b	1
2238  0043 03            	dc.b	3
2239  0044 02            	dc.b	2
2240  0045 03            	dc.b	3
2241  0046 07            	dc.b	7
2242  0047 07            	dc.b	7
2243  0048 03            	dc.b	3
2244  0049 00            	dc.b	0
2245  004a 03            	dc.b	3
2246  004b 01            	dc.b	1
2247  004c 03            	dc.b	3
2248  004d 02            	dc.b	2
2249  004e 04            	dc.b	4
2250  004f 00            	dc.b	0
2251  0050 01            	dc.b	1
2252  0051 05            	dc.b	5
2253  0052 02            	dc.b	2
2254  0053 05            	dc.b	5
2255  0054 04            	dc.b	4
2256  0055 01            	dc.b	1
2257  0056 04            	dc.b	4
2258  0057 02            	dc.b	2
2259  0058 02            	dc.b	2
2260  0059 06            	dc.b	6
2261  005a 04            	dc.b	4
2262  005b 06            	dc.b	6
2263  005c 04            	dc.b	4
2264  005d 05            	dc.b	5
2265  005e 05            	dc.b	5
2266  005f 06            	dc.b	6
2477                     ; 357 void set_led(u8 led_index)
2477                     ; 358 {
2478                     	switch	.text
2479  0425               _set_led:
2481  0425 88            	push	a
2482  0426 525c          	subw	sp,#92
2483       0000005c      OFST:	set	92
2486                     ; 362 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2486                     ; 363 		{0,1},{0,2},{1,2},//LED7  RGB
2486                     ; 364 		{1,0},{2,0},{2,1},//LED3  RGB
2486                     ; 365 		{5,0},{5,1},{5,2},//LED1  RGB
2486                     ; 366 		{6,0},{6,1},{6,2},//LED20 RGB
2486                     ; 367 		{6,5},{6,4},{5,4},//LED22 RGB
2486                     ; 368 		{4,3},{5,3},{6,3},//LED23 RGB
2486                     ; 369 		{3,4},{3,5},{3,6},//LED21 RGB
2486                     ; 370 		{0,5},{0,6},{1,6},//LED19 RGB
2486                     ; 371 		{0,4},{1,4},{2,4},//LED18 RGB
2486                     ; 372 		{0,3},{1,3},{2,3},//LED2  RGB
2486                     ; 373 		{7,7},//debug; GND is tied low, no charlieplexing involved
2486                     ; 374 		{3,0},//LED6
2486                     ; 375 		{3,1},//LED4
2486                     ; 376 		{3,2},//LED5
2486                     ; 377 		{4,0},//LED14
2486                     ; 378 		{1,5},//LED8
2486                     ; 379 		{2,5},//LED9
2486                     ; 380 		{4,1},//LED10
2486                     ; 381 		{4,2},//LED16
2486                     ; 382 		{2,6},//LED17
2486                     ; 383 		{4,6},//LED12
2486                     ; 384 		{4,5},//LED13
2486                     ; 385 		{5,6} //LED11
2486                     ; 386 	};
2488  0428 96            	ldw	x,sp
2489  0429 1c0006        	addw	x,#OFST-86
2490  042c 90ae000a      	ldw	y,#L517_led_lookup
2491  0430 a656          	ld	a,#86
2492  0432 cd0000        	call	c_xymov
2494                     ; 387 	bool is_high=0;
2496  0435 0f5c          	clr	(OFST+0,sp)
2498  0437               L3601:
2499                     ; 391 		switch(led_lookup[led_index][!is_high])
2501  0437 0d5c          	tnz	(OFST+0,sp)
2502  0439 2605          	jrne	L451
2503  043b ae0001        	ldw	x,#1
2504  043e 2001          	jra	L651
2505  0440               L451:
2506  0440 5f            	clrw	x
2507  0441               L651:
2508  0441 9096          	ldw	y,sp
2509  0443 72a90006      	addw	y,#OFST-86
2510  0447 1701          	ldw	(OFST-91,sp),y
2512  0449 7b5d          	ld	a,(OFST+1,sp)
2513  044b 905f          	clrw	y
2514  044d 9097          	ld	yl,a
2515  044f 9058          	sllw	y
2516  0451 72f901        	addw	y,(OFST-91,sp)
2517  0454 bf00          	ldw	c_y,x
2518  0456 51            	exgw	x,y
2519  0457 92d600        	ld	a,([c_y.w],x)
2520  045a 51            	exgw	x,y
2522                     ; 427 			}break;
2523  045b 4d            	tnz	a
2524  045c 2717          	jreq	L717
2525  045e 4a            	dec	a
2526  045f 271f          	jreq	L127
2527  0461 4a            	dec	a
2528  0462 2727          	jreq	L327
2529  0464 4a            	dec	a
2530  0465 272f          	jreq	L527
2531  0467 4a            	dec	a
2532  0468 2737          	jreq	L727
2533  046a 4a            	dec	a
2534  046b 273f          	jreq	L137
2535  046d 4a            	dec	a
2536  046e 2747          	jreq	L337
2537  0470 4a            	dec	a
2538  0471 274f          	jreq	L537
2539  0473 2056          	jra	L3701
2540  0475               L717:
2541                     ; 394 				GPIOx=GPIOD;
2543  0475 ae500f        	ldw	x,#20495
2544  0478 1f03          	ldw	(OFST-89,sp),x
2546                     ; 395 				PortPin=GPIO_PIN_3;
2548  047a a608          	ld	a,#8
2549  047c 6b05          	ld	(OFST-87,sp),a
2551                     ; 396 			}break;
2553  047e 204b          	jra	L3701
2554  0480               L127:
2555                     ; 398 				GPIOx=GPIOD;
2557  0480 ae500f        	ldw	x,#20495
2558  0483 1f03          	ldw	(OFST-89,sp),x
2560                     ; 399 				PortPin=GPIO_PIN_2;
2562  0485 a604          	ld	a,#4
2563  0487 6b05          	ld	(OFST-87,sp),a
2565                     ; 400 			}break;
2567  0489 2040          	jra	L3701
2568  048b               L327:
2569                     ; 402 				GPIOx=GPIOC;
2571  048b ae500a        	ldw	x,#20490
2572  048e 1f03          	ldw	(OFST-89,sp),x
2574                     ; 403 				PortPin=GPIO_PIN_7;
2576  0490 a680          	ld	a,#128
2577  0492 6b05          	ld	(OFST-87,sp),a
2579                     ; 404 			}break;
2581  0494 2035          	jra	L3701
2582  0496               L527:
2583                     ; 406 				GPIOx=GPIOC;
2585  0496 ae500a        	ldw	x,#20490
2586  0499 1f03          	ldw	(OFST-89,sp),x
2588                     ; 407 				PortPin=GPIO_PIN_6;
2590  049b a640          	ld	a,#64
2591  049d 6b05          	ld	(OFST-87,sp),a
2593                     ; 408 			}break;
2595  049f 202a          	jra	L3701
2596  04a1               L727:
2597                     ; 410 				GPIOx=GPIOC;
2599  04a1 ae500a        	ldw	x,#20490
2600  04a4 1f03          	ldw	(OFST-89,sp),x
2602                     ; 411 				PortPin=GPIO_PIN_5;
2604  04a6 a620          	ld	a,#32
2605  04a8 6b05          	ld	(OFST-87,sp),a
2607                     ; 412 			}break;
2609  04aa 201f          	jra	L3701
2610  04ac               L137:
2611                     ; 414 				GPIOx=GPIOC;
2613  04ac ae500a        	ldw	x,#20490
2614  04af 1f03          	ldw	(OFST-89,sp),x
2616                     ; 415 				PortPin=GPIO_PIN_4;
2618  04b1 a610          	ld	a,#16
2619  04b3 6b05          	ld	(OFST-87,sp),a
2621                     ; 416 			}break;
2623  04b5 2014          	jra	L3701
2624  04b7               L337:
2625                     ; 418 				GPIOx=GPIOC;
2627  04b7 ae500a        	ldw	x,#20490
2628  04ba 1f03          	ldw	(OFST-89,sp),x
2630                     ; 419 				PortPin=GPIO_PIN_3;
2632  04bc a608          	ld	a,#8
2633  04be 6b05          	ld	(OFST-87,sp),a
2635                     ; 420 			}break;
2637  04c0 2009          	jra	L3701
2638  04c2               L537:
2639                     ; 422 				GPIOx=GPIOA;
2641  04c2 ae5000        	ldw	x,#20480
2642  04c5 1f03          	ldw	(OFST-89,sp),x
2644                     ; 423 				PortPin=GPIO_PIN_3;
2646  04c7 a608          	ld	a,#8
2647  04c9 6b05          	ld	(OFST-87,sp),a
2649                     ; 424 			}break;
2651  04cb               L3701:
2652                     ; 429 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
2654  04cb 0d5c          	tnz	(OFST+0,sp)
2655  04cd 2704          	jreq	L061
2656  04cf a6d0          	ld	a,#208
2657  04d1 2002          	jra	L261
2658  04d3               L061:
2659  04d3 a6c0          	ld	a,#192
2660  04d5               L261:
2661  04d5 88            	push	a
2662  04d6 7b06          	ld	a,(OFST-86,sp)
2663  04d8 88            	push	a
2664  04d9 1e05          	ldw	x,(OFST-87,sp)
2665  04db cd0000        	call	_GPIO_Init
2667  04de 85            	popw	x
2668                     ; 430 		is_high=!is_high;
2670  04df 0d5c          	tnz	(OFST+0,sp)
2671  04e1 2604          	jrne	L461
2672  04e3 a601          	ld	a,#1
2673  04e5 2001          	jra	L661
2674  04e7               L461:
2675  04e7 4f            	clr	a
2676  04e8               L661:
2677  04e8 6b5c          	ld	(OFST+0,sp),a
2679                     ; 431 	}while(is_high);
2681  04ea 0d5c          	tnz	(OFST+0,sp)
2682  04ec 2703          	jreq	L071
2683  04ee cc0437        	jp	L3601
2684  04f1               L071:
2685                     ; 432 }
2688  04f1 5b5d          	addw	sp,#93
2689  04f3 81            	ret
2713                     ; 435 bool is_space_sao()
2713                     ; 436 {
2714                     	switch	.text
2715  04f4               _is_space_sao:
2719                     ; 437 	return 1;//TODO: implement EEPROM read
2721  04f4 a601          	ld	a,#1
2724  04f6 81            	ret
2758                     ; 440 u8 get_eeprom_byte(u16 eeprom_address)
2758                     ; 441 {
2759                     	switch	.text
2760  04f7               _get_eeprom_byte:
2764                     ; 442 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2766  04f7 d64000        	ld	a,(16384,x)
2769  04fa 81            	ret
2951                     	xdef	f_TIM2_CapComp_IRQ_Handler
2952                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2953                     	switch	.ubsct
2954  0000               _audio_running_std:
2955  0000 0000          	ds.b	2
2956                     	xdef	_audio_running_std
2957  0002               _audio_running_mean:
2958  0002 0000          	ds.b	2
2959                     	xdef	_audio_running_mean
2960  0004               _audio_std:
2961  0004 00            	ds.b	1
2962                     	xdef	_audio_std
2963  0005               _audio_mean:
2964  0005 00            	ds.b	1
2965                     	xdef	_audio_mean
2966                     	xdef	_audio_measurement_count
2967  0006               _button_pressed_event:
2968  0006 00000000      	ds.b	4
2969                     	xdef	_button_pressed_event
2970  000a               _button_start_ms:
2971  000a 00000000      	ds.b	4
2972                     	xdef	_button_start_ms
2973                     	xdef	_pwm_state
2974                     	xdef	_pwm_led_index
2975                     	xdef	_pwm_sleep_remaining
2976  000e               _pwm_led_count:
2977  000e 0000          	ds.b	2
2978                     	xdef	_pwm_led_count
2979  0010               _pwm_sleep:
2980  0010 00000000      	ds.b	4
2981                     	xdef	_pwm_sleep
2982  0014               _pwm_brightness:
2983  0014 000000000000  	ds.b	172
2984                     	xdef	_pwm_brightness
2985                     	xdef	_PWM_MAX_PERIOD
2986  00c0               _pwm_brightness_buffer:
2987  00c0 000000000000  	ds.b	43
2988                     	xdef	_pwm_brightness_buffer
2989                     	xdef	_api_counter
2990                     	xdef	_hw_revision
2991                     	xref	_UART1_Cmd
2992                     	xref	_UART1_Init
2993                     	xref	_UART1_DeInit
2994                     	xref	_GPIO_ReadInputPin
2995                     	xref	_GPIO_Init
2996                     	xdef	_get_eeprom_byte
2997                     	xdef	_set_millis
2998                     	xdef	_get_audio_level
2999                     	xdef	_get_random
3000                     	xdef	_is_space_sao
3001                     	xdef	_is_button_down
3002                     	xdef	_clear_button_events
3003                     	xdef	_clear_button_event
3004                     	xdef	_get_button_event
3005                     	xdef	_update_buttons
3006                     	xdef	_is_sleep_valid
3007                     	xdef	_is_developer_valid
3008                     	xdef	_set_hue
3009                     	xdef	_flush_leds
3010                     	xdef	_set_led
3011                     	xdef	_get_audio_sample
3012                     	xdef	_set_debug
3013                     	xdef	_set_white
3014                     	xdef	_set_rgb
3015                     	xdef	_set_matrix_high_z
3016                     	xdef	_millis
3017                     	xdef	_setup_main
3018                     	xdef	_is_application_valid
3019                     	xdef	_setup_serial
3020                     	xdef	_hello_world
3021                     	xref.b	c_lreg
3022                     	xref.b	c_x
3023                     	xref.b	c_y
3043                     	xref	c_xymov
3044                     	xref	c_bmulx
3045                     	xref	c_lzmp
3046                     	xref	c_lsub
3047                     	xref	c_rtol
3048                     	xref	c_uitolx
3049                     	xref	c_itolx
3050                     	xref	c_imul
3051                     	xref	c_lrzmp
3052                     	xref	c_lmod
3053                     	xref	c_ltor
3054                     	xref	c_lgadc
3055                     	end
