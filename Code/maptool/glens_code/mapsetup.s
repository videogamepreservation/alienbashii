***********************************
**** DISPLAY SETUP WINDOW      ****
***********************************
display_setup_window
	bsr	set_original_colours
	move.l	current_map_ptr,a1
	move.l	(a1),map_backup_details
	move.l	4(a1),map_backup_details+4
	move.w	8(a1),map_backup_details+8

	move.l	#map_block_type8,a0
	move.b	#0,button_start(a0)
	move.l	#map_block_type16,a0
	move.b	#0,button_start(a0)
	move.l	#map_block_type32,a0
	move.b	#0,button_start(a0)

	move.l	#data_sizeb,a0
	move.b	#0,button_start(a0)
	move.l	#data_sizew,a0
	move.b	#0,button_start(a0)

	cmp.w	#0,Map_Datasize(a1)
	bne.s	sized_is_word
	move.l	#data_sizeb,a0
	move.b	#1,button_start(a0)
	bra.s	check_block_butts
sized_is_word
	move.l	#data_sizew,a0
	move.b	#1,button_start(a0)
check_block_butts

	cmp.w	#8,Map_Block_size(a1)
	bne.s	not_block_8
	move.l	#map_block_type8,a0
	move.b	#1,button_start(a0)
	bra.s	set_up_no_planes
not_block_8
	cmp.w	#16,Map_Block_Size(a1)
	bne.s	not_block_16
	move.l	#map_block_type16,a0
	move.b	#1,button_start(a0)
	bra.s	set_up_no_planes
not_block_16
	move.l	#map_block_type32,a0
	move.b	#1,button_start(a0)
*put tick into planes box

set_up_no_planes

	move.b	#0,map_planes1+button_start	;init buttons
	move.b	#0,map_planes2+button_start
	move.b	#0,map_planes3+button_start
	move.b	#0,map_planes4+button_start
	move.b	#0,map_planes5+button_start
	move.b	#0,map_planes6+button_start
	move.b	#0,map_planes7+button_start
	move.b	#0,map_planes8+button_start


	move.w	map_planes(a1),d0
	subq.w	#1,d0
	asl.w	#2,d0
	move.l	#map_plane_ticks,a0
	move.l	(a0,d0),a0
	move.b	#1,button_start(a0)

	move.l	#Setup_Request_Window,a0
	bsr	create_window

	move.l	#Setup_Request_Window,a0		; write in filename
	move.l	#setupstr1,a1
	move.w	#2,d2
	move.w	#6,d0
	move.w	#6,d1
	bsr	Write_Text	

	bsr	display_map_sizes
	move.l	#setup_buttons,a0
	bsr	display_button_list	
	rts


***********************************
**** REMOVE  SETUP WINDOW      ****
***********************************
remove_setup_window
	move.l	#setup_buttons,a0
	bsr	remove_button_list
	move.l	#Setup_Request_Window,a0
	bsr	destroy_window
	bsr	set_current_page_colours
	rts

***********************************
**** CHANGE MAP SETUP          ****
***********************************
change_map_setup

  	bsr	remove_setup_window
	bsr	convert_new_map

	rts

***********************************
**** CANCEL  SETUP WINDOW      ****
***********************************
cancel_setup_window
	bsr	remove_setup_window
	move.l	current_map_ptr,a1
	move.l	map_backup_details,(a1)
	move.l	map_backup_details+4,4(a1)
	move.w	map_backup_details+8,8(a1)
	rts

***********************************
**** DISPLAY MAP SIZES         ****
***********************************
display_map_sizes
	
	move.l	#Setup_Request_Window,a0		; write in filename
	move.w	#2,d2
	move.w	#116,d0
	move.w	#51,d1
	move.l	current_map_ptr,a1
	move.w	Map_XSize(a1),d3
	move.w	#1,d4
	bsr	Write_num

	move.l	#Setup_Request_Window,a0		; write in filename
	move.w	#2,d2
	move.w	#116,d0
	move.w	#71,d1
	move.l	current_map_ptr,a1
	move.w	Map_ySize(a1),d3
	move.w	#1,d4
	bsr	Write_num

	rts

***********************************
**** DELETE  MAP SIZES         ****
***********************************
delete_map_sizes
	
	move.l	#Setup_Request_Window,a0		; write in filename
	move.w	#2,d2
	move.w	#116,d0
	move.w	#51,d1
	move.l	current_map_ptr,a1
	move.w	Map_XSize(a1),d3
	move.w	#0,d4
	bsr	Write_num

	move.l	#Setup_Request_Window,a0		; write in filename
	move.w	#2,d2
	move.w	#116,d0
	move.w	#71,d1
	move.l	current_map_ptr,a1
	move.w	Map_ySize(a1),d3
	move.w	#0,d4
	bsr	Write_num

	rts

***********************************
**** UP X ROUTINE              ****
***********************************
up_x_routine
	bsr	delete_map_sizes
	move.l  current_map_ptr,a0
	cmp.w	#10000,map_xsize(a0)
	beq.s	no_change_x
	addq.w	#1,map_xsize(a0)
no_change_x
	bsr	display_map_sizes
	rts

***********************************
**** UP Y ROUTINE              ****
***********************************
up_y_routine
	bsr	delete_map_sizes
	move.l  current_map_ptr,a0
	cmp.w	#10000,map_ysize(a0)
	beq.s	no_change_y
	addq.w	#1,map_ysize(a0)
no_change_y
	bsr	display_map_sizes
	rts

***********************************
**** DOWN X ROUTINE            ****
***********************************
down_x_routine
	bsr	delete_map_sizes
	move.l	current_map_ptr,a0
	cmp.w	#1,map_xsize(a0)
	beq.s	no_change_xd
	subq.w	#1,map_xsize(a0)
no_change_xd
	bsr	display_map_sizes
	rts

***********************************
**** DOWN Y ROUTINE            ****
***********************************
down_y_routine
	bsr	delete_map_sizes
	move.l	current_map_ptr,a0
	cmp.w	#1,map_ysize(a0)
	beq.s	no_change_yd
	subq.w	#1,map_ysize(a0)
no_change_yd
	bsr	display_map_sizes
	rts


***********************************
**** CHANGE PLANES             ****
***********************************
change_planes

	move.l	clicked_button,a0
	move.l	current_map_ptr,a2
	moveq	#0,d0
	move.b	button_data(a0),d0
	
	move.w	map_planes(a2),d1
	move.l	#map_plane_ticks,a1
	subq.w	#1,d1
	asl.w	#2,d1
	move.l	(a1,d1.w),a0

	cmp.w	map_planes(a2),d0
	bne.s	no_reset_planes
	move.b	#DEPRESSED,button_start(a0)
	bra.s	redisplay_buttons
no_reset_planes
	move.b	#NOT_DEPRESSED,button_start(a0) 
	move.w	d0,map_planes(a2)
redisplay_buttons
	bsr	remove_button
	bsr	display_button
no_change_planes
	rts

***********************************
**** CHANGE BLOCK SIZE         ****
***********************************
change_block_size

	move.l	clicked_button,a0	
	moveq	#0,d0
	move.b	button_data(a0),d0
	move.l	current_map_ptr,a1
	cmp.w	map_block_size(a1),d0
	bne.s	no_reset_same_button
	cmp.w	#8,d0
	bne.s	rcheck16
	move.l	#map_block_type8,a0
	move.b	#DEPRESSED,button_start(a0)
	bra.s	show_block_button
rcheck16
	cmp.w	#16,d0
	bne.s	rcheck32
	move.l	#map_block_type16,a0
	move.b	#DEPRESSED,button_start(a0)
	bra.s	show_block_button
rcheck32
	move.l	#map_block_type32,a0
	move.b	#DEPRESSED,button_start(a0)
	bra.s	show_block_button
no_reset_same_button
	cmp.w	#8,map_block_size(a1)
	bne.s	check16
	move.l	#map_block_type8,a0
	move.b	#NOT_DEPRESSED,button_start(a0)
	bra.s	show_block_button
check16
	cmp.w	#16,map_block_size(a1)
	bne.s	check32
	move.l	#map_block_type16,a0
	move.b	#NOT_DEPRESSED,button_start(a0)
	bra.s	show_block_button
check32
	move.l	#map_block_type32,a0
	move.b	#NOT_DEPRESSED,button_start(a0)

show_block_button
	bsr	remove_button
	bsr	display_button
	move.w	d0,map_block_size(a1)
	rts

***********************************
**** CHANGE DATA SIZE         ****
***********************************
change_DATA_size

	move.l	clicked_button,a0	
	moveq	#0,d0
	move.b	button_data(a0),d0
	move.l	current_map_ptr,a1
	cmp.w	map_datasize(a1),d0
	bne.s	no_reset_size_button
	cmp.w	#0,d0
	bne.s	rcheckw
	move.l	#data_sizeb,a0
	move.b	#DEPRESSED,button_start(a0)
	bra.s	show_size_button
rcheckw
	cmp.w	#1,d0
	bne.s	show_size_button
	move.l	#data_sizew,a0
	move.b	#DEPRESSED,button_start(a0)
	bra.s	show_size_button
no_reset_size_button
	cmp.w	#0,map_datasize(a1)
	bne.s	checkw
	move.l	#data_sizeb,a0
	move.b	#NOT_DEPRESSED,button_start(a0)
	bra.s	show_size_button
checkw
	cmp.w	#1,map_datasize(a1)
	bne.s	show_size_button
	move.l	#data_sizew,a0
	move.b	#NOT_DEPRESSED,button_start(a0)
show_size_button
	bsr	remove_button
	bsr	display_button
	move.w	d0,map_datasize(a1)
	rts


 rsreset
Map_Block_Size rs.w 1
Map_XSize      rs.w 1
Map_YSize      rs.w 1
Map_Planes     rs.w 1
Map_DataSize   rs.w 1
Map_Mem	       rs.l 1
Map_Alien_Mem  rs.l	1
Map_allocdatasize rs.w 1
Map_allocx	rs.w 1
Map_allocy	rs.w 1
Map_X_Val	rs.w 1
Map_Y_Val	rs.w 1

map_Details
	dc.w 16
	dc.w 20
	dc.w 16
	dc.w 4
	dc.w 0
	dc.l 0
	dc.l 0	
	dc.w 0
	dc.w 0
	dc.w 0
	dc.w 0
	dc.w 0
		
Map_Details2		
	dc.w 16		
	dc.w 20
	dc.w 16
	dc.w 4
	dc.w 0
	dc.l 0
	dc.l 0	
	dc.w 0
	dc.w 0
	dc.w 0
	dc.w 0
	dc.w 0

map_backup_details
	ds.w 5 

current_map_ptr	dc.l	map_details

setupstr1 dc.b -2,10,"Block Size    8",$a
          dc.b "             16",$a
          dc.b "             32",$a,$a
	  dc.b "Map X Size ",$a,$a
	  dc.b "Map Y Size ",$a
          dc.b $a
	  dc.b "No. Of Planes 1  2",$a
          dc.b "              3  4",$a
          dc.b "              5  6",$a
          dc.b "              7  8",$a
	  dc.b " Data Size    B",$a
	  dc.b "              W"	
          dc.b 0
	  EVEN

Setup_Request_Window
	dc.w	240
	dc.w	191
	dc.w	40
	dc.w	0
	dc.l	0
	dc.l	0
	dc.b	"MAP SETUP",0
	even		


setup_buttons
	dc.l	setup_ok_button,setup_cancel_button
	dc.l	mapx_up_button,mapx_down_button
	dc.l	mapy_up_button,mapy_down_button
map_block_ticks
	dc.l	map_block_type8,map_block_type16
	dc.l	map_block_type32
map_plane_ticks
	dc.l	map_planes1,map_planes2,map_planes3
	dc.l	map_planes4,map_planes5,map_planes6
	dc.l	map_planes7,map_planes8
	dc.l	data_sizeb,data_sizew,-1

setup_Ok_Button
	dc.w	32
	dc.w	135+26
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	change_map_setup
	dc.b	0		
	even

setup_cancel_Button
	dc.w	32+80
	dc.w	135+26
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	cancel_setup_window
	dc.b	0		
	even


mapx_Up_Button
	dc.w	136+30
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	up_x_routine
	dc.b	0		
	EVEN						

mapx_down_Button
	dc.w	136+48
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down 
	dc.l	0	;not used
	dc.l	down_x_routine
	dc.b	0		
	EVEN						

mapy_Up_Button
	dc.w	136+30
	dc.w	70
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	up_y_routine
	dc.b	0		
	EVEN						

mapy_down_Button
	dc.w	136+48
	dc.w	70
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	down_y_routine
	dc.b	0		
	EVEN						

map_block_type8
	dc.w	158
	dc.w	6
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	8
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_block_size
	dc.b	0		
	EVEN						

map_block_type16
	dc.w	158
	dc.w	6+11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	16
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l    change_block_size
	dc.b	0		
	EVEN						

map_block_type32
	dc.w	158
	dc.w	6+22
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	32
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_block_size
	dc.b	0		
	EVEN						

map_planes1
	dc.w	158
	dc.w	84+11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN						

map_planes2
	dc.w	158+28
	dc.w	84+11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN						

map_planes3
	dc.w	158
	dc.w	84+22
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN						

map_planes4
	dc.w	158+28
	dc.w	84+22
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN						

map_planes5
	dc.w	158
	dc.w	84+33
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN		
	
map_planes6
	dc.w	158+28
	dc.w	84+33
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	6
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN							

map_planes7
	dc.w	158
	dc.w	84+44
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	7
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN		
	
map_planes8
	dc.w	158+28
	dc.w	84+44
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	8
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_planes
	dc.b	0		
	EVEN							



data_sizeb
	dc.w	158
	dc.w	84+55
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_data_size
	dc.b	0		
	EVEN						

data_sizew
	dc.w	158
	dc.w	84+66
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	tick_box_button	;not used
	dc.l	0	;not used
	dc.l	change_data_size
	dc.b	0		
	EVEN						

