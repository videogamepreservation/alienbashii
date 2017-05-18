
*********   PUT ALL DATA FOR GAME ALIENS IN HERE    *******



PIG_ALIEN_HEIGHT	EQU	35
PIG_ALIEN_WIDTH		EQU	32

Shoot_Wait_Pattern
	dc.w	0,0,0,0,0,0,0,0,0,0
	dc.w	OBJECT_SET_PAT
	dc.l	Normal_Repeat

Pig_Alien
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
	dc.l	Normal_Alien_Chase_Pattern
	dc.l	Alien_Death
	dc.l	Normal_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


New_Pig_Alien			;added via appear object
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
	dc.l	Alien_Death
	dc.l	Normal_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


Pig_NO_Shoot_Alien
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
	dc.l	No_Shoot_Alien_Chase_Pattern
	dc.l	Alien_Death
	dc.l	No_shoot_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


Fast_Pig_Alien
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	2		;
	dc.l	Alien1_Graphics_Table
	dc.l	Alien1_Mask_Table
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	No_Shoot_Fast_Alien_Chase_Pattern
	dc.l	Alien_Death
	dc.l	no_shoot_fast_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object

Fast_Pig_Alien_Added
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	6		;
	dc.w	2		;
	dc.l	Alien1_Graphics_Table
	dc.l	Alien1_Mask_Table
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4*6		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	No_Shoot_Fast_Alien_Running_Chase_Pattern
	dc.l	Alien_Death
	dc.l	no_shoot_fast_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


Pig_Alien_Convert		;for gaurds
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
	dc.l	Basic_Alien_Chase_Pattern
	dc.l	Alien_Death
	dc.l	Normal_pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


Added_Pig_Alien
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
	dc.l	Basic_Alien_Chase_Pattern
	dc.l	Added_Alien_Death
	dc.l	pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Added_Pig

Ex_Added_Pig_No_Skull_Alien
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
	dc.l	Ex_Basic_Alien_Chase_Pattern
	dc.l	Added_Alien_No_Skull_Death
	dc.l	pig_stop_pattern
	dc.w	4
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Added_Pig

Ex_Pig_No_Skull_Alien
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
	dc.l	Ex_Normal_Alien_Chase_Pattern
	dc.l	Alien_No_Skull_Death
	dc.l	pig_stop_pattern
	dc.w	4
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object

Ex_Pig_No_Skull_Fast_Alien
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
	dc.l	Ex_Fast_Alien_Chase_Pattern
	dc.l	Alien_No_Skull_Death
	dc.l	pig_stop_pattern
	dc.w	4
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object


Added_Pig_No_Skull_Alien
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
	dc.l	Basic_Alien_Chase_Pattern
	dc.l	Added_Alien_No_Skull_Death
	dc.l	pig_stop_pattern
	dc.w	2
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+HIT_PATTERN_SET+ALIEN_PRI_SET
	dc.b	Added_Pig

Normal_Alien_Chase_Pattern
	dc.w	0,32-PIG_ALIEN_HEIGHT
Normal_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE	;repeat twice - er too cut down execution time
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	Normal_Repeat


Added_Alien_Chase_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE	;repeat twice - er too cut down execution time
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART


No_Shoot_Alien_Chase_Pattern
	dc.w	0,32-PIG_ALIEN_HEIGHT
No_Shoot_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	No_Shoot_Repeat

No_Shoot_Fast_Alien_Chase_Pattern
	dc.w	0,32-PIG_ALIEN_HEIGHT
No_Shoot_fast_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	No_Shoot_Fast_Repeat

No_Shoot_Fast_Alien_Running_Chase_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

	
Basic_Alien_Chase_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

Ex_Basic_Alien_Chase_Pattern
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	2*25,3*25
Ex_Basic_Alien_Chase_Pattern_Rep
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Ex_Basic_Alien_Chase_Pattern_Rep
	dc.w	OBJECT_DECREASE
	dc.l	pigs_on_screen
	dc.w	OBJECT_SOUND_EFFECT_1	
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-8
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0

Ex_Normal_Alien_Chase_Pattern
	dc.w	0,32-PIG_ALIEN_HEIGHT
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	2*25,3*25
Ex_Normal_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE	;repeat twice - er too cut down execution time
	dc.l	Basic_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Ex_Normal_Repeat
	dc.w	OBJECT_SOUND_EFFECT_1	
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-8
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Ex_Fast_Alien_Chase_Pattern
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	1*25,2*25
Ex_Fast_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE	;repeat twice - er too cut down execution time
	dc.l	No_Shoot_Fast_Alien_Chase
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Ex_Fast_Repeat
	dc.w	OBJECT_SOUND_EFFECT_1	
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-8
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL
	dc.w	0,0

	

Alien_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	20
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	11-3,(12-6)-14
	dc.l	Skully
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_KILL,0,0	

Added_Alien_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	20
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	11-3,(12-6)-14
	dc.l	Skully
	dc.w	OBJECT_SOUND_EFFECT_1	;***
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_DECREASE
	dc.l	pigs_on_screen
	dc.w	OBJECT_KILL,0,0	

Added_Alien_No_Skull_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10
	dc.w	OBJECT_SOUND_EFFECT_1  ;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,12
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_DECREASE
	dc.l	pigs_on_screen
	dc.w	OBJECT_KILL,0,0	

Alien_No_Skull_death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10
	dc.w	OBJECT_SOUND_EFFECT_1  ;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,12
	dc.l	Pig_Explosion
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_KILL,0,0	


normal_pig_stop_pattern	;important all pigs use this
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	NORMAL_REPEAT

no_Shoot_pig_stop_pattern	;important all pigs use this
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	No_Shoot_REPEAT

no_Shoot_fast_pig_stop_pattern	;important all pigs use this
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	No_Shoot_fast_REPEAT



pig_stop_pattern	;important all pigs use this
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART


Pig_Guard_Object
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Pig_Guard_Graphics
	dc.l	Pig_Guard_Graphics+(PIG_ALIEN_HEIGHT*4)*NUM_PLANES
	dc.w	PIG_ALIEN_WIDTH		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	PIG_ALIEN_HEIGHT*4		;plane size
	dc.w	PIG_ALIEN_HEIGHT*4		;frame size
	dc.w	3		;alien x words
	dc.l	Pig_Guard_Pattern
	dc.l	Alien_Death
	dc.l	0
	dc.w	10
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET
	dc.b	Pig_Alien_Object

Pig_Guard_Pattern
	dc.w	OBJECT_CHECK_HITS
	dc.w	10
	dc.l	Transform_PigGuard
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	96
	dc.l	Transform_PigGuard
	dc.w	OBJECT_PATTERN_RESTART
Transform_PigGuard
	dc.w	OBJECT_RANDOM_PIG_SQUEAL
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	0,0
	dc.l	Pig_Alien_Convert	
	dc.w	OBJECT_KILL
	dc.w	0,0	

Pig_Explosion	
	dc.w	25<<6+3
	dc.w	BPR-6
	dc.w	13      	;number of frames
	dc.w	1		;frame rate
	dc.l	pig_explosion_graphics
	dc.l	pig_explosion_Graphics+(25*4*13)*NUM_PLANES
	dc.w	32		;xsize
	dc.w	25		;ysize
	dc.w	(25*4)*13	;plane size
	dc.w	(25*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	new_explo_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

smokey
	dc.w	20<<6+2
	dc.w	BPR-4
	dc.w	12		
	dc.w	2		;update anim frame every 2 frames
	dc.l	smokey_graphics
	dc.l	smokey_graphics+((20*2)*12)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	20		;ysize
	dc.w	(20*2)*12	;plane size	- so can get to next alien
	dc.w	(20*2)		;frame size
	dc.w	2		;alien x words
	dc.l	smokey_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

skully
	dc.w	14<<6+2
	dc.w	BPR-4
	dc.w	1		
	dc.w	-1		;update anim frame every 2 frames
	dc.l	skully_graphics
	dc.l	skully_graphics+(14*2)*NUM_PLANES
	dc.w	12		;xsize
	dc.w	14		;ysize
	dc.w	(14*2)		;plane size	- so can get to next alien
	dc.w	(14*2)		;frame size
	dc.w	2		;alien x words
	dc.l	skull_pattern
	dc.l	skull_go
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	skully_collect


skull_go
	dc.w	OBJECT_KILL
	dc.w	0,0

skull_pattern

*first bounce for 18 frames

	dc.w	0,1,0,2
	dc.w	0,3,0,4
	dc.w	0,3,0,3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Check_Skull_Not_In_Water
	dc.w	0,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling

	dc.w	0,-3,0,-2
	dc.w	0,-2,0,-1
	dc.w	0,-1,0,0
	
	
	
	dc.w	0,0,0,0
	dc.w	0,1,0,1
	dc.w	0,1,0,2
	dc.w	0,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	0,0
	
	

	dc.w	0,-1,0,-1
	dc.w	0,-1
	dc.w	0,0
	

	
	dc.w	0,1,0,0
	dc.w	0,1,0,1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv3

	dc.w	0,-1,0,0

	dc.w	0,0,0,0
	dc.w	0,1
		
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv4
	dc.w	0,0
	dc.w	0,0,0,0

	dc.w	OBJECT_SET_COUNTER
	dc.w	125
tosh_wait	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	tosh_wait		
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,-8
	dc.l	smokey
	dc.w	0,0	;wait for bit
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
skull_kill	
	dc.w	OBJECT_KILL
	dc.w	0,0

new_explo_pattern
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
	dc.w	OBJECT_KILL
	dc.w	0,0

smokey_pattern
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
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL
	dc.w	0,0


PigMissile_Object
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	5		
	dc.w	1		;update anim frame every 2 frames
	dc.l	PigMissile_Graphics
	dc.l	PigMissile_Graphics+(15*2)*5*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	(15*2)*5		;plane size	- so can get to next alien
	dc.w	(15*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Alien_Bullet_pattern
	dc.l	Pig_Missile_Death_Pattern
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	PigMissile

Pig_Missile_Death_Pattern

	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_PlingV2
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	4,4
	dc.l	small_bullet_explosion
	dc.w	OBJECT_KILL
	dc.w	0,0
		
Spikey_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Spikey_Graphics
	dc.l	SPikey_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)		;plane size	- so can get to next alien
	dc.w	(16*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Spikey_Pat
	dc.l	Spikey_Pat_Die
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Spikey_Pat
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART
	dc.w	0,0
	
Spikey_Pat_Die
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	50
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Spikey_Death_Routine
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-2
	dc.l	Pig_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL
	dc.w	0,0	
	
Spinny_Object
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;so will never animate
	dc.l	Alien_Bullet_Graphics
	dc.l	Alien_Bullet_Graphics+(5*2)*NUM_PLANES
	dc.w	5		;xsize
	dc.w	5		;ysize
	dc.w	5*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spinny_Bullet_Pattern
	dc.l	Dead_Alien_Bullet
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Alien_Bullet


Spinny_Bullet_Pattern
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Spinny_Repeat	
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Alien_Update_Bullet	
	dc.w	OBJECT_UNTIL
	dc.l	Spinny_Repeat
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	small_bullet_explosion
	dc.w	OBJECT_KILL
	dc.w	0,0

Fish_Bob_Left_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	2		;update anim frame every 2 frames
	dc.l	Fish_Bounce_Left
	dc.l	Fish_Bounce_Left+(16*2)*4*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)*4		;plane size	- so can get to next alien
	dc.w	(16*2)		;frame size
	dc.w	2		;alien x words
	dc.l	fish_bounce_left_pat
	dc.l	Fish_Death
	dc.l	0
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


Fish_Dive_Right
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Fish_Right
	dc.l	Fish_Right+(16*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)*3		;plane size	- so can get to next alien
	dc.w	(16*2)		;frame size
	dc.w	2		;alien x words
	dc.l	fish_dive_right_pat
	dc.l	Fish_Death
	dc.l	0
	dc.w	3
	dc.b	OFF_SCREEN_SET
	dc.b	Fish_Dr
	
Fish_Dive_Left
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Fish_Left
	dc.l	Fish_Left+(16*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)*3		;plane size	- so can get to next alien
	dc.w	(16*2)		;frame size
	dc.w	2		;alien x words
	dc.l	fish_dive_left_pat
	dc.l	Fish_Death
	dc.l	0
	dc.w	3
	dc.b	OFF_SCREEN_SET
	dc.b	Fish_Dl
	

	
	
fish_dive_left_pat
	dc.w	-4,-10
	dc.w	-4,-7
	dc.w	-4,-5
	dc.w	-4,-4
	dc.w	-4,-3
	dc.w	-4,-2
	
	dc.w	OBJECT_FRAME_SET
	dc.w	1	
	
	dc.w	-4,-1
	dc.w	-4,0
	dc.w	-4,0
	dc.w	-4,0
	dc.w	-4,0

	dc.w	-4,0
	dc.w	-4,1
	
	dc.w	OBJECT_FRAME_SET
	dc.w	2
	
	dc.w	-4,2
	dc.w	-4,3
	dc.w	-4,4
	dc.w	-4,5
	dc.w	-4,7
	dc.w	-4,10
	
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	-4,10-5
	dc.l	Splash_Object_L
	
	dc.w	OBJECT_KILL
	dc.w	0,0
	
fish_dive_right_pat
	dc.w	4,-10
	dc.w	4,-7
	dc.w	4,-5
	dc.w	4,-4
	dc.w	4,-3
	dc.w	4,-2
	
	dc.w	OBJECT_FRAME_SET
	dc.w	1	
	
	dc.w	4,-1
	dc.w	4,0
	dc.w	4,0
	dc.w	4,0
	dc.w	4,0

	dc.w	4,0
	dc.w	4,1
	
	dc.w	OBJECT_FRAME_SET
	dc.w	2
	
	dc.w	4,2
	dc.w	4,3
	dc.w	4,4
	dc.w	4,5
	dc.w	4,7
	dc.w	4,10
	
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	-4,10-5
	dc.l	Splash_Object_R
	
	dc.w	OBJECT_KILL
	dc.w	0,0
	
	

Fish_Bob_Right_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	2		;update anim frame every 2 frames
	dc.l	Fish_Bounce_Right
	dc.l	Fish_Bounce_Right+(16*2)*4*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)*4		;plane size	- so can get to next alien
	dc.w	(16*2)		;frame size
	dc.w	2		;alien x words
	dc.l	fish_bounce_right_pat
	dc.l	Fish_Death
	dc.l	0
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	

	
fish_bounce_left_pat	

	dc.w	OBJECT_SET_COUNTER
	dc.w	4*2*4
fblr
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	fblr
	
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	0,-8
	dc.l	Fish_Dive_Left
	
	dc.w	OBJECT_KILL	
	dc.w	0,0
	
	
fish_bounce_right_pat	

	dc.w	OBJECT_SET_COUNTER
	dc.w	4*2*4
fbrr
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	fbrr
	
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	0,-8
	dc.l	Fish_Dive_Right
	
	dc.w	OBJECT_KILL	
	dc.w	0,0
	
	
Statue_Object
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
	dc.l	Gun_Turret_Death
	dc.l	0
	dc.w	3
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

	
	
statue_pattern
	dc.w	-1,7
statue_repeat
	dc.w	0,1
	dc.w	0,2
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,1
	
	dc.w	OBJECT_FRAME_SET		
	dc.w	1
	
	dc.w	0,0
	dc.w	0,-1
	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Statue_Bullet
	
	dc.w	0,-2
	dc.w	0,-1
	
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,0

	
	dc.w	OBJECT_SET_PAT
	dc.l	statue_repeat
	
statue_die
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,9
	dc.l	Pig_Explosion
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL
	dc.w	0,0	
	
	
Splash_Object_L
	dc.w	23<<6+3
	dc.w	BPR-6
	dc.w	12
	dc.w	1	;update anim frame every 2 frames
	dc.l	Splash_Anim
	dc.l	Splash_Anim+(23*4)*12*NUM_PLANES
	dc.w	21		;xsize
	dc.w	23		;ysize
	dc.w	(23*4)*12	;plane size	- so can get to next alien
	dc.w	(23*4)		;frame size
	dc.w	3		;alien x words
	dc.l	splash_pattern_l
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
splash_pattern_l
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Splash
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
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	4,3
	dc.l	Fish_Bob_Right_Object

	dc.w	OBJECT_KILL
	dc.w	0,0


	
Splash_Object_R
	dc.w	23<<6+3
	dc.w	BPR-6
	dc.w	12
	dc.w	1	;update anim frame every 2 frames
	dc.l	Splash_Anim
	dc.l	Splash_Anim+(23*4)*12*NUM_PLANES
	dc.w	23		;xsize
	dc.w	23		;ysize
	dc.w	(23*4)*12	;plane size	- so can get to next alien
	dc.w	(23*4)		;frame size
	dc.w	3		;alien x words
	dc.l	splash_pattern_r
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
splash_pattern_r
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Splash

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
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	4,3
	dc.l	Fish_Bob_Left_Object

	dc.w	OBJECT_KILL
	dc.w	0,0

WaspNest_Object
	dc.w	23<<6+3
	dc.w	BPR-6
	dc.w	0
	dc.w	DONT_ANIMATE	;update anim frame every 2 frames
	dc.l	waspnest_graphics
	dc.l	waspnest_graphics+(23*4)*NUM_PLANES
	dc.w	32		;xsize
	dc.w	23		;ysize
	dc.w	(23*4)		;plane size	- so can get to next alien
	dc.w	(23*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Give_Birth_To_Wasp
	dc.l	WaspNestDeath    ;Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+ATTACH_SET
	dc.b	0

FallingWaspNest
	dc.w	23<<6+3
	dc.w	BPR-6
	dc.w	0
	dc.w	DONT_ANIMATE	;update anim frame every 2 frames
	dc.l	waspnest_graphics
	dc.l	waspnest_graphics+(23*4)*NUM_PLANES
	dc.w	32		;xsize
	dc.w	23		;ysize
	dc.w	(23*4)		;plane size	- so can get to next alien
	dc.w	(23*4)		;frame size
	dc.w	3		;alien x words
	dc.l	FallingWaspNestPat
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET+ATTACH_SET
	dc.b	0

FallingWaspNestPat
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

WaspNestDeath
	dc.w	OBJECT_CHANGE_TYPE
	dc.l	FallingWaspNest		;stop from getting hit again
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,2
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	0,4
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Split_Object_5
	dc.l	Explo_Split_Object_3
	dc.l	Explo_Split_Object_4
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0	



Give_Birth_To_Wasp
	dc.w	0,6
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	8,18+23
	dc.l	Key_Shadow
Wasp_Birth_Repeat
	dc.w	OBJECT_TEST
	dc.l	wasps_on_screen
	dc.w	MAX_WASPS_ON_SCREEN
	dc.l	Wasp_Wait_2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Check_To_Add_Wasp
	dc.w	0,0
Wasp_Wait_2
	dc.w	OBJECT_SET_COUNTER
	dc.w	30
Wasp_Gen_Rep2	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Wasp_Gen_Rep2
	
	dc.w	OBJECT_TEST
	dc.l	wasps_on_screen
	dc.w	MAX_WASPS_ON_SCREEN
	dc.l	Wasp_Wait_3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Check_To_Add_Wasp
	dc.w	0,0
Wasp_Wait_3
	dc.w	OBJECT_SET_COUNTER
	dc.w	30
Wasp_Gen_Rep3	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Wasp_Gen_Rep3

	dc.w	OBJECT_TEST
	dc.l	wasps_on_screen
	dc.w	MAX_WASPS_ON_SCREEN
	dc.l	Wasp_Wait_4
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Check_To_Add_Wasp
	dc.w	0,0
Wasp_Wait_4
	dc.w	OBJECT_SET_COUNTER
	dc.w	30
Wasp_Gen_Rep4
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Wasp_Gen_Rep4	
	
	dc.w	OBJECT_SET_COUNTER
	dc.w	50
Wasp_Gen_Rep	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Wasp_Gen_rep

	
	
	dc.w	OBJECT_SET_PAT
	dc.l	Wasp_Birth_Repeat	


dont_move
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE		
	
Wasp_Alien
	dc.w	14<<6+2
	dc.w	BPR-4
	dc.w	2		;
	dc.w	1		;
	dc.l	Wasp_Graphics_Table
	dc.l	Wasp_Mask_Table
	dc.w	16		;xsize
	dc.w	14		;ysize
	dc.w	14*2*2		;plane size
	dc.w	14*2		;frame size
	dc.w	2		;alien x words
	dc.l	Wasp_Buzz_Pattern
	dc.l	Wasp_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET+ATTACH_SET
	dc.b	Waspy
	
	
Wasp_Buzz_Pattern

	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,20
	dc.l	Wasp_Shadow_Alien
Restart_Wasp
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Wasp_Direction
	dc.w	OBJECT_SET_COUNTER
	dc.w	2
Wasp_Repeat	
	dc.w	0,-1
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE		;nasty
	dc.l	Find_Wasp_Direction
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,1
	dc.w	OBJECT_UNTIL
	dc.l	Wasp_Repeat
	
	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Wasp_Direction_Mabey
	dc.w	0,0
	
	dc.w	OBJECT_SET_COUNTER
	dc.w	WASP_MOVE_TIME

Wasp_Go
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Wasp_Follow
	dc.w	0,0
	dc.w	OBJECT_UNTIL		;set in routine
	dc.l	Wasp_Go
	
	dc.w	OBJECT_SET_PAT
	dc.l	Restart_Wasp
	
	
Wasp_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-1,-1
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Splat
	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_DECREASE
	dc.l	wasps_on_screen
	dc.w	OBJECT_KILL
	dc.w	0,0	
	
Fish_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-1,-1
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Splat
	dc.w	OBJECT_KILL
	dc.w	0,0	

	
wasp_speed_pattern
	dc.w	10,12,11,10,7,5,2
	
WASP_MOVE_TIME	EQU	(*-wasp_speed_pattern)/2

random_wasp_speed_pattern
	dc.w	10,12,10,10,8,4,2
	
Wasp_Shadow_Alien
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	small_shad
	dc.l	small_shad+(5*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Wasp_Shad_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET	;lives off - screen - only death of wasp can kill it
	dc.b	0
	
	
Wasp_Shad_Pattern

	dc.w	OBJECT_SET_COUNTER
	dc.w	2*8
wasp_swait	
	dc.w	OBJECT_ATTACH_X
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	wasp_swait
	
	dc.w	0,0
	dc.w	OBJECT_SET_COUNTER
	dc.w	WASP_MOVE_TIME
Wasp_sGo
	dc.w	OBJECT_ATTACH_BOTH_XY
	dc.w	0,20
	dc.w	OBJECT_UNTIL		;set in routine
	dc.l	Wasp_sGo

	dc.w	OBJECT_PATTERN_RESTART
	dc.w	0,0
	
	
Fish_Shadow_Alien
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	small_shad
	dc.l	small_shad+(5*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Fish_Shad_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

	
FishUpBob_Alien
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	4		;
	dc.w	3		;
	dc.l	fish_up_bob
	dc.l	fish_up_bob+(7*2)*4*NUM_PLANES
	dc.w	16		;xsize
	dc.w	7		;ysize
	dc.w	7*2*4		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Fish_Wait_Pattern
	dc.l	Fish_Death
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET
	dc.b	0
	
	
FishUp_Alien
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	2		;
	dc.w	DONT_ANIMATE		;
	dc.l	fish_up
	dc.l	fish_up+(16*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Fish_Jump_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0
	
Fish_Shad_Pattern
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
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
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-2
	
	dc.w	OBJECT_KILL
	dc.w	0,0	
	
Fish_Jump_Pattern
	dc.w	0,-6
	dc.w	0,-6
	dc.w	0,-6
	dc.w	0,-6
	dc.w	0,-6
	dc.w	0,-5
	dc.w	0,-5
	dc.w	0,-5
	dc.w	0,-4
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Fish_Bullet
	dc.w	0,0	
	
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	0,1
	dc.w	0,1
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	0,4
	dc.w	0,5
	dc.w	0,5
	dc.w	0,5
	dc.w	0,6
	dc.w	0,6
	dc.w	0,6
	dc.w	0,6
	dc.w	0,6	
	
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	-3,-5
	dc.l	Splash_Object_Fu
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Splash_Object_Fu
	dc.w	23<<6+3
	dc.w	BPR-6
	dc.w	12
	dc.w	1	;update anim frame every 2 frames
	dc.l	Splash_Anim
	dc.l	Splash_Anim+(23*4)*12*NUM_PLANES
	dc.w	21		;xsize
	dc.w	23		;ysize
	dc.w	(23*4)*12	;plane size	- so can get to next alien
	dc.w	(23*4)		;frame size
	dc.w	3		;alien x words
	dc.l	splash_pattern_up
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
 	dc.b	0
	
splash_pattern_up
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Splash

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
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	3,13
	dc.l	FishUpBob_Alien

	dc.w	OBJECT_KILL
	dc.w	0,0

		
Fish_Wait_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Get_Fish_Wait_Time
Fish_Up_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Fish_Up_Wait
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Fish_Shadow_Alien
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	0,-8
	dc.l	FishUp_Alien
	dc.w	OBJECT_KILL
	dc.w	0,0
	
	
Fish_Wait_Times
	dc.w	50,60,30,35,70,40,10,90,63,35
	dc.w	85,20,46,0
	
Fish_Wait_Point	dc.l	Fish_Wait_Times	
	
Fish_Bullet_Object
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	4		;
	dc.w	0		;
	dc.l	fish_bullet
	dc.l	fish_bullet+(7*2)*4*NUM_PLANES
	dc.w	6		;xsize
	dc.w	7		;ysize
	dc.w	7*4*2		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Fish_Bullet_Pattern
	dc.l	Dead_Alien_Bullet
	dc.l	0
	dc.w	6
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	FishBullet

Fish_Bullet_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Bullet_Position
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART	
	

Generator_Bullet_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	0		;
	dc.w	DONT_ANIMATE	;
	dc.l	generator_bullet
	dc.l	generator_bullet+(8*2)*NUM_PLANES
	dc.w	8		;xsize
	dc.w	8		;ysize
	dc.w	8*2		;plane size
	dc.w	8*2		;frame size
	dc.w	2		;alien x words
	dc.l	Generator_Bullet_Pattern
	dc.l	Dead_Alien_Bullet
	dc.l	0
	dc.w	6
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	FishBullet

Generator_Bullet_Pattern
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Gen_Bullet_Position
	dc.w	OBJECT_PATTERN_RESTART	


	
Alien_Bullet_Object
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;so will never animate
	dc.l	Alien_Bullet_Graphics
	dc.l	Alien_Bullet_Graphics+(5*2)*NUM_PLANES
	dc.w	5		;xsize
	dc.w	5		;ysize
	dc.w	5*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Fish_Bullet_Pattern
	dc.l	Dead_Alien_Bullet
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Alien_Bullet

Dead_Alien_Bullet
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	small_bullet_explosion
	dc.w	OBJECT_KILL,0,0
	
	
Pig_Generator_Object
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
	dc.l	Give_Birth_To_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_Generator
	
Pig_Generator_Object2
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
	dc.l	Give_Birth_To_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_Generator2

Pig_Generator_Object3
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
	dc.l	Give_Birth_To_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w    5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_Generator3

Pig_Generator_Object4
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
	dc.l	Give_Birth_To_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_Generator4
	
	
Pig_Generator_Object5
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
	dc.l	Give_Birth_To_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_Generator5

Pig_Generator_No_Skull_Object
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
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_GeneratorNoSkull


	
Bush_Generator
	dc.w	37<<6+3
	dc.w	BPR-6
	dc.w	0
	dc.w	DONT_ANIMATE	;update anim frame every 2 frames
	dc.l	Bush_Generator_Graphics
	dc.l	Bush_Generator_Graphics+(37*4)*NUM_PLANES
	dc.w	32		;xsize
	dc.w	37		;ysize
	dc.w	(37*4)		;plane size	- so can get to next alien
	dc.w	(37*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Bush_Give_Birth_To_No_Skull_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_GeneratorNoSkull

Bush_Give_Birth_To_No_Skull_Pigs
	dc.w	OBJECT_SET_COUNTER
	dc.w	10
Bush_Initial_No_Skull_Wait
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Bush_Initial_No_Skull_Wait
	
	dc.w	OBJECT_TEST
	dc.l	pigs_on_screen
	dc.w	MAX_PIGS_ON_SCREEN
	dc.l	Bush_No_Skull_Wait_A_Bit
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Out_Cave_No_Skull_Object
	dc.w	OBJECT_INCREASE
	dc.l	pigs_on_screen
	dc.w	0,0
	
Bush_No_Skull_Wait_A_bit	
	dc.w	OBJECT_SET_COUNTER
	dc.w	40
Bush_No_Skull_Pig_Gen_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Bush_No_Skull_Pig_Gen_rep
	dc.w	OBJECT_PATTERN_RESTART


Exploding_Pig_Generator_No_Skull_Object
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
	dc.l	Give_Birth_To_Exploding_No_Skull_Pigs
	dc.l	Explode_Generator
	dc.l	0
	dc.w	10
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Pig_GeneratorNoSkull

Give_Birth_To_Exploding_No_Skull_Pigs
	dc.w	0,2
Ex_Birth_No_skull		
	dc.w	OBJECT_SET_COUNTER
	dc.w	10
Ex_Initial_No_Skull_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Ex_Initial_No_Skull_Wait
	
	dc.w	OBJECT_TEST
	dc.l	pigs_on_screen
	dc.w	MAX_PIGS_ON_SCREEN
	dc.l	Ex_No_Skull_Wait_A_Bit
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Ex_Pig_Out_Cave_No_Skull_Object
	dc.w	OBJECT_INCREASE
	dc.l	pigs_on_screen
	dc.w	0,0
	
Ex_No_Skull_Wait_A_bit	
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Ex_No_Skull_Pig_Gen_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Ex_No_Skull_Pig_Gen_rep
	dc.w	OBJECT_RESTART_PATTERN_SKIP_POS

	
	
	
Explode_Generator
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Explo_Split_Object_5
	dc.l	Explo_Split_Object_3
	dc.l	Explo_Split_Object_4
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0	



Give_Birth_To_No_Skull_Pigs
	dc.w	0,2
Birth_No_skull		
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Initial_No_Skull_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Initial_No_Skull_Wait
	
	dc.w	OBJECT_TEST
	dc.l	pigs_on_screen
	dc.w	MAX_PIGS_ON_SCREEN
	dc.l	No_Skull_Wait_A_Bit
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,4
	dc.l	Pig_Out_Cave_No_Skull_Object
	dc.w	OBJECT_INCREASE
	dc.l	pigs_on_screen
	dc.w	0,0
	
No_Skull_Wait_A_bit	
	dc.w	OBJECT_SET_COUNTER
	dc.w	40
No_Skull_Pig_Gen_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	No_Skull_Pig_Gen_rep
	dc.w	OBJECT_RESTART_PATTERN_SKIP_POS

		
	
Give_Birth_To_Pigs	
	dc.w	0,2
Birth_Pigs_rep
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Initial_Pig_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Initial_Pig_Wait

	dc.w	OBJECT_TEST
	dc.l	pigs_on_screen
	dc.w	MAX_PIGS_ON_SCREEN
	dc.l	Wait_A_Bit
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Chuck_Out_Pig
	dc.w	0,0
Wait_A_bit	
	dc.w	OBJECT_SET_COUNTER
	dc.w	40
Pig_Gen_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Pig_Gen_rep
	dc.w	OBJECT_RESTART_PATTERN_SKIP_POS	
	
Pig_Out_Cave_Object
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	4
	dc.w	3		;update anim frame every 2 frames
	dc.l	pig_out_cave_graphics
	dc.l	pig_out_cave_graphics+(PIG_ALIEN_HEIGHT*4)*4*NUM_PLANES
	dc.w	32		;xsize
	dc.w	PIG_ALIEN_HEIGHT	;ysize
	dc.w	(PIG_ALIEN_HEIGHT*4)*4		;plane size	- so can get to next alien
	dc.w	(PIG_ALIEN_HEIGHT*4)		;frame size
	dc.w	3		;alien x words
	dc.l	move_pig_down_pattern
	dc.l	Added_Alien_Death
	dc.l	0
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+ALIEN_PRI_SET
	dc.b	Pig_Out_Cave
	
	
Pig_Out_Cave_No_Skull_Object
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	4
	dc.w	3		;update anim frame every 2 frames
	dc.l	pig_out_cave_graphics
	dc.l	pig_out_cave_graphics+(PIG_ALIEN_HEIGHT*4)*4*NUM_PLANES
	dc.w	32		;xsize
	dc.w	PIG_ALIEN_HEIGHT		;ysize
	dc.w	(PIG_ALIEN_HEIGHT*4)*4		;plane size	- so can get to next alien
	dc.w	(PIG_ALIEN_HEIGHT*4)		;frame size
	dc.w	3		;alien x words
	dc.l	move_pig_down_no_skull_pattern
	dc.l	Added_Alien_No_Skull_Death
	dc.l	0
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+ALIEN_PRI_SET
	dc.b	Pig_Out_Cave

Ex_Pig_Out_Cave_No_Skull_Object
	dc.w	PIG_ALIEN_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	4
	dc.w	3		;update anim frame every 2 frames
	dc.l	pig_out_cave_graphics
	dc.l	pig_out_cave_graphics+(PIG_ALIEN_HEIGHT*4)*4*NUM_PLANES
	dc.w	32		;xsize
	dc.w	PIG_ALIEN_HEIGHT		;ysize
	dc.w	(PIG_ALIEN_HEIGHT*4)*4		;plane size	- so can get to next alien
	dc.w	(PIG_ALIEN_HEIGHT*4)		;frame size
	dc.w	3		;alien x words
	dc.l	ex_move_pig_down_no_skull_pattern
	dc.l	Added_Alien_No_Skull_Death
	dc.l	0
	dc.w	4
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+ALIEN_PRI_SET
	dc.b	Pig_Out_Cave
	
	
move_pig_down_pattern	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2

	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Added_Pig_Alien
	dc.w	OBJECT_KILL
	dc.w	0,0


move_pig_down_no_skull_pattern	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2

	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
		
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Added_Pig_No_Skull_Alien
	dc.w	OBJECT_KILL
	dc.w	0,0

ex_move_pig_down_no_skull_pattern	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2

	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
		
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Ex_Added_Pig_No_Skull_Alien
	dc.w	OBJECT_KILL
	dc.w	0,0


Maggot_Alien
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
	dc.l	Maggot_Pattern
	dc.l	Fish_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET
	dc.b	Maggot

Maggot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Blow_Up_Time
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_A_Maggot_Direction
Maggot_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_EXECUTE_CODE		
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_SET_PAT
	dc.l	Maggot_Repeat
	
Maggot_Alien2
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4		;
	dc.w	3		;
	dc.l	Maggot_Graphics_Table
	dc.l	Maggot_Mask_Table
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Maggot_Pattern2
	dc.l	Fish_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET
	dc.b	Maggot2

Maggot_Pattern2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Blow_Up_Time
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_A_Maggot_Direction
Maggot_Repeat2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	OBJECT_EXECUTE_CODE		
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	OBJECT_SET_PAT
	dc.l	Maggot_Repeat2

Maggot_Alien3
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4		;
	dc.w	1		;
	dc.l	Maggot_Graphics_Table
	dc.l	Maggot_Mask_Table
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Maggot_Pattern3
	dc.l	Fish_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET
	dc.b	Maggot3

Maggot_Pattern3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Blow_Up_Time
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_A_Maggot_Direction
Maggot_Repeat3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Maggot_Position
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Maggot_Position

	dc.w	0,0
		
	dc.w	OBJECT_SET_PAT
	dc.l	Maggot_Repeat3


Explode_Maggot_Pattern
	dc.w	OBJECT_STOP_ANIM
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SET_COUNTER
	dc.w	30
wiggle_wait	
	dc.w	-2,0
	dc.w	2,0
	dc.w	OBJECT_UNTIL
	dc.l	wiggle_wait	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Spikey_Death_Routine
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-8,-2
	dc.l	Pig_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL
	dc.w	0,0	
		
Generator_Alien
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	3
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Generator_Graphics
	dc.l	Generator_Graphics+(18*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	(18*2)*3		;plane size	- so can get to next alien
	dc.w	(18*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Generator_Monitor_Pattern
	dc.l	Generator_Death
	dc.l	0
	dc.w	40
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Chain_Generator_Object
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	3
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Generator_Graphics
	dc.l	Generator_Graphics+(18*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	(18*2)*3		;plane size	- so can get to next alien
	dc.w	(18*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Chain_Generator_Monitor_Pattern
	dc.l	Generator_Death
	dc.l	0
	dc.w	40
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0
	
	

Generator_Active_Alien
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Generator_Graphics+(18*2*2)
	dc.l	Generator_Graphics+(18*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	(18*2)*3	;plane size	- so can get to next alien
	dc.w	(18*2)		;frame size
	dc.w	2		;alien x words
Generator_Level_Pattern	
	dc.l	0
	dc.l	Generator_Death
	dc.l	0
Generator_Hits		
	dc.w	40
	dc.b	PLAYER_NO_COLLISION_SET	
	dc.b	0

Chain_Generator_Active_Alien
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Generator_Graphics+(18*2*2)
	dc.l	Generator_Graphics+(18*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	(18*2)*3	;plane size	- so can get to next alien
	dc.w	(18*2)		;frame size
	dc.w	2		;alien x words
Chain_Generator_Level_Pattern	
	dc.l	0
	dc.l	Generator_Death
	dc.l	0
	dc.w	40
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0
	
Generator_Monitor_Pattern
	dc.w	1,2
Generator_Repeat
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	generator_activate
	dc.w	0
	dc.l	Generator_Repeat
	
	dc.w	OBJECT_SET_COUNTER
	dc.w	12
Generator_Wait
	dc.w	0,0
	dc.w	0,0	
	dc.w	OBJECT_UNTIL
	dc.l	Generator_Wait
	dc.w	OBJECT_SET_COUNTER
	dc.w	5
Orb_Flash	
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Orb_Flash
	dc.w	0,0
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	OBJECT_FRAME_SET
	dc.w	2
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,0	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_VARIABLE
	dc.l	SpurtFlag
	dc.w	0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Generator_Active_Alien
	dc.w	OBJECT_KILL,0,0		;never reach here	

Chain_Generator_Monitor_Pattern
	dc.w	1,2
Chain_Generator_Repeat
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TEST
	dc.l	generator_activate
	dc.w	0
	dc.l	Chain_Generator_Repeat
	
	dc.w	OBJECT_SET_COUNTER
	dc.w	12
Chain_Generator_Wait
	dc.w	0,0
	dc.w	0,0	
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Generator_Wait
	dc.w	OBJECT_SET_COUNTER
	dc.w	5
Chain_Orb_Flash	
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Chain_Orb_Flash
	dc.w	0,0
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	OBJECT_FRAME_SET
	dc.w	2
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,0	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Gas_Spurt_Speed
	dc.w	OBJECT_SET_VARIABLE
	dc.l	SpurtFlag
	dc.w	0
	dc.w	OBJECT_ACTIVATE_SCRIPT
	dc.l	Spurty
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Chain_Generator_Active_Alien
	dc.w	OBJECT_KILL,0,0		;never reach here	

Fast_Appear_Pig_Object
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
	dc.l	Fast_Appear_Pig_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Fast_Appear_Pig_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-5,-6
	dc.l	Appear_Pig_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Appear_Pig_Alien
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
	dc.l	Pig_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Pig_Appear_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	New_Pig_Alien	;*****
	dc.w	OBJECT_KILL,0,0

Fast_Running_Appear_Pig_Object
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
	dc.l	Fast_Running_Appear_Pig_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Fast_Running_Appear_Pig_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-5,-6
	dc.l	Appear_Running_Pig_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Appear_Running_Pig_Alien
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
	dc.l	Pig_Running_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Pig_Running_Appear_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Fast_Pig_Alien_Added	;*****
	dc.w	OBJECT_KILL,0,0


Fast_Ex_Running_Appear_Pig_Object
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
	dc.l	Fast_Ex_Running_Appear_Pig_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Fast_Ex_Running_Appear_Pig_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-5,-6
	dc.l	Appear_Ex_Running_Pig_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Appear_Ex_Running_Pig_Alien
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
	dc.l	Pig_Ex_Running_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Pig_Ex_Running_Appear_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Ex_Pig_No_Skull_Fast_Alien	;*****
	dc.w	OBJECT_KILL,0,0



Maggot_Generator_Alien
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Maggot_Generator_Graphics
	dc.l	Maggot_Generator_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Maggot_Generator_Pattern
	dc.l	Maggot_Generator_Death
	dc.l	0
	dc.w	5
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Maggot_Generator_Pattern
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Initial_Maggot_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Initial_Maggot_Wait

	dc.w	OBJECT_TEST
	dc.l	maggots_on_screen
	dc.w	MAX_MAGGOTS_ON_SCREEN
	dc.l	Wait_A_Maggot_Bit
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Chuck_Out_Maggot
	dc.w	0,0
Wait_A_Maggot_bit	
	dc.w	OBJECT_SET_COUNTER
	dc.w	60
Maggot_Gen_Rep	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Maggot_Gen_rep
	dc.w	OBJECT_PATTERN_RESTART	

	
Maggot_Generator_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	30
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Small_Explo_Split1
	dc.l	Small_Explo_Split2
	dc.l	Small_Explo_Split3
	dc.l	$ffffffff	
	dc.w	OBJECT_KILL,0,0	
	
Added_Maggot_Alien
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
	dc.l	Added_Maggot_Pattern
	dc.l    Added_Maggot_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+DIRECTION_ALIEN_SET+ALIEN_PRI_SET
	dc.b	Added_Maggot
	
Added_Maggot_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_EXECUTE_CODE		
	dc.l	Update_Maggot_Position
	dc.w	0,0
	
	dc.w	0,0
	
	dc.w	OBJECT_PATTERN_RESTART
	
Added_Maggot_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	10	
	dc.w	OBJECT_DECREASE
	dc.l	maggots_on_screen
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-1,-1
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Splat
	dc.w	OBJECT_KILL
	dc.w	0,0	


INITIAL_WAIT_TIME	EQU 	5

Spore_Bomber_Right_Object
	dc.w	41<<6+3
	dc.w	BPR-6
	dc.w	2		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Bomber_Graphics
	dc.l	Spore_Bomber_Graphics+(41*4)*2*NUM_PLANES
	dc.w	32		;xsize
	dc.w	41	;ysize
	dc.w	41*4*2		;plane size
	dc.w	41*4		;frame size
	dc.w	3		;alien x words
	dc.l	Spore_Bomber_Right_Pattern
	dc.l	Spore_Bomber_Death
	dc.l	0
	dc.w	4
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ATTACH_SET
	dc.b	Spore_Bomber_Right

Spore_Bomber_Right_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,4
	dc.l	Spore_Wait_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	INITIAL_WAIT_TIME
Spore_Bomber_Right_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spore_Bomber_Right_Wait	
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	7,-8
	dc.l	Spore_Bomb_Right_Object
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	OBJECT_SET_PAT
	dc.l	Spore_Reset_Time
	
Spore_Reset_Time	
	dc.w	OBJECT_SET_COUNTER
	dc.w	50
Spore_Reset_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spore_Reset_Wait
	dc.w	OBJECT_PATTERN_RESTART
	
Spore_Bomber_Death
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	75
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,5	
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	5,7
	dc.l	Dome_Explosion_Object
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	24,20
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_SExplo

	dc.w	OBJECT_KILL
	dc.w	0,0

Spore_Wait_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Graphics
	dc.l	Spore_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Wait_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0

Spore_Wait_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

		
Spore_Bomb_Right_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Graphics
	dc.l	Spore_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Bomb_Right_Pattern
	dc.l	Spore_Death
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0

SX_INC	EQU	5

Spore_Bomb_Right_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,58
	dc.l	Spore_RL_Shadow
	dc.w	SX_INC,-10
	dc.w	SX_INC,-9
	dc.w	SX_INC,-7
	dc.w	SX_INC,-5
	dc.w	SX_INC,-3
	dc.w	SX_INC,-2
	dc.w	SX_INC,-1
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Whistle
	
	dc.w	SX_INC,0
	dc.w	SX_INC,0

	
	dc.w	SX_INC,1
	dc.w	SX_INC,2
	dc.w	SX_INC,3
	dc.w	SX_INC,5
	dc.w	SX_INC,7
	dc.w	SX_INC,9
	dc.w	SX_INC,10
	dc.w	SX_INC,10
	dc.w	SX_INC,11
	dc.w	SX_INC-1,11
	dc.w	SX_INC-1,12
	dc.w	SX_INC-2,12

	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-11,-0
	dc.l	Pig_Explosion
	
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0
	
Spore_Death
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0
	
Spore_RL_Shadow
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	small_shad
	dc.l	small_shad+(5*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Shad_RL_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET	;lives off - screen - only death of wasp can kill it
	dc.b	0
	
Spore_Shad_RL_Pattern
	dc.w	OBJECT_ATTACH_X
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART
	
	
Spore_Up_Shadow
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	small_shad
	dc.l	small_shad+(5*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Shad_Up_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET	;lives off - screen - only death of wasp can kill it
	dc.b	0
	
Spore_Shad_Up_Pattern
	dc.w	0,-SX_INC	
	dc.w	OBJECT_PATTERN_RESTART


Spore_Down_Shadow
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	small_shad
	dc.l	small_shad+(5*2)*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*2		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Shad_Down_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET	;lives off - screen - only death of wasp can kill it
	dc.b	0
	
Spore_Shad_Down_Pattern
	dc.w	0,DOWN_INC	
	dc.w	OBJECT_PATTERN_RESTART
	
	
*-----------------------	
	
Spore_Bomber_Left_Object
	dc.w	41<<6+3
	dc.w	BPR-6
	dc.w	2		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Bomber_Graphics
	dc.l	Spore_Bomber_Graphics+(41*4)*2*NUM_PLANES
	dc.w	32		;xsize
	dc.w	41	;ysize
	dc.w	41*4*2		;plane size
	dc.w	41*4		;frame size
	dc.w	3		;alien x words
	dc.l	Spore_Bomber_Left_Pattern
	dc.l	Spore_Bomber_Death
	dc.l	0
	dc.w	4
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ATTACH_SET
	dc.b	Spore_Bomber_Right

Spore_Bomber_Left_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,4
	dc.l	Spore_Wait_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	INITIAL_WAIT_TIME
Spore_Bomber_Left_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spore_Bomber_Left_Wait	
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	7,-8
	dc.l	Spore_Bomb_Left_Object
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	OBJECT_SET_PAT
	dc.l	Spore_Reset_Time
			
Spore_Bomb_Left_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Graphics
	dc.l	Spore_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Bomb_Left_Pattern
	dc.l	Spore_Death
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0


Spore_Bomb_Left_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,58
	dc.l	Spore_RL_Shadow
	
	dc.w	-SX_INC,-10
	dc.w	-SX_INC,-9
	dc.w	-SX_INC,-7
	dc.w	-SX_INC,-5
	dc.w	-SX_INC,-3
	dc.w	-SX_INC,-2
	dc.w	-SX_INC,-1
	
	dc.w	-SX_INC,0
	dc.w	-SX_INC,0
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Whistle

	
	dc.w	-SX_INC,1
	dc.w	-SX_INC,2
	dc.w	-SX_INC,3
	dc.w	-SX_INC,5
	dc.w	-SX_INC,7
	dc.w	-SX_INC,9
	dc.w	-SX_INC,10
	dc.w	-SX_INC,10
	dc.w	-SX_INC,11
	dc.w	-SX_INC-1,11
	dc.w	-SX_INC-1,12
	dc.w	-SX_INC-2,12

	

	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-11,0
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0



Spore_Fragment_Object1
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	8		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Fragment_Graphics
	dc.l	Spore_Fragment_Graphics+(18*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*8		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Fragment_Pattern1
	dc.l	Spore_Fragment_Death
	dc.l	0
	dc.w	4
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Spore_Fragment

Spore_Fragment_Object2
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	8		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Fragment_Graphics
	dc.l	Spore_Fragment_Graphics+(18*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*8		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Fragment_Pattern2
	dc.l	Spore_Fragment_Death
	dc.l	0
	dc.w	4
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Spore_Fragment

Spore_Fragment_Object3
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Fragment_Graphics
	dc.l	Spore_Fragment_Graphics+(18*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*8		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Fragment_Pattern3
	dc.l	Spore_Fragment_Death
	dc.l	0
	dc.w	4
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Spore_Fragment

Spore_Fragment_Death
	dc.w	OBJECT_KILL,0,0


Spore_Fragment_Pattern1
	include "data/patterns/spore1.s"
 	dc.w	OBJECT_KILL,0,0

Spore_Fragment_Pattern2
	include "data/patterns/spore2.s"
 	dc.w	OBJECT_KILL,0,0

Spore_Fragment_Pattern3
	include "data/patterns/spore3.s"
 	dc.w	OBJECT_KILL,0,0


Spore_Bomber_Up_Object
	dc.w	41<<6+3
	dc.w	BPR-6
	dc.w	2		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Bomber_Graphics
	dc.l	Spore_Bomber_Graphics+(41*4)*2*NUM_PLANES
	dc.w	32		;xsize
	dc.w	41	;ysize
	dc.w	41*4*2		;plane size
	dc.w	41*4		;frame size
	dc.w	3		;alien x words
	dc.l	Spore_Bomber_Up_Pattern
	dc.l	Spore_Bomber_Death
	dc.l	0
	dc.w	4
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ATTACH_SET
	dc.b	Spore_Bomber_Right

Spore_Bomber_Up_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,4
	dc.l	Spore_Wait_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	INITIAL_WAIT_TIME
Spore_Bomber_Up_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spore_Bomber_Up_Wait	
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	7,-8
	dc.l	Spore_Bomb_Up_Object
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	OBJECT_SET_PAT
	dc.l	Spore_Reset_Time
			
Spore_Bomb_Up_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Graphics
	dc.l	Spore_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Bomb_Up_Pattern
	dc.l	Spore_Death
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0


Spore_Bomb_Up_Pattern

	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,58
	dc.l	Spore_UP_Shadow
	
	dc.w	0,-10-SX_INC
	dc.w	0,-9-SX_INC
	dc.w	0,-7-SX_INC
	dc.w	0,-5-SX_INC
	dc.w	0,-3-SX_INC
	dc.w	0,-2-SX_INC
	dc.w	0,-1-SX_INC
	
	dc.w	0,0-SX_INC
	dc.w	0,0-SX_INC
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Whistle

	
	dc.w	0,1-SX_INC
	dc.w	0,2-SX_INC
	dc.w	0,3-SX_INC
	dc.w	0,5-SX_INC
	dc.w	0,7-SX_INC
	dc.w	0,9-SX_INC
	dc.w	0,10-SX_INC
	dc.w	0,10-SX_INC
	dc.w	0,11-SX_INC
	dc.w	0,11-SX_INC
	dc.w	0,12-SX_INC
	dc.w	0,12-SX_INC

	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-11,0
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0


Spore_Bomber_Down_Object
	dc.w	41<<6+3
	dc.w	BPR-6
	dc.w	2		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Bomber_Graphics
	dc.l	Spore_Bomber_Graphics+(41*4)*2*NUM_PLANES
	dc.w	32		;xsize
	dc.w	41	;ysize
	dc.w	41*4*2		;plane size
	dc.w	41*4		;frame size
	dc.w	3		;alien x words
	dc.l	Spore_Bomber_Down_Pattern
	dc.l	Spore_Bomber_Death
	dc.l	0
	dc.w	4
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ATTACH_SET
	dc.b	Spore_Bomber_Right

Spore_Bomber_Down_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	7,4
	dc.l	Spore_Wait_Object
	dc.w	OBJECT_SET_COUNTER
	dc.w	INITIAL_WAIT_TIME
Spore_Bomber_Down_Wait
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spore_Bomber_Down_Wait	
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	7,-8
	dc.l	Spore_Bomb_Down_Object
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	0
	dc.w	OBJECT_SET_PAT
	dc.l	Spore_Reset_Time
			
Spore_Bomb_Down_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Spore_Graphics
	dc.l	Spore_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Bomb_Down_Pattern
	dc.l	Spore_Death
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0


DOWN_INC	EQU	4

Spore_Bomb_Down_Pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,58
	dc.l	Spore_Down_Shadow
	
	dc.w	0,-10+DOWN_INC
	dc.w	0,-9+DOWN_INC
	dc.w	0,-7+DOWN_INC
	dc.w	0,-5+DOWN_INC
	dc.w	0,-3+DOWN_INC
	dc.w	0,-2+DOWN_INC
	dc.w	0,-1+DOWN_INC
	
	dc.w	0,0+DOWN_INC
	dc.w	0,0+DOWN_INC
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_Whistle

	
	dc.w	0,1+DOWN_INC
	dc.w	0,2+DOWN_INC
	dc.w	0,3+DOWN_INC
	dc.w	0,5+DOWN_INC
	dc.w	0,7+DOWN_INC
	dc.w	0,9+DOWN_INC
	dc.w	0,10+DOWN_INC
	dc.w	0,10+DOWN_INC
	dc.w	0,11+DOWN_INC
	dc.w	0,11+DOWN_INC
	dc.w	0,12+DOWN_INC
	dc.w	0,12+DOWN_INC

	dc.w	OBJECT_KILL_ATTACHED_OBJECT
	dc.w	OBJECT_SOUND_EFFECT_1	;****
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-11,0
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0
	
Spore_Fragment_Object
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	8		;
	dc.w	1		;
	dc.l	Spore_Fragment_Graphics
	dc.l	Spore_Fragment_Graphics+(18*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*8		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spore_Fragment_Pattern
	dc.l	Spore_Fragment_Death
	dc.l	0
	dc.w	4
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Spore_Fragment

Spore_Fragment_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0

Spider_Object
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	2		;
	dc.w	2		;
	dc.l	Spider_Graphics
	dc.l	Spider_Graphics+(18*2*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*2		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spider_Pattern
	dc.l	Spider_Death
	dc.l	0
	dc.w	8
	dc.b	OFF_SCREEN_SET
	dc.b	Spider
	
Spider_Pattern
	dc.w	OBJECT_STOP_ANIM
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	(25/4),(2*25/4)
Spider_Wait1_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spider_Wait1_Rep
	dc.w	OBJECT_START_ANIM
	dc.w	-1,2
	dc.w	-1,2
	dc.w	-1,2
	dc.w	-1,2
	dc.w	-1,2
	dc.w	-1,1
	dc.w	-1,1
	dc.w	OBJECT_STOP_ANIM
	
	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Spider_Bullet

	
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	(25/4),(2*25/4)
Spider_Wait2_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spider_Wait2_Rep
	dc.w	OBJECT_START_ANIM
	dc.w	2,0
	dc.w	2,0
	dc.w	2,0
	dc.w	2,0
	dc.w	2,0
	dc.w	OBJECT_STOP_ANIM
	dc.w	OBJECT_SET_RANDOM_COUNTER
	dc.w	(25/4),(2*25/4)
Spider_Wait3_Rep	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Spider_Wait3_Rep

	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Fire_Spider_Bullet

	dc.w	OBJECT_START_ANIM
	dc.w	0,-2
	dc.w	-1,-2
	dc.w	0,-2
	dc.w	-1,-2
	dc.w	0,-2
	dc.w	-1,-2
	dc.w	OBJECT_PATTERN_RESTART

Spider_Death
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,-1
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Splat
	dc.w	OBJECT_KILL,0,0
		
Spider_Missile_Object
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	3		;
	dc.w	1		;
	dc.l	Spider_Missile_Graphics
	dc.l	Spider_Missile_Graphics+(11*2*3)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2*3		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	Spider_Missile_Pattern
	dc.l	Spider_Missile_Death
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET
	dc.b	Spider_Missile
	
Spider_Missile_Pattern
	dc.w	OBJECT_SET_COUNTER
	dc.w	20
Spider_Missile_Repeat	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Bullet_Position
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Bullet_Position
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Bullet_Position
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Increment_Bullet_Position
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Re_Aim_Spider_Bullet
	dc.w	0,0
	dc.w	OBJECT_SET_PAT
	dc.l	Spider_Missile_Repeat	;fall into death routine

Spider_Missile_Death
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-3,-3
	dc.l	Block_Chain_Explosion

	dc.w	OBJECT_KILL,0,0


CHAIN1_X_START	EQU	9
CHAIN1_Y_START	EQU	-26

Chain_Link_Appear_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	7		;
	dc.w	1		;
	dc.l	Generic_Block_Graphics
	dc.l	Generic_Block_Graphics+(16*2)*7*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*7		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Chain_Link_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0

Chain_Link_Appear_Pattern
	dc.w	0,0

Fast_Appear_Chain_Object
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
	dc.l	Fast_Appear_Chain_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Fast_Appear_Chain_Pattern
	dc.w	0,0,0,0,0,0,0,0,0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,3+8
	dc.l	Chain_Link4_Dummy_Object
	dc.w	0,0,0,0,0,0,0,0,0,0
	dc.w	OBJECT_KILL,0,0


Chain_Link1_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE	;
	dc.l	Chain_Link_Graphics
	dc.l	Chain_Link_Graphics+(8*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	8		;ysize
	dc.w	8*2		;plane size
	dc.w	8*2		;frame size
	dc.w	2		;alien x words
	dc.l	Chain_Pattern1
	dc.l	Chain_Death	;remember nothing attached to this
	dc.l	0
	dc.w	1
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Chain_Link2_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Chain_Link_Graphics
	dc.l	Chain_Link_Graphics+(8*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	8		;ysize
	dc.w	8*2		;plane size
	dc.w	8*2		;frame size
	dc.w	2		;alien x words
	dc.l	Chain_Pattern2
	dc.l	Chain_Death_Attached
	dc.l	0
	dc.w	1
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Chain_Link3_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Chain_Link_Graphics
	dc.l	Chain_Link_Graphics+(8*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	8		;ysize
	dc.w	8*2		;plane size
	dc.w	8*2		;frame size
	dc.w	2		;alien x words
	dc.l	Chain_Pattern3
	dc.l	Chain_Death_Attached
	dc.l	0
	dc.w	1
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Chain_Link4_Object
	dc.w	16<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Chain_Block_Graphics
	dc.l	Chain_Block_Graphics+(16*4)*NUM_PLANES
	dc.w	22		;xsize
	dc.w	16		;ysize
	dc.w	16*4		;plane size
	dc.w	16*4		;frame size
	dc.w	3		;alien x words
	dc.l	Chain_Pattern4
	dc.l	Main_Chain_Death
	dc.l	0
	dc.w	12
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0

Chain_Link4_Shootable_Object
	dc.w	16<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Chain_Block_Graphics
	dc.l	Chain_Block_Graphics+(16*4)*NUM_PLANES
	dc.w	22		;xsize
	dc.w	16		;ysize
	dc.w	16*4		;plane size
	dc.w	16*4		;frame size
	dc.w	3		;alien x words
	dc.l	Chain_Pattern4
	dc.l	Main_Chain_Death
	dc.l	0
	dc.w	12
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0



Main_Chain_Death
	dc.w	OBJECT_DECREASE
	dc.l	Gen_Var
	dc.w	OBJECT_UPDATE_SCORE
	dc.w	150
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	-8,0
	dc.l	Explo_Split_Object_1
	dc.l	Explo_Split_Object_2
	dc.l	Explo_Split_Object_3
	dc.l	Explo_Split_Object_4
	dc.l	$ffffffff
	dc.w	OBJECT_BLOW_UP_ATTACHED
	dc.w	OBJECT_KILL,0,0	


Chain_Link4_Dummy_Object
	dc.w	16<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Chain_Block_Graphics
	dc.l	Chain_Block_Graphics+(16*4)*NUM_PLANES
	dc.w	22		;xsize
	dc.w	16		;ysize
	dc.w	16*4		;plane size
	dc.w	16*4		;frame size
	dc.w	3		;alien x words
	dc.l	Chain_PatternStart4
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0


Chain_PatternStart4
	dc.w	OBJECT_INCREASE
	dc.l	Gen_Var
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	(22-11)/2,8+3
	dc.l	Chain_Link3_Object
	dc.w	0,-8
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_TRANSFORM_BOTCH
	dc.l	Chain_Link4_Object
	dc.w	OBJECT_KILL,0,0
	
Chain_Pattern4
	include	"data/patterns/chain4.s"
	dc.w	OBJECT_CHANGE_TYPE
	dc.l	Chain_Link4_Shootable_Object
	dc.w	OBJECT_PATTERN_RESTART

Chain_Pattern3
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,4+3
	dc.l	Chain_Link2_Object
	dc.w	0,-4
	dc.w	0,0
	dc.w	0,0
Chain_Pattern3_Repeat	
	include	"data/patterns/chain3.s"
	dc.w	OBJECT_SET_PAT
	dc.l	Chain_Pattern3_Repeat

Chain_Pattern2
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,4+3
	dc.l	Chain_Link1_Object
	dc.w	0,-4
	dc.w	0,0
	dc.w	0,0
Chain_Pattern2_Repeat	
	include	"data/patterns/chain2.s"
	dc.w	OBJECT_SET_PAT
	dc.l	Chain_Pattern2_Repeat

Chain_Pattern1
	dc.w	0,-4
	dc.w	0,0
	dc.w	0,0
Chain_Pattern1_Repeat	
	include	"data/patterns/chain1.s"
	dc.w	OBJECT_SET_PAT
	dc.l	Chain_Pattern1_Repeat



Chain_Death_Attached
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SOUND_EFFECT_4
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_BLOW_UP_ATTACHED
	dc.w	OBJECT_KILL,0,0	

Chain_Death
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_SExplo
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Block_Chain_Explosion
	dc.w	OBJECT_KILL,0,0	
	
Bomb_Launch_Object
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Bomb_Launch_Graphics
	dc.l	Bomb_Launch_Graphics+(15*2*3)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*3		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Bomb_Launch_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0
	
Bomb_Launch_Pattern
	dc.w	7,-1
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	1
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET
	dc.w	2
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,-5
	dc.l	Bomb_Object
	dc.w	OBJECT_KILL,0,0	

Bomb_Object
	dc.w	20<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Bomb_Graphics
	dc.l	Bomb_Graphics+(20*2*7)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	20		;ysize
	dc.w	20*2*7		;plane size
	dc.w	20*2		;frame size
	dc.w	2		;alien x words
	dc.l	Bomb_Attack_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET+ALIEN_PRI_SET
	dc.b	0

Bomb_Attack_Pattern
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Bomb
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	dc.w	0,-8
	dc.w	0,-8

	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	
	dc.w	0,-8
	dc.w	0,-7

	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke
	
	dc.w	0,-7
	dc.w	0,-7
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	
	dc.w	0,-6
	dc.w	0,-6

	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	dc.w	0,-6
	dc.w	0,-4
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	dc.w	0,-4
	dc.w	OBJECT_FRAME_SET,1
	dc.w	0,-4
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke

	dc.w	OBJECT_FRAME_SET,2
	dc.w	0,-2	
	dc.w	OBJECT_FRAME_SET,3
	dc.w	0,-1
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	2,12
	dc.l	Smoke
	dc.w	OBJECT_FRAME_SET,4
	dc.w	0,0
	dc.w	OBJECT_FRAME_SET,5
	dc.w	0,1
	dc.w	OBJECT_FRAME_SET,6
	dc.w	0,2
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Whistle
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	0,5
	dc.w	0,5
	dc.w	0,6
	dc.w	0,6
	dc.w	0,6
	dc.w	0,7
	dc.w	0,7
	dc.w	0,8
	dc.w	0,8
	dc.w	0,8
	
	dc.w	OBJECT_SOUND_EFFECT_1	
	dc.w	Sound_Crap
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-11,0
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD_LOTS
	dc.w	0,0
	dc.l	Spore_Fragment_Object1
	dc.l	Spore_Fragment_Object2
	dc.l	Spore_Fragment_Object3
	dc.l	$ffffffff
	dc.w	OBJECT_KILL,0,0

	
	dc.w	OBJECT_KILL,0,0
	