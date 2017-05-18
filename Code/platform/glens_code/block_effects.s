*************************************************************
*                      BLOCK ROUTINES                       *
*************************************************************




block_effects_table

	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	up_slope
	dc.l	down_slope
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	spring_block
	dc.l	burn_squiz	
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	finished_level
	dc.l	make_log_fall
	dc.l	block_does_nothing 	;fruit 5
	dc.l	block_does_nothing 
	dc.l	block_does_nothing 
	dc.l	block_does_nothing 
	dc.l	block_does_nothing 
	dc.l	block_does_nothing 	;fruit 0
	dc.l	block_does_nothing


block_jump_effects_table

	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	block_does_nothing
	dc.l	hit_bump_block		;BUMP_BLOCK
	dc.l	knock_effect		;KNOCK_BLOCK	
	dc.l	make_block_explode
	dc.l	bring_up_text_window		;info block
	dc.l	block_does_nothing
	dc.l	block_does_nothing		;fire block	
	dc.l	arrow_up_routine
	dc.l	arrow_left_routine
	dc.l	arrow_right_routine	
	dc.l	block_does_nothing
	dc.l	block_does_nothing	;alien block
	dc.l	fruit5_routine
	dc.l	fruit4_routine
	dc.l	fruit3_routine
	dc.l	fruit2_routine
	dc.l	fruit1_routine
	dc.l	fruit0_routine
	dc.l	burst_ball_out

	
***************************************************
*******  BLOCK DOES NOTHING                  ******	
***************************************************
	
block_does_nothing
	rts
	
***************************************************
*******       UP SLOPE                       ******	
***************************************************

up_slope
	
	tst	xdirec
	beq.s	push_player
	bpl.s	quit_up_slope	
push_player	
	move.w	#-8,block_x_push
	rts
quit_up_slope	
	rts


	
***************************************************
*******         DOWN SLOPE                   ******	
***************************************************
	
down_slope
	
	tst	xdirec
	beq.s	push_player2
	bmi.s	quit_down_slope	
push_player2	
	move.w	#8,block_x_push
	rts
quit_down_slope	
	rts
	
		
***************************************************
*******  HIT BUMP BLOCK                      ******	
***************************************************
			
hit_bump_block
	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.b	#BLUE_BLOCK,(a4)		;move blue block into map
	
	move.w	#HIT_BLOCK_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Spangle,sound_chan1
	movem.l	(sp)+,d0-d2	
	rts			
	
	
***************************************************
*******  KNOCK EFFECT                        ******	
***************************************************
	
knock_effect
	move.w	#Sound_Headbutt,sound_chan1
	rts	
	
	
*******************************0********************
*******  MAKE BLOCK EXPLODE                  ******	
***************************************************
	
make_block_explode
	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.b	#0,(a4)	
	move.w	#CRACKED_BLOCK_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Blocksplit,sound_chan1
	movem.l	(sp)+,d0-d2	

	rts
	
***************************************************
*******  BRING UP TEXT WINDOW                 ******	
***************************************************
	
bring_up_text_window

	
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$dff000,a6
	move.w	#Sound_cowbell,sound_chan1
	bsr	sound_effects
	bsr	pause
	move.w	#0,fire
	bsr	sync
	move.l	#squiz_intro_script,a0
	bsr	start_script
	movem.l	(sp)+,d0-d7/a0-a6
	rts		

***************************************************
*******  SPRING BLOCK                        ******	
***************************************************

spring_block
	bset.b	#SPRING_FLAG,player_control_bits
	move.w	#0,supress_repeat_jump
	rts		
	
***************************************************
*******         BURN SQUIZ                   ******	
***************************************************

SQUIZ_NOT_HIT	EQU	0	
SQUIZ_BEEN_HIT	EQU	1
SQUIZ_DEAD	EQU	2
SQUIZ_DYING	EQU	3	
	
burn_squiz
	move.w	#SQUIZ_DEAD,player_has_been_hit	;2 means death
****ADD CODE TO ADD ALIEN TO MAKE SQUIZ SAY OUCH
	rts
	


***************************************************
*******        ARROW UP ROUTINE              ******	
***************************************************
arrow_up_routine
	movem.l	d0-d2,-(sp)
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	tst.b	-MAP_LINE_SIZE(a4)
	bne.s	dont_move_up_block
	move.b	#0,(a4)		;clear until block stopped
	move.b	#ARROW_UP_NUM,-MAP_LINE_SIZE(a4)
	
	move.w	#ARROW_UP_BLOCK_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Slide,sound_chan1
dont_move_up_block
	movem.l	(sp)+,d0-d2
	rts

***************************************************
*******        ARROW LEFT ROUTINE            ******	
***************************************************	
arrow_left_routine
	movem.l	d0-d2,-(sp)
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	tst.b	-1(a4)
	bne.s	dont_move_left_block
	move.b	#0,(a4)		;clear until block stopped
	move.b	#ARROW_LEFT_NUM,-1(a4)
	
	move.w	#ARROW_LEFT_BLOCK_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Slide,sound_chan1
dont_move_left_block
	movem.l	(sp)+,d0-d2
	rts
	
***************************************************
*******        ARROW RIGHT ROUTINE           ******	
***************************************************
arrow_right_routine
	movem.l	d0-d2,-(sp)
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	tst.b	1(a4)
	bne.s	dont_move_right_block
	move.b	#0,(a4)		;clear until block stopped
	move.b	#ARROW_RIGHT_NUM,1(a4)
	
	move.w	#arrow_right_block_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Slide,sound_chan1
dont_move_right_block
	movem.l	(sp)+,d0-d2
	rts
	
***************************************************
*******        FINISHED LEVEL                ******	
***************************************************
finished_level

	move.w	#LEVEL_SELECTION,Game_Flags
	rts

***************************************************
*******        MAKE LOG FALL                 ******	
***************************************************
make_log_fall
	movem.l	d0-d2,-(sp)
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	clr.b	(a4)
	move.w	#Log_Character,d2
	bsr	Add_An_Enemy
	movem.l	(sp)+,d0-d2

	rts
	
	
***************************************************
*******        FRUIT5 ROUTINE                ******	
***************************************************
fruit5_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BORING_BLOCK,(a4)
	move.b	#FRUIT_BLOCK4,fruit_block_number
	move.w	#FruitBlock_Character1,d2
	bsr	add_an_enemy	
	movem.l	(sp)+,d0-d2	
	move.w	#Sound_Fruit,sound_chan1

	rts
	
***************************************************
*******        FRUIT4 ROUTINE                ******	
***************************************************
fruit4_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BORING_BLOCK,(a4)			
	move.b	#FRUIT_BLOCK3,fruit_block_number
	move.w	#FruitBlock_Character2,d2
	bsr	add_an_enemy	
	move.w	#Sound_Fruit,sound_chan1

	movem.l	(sp)+,d0-d2	


	rts

***************************************************
*******        FRUIT3 ROUTINE                ******	
***************************************************
fruit3_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BORING_BLOCK,(a4)
				
	move.b	#FRUIT_BLOCK2,fruit_block_number
	move.w	#FruitBlock_Character3,d2
	bsr	add_an_enemy	
	move.w	#Sound_Fruit,sound_chan1


	movem.l	(sp)+,d0-d2	


	rts

***************************************************
*******        FRUIT2 ROUTINE                ******	
***************************************************
fruit2_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BORING_BLOCK,(a4)
				
	move.b	#FRUIT_BLOCK1,fruit_block_number
	move.w	#FruitBlock_Character4,d2
	bsr	add_an_enemy	
	move.w	#Sound_Fruit,sound_chan1
	
	movem.l	(sp)+,d0-d2	


	rts

***************************************************
*******        FRUIT1 ROUTINE                ******	
***************************************************
fruit1_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BORING_BLOCK,(a4)
	move.b	#FRUIT_FINAL_BLOCK,fruit_block_number			
	move.w	#FruitBlock_Character5,d2
	bsr	add_an_enemy	
	move.w	#Sound_Fruit,sound_chan1

	movem.l	(sp)+,d0-d2	


	rts
	
***************************************************
*******        FRUIT0 ROUTINE                ******	
***************************************************
fruit0_routine	

	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.l	a4,fruit_address
	move.b	#BLUE_BLOCK,(a4)
	move.b	#BLUE_BLOCK,fruit_block_number			

	move.w	#FruitBlock_Character6,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Fruit,sound_chan1


	movem.l	(sp)+,d0-d2	


	rts
	
***************************************************
*******        ACTIVATE FRUIT BLOCK          ******	
***************************************************
activate_fruit_block

	move.l	a0,-(sp)
	move.l	fruit_address,a0
	move.b	fruit_block_number,(a0)	
	move.l	(sp)+,a0

	rts



fruit_address	dc.l	0
fruit_block_number
		dc.b	0	
		EVEN
	
	
***************************************************
******     CHOOSE RANDOM FRUIT               ******	
***************************************************	
choose_random_fruit

	move.w	d0,d6
	move.w	d1,d7
	move.w	#FruitBlock_Character1,d0
	move.w	#FruitBlock_Character5,d1
	jsr	Get_Random_Number
	move.w	d0,d2
	move.w	d6,d0
	move.w	d7,d1
	bsr	Add_An_Enemy
	move.w	#Sound_Spangle,sound_chan1
	
	rts
	
***************************************************
******     BURST BALL OUT                    ******	
***************************************************	
burst_ball_out
	movem.l	d0-d2,-(sp)
	
	move.w	top_block(a4),d1
	move.w	x_block_pos(a4),d0
	move.l	block_mem_pos(a4),a4
	move.b	#0,(a4)		;move blue block into map
	
	move.w	#GlassBLOCK_Character,d2
	bsr	Add_An_Enemy
	move.w	#Sound_Spangle,sound_chan1
	movem.l	(sp)+,d0-d2	

	rts