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
  56                     ; 10 	get_button_event(0xFF,0xFF,1);//clear_button_events();
  58  0004 4b01          	push	#1
  59  0006 aeffff        	ldw	x,#65535
  60  0009 cd0000        	call	_get_button_event
  62  000c 84            	pop	a
  63                     ; 11 }
  66  000d 81            	ret
 246                     .const:	section	.text
 247  0000               L24:
 248  0000 00000006      	dc.l	6
 249                     ; 13 void run_application()
 249                     ; 14 {
 250                     	switch	.text
 251  000e               _run_application:
 253  000e 521f          	subw	sp,#31
 254       0000001f      OFST:	set	31
 257                     ; 15 	u8 new_game_state=0,old_game_state=255;
 259  0010 0f1e          	clr	(OFST-1,sp)
 263  0012 a6ff          	ld	a,#255
 264  0014 6b0d          	ld	(OFST-18,sp),a
 266                     ; 17 	bool is_new_state=1;
 268                     ; 20 	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
 270                     ; 27 	setup_application();
 272  0016 ade8          	call	_setup_application
 275  0018 ac6a046a      	jpf	L151
 276  001c               L741:
 277                     ; 30 		effective_led_count=1;//default empty list
 279  001c a601          	ld	a,#1
 280  001e 6b10          	ld	(OFST-15,sp),a
 282                     ; 31 		is_new_state=0;//flag to signify a new state has been entered
 284  0020 0f1f          	clr	(OFST+0,sp)
 286                     ; 32 		if(new_game_state!=old_game_state)
 288  0022 7b1e          	ld	a,(OFST-1,sp)
 289  0024 110d          	cp	a,(OFST-18,sp)
 290  0026 2712          	jreq	L551
 291                     ; 34 			is_new_state=1;
 293  0028 a601          	ld	a,#1
 294  002a 6b1f          	ld	(OFST+0,sp),a
 296                     ; 35 			game_state_start_ms=millis();
 298  002c cd0000        	call	_millis
 300  002f 96            	ldw	x,sp
 301  0030 1c0009        	addw	x,#OFST-22
 302  0033 cd0000        	call	c_rtol
 305                     ; 36 			old_game_state=new_game_state;
 307  0036 7b1e          	ld	a,(OFST-1,sp)
 308  0038 6b0d          	ld	(OFST-18,sp),a
 310  003a               L551:
 311                     ; 38 		game_state_elapsed_ms=millis()-game_state_start_ms;
 313  003a cd0000        	call	_millis
 315  003d 96            	ldw	x,sp
 316  003e 1c0009        	addw	x,#OFST-22
 317  0041 cd0000        	call	c_lsub
 319  0044 96            	ldw	x,sp
 320  0045 1c0012        	addw	x,#OFST-13
 321  0048 cd0000        	call	c_rtol
 324                     ; 43 		switch(new_game_state)
 326  004b 7b1e          	ld	a,(OFST-1,sp)
 328                     ; 170 			}break;
 329  004d 4d            	tnz	a
 330  004e 272e          	jreq	L12
 331  0050 4a            	dec	a
 332  0051 2603          	jrne	L05
 333  0053 cc012b        	jp	L32
 334  0056               L05:
 335  0056 4a            	dec	a
 336  0057 2603          	jrne	L25
 337  0059 cc01ad        	jp	L52
 338  005c               L25:
 339  005c 4a            	dec	a
 340  005d 2603          	jrne	L45
 341  005f cc027d        	jp	L72
 342  0062               L45:
 343  0062 4a            	dec	a
 344  0063 2603          	jrne	L65
 345  0065 cc02be        	jp	L13
 346  0068               L65:
 347  0068 4a            	dec	a
 348  0069 2603          	jrne	L06
 349  006b cc0303        	jp	L33
 350  006e               L06:
 351  006e 4a            	dec	a
 352  006f 2603          	jrne	L26
 353  0071 cc0335        	jp	L53
 354  0074               L26:
 355  0074 4a            	dec	a
 356  0075 2603          	jrne	L46
 357  0077 cc03e2        	jp	L73
 358  007a               L46:
 359  007a ac650465      	jpf	L161
 360  007e               L12:
 361                     ; 46 				game_level=0;//restart game
 363  007e 0f0f          	clr	(OFST-16,sp)
 365                     ; 47 				effective_led_count=set_sparkles(0);
 367  0080 4f            	clr	a
 368  0081 cd057c        	call	_set_sparkles
 370  0084 6b10          	ld	(OFST-15,sp),a
 372                     ; 48 				if(get_button_event(0xFF,0,1))
 374  0086 4b01          	push	#1
 375  0088 aeff00        	ldw	x,#65280
 376  008b cd0000        	call	_get_button_event
 378  008e 5b01          	addw	sp,#1
 379  0090 4d            	tnz	a
 380  0091 2602          	jrne	L66
 381  0093 207e          	jp	L361
 382  0095               L66:
 383                     ; 51 					new_game_state=1;
 385  0095 a601          	ld	a,#1
 386  0097 6b1e          	ld	(OFST-1,sp),a
 388  0099               L561:
 389                     ; 53 						for(iter=0;iter<RGB_LED_COUNT;iter++) target_pattern[iter]=0;//clear initial state for repeat play
 391  0099 0f1f          	clr	(OFST+0,sp)
 393  009b               L371:
 396  009b 96            	ldw	x,sp
 397  009c 1c0018        	addw	x,#OFST-7
 398  009f 9f            	ld	a,xl
 399  00a0 5e            	swapw	x
 400  00a1 1b1f          	add	a,(OFST+0,sp)
 401  00a3 2401          	jrnc	L01
 402  00a5 5c            	incw	x
 403  00a6               L01:
 404  00a6 02            	rlwa	x,a
 405  00a7 7f            	clr	(x)
 408  00a8 0c1f          	inc	(OFST+0,sp)
 412  00aa 7b1f          	ld	a,(OFST+0,sp)
 413  00ac a106          	cp	a,#6
 414  00ae 25eb          	jrult	L371
 415                     ; 54 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 417  00b0 a601          	ld	a,#1
 418  00b2 6b1f          	ld	(OFST+0,sp),a
 420  00b4               L102:
 421                     ; 56 							is_target_element_placed=0;
 423  00b4 0f11          	clr	(OFST-14,sp)
 425  00b6               L702:
 426                     ; 59 								level_fractional_progress=get_random(millis()-iter)%RGB_LED_COUNT;//using time to resolve infinite loop instability :/
 428  00b6 7b1f          	ld	a,(OFST+0,sp)
 429  00b8 b703          	ld	c_lreg+3,a
 430  00ba 3f02          	clr	c_lreg+2
 431  00bc 3f01          	clr	c_lreg+1
 432  00be 3f00          	clr	c_lreg
 433  00c0 96            	ldw	x,sp
 434  00c1 1c0005        	addw	x,#OFST-26
 435  00c4 cd0000        	call	c_rtol
 438  00c7 cd0000        	call	_millis
 440  00ca 96            	ldw	x,sp
 441  00cb 1c0005        	addw	x,#OFST-26
 442  00ce cd0000        	call	c_lsub
 444  00d1 be02          	ldw	x,c_lreg+2
 445  00d3 cd0000        	call	_get_random
 447  00d6 a606          	ld	a,#6
 448  00d8 62            	div	x,a
 449  00d9 5f            	clrw	x
 450  00da 97            	ld	xl,a
 451  00db 01            	rrwa	x,a
 452  00dc 6b17          	ld	(OFST-8,sp),a
 453  00de 02            	rlwa	x,a
 455                     ; 60 								if(target_pattern[level_fractional_progress]==0)
 457  00df 96            	ldw	x,sp
 458  00e0 1c0018        	addw	x,#OFST-7
 459  00e3 9f            	ld	a,xl
 460  00e4 5e            	swapw	x
 461  00e5 1b17          	add	a,(OFST-8,sp)
 462  00e7 2401          	jrnc	L21
 463  00e9 5c            	incw	x
 464  00ea               L21:
 465  00ea 02            	rlwa	x,a
 466  00eb 7d            	tnz	(x)
 467  00ec 2613          	jrne	L512
 468                     ; 62 									is_target_element_placed=1;
 470  00ee a601          	ld	a,#1
 471  00f0 6b11          	ld	(OFST-14,sp),a
 473                     ; 63 									target_pattern[level_fractional_progress]=iter;
 475  00f2 96            	ldw	x,sp
 476  00f3 1c0018        	addw	x,#OFST-7
 477  00f6 9f            	ld	a,xl
 478  00f7 5e            	swapw	x
 479  00f8 1b17          	add	a,(OFST-8,sp)
 480  00fa 2401          	jrnc	L41
 481  00fc 5c            	incw	x
 482  00fd               L41:
 483  00fd 02            	rlwa	x,a
 484  00fe 7b1f          	ld	a,(OFST+0,sp)
 485  0100 f7            	ld	(x),a
 486  0101               L512:
 487                     ; 57 							while(!is_target_element_placed)//beware infinite loop...
 489  0101 0d11          	tnz	(OFST-14,sp)
 490  0103 27b1          	jreq	L702
 491                     ; 54 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 493  0105 0c1f          	inc	(OFST+0,sp)
 497  0107 7b1f          	ld	a,(OFST+0,sp)
 498  0109 a106          	cp	a,#6
 499  010b 25a7          	jrult	L102
 500                     ; 68 					}while(target_pattern[0]==0);//avoid case where first goal is at the start, confusing the user about how the device operates
 502  010d 0d18          	tnz	(OFST-7,sp)
 503  010f 2602          	jrne	L07
 504  0111 2086          	jp	L561
 505  0113               L07:
 506  0113               L361:
 507                     ; 70 				if(get_button_event(0xFF,1,1)) new_game_state=6;//start cyclone game by long pressing the buttons
 509  0113 4b01          	push	#1
 510  0115 aeff01        	ldw	x,#65281
 511  0118 cd0000        	call	_get_button_event
 513  011b 5b01          	addw	sp,#1
 514  011d 4d            	tnz	a
 515  011e 2603          	jrne	L27
 516  0120 cc0465        	jp	L161
 517  0123               L27:
 520  0123 a606          	ld	a,#6
 521  0125 6b1e          	ld	(OFST-1,sp),a
 523  0127 ac650465      	jpf	L161
 524  012b               L32:
 525                     ; 74 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 527  012b 0f1f          	clr	(OFST+0,sp)
 529  012d               L122:
 530                     ; 76 					if(target_pattern[iter]<=(game_state_elapsed_ms>>9) && target_pattern[iter]<=game_level)
 532  012d 96            	ldw	x,sp
 533  012e 1c0012        	addw	x,#OFST-13
 534  0131 cd0000        	call	c_ltor
 536  0134 a609          	ld	a,#9
 537  0136 cd0000        	call	c_lursh
 539  0139 96            	ldw	x,sp
 540  013a 1c0005        	addw	x,#OFST-26
 541  013d cd0000        	call	c_rtol
 544  0140 96            	ldw	x,sp
 545  0141 1c0018        	addw	x,#OFST-7
 546  0144 9f            	ld	a,xl
 547  0145 5e            	swapw	x
 548  0146 1b1f          	add	a,(OFST+0,sp)
 549  0148 2401          	jrnc	L61
 550  014a 5c            	incw	x
 551  014b               L61:
 552  014b 02            	rlwa	x,a
 553  014c f6            	ld	a,(x)
 554  014d b703          	ld	c_lreg+3,a
 555  014f 3f02          	clr	c_lreg+2
 556  0151 3f01          	clr	c_lreg+1
 557  0153 3f00          	clr	c_lreg
 558  0155 96            	ldw	x,sp
 559  0156 1c0005        	addw	x,#OFST-26
 560  0159 cd0000        	call	c_lcmp
 562  015c 221a          	jrugt	L722
 564  015e 96            	ldw	x,sp
 565  015f 1c0018        	addw	x,#OFST-7
 566  0162 9f            	ld	a,xl
 567  0163 5e            	swapw	x
 568  0164 1b1f          	add	a,(OFST+0,sp)
 569  0166 2401          	jrnc	L02
 570  0168 5c            	incw	x
 571  0169               L02:
 572  0169 02            	rlwa	x,a
 573  016a f6            	ld	a,(x)
 574  016b 110f          	cp	a,(OFST-16,sp)
 575  016d 2209          	jrugt	L722
 576                     ; 78 						set_element_hue(iter,iter);
 578  016f 7b1f          	ld	a,(OFST+0,sp)
 579  0171 97            	ld	xl,a
 580  0172 7b1f          	ld	a,(OFST+0,sp)
 581  0174 95            	ld	xh,a
 582  0175 cd0476        	call	_set_element_hue
 584  0178               L722:
 585                     ; 74 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 587  0178 0c1f          	inc	(OFST+0,sp)
 591  017a 7b1f          	ld	a,(OFST+0,sp)
 592  017c a106          	cp	a,#6
 593  017e 25ad          	jrult	L122
 594                     ; 81 				effective_led_count=6;
 596  0180 a606          	ld	a,#6
 597  0182 6b10          	ld	(OFST-15,sp),a
 599                     ; 83 				if(get_button_event(0xFF,0,1)) new_game_state=2;
 601  0184 4b01          	push	#1
 602  0186 aeff00        	ldw	x,#65280
 603  0189 cd0000        	call	_get_button_event
 605  018c 5b01          	addw	sp,#1
 606  018e 4d            	tnz	a
 607  018f 2704          	jreq	L132
 610  0191 a602          	ld	a,#2
 611  0193 6b1e          	ld	(OFST-1,sp),a
 613  0195               L132:
 614                     ; 84 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 616  0195 4b01          	push	#1
 617  0197 aeff01        	ldw	x,#65281
 618  019a cd0000        	call	_get_button_event
 620  019d 5b01          	addw	sp,#1
 621  019f 4d            	tnz	a
 622  01a0 2603          	jrne	L47
 623  01a2 cc0465        	jp	L161
 624  01a5               L47:
 627  01a5 a606          	ld	a,#6
 628  01a7 6b1e          	ld	(OFST-1,sp),a
 630  01a9 ac650465      	jpf	L161
 631  01ad               L52:
 632                     ; 87 				if(is_new_state)
 634  01ad 0d1f          	tnz	(OFST+0,sp)
 635  01af 2704          	jreq	L532
 636                     ; 89 					cursor=0;
 638  01b1 0f16          	clr	(OFST-9,sp)
 640                     ; 90 					level_fractional_progress=0;
 642  01b3 0f17          	clr	(OFST-8,sp)
 644  01b5               L532:
 645                     ; 92 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 647  01b5 0f1f          	clr	(OFST+0,sp)
 649  01b7               L732:
 650                     ; 94 					if(target_pattern[iter]<level_fractional_progress)
 652  01b7 96            	ldw	x,sp
 653  01b8 1c0018        	addw	x,#OFST-7
 654  01bb 9f            	ld	a,xl
 655  01bc 5e            	swapw	x
 656  01bd 1b1f          	add	a,(OFST+0,sp)
 657  01bf 2401          	jrnc	L22
 658  01c1 5c            	incw	x
 659  01c2               L22:
 660  01c2 02            	rlwa	x,a
 661  01c3 f6            	ld	a,(x)
 662  01c4 1117          	cp	a,(OFST-8,sp)
 663  01c6 2409          	jruge	L542
 664                     ; 96 						set_element_hue(iter,iter);
 666  01c8 7b1f          	ld	a,(OFST+0,sp)
 667  01ca 97            	ld	xl,a
 668  01cb 7b1f          	ld	a,(OFST+0,sp)
 669  01cd 95            	ld	xh,a
 670  01ce cd0476        	call	_set_element_hue
 672  01d1               L542:
 673                     ; 92 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 675  01d1 0c1f          	inc	(OFST+0,sp)
 679  01d3 7b1f          	ld	a,(OFST+0,sp)
 680  01d5 a106          	cp	a,#6
 681  01d7 25de          	jrult	L732
 682                     ; 99 				if(game_state_elapsed_ms&0x0100) set_element_hue(cursor,cursor);
 684  01d9 7b14          	ld	a,(OFST-11,sp)
 685  01db a501          	bcp	a,#1
 686  01dd 2709          	jreq	L742
 689  01df 7b16          	ld	a,(OFST-9,sp)
 690  01e1 97            	ld	xl,a
 691  01e2 7b16          	ld	a,(OFST-9,sp)
 692  01e4 95            	ld	xh,a
 693  01e5 cd0476        	call	_set_element_hue
 695  01e8               L742:
 696                     ; 100 				if(get_button_event(1,0,1) || target_pattern[cursor]<level_fractional_progress)
 698  01e8 4b01          	push	#1
 699  01ea ae0100        	ldw	x,#256
 700  01ed cd0000        	call	_get_button_event
 702  01f0 5b01          	addw	sp,#1
 703  01f2 4d            	tnz	a
 704  01f3 2611          	jrne	L552
 706  01f5 96            	ldw	x,sp
 707  01f6 1c0018        	addw	x,#OFST-7
 708  01f9 9f            	ld	a,xl
 709  01fa 5e            	swapw	x
 710  01fb 1b16          	add	a,(OFST-9,sp)
 711  01fd 2401          	jrnc	L42
 712  01ff 5c            	incw	x
 713  0200               L42:
 714  0200 02            	rlwa	x,a
 715  0201 f6            	ld	a,(x)
 716  0202 1117          	cp	a,(OFST-8,sp)
 717  0204 241f          	jruge	L152
 718  0206               L552:
 719                     ; 103 						cursor=(cursor+1)%RGB_LED_COUNT;
 721  0206 7b16          	ld	a,(OFST-9,sp)
 722  0208 5f            	clrw	x
 723  0209 97            	ld	xl,a
 724  020a 5c            	incw	x
 725  020b a606          	ld	a,#6
 726  020d cd0000        	call	c_smodx
 728  0210 01            	rrwa	x,a
 729  0211 6b16          	ld	(OFST-9,sp),a
 730  0213 02            	rlwa	x,a
 732                     ; 104 					}while(target_pattern[cursor]<level_fractional_progress);//skip over indexes that have already been selected
 734  0214 96            	ldw	x,sp
 735  0215 1c0018        	addw	x,#OFST-7
 736  0218 9f            	ld	a,xl
 737  0219 5e            	swapw	x
 738  021a 1b16          	add	a,(OFST-9,sp)
 739  021c 2401          	jrnc	L62
 740  021e 5c            	incw	x
 741  021f               L62:
 742  021f 02            	rlwa	x,a
 743  0220 f6            	ld	a,(x)
 744  0221 1117          	cp	a,(OFST-8,sp)
 745  0223 25e1          	jrult	L552
 746  0225               L152:
 747                     ; 106 				if(get_button_event(0,0,1))
 749  0225 4b01          	push	#1
 750  0227 5f            	clrw	x
 751  0228 cd0000        	call	_get_button_event
 753  022b 5b01          	addw	sp,#1
 754  022d 4d            	tnz	a
 755  022e 2731          	jreq	L362
 756                     ; 108 					if(target_pattern[cursor]==level_fractional_progress)//correctly selected the proper led
 758  0230 96            	ldw	x,sp
 759  0231 1c0018        	addw	x,#OFST-7
 760  0234 9f            	ld	a,xl
 761  0235 5e            	swapw	x
 762  0236 1b16          	add	a,(OFST-9,sp)
 763  0238 2401          	jrnc	L03
 764  023a 5c            	incw	x
 765  023b               L03:
 766  023b 02            	rlwa	x,a
 767  023c f6            	ld	a,(x)
 768  023d 1117          	cp	a,(OFST-8,sp)
 769  023f 261c          	jrne	L562
 770                     ; 110 						level_fractional_progress++;
 772  0241 0c17          	inc	(OFST-8,sp)
 774                     ; 111 						if(level_fractional_progress>=RGB_LED_COUNT) new_game_state=5;//full win
 776  0243 7b17          	ld	a,(OFST-8,sp)
 777  0245 a106          	cp	a,#6
 778  0247 2506          	jrult	L762
 781  0249 a605          	ld	a,#5
 782  024b 6b1e          	ld	(OFST-1,sp),a
 785  024d 2012          	jra	L362
 786  024f               L762:
 787                     ; 112 						else if(level_fractional_progress>game_level){ new_game_state=4; game_level++; }//level win
 789  024f 7b17          	ld	a,(OFST-8,sp)
 790  0251 110f          	cp	a,(OFST-16,sp)
 791  0253 230c          	jrule	L362
 794  0255 a604          	ld	a,#4
 795  0257 6b1e          	ld	(OFST-1,sp),a
 799  0259 0c0f          	inc	(OFST-16,sp)
 801  025b 2004          	jra	L362
 802  025d               L562:
 803                     ; 114 						new_game_state=3;//lose
 805  025d a603          	ld	a,#3
 806  025f 6b1e          	ld	(OFST-1,sp),a
 808  0261               L362:
 809                     ; 117 				effective_led_count=RGB_LED_COUNT;
 811  0261 a606          	ld	a,#6
 812  0263 6b10          	ld	(OFST-15,sp),a
 814                     ; 118 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 816  0265 4b01          	push	#1
 817  0267 aeff01        	ldw	x,#65281
 818  026a cd0000        	call	_get_button_event
 820  026d 5b01          	addw	sp,#1
 821  026f 4d            	tnz	a
 822  0270 2603          	jrne	L67
 823  0272 cc0465        	jp	L161
 824  0275               L67:
 827  0275 a606          	ld	a,#6
 828  0277 6b1e          	ld	(OFST-1,sp),a
 830  0279 ac650465      	jpf	L161
 831  027d               L72:
 832                     ; 121 				if((game_state_elapsed_ms>>8)&0x04){ get_button_event(0xFF,0xFF,1); new_game_state=0; }//restart game after timeout, and clear any button pushes registered during lose
 834  027d 7b14          	ld	a,(OFST-11,sp)
 835  027f a504          	bcp	a,#4
 836  0281 270b          	jreq	L103
 839  0283 4b01          	push	#1
 840  0285 aeffff        	ldw	x,#65535
 841  0288 cd0000        	call	_get_button_event
 843  028b 84            	pop	a
 846  028c 0f1e          	clr	(OFST-1,sp)
 848  028e               L103:
 849                     ; 122 				if((game_state_elapsed_ms>>7)&0x01) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,0,255);//flash red LEDs
 851  028e 7b15          	ld	a,(OFST-10,sp)
 852  0290 49            	rlc	a
 853  0291 4f            	clr	a
 854  0292 49            	rlc	a
 855  0293 a401          	and	a,#1
 856  0295 b703          	ld	c_lreg+3,a
 857  0297 3f02          	clr	c_lreg+2
 858  0299 3f01          	clr	c_lreg+1
 859  029b 3f00          	clr	c_lreg
 860  029d cd0000        	call	c_lrzmp
 862  02a0 2714          	jreq	L303
 865  02a2 0f1f          	clr	(OFST+0,sp)
 867  02a4               L503:
 870  02a4 4bff          	push	#255
 871  02a6 7b20          	ld	a,(OFST+1,sp)
 872  02a8 5f            	clrw	x
 873  02a9 95            	ld	xh,a
 874  02aa cd0000        	call	_set_rgb
 876  02ad 84            	pop	a
 879  02ae 0c1f          	inc	(OFST+0,sp)
 883  02b0 7b1f          	ld	a,(OFST+0,sp)
 884  02b2 a106          	cp	a,#6
 885  02b4 25ee          	jrult	L503
 886  02b6               L303:
 887                     ; 123 				effective_led_count=RGB_LED_COUNT;
 889  02b6 a606          	ld	a,#6
 890  02b8 6b10          	ld	(OFST-15,sp),a
 892                     ; 124 			}break;
 894  02ba ac650465      	jpf	L161
 895  02be               L13:
 896                     ; 126 				if((game_state_elapsed_ms>>8)&0x04){ get_button_event(0xFF,0xFF,1);  new_game_state=1; }//go to next level, clear any button pushse during transition
 898  02be 7b14          	ld	a,(OFST-11,sp)
 899  02c0 a504          	bcp	a,#4
 900  02c2 270d          	jreq	L313
 903  02c4 4b01          	push	#1
 904  02c6 aeffff        	ldw	x,#65535
 905  02c9 cd0000        	call	_get_button_event
 907  02cc 84            	pop	a
 910  02cd a601          	ld	a,#1
 911  02cf 6b1e          	ld	(OFST-1,sp),a
 913  02d1               L313:
 914                     ; 127 				if((game_state_elapsed_ms>>7)&0x01) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,1,255);//flash green LEDs
 916  02d1 7b15          	ld	a,(OFST-10,sp)
 917  02d3 49            	rlc	a
 918  02d4 4f            	clr	a
 919  02d5 49            	rlc	a
 920  02d6 a401          	and	a,#1
 921  02d8 b703          	ld	c_lreg+3,a
 922  02da 3f02          	clr	c_lreg+2
 923  02dc 3f01          	clr	c_lreg+1
 924  02de 3f00          	clr	c_lreg
 925  02e0 cd0000        	call	c_lrzmp
 927  02e3 2716          	jreq	L513
 930  02e5 0f1f          	clr	(OFST+0,sp)
 932  02e7               L713:
 935  02e7 4bff          	push	#255
 936  02e9 7b20          	ld	a,(OFST+1,sp)
 937  02eb ae0001        	ldw	x,#1
 938  02ee 95            	ld	xh,a
 939  02ef cd0000        	call	_set_rgb
 941  02f2 84            	pop	a
 944  02f3 0c1f          	inc	(OFST+0,sp)
 948  02f5 7b1f          	ld	a,(OFST+0,sp)
 949  02f7 a106          	cp	a,#6
 950  02f9 25ec          	jrult	L713
 951  02fb               L513:
 952                     ; 128 				effective_led_count=RGB_LED_COUNT;
 954  02fb a606          	ld	a,#6
 955  02fd 6b10          	ld	(OFST-15,sp),a
 957                     ; 129 			}break;
 959  02ff ac650465      	jpf	L161
 960  0303               L33:
 961                     ; 131 				if(is_new_state) submenu_index=0;
 963  0303 0d1f          	tnz	(OFST+0,sp)
 964  0305 2702          	jreq	L523
 967  0307 0f0e          	clr	(OFST-17,sp)
 969  0309               L523:
 970                     ; 132 				effective_led_count=show_screensaver(submenu_index);
 972  0309 7b0e          	ld	a,(OFST-17,sp)
 973  030b cd04d8        	call	_show_screensaver
 975  030e 6b10          	ld	(OFST-15,sp),a
 977                     ; 133 				if(get_button_event(0xFF,0,1)) submenu_index++;//allow user to cycle through winning screensavers
 979  0310 4b01          	push	#1
 980  0312 aeff00        	ldw	x,#65280
 981  0315 cd0000        	call	_get_button_event
 983  0318 5b01          	addw	sp,#1
 984  031a 4d            	tnz	a
 985  031b 2702          	jreq	L723
 988  031d 0c0e          	inc	(OFST-17,sp)
 990  031f               L723:
 991                     ; 134 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press to get back to idle screen
 993  031f 4b01          	push	#1
 994  0321 aeff01        	ldw	x,#65281
 995  0324 cd0000        	call	_get_button_event
 997  0327 5b01          	addw	sp,#1
 998  0329 4d            	tnz	a
 999  032a 2603          	jrne	L001
1000  032c cc0465        	jp	L161
1001  032f               L001:
1004  032f 0f1e          	clr	(OFST-1,sp)
1006  0331 ac650465      	jpf	L161
1007  0335               L53:
1008                     ; 137 				set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
1010  0335 ae0505        	ldw	x,#1285
1011  0338 cd0476        	call	_set_element_hue
1013                     ; 138 				cursor=((game_state_elapsed_ms>>8)+(game_level>1?((game_state_elapsed_ms+(2<<6))>>8):0)
1013                     ; 139 									 			  								+(game_level>3?((game_state_elapsed_ms+(3<<6))>>8):0))%RGB_LED_COUNT;//player position
1015  033b 7b0f          	ld	a,(OFST-16,sp)
1016  033d a104          	cp	a,#4
1017  033f 2513          	jrult	L23
1018  0341 96            	ldw	x,sp
1019  0342 1c0012        	addw	x,#OFST-13
1020  0345 cd0000        	call	c_ltor
1022  0348 a6c0          	ld	a,#192
1023  034a cd0000        	call	c_ladc
1025  034d a608          	ld	a,#8
1026  034f cd0000        	call	c_lursh
1028  0352 2004          	jra	L43
1029  0354               L23:
1030  0354 5f            	clrw	x
1031  0355 cd0000        	call	c_itolx
1033  0358               L43:
1034  0358 96            	ldw	x,sp
1035  0359 1c0005        	addw	x,#OFST-26
1036  035c cd0000        	call	c_rtol
1039  035f 7b0f          	ld	a,(OFST-16,sp)
1040  0361 a102          	cp	a,#2
1041  0363 2513          	jrult	L63
1042  0365 96            	ldw	x,sp
1043  0366 1c0012        	addw	x,#OFST-13
1044  0369 cd0000        	call	c_ltor
1046  036c a680          	ld	a,#128
1047  036e cd0000        	call	c_ladc
1049  0371 a608          	ld	a,#8
1050  0373 cd0000        	call	c_lursh
1052  0376 2004          	jra	L04
1053  0378               L63:
1054  0378 5f            	clrw	x
1055  0379 cd0000        	call	c_itolx
1057  037c               L04:
1058  037c 96            	ldw	x,sp
1059  037d 1c0001        	addw	x,#OFST-30
1060  0380 cd0000        	call	c_rtol
1063  0383 96            	ldw	x,sp
1064  0384 1c0012        	addw	x,#OFST-13
1065  0387 cd0000        	call	c_ltor
1067  038a a608          	ld	a,#8
1068  038c cd0000        	call	c_lursh
1070  038f 96            	ldw	x,sp
1071  0390 1c0001        	addw	x,#OFST-30
1072  0393 cd0000        	call	c_ladd
1074  0396 96            	ldw	x,sp
1075  0397 1c0005        	addw	x,#OFST-26
1076  039a cd0000        	call	c_ladd
1078  039d ae0000        	ldw	x,#L24
1079  03a0 cd0000        	call	c_lumd
1081  03a3 b603          	ld	a,c_lreg+3
1082  03a5 6b16          	ld	(OFST-9,sp),a
1084                     ; 140 				if(is_target_element_placed) cursor=RGB_LED_COUNT-cursor-1;//reverse direction
1086  03a7 0d11          	tnz	(OFST-14,sp)
1087  03a9 2706          	jreq	L333
1090  03ab a605          	ld	a,#5
1091  03ad 1016          	sub	a,(OFST-9,sp)
1092  03af 6b16          	ld	(OFST-9,sp),a
1094  03b1               L333:
1095                     ; 141 				set_element_hue(cursor,game_level);
1097  03b1 7b0f          	ld	a,(OFST-16,sp)
1098  03b3 97            	ld	xl,a
1099  03b4 7b16          	ld	a,(OFST-9,sp)
1100  03b6 95            	ld	xh,a
1101  03b7 cd0476        	call	_set_element_hue
1103                     ; 142 				if(get_button_event(0xFF,0,1)) new_game_state=7;//show user evaluation of performance
1105  03ba 4b01          	push	#1
1106  03bc aeff00        	ldw	x,#65280
1107  03bf cd0000        	call	_get_button_event
1109  03c2 5b01          	addw	sp,#1
1110  03c4 4d            	tnz	a
1111  03c5 2704          	jreq	L533
1114  03c7 a607          	ld	a,#7
1115  03c9 6b1e          	ld	(OFST-1,sp),a
1117  03cb               L533:
1118                     ; 143 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle
1120  03cb 4b01          	push	#1
1121  03cd aeff01        	ldw	x,#65281
1122  03d0 cd0000        	call	_get_button_event
1124  03d3 5b01          	addw	sp,#1
1125  03d5 4d            	tnz	a
1126  03d6 2702          	jreq	L733
1129  03d8 0f1e          	clr	(OFST-1,sp)
1131  03da               L733:
1132                     ; 144 				effective_led_count=2;
1134  03da a602          	ld	a,#2
1135  03dc 6b10          	ld	(OFST-15,sp),a
1137                     ; 145 			}break;
1139  03de ac650465      	jpf	L161
1140  03e2               L73:
1141                     ; 147 				if(get_button_event(0xFF,0,1))
1143  03e2 4b01          	push	#1
1144  03e4 aeff00        	ldw	x,#65280
1145  03e7 cd0000        	call	_get_button_event
1147  03ea 5b01          	addw	sp,#1
1148  03ec 4d            	tnz	a
1149  03ed 2723          	jreq	L143
1150                     ; 149 					is_target_element_placed=!is_target_element_placed;//flip direction
1152  03ef 0d11          	tnz	(OFST-14,sp)
1153  03f1 2604          	jrne	L44
1154  03f3 a601          	ld	a,#1
1155  03f5 2001          	jra	L64
1156  03f7               L44:
1157  03f7 4f            	clr	a
1158  03f8               L64:
1159  03f8 6b11          	ld	(OFST-14,sp),a
1161                     ; 150 					if(cursor==(RGB_LED_COUNT-1)) game_level++;
1163  03fa 7b16          	ld	a,(OFST-9,sp)
1164  03fc a105          	cp	a,#5
1165  03fe 2602          	jrne	L343
1168  0400 0c0f          	inc	(OFST-16,sp)
1170  0402               L343:
1171                     ; 151 					if(game_level==RGB_LED_COUNT) new_game_state=5;//win after all levels
1173  0402 7b0f          	ld	a,(OFST-16,sp)
1174  0404 a106          	cp	a,#6
1175  0406 2606          	jrne	L543
1178  0408 a605          	ld	a,#5
1179  040a 6b1e          	ld	(OFST-1,sp),a
1182  040c 2004          	jra	L143
1183  040e               L543:
1184                     ; 152 					else new_game_state=6; //go to next level, clear any button pushse during transition
1186  040e a606          	ld	a,#6
1187  0410 6b1e          	ld	(OFST-1,sp),a
1189  0412               L143:
1190                     ; 154 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle
1192  0412 4b01          	push	#1
1193  0414 aeff01        	ldw	x,#65281
1194  0417 cd0000        	call	_get_button_event
1196  041a 5b01          	addw	sp,#1
1197  041c 4d            	tnz	a
1198  041d 2702          	jreq	L153
1201  041f 0f1e          	clr	(OFST-1,sp)
1203  0421               L153:
1204                     ; 155 				if((game_state_elapsed_ms>>7)&0x01)
1206  0421 7b15          	ld	a,(OFST-10,sp)
1207  0423 49            	rlc	a
1208  0424 4f            	clr	a
1209  0425 49            	rlc	a
1210  0426 a401          	and	a,#1
1211  0428 b703          	ld	c_lreg+3,a
1212  042a 3f02          	clr	c_lreg+2
1213  042c 3f01          	clr	c_lreg+1
1214  042e 3f00          	clr	c_lreg
1215  0430 cd0000        	call	c_lrzmp
1217  0433 2715          	jreq	L353
1218                     ; 157 					set_element_hue(cursor,game_level);
1220  0435 7b0f          	ld	a,(OFST-16,sp)
1221  0437 97            	ld	xl,a
1222  0438 7b16          	ld	a,(OFST-9,sp)
1223  043a 95            	ld	xh,a
1224  043b ad39          	call	_set_element_hue
1226                     ; 158 					if(cursor!=(RGB_LED_COUNT-1)) set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
1228  043d 7b16          	ld	a,(OFST-9,sp)
1229  043f a105          	cp	a,#5
1230  0441 271e          	jreq	L753
1233  0443 ae0505        	ldw	x,#1285
1234  0446 ad2e          	call	_set_element_hue
1236  0448 2017          	jra	L753
1237  044a               L353:
1238                     ; 160 					if(cursor==(RGB_LED_COUNT-1))
1240  044a 7b16          	ld	a,(OFST-9,sp)
1241  044c a105          	cp	a,#5
1242  044e 260c          	jrne	L163
1243                     ; 162 						set_element_hue(RGB_LED_COUNT-2,RGB_LED_COUNT-1);
1245  0450 ae0405        	ldw	x,#1029
1246  0453 ad21          	call	_set_element_hue
1248                     ; 163 						set_element_hue(0,RGB_LED_COUNT-1);
1250  0455 ae0005        	ldw	x,#5
1251  0458 ad1c          	call	_set_element_hue
1254  045a 2005          	jra	L753
1255  045c               L163:
1256                     ; 165 						set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
1258  045c ae0505        	ldw	x,#1285
1259  045f ad15          	call	_set_element_hue
1261  0461               L753:
1262                     ; 168 				effective_led_count=RGB_LED_COUNT;
1264                     ; 169 				effective_led_count=3;
1266  0461 a603          	ld	a,#3
1267  0463 6b10          	ld	(OFST-15,sp),a
1269                     ; 170 			}break;
1271  0465               L161:
1272                     ; 172 		flush_leds(effective_led_count);
1274  0465 7b10          	ld	a,(OFST-15,sp)
1275  0467 cd0000        	call	_flush_leds
1277  046a               L151:
1278                     ; 28 	while(is_application_valid())
1280  046a cd0000        	call	_is_application_valid
1282  046d 4d            	tnz	a
1283  046e 2703          	jreq	L201
1284  0470 cc001c        	jp	L741
1285  0473               L201:
1286                     ; 174 }
1289  0473 5b1f          	addw	sp,#31
1290  0475 81            	ret
1344                     ; 176 void set_element_hue(u8 led_index,u8 color_index)
1344                     ; 177 {
1345                     	switch	.text
1346  0476               _set_element_hue:
1348  0476 89            	pushw	x
1349  0477 89            	pushw	x
1350       00000002      OFST:	set	2
1353                     ; 179 	switch(color_index){
1355  0478 9f            	ld	a,xl
1357                     ; 188 	  default: color=0xD555; break;//purple
1358  0479 4d            	tnz	a
1359  047a 2738          	jreq	L763
1360  047c 4a            	dec	a
1361  047d 273c          	jreq	L173
1362  047f 4a            	dec	a
1363  0480 2740          	jreq	L373
1364  0482 4a            	dec	a
1365  0483 2742          	jreq	L573
1366  0485 a002          	sub	a,#2
1367  0487 2707          	jreq	L563
1368  0489               L773:
1371  0489 aed555        	ldw	x,#54613
1372  048c 1f01          	ldw	(OFST-1,sp),x
1376  048e 203c          	jra	L134
1377  0490               L563:
1378                     ; 180 		case 5: set_rgb(led_index,0,146);//dirty white
1380  0490 4b92          	push	#146
1381  0492 7b04          	ld	a,(OFST+2,sp)
1382  0494 5f            	clrw	x
1383  0495 95            	ld	xh,a
1384  0496 cd0000        	call	_set_rgb
1386  0499 84            	pop	a
1387                     ; 181 						set_rgb(led_index,1,146);//146**2 *3 = 255**2
1389  049a 4b92          	push	#146
1390  049c 7b04          	ld	a,(OFST+2,sp)
1391  049e ae0001        	ldw	x,#1
1392  04a1 95            	ld	xh,a
1393  04a2 cd0000        	call	_set_rgb
1395  04a5 84            	pop	a
1396                     ; 182 						set_rgb(led_index,2,146);
1398  04a6 4b92          	push	#146
1399  04a8 7b04          	ld	a,(OFST+2,sp)
1400  04aa ae0002        	ldw	x,#2
1401  04ad 95            	ld	xh,a
1402  04ae cd0000        	call	_set_rgb
1404  04b1 84            	pop	a
1405                     ; 183 						return;
1407  04b2 2021          	jra	L601
1408  04b4               L763:
1409                     ; 184 		case 0: color=0x2AAA; break;//yellow 
1411  04b4 ae2aaa        	ldw	x,#10922
1412  04b7 1f01          	ldw	(OFST-1,sp),x
1416  04b9 2011          	jra	L134
1417  04bb               L173:
1418                     ; 185 		case 1: color=0x5555; break;//green
1420  04bb ae5555        	ldw	x,#21845
1421  04be 1f01          	ldw	(OFST-1,sp),x
1425  04c0 200a          	jra	L134
1426  04c2               L373:
1427                     ; 186 	  case 2: color=0x0; break;//red
1429  04c2 5f            	clrw	x
1430  04c3 1f01          	ldw	(OFST-1,sp),x
1434  04c5 2005          	jra	L134
1435  04c7               L573:
1436                     ; 187 	  case 3: color=0xAAAA; break;//blue
1438  04c7 aeaaaa        	ldw	x,#43690
1439  04ca 1f01          	ldw	(OFST-1,sp),x
1443  04cc               L134:
1444                     ; 190 	set_hue_max(led_index,color);
1446  04cc 1e01          	ldw	x,(OFST-1,sp)
1447  04ce 89            	pushw	x
1448  04cf 7b05          	ld	a,(OFST+3,sp)
1449  04d1 cd0000        	call	_set_hue_max
1451  04d4 85            	popw	x
1452                     ; 191 }
1453  04d5               L601:
1456  04d5 5b04          	addw	sp,#4
1457  04d7 81            	ret
1493                     ; 193 u8 show_screensaver(u8 screensaver_index)
1493                     ; 194 {
1494                     	switch	.text
1495  04d8               _show_screensaver:
1497  04d8 88            	push	a
1498       00000001      OFST:	set	1
1501                     ; 195 	switch(screensaver_index%SCREENSAVER_COUNT)
1503  04d9 5f            	clrw	x
1504  04da 97            	ld	xl,a
1505  04db a607          	ld	a,#7
1506  04dd cd0000        	call	c_smodx
1509                     ; 203 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1510  04e0 5d            	tnzw	x
1511  04e1 2714          	jreq	L334
1512  04e3 5a            	decw	x
1513  04e4 2717          	jreq	L534
1514  04e6 5a            	decw	x
1515  04e7 2721          	jreq	L734
1516  04e9 5a            	decw	x
1517  04ea 272c          	jreq	L144
1518  04ec 5a            	decw	x
1519  04ed 2730          	jreq	L344
1520  04ef 5a            	decw	x
1521  04f0 2734          	jreq	L544
1522  04f2 5a            	decw	x
1523  04f3 273f          	jreq	L744
1524  04f5 204c          	jra	L174
1525  04f7               L334:
1526                     ; 197 		case 0: return set_frame_rainbow(0);
1528  04f7 4f            	clr	a
1529  04f8 ad4e          	call	_set_frame_rainbow
1533  04fa 5b01          	addw	sp,#1
1534  04fc 81            	ret
1535  04fd               L534:
1536                     ; 198 		case 1: return set_frame_rainbow(0)+set_sparkles(0);
1538  04fd 4f            	clr	a
1539  04fe ad7c          	call	_set_sparkles
1541  0500 6b01          	ld	(OFST+0,sp),a
1543  0502 4f            	clr	a
1544  0503 ad43          	call	_set_frame_rainbow
1546  0505 1b01          	add	a,(OFST+0,sp)
1549  0507 5b01          	addw	sp,#1
1550  0509 81            	ret
1551  050a               L734:
1552                     ; 199 		case 2: return set_frame_rainbow(0)+set_sparkles(1);
1554  050a a601          	ld	a,#1
1555  050c ad6e          	call	_set_sparkles
1557  050e 6b01          	ld	(OFST+0,sp),a
1559  0510 4f            	clr	a
1560  0511 ad35          	call	_set_frame_rainbow
1562  0513 1b01          	add	a,(OFST+0,sp)
1565  0515 5b01          	addw	sp,#1
1566  0517 81            	ret
1567  0518               L144:
1568                     ; 200 		case 3: return set_sparkles(1);
1570  0518 a601          	ld	a,#1
1571  051a ad60          	call	_set_sparkles
1575  051c 5b01          	addw	sp,#1
1576  051e 81            	ret
1577  051f               L344:
1578                     ; 201 		case 4: return set_frame_rainbow(1);
1580  051f a601          	ld	a,#1
1581  0521 ad25          	call	_set_frame_rainbow
1585  0523 5b01          	addw	sp,#1
1586  0525 81            	ret
1587  0526               L544:
1588                     ; 202 		case 5: return set_frame_rainbow(1)+set_sparkles(0);
1590  0526 4f            	clr	a
1591  0527 ad53          	call	_set_sparkles
1593  0529 6b01          	ld	(OFST+0,sp),a
1595  052b a601          	ld	a,#1
1596  052d ad19          	call	_set_frame_rainbow
1598  052f 1b01          	add	a,(OFST+0,sp)
1601  0531 5b01          	addw	sp,#1
1602  0533 81            	ret
1603  0534               L744:
1604                     ; 203 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1606  0534 a601          	ld	a,#1
1607  0536 ad44          	call	_set_sparkles
1609  0538 6b01          	ld	(OFST+0,sp),a
1611  053a a601          	ld	a,#1
1612  053c ad0a          	call	_set_frame_rainbow
1614  053e 1b01          	add	a,(OFST+0,sp)
1617  0540 5b01          	addw	sp,#1
1618  0542 81            	ret
1619  0543               L174:
1620                     ; 205 	return 1;
1622  0543 a601          	ld	a,#1
1625  0545 5b01          	addw	sp,#1
1626  0547 81            	ret
1681                     ; 208 u8 set_frame_rainbow(bool is_circular)
1681                     ; 209 {
1682                     	switch	.text
1683  0548               _set_frame_rainbow:
1685  0548 88            	push	a
1686  0549 5203          	subw	sp,#3
1687       00000003      OFST:	set	3
1690                     ; 211 	u16 offset=0;
1692  054b 5f            	clrw	x
1693  054c 1f01          	ldw	(OFST-2,sp),x
1695                     ; 212 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1697  054e 0f03          	clr	(OFST+0,sp)
1699  0550               L125:
1700                     ; 214 		set_hue_max(iter,(u16)(millis()<<5)+offset);
1702  0550 cd0000        	call	_millis
1704  0553 a605          	ld	a,#5
1705  0555 cd0000        	call	c_llsh
1707  0558 be02          	ldw	x,c_lreg+2
1708  055a 72fb01        	addw	x,(OFST-2,sp)
1709  055d 89            	pushw	x
1710  055e 7b05          	ld	a,(OFST+2,sp)
1711  0560 cd0000        	call	_set_hue_max
1713  0563 85            	popw	x
1714                     ; 215 		if(is_circular) offset+=0x2AAB;
1716  0564 0d04          	tnz	(OFST+1,sp)
1717  0566 2707          	jreq	L725
1720  0568 1e01          	ldw	x,(OFST-2,sp)
1721  056a 1c2aab        	addw	x,#10923
1722  056d 1f01          	ldw	(OFST-2,sp),x
1724  056f               L725:
1725                     ; 212 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1727  056f 0c03          	inc	(OFST+0,sp)
1731  0571 7b03          	ld	a,(OFST+0,sp)
1732  0573 a106          	cp	a,#6
1733  0575 25d9          	jrult	L125
1734                     ; 217 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
1736  0577 a606          	ld	a,#6
1739  0579 5b04          	addw	sp,#4
1740  057b 81            	ret
1795                     ; 220 u8 set_sparkles(bool is_fireworks)
1795                     ; 221 {
1796                     	switch	.text
1797  057c               _set_sparkles:
1799  057c 88            	push	a
1800  057d 5207          	subw	sp,#7
1801       00000007      OFST:	set	7
1804                     ; 224 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1806  057f 0f05          	clr	(OFST-2,sp)
1808  0581               L755:
1809                     ; 227 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
1811  0581 cd0000        	call	_millis
1813  0584 96            	ldw	x,sp
1814  0585 1c0001        	addw	x,#OFST-6
1815  0588 cd0000        	call	c_rtol
1818  058b 7b05          	ld	a,(OFST-2,sp)
1819  058d 5f            	clrw	x
1820  058e 97            	ld	xl,a
1821  058f 4f            	clr	a
1822  0590 02            	rlwa	x,a
1823  0591 58            	sllw	x
1824  0592 cd0000        	call	c_itolx
1826  0595 96            	ldw	x,sp
1827  0596 1c0001        	addw	x,#OFST-6
1828  0599 cd0000        	call	c_ladd
1830  059c be02          	ldw	x,c_lreg+2
1831  059e 1f06          	ldw	(OFST-1,sp),x
1833                     ; 228 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
1835  05a0 cd0000        	call	_millis
1837  05a3 7b05          	ld	a,(OFST-2,sp)
1838  05a5 a403          	and	a,#3
1839  05a7 ab02          	add	a,#2
1840  05a9 cd0000        	call	c_lursh
1842  05ac 96            	ldw	x,sp
1843  05ad 1c0001        	addw	x,#OFST-6
1844  05b0 cd0000        	call	c_rtol
1847  05b3 1e06          	ldw	x,(OFST-1,sp)
1848  05b5 cd0000        	call	c_uitolx
1850  05b8 96            	ldw	x,sp
1851  05b9 1c0001        	addw	x,#OFST-6
1852  05bc cd0000        	call	c_lsub
1854  05bf be02          	ldw	x,c_lreg+2
1855  05c1 1f06          	ldw	(OFST-1,sp),x
1857                     ; 229 		state+=millis()>>(2+((iter>>2)&0x02));
1859  05c3 cd0000        	call	_millis
1861  05c6 7b05          	ld	a,(OFST-2,sp)
1862  05c8 44            	srl	a
1863  05c9 44            	srl	a
1864  05ca a402          	and	a,#2
1865  05cc ab02          	add	a,#2
1866  05ce cd0000        	call	c_lursh
1868  05d1 96            	ldw	x,sp
1869  05d2 1c0001        	addw	x,#OFST-6
1870  05d5 cd0000        	call	c_rtol
1873  05d8 1e06          	ldw	x,(OFST-1,sp)
1874  05da cd0000        	call	c_uitolx
1876  05dd 96            	ldw	x,sp
1877  05de 1c0001        	addw	x,#OFST-6
1878  05e1 cd0000        	call	c_ladd
1880  05e4 be02          	ldw	x,c_lreg+2
1881  05e6 1f06          	ldw	(OFST-1,sp),x
1883                     ; 230 		if(!((state>>11)&(is_fireworks?0x01:0x03)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
1885  05e8 0d08          	tnz	(OFST+1,sp)
1886  05ea 2705          	jreq	L611
1887  05ec ae0001        	ldw	x,#1
1888  05ef 2003          	jra	L021
1889  05f1               L611:
1890  05f1 ae0003        	ldw	x,#3
1891  05f4               L021:
1892  05f4 1f03          	ldw	(OFST-4,sp),x
1894  05f6 1e06          	ldw	x,(OFST-1,sp)
1895  05f8 4f            	clr	a
1896  05f9 01            	rrwa	x,a
1897  05fa 54            	srlw	x
1898  05fb 54            	srlw	x
1899  05fc 54            	srlw	x
1900  05fd 01            	rrwa	x,a
1901  05fe 1404          	and	a,(OFST-3,sp)
1902  0600 01            	rrwa	x,a
1903  0601 1403          	and	a,(OFST-4,sp)
1904  0603 01            	rrwa	x,a
1905  0604 a30000        	cpw	x,#0
1906  0607 2672          	jrne	L565
1907                     ; 233 			if(is_fireworks)
1909  0609 0d08          	tnz	(OFST+1,sp)
1910  060b 2741          	jreq	L765
1911                     ; 234 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
1913  060d 1e06          	ldw	x,(OFST-1,sp)
1914  060f 4f            	clr	a
1915  0610 01            	rrwa	x,a
1916  0611 54            	srlw	x
1917  0612 54            	srlw	x
1918  0613 01            	rrwa	x,a
1919  0614 a501          	bcp	a,#1
1920  0616 270d          	jreq	L221
1921  0618 1e06          	ldw	x,(OFST-1,sp)
1922  061a 54            	srlw	x
1923  061b 54            	srlw	x
1924  061c 54            	srlw	x
1925  061d 53            	cplw	x
1926  061e 01            	rrwa	x,a
1927  061f a47f          	and	a,#127
1928  0621 5f            	clrw	x
1929  0622 02            	rlwa	x,a
1930  0623 201f          	jra	L421
1931  0625               L221:
1932  0625 1e06          	ldw	x,(OFST-1,sp)
1933  0627 a606          	ld	a,#6
1934  0629               L031:
1935  0629 54            	srlw	x
1936  062a 4a            	dec	a
1937  062b 26fc          	jrne	L031
1938  062d 01            	rrwa	x,a
1939  062e a40f          	and	a,#15
1940  0630 5f            	clrw	x
1941  0631 02            	rlwa	x,a
1942  0632 a3000f        	cpw	x,#15
1943  0635 2604          	jrne	L621
1944  0637 a6ff          	ld	a,#255
1945  0639 2001          	jra	L231
1946  063b               L621:
1947  063b 4f            	clr	a
1948  063c               L231:
1949  063c 97            	ld	xl,a
1950  063d 9f            	ld	a,xl
1951  063e 5f            	clrw	x
1952  063f 4d            	tnz	a
1953  0640 2a01          	jrpl	L431
1954  0642 53            	cplw	x
1955  0643               L431:
1956  0643 97            	ld	xl,a
1957  0644               L421:
1958  0644 9f            	ld	a,xl
1959  0645 97            	ld	xl,a
1960  0646 7b05          	ld	a,(OFST-2,sp)
1961  0648 95            	ld	xh,a
1962  0649 cd0000        	call	_set_white
1965  064c 202d          	jra	L565
1966  064e               L765:
1967                     ; 236 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
1969  064e 1e06          	ldw	x,(OFST-1,sp)
1970  0650 4f            	clr	a
1971  0651 01            	rrwa	x,a
1972  0652 54            	srlw	x
1973  0653 54            	srlw	x
1974  0654 01            	rrwa	x,a
1975  0655 a501          	bcp	a,#1
1976  0657 2707          	jreq	L631
1977  0659 1e06          	ldw	x,(OFST-1,sp)
1978  065b 54            	srlw	x
1979  065c 54            	srlw	x
1980  065d 53            	cplw	x
1981  065e 2013          	jra	L041
1982  0660               L631:
1983  0660 1e06          	ldw	x,(OFST-1,sp)
1984  0662 4f            	clr	a
1985  0663 01            	rrwa	x,a
1986  0664 01            	rrwa	x,a
1987  0665 a503          	bcp	a,#3
1988  0667 2704          	jreq	L241
1989  0669 a6ff          	ld	a,#255
1990  066b 2002          	jra	L441
1991  066d               L241:
1992  066d 7b07          	ld	a,(OFST+0,sp)
1993  066f               L441:
1994  066f 97            	ld	xl,a
1995  0670 9f            	ld	a,xl
1996  0671 5f            	clrw	x
1997  0672 97            	ld	xl,a
1998  0673               L041:
1999  0673 9f            	ld	a,xl
2000  0674 97            	ld	xl,a
2001  0675 7b05          	ld	a,(OFST-2,sp)
2002  0677 95            	ld	xh,a
2003  0678 cd0000        	call	_set_white
2005  067b               L565:
2006                     ; 224 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
2008  067b 0c05          	inc	(OFST-2,sp)
2012  067d 7b05          	ld	a,(OFST-2,sp)
2013  067f a10c          	cp	a,#12
2014  0681 2403          	jruge	L641
2015  0683 cc0581        	jp	L755
2016  0686               L641:
2017                     ; 239 	return WHITE_LED_COUNT/4;
2019  0686 a603          	ld	a,#3
2022  0688 5b08          	addw	sp,#8
2023  068a 81            	ret
2048                     	switch	.const
2049  0004               L251:
2050  0004 0000000c      	dc.l	12
2051                     ; 242 u8 set_white_test()
2051                     ; 243 {
2052                     	switch	.text
2053  068b               _set_white_test:
2057                     ; 244 	set_white((millis()>>6)%WHITE_LED_COUNT,0xFF);
2059  068b cd0000        	call	_millis
2061  068e a606          	ld	a,#6
2062  0690 cd0000        	call	c_lursh
2064  0693 ae0004        	ldw	x,#L251
2065  0696 cd0000        	call	c_lumd
2067  0699 b603          	ld	a,c_lreg+3
2068  069b ae00ff        	ldw	x,#255
2069  069e 95            	ld	xh,a
2070  069f cd0000        	call	_set_white
2072                     ; 245 	return 1;
2074  06a2 a601          	ld	a,#1
2077  06a4 81            	ret
2103                     ; 248 u8 set_debug_buttons()
2103                     ; 249 {//light up leds based on button states
2104                     	switch	.text
2105  06a5               _set_debug_buttons:
2109                     ; 250 	set_white(0,is_button_down(0)?0xFF:0);
2111  06a5 4f            	clr	a
2112  06a6 cd0000        	call	_is_button_down
2114  06a9 4d            	tnz	a
2115  06aa 2704          	jreq	L651
2116  06ac a6ff          	ld	a,#255
2117  06ae 2001          	jra	L061
2118  06b0               L651:
2119  06b0 4f            	clr	a
2120  06b1               L061:
2121  06b1 5f            	clrw	x
2122  06b2 97            	ld	xl,a
2123  06b3 cd0000        	call	_set_white
2125                     ; 251 	set_white(1,is_button_down(1)?0xFF:0);
2127  06b6 a601          	ld	a,#1
2128  06b8 cd0000        	call	_is_button_down
2130  06bb 4d            	tnz	a
2131  06bc 2704          	jreq	L261
2132  06be a6ff          	ld	a,#255
2133  06c0 2001          	jra	L461
2134  06c2               L261:
2135  06c2 4f            	clr	a
2136  06c3               L461:
2137  06c3 ae0100        	ldw	x,#256
2138  06c6 97            	ld	xl,a
2139  06c7 cd0000        	call	_set_white
2141                     ; 252 	set_white(2,is_button_down(2)?0xFF:0);
2143  06ca a602          	ld	a,#2
2144  06cc cd0000        	call	_is_button_down
2146  06cf 4d            	tnz	a
2147  06d0 2704          	jreq	L661
2148  06d2 a6ff          	ld	a,#255
2149  06d4 2001          	jra	L071
2150  06d6               L661:
2151  06d6 4f            	clr	a
2152  06d7               L071:
2153  06d7 ae0200        	ldw	x,#512
2154  06da 97            	ld	xl,a
2155  06db cd0000        	call	_set_white
2157                     ; 254 	set_white(3,get_button_event(0,0,0)?0xFF:0);
2159  06de 4b00          	push	#0
2160  06e0 5f            	clrw	x
2161  06e1 cd0000        	call	_get_button_event
2163  06e4 5b01          	addw	sp,#1
2164  06e6 4d            	tnz	a
2165  06e7 2704          	jreq	L271
2166  06e9 a6ff          	ld	a,#255
2167  06eb 2001          	jra	L471
2168  06ed               L271:
2169  06ed 4f            	clr	a
2170  06ee               L471:
2171  06ee ae0300        	ldw	x,#768
2172  06f1 97            	ld	xl,a
2173  06f2 cd0000        	call	_set_white
2175                     ; 255 	set_white(4,get_button_event(0,1,0)?0xFF:0);
2177  06f5 4b00          	push	#0
2178  06f7 ae0001        	ldw	x,#1
2179  06fa cd0000        	call	_get_button_event
2181  06fd 5b01          	addw	sp,#1
2182  06ff 4d            	tnz	a
2183  0700 2704          	jreq	L671
2184  0702 a6ff          	ld	a,#255
2185  0704 2001          	jra	L002
2186  0706               L671:
2187  0706 4f            	clr	a
2188  0707               L002:
2189  0707 ae0400        	ldw	x,#1024
2190  070a 97            	ld	xl,a
2191  070b cd0000        	call	_set_white
2193                     ; 256 	set_white(5,get_button_event(1,0,0)?0xFF:0);
2195  070e 4b00          	push	#0
2196  0710 ae0100        	ldw	x,#256
2197  0713 cd0000        	call	_get_button_event
2199  0716 5b01          	addw	sp,#1
2200  0718 4d            	tnz	a
2201  0719 2704          	jreq	L202
2202  071b a6ff          	ld	a,#255
2203  071d 2001          	jra	L402
2204  071f               L202:
2205  071f 4f            	clr	a
2206  0720               L402:
2207  0720 ae0500        	ldw	x,#1280
2208  0723 97            	ld	xl,a
2209  0724 cd0000        	call	_set_white
2211                     ; 257 	set_white(6,get_button_event(1,1,0)?0xFF:0);
2213  0727 4b00          	push	#0
2214  0729 ae0101        	ldw	x,#257
2215  072c cd0000        	call	_get_button_event
2217  072f 5b01          	addw	sp,#1
2218  0731 4d            	tnz	a
2219  0732 2704          	jreq	L602
2220  0734 a6ff          	ld	a,#255
2221  0736 2001          	jra	L012
2222  0738               L602:
2223  0738 4f            	clr	a
2224  0739               L012:
2225  0739 ae0600        	ldw	x,#1536
2226  073c 97            	ld	xl,a
2227  073d cd0000        	call	_set_white
2229                     ; 258 	return 7;
2231  0740 a607          	ld	a,#7
2234  0742 81            	ret
2247                     	xdef	_set_debug_buttons
2248                     	xdef	_set_element_hue
2249                     	xdef	_show_screensaver
2250                     	xdef	_set_white_test
2251                     	xdef	_set_sparkles
2252                     	xdef	_set_frame_rainbow
2253                     	xdef	_run_application
2254                     	xdef	_setup_application
2255                     	xref	_get_random
2256                     	xref	_is_button_down
2257                     	xref	_get_button_event
2258                     	xref	_set_hue_max
2259                     	xref	_flush_leds
2260                     	xref	_set_white
2261                     	xref	_set_rgb
2262                     	xref	_millis
2263                     	xref	_is_application_valid
2264                     	xref	_setup_serial
2265                     	xref.b	c_lreg
2266                     	xref.b	c_x
2285                     	xref	c_uitolx
2286                     	xref	c_llsh
2287                     	xref	c_lumd
2288                     	xref	c_ladd
2289                     	xref	c_itolx
2290                     	xref	c_ladc
2291                     	xref	c_lrzmp
2292                     	xref	c_smodx
2293                     	xref	c_lcmp
2294                     	xref	c_lursh
2295                     	xref	c_ltor
2296                     	xref	c_lsub
2297                     	xref	c_rtol
2298                     	end
