Player_Explosion
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Player_Explosion_Pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Wait_For_End_Explo
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Wait
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number



Explo_Up
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Up	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Down
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Down	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Left
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Left	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	
Explo_Right
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Right;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	
Explo_Up_Left
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Up_Left	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	
Explo_Up_Right
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Up_Right	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Down_Right
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Down_Right	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Down_Left
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	9		;number of frames
	dc.w	2		;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Explo_Patt_Down_Left	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	

Explo_Patt_Up
	dc.w	0,-10,0,-10,0,-10,0,-10,0,-10,0,-9
	dc.w	0,-9,0,-9,0,-9,0,-8,0,-8,0,-8
	dc.w	0,-8,0,-7,0,-7,0,-7,0,-6,0,-6
	dc.w	OBJECT_KILL,0,0
	
Explo_Patt_Down
	dc.w	0,10,0,10,0,10,0,10,0,10,0,9
	dc.w	0,9,0,9,0,9,0,8,0,8,0,8
	dc.w	0,8,0,7,0,7,0,7,0,6,0,6
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Left
	dc.w	-10,0,-10,0,-10,0,-10,0,-10,0,-9,0
	dc.w	-9,0,-9,0,-9,0,-8,0,-8,0,-8,0
	dc.w	-8,0,-7,0,-7,0,-7,0,-6,0,-6,0
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Right
	dc.w	10,0,10,0,10,0,10,0,10,0,9,0
	dc.w	9,0,9,0,9,0,8,0,8,0,8,0
	dc.w	8,0,7,0,7,0,7,0,6,0,6,0
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Up_Left
	dc.w	-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-7,-7
	dc.w	-7,-7,-7,-7,-7,-7,-6,-6,-6,-6,-6,-6
	dc.w	-6,-6,-5,-5,-5,-5,-5,-5,-4,-4,-4,-4
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Up_Right
	dc.w	8,-8,8,-8,8,-8,8,-8,8,-7,8,-7
	dc.w	7,-7,7,-7,7,-6,6,-6,6,-6,6,-6
	dc.w	6,-5,5,-5,5,-5,5,-4,4,-4,4,-4
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Down_Right
	dc.w	8,8,8,8,8,8,8,8,8,7,8,7
	dc.w	7,7,7,7,7,6,6,6,6,6,6,6
	dc.w	6,5,5,5,5,5,5,4,4,4,4,4
	dc.w	OBJECT_KILL,0,0

	
Explo_Patt_Down_Left
	dc.w	-8,8,-8,8,-8,8,-8,8,-8,8,-7,7
	dc.w	-7,7,-7,7,-7,7,-6,6,-6,6,-6,6
	dc.w	-6,6,-5,5,-5,5,-5,5,-4,4,-4,4
	dc.w	OBJECT_KILL,0,0




Player_Explosion_Pattern

	dc.w	OBJECT_SOUND_EFFECT_1
	dc.w	Sound_Bang
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Bang
	

	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Up
	dc.l	Explo_Down
	dc.l	Explo_Left
	dc.l	Explo_Right
	dc.l	$ffffffff
	dc.w	0,0,0,0
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Up_Left
	dc.l	Explo_Up_Right
	
	dc.l	Explo_Down_Right
	dc.l	Explo_Down_Left
	dc.l	$ffffffff
	dc.w	0,0,0,0,0,0,0,0,0,0

	
	
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Up
	dc.l	Explo_Down
	dc.l	Explo_Left
	dc.l	Explo_Right
	dc.l	$ffffffff
	dc.w	0,0,0,0
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Up_Left
	dc.l	Explo_Up_Right
	dc.l	Explo_Down_Left
	dc.l	Explo_Down_Right
	dc.l	Wait_For_End_Explo
	dc.l	$ffffffff

	
	dc.w	0,0,0,0,0,0,0,0
	dc.w	OBJECT_KILL,0,0


Explo_Wait
	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Continue_Game_If_Enough_Lives	;(in panel_routines.s)
	dc.w	OBJECT_KILL,0,0


