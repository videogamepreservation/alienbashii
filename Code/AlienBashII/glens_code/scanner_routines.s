
*********************************************
****  SET UP SCANNER DATA                ****
*********************************************
Setup_Scanner_Data
	bsr	Clear_Hostage_Indicators
	move.l	#scanner_point_data,scanner_points_list_end
	move.w	#$ffff,scanner_point_data
	move.w	#$ffff,points_on_scanner
	bsr	Setup_Points_Of_Interest
	bsr	Dim_Scanner
	rts

*********************************************
****  CONVERT CLIP DATA                  ****
*********************************************
Convert_Clip_Data

	move.l	#scanner_x_clip_data,a0
	move.w	#31-1,d0
convert_data_loop
	move.w	(a0),d1
	mulu	#(1152/31),d1
	move.w	d1,(a0)+	
	move.w	(a0),d1
	mulu	#(1152/31),d1
	subq.w	#1,d1	;cos bits on scanner two high
	move.w	d1,(a0)+
	dbra	d0,convert_data_loop		
	rts
	
*********************************************
****  SETUP POINTS OF INTEREST           ****
*********************************************
Setup_Points_Of_Interest
	clr.w	number_of_hostages

	move.l current_alien_map_pointer,a5
	moveq	#0,d1
	move.l	#generic_map_header,a1
	
	move.w	map_data_y(a1),d3
	subq.w	#1,d3
scanner_x_loop	
	moveq	#0,d0
	move.w	map_data_x(a1),d2
	subq.w	#1,d2
	move.l	a5,a0
scanner_setup_loop
	move.b	(a0),d5
	cmp.b	#GENERATOR,d5
	bne.s	check_for_hos
	move.w	d0,generator_x
	move.w	d1,generator_y
	move.l	a0,generator_map_pos
check_for_hos	
	cmp.b	#HOSTAGE,d5
	bne.s	keep_checking_map
	addq.w	#1,number_of_hostages
	bsr	Add_Scanner_Point
keep_checking_map
	addq.l	#1,a0
	add.w	#16,d0
	subq.w	#1,d2
	bne.s	scanner_setup_loop
	add.l	#BIGGEST_MAP_X,a5	;next line
	add.w	#16,d1
	subq.w	#1,d3
	bne.s	scanner_x_loop
	bsr	Display_Hostage_Indicators
	rts
	
DOT_DIST	EQU	72	

*********************************************
****  REMOVE HOSTAGE SCANNER POINT       ****
*********************************************
Remove_Hostage_Scanner_Point
*alien info in a1
	moveq	#0,d7	;use as flag
	move.l #scanner_point_data,a0
	move.l a0,a5
remove_hos_loop
	cmp.w	#$ffff,(a0)
	beq.s	found_end_of_list		
	
	tst	d7
	bne.s	copy_list_data
	
	move.l	scanner_map_pos(a0),a4
	cmp.l	alien_map_pos(a1),a4
	bne.s	copy_list_data
	moveq	#1,d7
	bra.s	update_list_pos
copy_list_data
	move.l	scanner_point_x(a0),scanner_point_x(a5)
	move.l	scanner_map_pos(a0),scanner_map_pos(a5)
	add.l	#scanner_data_size,a5
update_list_pos
	add.l	#scanner_data_size,a0	
	bra.s	remove_hos_loop
found_end_of_list
	move.w	#$ffff,(a5)
	move.l	a5,scanner_points_list_end
	
	subq.w	#1,number_of_hostages
	bne	not_collected_all_hostages
	move.w	number_of_hostages,d7
	bsr	Remove_Hostage_Char
	rts
not_collected_all_hostages	
	move.w	number_of_hostages,d7
	bsr	Remove_Hostage_Char
	rts
	
	
*************************************************
****     COLLECTED LAST HOSTAGE             *****	
*************************************************
Collected_Last_Hostage
*use block d6 and d7 pos

	move.w	#-1,number_of_hostages

	move.l	#scanner_point_data,a2
	move.l	generator_map_pos,a0
	move.w	generator_x,d0
	move.w	generator_y,d1
	sub.w	#DOT_DIST,d1
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2
	add.w	#DOT_DIST,d1
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2	
	sub.w	#DOT_DIST,d0
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2
	add.w	#DOT_DIST*2,d0
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2
	sub.w	#DOT_DIST,d0
	add.w	#DOT_DIST,d1
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2
	move.w	#$ffff,(a2)

	move.w	d6,d0
	andi.w	#$fff0,d0
	move.w	d7,d1
	sub.w	#160,d1 
	move.l	#Fire_Key_object,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_Switch,sound_chan4
	rts
	
*********************************************
****  ADD SCANNER POINT                  ****
*********************************************
Add_Scanner_Point

	move.l	scanner_points_list_end,a2
	move.w	d0,scanner_point_x(a2)
	move.w	d1,scanner_point_y(a2)			
	move.l	a0,scanner_map_pos(a2)
	add.l	#scanner_data_size,a2
	move.w	#$ffff,(a2)
	move.l	a2,scanner_points_list_end

	rts	

scanner_points_list_end
	dc.l	scanner_point_data	
	
*********************************************
****  DISPLAY POINTS ON SCANNER          ****
*********************************************
Display_Points_On_Scanner

	clr.w	d2	
	moveq	#0,d0
	moveq	#0,d1
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	
	move.w	d1,d3
	sub.w	#240*2,d1
	add.w	#240*2,d3
	sub.w	#288*2,d0

	move.l	#scanner_x_clip_data,a2
	move.l	#scanner_point_data,a0
	move.l	#points_on_scanner,a3
add_points_to_scanner_loop
	cmp.w	#$ffff,(a0)
	beq	done_adding_points_to_scanner

	move.w	scanner_point_y(a0),d4
	cmp.w	d1,d4
	ble	not_point_on_scanner
	cmp.w	d3,d4
	bgt	not_point_on_scanner	
	
	move.w	d0,d5
	move.w	d0,d6

*Test x against position using clipper 	
	sub.w	d1,d4
	ext.l	d4
	divs	#((240*4)/31)+1,d4	;number from 0 - 31
	ext.l	d4
	asl	#2,d4
	add.w	(a2,d4),d5
	move.w	scanner_point_x(a0),d7
	cmp.w	d5,d7
	ble	not_point_on_scanner
	

	add.w	2(a2,d4),d6
	cmp.w	d6,d7
	bgt	not_point_on_scanner
*Is point on scanner	(d7 = x and d4 = y)
	asr	#2,d4
	addq.b	#1,d2	
*Plot point on scanner
	sub.w	d0,d7
	moveq	#0,d6
	ext.l	d7
	divs	#(288*4)/31,d7	
	move.l	#scanner1+4,a4
	move.w	d7,d6
	asr	#4,d7	;get sprite 0 - 3
	muls	#(SCANNER_HEIGHT+2)*4,d7
	add.l	d7,a4		;get sprite
	addq.l	#4,a4		;get past header info

	clr.b	scanner_sprpos(a3)	
	moveq	#0,d7		;flag
	andi.w	#$f,d6
	cmp.w	#8,d6
	blt.s	in_first_byte
	subq.w	#8,d6
	addq.l	#1,a4
	moveq	#1,d7
in_first_byte	
	
	asl	#2,d4
	add.l	d4,a4		;actual place
		
	neg.b	d6
	add.b	#$7,d6		;pixel position
	
	move.l	a4,scanner_mem_pos(a3)
	move.b	d6,scanner_pix_pos(a3)
	
		
	bchg	d6,(a4)
	bchg	d6,4(a4)
		
	subq.b	#1,d6
	bge.s	not_gone_over_bound
	addq.l	#1,a4
	tst	d7
	beq.s	not_onto_next_sprite_draw
	add.l	#((SCANNER_HEIGHT+2)*4)-2,a4
	move.b	#1,scanner_sprpos(a3)
not_onto_next_sprite_draw	
		
	bchg	#7,(a4)
	bchg	#7,4(a4)
	bra.s	done_big_pix
not_gone_over_bound
	bchg	d6,(a4)
	bchg	d6,4(a4)
done_big_pix			
	

done_draw_point
	add.l	#scanner_pixels_size,a3
		
	
not_point_on_scanner	
	add.l	#scanner_data_size,a0
	bra	add_points_to_scanner_loop
done_adding_points_to_scanner	
	move.w	#$ffff,(a3)
	tst	d2
	beq.s	no_hostages_plotted
	bsr	Brighten_Scanner
	rts
no_hostages_plotted
	bsr	Dim_Scanner	
	rts	

*********************************************
****        BRIGHTEN  SCANNER            ****
*********************************************
Brighten_Scanner
	move.l	#sprite_cols+2,a0
	move.w	#$0d0,9*4(a0)
	move.w	#$0d0,13*4(a0)
	move.w	#$0a2,11*4(a0)
	move.w	#$0a2,15*4(a0)
	rts
	
*********************************************
****        DIM  SCANNER                 ****
*********************************************
Dim_Scanner
	move.l	#sprite_cols+2,a0
	move.w	#$0a0,9*4(a0)
	move.w	#$0a0,13*4(a0)
	move.w	#$071,11*4(a0)
	move.w	#$071,15*4(a0)
	rts	
		
	
*********************************************
****  DELETE POINTS FROM SCANNER         ****
*********************************************
Delete_Points_From_Scanner

	move.l	#points_on_scanner,a0
	moveq	#0,d0
delete_points_loop
	cmp.w	#$ffff,(a0)
	beq.s	all_points_deleted
	
	move.l	scanner_mem_pos(a0),a1
	move.b	scanner_pix_pos(a0),d0
	
	bchg	d0,(a1)
	bchg	d0,4(a1)
	subq.b	#1,d0
	bge.s	del_not_gone_over_bound
	addq.l	#1,a1
	tst.b	scanner_sprpos(a0)
	beq.s	not_onto_next_sprite_del	
	add.l	#((SCANNER_HEIGHT+2)*4)-2,a1
not_onto_next_sprite_del	
	bchg	#7,(a1)
	bchg	#7,4(a1)
	bra.s	done_del_big_pix
del_not_gone_over_bound
	bchg	d0,(a1)
	bchg	d0,4(a1)
done_del_big_pix	
	
	add.l	#scanner_pixels_size,a0
	bra.s	delete_points_loop	
all_points_deleted		
	rts

*****************************************
****** CLEAR KEY INDICATORS       *******
*****************************************
Clear_Key_Indicators

	move.l	#scanner1+39*4,a0
	move.l	#scanner2+39*4,a1
	move.w	#7-1,d0
clear_key_chars
	clr.w	(a0)
	clr.w	(a1)
	addq.l	#4,a0
	addq.l	#4,a1
	dbra	d0,clear_key_chars		
	rts

*****************************************
****** CLEAR HOSTAGE INDICATORS   *******
*****************************************
Clear_Hostage_Indicators

	move.l	#scanner1+33*4,a0
	move.l	#scanner2+33*4,a1
	move.w	#5-1,d0
clear_hos_chars
	clr.w	(a0)
	clr.w	(a1)
	addq.l	#4,a0
	addq.l	#4,a1
	dbra	d0,clear_hos_chars	
	rts

*********************************************
****  SET END KEY ON SCANNER             ****
*********************************************
Set_End_Key_On_Scanner
	move.l	#scanner1+33*4,a0
	move.l	#scanner2+33*4,a1
	
	move.w	#%0000000000010100,(a0)
	move.w	#%0011000000000000,(a1)
	
	move.w	#%0000000000010100,4(a0)
	move.w	#%0100100000000000,4(a1)

	move.w	#%0000000000111111,8(a0)
	move.w	#%1100100000000000,8(a1)

	move.w	#%0000000000000000,12(a0)
	move.w	#%0100100000000000,12(a1)

	move.w	#%0000000000000000,16(a0)
	move.w	#%0011000000000000,16(a1)
	
	rts

*****************************************
****** DISPLAY HOSTAGE INDICATORS *******
*****************************************
Display_Hostage_Indicators

	move.w	number_of_hostages,d0
	cmp.w	#7,d0
	ble.s	dont_draw_more_than_display
	move.w	#7,d0
dont_draw_more_than_display
	tst	d0
	beq.s	none_to_display
	
	subq.w	#1,d0
display_all_hos
	move.w	d0,d7
	bsr	Display_Hostage_Char
	dbra	d0,display_all_hos		
none_to_display
	rts
	
*****************************************
****** DISPLAY HOSTAGE CHAR       *******
*****************************************
Display_Hostage_Char
*send num in d7

	cmp.w	#7,d7
	ble.s	hostage_on_scanner
	rts
hostage_on_scanner


	cmp.w	#4,d7
	blt.s	second_sprite
	move.l	#scanner1+33*4,a0
	subq.w	#4,d7
	bra.s	copy_hostage_data_in
second_sprite	
	move.l	#scanner2+33*4,a0
copy_hostage_data_in
	lsl	#2,d7

	move.w	#$a,d6
	lsl	d7,d6
	or.w	d6,(a0)
	or.w	d6,4(a0)
	or.w	d6,12(a0)
	or.w	d6,16(a0)
	move.w	#$e,d6
	lsl	d7,d6
	or.w	d6,8(a0)		
	rts	


*****************************************
****** REMOVE HOSTAGE CHAR        *******
*****************************************
Remove_Hostage_Char
*send num in d7

	cmp.w	#7,d7
	ble.s	clear_hostage_on_scanner
	rts
clear_hostage_on_scanner

	cmp.w	#4,d7
	blt.s	clear_second_sprite
	move.l	#scanner1+33*4,a0
	subq.w	#4,d7
	bra.s	clear_hostage_data_in
clear_second_sprite	
	move.l	#scanner2+33*4,a0
clear_hostage_data_in
	lsl	#2,d7

	move.w	#$fff0,d6
	rol	d7,d6
	
	and.w	d6,(a0)
	and.w	d6,4(a0)
	and.w	d6,8(a0)
	and.w	d6,12(a0)
	and.w	d6,16(a0)

	rts	

*****************************************
******     DISPLAY KEY CHAR       *******
*****************************************
Display_Key_Char
*send num in d7

	cmp.w	#7,d7
	ble.s	key_on_scanner
	rts
key_on_scanner
	cmp.w	#4,d7
	blt.s	key_second_sprite
	move.l	#scanner1+39*4,a0
	subq.w	#4,d7
	bra.s	copy_key_data_in
key_second_sprite	
	move.l	#scanner2+39*4,a0
copy_key_data_in
	lsl	#2,d7

	move.w	#$4,d6
	lsl	d7,d6
	
	or.w	d6,(a0)
	or.w	d6,8(a0)
	or.w	d6,12(a0)
	or.w	d6,20(a0)
	
	move.w	#$a,d6
	lsl	d7,d6
	or.w	d6,4(a0)		
	
	move.w	#$c,d6
	lsl	d7,d6
	or.w	d6,16(a0)
	or.w	d6,24(a0)
	rts	

*****************************************
******    REMOVE KEY CHAR         *******
*****************************************
Remove_Key_Char
*send num in d7
	cmp.w	#7,d7
	ble.s	clear_key_on_scanner
	rts
clear_key_on_scanner


	cmp.w	#4,d7
	blt.s	key_clear_second_sprite
	move.l	#scanner1+39*4,a0
	subq.w	#4,d7
	bra.s	clear_key_data_in
key_clear_second_sprite	
	move.l	#scanner2+39*4,a0
clear_key_data_in
	lsl	#2,d7

	move.w	#$fff0,d6
	rol	d7,d6
	
	and.w	d6,(a0)
	and.w	d6,4(a0)
	and.w	d6,8(a0)
	and.w	d6,12(a0)
	and.w	d6,16(a0)
	and.w	d6,20(a0)
	and.w	d6,24(a0)

	rts	


	
generator_x	dc.w	0
generator_y	dc.w	0	
generator_map_pos dc.l	0