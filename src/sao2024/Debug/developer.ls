   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  46                     ; 10 void setup_developer()
  46                     ; 11 {
  48                     	switch	.text
  49  0000               _setup_developer:
  53                     ; 12 	setup_serial(1,1);//enabled, 0: 9600 baud, 1: at high speed (1MBaud)
  55  0000 ae0101        	ldw	x,#257
  56  0003 cd0000        	call	_setup_serial
  58                     ; 13 	clear_button_events();
  60  0006 cd0000        	call	_clear_button_events
  62                     ; 14 	flush_leds(0);//clear outstanding led buffer
  64  0009 4f            	clr	a
  65  000a cd0000        	call	_flush_leds
  67                     ; 15 	set_debug(255);//show only one debug led ON
  69  000d a6ff          	ld	a,#255
  70  000f cd0000        	call	_set_debug
  72                     ; 16 	flush_leds(1);
  74  0012 a601          	ld	a,#1
  75  0014 cd0000        	call	_flush_leds
  77                     ; 17 }
  80  0017 81            	ret
 139                     ; 19 void run_developer()
 139                     ; 20 {
 140                     	switch	.text
 141  0018               _run_developer:
 143  0018 520e          	subw	sp,#14
 144       0000000e      OFST:	set	14
 147                     ; 24 	setup_developer();
 149  001a ade4          	call	_setup_developer
 152  001c 2030          	jra	L15
 153  001e               L74:
 154                     ; 27 		Serial_print_string("> ");
 156  001e ae001b        	ldw	x,#L55
 157  0021 cd0000        	call	_Serial_print_string
 159                     ; 28 		get_terminal_command(&command,&parameters,&parameter_count);
 161  0024 96            	ldw	x,sp
 162  0025 1c000e        	addw	x,#OFST+0
 163  0028 89            	pushw	x
 164  0029 96            	ldw	x,sp
 165  002a 1c0003        	addw	x,#OFST-11
 166  002d 89            	pushw	x
 167  002e 96            	ldw	x,sp
 168  002f 1c0011        	addw	x,#OFST+3
 169  0032 ad23          	call	_get_terminal_command
 171  0034 5b04          	addw	sp,#4
 172                     ; 29 		set_debug(255);//show only one debug led ON
 174  0036 a6ff          	ld	a,#255
 175  0038 cd0000        	call	_set_debug
 177                     ; 30 		execute_terminal_command(command,&parameters,parameter_count);
 179  003b 7b0e          	ld	a,(OFST+0,sp)
 180  003d 88            	push	a
 181  003e 96            	ldw	x,sp
 182  003f 1c0002        	addw	x,#OFST-12
 183  0042 89            	pushw	x
 184  0043 7b10          	ld	a,(OFST+2,sp)
 185  0045 cd0139        	call	_execute_terminal_command
 187  0048 5b03          	addw	sp,#3
 188                     ; 31 		command=0;
 190  004a 0f0d          	clr	(OFST-1,sp)
 192                     ; 32 		parameter_count=0;
 194  004c 0f0e          	clr	(OFST+0,sp)
 196  004e               L15:
 197                     ; 25 	while(is_developer_valid())
 199  004e cd0000        	call	_is_developer_valid
 201  0051 4d            	tnz	a
 202  0052 26ca          	jrne	L74
 203                     ; 37 }
 206  0054 5b0e          	addw	sp,#14
 207  0056 81            	ret
 316                     ; 39 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 316                     ; 40 {
 317                     	switch	.text
 318  0057               _get_terminal_command:
 320  0057 89            	pushw	x
 321  0058 5207          	subw	sp,#7
 322       00000007      OFST:	set	7
 325                     ; 41 	bool is_new_line=0;
 327  005a 0f05          	clr	(OFST-2,sp)
 329                     ; 42 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
 331  005c 0f06          	clr	(OFST-1,sp)
 334  005e ac290129      	jpf	L531
 335  0062               L131:
 336                     ; 46 		if(Serial_available())
 338  0062 cd0000        	call	_Serial_available
 340  0065 4d            	tnz	a
 341  0066 2603          	jrne	L21
 342  0068 cc0129        	jp	L531
 343  006b               L21:
 344                     ; 48 			input_char=Serial_read_char();
 346  006b cd0000        	call	_Serial_read_char
 348  006e 6b07          	ld	(OFST+0,sp),a
 350                     ; 49 			if(input_char=='\n') is_new_line=1;//break on new line character found
 352  0070 7b07          	ld	a,(OFST+0,sp)
 353  0072 a10a          	cp	a,#10
 354  0074 2608          	jrne	L341
 357  0076 a601          	ld	a,#1
 358  0078 6b05          	ld	(OFST-2,sp),a
 361  007a ac290129      	jpf	L531
 362  007e               L341:
 363                     ; 50 			else if((*command)==0) (*command)=input_char;
 365  007e 1e08          	ldw	x,(OFST+1,sp)
 366  0080 7d            	tnz	(x)
 367  0081 2609          	jrne	L741
 370  0083 7b07          	ld	a,(OFST+0,sp)
 371  0085 1e08          	ldw	x,(OFST+1,sp)
 372  0087 f7            	ld	(x),a
 374  0088 ac290129      	jpf	L531
 375  008c               L741:
 376                     ; 52 				if('0'<=input_char && input_char<='9')
 378  008c 7b07          	ld	a,(OFST+0,sp)
 379  008e a130          	cp	a,#48
 380  0090 2402          	jruge	L41
 381  0092 2078          	jp	L351
 382  0094               L41:
 384  0094 7b07          	ld	a,(OFST+0,sp)
 385  0096 a13a          	cp	a,#58
 386  0098 2472          	jruge	L351
 387                     ; 54 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
 389  009a 0d06          	tnz	(OFST-1,sp)
 390  009c 2619          	jrne	L551
 393  009e 1e0e          	ldw	x,(OFST+7,sp)
 394  00a0 f6            	ld	a,(x)
 395  00a1 97            	ld	xl,a
 396  00a2 a604          	ld	a,#4
 397  00a4 42            	mul	x,a
 398  00a5 72fb0c        	addw	x,(OFST+5,sp)
 399  00a8 a600          	ld	a,#0
 400  00aa e703          	ld	(3,x),a
 401  00ac a600          	ld	a,#0
 402  00ae e702          	ld	(2,x),a
 403  00b0 a600          	ld	a,#0
 404  00b2 e701          	ld	(1,x),a
 405  00b4 a600          	ld	a,#0
 406  00b6 f7            	ld	(x),a
 407  00b7               L551:
 408                     ; 55 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
 410  00b7 7b07          	ld	a,(OFST+0,sp)
 411  00b9 5f            	clrw	x
 412  00ba 97            	ld	xl,a
 413  00bb 1d0030        	subw	x,#48
 414  00be cd0000        	call	c_itolx
 416  00c1 96            	ldw	x,sp
 417  00c2 1c0001        	addw	x,#OFST-6
 418  00c5 cd0000        	call	c_rtol
 421  00c8 1e0e          	ldw	x,(OFST+7,sp)
 422  00ca f6            	ld	a,(x)
 423  00cb 97            	ld	xl,a
 424  00cc a604          	ld	a,#4
 425  00ce 42            	mul	x,a
 426  00cf 72fb0c        	addw	x,(OFST+5,sp)
 427  00d2 cd0000        	call	c_ltor
 429  00d5 1e0e          	ldw	x,(OFST+7,sp)
 430  00d7 f6            	ld	a,(x)
 431  00d8 97            	ld	xl,a
 432  00d9 a604          	ld	a,#4
 433  00db 42            	mul	x,a
 434  00dc 72fb0c        	addw	x,(OFST+5,sp)
 435  00df e603          	ld	a,(3,x)
 436  00e1 5f            	clrw	x
 437  00e2 97            	ld	xl,a
 438  00e3 1c0003        	addw	x,#3
 439  00e6 01            	rrwa	x,a
 440  00e7 cd0000        	call	c_llsh
 442  00ea 3803          	sll	c_lreg+3
 443  00ec 3902          	rlc	c_lreg+2
 444  00ee 3901          	rlc	c_lreg+1
 445  00f0 3900          	rlc	c_lreg
 446  00f2 96            	ldw	x,sp
 447  00f3 1c0001        	addw	x,#OFST-6
 448  00f6 cd0000        	call	c_ladd
 450  00f9 1e0e          	ldw	x,(OFST+7,sp)
 451  00fb f6            	ld	a,(x)
 452  00fc 97            	ld	xl,a
 453  00fd a604          	ld	a,#4
 454  00ff 42            	mul	x,a
 455  0100 72fb0c        	addw	x,(OFST+5,sp)
 456  0103 cd0000        	call	c_rtol
 458                     ; 56 					is_any_input=1;
 460  0106 a601          	ld	a,#1
 461  0108 6b06          	ld	(OFST-1,sp),a
 464  010a 201d          	jra	L531
 465  010c               L351:
 466                     ; 58 					if(is_any_input)
 468  010c 0d06          	tnz	(OFST-1,sp)
 469  010e 2719          	jreq	L531
 470                     ; 60 						(*parameter_count)++;
 472  0110 1e0e          	ldw	x,(OFST+7,sp)
 473  0112 7c            	inc	(x)
 474                     ; 61 						is_any_input=0;
 476  0113 0f06          	clr	(OFST-1,sp)
 478                     ; 62 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
 480  0115 1e0e          	ldw	x,(OFST+7,sp)
 481  0117 f6            	ld	a,(x)
 482  0118 905f          	clrw	y
 483  011a 9097          	ld	yl,a
 484  011c a603          	ld	a,#3
 485  011e 9062          	div	y,a
 486  0120 905f          	clrw	y
 487  0122 9097          	ld	yl,a
 488  0124 9001          	rrwa	y,a
 489  0126 f7            	ld	(x),a
 490  0127 9002          	rlwa	y,a
 491  0129               L531:
 492                     ; 44 	while(is_developer_valid() && !is_new_line)
 494  0129 cd0000        	call	_is_developer_valid
 496  012c 4d            	tnz	a
 497  012d 2707          	jreq	L361
 499  012f 0d05          	tnz	(OFST-2,sp)
 500  0131 2603          	jrne	L61
 501  0133 cc0062        	jp	L131
 502  0136               L61:
 503  0136               L361:
 504                     ; 68 }
 507  0136 5b09          	addw	sp,#9
 508  0138 81            	ret
 589                     .const:	section	.text
 590  0000               L22:
 591  0000 00000006      	dc.l	6
 592  0004               L42:
 593  0004 00000003      	dc.l	3
 594  0008               L62:
 595  0008 000000ff      	dc.l	255
 596  000c               L03:
 597  000c 0000000c      	dc.l	12
 598                     ; 70 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 598                     ; 71 {
 599                     	switch	.text
 600  0139               _execute_terminal_command:
 602  0139 88            	push	a
 603  013a 88            	push	a
 604       00000001      OFST:	set	1
 607                     ; 73 	bool is_valid=0;
 609  013b 0f01          	clr	(OFST+0,sp)
 611                     ; 74 	switch(command)
 614                     ; 130 		}break;
 615  013d a065          	sub	a,#101
 616  013f 2753          	jreq	L171
 617  0141 a007          	sub	a,#7
 618  0143 275c          	jreq	L371
 619  0145 a004          	sub	a,#4
 620  0147 270f          	jreq	L561
 621  0149 a004          	sub	a,#4
 622  014b 273f          	jreq	L761
 623  014d a003          	sub	a,#3
 624  014f 2603          	jrne	L23
 625  0151 cc01ff        	jp	L571
 626  0154               L23:
 627  0154 ac430243      	jpf	L732
 628  0158               L561:
 629                     ; 77 			Serial_print_char(command);
 631  0158 7b02          	ld	a,(OFST+1,sp)
 632  015a cd0000        	call	_Serial_print_char
 634                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 636  015d 0f01          	clr	(OFST+0,sp)
 639  015f 201d          	jra	L542
 640  0161               L142:
 641                     ; 80 				Serial_print_char(' ');
 643  0161 a620          	ld	a,#32
 644  0163 cd0000        	call	_Serial_print_char
 646                     ; 81 				Serial_print_u32((*parameters)[iter]);
 648  0166 7b01          	ld	a,(OFST+0,sp)
 649  0168 97            	ld	xl,a
 650  0169 a604          	ld	a,#4
 651  016b 42            	mul	x,a
 652  016c 72fb05        	addw	x,(OFST+4,sp)
 653  016f 9093          	ldw	y,x
 654  0171 ee02          	ldw	x,(2,x)
 655  0173 89            	pushw	x
 656  0174 93            	ldw	x,y
 657  0175 fe            	ldw	x,(x)
 658  0176 89            	pushw	x
 659  0177 cd0000        	call	_Serial_print_u32
 661  017a 5b04          	addw	sp,#4
 662                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 664  017c 0c01          	inc	(OFST+0,sp)
 666  017e               L542:
 669  017e 7b01          	ld	a,(OFST+0,sp)
 670  0180 1107          	cp	a,(OFST+6,sp)
 671  0182 25dd          	jrult	L142
 672                     ; 83 			is_valid=1;
 674  0184 a601          	ld	a,#1
 675  0186 6b01          	ld	(OFST+0,sp),a
 677                     ; 84 		}break;
 679  0188 ac430243      	jpf	L732
 680  018c               L761:
 681                     ; 88 			is_valid=1;
 683  018c a601          	ld	a,#1
 684  018e 6b01          	ld	(OFST+0,sp),a
 686                     ; 89 		}break;
 688  0190 ac430243      	jpf	L732
 689  0194               L171:
 690                     ; 91 			if(parameter_count==1)
 692  0194 7b07          	ld	a,(OFST+6,sp)
 693  0196 a101          	cp	a,#1
 694  0198 2703          	jreq	L43
 695  019a cc0243        	jp	L732
 696  019d               L43:
 697  019d ac430243      	jpf	L732
 698  01a1               L371:
 699                     ; 109 			is_valid=1;
 701  01a1 a601          	ld	a,#1
 702  01a3 6b01          	ld	(OFST+0,sp),a
 704                     ; 110 			if(parameter_count<3) is_valid=0;
 706  01a5 7b07          	ld	a,(OFST+6,sp)
 707  01a7 a103          	cp	a,#3
 708  01a9 2402          	jruge	L352
 711  01ab 0f01          	clr	(OFST+0,sp)
 713  01ad               L352:
 714                     ; 111 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 716  01ad 1e05          	ldw	x,(OFST+4,sp)
 717  01af cd0000        	call	c_ltor
 719  01b2 ae0000        	ldw	x,#L22
 720  01b5 cd0000        	call	c_lcmp
 722  01b8 2502          	jrult	L552
 725  01ba 0f01          	clr	(OFST+0,sp)
 727  01bc               L552:
 728                     ; 112 			if((*parameters)[1]>=3) is_valid=0;
 730  01bc 1e05          	ldw	x,(OFST+4,sp)
 731  01be 1c0004        	addw	x,#4
 732  01c1 cd0000        	call	c_ltor
 734  01c4 ae0004        	ldw	x,#L42
 735  01c7 cd0000        	call	c_lcmp
 737  01ca 2502          	jrult	L752
 740  01cc 0f01          	clr	(OFST+0,sp)
 742  01ce               L752:
 743                     ; 113 			if((*parameters)[2]>=255) is_valid=0;
 745  01ce 1e05          	ldw	x,(OFST+4,sp)
 746  01d0 1c0008        	addw	x,#8
 747  01d3 cd0000        	call	c_ltor
 749  01d6 ae0008        	ldw	x,#L62
 750  01d9 cd0000        	call	c_lcmp
 752  01dc 2502          	jrult	L162
 755  01de 0f01          	clr	(OFST+0,sp)
 757  01e0               L162:
 758                     ; 114 			if(is_valid)
 760  01e0 0d01          	tnz	(OFST+0,sp)
 761  01e2 275f          	jreq	L732
 762                     ; 116 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 764  01e4 1e05          	ldw	x,(OFST+4,sp)
 765  01e6 e60b          	ld	a,(11,x)
 766  01e8 88            	push	a
 767  01e9 1e06          	ldw	x,(OFST+5,sp)
 768  01eb e607          	ld	a,(7,x)
 769  01ed 97            	ld	xl,a
 770  01ee 1606          	ldw	y,(OFST+5,sp)
 771  01f0 90e603        	ld	a,(3,y)
 772  01f3 95            	ld	xh,a
 773  01f4 cd0000        	call	_set_rgb
 775  01f7 84            	pop	a
 776                     ; 117 				flush_leds(2);//1 RGB led element and 1 for status led
 778  01f8 a602          	ld	a,#2
 779  01fa cd0000        	call	_flush_leds
 781  01fd 2044          	jra	L732
 782  01ff               L571:
 783                     ; 121 			is_valid=1;
 785  01ff a601          	ld	a,#1
 786  0201 6b01          	ld	(OFST+0,sp),a
 788                     ; 122 			if(parameter_count<2) is_valid=0;
 790  0203 7b07          	ld	a,(OFST+6,sp)
 791  0205 a102          	cp	a,#2
 792  0207 2402          	jruge	L562
 795  0209 0f01          	clr	(OFST+0,sp)
 797  020b               L562:
 798                     ; 123 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 800  020b 1e05          	ldw	x,(OFST+4,sp)
 801  020d cd0000        	call	c_ltor
 803  0210 ae000c        	ldw	x,#L03
 804  0213 cd0000        	call	c_lcmp
 806  0216 2502          	jrult	L762
 809  0218 0f01          	clr	(OFST+0,sp)
 811  021a               L762:
 812                     ; 124 			if((*parameters)[1]>=255) is_valid=0;
 814  021a 1e05          	ldw	x,(OFST+4,sp)
 815  021c 1c0004        	addw	x,#4
 816  021f cd0000        	call	c_ltor
 818  0222 ae0008        	ldw	x,#L62
 819  0225 cd0000        	call	c_lcmp
 821  0228 2502          	jrult	L172
 824  022a 0f01          	clr	(OFST+0,sp)
 826  022c               L172:
 827                     ; 125 			if(is_valid)
 829  022c 0d01          	tnz	(OFST+0,sp)
 830  022e 2713          	jreq	L732
 831                     ; 127 				set_white((*parameters)[0],(*parameters)[1]);
 833  0230 1e05          	ldw	x,(OFST+4,sp)
 834  0232 e607          	ld	a,(7,x)
 835  0234 97            	ld	xl,a
 836  0235 1605          	ldw	y,(OFST+4,sp)
 837  0237 90e603        	ld	a,(3,y)
 838  023a 95            	ld	xh,a
 839  023b cd0000        	call	_set_white
 841                     ; 128 				flush_leds(2);//1 RGB led element and 1 for status led
 843  023e a602          	ld	a,#2
 844  0240 cd0000        	call	_flush_leds
 846  0243               L732:
 847                     ; 132 	if(!is_valid) Serial_print_string("Invalid. h");
 849  0243 0d01          	tnz	(OFST+0,sp)
 850  0245 2606          	jrne	L572
 853  0247 ae0010        	ldw	x,#L772
 854  024a cd0000        	call	_Serial_print_string
 856  024d               L572:
 857                     ; 133 	Serial_newline();
 859  024d cd0000        	call	_Serial_newline
 861                     ; 134 }
 864  0250 85            	popw	x
 865  0251 81            	ret
 878                     	xref	_Serial_print_u32
 879                     	xref	_Serial_read_char
 880                     	xref	_Serial_available
 881                     	xref	_Serial_newline
 882                     	xref	_Serial_print_string
 883                     	xref	_Serial_print_char
 884                     	xdef	_execute_terminal_command
 885                     	xdef	_get_terminal_command
 886                     	xdef	_run_developer
 887                     	xdef	_setup_developer
 888                     	xref	_clear_button_events
 889                     	xref	_is_developer_valid
 890                     	xref	_flush_leds
 891                     	xref	_set_debug
 892                     	xref	_set_white
 893                     	xref	_set_rgb
 894                     	xref	_setup_serial
 895                     	switch	.const
 896  0010               L772:
 897  0010 496e76616c69  	dc.b	"Invalid. h",0
 898  001b               L55:
 899  001b 3e2000        	dc.b	"> ",0
 900                     	xref.b	c_lreg
 920                     	xref	c_lcmp
 921                     	xref	c_ladd
 922                     	xref	c_rtol
 923                     	xref	c_itolx
 924                     	xref	c_llsh
 925                     	xref	c_ltor
 926                     	end
