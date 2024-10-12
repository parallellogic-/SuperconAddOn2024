   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 7 void setup_application()
  44                     ; 8 {
  46                     	switch	.text
  47  0000               _setup_application:
  51                     ; 9 	setup_serial(0,0);
  53  0000 5f            	clrw	x
  54  0001 cd0000        	call	_setup_serial
  56                     ; 10 	clear_button_events();
  58  0004 cd0000        	call	_clear_button_events
  60                     ; 11 }
  63  0007 81            	ret
 116                     ; 13 void run_application()
 116                     ; 14 {
 117                     	switch	.text
 118  0008               _run_application:
 120  0008 89            	pushw	x
 121       00000002      OFST:	set	2
 124                     ; 15 	u8 game_state=2;
 126  0009 a602          	ld	a,#2
 127  000b 6b01          	ld	(OFST-1,sp),a
 129                     ; 16 	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
 131  000d a601          	ld	a,#1
 132  000f 6b02          	ld	(OFST+0,sp),a
 134                     ; 17 	setup_application();
 136  0011 aded          	call	_setup_application
 139  0013 acf100f1      	jpf	L75
 140  0017               L55:
 141                     ; 24 		switch(game_state)
 143  0017 7b01          	ld	a,(OFST-1,sp)
 145                     ; 50 			}break;
 146  0019 4d            	tnz	a
 147  001a 2716          	jreq	L12
 148  001c 4a            	dec	a
 149  001d 272a          	jreq	L32
 150  001f 4a            	dec	a
 151  0020 273b          	jreq	L52
 152  0022 4a            	dec	a
 153  0023 2603          	jrne	L44
 154  0025 cc00ec        	jp	L56
 155  0028               L44:
 156  0028 4a            	dec	a
 157  0029 2603          	jrne	L64
 158  002b cc00ec        	jp	L56
 159  002e               L64:
 160  002e acec00ec      	jpf	L56
 161  0032               L12:
 162                     ; 27 				effective_led_count=set_sparkles(0);
 164  0032 4f            	clr	a
 165  0033 cd0166        	call	_set_sparkles
 167  0036 6b02          	ld	(OFST+0,sp),a
 169                     ; 28 				if(clear_button_events()) game_state=1;
 171  0038 cd0000        	call	_clear_button_events
 173  003b 4d            	tnz	a
 174  003c 2603          	jrne	L05
 175  003e cc00ec        	jp	L56
 176  0041               L05:
 179  0041 a601          	ld	a,#1
 180  0043 6b01          	ld	(OFST-1,sp),a
 182  0045 acec00ec      	jpf	L56
 183  0049               L32:
 184                     ; 31 				effective_led_count=set_frame_rainbow();
 186  0049 cd0137        	call	_set_frame_rainbow
 188  004c 6b02          	ld	(OFST+0,sp),a
 190                     ; 32 				if(clear_button_events()) game_state=0;
 192  004e cd0000        	call	_clear_button_events
 194  0051 4d            	tnz	a
 195  0052 2603          	jrne	L25
 196  0054 cc00ec        	jp	L56
 197  0057               L25:
 200  0057 0f01          	clr	(OFST-1,sp)
 202  0059 acec00ec      	jpf	L56
 203  005d               L52:
 204                     ; 35 				set_white(0,is_button_down(0)?0xFF:0);
 206  005d 4f            	clr	a
 207  005e cd0000        	call	_is_button_down
 209  0061 4d            	tnz	a
 210  0062 2704          	jreq	L01
 211  0064 a6ff          	ld	a,#255
 212  0066 2001          	jra	L21
 213  0068               L01:
 214  0068 4f            	clr	a
 215  0069               L21:
 216  0069 5f            	clrw	x
 217  006a 97            	ld	xl,a
 218  006b cd0000        	call	_set_white
 220                     ; 36 				set_white(1,is_button_down(1)?0xFF:0);
 222  006e a601          	ld	a,#1
 223  0070 cd0000        	call	_is_button_down
 225  0073 4d            	tnz	a
 226  0074 2704          	jreq	L41
 227  0076 a6ff          	ld	a,#255
 228  0078 2001          	jra	L61
 229  007a               L41:
 230  007a 4f            	clr	a
 231  007b               L61:
 232  007b ae0100        	ldw	x,#256
 233  007e 97            	ld	xl,a
 234  007f cd0000        	call	_set_white
 236                     ; 37 				set_white(2,is_button_down(2)?0xFF:0);
 238  0082 a602          	ld	a,#2
 239  0084 cd0000        	call	_is_button_down
 241  0087 4d            	tnz	a
 242  0088 2704          	jreq	L02
 243  008a a6ff          	ld	a,#255
 244  008c 2001          	jra	L22
 245  008e               L02:
 246  008e 4f            	clr	a
 247  008f               L22:
 248  008f ae0200        	ldw	x,#512
 249  0092 97            	ld	xl,a
 250  0093 cd0000        	call	_set_white
 252                     ; 39 				set_white(3,get_button_event(0,0)?0xFF:0);
 254  0096 5f            	clrw	x
 255  0097 cd0000        	call	_get_button_event
 257  009a 4d            	tnz	a
 258  009b 2704          	jreq	L42
 259  009d a6ff          	ld	a,#255
 260  009f 2001          	jra	L62
 261  00a1               L42:
 262  00a1 4f            	clr	a
 263  00a2               L62:
 264  00a2 ae0300        	ldw	x,#768
 265  00a5 97            	ld	xl,a
 266  00a6 cd0000        	call	_set_white
 268                     ; 40 				set_white(4,get_button_event(0,1)?0xFF:0);
 270  00a9 ae0001        	ldw	x,#1
 271  00ac cd0000        	call	_get_button_event
 273  00af 4d            	tnz	a
 274  00b0 2704          	jreq	L03
 275  00b2 a6ff          	ld	a,#255
 276  00b4 2001          	jra	L23
 277  00b6               L03:
 278  00b6 4f            	clr	a
 279  00b7               L23:
 280  00b7 ae0400        	ldw	x,#1024
 281  00ba 97            	ld	xl,a
 282  00bb cd0000        	call	_set_white
 284                     ; 41 				set_white(5,get_button_event(1,0)?0xFF:0);
 286  00be ae0100        	ldw	x,#256
 287  00c1 cd0000        	call	_get_button_event
 289  00c4 4d            	tnz	a
 290  00c5 2704          	jreq	L43
 291  00c7 a6ff          	ld	a,#255
 292  00c9 2001          	jra	L63
 293  00cb               L43:
 294  00cb 4f            	clr	a
 295  00cc               L63:
 296  00cc ae0500        	ldw	x,#1280
 297  00cf 97            	ld	xl,a
 298  00d0 cd0000        	call	_set_white
 300                     ; 42 				set_white(6,get_button_event(1,1)?0xFF:0);
 302  00d3 ae0101        	ldw	x,#257
 303  00d6 cd0000        	call	_get_button_event
 305  00d9 4d            	tnz	a
 306  00da 2704          	jreq	L04
 307  00dc a6ff          	ld	a,#255
 308  00de 2001          	jra	L24
 309  00e0               L04:
 310  00e0 4f            	clr	a
 311  00e1               L24:
 312  00e1 ae0600        	ldw	x,#1536
 313  00e4 97            	ld	xl,a
 314  00e5 cd0000        	call	_set_white
 316                     ; 43 				effective_led_count=7;
 318  00e8 a607          	ld	a,#7
 319  00ea 6b02          	ld	(OFST+0,sp),a
 321                     ; 44 			}break;
 323  00ec               L56:
 324                     ; 52 		flush_leds(effective_led_count);
 326  00ec 7b02          	ld	a,(OFST+0,sp)
 327  00ee cd0000        	call	_flush_leds
 329  00f1               L75:
 330                     ; 18 	while(is_application_valid())
 332  00f1 cd0000        	call	_is_application_valid
 334  00f4 4d            	tnz	a
 335  00f5 2703          	jreq	L45
 336  00f7 cc0017        	jp	L55
 337  00fa               L45:
 338                     ; 54 }
 341  00fa 85            	popw	x
 342  00fb 81            	ret
 378                     ; 56 u8 show_screensaver(u8 screensaver_index)
 378                     ; 57 {
 379                     	switch	.text
 380  00fc               _show_screensaver:
 382  00fc 88            	push	a
 383       00000001      OFST:	set	1
 386                     ; 58 	switch(screensaver_index%SCREENSAVER_COUNT)
 388  00fd a403          	and	a,#3
 390                     ; 63 		case 3: return set_sparkles(1);
 391  00ff 4d            	tnz	a
 392  0100 270b          	jreq	L37
 393  0102 4a            	dec	a
 394  0103 270d          	jreq	L57
 395  0105 4a            	dec	a
 396  0106 2716          	jreq	L77
 397  0108 4a            	dec	a
 398  0109 2720          	jreq	L101
 399  010b 2025          	jra	L321
 400  010d               L37:
 401                     ; 60 		case 0: return set_frame_rainbow();
 403  010d ad28          	call	_set_frame_rainbow
 407  010f 5b01          	addw	sp,#1
 408  0111 81            	ret
 409  0112               L57:
 410                     ; 61 		case 1: return set_frame_rainbow()+set_sparkles(0);
 412  0112 4f            	clr	a
 413  0113 ad51          	call	_set_sparkles
 415  0115 6b01          	ld	(OFST+0,sp),a
 417  0117 ad1e          	call	_set_frame_rainbow
 419  0119 1b01          	add	a,(OFST+0,sp)
 422  011b 5b01          	addw	sp,#1
 423  011d 81            	ret
 424  011e               L77:
 425                     ; 62 		case 2: return set_frame_rainbow()+set_sparkles(1);
 427  011e a601          	ld	a,#1
 428  0120 ad44          	call	_set_sparkles
 430  0122 6b01          	ld	(OFST+0,sp),a
 432  0124 ad11          	call	_set_frame_rainbow
 434  0126 1b01          	add	a,(OFST+0,sp)
 437  0128 5b01          	addw	sp,#1
 438  012a 81            	ret
 439  012b               L101:
 440                     ; 63 		case 3: return set_sparkles(1);
 442  012b a601          	ld	a,#1
 443  012d ad37          	call	_set_sparkles
 447  012f 5b01          	addw	sp,#1
 448  0131 81            	ret
 449  0132               L321:
 450                     ; 65 	return 1;
 452  0132 a601          	ld	a,#1
 455  0134 5b01          	addw	sp,#1
 456  0136 81            	ret
 501                     ; 68 u8 set_frame_rainbow()
 501                     ; 69 {
 502                     	switch	.text
 503  0137               _set_frame_rainbow:
 505  0137 5203          	subw	sp,#3
 506       00000003      OFST:	set	3
 509                     ; 71 	u16 offset=0;
 511  0139 5f            	clrw	x
 512  013a 1f01          	ldw	(OFST-2,sp),x
 514                     ; 72 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 516  013c 0f03          	clr	(OFST+0,sp)
 518  013e               L741:
 519                     ; 74 		set_hue_max(iter,(u16)(millis()<<5)+offset);
 521  013e cd0000        	call	_millis
 523  0141 a605          	ld	a,#5
 524  0143 cd0000        	call	c_llsh
 526  0146 be02          	ldw	x,c_lreg+2
 527  0148 72fb01        	addw	x,(OFST-2,sp)
 528  014b 89            	pushw	x
 529  014c 7b05          	ld	a,(OFST+2,sp)
 530  014e cd0000        	call	_set_hue_max
 532  0151 85            	popw	x
 533                     ; 75 		offset+=0x2AAB;
 535  0152 1e01          	ldw	x,(OFST-2,sp)
 536  0154 1c2aab        	addw	x,#10923
 537  0157 1f01          	ldw	(OFST-2,sp),x
 539                     ; 72 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 541  0159 0c03          	inc	(OFST+0,sp)
 545  015b 7b03          	ld	a,(OFST+0,sp)
 546  015d a106          	cp	a,#6
 547  015f 25dd          	jrult	L741
 548                     ; 77 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
 550  0161 a606          	ld	a,#6
 553  0163 5b03          	addw	sp,#3
 554  0165 81            	ret
 629                     ; 80 u8 set_sparkles(bool is_fireworks)
 629                     ; 81 {
 630                     	switch	.text
 631  0166               _set_sparkles:
 633  0166 88            	push	a
 634  0167 5207          	subw	sp,#7
 635       00000007      OFST:	set	7
 638                     ; 84 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
 640  0169 0f05          	clr	(OFST-2,sp)
 642  016b               L312:
 643                     ; 87 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
 645  016b cd0000        	call	_millis
 647  016e 96            	ldw	x,sp
 648  016f 1c0001        	addw	x,#OFST-6
 649  0172 cd0000        	call	c_rtol
 652  0175 7b05          	ld	a,(OFST-2,sp)
 653  0177 5f            	clrw	x
 654  0178 97            	ld	xl,a
 655  0179 4f            	clr	a
 656  017a 02            	rlwa	x,a
 657  017b 58            	sllw	x
 658  017c cd0000        	call	c_itolx
 660  017f 96            	ldw	x,sp
 661  0180 1c0001        	addw	x,#OFST-6
 662  0183 cd0000        	call	c_ladd
 664  0186 be02          	ldw	x,c_lreg+2
 665  0188 1f06          	ldw	(OFST-1,sp),x
 667                     ; 88 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
 669  018a cd0000        	call	_millis
 671  018d 7b05          	ld	a,(OFST-2,sp)
 672  018f a403          	and	a,#3
 673  0191 ab02          	add	a,#2
 674  0193 cd0000        	call	c_lursh
 676  0196 96            	ldw	x,sp
 677  0197 1c0001        	addw	x,#OFST-6
 678  019a cd0000        	call	c_rtol
 681  019d 1e06          	ldw	x,(OFST-1,sp)
 682  019f cd0000        	call	c_uitolx
 684  01a2 96            	ldw	x,sp
 685  01a3 1c0001        	addw	x,#OFST-6
 686  01a6 cd0000        	call	c_lsub
 688  01a9 be02          	ldw	x,c_lreg+2
 689  01ab 1f06          	ldw	(OFST-1,sp),x
 691                     ; 89 		state+=millis()>>(2+((iter>>2)&0x02));
 693  01ad cd0000        	call	_millis
 695  01b0 7b05          	ld	a,(OFST-2,sp)
 696  01b2 44            	srl	a
 697  01b3 44            	srl	a
 698  01b4 a402          	and	a,#2
 699  01b6 ab02          	add	a,#2
 700  01b8 cd0000        	call	c_lursh
 702  01bb 96            	ldw	x,sp
 703  01bc 1c0001        	addw	x,#OFST-6
 704  01bf cd0000        	call	c_rtol
 707  01c2 1e06          	ldw	x,(OFST-1,sp)
 708  01c4 cd0000        	call	c_uitolx
 710  01c7 96            	ldw	x,sp
 711  01c8 1c0001        	addw	x,#OFST-6
 712  01cb cd0000        	call	c_ladd
 714  01ce be02          	ldw	x,c_lreg+2
 715  01d0 1f06          	ldw	(OFST-1,sp),x
 717                     ; 90 		if(!((state>>11)&(is_fireworks?0x01:0x03)))//only ON 25% of the time
 719  01d2 0d08          	tnz	(OFST+1,sp)
 720  01d4 2705          	jreq	L46
 721  01d6 ae0001        	ldw	x,#1
 722  01d9 2003          	jra	L66
 723  01db               L46:
 724  01db ae0003        	ldw	x,#3
 725  01de               L66:
 726  01de 1f03          	ldw	(OFST-4,sp),x
 728  01e0 1e06          	ldw	x,(OFST-1,sp)
 729  01e2 4f            	clr	a
 730  01e3 01            	rrwa	x,a
 731  01e4 54            	srlw	x
 732  01e5 54            	srlw	x
 733  01e6 54            	srlw	x
 734  01e7 01            	rrwa	x,a
 735  01e8 1404          	and	a,(OFST-3,sp)
 736  01ea 01            	rrwa	x,a
 737  01eb 1403          	and	a,(OFST-4,sp)
 738  01ed 01            	rrwa	x,a
 739  01ee a30000        	cpw	x,#0
 740  01f1 2672          	jrne	L122
 741                     ; 93 			if(is_fireworks)
 743  01f3 0d08          	tnz	(OFST+1,sp)
 744  01f5 2741          	jreq	L322
 745                     ; 94 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
 747  01f7 1e06          	ldw	x,(OFST-1,sp)
 748  01f9 4f            	clr	a
 749  01fa 01            	rrwa	x,a
 750  01fb 54            	srlw	x
 751  01fc 54            	srlw	x
 752  01fd 01            	rrwa	x,a
 753  01fe a501          	bcp	a,#1
 754  0200 270d          	jreq	L07
 755  0202 1e06          	ldw	x,(OFST-1,sp)
 756  0204 54            	srlw	x
 757  0205 54            	srlw	x
 758  0206 54            	srlw	x
 759  0207 53            	cplw	x
 760  0208 01            	rrwa	x,a
 761  0209 a47f          	and	a,#127
 762  020b 5f            	clrw	x
 763  020c 02            	rlwa	x,a
 764  020d 201f          	jra	L27
 765  020f               L07:
 766  020f 1e06          	ldw	x,(OFST-1,sp)
 767  0211 a606          	ld	a,#6
 768  0213               L67:
 769  0213 54            	srlw	x
 770  0214 4a            	dec	a
 771  0215 26fc          	jrne	L67
 772  0217 01            	rrwa	x,a
 773  0218 a40f          	and	a,#15
 774  021a 5f            	clrw	x
 775  021b 02            	rlwa	x,a
 776  021c a3000f        	cpw	x,#15
 777  021f 2604          	jrne	L47
 778  0221 a6ff          	ld	a,#255
 779  0223 2001          	jra	L001
 780  0225               L47:
 781  0225 4f            	clr	a
 782  0226               L001:
 783  0226 97            	ld	xl,a
 784  0227 9f            	ld	a,xl
 785  0228 5f            	clrw	x
 786  0229 4d            	tnz	a
 787  022a 2a01          	jrpl	L201
 788  022c 53            	cplw	x
 789  022d               L201:
 790  022d 97            	ld	xl,a
 791  022e               L27:
 792  022e 9f            	ld	a,xl
 793  022f 97            	ld	xl,a
 794  0230 7b05          	ld	a,(OFST-2,sp)
 795  0232 95            	ld	xh,a
 796  0233 cd0000        	call	_set_white
 799  0236 202d          	jra	L122
 800  0238               L322:
 801                     ; 96 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
 803  0238 1e06          	ldw	x,(OFST-1,sp)
 804  023a 4f            	clr	a
 805  023b 01            	rrwa	x,a
 806  023c 54            	srlw	x
 807  023d 54            	srlw	x
 808  023e 01            	rrwa	x,a
 809  023f a501          	bcp	a,#1
 810  0241 2707          	jreq	L401
 811  0243 1e06          	ldw	x,(OFST-1,sp)
 812  0245 54            	srlw	x
 813  0246 54            	srlw	x
 814  0247 53            	cplw	x
 815  0248 2013          	jra	L601
 816  024a               L401:
 817  024a 1e06          	ldw	x,(OFST-1,sp)
 818  024c 4f            	clr	a
 819  024d 01            	rrwa	x,a
 820  024e 01            	rrwa	x,a
 821  024f a503          	bcp	a,#3
 822  0251 2704          	jreq	L011
 823  0253 a6ff          	ld	a,#255
 824  0255 2002          	jra	L211
 825  0257               L011:
 826  0257 7b07          	ld	a,(OFST+0,sp)
 827  0259               L211:
 828  0259 97            	ld	xl,a
 829  025a 9f            	ld	a,xl
 830  025b 5f            	clrw	x
 831  025c 97            	ld	xl,a
 832  025d               L601:
 833  025d 9f            	ld	a,xl
 834  025e 97            	ld	xl,a
 835  025f 7b05          	ld	a,(OFST-2,sp)
 836  0261 95            	ld	xh,a
 837  0262 cd0000        	call	_set_white
 839  0265               L122:
 840                     ; 84 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
 842  0265 0c05          	inc	(OFST-2,sp)
 846  0267 7b05          	ld	a,(OFST-2,sp)
 847  0269 a10c          	cp	a,#12
 848  026b 2403          	jruge	L411
 849  026d cc016b        	jp	L312
 850  0270               L411:
 851                     ; 99 	return WHITE_LED_COUNT/4;
 853  0270 a603          	ld	a,#3
 856  0272 5b08          	addw	sp,#8
 857  0274 81            	ret
 882                     .const:	section	.text
 883  0000               L021:
 884  0000 0000000c      	dc.l	12
 885                     ; 102 u8 set_white_test()
 885                     ; 103 {
 886                     	switch	.text
 887  0275               _set_white_test:
 891                     ; 104 	set_white((millis()>>6)%WHITE_LED_COUNT,0xFF);
 893  0275 cd0000        	call	_millis
 895  0278 a606          	ld	a,#6
 896  027a cd0000        	call	c_lursh
 898  027d ae0000        	ldw	x,#L021
 899  0280 cd0000        	call	c_lumd
 901  0283 b603          	ld	a,c_lreg+3
 902  0285 ae00ff        	ldw	x,#255
 903  0288 95            	ld	xh,a
 904  0289 cd0000        	call	_set_white
 906                     ; 105 	return 1;
 908  028c a601          	ld	a,#1
 911  028e 81            	ret
 924                     	xdef	_show_screensaver
 925                     	xdef	_set_white_test
 926                     	xdef	_set_sparkles
 927                     	xdef	_set_frame_rainbow
 928                     	xdef	_run_application
 929                     	xdef	_setup_application
 930                     	xref	_is_button_down
 931                     	xref	_clear_button_events
 932                     	xref	_get_button_event
 933                     	xref	_set_hue_max
 934                     	xref	_flush_leds
 935                     	xref	_set_white
 936                     	xref	_millis
 937                     	xref	_is_application_valid
 938                     	xref	_setup_serial
 939                     	xref.b	c_lreg
 940                     	xref.b	c_x
 959                     	xref	c_lumd
 960                     	xref	c_lsub
 961                     	xref	c_lursh
 962                     	xref	c_uitolx
 963                     	xref	c_ladd
 964                     	xref	c_rtol
 965                     	xref	c_itolx
 966                     	xref	c_llsh
 967                     	end
