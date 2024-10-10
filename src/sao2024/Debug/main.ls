   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  48                     ; 6 int main()
  48                     ; 7 {
  50                     	switch	.text
  51  0000               _main:
  55                     ; 8 	setup_main();
  57  0000 cd0000        	call	_setup_main
  59                     ; 9 	hello_world();
  61  0003 cd0000        	call	_hello_world
  63  0006               L12:
  64                     ; 12 		if(is_application_valid()) run_application();
  66  0006 cd0000        	call	_is_application_valid
  68  0009 4d            	tnz	a
  69  000a 2703          	jreq	L52
  72  000c cd0000        	call	_run_application
  74  000f               L52:
  75                     ; 13 		if(is_developer_valid()) run_developer();
  77  000f cd0000        	call	_is_developer_valid
  79  0012 4d            	tnz	a
  80  0013 27f1          	jreq	L12
  83  0015 cd0000        	call	_run_developer
  85  0018 20ec          	jra	L12
  98                     	xdef	_main
  99                     	xref	_run_developer
 100                     	xref	_run_application
 101                     	xref	_is_developer_valid
 102                     	xref	_setup_main
 103                     	xref	_is_application_valid
 104                     	xref	_hello_world
 123                     	end
