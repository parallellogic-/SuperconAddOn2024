   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
 202                     ; 7 void run_application()
 202                     ; 8 {
 204                     	switch	.text
 205  0000               _run_application:
 207  0000 521b          	subw	sp,#27
 208       0000001b      OFST:	set	27
 211                     ; 9 	u8 new_game_state=0,old_game_state=255;
 213  0002 0f1a          	clr	(OFST-1,sp)
 217  0004 a6ff          	ld	a,#255
 218  0006 6b09          	ld	(OFST-18,sp),a
 220                     ; 11 	bool is_new_state=1;
 222                     ; 14 	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
 224                     ; 22 	get_button_event(0xFF,0xFF,1);//clear_button_events();
 226  0008 cd034b        	call	LC010
 227  000b               L731:
 228                     ; 25 		effective_led_count=1;//default empty list
 230  000b a601          	ld	a,#1
 231  000d 6b0c          	ld	(OFST-15,sp),a
 233                     ; 26 		is_new_state=0;//flag to signify a new state has been entered
 235  000f 0f1b          	clr	(OFST+0,sp)
 237                     ; 27 		if(new_game_state!=old_game_state)
 239  0011 7b1a          	ld	a,(OFST-1,sp)
 240  0013 1109          	cp	a,(OFST-18,sp)
 241  0015 2712          	jreq	L341
 242                     ; 29 			is_new_state=1;
 244  0017 a601          	ld	a,#1
 245  0019 6b1b          	ld	(OFST+0,sp),a
 247                     ; 30 			game_state_start_ms=millis();
 249  001b cd0000        	call	_millis
 251  001e 96            	ldw	x,sp
 252  001f 1c0005        	addw	x,#OFST-22
 253  0022 cd0000        	call	c_rtol
 256                     ; 31 			old_game_state=new_game_state;
 258  0025 7b1a          	ld	a,(OFST-1,sp)
 259  0027 6b09          	ld	(OFST-18,sp),a
 261  0029               L341:
 262                     ; 33 		game_state_elapsed_ms=millis()-game_state_start_ms;
 264  0029 cd0000        	call	_millis
 266  002c 96            	ldw	x,sp
 267  002d 1c0005        	addw	x,#OFST-22
 268  0030 cd0000        	call	c_lsub
 270  0033 96            	ldw	x,sp
 271  0034 1c000e        	addw	x,#OFST-13
 272  0037 cd0000        	call	c_rtol
 275                     ; 38 		switch(new_game_state)
 277  003a 7b1a          	ld	a,(OFST-1,sp)
 279                     ; 165 			}break;
 280  003c 272d          	jreq	L3
 281  003e 4a            	dec	a
 282  003f 2603cc00f6    	jreq	L5
 283  0044 4a            	dec	a
 284  0045 2603cc014c    	jreq	L7
 285  004a 4a            	dec	a
 286  004b 2603cc01fe    	jreq	L11
 287  0050 4a            	dec	a
 288  0051 2603cc0223    	jreq	L31
 289  0056 4a            	dec	a
 290  0057 2603cc024f    	jreq	L51
 291  005c 4a            	dec	a
 292  005d 2603cc026d    	jreq	L71
 293  0062 4a            	dec	a
 294  0063 2603cc02ce    	jreq	L12
 295  0068 cc0325        	jra	L741
 296  006b               L3:
 297                     ; 41 				game_level=0;//restart game
 299  006b 6b0b          	ld	(OFST-16,sp),a
 301                     ; 42 				effective_led_count=set_sparkles(0);
 303  006d cd044d        	call	_set_sparkles
 305  0070 6b0c          	ld	(OFST-15,sp),a
 307                     ; 43 				if(get_button_event(0xFF,0,1))
 309  0072 cd0339        	call	LC008
 310  0075 2770          	jreq	L151
 311                     ; 46 					new_game_state=1;
 313  0077 a601          	ld	a,#1
 314  0079 6b1a          	ld	(OFST-1,sp),a
 316  007b               L351:
 317                     ; 48 						for(iter=0;iter<RGB_LED_COUNT;iter++) target_pattern[iter]=0;//clear initial state for repeat play
 319  007b 0f1b          	clr	(OFST+0,sp)
 321  007d               L161:
 324  007d 96            	ldw	x,sp
 325  007e cd0345        	call	LC009
 326  0081 1b1b          	add	a,(OFST+0,sp)
 327  0083 2401          	jrnc	L02
 328  0085 5c            	incw	x
 329  0086               L02:
 330  0086 02            	rlwa	x,a
 331  0087 7f            	clr	(x)
 334  0088 0c1b          	inc	(OFST+0,sp)
 338  008a 7b1b          	ld	a,(OFST+0,sp)
 339  008c a106          	cp	a,#6
 340  008e 25ed          	jrult	L161
 341                     ; 49 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 343  0090 a601          	ld	a,#1
 344  0092 6b1b          	ld	(OFST+0,sp),a
 346  0094               L761:
 347                     ; 51 							is_target_element_placed=0;
 349  0094 0f0d          	clr	(OFST-14,sp)
 351  0096               L571:
 352                     ; 54 								level_fractional_progress=get_random(millis()-iter)%RGB_LED_COUNT;//using time to resolve infinite loop instability :/
 354  0096 7b1b          	ld	a,(OFST+0,sp)
 355  0098 b703          	ld	c_lreg+3,a
 356  009a 3f02          	clr	c_lreg+2
 357  009c 3f01          	clr	c_lreg+1
 358  009e 3f00          	clr	c_lreg
 359  00a0 96            	ldw	x,sp
 360  00a1 5c            	incw	x
 361  00a2 cd0000        	call	c_rtol
 364  00a5 cd0000        	call	_millis
 366  00a8 96            	ldw	x,sp
 367  00a9 5c            	incw	x
 368  00aa cd0000        	call	c_lsub
 370  00ad be02          	ldw	x,c_lreg+2
 371  00af cd0000        	call	_get_random
 373  00b2 a606          	ld	a,#6
 374  00b4 62            	div	x,a
 375  00b5 5f            	clrw	x
 376  00b6 97            	ld	xl,a
 377  00b7 01            	rrwa	x,a
 378  00b8 6b13          	ld	(OFST-8,sp),a
 380                     ; 55 								if(target_pattern[level_fractional_progress]==0)
 382  00ba 96            	ldw	x,sp
 383  00bb cd0345        	call	LC009
 384  00be 1b13          	add	a,(OFST-8,sp)
 385  00c0 2401          	jrnc	L62
 386  00c2 5c            	incw	x
 387  00c3               L62:
 388  00c3 02            	rlwa	x,a
 389  00c4 f6            	ld	a,(x)
 390  00c5 2610          	jrne	L302
 391                     ; 57 									is_target_element_placed=1;
 393  00c7 4c            	inc	a
 394  00c8 6b0d          	ld	(OFST-14,sp),a
 396                     ; 58 									target_pattern[level_fractional_progress]=iter;
 398  00ca 96            	ldw	x,sp
 399  00cb cd0345        	call	LC009
 400  00ce 1b13          	add	a,(OFST-8,sp)
 401  00d0 2401          	jrnc	L03
 402  00d2 5c            	incw	x
 403  00d3               L03:
 404  00d3 02            	rlwa	x,a
 405  00d4 7b1b          	ld	a,(OFST+0,sp)
 406  00d6 f7            	ld	(x),a
 407  00d7               L302:
 408                     ; 52 							while(!is_target_element_placed)//beware infinite loop...
 410  00d7 7b0d          	ld	a,(OFST-14,sp)
 411  00d9 27bb          	jreq	L571
 412                     ; 49 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 414  00db 0c1b          	inc	(OFST+0,sp)
 418  00dd 7b1b          	ld	a,(OFST+0,sp)
 419  00df a106          	cp	a,#6
 420  00e1 25b1          	jrult	L761
 421                     ; 63 					}while(target_pattern[0]==0);//avoid case where first goal is at the start, confusing the user about how the device operates
 423  00e3 7b14          	ld	a,(OFST-7,sp)
 424  00e5 2794          	jreq	L351
 425  00e7               L151:
 426                     ; 65 				if(get_button_event(0xFF,1,1)) new_game_state=6;//start cyclone game by long pressing the buttons
 428  00e7 cd032d        	call	LC007
 429  00ea 2603cc0325    	jreq	L741
 432  00ef a606          	ld	a,#6
 433  00f1 6b1a          	ld	(OFST-1,sp),a
 435  00f3 cc0325        	jra	L741
 436  00f6               L5:
 437                     ; 69 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 439  00f6 6b1b          	ld	(OFST+0,sp),a
 441  00f8               L702:
 442                     ; 71 					if(target_pattern[iter]<=(u8)(game_state_elapsed_ms>>9) && target_pattern[iter]<=game_level)
 444  00f8 96            	ldw	x,sp
 445  00f9 1c000e        	addw	x,#OFST-13
 446  00fc cd0000        	call	c_ltor
 448  00ff a609          	ld	a,#9
 449  0101 cd0000        	call	c_lursh
 451  0104 b603          	ld	a,c_lreg+3
 452  0106 6b04          	ld	(OFST-23,sp),a
 454  0108 96            	ldw	x,sp
 455  0109 cd0345        	call	LC009
 456  010c 1b1b          	add	a,(OFST+0,sp)
 457  010e 2401          	jrnc	L43
 458  0110 5c            	incw	x
 459  0111               L43:
 460  0111 02            	rlwa	x,a
 461  0112 f6            	ld	a,(x)
 462  0113 1104          	cp	a,(OFST-23,sp)
 463  0115 2214          	jrugt	L512
 465  0117 96            	ldw	x,sp
 466  0118 cd0345        	call	LC009
 467  011b 1b1b          	add	a,(OFST+0,sp)
 468  011d 2401          	jrnc	L63
 469  011f 5c            	incw	x
 470  0120               L63:
 471  0120 02            	rlwa	x,a
 472  0121 f6            	ld	a,(x)
 473  0122 110b          	cp	a,(OFST-16,sp)
 474  0124 2205          	jrugt	L512
 475                     ; 73 						set_element_hue(iter,iter);
 477  0126 7b1b          	ld	a,(OFST+0,sp)
 478  0128 cd0355        	call	LC011
 480  012b               L512:
 481                     ; 69 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 483  012b 0c1b          	inc	(OFST+0,sp)
 487  012d 7b1b          	ld	a,(OFST+0,sp)
 488  012f a106          	cp	a,#6
 489  0131 25c5          	jrult	L702
 490                     ; 76 				effective_led_count=6;
 492  0133 a606          	ld	a,#6
 493  0135 6b0c          	ld	(OFST-15,sp),a
 495                     ; 78 				if(get_button_event(0xFF,0,1)) new_game_state=2;
 497  0137 cd0339        	call	LC008
 498  013a 2704          	jreq	L712
 501  013c a602          	ld	a,#2
 502  013e 6b1a          	ld	(OFST-1,sp),a
 504  0140               L712:
 505                     ; 79 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 507  0140 cd032d        	call	LC007
 508  0143 27ae          	jreq	L741
 511  0145 a606          	ld	a,#6
 512  0147 6b1a          	ld	(OFST-1,sp),a
 514  0149 cc0325        	jra	L741
 515  014c               L7:
 516                     ; 82 				if(is_new_state)
 518  014c 0d1b          	tnz	(OFST+0,sp)
 519  014e 2704          	jreq	L322
 520                     ; 84 					cursor=0;
 522  0150 6b12          	ld	(OFST-9,sp),a
 524                     ; 85 					level_fractional_progress=0;
 526  0152 6b13          	ld	(OFST-8,sp),a
 528  0154               L322:
 529                     ; 87 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 531  0154 0f1b          	clr	(OFST+0,sp)
 533  0156               L522:
 534                     ; 89 					if(target_pattern[iter]<level_fractional_progress)
 536  0156 96            	ldw	x,sp
 537  0157 cd0345        	call	LC009
 538  015a 1b1b          	add	a,(OFST+0,sp)
 539  015c 2401          	jrnc	L64
 540  015e 5c            	incw	x
 541  015f               L64:
 542  015f 02            	rlwa	x,a
 543  0160 f6            	ld	a,(x)
 544  0161 1113          	cp	a,(OFST-8,sp)
 545  0163 2405          	jruge	L332
 546                     ; 91 						set_element_hue(iter,iter);
 548  0165 7b1b          	ld	a,(OFST+0,sp)
 549  0167 cd0355        	call	LC011
 551  016a               L332:
 552                     ; 87 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 554  016a 0c1b          	inc	(OFST+0,sp)
 558  016c 7b1b          	ld	a,(OFST+0,sp)
 559  016e a106          	cp	a,#6
 560  0170 25e4          	jrult	L522
 561                     ; 94 				if(game_state_elapsed_ms&0x0100) set_element_hue(cursor,cursor);
 563  0172 7b10          	ld	a,(OFST-11,sp)
 564  0174 a501          	bcp	a,#1
 565  0176 2705          	jreq	L532
 568  0178 7b12          	ld	a,(OFST-9,sp)
 569  017a cd0355        	call	LC011
 571  017d               L532:
 572                     ; 95 				if(get_button_event(1,0,1) || target_pattern[cursor]<level_fractional_progress)
 574  017d 4b01          	push	#1
 575  017f ae0100        	ldw	x,#256
 576  0182 cd0000        	call	_get_button_event
 578  0185 5b01          	addw	sp,#1
 579  0187 4d            	tnz	a
 580  0188 260f          	jrne	L342
 582  018a 96            	ldw	x,sp
 583  018b cd0345        	call	LC009
 584  018e 1b12          	add	a,(OFST-9,sp)
 585  0190 2401          	jrnc	L65
 586  0192 5c            	incw	x
 587  0193               L65:
 588  0193 02            	rlwa	x,a
 589  0194 f6            	ld	a,(x)
 590  0195 1113          	cp	a,(OFST-8,sp)
 591  0197 241c          	jruge	L732
 592  0199               L342:
 593                     ; 98 						cursor=(cursor+1)%RGB_LED_COUNT;
 595  0199 7b12          	ld	a,(OFST-9,sp)
 596  019b 5f            	clrw	x
 597  019c 97            	ld	xl,a
 598  019d 5c            	incw	x
 599  019e a606          	ld	a,#6
 600  01a0 cd0000        	call	c_smodx
 602  01a3 01            	rrwa	x,a
 603  01a4 6b12          	ld	(OFST-9,sp),a
 605                     ; 99 					}while(target_pattern[cursor]<level_fractional_progress);//skip over indexes that have already been selected
 607  01a6 96            	ldw	x,sp
 608  01a7 cd0345        	call	LC009
 609  01aa 1b12          	add	a,(OFST-9,sp)
 610  01ac 2401          	jrnc	L06
 611  01ae 5c            	incw	x
 612  01af               L06:
 613  01af 02            	rlwa	x,a
 614  01b0 f6            	ld	a,(x)
 615  01b1 1113          	cp	a,(OFST-8,sp)
 616  01b3 25e4          	jrult	L342
 617  01b5               L732:
 618                     ; 101 				if(get_button_event(0,0,1))
 620  01b5 4b01          	push	#1
 621  01b7 5f            	clrw	x
 622  01b8 cd0000        	call	_get_button_event
 624  01bb 5b01          	addw	sp,#1
 625  01bd 4d            	tnz	a
 626  01be 272b          	jreq	L152
 627                     ; 103 					if(target_pattern[cursor]==level_fractional_progress)//correctly selected the proper led
 629  01c0 96            	ldw	x,sp
 630  01c1 cd0345        	call	LC009
 631  01c4 1b12          	add	a,(OFST-9,sp)
 632  01c6 2401          	jrnc	L46
 633  01c8 5c            	incw	x
 634  01c9               L46:
 635  01c9 02            	rlwa	x,a
 636  01ca f6            	ld	a,(x)
 637  01cb 1113          	cp	a,(OFST-8,sp)
 638  01cd 2618          	jrne	L352
 639                     ; 105 						level_fractional_progress++;
 641  01cf 0c13          	inc	(OFST-8,sp)
 643                     ; 106 						if(level_fractional_progress>=RGB_LED_COUNT) new_game_state=5;//full win
 645  01d1 7b13          	ld	a,(OFST-8,sp)
 646  01d3 a106          	cp	a,#6
 647  01d5 2504          	jrult	L552
 650  01d7 a605          	ld	a,#5
 652  01d9 200e          	jp	LC001
 653  01db               L552:
 654                     ; 107 						else if(level_fractional_progress>game_level){ new_game_state=4; game_level++; }//level win
 656  01db 110b          	cp	a,(OFST-16,sp)
 657  01dd 230c          	jrule	L152
 660  01df a604          	ld	a,#4
 661  01e1 6b1a          	ld	(OFST-1,sp),a
 665  01e3 0c0b          	inc	(OFST-16,sp)
 667  01e5 2004          	jra	L152
 668  01e7               L352:
 669                     ; 109 						new_game_state=3;//lose
 671  01e7 a603          	ld	a,#3
 672  01e9               LC001:
 673  01e9 6b1a          	ld	(OFST-1,sp),a
 675  01eb               L152:
 676                     ; 112 				effective_led_count=RGB_LED_COUNT;
 678  01eb a606          	ld	a,#6
 679  01ed 6b0c          	ld	(OFST-15,sp),a
 681                     ; 113 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 683  01ef cd032d        	call	LC007
 684  01f2 2603cc0325    	jreq	L741
 687  01f7 a606          	ld	a,#6
 688  01f9 6b1a          	ld	(OFST-1,sp),a
 690  01fb cc0325        	jra	L741
 691  01fe               L11:
 692                     ; 116 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1); new_game_state=0; }//restart game after timeout, and clear any button pushes registered during lose
 694  01fe 7b10          	ld	a,(OFST-11,sp)
 695  0200 a504          	bcp	a,#4
 696  0202 2705          	jreq	L762
 699  0204 cd034b        	call	LC010
 702  0207 0f1a          	clr	(OFST-1,sp)
 704  0209               L762:
 705                     ; 117 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,0,255);//flash red LEDs
 707  0209 7b11          	ld	a,(OFST-10,sp)
 708  020b 2a3d          	jrpl	L303
 711  020d 0f1b          	clr	(OFST+0,sp)
 713  020f               L372:
 716  020f 4bff          	push	#255
 717  0211 7b1c          	ld	a,(OFST+1,sp)
 718  0213 5f            	clrw	x
 719  0214 95            	ld	xh,a
 720  0215 cd0000        	call	_set_rgb
 722  0218 84            	pop	a
 725  0219 0c1b          	inc	(OFST+0,sp)
 729  021b 7b1b          	ld	a,(OFST+0,sp)
 730  021d a106          	cp	a,#6
 731  021f 25ee          	jrult	L372
 732                     ; 118 				effective_led_count=RGB_LED_COUNT;
 733                     ; 119 			}break;
 735  0221 2027          	jp	L303
 736  0223               L31:
 737                     ; 121 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1);  new_game_state=1; }//go to next level, clear any button pushse during transition
 739  0223 7b10          	ld	a,(OFST-11,sp)
 740  0225 a504          	bcp	a,#4
 741  0227 2707          	jreq	L103
 744  0229 cd034b        	call	LC010
 747  022c a601          	ld	a,#1
 748  022e 6b1a          	ld	(OFST-1,sp),a
 750  0230               L103:
 751                     ; 122 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,1,255);//flash green LEDs
 753  0230 7b11          	ld	a,(OFST-10,sp)
 754  0232 2a16          	jrpl	L303
 757  0234 0f1b          	clr	(OFST+0,sp)
 759  0236               L503:
 762  0236 4bff          	push	#255
 763  0238 7b1c          	ld	a,(OFST+1,sp)
 764  023a ae0001        	ldw	x,#1
 765  023d 95            	ld	xh,a
 766  023e cd0000        	call	_set_rgb
 768  0241 84            	pop	a
 771  0242 0c1b          	inc	(OFST+0,sp)
 775  0244 7b1b          	ld	a,(OFST+0,sp)
 776  0246 a106          	cp	a,#6
 777  0248 25ec          	jrult	L503
 778  024a               L303:
 779                     ; 123 				effective_led_count=RGB_LED_COUNT;
 782  024a a606          	ld	a,#6
 783                     ; 124 			}break;
 785  024c cc0323        	jp	LC005
 786  024f               L51:
 787                     ; 126 				if(is_new_state) submenu_index=0;
 789  024f 0d1b          	tnz	(OFST+0,sp)
 790  0251 2702          	jreq	L313
 793  0253 6b0a          	ld	(OFST-17,sp),a
 795  0255               L313:
 796                     ; 127 				effective_led_count=show_screensaver(submenu_index);
 798  0255 7b0a          	ld	a,(OFST-17,sp)
 799  0257 cd03b1        	call	_show_screensaver
 801  025a 6b0c          	ld	(OFST-15,sp),a
 803                     ; 128 				if(get_button_event(0xFF,0,1)) submenu_index++;//allow user to cycle through winning screensavers
 805  025c cd0339        	call	LC008
 806  025f 2702          	jreq	L513
 809  0261 0c0a          	inc	(OFST-17,sp)
 811  0263               L513:
 812                     ; 129 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press to get back to idle screen
 814  0263 cd032d        	call	LC007
 815  0266 2793          	jreq	L741
 818  0268 0f1a          	clr	(OFST-1,sp)
 820  026a cc0325        	jra	L741
 821  026d               L71:
 822                     ; 132 				set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
 824  026d ae0505        	ldw	x,#1285
 825  0270 cd0359        	call	_set_element_hue
 827                     ; 133 				cursor=(((u16)game_state_elapsed_ms>>8)+(game_level>1?(((u16)game_state_elapsed_ms+(2<<6))>>8):0)
 827                     ; 134 									 			  								     +(game_level>3?(((u16)game_state_elapsed_ms+(3<<6))>>8):0))%RGB_LED_COUNT;//player position
 829  0273 7b0b          	ld	a,(OFST-16,sp)
 830  0275 a104          	cp	a,#4
 831  0277 2509          	jrult	L011
 832  0279 1e10          	ldw	x,(OFST-11,sp)
 833  027b 1c00c0        	addw	x,#192
 834  027e 4f            	clr	a
 835  027f 01            	rrwa	x,a
 836  0280 2001          	jra	L211
 837  0282               L011:
 838  0282 5f            	clrw	x
 839  0283               L211:
 840  0283 1f03          	ldw	(OFST-24,sp),x
 842  0285 7b0b          	ld	a,(OFST-16,sp)
 843  0287 a102          	cp	a,#2
 844  0289 2509          	jrult	L411
 845  028b 1e10          	ldw	x,(OFST-11,sp)
 846  028d 1c0080        	addw	x,#128
 847  0290 4f            	clr	a
 848  0291 01            	rrwa	x,a
 849  0292 2001          	jra	L611
 850  0294               L411:
 851  0294 5f            	clrw	x
 852  0295               L611:
 853  0295 1f01          	ldw	(OFST-26,sp),x
 855  0297 4f            	clr	a
 856  0298 1e10          	ldw	x,(OFST-11,sp)
 857  029a 01            	rrwa	x,a
 858  029b 72fb01        	addw	x,(OFST-26,sp)
 859  029e 72fb03        	addw	x,(OFST-24,sp)
 860  02a1 a606          	ld	a,#6
 861  02a3 62            	div	x,a
 862  02a4 5f            	clrw	x
 863  02a5 97            	ld	xl,a
 864  02a6 01            	rrwa	x,a
 865  02a7 6b12          	ld	(OFST-9,sp),a
 867                     ; 135 				if(is_target_element_placed) cursor=RGB_LED_COUNT-cursor-1;//reverse direction
 869  02a9 7b0d          	ld	a,(OFST-14,sp)
 870  02ab 2706          	jreq	L123
 873  02ad a605          	ld	a,#5
 874  02af 1012          	sub	a,(OFST-9,sp)
 875  02b1 6b12          	ld	(OFST-9,sp),a
 877  02b3               L123:
 878                     ; 136 				set_element_hue(cursor,game_level);
 880  02b3 7b0b          	ld	a,(OFST-16,sp)
 881  02b5 97            	ld	xl,a
 882  02b6 7b12          	ld	a,(OFST-9,sp)
 883  02b8 95            	ld	xh,a
 884  02b9 cd0359        	call	_set_element_hue
 886                     ; 137 				if(get_button_event(0xFF,0,1)) new_game_state=7;//show user evaluation of performance
 888  02bc ad7b          	call	LC008
 889  02be 2704          	jreq	L323
 892  02c0 a607          	ld	a,#7
 893  02c2 6b1a          	ld	(OFST-1,sp),a
 895  02c4               L323:
 896                     ; 138 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
 898  02c4 ad67          	call	LC007
 899  02c6 2702          	jreq	L523
 902  02c8 0f1a          	clr	(OFST-1,sp)
 904  02ca               L523:
 905                     ; 139 				effective_led_count=2;
 907  02ca a602          	ld	a,#2
 908                     ; 140 			}break;
 910  02cc 2055          	jp	LC005
 911  02ce               L12:
 912                     ; 142 				if(get_button_event(0xFF,0,1))
 914  02ce ad69          	call	LC008
 915  02d0 2720          	jreq	L723
 916                     ; 144 					is_target_element_placed=!is_target_element_placed;//flip direction
 918  02d2 7b0d          	ld	a,(OFST-14,sp)
 919  02d4 2603          	jrne	L031
 920  02d6 4c            	inc	a
 921  02d7 2001          	jra	L231
 922  02d9               L031:
 923  02d9 4f            	clr	a
 924  02da               L231:
 925  02da 6b0d          	ld	(OFST-14,sp),a
 927                     ; 145 					if(cursor==(RGB_LED_COUNT-1)) game_level++;
 929  02dc 7b12          	ld	a,(OFST-9,sp)
 930  02de a105          	cp	a,#5
 931  02e0 2602          	jrne	L133
 934  02e2 0c0b          	inc	(OFST-16,sp)
 936  02e4               L133:
 937                     ; 146 					if(game_level==RGB_LED_COUNT) new_game_state=5;//win after all levels
 939  02e4 7b0b          	ld	a,(OFST-16,sp)
 940  02e6 a106          	cp	a,#6
 941  02e8 2604          	jrne	L333
 944  02ea a605          	ld	a,#5
 946  02ec 2002          	jp	LC002
 947  02ee               L333:
 948                     ; 147 					else new_game_state=6; //go to next level, clear any button pushse during transition
 950  02ee a606          	ld	a,#6
 951  02f0               LC002:
 952  02f0 6b1a          	ld	(OFST-1,sp),a
 954  02f2               L723:
 955                     ; 149 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
 957  02f2 ad39          	call	LC007
 958  02f4 2702          	jreq	L733
 961  02f6 0f1a          	clr	(OFST-1,sp)
 963  02f8               L733:
 964                     ; 150 				if(game_state_elapsed_ms&0x80)
 966  02f8 7b11          	ld	a,(OFST-10,sp)
 967  02fa 2a10          	jrpl	L143
 968                     ; 152 					set_element_hue(cursor,game_level);//cursor
 970  02fc 7b0b          	ld	a,(OFST-16,sp)
 971  02fe 97            	ld	xl,a
 972  02ff 7b12          	ld	a,(OFST-9,sp)
 973  0301 95            	ld	xh,a
 974  0302 ad55          	call	_set_element_hue
 976                     ; 153 					if(cursor!=(RGB_LED_COUNT-1)) set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);//goal post
 978  0304 7b12          	ld	a,(OFST-9,sp)
 979  0306 a105          	cp	a,#5
 980  0308 2717          	jreq	L543
 983  030a 2010          	jp	L743
 984  030c               L143:
 985                     ; 155 					if(cursor==(RGB_LED_COUNT-1))
 987  030c 7b12          	ld	a,(OFST-9,sp)
 988  030e a105          	cp	a,#5
 989  0310 260a          	jrne	L743
 990                     ; 157 						set_element_hue(RGB_LED_COUNT-2,RGB_LED_COUNT-1);
 992  0312 ae0405        	ldw	x,#1029
 993  0315 ad42          	call	_set_element_hue
 995                     ; 158 						set_element_hue(0,RGB_LED_COUNT-1);
 997  0317 ae0005        	ldw	x,#5
1000  031a 2003          	jp	LC003
1001  031c               L743:
1002                     ; 160 						set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
1005  031c ae0505        	ldw	x,#1285
1006  031f               LC003:
1007  031f ad38          	call	_set_element_hue
1009  0321               L543:
1010                     ; 163 				effective_led_count=RGB_LED_COUNT;
1012                     ; 164 				effective_led_count=3;
1014  0321 a603          	ld	a,#3
1015  0323               LC005:
1016  0323 6b0c          	ld	(OFST-15,sp),a
1018                     ; 165 			}break;
1020  0325               L741:
1021                     ; 167 		flush_leds(effective_led_count);
1023  0325 7b0c          	ld	a,(OFST-15,sp)
1024  0327 cd0000        	call	_flush_leds
1027  032a cc000b        	jra	L731
1028  032d               LC007:
1029  032d 4b01          	push	#1
1030  032f aeff01        	ldw	x,#65281
1031  0332 cd0000        	call	_get_button_event
1033  0335 5b01          	addw	sp,#1
1034  0337 4d            	tnz	a
1035  0338 81            	ret	
1036  0339               LC008:
1037  0339 4b01          	push	#1
1038  033b aeff00        	ldw	x,#65280
1039  033e cd0000        	call	_get_button_event
1041  0341 5b01          	addw	sp,#1
1042  0343 4d            	tnz	a
1043  0344 81            	ret	
1044  0345               LC009:
1045  0345 1c0014        	addw	x,#OFST-7
1046  0348 9f            	ld	a,xl
1047  0349 5e            	swapw	x
1048  034a 81            	ret	
1049  034b               LC010:
1050  034b 4b01          	push	#1
1051  034d aeffff        	ldw	x,#65535
1052  0350 cd0000        	call	_get_button_event
1054  0353 84            	pop	a
1055  0354 81            	ret	
1056  0355               LC011:
1057  0355 97            	ld	xl,a
1058  0356 95            	ld	xh,a
1059  0357 2000          	jp	_set_element_hue
1113                     ; 171 void set_element_hue(u8 led_index,u8 color_index)
1113                     ; 172 {
1114                     	switch	.text
1115  0359               _set_element_hue:
1117  0359 89            	pushw	x
1118  035a 89            	pushw	x
1119       00000002      OFST:	set	2
1122                     ; 174 	switch(color_index){
1124  035b 9f            	ld	a,xl
1126                     ; 183 	  default: color=0xD555; break;//purple
1127  035c 4d            	tnz	a
1128  035d 2736          	jreq	L553
1129  035f 4a            	dec	a
1130  0360 2738          	jreq	L753
1131  0362 4a            	dec	a
1132  0363 273a          	jreq	L163
1133  0365 4a            	dec	a
1134  0366 273a          	jreq	L363
1135  0368 a002          	sub	a,#2
1136  036a 2705          	jreq	L353
1139  036c aed555        	ldw	x,#54613
1142  036f 2034          	jra	L714
1143  0371               L353:
1144                     ; 175 		case 5: set_rgb(led_index,0,146);//dirty white
1146  0371 4b92          	push	#146
1147  0373 7b04          	ld	a,(OFST+2,sp)
1148  0375 5f            	clrw	x
1149  0376 95            	ld	xh,a
1150  0377 cd0000        	call	_set_rgb
1152  037a 84            	pop	a
1153                     ; 176 						set_rgb(led_index,1,146);//146**2 *3 = 255**2
1155  037b 4b92          	push	#146
1156  037d 7b04          	ld	a,(OFST+2,sp)
1157  037f ae0001        	ldw	x,#1
1158  0382 95            	ld	xh,a
1159  0383 cd0000        	call	_set_rgb
1161  0386 84            	pop	a
1162                     ; 177 						set_rgb(led_index,2,146);
1164  0387 4b92          	push	#146
1165  0389 7b04          	ld	a,(OFST+2,sp)
1166  038b ae0002        	ldw	x,#2
1167  038e 95            	ld	xh,a
1168  038f cd0000        	call	_set_rgb
1170  0392 84            	pop	a
1171                     ; 178 						return;
1173  0393 2019          	jra	L461
1174  0395               L553:
1175                     ; 179 		case 0: color=0x2AAA; break;//yellow 
1177  0395 ae2aaa        	ldw	x,#10922
1180  0398 200b          	jra	L714
1181  039a               L753:
1182                     ; 180 		case 1: color=0x5555; break;//green
1184  039a ae5555        	ldw	x,#21845
1187  039d 2006          	jra	L714
1188  039f               L163:
1189                     ; 181 	  case 2: color=0x0; break;//red
1191  039f 5f            	clrw	x
1194  03a0 2003          	jra	L714
1195  03a2               L363:
1196                     ; 182 	  case 3: color=0xAAAA; break;//blue
1198  03a2 aeaaaa        	ldw	x,#43690
1201  03a5               L714:
1202  03a5 1f01          	ldw	(OFST-1,sp),x
1204                     ; 185 	set_hue_max(led_index,color);
1206  03a7 89            	pushw	x
1207  03a8 7b05          	ld	a,(OFST+3,sp)
1208  03aa cd0000        	call	_set_hue_max
1210  03ad 85            	popw	x
1211                     ; 186 }
1212  03ae               L461:
1215  03ae 5b04          	addw	sp,#4
1216  03b0 81            	ret	
1252                     ; 188 u8 show_screensaver(u8 screensaver_index)
1252                     ; 189 {
1253                     	switch	.text
1254  03b1               _show_screensaver:
1256  03b1 88            	push	a
1257       00000001      OFST:	set	1
1260                     ; 190 	switch(screensaver_index%SCREENSAVER_COUNT)
1262  03b2 5f            	clrw	x
1263  03b3 97            	ld	xl,a
1264  03b4 a607          	ld	a,#7
1265  03b6 cd0000        	call	c_smodx
1268                     ; 197 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1269  03b9 5a            	decw	x
1270  03ba 2711          	jreq	L124
1271  03bc 5a            	decw	x
1272  03bd 271b          	jreq	L324
1273  03bf 5a            	decw	x
1274  03c0 2726          	jreq	L524
1275  03c2 5a            	decw	x
1276  03c3 272a          	jreq	L724
1277  03c5 5a            	decw	x
1278  03c6 272e          	jreq	L134
1279  03c8 5a            	decw	x
1280  03c9 2739          	jreq	L334
1281  03cb 2046          	jra	L554
1282  03cd               L124:
1283                     ; 192 		case 1: return set_frame_rainbow(0)+set_sparkles(0);
1285  03cd 4f            	clr	a
1286  03ce ad7d          	call	_set_sparkles
1288  03d0 6b01          	ld	(OFST+0,sp),a
1290  03d2 4f            	clr	a
1291  03d3 ad44          	call	_set_frame_rainbow
1293  03d5 1b01          	add	a,(OFST+0,sp)
1296  03d7 5b01          	addw	sp,#1
1297  03d9 81            	ret	
1298  03da               L324:
1299                     ; 193 		case 2: return set_frame_rainbow(0)+set_sparkles(1);
1301  03da a601          	ld	a,#1
1302  03dc ad6f          	call	_set_sparkles
1304  03de 6b01          	ld	(OFST+0,sp),a
1306  03e0 4f            	clr	a
1307  03e1 ad36          	call	_set_frame_rainbow
1309  03e3 1b01          	add	a,(OFST+0,sp)
1312  03e5 5b01          	addw	sp,#1
1313  03e7 81            	ret	
1314  03e8               L524:
1315                     ; 194 		case 3: return set_sparkles(1);
1317  03e8 a601          	ld	a,#1
1318  03ea ad61          	call	_set_sparkles
1322  03ec 5b01          	addw	sp,#1
1323  03ee 81            	ret	
1324  03ef               L724:
1325                     ; 195 		case 4: return set_frame_rainbow(1);
1327  03ef a601          	ld	a,#1
1328  03f1 ad26          	call	_set_frame_rainbow
1332  03f3 5b01          	addw	sp,#1
1333  03f5 81            	ret	
1334  03f6               L134:
1335                     ; 196 		case 5: return set_frame_rainbow(1)+set_sparkles(0);
1337  03f6 4f            	clr	a
1338  03f7 ad54          	call	_set_sparkles
1340  03f9 6b01          	ld	(OFST+0,sp),a
1342  03fb a601          	ld	a,#1
1343  03fd ad1a          	call	_set_frame_rainbow
1345  03ff 1b01          	add	a,(OFST+0,sp)
1348  0401 5b01          	addw	sp,#1
1349  0403 81            	ret	
1350  0404               L334:
1351                     ; 197 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1353  0404 a601          	ld	a,#1
1354  0406 ad45          	call	_set_sparkles
1356  0408 6b01          	ld	(OFST+0,sp),a
1358  040a a601          	ld	a,#1
1359  040c ad0b          	call	_set_frame_rainbow
1361  040e 1b01          	add	a,(OFST+0,sp)
1364  0410 5b01          	addw	sp,#1
1365  0412 81            	ret	
1366  0413               L554:
1367                     ; 199 	return set_frame_rainbow(0);
1369  0413 4f            	clr	a
1370  0414 ad03          	call	_set_frame_rainbow
1374  0416 5b01          	addw	sp,#1
1375  0418 81            	ret	
1430                     ; 202 u8 set_frame_rainbow(bool is_circular)
1430                     ; 203 {
1431                     	switch	.text
1432  0419               _set_frame_rainbow:
1434  0419 88            	push	a
1435  041a 5203          	subw	sp,#3
1436       00000003      OFST:	set	3
1439                     ; 205 	u16 offset=0;
1441  041c 5f            	clrw	x
1442  041d 1f01          	ldw	(OFST-2,sp),x
1444                     ; 206 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1446  041f 0f03          	clr	(OFST+0,sp)
1448  0421               L505:
1449                     ; 208 		set_hue_max(iter,(u16)(millis()<<5)+offset);
1451  0421 cd0000        	call	_millis
1453  0424 a605          	ld	a,#5
1454  0426 cd0000        	call	c_llsh
1456  0429 be02          	ldw	x,c_lreg+2
1457  042b 72fb01        	addw	x,(OFST-2,sp)
1458  042e 89            	pushw	x
1459  042f 7b05          	ld	a,(OFST+2,sp)
1460  0431 cd0000        	call	_set_hue_max
1462  0434 85            	popw	x
1463                     ; 209 		if(is_circular) offset+=0x2AAB;
1465  0435 7b04          	ld	a,(OFST+1,sp)
1466  0437 2707          	jreq	L315
1469  0439 1e01          	ldw	x,(OFST-2,sp)
1470  043b 1c2aab        	addw	x,#10923
1471  043e 1f01          	ldw	(OFST-2,sp),x
1473  0440               L315:
1474                     ; 206 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1476  0440 0c03          	inc	(OFST+0,sp)
1480  0442 7b03          	ld	a,(OFST+0,sp)
1481  0444 a106          	cp	a,#6
1482  0446 25d9          	jrult	L505
1483                     ; 211 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
1485  0448 a606          	ld	a,#6
1488  044a 5b04          	addw	sp,#4
1489  044c 81            	ret	
1544                     ; 214 u8 set_sparkles(bool is_fireworks)
1544                     ; 215 {
1545                     	switch	.text
1546  044d               _set_sparkles:
1548  044d 88            	push	a
1549  044e 5207          	subw	sp,#7
1550       00000007      OFST:	set	7
1553                     ; 218 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1555  0450 0f05          	clr	(OFST-2,sp)
1557  0452               L345:
1558                     ; 221 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
1560  0452 cd0000        	call	_millis
1562  0455 96            	ldw	x,sp
1563  0456 5c            	incw	x
1564  0457 cd0000        	call	c_rtol
1567  045a 7b05          	ld	a,(OFST-2,sp)
1568  045c 97            	ld	xl,a
1569  045d 4f            	clr	a
1570  045e 02            	rlwa	x,a
1571  045f 58            	sllw	x
1572  0460 cd0000        	call	c_itolx
1574  0463 96            	ldw	x,sp
1575  0464 5c            	incw	x
1576  0465 cd0000        	call	c_ladd
1578  0468 be02          	ldw	x,c_lreg+2
1579  046a 1f06          	ldw	(OFST-1,sp),x
1581                     ; 222 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
1583  046c cd0000        	call	_millis
1585  046f 7b05          	ld	a,(OFST-2,sp)
1586  0471 a403          	and	a,#3
1587  0473 ab02          	add	a,#2
1588  0475 cd0000        	call	c_lursh
1590  0478 96            	ldw	x,sp
1591  0479 5c            	incw	x
1592  047a cd0000        	call	c_rtol
1595  047d 1e06          	ldw	x,(OFST-1,sp)
1596  047f cd0000        	call	c_uitolx
1598  0482 96            	ldw	x,sp
1599  0483 5c            	incw	x
1600  0484 cd0000        	call	c_lsub
1602  0487 be02          	ldw	x,c_lreg+2
1603  0489 1f06          	ldw	(OFST-1,sp),x
1605                     ; 223 		state+=millis()>>(2+((iter>>2)&0x02));
1607  048b cd0000        	call	_millis
1609  048e 7b05          	ld	a,(OFST-2,sp)
1610  0490 a408          	and	a,#8
1611  0492 44            	srl	a
1612  0493 44            	srl	a
1613  0494 ab02          	add	a,#2
1614  0496 cd0000        	call	c_lursh
1616  0499 96            	ldw	x,sp
1617  049a 5c            	incw	x
1618  049b cd0000        	call	c_rtol
1621  049e 1e06          	ldw	x,(OFST-1,sp)
1622  04a0 cd0000        	call	c_uitolx
1624  04a3 96            	ldw	x,sp
1625  04a4 5c            	incw	x
1626  04a5 cd0000        	call	c_ladd
1628  04a8 be02          	ldw	x,c_lreg+2
1629  04aa 1f06          	ldw	(OFST-1,sp),x
1631                     ; 225 		if(!(state&(is_fireworks?0x0800:0x1800)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
1633  04ac 0d08          	tnz	(OFST+1,sp)
1634  04ae 2705          	jreq	L432
1635  04b0 ae0800        	ldw	x,#2048
1636  04b3 2003          	jra	L632
1637  04b5               L432:
1638  04b5 ae1800        	ldw	x,#6144
1639  04b8               L632:
1640  04b8 01            	rrwa	x,a
1641  04b9 1407          	and	a,(OFST+0,sp)
1642  04bb 01            	rrwa	x,a
1643  04bc 1406          	and	a,(OFST-1,sp)
1644  04be 01            	rrwa	x,a
1645  04bf 5d            	tnzw	x
1646  04c0 2657          	jrne	L155
1647                     ; 228 			if(is_fireworks)
1649  04c2 7b08          	ld	a,(OFST+1,sp)
1650  04c4 2731          	jreq	L355
1651                     ; 229 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
1653  04c6 1e06          	ldw	x,(OFST-1,sp)
1654  04c8 4f            	clr	a
1655  04c9 01            	rrwa	x,a
1656  04ca 54            	srlw	x
1657  04cb 54            	srlw	x
1658  04cc 01            	rrwa	x,a
1659  04cd a501          	bcp	a,#1
1660  04cf 270d          	jreq	L242
1661  04d1 1e06          	ldw	x,(OFST-1,sp)
1662  04d3 54            	srlw	x
1663  04d4 54            	srlw	x
1664  04d5 54            	srlw	x
1665  04d6 01            	rrwa	x,a
1666  04d7 43            	cpl	a
1667  04d8 a47f          	and	a,#127
1668  04da 5f            	clrw	x
1669  04db 02            	rlwa	x,a
1670  04dc 2035          	jra	L262
1671  04de               L242:
1672  04de 1e06          	ldw	x,(OFST-1,sp)
1673  04e0 a606          	ld	a,#6
1674  04e2               L052:
1675  04e2 54            	srlw	x
1676  04e3 4a            	dec	a
1677  04e4 26fc          	jrne	L052
1678  04e6 01            	rrwa	x,a
1679  04e7 a40f          	and	a,#15
1680  04e9 5f            	clrw	x
1681  04ea 02            	rlwa	x,a
1682  04eb a3000f        	cpw	x,#15
1683  04ee 2604          	jrne	L642
1684  04f0               LC014:
1685  04f0 a6ff          	ld	a,#255
1686  04f2 201e          	jra	L662
1687  04f4               L642:
1688  04f4 4f            	clr	a
1691  04f5 201b          	jp	L662
1692  04f7               L355:
1693                     ; 231 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
1695  04f7 1e06          	ldw	x,(OFST-1,sp)
1696  04f9 01            	rrwa	x,a
1697  04fa 54            	srlw	x
1698  04fb 54            	srlw	x
1699  04fc 01            	rrwa	x,a
1700  04fd a501          	bcp	a,#1
1701  04ff 2707          	jreq	L062
1702  0501 1e06          	ldw	x,(OFST-1,sp)
1703  0503 54            	srlw	x
1704  0504 54            	srlw	x
1705  0505 53            	cplw	x
1706  0506 200b          	jra	L262
1707  0508               L062:
1708  0508 1e06          	ldw	x,(OFST-1,sp)
1709  050a 4f            	clr	a
1710  050b 02            	rlwa	x,a
1711  050c a503          	bcp	a,#3
1712  050e 26e0          	jrne	LC014
1713  0510 7b07          	ld	a,(OFST+0,sp)
1714  0512               L662:
1715  0512 97            	ld	xl,a
1716  0513               L262:
1717  0513 7b05          	ld	a,(OFST-2,sp)
1718  0515 95            	ld	xh,a
1719  0516 cd0000        	call	_set_white
1721  0519               L155:
1722                     ; 218 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1724  0519 0c05          	inc	(OFST-2,sp)
1728  051b 7b05          	ld	a,(OFST-2,sp)
1729  051d a10c          	cp	a,#12
1730  051f 2403cc0452    	jrult	L345
1731                     ; 234 	return WHITE_LED_COUNT/4;
1733  0524 a603          	ld	a,#3
1736  0526 5b08          	addw	sp,#8
1737  0528 81            	ret	
1750                     	xdef	_set_element_hue
1751                     	xdef	_show_screensaver
1752                     	xdef	_set_sparkles
1753                     	xdef	_set_frame_rainbow
1754                     	xdef	_run_application
1755                     	xref	_get_random
1756                     	xref	_get_button_event
1757                     	xref	_set_hue_max
1758                     	xref	_flush_leds
1759                     	xref	_set_white
1760                     	xref	_set_rgb
1761                     	xref	_millis
1762                     	xref.b	c_lreg
1763                     	xref.b	c_x
1782                     	xref	c_uitolx
1783                     	xref	c_ladd
1784                     	xref	c_itolx
1785                     	xref	c_llsh
1786                     	xref	c_smodx
1787                     	xref	c_lursh
1788                     	xref	c_ltor
1789                     	xref	c_lsub
1790                     	xref	c_rtol
1791                     	end
