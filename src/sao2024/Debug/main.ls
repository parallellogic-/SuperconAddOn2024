   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  51                     ; 6 int main()
  51                     ; 7 {
  53                     	switch	.text
  54  0000               _main:
  58                     ; 8 	setup_main();
  60  0000 cd0000        	call	_setup_main
  62                     ; 10 	if(0 || is_button_down(0) || is_button_down(1)) run_developer();//DEBUG_BROKEN default to developer mode
  64  0003 4f            	clr	a
  65  0004 cd0000        	call	_is_button_down
  67  0007 4d            	tnz	a
  68  0008 2607          	jrne	L32
  70  000a 4c            	inc	a
  71  000b cd0000        	call	_is_button_down
  73  000e 4d            	tnz	a
  74  000f 2703          	jreq	L12
  75  0011               L32:
  78  0011 cd0000        	call	_run_developer
  80  0014               L12:
  81                     ; 11 	run_application();
  83  0014 cd0000        	call	_run_application
  85                     ; 12 	return 0;
  87  0017 5f            	clrw	x
  90  0018 81            	ret	
 103                     	xdef	_main
 104                     	xref	_run_developer
 105                     	xref	_run_application
 106                     	xref	_is_button_down
 107                     	xref	_setup_main
 126                     	end
