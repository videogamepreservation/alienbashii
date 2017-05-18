****** INTRO 8 SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level8_Switch_Table
	dc.l	Level8_Switch1
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Level8_Switch9
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level8_Activate_Table
	dc.l	Level8_Event1
	dc.l	Level8_Event2
	dc.l	Level8_Event3
	dc.l	Level8_Event4
	dc.l	Level8_Event5
	dc.l	Level8_Event6
	dc.l	Level8_Event7
	dc.l	$ffffffff	;terminate switch list if less than 60



*Switches

Level8_Switch1
	dc.w	SWITCH_SET_STATUE_COUNT
	dc.w	4
	dc.w	SWITCH_SET_STATUE_SCRIPT
	dc.l	Level8_Build_Bridge
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	41,131
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_COLUMN
	dc.w	49,149
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_COLUMN
	dc.w	83,150
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END

Level8_Switch9
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	124,129
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	75,146
	dc.w	POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END
		

*Events

Level8_Event1
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_COLUMN
	dc.w	49,149
	dc.w	POST_UP,POST_UP,$ffff
	dc.w	SWITCH_SET_STATUE_COUNT
	dc.w	4
	dc.w	SWITCH_SET_STATUE_SCRIPT
	dc.l	Level8_Poles_Down1
	dc.w	SWITCH_END

Level8_Poles_Down1
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	41,131
	dc.w	POST_DOWN,POST_DOWN,POST_DOWN,POST_DOWN,$ffff
	dc.w	SWITCH_END
	
Level8_Event2
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	41,131
	dc.w	POST_UP,POST_UP,POST_UP,POST_UP,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Exploding_Pig_Gen
	dc.w	(42*16),(123*16)
	dc.l	Exploding_Pig_Generator_No_Skull_Object
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	42,123+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	42+1,123+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(42*16)+12,((123+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(42*16)+20,((123+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	42,123,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	42+1,123,425
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Exploding_Pig_Gen
	dc.w	(33*16),(121*16)
	dc.l	Exploding_Pig_Generator_No_Skull_Object
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	33,121+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	33+1,121+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(33*16)+12,((121+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(33*16)+20,((121+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	33,121,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	33+1,121,425
	dc.w	SWITCH_END

Level8_Event3
	dc.w	SWITCH_SET_VAR
	dc.l	Stop_Script1
	dc.w	0	
Level8_Event3_Rep
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(41*16)+5,(102*16)
	dc.l	Fast_Ex_Running_Appear_Pig_Object
	
	dc.w	SWITCH_TEST
	dc.l	Stop_Script1
	dc.w	1
	dc.l	End_Level8_Event3
	
	dc.w	Switch_Set_Count
	dc.w	1*25
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(43*16)+5,(102*16)
	dc.l	Fast_Ex_Running_Appear_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	1*25
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_TEST
	dc.l	Stop_Script1
	dc.w	0		;keep going????
	dc.l	Level8_Event3_Rep
	

End_Level8_Event3
	dc.w	SWITCH_END


Level8_Event4
	dc.w	SWITCH_SET_VAR
	dc.l	Stop_Script1
	dc.w	1
	dc.w	SWITCH_SET_VAR
	dc.l	Stop_Script2
	dc.w	0	
Level8_Event4_Rep
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(41*16)+5,91*16
	dc.l	Fast_Ex_Running_Appear_Pig_Object
	
	dc.w	SWITCH_TEST
	dc.l	Stop_Script2
	dc.w	1
	dc.l	End_Level8_Event4
	
	dc.w	Switch_Set_Count
	dc.w	1*25
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(43*16)+5,91*16
	dc.l	Fast_Ex_Running_Appear_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	1*25
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_TEST
	dc.l	Stop_Script2
	dc.w	0
	dc.l	Level8_Event4_Rep	

End_Level8_Event4
	dc.w	SWITCH_END

Level8_Event5
	dc.w	SWITCH_SET_VAR
	dc.l	Stop_Script2
	dc.w	1
	dc.w	SWITCH_END


Level8_Event6
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	124,129
	dc.w	POST_UP,POST_UP,$ffff
	dc.w	SWITCH_END
	
Level8_Build_Bridge
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	122,119
	dc.w	560,561,562,563,$ffff
	dc.w	SWITCH_END
	
Level8_Event7
	dc.w	SWITCH_SCROLL_GOTO		
	dc.w	66*16,0
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END

Stop_Script1
	dc.w	0	
Stop_Script2
	dc.w	0	