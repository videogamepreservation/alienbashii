
********************************************
*** CONVERT NEW MAP                      ***
********************************************
convert_new_map
	movem.l	d0-d7/a0-a6,-(sp)
	moveq	#0,d0
	moveq	#0,d1
	move.l  current_map_ptr,a0
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.w	map_datasize(a0),d1
	asl.l	d1,d0		;double if word map
	move.l	#MEM_PUBLIC+MEM_CLEAR,d1
	movem.l	a6/a0,-(sp)
	move.l	4.w,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,a6/a0
	tst.l	d0
	bne.s	got_new_map_mem
*raise error
	bra	end_convert
got_new_map_mem
	move.l	d0,a1		;store pointer
	
*-----get new alien map mem

	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.l	#MEM_PUBLIC+MEM_CLEAR,d1
	movem.l	a6/a0-a1,-(sp)
	move.l	4.w,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,a6/a0-a1
	tst.l	d0
	bne.s	got_new_alien_map_mem
*raise error
	bra	end_convert
got_new_alien_map_mem
	
	move.l	d0,new_alien_mem
	
	
*store the following so you know what size of block data is associated
*with the data currently in the structure
*and also old x and y sizes

convert_old_map_data

	move.l	a1,a2		;new map data
	move.l	map_mem(a0),a3	;old map data


	move.l	new_alien_mem,a2_reg
	move.l	map_alien_mem(a0),a3_reg
		
	move.w	map_ysize(a0),d1
	move.w	map_allocy(a0),d3
	
do_x_convert
	move.w	map_xsize(a0),d0
	move.w	map_allocx(a0),d4
	move.l	a2,a4
	move.l	a3,a5
	
	move.l	a2_reg,a4_reg
	move.l	a3_reg,a5_reg
start_convert
	moveq	#0,d2
	tst.w	map_allocdatasize(a0)
	beq.s	was_byte_data
	move.w	(a5)+,d2
	bra.s	insert_into_new_map
was_byte_data
	move.b	(a5)+,d2
insert_into_new_map
	tst	map_datasize(a0)
	beq.s	new_map_byte
	move.w	d2,(a4)+
	bra.s	check_sizes
new_map_byte
	move.b	d2,(a4)+
check_sizes

	movem.l	a4/a5,-(sp)
	move.l	a4_reg,a4
	move.l	a5_reg,a5
	move.b	(a5)+,(a4)+
	move.l	a5,a5_reg
	move.l	a4,a4_reg
	movem.l	(sp)+,a4/a5

	subq.w	#1,d0
	beq.s	do_next_line
	subq.w	#1,d4
	beq.s	do_next_line

	bra.s	start_convert
do_next_line
	moveq	#0,d7
	move.w	map_xsize(a0),d7
	move.w	map_datasize(a0),d6
	add.l	d7,a2_reg	;alien map always byte
	asl.w	d6,d7
	add.l	d7,a2

	moveq	#0,d7
	move.w	map_allocx(a0),d7
	move.w	map_allocdatasize(a0),d6
	add.l	d7,a3_reg		;alien map always byte
	asl.w	d6,d7
	add.l	d7,a3
	subq.w	#1,d1
	beq	done_all_map
	subq.w	#1,d3   ; was d2 - bug
	beq	done_all_map

	bra	do_x_convert
done_all_map
******FINISHED

	movem.l	a1/a0/a6,-(sp)
	move.l	map_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	map_allocx(a0),d0
	mulu	map_allocy(a0),d0
	move.w	map_allocdatasize(a0),d1
	asl.l	d1,d0
	move.l	4.w,a6
	jsr    -210(a6)		;deallocate old memory
	movem.l	(sp)+,a1/a0/a6

*---dealloc alien mem	
	movem.l	a1/a0/a6,-(sp)
	move.l	map_alien_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	map_allocx(a0),d0
	mulu	map_allocy(a0),d0
	move.l	4.w,a6
	jsr    -210(a6)		;deallocate old memory
	movem.l	(sp)+,a1/a0/a6

	
no_previous_map_allocated
	move.l	a1,map_mem(a0)
	move.l	new_alien_mem,map_alien_mem(a0)
	move.w	map_datasize(a0),map_allocdatasize(a0)
	move.w	map_xsize(a0),map_allocx(a0)
	move.w	map_ysize(a0),map_allocy(a0)

*reset 
	bsr	reset_all_page_positions
	clr.w	map_x_position
	clr.w	map_y_position	
	move.w	#0,current_block
	move.l	page_pointer,a0
	move.l	screen_mem(a0),current_block_mem
end_convert
	bsr	Calculate_Blocks_In_One_Page
	movem.l	(sp)+,d0-d7/a0-a6
	rts

********************************************
**     CALCULATE BLOCKS IN ONE PAGE	  **
********************************************
Calculate_Blocks_In_One_Page
*calc number of blocks in one page*
	moveq	#0,d1
	moveq	#0,d2
	move.l	#main_screen_struct,a0
	move.l	current_map_ptr,a1
	move.w	screen_x_size(a0),d1
	move.w	screen_y_size(a0),d2
	divu	map_block_size(a1),d1
	divu	map_block_size(a1),d2
	move.w	d1,num_x_blocks_in_page
	mulu	d1,d2
	move.w	d2,num_blocks_in_page
	
	move.w	#BUTTON_WINDOW_OFFSET,d0
	divu	map_block_size(a1),d0	
	move.w	d0,num_y_blocks_in_page
		
 	rts
 	
num_x_blocks_in_page
	dc.w	0
num_y_blocks_in_page
	dc.w	0	

new_alien_mem
	dc.l	0
a2_reg	dc.l	0
a3_reg	dc.l	0
a4_reg	dc.l	0
a5_reg	dc.l	0


num_blocks_in_page
	dc.w	(ScrPixelWidth/16)*(ScrPixelHeight/16)		;default
	
*****************************************
*** DISPLAY X Y                       ***
*****************************************
Display_X_Y
	tst	edit_data_flag
	bne.s	display_those_xy
	cmp.w	#1,edit_mode
	beq.s	display_those_xy
	rts
display_those_xy
	bsr	Remove_Edit_Nums
	bsr	Display_Edit_Nums
	rts
	
*******************************************
****** DISPLAY EDIT BUTTONS          ******
*******************************************
display_edit_buttons
	
	move.w	#1,show_box2		;current block box	
	move.l #edit_page_buttons,a0     ;depress current page
  	moveq	#0,d0
  	move.w current_page,d0
  	asl.w #2,d0
  	move.l (a0,d0.w),a0
  	move.b #1,button_start(a0)

	move.l #top_level_list,a0
	bsr	remove_button_list
	move.l  #edit_buttons_list,a0
	bsr	display_button_list
	bsr	display_map_on_screen
	tst.w	fullscreen_mode
	bne.s	dont_display_extras
	bsr	display_blocks_on_screen
	bsr	display_box_sprite2
dont_display_extras
	bsr	display_edit_text
	bsr	draw_current_buff_name
	bsr	Display_Selected_Block_Num
	bsr	display_edit_nums
	move.w	#ADD_BLOCK_MODE,map_function_mode
	move.w	#1,edit_mode
	rts
	
*******************************************
****** REMOVE EDIT BUTTONS           ******
*******************************************
remove_edit_buttons

	move.l  #edit_buttons_list,a0
	bsr	remove_button_list
	move.l #top_level_list,a0
	bsr	display_button_list
	bsr	clear_screen
	bsr	remove_edit_text
	bsr	remove_edit_nums
	bsr	remove_current_buff_name
	bsr	Remove_Selected_Block_Num
	move.w	#0,edit_mode
	move.w	#0,sprite_to_attach
	move.w	#0,show_box2
	bsr	position_box_sprite2
	bsr	remove_undo
	rts

edit_mode
	dc.w	0


*******************************************
****** EDIT MAP PALETTE              ******
*******************************************
edit_map_palette

	move.w	#0,sprite_to_attach
	move.w	#ADD_BLOCK_MODE,map_function_mode
	bsr	set_up_palette_window

	rts

*******************************************
****** HANDY WRITE                   ******
*******************************************
handy_write

	move.l	#button_window_struct,a0
	move.w	#(540+9*5)+2,d0
	move.w	#42,d1
	move.w	#4,d2
	move.w	#1,d4
	bsr	write_button_num
	rts

*******************************************
****** DISPLAY SELECTED BLOCK NUM    ******
*******************************************
Display_Selected_Block_Num

	move.w	#1,d4
	bsr	Display_Blk_Num
	rts

Remove_Selected_Block_Num
	move.w	#0,d4
	bsr	Display_Blk_Num
	rts
	
Display_Blk_Num	
	move.l	#button_window_struct,a0
	move.w	#440+8,d0
	move.w	#FOURTH_ROW+5,d1
	move.w	#4,d2
	move.w	current_block,d3
	bsr	write_button_num
	rts


*******************************************
****** DISPLAY EDIT NUMS             ******
*******************************************
display_edit_nums

	move.l	current_map_ptr,a0

	bsr	convert_mouse_and_store
	
	divu	map_block_size(a0),d0
	divu	map_block_size(a0),d1
	move.w	map_x_position,d3
	add.w	d0,d3
	move.w	d3,last_posx
	
	move.w	map_y_position,d2
	add.w	d1,d2
	move.w	d2,last_posy


	move.l	#button_window_struct,a0
	move.w	#(540+9*5)+2,d0
	move.w	#FIRST_ROW,d1
	move.w	#4,d2
	move.w	#1,d4
	bsr	write_button_num
	
	move.l	#button_window_struct,a0
	move.w	#(540+9*5)+2,d0
	move.w	#FIRST_ROW+11,d1
	move.w	#4,d2
	move.w	#1,d4
	move.w	last_posy,d3
	bsr	write_button_num
	rts
	
*******************************************
****** REMOVE EDIT NUMS              ******
*******************************************
remove_edit_nums

	move.l	#button_window_struct,a0
	move.w	#(540+9*5)+2,d0
	move.w	#FIRST_ROW,d1
	move.w	#4,d2
	move.w	#0,d4
	move.w	last_posx,d3
	bsr	write_button_num
	
	move.l	#button_window_struct,a0
	move.w	#(540+9*5)+2,d0
	move.w	#FIRST_ROW+11,d1
	move.w	#4,d2
	move.w	#0,d4
	move.w	last_posy,d3
	bsr	write_button_num
	rts
last_posx	dc.w	0
last_posy	dc.w	0


*******************************************
****** DISPLAY EDIT TEXT             ******
*******************************************
display_edit_text

	move.l	#button_window_struct,a0
	move.l	#edit_text,a1
	move.w	#540+9,d0
	move.w	#FIRST_ROW,d1
	move.w	#4,d2
	move.w	#1,d3
	bsr	write_button_text

	rts
	
*******************************************
****** REMOVE EDIT TEXT              ******
*******************************************
remove_edit_text

	move.l	#button_window_struct,a0
	move.l	#edit_text,a1
	move.w	#540+9,d0
	move.w	#FIRST_ROW,d1
	move.w	#4,d2
	move.w	#0,d3
	bsr	write_button_text

	rts

edit_text
	dc.b " X :",$a
	dc.b " Y :",0
	even


*******************************************
****** DISPLAY BLOCKS ON SCREEN      ******
*******************************************
display_blocks_on_screen

	tst.w	fullscreen_mode
	bne	end_display_blocks

	bsr	position_box_sprite2

	move.l  page_pointer,a0
	move.l  screen_palette(a0),a1
	bsr	setup_screen_colours

	move.l  #main_screen_struct,a2
	move.w	screen_y_pos(a0),d0
	move.w	screen_x_size(a2),d1
	asr.w	#3,d1
	mulu	d0,d1
	move.l  current_map_ptr,a4
	move.w  map_planes(a4),d7
	subq.w	#1,d7	
	move.l  screen_mem(a0),a0
        add.l   d1,a0
	move.l  screen_mem(a2),a1
	move.w  screen_x_size(a2),d1
	asr.w	#3,d1
	move.w	d1,d4
	mulu	#BUTTON_WINDOW_OFFSET-32,d4
	add.l	d4,a1	;so starts down bottom
	mulu	screen_y_size(a2),d1	;plane

copy_planes_blocks
	move.l	a0,a2	;page
	move.l	a1,a3	;screen	
	move.l	#(ScrByteWidth*32)-1,d0
copy_chunk
	move.b	(a2)+,(a3)+
	dbra	d0,copy_chunk
	add.l	d1,a0
	add.l	d1,a1
	dbra	d7,copy_planes_blocks	

	bsr	display_lines_on_screen
end_display_blocks	
	rts

*******************************************
****** DISPLAY LINES  ON SCREEN      ******
*******************************************
display_lines_on_screen

	tst.w	fullscreen_mode
	bne	dont_display_grid_lines
	tst.w	grid_on
	beq	dont_display_grid_lines
	move.l	current_map_ptr,a1
	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a0
	move.w	map_planes(a1),d5
	subq.w	#1,d5
draw_lines_planes	
	move.w	#0,d0
	move.w	#BUTTON_WINDOW_OFFSET-32,d1
	move.w	#ScrPixelWidth,d2		* FUCK
	move.w	#BUTTON_WINDOW_OFFSET-32,d3
draw_lines_down

	movem.l	d0-d5/a0-a1,-(sp)
	bsr	dark_line
	movem.l (sp)+,d0-d5/a0-a1
	add.w	map_block_size(a1),d1
	move.w	d1,d3
	cmp.w	#BUTTON_WINDOW_OFFSET,d1
	ble.s	draw_lines_down
	
	move.w	#0,d0
	move.w	#BUTTON_WINDOW_OFFSET-32,d1
	move.w	#0,d2
	move.w	#BUTTON_WINDOW_OFFSET,d3
draw_lines_across
	movem.l	d0-d5/a0-a1,-(sp)
	bsr	dark_line
	movem.l (sp)+,d0-d5/a0-a1
	add.w	map_block_size(a1),d0
	move.w  d0,d2
	cmp.w	#ScrPixelWidth,d0
	ble.s	draw_lines_across
	move.l	#main_screen_struct,a2
	move.w	screen_x_size(a2),d0
	asr.w	#3,d0
	mulu	screen_y_size(a2),d0
	add.l	d0,a0	
	dbra	d5,draw_lines_planes
dont_display_grid_lines	
	rts		
	

grid_on
	dc.w	1			;grid lines on
	
current_block
	dc.w	0	



*******************************************
****** DISPLAY MAP ON SCREEN         ******
*******************************************
display_map_on_screen

	movem.l	a6,-(sp)
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d5
	move.w	map_datasize(a0),d7
	move.w	map_xsize(a0),d1
***d1 is size of one line of map	
	asl.w	d7,d1	;mult up size of map
	
	move.w	map_y_position,d2
	mulu	d1,d2	
	
	move.w	map_x_position,d3
	asl.w	d7,d3	;x pos into map

******d0 - map data size
******d1 - one line of map

	add.l	d3,a1	; x
	add.l   d2,a1   ;top left hand corner of map
	
	move.l #main_screen_struct,a6
	moveq  #0,d0
	move.w screen_x_size(a6),d0
	move.w map_block_size(a0),d1   
	divu   d1,d0  ; blocks to draw in x axis
	move.w	d0,d5  ; d5 divide factor
	
	cmp.w	map_xsize(a0),d0
	ble.s	screen_not_bigger_than_xmap
	move.w	map_xsize(a0),d0
screen_not_bigger_than_xmap	
	subq.w	#1,d0

	move.w  max_map_screen_pos,d3
	ext.l	d3
	divu    d1,d3		;number of blocks to draw down	
	
	cmp.w	map_ysize(a0),d3
	ble.s	screen_not_bigger_than_ymap
	move.w	map_ysize(a0),d3
screen_not_bigger_than_ymap	
	subq.w	#1,d3

	
	move.l	screen_mem(a6),a3
draw_map_y_lines
	move.w	d0,d2
	move.l	a1,a2		;temp pointer for map
	move.l  a3,a4		;temp pointer for screen
draw_map_x_lines
	moveq	#0,d4
	tst	d7
	bne.s	map_word
	move.b  (a2)+,d4
	bra.s	display_block
map_word
	move.w  (a2)+,d4
display_block

	movem.l  d0,-(sp)
*------
	divu	num_blocks_in_page,d4	;div by num blocks in one page
	move.w	d4,d0		;page num to use
	clr.w	d4
	swap	d4		;new block num
	asl	#2,d0
*------	
	move.l   #picture_pages,a5		
	move.l	(a5,d0),a5	;first page
	move.l  screen_mem(a5),a5    ; page mem
	moveq	#0,d6
	tst	d4
	beq.s	no_divide
	divu	d5,d4		;divide block number by divide factor
no_divide
****value in lower d4 will be the block row number
****and the remainder will be the number of block along	
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6	;one row
	moveq	#0,d0
	move.w	d4,d0	;number of rows	
	mulu	d0,d6	;total rows down data
	add.l	d6,a5	;do	
	moveq	#0,d6
	swap	d4
	moveq	#0,d0
	move.w	d4,d0	;number of blocks in
	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	mulu	d0,d6   ;number of blocks in
	add.l	d6,a5	;position in graphic data to copy from
	
	movem.l  (sp)+,d0
	
	movem.l  a0-a1/d7,-(sp)
	
	move.w	map_planes(a0),d7	;number of planes specified by the user for map	
	move.l	a5,a0	;source - graphic page
	move.l  a4,a1	;dest	- screen

	bsr	copy_block_to_block
	
	movem.l  (sp)+,a0-a1/d7
******crasged	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	add.l	d6,a4   ;move along block in screen		
	dbra	d2,draw_map_x_lines

	moveq	#0,d6
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6
	add.l	d6,a3   ;move screen down column
	
	moveq	#0,d6
	move.w	map_xsize(a0),d6
	asl.w	d7,d6	;mult up size of map
	add.l	d6,a1		

	dbra	d3,draw_map_y_lines
	
	movem.l (sp)+,a6
	rts


********************************
**** CHANGE BLOCK PAGE     *****
********************************
change_block_page

  	move.l clicked_button,a0
  	move.b  button_data(a0),d0
manual_change_block_page  	
	ext.w	d0  	
  	subq.w	#1,d0
  	cmp.w   current_page,d0
  	bne.s   editnot_clicked_on_same_butt
  	move.b  #DEPRESSED,button_start(a0)
  	bra.s   editupdate_gr_button
editnot_clicked_on_same_butt 
	moveq	#0,d1 	
        move.w  current_page,d1
  	move.w  d0,current_page
  	
  	move.l  #edit_page_buttons,a0
  	asl.w   #2,d1
  	move.l  (a0,d1.w),a0
  	move.b  #NOT_DEPRESSED,button_start(a0)
editupdate_gr_button  	
  	bsr     remove_button
  	bsr     display_button  	
  	move.l  #picture_pages,a0
  	moveq	#0,d0
  	move.w  current_page,d0
  	asl.w	#2,d0
  	move.l  (a0,d0.w),page_pointer
  	bsr	display_blocks_on_screen
	rts
	
	
	
***************************************
****  CHANGE BLOCKS POSITION UP *****
***************************************
change_blocks_position_up

	move.l #main_screen_struct,a0
	move.w screen_y_size(a0),d0
	sub.w #32,d0   ; gives part of screen hiding (nasty hard coded!)
	move.l page_pointer,a0
	cmp.w  screen_y_pos(a0),d0
	beq.s  no_more_blocks_scroll
	move.l current_map_ptr,a1
	move.w  map_block_size(a1),d0
	add.w  d0,screen_y_pos(a0)
	bsr    display_blocks_on_screen

no_more_blocks_scroll	
	rts
	
		
******************************************
****  CHANGE BLOCKS POSITION DOWN  *****
******************************************
change_blocks_position_down
        move.l page_pointer,a0
	tst.w	screen_y_pos(a0)
	ble.s  no_more_blocks_scrolld
	move.l current_map_ptr,a1
	move.w  map_block_size(a1),d0
	sub.w   d0,screen_y_pos(a0)
	bsr    display_blocks_on_screen
no_more_blocks_scrolld	
	rts
	
map_x_position
	dc.w	0
map_y_position
	dc.w	0		
	
******************************************
****  EXECUTE MAP FUNCTION           *****
******************************************
execute_map_function
	
	move.w	mouse_y,d0
	cmp.w	max_map_screen_pos,d0
	bge.s	quit_add_data	
	bsr	test_for_out_of_bounds
	tst.l	d0
	bmi	quit_add_data
	
	moveq	#0,d0
	move.w	map_function_mode,d0
	move.l	#map_functions,a0
	add.l	d0,a0
	move.l	(a0),a0
	jsr	(a0)		;call relavant function
quit_add_data	
	rts


left_first
	dc.w	0

**************************************
******** ADD BLOCK TO MAP        *****
**************************************
add_block_to_map
	tst	left_first
	bne.s	left_hit_by_user	
	move.w	#1,left_first
	bsr	make_screen_backup
	bsr	display_undo
left_hit_by_user
	bsr	convert_mouse_and_store
	move.l	#main_screen_struct,a0
	moveq	#0,d2
	move.w	screen_x_size(a0),d2
	asr.w	#3,d2
	mulu	d2,d1
	asr.w	#3,d0
	move.l	screen_mem(a0),a1
	add.l	d1,a1
	add.l	d0,a1
	move.l	current_block_mem,a0
	move.w	current_block,d7
	bsr	put_data_into_block
	move.l	current_map_ptr,a2
	moveq	#0,d7
	move.w	map_planes(a2),d7
	bsr	copy_block_to_block
	rts
	
****************************************
****   PUT DATA INTO BLOCK         *****
****************************************	
put_data_into_block
	movem.l	a0-a2/d1-d7,-(sp)
	move.l	current_map_ptr,a2
	move.l	map_mem(a2),a0
	move.w	map_datasize(a2),d5
	
	moveq	#0,d1
	move.w	map_x_position,d1
	asl	d5,d1
	add.l	d1,a0
	move.w	map_y_position,d1
	move.w	map_xsize(a2),d6
	asl.w	d5,d6
	mulu	d6,d1	
	add.l	d1,a0	;map position
	
	bsr	convert_mouse_and_store
	
	divu	map_block_size(a2),d0
	swap	d0
	clr.w	d0
	swap	d0

	move.w	d0,d2
	add.w	map_x_position,d2
	addq.w	#1,d2
	asl	d5,d0
	add.l	d0,a0
	
	divu	map_block_size(a2),d1
	move.w	d1,d0
	add.w	map_y_position,d0
	addq.w	#1,d0
	mulu	d6,d1
	add.l	d1,a0		;got it !!!!
	
*---	
*	move.w	current_page,d1
*	mulu	num_blocks_in_page,d1		;blocks page
*	add.w	d1,d7

*----	
	
	
	tst	d5
	bne.s	word_data_map
	move.b	d7,(a0)
	bra.s	quit_place_ok
word_data_map
	move.w	d7,(a0)
quit_place_ok
	movem.l	(sp)+,a0-a2/d1-d7

	rts	
			

******************************************
****  TEST FOR OUT OF BOUNDS         *****
******************************************
test_for_out_of_bounds
	movem.l	a0-a5/d1-d7,-(sp)
	move.l	current_map_ptr,a2
	move.w	map_datasize(a2),d5
	
	moveq	#0,d1
	move.w	map_x_position,d1
	asl	d5,d1
	move.w	map_y_position,d1
	move.w	map_xsize(a2),d6
	asl.w	d5,d6
	
	bsr	convert_mouse_and_store
	
	divu	map_block_size(a2),d0
	swap	d0
	clr.w	d0
	swap	d0

	move.w	d0,d2
	add.w	map_x_position,d2
	addq.w	#1,d2
	cmp.w	map_xsize(a2),d2
	bgt.s	dont_put_data_in_out_of_bounds	
	
	divu	map_block_size(a2),d1
	move.w	d1,d0
	add.w	map_y_position,d0
	addq.w	#1,d0
	cmp.w	map_ysize(a2),d0
	bgt.s	dont_put_data_in_out_of_bounds	
	clr.l	d0
	bra.s	quit_test_bounds
dont_put_data_in_out_of_bounds
	moveq	#-1,d0
quit_test_bounds	
	movem.l	(sp)+,a0-a5/d1-d7
	rts


right_first
	dc.w	0
******************************************
****  DELETE MAP BLOCK               *****
******************************************
delete_map_block
	cmp.w	#ADD_BLOCK_MODE,map_function_mode
	beq.s	ok_in_right_mode
	move.w	#0,sprite_to_attach
	move.w	#ADD_BLOCK_MODE,map_function_mode
***wait for mouse button to come back up
wait_for_release
	btst	#10,$dff016
	beq.s	wait_for_release	
	rts	;have reset back to default edit mode
ok_in_right_mode
	move.w	mouse_y,d2	
	cmp.w	max_map_screen_pos,d2
	bge.s	quit_del_data	
	bsr	test_for_out_of_bounds
	tst.l	d0
	bmi	quit_del_data
	tst	right_first
	bne.s	right_down_by_user
	move.w	#1,right_first
	bsr	make_screen_backup
	bsr	display_undo
right_down_by_user	
	bsr	convert_mouse_and_store
	move.l	#main_screen_struct,a0
	moveq	#0,d2
	move.w	screen_x_size(a0),d2
	asr.w	#3,d2
	mulu	d2,d1
	asr.w	#3,d0
	move.l	screen_mem(a0),a1
	add.l	d1,a1
	add.l	d0,a1
	
	move.l	delete_block_mem,a0
	move.l	current_map_ptr,a2
	move.w	delete_block,d7
 	bsr	put_data_into_block
 	move.w	map_planes(a2),d7
	bsr	copy_block_to_block
quit_del_data	
	rts	



******************************************
****  update_current_block           *****
******************************************
update_current_block
	bsr	Remove_Selected_Block_Num
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d4
	moveq	#0,d5
	move.w	mouse_x,d0
	move.w	mouse_y,d1
	move.l	page_pointer,a0
	sub.w	max_map_screen_pos,d1
	add.w	screen_y_pos(a0),d1
	move.l	current_map_ptr,a1
	move.w	map_block_size(a1),d3
	cmp.w	#8,d3
	bne.s	current_block16
	andi.w	#$fff8,d0
	move.w	d0,d5
	andi.w	#$fff8,d1
	move.w	d1,d4
	asr.w	#3,d1
	asr.w	#3,d0
	bra.s	store_current_block
current_block16	
	cmp.w	#16,d3
	bne.s	current_block32
	andi.w	#$fff0,d0
	move.w	d0,d5
	andi.w	#$fff0,d1
	move.w	d1,d4
	asr.w	#4,d1
	asr.w	#4,d0
	bra.s	store_current_block		
current_block32	
	andi.w	#$ffe0,d0
	move.w	d0,d5
	andi.w	#$ffe0,d1
	move.w	d1,d4
	asr.w	#5,d1
	asr.w	#5,d0
store_current_block
	mulu	num_x_blocks_in_page,d1	;calc blocks down
	add.w	d0,d1
	move.w	d1,current_block

	
	move.w	num_blocks_in_page,d0	
	mulu	current_page,d0
	add.w	d0,current_block
	
****test if block > map data
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d0
	asr.w	#3,d0
	mulu	d0,d4
	asr.w	#3,d5
	add.l	d5,d4
	move.l	screen_mem(a0),a0
	add.l	d4,a0
	move.l	a0,current_block_mem	
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num
	rts	

******************************************
****  CONVERT BLOCK NUMBER TO MEMORY *****
******************************************
convert_block_number_to_memory
	moveq	#0,d0
	move.w	current_block,d0
	bsr	Get_Block_Mem_Pos	
	move.l	a2,current_block_mem									
	rts		

**********************************************
****CONVERT DELETE BLOCK NUMBER TO MEMORY*****
**********************************************
convert_delete_block_number_to_memory
	moveq	#0,d0
	move.w	delete_block,d0
	bsr	Get_Block_Mem_Pos	
	move.l	a2,delete_block_mem										
	rts		

**********************************************
****  GET BLOCK MEM POS                  *****
**********************************************

Get_Block_Mem_Pos
*Send in d0 returns a2
	clr.l	d1
	move.w	num_blocks_in_page,d1
	divu	d1,d0
	move.w	d0,d1		;number of pages
	clr.w	d0
	swap	d0		;remainder into page
	
	lsl.w	#2,d1
	move.l	#picture_pages,a0
	move.l	(a0,d1),a0
	move.l	screen_mem(a0),a2

	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d2
	asr.w	#3,d2	;number of bytes per row
	
	moveq	#0,d1	
	move.l	current_map_ptr,a1
	cmp.w	#8,map_block_size(a1)
	beq.s	rs40
	cmp.w	#16,map_block_size(a1)
	beq.s	rs20

	divu	num_x_blocks_in_page,d0
	swap	d0
	move.w	d0,d1
	swap	d0
	asl	#2,d1
	asl.w	#5,d0	;get size of one line
	bra.s	convert_to_mem

rs40	divu	num_x_blocks_in_page,d0
	swap	d0
	move.w	d0,d1
	swap	d0
	asl.w	#3,d0	;get size of one line

	bra.s	convert_to_mem

rs20	divu	num_x_blocks_in_page,d0
	swap	d0
	move.w	d0,d1
	swap	d0
	asl	d1
	asl.w	#4,d0	;get size of one line
convert_to_mem
	mulu	d2,d0	;row start
	add.l	d0,a2 
	add.l	d1,a2
	rts

current_block_mem
	dc.l	0
current_block_x
	dc.w	0
current_block_y 
	dc.w	0		
	
******************************************
****  SCROLL MAP DOWN                *****
******************************************
scroll_map_down
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	current_map_ptr,a0
	move.w	max_map_screen_pos,d0
	ext.l	d0
	divu	map_block_size(a0),d0
	add.w	map_y_position,d0
	cmp.w	map_ysize(a0),d0
	bge	no_scroll_map_down
;	bsr	sync				** RE-ADDED
	addq.w	#1,map_y_position
	moveq	#0,d2
	move.l	#main_screen_struct,a0
	move.l	current_map_ptr,a1
	
	move.w	map_block_size(a1),d4
	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	sub.w	d4,d2
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	mulu	d0,d5		;num to next planes
	mulu	d0,d4		;chunk to move down
	asr.w	d0
	add.w	d0,d2		;d2 = blit size
	
	
	move.w	map_planes(a1),d1
	subq.w	#1,d1

	move.w	#$8400,dmacon(a6)		* blitnasty
scroll_map_loop	
	btst	#14,DMACONR(a6)
	bne.s	scroll_map_loop
	move.w	#$0400,dmacon(a6)		* no blitnasty

	move.l	a2,bltdpt(a6)	
	move.l	a2,a3
	add.l	d4,a3
	move.l	a3,bltapt(a6)
	clr.w	bltamod(a6)
	clr.w	bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09f00000,bltcon0(a6)
	move.w	d2,bltsize(a6)
	
	add.l	d5,a2
	dbra	d1,scroll_map_loop	
	bsr	copy_blocks_bottom
no_scroll_map_down	
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts
	
	
******************************************
****  SCROLL MAP UP                  *****
******************************************
scroll_map_up
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	tst	map_y_position
	beq	no_scroll_up_map
;	bsr	sync				* RE-ADDED
	subq.w	#1,map_y_position
	moveq	#0,d2
	move.l	#main_screen_struct,a0
	move.l	current_map_ptr,a1
	
	move.w	map_block_size(a1),d4
	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	sub.w	d4,d2
	move.w	d2,d6
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	mulu	d0,d5		;num to next planes
	mulu	d0,d4		;chunk to move down
	mulu	d0,d6
	asr.w	d0
	add.w	d0,d2		;d2 = blit size

	add.l	d6,a2
	subq.l	#2,a2		
	
	move.w	map_planes(a1),d1
	subq.w	#1,d1
	move.w	#$8400,dmacon(a6)		* no blitnasty
scroll_map_loop_up	
	btst	#14,DMACONR(a6)
	bne.s	scroll_map_loop_up
	move.w	#$0400,dmacon(a6)		* no blitnasty
	move.l	a2,bltapt(a6)	
	move.l	a2,a3
	add.l	d4,a3
	move.l	a3,bltdpt(a6)
	clr.w	bltamod(a6)
	clr.w	bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09f00002,bltcon0(a6)
	move.w	d2,bltsize(a6)
	add.l	d5,a2
	dbra	d1,scroll_map_loop_up
***copy block line
	bsr	copy_blocks_top
no_scroll_up_map
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts			
	
******************************************
****  SCROLL MAP RIGHT                *****
******************************************
scroll_map_RIGHT
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	tst	map_x_position
	beq	no_scroll_right_map
;	jsr	sync				* RE-ADDED
	subq.w	#1,map_x_position
	move.l	#main_screen_struct,a0
	move.l	current_map_ptr,a1
	cmp.w	#8,map_block_size(a1)
	beq	scroll_right_8
	moveq	#0,d2
	moveq	#0,d6
	move.w	map_block_size(a1),d4
	move.w	d4,d6
	divu	#16,d6	;bottom half will be number of words in
	swap	d6
	move.w	d6,d7	;d7 is pixel shift to right
	ror.w	#4,d7
	ori.w	#$09f0,d7  ;terms 
	swap	d7
	move.w	#2,d7	;set decending
	move.w	#0,d6
	swap	d6
			
	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	move.w	d0,d3
	mulu	d0,d5		;num to next planes
	asr.w	d0
	sub.w	d6,d0		;minus shift size
	add.w	d0,d2		;d2 = blit size

	asl.w	d6		;to give bytes	
	move.w	max_map_screen_pos,d4
	mulu	d3,d4	
	add.l	d4,a2
	sub.l	#2,a2		;put at bottom
	sub.l	d6,a2		;start in
	move.w	map_planes(a1),d1
	subq.w	#1,d1
	move.w	#$8400,dmacon(a6)		* no blitnasty
scroll_map_loop_right	
	btst	#14,DMACONR(a6)
	bne.s	scroll_map_loop_right
	move.w	#$0400,dmacon(a6)		* no blitnasty
	move.l	a2,bltapt(a6)	
	move.l	a2,a3
	add.l	d6,a3
	move.l	a3,bltdpt(a6)
	move.w	d6,bltamod(a6)
	move.w	d6,bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	d7,bltcon0(a6)
	move.w	d2,bltsize(a6)
	add.l	d5,a2
	dbra	d1,scroll_map_loop_right
***copy block line
	bsr	copy_blocks_left
no_scroll_right_map
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts			


scroll_right_8
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	mulu	d0,d5		;num to next planes
	asr.w	d0
	add.w	d0,d2		;d2 = blit size

	move.w	map_planes(a1),d1
	subq.w	#1,d1
	move.w	#$8400,dmacon(a6)		* no blitnasty
scroll8_map_loop_right	
	btst	#14,DMACONR(a6)
	bne.s	scroll8_map_loop_right
	move.w	#$0400,dmacon(a6)		* no blitnasty
	move.l	a2,bltapt(a6)	
	move.l	a2,bltdpt(a6)
	move.w	#0,bltamod(a6)
	move.w	#0,bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$89f00000,bltcon0(a6)
	move.w	d2,bltsize(a6)
	add.l	d5,a2
	dbra	d1,scroll8_map_loop_right
	bsr	copy_blocks_left
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts

******************************************
****  SCROLL MAP LEFT                *****
******************************************
scroll_map_left
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	current_map_ptr,a1
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	divu	map_block_size(a1),d0
	add.w	map_x_position,d0
	cmp.w	map_xsize(a1),d0
	bge	no_scroll_left_map
;	jsr	sync				* RE-ADDED
	addq.w	#1,map_x_position
	move.l	current_map_ptr,a1
	moveq	#0,d2
	move.l	#main_screen_struct,a0
	cmp.w	#8,map_block_size(a1)
	beq	shift_by_8_pixels	
	moveq	#0,d6
	move.w	map_block_size(a1),d4
	move.w	d4,d6
	divu	#16,d6	;bottom half will be number of words in
	swap	d6
	move.w	d6,d7	;d7 is pixel shift to right
	ror.w	#4,d7
	ori.w	#$09f0,d7  ;terms 
	swap	d7
	move.w	#0,d7
	move.w	#0,d6
	swap	d6		
	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	mulu	d0,d5		;num to next planes
	asr.w	d0
	sub.w	d6,d0		;minus shift size
	add.w	d0,d2		;d2 = blit size

	asl.w	d6		;to give bytes	
	move.w	map_planes(a1),d1
	subq.w	#1,d1
	move.w	#$8400,dmacon(a6)		* no blitnasty
scroll_map_loop_left
	btst	#14,DMACONR(a6)
	bne.s	scroll_map_loop_left
	move.w	#$0400,dmacon(a6)		* no blitnasty
	move.l	a2,bltdpt(a6)	
	move.l	a2,a3
	add.l	d6,a3
	move.l	a3,bltapt(a6)
	move.w	d6,bltamod(a6)
	move.w	d6,bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	d7,bltcon0(a6)
	move.w	d2,bltsize(a6)
	add.l	d5,a2
	dbra	d1,scroll_map_loop_left
***copy block line
	bsr	copy_blocks_right
no_scroll_left_map
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts			

shift_by_8_pixels
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	screen_mem(a0),a2
	move.w	screen_x_size(a0),d0
	move.w	max_map_screen_pos,d2
	move.w	screen_y_size(a0),d5
	asl.w	#6,d2
	asr.w	#3,d0
	move.w	max_map_screen_pos,d3
	mulu	d0,d3
	add.l	d3,a2
	subq.l	#2,a2
	mulu	d0,d5		;num to next planes
	asr.w	d0
	add.w	d0,d2		;d2 = blit size

	move.w	map_planes(a1),d1
	subq.w	#1,d1
	move.w	#$8400,dmacon(a6)		* no blitnasty
scroll8_map_loop_left
	btst	#14,DMACONR(a6)
	bne.s	scroll8_map_loop_left
	move.w	#$0400,dmacon(a6)		* no blitnasty
	move.l	a2,bltapt(a6)	
	move.l	a2,bltdpt(a6)
	move.w	#0,bltamod(a6)
	move.w	#0,bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$89f00002,bltcon0(a6)
	move.w	d2,bltsize(a6)
	add.l	d5,a2
	dbra	d1,scroll8_map_loop_left
	bsr	copy_blocks_right
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts

******************************************
****  WAIT BLIT FIN                  *****
******************************************
wait_blit_fin
	move.w	#$8400,dmacon(a6)		* blitnasty
.waitin	btst	#14,dmaconr(a6)
	bne.s	.waitin
	move.w	#$0400,dmacon(a6)		* no blitnasty
	rts
	
******************************************
****  COPY BLOCKS BOTTOM             *****
******************************************
		
copy_blocks_bottom	
	
	bsr	wait_blit_fin		
	movem.l	a6,-(sp)
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	move.w	map_datasize(a0),d7
	move.w	map_xsize(a0),d1
	asl.w	d7,d1	;mult up size of map
	
	move.w	map_y_position,d2
	move.w	max_map_screen_pos,d3
	ext.l	d3
	divu	map_block_size(a0),d3
	subq.w	#1,d3
	add.w	d3,d2	;add so bottom line is being used
	moveq	#0,d3
	mulu	d1,d2	
	move.w	map_x_position,d3
	asl.w	d7,d3	;x pos into map
	add.l	d3,a1	; x
	add.l   d2,a1   ;top left hand corner of map
	
	move.l #main_screen_struct,a6
	moveq  #0,d0
	move.w screen_x_size(a6),d0
	move.w	d0,d6
	move.w map_block_size(a0),d1   
	divu   d1,d0  ; blocks to draw in x axis
	move.w	d0,d5  ; d5 divide factor

	move.l	screen_mem(a6),a3
	move.w	max_map_screen_pos,d2
	sub.w	d1,d2
	asr.w	#3,d6
	mulu	d6,d2
	add.l	d2,a3	;move it down to bottom of blocks
	
	move.w	d0,d2
	cmp.w	map_xsize(a0),d2
	ble.s	not_bigger_bottom
	move.w	map_xsize(a0),d2
not_bigger_bottom
	subq.w	#1,d2

	move.l	a1,a2		;temp pointer for map
	move.l  a3,a4		;temp pointer for screen
scroll_updraw_map_x_lines
	moveq	#0,d4
	tst	d7
	bne.s	scumap_word
	move.b  (a2)+,d4
	bra.s	scudisplay_block
scumap_word
	move.w  (a2)+,d4
scudisplay_block

*------
	moveq	#0,d6
	divu	num_blocks_in_page,d4	;div by num blocks in one page
	move.w	d4,d6		;page num to use
	clr.w	d4
	swap	d4		;new block num
	asl	#2,d6
*------	

	move.l   #picture_pages,a5		
	move.l	(a5,d6),a5	;first page
	move.l  screen_mem(a5),a5    ; page mem
	moveq	#0,d6
	tst	d4
	beq.s	scuno_divide
	divu	d5,d4		;divide block number by divide factor
scuno_divide
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6	;one row
	moveq	#0,d0
	move.w	d4,d0	;number of rows	
	mulu	d0,d6	;total rows down data
	add.l	d6,a5	;do	
	moveq	#0,d6
	swap	d4
	moveq	#0,d0
	move.w	d4,d0	;number of blocks in
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	mulu	d0,d6   ;number of blocks in
	add.l	d6,a5	;position in graphic data to copy from
	movem.l  a0-a1/d7,-(sp)
	move.w	map_planes(a0),d7	;number of planes specified by the user for map	
	move.l	a5,a0	;source - graphic page
	move.l  a4,a1	;dest	- screen
	bsr	copy_block_to_block
	movem.l  (sp)+,a0-a1/d7	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	add.l	d6,a4   ;move along block in screen		
	dbra	d2,scroll_updraw_map_x_lines
	movem.l (sp)+,a6
	rts


******************************************
****  COPY BLOCKS TOP                *****
******************************************
copy_blocks_top		
***copy blocks in gap	
	bsr	wait_blit_fin					
	movem.l	a6,-(sp)
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	move.w	map_datasize(a0),d7
	move.w	map_xsize(a0),d1
	asl.w	d7,d1	;mult up size of map
	move.w	map_y_position,d2
	mulu	d1,d2	
	moveq	#0,d3
	move.w	map_x_position,d3
	asl.w	d7,d3	;x pos into map
	add.l	d3,a1	; x
	add.l   d2,a1   ;top left hand corner of map
	
	move.l #main_screen_struct,a6
	moveq  #0,d0
	move.w screen_x_size(a6),d0
	move.w map_block_size(a0),d1   
	divu   d1,d0  ; blocks to draw in x axis
	move.w	d0,d5  ; d5 divide factor

	move.l	screen_mem(a6),a3
	move.w	d0,d2
	cmp.w	map_xsize(a0),d2
	ble.s	not_bigger_top
	move.w	map_xsize(a0),d2
not_bigger_top
	subq.w	#1,d2

	move.l	a1,a2		;temp pointer for map
	move.l  a3,a4		;temp pointer for screen
scroll_downdraw_map_x_lines
	moveq	#0,d4
	tst	d7
	bne.s	scdmap_word
	move.b  (a2)+,d4
	bra.s	scddisplay_block
scdmap_word
	move.w  (a2)+,d4
scddisplay_block

*------
	moveq	#0,d6
	divu	num_blocks_in_page,d4	;div by num blocks in one page
	move.w	d4,d6		;page num to use
	clr.w	d4
	swap	d4		;new block num
	asl	#2,d6
*------	

	move.l   #picture_pages,a5		
	move.l	(a5,d6),a5	;first page
	move.l  screen_mem(a5),a5    ; page mem
	moveq	#0,d6
	tst	d4
	beq.s	scdno_divide
	ext.l	d5
	divu	d5,d4		;divide block number by divide factor
scdno_divide
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6	;one row
	moveq	#0,d0
	move.w	d4,d0	;number of rows	
	mulu	d0,d6	;total rows down data
	add.l	d6,a5	;do	
	moveq	#0,d6
	swap	d4
	moveq	#0,d0
	move.w	d4,d0	;number of blocks in
	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	mulu	d0,d6   ;number of blocks in
	add.l	d6,a5	;position in graphic data to copy from
	
	movem.l  a0-a1/d7,-(sp)
	
	move.w	map_planes(a0),d7	;number of planes specified by the user for map	
	move.l	a5,a0	;source - graphic page
	move.l  a4,a1	;dest	- screen
	bsr	copy_block_to_block
	movem.l  (sp)+,a0-a1/d7	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	add.l	d6,a4   ;move along block in screen		
	dbra	d2,scroll_downdraw_map_x_lines
	movem.l (sp)+,a6


	rts
	
	
*******************************************
****** COPY BLOCKS LEFT              ******
*******************************************
copy_blocks_left
	bsr	wait_blit_fin
	movem.l	a6,-(sp)
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d5
	move.w	map_datasize(a0),d7
	move.w	map_xsize(a0),d1
	asl.w	d7,d1	;mult up size of map
	
	move.w	map_y_position,d2
	mulu	d1,d2	
	
	moveq	#0,d3
	move.w	map_x_position,d3
	asl.w	d7,d3	;x pos into map

	add.l	d3,a1	; x
	add.l   d2,a1   ;top left hand corner of map
	
	move.l #main_screen_struct,a6
	moveq  #0,d0
	move.w screen_x_size(a6),d0
	move.w map_block_size(a0),d1   
	divu   d1,d0  ; blocks to draw in x axis
	move.w	d0,d5  ; d5 divide factor
	subq.w	#1,d0

	move.w  max_map_screen_pos,d3
	ext.l	d3
	divu    d1,d3		;number of blocks to draw down	
	cmp.w	map_ysize(a0),d3
	ble.s	not_bigger_left
	move.w	map_ysize(a0),d3
not_bigger_left
	subq.w	#1,d3

	
	move.l	screen_mem(a6),a3
bldraw_map_y_lines
	;move.w	d0,d2
	move.l	a1,a2		;temp pointer for map
	move.l  a3,a4		;temp pointer for screen
bldraw_map_x_lines
	moveq	#0,d4
	tst	d7
	bne.s	blmap_word
	move.b  (a2)+,d4
	bra.s	bldisplay_block
blmap_word
	move.w  (a2)+,d4
bldisplay_block

	movem.l  d0,-(sp)
	
*------
	moveq	#0,d6
	divu	num_blocks_in_page,d4	;div by num blocks in one page
	move.w	d4,d6		;page num to use
	clr.w	d4
	swap	d4		;new block num
	asl	#2,d6
*------	
	
	
	move.l   #picture_pages,a5		
	move.l	(a5,d6),a5	;first page
	move.l  screen_mem(a5),a5    ; page mem
	moveq	#0,d6
	tst	d4
	beq.s	blno_divide
	divu	d5,d4		;divide block number by divide factor
blno_divide

	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6	;one row
	moveq	#0,d0
	move.w	d4,d0	;number of rows	
	mulu	d0,d6	;total rows down data
	add.l	d6,a5	;do	
	moveq	#0,d6
	swap	d4
	moveq	#0,d0
	move.w	d4,d0	;number of blocks in
	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	mulu	d0,d6   ;number of blocks in
	add.l	d6,a5	;position in graphic data to copy from
	
	movem.l  (sp)+,d0
	
	movem.l  a0-a1/d7,-(sp)
	
	move.w	map_planes(a0),d7	;number of planes specified by the user for map	
	move.l	a5,a0	;source - graphic page
	move.l  a4,a1	;dest	- screen

	bsr	copy_block_to_block
	
	movem.l  (sp)+,a0-a1/d7
	moveq	#0,d6
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6
	add.l	d6,a3   ;move screen down column
	
	moveq	#0,d6
	move.w	map_xsize(a0),d6
	asl.w	d7,d6	;mult up size of map
	add.l	d6,a1		

	dbra	d3,bldraw_map_y_lines
	
	movem.l (sp)+,a6
	rts



*******************************************
****** COPY BLOCKS RIGHT              ******
*******************************************
copy_blocks_right
	
	bsr	wait_blit_fin
	movem.l	a6,-(sp)
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	move.l	#main_screen_struct,a6
	moveq	#0,d0
	move.w	screen_x_size(a6),d0
	divu	map_block_size(a0),d0
	move.w	map_datasize(a0),d1
	swap	d0
	clr.w	d0
	swap	d0
	subq.w  #1,d0
	asl.w	d1,d0
	add.l	d0,a1	;so pointing to blocks far left
	
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	move.w	map_datasize(a0),d7
	move.w	map_xsize(a0),d1
	asl.w	d7,d1	;mult up size of map
	
	move.w	map_y_position,d2
	mulu	d1,d2	
	
	moveq	#0,d3
	move.w	map_x_position,d3
	asl.w	d7,d3	;x pos into map
	add.l	d3,a1	; x
	add.l   d2,a1   ;top left hand corner of map
	
	moveq  #0,d0
	move.w screen_x_size(a6),d0
	move.w map_block_size(a0),d1   
	ext.l	d0
	divu   d1,d0  ; blocks to draw in x axis
	move.w	d0,d5  ; d5 divide factor
	subq.w	#1,d0

	move.w  max_map_screen_pos,d3
	ext.l	d3
	divu    d1,d3		;number of blocks to draw down	
	cmp.w	map_ysize(a0),d3
	ble.s	not_bigger_right
	move.w	map_ysize(a0),d3
not_bigger_right	
	subq.w	#1,d3

	
	moveq	#0,d2
	move.l	screen_mem(a6),a3
	move.w	screen_x_size(a6),d2
	asr.w	#3,d2
	move.w	map_block_size(a0),d4
	asr.w	#3,d4
	sub.w	d4,d2
	add.l	d2,a3
	
brdraw_map_y_lines
	move.l	a1,a2		;temp pointer for map
	move.l  a3,a4		;temp pointer for screen
brdraw_map_x_lines
	moveq	#0,d4
	tst	d7
	bne.s	brmap_word
	move.b  (a2)+,d4
	bra.s	brdisplay_block
brmap_word
	move.w  (a2)+,d4
brdisplay_block
	movem.l  d0,-(sp)
	
*------
	moveq	#0,d6
	divu	num_blocks_in_page,d4	;div by num blocks in one page
	move.w	d4,d6		;page num to use
	clr.w	d4
	swap	d4		;new block num
	asl	#2,d6
*------	
	
	
	move.l   #picture_pages,a5		
	move.l	(a5,d6),a5	;first page
	move.l  screen_mem(a5),a5    ; page mem
	moveq	#0,d6
	tst	d4
	beq.s	brno_divide
	divu	d5,d4		;divide block number by divide factor
brno_divide
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6	;one row
	moveq	#0,d0
	move.w	d4,d0	;number of rows	
	mulu	d0,d6	;total rows down data
	add.l	d6,a5	;do	
	moveq	#0,d6
	swap	d4
	moveq	#0,d0
	move.w	d4,d0	;number of blocks in
	
	moveq	#0,d6
	move.w	d1,d6
	asr.w	#3,d6	;get block size into bytes
	mulu	d0,d6   ;number of blocks in
	add.l	d6,a5	;position in graphic data to copy from
	
	movem.l  (sp)+,d0
	
	movem.l  a0-a1/d7,-(sp)
	
	move.w	map_planes(a0),d7	;number of planes specified by the user for map	
	move.l	a5,a0	;source - graphic page
	move.l  a4,a1	;dest	- screen

	bsr	copy_block_to_block
	
	movem.l  (sp)+,a0-a1/d7
	moveq	#0,d6
	move.w	screen_x_size(a6),d6
	asr.w	#3,d6
	mulu	d1,d6
	add.l	d6,a3   ;move screen down column
	
	moveq	#0,d6
	move.w	map_xsize(a0),d6
	asl.w	d7,d6	;mult up size of map
	add.l	d6,a1		

	dbra	d3,brdraw_map_y_lines
	
	movem.l (sp)+,a6
	rts

*******************************************
****** INSERT MAP ROW                ******
*******************************************
insert_map_row

	move.w	#INSERT_ROW_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	rts


*******************************************
****** DELETE MAP ROW                ******
*******************************************
delete_map_row

	move.w	#DELETE_ROW_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	rts


*******************************************
****** INSERT MAP COLUMN             ******
*******************************************
insert_map_column

	move.w	#INSERT_COL_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	rts
	
*******************************************
****** DELETE MAP COLUMN             ******
*******************************************
delete_map_column

	move.w	#DELETE_COL_MODE,map_function_mode
	move.w	#PICK,sprite_to_attach
	rts


*******************************************
****** FILL MAP                      ******
*******************************************
fill_map

	move.w	#FILL_WITH_BLOCK,map_function_mode
	move.w	#PICK,sprite_to_attach
	rts

*******************************************
****** INSERT MAP ROW FUNCTION       ******
*******************************************
insert_map_row_function
	bsr	remove_undo 
	bsr	convert_mouse_and_store
	
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d1
	move.w	map_ysize(a0),d3	;map y size
	add.w	map_y_position,d1	;number of lines down
	move.w	map_datasize(a0),d0
	moveq	#0,d2
	move.w	map_xsize(a0),d2
	asl.w	d0,d2			;size of one line
	
	move.l	map_mem(a0),a1
	move.w	d2,d4
	move.w	d3,d7
	subq.w	#1,d7
	mulu	d7,d4			;get to bottom of map
	add.l	d4,a1			;map mem position
	move.l	a1,a2
	sub.l	d2,a2			;line to copy from
	
	sub.w	d1,d3			;number of lines to shift
	subq.w	#1,d3			;sub another one as we lose a line 
*	                                ;as we are copying from the line above 
*	                                ;to the line below
	beq.s	dont_shift_anything	;nothing to shift
insert_row_y	
	move.w	d2,d4
	subq.w	#1,d4		        ;size of x line in bytes

	move.l	a1,a3			;dest
	move.l	a2,a4			;source
insert_row_x
	move.b	(a4),(a3)+
	tst	d3
	bne.s	not_last_line_shifted
	clr.b	(a4)+
	bra.s	shift_cols_up
not_last_line_shifted	
	addq.l	#1,a4
shift_cols_up	
	dbra	d4,insert_row_x			
	
	sub.l	d2,a1
	sub.l	d2,a2
	dbra	d3,insert_row_y
				
	bsr	display_map_on_screen
dont_shift_anything	
	rts
	
	
*******************************************
****** DELETE MAP ROW FUNCTION       ******
*******************************************
delete_map_row_function

	bsr	remove_undo	 
	bsr	convert_mouse_and_store
	
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d1
	move.w	map_ysize(a0),d3	;map y size
	add.w	map_y_position,d1	;number of lines down
	move.w	map_datasize(a0),d0
	moveq	#0,d2
	move.w	map_xsize(a0),d2
	asl.w	d0,d2			;size of one line
	
	move.l	map_mem(a0),a1
	move.w	d1,d4
	mulu	d2,d4			;get to position in map
	add.l	d4,a1			;map mem position
	move.l	a1,a2
	add.l	d2,a2			;line to copy to
	
	sub.w	d1,d3			;number of lines to shift
	subq.w	#2,d3			
	bmi.s	dont_delete_anything	;nothing to shift
delete_row_y	
	move.w	d2,d4
	subq.w	#1,d4		        ;size of x line in bytes

	move.l	a1,a3			;dest
	move.l	a2,a4			;source
delete_row_x
	move.b	(a4)+,(a3)+
	dbra	d4,delete_row_x			
	
	add.l	d2,a1
	add.l	d2,a2
	dbra	d3,delete_row_y
dont_delete_anything		
	subq.w	#1,d2
delete_last_line_in_map
	clr.b	(a1)+
	dbra	d2,delete_last_line_in_map	
		
	bsr	display_map_on_screen
	rts
	
*******************************************
****** DELETE MAP COLUMN FUNCTION    ******
*******************************************
delete_map_column_function

	bsr	remove_undo
	bsr	convert_mouse_and_store
	
	moveq	#0,d1
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d0
	add.w	map_x_position,d0	;x position in map
	move.w	map_datasize(a0),d1
	move.w	map_ysize(a0),d2	;number of lines to do
	move.w	map_xsize(a0),d3
	move.w	d3,d4
	asl	d1,d3			;one line of map
	
	moveq	#0,d5
	move.w	d0,d5
	asl	d1,d5
	move.l	map_mem(a0),a1
	add.l	d5,a1			;start position (dest)
	move.l	a1,a2
	move.w	#1,d5
	asl	d1,d5
	add.l	d5,a2			;source
	sub.w	d0,d4			;no. blocks to shift
	subq.w	#2,d4
	bmi	dont_delete_col

	asl	d1,d4			;if word map convert to bytes
	subq.w	#1,d2			;y lines to do
delete_y_col
	move.w	d4,d6
	move.l	a1,a3
	move.l	a2,a4
delete_x_col			
	move.b	(a4)+,(a3)+
	dbra	d6,delete_x_col
	add.l	d3,a1
	add.l	d3,a2
	dbra	d2,delete_y_col	
dont_delete_col	

*****delete last line of blocks in data
	move.l	map_mem(a0),a1
	moveq	#0,d0
	move.w	map_xsize(a0),d0
	asl.w	d1,d0
	add.l	d0,a1
	subq.l	#1,a1
	move.w	map_ysize(a0),d2
	subq.w	#1,d2
	sub.l	d1,a1	;if word sub one byte
blank_out_end_bits
	tst	d1
	beq.s	 map_blank_byte
	move.w	#0,(a1)
	bra.s	fetch_other_line
map_blank_byte
	move.b	#0,(a1)
fetch_other_line
	add.l	d3,a1
	dbra	d2,blank_out_end_bits	
		
	bsr	display_map_on_screen

	rts

******************************************
****** INSERT MAP COLUMN FUNCTION    ******
*******************************************
insert_map_column_function

	bsr	remove_undo
	bsr	convert_mouse_and_store
	
	moveq	#0,d1
	move.l	current_map_ptr,a0
	divu	map_block_size(a0),d0
	add.w	map_x_position,d0	;x position in map
	move.w	map_datasize(a0),d1
	move.w	map_ysize(a0),d2	;number of lines to do
	move.w	map_xsize(a0),d3
	move.w	d3,d4
	asl	d1,d3			;one line of map
	
	move.l	map_mem(a0),a1
	add.l	d3,a1			;start position (dest)
	subq.l	#1,a1			;move back onto last byte
	move.l	a1,a2
	subq.l	#1,a2
*	tst	d1
*	beq.s	done_all_offsets
	sub.l	d1,a2
*done_all_offsets
	sub.w	d0,d4			;no. blocks to shift
	subq.w	#2,d4
	bmi	dont_insert_col

	asl	d1,d4			;if word map convert to bytes
	subq.w	#1,d2			;y lines to do
insert_y_col
	move.w	d4,d6
	move.l	a1,a3
	move.l	a2,a4
insert_x_col			
	move.b	(a4),(a3)
	subq.l	#1,a4
	subq.l	#1,a3
	dbra	d6,insert_x_col
	add.l	d3,a1
	add.l	d3,a2
	dbra	d2,insert_y_col	
dont_insert_col	

*****delete line of blocks in data
	move.l	map_mem(a0),a1
	asl	d1,d0
	add.l	d0,a1
	move.w	map_ysize(a0),d2
	subq.w	#1,d2
blank_out_end_bits_ins
	tst	d1
	beq.s	 map_blank_byte_ins
	move.w	#0,(a1)
	bra.s	fetch_other_line_ins
map_blank_byte_ins
	move.b	#0,(a1)
fetch_other_line_ins
	add.l	d3,a1
	dbra	d2,blank_out_end_bits_ins


	bsr	display_map_on_screen

	rts



	

*******************************************
****** RESET SPRITE AND MODE         ******
*******************************************
reset_sprite_and_mode

	move.w	#0,sprite_to_attach
	move.w	#ADD_BLOCK_MODE,map_function_mode
	rts

ADD_BLOCK_MODE	EQU 0
INSERT_ROW_MODE EQU 4
INSERT_COL_MODE EQU 8
DELETE_ROW_MODE EQU 12
DELETE_COL_MODE EQU 16
FILL_WITH_BLOCK EQU 20
COPYCUT_BLOCK_MODE EQU 24
PASTE_BLOCK_MODE EQU 28
PICK_BUFF_MODE EQU 32


map_function_mode
	dc.w	ADD_BLOCK_MODE	;always default
	
map_functions
	dc.l	add_block_to_map
	dc.l	insert_map_row_function
	dc.l	insert_map_column_function		
	dc.l	delete_map_row_function
	dc.l	delete_map_column_function
	dc.l	fill_block_function
	dc.l	get_buffer_box
	dc.l	paste_hold_to_map
	
	
	
remove_undo
	tst	undo_on
	beq.s	no_rem_undo
	move.l	#edit_undo_button,a0
	bsr	remove_button
no_rem_undo
	move.w	#0,undo_on	
	rts
	
display_undo
	tst	undo_on
	bne.s	no_dis_undo	
	move.l	#edit_undo_button,a0
	bsr	display_button
no_dis_undo	
	move.w	#1,undo_on
	rts
		
undo_on
	dc.w	0	
	
