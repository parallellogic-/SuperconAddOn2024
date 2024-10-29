   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
   4                     ; Optimizer V4.5.5 - 08 Nov 2022
  50                     ; 10 void setup_developer()
  50                     ; 11 {
  52                     	switch	.text
  53  0000               _setup_developer:
  57                     ; 13 	get_button_event(0xFF,0xFF,1);//clear_button_events();
  59  0000 4b01          	push	#1
  60  0002 aeffff        	ldw	x,#65535
  61  0005 cd0000        	call	_get_button_event
  63  0008 84            	pop	a
  64                     ; 15 	set_debug(255);//show only one debug led ON
  66  0009 a6ff          	ld	a,#255
  67  000b cd0000        	call	_set_debug
  69                     ; 16 	flush_leds(1);
  71  000e a601          	ld	a,#1
  73                     ; 17 }
  76  0010 cc0000        	jp	_flush_leds
 103                     ; 19 void run_developer()
 103                     ; 20 {
 104                     	switch	.text
 105  0013               _run_developer:
 109                     ; 25 	setup_developer();
 111  0013 adeb          	call	_setup_developer
 113  0015               L13:
 114                     ; 32 		if(get_developer_flag())
 116  0015 cd0000        	call	_get_developer_flag
 118  0018 4d            	tnz	a
 119  0019 27fa          	jreq	L13
 120                     ; 34 			flush_leds(get_developer_flag());
 122  001b cd0000        	call	_get_developer_flag
 124  001e cd0000        	call	_flush_leds
 126                     ; 35 			set_developer_flag(0);
 128  0021 4f            	clr	a
 129  0022 cd0000        	call	_set_developer_flag
 131  0025 20ee          	jra	L13
 144                     	xdef	_run_developer
 145                     	xdef	_setup_developer
 146                     	xref	_set_developer_flag
 147                     	xref	_get_developer_flag
 148                     	xref	_get_button_event
 149                     	xref	_flush_leds
 150                     	xref	_set_debug
 169                     	end
