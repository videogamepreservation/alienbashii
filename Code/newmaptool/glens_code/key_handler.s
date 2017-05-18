************************************************
**** READ KEYS                              ****
************************************************
Read_Keys
* I really dont care about this code
	bsr	get_pressed_key
	cmp.b	#'1',d0
	blt.s	not_interested
	cmp.b	#'3',d0
	bgt.s	not_interested
	bsr	Change_Edit_Mode
	rts
not_interested
	cmp.b	#'Q',d0
	beq	quit_editor
	cmp.b	#' ',d0
	beq	pick_under_cursor 
	cmp.b	#'f',d0
	beq	toggle_fullscreen
	cmp.b	#'-',d0
	beq	decrease_mouse_sense
	cmp.b	#'=',d0
	beq	increase_mouse_sense
	cmp.w	#1,edit_mode
	bne	no_key_pressed
	cmp.b	#'C',d0
	beq	select_copy_mode
	cmp.b	#'P',d0
	beq	select_paste_mode
	cmp.b	#'X',d0
	beq	select_cut_mode
	cmp.b	#'F',d0
	beq	select_fill_mode
	cmp.b	#'s',d0
	beq	select_show_all	
	cmp.b	#'j',d0
	beq	flip_map_pages
	cmp.b	#'p',d0
	beq	pick_delete_block
	cmp.b	#'g',d0
	beq	change_grid_mode
	cmp.b	#'u',d0
	beq	select_undo
	cmp.b	#'z',d0
	beq	scroll_block_line_up
	cmp.b	#'a',d0
	beq	scroll_block_line_down
	cmp.b	#CURSOR_UP,d0
	beq	move_cursor_up
	cmp.b	#CURSOR_DOWN,d0
	beq	move_cursor_down
	cmp.b	#CURSOR_LEFT,d0
	beq	move_cursor_left
	cmp.b	#CURSOR_RIGHT,d0
	beq	move_cursor_right
	cmp.b	#F1_KEY,d0
	beq	select_key_buffer
	cmp.b	#F2_KEY,d0
	beq	select_key_buffer
	cmp.b	#F3_KEY,d0
	beq	select_key_buffer
	cmp.b	#F4_KEY,d0
	beq	select_key_buffer
	cmp.b	#F5_KEY,d0
	beq	select_key_buffer
	cmp.b	#F6_KEY,d0
	beq	select_key_buffer
	cmp.b	#F7_KEY,d0
	beq	select_key_buffer
	cmp.b	#F8_KEY,d0
	beq	select_key_buffer	
not_num_key	
	cmp.b	#',',d0		;use < and > to select pages
	beq.s	down_page
	cmp.b	#'.',d0
	bne.s	no_key_pressed	;end of chain
	cmp.w	#3,current_page	;up page
	beq.s	no_key_pressed
	addq.w	#1,current_page
	bra.s	key_change_page
down_page
	tst.w	current_page
	beq.s	no_key_pressed
	subq.w	#1,current_page
key_change_page	
	move.w	current_page,d0
	move.l  #picture_pages,a0
	ext.l	d0
    	asl.w	#2,d0
  	move.l  (a0,d0.w),page_pointer
  	bsr	display_blocks_on_screen
no_key_pressed	
	rts
select_paste_mode	
	jsr	paste_block
	rts
select_cut_mode
	jsr	cut_block
	rts
select_copy_mode
	jsr	copy_block
	rts
select_fill_mode
	jsr	fill_map
	rts	
select_show_all
	jsr	show_whole_map
	rts	
decrease_mouse_sense
	subq.w	#5,sensativity
	cmp.w	#10,sensativity
	bge.s	dont_dec_mouse
	move.w	#10,sensativity
dont_dec_mouse
	rts
increase_mouse_sense
	addq.w	#5,sensativity
	cmp.w	#100,sensativity
	ble.s	dont_inc_mouse
	move.w	#100,sensativity
dont_inc_mouse
	rts					
select_undo
	tst.w	undo_on
	beq.s	dont_call_undo
	jsr	undo
dont_call_undo
	rts	
pick_under_cursor
	tst.w	edit_data_flag
	beq.s	are_we_in_map_mode	
	tst.w	last_alien_displayed
	beq.s	cannot_pick_alien
	clr.w	d3
	jsr	Display_Alien_String
	move.w	#1,d3
	move.w	last_alien_displayed,current_alien_number
	jsr	Display_Alien_String
cannot_pick_alien	
	rts
are_we_in_map_mode
	cmp.w	#1,edit_mode
	bne.s	not_in_em_mode
	bsr	Remove_Selected_Block_Num
	
	move.l	current_map_ptr,a1
	move.l	map_mem(a1),a0
	move.w	map_datasize(a1),d5

	bsr	Convert_Mouse_And_Store
	divu	map_block_size(a1),d0
	divu	map_block_size(a1),d1
	add.w	map_x_position,d0
	add.w	map_y_position,d1
	mulu	map_xsize(a1),d1
	add.w	d0,d1
	asl.w	d5,d1
	moveq	#0,d0
	tst	d5
	beq.s	extract_byte_map
	move.w	(a0,d1),d0
	bra.s	update_block_details
extract_byte_map
	move.b	(a0,d1),d0		
update_block_details
	move.w	d0,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num	
not_in_em_mode	
	rts
toggle_fullscreen
	tst.w	edit_data_flag	;this is so naff - why did I have a separate flag???
	bne.s	change_full_mode	
	tst.w	edit_mode
	bne.s	change_full_mode
	rts
change_full_mode	
	bsr	sync			;ensure not near bottom
	tst.w	fullscreen_mode
	beq	set_fullscreen
	clr.w	fullscreen_mode
	move.w	#BUTTON_WINDOW_OFFSET,max_screen_pos
	move.w	#BUTTON_WINDOW_OFFSET,screen_custom_y
	tst.w	edit_data_flag
	beq.s	not_in_edit_mode_ok
	move.w	#BUTTON_WINDOW_OFFSET,map_screen_custom_y
	move.w	#BUTTON_WINDOW_OFFSET,max_map_screen_pos

	bra.s	replace_cop
not_in_edit_mode_ok	
	move.w	#BUTTON_WINDOW_OFFSET-32,map_screen_custom_y	
	move.w	#BUTTON_WINDOW_OFFSET-32,max_map_screen_pos
replace_cop	
	move.w	#14-1,d2
	move.l	#full_screen,a0
remove_end_cop
	move.l	#$01fe0000,(a0)+
	dbra	d2,remove_end_cop
	cmp.w	#1,edit_mode
	bne.s	remove_not_in_map_mode
	move.w	#1,show_box2
	bsr	position_box_sprite2
	bsr	display_map_on_screen
	bsr	display_blocks_on_screen
remove_not_in_map_mode	
	tst	edit_data_flag
	beq.s	remove_not_in_edit_data_mode
	bsr	display_map_on_screen
	jsr	display_alien_numbers
remove_not_in_edit_data_mode	
	rts
set_fullscreen
	move.w	#1,fullscreen_mode
	move.w	#255,max_screen_pos
	move.w	#255,screen_custom_y
	move.w	#255,map_screen_custom_y
	move.w	#256,max_map_screen_pos
	move.l	#full_screen,a0
	move.l	#end_copper,a1
	move.w	#14-1,d2
copy_end_cop
	move.l	(a1)+,(a0)+
	dbra	d2,copy_end_cop			
	
	cmp.w	#2,edit_mode
	bne.s	not_in_graphics_mode	
	move.l page_pointer,a0
	tst.w	screen_y_pos(a0)
	beq.s	not_in_graphics_mode
	clr.w	screen_y_pos(a0)
	bsr    display_graphic_page
not_in_graphics_mode	
	cmp.w	#1,edit_mode
	bne.s	not_in_map_mode
	clr.w	show_box2
	bsr	position_box_sprite2
	bsr	display_map_on_screen
not_in_map_mode	
	tst.w	edit_data_flag
	beq.s	not_in_edit_data_mode
	bsr	display_map_on_screen
not_in_edit_data_mode	
	rts			
quit_editor
	bsr	kill_system
	rts
change_grid_mode
	bchg.b	#0,grid_on+1
	bsr	display_blocks_on_screen
	rts	
flip_map_pages
	move.l	current_map_ptr,a0
	move.w	map_y_position,Map_Y_Val(a0)
	move.w	map_x_position,Map_X_Val(a0)
	
	cmp.l	#map_details,current_map_ptr
	beq.s	Flip_To_Second_Map
	move.l	#map_details,current_map_ptr
	clr.w	current_map
	bra.s	Update_For_New_Map
Flip_To_Second_Map	
	move.l	#map_details2,current_map_ptr
	move.w	#1,current_map
Update_For_New_Map	
	move.l	current_map_ptr,a0
	move.w	Map_Y_Val(a0),map_y_position
	move.w	Map_X_Val(a0),map_x_position
	bsr	Calculate_Blocks_In_One_Page
	bsr	display_map_on_screen
	bsr	Display_X_Y
	rts	
Change_Edit_Mode
*determine mode in
	clr.w	d1
	tst	edit_mode
	beq.s	not_in_map_or_graph	
	cmp.w	#2,edit_mode
	beq.s	go_to_new_mode
	moveq	#1,d1
	bra.s	go_to_new_mode
not_in_map_or_graph	
	tst	edit_data_flag
	beq	not_in_any_mode
	move.w	#2,d1
go_to_new_mode			

*determine mode to change to	
	ext.w	d0
	sub.w	#'1',d0	
	cmp.w	d0,d1
	beq.s	not_in_any_mode	;dont bother to change
	
	tst	d0
	beq.s	go_to_graphic_mode
	cmp.w	#1,d0
	beq.s	go_to_edit_map_mode
*go to data	
	cmp.w	#1,d1
	beq.s	go_from_map2
*go from graphic
	bsr	remove_graphic_buttons
	bra.s	go_to_data	
go_from_map2
	bsr	remove_edit_buttons
go_to_data
	jsr	delete_buttons
	jsr	draw_buttons
	jsr	bring_up_data_function
	rts	

go_to_graphic_mode
	cmp.w	#1,d1
	beq.s	go_from_map
*go from edit_data
	jsr	exit_data_function
	bra.s	bring_up_gr			
go_from_map
	bsr	remove_edit_buttons	
bring_up_gr
	jsr	delete_buttons
	jsr	draw_buttons
	bsr	display_graphic_buttons
	rts
	
go_to_edit_map_mode
	tst	d1
	beq.s	go_from_graph
*go from data
	jsr	exit_data_function
	bra.s	bring_up_map
go_from_graph
	bsr	remove_graphic_buttons
bring_up_map
	jsr	delete_buttons
	jsr	draw_buttons
	bsr	display_edit_buttons
	rts		
		
not_in_any_mode	
	rts
	
pick_delete_block
	move.l	current_block_mem,delete_block_mem
	move.w	current_block,d1
	move.w	d1,delete_block
	move.l	#Project_Del_Block,d0
	jsr	Set_Project_Value
	rts	

delete_block
	dc.w	0
delete_block_mem
	dc.l	0	
	
scroll_block_line_up
	bsr	change_blocks_position_up
	rts
scroll_block_line_down
	bsr	change_blocks_position_down
	rts	
		
	
select_key_buffer
	add.w	#16,d0
	neg.w	d0
	move.w	d0,-(sp)	
	jsr	remove_current_buff_name
	move.w	(sp)+,d0
	move.w	d0,current_buffer
	jsr	calculate_buffer_mem
	jsr	display_current_buff_name

	rts
	
move_cursor_up
	bsr	Remove_Selected_Block_Num
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d0
	
	sub.w	d0,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num
	rts

move_cursor_down
	bsr	Remove_Selected_Block_Num
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d0
	
	add.w	d0,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num
	rts
	
move_cursor_left
	bsr	Remove_Selected_Block_Num
	subq.w	#1,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num

	rts
	
move_cursor_right
	bsr	Remove_Selected_Block_Num
	addq.w	#1,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num


	rts				

fullscreen_mode	dc.w	0
max_screen_pos	dc.w	BUTTON_WINDOW_OFFSET
max_map_screen_pos	dc.w	BUTTON_WINDOW_OFFSET-32