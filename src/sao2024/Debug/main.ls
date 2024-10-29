   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  50                     ; 6 int main()
  50                     ; 7 {
  52                     	switch	.text
  53  0000               _main:
  57                     ; 8 	setup_main();
  59  0000 cd0000        	call	_setup_main
  61                     ; 11 	run_application();
  63  0003 cd0000        	call	_run_application
  65                     ; 12 	run_developer();
  67  0006 cd0000        	call	_run_developer
  69                     ; 13 	return 0;
  71  0009 5f            	clrw	x
  74  000a 81            	ret	
  87                     	xdef	_main
  88                     	xref	_run_developer
  89                     	xref	_run_application
  90                     	xref	_setup_main
 109                     	end
