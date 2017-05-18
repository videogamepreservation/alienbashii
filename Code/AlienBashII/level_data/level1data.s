****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Intro_Level_switch_table
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0 
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Remove_Wall
	dc.l	$ffffffff	;terminate event list if less than 20

		
Intro_Level_Activate_Table
	dc.l	Gate_Pig_Appear_1
	dc.l	Gate_Pig_Appear_2
	dc.l	Bush_To_Pig_1
	dc.l	Level1_Pigs_Appear
	dc.l	Level1_Scroll_Goto
	dc.l	Level1_Pigs_Appear_2
	dc.l	$ffffffff	;terminate switch list if less than 60

Level1_Pigs_Appear
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(104*16),(83*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

Level1_Pigs_Appear_2
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(78*16),(54*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	SWITCH_ADD_ALIEN
	dc.w	(78*16),(60*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END





*Switch 9 - remove wall piece at the start

Remove_Wall
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,97
	dc.w	738,873,1,1,714,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,96
	dc.w	718,754,1,1,694,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,95
	dc.w	698,754,1,1,674,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,94
	dc.w	678,734,1,1,654,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,93
	dc.w	673,1,1,1,731,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	26,92
	dc.w	653,1,1,1,711,$ffff
	dc.w	SWITCH_END
	

*Event 1 - appear Pig at end of level gate and deactivate Event 2

Gate_Pig_Appear_1
	dc.w	Event_Deactivate
	dc.w	2

	dc.w	SWITCH_ADD_ALIEN
	dc.w	(29*16),(41*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	30
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(29*16),(41*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	SWITCH_END


*Event 2 - appear Pig at end of level gate and deactivate Event 1

Gate_Pig_Appear_2
	dc.w	Event_Deactivate
	dc.w	1

 	dc.w	SWITCH_ADD_ALIEN
	dc.w	(24*16),(41*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	30
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
 	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(24*16),(41*16)
	dc.l	Fast_Appear_Pig_Object
	
	dc.w	SWITCH_END

	
*Event 3 - destroy 2 bushes and replace with Pigs

Bush_To_Pig_1
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	39,54
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	39,59
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	39,55
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	39,60
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	39,56
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	39,61
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	
	dc.w	SWITCH_ADD_ALIEN		;Add top Pig
	dc.w	(40*16),(54*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN		;Add bottom Pig
	dc.w	(40*16),(59*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

Level1_Scroll_Goto
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	15*16,7*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END

	
	


