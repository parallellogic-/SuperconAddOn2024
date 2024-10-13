   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
 199                     ; 7 void run_application()
 199                     ; 8 {
 201                     	switch	.text
 202  0000               _run_application:
 204  0000 521b          	subw	sp,#27
 205       0000001b      OFST:	set	27
 208                     ; 9 	u8 new_game_state=0,old_game_state=255;
 210  0002 0f1a          	clr	(OFST-1,sp)
 214  0004 a6ff          	ld	a,#255
 215  0006 6b09          	ld	(OFST-18,sp),a
 217                     ; 11 	bool is_new_state=1;
 219                     ; 14 	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
 221                     ; 22 	setup_serial(0,0);
 223  0008 5f            	clrw	x
 224  0009 cd0000        	call	_setup_serial
 226                     ; 23 	get_button_event(0xFF,0xFF,1);//clear_button_events();
 228  000c 4b01          	push	#1
 229  000e aeffff        	ldw	x,#65535
 230  0011 cd0000        	call	_get_button_event
 232  0014 84            	pop	a
 234  0015 acf603f6      	jpf	L141
 235  0019               L731:
 236                     ; 26 		effective_led_count=1;//default empty list
 238  0019 a601          	ld	a,#1
 239  001b 6b0c          	ld	(OFST-15,sp),a
 241                     ; 27 		is_new_state=0;//flag to signify a new state has been entered
 243  001d 0f1b          	clr	(OFST+0,sp)
 245                     ; 28 		if(new_game_state!=old_game_state)
 247  001f 7b1a          	ld	a,(OFST-1,sp)
 248  0021 1109          	cp	a,(OFST-18,sp)
 249  0023 2712          	jreq	L541
 250                     ; 30 			is_new_state=1;
 252  0025 a601          	ld	a,#1
 253  0027 6b1b          	ld	(OFST+0,sp),a
 255                     ; 31 			game_state_start_ms=millis();
 257  0029 cd0000        	call	_millis
 259  002c 96            	ldw	x,sp
 260  002d 1c0005        	addw	x,#OFST-22
 261  0030 cd0000        	call	c_rtol
 264                     ; 32 			old_game_state=new_game_state;
 266  0033 7b1a          	ld	a,(OFST-1,sp)
 267  0035 6b09          	ld	(OFST-18,sp),a
 269  0037               L541:
 270                     ; 34 		game_state_elapsed_ms=millis()-game_state_start_ms;
 272  0037 cd0000        	call	_millis
 274  003a 96            	ldw	x,sp
 275  003b 1c0005        	addw	x,#OFST-22
 276  003e cd0000        	call	c_lsub
 278  0041 96            	ldw	x,sp
 279  0042 1c000e        	addw	x,#OFST-13
 280  0045 cd0000        	call	c_rtol
 283                     ; 39 		switch(new_game_state)
 285  0048 7b1a          	ld	a,(OFST-1,sp)
 287                     ; 166 			}break;
 288  004a 4d            	tnz	a
 289  004b 272e          	jreq	L3
 290  004d 4a            	dec	a
 291  004e 2603          	jrne	L44
 292  0050 cc0128        	jp	L5
 293  0053               L44:
 294  0053 4a            	dec	a
 295  0054 2603          	jrne	L64
 296  0056 cc019a        	jp	L7
 297  0059               L64:
 298  0059 4a            	dec	a
 299  005a 2603          	jrne	L05
 300  005c cc026a        	jp	L11
 301  005f               L05:
 302  005f 4a            	dec	a
 303  0060 2603          	jrne	L25
 304  0062 cc029d        	jp	L31
 305  0065               L25:
 306  0065 4a            	dec	a
 307  0066 2603          	jrne	L45
 308  0068 cc02d4        	jp	L51
 309  006b               L45:
 310  006b 4a            	dec	a
 311  006c 2603          	jrne	L65
 312  006e cc0306        	jp	L71
 313  0071               L65:
 314  0071 4a            	dec	a
 315  0072 2603          	jrne	L06
 316  0074 cc037c        	jp	L12
 317  0077               L06:
 318  0077 acf103f1      	jpf	L151
 319  007b               L3:
 320                     ; 42 				game_level=0;//restart game
 322  007b 0f0b          	clr	(OFST-16,sp)
 324                     ; 43 				effective_led_count=set_sparkles(0);
 326  007d 4f            	clr	a
 327  007e cd0500        	call	_set_sparkles
 329  0081 6b0c          	ld	(OFST-15,sp),a
 331                     ; 44 				if(get_button_event(0xFF,0,1))
 333  0083 4b01          	push	#1
 334  0085 aeff00        	ldw	x,#65280
 335  0088 cd0000        	call	_get_button_event
 337  008b 5b01          	addw	sp,#1
 338  008d 4d            	tnz	a
 339  008e 2602          	jrne	L26
 340  0090 207e          	jp	L351
 341  0092               L26:
 342                     ; 47 					new_game_state=1;
 344  0092 a601          	ld	a,#1
 345  0094 6b1a          	ld	(OFST-1,sp),a
 347  0096               L551:
 348                     ; 49 						for(iter=0;iter<RGB_LED_COUNT;iter++) target_pattern[iter]=0;//clear initial state for repeat play
 350  0096 0f1b          	clr	(OFST+0,sp)
 352  0098               L361:
 355  0098 96            	ldw	x,sp
 356  0099 1c0014        	addw	x,#OFST-7
 357  009c 9f            	ld	a,xl
 358  009d 5e            	swapw	x
 359  009e 1b1b          	add	a,(OFST+0,sp)
 360  00a0 2401          	jrnc	L6
 361  00a2 5c            	incw	x
 362  00a3               L6:
 363  00a3 02            	rlwa	x,a
 364  00a4 7f            	clr	(x)
 367  00a5 0c1b          	inc	(OFST+0,sp)
 371  00a7 7b1b          	ld	a,(OFST+0,sp)
 372  00a9 a106          	cp	a,#6
 373  00ab 25eb          	jrult	L361
 374                     ; 50 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 376  00ad a601          	ld	a,#1
 377  00af 6b1b          	ld	(OFST+0,sp),a
 379  00b1               L171:
 380                     ; 52 							is_target_element_placed=0;
 382  00b1 0f0d          	clr	(OFST-14,sp)
 384  00b3               L771:
 385                     ; 55 								level_fractional_progress=get_random(millis()-iter)%RGB_LED_COUNT;//using time to resolve infinite loop instability :/
 387  00b3 7b1b          	ld	a,(OFST+0,sp)
 388  00b5 b703          	ld	c_lreg+3,a
 389  00b7 3f02          	clr	c_lreg+2
 390  00b9 3f01          	clr	c_lreg+1
 391  00bb 3f00          	clr	c_lreg
 392  00bd 96            	ldw	x,sp
 393  00be 1c0001        	addw	x,#OFST-26
 394  00c1 cd0000        	call	c_rtol
 397  00c4 cd0000        	call	_millis
 399  00c7 96            	ldw	x,sp
 400  00c8 1c0001        	addw	x,#OFST-26
 401  00cb cd0000        	call	c_lsub
 403  00ce be02          	ldw	x,c_lreg+2
 404  00d0 cd0000        	call	_get_random
 406  00d3 a606          	ld	a,#6
 407  00d5 62            	div	x,a
 408  00d6 5f            	clrw	x
 409  00d7 97            	ld	xl,a
 410  00d8 01            	rrwa	x,a
 411  00d9 6b13          	ld	(OFST-8,sp),a
 412  00db 02            	rlwa	x,a
 414                     ; 56 								if(target_pattern[level_fractional_progress]==0)
 416  00dc 96            	ldw	x,sp
 417  00dd 1c0014        	addw	x,#OFST-7
 418  00e0 9f            	ld	a,xl
 419  00e1 5e            	swapw	x
 420  00e2 1b13          	add	a,(OFST-8,sp)
 421  00e4 2401          	jrnc	L01
 422  00e6 5c            	incw	x
 423  00e7               L01:
 424  00e7 02            	rlwa	x,a
 425  00e8 7d            	tnz	(x)
 426  00e9 2613          	jrne	L502
 427                     ; 58 									is_target_element_placed=1;
 429  00eb a601          	ld	a,#1
 430  00ed 6b0d          	ld	(OFST-14,sp),a
 432                     ; 59 									target_pattern[level_fractional_progress]=iter;
 434  00ef 96            	ldw	x,sp
 435  00f0 1c0014        	addw	x,#OFST-7
 436  00f3 9f            	ld	a,xl
 437  00f4 5e            	swapw	x
 438  00f5 1b13          	add	a,(OFST-8,sp)
 439  00f7 2401          	jrnc	L21
 440  00f9 5c            	incw	x
 441  00fa               L21:
 442  00fa 02            	rlwa	x,a
 443  00fb 7b1b          	ld	a,(OFST+0,sp)
 444  00fd f7            	ld	(x),a
 445  00fe               L502:
 446                     ; 53 							while(!is_target_element_placed)//beware infinite loop...
 448  00fe 0d0d          	tnz	(OFST-14,sp)
 449  0100 27b1          	jreq	L771
 450                     ; 50 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 452  0102 0c1b          	inc	(OFST+0,sp)
 456  0104 7b1b          	ld	a,(OFST+0,sp)
 457  0106 a106          	cp	a,#6
 458  0108 25a7          	jrult	L171
 459                     ; 64 					}while(target_pattern[0]==0);//avoid case where first goal is at the start, confusing the user about how the device operates
 461  010a 0d14          	tnz	(OFST-7,sp)
 462  010c 2602          	jrne	L46
 463  010e 2086          	jp	L551
 464  0110               L46:
 465  0110               L351:
 466                     ; 66 				if(get_button_event(0xFF,1,1)) new_game_state=6;//start cyclone game by long pressing the buttons
 468  0110 4b01          	push	#1
 469  0112 aeff01        	ldw	x,#65281
 470  0115 cd0000        	call	_get_button_event
 472  0118 5b01          	addw	sp,#1
 473  011a 4d            	tnz	a
 474  011b 2603          	jrne	L66
 475  011d cc03f1        	jp	L151
 476  0120               L66:
 479  0120 a606          	ld	a,#6
 480  0122 6b1a          	ld	(OFST-1,sp),a
 482  0124 acf103f1      	jpf	L151
 483  0128               L5:
 484                     ; 70 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 486  0128 0f1b          	clr	(OFST+0,sp)
 488  012a               L112:
 489                     ; 72 					if(target_pattern[iter]<=(u8)(game_state_elapsed_ms>>9) && target_pattern[iter]<=game_level)
 491  012a 96            	ldw	x,sp
 492  012b 1c000e        	addw	x,#OFST-13
 493  012e cd0000        	call	c_ltor
 495  0131 a609          	ld	a,#9
 496  0133 cd0000        	call	c_lursh
 498  0136 b603          	ld	a,c_lreg+3
 499  0138 6b04          	ld	(OFST-23,sp),a
 501  013a 96            	ldw	x,sp
 502  013b 1c0014        	addw	x,#OFST-7
 503  013e 9f            	ld	a,xl
 504  013f 5e            	swapw	x
 505  0140 1b1b          	add	a,(OFST+0,sp)
 506  0142 2401          	jrnc	L41
 507  0144 5c            	incw	x
 508  0145               L41:
 509  0145 02            	rlwa	x,a
 510  0146 f6            	ld	a,(x)
 511  0147 1104          	cp	a,(OFST-23,sp)
 512  0149 221a          	jrugt	L712
 514  014b 96            	ldw	x,sp
 515  014c 1c0014        	addw	x,#OFST-7
 516  014f 9f            	ld	a,xl
 517  0150 5e            	swapw	x
 518  0151 1b1b          	add	a,(OFST+0,sp)
 519  0153 2401          	jrnc	L61
 520  0155 5c            	incw	x
 521  0156               L61:
 522  0156 02            	rlwa	x,a
 523  0157 f6            	ld	a,(x)
 524  0158 110b          	cp	a,(OFST-16,sp)
 525  015a 2209          	jrugt	L712
 526                     ; 74 						set_element_hue(iter,iter);
 528  015c 7b1b          	ld	a,(OFST+0,sp)
 529  015e 97            	ld	xl,a
 530  015f 7b1b          	ld	a,(OFST+0,sp)
 531  0161 95            	ld	xh,a
 532  0162 cd0402        	call	_set_element_hue
 534  0165               L712:
 535                     ; 70 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 537  0165 0c1b          	inc	(OFST+0,sp)
 541  0167 7b1b          	ld	a,(OFST+0,sp)
 542  0169 a106          	cp	a,#6
 543  016b 25bd          	jrult	L112
 544                     ; 77 				effective_led_count=6;
 546  016d a606          	ld	a,#6
 547  016f 6b0c          	ld	(OFST-15,sp),a
 549                     ; 79 				if(get_button_event(0xFF,0,1)) new_game_state=2;
 551  0171 4b01          	push	#1
 552  0173 aeff00        	ldw	x,#65280
 553  0176 cd0000        	call	_get_button_event
 555  0179 5b01          	addw	sp,#1
 556  017b 4d            	tnz	a
 557  017c 2704          	jreq	L122
 560  017e a602          	ld	a,#2
 561  0180 6b1a          	ld	(OFST-1,sp),a
 563  0182               L122:
 564                     ; 80 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 566  0182 4b01          	push	#1
 567  0184 aeff01        	ldw	x,#65281
 568  0187 cd0000        	call	_get_button_event
 570  018a 5b01          	addw	sp,#1
 571  018c 4d            	tnz	a
 572  018d 2603          	jrne	L07
 573  018f cc03f1        	jp	L151
 574  0192               L07:
 577  0192 a606          	ld	a,#6
 578  0194 6b1a          	ld	(OFST-1,sp),a
 580  0196 acf103f1      	jpf	L151
 581  019a               L7:
 582                     ; 83 				if(is_new_state)
 584  019a 0d1b          	tnz	(OFST+0,sp)
 585  019c 2704          	jreq	L522
 586                     ; 85 					cursor=0;
 588  019e 0f12          	clr	(OFST-9,sp)
 590                     ; 86 					level_fractional_progress=0;
 592  01a0 0f13          	clr	(OFST-8,sp)
 594  01a2               L522:
 595                     ; 88 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 597  01a2 0f1b          	clr	(OFST+0,sp)
 599  01a4               L722:
 600                     ; 90 					if(target_pattern[iter]<level_fractional_progress)
 602  01a4 96            	ldw	x,sp
 603  01a5 1c0014        	addw	x,#OFST-7
 604  01a8 9f            	ld	a,xl
 605  01a9 5e            	swapw	x
 606  01aa 1b1b          	add	a,(OFST+0,sp)
 607  01ac 2401          	jrnc	L02
 608  01ae 5c            	incw	x
 609  01af               L02:
 610  01af 02            	rlwa	x,a
 611  01b0 f6            	ld	a,(x)
 612  01b1 1113          	cp	a,(OFST-8,sp)
 613  01b3 2409          	jruge	L532
 614                     ; 92 						set_element_hue(iter,iter);
 616  01b5 7b1b          	ld	a,(OFST+0,sp)
 617  01b7 97            	ld	xl,a
 618  01b8 7b1b          	ld	a,(OFST+0,sp)
 619  01ba 95            	ld	xh,a
 620  01bb cd0402        	call	_set_element_hue
 622  01be               L532:
 623                     ; 88 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 625  01be 0c1b          	inc	(OFST+0,sp)
 629  01c0 7b1b          	ld	a,(OFST+0,sp)
 630  01c2 a106          	cp	a,#6
 631  01c4 25de          	jrult	L722
 632                     ; 95 				if(game_state_elapsed_ms&0x0100) set_element_hue(cursor,cursor);
 634  01c6 7b10          	ld	a,(OFST-11,sp)
 635  01c8 a501          	bcp	a,#1
 636  01ca 2709          	jreq	L732
 639  01cc 7b12          	ld	a,(OFST-9,sp)
 640  01ce 97            	ld	xl,a
 641  01cf 7b12          	ld	a,(OFST-9,sp)
 642  01d1 95            	ld	xh,a
 643  01d2 cd0402        	call	_set_element_hue
 645  01d5               L732:
 646                     ; 96 				if(get_button_event(1,0,1) || target_pattern[cursor]<level_fractional_progress)
 648  01d5 4b01          	push	#1
 649  01d7 ae0100        	ldw	x,#256
 650  01da cd0000        	call	_get_button_event
 652  01dd 5b01          	addw	sp,#1
 653  01df 4d            	tnz	a
 654  01e0 2611          	jrne	L542
 656  01e2 96            	ldw	x,sp
 657  01e3 1c0014        	addw	x,#OFST-7
 658  01e6 9f            	ld	a,xl
 659  01e7 5e            	swapw	x
 660  01e8 1b12          	add	a,(OFST-9,sp)
 661  01ea 2401          	jrnc	L22
 662  01ec 5c            	incw	x
 663  01ed               L22:
 664  01ed 02            	rlwa	x,a
 665  01ee f6            	ld	a,(x)
 666  01ef 1113          	cp	a,(OFST-8,sp)
 667  01f1 241f          	jruge	L142
 668  01f3               L542:
 669                     ; 99 						cursor=(cursor+1)%RGB_LED_COUNT;
 671  01f3 7b12          	ld	a,(OFST-9,sp)
 672  01f5 5f            	clrw	x
 673  01f6 97            	ld	xl,a
 674  01f7 5c            	incw	x
 675  01f8 a606          	ld	a,#6
 676  01fa cd0000        	call	c_smodx
 678  01fd 01            	rrwa	x,a
 679  01fe 6b12          	ld	(OFST-9,sp),a
 680  0200 02            	rlwa	x,a
 682                     ; 100 					}while(target_pattern[cursor]<level_fractional_progress);//skip over indexes that have already been selected
 684  0201 96            	ldw	x,sp
 685  0202 1c0014        	addw	x,#OFST-7
 686  0205 9f            	ld	a,xl
 687  0206 5e            	swapw	x
 688  0207 1b12          	add	a,(OFST-9,sp)
 689  0209 2401          	jrnc	L42
 690  020b 5c            	incw	x
 691  020c               L42:
 692  020c 02            	rlwa	x,a
 693  020d f6            	ld	a,(x)
 694  020e 1113          	cp	a,(OFST-8,sp)
 695  0210 25e1          	jrult	L542
 696  0212               L142:
 697                     ; 102 				if(get_button_event(0,0,1))
 699  0212 4b01          	push	#1
 700  0214 5f            	clrw	x
 701  0215 cd0000        	call	_get_button_event
 703  0218 5b01          	addw	sp,#1
 704  021a 4d            	tnz	a
 705  021b 2731          	jreq	L352
 706                     ; 104 					if(target_pattern[cursor]==level_fractional_progress)//correctly selected the proper led
 708  021d 96            	ldw	x,sp
 709  021e 1c0014        	addw	x,#OFST-7
 710  0221 9f            	ld	a,xl
 711  0222 5e            	swapw	x
 712  0223 1b12          	add	a,(OFST-9,sp)
 713  0225 2401          	jrnc	L62
 714  0227 5c            	incw	x
 715  0228               L62:
 716  0228 02            	rlwa	x,a
 717  0229 f6            	ld	a,(x)
 718  022a 1113          	cp	a,(OFST-8,sp)
 719  022c 261c          	jrne	L552
 720                     ; 106 						level_fractional_progress++;
 722  022e 0c13          	inc	(OFST-8,sp)
 724                     ; 107 						if(level_fractional_progress>=RGB_LED_COUNT) new_game_state=5;//full win
 726  0230 7b13          	ld	a,(OFST-8,sp)
 727  0232 a106          	cp	a,#6
 728  0234 2506          	jrult	L752
 731  0236 a605          	ld	a,#5
 732  0238 6b1a          	ld	(OFST-1,sp),a
 735  023a 2012          	jra	L352
 736  023c               L752:
 737                     ; 108 						else if(level_fractional_progress>game_level){ new_game_state=4; game_level++; }//level win
 739  023c 7b13          	ld	a,(OFST-8,sp)
 740  023e 110b          	cp	a,(OFST-16,sp)
 741  0240 230c          	jrule	L352
 744  0242 a604          	ld	a,#4
 745  0244 6b1a          	ld	(OFST-1,sp),a
 749  0246 0c0b          	inc	(OFST-16,sp)
 751  0248 2004          	jra	L352
 752  024a               L552:
 753                     ; 110 						new_game_state=3;//lose
 755  024a a603          	ld	a,#3
 756  024c 6b1a          	ld	(OFST-1,sp),a
 758  024e               L352:
 759                     ; 113 				effective_led_count=RGB_LED_COUNT;
 761  024e a606          	ld	a,#6
 762  0250 6b0c          	ld	(OFST-15,sp),a
 764                     ; 114 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 766  0252 4b01          	push	#1
 767  0254 aeff01        	ldw	x,#65281
 768  0257 cd0000        	call	_get_button_event
 770  025a 5b01          	addw	sp,#1
 771  025c 4d            	tnz	a
 772  025d 2603          	jrne	L27
 773  025f cc03f1        	jp	L151
 774  0262               L27:
 777  0262 a606          	ld	a,#6
 778  0264 6b1a          	ld	(OFST-1,sp),a
 780  0266 acf103f1      	jpf	L151
 781  026a               L11:
 782                     ; 117 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1); new_game_state=0; }//restart game after timeout, and clear any button pushes registered during lose
 784  026a 7b10          	ld	a,(OFST-11,sp)
 785  026c a504          	bcp	a,#4
 786  026e 270b          	jreq	L172
 789  0270 4b01          	push	#1
 790  0272 aeffff        	ldw	x,#65535
 791  0275 cd0000        	call	_get_button_event
 793  0278 84            	pop	a
 796  0279 0f1a          	clr	(OFST-1,sp)
 798  027b               L172:
 799                     ; 118 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,0,255);//flash red LEDs
 801  027b 7b11          	ld	a,(OFST-10,sp)
 802  027d a580          	bcp	a,#128
 803  027f 2714          	jreq	L372
 806  0281 0f1b          	clr	(OFST+0,sp)
 808  0283               L572:
 811  0283 4bff          	push	#255
 812  0285 7b1c          	ld	a,(OFST+1,sp)
 813  0287 5f            	clrw	x
 814  0288 95            	ld	xh,a
 815  0289 cd0000        	call	_set_rgb
 817  028c 84            	pop	a
 820  028d 0c1b          	inc	(OFST+0,sp)
 824  028f 7b1b          	ld	a,(OFST+0,sp)
 825  0291 a106          	cp	a,#6
 826  0293 25ee          	jrult	L572
 827  0295               L372:
 828                     ; 119 				effective_led_count=RGB_LED_COUNT;
 830  0295 a606          	ld	a,#6
 831  0297 6b0c          	ld	(OFST-15,sp),a
 833                     ; 120 			}break;
 835  0299 acf103f1      	jpf	L151
 836  029d               L31:
 837                     ; 122 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1);  new_game_state=1; }//go to next level, clear any button pushse during transition
 839  029d 7b10          	ld	a,(OFST-11,sp)
 840  029f a504          	bcp	a,#4
 841  02a1 270d          	jreq	L303
 844  02a3 4b01          	push	#1
 845  02a5 aeffff        	ldw	x,#65535
 846  02a8 cd0000        	call	_get_button_event
 848  02ab 84            	pop	a
 851  02ac a601          	ld	a,#1
 852  02ae 6b1a          	ld	(OFST-1,sp),a
 854  02b0               L303:
 855                     ; 123 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,1,255);//flash green LEDs
 857  02b0 7b11          	ld	a,(OFST-10,sp)
 858  02b2 a580          	bcp	a,#128
 859  02b4 2716          	jreq	L503
 862  02b6 0f1b          	clr	(OFST+0,sp)
 864  02b8               L703:
 867  02b8 4bff          	push	#255
 868  02ba 7b1c          	ld	a,(OFST+1,sp)
 869  02bc ae0001        	ldw	x,#1
 870  02bf 95            	ld	xh,a
 871  02c0 cd0000        	call	_set_rgb
 873  02c3 84            	pop	a
 876  02c4 0c1b          	inc	(OFST+0,sp)
 880  02c6 7b1b          	ld	a,(OFST+0,sp)
 881  02c8 a106          	cp	a,#6
 882  02ca 25ec          	jrult	L703
 883  02cc               L503:
 884                     ; 124 				effective_led_count=RGB_LED_COUNT;
 886  02cc a606          	ld	a,#6
 887  02ce 6b0c          	ld	(OFST-15,sp),a
 889                     ; 125 			}break;
 891  02d0 acf103f1      	jpf	L151
 892  02d4               L51:
 893                     ; 127 				if(is_new_state) submenu_index=0;
 895  02d4 0d1b          	tnz	(OFST+0,sp)
 896  02d6 2702          	jreq	L513
 899  02d8 0f0a          	clr	(OFST-17,sp)
 901  02da               L513:
 902                     ; 128 				effective_led_count=show_screensaver(submenu_index);
 904  02da 7b0a          	ld	a,(OFST-17,sp)
 905  02dc cd0464        	call	_show_screensaver
 907  02df 6b0c          	ld	(OFST-15,sp),a
 909                     ; 129 				if(get_button_event(0xFF,0,1)) submenu_index++;//allow user to cycle through winning screensavers
 911  02e1 4b01          	push	#1
 912  02e3 aeff00        	ldw	x,#65280
 913  02e6 cd0000        	call	_get_button_event
 915  02e9 5b01          	addw	sp,#1
 916  02eb 4d            	tnz	a
 917  02ec 2702          	jreq	L713
 920  02ee 0c0a          	inc	(OFST-17,sp)
 922  02f0               L713:
 923                     ; 130 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press to get back to idle screen
 925  02f0 4b01          	push	#1
 926  02f2 aeff01        	ldw	x,#65281
 927  02f5 cd0000        	call	_get_button_event
 929  02f8 5b01          	addw	sp,#1
 930  02fa 4d            	tnz	a
 931  02fb 2603          	jrne	L47
 932  02fd cc03f1        	jp	L151
 933  0300               L47:
 936  0300 0f1a          	clr	(OFST-1,sp)
 938  0302 acf103f1      	jpf	L151
 939  0306               L71:
 940                     ; 133 				set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
 942  0306 ae0505        	ldw	x,#1285
 943  0309 cd0402        	call	_set_element_hue
 945                     ; 134 				cursor=(((u16)game_state_elapsed_ms>>8)+(game_level>1?(((u16)game_state_elapsed_ms+(2<<6))>>8):0)
 945                     ; 135 									 			  								     +(game_level>3?(((u16)game_state_elapsed_ms+(3<<6))>>8):0))%RGB_LED_COUNT;//player position
 947  030c 7b0b          	ld	a,(OFST-16,sp)
 948  030e a104          	cp	a,#4
 949  0310 2509          	jrult	L03
 950  0312 1e10          	ldw	x,(OFST-11,sp)
 951  0314 1c00c0        	addw	x,#192
 952  0317 4f            	clr	a
 953  0318 01            	rrwa	x,a
 954  0319 2001          	jra	L23
 955  031b               L03:
 956  031b 5f            	clrw	x
 957  031c               L23:
 958  031c 1f03          	ldw	(OFST-24,sp),x
 960  031e 7b0b          	ld	a,(OFST-16,sp)
 961  0320 a102          	cp	a,#2
 962  0322 2509          	jrult	L43
 963  0324 1e10          	ldw	x,(OFST-11,sp)
 964  0326 1c0080        	addw	x,#128
 965  0329 4f            	clr	a
 966  032a 01            	rrwa	x,a
 967  032b 2001          	jra	L63
 968  032d               L43:
 969  032d 5f            	clrw	x
 970  032e               L63:
 971  032e 1f01          	ldw	(OFST-26,sp),x
 973  0330 1e10          	ldw	x,(OFST-11,sp)
 974  0332 4f            	clr	a
 975  0333 01            	rrwa	x,a
 976  0334 72fb01        	addw	x,(OFST-26,sp)
 977  0337 72fb03        	addw	x,(OFST-24,sp)
 978  033a a606          	ld	a,#6
 979  033c 62            	div	x,a
 980  033d 5f            	clrw	x
 981  033e 97            	ld	xl,a
 982  033f 01            	rrwa	x,a
 983  0340 6b12          	ld	(OFST-9,sp),a
 984  0342 02            	rlwa	x,a
 986                     ; 136 				if(is_target_element_placed) cursor=RGB_LED_COUNT-cursor-1;//reverse direction
 988  0343 0d0d          	tnz	(OFST-14,sp)
 989  0345 2706          	jreq	L323
 992  0347 a605          	ld	a,#5
 993  0349 1012          	sub	a,(OFST-9,sp)
 994  034b 6b12          	ld	(OFST-9,sp),a
 996  034d               L323:
 997                     ; 137 				set_element_hue(cursor,game_level);
 999  034d 7b0b          	ld	a,(OFST-16,sp)
1000  034f 97            	ld	xl,a
1001  0350 7b12          	ld	a,(OFST-9,sp)
1002  0352 95            	ld	xh,a
1003  0353 cd0402        	call	_set_element_hue
1005                     ; 138 				if(get_button_event(0xFF,0,1)) new_game_state=7;//show user evaluation of performance
1007  0356 4b01          	push	#1
1008  0358 aeff00        	ldw	x,#65280
1009  035b cd0000        	call	_get_button_event
1011  035e 5b01          	addw	sp,#1
1012  0360 4d            	tnz	a
1013  0361 2704          	jreq	L523
1016  0363 a607          	ld	a,#7
1017  0365 6b1a          	ld	(OFST-1,sp),a
1019  0367               L523:
1020                     ; 139 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
1022  0367 4b01          	push	#1
1023  0369 aeff01        	ldw	x,#65281
1024  036c cd0000        	call	_get_button_event
1026  036f 5b01          	addw	sp,#1
1027  0371 4d            	tnz	a
1028  0372 2702          	jreq	L723
1031  0374 0f1a          	clr	(OFST-1,sp)
1033  0376               L723:
1034                     ; 140 				effective_led_count=2;
1036  0376 a602          	ld	a,#2
1037  0378 6b0c          	ld	(OFST-15,sp),a
1039                     ; 141 			}break;
1041  037a 2075          	jra	L151
1042  037c               L12:
1043                     ; 143 				if(get_button_event(0xFF,0,1))
1045  037c 4b01          	push	#1
1046  037e aeff00        	ldw	x,#65280
1047  0381 cd0000        	call	_get_button_event
1049  0384 5b01          	addw	sp,#1
1050  0386 4d            	tnz	a
1051  0387 2723          	jreq	L133
1052                     ; 145 					is_target_element_placed=!is_target_element_placed;//flip direction
1054  0389 0d0d          	tnz	(OFST-14,sp)
1055  038b 2604          	jrne	L04
1056  038d a601          	ld	a,#1
1057  038f 2001          	jra	L24
1058  0391               L04:
1059  0391 4f            	clr	a
1060  0392               L24:
1061  0392 6b0d          	ld	(OFST-14,sp),a
1063                     ; 146 					if(cursor==(RGB_LED_COUNT-1)) game_level++;
1065  0394 7b12          	ld	a,(OFST-9,sp)
1066  0396 a105          	cp	a,#5
1067  0398 2602          	jrne	L333
1070  039a 0c0b          	inc	(OFST-16,sp)
1072  039c               L333:
1073                     ; 147 					if(game_level==RGB_LED_COUNT) new_game_state=5;//win after all levels
1075  039c 7b0b          	ld	a,(OFST-16,sp)
1076  039e a106          	cp	a,#6
1077  03a0 2606          	jrne	L533
1080  03a2 a605          	ld	a,#5
1081  03a4 6b1a          	ld	(OFST-1,sp),a
1084  03a6 2004          	jra	L133
1085  03a8               L533:
1086                     ; 148 					else new_game_state=6; //go to next level, clear any button pushse during transition
1088  03a8 a606          	ld	a,#6
1089  03aa 6b1a          	ld	(OFST-1,sp),a
1091  03ac               L133:
1092                     ; 150 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
1094  03ac 4b01          	push	#1
1095  03ae aeff01        	ldw	x,#65281
1096  03b1 cd0000        	call	_get_button_event
1098  03b4 5b01          	addw	sp,#1
1099  03b6 4d            	tnz	a
1100  03b7 2702          	jreq	L143
1103  03b9 0f1a          	clr	(OFST-1,sp)
1105  03bb               L143:
1106                     ; 151 				if(game_state_elapsed_ms&0x80)
1108  03bb 7b11          	ld	a,(OFST-10,sp)
1109  03bd a580          	bcp	a,#128
1110  03bf 2715          	jreq	L343
1111                     ; 153 					set_element_hue(cursor,game_level);//cursor
1113  03c1 7b0b          	ld	a,(OFST-16,sp)
1114  03c3 97            	ld	xl,a
1115  03c4 7b12          	ld	a,(OFST-9,sp)
1116  03c6 95            	ld	xh,a
1117  03c7 ad39          	call	_set_element_hue
1119                     ; 154 					if(cursor!=(RGB_LED_COUNT-1)) set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);//goal post
1121  03c9 7b12          	ld	a,(OFST-9,sp)
1122  03cb a105          	cp	a,#5
1123  03cd 271e          	jreq	L743
1126  03cf ae0505        	ldw	x,#1285
1127  03d2 ad2e          	call	_set_element_hue
1129  03d4 2017          	jra	L743
1130  03d6               L343:
1131                     ; 156 					if(cursor==(RGB_LED_COUNT-1))
1133  03d6 7b12          	ld	a,(OFST-9,sp)
1134  03d8 a105          	cp	a,#5
1135  03da 260c          	jrne	L153
1136                     ; 158 						set_element_hue(RGB_LED_COUNT-2,RGB_LED_COUNT-1);
1138  03dc ae0405        	ldw	x,#1029
1139  03df ad21          	call	_set_element_hue
1141                     ; 159 						set_element_hue(0,RGB_LED_COUNT-1);
1143  03e1 ae0005        	ldw	x,#5
1144  03e4 ad1c          	call	_set_element_hue
1147  03e6 2005          	jra	L743
1148  03e8               L153:
1149                     ; 161 						set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
1151  03e8 ae0505        	ldw	x,#1285
1152  03eb ad15          	call	_set_element_hue
1154  03ed               L743:
1155                     ; 164 				effective_led_count=RGB_LED_COUNT;
1157                     ; 165 				effective_led_count=3;
1159  03ed a603          	ld	a,#3
1160  03ef 6b0c          	ld	(OFST-15,sp),a
1162                     ; 166 			}break;
1164  03f1               L151:
1165                     ; 168 		flush_leds(effective_led_count);
1167  03f1 7b0c          	ld	a,(OFST-15,sp)
1168  03f3 cd0000        	call	_flush_leds
1170  03f6               L141:
1171                     ; 24 	while(is_application_valid())
1173  03f6 cd0000        	call	_is_application_valid
1175  03f9 4d            	tnz	a
1176  03fa 2703          	jreq	L67
1177  03fc cc0019        	jp	L731
1178  03ff               L67:
1179                     ; 170 }
1182  03ff 5b1b          	addw	sp,#27
1183  0401 81            	ret
1237                     ; 172 void set_element_hue(u8 led_index,u8 color_index)
1237                     ; 173 {
1238                     	switch	.text
1239  0402               _set_element_hue:
1241  0402 89            	pushw	x
1242  0403 89            	pushw	x
1243       00000002      OFST:	set	2
1246                     ; 175 	switch(color_index){
1248  0404 9f            	ld	a,xl
1250                     ; 184 	  default: color=0xD555; break;//purple
1251  0405 4d            	tnz	a
1252  0406 2738          	jreq	L753
1253  0408 4a            	dec	a
1254  0409 273c          	jreq	L163
1255  040b 4a            	dec	a
1256  040c 2740          	jreq	L363
1257  040e 4a            	dec	a
1258  040f 2742          	jreq	L563
1259  0411 a002          	sub	a,#2
1260  0413 2707          	jreq	L553
1261  0415               L763:
1264  0415 aed555        	ldw	x,#54613
1265  0418 1f01          	ldw	(OFST-1,sp),x
1269  041a 203c          	jra	L124
1270  041c               L553:
1271                     ; 176 		case 5: set_rgb(led_index,0,146);//dirty white
1273  041c 4b92          	push	#146
1274  041e 7b04          	ld	a,(OFST+2,sp)
1275  0420 5f            	clrw	x
1276  0421 95            	ld	xh,a
1277  0422 cd0000        	call	_set_rgb
1279  0425 84            	pop	a
1280                     ; 177 						set_rgb(led_index,1,146);//146**2 *3 = 255**2
1282  0426 4b92          	push	#146
1283  0428 7b04          	ld	a,(OFST+2,sp)
1284  042a ae0001        	ldw	x,#1
1285  042d 95            	ld	xh,a
1286  042e cd0000        	call	_set_rgb
1288  0431 84            	pop	a
1289                     ; 178 						set_rgb(led_index,2,146);
1291  0432 4b92          	push	#146
1292  0434 7b04          	ld	a,(OFST+2,sp)
1293  0436 ae0002        	ldw	x,#2
1294  0439 95            	ld	xh,a
1295  043a cd0000        	call	_set_rgb
1297  043d 84            	pop	a
1298                     ; 179 						return;
1300  043e 2021          	jra	L201
1301  0440               L753:
1302                     ; 180 		case 0: color=0x2AAA; break;//yellow 
1304  0440 ae2aaa        	ldw	x,#10922
1305  0443 1f01          	ldw	(OFST-1,sp),x
1309  0445 2011          	jra	L124
1310  0447               L163:
1311                     ; 181 		case 1: color=0x5555; break;//green
1313  0447 ae5555        	ldw	x,#21845
1314  044a 1f01          	ldw	(OFST-1,sp),x
1318  044c 200a          	jra	L124
1319  044e               L363:
1320                     ; 182 	  case 2: color=0x0; break;//red
1322  044e 5f            	clrw	x
1323  044f 1f01          	ldw	(OFST-1,sp),x
1327  0451 2005          	jra	L124
1328  0453               L563:
1329                     ; 183 	  case 3: color=0xAAAA; break;//blue
1331  0453 aeaaaa        	ldw	x,#43690
1332  0456 1f01          	ldw	(OFST-1,sp),x
1336  0458               L124:
1337                     ; 186 	set_hue_max(led_index,color);
1339  0458 1e01          	ldw	x,(OFST-1,sp)
1340  045a 89            	pushw	x
1341  045b 7b05          	ld	a,(OFST+3,sp)
1342  045d cd0000        	call	_set_hue_max
1344  0460 85            	popw	x
1345                     ; 187 }
1346  0461               L201:
1349  0461 5b04          	addw	sp,#4
1350  0463 81            	ret
1386                     ; 189 u8 show_screensaver(u8 screensaver_index)
1386                     ; 190 {
1387                     	switch	.text
1388  0464               _show_screensaver:
1390  0464 88            	push	a
1391       00000001      OFST:	set	1
1394                     ; 191 	switch(screensaver_index%SCREENSAVER_COUNT)
1396  0465 5f            	clrw	x
1397  0466 97            	ld	xl,a
1398  0467 a607          	ld	a,#7
1399  0469 cd0000        	call	c_smodx
1402                     ; 198 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1403  046c 5a            	decw	x
1404  046d 2711          	jreq	L324
1405  046f 5a            	decw	x
1406  0470 271b          	jreq	L524
1407  0472 5a            	decw	x
1408  0473 2726          	jreq	L724
1409  0475 5a            	decw	x
1410  0476 272a          	jreq	L134
1411  0478 5a            	decw	x
1412  0479 272e          	jreq	L334
1413  047b 5a            	decw	x
1414  047c 2739          	jreq	L534
1415  047e 2046          	jra	L754
1416  0480               L324:
1417                     ; 193 		case 1: return set_frame_rainbow(0)+set_sparkles(0);
1419  0480 4f            	clr	a
1420  0481 ad7d          	call	_set_sparkles
1422  0483 6b01          	ld	(OFST+0,sp),a
1424  0485 4f            	clr	a
1425  0486 ad44          	call	_set_frame_rainbow
1427  0488 1b01          	add	a,(OFST+0,sp)
1430  048a 5b01          	addw	sp,#1
1431  048c 81            	ret
1432  048d               L524:
1433                     ; 194 		case 2: return set_frame_rainbow(0)+set_sparkles(1);
1435  048d a601          	ld	a,#1
1436  048f ad6f          	call	_set_sparkles
1438  0491 6b01          	ld	(OFST+0,sp),a
1440  0493 4f            	clr	a
1441  0494 ad36          	call	_set_frame_rainbow
1443  0496 1b01          	add	a,(OFST+0,sp)
1446  0498 5b01          	addw	sp,#1
1447  049a 81            	ret
1448  049b               L724:
1449                     ; 195 		case 3: return set_sparkles(1);
1451  049b a601          	ld	a,#1
1452  049d ad61          	call	_set_sparkles
1456  049f 5b01          	addw	sp,#1
1457  04a1 81            	ret
1458  04a2               L134:
1459                     ; 196 		case 4: return set_frame_rainbow(1);
1461  04a2 a601          	ld	a,#1
1462  04a4 ad26          	call	_set_frame_rainbow
1466  04a6 5b01          	addw	sp,#1
1467  04a8 81            	ret
1468  04a9               L334:
1469                     ; 197 		case 5: return set_frame_rainbow(1)+set_sparkles(0);
1471  04a9 4f            	clr	a
1472  04aa ad54          	call	_set_sparkles
1474  04ac 6b01          	ld	(OFST+0,sp),a
1476  04ae a601          	ld	a,#1
1477  04b0 ad1a          	call	_set_frame_rainbow
1479  04b2 1b01          	add	a,(OFST+0,sp)
1482  04b4 5b01          	addw	sp,#1
1483  04b6 81            	ret
1484  04b7               L534:
1485                     ; 198 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1487  04b7 a601          	ld	a,#1
1488  04b9 ad45          	call	_set_sparkles
1490  04bb 6b01          	ld	(OFST+0,sp),a
1492  04bd a601          	ld	a,#1
1493  04bf ad0b          	call	_set_frame_rainbow
1495  04c1 1b01          	add	a,(OFST+0,sp)
1498  04c3 5b01          	addw	sp,#1
1499  04c5 81            	ret
1500  04c6               L754:
1501                     ; 200 	return set_frame_rainbow(0);
1503  04c6 4f            	clr	a
1504  04c7 ad03          	call	_set_frame_rainbow
1508  04c9 5b01          	addw	sp,#1
1509  04cb 81            	ret
1564                     ; 203 u8 set_frame_rainbow(bool is_circular)
1564                     ; 204 {
1565                     	switch	.text
1566  04cc               _set_frame_rainbow:
1568  04cc 88            	push	a
1569  04cd 5203          	subw	sp,#3
1570       00000003      OFST:	set	3
1573                     ; 206 	u16 offset=0;
1575  04cf 5f            	clrw	x
1576  04d0 1f01          	ldw	(OFST-2,sp),x
1578                     ; 207 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1580  04d2 0f03          	clr	(OFST+0,sp)
1582  04d4               L705:
1583                     ; 209 		set_hue_max(iter,(u16)(millis()<<5)+offset);
1585  04d4 cd0000        	call	_millis
1587  04d7 a605          	ld	a,#5
1588  04d9 cd0000        	call	c_llsh
1590  04dc be02          	ldw	x,c_lreg+2
1591  04de 72fb01        	addw	x,(OFST-2,sp)
1592  04e1 89            	pushw	x
1593  04e2 7b05          	ld	a,(OFST+2,sp)
1594  04e4 cd0000        	call	_set_hue_max
1596  04e7 85            	popw	x
1597                     ; 210 		if(is_circular) offset+=0x2AAB;
1599  04e8 0d04          	tnz	(OFST+1,sp)
1600  04ea 2707          	jreq	L515
1603  04ec 1e01          	ldw	x,(OFST-2,sp)
1604  04ee 1c2aab        	addw	x,#10923
1605  04f1 1f01          	ldw	(OFST-2,sp),x
1607  04f3               L515:
1608                     ; 207 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1610  04f3 0c03          	inc	(OFST+0,sp)
1614  04f5 7b03          	ld	a,(OFST+0,sp)
1615  04f7 a106          	cp	a,#6
1616  04f9 25d9          	jrult	L705
1617                     ; 212 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
1619  04fb a606          	ld	a,#6
1622  04fd 5b04          	addw	sp,#4
1623  04ff 81            	ret
1678                     ; 215 u8 set_sparkles(bool is_fireworks)
1678                     ; 216 {
1679                     	switch	.text
1680  0500               _set_sparkles:
1682  0500 88            	push	a
1683  0501 5207          	subw	sp,#7
1684       00000007      OFST:	set	7
1687                     ; 219 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1689  0503 0f05          	clr	(OFST-2,sp)
1691  0505               L545:
1692                     ; 222 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
1694  0505 cd0000        	call	_millis
1696  0508 96            	ldw	x,sp
1697  0509 1c0001        	addw	x,#OFST-6
1698  050c cd0000        	call	c_rtol
1701  050f 7b05          	ld	a,(OFST-2,sp)
1702  0511 5f            	clrw	x
1703  0512 97            	ld	xl,a
1704  0513 4f            	clr	a
1705  0514 02            	rlwa	x,a
1706  0515 58            	sllw	x
1707  0516 cd0000        	call	c_itolx
1709  0519 96            	ldw	x,sp
1710  051a 1c0001        	addw	x,#OFST-6
1711  051d cd0000        	call	c_ladd
1713  0520 be02          	ldw	x,c_lreg+2
1714  0522 1f06          	ldw	(OFST-1,sp),x
1716                     ; 223 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
1718  0524 cd0000        	call	_millis
1720  0527 7b05          	ld	a,(OFST-2,sp)
1721  0529 a403          	and	a,#3
1722  052b ab02          	add	a,#2
1723  052d cd0000        	call	c_lursh
1725  0530 96            	ldw	x,sp
1726  0531 1c0001        	addw	x,#OFST-6
1727  0534 cd0000        	call	c_rtol
1730  0537 1e06          	ldw	x,(OFST-1,sp)
1731  0539 cd0000        	call	c_uitolx
1733  053c 96            	ldw	x,sp
1734  053d 1c0001        	addw	x,#OFST-6
1735  0540 cd0000        	call	c_lsub
1737  0543 be02          	ldw	x,c_lreg+2
1738  0545 1f06          	ldw	(OFST-1,sp),x
1740                     ; 224 		state+=millis()>>(2+((iter>>2)&0x02));
1742  0547 cd0000        	call	_millis
1744  054a 7b05          	ld	a,(OFST-2,sp)
1745  054c 44            	srl	a
1746  054d 44            	srl	a
1747  054e a402          	and	a,#2
1748  0550 ab02          	add	a,#2
1749  0552 cd0000        	call	c_lursh
1751  0555 96            	ldw	x,sp
1752  0556 1c0001        	addw	x,#OFST-6
1753  0559 cd0000        	call	c_rtol
1756  055c 1e06          	ldw	x,(OFST-1,sp)
1757  055e cd0000        	call	c_uitolx
1759  0561 96            	ldw	x,sp
1760  0562 1c0001        	addw	x,#OFST-6
1761  0565 cd0000        	call	c_ladd
1763  0568 be02          	ldw	x,c_lreg+2
1764  056a 1f06          	ldw	(OFST-1,sp),x
1766                     ; 226 		if(!(state&(is_fireworks?0x0800:0x1800)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
1768  056c 0d08          	tnz	(OFST+1,sp)
1769  056e 2705          	jreq	L211
1770  0570 ae0800        	ldw	x,#2048
1771  0573 2003          	jra	L411
1772  0575               L211:
1773  0575 ae1800        	ldw	x,#6144
1774  0578               L411:
1775  0578 01            	rrwa	x,a
1776  0579 1407          	and	a,(OFST+0,sp)
1777  057b 01            	rrwa	x,a
1778  057c 1406          	and	a,(OFST-1,sp)
1779  057e 01            	rrwa	x,a
1780  057f a30000        	cpw	x,#0
1781  0582 2672          	jrne	L355
1782                     ; 229 			if(is_fireworks)
1784  0584 0d08          	tnz	(OFST+1,sp)
1785  0586 2741          	jreq	L555
1786                     ; 230 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
1788  0588 1e06          	ldw	x,(OFST-1,sp)
1789  058a 4f            	clr	a
1790  058b 01            	rrwa	x,a
1791  058c 54            	srlw	x
1792  058d 54            	srlw	x
1793  058e 01            	rrwa	x,a
1794  058f a501          	bcp	a,#1
1795  0591 270d          	jreq	L611
1796  0593 1e06          	ldw	x,(OFST-1,sp)
1797  0595 54            	srlw	x
1798  0596 54            	srlw	x
1799  0597 54            	srlw	x
1800  0598 53            	cplw	x
1801  0599 01            	rrwa	x,a
1802  059a a47f          	and	a,#127
1803  059c 5f            	clrw	x
1804  059d 02            	rlwa	x,a
1805  059e 201f          	jra	L021
1806  05a0               L611:
1807  05a0 1e06          	ldw	x,(OFST-1,sp)
1808  05a2 a606          	ld	a,#6
1809  05a4               L421:
1810  05a4 54            	srlw	x
1811  05a5 4a            	dec	a
1812  05a6 26fc          	jrne	L421
1813  05a8 01            	rrwa	x,a
1814  05a9 a40f          	and	a,#15
1815  05ab 5f            	clrw	x
1816  05ac 02            	rlwa	x,a
1817  05ad a3000f        	cpw	x,#15
1818  05b0 2604          	jrne	L221
1819  05b2 a6ff          	ld	a,#255
1820  05b4 2001          	jra	L621
1821  05b6               L221:
1822  05b6 4f            	clr	a
1823  05b7               L621:
1824  05b7 97            	ld	xl,a
1825  05b8 9f            	ld	a,xl
1826  05b9 5f            	clrw	x
1827  05ba 4d            	tnz	a
1828  05bb 2a01          	jrpl	L031
1829  05bd 53            	cplw	x
1830  05be               L031:
1831  05be 97            	ld	xl,a
1832  05bf               L021:
1833  05bf 9f            	ld	a,xl
1834  05c0 97            	ld	xl,a
1835  05c1 7b05          	ld	a,(OFST-2,sp)
1836  05c3 95            	ld	xh,a
1837  05c4 cd0000        	call	_set_white
1840  05c7 202d          	jra	L355
1841  05c9               L555:
1842                     ; 232 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
1844  05c9 1e06          	ldw	x,(OFST-1,sp)
1845  05cb 4f            	clr	a
1846  05cc 01            	rrwa	x,a
1847  05cd 54            	srlw	x
1848  05ce 54            	srlw	x
1849  05cf 01            	rrwa	x,a
1850  05d0 a501          	bcp	a,#1
1851  05d2 2707          	jreq	L231
1852  05d4 1e06          	ldw	x,(OFST-1,sp)
1853  05d6 54            	srlw	x
1854  05d7 54            	srlw	x
1855  05d8 53            	cplw	x
1856  05d9 2013          	jra	L431
1857  05db               L231:
1858  05db 1e06          	ldw	x,(OFST-1,sp)
1859  05dd 4f            	clr	a
1860  05de 01            	rrwa	x,a
1861  05df 01            	rrwa	x,a
1862  05e0 a503          	bcp	a,#3
1863  05e2 2704          	jreq	L631
1864  05e4 a6ff          	ld	a,#255
1865  05e6 2002          	jra	L041
1866  05e8               L631:
1867  05e8 7b07          	ld	a,(OFST+0,sp)
1868  05ea               L041:
1869  05ea 97            	ld	xl,a
1870  05eb 9f            	ld	a,xl
1871  05ec 5f            	clrw	x
1872  05ed 97            	ld	xl,a
1873  05ee               L431:
1874  05ee 9f            	ld	a,xl
1875  05ef 97            	ld	xl,a
1876  05f0 7b05          	ld	a,(OFST-2,sp)
1877  05f2 95            	ld	xh,a
1878  05f3 cd0000        	call	_set_white
1880  05f6               L355:
1881                     ; 219 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1883  05f6 0c05          	inc	(OFST-2,sp)
1887  05f8 7b05          	ld	a,(OFST-2,sp)
1888  05fa a10c          	cp	a,#12
1889  05fc 2403          	jruge	L241
1890  05fe cc0505        	jp	L545
1891  0601               L241:
1892                     ; 235 	return WHITE_LED_COUNT/4;
1894  0601 a603          	ld	a,#3
1897  0603 5b08          	addw	sp,#8
1898  0605 81            	ret
1911                     	xdef	_set_element_hue
1912                     	xdef	_show_screensaver
1913                     	xdef	_set_sparkles
1914                     	xdef	_set_frame_rainbow
1915                     	xdef	_run_application
1916                     	xref	_get_random
1917                     	xref	_get_button_event
1918                     	xref	_set_hue_max
1919                     	xref	_flush_leds
1920                     	xref	_set_white
1921                     	xref	_set_rgb
1922                     	xref	_millis
1923                     	xref	_is_application_valid
1924                     	xref	_setup_serial
1925                     	xref.b	c_lreg
1926                     	xref.b	c_x
1945                     	xref	c_uitolx
1946                     	xref	c_ladd
1947                     	xref	c_itolx
1948                     	xref	c_llsh
1949                     	xref	c_smodx
1950                     	xref	c_lursh
1951                     	xref	c_ltor
1952                     	xref	c_lsub
1953                     	xref	c_rtol
1954                     	end
