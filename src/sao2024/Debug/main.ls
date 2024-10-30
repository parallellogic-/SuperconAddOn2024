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
  63                     ; 9 	if(is_button_down(0) || is_button_down(1) || is_button_down(2)) hello_world();
  65  0003 4f            	clr	a
  66  0004 cd0000        	call	_is_button_down
  68  0007 4d            	tnz	a
  69  0008 260f          	jrne	L32
  71  000a 4c            	inc	a
  72  000b cd0000        	call	_is_button_down
  74  000e 4d            	tnz	a
  75  000f 2608          	jrne	L32
  77  0011 a602          	ld	a,#2
  78  0013 cd0000        	call	_is_button_down
  80  0016 4d            	tnz	a
  81  0017 2703          	jreq	L12
  82  0019               L32:
  85  0019 cd0000        	call	_hello_world
  87  001c               L12:
  88                     ; 10 	run_application();
  90  001c cd0000        	call	_run_application
  92                     ; 11 	run_developer();
  94  001f cd0000        	call	_run_developer
  96                     ; 12 	return 0;
  98  0022 5f            	clrw	x
 101  0023 81            	ret	
 114                     	xdef	_main
 115                     	xref	_run_developer
 116                     	xref	_run_application
 117                     	xref	_is_button_down
 118                     	xref	_setup_main
 119                     	xref	_hello_world
 138                     	end
