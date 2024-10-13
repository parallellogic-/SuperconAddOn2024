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
  58                     ; 13 	get_button_event(0xFF,0xFF,1);//clear_button_events();
  60  0006 4b01          	push	#1
  61  0008 aeffff        	ldw	x,#65535
  62  000b cd0000        	call	_get_button_event
  64  000e 84            	pop	a
  65                     ; 14 	flush_leds(0);//clear outstanding led buffer
  67  000f 4f            	clr	a
  68  0010 cd0000        	call	_flush_leds
  70                     ; 15 	set_debug(255);//show only one debug led ON
  72  0013 a6ff          	ld	a,#255
  73  0015 cd0000        	call	_set_debug
  75                     ; 16 	flush_leds(1);
  77  0018 a601          	ld	a,#1
  78  001a cd0000        	call	_flush_leds
  80                     ; 17 }
  83  001d 81            	ret
 142                     ; 19 void run_developer()
 142                     ; 20 {
 143                     	switch	.text
 144  001e               _run_developer:
 146  001e 520e          	subw	sp,#14
 147       0000000e      OFST:	set	14
 150                     ; 24 	setup_developer();
 152  0020 adde          	call	_setup_developer
 155  0022 2030          	jra	L15
 156  0024               L74:
 157                     ; 27 		Serial_print_string("> ");
 159  0024 ae001b        	ldw	x,#L55
 160  0027 cd0000        	call	_Serial_print_string
 162                     ; 28 		get_terminal_command(&command,&parameters,&parameter_count);
 164  002a 96            	ldw	x,sp
 165  002b 1c000e        	addw	x,#OFST+0
 166  002e 89            	pushw	x
 167  002f 96            	ldw	x,sp
 168  0030 1c0003        	addw	x,#OFST-11
 169  0033 89            	pushw	x
 170  0034 96            	ldw	x,sp
 171  0035 1c0011        	addw	x,#OFST+3
 172  0038 ad23          	call	_get_terminal_command
 174  003a 5b04          	addw	sp,#4
 175                     ; 29 		set_debug(255);//show only one debug led ON
 177  003c a6ff          	ld	a,#255
 178  003e cd0000        	call	_set_debug
 180                     ; 30 		execute_terminal_command(command,&parameters,parameter_count);
 182  0041 7b0e          	ld	a,(OFST+0,sp)
 183  0043 88            	push	a
 184  0044 96            	ldw	x,sp
 185  0045 1c0002        	addw	x,#OFST-12
 186  0048 89            	pushw	x
 187  0049 7b10          	ld	a,(OFST+2,sp)
 188  004b cd013f        	call	_execute_terminal_command
 190  004e 5b03          	addw	sp,#3
 191                     ; 31 		command=0;
 193  0050 0f0d          	clr	(OFST-1,sp)
 195                     ; 32 		parameter_count=0;
 197  0052 0f0e          	clr	(OFST+0,sp)
 199  0054               L15:
 200                     ; 25 	while(is_developer_valid())
 202  0054 cd0000        	call	_is_developer_valid
 204  0057 4d            	tnz	a
 205  0058 26ca          	jrne	L74
 206                     ; 37 }
 209  005a 5b0e          	addw	sp,#14
 210  005c 81            	ret
 319                     ; 39 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 319                     ; 40 {
 320                     	switch	.text
 321  005d               _get_terminal_command:
 323  005d 89            	pushw	x
 324  005e 5207          	subw	sp,#7
 325       00000007      OFST:	set	7
 328                     ; 41 	bool is_new_line=0;
 330  0060 0f05          	clr	(OFST-2,sp)
 332                     ; 42 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
 334  0062 0f06          	clr	(OFST-1,sp)
 337  0064 ac2f012f      	jpf	L531
 338  0068               L131:
 339                     ; 46 		if(Serial_available())
 341  0068 cd0000        	call	_Serial_available
 343  006b 4d            	tnz	a
 344  006c 2603          	jrne	L21
 345  006e cc012f        	jp	L531
 346  0071               L21:
 347                     ; 48 			input_char=Serial_read_char();
 349  0071 cd0000        	call	_Serial_read_char
 351  0074 6b07          	ld	(OFST+0,sp),a
 353                     ; 49 			if(input_char=='\n') is_new_line=1;//break on new line character found
 355  0076 7b07          	ld	a,(OFST+0,sp)
 356  0078 a10a          	cp	a,#10
 357  007a 2608          	jrne	L341
 360  007c a601          	ld	a,#1
 361  007e 6b05          	ld	(OFST-2,sp),a
 364  0080 ac2f012f      	jpf	L531
 365  0084               L341:
 366                     ; 50 			else if((*command)==0) (*command)=input_char;
 368  0084 1e08          	ldw	x,(OFST+1,sp)
 369  0086 7d            	tnz	(x)
 370  0087 2609          	jrne	L741
 373  0089 7b07          	ld	a,(OFST+0,sp)
 374  008b 1e08          	ldw	x,(OFST+1,sp)
 375  008d f7            	ld	(x),a
 377  008e ac2f012f      	jpf	L531
 378  0092               L741:
 379                     ; 52 				if('0'<=input_char && input_char<='9')
 381  0092 7b07          	ld	a,(OFST+0,sp)
 382  0094 a130          	cp	a,#48
 383  0096 2402          	jruge	L41
 384  0098 2078          	jp	L351
 385  009a               L41:
 387  009a 7b07          	ld	a,(OFST+0,sp)
 388  009c a13a          	cp	a,#58
 389  009e 2472          	jruge	L351
 390                     ; 54 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
 392  00a0 0d06          	tnz	(OFST-1,sp)
 393  00a2 2619          	jrne	L551
 396  00a4 1e0e          	ldw	x,(OFST+7,sp)
 397  00a6 f6            	ld	a,(x)
 398  00a7 97            	ld	xl,a
 399  00a8 a604          	ld	a,#4
 400  00aa 42            	mul	x,a
 401  00ab 72fb0c        	addw	x,(OFST+5,sp)
 402  00ae a600          	ld	a,#0
 403  00b0 e703          	ld	(3,x),a
 404  00b2 a600          	ld	a,#0
 405  00b4 e702          	ld	(2,x),a
 406  00b6 a600          	ld	a,#0
 407  00b8 e701          	ld	(1,x),a
 408  00ba a600          	ld	a,#0
 409  00bc f7            	ld	(x),a
 410  00bd               L551:
 411                     ; 55 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
 413  00bd 7b07          	ld	a,(OFST+0,sp)
 414  00bf 5f            	clrw	x
 415  00c0 97            	ld	xl,a
 416  00c1 1d0030        	subw	x,#48
 417  00c4 cd0000        	call	c_itolx
 419  00c7 96            	ldw	x,sp
 420  00c8 1c0001        	addw	x,#OFST-6
 421  00cb cd0000        	call	c_rtol
 424  00ce 1e0e          	ldw	x,(OFST+7,sp)
 425  00d0 f6            	ld	a,(x)
 426  00d1 97            	ld	xl,a
 427  00d2 a604          	ld	a,#4
 428  00d4 42            	mul	x,a
 429  00d5 72fb0c        	addw	x,(OFST+5,sp)
 430  00d8 cd0000        	call	c_ltor
 432  00db 1e0e          	ldw	x,(OFST+7,sp)
 433  00dd f6            	ld	a,(x)
 434  00de 97            	ld	xl,a
 435  00df a604          	ld	a,#4
 436  00e1 42            	mul	x,a
 437  00e2 72fb0c        	addw	x,(OFST+5,sp)
 438  00e5 e603          	ld	a,(3,x)
 439  00e7 5f            	clrw	x
 440  00e8 97            	ld	xl,a
 441  00e9 1c0003        	addw	x,#3
 442  00ec 01            	rrwa	x,a
 443  00ed cd0000        	call	c_llsh
 445  00f0 3803          	sll	c_lreg+3
 446  00f2 3902          	rlc	c_lreg+2
 447  00f4 3901          	rlc	c_lreg+1
 448  00f6 3900          	rlc	c_lreg
 449  00f8 96            	ldw	x,sp
 450  00f9 1c0001        	addw	x,#OFST-6
 451  00fc cd0000        	call	c_ladd
 453  00ff 1e0e          	ldw	x,(OFST+7,sp)
 454  0101 f6            	ld	a,(x)
 455  0102 97            	ld	xl,a
 456  0103 a604          	ld	a,#4
 457  0105 42            	mul	x,a
 458  0106 72fb0c        	addw	x,(OFST+5,sp)
 459  0109 cd0000        	call	c_rtol
 461                     ; 56 					is_any_input=1;
 463  010c a601          	ld	a,#1
 464  010e 6b06          	ld	(OFST-1,sp),a
 467  0110 201d          	jra	L531
 468  0112               L351:
 469                     ; 58 					if(is_any_input)
 471  0112 0d06          	tnz	(OFST-1,sp)
 472  0114 2719          	jreq	L531
 473                     ; 60 						(*parameter_count)++;
 475  0116 1e0e          	ldw	x,(OFST+7,sp)
 476  0118 7c            	inc	(x)
 477                     ; 61 						is_any_input=0;
 479  0119 0f06          	clr	(OFST-1,sp)
 481                     ; 62 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
 483  011b 1e0e          	ldw	x,(OFST+7,sp)
 484  011d f6            	ld	a,(x)
 485  011e 905f          	clrw	y
 486  0120 9097          	ld	yl,a
 487  0122 a603          	ld	a,#3
 488  0124 9062          	div	y,a
 489  0126 905f          	clrw	y
 490  0128 9097          	ld	yl,a
 491  012a 9001          	rrwa	y,a
 492  012c f7            	ld	(x),a
 493  012d 9002          	rlwa	y,a
 494  012f               L531:
 495                     ; 44 	while(is_developer_valid() && !is_new_line)
 497  012f cd0000        	call	_is_developer_valid
 499  0132 4d            	tnz	a
 500  0133 2707          	jreq	L361
 502  0135 0d05          	tnz	(OFST-2,sp)
 503  0137 2603          	jrne	L61
 504  0139 cc0068        	jp	L131
 505  013c               L61:
 506  013c               L361:
 507                     ; 68 }
 510  013c 5b09          	addw	sp,#9
 511  013e 81            	ret
 592                     .const:	section	.text
 593  0000               L22:
 594  0000 00000006      	dc.l	6
 595  0004               L42:
 596  0004 00000003      	dc.l	3
 597  0008               L62:
 598  0008 000000ff      	dc.l	255
 599  000c               L03:
 600  000c 0000000c      	dc.l	12
 601                     ; 70 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 601                     ; 71 {
 602                     	switch	.text
 603  013f               _execute_terminal_command:
 605  013f 88            	push	a
 606  0140 88            	push	a
 607       00000001      OFST:	set	1
 610                     ; 73 	bool is_valid=0;
 612  0141 0f01          	clr	(OFST+0,sp)
 614                     ; 74 	switch(command)
 617                     ; 130 		}break;
 618  0143 a065          	sub	a,#101
 619  0145 2753          	jreq	L171
 620  0147 a007          	sub	a,#7
 621  0149 275c          	jreq	L371
 622  014b a004          	sub	a,#4
 623  014d 270f          	jreq	L561
 624  014f a004          	sub	a,#4
 625  0151 273f          	jreq	L761
 626  0153 a003          	sub	a,#3
 627  0155 2603          	jrne	L23
 628  0157 cc0205        	jp	L571
 629  015a               L23:
 630  015a ac490249      	jpf	L732
 631  015e               L561:
 632                     ; 77 			Serial_print_char(command);
 634  015e 7b02          	ld	a,(OFST+1,sp)
 635  0160 cd0000        	call	_Serial_print_char
 637                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 639  0163 0f01          	clr	(OFST+0,sp)
 642  0165 201d          	jra	L542
 643  0167               L142:
 644                     ; 80 				Serial_print_char(' ');
 646  0167 a620          	ld	a,#32
 647  0169 cd0000        	call	_Serial_print_char
 649                     ; 81 				Serial_print_u32((*parameters)[iter]);
 651  016c 7b01          	ld	a,(OFST+0,sp)
 652  016e 97            	ld	xl,a
 653  016f a604          	ld	a,#4
 654  0171 42            	mul	x,a
 655  0172 72fb05        	addw	x,(OFST+4,sp)
 656  0175 9093          	ldw	y,x
 657  0177 ee02          	ldw	x,(2,x)
 658  0179 89            	pushw	x
 659  017a 93            	ldw	x,y
 660  017b fe            	ldw	x,(x)
 661  017c 89            	pushw	x
 662  017d cd0000        	call	_Serial_print_u32
 664  0180 5b04          	addw	sp,#4
 665                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 667  0182 0c01          	inc	(OFST+0,sp)
 669  0184               L542:
 672  0184 7b01          	ld	a,(OFST+0,sp)
 673  0186 1107          	cp	a,(OFST+6,sp)
 674  0188 25dd          	jrult	L142
 675                     ; 83 			is_valid=1;
 677  018a a601          	ld	a,#1
 678  018c 6b01          	ld	(OFST+0,sp),a
 680                     ; 84 		}break;
 682  018e ac490249      	jpf	L732
 683  0192               L761:
 684                     ; 88 			is_valid=1;
 686  0192 a601          	ld	a,#1
 687  0194 6b01          	ld	(OFST+0,sp),a
 689                     ; 89 		}break;
 691  0196 ac490249      	jpf	L732
 692  019a               L171:
 693                     ; 91 			if(parameter_count==1)
 695  019a 7b07          	ld	a,(OFST+6,sp)
 696  019c a101          	cp	a,#1
 697  019e 2703          	jreq	L43
 698  01a0 cc0249        	jp	L732
 699  01a3               L43:
 700  01a3 ac490249      	jpf	L732
 701  01a7               L371:
 702                     ; 109 			is_valid=1;
 704  01a7 a601          	ld	a,#1
 705  01a9 6b01          	ld	(OFST+0,sp),a
 707                     ; 110 			if(parameter_count<3) is_valid=0;
 709  01ab 7b07          	ld	a,(OFST+6,sp)
 710  01ad a103          	cp	a,#3
 711  01af 2402          	jruge	L352
 714  01b1 0f01          	clr	(OFST+0,sp)
 716  01b3               L352:
 717                     ; 111 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 719  01b3 1e05          	ldw	x,(OFST+4,sp)
 720  01b5 cd0000        	call	c_ltor
 722  01b8 ae0000        	ldw	x,#L22
 723  01bb cd0000        	call	c_lcmp
 725  01be 2502          	jrult	L552
 728  01c0 0f01          	clr	(OFST+0,sp)
 730  01c2               L552:
 731                     ; 112 			if((*parameters)[1]>=3) is_valid=0;
 733  01c2 1e05          	ldw	x,(OFST+4,sp)
 734  01c4 1c0004        	addw	x,#4
 735  01c7 cd0000        	call	c_ltor
 737  01ca ae0004        	ldw	x,#L42
 738  01cd cd0000        	call	c_lcmp
 740  01d0 2502          	jrult	L752
 743  01d2 0f01          	clr	(OFST+0,sp)
 745  01d4               L752:
 746                     ; 113 			if((*parameters)[2]>=255) is_valid=0;
 748  01d4 1e05          	ldw	x,(OFST+4,sp)
 749  01d6 1c0008        	addw	x,#8
 750  01d9 cd0000        	call	c_ltor
 752  01dc ae0008        	ldw	x,#L62
 753  01df cd0000        	call	c_lcmp
 755  01e2 2502          	jrult	L162
 758  01e4 0f01          	clr	(OFST+0,sp)
 760  01e6               L162:
 761                     ; 114 			if(is_valid)
 763  01e6 0d01          	tnz	(OFST+0,sp)
 764  01e8 275f          	jreq	L732
 765                     ; 116 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 767  01ea 1e05          	ldw	x,(OFST+4,sp)
 768  01ec e60b          	ld	a,(11,x)
 769  01ee 88            	push	a
 770  01ef 1e06          	ldw	x,(OFST+5,sp)
 771  01f1 e607          	ld	a,(7,x)
 772  01f3 97            	ld	xl,a
 773  01f4 1606          	ldw	y,(OFST+5,sp)
 774  01f6 90e603        	ld	a,(3,y)
 775  01f9 95            	ld	xh,a
 776  01fa cd0000        	call	_set_rgb
 778  01fd 84            	pop	a
 779                     ; 117 				flush_leds(2);//1 RGB led element and 1 for status led
 781  01fe a602          	ld	a,#2
 782  0200 cd0000        	call	_flush_leds
 784  0203 2044          	jra	L732
 785  0205               L571:
 786                     ; 121 			is_valid=1;
 788  0205 a601          	ld	a,#1
 789  0207 6b01          	ld	(OFST+0,sp),a
 791                     ; 122 			if(parameter_count<2) is_valid=0;
 793  0209 7b07          	ld	a,(OFST+6,sp)
 794  020b a102          	cp	a,#2
 795  020d 2402          	jruge	L562
 798  020f 0f01          	clr	(OFST+0,sp)
 800  0211               L562:
 801                     ; 123 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 803  0211 1e05          	ldw	x,(OFST+4,sp)
 804  0213 cd0000        	call	c_ltor
 806  0216 ae000c        	ldw	x,#L03
 807  0219 cd0000        	call	c_lcmp
 809  021c 2502          	jrult	L762
 812  021e 0f01          	clr	(OFST+0,sp)
 814  0220               L762:
 815                     ; 124 			if((*parameters)[1]>=255) is_valid=0;
 817  0220 1e05          	ldw	x,(OFST+4,sp)
 818  0222 1c0004        	addw	x,#4
 819  0225 cd0000        	call	c_ltor
 821  0228 ae0008        	ldw	x,#L62
 822  022b cd0000        	call	c_lcmp
 824  022e 2502          	jrult	L172
 827  0230 0f01          	clr	(OFST+0,sp)
 829  0232               L172:
 830                     ; 125 			if(is_valid)
 832  0232 0d01          	tnz	(OFST+0,sp)
 833  0234 2713          	jreq	L732
 834                     ; 127 				set_white((*parameters)[0],(*parameters)[1]);
 836  0236 1e05          	ldw	x,(OFST+4,sp)
 837  0238 e607          	ld	a,(7,x)
 838  023a 97            	ld	xl,a
 839  023b 1605          	ldw	y,(OFST+4,sp)
 840  023d 90e603        	ld	a,(3,y)
 841  0240 95            	ld	xh,a
 842  0241 cd0000        	call	_set_white
 844                     ; 128 				flush_leds(2);//1 RGB led element and 1 for status led
 846  0244 a602          	ld	a,#2
 847  0246 cd0000        	call	_flush_leds
 849  0249               L732:
 850                     ; 132 	if(!is_valid) Serial_print_string("Invalid. h");
 852  0249 0d01          	tnz	(OFST+0,sp)
 853  024b 2606          	jrne	L572
 856  024d ae0010        	ldw	x,#L772
 857  0250 cd0000        	call	_Serial_print_string
 859  0253               L572:
 860                     ; 133 	Serial_newline();
 862  0253 cd0000        	call	_Serial_newline
 864                     ; 134 }
 867  0256 85            	popw	x
 868  0257 81            	ret
 881                     	xref	_Serial_print_u32
 882                     	xref	_Serial_read_char
 883                     	xref	_Serial_available
 884                     	xref	_Serial_newline
 885                     	xref	_Serial_print_string
 886                     	xref	_Serial_print_char
 887                     	xdef	_execute_terminal_command
 888                     	xdef	_get_terminal_command
 889                     	xdef	_run_developer
 890                     	xdef	_setup_developer
 891                     	xref	_get_button_event
 892                     	xref	_is_developer_valid
 893                     	xref	_flush_leds
 894                     	xref	_set_debug
 895                     	xref	_set_white
 896                     	xref	_set_rgb
 897                     	xref	_setup_serial
 898                     	switch	.const
 899  0010               L772:
 900  0010 496e76616c69  	dc.b	"Invalid. h",0
 901  001b               L55:
 902  001b 3e2000        	dc.b	"> ",0
 903                     	xref.b	c_lreg
 923                     	xref	c_lcmp
 924                     	xref	c_ladd
 925                     	xref	c_rtol
 926                     	xref	c_itolx
 927                     	xref	c_llsh
 928                     	xref	c_ltor
 929                     	end
