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
 114                     ; 19 void run_developer()
 114                     ; 20 {
 115                     	switch	.text
 116  0013               _run_developer:
 118  0013 5208          	subw	sp,#8
 119       00000008      OFST:	set	8
 122                     ; 25 	setup_developer();
 124  0015 ade9          	call	_setup_developer
 126  0017               L73:
 127                     ; 28 		start_ms=millis();
 129  0017 cd0000        	call	_millis
 131  001a 96            	ldw	x,sp
 132  001b 1c0005        	addw	x,#OFST-3
 133  001e cd0000        	call	c_rtol
 136                     ; 29 		set_debug(((start_ms>>8)&0x01)?0xFF:0);
 138  0021 7b07          	ld	a,(OFST-1,sp)
 139  0023 a501          	bcp	a,#1
 140  0025 2704          	jreq	L42
 141  0027 a6ff          	ld	a,#255
 142  0029 2001          	jra	L62
 143  002b               L42:
 144  002b 4f            	clr	a
 145  002c               L62:
 146  002c cd0000        	call	_set_debug
 149  002f               L54:
 150                     ; 30 		while(((millis()>>7)&0x01)==((start_ms>>7)&0x01)){}
 152  002f 7b08          	ld	a,(OFST+0,sp)
 153  0031 49            	rlc	a
 154  0032 4f            	clr	a
 155  0033 49            	rlc	a
 156  0034 b703          	ld	c_lreg+3,a
 157  0036 3f02          	clr	c_lreg+2
 158  0038 3f01          	clr	c_lreg+1
 159  003a 3f00          	clr	c_lreg
 160  003c 96            	ldw	x,sp
 161  003d 5c            	incw	x
 162  003e cd0000        	call	c_rtol
 165  0041 cd0000        	call	_millis
 167  0044 a607          	ld	a,#7
 168  0046 cd0000        	call	c_lursh
 170  0049 b603          	ld	a,c_lreg+3
 171  004b a401          	and	a,#1
 172  004d b703          	ld	c_lreg+3,a
 173  004f 3f02          	clr	c_lreg+2
 174  0051 3f01          	clr	c_lreg+1
 175  0053 3f00          	clr	c_lreg
 176  0055 96            	ldw	x,sp
 177  0056 5c            	incw	x
 178  0057 cd0000        	call	c_lcmp
 180  005a 27d3          	jreq	L54
 181                     ; 31 		flush_leds(1);
 183  005c a601          	ld	a,#1
 184  005e cd0000        	call	_flush_leds
 187  0061 20b4          	jra	L73
 295                     ; 47 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 295                     ; 48 {
 296                     	switch	.text
 297  0063               _get_terminal_command:
 299  0063 89            	pushw	x
 300  0064 5207          	subw	sp,#7
 301       00000007      OFST:	set	7
 304                     ; 49 	bool is_new_line=0;
 306  0066 0f05          	clr	(OFST-2,sp)
 308                     ; 50 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
 310  0068 0f06          	clr	(OFST-1,sp)
 313  006a cc0104        	jra	L721
 314  006d               L321:
 315                     ; 54 		if(Serial_available())
 317  006d cd0000        	call	_Serial_available
 319  0070 4d            	tnz	a
 320  0071 27f7          	jreq	L721
 321                     ; 56 			input_char=Serial_read_char();
 323  0073 cd0000        	call	_Serial_read_char
 325  0076 6b07          	ld	(OFST+0,sp),a
 327                     ; 57 			if(input_char=='\n') is_new_line=1;//break on new line character found
 329  0078 a10a          	cp	a,#10
 330  007a 2607          	jrne	L531
 333  007c a601          	ld	a,#1
 334  007e 6b05          	ld	(OFST-2,sp),a
 337  0080 cc0104        	jra	L721
 338  0083               L531:
 339                     ; 58 			else if((*command)==0) (*command)=input_char;
 341  0083 1e08          	ldw	x,(OFST+1,sp)
 342  0085 7d            	tnz	(x)
 345  0086 277b          	jreq	LC001
 346                     ; 60 				if('0'<=input_char && input_char<='9')
 348  0088 a130          	cp	a,#48
 349  008a 255f          	jrult	L541
 351  008c a13a          	cp	a,#58
 352  008e 245b          	jruge	L541
 353                     ; 62 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
 355  0090 0d06          	tnz	(OFST-1,sp)
 356  0092 2611          	jrne	L741
 359  0094 1e0e          	ldw	x,(OFST+7,sp)
 360  0096 ad76          	call	LC002
 361  0098 72fb0c        	addw	x,(OFST+5,sp)
 362  009b 4f            	clr	a
 363  009c e703          	ld	(3,x),a
 364  009e e702          	ld	(2,x),a
 365  00a0 e701          	ld	(1,x),a
 366  00a2 f7            	ld	(x),a
 367  00a3 7b07          	ld	a,(OFST+0,sp)
 368  00a5               L741:
 369                     ; 63 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
 371  00a5 5f            	clrw	x
 372  00a6 97            	ld	xl,a
 373  00a7 1d0030        	subw	x,#48
 374  00aa cd0000        	call	c_itolx
 376  00ad 96            	ldw	x,sp
 377  00ae 5c            	incw	x
 378  00af cd0000        	call	c_rtol
 381  00b2 1e0e          	ldw	x,(OFST+7,sp)
 382  00b4 ad58          	call	LC002
 383  00b6 72fb0c        	addw	x,(OFST+5,sp)
 384  00b9 cd0000        	call	c_ltor
 386  00bc 1e0e          	ldw	x,(OFST+7,sp)
 387  00be ad4e          	call	LC002
 388  00c0 72fb0c        	addw	x,(OFST+5,sp)
 389  00c3 e603          	ld	a,(3,x)
 390  00c5 5f            	clrw	x
 391  00c6 97            	ld	xl,a
 392  00c7 1c0003        	addw	x,#3
 393  00ca 01            	rrwa	x,a
 394  00cb cd0000        	call	c_llsh
 396  00ce 3803          	sll	c_lreg+3
 397  00d0 3902          	rlc	c_lreg+2
 398  00d2 3901          	rlc	c_lreg+1
 399  00d4 96            	ldw	x,sp
 400  00d5 3900          	rlc	c_lreg
 401  00d7 5c            	incw	x
 402  00d8 cd0000        	call	c_ladd
 404  00db 1e0e          	ldw	x,(OFST+7,sp)
 405  00dd ad2f          	call	LC002
 406  00df 72fb0c        	addw	x,(OFST+5,sp)
 407  00e2 cd0000        	call	c_rtol
 409                     ; 64 					is_any_input=1;
 411  00e5 a601          	ld	a,#1
 412  00e7 6b06          	ld	(OFST-1,sp),a
 415  00e9 2019          	jra	L721
 416  00eb               L541:
 417                     ; 66 					if(is_any_input)
 419  00eb 7b06          	ld	a,(OFST-1,sp)
 420  00ed 2715          	jreq	L721
 421                     ; 68 						(*parameter_count)++;
 423  00ef 1e0e          	ldw	x,(OFST+7,sp)
 424  00f1 7c            	inc	(x)
 425                     ; 69 						is_any_input=0;
 427  00f2 0f06          	clr	(OFST-1,sp)
 429                     ; 70 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
 431  00f4 905f          	clrw	y
 432  00f6 f6            	ld	a,(x)
 433  00f7 9097          	ld	yl,a
 434  00f9 a603          	ld	a,#3
 435  00fb 9062          	div	y,a
 436  00fd 905f          	clrw	y
 437  00ff 9097          	ld	yl,a
 438  0101 9001          	rrwa	y,a
 439  0103               LC001:
 441  0103 f7            	ld	(x),a
 442  0104               L721:
 443                     ; 52 	while(!is_new_line)
 445  0104 7b05          	ld	a,(OFST-2,sp)
 446  0106 2603cc006d    	jreq	L321
 447                     ; 76 }
 450  010b 5b09          	addw	sp,#9
 451  010d 81            	ret	
 452  010e               LC002:
 453  010e f6            	ld	a,(x)
 454  010f 97            	ld	xl,a
 455  0110 a604          	ld	a,#4
 456  0112 42            	mul	x,a
 457  0113 81            	ret	
 538                     .const:	section	.text
 539  0000               L25:
 540  0000 00000006      	dc.l	6
 541  0004               L45:
 542  0004 00000003      	dc.l	3
 543  0008               L65:
 544  0008 000000ff      	dc.l	255
 545  000c               L46:
 546  000c 0000000c      	dc.l	12
 547                     ; 78 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 547                     ; 79 {
 548                     	switch	.text
 549  0114               _execute_terminal_command:
 551  0114 88            	push	a
 552  0115 88            	push	a
 553       00000001      OFST:	set	1
 556                     ; 81 	bool is_valid=0;
 558  0116 0f01          	clr	(OFST+0,sp)
 560                     ; 82 	switch(command)
 563                     ; 138 		}break;
 564  0118 a065          	sub	a,#101
 565  011a 2603cc01f6    	jreq	L722
 566  011f a007          	sub	a,#7
 567  0121 2748          	jreq	L361
 568  0123 a004          	sub	a,#4
 569  0125 270e          	jreq	L551
 570  0127 a004          	sub	a,#4
 571  0129 273a          	jreq	L751
 572  012b a003          	sub	a,#3
 573  012d 2603cc01ba    	jreq	L561
 574  0132 cc01f6        	jra	L722
 575  0135               L551:
 576                     ; 85 			Serial_print_char(command);
 578  0135 7b02          	ld	a,(OFST+1,sp)
 579  0137 cd0000        	call	_Serial_print_char
 581                     ; 86 			for(iter=0;iter<parameter_count;iter++)
 583  013a 0f01          	clr	(OFST+0,sp)
 586  013c 201d          	jra	L532
 587  013e               L132:
 588                     ; 88 				Serial_print_char(' ');
 590  013e a620          	ld	a,#32
 591  0140 cd0000        	call	_Serial_print_char
 593                     ; 89 				Serial_print_u32((*parameters)[iter]);
 595  0143 7b01          	ld	a,(OFST+0,sp)
 596  0145 97            	ld	xl,a
 597  0146 a604          	ld	a,#4
 598  0148 42            	mul	x,a
 599  0149 72fb05        	addw	x,(OFST+4,sp)
 600  014c 9093          	ldw	y,x
 601  014e ee02          	ldw	x,(2,x)
 602  0150 89            	pushw	x
 603  0151 93            	ldw	x,y
 604  0152 fe            	ldw	x,(x)
 605  0153 89            	pushw	x
 606  0154 cd0000        	call	_Serial_print_u32
 608  0157 5b04          	addw	sp,#4
 609                     ; 86 			for(iter=0;iter<parameter_count;iter++)
 611  0159 0c01          	inc	(OFST+0,sp)
 613  015b               L532:
 616  015b 7b01          	ld	a,(OFST+0,sp)
 617  015d 1107          	cp	a,(OFST+6,sp)
 618  015f 25dd          	jrult	L132
 619                     ; 91 			is_valid=1;
 621  0161 a601          	ld	a,#1
 622                     ; 92 		}break;
 624  0163 2001          	jp	LC004
 625  0165               L751:
 626                     ; 96 			is_valid=1;
 628  0165 4c            	inc	a
 629  0166               LC004:
 630  0166 6b01          	ld	(OFST+0,sp),a
 632                     ; 97 		}break;
 634  0168 cc01f6        	jra	L722
 635                     ; 99 			if(parameter_count==1)
 637  016b               L361:
 638                     ; 117 			is_valid=1;
 640  016b 4c            	inc	a
 641  016c 6b01          	ld	(OFST+0,sp),a
 643                     ; 118 			if(parameter_count<3) is_valid=0;
 645  016e 7b07          	ld	a,(OFST+6,sp)
 646  0170 a103          	cp	a,#3
 647  0172 2402          	jruge	L342
 650  0174 0f01          	clr	(OFST+0,sp)
 652  0176               L342:
 653                     ; 119 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 655  0176 1e05          	ldw	x,(OFST+4,sp)
 656  0178 cd0000        	call	c_ltor
 658  017b ae0000        	ldw	x,#L25
 659  017e cd0000        	call	c_lcmp
 661  0181 2502          	jrult	L542
 664  0183 0f01          	clr	(OFST+0,sp)
 666  0185               L542:
 667                     ; 120 			if((*parameters)[1]>=3) is_valid=0;
 669  0185 1e05          	ldw	x,(OFST+4,sp)
 670  0187 1c0004        	addw	x,#4
 671  018a cd0000        	call	c_ltor
 673  018d ae0004        	ldw	x,#L45
 674  0190 cd0000        	call	c_lcmp
 676  0193 2502          	jrult	L742
 679  0195 0f01          	clr	(OFST+0,sp)
 681  0197               L742:
 682                     ; 121 			if((*parameters)[2]>=255) is_valid=0;
 684  0197 1e05          	ldw	x,(OFST+4,sp)
 685  0199 1c0008        	addw	x,#8
 686  019c ad67          	call	LC005
 688  019e 2502          	jrult	L152
 691  01a0 0f01          	clr	(OFST+0,sp)
 693  01a2               L152:
 694                     ; 122 			if(is_valid)
 696  01a2 7b01          	ld	a,(OFST+0,sp)
 697  01a4 2750          	jreq	L722
 698                     ; 124 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 700  01a6 1e05          	ldw	x,(OFST+4,sp)
 701  01a8 e60b          	ld	a,(11,x)
 702  01aa 88            	push	a
 703  01ab e607          	ld	a,(7,x)
 704  01ad 1606          	ldw	y,(OFST+5,sp)
 705  01af 97            	ld	xl,a
 706  01b0 90e603        	ld	a,(3,y)
 707  01b3 95            	ld	xh,a
 708  01b4 cd0000        	call	_set_rgb
 710  01b7 84            	pop	a
 711                     ; 125 				flush_leds(2);//1 RGB led element and 1 for status led
 713  01b8 2037          	jp	LC003
 714  01ba               L561:
 715                     ; 129 			is_valid=1;
 717  01ba 4c            	inc	a
 718  01bb 6b01          	ld	(OFST+0,sp),a
 720                     ; 130 			if(parameter_count<2) is_valid=0;
 722  01bd 7b07          	ld	a,(OFST+6,sp)
 723  01bf a102          	cp	a,#2
 724  01c1 2402          	jruge	L552
 727  01c3 0f01          	clr	(OFST+0,sp)
 729  01c5               L552:
 730                     ; 131 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 732  01c5 1e05          	ldw	x,(OFST+4,sp)
 733  01c7 cd0000        	call	c_ltor
 735  01ca ae000c        	ldw	x,#L46
 736  01cd cd0000        	call	c_lcmp
 738  01d0 2502          	jrult	L752
 741  01d2 0f01          	clr	(OFST+0,sp)
 743  01d4               L752:
 744                     ; 132 			if((*parameters)[1]>=255) is_valid=0;
 746  01d4 1e05          	ldw	x,(OFST+4,sp)
 747  01d6 1c0004        	addw	x,#4
 748  01d9 ad2a          	call	LC005
 750  01db 2502          	jrult	L162
 753  01dd 0f01          	clr	(OFST+0,sp)
 755  01df               L162:
 756                     ; 133 			if(is_valid)
 758  01df 7b01          	ld	a,(OFST+0,sp)
 759  01e1 2713          	jreq	L722
 760                     ; 135 				set_white((*parameters)[0],(*parameters)[1]);
 762  01e3 1e05          	ldw	x,(OFST+4,sp)
 763  01e5 e607          	ld	a,(7,x)
 764  01e7 1605          	ldw	y,(OFST+4,sp)
 765  01e9 97            	ld	xl,a
 766  01ea 90e603        	ld	a,(3,y)
 767  01ed 95            	ld	xh,a
 768  01ee cd0000        	call	_set_white
 770                     ; 136 				flush_leds(2);//1 RGB led element and 1 for status led
 772  01f1               LC003:
 774  01f1 a602          	ld	a,#2
 775  01f3 cd0000        	call	_flush_leds
 777  01f6               L722:
 778                     ; 140 	if(!is_valid) Serial_print_string("Invalid. h");
 780  01f6 7b01          	ld	a,(OFST+0,sp)
 781  01f8 2606          	jrne	L562
 784  01fa ae0010        	ldw	x,#L762
 785  01fd cd0000        	call	_Serial_print_string
 787  0200               L562:
 788                     ; 141 	Serial_newline();
 790  0200 cd0000        	call	_Serial_newline
 792                     ; 142 }
 795  0203 85            	popw	x
 796  0204 81            	ret	
 797  0205               LC005:
 798  0205 cd0000        	call	c_ltor
 800  0208 ae0008        	ldw	x,#L65
 801  020b cc0000        	jp	c_lcmp
 814                     	xref	_Serial_print_u32
 815                     	xref	_Serial_read_char
 816                     	xref	_Serial_available
 817                     	xref	_Serial_newline
 818                     	xref	_Serial_print_string
 819                     	xref	_Serial_print_char
 820                     	xdef	_execute_terminal_command
 821                     	xdef	_get_terminal_command
 822                     	xdef	_run_developer
 823                     	xdef	_setup_developer
 824                     	xref	_get_button_event
 825                     	xref	_flush_leds
 826                     	xref	_set_debug
 827                     	xref	_set_white
 828                     	xref	_set_rgb
 829                     	xref	_millis
 830                     	switch	.const
 831  0010               L762:
 832  0010 496e76616c69  	dc.b	"Invalid. h",0
 833                     	xref.b	c_lreg
 853                     	xref	c_ladd
 854                     	xref	c_itolx
 855                     	xref	c_llsh
 856                     	xref	c_ltor
 857                     	xref	c_lcmp
 858                     	xref	c_lursh
 859                     	xref	c_rtol
 860                     	end
