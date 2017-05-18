

**********************************************
*********** SAVE PIC WINDOW           ********
**********************************************
save_pic_window

	move.l	#savepic_dpaint,a0
	move.b	#DEPRESSED,button_start(a0)
	move.b	#1,save_format
	move.b	#0,sliced

	move.l	#savepic_raw,a0
	move.b	#NOT_DEPRESSED,button_start(a0)
		
	move.l	page_pointer,a0
	move.w	number_of_planes(a0),number_of_planes_to_save

	bsr	set_original_colours	
	move.l	#savepic_window,a0
	jsr	create_window
	move.l	#savepic_buttons,a0
	jsr	display_button_list
	move.l	#savepic_Window,a0		; write in filename
	move.l	#savepic_text,a1
	move.w	#2,d2
	move.w	#6,d0
	move.w	#6,d1
	move.w	#1,d3
	jsr	Write_Text

	bsr	display_plane_number


	rts


**********************************************
*********** REMOVE SAVE PIC WINDOW    ********
**********************************************
remove_save_pic_window


	move.l	#savepic_buttons,a0
	bsr	remove_button_list
	move.l	#savepic_window,a0
	bsr	destroy_window

	rts



**********************************************
*********** DISPLAY PLANE NUMBER      ********
**********************************************
display_plane_number
	
	move.w	#1,d4
	bsr	display_number_of_planes
	rts

**********************************************
*********** REMOVE PLANE NUMBER       ********
**********************************************
remove_plane_number
	
	move.w	#0,d4
	bsr	display_number_of_planes
	rts



**********************************************
*********** DISPLAY NUMBER OF PLANES  ********
**********************************************
display_number_of_planes
	
	move.l	#savepic_Window,a0		; write in filename
	move.w	#2,d2
	move.w	#110,d0
	move.w	#40,d1
	move.w	number_of_planes_to_save,d3
	jsr	Write_num


	rts
		
	
**********************************************
*********** DISPLAY DPAINT BUTTON     ********
**********************************************
display_dpaint_button

	move.b	#1,save_format
	bsr	display_relavant_button
	rts


**********************************************
*********** DISPLAY RAW BUTTON        ********
**********************************************
display_raw_button

	move.b	#0,save_format
	bsr	display_relavant_button
	rts
	
**********************************************
*********** DISPLAY RELAVANT BUTTON   ********
**********************************************
display_relavant_button

	tst.b	save_format
	beq.s	raw_selected
	move.l	#savepic_raw,a0
	bsr	remove_button
	move.b	#NOT_DEPRESSED,button_start(a0)
	bsr	display_button 
	move.l	#savepic_dpaint,a0
	bsr	remove_button
	move.b	#DEPRESSED,button_start(a0)
	bsr	display_button
	rts
raw_selected
	move.l	#savepic_dpaint,a0
	bsr	remove_button
	move.b	#NOT_DEPRESSED,button_start(a0)
	bsr	display_button 
	move.l	#savepic_raw,a0
	bsr	remove_button
	move.b	#DEPRESSED,button_start(a0)
	bsr	display_button 
	rts	
	
      
**********************************************
*********** CHOSEN SLICED FORMAT      ********
**********************************************
chosen_sliced_format

	bchg	#0,sliced
	rts

      
**********************************************
*********** UP THE PLANES             ********
**********************************************
up_the_planes

	cmp.w	#5,number_of_planes_to_save
	beq.s	at_max_pl
	bsr	remove_plane_number
	addq.w	#1,number_of_planes_to_save
	bsr	display_plane_number
at_max_pl
	rts


**********************************************
*********** DOWN THE PLANES           ********
**********************************************
down_the_planes

	cmp.w	#1,number_of_planes_to_save
	beq.s	at_min_pl
	bsr	remove_plane_number
	subq.w	#1,number_of_planes_to_save
	bsr	display_plane_number
at_min_pl

	rts

**********************************************
*********** SAVE TYPE PIC             ********
**********************************************
save_type_pic
	bsr	remove_save_pic_window	
	tst.b	save_format
	beq.s	hassle_save
	bsr	save_pic
	rts
hassle_save
	bsr	get_number_of_blocks_to_save	
	rts

**********************************************
*********** DRAW ASK NUMBER           ********
**********************************************
draw_ask_number

	move.l	#get_num_blocks_window,a0		; write in filename
	move.w	#6,d2
	move.w	#50,d0
	move.w	#6,d1
	move.w	number_of_blocks_to_write_out,d3
	jsr	Write_num


	move.l	#get_num_blocks_window,a0		; write in filename
	move.w	#6,d2
	move.w	#50,d0
	move.w	#17,d1
	move.w	number_of_k,d3
	jsr	Write_num


	rts


number_of_k
	dc.w	0
**********************************************
*********** DISPLAY ASK NUMBER        ********
**********************************************
display_ask_number

	move.w	#1,d4
	bsr	draw_ask_number
	rts


**********************************************
*********** DELETE  ASK NUMBER        ********
**********************************************
delete_ask_number

	move.w	#0,d4
	bsr	draw_ask_number
	rts

**********************************************
*********** DISPLAY ASK NUMBER        ********
**********************************************
display_ask_numbers

	bsr	set_original_colours	
	move.l	#get_num_blocks_window,a0
	jsr	create_window
	move.l	#get_num_buttons,a0
	jsr	display_button_list
	move.l	#get_num_blocks_window,a0		; write in filename
	move.l	#get_num_text,a1
	move.w	#2,d2
	move.w	#6,d0
	move.w	#6,d1
	move.w	#1,d3
	jsr	Write_Text

	move.l	current_map_ptr,a0
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d0
	divu	map_block_size(a0),d0	;xblocks
	move.w	screen_y_size(a1),d1
	divu	map_block_size(a0),d1
	mulu	d1,d0
	mulu	#4,d0	
	tst.w	map_datasize(a0)
	beq.s	bytey_wyty
	move.w	d0,number_of_blocks_to_write_out
	move.w	d0,max_blocks
	bra.s	display_the_num	
bytey_wyty
	cmp.w	#255,d0
	ble.s	within_limits_man
	move.w	#255,d0
within_limits_man
	move.w	d0,number_of_blocks_to_write_out		
	move.w	d0,max_blocks
display_the_num	
	bsr	calculate_block_k
	bsr	display_ask_number
	rts

calculate_block_k

	moveq	#0,d0
	move.l	current_map_ptr,a0
	move.l	map_block_size(a0),d0
	asr.w	#3,d0
	mulu	map_block_size(a0),d0
	mulu	map_planes(a0),d0
	mulu	number_of_blocks_to_write_out,d0
	divu	#1024,d0
	move.w	d0,number_of_k

	rts


max_blocks
	dc.w	0

**********************************************
*****     GET NUMBER OF BLOCKS TO SAVE********
**********************************************
get_number_of_blocks_to_save

	
	bsr	display_ask_numbers

	rts


**********************************************
*****  REMOVE GET NUM WINDOW          ********
**********************************************
remove_get_num_window


	move.l	#get_num_buttons,a0
	bsr	remove_button_list
	move.l	#get_num_blocks_window,a0
	bsr	destroy_window

	rts

**********************************************
*****   CANCEL GET NUM                ********
**********************************************
cancel_get_num


	bsr	remove_get_num_window

	rts


**********************************************
*****   GO GET NUM                    ********
**********************************************
go_get_num


	bsr	remove_get_num_window
	bsr	save_pic

	rts


**********************************************
*****   UP THE BLOCKS                 ********
**********************************************
up_the_blocks

	move.w	number_of_blocks_to_write_out,d0
	cmp.w	max_blocks,d0
	beq.s	at_max_block_level
	bsr	delete_ask_number
	addq.w	#1,number_of_blocks_to_write_out
	bsr	calculate_block_k
	bsr	display_ask_number
at_max_block_level	
	rts



**********************************************
*****   DOWN THE BLOCKS               ********
**********************************************
down_the_blocks

	cmp.w	#1,number_of_blocks_to_write_out
	beq.s	at_min_block_level
	bsr	delete_ask_number
	subq.w	#1,number_of_blocks_to_write_out
	bsr	calculate_block_k
	bsr	display_ask_number
at_min_block_level	
	rts


save_format
	dc.b 	0
	EVEN
sliced
	dc.b	0
	EVEN	
number_of_planes_to_save
	dc.w	0

number_of_blocks_to_write_out
	dc.w	0
	
savepic_text
	dc.b  "Save picture as ",$a,$a,-2,3
	dc.b  " DPAINT File    ",$a
	dc.b  "   -Planes  ",$a,$a
	dc.b  " Raw Data       ",$a
	dc.b  "   -Sliced  ",0
	even

savepic_window
	dc.w	240
	dc.w	140
	dc.w	32
	dc.w	20
	dc.l	0
	dc.l	0
	dc.b	"SAVE PIC WINDOW",0
	even		
savepic_buttons
	dc.l	savepic_save_button,savepic_cancel_button
	dc.l	savepic_dpaint,savepic_raw,savepic_sliced
	dc.l	savepic_plane_up,savepic_plane_down,-1

savepic_save_Button
	dc.w	21
	dc.w	108
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	save_custom_button
	dc.l	0	;not used
        dc.l	save_type_pic
	dc.b	0		
	even

savepic_cancel_Button
	dc.w	21+64+5+16+16
	dc.w	108
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	remove_save_pic_window
	dc.b	0		
	even
	

savepic_dpaint
	dc.w	152
	dc.w	30
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	display_dpaint_button
	dc.b	0		
	EVEN						

	

savepic_raw
	dc.w	152
	dc.w	63
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	display_raw_button
	dc.b	0		
	EVEN						


savepic_sliced
	dc.w	124
	dc.w	74
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	chosen_sliced_format
	dc.b	0		
	EVEN						

savepic_plane_up
	dc.w	160
	dc.w	40
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	up_the_planes
	dc.b	0		
	EVEN						

savepic_plane_down
	dc.w	160+20
	dc.w	40
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	down_the_planes
	dc.b	0		
	EVEN			



get_num_blocks_window
	dc.w	176+32
	dc.w	72+16
	dc.w	72-16
	dc.w	60
	dc.l	0
	dc.l	0
	dc.b	"NO. TO SAVE",0
	even		


get_num_text
	dc.b	"Save      blocks",$a
	dc.b    "  at      k",0
	EVEN
	

get_num_buttons
	dc.l	get_num_save_button,get_num_cancel_button
	dc.l	get_num_blocks_down,get_num_blocks_up,-1	

get_num_save_Button
	dc.w	10
	dc.w	35+20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	save_custom_button
	dc.l	0	;not used
        dc.l	go_get_num
	dc.b	0		
	even

get_num_cancel_Button
	dc.w	10+90
	dc.w	35+20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	cancel_get_num
	dc.b	0		
	even

get_num_blocks_up
	dc.w	60+5
	dc.w	25+10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	up_the_blocks
	dc.b	0		
	EVEN						

get_num_blocks_down
	dc.w	60+20+5
	dc.w	25+10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	down_the_blocks
	dc.b	0		
	EVEN			
	
	
