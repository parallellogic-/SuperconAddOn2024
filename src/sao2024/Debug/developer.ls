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
 593                     .const:	section	.text
 594  0000               L22:
 595  0000 00000080      	dc.l	128
 596  0004               L42:
 597  0004 0000000a      	dc.l	10
 598  0008               L62:
 599  0008 00000003      	dc.l	3
 600  000c               L03:
 601  000c 000000ff      	dc.l	255
 602  0010               L23:
 603  0010 0000000c      	dc.l	12
 604                     ; 70 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 604                     ; 71 {
 605                     	switch	.text
 606  0139               _execute_terminal_command:
 608  0139 88            	push	a
 609  013a 88            	push	a
 610       00000001      OFST:	set	1
 613                     ; 73 	bool is_valid=0;
 615  013b 0f01          	clr	(OFST+0,sp)
 617                     ; 74 	switch(command)
 620                     ; 134 		}break;
 621  013d a061          	sub	a,#97
 622  013f 2603          	jrne	L43
 623  0141 cc029e        	jp	L771
 624  0144               L43:
 625  0144 a004          	sub	a,#4
 626  0146 2779          	jreq	L171
 627  0148 a007          	sub	a,#7
 628  014a 2603          	jrne	L63
 629  014c cc01f8        	jp	L371
 630  014f               L63:
 631  014f a004          	sub	a,#4
 632  0151 270f          	jreq	L561
 633  0153 a004          	sub	a,#4
 634  0155 273f          	jreq	L761
 635  0157 a003          	sub	a,#3
 636  0159 2603          	jrne	L04
 637  015b cc0258        	jp	L571
 638  015e               L04:
 639  015e acb802b8      	jpf	L142
 640  0162               L561:
 641                     ; 77 			Serial_print_char(command);
 643  0162 7b02          	ld	a,(OFST+1,sp)
 644  0164 cd0000        	call	_Serial_print_char
 646                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 648  0167 0f01          	clr	(OFST+0,sp)
 651  0169 201d          	jra	L742
 652  016b               L342:
 653                     ; 80 				Serial_print_char(' ');
 655  016b a620          	ld	a,#32
 656  016d cd0000        	call	_Serial_print_char
 658                     ; 81 				Serial_print_u32((*parameters)[iter]);
 660  0170 7b01          	ld	a,(OFST+0,sp)
 661  0172 97            	ld	xl,a
 662  0173 a604          	ld	a,#4
 663  0175 42            	mul	x,a
 664  0176 72fb05        	addw	x,(OFST+4,sp)
 665  0179 9093          	ldw	y,x
 666  017b ee02          	ldw	x,(2,x)
 667  017d 89            	pushw	x
 668  017e 93            	ldw	x,y
 669  017f fe            	ldw	x,(x)
 670  0180 89            	pushw	x
 671  0181 cd0000        	call	_Serial_print_u32
 673  0184 5b04          	addw	sp,#4
 674                     ; 78 			for(iter=0;iter<parameter_count;iter++)
 676  0186 0c01          	inc	(OFST+0,sp)
 678  0188               L742:
 681  0188 7b01          	ld	a,(OFST+0,sp)
 682  018a 1107          	cp	a,(OFST+6,sp)
 683  018c 25dd          	jrult	L342
 684                     ; 83 			is_valid=1;
 686  018e a601          	ld	a,#1
 687  0190 6b01          	ld	(OFST+0,sp),a
 689                     ; 84 		}break;
 691  0192 acb802b8      	jpf	L142
 692  0196               L761:
 693                     ; 86 			if(parameter_count) set_millis((*parameters)[0]);
 695  0196 0d07          	tnz	(OFST+6,sp)
 696  0198 2711          	jreq	L352
 699  019a 1e05          	ldw	x,(OFST+4,sp)
 700  019c 9093          	ldw	y,x
 701  019e ee02          	ldw	x,(2,x)
 702  01a0 89            	pushw	x
 703  01a1 93            	ldw	x,y
 704  01a2 fe            	ldw	x,(x)
 705  01a3 89            	pushw	x
 706  01a4 cd0000        	call	_set_millis
 708  01a7 5b04          	addw	sp,#4
 710  01a9 200e          	jra	L552
 711  01ab               L352:
 712                     ; 87 			else Serial_print_u32(millis());
 714  01ab cd0000        	call	_millis
 716  01ae be02          	ldw	x,c_lreg+2
 717  01b0 89            	pushw	x
 718  01b1 be00          	ldw	x,c_lreg
 719  01b3 89            	pushw	x
 720  01b4 cd0000        	call	_Serial_print_u32
 722  01b7 5b04          	addw	sp,#4
 723  01b9               L552:
 724                     ; 88 			is_valid=1;
 726  01b9 a601          	ld	a,#1
 727  01bb 6b01          	ld	(OFST+0,sp),a
 729                     ; 89 		}break;
 731  01bd acb802b8      	jpf	L142
 732  01c1               L171:
 733                     ; 91 			if(parameter_count==1)
 735  01c1 7b07          	ld	a,(OFST+6,sp)
 736  01c3 a101          	cp	a,#1
 737  01c5 2703          	jreq	L24
 738  01c7 cc02b8        	jp	L142
 739  01ca               L24:
 740                     ; 93 				if((*parameters)[0]<128)
 742  01ca 1e05          	ldw	x,(OFST+4,sp)
 743  01cc cd0000        	call	c_ltor
 745  01cf ae0000        	ldw	x,#L22
 746  01d2 cd0000        	call	c_lcmp
 748  01d5 2503          	jrult	L44
 749  01d7 cc02b8        	jp	L142
 750  01da               L44:
 751                     ; 95 					Serial_print_u32(get_eeprom_byte((*parameters)[0]));
 753  01da 1e05          	ldw	x,(OFST+4,sp)
 754  01dc ee02          	ldw	x,(2,x)
 755  01de cd0000        	call	_get_eeprom_byte
 757  01e1 b703          	ld	c_lreg+3,a
 758  01e3 3f02          	clr	c_lreg+2
 759  01e5 3f01          	clr	c_lreg+1
 760  01e7 3f00          	clr	c_lreg
 761  01e9 be02          	ldw	x,c_lreg+2
 762  01eb 89            	pushw	x
 763  01ec be00          	ldw	x,c_lreg
 764  01ee 89            	pushw	x
 765  01ef cd0000        	call	_Serial_print_u32
 767  01f2 5b04          	addw	sp,#4
 768  01f4 acb802b8      	jpf	L142
 769  01f8               L371:
 770                     ; 109 			is_valid=1;
 772  01f8 a601          	ld	a,#1
 773  01fa 6b01          	ld	(OFST+0,sp),a
 775                     ; 110 			if(parameter_count<3) is_valid=0;
 777  01fc 7b07          	ld	a,(OFST+6,sp)
 778  01fe a103          	cp	a,#3
 779  0200 2402          	jruge	L362
 782  0202 0f01          	clr	(OFST+0,sp)
 784  0204               L362:
 785                     ; 111 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
 787  0204 1e05          	ldw	x,(OFST+4,sp)
 788  0206 cd0000        	call	c_ltor
 790  0209 ae0004        	ldw	x,#L42
 791  020c cd0000        	call	c_lcmp
 793  020f 2502          	jrult	L562
 796  0211 0f01          	clr	(OFST+0,sp)
 798  0213               L562:
 799                     ; 112 			if((*parameters)[1]>=3) is_valid=0;
 801  0213 1e05          	ldw	x,(OFST+4,sp)
 802  0215 1c0004        	addw	x,#4
 803  0218 cd0000        	call	c_ltor
 805  021b ae0008        	ldw	x,#L62
 806  021e cd0000        	call	c_lcmp
 808  0221 2502          	jrult	L762
 811  0223 0f01          	clr	(OFST+0,sp)
 813  0225               L762:
 814                     ; 113 			if((*parameters)[2]>=255) is_valid=0;
 816  0225 1e05          	ldw	x,(OFST+4,sp)
 817  0227 1c0008        	addw	x,#8
 818  022a cd0000        	call	c_ltor
 820  022d ae000c        	ldw	x,#L03
 821  0230 cd0000        	call	c_lcmp
 823  0233 2502          	jrult	L172
 826  0235 0f01          	clr	(OFST+0,sp)
 828  0237               L172:
 829                     ; 114 			if(is_valid)
 831  0237 0d01          	tnz	(OFST+0,sp)
 832  0239 2602          	jrne	L64
 833  023b 207b          	jp	L142
 834  023d               L64:
 835                     ; 116 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
 837  023d 1e05          	ldw	x,(OFST+4,sp)
 838  023f e60b          	ld	a,(11,x)
 839  0241 88            	push	a
 840  0242 1e06          	ldw	x,(OFST+5,sp)
 841  0244 e607          	ld	a,(7,x)
 842  0246 97            	ld	xl,a
 843  0247 1606          	ldw	y,(OFST+5,sp)
 844  0249 90e603        	ld	a,(3,y)
 845  024c 95            	ld	xh,a
 846  024d cd0000        	call	_set_rgb
 848  0250 84            	pop	a
 849                     ; 117 				flush_leds(2);//1 RGB led element and 1 for status led
 851  0251 a602          	ld	a,#2
 852  0253 cd0000        	call	_flush_leds
 854  0256 2060          	jra	L142
 855  0258               L571:
 856                     ; 121 			is_valid=1;
 858  0258 a601          	ld	a,#1
 859  025a 6b01          	ld	(OFST+0,sp),a
 861                     ; 122 			if(parameter_count<2) is_valid=0;
 863  025c 7b07          	ld	a,(OFST+6,sp)
 864  025e a102          	cp	a,#2
 865  0260 2402          	jruge	L572
 868  0262 0f01          	clr	(OFST+0,sp)
 870  0264               L572:
 871                     ; 123 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
 873  0264 1e05          	ldw	x,(OFST+4,sp)
 874  0266 cd0000        	call	c_ltor
 876  0269 ae0010        	ldw	x,#L23
 877  026c cd0000        	call	c_lcmp
 879  026f 2502          	jrult	L772
 882  0271 0f01          	clr	(OFST+0,sp)
 884  0273               L772:
 885                     ; 124 			if((*parameters)[1]>=255) is_valid=0;
 887  0273 1e05          	ldw	x,(OFST+4,sp)
 888  0275 1c0004        	addw	x,#4
 889  0278 cd0000        	call	c_ltor
 891  027b ae000c        	ldw	x,#L03
 892  027e cd0000        	call	c_lcmp
 894  0281 2502          	jrult	L103
 897  0283 0f01          	clr	(OFST+0,sp)
 899  0285               L103:
 900                     ; 125 			if(is_valid)
 902  0285 0d01          	tnz	(OFST+0,sp)
 903  0287 272f          	jreq	L142
 904                     ; 127 				set_white((*parameters)[0],(*parameters)[1]);
 906  0289 1e05          	ldw	x,(OFST+4,sp)
 907  028b e607          	ld	a,(7,x)
 908  028d 97            	ld	xl,a
 909  028e 1605          	ldw	y,(OFST+4,sp)
 910  0290 90e603        	ld	a,(3,y)
 911  0293 95            	ld	xh,a
 912  0294 cd0000        	call	_set_white
 914                     ; 128 				flush_leds(2);//1 RGB led element and 1 for status led
 916  0297 a602          	ld	a,#2
 917  0299 cd0000        	call	_flush_leds
 919  029c 201a          	jra	L142
 920  029e               L771:
 921                     ; 132 			Serial_print_u32(get_audio_level());
 923  029e cd0000        	call	_get_audio_level
 925  02a1 b703          	ld	c_lreg+3,a
 926  02a3 3f02          	clr	c_lreg+2
 927  02a5 3f01          	clr	c_lreg+1
 928  02a7 3f00          	clr	c_lreg
 929  02a9 be02          	ldw	x,c_lreg+2
 930  02ab 89            	pushw	x
 931  02ac be00          	ldw	x,c_lreg
 932  02ae 89            	pushw	x
 933  02af cd0000        	call	_Serial_print_u32
 935  02b2 5b04          	addw	sp,#4
 936                     ; 133 			is_valid=1;
 938  02b4 a601          	ld	a,#1
 939  02b6 6b01          	ld	(OFST+0,sp),a
 941                     ; 134 		}break;
 943  02b8               L142:
 944                     ; 136 	if(!is_valid) Serial_print_string("Invalid. h");
 946  02b8 0d01          	tnz	(OFST+0,sp)
 947  02ba 2606          	jrne	L503
 950  02bc ae0014        	ldw	x,#L703
 951  02bf cd0000        	call	_Serial_print_string
 953  02c2               L503:
 954                     ; 137 	Serial_newline();
 956  02c2 cd0000        	call	_Serial_newline
 958                     ; 138 }
 961  02c5 85            	popw	x
 962  02c6 81            	ret
 975                     	xref	_Serial_print_u32
 976                     	xref	_Serial_read_char
 977                     	xref	_Serial_available
 978                     	xref	_Serial_newline
 979                     	xref	_Serial_print_string
 980                     	xref	_Serial_print_char
 981                     	xdef	_execute_terminal_command
 982                     	xdef	_get_terminal_command
 983                     	xdef	_run_developer
 984                     	xdef	_setup_developer
 985                     	xref	_get_eeprom_byte
 986                     	xref	_set_millis
 987                     	xref	_get_audio_level
 988                     	xref	_clear_button_events
 989                     	xref	_is_developer_valid
 990                     	xref	_flush_leds
 991                     	xref	_set_debug
 992                     	xref	_set_white
 993                     	xref	_set_rgb
 994                     	xref	_millis
 995                     	xref	_setup_serial
 996                     	switch	.const
 997  0014               L703:
 998  0014 496e76616c69  	dc.b	"Invalid. h",0
 999  001f               L55:
1000  001f 3e2000        	dc.b	"> ",0
1001                     	xref.b	c_lreg
1021                     	xref	c_lcmp
1022                     	xref	c_ladd
1023                     	xref	c_rtol
1024                     	xref	c_itolx
1025                     	xref	c_llsh
1026                     	xref	c_ltor
1027                     	end
