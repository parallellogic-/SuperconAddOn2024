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
 592                     .const:	section	.text
 593  0000               L22:
 594  0000 00000080      	dc.l	128
 595  0004               L42:
 596  0004 0000000a      	dc.l	10
 597  0008               L62:
 598  0008 00000003      	dc.l	3
 599  000c               L03:
 600  000c 000000ff      	dc.l	255
 601  0010               L23:
 602  0010 0000000c      	dc.l	12
 603                     ; 70 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 603                     ; 71 {
 604                     	switch	.text
 605  0139               _execute_terminal_command:
 607  0139 88            	push	a
 608  013a 88            	push	a
 609       00000001      OFST:	set	1
 612                     ; 73 	bool is_valid=0;
 614  013b 0f01          	clr	(OFST+0,sp)
 616                     ; 74 	switch(command)
 619                     ; 130 		}break;
 620  013d a065          	sub	a,#101
 621  013f 2779          	jreq	L171
 622  0141 a007          	sub	a,#7
 623  0143 2603          	jrne	L43
 624  0145 cc01f1        	jp	L371
 625  0148               L43:
 626  0148 a004          	sub	a,#4
 627  014a 270f          	jreq	L561
 628  014c a004          	sub	a,#4
 629  014e 273f          	jreq	L761
 630  0150 a003          	sub	a,#3
 631  0152 2603          	jrne	L63
 632  0154 cc024f        	jp	L571
 633  0157               L63:
 634  0157 ac930293      	jpf	L732
 635  015b               L561:
 636                     ; 77 			Serial_print_char(command);
 638  015b 7b02          	ld	a,(OFST+1,sp)
 639  015d cd0000        	call	_Serial_print_char
 641                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 643  0160 0f01          	clr	(OFST+0,sp)
 646  0162 201d          	jra	L542
 647  0164               L142:
 648                     ; 80 				Serial_print_char(' ');
 650  0164 a620          	ld	a,#32
 651  0166 cd0000        	call	_Serial_print_char
 653                     ; 81 				Serial_print_u32((*parameters)[iter]);
 655  0169 7b01          	ld	a,(OFST+0,sp)
 656  016b 97            	ld	xl,a
 657  016c a604          	ld	a,#4
 658  016e 42            	mul	x,a
 659  016f 72fb05        	addw	x,(OFST+4,sp)
 660  0172 9093          	ldw	y,x
 661  0174 ee02          	ldw	x,(2,x)
 662  0176 89            	pushw	x
 663  0177 93            	ldw	x,y
 664  0178 fe            	ldw	x,(x)
 665  0179 89            	pushw	x
 666  017a cd0000        	call	_Serial_print_u32
 668  017d 5b04          	addw	sp,#4
 669                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 671  017f 0c01          	inc	(OFST+0,sp)
 673  0181               L542:
 676  0181 7b01          	ld	a,(OFST+0,sp)
 677  0183 1107          	cp	a,(OFST+6,sp)
 678  0185 25dd          	jrult	L142
 679                     ; 83 			is_valid=1;
 681  0187 a601          	ld	a,#1
 682  0189 6b01          	ld	(OFST+0,sp),a
 684                     ; 84 		}break;
 686  018b ac930293      	jpf	L732
 687  018f               L761:
 688                     ; 86 			if(parameter_count) set_millis((*parameters)[0]);
 690  018f 0d07          	tnz	(OFST+6,sp)
 691  0191 2711          	jreq	L152
 694  0193 1e05          	ldw	x,(OFST+4,sp)
 695  0195 9093          	ldw	y,x
 696  0197 ee02          	ldw	x,(2,x)
 697  0199 89            	pushw	x
 698  019a 93            	ldw	x,y
 699  019b fe            	ldw	x,(x)
 700  019c 89            	pushw	x
 701  019d cd0000        	call	_set_millis
 703  01a0 5b04          	addw	sp,#4
 705  01a2 200e          	jra	L352
 706  01a4               L152:
 707                     ; 87 			else Serial_print_u32(millis());
 709  01a4 cd0000        	call	_millis
 711  01a7 be02          	ldw	x,c_lreg+2
 712  01a9 89            	pushw	x
 713  01aa be00          	ldw	x,c_lreg
 714  01ac 89            	pushw	x
 715  01ad cd0000        	call	_Serial_print_u32
 717  01b0 5b04          	addw	sp,#4
 718  01b2               L352:
 719                     ; 88 			is_valid=1;
 721  01b2 a601          	ld	a,#1
 722  01b4 6b01          	ld	(OFST+0,sp),a
 724                     ; 89 		}break;
 726  01b6 ac930293      	jpf	L732
 727  01ba               L171:
 728                     ; 91 			if(parameter_count==1)
 730  01ba 7b07          	ld	a,(OFST+6,sp)
 731  01bc a101          	cp	a,#1
 732  01be 2703          	jreq	L04
 733  01c0 cc0293        	jp	L732
 734  01c3               L04:
 735                     ; 93 				if((*parameters)[0]<128)
 737  01c3 1e05          	ldw	x,(OFST+4,sp)
 738  01c5 cd0000        	call	c_ltor
 740  01c8 ae0000        	ldw	x,#L22
 741  01cb cd0000        	call	c_lcmp
 743  01ce 2503          	jrult	L24
 744  01d0 cc0293        	jp	L732
 745  01d3               L24:
 746                     ; 95 					Serial_print_u32(get_eeprom_byte((*parameters)[0]));
 748  01d3 1e05          	ldw	x,(OFST+4,sp)
 749  01d5 ee02          	ldw	x,(2,x)
 750  01d7 cd0000        	call	_get_eeprom_byte
 752  01da b703          	ld	c_lreg+3,a
 753  01dc 3f02          	clr	c_lreg+2
 754  01de 3f01          	clr	c_lreg+1
 755  01e0 3f00          	clr	c_lreg
 756  01e2 be02          	ldw	x,c_lreg+2
 757  01e4 89            	pushw	x
 758  01e5 be00          	ldw	x,c_lreg
 759  01e7 89            	pushw	x
 760  01e8 cd0000        	call	_Serial_print_u32
 762  01eb 5b04          	addw	sp,#4
 763  01ed ac930293      	jpf	L732
 764  01f1               L371:
 765                     ; 109 			is_valid=1;
 767  01f1 a601          	ld	a,#1
 768  01f3 6b01          	ld	(OFST+0,sp),a
 770                     ; 110 			if(parameter_count<3) is_valid=0;
 772  01f5 7b07          	ld	a,(OFST+6,sp)
 773  01f7 a103          	cp	a,#3
 774  01f9 2402          	jruge	L162
 777  01fb 0f01          	clr	(OFST+0,sp)
 779  01fd               L162:
 780                     ; 111 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 782  01fd 1e05          	ldw	x,(OFST+4,sp)
 783  01ff cd0000        	call	c_ltor
 785  0202 ae0004        	ldw	x,#L42
 786  0205 cd0000        	call	c_lcmp
 788  0208 2502          	jrult	L362
 791  020a 0f01          	clr	(OFST+0,sp)
 793  020c               L362:
 794                     ; 112 			if((*parameters)[1]>=3) is_valid=0;
 796  020c 1e05          	ldw	x,(OFST+4,sp)
 797  020e 1c0004        	addw	x,#4
 798  0211 cd0000        	call	c_ltor
 800  0214 ae0008        	ldw	x,#L62
 801  0217 cd0000        	call	c_lcmp
 803  021a 2502          	jrult	L562
 806  021c 0f01          	clr	(OFST+0,sp)
 808  021e               L562:
 809                     ; 113 			if((*parameters)[2]>=255) is_valid=0;
 811  021e 1e05          	ldw	x,(OFST+4,sp)
 812  0220 1c0008        	addw	x,#8
 813  0223 cd0000        	call	c_ltor
 815  0226 ae000c        	ldw	x,#L03
 816  0229 cd0000        	call	c_lcmp
 818  022c 2502          	jrult	L762
 821  022e 0f01          	clr	(OFST+0,sp)
 823  0230               L762:
 824                     ; 114 			if(is_valid)
 826  0230 0d01          	tnz	(OFST+0,sp)
 827  0232 275f          	jreq	L732
 828                     ; 116 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 830  0234 1e05          	ldw	x,(OFST+4,sp)
 831  0236 e60b          	ld	a,(11,x)
 832  0238 88            	push	a
 833  0239 1e06          	ldw	x,(OFST+5,sp)
 834  023b e607          	ld	a,(7,x)
 835  023d 97            	ld	xl,a
 836  023e 1606          	ldw	y,(OFST+5,sp)
 837  0240 90e603        	ld	a,(3,y)
 838  0243 95            	ld	xh,a
 839  0244 cd0000        	call	_set_rgb
 841  0247 84            	pop	a
 842                     ; 117 				flush_leds(2);//1 RGB led element and 1 for status led
 844  0248 a602          	ld	a,#2
 845  024a cd0000        	call	_flush_leds
 847  024d 2044          	jra	L732
 848  024f               L571:
 849                     ; 121 			is_valid=1;
 851  024f a601          	ld	a,#1
 852  0251 6b01          	ld	(OFST+0,sp),a
 854                     ; 122 			if(parameter_count<2) is_valid=0;
 856  0253 7b07          	ld	a,(OFST+6,sp)
 857  0255 a102          	cp	a,#2
 858  0257 2402          	jruge	L372
 861  0259 0f01          	clr	(OFST+0,sp)
 863  025b               L372:
 864                     ; 123 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 866  025b 1e05          	ldw	x,(OFST+4,sp)
 867  025d cd0000        	call	c_ltor
 869  0260 ae0010        	ldw	x,#L23
 870  0263 cd0000        	call	c_lcmp
 872  0266 2502          	jrult	L572
 875  0268 0f01          	clr	(OFST+0,sp)
 877  026a               L572:
 878                     ; 124 			if((*parameters)[1]>=255) is_valid=0;
 880  026a 1e05          	ldw	x,(OFST+4,sp)
 881  026c 1c0004        	addw	x,#4
 882  026f cd0000        	call	c_ltor
 884  0272 ae000c        	ldw	x,#L03
 885  0275 cd0000        	call	c_lcmp
 887  0278 2502          	jrult	L772
 890  027a 0f01          	clr	(OFST+0,sp)
 892  027c               L772:
 893                     ; 125 			if(is_valid)
 895  027c 0d01          	tnz	(OFST+0,sp)
 896  027e 2713          	jreq	L732
 897                     ; 127 				set_white((*parameters)[0],(*parameters)[1]);
 899  0280 1e05          	ldw	x,(OFST+4,sp)
 900  0282 e607          	ld	a,(7,x)
 901  0284 97            	ld	xl,a
 902  0285 1605          	ldw	y,(OFST+4,sp)
 903  0287 90e603        	ld	a,(3,y)
 904  028a 95            	ld	xh,a
 905  028b cd0000        	call	_set_white
 907                     ; 128 				flush_leds(2);//1 RGB led element and 1 for status led
 909  028e a602          	ld	a,#2
 910  0290 cd0000        	call	_flush_leds
 912  0293               L732:
 913                     ; 132 	if(!is_valid) Serial_print_string("Invalid. h");
 915  0293 0d01          	tnz	(OFST+0,sp)
 916  0295 2606          	jrne	L303
 919  0297 ae0014        	ldw	x,#L503
 920  029a cd0000        	call	_Serial_print_string
 922  029d               L303:
 923                     ; 133 	Serial_newline();
 925  029d cd0000        	call	_Serial_newline
 927                     ; 134 }
 930  02a0 85            	popw	x
 931  02a1 81            	ret
 944                     	xref	_Serial_print_u32
 945                     	xref	_Serial_read_char
 946                     	xref	_Serial_available
 947                     	xref	_Serial_newline
 948                     	xref	_Serial_print_string
 949                     	xref	_Serial_print_char
 950                     	xdef	_execute_terminal_command
 951                     	xdef	_get_terminal_command
 952                     	xdef	_run_developer
 953                     	xdef	_setup_developer
 954                     	xref	_get_eeprom_byte
 955                     	xref	_set_millis
 956                     	xref	_clear_button_events
 957                     	xref	_is_developer_valid
 958                     	xref	_flush_leds
 959                     	xref	_set_debug
 960                     	xref	_set_white
 961                     	xref	_set_rgb
 962                     	xref	_millis
 963                     	xref	_setup_serial
 964                     	switch	.const
 965  0014               L503:
 966  0014 496e76616c69  	dc.b	"Invalid. h",0
 967  001f               L55:
 968  001f 3e2000        	dc.b	"> ",0
 969                     	xref.b	c_lreg
 989                     	xref	c_lcmp
 990                     	xref	c_ladd
 991                     	xref	c_rtol
 992                     	xref	c_itolx
 993                     	xref	c_llsh
 994                     	xref	c_ltor
 995                     	end
