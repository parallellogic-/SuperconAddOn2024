   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  47                     ; 54 void UART1_DeInit(void)
  47                     ; 55 {
  49                     	switch	.text
  50  0000               _UART1_DeInit:
  54                     ; 58   (void)UART1->SR;
  56  0000 c65230        	ld	a,21040
  57                     ; 59   (void)UART1->DR;
  59  0003 c65231        	ld	a,21041
  60                     ; 61   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  62  0006 725f5233      	clr	21043
  63                     ; 62   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  65  000a 725f5232      	clr	21042
  66                     ; 64   UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  68  000e 725f5234      	clr	21044
  69                     ; 65   UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  71  0012 725f5235      	clr	21045
  72                     ; 66   UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  74  0016 725f5236      	clr	21046
  75                     ; 67   UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  77  001a 725f5237      	clr	21047
  78                     ; 68   UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  80  001e 725f5238      	clr	21048
  81                     ; 70   UART1->GTR = UART1_GTR_RESET_VALUE;
  83  0022 725f5239      	clr	21049
  84                     ; 71   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  86  0026 725f523a      	clr	21050
  87                     ; 72 }
  90  002a 81            	ret	
 393                     .const:	section	.text
 394  0000               L41:
 395  0000 00000064      	dc.l	100
 396                     ; 91 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 396                     ; 92                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 396                     ; 93                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 396                     ; 94 {
 397                     	switch	.text
 398  002b               _UART1_Init:
 400  002b 520c          	subw	sp,#12
 401       0000000c      OFST:	set	12
 404                     ; 95   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 408                     ; 98   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 410                     ; 99   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 412                     ; 100   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 414                     ; 101   assert_param(IS_UART1_PARITY_OK(Parity));
 416                     ; 102   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 418                     ; 103   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 420                     ; 106   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 422  002d 72195234      	bres	21044,#4
 423                     ; 109   UART1->CR1 |= (uint8_t)WordLength;
 425  0031 c65234        	ld	a,21044
 426  0034 1a13          	or	a,(OFST+7,sp)
 427  0036 c75234        	ld	21044,a
 428                     ; 112   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 430  0039 c65236        	ld	a,21046
 431  003c a4cf          	and	a,#207
 432  003e c75236        	ld	21046,a
 433                     ; 114   UART1->CR3 |= (uint8_t)StopBits;  
 435  0041 c65236        	ld	a,21046
 436  0044 1a14          	or	a,(OFST+8,sp)
 437  0046 c75236        	ld	21046,a
 438                     ; 117   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 440  0049 c65234        	ld	a,21044
 441  004c a4f9          	and	a,#249
 442  004e c75234        	ld	21044,a
 443                     ; 119   UART1->CR1 |= (uint8_t)Parity;  
 445  0051 c65234        	ld	a,21044
 446  0054 1a15          	or	a,(OFST+9,sp)
 447  0056 c75234        	ld	21044,a
 448                     ; 122   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 450  0059 725f5232      	clr	21042
 451                     ; 124   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 453  005d c65233        	ld	a,21043
 454  0060 a40f          	and	a,#15
 455  0062 c75233        	ld	21043,a
 456                     ; 126   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 458  0065 c65233        	ld	a,21043
 459  0068 a4f0          	and	a,#240
 460  006a c75233        	ld	21043,a
 461                     ; 129   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 463  006d 96            	ldw	x,sp
 464  006e cd0138        	call	LC001
 466  0071 96            	ldw	x,sp
 467  0072 5c            	incw	x
 468  0073 cd0000        	call	c_rtol
 471  0076 cd0000        	call	_CLK_GetClockFreq
 473  0079 96            	ldw	x,sp
 474  007a 5c            	incw	x
 475  007b cd0000        	call	c_ludv
 477  007e 96            	ldw	x,sp
 478  007f 1c0009        	addw	x,#OFST-3
 479  0082 cd0000        	call	c_rtol
 482                     ; 130   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 484  0085 96            	ldw	x,sp
 485  0086 cd0138        	call	LC001
 487  0089 96            	ldw	x,sp
 488  008a 5c            	incw	x
 489  008b cd0000        	call	c_rtol
 492  008e cd0000        	call	_CLK_GetClockFreq
 494  0091 a664          	ld	a,#100
 495  0093 cd0000        	call	c_smul
 497  0096 96            	ldw	x,sp
 498  0097 5c            	incw	x
 499  0098 cd0000        	call	c_ludv
 501  009b 96            	ldw	x,sp
 502  009c 1c0005        	addw	x,#OFST-7
 503  009f cd0000        	call	c_rtol
 506                     ; 132   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 508  00a2 96            	ldw	x,sp
 509  00a3 1c0009        	addw	x,#OFST-3
 510  00a6 cd0000        	call	c_ltor
 512  00a9 a664          	ld	a,#100
 513  00ab cd0000        	call	c_smul
 515  00ae 96            	ldw	x,sp
 516  00af 5c            	incw	x
 517  00b0 cd0000        	call	c_rtol
 520  00b3 96            	ldw	x,sp
 521  00b4 1c0005        	addw	x,#OFST-7
 522  00b7 cd0000        	call	c_ltor
 524  00ba 96            	ldw	x,sp
 525  00bb 5c            	incw	x
 526  00bc cd0000        	call	c_lsub
 528  00bf a604          	ld	a,#4
 529  00c1 cd0000        	call	c_llsh
 531  00c4 ae0000        	ldw	x,#L41
 532  00c7 cd0000        	call	c_ludv
 534  00ca b603          	ld	a,c_lreg+3
 535  00cc a40f          	and	a,#15
 536  00ce ca5233        	or	a,21043
 537  00d1 c75233        	ld	21043,a
 538                     ; 134   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 540  00d4 1e0b          	ldw	x,(OFST-1,sp)
 541  00d6 54            	srlw	x
 542  00d7 54            	srlw	x
 543  00d8 54            	srlw	x
 544  00d9 54            	srlw	x
 545  00da 01            	rrwa	x,a
 546  00db a4f0          	and	a,#240
 547  00dd ca5233        	or	a,21043
 548  00e0 c75233        	ld	21043,a
 549                     ; 136   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 551  00e3 c65232        	ld	a,21042
 552  00e6 1a0c          	or	a,(OFST+0,sp)
 553  00e8 c75232        	ld	21042,a
 554                     ; 139   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 556  00eb c65235        	ld	a,21045
 557  00ee a4f3          	and	a,#243
 558  00f0 c75235        	ld	21045,a
 559                     ; 141   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 561  00f3 c65236        	ld	a,21046
 562  00f6 a4f8          	and	a,#248
 563  00f8 c75236        	ld	21046,a
 564                     ; 143   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 564                     ; 144                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 566  00fb 7b16          	ld	a,(OFST+10,sp)
 567  00fd a407          	and	a,#7
 568  00ff ca5236        	or	a,21046
 569  0102 c75236        	ld	21046,a
 570                     ; 146   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 572  0105 7b17          	ld	a,(OFST+11,sp)
 573  0107 a504          	bcp	a,#4
 574  0109 2706          	jreq	L371
 575                     ; 149     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 577  010b 72165235      	bset	21045,#3
 579  010f 2004          	jra	L571
 580  0111               L371:
 581                     ; 154     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 583  0111 72175235      	bres	21045,#3
 584  0115               L571:
 585                     ; 156   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 587  0115 a508          	bcp	a,#8
 588  0117 2706          	jreq	L771
 589                     ; 159     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 591  0119 72145235      	bset	21045,#2
 593  011d 2004          	jra	L102
 594  011f               L771:
 595                     ; 164     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 597  011f 72155235      	bres	21045,#2
 598  0123               L102:
 599                     ; 168   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 601  0123 7b16          	ld	a,(OFST+10,sp)
 602  0125 2a06          	jrpl	L302
 603                     ; 171     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 605  0127 72175236      	bres	21046,#3
 607  012b 2008          	jra	L502
 608  012d               L302:
 609                     ; 175     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 611  012d a408          	and	a,#8
 612  012f ca5236        	or	a,21046
 613  0132 c75236        	ld	21046,a
 614  0135               L502:
 615                     ; 177 }
 618  0135 5b0c          	addw	sp,#12
 619  0137 81            	ret	
 620  0138               LC001:
 621  0138 1c000f        	addw	x,#OFST+3
 622  013b cd0000        	call	c_ltor
 624  013e a604          	ld	a,#4
 625  0140 cc0000        	jp	c_llsh
 680                     ; 185 void UART1_Cmd(FunctionalState NewState)
 680                     ; 186 {
 681                     	switch	.text
 682  0143               _UART1_Cmd:
 686                     ; 187   if (NewState != DISABLE)
 688  0143 4d            	tnz	a
 689  0144 2705          	jreq	L532
 690                     ; 190     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 692  0146 721b5234      	bres	21044,#5
 695  014a 81            	ret	
 696  014b               L532:
 697                     ; 195     UART1->CR1 |= UART1_CR1_UARTD;  
 699  014b 721a5234      	bset	21044,#5
 700                     ; 197 }
 703  014f 81            	ret	
 828                     ; 212 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 828                     ; 213 {
 829                     	switch	.text
 830  0150               _UART1_ITConfig:
 832  0150 89            	pushw	x
 833  0151 89            	pushw	x
 834       00000002      OFST:	set	2
 837                     ; 214   uint8_t uartreg = 0, itpos = 0x00;
 841                     ; 217   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 843                     ; 218   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 845                     ; 221   uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 847  0152 9e            	ld	a,xh
 848  0153 6b01          	ld	(OFST-1,sp),a
 850                     ; 223   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 852  0155 9f            	ld	a,xl
 853  0156 a40f          	and	a,#15
 854  0158 5f            	clrw	x
 855  0159 97            	ld	xl,a
 856  015a a601          	ld	a,#1
 857  015c 5d            	tnzw	x
 858  015d 2704          	jreq	L22
 859  015f               L42:
 860  015f 48            	sll	a
 861  0160 5a            	decw	x
 862  0161 26fc          	jrne	L42
 863  0163               L22:
 864  0163 6b02          	ld	(OFST+0,sp),a
 866                     ; 225   if (NewState != DISABLE)
 868  0165 7b07          	ld	a,(OFST+5,sp)
 869  0167 271f          	jreq	L713
 870                     ; 228     if (uartreg == 0x01)
 872  0169 7b01          	ld	a,(OFST-1,sp)
 873  016b a101          	cp	a,#1
 874  016d 2607          	jrne	L123
 875                     ; 230       UART1->CR1 |= itpos;
 877  016f c65234        	ld	a,21044
 878  0172 1a02          	or	a,(OFST+0,sp)
 880  0174 201e          	jp	LC003
 881  0176               L123:
 882                     ; 232     else if (uartreg == 0x02)
 884  0176 a102          	cp	a,#2
 885  0178 2607          	jrne	L523
 886                     ; 234       UART1->CR2 |= itpos;
 888  017a c65235        	ld	a,21045
 889  017d 1a02          	or	a,(OFST+0,sp)
 891  017f 2022          	jp	LC004
 892  0181               L523:
 893                     ; 238       UART1->CR4 |= itpos;
 895  0181 c65237        	ld	a,21047
 896  0184 1a02          	or	a,(OFST+0,sp)
 897  0186 2026          	jp	LC002
 898  0188               L713:
 899                     ; 244     if (uartreg == 0x01)
 901  0188 7b01          	ld	a,(OFST-1,sp)
 902  018a a101          	cp	a,#1
 903  018c 260b          	jrne	L333
 904                     ; 246       UART1->CR1 &= (uint8_t)(~itpos);
 906  018e 7b02          	ld	a,(OFST+0,sp)
 907  0190 43            	cpl	a
 908  0191 c45234        	and	a,21044
 909  0194               LC003:
 910  0194 c75234        	ld	21044,a
 912  0197 2018          	jra	L133
 913  0199               L333:
 914                     ; 248     else if (uartreg == 0x02)
 916  0199 a102          	cp	a,#2
 917  019b 260b          	jrne	L733
 918                     ; 250       UART1->CR2 &= (uint8_t)(~itpos);
 920  019d 7b02          	ld	a,(OFST+0,sp)
 921  019f 43            	cpl	a
 922  01a0 c45235        	and	a,21045
 923  01a3               LC004:
 924  01a3 c75235        	ld	21045,a
 926  01a6 2009          	jra	L133
 927  01a8               L733:
 928                     ; 254       UART1->CR4 &= (uint8_t)(~itpos);
 930  01a8 7b02          	ld	a,(OFST+0,sp)
 931  01aa 43            	cpl	a
 932  01ab c45237        	and	a,21047
 933  01ae               LC002:
 934  01ae c75237        	ld	21047,a
 935  01b1               L133:
 936                     ; 258 }
 939  01b1 5b04          	addw	sp,#4
 940  01b3 81            	ret	
 976                     ; 266 void UART1_HalfDuplexCmd(FunctionalState NewState)
 976                     ; 267 {
 977                     	switch	.text
 978  01b4               _UART1_HalfDuplexCmd:
 982                     ; 268   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 984                     ; 270   if (NewState != DISABLE)
 986  01b4 4d            	tnz	a
 987  01b5 2705          	jreq	L163
 988                     ; 272     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 990  01b7 72165238      	bset	21048,#3
 993  01bb 81            	ret	
 994  01bc               L163:
 995                     ; 276     UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 997  01bc 72175238      	bres	21048,#3
 998                     ; 278 }
1001  01c0 81            	ret	
1058                     ; 286 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1058                     ; 287 {
1059                     	switch	.text
1060  01c1               _UART1_IrDAConfig:
1064                     ; 288   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1066                     ; 290   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1068  01c1 4d            	tnz	a
1069  01c2 2705          	jreq	L314
1070                     ; 292     UART1->CR5 |= UART1_CR5_IRLP;
1072  01c4 72145238      	bset	21048,#2
1075  01c8 81            	ret	
1076  01c9               L314:
1077                     ; 296     UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1079  01c9 72155238      	bres	21048,#2
1080                     ; 298 }
1083  01cd 81            	ret	
1118                     ; 306 void UART1_IrDACmd(FunctionalState NewState)
1118                     ; 307 {
1119                     	switch	.text
1120  01ce               _UART1_IrDACmd:
1124                     ; 309   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1126                     ; 311   if (NewState != DISABLE)
1128  01ce 4d            	tnz	a
1129  01cf 2705          	jreq	L534
1130                     ; 314     UART1->CR5 |= UART1_CR5_IREN;
1132  01d1 72125238      	bset	21048,#1
1135  01d5 81            	ret	
1136  01d6               L534:
1137                     ; 319     UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1139  01d6 72135238      	bres	21048,#1
1140                     ; 321 }
1143  01da 81            	ret	
1202                     ; 330 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1202                     ; 331 {
1203                     	switch	.text
1204  01db               _UART1_LINBreakDetectionConfig:
1208                     ; 332   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1210                     ; 334   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1212  01db 4d            	tnz	a
1213  01dc 2705          	jreq	L764
1214                     ; 336     UART1->CR4 |= UART1_CR4_LBDL;
1216  01de 721a5237      	bset	21047,#5
1219  01e2 81            	ret	
1220  01e3               L764:
1221                     ; 340     UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1223  01e3 721b5237      	bres	21047,#5
1224                     ; 342 }
1227  01e7 81            	ret	
1262                     ; 350 void UART1_LINCmd(FunctionalState NewState)
1262                     ; 351 {
1263                     	switch	.text
1264  01e8               _UART1_LINCmd:
1268                     ; 352   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1270                     ; 354   if (NewState != DISABLE)
1272  01e8 4d            	tnz	a
1273  01e9 2705          	jreq	L115
1274                     ; 357     UART1->CR3 |= UART1_CR3_LINEN;
1276  01eb 721c5236      	bset	21046,#6
1279  01ef 81            	ret	
1280  01f0               L115:
1281                     ; 362     UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1283  01f0 721d5236      	bres	21046,#6
1284                     ; 364 }
1287  01f4 81            	ret	
1322                     ; 372 void UART1_SmartCardCmd(FunctionalState NewState)
1322                     ; 373 {
1323                     	switch	.text
1324  01f5               _UART1_SmartCardCmd:
1328                     ; 374   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1330                     ; 376   if (NewState != DISABLE)
1332  01f5 4d            	tnz	a
1333  01f6 2705          	jreq	L335
1334                     ; 379     UART1->CR5 |= UART1_CR5_SCEN;
1336  01f8 721a5238      	bset	21048,#5
1339  01fc 81            	ret	
1340  01fd               L335:
1341                     ; 384     UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1343  01fd 721b5238      	bres	21048,#5
1344                     ; 386 }
1347  0201 81            	ret	
1383                     ; 395 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1383                     ; 396 {
1384                     	switch	.text
1385  0202               _UART1_SmartCardNACKCmd:
1389                     ; 397   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1391                     ; 399   if (NewState != DISABLE)
1393  0202 4d            	tnz	a
1394  0203 2705          	jreq	L555
1395                     ; 402     UART1->CR5 |= UART1_CR5_NACK;
1397  0205 72185238      	bset	21048,#4
1400  0209 81            	ret	
1401  020a               L555:
1402                     ; 407     UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1404  020a 72195238      	bres	21048,#4
1405                     ; 409 }
1408  020e 81            	ret	
1465                     ; 417 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1465                     ; 418 {
1466                     	switch	.text
1467  020f               _UART1_WakeUpConfig:
1471                     ; 419   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1473                     ; 421   UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1475  020f 72175234      	bres	21044,#3
1476                     ; 422   UART1->CR1 |= (uint8_t)UART1_WakeUp;
1478  0213 ca5234        	or	a,21044
1479  0216 c75234        	ld	21044,a
1480                     ; 423 }
1483  0219 81            	ret	
1519                     ; 431 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1519                     ; 432 {
1520                     	switch	.text
1521  021a               _UART1_ReceiverWakeUpCmd:
1525                     ; 433   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1527                     ; 435   if (NewState != DISABLE)
1529  021a 4d            	tnz	a
1530  021b 2705          	jreq	L526
1531                     ; 438     UART1->CR2 |= UART1_CR2_RWU;
1533  021d 72125235      	bset	21045,#1
1536  0221 81            	ret	
1537  0222               L526:
1538                     ; 443     UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1540  0222 72135235      	bres	21045,#1
1541                     ; 445 }
1544  0226 81            	ret	
1567                     ; 452 uint8_t UART1_ReceiveData8(void)
1567                     ; 453 {
1568                     	switch	.text
1569  0227               _UART1_ReceiveData8:
1573                     ; 454   return ((uint8_t)UART1->DR);
1575  0227 c65231        	ld	a,21041
1578  022a 81            	ret	
1612                     ; 462 uint16_t UART1_ReceiveData9(void)
1612                     ; 463 {
1613                     	switch	.text
1614  022b               _UART1_ReceiveData9:
1616  022b 89            	pushw	x
1617       00000002      OFST:	set	2
1620                     ; 464   uint16_t temp = 0;
1622                     ; 466   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1624  022c c65234        	ld	a,21044
1625  022f a480          	and	a,#128
1626  0231 5f            	clrw	x
1627  0232 02            	rlwa	x,a
1628  0233 58            	sllw	x
1629  0234 1f01          	ldw	(OFST-1,sp),x
1631                     ; 467   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1633  0236 c65231        	ld	a,21041
1634  0239 5f            	clrw	x
1635  023a 97            	ld	xl,a
1636  023b 01            	rrwa	x,a
1637  023c 1a02          	or	a,(OFST+0,sp)
1638  023e 01            	rrwa	x,a
1639  023f 1a01          	or	a,(OFST-1,sp)
1640  0241 a401          	and	a,#1
1641  0243 01            	rrwa	x,a
1644  0244 5b02          	addw	sp,#2
1645  0246 81            	ret	
1679                     ; 475 void UART1_SendData8(uint8_t Data)
1679                     ; 476 {
1680                     	switch	.text
1681  0247               _UART1_SendData8:
1685                     ; 478   UART1->DR = Data;
1687  0247 c75231        	ld	21041,a
1688                     ; 479 }
1691  024a 81            	ret	
1725                     ; 487 void UART1_SendData9(uint16_t Data)
1725                     ; 488 {
1726                     	switch	.text
1727  024b               _UART1_SendData9:
1729  024b 89            	pushw	x
1730       00000000      OFST:	set	0
1733                     ; 490   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1735  024c 721d5234      	bres	21044,#6
1736                     ; 492   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1738  0250 54            	srlw	x
1739  0251 54            	srlw	x
1740  0252 9f            	ld	a,xl
1741  0253 a440          	and	a,#64
1742  0255 ca5234        	or	a,21044
1743  0258 c75234        	ld	21044,a
1744                     ; 494   UART1->DR   = (uint8_t)(Data);
1746  025b 7b02          	ld	a,(OFST+2,sp)
1747  025d c75231        	ld	21041,a
1748                     ; 495 }
1751  0260 85            	popw	x
1752  0261 81            	ret	
1775                     ; 502 void UART1_SendBreak(void)
1775                     ; 503 {
1776                     	switch	.text
1777  0262               _UART1_SendBreak:
1781                     ; 504   UART1->CR2 |= UART1_CR2_SBK;
1783  0262 72105235      	bset	21045,#0
1784                     ; 505 }
1787  0266 81            	ret	
1821                     ; 512 void UART1_SetAddress(uint8_t UART1_Address)
1821                     ; 513 {
1822                     	switch	.text
1823  0267               _UART1_SetAddress:
1825  0267 88            	push	a
1826       00000000      OFST:	set	0
1829                     ; 515   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1831                     ; 518   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1833  0268 c65237        	ld	a,21047
1834  026b a4f0          	and	a,#240
1835  026d c75237        	ld	21047,a
1836                     ; 520   UART1->CR4 |= UART1_Address;
1838  0270 c65237        	ld	a,21047
1839  0273 1a01          	or	a,(OFST+1,sp)
1840  0275 c75237        	ld	21047,a
1841                     ; 521 }
1844  0278 84            	pop	a
1845  0279 81            	ret	
1879                     ; 529 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1879                     ; 530 {
1880                     	switch	.text
1881  027a               _UART1_SetGuardTime:
1885                     ; 532   UART1->GTR = UART1_GuardTime;
1887  027a c75239        	ld	21049,a
1888                     ; 533 }
1891  027d 81            	ret	
1925                     ; 557 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1925                     ; 558 {
1926                     	switch	.text
1927  027e               _UART1_SetPrescaler:
1931                     ; 560   UART1->PSCR = UART1_Prescaler;
1933  027e c7523a        	ld	21050,a
1934                     ; 561 }
1937  0281 81            	ret	
2080                     ; 569 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2080                     ; 570 {
2081                     	switch	.text
2082  0282               _UART1_GetFlagStatus:
2084  0282 89            	pushw	x
2085  0283 88            	push	a
2086       00000001      OFST:	set	1
2089                     ; 571   FlagStatus status = RESET;
2091                     ; 574   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2093                     ; 578   if (UART1_FLAG == UART1_FLAG_LBDF)
2095  0284 a30210        	cpw	x,#528
2096  0287 2608          	jrne	L7501
2097                     ; 580     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2099  0289 9f            	ld	a,xl
2100  028a c45237        	and	a,21047
2101  028d 271c          	jreq	L5601
2102                     ; 583       status = SET;
2104  028f 2015          	jp	LC007
2105                     ; 588       status = RESET;
2106  0291               L7501:
2107                     ; 591   else if (UART1_FLAG == UART1_FLAG_SBK)
2109  0291 a30101        	cpw	x,#257
2110  0294 2609          	jrne	L7601
2111                     ; 593     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2113  0296 c65235        	ld	a,21045
2114  0299 1503          	bcp	a,(OFST+2,sp)
2115  029b 270d          	jreq	L7701
2116                     ; 596       status = SET;
2118  029d 2007          	jp	LC007
2119                     ; 601       status = RESET;
2120  029f               L7601:
2121                     ; 606     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2123  029f c65230        	ld	a,21040
2124  02a2 1503          	bcp	a,(OFST+2,sp)
2125  02a4 2704          	jreq	L7701
2126                     ; 609       status = SET;
2128  02a6               LC007:
2131  02a6 a601          	ld	a,#1
2135  02a8 2001          	jra	L5601
2136  02aa               L7701:
2137                     ; 614       status = RESET;
2140  02aa 4f            	clr	a
2142  02ab               L5601:
2143                     ; 618   return status;
2147  02ab 5b03          	addw	sp,#3
2148  02ad 81            	ret	
2183                     ; 647 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2183                     ; 648 {
2184                     	switch	.text
2185  02ae               _UART1_ClearFlag:
2189                     ; 649   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2191                     ; 652   if (UART1_FLAG == UART1_FLAG_RXNE)
2193  02ae a30020        	cpw	x,#32
2194  02b1 2605          	jrne	L1211
2195                     ; 654     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2197  02b3 35df5230      	mov	21040,#223
2200  02b7 81            	ret	
2201  02b8               L1211:
2202                     ; 659     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2204  02b8 72195237      	bres	21047,#4
2205                     ; 661 }
2208  02bc 81            	ret	
2290                     ; 676 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2290                     ; 677 {
2291                     	switch	.text
2292  02bd               _UART1_GetITStatus:
2294  02bd 89            	pushw	x
2295  02be 89            	pushw	x
2296       00000002      OFST:	set	2
2299                     ; 678   ITStatus pendingbitstatus = RESET;
2301                     ; 679   uint8_t itpos = 0;
2303                     ; 680   uint8_t itmask1 = 0;
2305                     ; 681   uint8_t itmask2 = 0;
2307                     ; 682   uint8_t enablestatus = 0;
2309                     ; 685   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2311                     ; 688   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2313  02bf 9f            	ld	a,xl
2314  02c0 a40f          	and	a,#15
2315  02c2 5f            	clrw	x
2316  02c3 97            	ld	xl,a
2317  02c4 a601          	ld	a,#1
2318  02c6 5d            	tnzw	x
2319  02c7 2704          	jreq	L67
2320  02c9               L001:
2321  02c9 48            	sll	a
2322  02ca 5a            	decw	x
2323  02cb 26fc          	jrne	L001
2324  02cd               L67:
2325  02cd 6b01          	ld	(OFST-1,sp),a
2327                     ; 690   itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2329  02cf 7b04          	ld	a,(OFST+2,sp)
2330  02d1 4e            	swap	a
2331  02d2 a40f          	and	a,#15
2332  02d4 6b02          	ld	(OFST+0,sp),a
2334                     ; 692   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2336  02d6 5f            	clrw	x
2337  02d7 97            	ld	xl,a
2338  02d8 a601          	ld	a,#1
2339  02da 5d            	tnzw	x
2340  02db 2704          	jreq	L201
2341  02dd               L401:
2342  02dd 48            	sll	a
2343  02de 5a            	decw	x
2344  02df 26fc          	jrne	L401
2345  02e1               L201:
2346  02e1 6b02          	ld	(OFST+0,sp),a
2348                     ; 696   if (UART1_IT == UART1_IT_PE)
2350  02e3 1e03          	ldw	x,(OFST+1,sp)
2351  02e5 a30100        	cpw	x,#256
2352  02e8 260c          	jrne	L7611
2353                     ; 699     enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2355  02ea c65234        	ld	a,21044
2356  02ed 1402          	and	a,(OFST+0,sp)
2357  02ef 6b02          	ld	(OFST+0,sp),a
2359                     ; 702     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2361  02f1 c65230        	ld	a,21040
2363                     ; 705       pendingbitstatus = SET;
2365  02f4 200f          	jp	LC010
2366                     ; 710       pendingbitstatus = RESET;
2367  02f6               L7611:
2368                     ; 714   else if (UART1_IT == UART1_IT_LBDF)
2370  02f6 a30346        	cpw	x,#838
2371  02f9 2616          	jrne	L7711
2372                     ; 717     enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2374  02fb c65237        	ld	a,21047
2375  02fe 1402          	and	a,(OFST+0,sp)
2376  0300 6b02          	ld	(OFST+0,sp),a
2378                     ; 719     if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2380  0302 c65237        	ld	a,21047
2382  0305               LC010:
2383  0305 1501          	bcp	a,(OFST-1,sp)
2384  0307 271a          	jreq	L7021
2385  0309 7b02          	ld	a,(OFST+0,sp)
2386  030b 2716          	jreq	L7021
2387                     ; 722       pendingbitstatus = SET;
2389  030d               LC009:
2392  030d a601          	ld	a,#1
2395  030f 2013          	jra	L5711
2396                     ; 727       pendingbitstatus = RESET;
2397  0311               L7711:
2398                     ; 733     enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2400  0311 c65235        	ld	a,21045
2401  0314 1402          	and	a,(OFST+0,sp)
2402  0316 6b02          	ld	(OFST+0,sp),a
2404                     ; 735     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2406  0318 c65230        	ld	a,21040
2407  031b 1501          	bcp	a,(OFST-1,sp)
2408  031d 2704          	jreq	L7021
2410  031f 7b02          	ld	a,(OFST+0,sp)
2411                     ; 738       pendingbitstatus = SET;
2413  0321 26ea          	jrne	LC009
2414  0323               L7021:
2415                     ; 743       pendingbitstatus = RESET;
2419  0323 4f            	clr	a
2421  0324               L5711:
2422                     ; 748   return  pendingbitstatus;
2426  0324 5b04          	addw	sp,#4
2427  0326 81            	ret	
2463                     ; 776 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2463                     ; 777 {
2464                     	switch	.text
2465  0327               _UART1_ClearITPendingBit:
2469                     ; 778   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2471                     ; 781   if (UART1_IT == UART1_IT_RXNE)
2473  0327 a30255        	cpw	x,#597
2474  032a 2605          	jrne	L1321
2475                     ; 783     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2477  032c 35df5230      	mov	21040,#223
2480  0330 81            	ret	
2481  0331               L1321:
2482                     ; 788     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2484  0331 72195237      	bres	21047,#4
2485                     ; 790 }
2488  0335 81            	ret	
2501                     	xref	_CLK_GetClockFreq
2502                     	xdef	_UART1_ClearITPendingBit
2503                     	xdef	_UART1_GetITStatus
2504                     	xdef	_UART1_ClearFlag
2505                     	xdef	_UART1_GetFlagStatus
2506                     	xdef	_UART1_SetPrescaler
2507                     	xdef	_UART1_SetGuardTime
2508                     	xdef	_UART1_SetAddress
2509                     	xdef	_UART1_SendBreak
2510                     	xdef	_UART1_SendData9
2511                     	xdef	_UART1_SendData8
2512                     	xdef	_UART1_ReceiveData9
2513                     	xdef	_UART1_ReceiveData8
2514                     	xdef	_UART1_ReceiverWakeUpCmd
2515                     	xdef	_UART1_WakeUpConfig
2516                     	xdef	_UART1_SmartCardNACKCmd
2517                     	xdef	_UART1_SmartCardCmd
2518                     	xdef	_UART1_LINCmd
2519                     	xdef	_UART1_LINBreakDetectionConfig
2520                     	xdef	_UART1_IrDACmd
2521                     	xdef	_UART1_IrDAConfig
2522                     	xdef	_UART1_HalfDuplexCmd
2523                     	xdef	_UART1_ITConfig
2524                     	xdef	_UART1_Cmd
2525                     	xdef	_UART1_Init
2526                     	xdef	_UART1_DeInit
2527                     	xref.b	c_lreg
2528                     	xref.b	c_x
2547                     	xref	c_lsub
2548                     	xref	c_smul
2549                     	xref	c_ludv
2550                     	xref	c_rtol
2551                     	xref	c_llsh
2552                     	xref	c_ltor
2553                     	end
