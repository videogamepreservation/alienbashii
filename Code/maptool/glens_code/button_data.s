*******************************************************
*****               BUTTON    DATA                *****
*******************************************************
****BUTTON DATA FOR ALL EDITOR/MUSIC DRAW ROUTINES*****
*******************************************************

top_level_list
	dc.l	exit_system_button,graphics_system_button
	dc.l    edit_system_button,editdata_system_button
	dc.l	load_project_file_button,save_project_file_button
	dc.l	system_setup_button,-1


exit_system_button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	check_kill
	dc.b	"EXIT",0
	EVEN

graphics_system_button
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	display_graphic_buttons
	dc.b	"GRAPHICS",0
	EVEN

edit_system_button
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	display_edit_buttons
	dc.b	"EDIT MAP",0
	EVEN

editdata_system_button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	bring_up_data_function
	dc.b	"EDIT DATA",0
	EVEN

system_setup_button
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	display_setup_window
	dc.b	"MAP SETUP",0
	EVEN

load_project_file_button
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	load_project_requester
	dc.b	"LOAD PROJ",0
	EVEN

save_project_file_button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	save_project_requester
	dc.b	"SAVE PROJ",0
	EVEN



*********GRAPHICS BUTTONS****************

graphic_list
	dc.l exit_graphics_button,load_graphics_button	
	dc.l save_graphics_button,copy_graphics_button
	dc.l exchange_graphics_button,move_graphics_button,edit_data_button
	dc.l load_block_data_button,save_block_data_button,combine_graphics_button
	dc.l xflip_graphics_button,yflip_graphics_button
	dc.l rotate_graphics_button,select_data_button,view_data_button,edit_blk_button
graphic_page_buttons	
	dc.l page1_graphics_button,page2_graphics_button
	dc.l page3_graphics_button,page4_graphics_button
	dc.l scrolldown_graphics_button
	dc.l scrollup_graphics_button,-1
	
exit_graphics_button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	remove_graphic_buttons
	dc.b	"EXIT",0
	EVEN

load_graphics_button
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	load_an_image_file
	dc.b	"LOAD PIC",0
	EVEN

save_graphics_button
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	save_pic_window
	dc.b	"SAVE PIC",0
	EVEN

copy_graphics_button
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_COPY_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"COPY BLOCK",0
	EVEN

exchange_graphics_button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_EXCHANGE_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"XCNG BLOCK",0
	EVEN

move_graphics_button
	dc.w	BUTTON_2
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_MOVE_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"MOVE BLOCK",0
	EVEN


combine_graphics_button
	dc.w	BUTTON_2
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_COMBINE_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"COMBINE",0
	EVEN


load_block_data_button
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	load_block_data
	dc.b	"LOAD DATA",0
	EVEN

save_block_data_button
	dc.w	BUTTON_4
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	save_block_data
	dc.b	"SAVE DATA",0
	EVEN

xflip_graphics_button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_XFLIP_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"XFLIP",0
	EVEN

yflip_graphics_button
	dc.w	BUTTON_3
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_YFLIP_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"YFLIP",0
	EVEN

rotate_graphics_button
	dc.w	BUTTON_3
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	MODE_ROTATE_BLOCK
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	select_block_mode
	dc.b	"ROTATE",0
	EVEN

page1_graphics_button
	dc.w	BUTTON_5+120
	dc.w	FIRST_ROW+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l    page1_button
	dc.l	0	;not used
	dc.l	change_page
	dc.b	0
	EVEN

page2_graphics_button
	dc.w	BUTTON_5+148
	dc.w	FIRST_ROW+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l    page2_button
	dc.l	0	;not used
	dc.l	change_page
	dc.b	0
	EVEN
	
page3_graphics_button
	dc.w	BUTTON_5+120
	dc.w	FIRST_ROW+13+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b    CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l    page3_button
	dc.l	0	;not used
	dc.l	change_page
	dc.b	0
	EVEN
	
page4_graphics_button
	dc.w	BUTTON_5+148
	dc.w	FIRST_ROW+13+17
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l    page4_button
	dc.l	0	;not used
	dc.l	change_page
	dc.b	0
	EVEN

scrollup_graphics_button
	dc.w	BUTTON_5+44
	dc.w	FIRST_ROW+8
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_up
	dc.l	0	;not used
	dc.l	change_graphics_position_down
	dc.b	0
	EVEN
	
scrolldown_graphics_button
	dc.w	BUTTON_5+44
	dc.w	FIRST_ROW+28
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_down
	dc.l	0	;not used
	dc.l	change_graphics_position_up
	dc.b	0
	EVEN

detect_generic_button
	dc.w	0
	dc.w	0
	dc.w	MAIN_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    screen_custom_button
	dc.l	0	;not used
	dc.l	select_relavant_mode
	dc.b	0
	EVEN

