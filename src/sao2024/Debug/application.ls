   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
 183                     ; 7 void run_application()
 183                     ; 8 {
 185                     	switch	.text
 186  0000               _run_application:
 188  0000 521b          	subw	sp,#27
 189       0000001b      OFST:	set	27
 192                     ; 9 	u8 new_game_state=0,old_game_state=255;
 194  0002 0f1a          	clr	(OFST-1,sp)
 198  0004 a6ff          	ld	a,#255
 199  0006 6b09          	ld	(OFST-18,sp),a
 201                     ; 11 	bool is_new_state=1;
 203                     ; 14 	u8 effective_led_count=1;//two leds ON at half brightness (duration) = 1 effective LED
 205                     ; 22 	get_button_event(0xFF,0xFF,1);//clear_button_events();
 207  0008 cd0358        	call	LC010
 209  000b cc032e        	jra	L511
 210  000e               L311:
 211                     ; 25 		effective_led_count=1;//default empty list
 213  000e a601          	ld	a,#1
 214  0010 6b0c          	ld	(OFST-15,sp),a
 216                     ; 26 		is_new_state=0;//flag to signify a new state has been entered
 218  0012 0f1b          	clr	(OFST+0,sp)
 220                     ; 27 		if(new_game_state!=old_game_state)
 222  0014 7b1a          	ld	a,(OFST-1,sp)
 223  0016 1109          	cp	a,(OFST-18,sp)
 224  0018 2712          	jreq	L121
 225                     ; 29 			is_new_state=1;
 227  001a a601          	ld	a,#1
 228  001c 6b1b          	ld	(OFST+0,sp),a
 230                     ; 30 			game_state_start_ms=millis();
 232  001e cd0000        	call	_millis
 234  0021 96            	ldw	x,sp
 235  0022 1c0005        	addw	x,#OFST-22
 236  0025 cd0000        	call	c_rtol
 239                     ; 31 			old_game_state=new_game_state;
 241  0028 7b1a          	ld	a,(OFST-1,sp)
 242  002a 6b09          	ld	(OFST-18,sp),a
 244  002c               L121:
 245                     ; 33 		game_state_elapsed_ms=millis()-game_state_start_ms;
 247  002c cd0000        	call	_millis
 249  002f 96            	ldw	x,sp
 250  0030 1c0005        	addw	x,#OFST-22
 251  0033 cd0000        	call	c_lsub
 253  0036 96            	ldw	x,sp
 254  0037 1c000e        	addw	x,#OFST-13
 255  003a cd0000        	call	c_rtol
 258                     ; 38 		switch(new_game_state)
 260  003d 7b1a          	ld	a,(OFST-1,sp)
 262                     ; 165 			}break;
 263  003f 272d          	jreq	L3
 264  0041 4a            	dec	a
 265  0042 2603cc00f9    	jreq	L5
 266  0047 4a            	dec	a
 267  0048 2603cc014f    	jreq	L7
 268  004d 4a            	dec	a
 269  004e 2603cc0201    	jreq	L11
 270  0053 4a            	dec	a
 271  0054 2603cc0226    	jreq	L31
 272  0059 4a            	dec	a
 273  005a 2603cc0252    	jreq	L51
 274  005f 4a            	dec	a
 275  0060 2603cc0270    	jreq	L71
 276  0065 4a            	dec	a
 277  0066 2603cc02d2    	jreq	L12
 278  006b cc0329        	jra	L521
 279  006e               L3:
 280                     ; 41 				game_level=0;//restart game
 282  006e 6b0b          	ld	(OFST-16,sp),a
 284                     ; 42 				effective_led_count=set_sparkles(0);
 286  0070 cd045a        	call	_set_sparkles
 288  0073 6b0c          	ld	(OFST-15,sp),a
 290                     ; 43 				if(get_button_event(0xFF,0,1))
 292  0075 cd0346        	call	LC008
 293  0078 2770          	jreq	L721
 294                     ; 46 					new_game_state=1;
 296  007a a601          	ld	a,#1
 297  007c 6b1a          	ld	(OFST-1,sp),a
 299  007e               L131:
 300                     ; 48 						for(iter=0;iter<RGB_LED_COUNT;iter++) target_pattern[iter]=0;//clear initial state for repeat play
 302  007e 0f1b          	clr	(OFST+0,sp)
 304  0080               L731:
 307  0080 96            	ldw	x,sp
 308  0081 cd0352        	call	LC009
 309  0084 1b1b          	add	a,(OFST+0,sp)
 310  0086 2401          	jrnc	L02
 311  0088 5c            	incw	x
 312  0089               L02:
 313  0089 02            	rlwa	x,a
 314  008a 7f            	clr	(x)
 317  008b 0c1b          	inc	(OFST+0,sp)
 321  008d 7b1b          	ld	a,(OFST+0,sp)
 322  008f a106          	cp	a,#6
 323  0091 25ed          	jrult	L731
 324                     ; 49 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 326  0093 a601          	ld	a,#1
 327  0095 6b1b          	ld	(OFST+0,sp),a
 329  0097               L541:
 330                     ; 51 							is_target_element_placed=0;
 332  0097 0f0d          	clr	(OFST-14,sp)
 334  0099               L351:
 335                     ; 54 								level_fractional_progress=get_random(millis()-iter)%RGB_LED_COUNT;//using time to resolve infinite loop instability :/
 337  0099 7b1b          	ld	a,(OFST+0,sp)
 338  009b b703          	ld	c_lreg+3,a
 339  009d 3f02          	clr	c_lreg+2
 340  009f 3f01          	clr	c_lreg+1
 341  00a1 3f00          	clr	c_lreg
 342  00a3 96            	ldw	x,sp
 343  00a4 5c            	incw	x
 344  00a5 cd0000        	call	c_rtol
 347  00a8 cd0000        	call	_millis
 349  00ab 96            	ldw	x,sp
 350  00ac 5c            	incw	x
 351  00ad cd0000        	call	c_lsub
 353  00b0 be02          	ldw	x,c_lreg+2
 354  00b2 cd0000        	call	_get_random
 356  00b5 a606          	ld	a,#6
 357  00b7 62            	div	x,a
 358  00b8 5f            	clrw	x
 359  00b9 97            	ld	xl,a
 360  00ba 01            	rrwa	x,a
 361  00bb 6b13          	ld	(OFST-8,sp),a
 363                     ; 55 								if(target_pattern[level_fractional_progress]==0)
 365  00bd 96            	ldw	x,sp
 366  00be cd0352        	call	LC009
 367  00c1 1b13          	add	a,(OFST-8,sp)
 368  00c3 2401          	jrnc	L62
 369  00c5 5c            	incw	x
 370  00c6               L62:
 371  00c6 02            	rlwa	x,a
 372  00c7 f6            	ld	a,(x)
 373  00c8 2610          	jrne	L161
 374                     ; 57 									is_target_element_placed=1;
 376  00ca 4c            	inc	a
 377  00cb 6b0d          	ld	(OFST-14,sp),a
 379                     ; 58 									target_pattern[level_fractional_progress]=iter;
 381  00cd 96            	ldw	x,sp
 382  00ce cd0352        	call	LC009
 383  00d1 1b13          	add	a,(OFST-8,sp)
 384  00d3 2401          	jrnc	L03
 385  00d5 5c            	incw	x
 386  00d6               L03:
 387  00d6 02            	rlwa	x,a
 388  00d7 7b1b          	ld	a,(OFST+0,sp)
 389  00d9 f7            	ld	(x),a
 390  00da               L161:
 391                     ; 52 							while(!is_target_element_placed)//beware infinite loop...
 393  00da 7b0d          	ld	a,(OFST-14,sp)
 394  00dc 27bb          	jreq	L351
 395                     ; 49 						for(iter=1;iter<RGB_LED_COUNT;iter++)//start at 1 since already set 0s in prior step
 397  00de 0c1b          	inc	(OFST+0,sp)
 401  00e0 7b1b          	ld	a,(OFST+0,sp)
 402  00e2 a106          	cp	a,#6
 403  00e4 25b1          	jrult	L541
 404                     ; 63 					}while(target_pattern[0]==0);//avoid case where first goal is at the start, confusing the user about how the device operates
 406  00e6 7b14          	ld	a,(OFST-7,sp)
 407  00e8 2794          	jreq	L131
 408  00ea               L721:
 409                     ; 65 				if(get_button_event(0xFF,1,1)) new_game_state=6;//start cyclone game by long pressing the buttons
 411  00ea cd033a        	call	LC007
 412  00ed 2603cc0329    	jreq	L521
 415  00f2 a606          	ld	a,#6
 416  00f4 6b1a          	ld	(OFST-1,sp),a
 418  00f6 cc0329        	jra	L521
 419  00f9               L5:
 420                     ; 69 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 422  00f9 6b1b          	ld	(OFST+0,sp),a
 424  00fb               L561:
 425                     ; 71 					if(target_pattern[iter]<=(u8)(game_state_elapsed_ms>>9) && target_pattern[iter]<=game_level)
 427  00fb 96            	ldw	x,sp
 428  00fc 1c000e        	addw	x,#OFST-13
 429  00ff cd0000        	call	c_ltor
 431  0102 a609          	ld	a,#9
 432  0104 cd0000        	call	c_lursh
 434  0107 b603          	ld	a,c_lreg+3
 435  0109 6b04          	ld	(OFST-23,sp),a
 437  010b 96            	ldw	x,sp
 438  010c cd0352        	call	LC009
 439  010f 1b1b          	add	a,(OFST+0,sp)
 440  0111 2401          	jrnc	L43
 441  0113 5c            	incw	x
 442  0114               L43:
 443  0114 02            	rlwa	x,a
 444  0115 f6            	ld	a,(x)
 445  0116 1104          	cp	a,(OFST-23,sp)
 446  0118 2214          	jrugt	L371
 448  011a 96            	ldw	x,sp
 449  011b cd0352        	call	LC009
 450  011e 1b1b          	add	a,(OFST+0,sp)
 451  0120 2401          	jrnc	L63
 452  0122 5c            	incw	x
 453  0123               L63:
 454  0123 02            	rlwa	x,a
 455  0124 f6            	ld	a,(x)
 456  0125 110b          	cp	a,(OFST-16,sp)
 457  0127 2205          	jrugt	L371
 458                     ; 73 						set_element_hue(iter,iter);
 460  0129 7b1b          	ld	a,(OFST+0,sp)
 461  012b cd0362        	call	LC011
 463  012e               L371:
 464                     ; 69 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 466  012e 0c1b          	inc	(OFST+0,sp)
 470  0130 7b1b          	ld	a,(OFST+0,sp)
 471  0132 a106          	cp	a,#6
 472  0134 25c5          	jrult	L561
 473                     ; 76 				effective_led_count=6;
 475  0136 a606          	ld	a,#6
 476  0138 6b0c          	ld	(OFST-15,sp),a
 478                     ; 78 				if(get_button_event(0xFF,0,1)) new_game_state=2;
 480  013a cd0346        	call	LC008
 481  013d 2704          	jreq	L571
 484  013f a602          	ld	a,#2
 485  0141 6b1a          	ld	(OFST-1,sp),a
 487  0143               L571:
 488                     ; 79 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 490  0143 cd033a        	call	LC007
 491  0146 27ae          	jreq	L521
 494  0148 a606          	ld	a,#6
 495  014a 6b1a          	ld	(OFST-1,sp),a
 497  014c cc0329        	jra	L521
 498  014f               L7:
 499                     ; 82 				if(is_new_state)
 501  014f 0d1b          	tnz	(OFST+0,sp)
 502  0151 2704          	jreq	L102
 503                     ; 84 					cursor=0;
 505  0153 6b12          	ld	(OFST-9,sp),a
 507                     ; 85 					level_fractional_progress=0;
 509  0155 6b13          	ld	(OFST-8,sp),a
 511  0157               L102:
 512                     ; 87 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 514  0157 0f1b          	clr	(OFST+0,sp)
 516  0159               L302:
 517                     ; 89 					if(target_pattern[iter]<level_fractional_progress)
 519  0159 96            	ldw	x,sp
 520  015a cd0352        	call	LC009
 521  015d 1b1b          	add	a,(OFST+0,sp)
 522  015f 2401          	jrnc	L64
 523  0161 5c            	incw	x
 524  0162               L64:
 525  0162 02            	rlwa	x,a
 526  0163 f6            	ld	a,(x)
 527  0164 1113          	cp	a,(OFST-8,sp)
 528  0166 2405          	jruge	L112
 529                     ; 91 						set_element_hue(iter,iter);
 531  0168 7b1b          	ld	a,(OFST+0,sp)
 532  016a cd0362        	call	LC011
 534  016d               L112:
 535                     ; 87 				for(iter=0;iter<RGB_LED_COUNT;iter++)
 537  016d 0c1b          	inc	(OFST+0,sp)
 541  016f 7b1b          	ld	a,(OFST+0,sp)
 542  0171 a106          	cp	a,#6
 543  0173 25e4          	jrult	L302
 544                     ; 94 				if(game_state_elapsed_ms&0x0100) set_element_hue(cursor,cursor);
 546  0175 7b10          	ld	a,(OFST-11,sp)
 547  0177 a501          	bcp	a,#1
 548  0179 2705          	jreq	L312
 551  017b 7b12          	ld	a,(OFST-9,sp)
 552  017d cd0362        	call	LC011
 554  0180               L312:
 555                     ; 95 				if(get_button_event(1,0,1) || target_pattern[cursor]<level_fractional_progress)
 557  0180 4b01          	push	#1
 558  0182 ae0100        	ldw	x,#256
 559  0185 cd0000        	call	_get_button_event
 561  0188 5b01          	addw	sp,#1
 562  018a 4d            	tnz	a
 563  018b 260f          	jrne	L122
 565  018d 96            	ldw	x,sp
 566  018e cd0352        	call	LC009
 567  0191 1b12          	add	a,(OFST-9,sp)
 568  0193 2401          	jrnc	L65
 569  0195 5c            	incw	x
 570  0196               L65:
 571  0196 02            	rlwa	x,a
 572  0197 f6            	ld	a,(x)
 573  0198 1113          	cp	a,(OFST-8,sp)
 574  019a 241c          	jruge	L512
 575  019c               L122:
 576                     ; 98 						cursor=(cursor+1)%RGB_LED_COUNT;
 578  019c 7b12          	ld	a,(OFST-9,sp)
 579  019e 5f            	clrw	x
 580  019f 97            	ld	xl,a
 581  01a0 5c            	incw	x
 582  01a1 a606          	ld	a,#6
 583  01a3 cd0000        	call	c_smodx
 585  01a6 01            	rrwa	x,a
 586  01a7 6b12          	ld	(OFST-9,sp),a
 588                     ; 99 					}while(target_pattern[cursor]<level_fractional_progress);//skip over indexes that have already been selected
 590  01a9 96            	ldw	x,sp
 591  01aa cd0352        	call	LC009
 592  01ad 1b12          	add	a,(OFST-9,sp)
 593  01af 2401          	jrnc	L06
 594  01b1 5c            	incw	x
 595  01b2               L06:
 596  01b2 02            	rlwa	x,a
 597  01b3 f6            	ld	a,(x)
 598  01b4 1113          	cp	a,(OFST-8,sp)
 599  01b6 25e4          	jrult	L122
 600  01b8               L512:
 601                     ; 101 				if(get_button_event(0,0,1))
 603  01b8 4b01          	push	#1
 604  01ba 5f            	clrw	x
 605  01bb cd0000        	call	_get_button_event
 607  01be 5b01          	addw	sp,#1
 608  01c0 4d            	tnz	a
 609  01c1 272b          	jreq	L722
 610                     ; 103 					if(target_pattern[cursor]==level_fractional_progress)//correctly selected the proper led
 612  01c3 96            	ldw	x,sp
 613  01c4 cd0352        	call	LC009
 614  01c7 1b12          	add	a,(OFST-9,sp)
 615  01c9 2401          	jrnc	L46
 616  01cb 5c            	incw	x
 617  01cc               L46:
 618  01cc 02            	rlwa	x,a
 619  01cd f6            	ld	a,(x)
 620  01ce 1113          	cp	a,(OFST-8,sp)
 621  01d0 2618          	jrne	L132
 622                     ; 105 						level_fractional_progress++;
 624  01d2 0c13          	inc	(OFST-8,sp)
 626                     ; 106 						if(level_fractional_progress>=RGB_LED_COUNT) new_game_state=5;//full win
 628  01d4 7b13          	ld	a,(OFST-8,sp)
 629  01d6 a106          	cp	a,#6
 630  01d8 2504          	jrult	L332
 633  01da a605          	ld	a,#5
 635  01dc 200e          	jp	LC001
 636  01de               L332:
 637                     ; 107 						else if(level_fractional_progress>game_level){ new_game_state=4; game_level++; }//level win
 639  01de 110b          	cp	a,(OFST-16,sp)
 640  01e0 230c          	jrule	L722
 643  01e2 a604          	ld	a,#4
 644  01e4 6b1a          	ld	(OFST-1,sp),a
 648  01e6 0c0b          	inc	(OFST-16,sp)
 650  01e8 2004          	jra	L722
 651  01ea               L132:
 652                     ; 109 						new_game_state=3;//lose
 654  01ea a603          	ld	a,#3
 655  01ec               LC001:
 656  01ec 6b1a          	ld	(OFST-1,sp),a
 658  01ee               L722:
 659                     ; 112 				effective_led_count=RGB_LED_COUNT;
 661  01ee a606          	ld	a,#6
 662  01f0 6b0c          	ld	(OFST-15,sp),a
 664                     ; 113 				if(get_button_event(0xFF,1,1)) new_game_state=6;
 666  01f2 cd033a        	call	LC007
 667  01f5 2603cc0329    	jreq	L521
 670  01fa a606          	ld	a,#6
 671  01fc 6b1a          	ld	(OFST-1,sp),a
 673  01fe cc0329        	jra	L521
 674  0201               L11:
 675                     ; 116 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1); new_game_state=0; }//restart game after timeout, and clear any button pushes registered during lose
 677  0201 7b10          	ld	a,(OFST-11,sp)
 678  0203 a504          	bcp	a,#4
 679  0205 2705          	jreq	L542
 682  0207 cd0358        	call	LC010
 685  020a 0f1a          	clr	(OFST-1,sp)
 687  020c               L542:
 688                     ; 117 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,0,255);//flash red LEDs
 690  020c 7b11          	ld	a,(OFST-10,sp)
 691  020e 2a3d          	jrpl	L162
 694  0210 0f1b          	clr	(OFST+0,sp)
 696  0212               L152:
 699  0212 4bff          	push	#255
 700  0214 7b1c          	ld	a,(OFST+1,sp)
 701  0216 5f            	clrw	x
 702  0217 95            	ld	xh,a
 703  0218 cd0000        	call	_set_rgb
 705  021b 84            	pop	a
 708  021c 0c1b          	inc	(OFST+0,sp)
 712  021e 7b1b          	ld	a,(OFST+0,sp)
 713  0220 a106          	cp	a,#6
 714  0222 25ee          	jrult	L152
 715                     ; 118 				effective_led_count=RGB_LED_COUNT;
 716                     ; 119 			}break;
 718  0224 2027          	jp	L162
 719  0226               L31:
 720                     ; 121 				if(game_state_elapsed_ms&0x0400){ get_button_event(0xFF,0xFF,1);  new_game_state=1; }//go to next level, clear any button pushse during transition
 722  0226 7b10          	ld	a,(OFST-11,sp)
 723  0228 a504          	bcp	a,#4
 724  022a 2707          	jreq	L752
 727  022c cd0358        	call	LC010
 730  022f a601          	ld	a,#1
 731  0231 6b1a          	ld	(OFST-1,sp),a
 733  0233               L752:
 734                     ; 122 				if(game_state_elapsed_ms&0x80) for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb(iter,1,255);//flash green LEDs
 736  0233 7b11          	ld	a,(OFST-10,sp)
 737  0235 2a16          	jrpl	L162
 740  0237 0f1b          	clr	(OFST+0,sp)
 742  0239               L362:
 745  0239 4bff          	push	#255
 746  023b 7b1c          	ld	a,(OFST+1,sp)
 747  023d ae0001        	ldw	x,#1
 748  0240 95            	ld	xh,a
 749  0241 cd0000        	call	_set_rgb
 751  0244 84            	pop	a
 754  0245 0c1b          	inc	(OFST+0,sp)
 758  0247 7b1b          	ld	a,(OFST+0,sp)
 759  0249 a106          	cp	a,#6
 760  024b 25ec          	jrult	L362
 761  024d               L162:
 762                     ; 123 				effective_led_count=RGB_LED_COUNT;
 765  024d a606          	ld	a,#6
 766                     ; 124 			}break;
 768  024f cc0327        	jp	LC005
 769  0252               L51:
 770                     ; 126 				if(is_new_state) submenu_index=0;
 772  0252 0d1b          	tnz	(OFST+0,sp)
 773  0254 2702          	jreq	L172
 776  0256 6b0a          	ld	(OFST-17,sp),a
 778  0258               L172:
 779                     ; 127 				effective_led_count=show_screensaver(submenu_index);
 781  0258 7b0a          	ld	a,(OFST-17,sp)
 782  025a cd03be        	call	_show_screensaver
 784  025d 6b0c          	ld	(OFST-15,sp),a
 786                     ; 128 				if(get_button_event(0xFF,0,1)) submenu_index++;//allow user to cycle through winning screensavers
 788  025f cd0346        	call	LC008
 789  0262 2702          	jreq	L372
 792  0264 0c0a          	inc	(OFST-17,sp)
 794  0266               L372:
 795                     ; 129 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press to get back to idle screen
 797  0266 cd033a        	call	LC007
 798  0269 2793          	jreq	L521
 801  026b 0f1a          	clr	(OFST-1,sp)
 803  026d cc0329        	jra	L521
 804  0270               L71:
 805                     ; 132 				set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
 807  0270 ae0505        	ldw	x,#1285
 808  0273 cd0366        	call	_set_element_hue
 810                     ; 133 				cursor=(((u16)game_state_elapsed_ms>>8)+(game_level>1?(((u16)game_state_elapsed_ms+(2<<6))>>8):0)
 810                     ; 134 									 			  								     +(game_level>3?(((u16)game_state_elapsed_ms+(3<<6))>>8):0))%RGB_LED_COUNT;//player position
 812  0276 7b0b          	ld	a,(OFST-16,sp)
 813  0278 a104          	cp	a,#4
 814  027a 2509          	jrult	L011
 815  027c 1e10          	ldw	x,(OFST-11,sp)
 816  027e 1c00c0        	addw	x,#192
 817  0281 4f            	clr	a
 818  0282 01            	rrwa	x,a
 819  0283 2001          	jra	L211
 820  0285               L011:
 821  0285 5f            	clrw	x
 822  0286               L211:
 823  0286 1f03          	ldw	(OFST-24,sp),x
 825  0288 7b0b          	ld	a,(OFST-16,sp)
 826  028a a102          	cp	a,#2
 827  028c 2509          	jrult	L411
 828  028e 1e10          	ldw	x,(OFST-11,sp)
 829  0290 1c0080        	addw	x,#128
 830  0293 4f            	clr	a
 831  0294 01            	rrwa	x,a
 832  0295 2001          	jra	L611
 833  0297               L411:
 834  0297 5f            	clrw	x
 835  0298               L611:
 836  0298 1f01          	ldw	(OFST-26,sp),x
 838  029a 4f            	clr	a
 839  029b 1e10          	ldw	x,(OFST-11,sp)
 840  029d 01            	rrwa	x,a
 841  029e 72fb01        	addw	x,(OFST-26,sp)
 842  02a1 72fb03        	addw	x,(OFST-24,sp)
 843  02a4 a606          	ld	a,#6
 844  02a6 62            	div	x,a
 845  02a7 5f            	clrw	x
 846  02a8 97            	ld	xl,a
 847  02a9 01            	rrwa	x,a
 848  02aa 6b12          	ld	(OFST-9,sp),a
 850                     ; 135 				if(is_target_element_placed) cursor=RGB_LED_COUNT-cursor-1;//reverse direction
 852  02ac 7b0d          	ld	a,(OFST-14,sp)
 853  02ae 2706          	jreq	L772
 856  02b0 a605          	ld	a,#5
 857  02b2 1012          	sub	a,(OFST-9,sp)
 858  02b4 6b12          	ld	(OFST-9,sp),a
 860  02b6               L772:
 861                     ; 136 				set_element_hue(cursor,game_level);
 863  02b6 7b0b          	ld	a,(OFST-16,sp)
 864  02b8 97            	ld	xl,a
 865  02b9 7b12          	ld	a,(OFST-9,sp)
 866  02bb 95            	ld	xh,a
 867  02bc cd0366        	call	_set_element_hue
 869                     ; 137 				if(get_button_event(0xFF,0,1)) new_game_state=7;//show user evaluation of performance
 871  02bf cd0346        	call	LC008
 872  02c2 2704          	jreq	L103
 875  02c4 a607          	ld	a,#7
 876  02c6 6b1a          	ld	(OFST-1,sp),a
 878  02c8               L103:
 879                     ; 138 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
 881  02c8 ad70          	call	LC007
 882  02ca 2702          	jreq	L303
 885  02cc 0f1a          	clr	(OFST-1,sp)
 887  02ce               L303:
 888                     ; 139 				effective_led_count=2;
 890  02ce a602          	ld	a,#2
 891                     ; 140 			}break;
 893  02d0 2055          	jp	LC005
 894  02d2               L12:
 895                     ; 142 				if(get_button_event(0xFF,0,1))
 897  02d2 ad72          	call	LC008
 898  02d4 2720          	jreq	L503
 899                     ; 144 					is_target_element_placed=!is_target_element_placed;//flip direction
 901  02d6 7b0d          	ld	a,(OFST-14,sp)
 902  02d8 2603          	jrne	L031
 903  02da 4c            	inc	a
 904  02db 2001          	jra	L231
 905  02dd               L031:
 906  02dd 4f            	clr	a
 907  02de               L231:
 908  02de 6b0d          	ld	(OFST-14,sp),a
 910                     ; 145 					if(cursor==(RGB_LED_COUNT-1)) game_level++;
 912  02e0 7b12          	ld	a,(OFST-9,sp)
 913  02e2 a105          	cp	a,#5
 914  02e4 2602          	jrne	L703
 917  02e6 0c0b          	inc	(OFST-16,sp)
 919  02e8               L703:
 920                     ; 146 					if(game_level==RGB_LED_COUNT) new_game_state=5;//win after all levels
 922  02e8 7b0b          	ld	a,(OFST-16,sp)
 923  02ea a106          	cp	a,#6
 924  02ec 2604          	jrne	L113
 927  02ee a605          	ld	a,#5
 929  02f0 2002          	jp	LC002
 930  02f2               L113:
 931                     ; 147 					else new_game_state=6; //go to next level, clear any button pushse during transition
 933  02f2 a606          	ld	a,#6
 934  02f4               LC002:
 935  02f4 6b1a          	ld	(OFST-1,sp),a
 937  02f6               L503:
 938                     ; 149 				if(get_button_event(0xFF,1,1)) new_game_state=0;//long press drops to idle mode
 940  02f6 ad42          	call	LC007
 941  02f8 2702          	jreq	L513
 944  02fa 0f1a          	clr	(OFST-1,sp)
 946  02fc               L513:
 947                     ; 150 				if(game_state_elapsed_ms&0x80)
 949  02fc 7b11          	ld	a,(OFST-10,sp)
 950  02fe 2a10          	jrpl	L713
 951                     ; 152 					set_element_hue(cursor,game_level);//cursor
 953  0300 7b0b          	ld	a,(OFST-16,sp)
 954  0302 97            	ld	xl,a
 955  0303 7b12          	ld	a,(OFST-9,sp)
 956  0305 95            	ld	xh,a
 957  0306 ad5e          	call	_set_element_hue
 959                     ; 153 					if(cursor!=(RGB_LED_COUNT-1)) set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);//goal post
 961  0308 7b12          	ld	a,(OFST-9,sp)
 962  030a a105          	cp	a,#5
 963  030c 2717          	jreq	L323
 966  030e 2010          	jp	L523
 967  0310               L713:
 968                     ; 155 					if(cursor==(RGB_LED_COUNT-1))
 970  0310 7b12          	ld	a,(OFST-9,sp)
 971  0312 a105          	cp	a,#5
 972  0314 260a          	jrne	L523
 973                     ; 157 						set_element_hue(RGB_LED_COUNT-2,RGB_LED_COUNT-1);
 975  0316 ae0405        	ldw	x,#1029
 976  0319 ad4b          	call	_set_element_hue
 978                     ; 158 						set_element_hue(0,RGB_LED_COUNT-1);
 980  031b ae0005        	ldw	x,#5
 983  031e 2003          	jp	LC003
 984  0320               L523:
 985                     ; 160 						set_element_hue(RGB_LED_COUNT-1,RGB_LED_COUNT-1);
 988  0320 ae0505        	ldw	x,#1285
 989  0323               LC003:
 990  0323 ad41          	call	_set_element_hue
 992  0325               L323:
 993                     ; 163 				effective_led_count=RGB_LED_COUNT;
 995                     ; 164 				effective_led_count=3;
 997  0325 a603          	ld	a,#3
 998  0327               LC005:
 999  0327 6b0c          	ld	(OFST-15,sp),a
1001                     ; 165 			}break;
1003  0329               L521:
1004                     ; 167 		flush_leds(effective_led_count);
1006  0329 7b0c          	ld	a,(OFST-15,sp)
1007  032b cd0000        	call	_flush_leds
1009  032e               L511:
1010                     ; 23 	while(is_application())
1012  032e cd0000        	call	_is_application
1014  0331 4d            	tnz	a
1015  0332 2703cc000e    	jrne	L311
1016                     ; 169 }
1019  0337 5b1b          	addw	sp,#27
1020  0339 81            	ret	
1021  033a               LC007:
1022  033a 4b01          	push	#1
1023  033c aeff01        	ldw	x,#65281
1024  033f cd0000        	call	_get_button_event
1026  0342 5b01          	addw	sp,#1
1027  0344 4d            	tnz	a
1028  0345 81            	ret	
1029  0346               LC008:
1030  0346 4b01          	push	#1
1031  0348 aeff00        	ldw	x,#65280
1032  034b cd0000        	call	_get_button_event
1034  034e 5b01          	addw	sp,#1
1035  0350 4d            	tnz	a
1036  0351 81            	ret	
1037  0352               LC009:
1038  0352 1c0014        	addw	x,#OFST-7
1039  0355 9f            	ld	a,xl
1040  0356 5e            	swapw	x
1041  0357 81            	ret	
1042  0358               LC010:
1043  0358 4b01          	push	#1
1044  035a aeffff        	ldw	x,#65535
1045  035d cd0000        	call	_get_button_event
1047  0360 84            	pop	a
1048  0361 81            	ret	
1049  0362               LC011:
1050  0362 97            	ld	xl,a
1051  0363 95            	ld	xh,a
1052  0364 2000          	jp	_set_element_hue
1100                     ; 171 void set_element_hue(u8 led_index,u8 color_index)
1100                     ; 172 {
1101                     	switch	.text
1102  0366               _set_element_hue:
1104  0366 89            	pushw	x
1105  0367 89            	pushw	x
1106       00000002      OFST:	set	2
1109                     ; 174 	switch(color_index){
1111  0368 9f            	ld	a,xl
1113                     ; 183 	  default: color=0xD555; break;//purple
1114  0369 4d            	tnz	a
1115  036a 2736          	jreq	L333
1116  036c 4a            	dec	a
1117  036d 2738          	jreq	L533
1118  036f 4a            	dec	a
1119  0370 273a          	jreq	L733
1120  0372 4a            	dec	a
1121  0373 273a          	jreq	L143
1122  0375 a002          	sub	a,#2
1123  0377 2705          	jreq	L133
1126  0379 aed555        	ldw	x,#54613
1129  037c 2034          	jra	L763
1130  037e               L133:
1131                     ; 175 		case 5: set_rgb(led_index,0,146);//dirty white
1133  037e 4b92          	push	#146
1134  0380 7b04          	ld	a,(OFST+2,sp)
1135  0382 5f            	clrw	x
1136  0383 95            	ld	xh,a
1137  0384 cd0000        	call	_set_rgb
1139  0387 84            	pop	a
1140                     ; 176 						set_rgb(led_index,1,146);//146**2 *3 = 255**2
1142  0388 4b92          	push	#146
1143  038a 7b04          	ld	a,(OFST+2,sp)
1144  038c ae0001        	ldw	x,#1
1145  038f 95            	ld	xh,a
1146  0390 cd0000        	call	_set_rgb
1148  0393 84            	pop	a
1149                     ; 177 						set_rgb(led_index,2,146);
1151  0394 4b92          	push	#146
1152  0396 7b04          	ld	a,(OFST+2,sp)
1153  0398 ae0002        	ldw	x,#2
1154  039b 95            	ld	xh,a
1155  039c cd0000        	call	_set_rgb
1157  039f 84            	pop	a
1158                     ; 178 						return;
1160  03a0 2019          	jra	L661
1161  03a2               L333:
1162                     ; 179 		case 0: color=0x2AAA; break;//yellow 
1164  03a2 ae2aaa        	ldw	x,#10922
1167  03a5 200b          	jra	L763
1168  03a7               L533:
1169                     ; 180 		case 1: color=0x5555; break;//green
1171  03a7 ae5555        	ldw	x,#21845
1174  03aa 2006          	jra	L763
1175  03ac               L733:
1176                     ; 181 	  case 2: color=0x0; break;//red
1178  03ac 5f            	clrw	x
1181  03ad 2003          	jra	L763
1182  03af               L143:
1183                     ; 182 	  case 3: color=0xAAAA; break;//blue
1185  03af aeaaaa        	ldw	x,#43690
1188  03b2               L763:
1189  03b2 1f01          	ldw	(OFST-1,sp),x
1191                     ; 185 	set_hue_max(led_index,color);
1193  03b4 89            	pushw	x
1194  03b5 7b05          	ld	a,(OFST+3,sp)
1195  03b7 cd0000        	call	_set_hue_max
1197  03ba 85            	popw	x
1198                     ; 186 }
1199  03bb               L661:
1202  03bb 5b04          	addw	sp,#4
1203  03bd 81            	ret	
1237                     ; 188 u8 show_screensaver(u8 screensaver_index)
1237                     ; 189 {
1238                     	switch	.text
1239  03be               _show_screensaver:
1241  03be 88            	push	a
1242       00000001      OFST:	set	1
1245                     ; 190 	switch(screensaver_index%SCREENSAVER_COUNT)
1247  03bf 5f            	clrw	x
1248  03c0 97            	ld	xl,a
1249  03c1 a607          	ld	a,#7
1250  03c3 cd0000        	call	c_smodx
1253                     ; 197 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1254  03c6 5a            	decw	x
1255  03c7 2711          	jreq	L173
1256  03c9 5a            	decw	x
1257  03ca 271b          	jreq	L373
1258  03cc 5a            	decw	x
1259  03cd 2726          	jreq	L573
1260  03cf 5a            	decw	x
1261  03d0 272a          	jreq	L773
1262  03d2 5a            	decw	x
1263  03d3 272e          	jreq	L104
1264  03d5 5a            	decw	x
1265  03d6 2739          	jreq	L304
1266  03d8 2046          	jra	L324
1267  03da               L173:
1268                     ; 192 		case 1: return set_frame_rainbow(0)+set_sparkles(0);
1270  03da 4f            	clr	a
1271  03db ad7d          	call	_set_sparkles
1273  03dd 6b01          	ld	(OFST+0,sp),a
1275  03df 4f            	clr	a
1276  03e0 ad44          	call	_set_frame_rainbow
1278  03e2 1b01          	add	a,(OFST+0,sp)
1281  03e4 5b01          	addw	sp,#1
1282  03e6 81            	ret	
1283  03e7               L373:
1284                     ; 193 		case 2: return set_frame_rainbow(0)+set_sparkles(1);
1286  03e7 a601          	ld	a,#1
1287  03e9 ad6f          	call	_set_sparkles
1289  03eb 6b01          	ld	(OFST+0,sp),a
1291  03ed 4f            	clr	a
1292  03ee ad36          	call	_set_frame_rainbow
1294  03f0 1b01          	add	a,(OFST+0,sp)
1297  03f2 5b01          	addw	sp,#1
1298  03f4 81            	ret	
1299  03f5               L573:
1300                     ; 194 		case 3: return set_sparkles(1);
1302  03f5 a601          	ld	a,#1
1303  03f7 ad61          	call	_set_sparkles
1307  03f9 5b01          	addw	sp,#1
1308  03fb 81            	ret	
1309  03fc               L773:
1310                     ; 195 		case 4: return set_frame_rainbow(1);
1312  03fc a601          	ld	a,#1
1313  03fe ad26          	call	_set_frame_rainbow
1317  0400 5b01          	addw	sp,#1
1318  0402 81            	ret	
1319  0403               L104:
1320                     ; 196 		case 5: return set_frame_rainbow(1)+set_sparkles(0);
1322  0403 4f            	clr	a
1323  0404 ad54          	call	_set_sparkles
1325  0406 6b01          	ld	(OFST+0,sp),a
1327  0408 a601          	ld	a,#1
1328  040a ad1a          	call	_set_frame_rainbow
1330  040c 1b01          	add	a,(OFST+0,sp)
1333  040e 5b01          	addw	sp,#1
1334  0410 81            	ret	
1335  0411               L304:
1336                     ; 197 		case 6: return set_frame_rainbow(1)+set_sparkles(1);
1338  0411 a601          	ld	a,#1
1339  0413 ad45          	call	_set_sparkles
1341  0415 6b01          	ld	(OFST+0,sp),a
1343  0417 a601          	ld	a,#1
1344  0419 ad0b          	call	_set_frame_rainbow
1346  041b 1b01          	add	a,(OFST+0,sp)
1349  041d 5b01          	addw	sp,#1
1350  041f 81            	ret	
1351  0420               L324:
1352                     ; 199 	return set_frame_rainbow(0);
1354  0420 4f            	clr	a
1355  0421 ad03          	call	_set_frame_rainbow
1359  0423 5b01          	addw	sp,#1
1360  0425 81            	ret	
1411                     ; 202 u8 set_frame_rainbow(bool is_circular)
1411                     ; 203 {
1412                     	switch	.text
1413  0426               _set_frame_rainbow:
1415  0426 88            	push	a
1416  0427 5203          	subw	sp,#3
1417       00000003      OFST:	set	3
1420                     ; 205 	u16 offset=0;
1422  0429 5f            	clrw	x
1423  042a 1f01          	ldw	(OFST-2,sp),x
1425                     ; 206 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1427  042c 0f03          	clr	(OFST+0,sp)
1429  042e               L744:
1430                     ; 208 		set_hue_max(iter,(u16)(millis()<<5)+offset);
1432  042e cd0000        	call	_millis
1434  0431 a605          	ld	a,#5
1435  0433 cd0000        	call	c_llsh
1437  0436 be02          	ldw	x,c_lreg+2
1438  0438 72fb01        	addw	x,(OFST-2,sp)
1439  043b 89            	pushw	x
1440  043c 7b05          	ld	a,(OFST+2,sp)
1441  043e cd0000        	call	_set_hue_max
1443  0441 85            	popw	x
1444                     ; 209 		if(is_circular) offset+=0x2AAB;
1446  0442 7b04          	ld	a,(OFST+1,sp)
1447  0444 2707          	jreq	L554
1450  0446 1e01          	ldw	x,(OFST-2,sp)
1451  0448 1c2aab        	addw	x,#10923
1452  044b 1f01          	ldw	(OFST-2,sp),x
1454  044d               L554:
1455                     ; 206 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1457  044d 0c03          	inc	(OFST+0,sp)
1461  044f 7b03          	ld	a,(OFST+0,sp)
1462  0451 a106          	cp	a,#6
1463  0453 25d9          	jrult	L744
1464                     ; 211 	return RGB_LED_COUNT;//max 2 colors ON at a time and one led for button pushes
1466  0455 a606          	ld	a,#6
1469  0457 5b04          	addw	sp,#4
1470  0459 81            	ret	
1521                     ; 214 u8 set_sparkles(bool is_fireworks)
1521                     ; 215 {
1522                     	switch	.text
1523  045a               _set_sparkles:
1525  045a 88            	push	a
1526  045b 5207          	subw	sp,#7
1527       00000007      OFST:	set	7
1530                     ; 218 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1532  045d 0f05          	clr	(OFST-2,sp)
1534  045f               L105:
1535                     ; 221 		state=(iter<<9)+millis();//randomize start phasing, and incremetn state in time
1537  045f cd0000        	call	_millis
1539  0462 96            	ldw	x,sp
1540  0463 5c            	incw	x
1541  0464 cd0000        	call	c_rtol
1544  0467 7b05          	ld	a,(OFST-2,sp)
1545  0469 97            	ld	xl,a
1546  046a 4f            	clr	a
1547  046b 02            	rlwa	x,a
1548  046c 58            	sllw	x
1549  046d cd0000        	call	c_itolx
1551  0470 96            	ldw	x,sp
1552  0471 5c            	incw	x
1553  0472 cd0000        	call	c_ladd
1555  0475 be02          	ldw	x,c_lreg+2
1556  0477 1f06          	ldw	(OFST-1,sp),x
1558                     ; 222 		state-=millis()>>(2+(iter&0x03));//randomize the state progression rates
1560  0479 cd0000        	call	_millis
1562  047c 7b05          	ld	a,(OFST-2,sp)
1563  047e a403          	and	a,#3
1564  0480 ab02          	add	a,#2
1565  0482 cd0000        	call	c_lursh
1567  0485 96            	ldw	x,sp
1568  0486 5c            	incw	x
1569  0487 cd0000        	call	c_rtol
1572  048a 1e06          	ldw	x,(OFST-1,sp)
1573  048c cd0000        	call	c_uitolx
1575  048f 96            	ldw	x,sp
1576  0490 5c            	incw	x
1577  0491 cd0000        	call	c_lsub
1579  0494 be02          	ldw	x,c_lreg+2
1580  0496 1f06          	ldw	(OFST-1,sp),x
1582                     ; 223 		state+=millis()>>(2+((iter>>2)&0x02));
1584  0498 cd0000        	call	_millis
1586  049b 7b05          	ld	a,(OFST-2,sp)
1587  049d a408          	and	a,#8
1588  049f 44            	srl	a
1589  04a0 44            	srl	a
1590  04a1 ab02          	add	a,#2
1591  04a3 cd0000        	call	c_lursh
1593  04a6 96            	ldw	x,sp
1594  04a7 5c            	incw	x
1595  04a8 cd0000        	call	c_rtol
1598  04ab 1e06          	ldw	x,(OFST-1,sp)
1599  04ad cd0000        	call	c_uitolx
1601  04b0 96            	ldw	x,sp
1602  04b1 5c            	incw	x
1603  04b2 cd0000        	call	c_ladd
1605  04b5 be02          	ldw	x,c_lreg+2
1606  04b7 1f06          	ldw	(OFST-1,sp),x
1608                     ; 225 		if(!(state&(is_fireworks?0x0800:0x1800)))//only ON 25% of the time for standard, dim ON 50% of the dime for fireworks
1610  04b9 0d08          	tnz	(OFST+1,sp)
1611  04bb 2705          	jreq	L632
1612  04bd ae0800        	ldw	x,#2048
1613  04c0 2003          	jra	L042
1614  04c2               L632:
1615  04c2 ae1800        	ldw	x,#6144
1616  04c5               L042:
1617  04c5 01            	rrwa	x,a
1618  04c6 1407          	and	a,(OFST+0,sp)
1619  04c8 01            	rrwa	x,a
1620  04c9 1406          	and	a,(OFST-1,sp)
1621  04cb 01            	rrwa	x,a
1622  04cc 5d            	tnzw	x
1623  04cd 2657          	jrne	L705
1624                     ; 228 			if(is_fireworks)
1626  04cf 7b08          	ld	a,(OFST+1,sp)
1627  04d1 2731          	jreq	L115
1628                     ; 229 				set_white(iter,(state>>10)&0x01?((~(state>>3))&0x7F):(((state>>6)&0x0F)==0x0F?0xFF:0));//bright flash at start, then fade from half brightness to OFF
1630  04d3 1e06          	ldw	x,(OFST-1,sp)
1631  04d5 4f            	clr	a
1632  04d6 01            	rrwa	x,a
1633  04d7 54            	srlw	x
1634  04d8 54            	srlw	x
1635  04d9 01            	rrwa	x,a
1636  04da a501          	bcp	a,#1
1637  04dc 270d          	jreq	L442
1638  04de 1e06          	ldw	x,(OFST-1,sp)
1639  04e0 54            	srlw	x
1640  04e1 54            	srlw	x
1641  04e2 54            	srlw	x
1642  04e3 01            	rrwa	x,a
1643  04e4 43            	cpl	a
1644  04e5 a47f          	and	a,#127
1645  04e7 5f            	clrw	x
1646  04e8 02            	rlwa	x,a
1647  04e9 2035          	jra	L462
1648  04eb               L442:
1649  04eb 1e06          	ldw	x,(OFST-1,sp)
1650  04ed a606          	ld	a,#6
1651  04ef               L252:
1652  04ef 54            	srlw	x
1653  04f0 4a            	dec	a
1654  04f1 26fc          	jrne	L252
1655  04f3 01            	rrwa	x,a
1656  04f4 a40f          	and	a,#15
1657  04f6 5f            	clrw	x
1658  04f7 02            	rlwa	x,a
1659  04f8 a3000f        	cpw	x,#15
1660  04fb 2604          	jrne	L052
1661  04fd               LC014:
1662  04fd a6ff          	ld	a,#255
1663  04ff 201e          	jra	L072
1664  0501               L052:
1665  0501 4f            	clr	a
1668  0502 201b          	jp	L072
1669  0504               L115:
1670                     ; 231 				set_white(iter,(state>>10)&0x01?(~(state>>2)):((state>>8)&0x03?0xFF:state));//sharp rise and hold before fading off slowly
1672  0504 1e06          	ldw	x,(OFST-1,sp)
1673  0506 01            	rrwa	x,a
1674  0507 54            	srlw	x
1675  0508 54            	srlw	x
1676  0509 01            	rrwa	x,a
1677  050a a501          	bcp	a,#1
1678  050c 2707          	jreq	L262
1679  050e 1e06          	ldw	x,(OFST-1,sp)
1680  0510 54            	srlw	x
1681  0511 54            	srlw	x
1682  0512 53            	cplw	x
1683  0513 200b          	jra	L462
1684  0515               L262:
1685  0515 1e06          	ldw	x,(OFST-1,sp)
1686  0517 4f            	clr	a
1687  0518 02            	rlwa	x,a
1688  0519 a503          	bcp	a,#3
1689  051b 26e0          	jrne	LC014
1690  051d 7b07          	ld	a,(OFST+0,sp)
1691  051f               L072:
1692  051f 97            	ld	xl,a
1693  0520               L462:
1694  0520 7b05          	ld	a,(OFST-2,sp)
1695  0522 95            	ld	xh,a
1696  0523 cd0000        	call	_set_white
1698  0526               L705:
1699                     ; 218 	for(iter=0;iter<WHITE_LED_COUNT;iter++)
1701  0526 0c05          	inc	(OFST-2,sp)
1705  0528 7b05          	ld	a,(OFST-2,sp)
1706  052a a10c          	cp	a,#12
1707  052c 2403cc045f    	jrult	L105
1708                     ; 234 	return WHITE_LED_COUNT/4;
1710  0531 a603          	ld	a,#3
1713  0533 5b08          	addw	sp,#8
1714  0535 81            	ret	
1727                     	xdef	_set_element_hue
1728                     	xdef	_show_screensaver
1729                     	xdef	_set_sparkles
1730                     	xdef	_set_frame_rainbow
1731                     	xdef	_run_application
1732                     	xref	_is_application
1733                     	xref	_get_random
1734                     	xref	_get_button_event
1735                     	xref	_set_hue_max
1736                     	xref	_flush_leds
1737                     	xref	_set_white
1738                     	xref	_set_rgb
1739                     	xref	_millis
1740                     	xref.b	c_lreg
1741                     	xref.b	c_x
1760                     	xref	c_uitolx
1761                     	xref	c_ladd
1762                     	xref	c_itolx
1763                     	xref	c_llsh
1764                     	xref	c_smodx
1765                     	xref	c_lursh
1766                     	xref	c_ltor
1767                     	xref	c_lsub
1768                     	xref	c_rtol
1769                     	end
