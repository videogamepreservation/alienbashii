

Generator_Explosion_Object
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	1		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	generator_explosion_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number


Generator_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	1000
	dc.w	OBJECT_SET_VARIABLE
	dc.l	SpurtFlag
	dc.w	0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-5,0
	dc.l	Generator_Explosion_Object
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Generator_Explosion_Pattern

	dc.w	OBJECT_SIMPLE_ADD
	dc.w	4,9
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_1
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	4,3
	dc.l	Block_Chain_Explosion
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,-3
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	4,-5
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-5,-6
	dc.l	Block_Chain_Explosion
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-7,-3
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	3,9
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	8,0
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_SExplo
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-10,14
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_1
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-3,4
	dc.l	Block_Chain_Explosion
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0,0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-6,-2
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,5
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-0
	dc.l	Block_Chain_Explosion
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	5,-8
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-3,12
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	5,4
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_SExplo
	dc.w	OBJECT_SET_COUNTER,10
Wait_For_Explosions_To_Finish
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Wait_For_Explosions_To_Finish	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Blow_Up_Level
	dc.w	OBJECT_KILL	
	dc.w	0,0

