   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  47                     ; 6 int main()
  47                     ; 7 {
  49                     	switch	.text
  50  0000               _main:
  54                     ; 8 	setup_main();
  56  0000 cd0000        	call	_setup_main
  58  0003               L12:
  59                     ; 12 		if(is_application_valid()) run_application();
  61  0003 cd0000        	call	_is_application_valid
  63  0006 4d            	tnz	a
  64  0007 2703          	jreq	L52
  67  0009 cd0000        	call	_run_application
  69  000c               L52:
  70                     ; 13 		if(is_developer_valid()) run_developer();
  72  000c cd0000        	call	_is_developer_valid
  74  000f 4d            	tnz	a
  75  0010 27f1          	jreq	L12
  78  0012 cd0000        	call	_run_developer
  80  0015 20ec          	jra	L12
  93                     	xdef	_main
  94                     	xref	_run_developer
  95                     	xref	_run_application
  96                     	xref	_is_developer_valid
  97                     	xref	_setup_main
  98                     	xref	_is_application_valid
 117                     	end
