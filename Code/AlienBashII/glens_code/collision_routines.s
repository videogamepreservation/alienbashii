

block_activation_table
	dc.l	Null_Routine
	dc.l	Player_On_Bridge 	;these used to be something
	dc.l	Null_Routine
	dc.l	Null_Routine
	dc.l	Null_Routine
	dc.l	Player_Stepped_On_Switch
	dc.l	Player_Activates_Event
	dc.l	Player_Activates_Door
	dc.l	Player_Activates_Door2	;second block of door
	dc.l	Player_Activates_Big_Door
	dc.l	Drop_Big_Key

***********************************************
*********   PLAYER ON BRIDGE          *********
***********************************************
Player_On_Bridge

	tst.b	man_direction
	beq.s	player_not_moving_on_bridge

	cmp.w	#1,man_frame_count
	bne.s	player_not_moving_on_bridge

	tst.w	player_current_frame
	beq.s	make_wood_noise
	cmp.w	#3,player_current_frame
	beq.s	make_wood_noise2
player_not_moving_on_bridge	
	rts
make_wood_noise	
	move.w	#Sound_Wood,sound_chan4
	rts
make_wood_noise2	
	move.w	#Sound_Wood2,sound_chan4	
	rts

	
***********************************************
*********   PLAYER ACTIVATES DOOR2    *********
***********************************************
Player_Activates_Door2
	sub.w	#16,d6		;nice dodgy code - i.e slip into next routine
	subq.l	#2,a0	

***********************************************
*********   PLAYER ACTIVATES DOOR     *********
***********************************************
Player_Activates_Door

	tst	Number_Of_Keys
	bne.s	use_key
	rts
use_key
	subq.w	#1,Number_Of_Keys	

	clr.l	(a0)	;clear those blocks/stop multiple blocks added

	move.l	#Use_Key_On_Door,a5		
	lsr	#4,d6	;get block x,y	
	move.w	d6,2(a5)
	lsr	#4,d7
	move.w	d7,4(a5)
	subq.w	#1,d7
	move.w	d6,16(a5)
	move.w	d7,18(a5)
	subq.w	#1,d7
	move.w	d6,30(a5)
	move.w	d7,32(a5)
		
	move.l	switch_list_pointer,a1
	move.l	a5,(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
	
	move.w	Number_of_Keys,d7
	bsr	Remove_Key_Char
	
	rts


***********************************************
*********  PLAYER ACTIVATES BIG DOOR  *********
***********************************************
Player_Activates_Big_Door

	tst	end_of_level_key
	bne.s	use_eol_key
	rts
use_eol_key
	clr.w	end_of_level_key
*Find out which block was activated
	move.w	(a0),d0
	sub.w  #285,d0
	lsl	#4,d0	;find block
	sub.w	d0,d6

	clr.l	(a0)	;clear those blocks/stop multiple blocks added
	sub.w	#16,d6

	move.l	#Blow_Up_Big_Door,a5		
	lsr	#4,d6	;get block x,y	
	move.w	d6,2(a5)
	lsr	#4,d7
	move.w	d7,4(a5)
	subq.w	#1,d7
	move.w	d6,20(a5)
	move.w	d7,22(a5)
	subq.w	#1,d7
	move.w	d6,38(a5)
	move.w	d7,40(a5)
	subq.w	#1,d7
	move.w	d6,56(a5)
	move.w	d7,58(a5)

		
	move.l	switch_list_pointer,a1
	move.l	a5,(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer	
	rts

	
	
***********************************************
*********  REMOVE SWITCH              *********
***********************************************	
Remove_Switch
	
	move.w	d6,d0
	move.w	d7,d1
	andi.w	#$fff0,d0
	andi.w	#$fff0,d1
	move.l	#Switch_Cover_Object,d2
	bsr	Simple_Add_Alien_To_List
	move.w	scroll_x_position,d2
	andi.w	#$fff0,d2
	sub.w	d2,d0
	sub.w	scroll_y_position,d1
	move.l	#Switch_Down_Graphics,a5
	bsr	Draw_Block_Into_Copyback
	move.w	#Sound_Switch,sound_chan4

	rts

***********************************************
*********  REMOVE BLUE SWITCH         *********
***********************************************	
Remove_Blue_Switch
	
	move.w	d6,d0
	move.w	d7,d1
	andi.w	#$fff0,d0
	andi.w	#$fff0,d1
	move.l	#Switch_Blue_Cover_Object,d2
	bsr	Simple_Add_Alien_To_List
	move.w	scroll_x_position,d2
	andi.w	#$fff0,d2
	sub.w	d2,d0
	sub.w	scroll_y_position,d1
	move.l	#Switch_Blue_Down_Graphics,a5
	bsr	Draw_Block_Into_Copyback
	move.w	#Sound_Switch,sound_chan4

	rts
	

***********************************************
*********  PLAYER STEPPED ON SWITCH   *********
***********************************************
Player_Stepped_On_Switch
*d4 = block number
	
	sub.w	#FIRST_SWITCH_BLOCK,d4
	
	move.l	#switch_table,a1
	ext.l	d4
	asl	#2,d4
	move.l	(a1,d4),d5
	beq.s	empty_switch_entry	
	move.l	switch_list_pointer,a1
	move.l	d5,(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
empty_switch_entry
	cmp.w	#8,d4
	bgt.s	stepped_on_blue_switch	
	move.w	#402,(a0)
	bsr	Remove_Switch
	rts
stepped_on_blue_switch
	move.w	#403,(a0)
	bsr	Remove_Blue_Switch
	rts


***********************************************
*********       DROP BIG KEY          *********
***********************************************
Drop_Big_Key

	tst.w	number_of_hostages
	bne.s	not_all_collected_yet
	bsr	Collected_Last_Hostage
not_all_collected_yet
	rts	
	

***********************************************
*********  PLAYER ACTIVATES EVENT     *********
***********************************************
Player_Activates_Event
*d4 = block number

	sub.w	#FIRST_EVENT_BLOCK,d4
	move.l	#event_table,a0
	ext.l	d4
	asl	#2,d4
	move.l	(a0,d4),d7
	beq.s	empty_activate_entry
	clr.l	(a0,d4)		;cant activate event again
	move.l	switch_list_pointer,a1
	move.l	d7,(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
empty_activate_entry
	rts	
	

***********************************************
*********  WHAT IS PLAYER STANDING ON *********
***********************************************
What_Is_Player_Standing_On

*Init vars

*a0 will point to area


*
	move.l	current_map_pointer,a0

	moveq	#0,d0
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	
	add.w	#16,d0	;position right in middle of player
	add.w	#16,d1
	
	move.w	d0,d6	;x and y pos
	move.w	d1,d7

	asr	#4,d0
	asr	#4,d1	
	mulu	#BIGGEST_MAP_X*2,d1
	add.l	d1,a0
	asl	d0
	add.l	d0,a0	;gives block
	moveq	#0,d0	
	move.w	(a0),d0
	move.w	d0,d4
	
	
	asl.w	#BLOCK_STRUCT_MULT,d0

	move.l	#block_data_information,a1
	moveq	#0,d1
	move.b	block_type(a1,d0.l),d1
	andi.w	#$0f,d1		;mask off unwanted data
	beq.s	nothing_to_run	
	lsl	#2,d1
	move.l	#block_activation_table,a1
	move.l	(a1,d1),a1
	jsr	(a1)	
nothing_to_run
	rts

Null_Routine
	rts
	
Slope_Down_Right_Routine
	tst	last_x_direc
	beq.s	skip_move
	add.w	#32,player_move_x
skip_move	
	rts	


PLAYER_ON_SLOPE_RIGHT		EQU	0

player_move_x			dc.w	0
player_move_y			dc.w	0

PLAYER_TEST_HEIGHT	EQU	15
PLAYER_TEST_WIDTH	EQU	15


***********************************************
*********  DO PLAYER Y COLLISION      *********
***********************************************
Do_Player_Y_Collision
*test player sides
*d0 and d1 sent

	add.w	#8,d0	;add in a bit so collision not big square round player
	add.w	#12,d1
	move.l	#y_collision_struct,a3
	move.w	#PLAYER_TEST_WIDTH,d3
	bsr	test_y_collision_side
	tst.w	y_collision(a3)
	beq.s	test_other_sidey
	add.w	#16-12,y_position(a3)
	bra.s	done_y_collision
test_other_sidey	
	add.w	#16,d1
	move.l	#y_collision_struct,a3
	move.w	#PLAYER_TEST_WIDTH,d3
	bsr	test_y_collision_side
	tst.w	y_collision(a3)
	beq.s	done_this_sidey
	sub.w	#16+12,y_position(a3)
	bra.s	done_y_collision
done_this_sidey
	sub.w	#12,d1
done_y_collision		
	rts

***********************************************
*********  DO PLAYER X COLLISION      *********
***********************************************
Do_Player_X_Collision

*test player sides
*d0 and d1 sent

	add.w	#8,d0		;add in a bit
	add.w	#12,d1
	move.l	#x_collision_struct,a3
	move.w	#PLAYER_TEST_HEIGHT,d4
	bsr	test_x_collision_side
	tst.w	x_collision(a3)
	beq.s	test_other_side
	add.w	#16-8,x_position(a3)
	bra.s	done_x_collision
test_other_side	
	add.w	#16,d0
	move.l	#x_collision_struct,a3
	move.w	#PLAYER_TEST_HEIGHT,d4
	bsr	test_x_collision_side
	tst.w	x_collision(a3)
	beq.s	no_collision_this_side
	sub.w	#16+8,x_position(a3)
	bra.s	done_x_collision
no_collision_this_side
	sub.w	#16+8,d0
	rts	
done_this_side
	sub.w	#8,d0
done_x_collision
	rts
	
***********************************************
*********  TEST Y COLLISION SIDE      *********
***********************************************
Test_Y_Collision_Side

*send in x and y in d0,d1 and width in d3
*send struct in a3

	move.l	current_map_pointer,a0
	addq.l	#MAP_BLOCK_SIZE,a0
***********Obtain first map block  ****************************	
	moveq	#0,d2
	move.w	d1,d2	
	move.w	d2,d4	
	asr.w	#4,d2		;give map y line
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d2
	add.l	d2,a0	
	move.l	a0,a1
	moveq	#0,d2
	move.w	d0,d2
	andi.w	#$fff0,d2
	asr.w	#3,d2	;word map		;get map x pos
	move.l	a0,a2				;store for later
	add.l	d2,a0				;where currently is
	
*************first map block in a0*****************************	

*******************Do tests on first block tested**************
	moveq	#0,d2
	clr.l	y_block_left(a3)	;clears sign as well
	move.w	(a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a4

	btst.b	#COLLISION_FLAG,block_details(a4,d2)
	bne.s	simple_hit_block_left
******************Done tests on first block********************

******************Do tests on second block*********************
do_tests_on_sec_block
	
simple_test_next_block_in_line
	moveq	#0,d2
	move.w	d0,d2
	add.w	d3,d2
	andi.w	#$fff0,d2
	asr.w	#3,d2	;cos word map
	move.l	a1,a0
	add.l	d2,a0
	moveq	#0,d2
	move.w	(a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2

	btst.b	#COLLISION_FLAG,block_details(a4,d2)
	bne.s	simple_hit_block_right
	
simple_not_hit_a_block	
	clr.w	y_collision(a3)
	bra.s	quit_simple_y_collision
simple_hit_block_right

	move.w	#1,y_block_sign(a3)
simple_hit_block_left
	
	move.w	#1,y_collision(a3)
	andi.w	#$fff0,d4
	move.w	d4,y_position(a3)

*Determine status of blocks left and right of hit point

	moveq	#0,d2
	move.w	-MAP_BLOCK_SIZE(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2			
	btst.b	#COLLISION_FLAG,block_details(a4,d2)
	beq.s	block_left_free
	move.b	#1,y_block_left(a3)
block_left_free
	moveq	#0,d2
	move.w	MAP_BLOCK_SIZE(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2			
	btst.b	#COLLISION_FLAG,block_details(a4,d2)
	beq.s	quit_simple_y_collision
	move.b	#1,y_block_right(a3)
	
quit_simple_y_collision
	rts	


	

***********************************************
*********  TEST X COLLISION SIDE      *********
***********************************************
test_x_collision_side
*send in d0 and d1 the x and y  - not scaled
*send height in d4
*send x collision struct in a3

*routine does not hurt d0 or d1

	move.l	current_map_pointer,a0
	add.l	#MAP_BLOCK_SIZE,a0
	moveq	#0,d2
	move.w	d1,d2	
	add.w	d1,d4			;test block below if height bigger than one block
	asr.w	#4,d2
	asr.w	#4,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d2		;give map y line
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	move.l	a0,a1
	add.l	d4,a1
	add.l	d2,a0				;position in map data of object
	
	
	
	moveq	#0,d2
	move.w	d0,d4				;save player x for use in positioning if player hit block
	move.w	d0,d2
	andi.w	#$fff0,d2
	asr.w	#3,d2	;word map		;get map x pos
	add.l	d2,a1
	add.l	d2,a0				;where currently is


	clr.l	x_block_up(a3)	;clears sign as well
	moveq	#0,d2
	move.l	#block_data_information,a2

	move.w	(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2

	btst.b	#COLLISION_FLAG,block_details(a2,d2)
	bne.s	have_hit_top_block

	move.l	a1,a0	
	moveq	#0,d2
	move.w	(a1),d2
	asl.w	#BLOCK_STRUCT_MULT,d2
	
	btst.b	#COLLISION_FLAG,block_details(a2,d2)
	bne.s	have_hit_bottom_block
		
	clr.w	x_collision(a3)
	bra.s	finished_x_collision
have_hit_bottom_block
	move.w	#1,x_block_sign(a3)	
have_hit_top_block	
	move.w	#1,x_collision(a3)
	andi.w	#$fff0,d4	
	move.w	d4,x_position(a3)
	add.l	d2,a2
	move.l	a2,x_block_data_struct(a3)

	
*Determine status of blocks above and below hit point	

	move.l	#block_data_information,a2
	moveq	#0,d2
	move.w	-(BIGGEST_MAP_X*MAP_BLOCK_SIZE)(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2			
	btst.b	#COLLISION_FLAG,block_details(a2,d2)
	beq.s	block_up_free
	move.b	#1,x_block_up(a3)
block_up_free
	move.w	(BIGGEST_MAP_X*MAP_BLOCK_SIZE)(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2			
	btst.b	#COLLISION_FLAG,block_details(a2,d2)
	beq.s	finished_x_collision
	move.b	#1,x_block_down(a3)
	
finished_x_collision			
	rts
	

	

	rsreset
	
x_collision		rs.w	1	
x_position		rs.w	1
x_block_data_struct	rs.l	1
x_block_mem_pos		rs.l	1
x_block_up		rs.b	1
x_block_down		rs.b	1
x_block_sign		rs.w	1

	
		
x_collision_struct
	dc.w	0	
	dc.w	0
	dc.l	0
	dc.l	0
	dc.w	0
	dc.w	0
	
	rsreset
	
y_collision		rs.w	1	
y_position		rs.w	1
y_block_data_struct 	rs.l	1
y_block_mem_pos		rs.l	1
y_block_left		rs.b	1
y_block_right		rs.b	1
y_block_sign		rs.w	1	
	EVEN


y_collision_struct
	dc.w	0
	dc.w	0
	dc.l	0	
	dc.l	0
	dc.w	0
	dc.w	0

