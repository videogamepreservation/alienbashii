****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level3_switch_table
	dc.l	0
	dc.l	Level3_Switch2
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level3_Activate_Table
	dc.l	Maggot_Watch
	dc.l	Freeze_Level3_Scroll
	dc.l	Level3_Event3
	dc.l	Level3_Event4
	dc.l	Level3_Event5
	dc.l	Level3_Event6
	dc.l	$ffffffff	;terminate switch list if less than 60


*activate event lists - these are the same as switch lists

Maggot_Watch
	dc.w	SWITCH_SET_VAR
	dc.l	Maggot_Counter
	dc.w	6
	dc.w	SWITCH_SET_ADDRESS
	dc.l	Current_Maggot_Script
	dc.l	Maggot_Bridges
	dc.w	SWITCH_END

Freeze_Level3_Scroll
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	87*16,0*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END



Pig_Appear_1
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(65*16),(148*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
pig_appear1
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(21*16),(71*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(22*16),(74*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
pig_appear2
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(53*16),(75*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

pig_appear3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(66*16),(76*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
pig_appear4
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(88*16),(73*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16),(77*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
pig_appear5
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(82*16),(34*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END


****** Switches

Level3_Switch2
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	57,98
	dc.w	565,585,605,625,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	58,98
	dc.w	566,586,606,626,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	59,98
	dc.w	564,584,604,624,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	60,98
	dc.w	565,585,605,625,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	33,73
	dc.w	920,921,922,923,920,921,922,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	34,74
	dc.w	941,942,943,940,941,942,020,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	34,75
	dc.w	868,869,876,877,878,879,876,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	34,76
	dc.w	888,889,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	43,83
	dc.w	620,621,622,623,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	43,84
	dc.w	580,581,582,583,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	43,85
	dc.w	600,601,602,603,$ffff	
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	43,86
	dc.w	405,406,407,408,$ffff	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	54,84
	dc.w	876,877,878,879,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	54,85
	dc.w	1,1,1,1,$ffff	
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	54,86
	dc.w	1,1,1,1,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	54,87
	dc.w	920,921,922,923,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	58,84
	dc.w	876,877,955,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	58,85
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	58,86
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	58,87
	dc.w	950,895,896,$ffff
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	60,88
	dc.w	916		
	dc.w	SWITCH_END	


Maggot_Bridges
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	9,40
	dc.w	405,406,407,408,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	9,39
	dc.w	600,581,582,603,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	9,38
	dc.w	620,621,622,623,$ffff
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	11,33
	dc.w	405,406,407,408,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	11,32
	dc.w	600,581,582,603,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	11,31
	dc.w	620,621,622,623,$ffff
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	62,29
	dc.w	180,181,1,1,1,654,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	62,30
	dc.w	698,754,1,1,1,674,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	62,31
	dc.w	718,754,1,1,1,694,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	62,32
	dc.w	738,873,1,1,1,714,$ffff
	dc.w	SWITCH_END
	
Level3_Event3
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Statue_Head
	dc.w	(89*16),(127*16)
	dc.l	Statue_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16)-4,(127*16)+6
	dc.l	Fast_Appear_Object	
	dc.w	EVENT_DEACTIVATE
	dc.w	4
	dc.w	SWITCH_END	
	
Level3_Event4
	dc.w	EVENT_DEACTIVATE
	dc.w	3
	dc.w	SWITCH_END
		
Level3_Event5
	dc.w	SWITCH_SET_VAR
	dc.l	Level3_Wave_Counter
	dc.w	3
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level3_Wave_Counter
	dc.w	(63*16),(122*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level3_Wave_Counter
	dc.w	(65*16),(119*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level3_Wave_Counter
	dc.w	(68*16),(116*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	SWITCH_END	
	
Level3_Wave_Counter	
	dc.w	3
	dc.l	Level3_Alien_Bonus		

Level3_Alien_Bonus
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level3_Add_Chest
	dc.w	OBJECT_KILL,0,0
	
Level3_Add_Chest	
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	56,121
	dc.w	CHEST_SOLID_BLOCK
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Chest
	dc.w	56*16,121*16
	dc.l	Chest_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(56*16),(121*16)-4
	dc.l	Fast_Appear_Object		
	dc.w	SWITCH_END
	
Level3_Event6	
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	68,105
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	68,106
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	68,107
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	68,108
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;dont kill pigs
	dc.w	68,109
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;dont kill pigs
	dc.w	68,1110
	dc.w	20,20,20,20,$ffff
	dc.w	SWITCH_END


