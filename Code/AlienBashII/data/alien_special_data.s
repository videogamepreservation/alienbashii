**************************************************************
*** FILE CONTAINING SPECIAL CASE ALIENS                    ***
**************************************************************

Fast_Appear_Wave_Pig_Object
	dc.w	24<<6+3
	dc.w	BPR-6
	dc.w	10
	dc.w	1		;update anim frame every 2 frames
	dc.l	Appear_Graphics
	dc.l	Appear_Graphics+(24*4)*10*NUM_PLANES
	dc.w	32		;xsize
	dc.w	24		;ysize
	dc.w	(24*4)*10		;plane size	- so can get to next alien
	dc.w	(24*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Fast_Appear_Wave_Pig_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Fast_Appear_Wave_Pig_Pattern
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD_WAVE_TRANSFER
	dc.w	-5,-6
	dc.l	Appear_Wave_Pig_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Appear_Wave_Pig_Alien
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	3		;
	dc.l	piggraphicsd
	dc.l	piggraphicsd+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	Pig_Wave_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Pig_Wave_Appear_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD_WAVE_TRANSFER
	dc.w	0,0
	dc.l	Generic_Wave_Pig_Alien	
	dc.w	OBJECT_KILL,0,0



Generic_Wave_Pig_Alien
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	3		;
	dc.l	Alien1_Graphics_Table
	dc.l	Alien1_Mask_Table
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	Added_Alien_Chase_Pattern
	dc.l	Wave_Alien_Death
	dc.l	Normal_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object

Wave_Alien_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	20
	dc.w	OBJECT_SOUND_EFFECT_1		;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_WAVE_TEST
	dc.w	OBJECT_KILL,0,0	


Counter_Maggot_Alien
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4		;
	dc.w	4		;
	dc.l	Maggot_Graphics_Table
	dc.l	Maggot_Mask_Table
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Non_Explode_Maggot_Pattern
	dc.l	Counter_Maggot_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET
	dc.b	Maggot

Counter_Maggot_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-1,-1
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Splat
	dc.w	OBJECT_DECREASE
	dc.l	Maggot_Counter
	dc.w	OBJECT_TEST
	dc.l	Maggot_Counter
	dc.w	0
	dc.l	Activate_Maggot_Event
	dc.w	OBJECT_KILL
	dc.w	0,0	
Activate_Maggot_Event
	dc.w	OBJECT_START_SCRIPT
	dc.l	Current_Maggot_Script
	dc.w	OBJECT_KILL,0,0

Non_Explode_Maggot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_A_Maggot_Direction
Non_Explode_Maggot_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Non_Explode_Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_EXECUTE_CODE		
	dc.l	Non_Explode_Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_SET_PAT
	dc.l	Non_Explode_Maggot_Repeat
	
	
Maggot_Appear_Object
	dc.w	24<<6+3
	dc.w	BPR-6
	dc.w	10
	dc.w	1		;update anim frame every 2 frames
	dc.l	Appear_Graphics
	dc.l	Appear_Graphics+(24*4)*10*NUM_PLANES
	dc.w	32		;xsize
	dc.w	24		;ysize
	dc.w	(24*4)*10		;plane size	- so can get to next alien
	dc.w	(24*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Fast_Appear_Maggot_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Normal_Maggot_Appear_Object
	dc.w	24<<6+3
	dc.w	BPR-6
	dc.w	10
	dc.w	1		;update anim frame every 2 frames
	dc.l	Appear_Graphics
	dc.l	Appear_Graphics+(24*4)*10*NUM_PLANES
	dc.w	32		;xsize
	dc.w	24		;ysize
	dc.w	(24*4)*10		;plane size	- so can get to next alien
	dc.w	(24*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Normal_Fast_Appear_Maggot_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Normal_Fast_Appear_Maggot_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	8,8
	dc.l	Maggot_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Fast_Appear_Maggot_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	8,8
	dc.l	Counter_Maggot_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0
	
	



Fast_Appear_Wave_Pig_Object_Timed
	dc.w	24<<6+3
	dc.w	BPR-6
	dc.w	10
	dc.w	1		;update anim frame every 2 frames
	dc.l	Appear_Graphics
	dc.l	Appear_Graphics+(24*4)*10*NUM_PLANES
	dc.w	32		;xsize
	dc.w	24		;ysize
	dc.w	(24*4)*10		;plane size	- so can get to next alien
	dc.w	(24*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Fast_Appear_Wave_Pig_Pattern_Timed
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Fast_Appear_Wave_Pig_Pattern_Timed
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Appear
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD_WAVE_TRANSFER
	dc.w	-5,-6
	dc.l	Appear_Wave_Pig_Alien_Timed
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Appear_Wave_Pig_Alien_Timed
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	3		;
	dc.l	piggraphicsd
	dc.l	piggraphicsd+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	Pig_Wave_Appear_Pattern_Timed
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Pig_Wave_Appear_Pattern_Timed
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD_WAVE_TRANSFER
	dc.w	0,0
	dc.l	Generic_Wave_Pig_Alien_Timed
	dc.w	OBJECT_KILL,0,0

Generic_Wave_Pig_Alien_Timed
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	3		;
	dc.l	Alien1_Graphics_Table
	dc.l	Alien1_Mask_Table
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	Normal_Alien_Chase_Pattern_Timed
	dc.l	Wave_Alien_Death
	dc.l	Normal_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object

Normal_Alien_Chase_Pattern_Timed
	dc.w	0,32-PIG_ALIEN_HEIGHT
	dc.w	OBJECT_SET_COUNTER
	dc.w	25*120
Normal_Repeat_Timed	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE	;repeat twice - er too cut down execution time
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Normal_Repeat_Timed
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_KILL,0,0	


Statue_Head_Counter_Object
	dc.w	17<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE	;update anim frame every 2 frames
	dc.l	Statue_Head_Graphics
	dc.l	Statue_Head_Graphics+(17*2*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	17		;ysize
	dc.w	(17*2*2)		;plane size	- so can get to next alien
	dc.w	(17*2)		;frame size
	dc.w	2		;alien x words
	dc.l	statue_pattern
	dc.l	Counter_Gun_Turret_Death
	dc.l	0
	dc.w	3
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Counter_Gun_Turret_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	50
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	-8,0
	dc.l	Explo_Split_Object_1
	dc.l	Explo_Split_Object_2
	dc.l	Explo_Split_Object_3
	dc.l	Explo_Split_Object_4
	dc.l	$ffffffff
	dc.w	OBJECT_DECREASE
	dc.l	Statue_Counter
	dc.w	OBJECT_TEST
	dc.l	Statue_Counter
	dc.w	0
	dc.l	Activate_Statue_Event
	dc.w	OBJECT_KILL
	dc.w	0,0	
Activate_Statue_Event
	dc.w	OBJECT_START_SCRIPT
	dc.l	Statue_Script_Ptr
	dc.w	OBJECT_KILL,0,0

Pig_Generator_No_Skull_Counter_Object
	dc.w	34<<6+3
	dc.w	BPR-6
	dc.w	0
	dc.w	DONT_ANIMATE	;update anim frame every 2 frames
	dc.l	Pig_Generator_Graphics
	dc.l	Pig_Generator_Graphics+(34*4)*NUM_PLANES
	dc.w	34		;xsize
	dc.w	34		;ysize
	dc.w	(34*4)		;plane size	- so can get to next alien
	dc.w	(34*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Give_Birth_To_No_Skull_Pigs
	dc.l	Explode_Counter_Generator
	dc.l	0
	dc.w	15
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_GeneratorNoSkull

Explode_Counter_Generator
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Split_Object_5
	dc.l	Explo_Split_Object_3
	dc.l	Explo_Split_Object_4
	dc.l	$ffffffff
	dc.w	OBJECT_DECREASE
	dc.l	Statue_Counter
	dc.w	OBJECT_TEST
	dc.l	Statue_Counter
	dc.w	0
	dc.l	Activate_Gen_Event
	dc.w	OBJECT_KILL
	dc.w	0,0	
Activate_Gen_Event
	dc.w	OBJECT_START_SCRIPT
	dc.l	Statue_Script_Ptr
	dc.w	OBJECT_KILL,0,0

	
	
*special variable values

Maggot_Counter	dc.w	0
Pig_Counter	dc.w	0

Current_Maggot_Script	dc.l	0	;must be setup 
Current_Pig_Script	dc.l	0	

Statue_Counter	dc.w	0
Statue_Script_Ptr	dc.l	0

