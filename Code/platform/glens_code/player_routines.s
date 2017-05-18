

*-------SPECIFIC PLAYER DETAILS----------------


SCALE_FACTOR EQU 50

PLAYER_FRAMES	EQU 8
PLAYER_SPIN_FRAMES	EQU	6
PLAYER_HEIGHT   EQU 31
PLAYER_HEIGHT_SCALED	EQU PLAYER_HEIGHT*SCALE_FACTOR
ATTACH		EQU 7
LOW_BIT		EQU	0
PLAYER_WIDTH	EQU 16
PLAYER_WIDTH_SCALED	EQU PLAYER_WIDTH*SCALE_FACTOR

PLAYER_HEAD_ALLOWANCE	EQu 6

*-----------------------------------------------



*---------------BASE VELOCITY EQUATES----------------


*-----FOR GROUND--------

INCREASE_VELOCITY	EQU 15
DECREASE_VELOCITY	EQU 5
PLAYER_BUM_REDUCE_VELOCITY	EQU 2
PLAYER_DROP_VELOCITY	EQU 15

REGULAR_WALK_SPEED	EQU 2*SCALE_FACTOR
MAX_WALK_SPEED		EQU 3*SCALE_FACTOR
	
MAX_DROP_VELOCITY	EQU 5

JUMP_START_VELOCITY				EQU	250
SPRING_JUMP_VELOCITY				EQU	412
PLAYER_DECREASE_JUMP_VELOCITY_GROUND		EQU	10
PLAYER_DECREASE_JUMP_VELOCITY_QUICK_GROUND	EQU	30




*-----FOR UNDERWATER------

UNDERWATER_JUMP_START_VELOCITY				EQU	JUMP_START_VELOCITY/3
UNDERWATER_PLAYER_DECREASE_JUMP_VELOCITY_GROUND		EQU	PLAYER_DECREASE_JUMP_VELOCITY_GROUND/4
UNDERWATER_PLAYER_DECREASE_JUMP_VELOCITY_QUICK_GROUND	EQU	PLAYER_DECREASE_JUMP_VELOCITY_QUICK_GROUND/4
UNDERWATER_PLAYER_DROP_VELOCITY				EQU	PLAYER_DROP_VELOCITY/4
UNDERWATER_INCREASE_VELOCITY				EQU	11
UNDERWATER_DECREASE_VELOCITY				EQU	4	
UNDERWATER_MAX_WALK_SPEED				EQU	MAX_WALK_SPEED/2
UNDERWATER_REGULAR_WALK_SPEED				EQU	REGULAR_WALK_SPEED/2


*---------------------------

*------FOR SNOW-------------

*---------------------------

*-----------------------------------------------------

PUFF_LIMIT		EQU 100	;after which add smoke if turning or spinning




*************************************
****** CHECK PLAYER VELOCITYS   *****
*************************************
check_player_velocitys
	
	tst.w	ydirec
	bmi.s	player_sliding_on_bum
	beq.s	reduce_speed
	bra.s	player_pushing_up_for_speed
player_sliding_on_bum
	move.l	#y_collision_fall_struct,a0
	move.l	block_data_struct(a0),a0
	btst.b	#SLOPE_FLAG,block_details(a0)
	beq	player_not_standing_on_slope

**block type in a0

	move.w	player_maximum_vel,maximum_velocity
***bit of code to increase players velocity down slope
	moveq	#0,d0
	move.b	velocity(a0),d0
	ext.w	d0
	move.w	d0,block_x_push
	bra.s	quit_y_vel
player_not_standing_on_slope	

player_pushing_up_for_speed
**player pushing up
	addq.w	#2,maximum_velocity		;if pushing up - increase maximum speed limit - until at max
	move.w	player_maximum_vel,d7
	cmp.w	maximum_velocity,d7
	bgt.s	quit_y_vel
	move.w	d7,maximum_velocity
	bra.s	quit_y_vel
reduce_speed		
***recuce velocity until normal
	subq.w	#3,maximum_velocity		;if not pushing up - gradually reduce max speed until at norm
	move.w	player_regular_walk_speed,d7
	cmp.w	maximum_velocity,d7
	blt.s	quit_y_vel
	move.w	d7,maximum_velocity
quit_y_vel

	rts



*************************************
****** DETERMINE PLAYER ACTIONS *****
*************************************
determine_player_actions

*this routine checks to see if player is pushing down
*and to see if player has fired and is using extra velocity

	

player_check_routines	
	tst.w	crouch		;if forced by y collision
	bne.s	player_is_pushing_down
	tst.w	ydirec
	bmi.s	player_is_pushing_down
	bra.s	player_not_pushing_down
player_push_up
	tst.w	last_up
	beq.s	player_shoot
	bra.s	player_not_pushing_down	
player_shoot	
	move.w	#1,last_up
	bra.s	quit_determine_routine
player_is_pushing_down
	move.w	#-1,ydirec
	move.w	#1,crouch
	move.w	#0,xdirec
	btst.b	#SPRING_FLAG,player_control_bits
	bne.s	player_not_pushing_down
	move.w	#0,fire
player_not_pushing_down
	
	move.w	#0,last_up
quit_determine_routine	
	btst.b	#SPRING_FLAG,player_control_bits
	beq.s	done_stop_jump
	move.w	#1,fire
done_stop_jump	
	btst.b	#BOUNCE_FLAG,player_control_bits
	beq.s	fin_det_actions	
	bclr.b	#SPRING_FLAG,player_control_bits
	bclr.b	#BOUNCE_FLAG,player_control_bits
fin_det_actions
	rts

last_up
	dc.w	0
crouch
	dc.w	0	

*************************************
****** ADD ON SCROLL OFFSETS    *****
*************************************
add_on_scroll_offsets


*********add on scroll adjust values

	move.w	scroll_adjust_value,d0
	sub.w	d0,player_x
	muls	#SCALE_FACTOR,d0
	sub.w	d0,player_x_scaled


	move.w	scroll_y_adjust_value,d0
	sub.w	d0,player_y
	muls	#SCALE_FACTOR,d0
	sub.w	d0,player_y_scaled


********added scroll adjust values



	rts


*************************************
****** UPDATE PLAYER            *****
*************************************
update_player

	

	bsr	determine_player_actions


*----------------do x collision-------------------
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d4
	moveq	#0,d0

	

	move.w	maximum_velocity,d4

	
	move.w	player_x_scaled,d0
	move.w	player_y_scaled,d1

	btst.b	#STUCK_FLAG,player_control_bits
	bne	bypass_all_x_player_movement


	
	move.w	player_x_velocity,d2
	add.w	block_x_push,d2
	move.w	#0,block_x_push

	tst	xdirec
	beq.s	test_bounds	
	bmi.s	player_moving_left
	move.w	player_increase_velocity,d5
	tst	d2
	bpl.s	no_skid_right
	subq.w	#5,d5
	cmp.w	#-PUFF_LIMIT,d2
	bgt.s	no_skid_right
	move.w	#1,add_player_smoke
no_skid_right	
	
	add.w	d5,d2
skip_add_vel_x
	bra.s	test_bounds
	
player_moving_left
	move.w	player_increase_velocity,d5
	tst.w	d2
	bmi.s	no_skid_left
	subq.w	#5,d5
	cmp.w	#PUFF_LIMIT,d2
	ble.s	no_skid_left
	move.w	#1,add_player_smoke
no_skid_left	
	tst	xdirec
	beq.s	skip_sub_vel_x
	sub.w	d5,d2
skip_sub_vel_x	

test_bounds
	tst	d2
	bmi.s	test_lower_bounds
	cmp.w	d4,d2
	ble.s	not_out
	move.w	d4,d2
	bra.s	not_out
test_lower_bounds
	neg.w	d4
	cmp.w	d4,d2
	bge.s	not_out
	move.w	d4,d2
not_out			
	tst	xdirec
	beq.s	reduce_velocity
	bra.s	update_x_pos	
reduce_velocity
	tst	ydirec
	bmi.s	on_bum
	move.w	player_decrease_velocity,d3
	bra.s	decrease_vel	
on_bum
	move.w	#PLAYER_BUM_REDUCE_VELOCITY,d3	
decrease_vel	
	tst	d2
	bpl.s	reduce_by_sub
	add.w	d3,d2
	ble.s	update_x_pos
	move.w	#0,d2
	bra.s	update_x_pos
reduce_by_sub
	sub.w	d3,d2
	bge.s	update_x_pos
	move.w	#0,d2

update_x_pos


	move.w	d2,player_x_velocity
	
	add.w	d2,d0
	bsr	do_x_collision

	cmp.w	#0,d0
	bge.s	player_within_min_x_bounds
	move.w	#0,d0
	bra.s	store_new_x_position
player_within_min_x_bounds		
	cmp.w	#(320-16)*SCALE_FACTOR,d0
	ble.s	store_new_x_position
	move.w	#(320-16)*SCALE_FACTOR,d0
	
store_new_x_position	
	move.w	d0,player_x_scaled


*------------------DONE X COLLISION--------------------------


*------------------DO JUMP AND FALL TESTS--------------------

bypass_all_x_player_movement

	moveq	#0,d0
	moveq	#0,d1


	move.w	player_y_scaled,d1
	move.w	player_x_scaled,d0

	tst	player_falling_flag
	bne	player_falling


	tst	start_jump
	bne	doing_jump

****player not jumped yet

	tst.w	fire
	bne	do_jump_code
*player not hit fire on joystick	
	clr.w	supress_repeat_jump
	bra	player_falling	
do_jump_code
	
	
	tst	supress_repeat_jump
	bne	player_falling


*----------------------------CODE FOR JUMP---------------
	
*****the in air flag is set in the y collision fall struct
*****so that if player is on a slope and it jumps and hits its head
*****it falls down to its position on the slope and is not forced
*****onto the block - routine checks previous value of in air , if
*****not in air then assumes moving down slope and so positions on block
*****rather than allows player to fall onto block!!!!
**********************************************************
	move.l	#y_collision_fall_struct,a0
	move.b	#1,in_air(a0)
	move.w	#0,player_slope_hit
**********************************************************	

	clr.w	player_falling_flag
	
	tst.w	sound_chan1
	bne.s	player_hit_alien_on_head
	move.w	jump_sfx,sound_chan1
player_hit_alien_on_head
	move.w	#1,start_jump
	move.w	#1,supress_repeat_jump
	clr.w	player_fall_velocity

	move.w	player_decrease_jump_velocity_normal,jump_decay
	btst.b	#SPRING_FLAG,player_control_bits
	beq.s	normal_jump
	
	move.w	#SPRING_JUMP_VELOCITY,player_jump_velocity
	move.w	#Sound_Spring,sound_chan1	;supress jump noise over spring
	bra.s	carry_on_with_jump	
normal_jump	
	move.w	player_start_jump_velocity,player_jump_velocity	
carry_on_with_jump	
	move.w	#6,default_jump	
	bra.s	player_still_holding_fire
doing_jump


	tst	fire
	bne.s	player_still_holding_fire
	
	tst.w	multiple_jump_flag
	beq.s	dont_test_for_multiple
	clr.w	supress_repeat_jump
dont_test_for_multiple	

	move.w	player_decrease_jump_velocity_quick,jump_decay
	tst	default_jump
	bne.s	player_still_holding_fire
	tst	player_jump_velocity
	bpl.s	player_still_holding_fire
	move.w	#1,player_falling_flag
	bra	player_falling	
player_still_holding_fire	
	tst	default_jump
	beq.s	reached_min
	subq.w	#1,default_jump
reached_min	
	move.w	player_jump_velocity,d7


	sub.w	d7,d1
	
	bsr	do_jump_collision
	move.l	#y_collision_jump_struct,a3
	tst.b	in_air(a3)
	bne.s	not_hit_head
****player has hit head on block so position head just under block 
****and make him fall
	move.w	top_block(a3),d1
	move.w	screen_y_position,d2	;make relative to screen again
	sub.w	d2,d1
	add.w	#16-PLAYER_HEAD_ALLOWANCE,d1	
	mulu	#SCALE_FACTOR,d1

	move.w	#1,player_falling_flag	

	move.l	a3,a4	;save for use in block hit routines
	move.l	block_data_struct(a3),a3
	bsr	perform_jump_block_effect
	bra.s	have_not_hit_ground_yet
not_hit_head

****
	move.l	#y_collision_fall_struct,a3
	tst.b	in_air(a3)
	bne.s	have_not_hit_ground_yet
	tst.w	player_slope_hit
	bne.s	have_not_hit_ground_yet
	move.w	#1,player_falling_flag	
have_not_hit_ground_yet	
****
	

***need to scroll screen in springing so set to tell scroll
	btst.b	#SPRING_FLAG,player_control_bits
	beq.s	not_springing	
	bclr.b	#SPRING_FLAG,player_control_bits
	move.w	#ACTION_PLAYER_SPRINGING,player_action
	bra.s	do_decay_jump
not_springing	
	cmp.w	#ACTION_PLAYER_SPRINGING,player_action
	beq.s	do_decay_jump	;dont reset until hit ground
	move.w	#ACTION_PLAYER_JUMPING,player_action
do_decay_jump	
	sub.w	jump_decay,d7
	move.w	d7,player_jump_velocity
	bgt.s	have_not_reached_end_of_velocitys
	move.w	#1,player_falling_flag
have_not_reached_end_of_velocitys		
	bra	done_jump
	
	
*------------------------DONE JUMP TESTS-------------------	
	
	
*------------------------DO FALLING CODE-------------------	

		
*** follwing will need to be called constantly
*** but with extra info about blocks		
player_falling		

	tst.l	player_object
	beq	do_the_fall_tests
*otherwise on platform - still do crouch collision though	
	bsr	perform_crouch_tests
	bra	done_jump
do_the_fall_tests	


	move.w	player_increase_fall_velocity,d7
	add.w	d7,player_fall_velocity
	cmp.w	#MAX_DROP_VELOCITY*SCALE_FACTOR,player_fall_velocity
	ble.s	within_range
	move.w	#MAX_DROP_VELOCITY*SCALE_FACTOR,player_fall_velocity
within_range
*do extra test - before y added	to ensure cannot skip over platforms
	bsr	do_player_fall_collision
	tst.b	in_air(a3)
	beq.s	initial_test_bad
	add.w	player_fall_velocity,d1
*done	

	bsr	do_player_fall_collision
	tst.b	in_air(a3)		;still falling?
	bne.s	player_in_air
initial_test_bad
	
	move.w	top_block(a3),d1
	move.w	screen_y_position,d2	;make relative to screen again
	sub.w	d2,d1

	mulu	#SCALE_FACTOR,d1	;position to sit
	sub.w	#PLAYER_HEIGHT_SCALED,d1
	
	
		
*-----------PERFORM TESTS TO SEE IF PLAYER CROUCHING UNDER BLOCKS-------

*send x,y in d0 and d1
	bsr	perform_crouch_tests

*------------DONE CROUCH TESTS-------------------------------------------

	move.l	a3,a4	;for use in perform_fall ... block
	move.l	block_data_struct(a3),a3
	bsr	perform_fall_block_effect
	
	move.w	#0,player_fall_velocity
	move.w	#0,start_jump
	move.w	#0,player_falling_flag
	move.w	#ACTION_PLAYER_ON_GROUND,player_action
	bra.s	done_jump
player_in_air
	tst	fire
	bne.s	player_not_let_up
	move.w	#0,supress_repeat_jump
player_not_let_up	
	move.w	#ACTION_PLAYER_FALLING,player_action
	move.w	#0,crouch
	move.w	#1,player_falling_flag
	tst.w	multiple_jump_flag
	beq.s	done_jump
	clr.w	start_jump
	clr.w	player_falling_flag
done_jump

*--------------------DONE ALL JUMP AND FALL TESTS---------------------


*--------------------test for player going off screen----------------


	cmp.w	#255*SCALE_FACTOR,d1
	ble.s	player_not_off_bottom
	move.w	#SQUIZ_DEAD,player_has_been_hit
player_not_off_bottom	
	move.w	d1,player_y_scaled			

*-----------------------CONVERT SCALED CO-ORDS TO NORMAL PIXEL------

	ext.l	d1
	divs	#SCALE_FACTOR,d1
	move.w	d1,player_y
	divs	#SCALE_FACTOR,d0
	move.w	d0,player_x
	
	add.w	screen_x_position,d0
	add.w	screen_y_position,d1
	
	move.w	d0,player_x_world
	move.w	d1,player_y_world
	
	rts
			
*************************************
****** PERFORM CROUCH TESTS       ***
*************************************

perform_crouch_tests	
	tst.w	ydirec
	bmi.s	do_crouch_tests
	bra.s	player_not_crouching
do_crouch_tests	
	move.w	#PLAYER_WIDTH-8,d3
	bsr	do_simple_collision
	tst	d4
	beq.s	player_not_crouching
***player stuck under block	
player_still_crouching	
	tst.w	crouch
	beq.s	player_not_crouching
	move.w	#-1,ydirec	;force to crouch
	tst.l	player_object
	bne.s	done_crouch_tests
	move.w	lastx_direc,d3
	asl.b	#6,d3
	add.w	d3,player_x_scaled
	bra.s	done_crouch_tests
player_not_crouching
	move.w	#0,crouch
done_crouch_tests
	rts	
	
*************************************
****** PERFORM FALL BLOCK EFFECT  ***
**************************************
perform_fall_block_effect
*send in pointer to collision structure in a4
	moveq	#0,d2
	move.b	block_type(a3),d2
	move.l	#block_effects_table,a3
	move.l	(a3,d2.w*4),a3
	jsr	(a3)
	rts

*************************************
****** PERFORM JUMP BLOCK EFFECT  ***
*************************************
perform_jump_block_effect
*send in pointer to collision structure in a4
	
	moveq	#0,d2
	move.b	block_type(a3),d2
	move.l	#block_jump_effects_table,a3
	move.l	(a3,d2.w*4),a3
	jsr	(a3)
	rts


*************************************
****** DO X COLLISION           *****
*************************************
do_x_collision
	
	movem.l	d0-d4/a0,-(sp)
	
	
	move.l	#x_collision_struct,a3
	add.w	#1*SCALE_FACTOR,d0	;1 pix in
	move.w	#PLAYER_WIDTH-2,d3	;size
	
***when testing for x check a height just inside character to allow
***a little leway	

	tst	crouch
	beq.s	not_crouching
	add.w	#15*SCALE_FACTOR,d1
	move.w	#PLAYER_HEIGHT-18,d4
	bra.s	go_and_check_x
not_crouching
	add.w	#12*SCALE_FACTOR,d1
	move.w	#PLAYER_HEIGHT-15,d4		;minus 4 due to 2 being added to start height position
***	
go_and_check_x	
	bsr	do_player_x_collision
	movem.l	(sp)+,d0-d4/a0

	tst	x_collision(a3)
	beq.s	have_not_hit_block
	tst	ydirec
	bmi.s	push_other_way
	move.w	#0,player_x_velocity
	bra.s	position_on_x
push_other_way
	move.w	#Sound_Headbutt,sound_chan1
	neg	player_x_velocity	
position_on_x	
	move.w	x_position(a3),d0
	mulu	#SCALE_FACTOR,d0
have_not_hit_block	
	rts
	
	
	
*************************************
****** DO PLAYER FALL COLLISION *****
*************************************
***d0 and d1 are the scaled velocitys
do_player_fall_collision
	
	movem.l	d0-d4/a0,-(sp)
	
	move.l	#y_collision_fall_struct,a3
	add.w	#PLAYER_HEIGHT_SCALED,d1
	move.w	#0,d4	;player not jumping
	
*player is 16 pixels wide - but have two pixels each side	
***area tested under player was reduced to 8 pixels as
**before it was possible to skate over some holes
	
	add.w	#4*SCALE_FACTOR,d0	;was 
	move.w	#PLAYER_WIDTH-8,d3	;size of area to test ; was
	bsr	do_player_y_collision
	movem.l	(sp)+,d0-d4/a0	
	rts

*************************************
****** DO JUMP        COLLISION *****
*************************************
***d0 and d1 are the scaled velocitys
do_jump_collision
	movem.l	d0-d3/a0,-(sp)

	move.l	#y_collision_jump_struct,a3

	move.w	#1,d4	;send jump flag
*player is 16 pixels wide - but have two pixels each side	
	add.w	#4*SCALE_FACTOR,d0	
	add.w	#PLAYER_HEAD_ALLOWANCE*SCALE_FACTOR,d1
	move.w	#PLAYER_WIDTH-8,d3	;size of area to test
	bsr	do_player_y_collision

	movem.l	(sp)+,d0-d3/a0
	movem.l	d0-d3/a0,-(sp)
*Have to do extra test to see if player has jumped into a slope!!!
*This code is exactly the same as the fall collision code
	move.l	#y_collision_fall_struct,a3
	add.w	#PLAYER_HEIGHT_SCALED,d1
	move.w	#0,d4	;player not jumping
	add.w	#4*SCALE_FACTOR,d0
	move.w	#PLAYER_WIDTH-8,d3	;size of area to test
	bsr	do_player_y_collision
	
	
	movem.l	(sp)+,d0-d3/a0
	rts
	
	
*************************************
****** DO SIMPLE COLLISION      *****
*************************************
do_simple_collision
	
	movem.l	d0-d3/a0,-(sp)

	add.w	#PLAYER_HEIGHT_SCALED-20*SCALE_FACTOR,d1
	add.w	#4*SCALE_FACTOR,d0

	move.w	#PLAYER_WIDTH-8,d3	;size of area to test
	
	ext.l	d0
	divs	#SCALE_FACTOR,d0
	add.w	screen_x_position,d0	;add on scroll offset
	ext.l	d1
	divs	#SCALE_FACTOR,d1
	add.w	screen_y_position,d1

	bsr	simple_y_collision
	movem.l	(sp)+,d0-d3/a0
	rts	


*************************************
****** ADD PLAYER EFFECTS       *****
*************************************
add_player_effects

	tst	add_player_smoke
	beq.s	no_add_smoke
	subq.w	#1,add_smoke_count
	bne.s	no_add_smoke
	move.w	#5,add_smoke_count	
	move.w	#0,add_player_smoke
	move.l	#y_collision_fall_struct,a0
	tst.b	in_air(a0)
	bne.s	no_add_smoke
	move.w	player_x_world,d0
	add.w	#8,d0		;frig
	move.w	player_y_world,d1
	add.w	#PLAYER_HEIGHT-4,d1

	move.w	#Smoke_Character,d2
	bsr	Add_An_Enemy

no_add_smoke		
	
	bsr	player_object_routines
	rts

*************************************
****** PLAYER UNDER WATER       *****
*************************************
player_under_water

	move.w	#MULT_ON,multiple_jump_flag
	move.w	#1,player_in_water
	move.w	#Sound_Water,jump_sfx
	move.w	#UNDERWATER_INCREASE_VELOCITY,player_increase_velocity		
	move.w	#UNDERWATER_DECREASE_VELOCITY,player_decrease_velocity	
	move.w	#UNDERWATER_PLAYER_DECREASE_JUMP_VELOCITY_GROUND,player_decrease_jump_velocity_normal		
	move.w	#UNDERWATER_PLAYER_DECREASE_JUMP_VELOCITY_QUICK_GROUND,player_decrease_jump_velocity_quick
	move.w	#UNDERWATER_PLAYER_DROP_VELOCITY,player_increase_fall_velocity			
	move.w	#UNDERWATER_JUMP_START_VELOCITY,player_start_jump_velocity
	move.w	#UNDERWATER_MAX_WALK_SPEED,player_maximum_vel
	move.w	#UNDERWATER_REGULAR_WALK_SPEED,player_regular_walk_speed
	rts

*************************************
****** PLAYER ON GROUND         *****
*************************************
player_on_ground

	clr.w	player_in_water
	move.w	#MULT_OFF,multiple_jump_flag
	move.w	#Sound_Jump,jump_sfx

*-WHEN IN WATER JUMP DECAY IS /4 SO WHEN IN AIR SET BACK---	
	move.w	jump_decay,d0
	asl.w	#2,d0
	move.w	d0,jump_decay
	
	move.w	player_jump_velocity,d0
	mulu	#3,d0
	move.w	d0,player_jump_velocity
*---
	

	move.w	#INCREASE_VELOCITY,player_increase_velocity		
	move.w	#DECREASE_VELOCITY,player_decrease_velocity	
	move.w	#PLAYER_DECREASE_JUMP_VELOCITY_GROUND,player_decrease_jump_velocity_normal		
	move.w	#PLAYER_DECREASE_JUMP_VELOCITY_QUICK_GROUND,player_decrease_jump_velocity_quick
	move.w	#PLAYER_DROP_VELOCITY,player_increase_fall_velocity			
	move.w	#JUMP_START_VELOCITY,player_start_jump_velocity
	move.w	#MAX_WALK_SPEED,player_maximum_vel
	move.w	#REGULAR_WALK_SPEED,player_regular_walk_speed			

	rts
	
*************************************
****** PLAYER ON SNOW           *****
*************************************
player_on_snow

	move.w	#MULT_OFF,multiple_jump_flag


	rts
	
*************************************
****** PLAYER ZERO GRAVITY      *****
*************************************
player_zero_gravity
	
	move.w	#MULT_OFF,multiple_jump_flag

	rts

*************************************
****** PLAYER OBJECT ROUTINES   *****
*************************************
player_object_routines

	move.l	#player_object_table,a0
	move.w	player_holding_object,d0
	move.l	(a0,d0.w*4),a0
	jsr	(a0)

	rts

player_object_table
	dc.l	player_not_holding_anything
	dc.l	player_holding_bat
	dc.l	player_holding_ball	
	dc.l	player_holding_bat

*---------------------PLAYER OBJECT ROUTINES------------

*************************************
****** PLAYER NOT HOLDING ANYTHING***
*************************************
player_not_holding_anything
	rts
	
*************************************
****** PLAYER HOLDING BAT         ***
*************************************
player_holding_bat
	
*test to see if player wielding bat
	moveq	#0,d1
	move.w	bat_frame,d1
	beq.s	dont_increase_bat_frame
	subq.w	#1,bat_timer
	bne.s	dont_increase_bat_frame
	move.w	#BAT_TIME,bat_timer

	addq.w	#1,d1
	cmp.w	#3,d1
	beq.s	player_swing_done
dont_increase_bat_frame	
	move.w	d1,bat_frame
	move.l	#bat_frame_table,a0
	asl.w	#3,d1
	add.l	d1,a0
	move.w	(a0)+,d2	;character
	move.w	(a0)+,d0	;x offset
	move.w	(a0),d1		;y offset
	add.w	player_x_world,d0
	add.w	player_y_world,d1
	bsr	Add_An_Enemy	
	tst	bat_frame
	beq.s	player_not_swinging
	bra.s	player_not_holding_bat
player_swing_done
	move.w	#0,bat_frame
	bra.s	player_not_holding_bat
player_not_swinging
	tst	fire2	
	beq.s	player_not_holding_bat
	move.w	#Sound_Swoosh,sound_chan1
	move.w	#1,bat_frame
	cmp.w	#BAT_N_BALL,player_holding_object
	bne.s	player_not_got_ball
	move.w	player_x_world,d0
	move.w	player_y_world,d1
	subq.w	#8,d1
	*move.w	#ThrowBall_Character,d2
	bsr	Add_An_Enemy
player_not_got_ball	
	move.w	#BAT_TIME,bat_timer
player_not_holding_bat
	

	rts
	
*************************************
****** PLAYER HOLDING BALL      *****
*************************************
player_holding_ball
	
	tst	ball_release_timer
	beq.s	skip_decrease	
	subq.w	#1,ball_release_timer
	bne.s	player_not_holding_ball

skip_decrease	

	tst	fire2
	beq.s	player_not_press_fire2
	tst	suppress_fire2
	bne.s	player_not_holding_ball
	move.w	#BALL_RELEASE_GAP,ball_release_timer

	move.w	#1,suppress_fire2
	move.w	#Sound_Chuck,sound_chan1
	move.w	player_x_world,d0
	move.w	player_y_world,d1
****following is a frig for the show
	tst	ydirec
	bpl.s	player_not_throwing_whilst_down
	add.w	#5,d1
player_not_throwing_whilst_down	
		
	move.w	#Baseball_Character,d2
	bsr	Add_An_Enemy

	
	tst	lastx_direc
	bpl.s	player_throwing_right
	move.l	Add_Enemy_Pointer,a1
	bset.b	#Alien_Left,Alien_Mode2(a1)
	
player_throwing_right
	bra.s	player_not_holding_ball
player_not_press_fire2
	move.w	#0,suppress_fire2
player_not_holding_ball	


	rts
	

*************************************
****** PLAYER HIT               *****
*************************************
player_hit

	cmp.w	#SQUIZ_DYING,player_death_flag
	beq	quit_player_hit_routine
	
	tst	player_invisible_timer
	bne	player_has_been_hit_already
	
***-put in code to see if player been hit
	cmp.w	#SQUIZ_DEAD,player_has_been_hit
	beq.s	player_dead_man
	cmp.w	#SQUIZ_BEEN_HIT,player_has_been_hit
	bne.s	player_not_hit	
	subq.w	#1,player_hits
	beq.s	player_dead_man
	move.w	#Sound_SquizHurt,sound_chan1
	move.w	#INVISIBLE_TIME,player_invisible_timer			
	bra.s	player_has_been_hit_already
player_dead_man	
	move.w	#SQUIZ_DYING,player_death_flag
	bsr	decrease_lives
	bsr	do_lives
	move.w	#MAX_PLAYER_HITS,player_hits
	move.w	#PLAYER_HOLDING_NOTHING,player_holding_object
	clr.w	player_has_been_hit
	bra.s	quit_player_hit_routine
player_has_been_hit_already	
	clr.w	player_has_been_hit
	subq.w	#1,player_invisible_timer
	neg.w	draw_player_flag	;toggle		
	bra.s	quit_player_hit_routine	
player_not_hit	
	move.w	#1,draw_player_flag
	
	
quit_player_hit_routine
	rts

	
INVISIBLE_TIME	EQU	50*1
	
	

player_has_been_hit
	dc.w	0
player_invisible_timer
	dc.w	INVISIBLE_TIME
draw_player_flag
	dc.w	1

MAX_PLAYER_HITS	EQU	2

player_hits
	dc.w	MAX_PLAYER_HITS
player_death_flag
	dc.w	0


MULT_ON		EQU	1
MULT_OFF	EQU	0

*************************************
****** DO SQUIZ DEATH           *****
*************************************
do_squiz_death
	ifd	squiz_mortal
	subq.w	#1,leap_time
	beq.s	done_death_stuff
	move.w	player_y_scaled,d0
	
	cmp.w	#10*SCALE_FACTOR,leap_velocity
	bge.s	no_more_vel
	add.w	#24,leap_velocity
no_more_vel	
	add.w	leap_velocity,d0


	cmp.w	#(256-(PLAYER_HEIGHT+2))*SCALE_FACTOR,d0
	ble.s	player_ok_height
	tst	leap_velocity
	bpl	done_death_stuff
	move.w	#(256-(PLAYER_HEIGHT+2))*SCALE_FACTOR,d0
player_ok_height

	
	move.w	d0,player_y_scaled
	
	ext.l	d0
	divs	#SCALE_FACTOR,d0
	move.w	d0,player_y
	add.w	screen_y_position,d0
	move.w	d0,player_y_world
	rts	
done_death_stuff
	move.w	#-10*SCALE_FACTOR,leap_velocity
	move.w	#50*2,leap_time
	cmp.w	#"00",lives_text
	bne.s	player_not_finished_yet
	move.w	#Show_Title_Screen,Game_Flags
	move.w	#"03",lives_text
	bra.s	reset_params
player_not_finished_yet	
	move.w	#Level_Selection,Game_Flags
reset_params

	clr.w	player_death_flag
	endc
	rts
	
leap_velocity
	dc.w	-10*SCALE_FACTOR
leap_time	dc.w	50*2



*------PLAYER VELOCITY VARIABLES

player_increase_velocity		dc.w	0
player_decrease_velocity		dc.w	0
player_decrease_jump_velocity_normal	dc.w	0
player_decrease_jump_velocity_quick	dc.w	0
player_increase_fall_velocity		dc.w	0
player_start_jump_velocity		dc.w	0
player_maximum_vel			dc.w	0
player_regular_walk_speed		dc.w	0

*----------------------

ACTION_PLAYER_JUMPING		EQU	0
ACTION_PLAYER_ON_GROUND	EQU	1
ACTION_PLAYER_FALLING		EQU	2
ACTION_PLAYER_SPRINGING		EQU	3

player_action				dc.w	ACTION_PLAYER_ON_GROUND

jump_sfx				dc.w	0

multiple_jump_flag			dc.w	MULT_OFF

player_spin_frame			dc.w	0	

player_spin_timer			dc.w	0	


player_x_scaled 			dc.w 0

player_y_scaled 			dc.w 128*SCALE_FACTOR


player_x  				dc.w	0

player_y  				dc.w  	0

player_x_world 				dc.w	0

player_y_world 				dc.w  	0


player_fall_velocity			dc.w	0

default_jump				dc.w	0

player_falling_flag			dc.w	1	;start falling

start_jump				dc.w	0

player_timer				dc.w	0

supress_repeat_jump			dc.w	0

player_x_velocity  			dc.w 	0

player_y_velocity  			dc.w 	0

lastx_direc				dc.w	1

lasty_direc				dc.w	0


block_x_push				dc.w	0

player_jump_velocity			dc.w	300
	
jump_decay				dc.w	0

player_in_water				dc.w	0

maximum_velocity			dc.w	REGULAR_WALK_SPEED

add_player_smoke			dc.w	0

add_smoke_count				dc.w	5


SPRING_FLAG	EQU	0
STUCK_FLAG	EQU	1
BOUNCE_FLAG	EQU	2

player_control_bits			dc.b	0
					EVEN

****temporary

player_slope_hit	dc.w	0



BAT_TIME	EQU 4

suppress_fire2
	dc.w	0

bat_timer
	dc.w	BAT_TIME
	
bat_frame
	dc.w	0

bat_frame_table
	dc.w	BaseballBat1,-4,-2,0
	dc.w	BaseballBat2,-4+8,-2+19,0
	dc.w	BaseballBat3,-4+12+8,-2+8+19,0


PLAYER_HOLDING_NOTHING	EQU 	0
BASEBALL_BAT		EQU	1
BASE_BALL		EQU	2
BAT_N_BALL		EQU	3


player_holding_object
	dc.w		PLAYER_HOLDING_NOTHING

BALL_RELEASE_GAP	EQU	10

ball_release_timer
	dc.w	BALL_RELEASE_GAP

