   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  52                     ; 6 int main()
  52                     ; 7 {
  54                     	switch	.text
  55  0000               _main:
  59                     ; 8 	setup_main();
  61  0000 cd0000        	call	_setup_main
  63                     ; 9 	if(is_button_down(0) || is_button_down(1)) hello_world();
  65  0003 4f            	clr	a
  66  0004 cd0000        	call	_is_button_down
  68  0007 4d            	tnz	a
  69  0008 2607          	jrne	L32
  71  000a 4c            	inc	a
  72  000b cd0000        	call	_is_button_down
  74  000e 4d            	tnz	a
  75  000f 2703          	jreq	L12
  76  0011               L32:
  79  0011 cd0000        	call	_hello_world
  81  0014               L12:
  82                     ; 10 	run_application();
  84  0014 cd0000        	call	_run_application
  86                     ; 11 	run_developer();
  88  0017 cd0000        	call	_run_developer
  90                     ; 12 	return 0;
  92  001a 5f            	clrw	x
  95  001b 81            	ret	
 108                     	xdef	_main
 109                     	xref	_run_developer
 110                     	xref	_run_application
 111                     	xref	_is_button_down
 112                     	xref	_setup_main
 113                     	xref	_hello_world
 132                     	end
