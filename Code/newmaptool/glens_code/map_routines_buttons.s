

edit_buttons_list
	dc.l	edit_exit_button,edit_save_button,edit_load_button
	dc.l    edit_cut_button,edit_copy_button,edit_paste_button
	dc.l    edit_choose_button
	dc.l    edit_insert_row_button,edit_insert_col_button
	dc.l    edit_delete_row_button,edit_delete_col_button
	dc.l    edit_palette_button,show_whole_map_button,edit_fill_button
edit_page_buttons	
	dc.l    edit_page1_button,edit_page2_button
	dc.l    edit_page3_button,edit_page4_button
	dc.l	edit_scrollup_page_button,edit_scrolldown_page_button
	dc.l    edit_scrollup_map_button,edit_scrolldown_map_button
	dc.l    edit_scrollleft_map_button,edit_scrollright_map_button
	dc.l    edit_hit_on_map,edit_hit_on_blocks
	dc.l	-1
	


edit_exit_button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	remove_edit_buttons
	dc.b	"EXIT EDIT",0
	EVEN

edit_save_button
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	set_up_save_map
	dc.b	"SAVE MAP",0
	EVEN


edit_load_button
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	load_a_map
	dc.b	"LOAD MAP",0
	EVEN


edit_cut_button
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	cut_block
	dc.b	"CUT BLK",0
	EVEN

edit_copy_button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	copy_block
	dc.b	"COPY BLK",0
	EVEN

edit_paste_button
	dc.w	BUTTON_2
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	paste_block
	dc.b	"PASTE BLK",0
	EVEN
	
edit_choose_button
	dc.w	BUTTON_2
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	display_buffer_window
	dc.b	"PICK BUFF",0
	EVEN


edit_insert_row_button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	insert_map_row
	dc.b	"INSERT ROW",0
	EVEN

edit_insert_col_button
	dc.w	BUTTON_3
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	insert_map_column
	dc.b	"INSERT COL",0
	EVEN

edit_delete_row_button
	dc.w	BUTTON_3
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	delete_map_row
	dc.b	"DELETE ROW",0
	EVEN

edit_delete_col_button
	dc.w	BUTTON_3
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	delete_map_column
	dc.b	"DELETE COL",0
	EVEN

edit_fill_button
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	fill_map
	dc.b	"FILL",0
	EVEN

edit_palette_button
	dc.w	BUTTON_4
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	edit_map_palette
	dc.b	"PALETTE",0
	EVEN

show_whole_map_button
	dc.w	BUTTON_4
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	show_whole_map
	dc.b	"SHOW WHOLE",0
	EVEN


edit_undo_button
	dc.w	BUTTON_4
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	undo
	dc.b	"UNDO",0
	EVEN


edit_page1_button
	dc.w	BUTTON_5+40
	dc.w	FIRST_ROW+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l    page1_button
	dc.l	0	;not used
	dc.l	change_block_page
	dc.b	0
	EVEN

edit_page2_button
	dc.w	BUTTON_5+68
	dc.w	FIRST_ROW+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l    page2_button
	dc.l	0	;not used
	dc.l	change_block_page
	dc.b	0
	EVEN
	
edit_page3_button
	dc.w	BUTTON_5+40
	dc.w	FIRST_ROW+13+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b    CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l    page3_button
	dc.l	0	;not used
	dc.l	change_block_page
	dc.b	0
	EVEN
	
edit_page4_button
	dc.w	BUTTON_5+68
	dc.w	FIRST_ROW+13+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l    page4_button
	dc.l	0	;not used
	dc.l	change_block_page
	dc.b	0
	EVEN

edit_scrollup_page_button
	dc.w	BUTTON_5+10
	dc.w	FIRST_ROW+10
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_up
	dc.l	0	;not used
	dc.l	change_blocks_position_down
	dc.b	0
	EVEN
	
edit_scrolldown_page_button
	dc.w	BUTTON_5+10
	dc.w	FIRST_ROW+30
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_down
	dc.l	0	;not used
	dc.l	change_blocks_position_up
	dc.b	0
	EVEN


edit_scrollup_map_button
	dc.w	BUTTON_5+140
	dc.w	SECOND_ROW+5
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_up
	dc.l	0	;not used
	dc.l	scroll_map_up
	dc.b	0
	EVEN
	
edit_scrolldown_map_button
	dc.w	BUTTON_5+140
	dc.w	SECOND_ROW+35
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_down
	dc.l	0	;not used
	dc.l	scroll_map_down
	dc.b	0
	EVEN


edit_scrollleft_map_button
	dc.w	BUTTON_5+110
	dc.w	SECOND_ROW+20
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_left
	dc.l	0	;not used
	dc.l	scroll_map_right
	dc.b	0
	EVEN
	
edit_scrollright_map_button
	dc.w	BUTTON_5+167
	dc.w	SECOND_ROW+20
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_right
	dc.l	0	;not used
	dc.l	scroll_map_left
	dc.b	0
	EVEN

*******detect buttons

edit_hit_on_map
	dc.w	0
	dc.w	0
	dc.w	MAIN_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON    ;+NO_WAIT_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    map_screen_custom_button
	dc.l	0	;not used
	dc.l	execute_map_function
	dc.b	0
	EVEN

edit_hit_on_blocks
	dc.w	0
	dc.w	BUTTON_WINDOW_OFFSET-32
	dc.w	MAIN_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    map_blocks_custom_button
	dc.l	0	;not used
	dc.l	update_current_block
	dc.b	0
	EVEN
