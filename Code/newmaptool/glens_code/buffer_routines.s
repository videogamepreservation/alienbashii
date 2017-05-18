***********************************
**** DISPLAY CURRENT BUFF NAME ****
***********************************
Display_Current_Buff_Name

	moveq	#1,d3
	bsr	Draw_Current_Buff_Name	

	rts

***********************************
**** REMOVE CURRENT BUFF NAME ****
***********************************
Remove_Current_Buff_Name

	moveq	#0,d3
	bsr	Draw_Current_Buff_Name
	rts
	
***********************************
**** DRAW    CURRENT BUFF NAME ****
***********************************
Draw_Current_Buff_Name

	move.w	current_buffer,d0
	mulu	#buffstructsize,d0
	move.l	#buffers,a1
	add.l	d0,a1
	add.l	#buffername,a1
	move.l	#button_window_struct,a0
	move.w	#440+9,d0
	move.w	#FOURTH_ROW-4,d1
	move.w	#4,d2
	bsr	write_button_text
	rts	




*******************************************
***** GET BUFFER BOX                   ****
*******************************************

get_buffer_box
	
WD	btst.b	#6,$bfe001
	bne.s	WD			; press down mouse button (start drag)


	bsr	convert_mouse_and_store
	bsr	truncate_values	
	move.w	d0,Image_Start_X
	move.w	d1,Image_Start_y

drag_box_loop
	
	bsr	convert_mouse_and_store
	move.l	current_map_ptr,a0
	bsr	truncate_values
	move.l	#main_screen_struct,a0
	move.w	d0,Box_X
	move.w	d1,Box_Y

DrawBoxIn
	move.w	Image_Start_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

	move.w	Box_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Box_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Image_Start_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

Boxsync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	Boxsync		Test for zero (box can't draw past)

Delete_Box
	move.w	Image_Start_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

	move.w	Box_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Box_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Image_Start_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line
		
	btst.b	#6,$bfe001
	beq	drag_box_loop			; release mouse button (end drag)

	move.w	Box_X,Image_End_X
	move.w	Box_Y,Image_End_Y
	
	move.w	Image_End_X,d0		;
	cmp.w	Image_Start_X,d0
	bge.s	Box_Drawn_Ok_X
	move.w	Image_Start_X,Image_End_X
	move.w	d0,Image_Start_X	
Box_Drawn_Ok_X	
	move.w	Image_End_Y,d0		;
	cmp.w	Image_Start_Y,d0
	bge.s	Box_Drawn_Ok_Y
	move.w	Image_Start_Y,Image_End_Y
	move.w	d0,Image_Start_Y
Box_Drawn_Ok_Y


	moveq	#0,d7
	cmp.w	#MODE_CUT,buffer_mode
	bne.s	mode_copy_buff
	moveq	#1,d7
mode_copy_buff	
	move.w	d7,-(sp)
	bsr	copy_buffer_to_hold	
	move.w	(sp)+,d7
	beq.s	no_cut
	bsr	display_undo
	bsr	make_screen_backup
no_cut
	rts
	
Box_X	dc.w	0
Box_Y	dc.w	0

Image_Start_Y	dc.w	0
Image_End_Y	dc.w	0
Image_Start_X	dc.w	0
Image_End_X	dc.w	0		

*******************************************
***** TRUNCATE VALUES                  ****
*******************************************
truncate_values
*send in d0 and d1

	move.l	current_map_ptr,a0
	move.w	map_xsize(a0),d2
	add.w	map_x_position,d2
	mulu	map_block_size(a0),d2
	move.w	map_ysize(a0),d3
	add.w	map_y_position,d3
	mulu	map_block_size(a0),d3
	
	cmp.w	d2,d0
	ble.s	no_trunc_x
	move.w	d2,d0
no_trunc_x
	cmp.w	d3,d1
	ble.s	no_trunc_y
	move.w	d3,d1
no_trunc_y
	rts		

*******************************************
***** CUT BLOCK                        ****
*******************************************
cut_block

	move.w	#COPYCUT_BLOCK_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	move.w	#MODE_CUT,buffer_mode
	rts
	
*******************************************
***** COPY BLOCK                       ****
*******************************************
copy_block

	move.w	#COPYCUT_BLOCK_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	move.w	#MODE_COPY,buffer_mode
	rts



buffer_mode
	dc.w	0

MODE_CUT  EQU 0
MODE_COPY EQU 1



********************************************
****** COPY BUFFER TO HOLD            ******
********************************************
copy_buffer_to_hold

*send in d7 whether to clear original data ( 0 = no clear )

	move.w	map_x_position,d0
	move.w	map_y_position,d1
copy_buffer_to_pos	


	move.l	current_buffer_mem,a1
	move.l	buffer_mem(a1),a2
	
	move.l	current_map_ptr,a3

	moveq	#0,d2
	move.w	Image_Start_X,d2
	divu	map_block_size(a3),d2
	add.w	d2,d0
	moveq	#0,d2
	move.w	Image_Start_Y,d2
	divu	map_block_size(a3),d2
	add.w	d2,d1
	
	bsr	get_map_position
	
****start of block in a0	
	moveq	#0,d2
	move.w	Image_End_X,d2
	sub.w	Image_Start_X,d2	
	divu	map_block_size(a3),d2	;x size of block
	move.w	d2,buffer_xsize(a1)
	
	moveq	#0,d3
	move.w	Image_End_Y,d3
	sub.w	Image_Start_Y,d3		
	divu	map_block_size(a3),d3	;y size of block
	move.w	d3,buffer_ysize(a1)
	
	move.w	map_datasize(a3),d6
	moveq	#0,d5
	move.w	map_xsize(a3),d5
	asl.w	d6,d5	;one line size		

	tst	d2
	beq	no_refresh_buffer
	tst	d3
	beq	no_refresh_buffer
	
	subq.w	#1,d2
	subq.w	#1,d3
		
	
copy_y_data_buffer
	move.l	a0,a4
	move.w	d2,d4
	
copy_x_data_buffer
	tst	d6
	beq.s	copy_byte_buffer
	move.w	(a4),(a2)+
	tst	d7
	beq.s	no_clear_word_buffer
	move.w	#0,(a4)
no_clear_word_buffer
	addq.l	#2,a4	
	bra.s	get_next_block_buffer
copy_byte_buffer
	move.b	(a4),(a2)+
	tst	d7
	beq.s	no_clear_byte_buffer
	move.b	#0,(a4)
no_clear_byte_buffer
	addq.l	#1,a4	
get_next_block_buffer
	dbra	d4,copy_x_data_buffer
	add.l	d5,a0
	dbra	d3,copy_y_data_buffer					
	tst	d7
	beq.s	no_refresh_buffer
	bsr	display_map_on_screen
no_refresh_buffer	
	rts
	

********************************************
****** PASTE BLOCK                    ******
********************************************
paste_block
	move.w	#TO,sprite_to_attach
	move.w	#PASTE_BLOCK_MODE,map_function_mode
	rts
	
********************************************
****** PASTE HOLD TO MAP              ******
********************************************
paste_hold_to_map

*ensure user not trying to paste non existant buffer

	move.l	current_buffer_mem,a0
	tst.w	buffer_xsize(a0)
	beq	quit_paste
	tst.w	buffer_ysize(a0)
	beq	quit_paste



	bsr	display_undo
	bsr	make_screen_backup
paste_box_loop

	bsr	draw_paste_box	
pasteBoxsync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	pasteBoxsync		Test for zero (box can't draw past)

Delete_pasteBox

	bsr	delete_paste_box
	
	btst.b	#6,$bfe001
	beq	paste_box_loop			; release mouse button (end drag)



	bsr	test_for_out_of_bounds
	tst	d0
	bmi	quit_paste
	move.l	current_buffer_mem,a1
	move.l	buffer_mem(a1),a2
	
	move.l	current_map_ptr,a3

	bsr	convert_mouse_and_store
paste_in_quiet	
	divu	map_block_size(a3),d0
	divu	map_block_size(a3),d1
	add.w	map_x_position,d0
	add.w	map_y_position,d1
paste_in_very_quiet	

	bsr	get_map_position
	
****start of block in a0	
	move.w	buffer_xsize(a1),d2
	move.w	buffer_ysize(a1),d3
	
	moveq	#0,d7
	move.w	d2,d6
	add.w	d0,d6
	cmp.w	map_xsize(a3),d6
	ble.s	no_out_of_bounds_paste_x
	sub.w	map_xsize(a3),d6
	move.w	d6,d7
	sub.w	d6,d2
no_out_of_bounds_paste_x
	
	
	move.w	d3,d6
	add.w	d1,d6
	cmp.w	map_ysize(a3),d6
	ble.s	no_out_of_bounds_paste_y
	sub.w	map_ysize(a3),d6
	sub.w	d6,d3		;new y size to copy in
no_out_of_bounds_paste_y

	
	move.w	map_datasize(a3),d6
	moveq	#0,d5
	move.w	map_xsize(a3),d5
	asl.w	d6,d5	;one line size		

	asl	d6,d7	;map x remainder
	
	subq.w	#1,d2
	subq.w	#1,d3
		
paste_y_data_buffer
	move.l	a0,a4
	move.w	d2,d4
paste_x_data_buffer
	tst	d6
	beq.s	paste_byte_buffer
	move.w	(a2)+,(a4)+
	bra.s	get_next_block_buffer_paste
paste_byte_buffer
	move.b	(a2)+,(a4)+
get_next_block_buffer_paste
	dbra	d4,paste_x_data_buffer
	add.l	d7,a2
	add.l	d5,a0
	dbra	d3,paste_y_data_buffer					
	bsr	display_map_on_screen
quit_paste	
	rts
	

********************************************
****** DRAW PASTE BOX                 ******
********************************************
draw_paste_box
	bsr	convert_mouse_and_store
	
	move.l	#main_screen_struct,a1
	moveq	#0,d4
	move.l	current_map_ptr,a3
	move.l	current_buffer_mem,a0
	move.w	buffer_xsize(a0),d4
	mulu	map_block_size(a3),d4
	cmp.w	screen_x_size(a1),d4
	ble.s	withinbounds
	move.w	screen_x_size(a1),d4
withinbounds	
	moveq	#0,d5
	move.w	buffer_ysize(a0),d5
	mulu	map_block_size(a3),d5
	cmp.w	max_map_screen_pos,d5
	ble.s	with_y_bounds
	move.w	max_map_screen_pos,d5
with_y_bounds		
	move.l	#main_screen_struct,a4
	move.w	screen_x_size(a4),d7
	sub.w	d4,d7
	cmp.w	d7,d0
	ble.s	fits_ok
	move.w	d7,d0
fits_ok
	move.w	max_map_screen_pos,d7
	sub.w	d5,d7
	cmp.w	d7,d1
	ble.s	fits_ok_y
	move.w	d7,d1
fits_ok_y	
	
     	move.w	d0,bx1
	move.w	d1,by1
	move.w	d4,bxsize
	move.w	d5,bysize	
	
draw_paste_box_lines
	move.l	#main_screen_struct,a0

	move.w	d0,d2
	move.w	d1,d3
	add.w	d5,d3
	
	movem.l	d0-d5,-(sp)
	bsr	EOR_Draw_Line	;left to bot
	movem.l	(sp)+,d0-d5
	
	add.w	d5,d1
	add.w	d4,d2		;left to right
	
	movem.l	d0-d5,-(sp)
	bsr	EOR_Draw_Line	
	movem.l	(sp)+,d0-d5

	
	add.w	d4,d0
	sub.w	d5,d3	
	
	movem.l	d0-d5,-(sp)
	bsr	EOR_Draw_Line	;right to top
	movem.l	(sp)+,d0-d5

	
	sub.w	d5,d1
	sub.w	d4,d2	
	
	movem.l	d0-d5,-(sp)
	bsr	EOR_Draw_Line	;right to left
	movem.l	(sp)+,d0-d5

	
	rts
	
********************************************
****** DELETE PASTE BOX               ******
********************************************
delete_paste_box
	move.w	bx1,d0
	move.w	by1,d1
	move.w	bxsize,d4
	move.w	bysize,d5
	bra	draw_paste_box_lines
	rts

bx1  dc.w	0
by1  dc.w	0
bxsize  dc.w	0
bysize  dc.w	0		


********************************************
****** MAKE SCREEN BACKUP             ******
********************************************
make_screen_backup
	
	move.l	current_buffer_mem,buffer_temp
	move.l	undo_buffer1,current_buffer_mem
	move.w	#0,IMage_Start_X
	move.w	#0,Image_Start_Y
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d0
	move.w	max_map_screen_pos,d1
	bsr	truncate_values
	move.w	d0,Image_End_X
	move.w	d1,Image_End_Y
	move.w	#0,d7
	bsr	copy_buffer_to_hold
	move.l	buffer_temp,current_buffer_mem
	move.w	map_x_position,mp_x_pos
	move.w	map_y_position,mp_y_pos
	
	rts

mp_x_pos	dc.w	0
mp_y_pos	dc.w	0	
	
********************************************
****** UNDO                           ******
********************************************
undo
	move.l	current_buffer_mem,buffer_temp
	move.l	undo_buffer2,current_buffer_mem
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d1
	bsr	truncate_values
	move.w	#0,Image_Start_X
	move.w	#0,Image_Start_Y
	move.w	d0,Image_End_X
	move.w	d1,Image_End_Y
	move.w	#0,d7
	move.w	mp_x_pos,d0
	move.w	mp_y_pos,d1
	bsr	copy_buffer_to_pos

	moveq	#0,d0
	moveq	#0,d1	
	move.w	mp_x_pos,d0
	move.w	mp_y_pos,d1

	move.l	undo_buffer1,current_buffer_mem
	move.l	current_map_ptr,a3	
	move.l	current_buffer_mem,a1
	move.l	buffer_mem(a1),a2
	bsr	paste_in_very_quiet
	
	move.l	undo_buffer1,a0
	move.l	undo_buffer2,a1
	move.l	a0,undo_buffer2
	move.l	a1,undo_buffer1
	
	move.l	buffer_temp,current_buffer_mem
	bsr	display_map_on_screen
	rts
	
buffer_temp
	dc.l	0	
	
undo_buffer1
	dc.l	screen_backup1
undo_buffer2
	dc.l	screen_backup2	

screen_backup1
	ds.w	2
	ds.b    12
	dc.l	scr1b

screen_backup2	
	ds.w	2
	ds.b    12
	dc.l	scr2b
