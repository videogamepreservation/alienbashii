
*************************************
****** CLEAN PLAYER             *****
*************************************
clean_player

*CLEARS ALL OLD SPRITE DATA FROM COPPER LIST

	move.l	old_sprite_pos,a4	;top of head

	move.w	#PLAYER_HEIGHT,d0
clear_top_and_bottom

	clr.w	(a4)		;clear top sprite data
	clr.w	4(a4)
	clr.w	8(a4)
	clr.w	12(a4)
	clr.w	16(a4)
	clr.w	20(a4)
	clr.w	24(a4)
	clr.w	28(a4)
	
	add.l	#SIZE_COP,a4
	cmp.l	#copper_sprite_mem_end,a4
	bge.s	stop_drawing	
	dbra	d0,clear_top_and_bottom
stop_drawing	
	rts	

	
*************************************
****** DISPLAY PLAYER           *****
*************************************
display_player


***depending on speed of player move legs


	tst	ydirec
	bmi	spin_player

	move.w	#0,started_spin
	moveq	#0,d4
	move.w	player_x_velocity,d4
	tst	d4
	bpl.s	ok_x_vel
	neg.w	d4
ok_x_vel	
	divu	#SCALE_FACTOR,d4
	move.w	#6,d6
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
	
	tst.w	player_falling_flag
	beq.s	is_player_jumping
	move.l	#fallright_table,a0
	moveq	#0,d5
	bra.s	do_right_player	
is_player_jumping
	tst	start_jump
	beq.s	player_not_jumping_right
	moveq	#0,d5
	move.l	#jumpright_table,a0
	bra.s	do_right_player	
player_not_jumping_right
	move.l	#player_walk_right,a0
do_right_player	
	move.w	#16,d6	;tail offset from body
	bra.s	position_player
	
player_going_left				
	tst.w	player_falling_flag
	beq.s	is_player_jumping2
	move.l	#fallleft_table,a0
	moveq	#0,d5
	bra.s	do_left_player
is_player_jumping2
	tst	start_jump
	beq.s	player_not_jumping_left
	moveq	#0,d5
	move.l	#jumpleft_table,a0
	bra.s	do_left_player	
player_not_jumping_left
	move.l	#player_walk_left,a0
do_left_player
	move.w	#-16,d6	;tail offset from body	
	
position_player

stuff_data_into_sprites	
	
	move.l	4(a0,d5.w*8),frame2
	move.l	(a0,d5.w*8),frame1

	move.w	d6,tail_pos

	moveq	#0,d0
	move.w	player_x,d0
	
	move.w	#1<<ATTACH,d1
	add.w	#$81-1,d0	;tricky positioning
	asr.w	#1,d0
	bcc.s	first_half_of_squiz
	move.w	#(1<<LOW_BIT)+1<<ATTACH,d1	
first_half_of_squiz
	move.w	d0,SPR0POS
	move.w	d1,SPR0CTL

	
	move.w	d0,SPR1POS
	move.w	d1,SPR1CTL
	
	moveq	#0,d0
	move.w	player_x,d0
	sub.w	d6,d0
	move.w	#1<<ATTACH,d1
	add.w	#$81-1,d0	
	asr.w	#1,d0
	bcc.s	second_half_of_squiz
	move.w	#(1<<LOW_BIT)+1<<ATTACH,d1	
second_half_of_squiz
	move.w	d0,SPR2POS
	move.w	d1,SPR2CTL

	move.w	d0,SPR3POS
	move.w	d1,SPR3CTL
	
	rts

	
*************************************
****** DRAW PLAYER              *****
*************************************

draw_player		

	cmp.w	#SQUIZ_DYING,player_death_flag
	bne.s	squiz_not_snuffing

	move.l	#spinright+SFS*0,frame1
	move.l	#tailright+SFS*0,frame2
squiz_not_snuffing
	move.l	frame1,a0
	move.l	frame2,a1

	move.w	tail_pos,d6
	bsr	clean_player	

	tst	draw_player_flag
	bmi	quit_draw_player
	
*-----------------CODE TO MOVE PLAYER SPRITE INTO COPPER--------

*sprite data in a0 and a1
	
	move.w	#(PLAYER_HEIGHT+2)-1,d7	;height of data to copy
	move.w	player_y,d0
	bpl	player_visible_on_screen

	add.w	d0,d7		;amount of data to copy
	tst	d7
	ble	quit_draw_player
	neg.w	d0
	moveq	#0,d6
	move.w	d0,d6		;start height of data
	moveq	#0,d0		;draw from top of copper		
	asl.w	#2,d6
	add.l	d6,a0		;clip data start draw position
	add.l	d6,a1	
	bra	player_still_on_screen
player_visible_on_screen	

	cmp.w	#(255-16)-(PLAYER_HEIGHT+2),d0
	ble.s	player_still_on_screen
	
	
	sub.w	#(255-16)-(PLAYER_HEIGHT+2),d0	;d0 = amount off screen
	sub.w	d0,d7			;amount of player to draw
	tst	d7
	ble	quit_draw_player
	add.w	#(255-16)-(PLAYER_HEIGHT+2),d0	;ensure dont draw over end of copper
player_still_on_screen	
	mulu	#SIZE_COP,d0	;get start
	move.l	#copper_sprite_mem,a2
	add.l	d0,a2
	move.l	a2,a3
	move.l	a3,a4
	move.l	a4,a5
	add.l	#SPRITE1B+2,a2
	move.l	a2,old_sprite_pos
	add.l	#SPRITE2B+2,a3
	
	add.l	#SPRITE3B+2,a4
	add.l	#SPRITE4B+2,a5

	move.w	d7,d0
copy_player_into_sprites

*-------FIRST SPRITE PLANE
	move.w	2(a0),(a2)	;plane 1 into data b
	move.w	2(a1),(a4)
	move.w	(a0),4(a2)	;plane 2 into data a	
	move.w	(a1),4(a4)

*-------SECOND SPRITE PLANE
	move.w	(PLAYER_HEIGHT+2)*4+2(a0),(a3)	;plane 1 into data b
	move.w	(PLAYER_HEIGHT+2)*4+2(a1),(a5)
	move.w	(PLAYER_HEIGHT+2)*4(a0),4(a3)	;plane 2 into data a	
	move.w	(PLAYER_HEIGHT+2)*4(a1),4(a5)

	add.l	#SIZE_COP,a2
	add.l	#SIZE_COP,a3
	add.l	#SIZE_COP,a4
	add.l	#SIZE_COP,a5
	
	addq.l	#4,a0
	addq.l	#4,a1
	
	dbra	d0,copy_player_into_sprites

quit_draw_player
	rts

spin_player

	moveq	#0,d4
	move.w	player_x_velocity,d4
	tst	d4
	bpl.s	ok_x_vel_spin
	neg.w	d4
ok_x_vel_spin	
	divu	#SCALE_FACTOR,d4
	cmp.w	#PUFF_LIMIT/SCALE_FACTOR,d4
	blt.s	no_add_spin_puff
	move.w	#1,add_player_smoke
no_add_spin_puff	
	move.w	#6,d6	;get speed of animatatiion from velocity
	sub.w	d4,d6
	
	tst	started_spin
	bne.s	already_in_spin
	
**position player coorectly for spin depending on direction standing	
	tst	lastx_direc
	bpl.s	player_going_left_into_spin
	move.w	#1,player_spin_frame
	bra.s	already_in_spin
player_going_left_into_spin
	move.w	#5,player_spin_frame
	
already_in_spin	
	move.w	#1,started_spin	
	move.w	player_spin_frame,d5
	addq.w	#1,player_spin_timer
	cmp.w	player_spin_timer,d6
	bgt.s   no_spin_frame_update
	move.w	#0,player_spin_timer		
	tst	player_x_velocity
	beq.s	no_spin_frame_update
	addq.w	#1,d5
	cmp.w	#PLAYER_SPIN_FRAMES,d5
	blt.s	no_spin_frame_update
frame_spin_reset
	move.w	#0,d5	
no_spin_frame_update	
	move.w	d5,player_spin_frame
	move.w	d5,d0

	move.l	#spin_table,a0
	cmp.w	#4,d0
	bge.s	player_spinning_left
	move.w	#-16,d6	;tail offset from body
	bra.s	position_spin_player
player_spinning_left				
	move.w	#16,d6	;tail offset from body	
position_spin_player
	bra	stuff_data_into_sprites
	rts


	
tail_pos	dc.w	0	

frame1		dc.l	0

frame2		dc.l	0 


old_sprite_pos				dc.l	copper_sprite_mem+SPRITE1B+2

started_spin				dc.w	0

player_frame				dc.w	0

**player frame tables


player_walk_left

SFS	EQU	(PLAYER_HEIGHT+2)*4*2*2
	

	dc.l	leftbodys+SFS*4		;body
	dc.l	lefttails+SFS*4		;tail

	dc.l	leftbodys+SFS*3
	dc.l	lefttails+SFS*3

	dc.l	leftbodys+SFS*2
	dc.l	lefttails+SFS*2

	dc.l	leftbodys+SFS*3
	dc.l	lefttails+SFS*3

	dc.l	leftbodys+SFS*4
	dc.l	lefttails+SFS*4

	dc.l	leftbodys+SFS*1
	dc.l	lefttails+SFS*1

	dc.l	leftbodys+SFS*0
	dc.l	lefttails+SFS*0

	dc.l	leftbodys+SFS*1
	dc.l	lefttails+SFS*1


player_walk_right

	dc.l	rightbodys		;body
	dc.l	righttails		;tail

	dc.l	rightbodys+SFS*1
	dc.l	righttails+SFS*1

	dc.l	rightbodys+SFS*2
	dc.l	righttails+SFS*2

	dc.l	rightbodys+SFS*1
	dc.l	righttails+SFS*1

	dc.l	rightbodys+SFS*0
	dc.l	righttails+SFS*0

	dc.l	rightbodys+SFS*3
	dc.l	righttails+SFS*3

	dc.l	rightbodys+SFS*4
	dc.l	righttails+SFS*4

	dc.l	rightbodys+SFS*3
	dc.l	righttails+SFS*3


spin_table
	dc.l	spinright
	dc.l	tailright
	
	dc.l	spinright+SFS*1
	dc.l	tailright+SFS*1
	
	dc.l	spinright+SFS*2
	dc.l	tailright+SFS*2
	
	dc.l	spinright+SFS*3
	dc.l	tailright+SFS*3
	
	dc.l	spinright+SFS*4
	dc.l	tailright+SFS*4

		
	dc.l	spinright+SFS*5
	dc.l	tailright+SFS*5

jumpleft_table
	dc.l	jumpleft
	dc.l	jumplefttail
	
jumpright_table
	dc.l	jumpright
	dc.l	jumprighttail	
	
fallleft_table
	dc.l	fallleft
	dc.l	falllefttail

fallright_table
	dc.l	fallright
	dc.l	fallrighttail	
	
