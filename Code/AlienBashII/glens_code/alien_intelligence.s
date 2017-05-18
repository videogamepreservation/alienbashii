*------------------------------------------------------------------------* 
*- Not much thought went into these, I just added new ones as needed    -*
*- I often just copied code for speed					-*
*------------------------------------------------------------------------*
	
*****************************************
****     ALIEN UPDATE BULLET       ******
*****************************************
Alien_Update_Bullet
*Update alien position using vector calculated

	movem.l	d0-d1/a1,-(sp)
	move.w	alien_data(a2),d0
	move.w	alien_data_extra(a2),d1
	add.w	d0,alien_x(a2)
	add.w	d1,alien_y(a2)
	
	move.l	current_map_pointer,a1
 	
 	moveq	#0,d0
 	move.w	alien_x(a2),d0
 	move.w	alien_y(a2),d1
 	andi.w	#$fff0,d0
	asr.w	#3,d0	;cos word map
	asr.w	#4,d1
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d1
	add.l	d1,a1
		
	move.w	(a1,d0),d0		;block
	asl	#BLOCK_STRUCT_MULT,d0
	move.l	#block_data_information,a1
	btst	#BULLET_DIE_FLAG,block_details(a1,d0)
	beq.s	alien_bullet_not_hit_block
	move.l	alien_dead_pattern(a4),a5	;overide pattern
alien_bullet_not_hit_block	
	movem.l	(sp)+,d0-d1/a1
	rts
	
*****************************************
****     FIRE PIG BULLET           ******
*****************************************
Fire_Pig_Bullet



	rts	
	
GUN_TURRET_FIRE_DELAY	EQU	25

*****************************************
****     FIRE ALIEN  BULLET        ******
*****************************************
Fire_Alien_Bullet
	
	movem.l	a0-a3/d0-d1,-(sp)
	move.l	#gun_Turret_Pos_Table,a3
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	moveq	#0,d5
	move.w	alien_frame(a2),d5
	moveq	#0,d6
	move.w	alien_data(a2),d6
	asl	#2,d5
	add.w	(a3,d5),d0
	add.w	2(a3,d5),d1
	move.l	#Alien_Bullet_Object,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#alien_bullet_direction_table,a3
	asl	#2,d6
	move.w	(a3,d6),alien_data(a1)
	move.w	2(a3,d6),alien_data_extra(a1)
	movem.l	(sp)+,a0-a3/d0-d1
dont_fire_alien_bullet	
	rts		
	
*****************************************
****     FACE PLAYER               ******
*****************************************
Face_Player

*General routine - make object with 8 directions face player
	movem.l	a3,-(sp)
	move.w	d0,d6
	move.w	d1,d7
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	bsr	Aim_Alien_Bullet
	move.l	#face_table,a3
	move.w	(a3,d5),d5
	move.w	d5,alien_data(a2)
	move.l	#face_direction_table,a3
	asl	d5
	move.w	(a3,d5),alien_frame(a2)
	move.w	d6,d0
	move.w	d7,d1
	movem.l	(sp)+,a3
	rts
	

*Routine for background animation objects
	
*****************************************
****     DELAY ANIMATION           ******
*****************************************
delay_animation

	bsr	Get_Animation_Delay
	move.w	d7,alien_frame_counter(a2)	;just stop it
	move.w	d7,alien_counter(a2)
	rts	


	
*****************************************
****     GET ANIMATION DELAY       ******
*****************************************
Get_Animation_Delay
	move.l	a5,-(sp)
	move.l	random_anim_ptr,a5
	move.w	(a5)+,d7
	tst	(a5)
	bge.s	not_at_end_of_rands
	move.l	#random_animation_delay,a5
not_at_end_of_rands		
	move.l	a5,random_anim_ptr
	move.l	(sp)+,a5	
	rts	
	
random_anim_ptr
	dc.l	random_animation_delay	
	
random_animation_delay
	dc.w	100,10,5,30,80,5,160,40,10,17,20,19,30,15
	dc.w	15,10,20,40,8,4,50,100
	dc.w	-1	
	
alienx_collision_struct
	dc.w	0	
	dc.w	0
	dc.l	0
	dc.l	0
	
alieny_collision_struct
	dc.w	0
	dc.w	0
	dc.l	0	
	dc.l	0
	
	
	
Get_Random_Number

* D0 - Lower Bound, D1 - Upper Bound, number returned in d0

mult	equ	34564
inc	equ	7682
mod 	equ	65535

	sub.w	d0,d1	
	addq.w	#1,d1
	move.w	old_seed,d2

	mulu.w	#mult,d2
	add.l	#inc,d2
	divu.w	#mod,d2
	swap	d2		
	move.w	d2,old_seed		
	
	mulu.w	d1,d2
	divu.w	#mod,d2
	add.w	d2,d0	
	rts
old_seed	dc.w	0
	
SPIKEY_SPEED	EQU	4	
	
*****************************************
****     SPIKEY_DEATH_ROUTINE      ******
*****************************************
Spikey_Death_Routine	

	movem.l	a0-a2/d2,-(sp)

	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	
	addq.w	#4,d0
	addq.w	#4,d1
	
	move.l	#Spinny_Object,d2
	
	bsr	Simple_Add_Alien_To_List
	
	move.w	#-SPIKEY_SPEED,alien_data(a1)
	move.w	#-SPIKEY_SPEED,alien_data_extra(a1)
	
	bsr	Simple_Add_Alien_To_List
	
	move.w	#SPIKEY_SPEED,alien_data(a1)
	move.w	#SPIKEY_SPEED,alien_data_extra(a1)

	bsr	Simple_Add_Alien_To_List
	
	move.w	#-SPIKEY_SPEED,alien_data(a1)
	move.w	#SPIKEY_SPEED,alien_data_extra(a1)

	bsr	Simple_Add_Alien_To_List
	
	move.w	#SPIKEY_SPEED,alien_data(a1)
	move.w	#-SPIKEY_SPEED,alien_data_extra(a1)


	bsr	Simple_Add_Alien_To_List
	
	move.w	#(SPIKEY_SPEED+1),alien_data(a1)
	clr	alien_data_extra(a1)

	bsr	Simple_Add_Alien_To_List
	
	clr	alien_data(a1)
	move.w	#(SPIKEY_SPEED+1),alien_data_extra(a1)

	bsr	Simple_Add_Alien_To_List
	
	move.w	#-(SPIKEY_SPEED+1),alien_data(a1)
	clr	alien_data_extra(a1)

	bsr	Simple_Add_Alien_To_List
	
	clr	alien_data(a1)
	move.w	#-(SPIKEY_SPEED+1),alien_data_extra(a1)

	movem.l	(sp)+,a0-a2/d2

	rts
	
COIN_SCALE	equ	16
COIN_DIV	EQU	4	

*******************************************
****     TEST  CHUCK OUT COIN         *****
*******************************************
Test_Chuck_Out_Coin

	btst.b	#ALIEN_HIT,alien_flags(a2)
	beq.s	dont_chuck_coin
	bsr	Chuck_Out_Coin	
dont_chuck_coin	
	rts
	
*******************************************
****       CHUCK OUT COIN             *****
*******************************************
Chuck_Out_Coin

	
	movem.l	a0-a2/d0-d1,-(sp)

	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	
	moveq	#0,d4	
	move.l	alien_map_pos(a2),a1
	addq.b	#1,(a1)
	move.b	(a1),d4
	andi.b	#$7f,d4
	
	
	addq.w	#4,d0
	
	move.l	#Coin_Object,d2
	bsr	Simple_Add_Alien_To_list
	
	move.l	#coin_deltas,a0
	sub.w	#Chest,d4
	asl	#2,d4
	move.w	(a0,d4),alien_data(a1)
	move.w	2(a0,d4),alien_data_extra(a1)
	
	movem.l	(sp)+,a0-a2/d0-d1

	rts	
	
	
*******************************************
****     TEST  CHUCK OUT SILVER  COIN *****
*******************************************
Test_Chuck_Out_Silver_Coin

	btst.b	#ALIEN_HIT,alien_flags(a2)
	beq.s	dont_chuck_scoin
	bsr	Chuck_Out_Silver_Coin	
dont_chuck_scoin	
	rts
	
*******************************************
****       CHUCK OUT SILVER COIN      *****
*******************************************
Chuck_Out_Silver_Coin

	
	movem.l	a0-a2/d0-d1,-(sp)

	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	
	moveq	#0,d4
	move.l	alien_map_pos(a2),a1
	addq.b	#1,(a1)
	move.b	(a1),d4
	andi.b	#$7f,d4

	sub.w	#Silver_Chest,d4
	
	addq.w	#4,d0
	
	move.l	#Silver_Coin_Object,d2
	bsr	Simple_Add_Alien_To_list
	
	move.l	#coin_deltas,a0
	asl	#2,d4
	move.w	(a0,d4),alien_data(a1)
	move.w	2(a0,d4),alien_data_extra(a1)
	
	movem.l	(sp)+,a0-a2/d0-d1

	rts	
	
	
coin_deltas
	dc.w	0,0
	dc.w	-2*COIN_SCALE,0
	dc.w	(-2*COIN_SCALE)+8,(3*COIN_SCALE)-8
	dc.w	0,3*COIN_SCALE
	dc.w	(3*COIN_SCALE)-8,(3*COIN_SCALE)-8
	dc.w	3*COIN_SCALE,0
	
*******************************************
****       MOVE COIN                  *****
*******************************************
Move_Coin

	move.w	alien_data(a2),d5
	beq.s	do_coin_y
	bpl.s	reduce_c_x
	addq.w	#1,alien_data(a2)	
	bra.s	add_coin_x
reduce_c_x
	subq.w	#1,alien_data(a2)	
	
add_coin_x	
	asr	#COIN_DIV,d5
	add.w	d5,alien_x(a2)

	
do_coin_y
	move.w	alien_data_extra(a2),d6
	beq.s	finished_coin
	bpl.s	reduce_c_y
	addq.w	#1,alien_data_extra(a2)	
	bra.s	finished_moving_coin
reduce_c_y
	subq.w	#1,alien_data_extra(a2)	
finished_moving_coin	
	asr	#COIN_DIV,d6
	add.w	d6,alien_y(a2)
finished_coin

	rts	

ABS		EQU	5
	
alien_bullet_direction_table
	dc.w	0,ABS		;0000
	dc.w	ABS,ABS		;0001
	
	dc.w	ABS,0		;0010
	dc.w	ABS,ABS		;0011
	
	dc.w	0,ABS		;0100
	dc.w	-ABS,ABS	;0101
	
	dc.w	-ABS,0		;0110
	dc.w	-ABS,ABS	;0111
	
	dc.w	0,-ABS		;1000
	dc.w	ABS,-ABS	;1001
	
	dc.w	ABS,0		;1010
	dc.w	ABS,-ABS	;1011
	
	dc.w	0,-ABS		;1100
	dc.w	-ABS,-ABS	;1101
	
	dc.w	-ABS,0		;1110
	dc.w	-ABS,-ABS	;1111

Gun_Turret_Pos_Table
	dc.w	9,0
	dc.w	22,2
	dc.w	24,10
	dc.w	19,19
	dc.w	11,23
	dc.w	-4,22
	dc.w	0,10
	dc.w	1,1

	
Update_Wasp_Direction
	movem.l	d0-d1/a0,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1

	bsr	Find_Direction_Of_Bullet

	muls	#5,d5		;bullet = 5 pixels
	muls	#5,d6
	
	move.w	d5,alien_work(a2)
	move.w	d6,alien_work+2(a2)
	clr.l	alien_data(A2)
	
	movem.l	(sp)+,d0-d1/a0
	rts
	
		
***********************************
****  FIND WASP DIRECTION      ****
***********************************	
Find_Wasp_Direction
	movem.l	a0/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	bsr	Aim_Alien_Bullet
	move.l	#wasp_face_table,a0
	asl	d5
	move.w	(a0,d5),alien_direction(a2)	
	movem.l	(sp)+,a0/d0-d1
	rts

***********************************
****  FIND WASP DIRECTION MABEY ****
***********************************	
Find_Wasp_Direction_Mabey
	movem.l	a0-a1/d0-d1,-(sp)
	
	tst.w	alien_work+8(a2)
	beq.s	dont_go_random
	clr.w	alien_work+8(a2)
	move.l	random_direction_ptr,a1	
	move.b	(a1)+,d5
	cmp.b	#-1,(a1)
	bne.s	not_end_ran
	move.l	#random_direction_table,a1
not_end_ran
	move.l	a1,random_direction_ptr	
	ext.w	d5
	move.l	#random_wasp_speed_pattern,alien_data(a2)
	bra.s	update_wasp_as_norm
dont_go_random	
	move.w	#1,alien_work+8(a2)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	bsr	Aim_Alien_Bullet	
	move.l	#wasp_speed_pattern,alien_data(a2)
update_wasp_as_norm	
	move.l	#wasp_face_table,a0
	asl	d5
	move.w	(a0,d5.w),alien_direction(a2)	
	move.l	#wasp_direction_table,a0
	asl	d5
	move.w	(a0,d5.w),alien_work(a2)
	move.w	2(a0,d5.w),alien_work+2(a2)
	movem.l	(sp)+,a0-a1/d0-d1
	rts


*************************************
****        WASP FOLLOW           ***
*************************************	
Wasp_Follow
	move.l	a0,d6
	
	move.l	alien_data(a2),a0
	move.w	(a0),d7
	beq.s	dont_inc
	addq.l	#2,alien_data(a2)
dont_inc	
	move.l	d6,a0
	
	move.w	d7,d6
	muls	alien_work(a2),d6
	muls	alien_work+2(a2),d7
	
	add.w	d6,alien_x(a2)
	add.w	d7,alien_y(a2)
	rts


WASP	EQU	1

wasp_direction_table
	dc.w	0,WASP		;0000
	dc.w	WASP,WASP	;0001
	
	dc.w	WASP,0		;0010
	dc.w	WASP,WASP	;0011
	
	dc.w	0,WASP		;0100
	dc.w	-WASP,WASP	;0101
	
	dc.w	-WASP,0		;0110
	dc.w	-WASP,WASP	;0111
	
	dc.w	0,-WASP		;1000
	dc.w	WASP,-WASP	;1001
	
	dc.w	WASP,0		;1010
	dc.w	WASP,-WASP	;1011
	
	dc.w	0,-WASP		;1100
	dc.w	-WASP,-WASP	;1101
	
	dc.w	-WASP,0		;1110
	dc.w	-WASP,-WASP	;1111

wasp_face_table
	dc.w	4
	dc.w	3
	
	dc.w	2
	dc.w	3
	
	dc.w	4
	dc.w	5
	
	dc.w	6
	dc.w	5
	
	dc.w	0
	dc.w	1
	
	dc.w	2
	dc.w	1
	
	dc.w	0
	dc.w	7
	
	dc.w	6
	dc.w	7

************************************************
***   FIRE FISH BULLET                       ***
************************************************
Fire_Fish_Bullet

	movem.l	d0-d1/a0-a2,-(sp)
	move.w	alien_x(a2),d0
	addq.w	#5,d0
	move.w	alien_y(a2),d1

	bsr	Find_Direction_Of_Bullet
	cmp.w	#10000,d5
	beq.s	dont_fire_fish_bullet


	move.l	#Fish_Bullet_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List

	muls	#5,d5		;bullet = 5 pixels
	muls	#5,d6
	
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	
	clr.w	alien_data_extra(a1)
dont_fire_fish_bullet	
	movem.l	(sp)+,d0-d1/a0-a2
	
	rts


************************************************
***   FIRE GEN BULLETv                       ***
************************************************
Fire_Gen_Bullet

	movem.l	d0-d1/a0-a2,-(sp)
	move.w	alien_x(a2),d0
	add.w	#4,d0
	move.w	alien_y(a2),d1
	add.w	#12,d1

	bsr	Find_Direction_Of_Bullet
	cmp.w	#10000,d5
	beq.s	dont_fire_gen_bullet

	move.w	#Sound_Pigshoot,sound_chan4
	move.l	#Generator_Bullet_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List

	muls	#6,d5		;bullet = 5 pixels
	muls	#6,d6
	
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	
	clr.w	alien_data_extra(a1)
dont_fire_gen_bullet	
	movem.l	(sp)+,d0-d1/a0-a2
	
	rts

************************************************
***   FIRE GEN BULLET2                       ***
************************************************
Fire_Gen_Bullet2
	movem.l	d0-d1/a0-a2,-(sp)
	
	move.w	alien_x(a2),d0
	add.w	#4,d0
	move.w	alien_y(a2),d1
	add.w	#12,d1
	move.w	actual_player_map_x_position,d5
	move.w	actual_player_map_y_position,d6
	
	sub.w	#16,d5
	add.w	#16,d6

	bsr	Find_Bullet_Spot_Direction
	cmp.w	#10000,d5
	beq.s	bullet_1_no_go

	move.w	#Sound_Pigshoot,sound_chan3
	move.l	#Generator_Bullet_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List
	muls	#6,d5		;bullet = 5 pixels
	muls	#6,d6
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	clr.w	alien_data_extra(a1)
bullet_1_no_go
	move.w	actual_player_map_x_position,d5
	move.w	actual_player_map_y_position,d6
	add.w	#16+32,d5
	add.w	#16,d6
	
	bsr	Find_Bullet_Spot_Direction
	cmp.w	#10000,d5
	beq.s	bullet_2_no_go
	move.l	#Generator_Bullet_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List
	muls	#6,d5		;bullet = 5 pixels
	muls	#6,d6
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	clr.w	alien_data_extra(a1)
bullet_2_no_go
	movem.l	(sp)+,d0-d1/a0-a2
	rts

	
	
************************************************
***   FIRE STATUE BULLET                     ***
************************************************
Fire_Statue_Bullet

	movem.l	d0-d1/a0-a2,-(sp)
	move.w	alien_x(a2),d0
	addq.w	#5,d0
	move.w	alien_y(a2),d1
	add.w	#12,d1

	bsr	Find_Direction_Of_Bullet
	cmp.w	#10000,d5
	beq.s	dont_fire_statue_bullet


	move.l	#Alien_Bullet_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List

	muls	#6,d5		;bullet = 4 pixels
	muls	#6,d6
	
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	
	clr.w	alien_data_extra(a1)
dont_fire_statue_bullet	
	movem.l	(sp)+,d0-d1/a0-a2
	
	rts
	
	
	
************************************************
***   FIND DIRECTION OF BULLET               ***
************************************************
Find_Direction_Of_Bullet

*Send alien x and y in d0 and d1

*Returns d5 and d6

	move.w	actual_player_map_x_position,d5
	move.w	actual_player_map_y_position,d6
	
	add.w	#16,d5
	add.w	#16,d6

Find_Bullet_Spot_Direction			
	clr.w	d2
	clr.w	d3
	
	sub.w	d1,d6			;sub alien y from player y
	bpl	by2bigger
	neg.w	d6
	move.w	#-1,d3			;mulu for y
by2bigger
	cmp.w	#255,d6
	bgt.s	bullet_out_of_range

	sub.w	d0,d5			;alien x from player x
	bpl	bx2bigger
	neg.w	d5
	move.w	#-1,d2
bx2bigger
	
	cmp.w	#328,d5
	bgt.s	bullet_out_of_range


	asr	#3,d5
	asr	#3,d6
	
	move.l	#bullet_pos_lookup_table,a0
	mulu	#328/8,d6
	
	add.w	d5,d6
	asl	#2,d6	;pairs of data
	
	move.w	(a0,d6),d5	;x
	tst	d2
	bpl.s	dont_neg_x
	neg.w	d5
dont_neg_x
	
	move.w	2(a0,d6),d6	;x
	tst	d3
	bpl.s	dont_neg_y
	neg.w	d6
dont_neg_y	

	rts
bullet_out_of_range
	move.w	#10000,d5
	rts

*********************************************
***      INCREMENT BULLET POSITION        ***
*********************************************
	
Increment_Bullet_Position 	

	bsr	Increment_Object_Position	
	
	move.l	a1,d5
	move.l	current_map_pointer,a1
 	
 	moveq	#0,d6
 	move.w	alien_x(a2),d6
 	move.w	alien_y(a2),d7
 	andi.w	#$fff0,d6
	asr.w	#3,d6	;cos word map
	asr.w	#4,d7
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d7
	add.l	d6,a1
	add.l	d7,a1
		
	move.w	(a1),d6		;block
	asl	#BLOCK_STRUCT_MULT,d6
	move.l	#block_data_information,a1
	add.l	d6,a1
	btst	#BULLET_DIE_FLAG,block_details(a1)
	beq.s	nice_bullet_not_dead
	move.w	#Sound_Thud,sound_chan2
	move.l	alien_dead_pattern(a4),a5	;overide pattern
nice_bullet_not_dead
	move.l	d5,a1
	rts

*********************************************
***      INCREMENT OBJECT POSITION        ***
*********************************************
	
Increment_Object_Position 	

	move.w	alien_data(a2),d6
	move.w	alien_data_extra(a2),d7
	
	add.w	alien_work(a2),d6	;incs to add
	add.w	alien_work+2(a2),d7
	
	move.w	d6,alien_data(a2)
	move.w	d7,alien_data_extra(a2)
	
	asr	#SHIFT_FACTOR,d6
	asr	#SHIFT_FACTOR,d7
	
	add.w	d6,alien_x(a2)
	add.w	d7,alien_y(a2)
	
	asl	#SHIFT_FACTOR,d6
	asl	#SHIFT_FACTOR,d7
	sub.w	d6,alien_data(a2)
	sub.w	d7,alien_data_extra(a2)
	
	rts



*********************************************
***   INCREMENT GEN BULLET POSITION       ***
*********************************************
Increment_Gen_Bullet_Position 	

	move.w	alien_data(a2),d6
	move.w	alien_data_extra(a2),d7
	
	add.w	alien_work(a2),d6	;incs to add
	add.w	alien_work+2(a2),d7
	
	move.w	d6,alien_data(a2)
	move.w	d7,alien_data_extra(a2)
	
	asr	#SHIFT_FACTOR,d6
	asr	#SHIFT_FACTOR,d7
	
	add.w	d6,alien_x(a2)
	add.w	d7,alien_y(a2)
	
	asl	#SHIFT_FACTOR,d6
	asl	#SHIFT_FACTOR,d7
	sub.w	d6,alien_data(a2)
	sub.w	d7,alien_data_extra(a2)
	
	rts


*********************************************
***      GET FISH WAIT TIME               ***
*********************************************

Get_Fish_Wait_Time
	move.l	a5,d7
	move.l	Fish_Wait_Point,a5	
	move.w	(a5)+,alien_counter(a2)
	tst	(a5)
	bne.s	not_at_fishy_end
	move.l	#Fish_Wait_Times,a5
not_at_fishy_end	
	move.l	a5,Fish_Wait_Point
	move.l	d7,a5
	rts	
	

MAX_PIGS_ON_SCREEN	EQU 4
MAX_WASPS_ON_SCREEN	EQU 5
MAX_MAGGOTS_ON_SCREEN	EQU 10


*********************************************
***      ADDED PIG OFF SCREEN             ***
*********************************************
Added_Pig_Off_Screen

	tst	pigs_on_screen
	beq.s	dont_bother_pig_dec
	subq.w	#1,pigs_on_screen
dont_bother_pig_dec
	rts	


*********************************************
***      ADDED WASP OFF SCREEN            ***
*********************************************
Added_Wasp_Off_Screen

	tst	wasps_on_screen
	beq.s	dont_bother_wasp_dec
	subq.w	#1,wasps_on_screen
dont_bother_wasp_dec
	rts	

WASP_BOUND	EQU	140

*********************************************
***      Check_To_Add_Wasp                ***
*********************************************
Check_To_Add_Wasp

*will only add wasp if player within certain bound of nest

	move.w	alien_x(a2),d6
	move.w	alien_y(a2),d7
	
	sub.w	actual_player_map_x_position,d6
	bpl.s	dont_neg_wasp_x
	neg.w	d6
dont_neg_wasp_x
	cmp.w	#WASP_BOUND,d6
	bgt.s	dont_add_wasp	
	sub.w	actual_player_map_y_position,d7
	bpl.s	dont_neg_wasp_y
	neg.w	d7
dont_neg_wasp_y	
	cmp.w	#WASP_BOUND,d7
	bgt.s	dont_add_wasp	

	movem.l	a0-a2/d0-d1,-(sp)	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	addq.w	#8,d0
	addq.w	#8,d1
	move.l	#Wasp_Alien,d2
	bsr	Simple_Add_Alien_To_List
	movem.l	(sp)+,a0-a2/d0-d1
	addq.w	#1,wasps_on_screen
dont_add_wasp
	rts

pigs_on_screen
	dc.w	0

wasps_on_screen
	dc.w	0	

maggots_on_screen	
	dc.w	0		
	
*********************************************
***      CHUCK OUT PIG                    ***
*********************************************
Chuck_Out_Pig

	movem.l	d0-d2/a0-a2,-(sp)
	
	addq.w	#1,pigs_on_screen
	
	clr.l	d5
	
*Change alien type in map	
	move.l	alien_map_pos(a2),a0
	addq.b	#1,(a0)		;update type
	move.b	(a0),d5
	andi.b	#$7f,d5

*Change type of object
	move.l	#Pig_Gen_List,a1
	sub.w	#Pig_Generator2,d5
	asl	#2,d5
	move.l	(a1,d5),alien_type_ptr(a2)	
		
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	addq.w	#4,d1	
	move.l	#Pig_Out_Cave_Object,d2
	bsr	Simple_Add_Alien_To_List
	
	movem.l	(sp)+,d0-d2/a0-a2
	rts		
	
	
*********************************************
***      CHUCK OUT MAGGOT                 ***
*********************************************
Chuck_Out_Maggot

	movem.l	d0-d2/a0-a2,-(sp)
	
	addq.w	#1,maggots_on_screen
	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	#12,d1	
	move.l	#Added_Maggot_Alien,d2
	bsr	Simple_Add_Alien_To_List
	
*Start maggot off going down
	move.w	#4,alien_direction(a1)
	move.w	#0,alien_work(a1)
	move.w	#1,alien_work+2(a1)	
	
	move.b	#125-16,alien_c_pad(a1)	;changes direction quickly
	
	moveq.w	#0,d0
	moveq.w #2,d1
	bsr	Get_Random_Number
	ext.l	d0
	asl	#2,d0
	move.l	#maggot_pattern_choice,a0
	move.l	(a0,d0),alien_pat_ptr(a1)	
	
	movem.l	(sp)+,d0-d2/a0-a2
	rts		

maggot_pattern_choice
	dc.l	Maggot_Repeat
	dc.l	Maggot_Repeat2
	dc.l	Maggot_Repeat3	
	
*********************************************
***      ADDED MAGGOT OFF SCREEN          ***
*********************************************
Added_Maggot_Off_Screen

	tst	maggots_on_screen
	beq.s	dont_bother_maggot_dec
	subq.w	#1,maggots_on_screen
dont_bother_maggot_dec
	rts	
	
	
	
new_direction_x
	dc.b	0,7,6,5,4,3,2,1
	even
new_direction_y
	dc.b	4,3,2,1,0,7,6,5
	even		
	
	
*********************************************
***      Remove_Blocks_On_Chest           ***
*********************************************
Remove_Blocks_on_Chest
	move.l	a5,d7
	
	moveq	#0,d5
	move.w	alien_x(a2),d5
	move.w	alien_y(a2),d6
	add.w	#15,d6
	asr	#4,d5
	asr	#4,d6	
	mulu	#BIGGEST_MAP_X*2,d6
	move.l	current_map_pointer,a5

	add.l	d6,a5
	asl	d5

	move.w	#1,(a5,d5)
	move.l	d7,a5
chest_safe_check	
	rts	


*********************************************
***      FIND BLOW UP TIME                ***
*********************************************
Find_Blow_Up_Time
	move.w	d0,d6
	move.w	d1,d7
	move.w	#50,d0
	move.w	#500,d1
	bsr	Get_Random_Number
	move.w	d0,alien_work+4(a2)
	move.w	d6,d0
	move.w	d7,d1
	rts
	
	
*********************************************
***      FIND A MAGGOT DIRECTION          ***
*********************************************
Find_A_Maggot_Direction

	move.l	a0,d6
	move.l	a1,d7
	
	moveq	#0,d5
	move.l	random_direction_ptr,a1	
	move.b	(a1)+,d5
	cmp.b	#-1,(a1)
	bne.s	not_end_magran
	move.l	#random_direction_table,a1
not_end_magran
	move.l	a1,random_direction_ptr	
	
	move.l	#wasp_face_table,a0
	asl	d5
	move.w	(a0,d5.w),alien_direction(a2)	
	move.l	#wasp_direction_table,a0
	asl	d5
	
	move.w	(a0,d5.w),alien_work(a2)
	move.w	2(a0,d5.w),alien_work+2(a2)
	
	move.l	d6,a0
	move.l	d7,a1
	rts	
	
	
MAGGOT_BORED	EQU	125	

*********************************************
*** NON EXPLODE UPDATE MAGGOT POSITION    ***
*********************************************
Non_Explode_Update_Maggot_Position
	
	
	addq.b	#1,alien_c_pad(a2)
	cmp.b	#MAGGOT_BORED,alien_c_pad(a2)
	ble.s	maggot_not_bored
	bsr	Find_A_Maggot_Direction
	clr.b	alien_c_pad(a2)
maggot_not_bored		
	
	move.l	a0,d7

	move.w	alien_work(a2),d2
	

	moveq	#0,d3
	moveq	#0,d5
	move.w	alien_x(a2),d3
	move.w	alien_y(a2),d4
	
	addq.w	#8,d3	;test from middle of maggot
	addq.w	#7,d4	
	
	move.w	d3,d5
	move.w	d4,d6
	move.l	current_map_pointer,a0
	add.w	d2,d3		;add on x
	
	andi.w	#$fff0,d3
	asr	#3,d3
	asr	#4,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	add.l	d3,d4
	
	move.w	(a0,d4.l),d4

	asl	#BLOCK_STRUCT_MULT,d4
	move.l	#block_data_information,a0
	btst.b	#COLLISION_FLAG,block_details(a0,d4)
	beq.s	maggot_not_hit_x
	
*Go in opposite direction

	neg.w	alien_work(a2)	
	move.l	#new_direction_x,a0
	move.w	alien_direction(a2),d4
	move.b	(a0,d4.w),alien_direction+1(a2)		
	bra.s	do_maggot_y_test
maggot_not_hit_x

*add on increment
	add.w	d2,alien_x(a2)	

do_maggot_y_test

*use d5 and d6 - saved previously

	move.w	alien_work+2(a2),d2
	
	move.l	current_map_pointer,a0
	add.w	d2,d6		;add on y
	
	andi.w	#$fff0,d5
	asr	#3,d5
	asr	#4,d6
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d6
	add.l	d5,d6
	
	move.w	(a0,d6.l),d6

	asl	#BLOCK_STRUCT_MULT,d6
	move.l	#block_data_information,a0
	btst.b	#COLLISION_FLAG,block_details(a0,d6)
	beq.s	maggot_not_hit_y
	
*Go in opposite direction

	neg.w	alien_work+2(a2)	
	move.l	#new_direction_y,a0
	move.w	alien_direction(a2),d6
	move.b	(a0,d6.w),alien_direction+1(a2)		
	bra.s	done_maggot_tests
maggot_not_hit_y
			
*add on increment
	add.w	d2,alien_y(a2)	

done_maggot_tests
	move.l	d7,a0
	rts	

*********************************************
***      UPDATE MAGGOT POSITION           ***
*********************************************
Update_Maggot_Position

	subq.w	#1,alien_work+4(a2)
	beq.s	dont_explode_maggot
	bsr	Non_Explode_Update_Maggot_Position
	rts
dont_explode_maggot	
	move.l	#Explode_Maggot_Pattern,a5
	rts

	
	
*********************************************
***     Set_Up_Shrap_Pat                  ***
*********************************************	
Set_Up_Shrap_Pat
	move.l	#Shrap_Patt,alien_work(a2)
	move.w	#Shrap_Pat_Size,alien_counter(a2)
	rts	
	
*********************************************
***     Update Shrap                      ***
*********************************************	
Update_Shrap
	move.l	a5,d7

	move.l	alien_work(a2),a5
	move.w	(a5)+,d6
	cmp.w	#Sound_Pling,d6
	blt.s	not_a_shrap_sfx
	move.w	d6,sound_chan2
	move.w	(a5)+,d6
not_a_shrap_sfx	
	add.w	d6,alien_y(a2)
	move.l	a5,alien_work(a2)	
	move.l	d7,a5
	rts	
	
*********************************************
***     CHECK SKULL NOT IN WATER          ***
*********************************************
Check_Skull_Not_In_Water
	moveq	#0,d3
	moveq	#0,d5
	move.l	a0,d7
	move.w	alien_x(a2),d3
	move.w	alien_y(a2),d4
	
	addq.w	#6,d3	;test from middle of maggot
	addq.w	#6,d4	
	
	move.l	current_map_pointer,a0
	
	andi.w	#$fff0,d3
	asr	#3,d3
	asr	#4,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	add.l	d3,d4
	
	move.w	(a0,d4.l),d4

	asl	#BLOCK_STRUCT_MULT,d4
	move.l	#block_data_information,a0
	btst.b	#WATER_FLAG,block_details(a0,d4)
	beq.s	skull_not_hit_water
	move.l	#skull_kill,a5

	movem.l	d0-d1/a1-a2,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	subq.w	#5,d0
	subq.w	#5,d1
	move.l	#Generic_Splash_Object,d2
	bsr	Simple_Add_Alien_To_List
	movem.l	(sp)+,d0-d1/a1-a2
skull_not_hit_water	

	move.l	d7,a0
	rts	
	
*********************************************
***     BLOW UP LEVEL                     ***
*********************************************
Blow_Up_Level

	move.w	#1,count_down_to_death
	move.w	#END_LEVEL,Schedule_Entry
	move.l	#Shake_Data,Shake_pointer
	rts

*********************************************
***     ADD RANDOM EXPLODES               ***
*********************************************
Add_Random_Explodes

	move.w	#0,d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d0,d6
	
	move.w	#0,d0
	move.w	#240,d1
	bsr	Get_Random_Number
	move.w	d0,d7

	move.w	#0,d0
	move.w	#1,d1
	bsr	Get_Random_Number
	tst	d0
	beq.s	add_small_explosion
	
	move.w	scroll_x_position,d0
	add.w	d6,d0
	move.w	scroll_y_position,d1
	add.w	d7,d1
	move.l	#Dome_Explosion_Object,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_SExplo,sound_chan2
	rts
add_small_explosion	
	move.w	scroll_x_position,d0
	add.w	d6,d0
	move.w	scroll_y_position,d1
	add.w	d7,d1
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_SExplo,sound_chan1

	rts	
	
PIG_GUARD_CHECK	EQU	64
	


********************************************
**	Find_Random_Diretion_And_Time    ***
********************************************
Find_Random_Direction_And_Time

	movem.l	d0-d1,-(sp)

	move.w	#-64,d0
	move.w	#64,d1
	bsr	Get_Random_Number
	
	move.w	d0,alien_work(a2)
	
	move.w	#-64,d0
	move.w	#64,d1
	bsr	Get_Random_Number
	
	move.w	d0,alien_work+2(a2)
	
	move.w	#8,d0
	move.w	#40,d1
	bsr	Get_Random_Number

	move.w	d0,alien_counter(a2)
	clr.l	alien_data(a2)

	movem.l	(sp)+,d0-d1
	rts
	
********************************************
**	BUTTERFLY FOLLOW DIRECTION       ***
********************************************
Butterfly_Follow_Direction

	move.w	alien_data(a2),d6
	move.w	alien_data_extra(a2),d7
	
	add.w	alien_work(a2),d6	;incs to add
	add.w	alien_work+2(a2),d7
	
	move.w	d6,alien_data(a2)
	move.w	d7,alien_data_extra(a2)
	
	asr	#6,d6
	asr	#6,d7
	
	add.w	d6,alien_x(a2)
	add.w	d7,alien_y(a2)
	
	asl	#6,d6
	asl	#6,d7
	sub.w	d6,alien_data(a2)
	sub.w	d7,alien_data_extra(a2)

	rts	

************************************************
***   FIRE SPIDER BULLET                     ***
************************************************
Fire_Spider_Bullet

	movem.l	d0-d1/a0-a2,-(sp)
	move.w	alien_x(a2),d0
	addq.w	#5,d0
	move.w	alien_y(a2),d1
	add.w	#12,d1

	bsr	Find_Direction_Of_Bullet
	cmp.w	#10000,d5
	beq.s	dont_fire_spider_bullet


	move.l	#Spider_Missile_Object,d2
	clr.w	d3
	bsr	Simple_Add_Alien_To_List

	asl.w	#2,d5		;spider bullet = 4 pixels
	asl.w	#2,d6
	
	move.w	d5,alien_work(a1)
	move.w	d6,alien_work+2(a1)
	
	clr.w	alien_data_extra(a1)
dont_fire_spider_bullet	
	movem.l	(sp)+,d0-d1/a0-a2
	
	rts

******************************************
***          RE AIM SPIDER BULLET      ***
******************************************
Re_Aim_Spider_Bullet
	movem.l	d0-d1/a0-a2,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	bsr	Find_Direction_Of_Bullet
	cmp.w	#10000,d5
	bne.s	found_new_direction_of_spider_bullet
	move.l	alien_dead_pattern(a1),a5
	bra.s	quit_re_aim_spider_bullet
found_new_direction_of_spider_bullet
	asl.w	#2,d5		;spider bullet = 4 pixels
	asl.w	#2,d6
	move.w	d5,alien_work(a2)
	move.w	d6,alien_work+2(a2)
	clr.w	alien_data_extra(a2)
quit_re_aim_spider_bullet	
	movem.l	(sp)+,d0-d1/a0-a2
	rts

********************************************
**	ADD BIG RAIN DROP                ***
********************************************
Add_Big_Rain_Drop
	movem.l	a0-a2,-(sp)	
	clr.w	d0
	move.w	#240,d1
	bsr	Get_Random_Number
	move.w	d0,d7
	clr.w	d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d7,d1
	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	move.l	#Big_Rain_Drop,d2
	bsr	Simple_Add_Alien_To_List	
	movem.l	(sp)+,a0-a2
	rts

********************************************
**	ADD SMALL RAIN DROP              ***
********************************************
Add_Small_Rain_Drop
	movem.l	a0-a2,-(sp)	
	clr.w	d0
	move.w	#240,d1
	bsr	Get_Random_Number
	move.w	d0,d7
	clr.w	d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d7,d1
	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	move.l	#Small_Rain_Drop,d2
	bsr	Simple_Add_Alien_To_List	
	movem.l	(sp)+,a0-a2
	rts

********************************************
**	ADD SNOW FLAKE                   ***
********************************************
Add_Snow_Flake
	movem.l	a0-a2,-(sp)	
	clr.w	d0
	move.w	#100,d1
	bsr	Get_Random_Number
	move.w	d0,d7
	clr.w	d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d7,d1
	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	move.l	#Snow_Flake,d2
	bsr	Simple_Add_Alien_To_List	
	movem.l	(sp)+,a0-a2
	rts

********************************************
**	ADD SNOW FLAKE                   ***
********************************************
Add_Snow_Flake2
	movem.l	a0-a2,-(sp)	
	move.w	#10,d0
	move.w	#100,d1
	bsr	Get_Random_Number
	move.w	d0,d7
	clr.w	d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d7,d1
	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	move.l	#Snow_Flake2,d2
	bsr	Simple_Add_Alien_To_List	
	movem.l	(sp)+,a0-a2
	rts
	
********************************************
**	ADD SNOW FLAKE                   ***
********************************************
Add_Snow_Flake3
	movem.l	a0-a2,-(sp)	
	clr.w	d0
	move.w	#100,d1
	bsr	Get_Random_Number
	move.w	d0,d7
	clr.w	d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d7,d1
	add.w	scroll_x_position,d0
	add.w	scroll_y_position,d1

	move.l	#Snow_Flake3,d2
	bsr	Simple_Add_Alien_To_List	
	movem.l	(sp)+,a0-a2
	rts

********************************************
**	RANDOM FLASH                     ***
********************************************
Random_Flash

	clr.w	d0
	move.w	#15,d1
	bsr	Get_Random_Number
	cmp.w	#2,d0
	bgt.s	dont_flash
	move.l	#FlashTable,a4
	ext.l	d0
	lsl	#2,d0
	move.l	(a4,d0),a2	;change position of script
dont_flash	
	rts
	
FlashTable
	dc.l	Lightning1
	dc.l	Lightning2
	dc.l	Lightning3
	
********************************************
**	CONTROL WIND DIRECTION           ***
********************************************
Control_Wind_Direction

	subq.w	#1,Wind_Counter
	bge.s	Dont_Change_Wind_Direction
	move.w	#10,d0
	move.w	#25*4,d1	
	bsr	Get_Random_Number
	move.w	d0,Wind_Counter
	moveq.w	#0,d0
	move.w	#1,d1	
	bsr	Get_Random_Number
	move.w	d0,Wind_Direction	
	move.w	#1,Wind_Change	;start to speed up
	rts
Dont_Change_Wind_Direction
	move.w	Wind_Counter,d0

	tst.w	Wind_Change
	beq.s	Dont_Change_Speed
Dont_Change_Speed	
	cmp.w	#6,Wind_Counter
	bge.s	No_Need_To_Slow_Wind
	move.w	#-1,Wind_Change
No_Need_To_Slow_Wind
	
	rts

Wind_Counter
	dc.w	0
Wind_Direction
	dc.w	0	
Wind_Change
	dc.w	0		
	
Wind_Speeds
	dc.w	0,0,0
	dc.w	0,0,-1
	dc.w	0,-1,-2
	dc.w	-1,-1,-2
	dc.w	-2,-3,-4
	dc.w	-3,-5,-7
	
	dc.w	0,0,0	;right direction
	dc.w	0,0,1
	dc.w	0,1,2
	dc.w	1,1,2
	dc.w	2,3,4
	dc.w	3,5,7
	
********************************************
**	SET GAS SPURT SPEED              ***
********************************************
Set_Gas_Spurt_Speed

	movem.l	d0/a1,-(sp)
	clr.l	d1
	move.w	alien_hits(a2),d0
	move.l	alien_type_ptr(a2),a1
	move.w	alien_hit_count(a1),d1
	mulu	#80,d0
	divu	d1,d0
	asr.w	d0
	move.w	d0,Spurt_Speed2
	asr.w	d0
	move.w	d0,Spurt_Speed1
	movem.l	(sp)+,d0/a1
	rts	