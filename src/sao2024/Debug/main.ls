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
  62                     ; 10 	if(1 || is_button_down(0) || is_button_down(1)) run_developer();//DEBUG_BROKEN default to developer mode
  64  0003 cd0000        	call	_run_developer
  66                     ; 11 	run_application();
  68  0006 cd0000        	call	_run_application
  70                     ; 12 	return 0;
  72  0009 5f            	clrw	x
  75  000a 81            	ret	
  88                     	xdef	_main
  89                     	xref	_run_developer
  90                     	xref	_run_application
  91                     	xref	_is_button_down
  92                     	xref	_setup_main
 111                     	end
