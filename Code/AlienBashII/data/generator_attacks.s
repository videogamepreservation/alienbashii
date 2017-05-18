*-------------------------------------------------------*
*-------------  LEVEL1 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*

Level1_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(23*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(12*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(27*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(12*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty
Level1_Generator_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level1_Generator_Repeat

*-------------------------------------------------------*
*-------------  LEVEL2 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level2_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(53*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(11*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(57*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(11*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty

	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level2_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level2_Gen_Repeat
Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level2_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0

Level2_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level2_Generator_Shoot_Pattern
	
*-------------------------------------------------------*
*-------------  LEVEL3 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level3_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(95*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(99*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty

	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level3_Pig_Platforms	;start it running dude
	

	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level3_Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level3_Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level3_Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level3_Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level3_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Level3_Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level3_Gen_Repeat
Level3_Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level3_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0

	
Level3_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0		
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level3_Generator_Shoot_Pattern

*-------------------------------------------------------*
*-------------  LEVEL4 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level4_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(186*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(23*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(190*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(23*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level4_Bomb_Attack
	
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level4_Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level4_Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level4_Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level4_Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level4_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Level4_Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level4_Gen_Repeat
Level4_Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level3_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0



	
Level4_Generator_Shoot_Pattern
		dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level4_Generator_Shoot_Pattern

*-------------------------------------------------------*
*-------------  LEVEL5 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level5_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(155*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(6*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(159*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(6*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty

	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level5_Pig_Platforms
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level5_Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level5_Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level5_Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level5_Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level5_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Level5_Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level5_Gen_Repeat
Level5_Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level5_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0

Level5_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level5_Generator_Shoot_Pattern


*-------------------------------------------------------*
*-------------  LEVEL6 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level6_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(140*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(144*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty

	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level6_Bomb_Attack
	
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level6_Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level6_Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level6_Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level6_Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level6_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0	
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Level6_Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level6_Gen_Repeat
Level6_Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level6_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0

		
Level6_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	0,0
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	0,0
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level6_Generator_Shoot_Pattern
	
*-------------------------------------------------------*
*-------------  LEVEL7 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level7_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(90*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(41*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(94*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(41*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty
	
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level7_Pig_Platforms

	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level7_Chain_Wait1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level7_Chain_Wait1

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Level7_Chain_Wait2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Level7_Chain_Wait2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level7_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Level7_Set_New_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level7_Gen_Repeat
Level7_Set_New_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level7_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0


Level7_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level7_Generator_Shoot_Pattern

*-------------------------------------------------------*
*-------------  LEVEL8 GENERATOR SCRIPTS ---------------*
*-------------------------------------------------------*
Level8_Generator
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_X
	dc.w	(73*16)-4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt1_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_X
	dc.w	(77*16)+4
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Spurt2_Y
	dc.w	(5*16)-42+5
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level8_Pig_Platforms
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Level8_Bomb_Attack
	dc.w	OBJECT_SET_VARIABLE
	dc.l	Gen_var
	dc.w	0			;reset
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Chain_Wait8
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Wait8

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object

	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Chain_Wait8_2
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Wait8_2

	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	CHAIN1_X_START-11,CHAIN1_Y_START-11
	dc.l	Fast_Appear_Chain_Object
Level8_Gen_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	Gen_Var
	dc.w	0
	dc.l	Set_New_Level8_Generator
	dc.w	OBJECT_SET_PAT
	dc.l	Level8_Gen_Repeat
Set_New_Level8_Generator
	dc.w	OBJECT_TRANSFORM_PATTERN
	dc.l	Generator_Active_Alien
	dc.l	Level8_Generator_Shoot_Pattern
	dc.w	OBJECT_KILL,0,0

Level8_Generator_Shoot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet2	
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Gen_Bullet
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_PAT
	dc.l	Level8_Generator_Shoot_Pattern



Gen_Var
	dc.w	0		;general var for gens