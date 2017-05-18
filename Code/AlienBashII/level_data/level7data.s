****** INTRO 7 SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level7_Switch_Table
	dc.l	Level7_Switch1
	dc.l	Level7_Switch2
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Level7_Switch9
	dc.l	Level7_Switch10
	dc.l	Level7_Switch11
	dc.l	Level7_Switch12
	dc.l	Level7_Switch13
	dc.l	Level7_Switch14
	dc.l	Level7_Switch15
	dc.l	Level7_Switch16
	dc.l	Level7_Switch17
	dc.l	Level7_Switch18
	dc.l	Level7_Switch19
	dc.l	Level7_Switch20
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level7_Activate_Table
	dc.l	ThunderStorm
	dc.l	Stop_Level7_Storm
	dc.l	Level7_Event3
	dc.l	Level7_Event4
	dc.l	Level7_Event5
	dc.l	Level7_Event6
	dc.l	Level7_Event7
	dc.l	Level7_Event8
	dc.l	Level7_Event9
	dc.l	Level7_Event10
	dc.l	Level7_Event11
	dc.l	Level7_Event12
	dc.l	Level7_Event13
	dc.l	Level7_Event14
	dc.l	Level7_Event15
	dc.l	Level7_Event16
	dc.l	Level7_Event17
	dc.l	$ffffffff	;terminate switch list if less than 60



*Switches

Level7_Switch1
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	61,61
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_ADD_ALIEN
	dc.w	68,77
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	69,77
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	70,78
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	70,79
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	70,80
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	69,81
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	68,81
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	67,81
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	67,80
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	66,79
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	66,78
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	67,77
	dc.l	Pot_Gold_Coin_Object
	dc.w	SWITCH_END



Level7_Switch2
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	152,53
	dc.w	939,1,92,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	152,52
	dc.w	936,1,854,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	152,51
	dc.w	691,1,94,$ffff
	dc.w	SWITCH_END



Level7_Switch9
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	190,142
	dc.w	842,845,846,816,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	190,141
	dc.w	822,825,826,796,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	190,140
	dc.w	802,805,1,776,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	190,139
	dc.w	782,785,1,816,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	190,138
	dc.w	762,765,1,796,$ffff
	dc.w	SWITCH_END

Level7_Switch10
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	75,127
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	74,128
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	75,131
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	78,128
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END

Level7_Switch11
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	72,72,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	73,73,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	72,74,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	71,73,POST_DOWN
	dc.w	SWITCH_END 

Level7_Switch12
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	54,78,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	55,79,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	54,80,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	53,79,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	52,76,14
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	55,80,14
	dc.w	SWITCH_END 

Level7_Switch13
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	61,64,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	62,65,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	61,66,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	60,65,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	63,64,14
	dc.w	SWITCH_END 

Level7_Switch14
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	61,84,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	62,85,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	60,85,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	63,84,14
	dc.w	SWITCH_END 

Level7_Switch15
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide

	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	69,67,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	70,68,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	69,69,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	68,68,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	67,64,14
	dc.w	SWITCH_ADD_ALIEN_NUM
	dc.w	71,64,14
	dc.w	SWITCH_END 

Level7_Switch16
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	68,78,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	69,79,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	68,80,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	67,79,POST_DOWN
	dc.w	SWITCH_END

Level7_Switch17
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK_COLUMN
	dc.w	78,70
	dc.w	POST_DOWN_SHAD,POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END

Level7_Switch18
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	132,78
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_COLUMN
	dc.w	104,70,POST_DOWN_SHAD,POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END

Level7_Switch19
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,61
	dc.w	863,754,1,1,674,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,60
	dc.w	843,754,1,1,654,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,59
	dc.w	823,754,1,1,804,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,58
	dc.w	803,754,1,1,784,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,57
	dc.w	783,754,1,1,764,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	87,56
	dc.w	763,734,1,1,711,$ffff
	dc.w	SWITCH_END


Level7_Switch20
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16),(64*16)
	dc.l	Fast_Appear_Pig_Object	

	dc.w	Switch_Set_Count
	dc.w	3*25
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_ALIEN
	dc.w	(89*16),(64*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_END

*Events
Stop_Level7_Storm
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	1
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	92,80
	dc.w	POST_UP,POST_UP,$ffff
	dc.w	SWITCH_WAIT
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
	dc.w	SWITCH_END

Level7_Event3
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(92*16),(117*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level7_Event4
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(120*16),(141*16)
	dc.l	Normal_Maggot_Appear_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(122*16),(143*16)
	dc.l	Normal_Maggot_Appear_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(124*16),(145*16)
	dc.l	Normal_Maggot_Appear_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(113*16),(147*16)
	dc.l	Normal_Maggot_Appear_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(117*16),(148*16)
	dc.l	Normal_Maggot_Appear_Object
	dc.w	SWITCH_END
	
Level7_Event5
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(190*16),(121*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(184*16),(124*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level7_Event6
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(174*16),(128*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(184*16),(124*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_END


Level7_Event7
	dc.w	SWITCH_SET_VAR
	dc.l	Level7_Wave_Counter
	dc.w	3

	dc.w	SWITCH_SET_WAVE
	dc.l	Level7_Wave_Counter
	dc.w	(156*16),(23*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	10
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level7_Wave_Counter
	dc.w	(159*16),(23*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT
	
	dc.w	Switch_Set_Count
	dc.w	10
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_SET_WAVE
	dc.l	Level7_Wave_Counter
	dc.w	(159*16),(19*16)
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_END	
	
Level7_Wave_Counter	
	dc.w	3
	dc.l	Level2_Alien_Bonus

Level7_Event8
	dc.w	SWITCH_SET_STATUE_COUNT
	dc.w	2
	dc.w	SWITCH_SET_STATUE_SCRIPT
	dc.l	Level7_Pole_Down1
	dc.w	SWITCH_END
	
Level7_Pole_Down1
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	129,14
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END
	
	
Level7_Event9	
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(95*16),(1*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	95,1+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	95+1,1+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(95*16)+12,((1+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(95*16)+20,((1+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	95,1,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	95+1,1,425
	dc.w	SWITCH_END

Level7_Event10
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(77*16),(15*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	77,15+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	77+1,15+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(77*16)+12,((15+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(77*16)+20,((15+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	77,15,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	77+1,15,425
	dc.w	SWITCH_END

Level7_Event11
	dc.w	SWITCH_SET_STATUE_COUNT
	dc.w	2
	dc.w	SWITCH_SET_STATUE_SCRIPT
	dc.l	Level7_Pole_Down2
	dc.w	SWITCH_END

Level7_Pole_Down2
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	66,16
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END
	
Level7_Event12	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(43*16),(34*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_END
	
Level7_Event13
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(33*16),(41*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(33*16),(52*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level7_Event14
	dc.w	SWITCH_ADD_POST
	dc.w	10,106,POST_UP
	dc.w	SWITCH_ADD_POST
	dc.w	9,107,POST_UP		
	dc.w	SWITCH_SET_STATUE_COUNT
	dc.w	1
	dc.w	SWITCH_SET_STATUE_SCRIPT
	dc.l	Level7_Pole_Down3
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(11*16),(106*16)
	dc.l	Statue_Head_Counter_Object
	dc.w	SWITCH_END
	
Level7_Pole_Down3
	dc.w	SWITCH_ADD_POST
	dc.w	10,106,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	9,107,POST_DOWN
	dc.w	SWITCH_END
	
Level7_Event15
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	78,70,POST_UP_SHAD,POST_UP,POST_UP,POST_UP,POST_UP,POST_UP,$ffff
	dc.w	SWITCH_END
				
Level7_Event16
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	104,70,POST_UP_SHAD,POST_UP,POST_UP,POST_UP,POST_UP,POST_UP,$ffff
	dc.w	SWITCH_END

Level7_Event17
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	83*16,36*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END

