
ALIEN_DROP_VELOCITY	EQU	25
MAX_ALIEN_DROP		EQU	5*64

ALIEN_SCALE_FACTOR	EQU	64
	
*-----------------------ALIEN COLLISION CALLS----------------------

***********************************************
*********  BASEBALL COLLISION         *********
***********************************************
baseball_collision
	
	movem.l	d0-d1/a0-a2,-(sp)
	
	
	add.w	x_in(a0),d0
	move.w	alien_test_height(a0),d4


	move.l	map_pointer,a0
	moveq	#0,d2
	move.w	d1,d2	
	add.w	d1,d4			;test block below if height bigger than one block

	move.w	d2,d5			;save for reference
	move.w	d4,d6
	
	asr.w	#4,d2
	asr.w	#4,d4
	muls	#MAP_LINE_SIZE,d2		;give map y line
	muls	#MAP_LINE_SIZE,d4
	move.l	a0,a1
	add.l	d4,a1
	add.l	d2,a0				;position in map data of object
	
	
	
	moveq	#0,d2
	move.w	d0,d4				;save player x for use in positioning if player hit block
	move.w	d0,d2
	asr.w	#4,d2				;get map x pos
	add.l	d2,a1
	add.l	d2,a0				;where currently is

	moveq	#0,d2
	move.b	(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a2
	add.l	d2,a2

	
	btst.b	#X_COLLISION_FLAG,block_details(a2)
	bne.s	have_hit_block_baseball
	
	moveq	#0,d2
	move.b	(a1),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a2
	add.l	d2,a2


	btst.b	#X_COLLISION_FLAG,block_details(a2)
	bne.s	have_hit_enemie
	btst.b	#Y_COLLISION_FLAG,block_details(a2)
	bne.s	have_hit_enemie
	bra	finished_x_collision_baseball
have_hit_enemie
	move.l	a1,a0	;for benifit of below
	move.w	d6,d5	;same
	
have_hit_block_baseball	

	cmp.b	#EXPLODE_BLOCK,block_type(a2)
	bne.s	dont_kill_block
	move.b	#0,(a0)	     ;clear map block	

	move.w	d4,d0	;x pos of block
	andi.w	#$fff0,d0
	move.w	d5,d1	;y pos of block
	andi.w	#$fff0,d1
	move.w	#CRACKED_BLOCK_Character,d2
	bsr	add_an_enemy
	move.w	#Sound_Blocksplit,sound_chan1
	bra.s	skip_thud_noise	
dont_kill_block
	move.w	#Sound_Wallhit,sound_chan1
skip_thud_noise
	movem.l	(sp)+,d0-d1/a0-a2

	move.l	Character_Dead(a0),a2
	*move.l	a0,Alien_Flight(a1)	; set hit anim
	clr.w	Repeat_Counter(a1)	
	bset.b	#Alien_OffScreen,Alien_Mode(a1)
	bset.b	#Alien_Hit,Alien_Mode(a1)

	rts
finished_x_collision_baseball			
	movem.l	(sp)+,d0-d1/a0-a2
	rts


	
***********************************************
*********  ALIEN GROUND COLLISION     *********
***********************************************
alien_ground_collision

**send in alien x and y in d0 and d1
**pointer in a0 pointing to dimensions structure
**pointer in a1 pointing to alien structure
**I process both x and y collision and return new positions in d0 and d1

	move.l	map_pointer,-(sp)
	move.l	alien_collision_map_ptr,map_pointer

	
*-----------------------FIRST DO X--------------------------
	movem.l	d0-d1/a0-a1,-(sp)
	
	move.l	#alien_collision_x_struct,a3
	
	add.w	x_in(a0),d0
	add.w	y_in(a0),d1
	move.w	alien_test_height(a0),d4
	bsr	test_x_collision_side	
	
	movem.l	(sp)+,d0-d1/a0-a1
	
			
	tst.w	x_collision(a3)
	beq.s	test_other_alien_side
	
	move.w	x_position(a3),d0
	add.w	#15,d0
	bchg.b	#Alien_Left,alien_mode2(a1)	;make alien go other way
	bra.s	do_alien_y_collision
test_other_alien_side

	movem.l	d0-d1/a0-a1,-(sp)

	add.w	alien_test_width(a0),d0	
	add.w	x_in(a0),d0
	add.w	y_in(a0),d1
	move.w	alien_test_height(a0),d4
	move.l	#alien_collision_x_struct,a3
	bsr	test_x_collision_side	
	
	movem.l	(sp)+,d0-d1/a0-a1

	tst.w	x_collision(a3)
	beq.s	do_alien_y_collision
	
	move.w	x_position(a3),d0

	bchg.b	#Alien_Left,alien_mode2(a1)	;make alien go other way

	
	sub.w	character_width(a0),d0
	add.w	x_in(a0),d0
****need to add width onto new player pos
do_alien_y_collision
	
**do test for y		
**need to know jump or fall




do_alien_fall_collision

	move.w	alien_fall_velocity(a1),d4
	asr.w	#6,d4
	add.w	d4,d1
		
	movem.l	d0-d1/a0-a1,-(sp)
	add.w	character_height(a0),d1
	add.w	x_in(a0),d0
	
*******what to do about in _air	
	move.l	#alien_collision_y_struct,a3
	move.w	alien_in_air(a1),d3
	move.b	d3,in_air(a3)
	
	move.w	alien_test_width(a0),d3
	move.w	#0,d4		;not jumping - do for now

	bsr	test_y_collision
	movem.l	(sp)+,d0-d1/a0-a1
	
	
	tst.b	in_air(a3)		;still falling?
	bne.s	alien_still_in_air	
	
	move.w	top_block(a3),d1
	sub.w	character_height(a0),d1
	move.w	#0,alien_in_air(a1)
	move.w	#0,alien_fall_velocity(a1)
	move.l	(sp)+,map_pointer
	rts	
alien_still_in_air
	add.w	#ALIEN_DROP_VELOCITY,alien_fall_velocity(a1)
	cmp.w	#MAX_ALIEN_DROP,alien_fall_velocity(a1)
	ble.s	not_reached_max_alien_drop
	move.w	#MAX_ALIEN_DROP,alien_fall_velocity(a1)
not_reached_max_alien_drop	
***could add on drop velocity to alien at this point
	move.w	#1,alien_in_air(a1)
	
	
	move.l	(sp)+,map_pointer
	rts	
	
		
alien_collision_y_struct
	dc.w	0
	dc.w	0
	dc.w	0
	dc.l	0	
	dc.l	0

		
alien_collision_x_struct
	dc.w	0	
	dc.w	0
	dc.l	0
	
********player routines to interface with collision routines


***********************************************
*********  DO PLAYER X COLLISION      *********
***********************************************
do_player_x_collision
***send size of object in d3 
***send height in d4
**will test  one side and then the other
*send x collsion struct in a3
	

	movem.l	d0-d1/d4,-(sp)	
	
	ext.l	d0
	divs	#SCALE_FACTOR,d0	;get actual screen pos
	ext.l	d1	
	divs	#SCALE_FACTOR,d1
	add.w	screen_y_position,d1	
	add.w	screen_x_position,d0
	bsr	test_x_collision_side
	
	movem.l	(sp)+,d0-d1/d4

	tst.w	x_collision(a3)
	beq.s	test_other_side
**please note value below was 16
	add.w	#15,x_position(a3)
	move.w	screen_x_position,d4
	sub.w	d4,x_position(a3)	;make player relative to scroll
	bra.s	quit_x_collision
test_other_side
	
	ext.l	d0
	divs	#SCALE_FACTOR,d0	;get actual screen pos
	ext.l	d1	
	divs	#SCALE_FACTOR,d1
	add.w	screen_x_position,d0
	add.w	screen_y_position,d1	
	add.w	d3,d0			;add collision width to x
	
	bsr	test_x_collision_side
	
	tst.w	x_collision(a3)
	beq.s	quit_x_collision
	sub.w	#PLAYER_WIDTH,x_position(a3)
	move.w	screen_x_position,d4
	sub.w	d4,x_position(a3)	;make player relative to scroll

quit_x_collision
	rts


***********************************************
*********  DO PLAYER Y COLLISION      *********
***********************************************
do_player_y_collision


******************convert co-ords***********************
	ext.l	d0
	divs	#SCALE_FACTOR,d0	;get actual screen pos
	add.w	screen_x_position,d0	;add on scroll offset
	ext.l	d1	
	divs	#SCALE_FACTOR,d1
	add.w	screen_y_position,d1
***************done converting co-ords*******************
	
	bsr	test_y_collision
	
	

	rts

****done interface routines



***********************************************
*********  TEST X COLLISION SIDE      *********
***********************************************
test_x_collision_side
*send in d0 and d1 the x and y  - not scaled

	move.l	map_pointer,a0
	moveq	#0,d2
	move.w	d1,d2	
	add.w	d1,d4			;test block below if height bigger than one block
	asr.w	#4,d2
	asr.w	#4,d4
	muls	#MAP_LINE_SIZE,d2		;give map y line
	muls	#MAP_LINE_SIZE,d4
	move.l	a0,a1
	add.l	d4,a1
	add.l	d2,a0				;position in map data of object
	
	
	
	moveq	#0,d2
	move.w	d0,d4				;save player x for use in positioning if player hit block
	move.w	d0,d2
	asr.w	#4,d2				;get map x pos
	add.l	d2,a1
	add.l	d2,a0				;where currently is

	moveq	#0,d2
	move.b	(a0),d2
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a0
	add.l	d2,a0

	
	btst.b	#X_COLLISION_FLAG,block_details(a0)
	bne.s	have_hit_block
	
	moveq	#0,d2
	move.b	(a1),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a0
	add.l	d2,a0


	btst.b	#X_COLLISION_FLAG,block_details(a0)
	bne.s	have_hit_block
	
	move.w	#0,x_collision(a3)
	bra.s	finished_x_collision
have_hit_block	
	move.w	#1,x_collision(a3)
	andi.w	#$fff0,d4	
	move.w	d4,x_position(a3)
	move.l	a0,x_block_data_struct(a3)
finished_x_collision			
	rts
	
	
***********************************************
*********  TEST Y COLLISION           *********
***********************************************
test_y_collision

*************************************************************************
*send in x and y co-ords in d0 and d1 - actual position to test  *
*i.e not just the chars top left hand position in screen but position to*
*test									*
*in d3 send size of area to test					*
*when baselining area on slopes middle of object will be used.		*
* d4 detials whether jumping or falling                                 *
*									*
*send y collision struct in a3						*
*									*
*									*
*routine assumes object can only ever be over two blocks		*
*this can be adjusted without too much hassle - just need to test	*
*size of object (d3)							*
*************************************************************************


	move.l	map_pointer,a0
	

*----------Obtain first map block  -----------------------
	moveq	#0,d2
	move.w	d1,d2	
	asr.w	#4,d2		;give map y line
	muls	#MAP_LINE_SIZE,d2
	add.l	d2,a0	
	
	moveq	#0,d2
	move.w	d0,d2
	andi.w	#$fff0,d2
	move.w	d2,x_block_pos(a3)

	asr.w	#4,d2				;get map x pos
	move.l	a0,a1
	move.l	a0,a2				;store for later
	add.l	d2,a0				;where currently is
	move.l	a0,block_mem_pos(a3)
	
*----------first map block in a0---------------------------




	
*----------Do tests on first block tested------------------

	moveq	#0,d2
	move.b	(a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a4
	add.l	d2,a4
	
	tst	d4
	beq.s	not_jumping_test1
	tst.b	jump_through(a4)
	bne.s	test_next_block_in_line
not_jumping_test1
	btst.b	#Y_COLLISION_FLAG,block_details(a4)
	bne.s	hit_block
	
*-----------Done tests on first block-----------------------



*-----------Do tests on second block-------------------------

test_next_block_in_line
	moveq	#0,d2
	move.w	d0,d2
	add.w	d3,d2
	andi.w	#$fff0,d2
	move.w	d2,x_block_pos(a3)
	asr.w	#4,d2
	move.l	a1,a0
	add.l	d2,a0
	moveq	#0,d2
	move.b	(a0),d2
	move.l	a0,block_mem_pos(a3)
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a4
	add.l	d2,a4

	tst	d4
	beq.s	not_jumping_test2
	tst.b	jump_through(a4)
	bne.s	not_hit_a_block
not_jumping_test2
	btst.b	#Y_COLLISION_FLAG,block_details(a4)
	bne.s	hit_block

*----------Done tests on second block--------------------




*----------Code for if player not hit a block------------

not_hit_a_block	
	move.b	#1,in_air(a3)	
	clr.b	block_collision(a3)
	move.l	#blank_block,block_data_struct(a3)
	bra	quit_y_collision

*-----------End of code for player not hitting a block-----
	
	
	
*-----------Code for player hitting a block-----------------

hit_block	

	move.l	a0,non_slope_block
	
*calculate the middle of the character collision and
*test that block	

	asr.w	d3		;half width
	add.w	d3,d0
	moveq	#0,d2
	move.w	d0,d2
	andi.w	#$fff0,d2
	move.w	d2,actual_block_hit_position
	asr.w	#4,d2
	move.l	a2,a0
	add.l	d2,a0
	moveq	#0,d2	
	move.b	(a0),d2		;pixel position block detect
	move.l	a0,actual_block_mem_position
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a0
	add.l	d2,a0

	
	move.l	a0,other_block	


**If the block that the middle of squiz is over is not a slope
**the code does not position the player on this block but on 
**one of the other blocks he is touching - else squiz can fall
**down holes even when he is not over them



****if not a slope block hit by player
	btst.b	#SLOPE_FLAG,block_details(a0)
	beq.s	not_a_slope	 

***calculate slope stand position
	move.l	position_data(a0),a1
	moveq	#0,d2
	move.w	d0,d2
	andi.w	#$000f,d2
	move.w	#16,d3
	sub.w	(a1,d2.w*2),d3	
	bra.s	position_on_block
***done slope calc position

not_a_slope

******if player has hit block with head - this part of the code
******looks at the middle point of the block - if the middle point
******lies over a headbutt block then use its x and y otherwise 
******use the x and y of the other block touched by the player
******this code does not matter if the player lands on block as there
******is a different set of routines called for landing as there is
******for jumping

	btst.b	#HEAD_BUTT_FLAG,block_details(a0)
	beq.s	dont_use_block_for_head_hit
	move.w	actual_block_hit_position,x_block_pos(a3)
	move.l	actual_block_mem_position,block_mem_pos(a3)
	bra.s	not_standing_on_slope
dont_use_block_for_head_hit	

********************


	move.l	non_slope_block,a0	;if block middle of squiz on not a stand on block
	
	
	
	moveq	#0,d2
	move.b  (a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a0
	add.l	d2,a0

	btst.b	#SLOPE_FLAG,block_details(a0)
	beq.s	not_standing_on_slope

***if player is on slope but on very last pixel position then
***position him on other non slope block	
	move.l	other_block,a0
	btst.b	#Y_COLLISION_FLAG,block_details(a0)
	beq	not_hit_a_block

not_standing_on_slope	

	move.w	#16,d3
	sub.w	position_data+2(a0),d3
position_on_block	

*-------------------- CODE FOR POSITIONING ON RAMPS -----------------------

	
****test that players feet have actually touched pixel position of
****block height - very important for slope positioning

**a0 contains the block type player will be positioned on

	
	move.w	d1,d2		;player y position
	andi.w	#$fff0,d2
***add to d2 block baseline value - 0 top of block
	add.w	d3,d2		;d2 = block pixel height position	
	
	
***********perform test to allow players to jump through blocks

	tst.b	jump_through(a0)
	beq.s	stop_falling_information
	tst	d4
	bne	not_hit_a_block
	move.w	d2,d3
	addq.w	#MAX_DROP_VELOCITY,d3	;if player beneath this point - falling
	cmp.w	d3,d1
	ble	not_a_jump_through_block
	move.w	#1,player_slope_hit		
	bra	not_hit_a_block
not_a_jump_through_block

***********done tests for passing through blocks


***checking for landing on slope - so if jumping skip	
	tst	d4
	bne	not_hit_a_block	
	
*** if the player is on a slope then want to stick to it therefore
*** unless in the air force onto slope	

	tst.b	in_air(a3)
	beq.s	stop_falling_information


****next check determines if adding the maximum velocity to the player
****could put him through the block - to do this take the block position
****and add the gap allowed before the player falls through block
****this is then subtracted from where the player stands - if the gap
****is smaller than the maximum drop velocity - i.e adding max could
****bypass block then position player onto block
	
	move.w	d2,d3	;block pixel stand position
	addq.w	#MAX_DROP_VELOCITY-2,d3	;just for safety
	sub.w	d1,d3	;find how many pixels playhe is above block
	cmp.w	#MAX_DROP_VELOCITY,d3
	blt.s	stop_falling_information
	
*****following 2 lines checks to see if player hit slope (above code ensures
*****that no accidents can happen at this stage) - if above then not hit	

	cmp.w	d2,d1
	blt	not_hit_a_block
	
	
********************done pixel ramp fall test******************************


*-------------------- FIN CODE FOR POSITIONING ON RAMPS --------------------

stop_falling_information	
	clr.b	in_air(a3)
	move.b	#1,block_collision(a3)
	move.l	a0,block_data_struct(a3)
	move.w	d2,top_block(a3)		

quit_y_collision
	rts
	
	
	
	
	
	
***********************************************
*********  SIMPLE Y COLLISION         *********
***********************************************
simple_y_collision

*to be used for quick tests

*send in x and y in d0,d1 and width in d3
*will send back in d4 - whether hit block or not

	move.l	map_pointer,a0
	

***********Obtain first map block  ****************************	
	moveq	#0,d2
	move.w	d1,d2	
	asr.w	#4,d2		;give map y line
	muls	#MAP_LINE_SIZE,d2
	add.l	d2,a0	
	
	moveq	#0,d2
	move.w	d0,d2
	asr.w	#4,d2				;get map x pos
	move.l	a0,a1
	move.l	a0,a2				;store for later
	add.l	d2,a0				;where currently is
	
*************first map block in a0*****************************	

	moveq	#0,d2
*******************Do tests on first block tested**************
	move.b	(a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a4
	add.l	d2,a4

	tst.b	jump_through(a4)
	bne.s	do_tests_on_sec_block
	btst.b	#Y_COLLISION_FLAG,block_details(a4)
	bne.s	simple_hit_block
******************Done tests on first block********************

do_tests_on_sec_block
******************Do tests on second block*********************	
simple_test_next_block_in_line
	moveq	#0,d2
	move.w	d0,d2
	add.w	d3,d2
	asr.w	#4,d2
	move.l	a1,a0
	add.l	d2,a0
	moveq	#0,d2
	move.b	(a0),d2
	
	asl.w	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a4
	add.l	d2,a4

	tst.b	jump_through(a4)
	bne.s	simple_not_hit_a_block
	btst.b	#Y_COLLISION_FLAG,block_details(a4)
	bne.s	simple_hit_block
	
simple_not_hit_a_block	
	moveq.w	#0,d4
	bra	quit_simple_y_collision
simple_hit_block
	moveq.w	#1,d4
quit_simple_y_collision
	rts	
	
*The two routines following are for use with the alien routine
* The first check_player_fall_onto_platform is called when the player
* is found to be within the platforms x bounds - but is above the platform
* This routine then checks to see if the  player next time round will have
* accidently missed the platform i.e adding the players velocity will put
* him past the platform - if this is so it positions him on the platform

*The second routine is called when the player is definately on the platform
*it checks to see where the players feet are in relation to the platform
*if the players feet are within an area of MAX_DROP_VELOCITY size from the
*top of the object then the player is positioned on the object - if player
*is lower he is not.	
	
	
	
***********************************************
*********  CHECK PLAYER FALL ONTO PLATFORM ****
***********************************************
check_player_fall_onto_platform

	moveq	#0,d7
	
*---CHECK PLAYER CANNOT FALL THROUGH PLATFORM	
	tst	player_action
	beq.s	player_not_fall_onto_platform
	move.w	player_fall_velocity,d6
	divs	#SCALE_FACTOR,d6
	add.w	d6,d1
	move.w	d5,d4
	add.w	#MAX_DROP_VELOCITY+3,d4
	
	cmp.w	d4,d6
	ble.s	player_not_fall_onto_platform		
	moveq	#1,d7
player_not_fall_onto_platform

	rts	
	
***********************************************
*********  CHECK PLAYER ON PLATFORM   *********
***********************************************
check_player_on_platform
*uses d1 = player feet position
*and d5 = top of object

	moveq	#0,d7
	tst.w	player_action
	beq.s	player_not_hit_platform
*----------SEE IF CAN JUMP ONTO PLATFORM	
check_if_can_jump_onto_platform
	move.w	d5,d6
	add.w	#MAX_DROP_VELOCITY+3,d6
	cmp.w	d6,d1
	bgt.s	player_not_hit_platform
	moveq	#1,d7
	
player_not_hit_platform
	rts




actual_block_hit_position		dc.w	0	

actual_block_mem_position		dc.l	0	

non_slope_block				dc.l	0

other_block				dc.w	0		
	
	

	rsreset
	
x_collision	rs.w	1	
x_position	rs.w	1
x_block_data_struct	rs.l	1


	
	rsreset
	
in_air		rs.b	1
block_collision	rs.b	1
top_block	rs.w	1
x_block_pos	rs.w	1
block_data_struct rs.l	1
block_mem_pos	rs.l	1
	
	EVEN


y_collision_jump_struct
	dc.w	0
	dc.w	0	
	dc.w	0
	dc.l	0	
	dc.l	0

	
		
y_collision_fall_struct
	dc.w	0
	dc.w	0
	dc.w	0
	dc.l	0
	dc.l	0	

	
		
x_collision_struct
	dc.w	0	
	dc.w	0
	dc.l	0

