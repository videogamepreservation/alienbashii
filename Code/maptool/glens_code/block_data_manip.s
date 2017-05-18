*----------------------------------------------------*
*--- Routines to handle block data manipulation   ---*
*----------------------------------------------------*

*** Note at present the block manipulation routines are
*** set up to deal with 16 pixel blocks for ABII,the 
*** code is therefore a bit hardwired - but it should be
*** easy to convert it to handle 8,16 or 32


DELETE_TEXT	EQU	0
DRAW_TEXT	EQU	1

FORWARD		EQU	0
FORWARD_FIRST	EQU	1
REVERSE		EQU	2


******************************************
****     EDIT SINGLE BLOCK           *****
******************************************
Edit_Single_Block
	
	jsr  convert_mouse_and_store	
	move.l page_pointer,a0
	clr.l	d2
	move.w screen_y_pos(a0),d2
	add.w	d1,d2		;giving y position down screen
	move.l	current_map_ptr,a1
	divu	map_block_size(a1),d2
	mulu	num_x_blocks_in_page,d2
	
	divu	map_block_size(a1),d0	;blocks in
	
	add.w	d2,d0
	move.w	current_page,d1
	mulu	num_blocks_in_page,d1
	add.w	d1,d0			;gives us the block
	
	cmp.w	#MAX_DATA_BLOCKS,d0	;just in case
	blt.s	within_sblock_range
	move.w	#MAX_DATA_BLOCKS-1,d0
within_sblock_range	

	move.w	d0,currently_selected_block


	clr.w	Edit_Blk_Mode	
	move.l	#edit_block_data_window,a0
	jsr	create_window

	bsr	Set_New_Attributes
	
	move.l	#edit_single_block_data_buttons,a0
	jsr	display_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	display_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	display_button_list

	bsr	Display_Attr_Titles
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Menu
	bsr	Display_Shooting_Menu
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice

	rts


******************************************
*****REMOVE SINGLE EDIT BLOCK WINDOW *****
******************************************
remove_single_edit_block_window

	move.l	#edit_single_block_data_buttons,a0
	jsr	remove_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	remove_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	remove_button_list	
	move.l	#edit_block_data_window,a0
	jsr	destroy_window
	jsr	Display_Graphic_Page
	
	rts


******************************************
****     DISPLAY EDIT WINDOW         *****
******************************************
display_edit_window

	clr.w	Edit_Blk_Mode	
	move.l	#edit_block_data_window,a0
	jsr	create_window
	move.l	#edit_block_data_buttons,a0
	jsr	display_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	display_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	display_button_list
	rts



******************************************
*****	REMOVE EDIT BLOCK WINDOW     *****
******************************************
remove_edit_block_window

	move.l	#edit_block_data_buttons,a0
	jsr	remove_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	remove_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	remove_button_list	
	move.l	#edit_block_data_window,a0
	jsr	destroy_window
	jsr	Display_Graphic_Page
	
	rts


******************************************
****     VIEW BLOCK ATTRIBUTES       *****
******************************************
View_Block_Attributes	

	move.l	#Block_Attr1,a0
	move.w	#8-1,d0
clear_attr_butts
	clr.b	button_start(a0)	;clear button contents
	add.l	#block_butt_size,a0
	dbra	d0,clear_attr_butts


	clr.w	CompareData
	move.w	#1,Edit_Blk_Mode	;set flag
	move.l	#edit_block_data_window,a0
	jsr	create_window
	move.l	#view_block_data_buttons,a0
	jsr	display_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	display_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	display_button_list
	
	clr.w	Standing_Menu_Pos
	clr.w	Shooting_Menu_Pos
	clr.w	Standing_Choice
	clr.w	Shooting_Choice
	bsr	Display_Attr_Titles
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Menu
	bsr	Display_Shooting_Menu
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice

	
	rts

******************************************
*****	REMOVE VIEW BLOCK WINDOW     *****
******************************************
remove_view_block_window

	move.l	#view_block_data_buttons,a0
	jsr	remove_button_list
	move.l	#edit_block_other_buttons,a0
	jsr	remove_button_list
	move.l	#edit_blk_attr_buttons,a0
	jsr	remove_button_list	
	move.l	#edit_block_data_window,a0
	jsr	destroy_window

	move.l	clicked_button,a0	
	moveq	#0,d1
	tst.b	button_data(a0)
	bne.s	dont_add_any_data

	bsr	Add_Specified_Blks_To_Group		
	bra.s	display_new_grps
dont_add_any_data
	bsr	Clear_Blk_Group	
display_new_grps	
	jsr	Display_Graphic_Page	
	rts

******************************************
*****	ADD SPECIFIED BLKS TO GROUP  *****
******************************************
Add_Specified_Blks_To_Group
	move.l	block_data_ptr,a0
	move.l	#block_group_data,a1
	move.w	CompareData,d1
	move.w	#MAX_DATA_BLOCKS-1,d0
view_loop
	cmp.w	(a0)+,d1
	beq.s	add_block_to_group
	clr.b	(a1)			
	bra.s	test_next_blk
add_block_to_group
	move.b	#1,(a1)
test_next_blk
	add.l	#1,a1
	dbra	d0,view_loop	
	rts

******************************************
*****    	CLEAR BLK GROUP      *****
******************************************
Clear_Blk_Group
	move.l	#block_group_data,a1
	move.w	#MAX_DATA_BLOCKS-1,d0
clear_blk_loop
	clr.b	(a1)+
	dbra	d0,clear_blk_loop
	rts

******************************************
****     ENTER BLOCK INTO GROUP      *****
******************************************
Enter_Block_Into_Group
*If block already selected - remove from group

	jsr  convert_mouse_and_store	
	move.l page_pointer,a0
	clr.l	d2
	move.w screen_y_pos(a0),d2
	add.w	d1,d2		;giving y position down screen
	move.l	current_map_ptr,a1
	divu	map_block_size(a1),d2
	mulu	num_x_blocks_in_page,d2
	
	divu	map_block_size(a1),d0	;blocks in
	
	add.w	d2,d0
	move.w	current_page,d1
	mulu	num_blocks_in_page,d1
	add.w	d1,d0			;gives us the block
	
	cmp.w	#MAX_DATA_BLOCKS,d0
	blt.s	within_block_range
	move.w	#MAX_DATA_BLOCKS-1,d0
within_block_range	

	ext.l	d0	
	move.l	#block_group_data,a0
	tst.b	(a0,d0)
	beq.s	set_block_as_highlighted
	clr.b	(a0,d0)
	jsr	display_graphic_page
	rts	
set_block_as_highlighted	
	move.b	#1,(a0,d0)
display_highlight	
	divu	#320,d0
	clr.w	d0
	swap	d0		;gives modulo
	move.l	page_pointer,a1
	move.w  screen_y_pos(a1),d2
	ext.l   d2
	move.l  current_map_ptr,a1
	divu.w  map_block_size(a1),d2
	mulu	num_x_blocks_in_page,d2
	sub.l	d2,d0
	bsr	Highlight_Block	
	rts

******************************************
****     DISPLAY OVERLAYS            *****
******************************************
Display_Overlays
	move.w	current_page,d0
	move.l	#block_group_data,a0
	mulu	#320,d0
	add.l	d0,a0		;get page pos
	
	move.l page_pointer,a1
	move.w screen_y_pos(a1),d2
	ext.l  d2
	move.l current_map_ptr,a1
	divu.w  map_block_size(a1),d2
	mulu	num_x_blocks_in_page,d2
	add.l	d2,a0
	move.w	#320-1,d1
	sub.w	d2,d1		
	
	clr.w	d0
check_for_display
	tst.b	(a0)+
	beq.s	dont_display_ov
	
	movem.l	d0-d1/a0,-(sp)
	bsr	HighLight_Block	
	movem.l	(sp)+,d0-d1/a0
dont_display_ov	
	addq.w	#1,d0
	dbra	d1,check_for_display		
	rts
	
******************************************
****     HIGHLIGHT BLOCK             *****
******************************************
HighLight_Block
*send block in d0

	move.l #main_screen_struct,a0
	move.l	screen_mem(a0),a0

	divu	num_x_blocks_in_page,d0	
	moveq	#0,d1
	move.w	d0,d1		;lines down
	lsl.w	#4,d1		;pixels down
			
	clr.w	d0
	swap	d0		;gives blocks in
	lsl.w	#4,d0		;gives pixels in
	
	move.l	current_map_ptr,a1
	move.w	map_planes(a1),d5
	subq.w	#1,d5

draw_blk_lines	
	
	move.w	d0,d2
	move.w	d1,d3
	move.l	current_map_ptr,a1
	add.w	map_block_size(a1),d2
	add.w	map_block_size(a1),d3
	
	movem.l	a6/d5,-(sp)
	movem.l	a0/d0-d3,-(sp)
	jsr	Dark_Line	
	movem.l	(sp)+,a0/d0-d3
	
	movem.l	a0/d0-d3,-(sp)
	move.l	current_map_ptr,a1
	add.w	map_block_size(a1),d1
	sub.w	map_block_size(a1),d3
	jsr	Dark_Line
	
	movem.l	(sp)+,a0/d0-d3	
	
	move.l	#main_screen_struct,a2
	move.w	screen_x_size(a2),d4
	asr.w	#3,d4
	mulu	screen_y_size(a2),d4
	add.l	d4,a0	
		
	movem.l	(sp)+,a6/d5

	dbra	d5,draw_blk_lines
	
	rts		
		
block_group_data
	ds.b	MAX_DATA_BLOCKS		;max number of blocks	


***************************************
***** LOAD BLOCK DATA              ****
***************************************
Load_Block_Data

	move.l	#Load_Block_Data_Into_Memory,File_Routine_Pointer
	jsr	display_file_request
	rts

***************************************
***** LOAD BLOCK DATA INTO MEMORY  ****
***************************************
Load_Block_Data_Into_Memory

	movem.l	a6,-(sp)

	jsr	remove_file_request

	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq	could_not_load_block_data	
	bsr	Load_Block_Data_From_File
	move.l	#Project_DataList,d0
	move.l	#Current_Filename,a0
	jsr	Set_Project_Information
		
	bra.s	exit_load_block_data
could_not_load_block_data
	jsr	display_error
exit_load_block_data	
	movem.l	(sp)+,a6

	rts
***************************************
***** LOAD BLOCK DATA FROM FILE    ****
***************************************
Load_Block_Data_From_File
*Send filehandle in d0
	
	move.l	d0,d1		;filehandle
	move.w	#16-1,d0
	move.l	#Blk_Standing_Strings,d2
load_stand_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	read(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,load_stand_strings
	
	move.w	#16-1,d0
	move.l	#Blk_Shooting_Strings,d2
load_shoot_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	read(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,load_shoot_strings

	move.w	#8-1,d0
	move.l	#Blk_Bit_Attrs,d2
load_attr_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	read(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,load_attr_strings
	
	move.l	block_data_ptr,d2
	move.l	#MAX_BLOCKS_MEM,d3
	move.l	dosbase,a6
	move.l	d1,-(sp)
	jsr	read(a6)
	move.l	(sp)+,d1
	
	move.l	dosbase,a6
	jsr	close(a6)
	rts
	
***************************************
***** SAVE BLOCK DATA              ****
***************************************
Save_Block_Data
	move.l	#Save_Block_Data_To_Disk,File_Routine_Pointer
	jsr	display_file_request
	rts

***************************************
***** SAVE BLOCK DATA TO DISK      ****
***************************************
Save_Block_Data_To_Disk

	movem.l	a6,-(sp)

	jsr	remove_file_request

	move.l	#Current_Filename,d1
	move.l	#MODE_NEW,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq	could_not_save_block_data
	
	
	
	move.l	d0,d1		;filehandle
	move.w	#16-1,d0
	move.l	#Blk_Standing_Strings,d2
save_stand_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	write(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,save_stand_strings
	
	move.w	#16-1,d0
	move.l	#Blk_Shooting_Strings,d2
save_shoot_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	read(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,save_shoot_strings

	move.w	#8-1,d0
	move.l	#Blk_Bit_Attrs,d2
save_attr_strings
	move.l	dosbase,a6
	move.l	#11,d3
	movem.l	d0-d3,-(sp)
	jsr	read(a6)
	movem.l	(sp)+,d0-d3
	add.l	#12,d2
	dbra	d0,save_attr_strings
		
	move.l	block_data_ptr,d2
	move.l	#MAX_BLOCKS_MEM,d3
	move.l	dosbase,a6
	move.l	d1,-(sp)
	jsr	write(a6)
	move.l	(sp)+,d1
	
	move.l	dosbase,a6
	jsr	close(a6)		
	bra.s	exit_save_block_data
could_not_save_block_data
	jsr	display_error
exit_save_block_data	
	movem.l	(sp)+,a6
	rts

******************************************
****     EDIT BLOCK GROUP            *****
******************************************
Edit_Block_Group
	move.l	#block_group_data,block_group_ptr
	clr.w	currently_selected_block
	move.w	#FORWARD_FIRST,d7
	bsr	Find_Next_Block
	tst.w	currently_selected_block
	bmi.s	dont_open_window
	bsr	Set_New_Attributes
	bsr	Display_Edit_Window
	bsr	Display_Attr_Titles
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Menu
	bsr	Display_Shooting_Menu
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice
dont_open_window	
	rts

block_group_ptr
	dc.l	0
current_block_ptr
	dc.l	0	

******************************************
****    SELECT BLOCK ATTR            *****
******************************************
Select_Block_Attr

	move.l	clicked_button,a0	
	moveq	#0,d1
	move.b	button_data(a0),d1

	tst.w	Edit_Blk_Mode
	bne.s	Set_Data_For_View

	clr.l	d0
	move.w	currently_selected_block,d0
	move.l	block_data_ptr,a0
	lsl	d0
			
	bset.b	d1,1(a0,d0)
	bra.s	End_Select_Block_Attr
set_data_for_view
	bset.b	d1,CompareData
End_Select_Block_Attr
	rts

Edit_Blk_Mode	dc.w	0
CompareData	dc.w	0	

STANDING_MENU_X	EQU	10+16
STANDING_MENU_Y EQU 	20


SHOOTING_MENU_X	EQU	130+16
SHOOTING_MENU_Y EQU 	20

MENU_CHOICES	EQU	5

ATTR_Y_POS	EQU	108

*******************************************
****** DISPLAY ATTR TITLES           ******
*******************************************
Display_Attr_Titles

	move.w	#DRAW_TEXT,d3
	move.l	#Standing_Title,a1
	move.l	#edit_block_data_window,a0
	move.w	#STANDING_MENU_X+32,d0
	move.w	#2,d1
	move.w	#2,d2
	jsr	write_text
	
	move.l	#Shooting_Title,a1
	move.l	#edit_block_data_window,a0
	move.w	#SHOOTING_MENU_X+32,d0
	move.w	#2,d1
	move.w	#2,d2
	jsr	write_text
	
	move.l	#Blk_Bit_Attrs,a1
	move.w	#4-1,d7
	move.w	#DRAW_TEXT,d3	
	move.w	#STANDING_MENU_X,d0
	move.w	#ATTR_Y_POS,d1
	move.w	#2,d2
display_blk_set1
	jsr	write_text
	add.w	#FONT_HEIGHT,d1
	add.l	#12,a1
	dbra	d7,display_blk_set1
	
	move.l	#Blk_Bit_Attrs2,a1
	move.w	#4-1,d7
	move.w	#DRAW_TEXT,d3	
	move.w	#SHOOTING_MENU_X+16,d0
	move.w	#ATTR_Y_POS,d1
	move.w	#2,d2
display_blk_set2
	jsr	write_text
	add.w	#FONT_HEIGHT,d1
	add.l	#12,a1
	dbra	d7,display_blk_set2
	rts

*******************************************
****** SCROLL STANDING_UP            ******
*******************************************
Scroll_Standing_Up
	tst.w	Standing_Menu_Pos
	beq.s	cannot_move_standing_up
	move.w	#DELETE_TEXT,d3
	bsr	Display_Standing_Menu
	subq.w	#1,Standing_Menu_Pos
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Menu
cannot_move_standing_up
	rts

*******************************************
****** SCROLL STANDING DOWN          ******
*******************************************
Scroll_Standing_Down
	cmp.w	#11,Standing_Menu_Pos
	beq.s	cannot_move_standing_down
	move.w	#DELETE_TEXT,d3
	bsr	Display_Standing_Menu
	addq.w	#1,Standing_Menu_Pos
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Menu
cannot_move_standing_down
	rts

*******************************************
****** SCROLL SHOOTING_UP            ******
*******************************************
Scroll_Shooting_Up
	tst.w	Shooting_Menu_Pos
	beq.s	cannot_move_shooting_up
	move.w	#DELETE_TEXT,d3
	bsr	Display_Shooting_Menu
	subq.w	#1,Shooting_Menu_Pos
	move.w	#DRAW_TEXT,d3
	bsr	Display_Shooting_Menu
cannot_move_shooting_up
	rts

*******************************************
****** SCROLL SHOOTING DOWN          ******
*******************************************
Scroll_Shooting_Down
	cmp.w	#11,Shooting_Menu_Pos
	beq.s	cannot_move_shooting_down
	move.w	#DELETE_TEXT,d3
	bsr	Display_Shooting_Menu
	addq.w	#1,Shooting_Menu_Pos
	move.w	#DRAW_TEXT,d3
	bsr	Display_Shooting_Menu
cannot_move_shooting_down
	rts

	
*******************************************
****** DISPLAY STANDING MENU         ******
*******************************************
Display_Standing_Menu
*send delete or draw in d3

	move.w	Standing_Menu_Pos,d0
	mulu	#12,d0
	move.l	#Blk_Standing_Strings,a1
	add.l	d0,a1
	move.l	#edit_block_data_window,a0
	move.w	#STANDING_MENU_X,d0
	move.w	#STANDING_MENU_Y,d1
	move.w	#4,d2
	move.w	#MENU_CHOICES-1,d7
draw_up_standing_menu	
	jsr	write_text
	add.l	#12,a1
	add.w	#FONT_HEIGHT,d1
	dbra	d7,draw_up_standing_menu
	rts

*******************************************
****** DISPLAY STANDING CHOICE       ******
*******************************************
Display_Standing_Choice
*send delete or draw in d3

	move.w	Standing_Choice,d0
	mulu	#12,d0
	move.l	#Blk_Standing_Strings,a1
	add.l	d0,a1
	move.l	#edit_block_data_window,a0
	move.w	#STANDING_MENU_X,d0
	move.w	#STANDING_MENU_Y+(MENU_CHOICES+1)*FONT_HEIGHT,d1
	move.w	#1,d2	
	jsr	write_text
	rts

*******************************************
****** DISPLAY SHOOTING CHOICE       ******
*******************************************
Display_Shooting_Choice
*send delete or draw in d3

	move.w	Shooting_Choice,d0
	mulu	#12,d0
	move.l	#Blk_Shooting_Strings,a1
	add.l	d0,a1
	move.l	#edit_block_data_window,a0
	move.w	#SHOOTING_MENU_X,d0
	move.w	#SHOOTING_MENU_Y+(MENU_CHOICES+1)*FONT_HEIGHT,d1
	move.w	#1,d2	
	jsr	write_text
	rts

*******************************************
****** FIND NEXT BLOCK               ******
*******************************************
Find_Next_Block
*Direction in d7
	move.l	block_group_ptr,a0
	move.w	currently_selected_block,d0	

	cmp.w	#FORWARD_FIRST,d7
	beq.s	Skip_First_Time
	cmp.w	#FORWARD,d7
	beq.s	Test_Forward
find_block_reverse_loop	
	subq.w	#1,d0
	subq.l	#1,a0
	tst.w	d0
	bge.s	not_at_start_of_list
	move.w	#MAX_DATA_BLOCKS-1,d0
	move.l	#block_group_data+MAX_DATA_BLOCKS-1,a0
not_at_start_of_list
	tst.b	(a0)
	bne.s	found_a_block
	cmp.w	currently_selected_block,d0	;full circle?
	beq.s	no_blocks_found	
	bra.s	find_block_reverse_loop		
Test_Forward	
	addq.w	#1,d0	
	addq.l	#1,a0
	cmp.w	#MAX_DATA_BLOCKS,d0
	bne.s	not_at_end_of_list
	clr.w	d0
	move.l	#block_group_data,a0
not_at_end_of_list	
	cmp.w	currently_selected_block,d0	;full circle?
	beq.s	no_blocks_found	
Skip_First_Time	
	tst.b	(a0)
	beq.s	Test_Forward
found_a_block
	move.l	a0,block_group_ptr
	move.w	d0,currently_selected_block
	rts
no_blocks_found
	move.w	#-1,currently_selected_block
	rts

currently_selected_block	dc.w	0

*******************************************
****** SET NEW ATTRIBUTES            ******
*******************************************
Set_New_Attributes

	moveq	#0,d0
	move.w	currently_selected_block,d0
	moveq	#0,d1
	moveq	#0,d2
	move.l	block_data_ptr,a0
	lsl.w	d0
	move.b	1(a0,d0),d1		;block data, first byte = stand shoot
	move.b	(a0,d0),d3
		
	move.w	d1,d2
	andi.w	#$f0,d1
	lsr	#4,d1		
	move.w	d1,shooting_choice
	andi.w	#$f,d2
	move.w	d2,standing_choice	

	move.l	#Block_Attr1,a0
	move.w	#8-1,d0
set_attr_bits
	lsr.b	d3
	bcc.s	set_button_clear
	move.b	#1,button_start(a0)
	bra.s	set_next_button
set_button_clear
	clr.b	button_start(a0)	
set_next_button		
	add.l	#block_butt_size,a0
	dbra	d0,set_attr_bits
	rts

*******************************************
****** DISPLAY SHOOTING MENU         ******
*******************************************
Display_Shooting_Menu
*send delete or draw in d3

	move.w	Shooting_Menu_Pos,d0
	mulu	#12,d0
	move.l	#Blk_Shooting_Strings,a1
	add.l	d0,a1
	move.l	#edit_block_data_window,a0
	move.w	#SHOOTING_MENU_X,d0
	move.w	#SHOOTING_MENU_Y,d1
	move.w	#4,d2
	move.w	#MENU_CHOICES-1,d7
draw_up_shooting_menu	
	jsr	write_text
	add.l	#12,a1
	add.w	#FONT_HEIGHT,d1
	dbra	d7,draw_up_shooting_menu
	rts

*******************************************
****** SELECT STANDING CHOICE        ******
*******************************************
Select_Standing_Choice
	move.w	#DELETE_TEXT,d3
	bsr	Display_Standing_Choice

	move.l	clicked_button,a0	
	moveq	#0,d1
	move.b	button_data(a0),d1

	add.w	Standing_Menu_Pos,d1
	move.w	d1,Standing_Choice
	
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Choice
		
	tst.w	Edit_Blk_Mode
	bne.s	Set_StandData_For_View

	move.w	Standing_Choice,d1
	lsl	#4,d1
	clr.l	d0
	move.w	currently_selected_block,d0
	move.l	block_data_ptr,a0
	lsl	d0
	move.b	(a0,d0),d2
	andi.b	#$0f,d2
	or.b	d1,d2
	move.b	d2,(a0,d0)
	bra.s	End_Select_Stand_Block
Set_StandData_for_view
	move.b	CompareData+1,d2
	andi.b	#$f0,d2
	move.w	Standing_Choice,d1
	or.w	d1,d2
	move.b	d2,CompareData+1
End_Select_Stand_Block	
	rts

*******************************************
****** SELECT SHOOTING CHOICE        ******
*******************************************
Select_Shooting_Choice
	move.w	#DELETE_TEXT,d3
	bsr	Display_Shooting_Choice

	move.l	clicked_button,a0	
	moveq	#0,d1
	move.b	button_data(a0),d1

	add.w	Shooting_Menu_Pos,d1
	move.w	d1,Shooting_Choice
	
	move.w	#DRAW_TEXT,d3
	bsr	Display_Shooting_Choice
		
	tst.w	Edit_Blk_Mode
	bne.s	Set_ShootData_For_View

	move.w	Shooting_Choice,d1
	clr.l	d0
	move.w	currently_selected_block,d0
	move.l	block_data_ptr,a0
	lsl	d0
	move.b	(a0,d0),d2
	andi.b	#$f0,d2
	or.b	d1,d2
	move.b	d2,(a0,d0)
	bra.s	End_Select_Shoot_Block
Set_ShootData_for_view
	move.b	CompareData+1,d2
	andi.b	#$f,d2
	move.w	Shooting_Choice,d1
	lsl	#4,d1
	or.w	d1,d2
	move.b	d2,CompareData+1
End_Select_Shoot_Block	
	rts

*******************************************
****** SELECT PREV BLOCK             ******
*******************************************
Select_Prev_Block	
	move.w	#DELETE_TEXT,d3
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice
	move.l	#edit_blk_attr_buttons,a0
	jsr	Remove_Button_List
	move.w	#REVERSE,d7
	bsr	Find_Next_Block
	bsr	Set_New_Attributes
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice
	move.l	#edit_blk_attr_buttons,a0
	jsr	Display_Button_List
	rts


*******************************************
****** SELECT NEXT BLOCK             ******
*******************************************
Select_Next_Block	
	move.w	#DELETE_TEXT,d3
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice
	move.l	#edit_blk_attr_buttons,a0
	jsr	Remove_Button_List
	move.w	#FORWARD,d7
	bsr	Find_Next_Block
	tst.w	currently_selected_block
	bmi.s	block_find_error
	bsr	Set_New_Attributes
	move.w	#DRAW_TEXT,d3
	bsr	Display_Standing_Choice
	bsr	Display_Shooting_Choice
	move.l	#edit_blk_attr_buttons,a0
	jsr	Display_Button_List
	rts
block_find_error
	bsr	Remove_Edit_Block_Window	
	rts

*******************************************
****** APPLY DATA TO BLOCK GROUP     ******
*******************************************
Apply_Data_To_Block_Group
	move.l	block_group_ptr,a1		;save
	move.w	currently_selected_block,d5
	clr.l	d6
	move.w	d5,d6
	move.l	block_data_ptr,a2
	lsl	d6
	move.w	(a2,d6),d6		;contains data
	move.w	#FORWARD,d7	
Apply_Loop
	bsr	Find_Next_Block
	moveq	#0,d4
	move.w	currently_selected_block,d4
	bmi.s	end_of_apply
	cmp.w	d4,d5
	beq.s	end_of_apply
	move.l	block_data_ptr,a2
	lsl	d4
	move.w	d6,(a2,d4)
	bra.s	Apply_Loop
end_of_apply
	move.w	d5,currently_selected_block
	move.l	a1,a0
	rts

*******************************************
****** REMOVE BLOCK FROM GROUP       ******
*******************************************
Remove_Block_From_Group
	move.l	block_group_ptr,a0
	clr.b	(a0)		;remove from group
	bsr	Select_Next_Block
	move.w	#FORWARD,d7
	rts

*******************************************
****** Add_Current_Attr_To_Group     ******
*******************************************
Add_Current_Attr_To_Group	
	clr.l	d0
	move.w	currently_selected_block,d0
	move.l	block_data_ptr,a0
	lsl	d0
	move.w	(a0,d0),CompareData	
	bsr	Add_Specified_Blks_To_Group	
	rts
	
	
Standing_Menu_Pos	dc.w	0
Shooting_Menu_Pos	dc.w	0
Standing_Choice		dc.w	0
Shooting_Choice		dc.w	0
	
edit_block_data_window
	dc.w	320
	dc.w	192		;full screen
	dc.w	0
	dc.w	0
	dc.l	0
	dc.l	0
	dc.b	"BLOCK ATTRIBUTES",0
	even		

view_block_data_buttons
	dc.l	view_block_data_ok,view_block_data_cancel
	dc.l	-1


edit_single_block_data_buttons
	dc.l	edit_single_block_data_ok
	dc.l	-1

edit_block_data_buttons
	dc.l	edit_block_data_ok
	dc.l	Block_Left_Arrow,Block_Right_Arrow
	dc.l	Apply_Button,Remove_Blk_Button,Set_Group_Blk_Button
	dc.l	-1
edit_blk_attr_buttons	
	dc.l	Block_Attr1,Block_Attr2,Block_Attr3,Block_Attr4
	dc.l	Block_Attr5,Block_Attr6,Block_Attr7,Block_Attr8
	dc.l	-1
edit_block_other_buttons	
	dc.l	Standing_Up_Arrow,Standing_Down_Arrow
	dc.l	Shooting_Up_Arrow,Shooting_Down_Arrow
	dc.l	StandMenu1,StandMenu2,StandMenu3,StandMenu4,StandMenu5
	dc.l	ShootMenu1,ShootMenu2,ShootMenu3,ShootMenu4,ShootMenu5
	dc.l	-1	

edit_block_data_ok
	dc.w	(320/2)-48
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_edit_block_window
	dc.b	0		
	even

edit_single_block_data_ok
	dc.w	(320/2)-48
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_single_edit_block_window
	dc.b	0		
	even


view_block_data_ok
	dc.w	32
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_view_block_window
	dc.b	0		
	even

view_block_data_cancel
	dc.w	320-128
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	remove_view_block_window
	dc.b	0		
	even


edit_data_button
	dc.w	BUTTON_4
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_EDIT_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	edit_block_group
	dc.b	"EDIT GRP",0
	EVEN

edit_blk_button
	dc.w	BUTTON_5
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_EDIT_SINGLE_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"EDIT BLK",0
	EVEN


select_data_button
	dc.w	BUTTON_4
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_EDIT_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"SEL GRP",0
	EVEN

view_data_button
	dc.w	BUTTON_3
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_EDIT_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	view_block_attributes
	dc.b	"VIEW ATTR",0
	EVEN

*-------------------Window buttons------------------*

Block_Attr1
	dc.w	STANDING_MENU_X-16
	dc.w	ATTR_Y_POS
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	
Block_Butt_Size	equ	*-Block_Attr1	

Block_Attr2
	dc.w	STANDING_MENU_X-16
	dc.w	ATTR_Y_POS+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr3
	dc.w	STANDING_MENU_X-16
	dc.w	ATTR_Y_POS+FONT_HEIGHT*2
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr4
	dc.w	STANDING_MENU_X-16
	dc.w	ATTR_Y_POS+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr5
	dc.w	SHOOTING_MENU_X
	dc.w	ATTR_Y_POS
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr6
	dc.w	SHOOTING_MENU_X
	dc.w	ATTR_Y_POS+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	5	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr7
	dc.w	SHOOTING_MENU_X
	dc.w	ATTR_Y_POS+FONT_HEIGHT*2
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	6	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Block_Attr8
	dc.w	SHOOTING_MENU_X
	dc.w	ATTR_Y_POS+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	7	;index
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	Select_Block_Attr
	dc.b	0		
	EVEN	

Standing_Up_Arrow
	dc.w	2
	dc.w	STANDING_MENU_Y+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	scroll_standing_up
	dc.b	0		
	EVEN	

Standing_Down_Arrow
	dc.w	2
	dc.w	STANDING_MENU_Y+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	scroll_standing_down
	dc.b	0		
	EVEN	

Shooting_Up_Arrow
	dc.w	320-62
	dc.w	STANDING_MENU_Y+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	scroll_shooting_up
	dc.b	0		
	EVEN	

Shooting_Down_Arrow
	dc.w	320-62
	dc.w	STANDING_MENU_Y+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	scroll_shooting_down
	dc.b	0		
	EVEN	

Block_Left_Arrow
	dc.w	192-8
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_left
	dc.l	0	;not used
	dc.l	select_prev_block
	dc.b	0		
	EVEN	

Block_Right_Arrow
	dc.w	210
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_right
	dc.l	0	;not used
	dc.l	select_next_block
	dc.b	0		
	EVEN	

StandMenu1
	dc.w	STANDING_MENU_X
	dc.w	STANDING_MENU_Y
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Standing_Choice
	dc.b	0		
	EVEN					

StandMenu2
	dc.w	STANDING_MENU_X
	dc.w	STANDING_MENU_Y+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Standing_Choice
	dc.b	0		
	EVEN	

StandMenu3
	dc.w	STANDING_MENU_X
	dc.w	STANDING_MENU_Y+FONT_HEIGHT*2
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Standing_Choice
	dc.b	0		
	EVEN	

StandMenu4
	dc.w	STANDING_MENU_X
	dc.w	STANDING_MENU_Y+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Standing_Choice
	dc.b	0		
	EVEN	

StandMenu5
	dc.w	STANDING_MENU_X
	dc.w	STANDING_MENU_Y+FONT_HEIGHT*4
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Standing_Choice
	dc.b	0		
	EVEN	

ShootMenu1
	dc.w	SHOOTING_MENU_X
	dc.w	SHOOTING_MENU_Y
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Shooting_Choice
	dc.b	0		
	EVEN					

ShootMenu2
	dc.w	SHOOTING_MENU_X
	dc.w	SHOOTING_MENU_Y+FONT_HEIGHT
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Shooting_Choice
	dc.b	0		
	EVEN	

ShootMenu3
	dc.w	SHOOTING_MENU_X
	dc.w	SHOOTING_MENU_Y+FONT_HEIGHT*2
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Shooting_Choice
	dc.b	0		
	EVEN	

ShootMenu4
	dc.w	SHOOTING_MENU_X
	dc.w	SHOOTING_MENU_Y+FONT_HEIGHT*3
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Shooting_Choice
	dc.b	0		
	EVEN	

ShootMenu5
	dc.w	SHOOTING_MENU_X
	dc.w	SHOOTING_MENU_Y+FONT_HEIGHT*4
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	MenuButton ;not used
	dc.l	0	;not used
	dc.l	Select_Shooting_Choice
	dc.b	0		
	EVEN	

Apply_Button
	dc.w	5
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    apply_custom_button ;not used
	dc.l	0	;not used
	dc.l	Apply_Data_To_Block_Group
	dc.b	0		
	EVEN	

Remove_Blk_Button
	dc.w	5+36
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    remove_custom_button ;not used
	dc.l	0	;not used
	dc.l	Remove_Block_From_Group
	dc.b	0		
	EVEN	

Set_Group_Blk_Button
	dc.w	5+36+36
	dc.w	128+32
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    setgroup_custom_button ;not used
	dc.l	0	;not used
	dc.l	Add_Current_Attr_To_Group
	dc.b	0		
	EVEN	


Blk_Standing_Strings
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0			
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	
Blk_Shooting_Strings
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0		;0 not available
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	
Blk_Bit_Attrs
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
Blk_Bit_Attrs2	
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	dc.b	"Undefined  ",0
	
	even

Shooting_Title
	dc.b	"SHOOT",0
Standing_Title
	dc.b	"STAND",0					