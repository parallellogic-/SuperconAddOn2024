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
 156  001e ae001f        	ldw	x,#L55
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
 590                     .const:	section	.text
 591  0000               L22:
 592  0000 00000080      	dc.l	128
 593  0004               L42:
 594  0004 00000006      	dc.l	6
 595  0008               L62:
 596  0008 00000003      	dc.l	3
 597  000c               L03:
 598  000c 000000ff      	dc.l	255
 599  0010               L23:
 600  0010 0000000c      	dc.l	12
 601                     ; 70 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 601                     ; 71 {
 602                     	switch	.text
 603  0139               _execute_terminal_command:
 605  0139 88            	push	a
 606  013a 88            	push	a
 607       00000001      OFST:	set	1
 610                     ; 73 	bool is_valid=0;
 612  013b 0f01          	clr	(OFST+0,sp)
 614                     ; 74 	switch(command)
 617                     ; 130 		}break;
 618  013d a065          	sub	a,#101
 619  013f 2756          	jreq	L171
 620  0141 a007          	sub	a,#7
 621  0143 2603          	jrne	L43
 622  0145 cc01ce        	jp	L371
 623  0148               L43:
 624  0148 a004          	sub	a,#4
 625  014a 270f          	jreq	L561
 626  014c a004          	sub	a,#4
 627  014e 273f          	jreq	L761
 628  0150 a003          	sub	a,#3
 629  0152 2603          	jrne	L63
 630  0154 cc022c        	jp	L571
 631  0157               L63:
 632  0157 ac700270      	jpf	L732
 633  015b               L561:
 634                     ; 77 			Serial_print_char(command);
 636  015b 7b02          	ld	a,(OFST+1,sp)
 637  015d cd0000        	call	_Serial_print_char
 639                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 641  0160 0f01          	clr	(OFST+0,sp)
 644  0162 201d          	jra	L542
 645  0164               L142:
 646                     ; 80 				Serial_print_char(' ');
 648  0164 a620          	ld	a,#32
 649  0166 cd0000        	call	_Serial_print_char
 651                     ; 81 				Serial_print_u32((*parameters)[iter]);
 653  0169 7b01          	ld	a,(OFST+0,sp)
 654  016b 97            	ld	xl,a
 655  016c a604          	ld	a,#4
 656  016e 42            	mul	x,a
 657  016f 72fb05        	addw	x,(OFST+4,sp)
 658  0172 9093          	ldw	y,x
 659  0174 ee02          	ldw	x,(2,x)
 660  0176 89            	pushw	x
 661  0177 93            	ldw	x,y
 662  0178 fe            	ldw	x,(x)
 663  0179 89            	pushw	x
 664  017a cd0000        	call	_Serial_print_u32
 666  017d 5b04          	addw	sp,#4
 667                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 669  017f 0c01          	inc	(OFST+0,sp)
 671  0181               L542:
 674  0181 7b01          	ld	a,(OFST+0,sp)
 675  0183 1107          	cp	a,(OFST+6,sp)
 676  0185 25dd          	jrult	L142
 677                     ; 83 			is_valid=1;
 679  0187 a601          	ld	a,#1
 680  0189 6b01          	ld	(OFST+0,sp),a
 682                     ; 84 		}break;
 684  018b ac700270      	jpf	L732
 685  018f               L761:
 686                     ; 88 			is_valid=1;
 688  018f a601          	ld	a,#1
 689  0191 6b01          	ld	(OFST+0,sp),a
 691                     ; 89 		}break;
 693  0193 ac700270      	jpf	L732
 694  0197               L171:
 695                     ; 91 			if(parameter_count==1)
 697  0197 7b07          	ld	a,(OFST+6,sp)
 698  0199 a101          	cp	a,#1
 699  019b 2703          	jreq	L04
 700  019d cc0270        	jp	L732
 701  01a0               L04:
 702                     ; 93 				if((*parameters)[0]<128)
 704  01a0 1e05          	ldw	x,(OFST+4,sp)
 705  01a2 cd0000        	call	c_ltor
 707  01a5 ae0000        	ldw	x,#L22
 708  01a8 cd0000        	call	c_lcmp
 710  01ab 2503          	jrult	L24
 711  01ad cc0270        	jp	L732
 712  01b0               L24:
 713                     ; 95 					Serial_print_u32(get_eeprom_byte((*parameters)[0]));
 715  01b0 1e05          	ldw	x,(OFST+4,sp)
 716  01b2 ee02          	ldw	x,(2,x)
 717  01b4 cd0000        	call	_get_eeprom_byte
 719  01b7 b703          	ld	c_lreg+3,a
 720  01b9 3f02          	clr	c_lreg+2
 721  01bb 3f01          	clr	c_lreg+1
 722  01bd 3f00          	clr	c_lreg
 723  01bf be02          	ldw	x,c_lreg+2
 724  01c1 89            	pushw	x
 725  01c2 be00          	ldw	x,c_lreg
 726  01c4 89            	pushw	x
 727  01c5 cd0000        	call	_Serial_print_u32
 729  01c8 5b04          	addw	sp,#4
 730  01ca ac700270      	jpf	L732
 731  01ce               L371:
 732                     ; 109 			is_valid=1;
 734  01ce a601          	ld	a,#1
 735  01d0 6b01          	ld	(OFST+0,sp),a
 737                     ; 110 			if(parameter_count<3) is_valid=0;
 739  01d2 7b07          	ld	a,(OFST+6,sp)
 740  01d4 a103          	cp	a,#3
 741  01d6 2402          	jruge	L552
 744  01d8 0f01          	clr	(OFST+0,sp)
 746  01da               L552:
 747                     ; 111 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 749  01da 1e05          	ldw	x,(OFST+4,sp)
 750  01dc cd0000        	call	c_ltor
 752  01df ae0004        	ldw	x,#L42
 753  01e2 cd0000        	call	c_lcmp
 755  01e5 2502          	jrult	L752
 758  01e7 0f01          	clr	(OFST+0,sp)
 760  01e9               L752:
 761                     ; 112 			if((*parameters)[1]>=3) is_valid=0;
 763  01e9 1e05          	ldw	x,(OFST+4,sp)
 764  01eb 1c0004        	addw	x,#4
 765  01ee cd0000        	call	c_ltor
 767  01f1 ae0008        	ldw	x,#L62
 768  01f4 cd0000        	call	c_lcmp
 770  01f7 2502          	jrult	L162
 773  01f9 0f01          	clr	(OFST+0,sp)
 775  01fb               L162:
 776                     ; 113 			if((*parameters)[2]>=255) is_valid=0;
 778  01fb 1e05          	ldw	x,(OFST+4,sp)
 779  01fd 1c0008        	addw	x,#8
 780  0200 cd0000        	call	c_ltor
 782  0203 ae000c        	ldw	x,#L03
 783  0206 cd0000        	call	c_lcmp
 785  0209 2502          	jrult	L362
 788  020b 0f01          	clr	(OFST+0,sp)
 790  020d               L362:
 791                     ; 114 			if(is_valid)
 793  020d 0d01          	tnz	(OFST+0,sp)
 794  020f 275f          	jreq	L732
 795                     ; 116 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 797  0211 1e05          	ldw	x,(OFST+4,sp)
 798  0213 e60b          	ld	a,(11,x)
 799  0215 88            	push	a
 800  0216 1e06          	ldw	x,(OFST+5,sp)
 801  0218 e607          	ld	a,(7,x)
 802  021a 97            	ld	xl,a
 803  021b 1606          	ldw	y,(OFST+5,sp)
 804  021d 90e603        	ld	a,(3,y)
 805  0220 95            	ld	xh,a
 806  0221 cd0000        	call	_set_rgb
 808  0224 84            	pop	a
 809                     ; 117 				flush_leds(2);//1 RGB led element and 1 for status led
 811  0225 a602          	ld	a,#2
 812  0227 cd0000        	call	_flush_leds
 814  022a 2044          	jra	L732
 815  022c               L571:
 816                     ; 121 			is_valid=1;
 818  022c a601          	ld	a,#1
 819  022e 6b01          	ld	(OFST+0,sp),a
 821                     ; 122 			if(parameter_count<2) is_valid=0;
 823  0230 7b07          	ld	a,(OFST+6,sp)
 824  0232 a102          	cp	a,#2
 825  0234 2402          	jruge	L762
 828  0236 0f01          	clr	(OFST+0,sp)
 830  0238               L762:
 831                     ; 123 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 833  0238 1e05          	ldw	x,(OFST+4,sp)
 834  023a cd0000        	call	c_ltor
 836  023d ae0010        	ldw	x,#L23
 837  0240 cd0000        	call	c_lcmp
 839  0243 2502          	jrult	L172
 842  0245 0f01          	clr	(OFST+0,sp)
 844  0247               L172:
 845                     ; 124 			if((*parameters)[1]>=255) is_valid=0;
 847  0247 1e05          	ldw	x,(OFST+4,sp)
 848  0249 1c0004        	addw	x,#4
 849  024c cd0000        	call	c_ltor
 851  024f ae000c        	ldw	x,#L03
 852  0252 cd0000        	call	c_lcmp
 854  0255 2502          	jrult	L372
 857  0257 0f01          	clr	(OFST+0,sp)
 859  0259               L372:
 860                     ; 125 			if(is_valid)
 862  0259 0d01          	tnz	(OFST+0,sp)
 863  025b 2713          	jreq	L732
 864                     ; 127 				set_white((*parameters)[0],(*parameters)[1]);
 866  025d 1e05          	ldw	x,(OFST+4,sp)
 867  025f e607          	ld	a,(7,x)
 868  0261 97            	ld	xl,a
 869  0262 1605          	ldw	y,(OFST+4,sp)
 870  0264 90e603        	ld	a,(3,y)
 871  0267 95            	ld	xh,a
 872  0268 cd0000        	call	_set_white
 874                     ; 128 				flush_leds(2);//1 RGB led element and 1 for status led
 876  026b a602          	ld	a,#2
 877  026d cd0000        	call	_flush_leds
 879  0270               L732:
 880                     ; 132 	if(!is_valid) Serial_print_string("Invalid. h");
 882  0270 0d01          	tnz	(OFST+0,sp)
 883  0272 2606          	jrne	L772
 886  0274 ae0014        	ldw	x,#L103
 887  0277 cd0000        	call	_Serial_print_string
 889  027a               L772:
 890                     ; 133 	Serial_newline();
 892  027a cd0000        	call	_Serial_newline
 894                     ; 134 }
 897  027d 85            	popw	x
 898  027e 81            	ret
 911                     	xref	_Serial_print_u32
 912                     	xref	_Serial_read_char
 913                     	xref	_Serial_available
 914                     	xref	_Serial_newline
 915                     	xref	_Serial_print_string
 916                     	xref	_Serial_print_char
 917                     	xdef	_execute_terminal_command
 918                     	xdef	_get_terminal_command
 919                     	xdef	_run_developer
 920                     	xdef	_setup_developer
 921                     	xref	_get_eeprom_byte
 922                     	xref	_clear_button_events
 923                     	xref	_is_developer_valid
 924                     	xref	_flush_leds
 925                     	xref	_set_debug
 926                     	xref	_set_white
 927                     	xref	_set_rgb
 928                     	xref	_setup_serial
 929                     	switch	.const
 930  0014               L103:
 931  0014 496e76616c69  	dc.b	"Invalid. h",0
 932  001f               L55:
 933  001f 3e2000        	dc.b	"> ",0
 934                     	xref.b	c_lreg
 954                     	xref	c_lcmp
 955                     	xref	c_ladd
 956                     	xref	c_rtol
 957                     	xref	c_itolx
 958                     	xref	c_llsh
 959                     	xref	c_ltor
 960                     	end
