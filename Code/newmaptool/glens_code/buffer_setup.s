**********************************************
*********  DISPLAY BUFFER WINDOW    **********
**********************************************
display_buffer_window

	bsr	remove_current_buff_name
	bsr	set_original_colours	
	move.l	#buffer_window,a0
	jsr	create_window
	move.l	#buffer_buttons,a0
	jsr	display_button_list
	move.l	#Buffer_Window,a0		; write in filename
	move.l	#buffer_text,a1
	move.w	#2,d2
	move.w	#6,d0
	move.w	#6,d1
	move.w	#1,d3
	jsr	Write_Text	
	move.l	#buffer_window,a0
	move.w	#95,d0
	move.w	#37,d1
	move.w	#95+(8*16)-4,d2
	move.w  #37+16,d3
	jsr	draw_box
	jsr	display_buffer_name
	rts	

**********************************************
*********  REMOVE BUFFER WINDOW    **********
**********************************************
remove_buffer_window
	

	move.l	#buffer_buttons,a0
	jsr	remove_button_list
	move.l	#buffer_window,a0
	jsr	destroy_window
	jsr	set_current_page_colours
	bsr	draw_current_buff_name
	rts	
	
***********************************************
******* ENTER BUFFER NAME   *******************
***********************************************	
		
Enter_buffer_name


	move.l current_buffer_mem,a0
	add.l  #buffername,a0
	move.b	#0,(a0)
	move.w	#0,char_position

	move.l	#buffer_window,a0
	move.w	#6,d0
	move.w	#40,d1
	move.w	#7,d2
	move.w	#10,d3
	jsr	Clear_Word_Chunk		; clear text
	
bkey_in_loop
	btst.b	#6,$bfe001
	beq	bend_enter_file

	jsr	get_pressed_key			; key in d0
	tst.b	d0	
	beq.s	bkey_in_loop


	cmp.b	#KEY_RETURN,d0
	beq	bend_enter_file
	
	cmp.b	#KEY_DELETE,d0
	bne.s	bnobackspace
	cmp.w	#0,char_position
	ble.s	bnobackspace
	subq.w	#1,char_position

	move.l current_buffer_mem,a0
	add.l  #buffername,a0
	move.w	char_position,d1
	move.b	#0,(a0,d1.w)			; terminate string
	bra.s	bprint_fname
bnobackspace

	move.l current_buffer_mem,a0
	add.l  #buffername,a0
	move.w	char_position,d1

	cmp.w	#11,char_position
	bge.s	bfilename_to_big
	add.w	#1,char_position

	move.b	d0,(a0,d1.w)			; put character in
bterminator
	move.b	#0,1(a0,d1.w)			; terminate string
bfilename_to_big
bprint_fname
	move.l	#Buffer_Window,a0
	move.w	#6,d0
	move.w	#40,d1
	move.w	#7,d2
	move.w	#10,d3
	jsr	Clear_Word_Chunk		; clear text
	
	move.l	#Buffer_Window,a0		; write in filename
	move.l current_buffer_mem,a1
	add.l  #buffername,a1
	move.w	#1,d2
	move.w	#100,d0
	move.w	#40,d1
	jsr	Write_Text
	bra	bkey_in_loop

bend_enter_file
	rts

	

*********************************************
****** CALCULATE BUFFER MEM           *******
*********************************************
calculate_buffer_mem
	move.w	current_buffer,d0
	mulu	#buffstructsize,d0
	add.l	#buffers,d0
	move.l	d0,current_buffer_mem
	rts

**********************************************
*********  BUFFER UP                **********
**********************************************
buffer_up
	bsr	remove_buffer_name
	
	cmp.w	#7,current_buffer
	beq.s	at_buff_max
	addq.w	#1,current_buffer
	bsr	calculate_buffer_mem
at_buff_max
	bsr	display_buffer_name
	rts	



**********************************************
*********  BUFFER DOWN              **********
**********************************************
buffer_down
	bsr	remove_buffer_name
	
	cmp.w	#0,current_buffer
	beq.s	at_buff_min
	subq.w	#1,current_buffer
	bsr	calculate_buffer_mem
at_buff_min
	bsr	display_buffer_name
	rts	


**********************************************
*********  DISPLAY BUFFER NAME      **********
**********************************************
display_buffer_name

	moveq	#0,d0
	move.w	#1,d3	
	move.w	#1,d4
remove_buffer_text	
	move.w	current_buffer,d0
	mulu	#buffstructsize,d0
	move.l	#buffers,a2
	add.l	d0,a2
	move.l	a2,a1
	add.l	#buffername,a1
	move.l	#Buffer_Window,a0		; write in filename
	move.w	#1,d2
	move.w	#100,d0
	move.w	#40,d1
	jsr	Write_Text	

	move.w	buffer_xsize(a2),d3
	move.w	#1,d2
	move.w	#100,d0
	move.w	#60,d1
	jsr	Write_Num
	
	move.w	buffer_ysize(a2),d3
	move.w	#1,d2
	move.w	#100,d0
	move.w	#80,d1
	jsr	Write_Num

	rts
	
**********************************************
*********  REMOVE  BUFFER NAME      **********
**********************************************
remove_buffer_name
	moveq	#0,d3	;delete for text
	moveq	#0,d4	;delete for nums
	bsr	remove_buffer_text
	rts



current_buffer
	dc.w	0

current_buffer_mem
	dc.l	buffers


buffer_info_size  equ  2+2+12	;x,y and name

	rsreset
	
buffer_xsize	rs.w	1
buffer_ysize	rs.w 	1
buffername	rs.b	12
buffer_mem	rs.l	1
buffstructsize	rs.w    1	
		EVEN
		
*define 8 buffers

buffers

	ds.w	2
	dc.b    "Buff1      ",0
	dc.l	buff1
	
		
	ds.w	2
	dc.b	"Buff2      ",0
	dc.l	buff2	

	ds.w	2
	dc.b	"Buff3      ",0
	dc.l	buff3

	ds.w	2
	dc.b	"Buff4      ",0
	dc.l	buff4


	ds.w	2
	dc.b	"Buff5      ",0
	dc.l	buff5

	ds.w	2
	dc.b	"Buff6      ",0
	dc.l	buff6

	ds.w	2
	dc.b	"Buff7      ",0
	dc.l	buff7

	ds.w	2
	dc.b	"Buff8      ",0
	dc.l	buff8	
	
***************buffer window routines

buffer_window
	dc.w	272
	dc.w	144
	dc.w	24
	dc.w	20
	dc.l	0
	dc.l	0
	dc.b	"BUFFER WINDOW",0
	even		


buffer_text
	dc.b	"     Select Buffer",$a,$a,$a
	dc.b    "Name   : ",$a,$a
	dc.b    "X Size :",$a,$a
	dc.b    "Y Size :",0
	EVEN               

buffer_buttons
	dc.l	buffer_ok_button,buffer_save_button,buffer_load_button
	dc.l	buffer_up_button,buffer_down_button,get_buff_name,-1

buffer_Ok_Button
	dc.w	21
	dc.w	110
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_buffer_window
	dc.b	0		
	even

buffer_save_Button
	dc.w	21+64+5
	dc.w	110
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	save_custom_button
	dc.l	0	;not used
        dc.l	save_buffers
	dc.b	0		
	even
	
buffer_load_Button
	dc.w	21+64+5+64+5
	dc.w	110
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	load_custom_button
	dc.l	0	;not used
        dc.l	load_buffers
	dc.b	0		
	even

buffer_Up_Button
	dc.w	100+30
	dc.w	20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_right
	dc.l	0	;not used
	dc.l	buffer_up
	dc.b	0		
	EVEN		
	
	
buffer_Down_Button
	dc.w	100
	dc.w	20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_left
	dc.l	0	;not used
	dc.l	buffer_down
	dc.b	0		
	EVEN	

get_buff_name
	dc.w	100
	dc.w	39
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	buffername_get
	dc.l	0	;not used
	dc.l	enter_buffer_name
	dc.b	0		
	EVEN	







	
	
	
