   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  19                     	switch	.data
  20  0000               _atomic_counter:
  21  0000 00000000      	dc.l	0
  22  0004               _pwm_brightness:
  23  0004 0001          	dc.w	1
  24  0006 0001          	dc.w	1
  25  0008 000000000000  	ds.b	120
  26  0080               _pwm_sleep:
  27  0080 0001          	dc.w	1
  28  0082 0001          	dc.w	1
  29  0084               _pwm_led_count:
  30  0084 01            	dc.b	1
  31  0085 01            	dc.b	1
  32  0086               _pwm_visible_index:
  33  0086 00            	dc.b	0
  34  0087               _pwm_state:
  35  0087 00            	dc.b	0
  36  0088               _is_valid_i2c_received:
  37  0088 00            	dc.b	0
  38  0089               _button_start_ms:
  39  0089 00000000      	dc.l	0
  40  008d               _is_right_button_down:
  41  008d 00            	dc.b	0
 101                     ; 29 void hello_world()
 101                     ; 30 {//basic program that blinks the debug LED ON/OFF
 103                     	switch	.text
 104  0000               _hello_world:
 106  0000 5204          	subw	sp,#4
 107       00000004      OFST:	set	4
 110                     ; 31 	const u8 cycle_speed=8;//larger=faster
 112  0002 a608          	ld	a,#8
 113  0004 6b02          	ld	(OFST-2,sp),a
 115                     ; 32 	const u8 white_speed=5;//smaller=faster
 117  0006 a605          	ld	a,#5
 118  0008 6b01          	ld	(OFST-3,sp),a
 120                     ; 34 	while(0)
 123  000a 5f            	clrw	x
 125  000b               L53:
 126                     ; 42 		frame++;
 128  000b 5c            	incw	x
 129  000c 1f03          	ldw	(OFST-1,sp),x
 131                     ; 43 		set_hue_max(0,(frame<<cycle_speed));
 133  000e 7b02          	ld	a,(OFST-2,sp)
 134  0010 2704          	jreq	L01
 135  0012               L21:
 136  0012 58            	sllw	x
 137  0013 4a            	dec	a
 138  0014 26fc          	jrne	L21
 139  0016               L01:
 140  0016 89            	pushw	x
 141  0017 4f            	clr	a
 142  0018 cd075d        	call	_set_hue_max
 144  001b 85            	popw	x
 145                     ; 44 		set_hue_max(1,(frame<<cycle_speed)+0x2AAB);
 147  001c 1e03          	ldw	x,(OFST-1,sp)
 148  001e 7b02          	ld	a,(OFST-2,sp)
 149  0020 2704          	jreq	L61
 150  0022               L02:
 151  0022 58            	sllw	x
 152  0023 4a            	dec	a
 153  0024 26fc          	jrne	L02
 154  0026               L61:
 155  0026 1c2aab        	addw	x,#10923
 156  0029 89            	pushw	x
 157  002a a601          	ld	a,#1
 158  002c cd075d        	call	_set_hue_max
 160  002f 85            	popw	x
 161                     ; 45 		set_hue_max(2,(frame<<cycle_speed)+0x5556);
 163  0030 1e03          	ldw	x,(OFST-1,sp)
 164  0032 7b02          	ld	a,(OFST-2,sp)
 165  0034 2704          	jreq	L42
 166  0036               L62:
 167  0036 58            	sllw	x
 168  0037 4a            	dec	a
 169  0038 26fc          	jrne	L62
 170  003a               L42:
 171  003a 1c5556        	addw	x,#21846
 172  003d 89            	pushw	x
 173  003e a602          	ld	a,#2
 174  0040 cd075d        	call	_set_hue_max
 176  0043 85            	popw	x
 177                     ; 46 		set_hue_max(3,(frame<<cycle_speed)+0x8000);
 179  0044 1e03          	ldw	x,(OFST-1,sp)
 180  0046 7b02          	ld	a,(OFST-2,sp)
 181  0048 2704          	jreq	L23
 182  004a               L43:
 183  004a 58            	sllw	x
 184  004b 4a            	dec	a
 185  004c 26fc          	jrne	L43
 186  004e               L23:
 187  004e 1c8000        	addw	x,#32768
 188  0051 89            	pushw	x
 189  0052 a603          	ld	a,#3
 190  0054 cd075d        	call	_set_hue_max
 192  0057 85            	popw	x
 193                     ; 47 		set_hue_max(4,(frame<<cycle_speed)+0xAAAB);
 195  0058 1e03          	ldw	x,(OFST-1,sp)
 196  005a 7b02          	ld	a,(OFST-2,sp)
 197  005c 2704          	jreq	L04
 198  005e               L24:
 199  005e 58            	sllw	x
 200  005f 4a            	dec	a
 201  0060 26fc          	jrne	L24
 202  0062               L04:
 203  0062 1caaab        	addw	x,#43691
 204  0065 89            	pushw	x
 205  0066 a604          	ld	a,#4
 206  0068 cd075d        	call	_set_hue_max
 208  006b 85            	popw	x
 209                     ; 48 		set_hue_max(5,(frame<<cycle_speed)+0xD554);
 211  006c 1e03          	ldw	x,(OFST-1,sp)
 212  006e 7b02          	ld	a,(OFST-2,sp)
 213  0070 2704          	jreq	L64
 214  0072               L05:
 215  0072 58            	sllw	x
 216  0073 4a            	dec	a
 217  0074 26fc          	jrne	L05
 218  0076               L64:
 219  0076 1cd554        	addw	x,#54612
 220  0079 89            	pushw	x
 221  007a a605          	ld	a,#5
 222  007c cd075d        	call	_set_hue_max
 224  007f 85            	popw	x
 225                     ; 51 		set_white((frame>>(white_speed+1))%12,(frame>>white_speed)&0x01?(~(frame<<(8-white_speed))):(frame<<(8-white_speed)));
 227  0080 1e03          	ldw	x,(OFST-1,sp)
 228  0082 7b01          	ld	a,(OFST-3,sp)
 229  0084 2704          	jreq	L65
 230  0086               L06:
 231  0086 54            	srlw	x
 232  0087 4a            	dec	a
 233  0088 26fc          	jrne	L06
 234  008a               L65:
 235  008a 01            	rrwa	x,a
 236  008b a501          	bcp	a,#1
 237  008d 2712          	jreq	L45
 238  008f a608          	ld	a,#8
 239  0091 1001          	sub	a,(OFST-3,sp)
 240  0093 5f            	clrw	x
 241  0094 97            	ld	xl,a
 242  0095 7b04          	ld	a,(OFST+0,sp)
 243  0097 5d            	tnzw	x
 244  0098 2704          	jreq	L26
 245  009a               L46:
 246  009a 48            	sll	a
 247  009b 5a            	decw	x
 248  009c 26fc          	jrne	L46
 249  009e               L26:
 250  009e 43            	cpl	a
 251  009f 200f          	jra	L07
 252  00a1               L45:
 253  00a1 a608          	ld	a,#8
 254  00a3 1001          	sub	a,(OFST-3,sp)
 255  00a5 5f            	clrw	x
 256  00a6 97            	ld	xl,a
 257  00a7 7b04          	ld	a,(OFST+0,sp)
 258  00a9 5d            	tnzw	x
 259  00aa 2704          	jreq	L07
 260  00ac               L27:
 261  00ac 48            	sll	a
 262  00ad 5a            	decw	x
 263  00ae 26fc          	jrne	L27
 264  00b0               L07:
 265  00b0 97            	ld	xl,a
 266  00b1 1603          	ldw	y,(OFST-1,sp)
 267  00b3 7b01          	ld	a,(OFST-3,sp)
 268  00b5 4c            	inc	a
 269  00b6 2705          	jreq	L47
 270  00b8               L67:
 271  00b8 9054          	srlw	y
 272  00ba 4a            	dec	a
 273  00bb 26fb          	jrne	L67
 274  00bd               L47:
 275  00bd a60c          	ld	a,#12
 276  00bf 9062          	div	y,a
 277  00c1 95            	ld	xh,a
 278  00c2 cd0808        	call	_set_white
 280                     ; 52 		flush_leds(7);
 282  00c5 a607          	ld	a,#7
 283  00c7 cd0657        	call	_flush_leds
 286  00ca 1e03          	ldw	x,(OFST-1,sp)
 287  00cc cc000b        	jra	L53
 332                     ; 56 bool is_application()
 332                     ; 57 {
 333                     	switch	.text
 334  00cf               _is_application:
 338                     ; 58 	return !is_valid_i2c_received;
 340  00cf c60088        	ld	a,_is_valid_i2c_received
 341  00d2 2602          	jrne	L401
 342  00d4 4c            	inc	a
 344  00d5 81            	ret	
 345  00d6               L401:
 346  00d6 4f            	clr	a
 349  00d7 81            	ret	
 395                     ; 61 u16 get_random(u16 x)
 395                     ; 62 {
 396                     	switch	.text
 397  00d8               _get_random:
 399       00000004      OFST:	set	4
 402                     ; 63 	u16 a=1664525;
 404                     ; 64 	u16 c=1013904223;
 406                     ; 65 	return a * x + c;
 408  00d8 90ae660d      	ldw	y,#26125
 409  00dc cd0000        	call	c_imul
 411  00df 1cf35f        	addw	x,#62303
 414  00e2 81            	ret	
 443                     ; 85 void setup_main()
 443                     ; 86 {
 444                     	switch	.text
 445  00e3               _setup_main:
 449                     ; 87 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 451  00e3 c650c6        	ld	a,20678
 452  00e6 a4e7          	and	a,#231
 453  00e8 c750c6        	ld	20678,a
 454                     ; 96 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 456  00eb 3505530e      	mov	21262,#5
 457                     ; 97 	TIM2->ARRH= 0;// init auto reload register
 459  00ef 725f530f      	clr	21263
 460                     ; 98 	TIM2->ARRL= 255;// init auto reload register
 462  00f3 35ff5310      	mov	21264,#255
 463                     ; 100 	TIM2->CR1|= TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 465  00f7 c65300        	ld	a,21248
 466  00fa aa05          	or	a,#5
 467  00fc c75300        	ld	21248,a
 468                     ; 102 	TIM2->IER= TIM2_IER_UIE;// enable TIM2 interrupt
 470  00ff 35015303      	mov	21251,#1
 471                     ; 109 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 473  0103 4b40          	push	#64
 474  0105 4b08          	push	#8
 475  0107 ae500f        	ldw	x,#20495
 476  010a cd0000        	call	_GPIO_Init
 478  010d 85            	popw	x
 479                     ; 110 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);
 481  010e 4b40          	push	#64
 482  0110 4b10          	push	#16
 483  0112 ae500f        	ldw	x,#20495
 484  0115 cd0000        	call	_GPIO_Init
 486  0118 85            	popw	x
 487                     ; 113 	I2C_DeInit();
 489  0119 cd0000        	call	_I2C_DeInit
 491                     ; 114 	I2C_Init(100000, I2C_SLAVE_ADDRESS_DEFAULT<<1, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 16);
 493  011c 4b10          	push	#16
 494  011e 4b00          	push	#0
 495  0120 4b01          	push	#1
 496  0122 4b00          	push	#0
 497  0124 ae0060        	ldw	x,#96
 498  0127 89            	pushw	x
 499  0128 ae86a0        	ldw	x,#34464
 500  012b 89            	pushw	x
 501  012c ae0001        	ldw	x,#1
 502  012f 89            	pushw	x
 503  0130 cd0000        	call	_I2C_Init
 505  0133 5b0a          	addw	sp,#10
 506                     ; 115 	I2C_ITConfig(I2C_IT_EVT | I2C_IT_BUF | I2C_IT_ERR, ENABLE);  // Enable I2C interrupts
 508  0135 ae0701        	ldw	x,#1793
 509  0138 cd0000        	call	_I2C_ITConfig
 511                     ; 116 	I2C_Cmd(ENABLE);
 513  013b a601          	ld	a,#1
 514  013d cd0000        	call	_I2C_Cmd
 516                     ; 117 	enableInterrupts();  // Enable global interrupts
 519  0140 9a            	rim	
 521                     ; 118 }
 525  0141 81            	ret	
 549                     ; 120 u32 millis()
 549                     ; 121 {
 550                     	switch	.text
 551  0142               _millis:
 555                     ; 122 	return atomic_counter>>9;//TIM2->PSCR + shift = 14
 557  0142 ae0000        	ldw	x,#_atomic_counter
 558  0145 cd0000        	call	c_ltor
 560  0148 a609          	ld	a,#9
 564  014a cc0000        	jp	c_lursh
 611                     .const:	section	.text
 612  0000               L651:
 613  0000 00000201      	dc.l	513
 614  0004               L061:
 615  0004 00000033      	dc.l	51
 616                     ; 127 void update_buttons()
 616                     ; 128 {
 617                     	switch	.text
 618  014d               _update_buttons:
 620  014d 5205          	subw	sp,#5
 621       00000005      OFST:	set	5
 624                     ; 131 	if(is_valid_i2c_received) GPIO_Init(GPIOD, GPIO_PIN_6, (is_button_down(0)||is_button_down(1))?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
 626  014f c60088        	ld	a,_is_valid_i2c_received
 627  0152 271e          	jreq	L731
 630  0154 4f            	clr	a
 631  0155 cd0250        	call	_is_button_down
 633  0158 4d            	tnz	a
 634  0159 2607          	jrne	L041
 635  015b 4c            	inc	a
 636  015c cd0250        	call	_is_button_down
 638  015f 4d            	tnz	a
 639  0160 2704          	jreq	L631
 640  0162               L041:
 641  0162 a6d0          	ld	a,#208
 642  0164 2002          	jra	L641
 643  0166               L631:
 644  0166 a6c0          	ld	a,#192
 645  0168               L641:
 646  0168 88            	push	a
 647  0169 4b40          	push	#64
 648  016b ae500f        	ldw	x,#20495
 649  016e cd0000        	call	_GPIO_Init
 651  0171 85            	popw	x
 652  0172               L731:
 653                     ; 132 	if(button_start_ms)
 655  0172 ae0089        	ldw	x,#_button_start_ms
 656  0175 cd0000        	call	c_lzmp
 658  0178 2756          	jreq	L141
 659                     ; 134 		set_debug(255);
 661  017a a6ff          	ld	a,#255
 662  017c cd0813        	call	_set_debug
 664                     ; 135 		if(!is_button_down(is_right_button_down))
 666  017f c6008d        	ld	a,_is_right_button_down
 667  0182 cd0250        	call	_is_button_down
 669  0185 4d            	tnz	a
 670  0186 2671          	jrne	L351
 671                     ; 137 			elapsed_pressed_ms=millis()-button_start_ms;
 673  0188 adb8          	call	_millis
 675  018a ae0089        	ldw	x,#_button_start_ms
 676  018d cd0000        	call	c_lsub
 678  0190 96            	ldw	x,sp
 679  0191 5c            	incw	x
 680  0192 cd0000        	call	c_rtol
 683                     ; 138 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 685  0195 96            	ldw	x,sp
 686  0196 5c            	incw	x
 687  0197 cd0000        	call	c_ltor
 689  019a ae0000        	ldw	x,#L651
 690  019d cd0000        	call	c_lcmp
 692  01a0 250d          	jrult	L541
 695  01a2 c6008d        	ld	a,_is_right_button_down
 696  01a5 5f            	clrw	x
 697  01a6 97            	ld	xl,a
 698  01a7 58            	sllw	x
 699  01a8 a601          	ld	a,#1
 700  01aa d7000e        	ld	(_button_pressed_event+1,x),a
 702  01ad 2018          	jra	L741
 703  01af               L541:
 704                     ; 139 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 706  01af 96            	ldw	x,sp
 707  01b0 5c            	incw	x
 708  01b1 cd0000        	call	c_ltor
 710  01b4 ae0004        	ldw	x,#L061
 711  01b7 cd0000        	call	c_lcmp
 713  01ba 250b          	jrult	L741
 716  01bc c6008d        	ld	a,_is_right_button_down
 717  01bf 5f            	clrw	x
 718  01c0 97            	ld	xl,a
 719  01c1 58            	sllw	x
 720  01c2 a601          	ld	a,#1
 721  01c4 d7000d        	ld	(_button_pressed_event,x),a
 722  01c7               L741:
 723                     ; 140 			button_start_ms=0;
 725  01c7 5f            	clrw	x
 726  01c8 cf008b        	ldw	_button_start_ms+2,x
 727  01cb cf0089        	ldw	_button_start_ms,x
 728  01ce 2029          	jra	L351
 729  01d0               L141:
 730                     ; 143 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 732  01d0 0f05          	clr	(OFST+0,sp)
 735  01d2 2017          	jra	L161
 736  01d4               L551:
 737                     ; 145 			if(is_button_down(button_index))
 739  01d4 7b05          	ld	a,(OFST+0,sp)
 740  01d6 ad78          	call	_is_button_down
 742  01d8 4d            	tnz	a
 743  01d9 270e          	jreq	L561
 744                     ; 147 				is_right_button_down=button_index;
 746  01db 7b05          	ld	a,(OFST+0,sp)
 747  01dd c7008d        	ld	_is_right_button_down,a
 748                     ; 148 				button_start_ms=millis();
 750  01e0 cd0142        	call	_millis
 752  01e3 ae0089        	ldw	x,#_button_start_ms
 753  01e6 cd0000        	call	c_rtol
 755  01e9               L561:
 756                     ; 143 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 758  01e9 0c05          	inc	(OFST+0,sp)
 760  01eb               L161:
 763  01eb 7b05          	ld	a,(OFST+0,sp)
 764  01ed a102          	cp	a,#2
 765  01ef 2408          	jruge	L351
 767  01f1 ae0089        	ldw	x,#_button_start_ms
 768  01f4 cd0000        	call	c_lzmp
 770  01f7 27db          	jreq	L551
 771  01f9               L351:
 772                     ; 152 }
 775  01f9 5b05          	addw	sp,#5
 776  01fb 81            	ret	
 844                     ; 157 bool get_button_event(u8 button_index,u8 is_long,bool is_clear)
 844                     ; 158 {
 845                     	switch	.text
 846  01fc               _get_button_event:
 848  01fc 89            	pushw	x
 849  01fd 89            	pushw	x
 850       00000002      OFST:	set	2
 853                     ; 160 	bool out=0;
 855  01fe 0f01          	clr	(OFST-1,sp)
 857                     ; 161 	for(iter=0;iter<BUTTON_COUNT;iter++)
 859  0200 0f02          	clr	(OFST+0,sp)
 861  0202               L122:
 862                     ; 163 		if(button_index==iter || button_index==0xFF)
 864  0202 7b03          	ld	a,(OFST+1,sp)
 865  0204 1102          	cp	a,(OFST+0,sp)
 866  0206 2703          	jreq	L132
 868  0208 4c            	inc	a
 869  0209 2638          	jrne	L722
 870  020b               L132:
 871                     ; 165 			if(is_long==0 || is_long==0xFF)
 873  020b 7b04          	ld	a,(OFST+2,sp)
 874  020d 2703          	jreq	L532
 876  020f 4c            	inc	a
 877  0210 2614          	jrne	L332
 878  0212               L532:
 879                     ; 167 				out|=button_pressed_event[iter][0];
 881  0212 7b02          	ld	a,(OFST+0,sp)
 882  0214 5f            	clrw	x
 883  0215 97            	ld	xl,a
 884  0216 58            	sllw	x
 885  0217 7b01          	ld	a,(OFST-1,sp)
 886  0219 da000d        	or	a,(_button_pressed_event,x)
 887  021c 6b01          	ld	(OFST-1,sp),a
 889                     ; 168 				if(is_clear) button_pressed_event[iter][0]=0;
 891  021e 7b07          	ld	a,(OFST+5,sp)
 892  0220 2704          	jreq	L332
 895  0222 724f000d      	clr	(_button_pressed_event,x)
 896  0226               L332:
 897                     ; 170 			if(is_long==1 || is_long==0xFF)
 899  0226 7b04          	ld	a,(OFST+2,sp)
 900  0228 a101          	cp	a,#1
 901  022a 2703          	jreq	L342
 903  022c 4c            	inc	a
 904  022d 2614          	jrne	L722
 905  022f               L342:
 906                     ; 172 				out|=button_pressed_event[iter][1];
 908  022f 7b02          	ld	a,(OFST+0,sp)
 909  0231 5f            	clrw	x
 910  0232 97            	ld	xl,a
 911  0233 58            	sllw	x
 912  0234 7b01          	ld	a,(OFST-1,sp)
 913  0236 da000e        	or	a,(_button_pressed_event+1,x)
 914  0239 6b01          	ld	(OFST-1,sp),a
 916                     ; 173 				if(is_clear) button_pressed_event[iter][1]=0;
 918  023b 7b07          	ld	a,(OFST+5,sp)
 919  023d 2704          	jreq	L722
 922  023f 724f000e      	clr	(_button_pressed_event+1,x)
 923  0243               L722:
 924                     ; 161 	for(iter=0;iter<BUTTON_COUNT;iter++)
 926  0243 0c02          	inc	(OFST+0,sp)
 930  0245 7b02          	ld	a,(OFST+0,sp)
 931  0247 a102          	cp	a,#2
 932  0249 25b7          	jrult	L122
 933                     ; 177 	return out;
 935  024b 7b01          	ld	a,(OFST-1,sp)
 938  024d 5b04          	addw	sp,#4
 939  024f 81            	ret	
 973                     ; 181 bool is_button_down(u8 index)
 973                     ; 182 {
 974                     	switch	.text
 975  0250               _is_button_down:
 979                     ; 183 	switch(index)
 982                     ; 186 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
 984  0250 4d            	tnz	a
 985  0251 2705          	jreq	L742
 986  0253 4a            	dec	a
 987  0254 2713          	jreq	L152
 988  0256 2022          	jra	L172
 989  0258               L742:
 990                     ; 185 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_3); break; }//left button
 992  0258 4b08          	push	#8
 993  025a ae500f        	ldw	x,#20495
 994  025d cd0000        	call	_GPIO_ReadInputPin
 996  0260 5b01          	addw	sp,#1
 997  0262 4d            	tnz	a
 998  0263 2602          	jrne	L271
 999  0265 4c            	inc	a
1001  0266 81            	ret	
1002  0267               L271:
1003  0267 4f            	clr	a
1006  0268 81            	ret	
1007  0269               L152:
1008                     ; 186 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_4); break; }//right button
1011  0269 4b10          	push	#16
1012  026b ae500f        	ldw	x,#20495
1013  026e cd0000        	call	_GPIO_ReadInputPin
1015  0271 5b01          	addw	sp,#1
1016  0273 4d            	tnz	a
1017  0274 2602          	jrne	L002
1018  0276 4c            	inc	a
1020  0277 81            	ret	
1021  0278               L002:
1022  0278 4f            	clr	a
1025  0279 81            	ret	
1026  027a               L172:
1027                     ; 189 	return 0;
1029  027a 4f            	clr	a
1032  027b 81            	ret	
1035                     	switch	.data
1036  008e               _is_developer_debug:
1037  008e 01            	dc.b	1
1038  008f               _developer_flag:
1039  008f 00            	dc.b	0
1040  0090               _i2c_transaction_byte_count:
1041  0090 00            	dc.b	0
1063                     ; 205 u8 get_developer_flag(){ return developer_flag; }
1064                     	switch	.text
1065  027c               _get_developer_flag:
1071  027c c6008f        	ld	a,_developer_flag
1074  027f 81            	ret	
1108                     ; 206 void set_developer_flag(u8 value)
1108                     ; 207 {
1109                     	switch	.text
1110  0280               _set_developer_flag:
1112  0280 88            	push	a
1113       00000000      OFST:	set	0
1116                     ; 208 	if(value!=0) GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_SLOW);//frame_buffer_pin
1118  0281 4d            	tnz	a
1119  0282 270b          	jreq	L713
1122  0284 4bd0          	push	#208
1123  0286 4b20          	push	#32
1124  0288 ae500f        	ldw	x,#20495
1125  028b cd0000        	call	_GPIO_Init
1127  028e 85            	popw	x
1128  028f               L713:
1129                     ; 209 	developer_flag=value;
1131  028f 7b01          	ld	a,(OFST+1,sp)
1132  0291 c7008f        	ld	_developer_flag,a
1133                     ; 210 	if(value==0) GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_SLOW);
1135  0294 260b          	jrne	L123
1138  0296 4bc0          	push	#192
1139  0298 4b20          	push	#32
1140  029a ae500f        	ldw	x,#20495
1141  029d cd0000        	call	_GPIO_Init
1143  02a0 85            	popw	x
1144  02a1               L123:
1145                     ; 211 }
1148  02a1 84            	pop	a
1149  02a2 81            	ret	
1174                     ; 218 	void I2C_transaction_begin(void)
1174                     ; 219 	{
1175                     	switch	.text
1176  02a3               _I2C_transaction_begin:
1180                     ; 220 		MessageBegin = TRUE;
1182  02a3 35010004      	mov	_MessageBegin,#1
1183                     ; 222 	}
1186  02a7 81            	ret	
1231                     ; 223 	void I2C_transaction_end(bool is_slave_txd)
1231                     ; 224 	{
1232                     	switch	.text
1233  02a8               _I2C_transaction_end:
1237                     ; 225 		is_valid_i2c_received=1;
1239  02a8 35010088      	mov	_is_valid_i2c_received,#1
1240                     ; 226 		if(is_slave_txd)
1242  02ac 4d            	tnz	a
1243  02ad 2706          	jreq	L363
1244                     ; 228 			u8_My_Buffer[2]=u8_My_Buffer[2]+1;
1246  02af 725c0009      	inc	_u8_My_Buffer+2
1248  02b3 202d          	jra	L563
1249  02b5               L363:
1250                     ; 230 			u8_My_Buffer[1]=u8_My_Buffer[1]+1;
1252  02b5 725c0008      	inc	_u8_My_Buffer+1
1253                     ; 231 			switch(this_addr)
1255  02b9 c60003        	ld	a,_this_addr
1257                     ; 251 				default: break;
1258  02bc 270c          	jreq	L333
1259  02be a003          	sub	a,#3
1260  02c0 2725          	jreq	L533
1261  02c2 4a            	dec	a
1262  02c3 273c          	jreq	L733
1263  02c5 4a            	dec	a
1264  02c6 274a          	jreq	L143
1265  02c8 2018          	jra	L563
1266  02ca               L333:
1267                     ; 234 					is_developer_debug=!is_developer_debug;
1269  02ca 725d008e      	tnz	_is_developer_debug
1270  02ce 2603          	jrne	L222
1271  02d0 4c            	inc	a
1272  02d1 2001          	jra	L422
1273  02d3               L222:
1274  02d3 4f            	clr	a
1275  02d4               L422:
1276  02d4 c7008e        	ld	_is_developer_debug,a
1277                     ; 235 					set_debug(is_developer_debug?0xFF:0);
1279  02d7 2702          	jreq	L032
1280  02d9 a6ff          	ld	a,#255
1281  02db               L032:
1282  02db cd0813        	call	_set_debug
1284                     ; 236 					set_developer_flag(1);
1286  02de a601          	ld	a,#1
1287  02e0               LC001:
1288  02e0 ad9e          	call	_set_developer_flag
1290                     ; 237 				}break;
1291  02e2               L563:
1292                     ; 254 		i2c_transaction_byte_count=0;
1294  02e2 725f0090      	clr	_i2c_transaction_byte_count
1295                     ; 255 	}
1298  02e6 81            	ret	
1299  02e7               L533:
1300                     ; 239 						if(i2c_transaction_byte_count>1 && u8_MyBuffp==&u8_My_Buffer[4])
1302  02e7 c60090        	ld	a,_i2c_transaction_byte_count
1303  02ea a102          	cp	a,#2
1304  02ec 25f4          	jrult	L563
1306  02ee ce0005        	ldw	x,_u8_MyBuffp
1307  02f1 a3000b        	cpw	x,#_u8_My_Buffer+4
1308  02f4 26ec          	jrne	L563
1309                     ; 241 							set_developer_flag(u8_My_Buffer[3]);
1311  02f6 c6000a        	ld	a,_u8_My_Buffer+3
1312  02f9 ad85          	call	_set_developer_flag
1314                     ; 242 							u8_My_Buffer[3]=0;//reset the led_index register to default state
1316  02fb 725f000a      	clr	_u8_My_Buffer+3
1317  02ff 20e1          	jra	L563
1318  0301               L733:
1319                     ; 246 					if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1321  0301 c6000a        	ld	a,_u8_My_Buffer+3
1322  0304 a11f          	cp	a,#31
1323  0306 24da          	jruge	L563
1326  0308 5f            	clrw	x
1327  0309 97            	ld	xl,a
1328  030a c6000b        	ld	a,_u8_My_Buffer+4
1329  030d d70011        	ld	(_pwm_brightness_buffer,x),a
1330  0310 20d0          	jra	L563
1331  0312               L143:
1332                     ; 249 					set_developer_flag(u8_My_Buffer[5]);//note: an excessively high value here (>>10) will cause the LEDs on the SAO to flicker notably
1334  0312 c6000c        	ld	a,_u8_My_Buffer+5
1336                     ; 250 				}break;
1338  0315 20c9          	jp	LC001
1339                     ; 251 				default: break;
1378                     ; 256 	void I2C_byte_received(u8 u8_RxData)
1378                     ; 257 	{
1379                     	switch	.text
1380  0317               _I2C_byte_received:
1382  0317 88            	push	a
1383       00000000      OFST:	set	0
1386                     ; 258 		if (MessageBegin == TRUE  &&  u8_RxData < ADDRESS_COUNT_READ) {
1388  0318 c60004        	ld	a,_MessageBegin
1389  031b 4a            	dec	a
1390  031c 2617          	jrne	L314
1392  031e 7b01          	ld	a,(OFST+1,sp)
1393  0320 a108          	cp	a,#8
1394  0322 2411          	jruge	L314
1395                     ; 259 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
1397  0324 5f            	clrw	x
1398  0325 97            	ld	xl,a
1399  0326 1c0007        	addw	x,#_u8_My_Buffer
1400  0329 cf0005        	ldw	_u8_MyBuffp,x
1401                     ; 260 			MessageBegin = FALSE;
1403  032c 725f0004      	clr	_MessageBegin
1404                     ; 261 			this_addr=u8_RxData;
1406  0330 c70003        	ld	_this_addr,a
1408  0333 2037          	jra	L514
1409  0335               L314:
1410                     ; 265 			i2c_transaction_byte_count++;
1412  0335 725c0090      	inc	_i2c_transaction_byte_count
1413                     ; 266       if(u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE]) *(u8_MyBuffp++) = u8_RxData;
1415  0339 ce0005        	ldw	x,_u8_MyBuffp
1416  033c a3000d        	cpw	x,#_u8_My_Buffer+6
1417  033f 2407          	jruge	L714
1420  0341 7b01          	ld	a,(OFST+1,sp)
1421  0343 f7            	ld	(x),a
1422  0344 5c            	incw	x
1423  0345 cf0005        	ldw	_u8_MyBuffp,x
1424  0348               L714:
1425                     ; 267 			if(this_addr==3 && u8_MyBuffp==&u8_My_Buffer[5])
1427  0348 c60003        	ld	a,_this_addr
1428  034b a103          	cp	a,#3
1429  034d 261d          	jrne	L514
1431  034f a3000c        	cpw	x,#_u8_My_Buffer+5
1432  0352 2618          	jrne	L514
1433                     ; 269 				if(u8_My_Buffer[3]<LED_COUNT) pwm_brightness_buffer[u8_My_Buffer[3]]=u8_My_Buffer[4];
1435  0354 c6000a        	ld	a,_u8_My_Buffer+3
1436  0357 a11f          	cp	a,#31
1437  0359 240b          	jruge	L324
1440  035b 5f            	clrw	x
1441  035c 97            	ld	xl,a
1442  035d c6000b        	ld	a,_u8_My_Buffer+4
1443  0360 d70011        	ld	(_pwm_brightness_buffer,x),a
1444  0363 ce0005        	ldw	x,_u8_MyBuffp
1445  0366               L324:
1446                     ; 270 				u8_MyBuffp-=2;
1448  0366 1d0002        	subw	x,#2
1449  0369 cf0005        	ldw	_u8_MyBuffp,x
1450  036c               L514:
1451                     ; 273 	}
1454  036c 84            	pop	a
1455  036d 81            	ret	
1483                     ; 274 	u8 I2C_byte_write(void)
1483                     ; 275 	{
1484                     	switch	.text
1485  036e               _I2C_byte_write:
1487  036e 5205          	subw	sp,#5
1488       00000005      OFST:	set	5
1491                     ; 276 		if (u8_MyBuffp < &u8_My_Buffer[ADDRESS_COUNT_WRITE])
1493  0370 ce0005        	ldw	x,_u8_MyBuffp
1494  0373 a3000d        	cpw	x,#_u8_My_Buffer+6
1495  0376 2408          	jruge	L534
1496                     ; 277 			return *(u8_MyBuffp++);
1498  0378 f6            	ld	a,(x)
1499  0379 5c            	incw	x
1500  037a cf0005        	ldw	_u8_MyBuffp,x
1502  037d cc040d        	jra	L203
1503  0380               L534:
1504                     ; 278 		else if(this_addr==6 || this_addr==7)
1506  0380 c60003        	ld	a,_this_addr
1507  0383 a106          	cp	a,#6
1508  0385 2707          	jreq	L344
1510  0387 a107          	cp	a,#7
1511  0389 2703cc0410    	jrne	L144
1512  038e               L344:
1513                     ; 280 			return
1513                     ; 281 				get_button_event(1,1,this_addr==7)<<5 |
1513                     ; 282 				get_button_event(0,1,this_addr==7)<<4 |
1513                     ; 283 				get_button_event(1,0,this_addr==7)<<3 |
1513                     ; 284 				get_button_event(0,0,this_addr==7)<<2 |
1513                     ; 285 				is_button_down(1)<<1 |
1513                     ; 286 				is_button_down(0);
1515  038e 4f            	clr	a
1516  038f cd0250        	call	_is_button_down
1518  0392 6b05          	ld	(OFST+0,sp),a
1520  0394 a601          	ld	a,#1
1521  0396 cd0250        	call	_is_button_down
1523  0399 48            	sll	a
1524  039a 6b04          	ld	(OFST-1,sp),a
1526  039c c60003        	ld	a,_this_addr
1527  039f a107          	cp	a,#7
1528  03a1 2604          	jrne	L452
1529  03a3 a601          	ld	a,#1
1530  03a5 2001          	jra	L652
1531  03a7               L452:
1532  03a7 4f            	clr	a
1533  03a8               L652:
1534  03a8 88            	push	a
1535  03a9 5f            	clrw	x
1536  03aa cd01fc        	call	_get_button_event
1538  03ad 5b01          	addw	sp,#1
1539  03af 48            	sll	a
1540  03b0 48            	sll	a
1541  03b1 6b03          	ld	(OFST-2,sp),a
1543  03b3 c60003        	ld	a,_this_addr
1544  03b6 a107          	cp	a,#7
1545  03b8 2604          	jrne	L262
1546  03ba a601          	ld	a,#1
1547  03bc 2001          	jra	L462
1548  03be               L262:
1549  03be 4f            	clr	a
1550  03bf               L462:
1551  03bf 88            	push	a
1552  03c0 ae0100        	ldw	x,#256
1553  03c3 cd01fc        	call	_get_button_event
1555  03c6 5b01          	addw	sp,#1
1556  03c8 48            	sll	a
1557  03c9 48            	sll	a
1558  03ca 48            	sll	a
1559  03cb 6b02          	ld	(OFST-3,sp),a
1561  03cd c60003        	ld	a,_this_addr
1562  03d0 a107          	cp	a,#7
1563  03d2 2604          	jrne	L072
1564  03d4 a601          	ld	a,#1
1565  03d6 2001          	jra	L272
1566  03d8               L072:
1567  03d8 4f            	clr	a
1568  03d9               L272:
1569  03d9 88            	push	a
1570  03da ae0001        	ldw	x,#1
1571  03dd cd01fc        	call	_get_button_event
1573  03e0 5b01          	addw	sp,#1
1574  03e2 97            	ld	xl,a
1575  03e3 a610          	ld	a,#16
1576  03e5 42            	mul	x,a
1577  03e6 9f            	ld	a,xl
1578  03e7 6b01          	ld	(OFST-4,sp),a
1580  03e9 c60003        	ld	a,_this_addr
1581  03ec a107          	cp	a,#7
1582  03ee 2604          	jrne	L672
1583  03f0 a601          	ld	a,#1
1584  03f2 2001          	jra	L003
1585  03f4               L672:
1586  03f4 4f            	clr	a
1587  03f5               L003:
1588  03f5 88            	push	a
1589  03f6 ae0101        	ldw	x,#257
1590  03f9 cd01fc        	call	_get_button_event
1592  03fc 5b01          	addw	sp,#1
1593  03fe 97            	ld	xl,a
1594  03ff a620          	ld	a,#32
1595  0401 42            	mul	x,a
1596  0402 9f            	ld	a,xl
1597  0403 1a01          	or	a,(OFST-4,sp)
1598  0405 1a02          	or	a,(OFST-3,sp)
1599  0407 1a03          	or	a,(OFST-2,sp)
1600  0409 1a04          	or	a,(OFST-1,sp)
1601  040b 1a05          	or	a,(OFST+0,sp)
1603  040d               L203:
1605  040d 5b05          	addw	sp,#5
1606  040f 81            	ret	
1607  0410               L144:
1608                     ; 289 			return 0x00;
1610  0410 4f            	clr	a
1612  0411 20fa          	jra	L203
1664                     ; 293 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1666                     	switch	.text
1667  0413               f_TIM2_UPD_OVF_IRQHandler:
1669  0413 8a            	push	cc
1670  0414 84            	pop	a
1671  0415 a4bf          	and	a,#191
1672  0417 88            	push	a
1673  0418 86            	pop	cc
1674       00000005      OFST:	set	5
1675  0419 3b0002        	push	c_x+2
1676  041c be00          	ldw	x,c_x
1677  041e 89            	pushw	x
1678  041f 3b0002        	push	c_y+2
1679  0422 be00          	ldw	x,c_y
1680  0424 89            	pushw	x
1681  0425 be02          	ldw	x,c_lreg+2
1682  0427 89            	pushw	x
1683  0428 be00          	ldw	x,c_lreg
1684  042a 89            	pushw	x
1685  042b 5205          	subw	sp,#5
1688                     ; 294 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1690  042d c60087        	ld	a,_pwm_state
1691  0430 a401          	and	a,#1
1692  0432 6b03          	ld	(OFST-2,sp),a
1694                     ; 295 	u16 sleep_counts=1;
1696  0434 ae0001        	ldw	x,#1
1697  0437 1f04          	ldw	(OFST-1,sp),x
1699                     ; 297 	GPIOC->DDR &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));
1701  0439 c6500c        	ld	a,20492
1702  043c a407          	and	a,#7
1703  043e c7500c        	ld	20492,a
1704                     ; 298 	GPIOD->DDR &= (uint8_t)(~(GPIO_PIN_2));
1706  0441 72155011      	bres	20497,#2
1707                     ; 299 	GPIOA->DDR &= (uint8_t)(~(GPIO_PIN_3));
1709  0445 72175002      	bres	20482,#3
1710                     ; 300 	GPIOC->CR1 &= (uint8_t)(~(GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3));//float
1712  0449 c6500d        	ld	a,20493
1713  044c a407          	and	a,#7
1714  044e c7500d        	ld	20493,a
1715                     ; 301 	GPIOD->CR1 &= (uint8_t)(~(GPIO_PIN_2));
1717  0451 72155012      	bres	20498,#2
1718                     ; 302 	GPIOA->CR1 &= (uint8_t)(~(GPIO_PIN_3));
1720  0455 72175003      	bres	20483,#3
1721                     ; 303   TIM2->CR1 &= ~TIM2_CR1_CEN;  // Clear the CEN bit to stop the timer
1723  0459 72115300      	bres	21248,#0
1724                     ; 304 	if(pwm_visible_index==pwm_led_count[buffer_index])//hold all LEDs OFF at end of frame to stabalize the display brightness, regardless of how long the displayed LEDs are ON for
1726  045d 7b03          	ld	a,(OFST-2,sp)
1727  045f 8d070507      	callf	LC002
1728  0463 260a          	jrne	L764
1729                     ; 306 		sleep_counts=pwm_sleep[buffer_index];
1731  0465 7b03          	ld	a,(OFST-2,sp)
1732  0467 5f            	clrw	x
1733  0468 97            	ld	xl,a
1734  0469 58            	sllw	x
1735  046a de0080        	ldw	x,(_pwm_sleep,x)
1736  046d 1f04          	ldw	(OFST-1,sp),x
1738  046f               L764:
1739                     ; 308 	if(pwm_visible_index>pwm_led_count[buffer_index])
1741  046f 7b03          	ld	a,(OFST-2,sp)
1742  0471 8d070507      	callf	LC002
1743  0475 2418          	jruge	L174
1744                     ; 310 		pwm_visible_index=0;//formally start new frame
1746  0477 725f0086      	clr	_pwm_visible_index
1747                     ; 311 		update_buttons();
1749  047b cd014d        	call	_update_buttons
1751                     ; 312 		if(pwm_state&0x02)
1753  047e 720300870c    	btjf	_pwm_state,#1,L174
1754                     ; 314 			pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1756  0483 c60087        	ld	a,_pwm_state
1757  0486 a803          	xor	a,#3
1758  0488 c70087        	ld	_pwm_state,a
1759                     ; 315 			buffer_index=pwm_state&0x01;//recompute primary vs redundant side to pull data from if on a new frame
1761  048b a401          	and	a,#1
1762  048d 6b03          	ld	(OFST-2,sp),a
1764  048f               L174:
1765                     ; 318 	if(pwm_visible_index<pwm_led_count[buffer_index])
1767  048f 7b03          	ld	a,(OFST-2,sp)
1768  0491 8d070507      	callf	LC002
1769  0495 2332          	jrule	L574
1770                     ; 320 		sleep_counts=pwm_brightness[pwm_visible_index][buffer_index];//how long to keep it ON
1772  0497 7b03          	ld	a,(OFST-2,sp)
1773  0499 5f            	clrw	x
1774  049a 97            	ld	xl,a
1775  049b 58            	sllw	x
1776  049c 1f01          	ldw	(OFST-4,sp),x
1778  049e c60086        	ld	a,_pwm_visible_index
1779  04a1 97            	ld	xl,a
1780  04a2 a604          	ld	a,#4
1781  04a4 42            	mul	x,a
1782  04a5 72fb01        	addw	x,(OFST-4,sp)
1783  04a8 de0004        	ldw	x,(_pwm_brightness,x)
1784  04ab 1f04          	ldw	(OFST-1,sp),x
1786                     ; 321 		if(sleep_counts==0)
1788  04ad 2607          	jrne	L774
1789                     ; 323 			sleep_counts=1<<10;
1791  04af ae0400        	ldw	x,#1024
1792  04b2 1f04          	ldw	(OFST-1,sp),x
1795  04b4 2013          	jra	L574
1796  04b6               L774:
1797                     ; 325 			set_led_on(pwm_brightness_index[pwm_visible_index][buffer_index]);//turn ON this LED
1799  04b6 c60086        	ld	a,_pwm_visible_index
1800  04b9 5f            	clrw	x
1801  04ba 97            	ld	xl,a
1802  04bb 58            	sllw	x
1803  04bc 01            	rrwa	x,a
1804  04bd 1b03          	add	a,(OFST-2,sp)
1805  04bf 2401          	jrnc	L213
1806  04c1 5c            	incw	x
1807  04c2               L213:
1808  04c2 02            	rlwa	x,a
1809  04c3 d60030        	ld	a,(_pwm_brightness_index,x)
1810  04c6 cd05a8        	call	_set_led_on
1812  04c9               L574:
1813                     ; 328 	pwm_visible_index++;
1815  04c9 725c0086      	inc	_pwm_visible_index
1816                     ; 329 	atomic_counter+=sleep_counts;
1818  04cd 1e04          	ldw	x,(OFST-1,sp)
1819  04cf cd0000        	call	c_uitolx
1821  04d2 ae0000        	ldw	x,#_atomic_counter
1822  04d5 cd0000        	call	c_lgadd
1824                     ; 331   TIM2->CNTRH = 0;// Set the high byte of the counter
1826  04d8 725f530c      	clr	21260
1827                     ; 332   TIM2->CNTRL = 0;// Set the low byte of the counter
1829  04dc 725f530d      	clr	21261
1830                     ; 333 	TIM2->ARRH= sleep_counts>>8;// init auto reload register
1832  04e0 7b04          	ld	a,(OFST-1,sp)
1833  04e2 c7530f        	ld	21263,a
1834                     ; 334 	TIM2->ARRL= sleep_counts&0x00FF;// init auto reload register
1836  04e5 7b05          	ld	a,(OFST+0,sp)
1837  04e7 c75310        	ld	21264,a
1838                     ; 336 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1840  04ea 72115304      	bres	21252,#0
1841                     ; 337   TIM2->CR1 |= TIM2_CR1_CEN;   // Set the CEN bit to restart the timer
1843  04ee 72105300      	bset	21248,#0
1844                     ; 338 }
1847  04f2 5b05          	addw	sp,#5
1848  04f4 85            	popw	x
1849  04f5 bf00          	ldw	c_lreg,x
1850  04f7 85            	popw	x
1851  04f8 bf02          	ldw	c_lreg+2,x
1852  04fa 85            	popw	x
1853  04fb bf00          	ldw	c_y,x
1854  04fd 320002        	pop	c_y+2
1855  0500 85            	popw	x
1856  0501 bf00          	ldw	c_x,x
1857  0503 320002        	pop	c_x+2
1858  0506 80            	iret	
1859  0507               LC002:
1860  0507 5f            	clrw	x
1861  0508 97            	ld	xl,a
1862  0509 d60084        	ld	a,(_pwm_led_count,x)
1863  050c c10086        	cp	a,_pwm_visible_index
1864  050f 87            	retf	
1866                     	switch	.bss
1867  0000               L305_sr1:
1868  0000 00            	ds.b	1
1869  0001               L505_sr2:
1870  0001 00            	ds.b	1
1871  0002               L705_sr3:
1872  0002 00            	ds.b	1
1920                     ; 340 @far @interrupt void I2C_EventHandler(void)
1920                     ; 341 {
1921                     	switch	.text
1922  0510               f_I2C_EventHandler:
1924  0510 8a            	push	cc
1925  0511 84            	pop	a
1926  0512 a4bf          	and	a,#191
1927  0514 88            	push	a
1928  0515 86            	pop	cc
1929  0516 3b0002        	push	c_x+2
1930  0519 be00          	ldw	x,c_x
1931  051b 89            	pushw	x
1932  051c 3b0002        	push	c_y+2
1933  051f be00          	ldw	x,c_y
1934  0521 89            	pushw	x
1937                     ; 347 sr1 = I2C->SR1;
1939  0522 5552170000    	mov	L305_sr1,21015
1940                     ; 348 sr2 = I2C->SR2;
1942  0527 5552180001    	mov	L505_sr2,21016
1943                     ; 349 sr3 = I2C->SR3;
1945  052c 5552190002    	mov	L705_sr3,21017
1946                     ; 352   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1948  0531 c60001        	ld	a,L505_sr2
1949  0534 a52b          	bcp	a,#43
1950  0536 2708          	jreq	L135
1951                     ; 354     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1953  0538 72125211      	bset	21009,#1
1954                     ; 355     I2C->SR2= 0;					    // clear all error flags
1956  053c 725f5218      	clr	21016
1957  0540               L135:
1958                     ; 358   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1960  0540 c60000        	ld	a,L305_sr1
1961  0543 a444          	and	a,#68
1962  0545 a144          	cp	a,#68
1963  0547 2606          	jrne	L335
1964                     ; 360     I2C_byte_received(I2C->DR);
1966  0549 c65216        	ld	a,21014
1967  054c cd0317        	call	_I2C_byte_received
1969  054f               L335:
1970                     ; 363   if (sr1 & I2C_SR1_RXNE)
1972  054f 720d000006    	btjf	L305_sr1,#6,L535
1973                     ; 365     I2C_byte_received(I2C->DR);
1975  0554 c65216        	ld	a,21014
1976  0557 cd0317        	call	_I2C_byte_received
1978  055a               L535:
1979                     ; 368   if (sr2 & I2C_SR2_AF)
1981  055a 7205000109    	btjf	L505_sr2,#2,L735
1982                     ; 370     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1984  055f 72155218      	bres	21016,#2
1985                     ; 371 		I2C_transaction_end(1);
1987  0563 a601          	ld	a,#1
1988  0565 cd02a8        	call	_I2C_transaction_end
1990  0568               L735:
1991                     ; 374   if (sr1 & I2C_SR1_STOPF) 
1993  0568 7209000008    	btjf	L305_sr1,#4,L145
1994                     ; 376     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1996  056d 72145211      	bset	21009,#2
1997                     ; 377 		I2C_transaction_end(0);
1999  0571 4f            	clr	a
2000  0572 cd02a8        	call	_I2C_transaction_end
2002  0575               L145:
2003                     ; 380   if (sr1 & I2C_SR1_ADDR)
2005  0575 7203000003    	btjf	L305_sr1,#1,L345
2006                     ; 382 		I2C_transaction_begin();
2008  057a cd02a3        	call	_I2C_transaction_begin
2010  057d               L345:
2011                     ; 385   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
2013  057d c60000        	ld	a,L305_sr1
2014  0580 a484          	and	a,#132
2015  0582 a184          	cp	a,#132
2016  0584 2606          	jrne	L545
2017                     ; 387 		I2C->DR = I2C_byte_write();
2019  0586 cd036e        	call	_I2C_byte_write
2021  0589 c75216        	ld	21014,a
2022  058c               L545:
2023                     ; 390   if (sr1 & I2C_SR1_TXE)
2025  058c 720f000006    	btjf	L305_sr1,#7,L745
2026                     ; 392 		I2C->DR = I2C_byte_write();
2028  0591 cd036e        	call	_I2C_byte_write
2030  0594 c75216        	ld	21014,a
2031  0597               L745:
2032                     ; 394 	GPIOD->ODR^=1;
2034  0597 9010500f      	bcpl	20495,#0
2035                     ; 395 }
2038  059b 85            	popw	x
2039  059c bf00          	ldw	c_y,x
2040  059e 320002        	pop	c_y+2
2041  05a1 85            	popw	x
2042  05a2 bf00          	ldw	c_x,x
2043  05a4 320002        	pop	c_x+2
2044  05a7 80            	iret	
2046                     	switch	.const
2047  0008               L155_led_lookup:
2048  0008 00            	dc.b	0
2049  0009 03            	dc.b	3
2050  000a 01            	dc.b	1
2051  000b 03            	dc.b	3
2052  000c 02            	dc.b	2
2053  000d 03            	dc.b	3
2054  000e 03            	dc.b	3
2055  000f 00            	dc.b	0
2056  0010 04            	dc.b	4
2057  0011 00            	dc.b	0
2058  0012 05            	dc.b	5
2059  0013 00            	dc.b	0
2060  0014 00            	dc.b	0
2061  0015 04            	dc.b	4
2062  0016 01            	dc.b	1
2063  0017 04            	dc.b	4
2064  0018 02            	dc.b	2
2065  0019 04            	dc.b	4
2066  001a 03            	dc.b	3
2067  001b 01            	dc.b	1
2068  001c 04            	dc.b	4
2069  001d 01            	dc.b	1
2070  001e 05            	dc.b	5
2071  001f 01            	dc.b	1
2072  0020 00            	dc.b	0
2073  0021 05            	dc.b	5
2074  0022 01            	dc.b	1
2075  0023 05            	dc.b	5
2076  0024 02            	dc.b	2
2077  0025 05            	dc.b	5
2078  0026 03            	dc.b	3
2079  0027 02            	dc.b	2
2080  0028 04            	dc.b	4
2081  0029 02            	dc.b	2
2082  002a 05            	dc.b	5
2083  002b 02            	dc.b	2
2084  002c 06            	dc.b	6
2085  002d 06            	dc.b	6
2086  002e 01            	dc.b	1
2087  002f 00            	dc.b	0
2088  0030 02            	dc.b	2
2089  0031 00            	dc.b	0
2090  0032 00            	dc.b	0
2091  0033 01            	dc.b	1
2092  0034 02            	dc.b	2
2093  0035 01            	dc.b	1
2094  0036 00            	dc.b	0
2095  0037 02            	dc.b	2
2096  0038 01            	dc.b	1
2097  0039 02            	dc.b	2
2098  003a 04            	dc.b	4
2099  003b 03            	dc.b	3
2100  003c 05            	dc.b	5
2101  003d 03            	dc.b	3
2102  003e 03            	dc.b	3
2103  003f 04            	dc.b	4
2104  0040 05            	dc.b	5
2105  0041 04            	dc.b	4
2106  0042 03            	dc.b	3
2107  0043 05            	dc.b	5
2108  0044 04            	dc.b	4
2109  0045 05            	dc.b	5
2151                     ; 399 void set_led_on(u8 led_index)
2151                     ; 400 {
2153                     	switch	.text
2154  05a8               _set_led_on:
2156  05a8 88            	push	a
2157  05a9 5240          	subw	sp,#64
2158       00000040      OFST:	set	64
2161                     ; 401 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2161                     ; 402 		{0,3},{1,3},{2,3},{3,0},{4,0},{5,0},//reds
2161                     ; 403 		{0,4},{1,4},{2,4},{3,1},{4,1},{5,1},//greens
2161                     ; 404 		{0,5},{1,5},{2,5},{3,2},{4,2},{5,2},//blues
2161                     ; 405 		{6,6},//debug; GND is tied low, no charlieplexing involved
2161                     ; 406 		{1,0},//LED7
2161                     ; 407 		{2,0},//LED8
2161                     ; 408 		{0,1},//LED9
2161                     ; 409 		{2,1},//LED10
2161                     ; 410 		{0,2},//LED11
2161                     ; 411 		{1,2},//LED12
2161                     ; 412 		{4,3},//LED13
2161                     ; 413 		{5,3},//LED14
2161                     ; 414 		{3,4},//LED15
2161                     ; 415 		{5,4},//LED16
2161                     ; 416 		{3,5},//LED17
2161                     ; 417 		{4,5} //LED18
2161                     ; 418 	};
2163  05ab 96            	ldw	x,sp
2164  05ac 1c0003        	addw	x,#OFST-61
2165  05af 90ae0008      	ldw	y,#L155_led_lookup
2166  05b3 a63e          	ld	a,#62
2167  05b5 cd0000        	call	c_xymov
2169                     ; 419 	set_mat(led_lookup[led_index][0],1);
2171  05b8 96            	ldw	x,sp
2172  05b9 1c0003        	addw	x,#OFST-61
2173  05bc 1f01          	ldw	(OFST-63,sp),x
2175  05be 5f            	clrw	x
2176  05bf 7b41          	ld	a,(OFST+1,sp)
2177  05c1 97            	ld	xl,a
2178  05c2 58            	sllw	x
2179  05c3 72fb01        	addw	x,(OFST-63,sp)
2180  05c6 f6            	ld	a,(x)
2181  05c7 ae0001        	ldw	x,#1
2182  05ca 95            	ld	xh,a
2183  05cb ad1a          	call	_set_mat
2185                     ; 420 	if(led_index!=DEBUG_LED_INDEX) set_mat(led_lookup[led_index][1],0);
2187  05cd 7b41          	ld	a,(OFST+1,sp)
2188  05cf a112          	cp	a,#18
2189  05d1 2711          	jreq	L375
2192  05d3 96            	ldw	x,sp
2193  05d4 1c0004        	addw	x,#OFST-60
2194  05d7 1f01          	ldw	(OFST-63,sp),x
2196  05d9 5f            	clrw	x
2197  05da 97            	ld	xl,a
2198  05db 58            	sllw	x
2199  05dc 72fb01        	addw	x,(OFST-63,sp)
2200  05df f6            	ld	a,(x)
2201  05e0 5f            	clrw	x
2202  05e1 95            	ld	xh,a
2203  05e2 ad03          	call	_set_mat
2205  05e4               L375:
2206                     ; 421 }
2209  05e4 5b41          	addw	sp,#65
2210  05e6 81            	ret	
2409                     ; 426 void set_mat(u8 mat_index,bool is_high)
2409                     ; 427 {
2410                     	switch	.text
2411  05e7               _set_mat:
2413  05e7 89            	pushw	x
2414  05e8 5203          	subw	sp,#3
2415       00000003      OFST:	set	3
2418                     ; 430 	switch(mat_index)
2420  05ea 9e            	ld	a,xh
2422                     ; 438 		default: GPIOx=GPIOA; GPIO_Pin=GPIO_PIN_3; break;
2423  05eb 4d            	tnz	a
2424  05ec 2718          	jreq	L575
2425  05ee 4a            	dec	a
2426  05ef 271e          	jreq	L775
2427  05f1 4a            	dec	a
2428  05f2 2724          	jreq	L106
2429  05f4 4a            	dec	a
2430  05f5 272a          	jreq	L306
2431  05f7 4a            	dec	a
2432  05f8 2730          	jreq	L506
2433  05fa 4a            	dec	a
2434  05fb 2736          	jreq	L706
2437  05fd ae5000        	ldw	x,#20480
2438  0600 1f01          	ldw	(OFST-2,sp),x
2442  0602 a608          	ld	a,#8
2445  0604 2034          	jra	L137
2446  0606               L575:
2447                     ; 432 		case 0:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_3; break;
2449  0606 ae500a        	ldw	x,#20490
2450  0609 1f01          	ldw	(OFST-2,sp),x
2454  060b a608          	ld	a,#8
2457  060d 202b          	jra	L137
2458  060f               L775:
2459                     ; 433 		case 1:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_4; break;
2461  060f ae500a        	ldw	x,#20490
2462  0612 1f01          	ldw	(OFST-2,sp),x
2466  0614 a610          	ld	a,#16
2469  0616 2022          	jra	L137
2470  0618               L106:
2471                     ; 434 		case 2:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_5; break;
2473  0618 ae500a        	ldw	x,#20490
2474  061b 1f01          	ldw	(OFST-2,sp),x
2478  061d a620          	ld	a,#32
2481  061f 2019          	jra	L137
2482  0621               L306:
2483                     ; 435 		case 3:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_6; break;
2485  0621 ae500a        	ldw	x,#20490
2486  0624 1f01          	ldw	(OFST-2,sp),x
2490  0626 a640          	ld	a,#64
2493  0628 2010          	jra	L137
2494  062a               L506:
2495                     ; 436 		case 4:  GPIOx=GPIOC; GPIO_Pin=GPIO_PIN_7; break;
2497  062a ae500a        	ldw	x,#20490
2498  062d 1f01          	ldw	(OFST-2,sp),x
2502  062f a680          	ld	a,#128
2505  0631 2007          	jra	L137
2506  0633               L706:
2507                     ; 437 		case 5:  GPIOx=GPIOD; GPIO_Pin=GPIO_PIN_2; break;
2509  0633 ae500f        	ldw	x,#20495
2510  0636 1f01          	ldw	(OFST-2,sp),x
2514  0638 a604          	ld	a,#4
2517  063a               L137:
2518  063a 6b03          	ld	(OFST+0,sp),a
2520                     ; 440 	if(is_high) GPIOx->ODR |= (uint8_t)GPIO_Pin;
2522  063c 0d05          	tnz	(OFST+2,sp)
2523  063e 2705          	jreq	L337
2526  0640 f6            	ld	a,(x)
2527  0641 1a03          	or	a,(OFST+0,sp)
2529  0643 2002          	jra	L537
2530  0645               L337:
2531                     ; 441 	else        GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
2533  0645 43            	cpl	a
2534  0646 f4            	and	a,(x)
2535  0647               L537:
2536  0647 f7            	ld	(x),a
2537                     ; 442 	GPIOx->DDR |= (uint8_t)GPIO_Pin;
2539  0648 e602          	ld	a,(2,x)
2540  064a 1a03          	or	a,(OFST+0,sp)
2541  064c e702          	ld	(2,x),a
2542                     ; 443 	GPIOx->CR1 |= (uint8_t)GPIO_Pin;
2544  064e e603          	ld	a,(3,x)
2545  0650 1a03          	or	a,(OFST+0,sp)
2546  0652 e703          	ld	(3,x),a
2547                     ; 444 }
2550  0654 5b05          	addw	sp,#5
2551  0656 81            	ret	
2617                     ; 447 void flush_leds(u8 led_count)
2617                     ; 448 {
2618                     	switch	.text
2619  0657               _flush_leds:
2621  0657 88            	push	a
2622  0658 5207          	subw	sp,#7
2623       00000007      OFST:	set	7
2626                     ; 449 	u8 led_read_index=0,led_write_index=0;
2630  065a 0f05          	clr	(OFST-2,sp)
2633  065c               L767:
2634                     ; 452 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
2636  065c 72020087fb    	btjt	_pwm_state,#1,L767
2637                     ; 453 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
2639  0661 c60087        	ld	a,_pwm_state
2640  0664 a401          	and	a,#1
2641  0666 a801          	xor	a,#1
2642  0668 6b07          	ld	(OFST+0,sp),a
2644                     ; 455 	if(led_count==0) led_count=1;//min value
2646  066a 7b08          	ld	a,(OFST+1,sp)
2647  066c 2603          	jrne	L377
2650  066e 4c            	inc	a
2651  066f 6b08          	ld	(OFST+1,sp),a
2652  0671               L377:
2653                     ; 456 	pwm_sleep[buffer_index]=((uint16_t)led_count)<<10;//prepare the max value of sleep, and subtract from it for each LED illuminated based on brightness (time illuminated)
2655  0671 97            	ld	xl,a
2656  0672 4f            	clr	a
2657  0673 02            	rlwa	x,a
2658  0674 58            	sllw	x
2659  0675 58            	sllw	x
2660  0676 7b07          	ld	a,(OFST+0,sp)
2661  0678 cd0756        	call	LC003
2662                     ; 458 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2664  067b 4f            	clr	a
2665  067c 90df0080      	ldw	(_pwm_sleep,y),x
2666  0680 6b06          	ld	(OFST-1,sp),a
2668  0682               L577:
2669                     ; 460 		read_brightness=pwm_brightness_buffer[led_read_index];
2671  0682 5f            	clrw	x
2672  0683 97            	ld	xl,a
2673  0684 d60011        	ld	a,(_pwm_brightness_buffer,x)
2674  0687 5f            	clrw	x
2675  0688 97            	ld	xl,a
2676  0689 1f03          	ldw	(OFST-4,sp),x
2678                     ; 461 		if(read_brightness!=0)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
2680  068b 2765          	jreq	L3001
2681                     ; 463 			pwm_brightness_index[led_write_index][buffer_index]=led_read_index;
2683  068d 7b05          	ld	a,(OFST-2,sp)
2684  068f 5f            	clrw	x
2685  0690 97            	ld	xl,a
2686  0691 58            	sllw	x
2687  0692 01            	rrwa	x,a
2688  0693 1b07          	add	a,(OFST+0,sp)
2689  0695 2401          	jrnc	L643
2690  0697 5c            	incw	x
2691  0698               L643:
2692  0698 02            	rlwa	x,a
2693  0699 7b06          	ld	a,(OFST-1,sp)
2694  069b d70030        	ld	(_pwm_brightness_index,x),a
2695                     ; 464 			pwm_brightness[led_write_index][buffer_index]=((read_brightness*read_brightness)>>6)+1;//square 8-bit brightness and then clip 16 bit result down to 10 bits.  Values <8 are rounded to 0, so round that up to avoid zero-length display states
2697  069e 1e03          	ldw	x,(OFST-4,sp)
2698  06a0 9093          	ldw	y,x
2699  06a2 cd0000        	call	c_imul
2701  06a5 a606          	ld	a,#6
2702  06a7               L053:
2703  06a7 54            	srlw	x
2704  06a8 4a            	dec	a
2705  06a9 26fc          	jrne	L053
2706  06ab 5c            	incw	x
2707  06ac 7b07          	ld	a,(OFST+0,sp)
2708  06ae cd0756        	call	LC003
2709  06b1 1701          	ldw	(OFST-6,sp),y
2711  06b3 905f          	clrw	y
2712  06b5 7b05          	ld	a,(OFST-2,sp)
2713  06b7 9097          	ld	yl,a
2714  06b9 9058          	sllw	y
2715  06bb 9058          	sllw	y
2716  06bd 72f901        	addw	y,(OFST-6,sp)
2717  06c0 90df0004      	ldw	(_pwm_brightness,y),x
2718                     ; 465 			pwm_sleep[buffer_index]-=pwm_brightness[led_write_index][buffer_index];
2720  06c4 5f            	clrw	x
2721  06c5 7b07          	ld	a,(OFST+0,sp)
2722  06c7 97            	ld	xl,a
2723  06c8 58            	sllw	x
2724  06c9 cd0756        	call	LC003
2725  06cc 1701          	ldw	(OFST-6,sp),y
2727  06ce 905f          	clrw	y
2728  06d0 7b05          	ld	a,(OFST-2,sp)
2729  06d2 9097          	ld	yl,a
2730  06d4 9058          	sllw	y
2731  06d6 9058          	sllw	y
2732  06d8 72f901        	addw	y,(OFST-6,sp)
2733  06db 90de0004      	ldw	y,(_pwm_brightness,y)
2734  06df 9001          	rrwa	y,a
2735  06e1 d00081        	sub	a,(_pwm_sleep+1,x)
2736  06e4 9001          	rrwa	y,a
2737  06e6 d20080        	sbc	a,(_pwm_sleep,x)
2738  06e9 9001          	rrwa	y,a
2739  06eb 9050          	negw	y
2740  06ed df0080        	ldw	(_pwm_sleep,x),y
2741                     ; 466 			led_write_index++;
2743  06f0 0c05          	inc	(OFST-2,sp)
2745  06f2               L3001:
2746                     ; 468 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
2748  06f2 7b06          	ld	a,(OFST-1,sp)
2749  06f4 5f            	clrw	x
2750  06f5 97            	ld	xl,a
2751  06f6 724f0011      	clr	(_pwm_brightness_buffer,x)
2752                     ; 458 	for(led_read_index=0;led_read_index<LED_COUNT;led_read_index++)
2754  06fa 0c06          	inc	(OFST-1,sp)
2758  06fc 7b06          	ld	a,(OFST-1,sp)
2759  06fe a11f          	cp	a,#31
2760  0700 2580          	jrult	L577
2761                     ; 470 	if(pwm_sleep[buffer_index]>(LED_COUNT<<10)||pwm_sleep[buffer_index]==0) pwm_sleep[buffer_index]=1;//leds are trying to be brighter than max, causing a negative sleep time to equalize brightness
2763  0702 7b07          	ld	a,(OFST+0,sp)
2764  0704 5f            	clrw	x
2765  0705 97            	ld	xl,a
2766  0706 58            	sllw	x
2767  0707 9093          	ldw	y,x
2768  0709 90de0080      	ldw	y,(_pwm_sleep,y)
2769  070d 90a37c01      	cpw	y,#31745
2770  0711 2408          	jruge	L7001
2772  0713 d60081        	ld	a,(_pwm_sleep+1,x)
2773  0716 da0080        	or	a,(_pwm_sleep,x)
2774  0719 2607          	jrne	L5001
2775  071b               L7001:
2778  071b 90ae0001      	ldw	y,#1
2779  071f df0080        	ldw	(_pwm_sleep,x),y
2780  0722               L5001:
2781                     ; 471 	if(led_write_index==0)
2783  0722 7b05          	ld	a,(OFST-2,sp)
2784  0724 2620          	jrne	L1101
2785                     ; 473 		led_write_index=1;
2787  0726 4c            	inc	a
2788  0727 6b05          	ld	(OFST-2,sp),a
2790                     ; 474 		pwm_sleep[buffer_index]=1<<10;
2792  0729 5f            	clrw	x
2793  072a 7b07          	ld	a,(OFST+0,sp)
2794  072c 97            	ld	xl,a
2795  072d 58            	sllw	x
2796  072e 90ae0400      	ldw	y,#1024
2797  0732 df0080        	ldw	(_pwm_sleep,x),y
2798                     ; 475 		pwm_brightness_index[0][buffer_index]=DEBUG_LED_INDEX;
2800  0735 5f            	clrw	x
2801  0736 97            	ld	xl,a
2802  0737 a612          	ld	a,#18
2803  0739 d70030        	ld	(_pwm_brightness_index,x),a
2804                     ; 476 		pwm_brightness[0][buffer_index]=0;
2806  073c 5f            	clrw	x
2807  073d 7b07          	ld	a,(OFST+0,sp)
2808  073f 97            	ld	xl,a
2809  0740 58            	sllw	x
2810  0741 905f          	clrw	y
2811  0743 df0004        	ldw	(_pwm_brightness,x),y
2812  0746               L1101:
2813                     ; 478 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm routine state machine.
2815  0746 7b07          	ld	a,(OFST+0,sp)
2816  0748 5f            	clrw	x
2817  0749 97            	ld	xl,a
2818  074a 7b05          	ld	a,(OFST-2,sp)
2819  074c d70084        	ld	(_pwm_led_count,x),a
2820                     ; 481 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
2822  074f 72120087      	bset	_pwm_state,#1
2823                     ; 482 }
2826  0753 5b08          	addw	sp,#8
2827  0755 81            	ret	
2828  0756               LC003:
2829  0756 905f          	clrw	y
2830  0758 9097          	ld	yl,a
2831  075a 9058          	sllw	y
2832  075c 81            	ret	
2925                     ; 485 void set_hue_max(u8 index,u16 color)
2925                     ; 486 {
2926                     	switch	.text
2927  075d               _set_hue_max:
2929  075d 88            	push	a
2930  075e 5207          	subw	sp,#7
2931       00000007      OFST:	set	7
2934                     ; 489 	const u8 MAX_BRIGHTNESS=180;//180**2+180**2 < 255**2  --> effectively just 1 LED ON regardless of color
2936  0760 a6b4          	ld	a,#180
2937  0762 6b06          	ld	(OFST-1,sp),a
2939                     ; 490 	const u8 BRIGHTNESS_STEP=61;//CEIL(0x2AAB/MAX_BRIGHTNESS)
2941  0764 a63d          	ld	a,#61
2942  0766 6b01          	ld	(OFST-6,sp),a
2944                     ; 491 	u8 red=0,green=0,blue=0;
2946  0768 0f02          	clr	(OFST-5,sp)
2950  076a 0f03          	clr	(OFST-4,sp)
2954  076c 0f04          	clr	(OFST-3,sp)
2956                     ; 492 	u8 residual=0;
2958  076e 0f07          	clr	(OFST+0,sp)
2960                     ; 494 	for(iter=0;iter<6;iter++)
2962  0770 0f05          	clr	(OFST-2,sp)
2964  0772               L7601:
2965                     ; 496 		if(color<0x2AAB)
2967  0772 1e0b          	ldw	x,(OFST+4,sp)
2968  0774 a32aab        	cpw	x,#10923
2969  0777 2408          	jruge	L5701
2970                     ; 498 			residual=color/BRIGHTNESS_STEP;
2972  0779 7b01          	ld	a,(OFST-6,sp)
2973  077b 62            	div	x,a
2974  077c 01            	rrwa	x,a
2975  077d 6b07          	ld	(OFST+0,sp),a
2977                     ; 499 			break;
2979  077f 200d          	jra	L3701
2980  0781               L5701:
2981                     ; 501 		color-=0x2AAB;
2983  0781 1d2aab        	subw	x,#10923
2984  0784 1f0b          	ldw	(OFST+4,sp),x
2985                     ; 494 	for(iter=0;iter<6;iter++)
2987  0786 0c05          	inc	(OFST-2,sp)
2991  0788 7b05          	ld	a,(OFST-2,sp)
2992  078a a106          	cp	a,#6
2993  078c 25e4          	jrult	L7601
2994  078e               L3701:
2995                     ; 503 	switch(iter)
2997  078e 7b05          	ld	a,(OFST-2,sp)
2999                     ; 510 		default: red=MAX_BRIGHTNESS; blue=MAX_BRIGHTNESS-residual; break;
3000  0790 2714          	jreq	L3101
3001  0792 4a            	dec	a
3002  0793 2719          	jreq	L5101
3003  0795 4a            	dec	a
3004  0796 271e          	jreq	L7101
3005  0798 4a            	dec	a
3006  0799 2725          	jreq	L1201
3007  079b 4a            	dec	a
3008  079c 272c          	jreq	L3201
3011  079e 7b06          	ld	a,(OFST-1,sp)
3012  07a0 6b02          	ld	(OFST-5,sp),a
3016  07a2 1007          	sub	a,(OFST+0,sp)
3019  07a4 2016          	jp	LC005
3020  07a6               L3101:
3021                     ; 505 	  case 0: red=MAX_BRIGHTNESS; green=residual; break;
3023  07a6 7b06          	ld	a,(OFST-1,sp)
3024  07a8 6b02          	ld	(OFST-5,sp),a
3028  07aa 7b07          	ld	a,(OFST+0,sp)
3031  07ac 2018          	jp	LC006
3032  07ae               L5101:
3033                     ; 506 		case 1: green=MAX_BRIGHTNESS; red=MAX_BRIGHTNESS-residual; break;
3035  07ae 7b06          	ld	a,(OFST-1,sp)
3036  07b0 6b03          	ld	(OFST-4,sp),a
3040  07b2 1007          	sub	a,(OFST+0,sp)
3043  07b4 201a          	jp	LC004
3044  07b6               L7101:
3045                     ; 507 		case 2: green=MAX_BRIGHTNESS; blue=residual; break;
3047  07b6 7b06          	ld	a,(OFST-1,sp)
3048  07b8 6b03          	ld	(OFST-4,sp),a
3052  07ba 7b07          	ld	a,(OFST+0,sp)
3053  07bc               LC005:
3054  07bc 6b04          	ld	(OFST-3,sp),a
3058  07be 2012          	jra	L1011
3059  07c0               L1201:
3060                     ; 508 		case 3: blue=MAX_BRIGHTNESS; green=MAX_BRIGHTNESS-residual; break;
3062  07c0 7b06          	ld	a,(OFST-1,sp)
3063  07c2 6b04          	ld	(OFST-3,sp),a
3067  07c4 1007          	sub	a,(OFST+0,sp)
3068  07c6               LC006:
3069  07c6 6b03          	ld	(OFST-4,sp),a
3073  07c8 2008          	jra	L1011
3074  07ca               L3201:
3075                     ; 509 		case 4: blue=MAX_BRIGHTNESS; red=residual; break;
3077  07ca 7b06          	ld	a,(OFST-1,sp)
3078  07cc 6b04          	ld	(OFST-3,sp),a
3082  07ce 7b07          	ld	a,(OFST+0,sp)
3083  07d0               LC004:
3084  07d0 6b02          	ld	(OFST-5,sp),a
3088  07d2               L1011:
3089                     ; 512 	set_rgb(index,0,red);
3091  07d2 7b02          	ld	a,(OFST-5,sp)
3092  07d4 88            	push	a
3093  07d5 7b09          	ld	a,(OFST+2,sp)
3094  07d7 5f            	clrw	x
3095  07d8 95            	ld	xh,a
3096  07d9 ad1b          	call	_set_rgb
3098  07db 84            	pop	a
3099                     ; 513 	set_rgb(index,1,green);
3101  07dc 7b03          	ld	a,(OFST-4,sp)
3102  07de 88            	push	a
3103  07df 7b09          	ld	a,(OFST+2,sp)
3104  07e1 ae0001        	ldw	x,#1
3105  07e4 95            	ld	xh,a
3106  07e5 ad0f          	call	_set_rgb
3108  07e7 84            	pop	a
3109                     ; 514 	set_rgb(index,2,blue);
3111  07e8 7b04          	ld	a,(OFST-3,sp)
3112  07ea 88            	push	a
3113  07eb 7b09          	ld	a,(OFST+2,sp)
3114  07ed ae0002        	ldw	x,#2
3115  07f0 95            	ld	xh,a
3116  07f1 ad03          	call	_set_rgb
3118  07f3 5b09          	addw	sp,#9
3119                     ; 515 }
3122  07f5 81            	ret	
3169                     ; 519 void set_rgb(u8 index,u8 color,u8 brightness)
3169                     ; 520 { pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness; }//smaller SRAM size with multiply operation than with 2-case if statement add
3170                     	switch	.text
3171  07f6               _set_rgb:
3173  07f6 89            	pushw	x
3174       00000000      OFST:	set	0
3179  07f7 a606          	ld	a,#6
3180  07f9 42            	mul	x,a
3181  07fa 01            	rrwa	x,a
3182  07fb 1b01          	add	a,(OFST+1,sp)
3183  07fd 2401          	jrnc	L463
3184  07ff 5c            	incw	x
3185  0800               L463:
3186  0800 02            	rlwa	x,a
3187  0801 7b05          	ld	a,(OFST+5,sp)
3188  0803 d70011        	ld	(_pwm_brightness_buffer,x),a
3192  0806 85            	popw	x
3193  0807 81            	ret	
3233                     ; 521 void set_white(u8 index,u8 brightness)
3233                     ; 522 { pwm_brightness_buffer[DEBUG_LED_INDEX+1+index]=brightness; }
3234                     	switch	.text
3235  0808               _set_white:
3237  0808 89            	pushw	x
3238       00000000      OFST:	set	0
3243  0809 9e            	ld	a,xh
3244  080a 5f            	clrw	x
3245  080b 97            	ld	xl,a
3246  080c 7b02          	ld	a,(OFST+2,sp)
3247  080e d70024        	ld	(_pwm_brightness_buffer+19,x),a
3251  0811 85            	popw	x
3252  0812 81            	ret	
3285                     ; 523 void set_debug(u8 brightness)
3285                     ; 524 { pwm_brightness_buffer[DEBUG_LED_INDEX]=brightness; }
3286                     	switch	.text
3287  0813               _set_debug:
3293  0813 c70023        	ld	_pwm_brightness_buffer+18,a
3297  0816 81            	ret	
3489                     	xdef	f_I2C_EventHandler
3490                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3491                     	xdef	_i2c_transaction_byte_count
3492                     	xdef	_developer_flag
3493                     	xdef	_is_developer_debug
3494                     	switch	.bss
3495  0003               _this_addr:
3496  0003 00            	ds.b	1
3497                     	xdef	_this_addr
3498  0004               _MessageBegin:
3499  0004 00            	ds.b	1
3500                     	xdef	_MessageBegin
3501  0005               _u8_MyBuffp:
3502  0005 0000          	ds.b	2
3503                     	xdef	_u8_MyBuffp
3504  0007               _u8_My_Buffer:
3505  0007 000000000000  	ds.b	6
3506                     	xdef	_u8_My_Buffer
3507  000d               _button_pressed_event:
3508  000d 00000000      	ds.b	4
3509                     	xdef	_button_pressed_event
3510                     	xdef	_is_right_button_down
3511                     	xdef	_button_start_ms
3512                     	xdef	_is_valid_i2c_received
3513                     	xdef	_pwm_state
3514                     	xdef	_pwm_visible_index
3515                     	xdef	_pwm_led_count
3516                     	xdef	_pwm_sleep
3517  0011               _pwm_brightness_buffer:
3518  0011 000000000000  	ds.b	31
3519                     	xdef	_pwm_brightness_buffer
3520  0030               _pwm_brightness_index:
3521  0030 000000000000  	ds.b	62
3522                     	xdef	_pwm_brightness_index
3523                     	xdef	_pwm_brightness
3524                     	xdef	_atomic_counter
3525                     	xref	_GPIO_ReadInputPin
3526                     	xref	_GPIO_Init
3527                     	xref	_I2C_ITConfig
3528                     	xref	_I2C_Cmd
3529                     	xref	_I2C_Init
3530                     	xref	_I2C_DeInit
3531                     	xdef	_set_developer_flag
3532                     	xdef	_get_developer_flag
3533                     	xdef	_is_application
3534                     	xdef	_I2C_byte_write
3535                     	xdef	_I2C_byte_received
3536                     	xdef	_I2C_transaction_end
3537                     	xdef	_I2C_transaction_begin
3538                     	xdef	_set_led_on
3539                     	xdef	_set_mat
3540                     	xdef	_get_random
3541                     	xdef	_is_button_down
3542                     	xdef	_get_button_event
3543                     	xdef	_update_buttons
3544                     	xdef	_set_hue_max
3545                     	xdef	_flush_leds
3546                     	xdef	_set_debug
3547                     	xdef	_set_white
3548                     	xdef	_set_rgb
3549                     	xdef	_millis
3550                     	xdef	_setup_main
3551                     	xdef	_hello_world
3552                     	xref.b	c_lreg
3553                     	xref.b	c_x
3554                     	xref.b	c_y
3574                     	xref	c_xymov
3575                     	xref	c_lgadd
3576                     	xref	c_uitolx
3577                     	xref	c_lcmp
3578                     	xref	c_rtol
3579                     	xref	c_lsub
3580                     	xref	c_lzmp
3581                     	xref	c_lursh
3582                     	xref	c_ltor
3583                     	xref	c_imul
3584                     	end
