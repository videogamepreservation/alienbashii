****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level2_switch_table
	dc.l	Open_Post_Path
	dc.l	Level2_Add_Bridge
	dc.l	Level2_Add_Chest
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Push_Down_Poles
	dc.l	Open_Left_Path
	dc.l	Open_Right_Path
	dc.l	Get_Past_Stream
	dc.l	Right_Exit
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level2_Activate_Table
	dc.l	Level2_Gen_Appear1
	dc.l	Level2_Gen_Appear2
	dc.l	Level2_Add_Pig_Wave1
	dc.l	Level2_Gen_Appear3
	dc.l	Level2_Add_Maggots
	dc.l	Level2_Add_Pig
	dc.l	Level2_Post_Bonus
	dc.l	Level2_Event8
	dc.l	Level2_Add_Pig_Wave2
	dc.l	Level2_Event10
	dc.l	Level2_Event11
	dc.l	Level2_Event12
	dc.l	Level2_Event13
	dc.l	Level2_Event14
	dc.l	Level2_Event15
	dc.l	$ffffffff	;terminate switch list if less than 60

Level2_Add_Bridge
	dc.w	SWITCH_ADD_BLOCK
	dc.w	100,90
	dc.w	97
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	105,95
	dc.w	481,501,521,541,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	104,95
	dc.w	566,586,606,626,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	103,95
	dc.w	566,586,606,626,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	102,95
	dc.w	566,586,606,626,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	101,95
	dc.w	480,500,520,540,$ffff
	dc.w	SWITCH_END

Level2_Add_Chest
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	109,95
	dc.w	CHEST_SOLID_BLOCK
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Chest
	dc.w	109*16,95*16
	dc.l	Chest_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(109*16),(95*16)-4
	dc.l	Fast_Appear_Object	
	dc.w	SWITCH_END	

Push_Down_Poles
	dc.w	SWITCH_CHANGE_BLOCK_ROW	;add event block 13
	dc.w	142,68
	dc.w	332,332,332,332,$ffff
	dc.w	EVENT_DEACTIVATE	;stop poles from popping up
	dc.w	12
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	132,87
	dc.w	POST_HOLE,POST_HOLE,$ffff
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	139,87
	dc.w	POST_HOLE,POST_HOLE,POST_HOLE,$ffff
	dc.w	SWITCH_END



Get_Past_Stream
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	48,90
	dc.w	132,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	49,90
	dc.w	870,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	50,90
	dc.w	59,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	67,76		;just add to alien map
	dc.w	Statue_Head
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	57,88
	dc.w	325,325,$ffff
	dc.w	SWITCH_END


	
	
Open_Right_Path
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	73,69
	dc.w	132,1,1,114,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	74,69
	dc.w	876,1,1,920,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	75,69
	dc.w	877,1,1,921,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	76,69
	dc.w	878,1,1,922,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	77,69
	dc.w	59,1,1,113,$ffff
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(80*16),(70*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_END


Reveal_Money
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	52,105
	dc.w	738,873,1,714,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	52,104
	dc.w	718,754,1,694,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	52,103
	dc.w	698,734,1,674,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	52,102
	dc.w	673,1,1,654,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	52,101
	dc.w	653,1,1,711,$ffff
	dc.w	SWITCH_END



Open_Left_Path
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	38,71
	dc.w	851,754,873,1,1,57,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	37,71
	dc.w	698,718,738,1,1,56,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	36,71
	dc.w	697,717,737,1,1,55,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	35,71
	dc.w	708,728,748,1,1,54,$ffff
	dc.w	SWITCH_END

Right_Exit
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	62,88
	dc.w	831,851,873,1,57,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	61,88
	dc.w	698,718,738,1,56,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	60,88
	dc.w	675,695,715,1,55,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_COLUMN
	dc.w	59,88
	dc.w	674,694,714,1,54,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_END


Open_Post_Path
	dc.w	SWITCH_SOUND_CHAN3
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST
	dc.w	89,21
	dc.w	POST_DOWN
	dc.w	SWITCH_END


*activate event lists - these are the same as switch lists

Level2_Gen_Appear1
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	34,73
	dc.w	POST_UP_SHAD
	dc.w	POST_UP
	dc.w	POST_UP
	dc.w	$ffff
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(29*16),(67*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	29,68,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	30,68,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(29*16)+12,(69*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(29*16)+20,(69*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	29,67,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	30,67,425
	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(22*16),(74*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(21*16),(78*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
Level2_Rain_Script	
	dc.l	Rain_Script
	dc.w	SWITCH_END

Level2_Gen_Appear2
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(15*16),(90*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	15,91,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	16,91,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(15*16)+12,(92*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(15*16)+20,(92*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	15,90,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	16,90,425
	dc.w	SWITCH_END

Level2_Add_Pig_Wave1

	dc.w	SWITCH_SET_VAR		;set up wave counter
	dc.l	Level2_Wave_Counter
	dc.w	4
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter
	dc.w	(13*16),(109*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter
	dc.w	(13*16),(113*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter
	dc.w	(9*16),(115*16)
	dc.l	Fast_Appear_Wave_Pig_Object	
	dc.w	SWITCH_WAIT
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter
	dc.w	(5*16),(108*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_END	
	
Level2_Wave_Counter	
	dc.w	4
	dc.l	Level2_Alien_Bonus
	
Level2_Alien_Bonus
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	7,8+4
	dc.l	Bonus_Coins_Object
	dc.w	OBJECT_KILL,0,0	
	
Level2_Gen_Appear3
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(28*16),(110*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	28,111,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	29,111,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(28*16)+12,(112*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(28*16)+20,(112*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	28,110,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	29,110,425
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(40*16),(114*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40,115,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	41,115,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(40*16)+12,(116*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(40*16)+20,(116*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40,114,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	41,114,425
	dc.w	SWITCH_END
	

Level2_Add_Maggots		
	dc.w	SWITCH_SET_VAR
	dc.l	Maggot_Counter
	dc.w	6
	dc.w	SWITCH_SET_ADDRESS
	dc.l	Current_Maggot_Script
	dc.l	Reveal_Money
	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(46*16),(107*16)
	dc.l	Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(45*16),(109*16)
	dc.l	Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(48*16),(111*16)
	dc.l	Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(56*16),(109*16)
	dc.l	Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(57*16),(107*16)
	dc.l	Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(55*16),(105*16)
	dc.l	Maggot_Appear_Object	
	dc.w	SWITCH_END

Level2_Add_Pig
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(56*16),(76*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
			
Level2_Post_Bonus
	dc.w	SWITCH_TEST
	dc.l	Level_Toggle
	dc.w	0
	dc.l	Level2_Post_Bonus_Down
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST
	dc.w	104,53
	dc.w	POST_UP
	dc.w	SWITCH_ADD_POST
	dc.w	107,53
	dc.w	POST_UP
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	105,52
	dc.w	POST_UP,POST_UP,$ffff

	dc.w	SWITCH_CLEAR_VAR
	dc.l	Level_Toggle
	dc.w	SWITCH_END
Level2_Post_Bonus_Down	
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	105,52
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST
	dc.w	104,53
	dc.w	POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	107,53
	dc.w	POST_DOWN
	dc.w	SWITCH_SET_VAR
	dc.l	Level_Toggle
	dc.w	1
	dc.w	EVENT_REACTIVATE
	dc.w	8
	dc.w	SWITCH_END

Level2_Event8
	dc.w	EVENT_REACTIVATE
	dc.w	7
	dc.w	SWITCH_END
	
Level2_Add_Pig_Wave2

	dc.w	SWITCH_SET_VAR		;set up wave
	dc.l	Level2_Wave_Counter2
	dc.w	4

	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter2
	dc.w	(93*16),(37*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	SWITCH_WAIT
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter2
	dc.w	(98*16),(37*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter2
	dc.w	(93*16),(48*16)
	dc.l	Fast_Appear_Wave_Pig_Object	
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter2
	dc.w	(98*16),(48*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_END
	
Level2_Wave_Counter2	
	dc.w	4
	dc.l	Level2_Alien_Bonus
				
Level2_Event10
	dc.w	SWITCH_SET_VAR		;set up wave
	dc.l	Level2_Wave_Counter3
	dc.w	2

	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter3
	dc.w	(121*16),(67*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	dc.w	SWITCH_SET_WAVE
	dc.l	Level2_Wave_Counter3
	dc.w	(125*16),(67*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	dc.w	SWITCH_END
Level2_Wave_Counter3	
	dc.w	2
	dc.l	Level2_Alien_Bonus

Level2_Event11
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(128*16),(73*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	128,74,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	129,74,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(128*16)+12,(75*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(128*16)+20,(75*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	128,73,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	129,73,425
	dc.w	SWITCH_END

Level2_Event12
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	132,87
	dc.w	POST_UP,POST_UP,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	139,87
	dc.w	POST_UP,POST_UP,POST_UP,$ffff
	dc.w	SWITCH_END
	

Level2_Event13
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(135*16),(70*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(139*16),(74*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END


Level2_Event14
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(89*16),(92*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	89,93,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	90,93,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16)+12,(94*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16)+20,(94*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	89,92,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	90,92,425
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(96*16),(92*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	96,93,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	97,93,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(96*16)+12,(94*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(96*16)+20,(94*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	96,92,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	97,92,425
	dc.w	SWITCH_END

Level2_Event15
	dc.w	SWITCH_SET_VAR	;turn off storm
	dc.l	WeatherFx
	dc.w	1
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	46*16,5*16
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	45
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	40
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	35
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	30
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	25
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	20
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	15
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	10
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	5
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	0
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Stop_Looping_Sample
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END
