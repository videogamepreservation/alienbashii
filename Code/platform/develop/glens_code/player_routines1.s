

****player specifics

PLAYER_FRAMES	EQU 2
PLAYER_HEIGHT   EQU 20
ATTACH		EQU 7



INCREASE_VELOCITY	EQU 15
DECREASE_VELOCITY	EQU 5

PLAYER_DROP_VELOCITY	EQU 15

*************************************
****** UPDATE PLAYER            *****
*************************************
update_player

	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	move.w	maximum_velocity,d4
	move.w	player_x_scaled,d0
	move.w	player_y_scaled,d1
	
	move.w	player_x_velocity,d2
	tst	xdirec
	beq.s	reduce_velocity
	
	tst	xdirec
	bmi.s	player_moving_left
	move.w	#INCREASE_VELOCITY,d5
	tst	d2
	bpl.s	no_skid_right
	subq.w	#5,d5
no_skid_right	
	
	add.w	d5,d2
	cmp.w	d4,d2
	ble.s	update_x_pos
	move.w	d4,d2
	bra.s	update_x_pos
	
player_moving_left
	move.w	#INCREASE_VELOCITY,d5
	tst.w	d2
	bmi.s	no_skid_left
	subq.w	#5,d5
no_skid_left	
	sub.w	d5,d2
	neg.w	d4
	cmp.w	d4,d2
	bge.s   update_x_pos
	move.w	d4,d2
	bra.s	update_x_pos
	
reduce_velocity
	tst	d2
	bpl.s	reduce_by_sub
	add.w	#DECREASE_VELOCITY,d2
	ble.s	update_x_pos
	move.w	#0,d2
	bra.s	update_x_pos
reduce_by_sub
	sub.w	#DECREASE_VELOCITY,d2
	bge.s	update_x_pos
	move.w	#0,d2

update_x_pos
	move.w	d2,player_x_velocity
	
	add.w	d2,d0
	
	move.w	d0,player_x_scaled
	
***and now jump

	tst	player_falling_flag
	bne	player_falling
	tst	start_jump
	bne.s	doing_jump

****player not jumped yet
	tst.w	fire
	bne	do_jump_code
	tst	player_landed
	beq	done_jump
	move.w	#0,player_landed
	bra	done_jump
do_jump_code
	tst	player_landed
	bne	done_jump	
	move.w	#0,player_falling_flag
	move.w	#1,start_jump
	move.w	#250,player_jump_velocity
	move.w	#10,jump_decay
	move.w	#6,default_jump
	move.w	#0,player_fall_velocity	
	bra.s	player_still_holding_fire
doing_jump
	tst	fire
	bne.s	player_still_holding_fire
	move.w	#30,jump_decay
	tst	default_jump
	bne.s	player_still_holding_fire
	tst	player_jump_velocity
	bpl.s	player_still_holding_fire
	move.w	#1,player_falling_flag
	bra.s	player_falling	
player_still_holding_fire	
	tst	default_jump
	beq.s	reached_min
	subq.w	#1,default_jump
reached_min	
	move.w	player_jump_velocity,d7
	sub.w	d7,d1
	sub.w	jump_decay,d7
	move.w	d7,player_jump_velocity
	bgt.s	have_not_reached_end_of_velocitys
	move.w	#1,player_falling_flag
have_not_reached_end_of_velocitys		
	bra.s	done_jump
*** follwing will need to be called constantly
*** but with extra info about blocks		
player_falling		
	add.w	#PLAYER_DROP_VELOCITY,player_fall_velocity
	cmp.w	#6*SCALE_FACTOR,player_fall_velocity
	ble.s	within_range
	move.w	#6*SCALE_FACTOR,player_fall_velocity
within_range	
	add.w	player_fall_velocity,d1
	cmp.w	#128*SCALE_FACTOR,d1
	blt.s	done_jump
	move.w	#128*SCALE_FACTOR,d1
	move.w	#0,start_jump
	move.w	#0,player_falling_flag
	move.w	#1,player_landed
done_jump
	move.w	d1,player_y_scaled			


	divu	#SCALE_FACTOR,d0
	move.w	d0,player_x
	divu	#SCALE_FACTOR,d1
	move.w	d1,player_y
	move.w	#$0f0,$dff180
	rts
	
	
*************************************
****** DISPLAY PLAYER           *****
*************************************
display_player

***depeding on speed of player move legs

	moveq	#0,d4
	move.w	player_x_velocity,d4
	tst	d4
	bpl.s	ok_x_vel
	neg.w	d4
ok_x_vel	
	divu	#SCALE_FACTOR,d4
	move.w	#7,d6
	sub.w	d4,d6
	
	
	move.w	player_frame,d5
	addq.w	#1,player_timer
	cmp.w	player_timer,d6
	bgt.s   no_frame_update
	move.w	#0,player_timer		
	tst	player_x_velocity
	beq.s	frame_reset
	addq.w	#1,d5
	cmp.w	#PLAYER_FRAMES,d5
	blt.s	no_frame_update
frame_reset
	move.w	#0,d5	
no_frame_update	
	move.w	d5,player_frame
	mulu	#22*4*2,d5

	tst.w	xdirec
	bne.s	not_zeroed
	move.w	lastx_direc,d0
	bra.s	get_direction_graphics
not_zeroed
	move.w	xdirec,d0
	move.w	d0,lastx_direc
get_direction_graphics	

	tst	d0
	bmi.s	player_going_left
	move.l	#playerrightf1sp1,a0
	bra.s	position_player
player_going_left				
	move.l	#playerleftf1sp1,a0	
position_player
	
	add.l	d5,a0	
	move.w	player_x,d0
	move.w	player_y,d1
	move.w	#PLAYER_HEIGHT,d2
	move.w	d0,d3
	move.w	d1,d4
	bsr	position_any_sprite
	bset.b	#ATTACH,3(a0)
	move.l	a0,d0
	move.w	d0,sprite0l
	swap	d0
	move.w	d0,sprite0h
		
	add.l	#22*4,a0
	move.w	d3,d0
	move.w	d4,d1
	bsr	position_any_sprite

	bset.b	#ATTACH,3(a0)
	move.l	a0,d0
	move.w	d0,sprite1l
	swap	d0
	move.w	d0,sprite1h	

	rts


SCALE_FACTOR EQU 50


player_x_scaled dc.w 0
player_y_scaled dc.w 128*SCALE_FACTOR

player_x  dc.w	0
player_y  dc.w  0

player_fall_velocity	dc.w	0
default_jump	dc.w	4
player_falling_flag	dc.w	0

start_jump	dc.w	0

player_timer	dc.w	0

player_landed	dc.w	0

player_x_velocity  dc.w 0
player_y_velocity  dc.w 0

lastx_direc	dc.w	1
lasty_direc	dc.w	0

player_frame	dc.w	0


player_jump_velocity
	dc.w	300
	
jump_decay
	dc.w	0

maximum_velocity	dc.w	2*SCALE_FACTOR


jump_no_more
	dc.w	0
	
*************************************
****** POSITION ANY SPRITE      *****
*************************************
position_any_sprite
*send in data in a0
*x in d0

*y in d1
*height in d2

gendo_other_mouse_stuff
	add.w	#$81-1,d0	;tricky positioning
	move.b	#0,3(A0)
	asr.w	#1,d0
	bcc.s	genno_bit_set
	bset	#0,3(a0)
genno_bit_set	
	move.b	d0,1(a0)
	
	add.w	#$2c,d1
	btst	#8,d1
	beq.s	gennot_vert_set
	bset	#2,3(a0)
gennot_vert_set
	move.b	d1,(a0)	
	add.w	d2,d1
	btst	#8,d1
	beq.s	gennot_vstop_set
	bset	#1,3(a0)
gennot_vstop_set	
	move.b	d1,2(a0)
	rts


	
	
	