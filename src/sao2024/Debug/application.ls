   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 5 void setup_application()
  44                     ; 6 {
  46                     	switch	.text
  47  0000               _setup_application:
  51                     ; 7 	setup_serial(0,0);
  53  0000 5f            	clrw	x
  54  0001 cd0000        	call	_setup_serial
  56                     ; 8 	clear_button_events();
  58  0004 cd0000        	call	_clear_button_events
  60                     ; 9 }
  63  0007 81            	ret
 103                     ; 11 void run_application()
 103                     ; 12 {
 104                     	switch	.text
 105  0008               _run_application:
 107  0008 5205          	subw	sp,#5
 108       00000005      OFST:	set	5
 111                     ; 15 	u32 show_top_menu_since_ms=0;
 113                     ; 16 	setup_application();
 115  000a adf4          	call	_setup_application
 118  000c 200e          	jra	L14
 119  000e               L73:
 120                     ; 21 		flush_leds(set_sparkles(1)+set_frame_rainbow()-1);
 122  000e ad15          	call	_set_frame_rainbow
 124  0010 6b01          	ld	(OFST-4,sp),a
 126  0012 a601          	ld	a,#1
 127  0014 ad3e          	call	_set_sparkles
 129  0016 1b01          	add	a,(OFST-4,sp)
 130  0018 4a            	dec	a
 131  0019 cd0000        	call	_flush_leds
 133  001c               L14:
 134                     ; 17 	while(is_application_valid())
 136  001c cd0000        	call	_is_application_valid
 138  001f 4d            	tnz	a
 139  0020 26ec          	jrne	L73
 140                     ; 24 }
 143  0022 5b05          	addw	sp,#5
 144  0024 81            	ret
 189                     ; 26 u8 set_frame_rainbow()
 189                     ; 27 {
 190                     	switch	.text
 191  0025               _set_frame_rainbow:
 193  0025 5203          	subw	sp,#3
 194       00000003      OFST:	set	3
 197                     ; 29 	u16 offset=0;
 199  0027 5f            	clrw	x
 200  0028 1f01          	ldw	(OFST-2,sp),x
 202                     ; 30 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 204  002a 0f03          	clr	(OFST+0,sp)
 206  002c               L76:
 207                     ; 32 		set_hue_max(iter,(u16)(millis()<<5)+offset);
 209  002c cd0000        	call	_millis
 211  002f a605          	ld	a,#5
 212  0031 cd0000        	call	c_llsh
 214  0034 be02          	ldw	x,c_lreg+2
 215  0036 72fb01        	addw	x,(OFST-2,sp)
 216  0039 89            	pushw	x
 217  003a 7b05          	ld	a,(OFST+2,sp)
 218  003c cd0000        	call	_set_hue_max
 220  003f 85            	popw	x
 221                     ; 33 		offset+=0x2AAB;
 223  0040 1e01          	ldw	x,(OFST-2,sp)
 224  0042 1c2aab        	addw	x,#10923
 225  0045 1f01          	ldw	(OFST-2,sp),x
 227                     ; 30 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 229  0047 0c03          	inc	(OFST+0,sp)
 233  0049 7b03          	ld	a,(OFST+0,sp)
 234  004b a106          	cp	a,#6
 235  004d 25dd          	jrult	L76
 236                     ; 35 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
 238  004f a606          	ld	a,#6
 241  0051 5b03          	addw	sp,#3
 242  0053 81            	ret
 317                     ; 38 u8 set_sparkles(bool is_fireworks)
 317                     ; 39 {
 318                     	switch	.text
 319  0054               _set_sparkles:
 321  0054 88            	push	a
 322  0055 5207          	subw	sp,#7
 323       00000007      OFST:	set	7
 326                     ; 42 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
 328  0057 0f05          	clr	(OFST-2,sp)
 330  0059               L331:
 331                     ; 45 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
 333  0059 cd0000        	call	_millis
 335  005c 96            	ldw	x,sp
 336  005d 1c0001        	addw	x,#OFST-6
 337  0060 cd0000        	call	c_rtol
 340  0063 7b05          	ld	a,(OFST-2,sp)
 341  0065 5f            	clrw	x
 342  0066 97            	ld	xl,a
 343  0067 4f            	clr	a
 344  0068 02            	rlwa	x,a
 345  0069 58            	sllw	x
 346  006a cd0000        	call	c_itolx
 348  006d 96            	ldw	x,sp
 349  006e 1c0001        	addw	x,#OFST-6
 350  0071 cd0000        	call	c_ladd
 352  0074 be02          	ldw	x,c_lreg+2
 353  0076 1f06          	ldw	(OFST-1,sp),x
 355                     ; 46 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
 357  0078 cd0000        	call	_millis
 359  007b 7b05          	ld	a,(OFST-2,sp)
 360  007d a403          	and	a,#3
 361  007f ab02          	add	a,#2
 362  0081 cd0000        	call	c_lursh
 364  0084 96            	ldw	x,sp
 365  0085 1c0001        	addw	x,#OFST-6
 366  0088 cd0000        	call	c_rtol
 369  008b 1e06          	ldw	x,(OFST-1,sp)
 370  008d cd0000        	call	c_uitolx
 372  0090 96            	ldw	x,sp
 373  0091 1c0001        	addw	x,#OFST-6
 374  0094 cd0000        	call	c_lsub
 376  0097 be02          	ldw	x,c_lreg+2
 377  0099 1f06          	ldw	(OFST-1,sp),x
 379                     ; 47 		state+=millis()>>(2+((iter>>2)&0x02));
 381  009b cd0000        	call	_millis
 383  009e 7b05          	ld	a,(OFST-2,sp)
 384  00a0 44            	srl	a
 385  00a1 44            	srl	a
 386  00a2 a402          	and	a,#2
 387  00a4 ab02          	add	a,#2
 388  00a6 cd0000        	call	c_lursh
 390  00a9 96            	ldw	x,sp
 391  00aa 1c0001        	addw	x,#OFST-6
 392  00ad cd0000        	call	c_rtol
 395  00b0 1e06          	ldw	x,(OFST-1,sp)
 396  00b2 cd0000        	call	c_uitolx
 398  00b5 96            	ldw	x,sp
 399  00b6 1c0001        	addw	x,#OFST-6
 400  00b9 cd0000        	call	c_ladd
 402  00bc be02          	ldw	x,c_lreg+2
 403  00be 1f06          	ldw	(OFST-1,sp),x
 405                     ; 48 		if(!((state>>11)&(is_fireworks?0x01:0x03)))//only ON 25% of the time
 407  00c0 0d08          	tnz	(OFST+1,sp)
 408  00c2 2705          	jreq	L41
 409  00c4 ae0001        	ldw	x,#1
 410  00c7 2003          	jra	L61
 411  00c9               L41:
 412  00c9 ae0003        	ldw	x,#3
 413  00cc               L61:
 414  00cc 1f03          	ldw	(OFST-4,sp),x
 416  00ce 1e06          	ldw	x,(OFST-1,sp)
 417  00d0 4f            	clr	a
 418  00d1 01            	rrwa	x,a
 419  00d2 54            	srlw	x
 420  00d3 54            	srlw	x
 421  00d4 54            	srlw	x
 422  00d5 01            	rrwa	x,a
 423  00d6 1404          	and	a,(OFST-3,sp)
 424  00d8 01            	rrwa	x,a
 425  00d9 1403          	and	a,(OFST-4,sp)
 426  00db 01            	rrwa	x,a
 427  00dc a30000        	cpw	x,#0
 428  00df 2672          	jrne	L141
 429                     ; 51 			if(is_fireworks)
 431  00e1 0d08          	tnz	(OFST+1,sp)
 432  00e3 2741          	jreq	L341
 433                     ; 52 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
 435  00e5 1e06          	ldw	x,(OFST-1,sp)
 436  00e7 4f            	clr	a
 437  00e8 01            	rrwa	x,a
 438  00e9 54            	srlw	x
 439  00ea 54            	srlw	x
 440  00eb 01            	rrwa	x,a
 441  00ec a501          	bcp	a,#1
 442  00ee 270d          	jreq	L02
 443  00f0 1e06          	ldw	x,(OFST-1,sp)
 444  00f2 54            	srlw	x
 445  00f3 54            	srlw	x
 446  00f4 54            	srlw	x
 447  00f5 53            	cplw	x
 448  00f6 01            	rrwa	x,a
 449  00f7 a47f          	and	a,#127
 450  00f9 5f            	clrw	x
 451  00fa 02            	rlwa	x,a
 452  00fb 201f          	jra	L22
 453  00fd               L02:
 454  00fd 1e06          	ldw	x,(OFST-1,sp)
 455  00ff a606          	ld	a,#6
 456  0101               L62:
 457  0101 54            	srlw	x
 458  0102 4a            	dec	a
 459  0103 26fc          	jrne	L62
 460  0105 01            	rrwa	x,a
 461  0106 a40f          	and	a,#15
 462  0108 5f            	clrw	x
 463  0109 02            	rlwa	x,a
 464  010a a3000f        	cpw	x,#15
 465  010d 2604          	jrne	L42
 466  010f a6ff          	ld	a,#255
 467  0111 2001          	jra	L03
 468  0113               L42:
 469  0113 4f            	clr	a
 470  0114               L03:
 471  0114 97            	ld	xl,a
 472  0115 9f            	ld	a,xl
 473  0116 5f            	clrw	x
 474  0117 4d            	tnz	a
 475  0118 2a01          	jrpl	L23
 476  011a 53            	cplw	x
 477  011b               L23:
 478  011b 97            	ld	xl,a
 479  011c               L22:
 480  011c 9f            	ld	a,xl
 481  011d 97            	ld	xl,a
 482  011e 7b05          	ld	a,(OFST-2,sp)
 483  0120 95            	ld	xh,a
 484  0121 cd0000        	call	_set_white
 487  0124 202d          	jra	L141
 488  0126               L341:
 489                     ; 54 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
 491  0126 1e06          	ldw	x,(OFST-1,sp)
 492  0128 4f            	clr	a
 493  0129 01            	rrwa	x,a
 494  012a 54            	srlw	x
 495  012b 54            	srlw	x
 496  012c 01            	rrwa	x,a
 497  012d a501          	bcp	a,#1
 498  012f 2707          	jreq	L43
 499  0131 1e06          	ldw	x,(OFST-1,sp)
 500  0133 54            	srlw	x
 501  0134 54            	srlw	x
 502  0135 53            	cplw	x
 503  0136 2013          	jra	L63
 504  0138               L43:
 505  0138 1e06          	ldw	x,(OFST-1,sp)
 506  013a 4f            	clr	a
 507  013b 01            	rrwa	x,a
 508  013c 01            	rrwa	x,a
 509  013d a503          	bcp	a,#3
 510  013f 2704          	jreq	L04
 511  0141 a6ff          	ld	a,#255
 512  0143 2002          	jra	L24
 513  0145               L04:
 514  0145 7b07          	ld	a,(OFST+0,sp)
 515  0147               L24:
 516  0147 97            	ld	xl,a
 517  0148 9f            	ld	a,xl
 518  0149 5f            	clrw	x
 519  014a 97            	ld	xl,a
 520  014b               L63:
 521  014b 9f            	ld	a,xl
 522  014c 97            	ld	xl,a
 523  014d 7b05          	ld	a,(OFST-2,sp)
 524  014f 95            	ld	xh,a
 525  0150 cd0000        	call	_set_white
 527  0153               L141:
 528                     ; 42 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
 530  0153 0c05          	inc	(OFST-2,sp)
 534  0155 7b05          	ld	a,(OFST-2,sp)
 535  0157 a10c          	cp	a,#12
 536  0159 2403          	jruge	L44
 537  015b cc0059        	jp	L331
 538  015e               L44:
 539                     ; 57 	return WHITE_LED_COUNT/4;
 541  015e a603          	ld	a,#3
 544  0160 5b08          	addw	sp,#8
 545  0162 81            	ret
 570                     .const:	section	.text
 571  0000               L05:
 572  0000 0000000c      	dc.l	12
 573                     ; 60 u8 set_white_test()
 573                     ; 61 {
 574                     	switch	.text
 575  0163               _set_white_test:
 579                     ; 62 	set_white((millis()>>6)%WHITE_LED_COUNT,0xFF);
 581  0163 cd0000        	call	_millis
 583  0166 a606          	ld	a,#6
 584  0168 cd0000        	call	c_lursh
 586  016b ae0000        	ldw	x,#L05
 587  016e cd0000        	call	c_lumd
 589  0171 b603          	ld	a,c_lreg+3
 590  0173 ae00ff        	ldw	x,#255
 591  0176 95            	ld	xh,a
 592  0177 cd0000        	call	_set_white
 594                     ; 63 	return 1;
 596  017a a601          	ld	a,#1
 599  017c 81            	ret
 612                     	xdef	_set_white_test
 613                     	xdef	_set_sparkles
 614                     	xdef	_set_frame_rainbow
 615                     	xdef	_run_application
 616                     	xdef	_setup_application
 617                     	xref	_clear_button_events
 618                     	xref	_set_hue_max
 619                     	xref	_flush_leds
 620                     	xref	_set_white
 621                     	xref	_millis
 622                     	xref	_is_application_valid
 623                     	xref	_setup_serial
 624                     	xref.b	c_lreg
 625                     	xref.b	c_x
 644                     	xref	c_lumd
 645                     	xref	c_lsub
 646                     	xref	c_lursh
 647                     	xref	c_uitolx
 648                     	xref	c_ladd
 649                     	xref	c_rtol
 650                     	xref	c_itolx
 651                     	xref	c_llsh
 652                     	end
