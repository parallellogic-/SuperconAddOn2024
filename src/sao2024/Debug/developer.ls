   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  50                     ; 10 void setup_developer()
  50                     ; 11 {
  52                     	switch	.text
  53  0000               _setup_developer:
  57                     ; 13 	get_button_event(0xFF,0xFF,1);//clear_button_events();
  59  0000 4b01          	push	#1
  60  0002 aeffff        	ldw	x,#65535
  61  0005 cd0000        	call	_get_button_event
  63  0008 84            	pop	a
  64                     ; 15 	set_debug(255);//show only one debug led ON
  66  0009 a6ff          	ld	a,#255
  67  000b cd0000        	call	_set_debug
  69                     ; 16 	flush_leds(1);
  71  000e a601          	ld	a,#1
  73                     ; 17 }
  76  0010 cc0000        	jp	_flush_leds
 103                     ; 19 void run_developer()
 103                     ; 20 {
 104                     	switch	.text
 105  0013               _run_developer:
 109                     ; 24 	setup_developer();
 111  0013 adeb          	call	_setup_developer
 113  0015               L13:
 114                     ; 27 		set_debug(((millis()>>8)&0x01)?0xFF:0);
 116  0015 cd0000        	call	_millis
 118  0018 a608          	ld	a,#8
 119  001a cd0000        	call	c_lursh
 121  001d 7201000304    	btjf	c_lreg+3,#0,L22
 122  0022 a6ff          	ld	a,#255
 123  0024 2001          	jra	L62
 124  0026               L22:
 125  0026 4f            	clr	a
 126  0027               L62:
 127  0027 cd0000        	call	_set_debug
 129                     ; 28 		flush_leds(1);
 131  002a a601          	ld	a,#1
 132  002c cd0000        	call	_flush_leds
 135  002f 20e4          	jra	L13
 243                     ; 44 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 243                     ; 45 {
 244                     	switch	.text
 245  0031               _get_terminal_command:
 247  0031 89            	pushw	x
 248  0032 5207          	subw	sp,#7
 249       00000007      OFST:	set	7
 252                     ; 46 	bool is_new_line=0;
 254  0034 0f05          	clr	(OFST-2,sp)
 256                     ; 47 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
 258  0036 0f06          	clr	(OFST-1,sp)
 261  0038 cc00d2        	jra	L311
 262  003b               L701:
 263                     ; 51 		if(Serial_available())
 265  003b cd0000        	call	_Serial_available
 267  003e 4d            	tnz	a
 268  003f 27f7          	jreq	L311
 269                     ; 53 			input_char=Serial_read_char();
 271  0041 cd0000        	call	_Serial_read_char
 273  0044 6b07          	ld	(OFST+0,sp),a
 275                     ; 54 			if(input_char=='\n') is_new_line=1;//break on new line character found
 277  0046 a10a          	cp	a,#10
 278  0048 2607          	jrne	L121
 281  004a a601          	ld	a,#1
 282  004c 6b05          	ld	(OFST-2,sp),a
 285  004e cc00d2        	jra	L311
 286  0051               L121:
 287                     ; 55 			else if((*command)==0) (*command)=input_char;
 289  0051 1e08          	ldw	x,(OFST+1,sp)
 290  0053 7d            	tnz	(x)
 293  0054 277b          	jreq	LC001
 294                     ; 57 				if('0'<=input_char && input_char<='9')
 296  0056 a130          	cp	a,#48
 297  0058 255f          	jrult	L131
 299  005a a13a          	cp	a,#58
 300  005c 245b          	jruge	L131
 301                     ; 59 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
 303  005e 0d06          	tnz	(OFST-1,sp)
 304  0060 2611          	jrne	L331
 307  0062 1e0e          	ldw	x,(OFST+7,sp)
 308  0064 ad76          	call	LC002
 309  0066 72fb0c        	addw	x,(OFST+5,sp)
 310  0069 4f            	clr	a
 311  006a e703          	ld	(3,x),a
 312  006c e702          	ld	(2,x),a
 313  006e e701          	ld	(1,x),a
 314  0070 f7            	ld	(x),a
 315  0071 7b07          	ld	a,(OFST+0,sp)
 316  0073               L331:
 317                     ; 60 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
 319  0073 5f            	clrw	x
 320  0074 97            	ld	xl,a
 321  0075 1d0030        	subw	x,#48
 322  0078 cd0000        	call	c_itolx
 324  007b 96            	ldw	x,sp
 325  007c 5c            	incw	x
 326  007d cd0000        	call	c_rtol
 329  0080 1e0e          	ldw	x,(OFST+7,sp)
 330  0082 ad58          	call	LC002
 331  0084 72fb0c        	addw	x,(OFST+5,sp)
 332  0087 cd0000        	call	c_ltor
 334  008a 1e0e          	ldw	x,(OFST+7,sp)
 335  008c ad4e          	call	LC002
 336  008e 72fb0c        	addw	x,(OFST+5,sp)
 337  0091 e603          	ld	a,(3,x)
 338  0093 5f            	clrw	x
 339  0094 97            	ld	xl,a
 340  0095 1c0003        	addw	x,#3
 341  0098 01            	rrwa	x,a
 342  0099 cd0000        	call	c_llsh
 344  009c 3803          	sll	c_lreg+3
 345  009e 3902          	rlc	c_lreg+2
 346  00a0 3901          	rlc	c_lreg+1
 347  00a2 96            	ldw	x,sp
 348  00a3 3900          	rlc	c_lreg
 349  00a5 5c            	incw	x
 350  00a6 cd0000        	call	c_ladd
 352  00a9 1e0e          	ldw	x,(OFST+7,sp)
 353  00ab ad2f          	call	LC002
 354  00ad 72fb0c        	addw	x,(OFST+5,sp)
 355  00b0 cd0000        	call	c_rtol
 357                     ; 61 					is_any_input=1;
 359  00b3 a601          	ld	a,#1
 360  00b5 6b06          	ld	(OFST-1,sp),a
 363  00b7 2019          	jra	L311
 364  00b9               L131:
 365                     ; 63 					if(is_any_input)
 367  00b9 7b06          	ld	a,(OFST-1,sp)
 368  00bb 2715          	jreq	L311
 369                     ; 65 						(*parameter_count)++;
 371  00bd 1e0e          	ldw	x,(OFST+7,sp)
 372  00bf 7c            	inc	(x)
 373                     ; 66 						is_any_input=0;
 375  00c0 0f06          	clr	(OFST-1,sp)
 377                     ; 67 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
 379  00c2 905f          	clrw	y
 380  00c4 f6            	ld	a,(x)
 381  00c5 9097          	ld	yl,a
 382  00c7 a603          	ld	a,#3
 383  00c9 9062          	div	y,a
 384  00cb 905f          	clrw	y
 385  00cd 9097          	ld	yl,a
 386  00cf 9001          	rrwa	y,a
 387  00d1               LC001:
 389  00d1 f7            	ld	(x),a
 390  00d2               L311:
 391                     ; 49 	while(!is_new_line)
 393  00d2 7b05          	ld	a,(OFST-2,sp)
 394  00d4 2603cc003b    	jreq	L701
 395                     ; 73 }
 398  00d9 5b09          	addw	sp,#9
 399  00db 81            	ret	
 400  00dc               LC002:
 401  00dc f6            	ld	a,(x)
 402  00dd 97            	ld	xl,a
 403  00de a604          	ld	a,#4
 404  00e0 42            	mul	x,a
 405  00e1 81            	ret	
 486                     .const:	section	.text
 487  0000               L05:
 488  0000 00000006      	dc.l	6
 489  0004               L25:
 490  0004 00000003      	dc.l	3
 491  0008               L45:
 492  0008 000000ff      	dc.l	255
 493  000c               L26:
 494  000c 0000000c      	dc.l	12
 495                     ; 75 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 495                     ; 76 {
 496                     	switch	.text
 497  00e2               _execute_terminal_command:
 499  00e2 88            	push	a
 500  00e3 88            	push	a
 501       00000001      OFST:	set	1
 504                     ; 78 	bool is_valid=0;
 506  00e4 0f01          	clr	(OFST+0,sp)
 508                     ; 79 	switch(command)
 511                     ; 135 		}break;
 512  00e6 a065          	sub	a,#101
 513  00e8 2603cc01c4    	jreq	L312
 514  00ed a007          	sub	a,#7
 515  00ef 2748          	jreq	L741
 516  00f1 a004          	sub	a,#4
 517  00f3 270e          	jreq	L141
 518  00f5 a004          	sub	a,#4
 519  00f7 273a          	jreq	L341
 520  00f9 a003          	sub	a,#3
 521  00fb 2603cc0188    	jreq	L151
 522  0100 cc01c4        	jra	L312
 523  0103               L141:
 524                     ; 82 			Serial_print_char(command);
 526  0103 7b02          	ld	a,(OFST+1,sp)
 527  0105 cd0000        	call	_Serial_print_char
 529                     ; 83 			for(iter=0;iter<parameter_count;iter++)
 531  0108 0f01          	clr	(OFST+0,sp)
 534  010a 201d          	jra	L122
 535  010c               L512:
 536                     ; 85 				Serial_print_char(' ');
 538  010c a620          	ld	a,#32
 539  010e cd0000        	call	_Serial_print_char
 541                     ; 86 				Serial_print_u32((*parameters)[iter]);
 543  0111 7b01          	ld	a,(OFST+0,sp)
 544  0113 97            	ld	xl,a
 545  0114 a604          	ld	a,#4
 546  0116 42            	mul	x,a
 547  0117 72fb05        	addw	x,(OFST+4,sp)
 548  011a 9093          	ldw	y,x
 549  011c ee02          	ldw	x,(2,x)
 550  011e 89            	pushw	x
 551  011f 93            	ldw	x,y
 552  0120 fe            	ldw	x,(x)
 553  0121 89            	pushw	x
 554  0122 cd0000        	call	_Serial_print_u32
 556  0125 5b04          	addw	sp,#4
 557                     ; 83 			for(iter=0;iter<parameter_count;iter++)
 559  0127 0c01          	inc	(OFST+0,sp)
 561  0129               L122:
 564  0129 7b01          	ld	a,(OFST+0,sp)
 565  012b 1107          	cp	a,(OFST+6,sp)
 566  012d 25dd          	jrult	L512
 567                     ; 88 			is_valid=1;
 569  012f a601          	ld	a,#1
 570                     ; 89 		}break;
 572  0131 2001          	jp	LC004
 573  0133               L341:
 574                     ; 93 			is_valid=1;
 576  0133 4c            	inc	a
 577  0134               LC004:
 578  0134 6b01          	ld	(OFST+0,sp),a
 580                     ; 94 		}break;
 582  0136 cc01c4        	jra	L312
 583                     ; 96 			if(parameter_count==1)
 585  0139               L741:
 586                     ; 114 			is_valid=1;
 588  0139 4c            	inc	a
 589  013a 6b01          	ld	(OFST+0,sp),a
 591                     ; 115 			if(parameter_count<3) is_valid=0;
 593  013c 7b07          	ld	a,(OFST+6,sp)
 594  013e a103          	cp	a,#3
 595  0140 2402          	jruge	L722
 598  0142 0f01          	clr	(OFST+0,sp)
 600  0144               L722:
 601                     ; 116 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 603  0144 1e05          	ldw	x,(OFST+4,sp)
 604  0146 cd0000        	call	c_ltor
 606  0149 ae0000        	ldw	x,#L05
 607  014c cd0000        	call	c_lcmp
 609  014f 2502          	jrult	L132
 612  0151 0f01          	clr	(OFST+0,sp)
 614  0153               L132:
 615                     ; 117 			if((*parameters)[1]>=3) is_valid=0;
 617  0153 1e05          	ldw	x,(OFST+4,sp)
 618  0155 1c0004        	addw	x,#4
 619  0158 cd0000        	call	c_ltor
 621  015b ae0004        	ldw	x,#L25
 622  015e cd0000        	call	c_lcmp
 624  0161 2502          	jrult	L332
 627  0163 0f01          	clr	(OFST+0,sp)
 629  0165               L332:
 630                     ; 118 			if((*parameters)[2]>=255) is_valid=0;
 632  0165 1e05          	ldw	x,(OFST+4,sp)
 633  0167 1c0008        	addw	x,#8
 634  016a ad67          	call	LC005
 636  016c 2502          	jrult	L532
 639  016e 0f01          	clr	(OFST+0,sp)
 641  0170               L532:
 642                     ; 119 			if(is_valid)
 644  0170 7b01          	ld	a,(OFST+0,sp)
 645  0172 2750          	jreq	L312
 646                     ; 121 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 648  0174 1e05          	ldw	x,(OFST+4,sp)
 649  0176 e60b          	ld	a,(11,x)
 650  0178 88            	push	a
 651  0179 e607          	ld	a,(7,x)
 652  017b 1606          	ldw	y,(OFST+5,sp)
 653  017d 97            	ld	xl,a
 654  017e 90e603        	ld	a,(3,y)
 655  0181 95            	ld	xh,a
 656  0182 cd0000        	call	_set_rgb
 658  0185 84            	pop	a
 659                     ; 122 				flush_leds(2);//1 RGB led element and 1 for status led
 661  0186 2037          	jp	LC003
 662  0188               L151:
 663                     ; 126 			is_valid=1;
 665  0188 4c            	inc	a
 666  0189 6b01          	ld	(OFST+0,sp),a
 668                     ; 127 			if(parameter_count<2) is_valid=0;
 670  018b 7b07          	ld	a,(OFST+6,sp)
 671  018d a102          	cp	a,#2
 672  018f 2402          	jruge	L142
 675  0191 0f01          	clr	(OFST+0,sp)
 677  0193               L142:
 678                     ; 128 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 680  0193 1e05          	ldw	x,(OFST+4,sp)
 681  0195 cd0000        	call	c_ltor
 683  0198 ae000c        	ldw	x,#L26
 684  019b cd0000        	call	c_lcmp
 686  019e 2502          	jrult	L342
 689  01a0 0f01          	clr	(OFST+0,sp)
 691  01a2               L342:
 692                     ; 129 			if((*parameters)[1]>=255) is_valid=0;
 694  01a2 1e05          	ldw	x,(OFST+4,sp)
 695  01a4 1c0004        	addw	x,#4
 696  01a7 ad2a          	call	LC005
 698  01a9 2502          	jrult	L542
 701  01ab 0f01          	clr	(OFST+0,sp)
 703  01ad               L542:
 704                     ; 130 			if(is_valid)
 706  01ad 7b01          	ld	a,(OFST+0,sp)
 707  01af 2713          	jreq	L312
 708                     ; 132 				set_white((*parameters)[0],(*parameters)[1]);
 710  01b1 1e05          	ldw	x,(OFST+4,sp)
 711  01b3 e607          	ld	a,(7,x)
 712  01b5 1605          	ldw	y,(OFST+4,sp)
 713  01b7 97            	ld	xl,a
 714  01b8 90e603        	ld	a,(3,y)
 715  01bb 95            	ld	xh,a
 716  01bc cd0000        	call	_set_white
 718                     ; 133 				flush_leds(2);//1 RGB led element and 1 for status led
 720  01bf               LC003:
 722  01bf a602          	ld	a,#2
 723  01c1 cd0000        	call	_flush_leds
 725  01c4               L312:
 726                     ; 137 	if(!is_valid) Serial_print_string("Invalid. h");
 728  01c4 7b01          	ld	a,(OFST+0,sp)
 729  01c6 2606          	jrne	L152
 732  01c8 ae0010        	ldw	x,#L352
 733  01cb cd0000        	call	_Serial_print_string
 735  01ce               L152:
 736                     ; 138 	Serial_newline();
 738  01ce cd0000        	call	_Serial_newline
 740                     ; 139 }
 743  01d1 85            	popw	x
 744  01d2 81            	ret	
 745  01d3               LC005:
 746  01d3 cd0000        	call	c_ltor
 748  01d6 ae0008        	ldw	x,#L45
 749  01d9 cc0000        	jp	c_lcmp
 762                     	xref	_Serial_print_u32
 763                     	xref	_Serial_read_char
 764                     	xref	_Serial_available
 765                     	xref	_Serial_newline
 766                     	xref	_Serial_print_string
 767                     	xref	_Serial_print_char
 768                     	xdef	_execute_terminal_command
 769                     	xdef	_get_terminal_command
 770                     	xdef	_run_developer
 771                     	xdef	_setup_developer
 772                     	xref	_get_button_event
 773                     	xref	_flush_leds
 774                     	xref	_set_debug
 775                     	xref	_set_white
 776                     	xref	_set_rgb
 777                     	xref	_millis
 778                     	switch	.const
 779  0010               L352:
 780  0010 496e76616c69  	dc.b	"Invalid. h",0
 781                     	xref.b	c_lreg
 801                     	xref	c_lcmp
 802                     	xref	c_ladd
 803                     	xref	c_rtol
 804                     	xref	c_itolx
 805                     	xref	c_llsh
 806                     	xref	c_ltor
 807                     	xref	c_lursh
 808                     	end
