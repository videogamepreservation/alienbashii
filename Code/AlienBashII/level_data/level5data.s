****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level5_switch_table
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Level5_Switch9	
	dc.l	Level5_Switch10	
	dc.l	Level5_Switch11
	dc.l	Level5_Switch12	
	dc.l	Level5_Switch13
	dc.l	Level5_Switch14
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level5_Activate_Table
	dc.l 	Level5_Event1
	dc.l 	Level5_Event2
	dc.l 	Level5_Event3
	dc.l 	Level5_Event4
	dc.l 	Level5_Event5
	dc.l 	Level5_Event6
	dc.l 	Level5_Event7
	dc.l 	Level5_Event8
	dc.l 	Level5_Event9
	dc.l 	Level5_Event10
	dc.l 	Level5_Event11
	dc.l 	Level5_Event12
	dc.l 	Level5_Event13
Level5_Snow_Script	
	dc.l	SnowStorm	
	dc.l	StopStorm
	dc.l	$ffffffff	;terminate switch list if less than 60

Level5_Event1
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	34,181
	dc.w	1,1,1,1,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	34,180
	dc.w	1,1,1,1,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	34,179
	dc.w	1,1,1,1,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	34,178
	dc.w	1,1,1,1,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	34,177
	dc.w	1,1,1,1,1,$ffff
	dc.w	SWITCH_END

Level5_Event2
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(43*16),(127*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_END	

Level5_Event3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(51*16),(123*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_END
	
Level5_Event4
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	43,105
	dc.w	64,84,$ffff
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	44,105
	dc.w	65,85,$ffff
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Statue_Head
	dc.w	(43*16),(104*16)
	dc.l	Statue_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(43*16)-4,(104*16)+6
	dc.l	Fast_Appear_Object
	dc.w	SWITCH_END
	
Level5_Event5
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(59*16),(60*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	59,60+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	59+1,60+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(59*16)+12,((60+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(59*16)+20,((60+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	59,60,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	59+1,60,425
	dc.w	SWITCH_END	

Level5_Event6
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(64*16),(58*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	64,58+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	64+1,58+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(64*16)+12,((58+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(64*16)+20,((58+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	64,58,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	64+1,58,425
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(67*16),(58*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	67,58+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	67+1,58+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(67*16)+12,((58+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(67*16)+20,((58+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	67,58,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	67+1,58,425
	dc.w	SWITCH_END

Level5_Event7
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(79*16),(58*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	79,58+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	79+1,58+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(79*16)+12,((58+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(79*16)+20,((58+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	79,58,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	79+1,58,425
	dc.w	SWITCH_END	

Level5_Event8
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(90*16),(77*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(93*16),(77*16)
	dc.l	Fast_Appear_Pig_Object	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(92*16),(71*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_END


Level5_Event9
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(86*16),(99*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	86,99+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	86+1,99+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(86*16)+12,((99+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(86*16)+20,((99+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	86,99,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	86+1,99,425
	dc.w	SWITCH_END

Level5_Event10
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(99*16),(103*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	99,103+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	99+1,103+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(99*16)+12,((103+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(99*16)+20,((103+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	99,103,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	99+1,103,425
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(106*16),(107*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	106,107+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	106+1,107+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(106*16)+12,((107+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(106*16)+20,((107+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	106,107,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	106+1,107,425
	dc.w	SWITCH_END

Level5_Event11
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	90,59
	dc.w	845,846,1,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	90,58
	dc.w	825,826,820,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	90,57
	dc.w	805,1,800,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	90,56
	dc.w	785,1,780,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW
	dc.w	90,55
	dc.w	765,1,760,$ffff
	dc.w	SWITCH_END

Level5_Event12
	dc.w	SWITCH_ADD_POST_ROW
	dc.w	157,35
	dc.w	POST_UP
	dc.w	POST_UP
	dc.w	$ffff
	dc.w	SWITCH_SOUND_CHAN4
	dc.w	Sound_Slide
	dc.w	SWITCH_END	

		
Level5_Event13
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	147*16,0*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END


Level5_Switch9
	dc.w	SWITCH_ADD_POST
	dc.w	113,96
	dc.w	POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	118,95,403		;switch down
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	121,96,403		;switch down
	dc.w	SWITCH_END

Level5_Switch10
	dc.w	SWITCH_ADD_POST
	dc.w	118,94
	dc.w	POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	115,96,403		;switch down
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	121,96,403		;switch down
	dc.w	SWITCH_END

Level5_Switch11
	dc.w	SWITCH_ADD_POST
	dc.w	123,96
	dc.w	POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	115,96,403		;switch down
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK
	dc.w	118,95,403		;switch down
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Statue_Head
	dc.w	(118*16),(97*16)
	dc.l	Statue_Object
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(118*16)-4,(97*16)+6
	dc.l	Fast_Appear_Object

	dc.w	SWITCH_END

Level5_Switch12
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	156,56
	dc.w	620,621,622,623,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	156,57
	dc.w	580,581,582,583,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	156,58
	dc.w	600,601,602,603,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	156,59
	dc.w	405,406,407,408,$ffff
	dc.w	SWITCH_END

Level5_Switch13
	dc.w	SWITCH_ADD_POST
	dc.w	138,26,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	142,26,POST_DOWN	
	dc.w	SWITCH_ADD_POST
	dc.w	144,26,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	146,26,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST
	dc.w	138,32,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	142,32,POST_DOWN	
	dc.w	SWITCH_ADD_POST
	dc.w	144,32,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	146,32,POST_DOWN
	dc.w	SWITCH_END
	
Level5_Switch14
	dc.w	SWITCH_ADD_POST
	dc.w	169,26,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	171,26,POST_DOWN	
	dc.w	SWITCH_ADD_POST
	dc.w	173,26,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	177,26,POST_DOWN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_POST
	dc.w	169,32,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	171,32,POST_DOWN	
	dc.w	SWITCH_ADD_POST
	dc.w	173,32,POST_DOWN
	dc.w	SWITCH_ADD_POST
	dc.w	177,32,POST_DOWN
	dc.w	SWITCH_END	
	