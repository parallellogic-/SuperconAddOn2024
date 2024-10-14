   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  50                     ; 7  char Serial_read_char(void)
  50                     ; 8  {
  52                     	switch	.text
  53  0000               _Serial_read_char:
  57  0000               L32:
  58                     ; 9 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
  60  0000 ae0080        	ldw	x,#128
  61  0003 cd0000        	call	_UART1_GetFlagStatus
  63  0006 4d            	tnz	a
  64  0007 27f7          	jreq	L32
  65                     ; 10 	 UART1_ClearFlag(UART1_FLAG_RXNE);
  67  0009 ae0020        	ldw	x,#32
  68  000c cd0000        	call	_UART1_ClearFlag
  70                     ; 11 	 return (UART1_ReceiveData8());
  75  000f cc0000        	jp	_UART1_ReceiveData8
 111                     ; 14  void Serial_print_char (char value)
 111                     ; 15  {
 112                     	switch	.text
 113  0012               _Serial_print_char:
 117                     ; 16 	 UART1_SendData8(value);
 119  0012 cd0000        	call	_UART1_SendData8
 122  0015               L74:
 123                     ; 17 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
 125  0015 ae0080        	ldw	x,#128
 126  0018 cd0000        	call	_UART1_GetFlagStatus
 128  001b 4d            	tnz	a
 129  001c 27f7          	jreq	L74
 130                     ; 18  }
 133  001e 81            	ret	
 171                     ; 20   void Serial_begin(uint32_t baud_rate)
 171                     ; 21  {
 172                     	switch	.text
 173  001f               _Serial_begin:
 175       00000000      OFST:	set	0
 178                     ; 22 	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 180  001f 4bf0          	push	#240
 181  0021 4b20          	push	#32
 182  0023 ae500f        	ldw	x,#20495
 183  0026 cd0000        	call	_GPIO_Init
 185  0029 85            	popw	x
 186                     ; 23 	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 188  002a 4b40          	push	#64
 189  002c 4b40          	push	#64
 190  002e ae500f        	ldw	x,#20495
 191  0031 cd0000        	call	_GPIO_Init
 193  0034 85            	popw	x
 194                     ; 25 	 UART1_DeInit(); //Deinitialize UART peripherals 
 196  0035 cd0000        	call	_UART1_DeInit
 198                     ; 28 		UART1_Init(baud_rate, 
 198                     ; 29                 UART1_WORDLENGTH_8D, 
 198                     ; 30                 UART1_STOPBITS_1, 
 198                     ; 31                 UART1_PARITY_NO, 
 198                     ; 32                 UART1_SYNCMODE_CLOCK_DISABLE, 
 198                     ; 33                 UART1_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
 200  0038 4b0c          	push	#12
 201  003a 4b80          	push	#128
 202  003c 4b00          	push	#0
 203  003e 4b00          	push	#0
 204  0040 4b00          	push	#0
 205  0042 1e0a          	ldw	x,(OFST+10,sp)
 206  0044 89            	pushw	x
 207  0045 1e0a          	ldw	x,(OFST+10,sp)
 208  0047 89            	pushw	x
 209  0048 cd0000        	call	_UART1_Init
 211  004b 5b09          	addw	sp,#9
 212                     ; 35 		UART1_Cmd(ENABLE);
 214  004d a601          	ld	a,#1
 216                     ; 36  }
 219  004f cc0000        	jp	_UART1_Cmd
 273                     ; 38  void Serial_print_u32(u32 number)
 273                     ; 39  {
 274                     	switch	.text
 275  0052               _Serial_print_u32:
 277  0052 89            	pushw	x
 278       00000002      OFST:	set	2
 281                     ; 42 	 Serial_print_string("0x");
 283  0053 ae0005        	ldw	x,#L711
 284  0056 cd00fd        	call	_Serial_print_string
 286                     ; 43 	 for(iter=28;iter<32;iter-=4)
 288  0059 a61c          	ld	a,#28
 289  005b 6b02          	ld	(OFST+0,sp),a
 291  005d               L121:
 292                     ; 45 		 digit=number>>iter;
 294  005d 96            	ldw	x,sp
 295  005e 1c0005        	addw	x,#OFST+3
 296  0061 cd0000        	call	c_ltor
 298  0064 7b02          	ld	a,(OFST+0,sp)
 299  0066 cd0000        	call	c_lursh
 301  0069 b603          	ld	a,c_lreg+3
 302  006b 6b01          	ld	(OFST-1,sp),a
 304                     ; 46 		 if(digit>9) Serial_print_char('A'+(digit-10));
 306  006d a10a          	cp	a,#10
 307  006f 2504          	jrult	L721
 310  0071 ab37          	add	a,#55
 313  0073 2002          	jra	L131
 314  0075               L721:
 315                     ; 47 		 else Serial_print_char('0'+digit);
 317  0075 ab30          	add	a,#48
 319  0077               L131:
 320  0077 ad99          	call	_Serial_print_char
 321                     ; 48 		 if(iter==16) Serial_print_char('_');
 323  0079 7b02          	ld	a,(OFST+0,sp)
 324  007b a110          	cp	a,#16
 325  007d 2606          	jrne	L331
 328  007f a65f          	ld	a,#95
 329  0081 ad8f          	call	_Serial_print_char
 331  0083 7b02          	ld	a,(OFST+0,sp)
 332  0085               L331:
 333                     ; 43 	 for(iter=28;iter<32;iter-=4)
 335  0085 a004          	sub	a,#4
 336  0087 6b02          	ld	(OFST+0,sp),a
 340  0089 a120          	cp	a,#32
 341  008b 25d0          	jrult	L121
 342                     ; 50  }
 345  008d 85            	popw	x
 346  008e 81            	ret	
 349                     .const:	section	.text
 350  0000               L531_digit:
 351  0000 00            	dc.b	0
 352  0001 00000000      	ds.b	4
 405                     ; 52  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 405                     ; 53  {
 406                     	switch	.text
 407  008f               _Serial_print_int:
 409  008f 89            	pushw	x
 410  0090 5208          	subw	sp,#8
 411       00000008      OFST:	set	8
 414                     ; 54 	 char count = 0;
 416  0092 0f08          	clr	(OFST+0,sp)
 418                     ; 55 	 char digit[5] = "";
 420  0094 96            	ldw	x,sp
 421  0095 1c0003        	addw	x,#OFST-5
 422  0098 90ae0000      	ldw	y,#L531_digit
 423  009c a605          	ld	a,#5
 424  009e cd0000        	call	c_xymov
 427  00a1 2021          	jra	L171
 428  00a3               L561:
 429                     ; 59 		 digit[count] = number%10;
 431  00a3 96            	ldw	x,sp
 432  00a4 1c0003        	addw	x,#OFST-5
 433  00a7 9f            	ld	a,xl
 434  00a8 5e            	swapw	x
 435  00a9 1b08          	add	a,(OFST+0,sp)
 436  00ab 2401          	jrnc	L25
 437  00ad 5c            	incw	x
 438  00ae               L25:
 439  00ae 02            	rlwa	x,a
 440  00af 1609          	ldw	y,(OFST+1,sp)
 441  00b1 a60a          	ld	a,#10
 442  00b3 cd0000        	call	c_smody
 444  00b6 9001          	rrwa	y,a
 445  00b8 f7            	ld	(x),a
 446                     ; 60 		 count++;
 448  00b9 0c08          	inc	(OFST+0,sp)
 450                     ; 61 		 number = number/10;
 452  00bb a60a          	ld	a,#10
 453  00bd 1e09          	ldw	x,(OFST+1,sp)
 454  00bf cd0000        	call	c_sdivx
 456  00c2 1f09          	ldw	(OFST+1,sp),x
 457  00c4               L171:
 458                     ; 57 	 while (number != 0) //split the int to char array 
 460  00c4 1e09          	ldw	x,(OFST+1,sp)
 461  00c6 26db          	jrne	L561
 463  00c8 201d          	jra	L771
 464  00ca               L571:
 465                     ; 66 		UART1_SendData8(digit[count-1] + 0x30);
 467  00ca 96            	ldw	x,sp
 468  00cb 1c0003        	addw	x,#OFST-5
 469  00ce 1f01          	ldw	(OFST-7,sp),x
 471  00d0 5f            	clrw	x
 472  00d1 97            	ld	xl,a
 473  00d2 5a            	decw	x
 474  00d3 72fb01        	addw	x,(OFST-7,sp)
 475  00d6 f6            	ld	a,(x)
 476  00d7 ab30          	add	a,#48
 477  00d9 cd0000        	call	_UART1_SendData8
 480  00dc               L502:
 481                     ; 67 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 483  00dc ae0080        	ldw	x,#128
 484  00df cd0000        	call	_UART1_GetFlagStatus
 486  00e2 4d            	tnz	a
 487  00e3 27f7          	jreq	L502
 488                     ; 68 		count--; 
 490  00e5 0a08          	dec	(OFST+0,sp)
 492  00e7               L771:
 493                     ; 64 	 while (count !=0) //print char array in correct direction 
 495  00e7 7b08          	ld	a,(OFST+0,sp)
 496  00e9 26df          	jrne	L571
 497                     ; 70  }
 500  00eb 5b0a          	addw	sp,#10
 501  00ed 81            	ret	
 526                     ; 72  void Serial_newline(void)
 526                     ; 73  {
 527                     	switch	.text
 528  00ee               _Serial_newline:
 532                     ; 74 	 UART1_SendData8(0x0a);
 534  00ee a60a          	ld	a,#10
 535  00f0 cd0000        	call	_UART1_SendData8
 538  00f3               L322:
 539                     ; 75 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 541  00f3 ae0080        	ldw	x,#128
 542  00f6 cd0000        	call	_UART1_GetFlagStatus
 544  00f9 4d            	tnz	a
 545  00fa 27f7          	jreq	L322
 546                     ; 76  }
 549  00fc 81            	ret	
 596                     ; 78  void Serial_print_string (char string[])
 596                     ; 79  {
 597                     	switch	.text
 598  00fd               _Serial_print_string:
 600  00fd 89            	pushw	x
 601  00fe 88            	push	a
 602       00000001      OFST:	set	1
 605                     ; 81 	 char i=0;
 607  00ff 0f01          	clr	(OFST+0,sp)
 610  0101 200e          	jra	L552
 611  0103               L152:
 612                     ; 85 		UART1_SendData8(string[i]);
 614  0103 cd0000        	call	_UART1_SendData8
 617  0106               L362:
 618                     ; 86 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 620  0106 ae0080        	ldw	x,#128
 621  0109 cd0000        	call	_UART1_GetFlagStatus
 623  010c 4d            	tnz	a
 624  010d 27f7          	jreq	L362
 625                     ; 87 		i++;
 627  010f 0c01          	inc	(OFST+0,sp)
 629  0111               L552:
 630                     ; 83 	 while (string[i] != 0x00)
 632  0111 7b01          	ld	a,(OFST+0,sp)
 633  0113 5f            	clrw	x
 634  0114 97            	ld	xl,a
 635  0115 72fb02        	addw	x,(OFST+1,sp)
 636  0118 f6            	ld	a,(x)
 637  0119 26e8          	jrne	L152
 638                     ; 89  }
 641  011b 5b03          	addw	sp,#3
 642  011d 81            	ret	
 687                     ; 91  bool Serial_available()
 687                     ; 92  {
 688                     	switch	.text
 689  011e               _Serial_available:
 693                     ; 93 	 if(UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
 695  011e ae0020        	ldw	x,#32
 696  0121 cd0000        	call	_UART1_GetFlagStatus
 698  0124 4a            	dec	a
 699  0125 2602          	jrne	L703
 700                     ; 94 	 return TRUE;
 702  0127 4c            	inc	a
 705  0128 81            	ret	
 706  0129               L703:
 707                     ; 96 	 return FALSE;
 709  0129 4f            	clr	a
 712  012a 81            	ret	
 725                     	xref	_GPIO_Init
 726                     	xref	_UART1_ClearFlag
 727                     	xref	_UART1_GetFlagStatus
 728                     	xref	_UART1_SendData8
 729                     	xref	_UART1_ReceiveData8
 730                     	xref	_UART1_Cmd
 731                     	xref	_UART1_Init
 732                     	xref	_UART1_DeInit
 733                     	xdef	_Serial_print_u32
 734                     	xdef	_Serial_read_char
 735                     	xdef	_Serial_available
 736                     	xdef	_Serial_newline
 737                     	xdef	_Serial_print_string
 738                     	xdef	_Serial_print_char
 739                     	xdef	_Serial_print_int
 740                     	xdef	_Serial_begin
 741                     	switch	.const
 742  0005               L711:
 743  0005 307800        	dc.b	"0x",0
 744                     	xref.b	c_lreg
 745                     	xref.b	c_x
 746                     	xref.b	c_y
 766                     	xref	c_sdivx
 767                     	xref	c_smody
 768                     	xref	c_smodx
 769                     	xref	c_xymov
 770                     	xref	c_lursh
 771                     	xref	c_ltor
 772                     	end
