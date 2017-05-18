BIT_LEFT	EQU	0
BIT_RIGHT	EQU	1
BIT_UP		EQU	2
BIT_DOWN	EQU	3


PLAYER_UP	  EQU	4
PLAYER_DOWN	  EQU	8
PLAYER_LEFT	  EQU	1
PLAYER_RIGHT	  EQU	2
PLAYER_UP_LEFT	  EQU	5
PLAYER_UP_RIGHT	  EQU	6
PLAYER_DOWN_LEFT  EQU	9
PLAYER_DOWN_RIGHT EQU	10


NUMBER_PLAYER_FRAMES	EQU	6
MAN_WALK_FRAME_SPEED		EQU	4
MAN_RUN_SPEED		EQU	3
PLAYER_HEIGHT		EQU	32

ATTACH	EQU	7



PLAYER_INCREMENT	EQU	64+64
PLAYER_SCALE		EQU	6	;for asl


BOX_LEFT		EQU	130
BOX_RIGHT		EQU	288-130
BOX_UP			EQU	110
BOX_DOWN		EQU	240-130


****************************************
****     CONTROL METHOD 2          *****
****************************************
Control_Method_2

*player can walk and shoot

	move.w	player_current_frame,d1
	moveq	#0,d0
	move.b	man_direction,d0
	beq.s	player_stopped
	move.w	d0,last_direction
player_stopped
	tst	last_x_direc
	bne.s	pnot_zero
	tst	last_y_direc
	bne.s	pnot_zero
	bra.s	player_not_changed_direction

pnot_zero
	subq.w	#1,man_frame_count
	bne.s	dont_update_frame
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
update_frame	
	addq.w	#1,d1
	cmp.w	#NUMBER_PLAYER_FRAMES,d1
	blt.s	dont_update_frame
	move.w	#0,d1
	bra.s	dont_update_frame
player_not_changed_direction

	move.w	last_direction,d0
	clr.w	player_current_frame	;player has stopped moving
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
dont_update_frame

	move.w	d1,player_current_frame
	rts


****************************************
****     CONTROL METHOD 1          *****
****************************************
Control_Method_1

*player cannot walk and shoot

	move.w	player_current_frame,d1
	moveq	#0,d0
	move.b	man_direction,d0
	beq.s	player_stopped2
	move.w	d0,last_direction
	tst.w	fire
	beq.s	player_stopped2
	clr.w	last_x_direc
	clr.w	last_y_direc
	clr.b	man_direction
	clr.w	d1		;player has stopped moving
	bra.s	player_not_changed_direction2
player_stopped2
	tst	last_x_direc
	bne.s	pnot_zero2
	tst	last_y_direc
	bne.s	pnot_zero2
	bra.s	player_not_changed_direction2

pnot_zero2
	subq.w	#1,man_frame_count
	bne.s	dont_update_frame2
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
update_frame2	
	addq.w	#1,d1
	cmp.w	#NUMBER_PLAYER_FRAMES,d1
	blt.s	dont_update_frame2
	move.w	#0,d1
	bra.s	dont_update_frame2
player_not_changed_direction2

	move.w	last_direction,d0
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
dont_update_frame2

	move.w	d1,player_current_frame
	rts

****************************************
****     CONTROL METHOD 3          *****
****************************************
Control_Method_3

*player will walk and shoot unless shooting began before
*player moving

	move.w	player_current_frame,d1
	moveq	#0,d0
	move.b	man_direction,d0
	beq.s	player_has_stopped
	move.w	d0,last_direction
	tst.w	stop_flag
	beq.s	player_stopped3
player_has_stopped	
	tst.w	fire
	beq.s	player_stopped3
	move.w	#1,stop_flag
	clr.w	last_x_direc
	clr.w	last_y_direc
	clr.b	man_direction
	clr.w	d1
	bra.s	player_not_changed_direction3
player_stopped3
	clr.w	stop_flag
	tst	last_x_direc
	bne.s	pnot_zero3
	tst	last_y_direc
	bne.s	pnot_zero3
	bra.s	player_not_changed_direction3
pnot_zero3
	subq.w	#1,man_frame_count
	bne.s	dont_update_frame3
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
update_frame3
	addq.w	#1,d1
	cmp.w	#NUMBER_PLAYER_FRAMES,d1
	blt.s	dont_update_frame3
	move.w	#0,d1
	bra.s	dont_update_frame3
player_not_changed_direction3

	move.w	last_direction,d0
	move.w	#MAN_WALK_FRAME_SPEED,man_frame_count
dont_update_frame3

	move.w	d1,player_current_frame
	rts

stop_flag
	dc.w	0

current_control_method
	dc.l	Control_Method_1

****************************************
****        MOVE PLAYER            *****
****************************************
move_player

	tst	player_start_moving_count
	beq.s	player_moving_now
	subq.w	#1,player_start_moving_count
player_moving_now	

	move.l	current_control_method,a0
	jsr	(a0)
	
	move.w	player_x_position,d0
	move.w	player_y_position,d1

	moveq	#0,d7
	move.b	man_direction,d7
	move.l	#man_increments,a5
	asl	#2,d7
	bne.s	man_still_moving
	
	
	
	tst	player_start_moving_count
	beq.s	player_on_the_move
	move.w	#32,d6
	bra.s	slow_down_p
player_on_the_move
	move.w	#8,d6
slow_down_p	
			
	tst	last_x_direc
	bpl.s	x_red
	add.w	d6,last_x_direc
	ble.s	do_y_direc
	clr.w	last_x_direc
	bra.s	do_y_direc
x_red
	sub.w	d6,last_x_direc
	bge.s	do_y_direc
	clr.w	last_x_direc
do_y_direc	
	tst	last_y_direc
	bpl.s	y_red
	add.w	d6,last_y_direc
	ble.s	done_direc
	clr.w	last_y_direc
	bra.s	done_direc
y_red
	sub.w	d6,last_y_direc
	bge.s	done_direc
	clr.w	last_y_direc	
done_direc	
	tst	last_x_direc
	bne.s	apply_direc
	tst	last_y_direc
	bne.s	apply_direc
	move.w	#PLAYER_WAIT_COUNT,player_start_moving_count
	bra.s	apply_direc
man_still_moving	
	move.w	(a5,d7),last_x_direc
	move.w	2(a5,d7),last_y_direc
	
apply_direc	
	
	moveq	#0,d7
	add.w	last_x_direc,d0
	tst.w	last_x_direc
	bne.s	dont_add_y_shift
	add.w	player_move_x,d0
	clr.w	player_move_x
dont_add_y_shift

	move.w	d0,d5
	asr.w	#PLAYER_SCALE,d0
	asr.w	#PLAYER_SCALE,d1

	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	bsr	do_player_x_collision
	tst.w	x_collision(a3)
	beq.s	no_collision_on_x
	move.w	x_position(a3),d5
	move.w	d5,d0
	sub.w	scroll_x_position,d5
	asl.w	#PLAYER_SCALE,d5
	move.w	d5,player_x_position
	
*Do shift analysis - if pushing correct way
	tst.w	last_x_direc
	beq.s	now_test_y
	
	tst.w	x_block_sign(a3)
	beq.s	x_up_hit
x_down_hit
	tst.b	x_block_up(a3)
	bne.s	now_test_y
	move.w	#-1<<PLAYER_SCALE,d7
	bra.s	now_test_y
x_up_hit	
	tst.b	x_block_down(a3)
	bne.s	now_test_y
	move.w	#1<<PLAYER_SCALE,d7
	bra.s	now_test_y
no_collision_on_x
	move.w	d5,player_x_position
	
now_test_y		
*d0 = still contains position of playerx


	move.w	player_y_position,d1
	
	add.w	last_y_direc,d1
	tst.w	last_y_direc
	bne.s	dont_add_x_shift
	add.w	player_move_y,d1
	clr.w	player_move_y
dont_add_x_shift	
	
	move.w	d1,d6	

	asr.w	#PLAYER_SCALE,d1 
	add.w	scroll_y_position,d1

	bsr	do_player_y_collision
	tst.w	y_collision(a3)
	beq.s	no_collision_on_y
	move.w	y_position(a3),d6
	move.w	d6,d1
	sub.w	scroll_y_position,d6
	asl.w	#PLAYER_SCALE,d6
	move.w	d6,player_y_position
	
*Do shift analysis
	tst.w	last_y_direc
	beq.s	done_collision
	tst.w	y_block_sign(a3)
	beq.s	y_left_hit
y_right_hit
	tst.b	y_block_left(a3)
	bne.s	done_collision
	move.w	#-1<<PLAYER_SCALE,player_move_x
	bra.s	done_collision		
y_left_hit	
	tst.b	y_block_right(a3)
	bne.s	done_collision
	move.w	#1<<PLAYER_SCALE,player_move_x
	bra.s	done_collision
no_collision_on_y		
	move.w	d6,player_y_position	
done_collision		
	move.w	d7,player_move_y
	rts


last_x_direc		dc.w	0
last_y_direc		dc.w	0


****************************************
****  EXPLODE PLAYER               *****
****************************************
Explode_Player
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	move.l	#Player_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	rts


****************************************
****  FLASH PLAYER                 *****
****************************************
Flash_Player

	tst	Player_Invincible_Timer
	bne	Ghost_Player
	tst	Flash_Request
	beq.s	Test_If_Flash_On
	
	cmp.w	#4*4,Player_Current_Energy
	bge.s	flash_player_with_white
	move.w	#$f00,d1
	bra.s	start_flashing
flash_player_with_white
	move.w	#$fff,d1
start_flashing		

	 
	move.l	#Sprite_cols+6,a0
	move.w	d1,(a0)
	move.w	d1,4(a0)
	move.w	d1,8(a0)
	move.w	d1,12(a0)
	move.w	d1,16(a0)
	move.w	d1,20(a0)
	move.w	d1,24(a0)
	move.w	d1,28(a0)
	
	move.w	d1,36(a0)
	move.w	d1,44(a0)
	move.w	d1,52(a0)

	clr.w	Flash_Request
	move.w	#1,Flash_Flag
	bsr	Update_Player_Energy
	rts

Test_If_Flash_On
	tst	Flash_Flag
	beq.s	Dont_Bother_Reset
	
	bsr	Restore_Colours_Norm
	
Dont_Bother_Reset	
	rts
	
Ghost_Player
	subq.w	#1,Player_Invincible_Timer
	beq.s	Restore_Player
	bchg	#0,Invincible_flag
	rts			
Restore_Player
	clr.b	Invincible_Flag
	rts	
	
Player_Invincible_Timer
	dc.w	0
Invincible_Flag
	dc.b	0
	even	
	
Flash_Flag
	dc.w	0
Flash_Request
	dc.w	0		

PLAYER_DIE	EQU	0

Player_Flags
	dc.b	0
	even		
	
****************************************
****  RESTORE_COLOURS_NORM         *****
****************************************
Restore_Colours_Norm	

	move.l	#Sprite_Cols+6,a0
	move.l	sprite_palette,a1
	addq.l	#2,a1	
	
	move.w	(a1)+,(a0)
	move.w	(a1)+,4(a0)
	move.w	(a1)+,8(a0)
	move.w	(a1)+,12(a0)
	move.w	(a1)+,16(a0)
	move.w	(a1)+,20(a0)
	move.w	(a1)+,24(a0)
	move.w	(a1)+,28(a0)
	
	move.w	2(a1),36(a0)
	move.w	6(a1),44(a0)
	move.w	10(a1),52(a0)

	rts
	
****************************************
****  FLASH RED PLAYER             *****
****************************************
Flash_Red_Player

	
	bchg	#0,red_flag
	beq.s	norm_player	
	move.w	#$f00,d1
	move.l	#Sprite_cols+6,a0
red_sprite_cols

	move.w	d1,(a0)
	move.w	d1,4(a0)
	move.w	d1,8(a0)
	move.w	d1,12(a0)
	move.w	d1,16(a0)
	move.w	d1,20(a0)
	move.w	d1,24(a0)
	move.w	d1,28(a0)
	
	move.w	d1,36(a0)
	move.w	d1,44(a0)
	move.w	d1,52(a0)
	rts
norm_player	
	bsr	Restore_Colours_Norm
	rts	

red_flag
	dc.b	0
	EVEN		
	
****************************************
****  WORK OUT SCROLL MOVEMENT     *****
****************************************
Work_Out_Scroll_Movement	

*First do bounds on player

	move.w	player_x_position,d0
	move.w	player_y_position,d1


	cmp.w	#0,d0
	bge.s	test_other_edge_x
	move.w	#0,d0
	bra.s	test_y_player_bounds
test_other_edge_x
	cmp.w	#(320-32-16)<<PLAYER_SCALE,d0
	ble.s	test_y_player_bounds
	move.w	#(320-32-16)<<PLAYER_SCALE,d0
test_y_player_bounds	
	
	cmp.w	#0,d1
	bge.s	test_other_edge_y
	move.w	#0,d1
	bra.s	done_player_bounds
test_other_edge_y
	cmp.w	#(240-PLAYER_HEIGHT)<<PLAYER_SCALE,d1
	ble.s	done_player_bounds
	move.w	#(240-PLAYER_HEIGHT)<<PLAYER_SCALE,d1
done_player_bounds
		
	move.w	d0,player_x_position
	move.w	d1,player_y_position		
		
	asr.w	#PLAYER_SCALE,d0
	asr.w	#PLAYER_SCALE,d1
	
	move.w	d0,d2
	move.w	d1,d3
	
	add.w	#16,d0	;cos border

	move.w	d0,actual_x_position
	move.w	d1,actual_y_position	

	
	add.w	scroll_x_position,d2	;after collision
	add.w	scroll_y_position,d3

	move.w	d2,d4
	move.w	d3,d5
	
	
	sub.w	last_scrollx_position,d2
	sub.w	last_scrolly_position,d3
	
	tst	d2
	bpl.s	p_going_right
p_going_left
	cmp.w	#BOX_LEFT,d0
	bgt.s	clear_x_inc
	bra.s	test_y
p_going_right
	cmp.w	#BOX_RIGHT,d0
	blt.s	clear_x_inc
	bra.s	test_y
clear_x_inc
	moveq	#0,d2
	
test_y	
	tst	d3
	bpl.s	p_going_down
p_going_up
	cmp.w	#BOX_UP,d1
	bgt.s	clear_y_inc
	bra.s	done_y_tests
p_going_down
	cmp.w	#BOX_DOWN,d1
	blt.s	clear_y_inc
	bra.s	done_y_tests
clear_y_inc
	moveq	#0,d3
done_y_tests		
				

	move.w	d2,player_x_inc
	move.w	d3,player_y_inc

	move.w	d4,last_scrollx_position
	move.w	d5,last_scrolly_position


	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1
	
	
	move.w	d0,actual_player_map_x_position
	move.w	d1,actual_player_map_y_position		
	rts

SPIN_SPEED	EQU	1

****************************************
****     SPIN PLAYER               *****
****************************************
Spin_Player

	tst	spin_speed_counter
	bne.s	dont_spin_yet
	move.w	#SPIN_SPEED,spin_speed_counter
	move.l	spin_table_pos,a0
	move.w	(a0)+,last_direction
	tst	(a0)
	bpl.s	not_at_end_of_spin_list
	move.l	#spin_table,a0
not_at_end_of_spin_list	
	move.l	a0,spin_table_pos
	rts	
dont_spin_yet	
	subq.w	#1,spin_speed_counter
	rts

	

spin_speed_counter
	dc.w	0
	
spin_table
	dc.w	4,6,2,10,8,9,1,5,-1
	
spin_table_pos	
	dc.l	spin_table	


****************************************
****        DISPLAY PLAYER         *****
****************************************
Display_Player
	move.w	last_direction,d0
	move.w	player_current_frame,d1
	move.l	#man_frames,a0
	asl	#2,d0
	move.l	(a0,d0),a0
	asl	#2,d1
	move.l	(a0,d1),a0	;current sprite
	bsr	Display_Sprite_Data
	rts
	
****************************************
****     REMOVE PLAYER             *****
****************************************
Remove_Player
	move.l	#Blank_Data,d0

	move.w	d0,sprite0l
	move.w	d0,sprite1l
	move.w	d0,sprite2l
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite0h
	move.w	d0,sprite1h
	move.w	d0,sprite2h
	move.w	d0,sprite3h

	rts
	
****************************************
****     DISPLAY SPRITE DATA       *****
****************************************
Display_Sprite_Data
	move.w	actual_x_position,d7
	move.w	actual_y_position,d6
	
	move.w	d7,d0
	move.w	d6,d1
	move.w	#PLAYER_HEIGHT,d2
	bsr	position_any_sprite
	bset.b	#ATTACH,3(a0)
	move.l	a0,a1
	add.l	#MAN_SPRITE_SIZE,a1
	move.l	(a0),(a1)

	move.l	a0,d0
	move.w	d0,sprite0l
	swap	d0
	move.w	d0,sprite0h
	
		
	move.l	a1,d0
	move.w	d0,sprite1l
	swap	d0
	move.w	d0,sprite1h



	add.l	#MAN_SPRITE_SIZE,a1
	move.l	a1,a0
	add.w	#16,d7
	move.w	d7,d0
	move.w	d6,d1
	move.w	#PLAYER_HEIGHT,d2
	
	bsr	position_any_sprite
	bset.b	#ATTACH,3(a0)
	move.l	a0,a1
	add.l	#MAN_SPRITE_SIZE,a1
	move.l	(a0),(a1)

	move.l	a0,d0

	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	
	move.l	a1,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h


	rts



PLAYER_WAIT_COUNT	EQU	10

player_start_moving_count
	dc.w	PLAYER_WAIT_COUNT

* below will change for boat etc

player_x_in			dc.w	8
player_y_in			dc.w	8

actual_player_map_x_position	dc.w	0
actual_player_map_y_position	dc.w	0

player_x_position		dc.w	100<<PLAYER_SCALE
player_y_position		dc.w	100<<PLAYER_SCALE

actual_x_position		dc.w	100
actual_y_position		dc.w	100

player_x_inc			dc.w	0
player_y_inc			dc.w	0

last_scrollx_position		dc.w	100	;scroll+player pos
last_scrolly_position		dc.w	100

man_frame_count	dc.w	MAN_WALK_FRAME_SPEED
man_direction
	dc.b	PLAYER_UP
	even
	
last_direction
	dc.w	PLAYER_UP	

player_current_frame
	dc.w	0

*	8421
	
*	0000			-	no direction		0
*	0001			- 	left			1			
*	0010			-       right			2
*       0100			-       up			4
*	1000			-    	down			8
*	0101			-       up/left			5
*	0110			-	up/right		6
*	1001			-	down/left		9
*	1010			-	down/right		10


man_increments
	dc.w	0,0
	dc.w	-PLAYER_INCREMENT,0
	dc.w	PLAYER_INCREMENT,0
	dc.w	0,0
	dc.w	0,-PLAYER_INCREMENT
	dc.w	-PLAYER_INCREMENT,-PLAYER_INCREMENT
	dc.w	PLAYER_INCREMENT,-PLAYER_INCREMENT
	dc.w	0,0
	dc.w	0,PLAYER_INCREMENT
	dc.w	-PLAYER_INCREMENT,PLAYER_INCREMENT
	dc.w	PLAYER_INCREMENT,PLAYER_INCREMENT

fast_man_inc
	dc.w	0,0
	dc.w	-PLAYER_INCREMENT*2,0
	dc.w	PLAYER_INCREMENT*2,0
	dc.w	0,0
	dc.w	0,-PLAYER_INCREMENT*2
	dc.w	-PLAYER_INCREMENT*2,-PLAYER_INCREMENT*2
	dc.w	PLAYER_INCREMENT*2,-PLAYER_INCREMENT*2
	dc.w	0,0
	dc.w	0,PLAYER_INCREMENT*2
	dc.w	-PLAYER_INCREMENT*2,PLAYER_INCREMENT*2
	dc.w	PLAYER_INCREMENT*2,PLAYER_INCREMENT*2


man_frames
	dc.l	0			;0
	dc.l	frame_table_left	;1
	dc.l	frame_table_right	;2
	dc.l	0			;3
	dc.l	frame_table_up		;4
	dc.l	frame_table_up_left	;5
	dc.l	frame_table_up_right	;6
	dc.l	0			;7
	dc.l	frame_table_down	;8
	dc.l	frame_table_down_left	;9
	dc.l	frame_table_down_right	;10
	
	
MAN_SPRITE_SIZE	EQU	(PLAYER_HEIGHT+2)*4
MAN_FRAME_SIZE	EQU	MAN_SPRITE_SIZE*4

frame_table_left
	dc.l	man_left_graphics
	dc.l	man_left_graphics+MAN_FRAME_SIZE
	dc.l	man_left_graphics+MAN_FRAME_SIZE*2
	dc.l	man_left_graphics+MAN_FRAME_SIZE*3
	dc.l	man_left_graphics+MAN_FRAME_SIZE*4
	dc.l	man_left_graphics+MAN_FRAME_SIZE*5
	
frame_table_right
	dc.l	man_right_graphics
	dc.l	man_right_graphics+MAN_FRAME_SIZE
	dc.l	man_right_graphics+MAN_FRAME_SIZE*2
	dc.l	man_right_graphics+MAN_FRAME_SIZE*3
	dc.l	man_right_graphics+MAN_FRAME_SIZE*4
	dc.l	man_right_graphics+MAN_FRAME_SIZE*5
	

frame_table_up
	dc.l	man_up_graphics
	dc.l	man_up_graphics+MAN_FRAME_SIZE
	dc.l	man_up_graphics+MAN_FRAME_SIZE*2
	dc.l	man_up_graphics+MAN_FRAME_SIZE*3
	dc.l	man_up_graphics+MAN_FRAME_SIZE*4
	dc.l	man_up_graphics+MAN_FRAME_SIZE*5

frame_table_down
	dc.l	man_down_graphics
	dc.l	man_down_graphics+MAN_FRAME_SIZE
	dc.l	man_down_graphics+MAN_FRAME_SIZE*2
	dc.l	man_down_graphics+MAN_FRAME_SIZE*3
	dc.l	man_down_graphics+MAN_FRAME_SIZE*4
	dc.l	man_down_graphics+MAN_FRAME_SIZE*5
		
	
frame_table_up_left
	dc.l	man_up_left_graphics
	dc.l	man_up_left_graphics+MAN_FRAME_SIZE
	dc.l	man_up_left_graphics+MAN_FRAME_SIZE*2
	dc.l	man_up_left_graphics+MAN_FRAME_SIZE*3
	dc.l	man_up_left_graphics+MAN_FRAME_SIZE*4
	dc.l	man_up_left_graphics+MAN_FRAME_SIZE*5


		
	
frame_table_up_right
	dc.l	man_up_right_graphics
	dc.l	man_up_right_graphics+MAN_FRAME_SIZE
	dc.l	man_up_right_graphics+MAN_FRAME_SIZE*2
	dc.l	man_up_right_graphics+MAN_FRAME_SIZE*3
	dc.l	man_up_right_graphics+MAN_FRAME_SIZE*4
	dc.l	man_up_right_graphics+MAN_FRAME_SIZE*5

frame_table_down_left
	dc.l	man_down_left_graphics
	dc.l	man_down_left_graphics+MAN_FRAME_SIZE
	dc.l	man_down_left_graphics+MAN_FRAME_SIZE*2
	dc.l	man_down_left_graphics+MAN_FRAME_SIZE*3
	dc.l	man_down_left_graphics+MAN_FRAME_SIZE*4
	dc.l	man_down_left_graphics+MAN_FRAME_SIZE*5


	
frame_table_down_right
	dc.l	man_down_right_graphics
	dc.l	man_down_right_graphics+MAN_FRAME_SIZE
	dc.l	man_down_right_graphics+MAN_FRAME_SIZE*2
	dc.l	man_down_right_graphics+MAN_FRAME_SIZE*3
	dc.l	man_down_right_graphics+MAN_FRAME_SIZE*4
	dc.l	man_down_right_graphics+MAN_FRAME_SIZE*5
	
Shake_Screen
	move.l	Shake_Pointer,a0
	move.w	scroll_x_position,d0
	move.w	scroll_y_position,d1
	add.w	(a0)+,d0
	add.w	(a0)+,d1
	
	tst	d0
	bge.s	x_screen_within_min
	clr.w	d0
x_screen_within_min	
	cmp.w	map_x_size,d0
	ble.s	x_screen_within_max
	move.w	map_x_size,d0
x_screen_within_max

	tst	d1
	bge.s	y_screen_within_min
	clr.w	d1
y_screen_within_min	
	cmp.w	map_y_size,d1
	ble.s	y_screen_within_max
	move.w	map_y_size,d1
y_screen_within_max

	move.w	d0,scroll_x_position
	move.w	d1,scroll_y_position

	cmp.w	#$ffff,(a0)
	bne.s	not_at_end_of_shake_list
	move.l	#Shake_Data,a0
not_at_end_of_shake_list		
	move.l	a0,Shake_Pointer
	rts

Shake_Data
	dc.w	 0,1
	dc.w	-2,-3
	dc.w	 3,3
	dc.w	-2,4
	dc.w	-2,-2
	dc.w	1,0
	dc.w	0,-3
	dc.w	2,0
	dc.w	$ffff
	
Shake_Pointer	dc.l	Shake_Data

old_sx	dc.w	0
old_sy	dc.w	0
		
count_down_to_death
	dc.w	0
