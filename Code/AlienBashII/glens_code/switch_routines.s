BLK_X_MAX		EQU	320+32
BLK_X_MIN		EQU	-48

BLK_Y_MAX		EQU	240+48
BLK_Y_MIN		EQU	-48


MAX_SWITCH_LISTS	EQU	10


SWITCH_WAIT			EQU	-1	;Put between commands to break up processing
SWITCH_END			EQU	0
SWITCH_ADD_BLOCK		EQU	1*4
SWITCH_ADD_DESTROY_BLOCK	EQU	2*4
SWITCH_ADD_ALIEN		EQU	3*4
SWITCH_ADD_ALIEN_TO_MAP		EQU	4*4
SWITCH_CHANGE_BLOCK		EQU	5*4
SWITCH_CHANGE_BLOCK_COLUMN	EQU	6*4
SWITCH_CHANGE_BLOCK_ROW		EQU	7*4
SWITCH_DEACTIVATE		EQU	8*4
SWITCH_REACTIVATE		EQU	9*4
SWITCH_COUNT			EQU	10*4
SWITCH_SET_COUNT		EQU	11*4
EVENT_DEACTIVATE		EQU	12*4
EVENT_REACTIVATE		EQU	13*4
SWITCH_REMOVE_ALIEN		EQU	14*4
SWITCH_TEST			EQU	15*4
SWITCH_ADD_DESTROY_BLOCK_ROW	EQU	16*4
SWITCH_ADD_FIRE_BLOCK		EQU	17*4
SWITCH_SET_DATA			EQU	18*4
SWITCH_ADD_DESTROY_BLOCK_COLUMN	EQU	19*4
SWITCH_ADD_BLOCK_COLUMN		EQU	20*4
SWITCH_ADD_BLOCK_ROW		EQU	21*4
SWITCH_CLEAR_VAR		EQU	22*4
SWITCH_INC_VAR			EQU	23*4
SWITCH_DEC_VAR			EQU	24*4
SWITCH_SET_VAR			EQU	25*4
SWITCH_JUMP			EQU	26*4
SWITCH_SCROLL_GOTO		EQU	27*4
SWITCH_RELEASE_SCROLL		EQU	28*4
SWITCH_SET_ADDRESS		EQU	29*4
SWITCH_SET_WAVE			EQU	30*4
SWITCH_ADD_ALIEN_NUM		EQU	31*4
SWITCH_ADD_POST_COLUMN		EQU	32*4
SWITCH_ADD_POST_ROW		EQU	33*4
SWITCH_ADD_POST			EQU	34*4

*Very game specific routines

SWITCH_SOUND_CHAN4		EQU	35*4
SWITCH_EXECUTE_CODE		EQU	36*4
SWITCH_INSERT_PALETTE		EQU	37*4
SWITCH_SET_STATUE_COUNT		EQU	38*4
SWITCH_SET_STATUE_SCRIPT	EQU	39*4
SWITCH_SOUND_THUN		EQU	40*4
SWITCH_SET_RAIN_VOL		EQU	41*4
SWITCH_INSERT_GEN_PALETTE	EQU	42*4

*Back to normal type things
SWITCH_JUMP_RANDOM		EQU	43*4
SWITCH_ADD_EXPLO_BLOCK_ROW	EQU	44*4	;exploding block - not bullet
SWITCH_ADD_EXPLO_BLOCK_COLUMN	EQU	45*4
SWITCH_SOUND_CHAN3		EQU	46*4

***********************************
****   PROCESS SWITCH LISTS    ****
***********************************
Process_Switch_lists

	move.l	#switch_list,a0
	move.l	a0,a1
	move.l	#Switch_Routine_Jump_Table,a3
switch_loop
	move.l	(a0)+,a2
	cmp.l	#$ffffffff,a2
	beq.s	finished_switch_list	
execute_switch_pat
	moveq	#0,d0
	move.w	(a2)+,d0
	beq.s	next_switch_list
	bmi.s	keep_switch_in_list
	move.l	(a3,d0.w),a4
	jsr	(a4)	
	bra.s	execute_switch_pat
keep_switch_in_list
	move.l	a2,(a1)+	
next_switch_list
	bra.s	switch_loop		

finished_switch_list
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
	rts
	
Switch_Routine_Jump_Table
	dc.l	null_routine	; nothing
	dc.l	Switch_Add_Block_Routine
	dc.l	Switch_Add_Destroy_Block_Routine
	dc.l	Switch_Add_Alien_Routine
	dc.l	Switch_Add_Alien_To_Map_Routine
	dc.l	Switch_Change_Block_Routine
	dc.l	Switch_Change_Column_Blocks_Routine
	dc.l	Switch_Change_Row_Blocks_Routine
	dc.l	Deactivate_Switch_Routine
	dc.l	Reactivate_Switch_Routine
	dc.l	Switch_Count_Routine
	dc.l	Switch_Set_Count_Routine
	dc.l	Deactivate_Event_Routine
	dc.l	Reactivate_Event_Routine
	dc.l	Switch_Remove_Alien_Routine
	dc.l	Switch_Test_Routine
	dc.l	Switch_Add_Destroy_Block_Row_Routine
	dc.l	Switch_Add_Fire_Block_Routine
	dc.l	Switch_Set_Data_Routine	
	dc.l	Switch_Add_Destroy_Block_Column_Routine
	dc.l	Switch_Add_Block_Column_Routine
	dc.l	Switch_Add_Block_Row_Routine
	dc.l	Switch_Clear_Var_Routine
	dc.l	Switch_Inc_Var_Routine
	dc.l	Switch_Dec_Var_Routine
	dc.l	Switch_Set_Var_Routine
	dc.l	Switch_Jump_Routine
	dc.l	Switch_Goto_Scroll_Routine
	dc.l	Switch_Release_Scroll_Routine
	dc.l	Switch_Set_Address_Routine
	dc.l	Switch_Set_Wave_Routine
	dc.l	Switch_Add_Alien_Block
	dc.l	Switch_Add_Post_Column_Routine
	dc.l	Switch_Add_Post_Row_Routine
	dc.l	Switch_Add_Post_Routine
	dc.l	Switch_Sound_Chan4_Routine
	dc.l	Switch_Execute_Code_Routine
	dc.l	Switch_Insert_Palette_Routine
	dc.l	Switch_Set_Statue_Count_Routine
	dc.l	Switch_Set_Statue_Script_Routine
	dc.l	Switch_Sound_Thun_Routine
	dc.l	Switch_Set_Rain_Vol_Routine
	dc.l	Switch_Insert_Generator_Palette_Routine
	dc.l	Switch_Jump_To_Random_Routine
	dc.l	Switch_Add_Explo_Block_Row_Routine
	dc.l	Switch_Add_Explo_Block_Column_Routine
	dc.l	Switch_Sound_Chan3_Routine

************************************************
***     SWITCH JUMP TO RANDOM ROUTINE        ***
************************************************
Switch_Jump_To_Random_Routine
	clr.w	d0		;set up random range
	move.w	(a2)+,d1
	bsr	Get_Random_Number
	ext.l	d0
	lsl.w	#2,d0		;mult up
	move.l	(a2,d0.l),a2		;go there!!!
	rts

************************************************
***     SWITCH SET RAIN VOL ROUTINE          ***
************************************************
Switch_Set_Rain_Vol_Routine
	move.w	(a2)+,aud0+ac_vol(a6)
	rts

************************************************
***     SWITCH SET STATUE COUNT ROUTINE      ***
************************************************
Switch_Set_Statue_Count_Routine
	move.w	(a2)+,Statue_Counter
	rts

************************************************
***     SWITCH SET STATUE SCRIPT ROUTINE     ***
************************************************
Switch_Set_Statue_Script_Routine
	move.l	(a2)+,Statue_Script_Ptr
	rts

************************************************
***     SWITCH INSERT PALETTE ROUTINE        ***
************************************************
Switch_Insert_Palette_Routine
	move.w	(a2)+,d0
	move.l	#Level_1_Colour_List_Bright,a4
	lsl.w	#5,d0
	add.l	d0,a4
	
	move.l	#copper_colours+2,a5
	move.w	#16-1,d0
insert_faded_palette
	move.w	(a4)+,(a5)
	addq.l	#4,a5
	dbra	d0,insert_faded_palette	
	rts

************************************************
***SWITCH INSERT GENERATOR PALETTE ROUTINE   ***
************************************************
Switch_Insert_Generator_Palette_Routine
	move.l	#Generator_Palette,a4
	move.l	#copper_colours+2,a5
	move.w	#16-1,d0
insert_gen_palette
	move.w	(a4)+,(a5)
	addq.l	#4,a5
	dbra	d0,insert_gen_palette	
	rts


************************************************
***     SWITCH EXECUTE CODE                  ***
************************************************
Switch_Execute_Code_Routine
	move.l	(a2)+,a5
	jsr	(a5)
	rts
	
************************************************
***     SWITCH SOUND CHAN 4                  ***
************************************************
Switch_Sound_Chan4_Routine
	move.w	(a2)+,sound_chan4
	rts	

************************************************
***     SWITCH SOUND CHAN 3                  ***
************************************************
Switch_Sound_Chan3_Routine
	move.w	(a2)+,sound_chan3
	rts	

************************************************
***     SWITCH SOUND THUN                    ***
************************************************
Switch_Sound_Thun_Routine
	move.w	#sound_thunder,sound_chan4
	rts	


************************************************
***     SWITCH SET WAVE ROUTINE              ***
************************************************
Switch_Set_Wave_Routine
*script =
*SWITCH_ADD_WAVE
*dc.l	?		;counter + death script address
*dc.w	x,y		;alien x and y
*dc.l	alien_num	;alien struct number

	move.l	a0,d5		;faster than stack
	move.l	a1,d6

	move.l	(a2)+,a5	;store counter mem pos
	
	move.w	(a2)+,d0	;get x,y
	move.w	(a2)+,d1	
	move.l	(a2)+,d2	;alien struct
	move.l	a2,d7

	bsr	Simple_Add_Alien_To_List
	move.l	a5,alien_script(a1)
	
	move.l	d5,a0
	move.l	d6,a1
	move.l	d7,a2	
	rts	


	
*Remember we are using a0-a3 only
*pattern in a2

************************************************
***     SWITCH RELEASE SCROLL ROUTINE        ***
************************************************
Switch_Release_Scroll_Routine
	clr.w	freeze_scroll
	rts

************************************************
***        SWITCH GOTO SCROLL ROUTINE        ***
************************************************
Switch_Goto_Scroll_Routine
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	sub.w	scroll_x_position,d0
	sub.w	scroll_y_position,d1
		
	move.w	d0,goto_sc_x
	move.w	d1,goto_sc_y
		
	move.w	#1,goto_flag	;start movement
	move.w	#1,freeze_scroll
	rts


************************************************
***        SWITCH JUMP ROUTINE               ***
************************************************
Switch_Jump_Routine
	move.l	(a2),a2
	rts


************************************************
***        SWITCH CLEAR VAR ROUTINE          ***
************************************************
Switch_Clear_Var_Routine
	move.l	(a2)+,a4
	clr.w	(a4)
	rts

************************************************
***        SWITCH INC VAR ROUTINE            ***
************************************************
Switch_Inc_Var_Routine
	move.l	(a2)+,a4
	addq.w	#1,(a4)
	rts

************************************************
***        SWITCH DEC VAR ROUTINE            ***
************************************************
Switch_Dec_Var_Routine
	move.l	(a2)+,a4
	subq.w	#1,(a4)
	rts

************************************************
***        SWITCH SET VAR ROUTINE            ***
************************************************
Switch_Set_Var_Routine
	move.l	(a2)+,a4
	move.w	(a2)+,(a4)
	rts

************************************************
***        SWITCH SET ADDRESS ROUTINE        ***
************************************************
Switch_Set_Address_Routine
	move.l	(a2)+,a4
	move.l	(a2)+,(a4)
	rts



************************************************
***         SWITCH SET DATA ROUTINE          ***
************************************************
Switch_Set_Data_Routine
	move.l	(a2)+,a4
	move.w	(a2)+,(a4)	;umm same as set var??
	rts
	
************************************************
***         SWITCH TEST ROUTINE              ***
************************************************
Switch_Test_Routine

	move.l	(a2)+,a4	;variable to test
	move.w	(a2)+,d6	;num to test
	cmp.w	(a4),d6
	beq.s	move_to_new_script_pos
	addq.l	#4,a2
	rts
move_to_new_script_pos	
	move.l	(a2),a2
	rts
	
************************************************
***         SWITCH COUNT ROUTINE             ***
************************************************
Switch_Count_Routine
*in switch data must have switch wait, followed by switch count, then number


	subq.w	#1,(a2)+
	ble.s	move_past_switch_command
	subq.l	#6,a2	;go back
move_past_switch_command
	rts

************************************************
***       DEACTIVATE EVENT ROUTINE           ***
************************************************	
Deactivate_Event_Routine
	moveq	#0,d0
	move.w	(a2)+,d0		;switch to deac
	subq.w	#1,d0			;numbered from 1
	move.l	#Event_Table,a5
	asl	#2,d0
	clr.l	(a5,d0.l)	
	rts

************************************************
***       REACTIVATE EVENT ROUTINE           ***
************************************************	
Reactivate_Event_Routine
	moveq	#0,d0
	move.w	(a2)+,d0		;switch to reac
	subq.w	#1,d0			;numbered from 1
	asl	#2,d0
	move.l	current_level,a5
	move.l	level_activator_table(a5),a5
	move.l	(a5,d0.l),d1
	move.l	#Event_Table,a5
	move.l	d1,(a5,d0.l)	
	rts	

	
************************************************
***       DEACTIVATE SWITCH ROUTINE          ***
************************************************	
Deactivate_Switch_Routine
	moveq	#0,d0
	move.w	(a2)+,d0		;switch to deac
	subq.w	#1,d0			;numbered from 1
	move.l	#Switch_Table,a5
	asl	#2,d0
	clr.l	(a5,d0.l)	
	rts

************************************************
***       SWITCH SET COUNT ROUTINE           ***
************************************************	
Switch_Set_Count_Routine
*followed by num - will write into space after SWITCH_WAIT & SWITCH_COUNT

	move.w	(a2)+,4(a2)

	rts	
	
************************************************
***       REACTIVATE SWITCH ROUTINE          ***
************************************************
Reactivate_Switch_Routine
	moveq	#0,d0
	move.w	(a2)+,d0		;switch to deac
	subq.w	#1,d0			;numbered from 1
	asl	#2,d0
	move.l	current_level,a5
	move.l	level_switch_table(a5),a5
	move.l	(a5,d0.l),d1
	move.l	#Switch_Table,a5
	move.l	d1,(a5,d0.l)	
	rts	

************************************************
***  SWITCH CHANGE COLUMN BLOCKS ROUTINE     ***
************************************************
Switch_Change_Column_Blocks_Routine
	clr.l	d0
	move.w	(a2)+,d0	;x
	move.w	(a2)+,d1	;y
	mulu	#BIGGEST_MAP_X*2,d1
	move.l	current_map_pointer,a5
	add.l	d1,a5
	asl	d0
	add.l	d0,a5
loop_until_end_column
	cmp.w	#$ffff,(a2)
	beq.s	done_the_column
	move.w	(a2)+,(a5)
	add.l	#BIGGEST_MAP_X*2,a5
	bra.s	loop_until_end_column
done_the_column
	rts

************************************************
***    SWITCH CHANGE ROW BLOCKS ROUTINE      ***
************************************************
Switch_Change_Row_Blocks_Routine
	clr.l	d0
	move.w	(a2)+,d0	;x
	move.w	(a2)+,d1	;y
	mulu	#BIGGEST_MAP_X*2,d1
	move.l	current_map_pointer,a5
	add.l	d1,a5
	asl	d0
	add.l	d0,a5
loop_until_end_row
	cmp.w	#$ffff,(a2)
	beq.s	done_the_row
	move.w	(a2)+,(a5)+
	bra.s	loop_until_end_row
done_the_row
	rts


************************************************
***       SWITCH REMOVE ALIEN ROUTINE        ***
************************************************
Switch_Remove_Alien_Routine

	moveq	#0,d4
	move.w	(a2)+,d4	;block x
	move.w	(a2)+,d3	;block y
	move.l	current_alien_map_pointer,a5
	mulu	#BIGGEST_MAP_X,d3
	add.l	d4,d3
	clr.b	(a5,d3.l)
	rts
	
************************************************
***       SWITCH ADD ALIEN BLOCK             ***
************************************************
Switch_Add_Alien_Block

	moveq	#0,d4
	move.w	(a2)+,d4	;block x
	move.w	(a2)+,d3	;block y
	move.w	(a2)+,d5	;alien to add

	move.l	current_alien_map_pointer,a5
	mulu	#BIGGEST_MAP_X,d3
	add.l	d4,d3
	move.b	d5,(a5,d3.l)
	rts
	

************************************************
***       SWITCH CHANGE BLOCK ROUTINE        ***
************************************************
Switch_Change_Block_Routine

	clr.l	d0
	move.w	(a2)+,d0	;x
	move.w	(a2)+,d1	;y
	
	mulu	#BIGGEST_MAP_X*2,d1
	move.l	current_map_pointer,a5

	add.l	d1,a5
	asl	d0
	move.w	(a2)+,(a5,d0)
	rts


*************************************
***   SWITCH ADD DESTROY BLOCK    ***
*************************************
Switch_Add_Destroy_Block_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y
	move.w (a2)+,d2		;block number
		
*Stuff data into map
	move.l	current_map_pointer,a4
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	asl	d3
	add.l	d3,d4
	
	move.w	d2,(a4,d4.l)		;updated mem		
	move.w	d2,d7
	
	asl	#4,d0		;change from block pos to pixel pos
	asl	#4,d1
	
	movem.l	a0-a3,-(sp)
	move.l	#small_explo_bullet,d2	;special bullet!!! - not an alien
	bsr	Add_Bullet_To_List
	
	move.w	#Sound_SExplo,sound_chan2
	
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2		
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,a0-a3
	rts


*************************************
***   SWITCH ADD FIRE BLOCK       ***
*************************************
Switch_Add_Fire_Block_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y
	move.w (a2)+,d2		;block number
		
*Stuff data into map
	move.l	current_map_pointer,a4
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	asl	d3
	add.l	d3,d4
	
	move.w	d2,(a4,d4.l)		;updated mem		
	move.w	d2,d7
	
	asl	#4,d0		;change from block pos to pixel pos
	asl	#4,d1
	
	movem.l	a0-a3,-(sp)
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	
	move.w	#Sound_SExplo,sound_chan2
	
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1
	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,a0-a3
	rts


*********************************************
***   SWITCH ADD EXPLO BLOCK ROW BLOCK    ***
*********************************************
Switch_Add_Explo_Block_Row_Routine

	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	move.w	#Sound_SExplo,sound_chan2
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_explo_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_explo
		
	move.w	d2,(a4)+		;updated mem		
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1

	move.l	#small_explosion_object,d2
	bsr	Simple_Add_Alien_To_List

	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d0		;next block along
	bra.s	Switch_explo_loop
finished_explo
	movem.l	(sp)+,a0/a1/a3
	rts

*******************************************
***    SWITCH ADD EXPLO BLOCK COLUMN    ***
*******************************************
Switch_Add_Explo_Block_Column_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	move.w	#Sound_SExplo,sound_chan2
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_dcexplo_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_dcexplo
*Stuff data into map
	
	
	move.w	d2,(a4)		;updated mem		
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a4
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1
	
	move.l	#small_explosion_object,d2
	bsr	Simple_Add_Alien_To_List

	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack

	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d1		;next block down
	bra	Switch_dcexplo_loop
finished_dcexplo
	movem.l	(sp)+,a0/a1/a3
	rts


*******************************************
***   SWITCH ADD DESTROY BLOCK ROW      ***
*******************************************
Switch_Add_Destroy_Block_Row_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	move.w	#Sound_SExplo,sound_chan2
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_dr_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_dr
*Stuff data into map
	
	
	move.w	d2,(a4)+		;updated mem		
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1

	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
			
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	
	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d0		;next block along
	bra.s	Switch_dr_loop
finished_dr
	movem.l	(sp)+,a0/a1/a3
	rts

*******************************************
***   SWITCH ADD BLOCK ROW              ***
*******************************************
Switch_Add_Block_Row_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_ar_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_ar
*Stuff data into map
	
	
	move.w	d2,(a4)+		;updated mem		
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1

	move.l	#Generic_Block_Alien,d2
	bsr	Simple_Add_Alien_To_List
		
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d0		;next block along
	bra	Switch_ar_loop
finished_ar
	movem.l	(sp)+,a0/a1/a3
	rts

*******************************************
***   SWITCH ADD BLOCK COLUMN           ***
*******************************************
Switch_Add_Block_Column_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_ac_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_ac
*Stuff data into map
	
	
	move.w	d2,(a4)		;updated mem		
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a4
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1

	move.l	#Generic_Block_Alien,d2
	bsr	Simple_Add_Alien_To_List
		
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d1		;next block along
	bra	Switch_ac_loop
finished_ac
	movem.l	(sp)+,a0/a1/a3
	rts


*******************************************
***   ADD POST DATA 	                ***
*******************************************
Add_Post_Data
*send d0, d1 (as block pos) and d7 = post block
		
*Stuff data into map
		

	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1

	btst	#0,d7		;find out post type
	beq.s	post_sdown_alien
	cmp.w	#POST_UP_SHAD,d7
	beq.s	use_shadow_alien
	move.l	#Post_Move_Up_Object,d2	;burns block itself
	bra.s	do_post_add
use_shadow_alien
	move.l	#Post_Move_UpShad_Object,d2	;burns block itself
do_post_add	
	bsr	Simple_Add_Alien_To_List
	rts
post_sdown_alien
	move.l	#Post_Move_Down_Object,d2
do_spost_man	
	bsr	Simple_Add_Alien_To_List
		
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1
	
	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack
	rts

*******************************************
***   SWITCH ADD POST 	                ***
*******************************************
Switch_Add_Post_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	move.w	(a2)+,d7	;get blk num
	move.w	d7,(a4,d4.l)	;change mem

	movem.l	a0-a3,-(sp)

	bsr	Add_Post_Data	
	
	movem.l	(sp)+,a0-a3
	rts


*******************************************
***   SWITCH ADD POST ROW              ***
*******************************************
Switch_Add_Post_Row_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_post_loop	
	move.w (a2)+,d7		;block number
	bmi.s	finished_post
*Stuff data into map
	
	
	move.w	d7,(a4)+		;updated mem	

	movem.l	d0-d1/a2/a4,-(sp)
	bsr	Add_Post_Data
	movem.l	(sp)+,d0-d1/a2/a4
	
	addq.w	#1,d0		;next block along
	bra	Switch_post_loop
finished_post
	movem.l	(sp)+,a0/a1/a3
	rts

*******************************************
***   SWITCH ADD POST BLOCK COLUMN      ***
*******************************************
Switch_Add_Post_Column_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_postc_loop	
	move.w (a2)+,d7		;block number
	bmi.s	finished_postc
*Stuff data into map
	
	
	move.w	d7,(a4)		;updated mem		
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a4

	movem.l	d0-d1/a2/a4,-(sp)
	bsr	Add_Post_Data	
	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d1		;next block along
	bra	Switch_postc_loop
finished_postc
	movem.l	(sp)+,a0/a1/a3
	rts

*******************************************
***   SWITCH ADD DESTROY BLOCK COLUMN   ***
*******************************************
Switch_Add_Destroy_Block_Column_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y

	move.w	#Sound_SExplo,sound_chan2
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	lsl	d3
	add.l	d3,d4
	move.l	current_map_pointer,a4
	add.l	d4,a4

	movem.l	a0/a1/a3,-(sp)
		
Switch_dc_loop	
	move.w (a2)+,d2		;block number
	bmi.s	finished_dc
*Stuff data into map
	
	
	move.w	d2,(a4)		;updated mem		
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a4
	move.w	d2,d7

	movem.l	d0-d1/a2/a4,-(sp)
	lsl	#4,d0		;change from block pos to pixel pos
	lsl	#4,d1
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
		
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack

	movem.l	(sp)+,d0-d1/a2/a4
	addq.w	#1,d1		;next block down
	bra	Switch_dc_loop
finished_dc
	movem.l	(sp)+,a0/a1/a3
	rts


*************************************
***       SWITCH ADD BLOCK        ***
*************************************
Switch_Add_Block_Routine
	move.w (a2)+,d0		;x
	move.w (a2)+,d1		;y
	move.w (a2)+,d2		;block number
		
*Stuff data into map
	move.l	current_map_pointer,a4
	
	moveq	#0,d3
	move.w	d0,d3
	move.w	d1,d4
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d4
	asl	d3
	add.l	d3,d4
	
	move.w	d2,(a4,d4.l)		;updated mem		
	move.w	d2,d7
	
	asl	#4,d0		;change from block pos to pixel pos
	asl	#4,d1
	
	movem.l	a0-a3,-(sp)
	move.l	#Generic_Block_Alien,d2
	bsr	Simple_Add_Alien_To_List
	
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1

	move.w	d7,d2	
	bsr	Draw_68000_Block_Into_CopyBack

	movem.l	(sp)+,a0-a3
	rts

*************************************
***       SWITCH ADD ALIEN        ***
*************************************
Switch_Add_Alien_Routine
	
	move.l	a0,d5		;faster than stack
	move.l	a1,d6
	
	move.w	(a2)+,d0	;x
	move.w	(a2)+,d1	;y
	move.l	(a2)+,d2	;alien struct
	move.l	a2,d7

	bsr	Simple_Add_Alien_To_List
	
	move.l	d5,a0
	move.l	d6,a1
	move.l	d7,a2
	
	rts	
	
*************************************
***       SWITCH ADD ALIEN TO MAP ***
*************************************
Switch_Add_Alien_To_Map_Routine
	
	move.l	a0,d5		;faster than stack
	move.l	a1,d6
	
	move.w	(a2)+,d2
	move.w	(a2)+,d0	;x
	move.w	(a2)+,d1	;y


	moveq	#0,d4
	move.l	current_alien_map_pointer,a5
	move.w	d0,d4
	move.w	d1,d3
	asr	#4,d4
	asr	#4,d3
	mulu	#BIGGEST_MAP_X,d3
	add.l	d4,d3
	add.l	d3,a5
	add.b	#128,d2
	move.b	d2,(a5)
	
	
	move.l	(a2)+,d2	;alien struct
	move.l	a2,d7

	bsr	Simple_Add_Alien_To_List
	move.l	a5,alien_map_pos(a1)
	
	move.l	d5,a0
	move.l	d6,a1
	move.l	d7,a2
	
	rts	
	
***********************************
****   SWITCH SETUP            ****
***********************************
Switch_SetUp
	
	move.l	current_level,a0
	move.l	level_switch_table(a0),a1
	move.l	level_activator_table(a0),a2
	
	move.l	#Switch_Table,a3
	move.w	#MAX_SWITCHES-1,d0
set_up_switch_list_loop
	cmp.l	#$ffffffff,(a1)
	bne.s	not_end_of_switch_setup_list
	clr.l	(a3)+
	bra.s	keep_init_switch
not_end_of_switch_setup_list	
	move.l	(a1)+,(a3)+
keep_init_switch	
	dbra	d0,set_up_switch_list_loop	

	move.l	#Event_Table,a4
	move.w	#MAX_EVENTS-1,d0
set_up_event_list_loop
	cmp.l	#$ffffffff,(a2)
	bne.s	not_end_of_event_setup_list
	clr.l	(a4)+
	bra.s	keep_init_event	
not_end_of_event_setup_list	
	move.l	(a2)+,(a4)+
keep_init_event	
	dbra	d0,set_up_event_list_loop	

	move.l	#switch_list,switch_list_pointer
	move.l	#$ffffffff,switch_list
	rts	
	
switch_list
	ds.l	MAX_SWITCH_LISTS
	dc.l	$ffffffff
	
	
	
switch_list_pointer
	dc.l	0
	
goto_sc_x	dc.w	0
goto_sc_y	dc.w	0
goto_flag	dc.w	0