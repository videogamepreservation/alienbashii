****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level4_switch_table
	dc.l	Level4_Switch1
	dc.l	Level4_Switch2
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Level4_Switch9
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level4_Activate_Table
	dc.l	Level4_Event1
	dc.l	Level4_Event2
	dc.l	Level4_Event3
	dc.l	Level4_Event4
	dc.l	Level4_Event5
	dc.l	Level4_Event6
	dc.l	0
	dc.l	Level4_Event8
	dc.l	Level4_Event9
	dc.l	$ffffffff	;terminate switch list if less than 60


*activate event lists - these are the same as switch lists

Level4_Event1
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(45*16),(44*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45,44+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45+1,44+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(45*16)+12,((44+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(45*16)+20,((44+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45,44,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45+1,44,425
	dc.w	SWITCH_END

Level4_Event2
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(36*16),(31*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	36,31+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	36+1,31+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(36*16)+12,((31+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(36*16)+20,((31+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	36,31,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	36+1,31,425
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(40*16),(31*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40,31+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40+1,31+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(40*16)+12,((31+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(40*16)+20,((31+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40,31,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	40+1,31,425
	dc.w	SWITCH_END

CIRCLE_DELAY	EQU	25

Level4_Event3
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	53*16,21*16
	
	dc.w	Switch_Set_Count
	dc.w	25*3
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	
	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(62*16),(25*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	
	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(58*16),(27*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(58*16),(32*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(62*16),(34*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(66*16),(34*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(69*16),(32*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(69*16),(27*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(66*16),(25*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(62*16),(25*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	
	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(58*16),(27*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(58*16),(32*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(62*16),(34*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(66*16),(34*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(69*16),(32*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(69*16),(27*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	CIRCLE_DELAY
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN		
	dc.w	(66*16),(25*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_POST
	dc.w	59,24
	dc.w	POST_DOWN_SHAD
	dc.w	SWITCH_ADD_POST
	dc.w	58,25
	dc.w	POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	57,26
	dc.w	POST_DOWN

	dc.w	SWITCH_RELEASE_SCROLL

	
	dc.w	SWITCH_END

Level4_Event4
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(120*16),(89*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(125*16),(89*16)
	dc.l	Fast_Appear_Pig_Object

	dc.w	SWITCH_END
	
Level4_Event5
	dc.w	SWITCH_SET_VAR
	dc.l	Level4_Wave_Counter3
	dc.w	3

	dc.w	SWITCH_SET_WAVE
	dc.l	Level4_Wave_Counter3
	dc.w	(125*16),(106*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	dc.w	SWITCH_SET_WAVE
	dc.l	Level4_Wave_Counter3
	dc.w	(134*16),(113*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	dc.w	SWITCH_SET_WAVE
	dc.l	Level4_Wave_Counter3
	dc.w	(143*16),(110*16)
	dc.l	Fast_Appear_Wave_Pig_Object
	dc.w	SWITCH_END

Level4_Wave_Counter3
	dc.w	3
	dc.l	Level4_Posts_Down

Level4_Posts_Down
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level4_PopDown
	dc.w	OBJECT_KILL,0,0

Level4_PopDown
	dc.w	SWITCH_ADD_POST
	dc.w	135,104
	dc.w	POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	136,105
	dc.w	POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	135,106
	dc.w	POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	134,105
	dc.w	POST_DOWN
	dc.w	SWITCH_END

Level4_Event6
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(145*16),(42*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	145,42+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	145+1,42+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(145*16)+12,((42+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(145*16)+20,((42+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	145,42,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	145+1,42,425
	dc.w	SWITCH_END	

Level4_Event8
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(166*16),(39*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	166,39+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	166+1,39+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(166*16)+12,((39+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(166*16)+20,((39+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	166,39,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	166+1,39,425
	dc.w	SWITCH_END	

Level4_Event9
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	178*16,18*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END

*-----------------------------Switches---------------*

Level4_Switch1
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	118,49
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END

Level4_Switch2
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	153,69,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	154,68,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	163,68,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	164,69,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	164,78,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	163,79,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	154,79,POST_DOWN
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	153,78,POST_DOWN
	dc.w	SWITCH_END


Level4_Switch9
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	154,39,POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	172,42,327
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	171,43,327
	dc.w	SWITCH_CHANGE_BLOCK
	dc.w	173,41,327
	dc.w	SWITCH_END
	