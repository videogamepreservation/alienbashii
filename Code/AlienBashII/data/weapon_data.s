*Bullet structrues are exactly the same as alien ones except they
*use different flags

SET_MULTI_HIT	EQU	2	
MULTI_HIT	EQU	1

SET_NO_EXPLODE	EQU	1
NO_EXPLODE	EQU	0	
	


*------------Bullet data
Grenade_Explosion_Bullet
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
	dc.l	grenade_explosion_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	SET_NO_EXPLODE
	dc.b	-1	;so we know its a grenade

Quick_Grenade_Explosion_Bullet
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
	dc.l	dome_explosion_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	SET_NO_EXPLODE
	dc.b	-1	;so we know its a grenade

		
Missile_Explosion
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
	dc.l	grenade_explosion_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	SET_NO_EXPLODE
	dc.b	0	;alien type number

*-------------------------Bullet Alien Structs
	
small_bullet_up
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets
	dc.l	small_bullets+(6*2*8)*NUM_PLANES
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_pat
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	0	;bullet direction
	
		
	
	
small_bullet_up_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets
	dc.l	small_bullets+(6*2*8)*NUM_PLANES
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	0   	;bullet direction
	
	
small_bullet_up_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets
	dc.l	small_bullets+(6*2*8)*NUM_PLANES
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	0	;bullet_direction
	

		
small_bullet_down
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*2
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	2		;bullet direction

small_bullet_down_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*2
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	2	;bullet direction

small_bullet_down_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*2
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	2		;bullet direction

small_bullet_left
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*3
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*3
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_left_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	3		;bullet direction

small_bullet_left_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*3
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*3
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_left_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	3		;bullet direction

small_bullet_left_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*3
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*3
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_left_pat_c	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	3		;bullet direction

	
small_bullet_right
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_right_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	1	;bullet direction

small_bullet_right_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_right_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	1	;bullet direction

small_bullet_right_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_right_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	1		;bullet direction

small_bullet_up_left
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*5
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*5
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_left_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	5		;bullet direction

small_bullet_up_left_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*5
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*5
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_left_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	5		;bullet direction

small_bullet_up_left_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*5
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*5
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_left_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	5		;bullet direction


small_bullet_up_right
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*6
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*6
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_right_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	6		;bullet direction

small_bullet_up_right_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*6
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*6
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_right_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	6		;bullet direction
small_bullet_up_right_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*6
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*6
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_up_right_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	6		;bullet direction


small_bullet_down_left
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*4
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*4
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_left_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	4		;bullet direction

small_bullet_down_left_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*4
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*4
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_left_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	4		;bullet direction


small_bullet_down_left_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*4
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*4
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_left_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	4		;bullet direction


small_bullet_down_right
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*7
	dc.l	small_bullets+((6*2*8)*NUM_PLANES)+6*2*7
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_right_pat	
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	7		;bullet direction

small_bullet_down_right_b
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*7
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*7
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_right_pat_b
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	7		;bullet direction


small_bullet_down_right_c
	dc.w	6<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	0
	dc.l	small_bullets+6*2*7
	dc.l	small_bullets+(6*2*8)*NUM_PLANES+6*2*7
	dc.w	6		;xsize
	dc.w	6		;ysize
	dc.w	6*2*8		;plane size
	dc.w	6*2		;frame size
	dc.w	2		;alien x words
	dc.l	bullet_down_right_pat_c
	dc.l	small_bullet_die
	dc.l	0
	dc.w	0
	dc.b	0
	dc.b	7		;bullet direction

SIZE_OF_BULLET_STRUCT	EQU (*-small_bullet_down_right_c)

NUMBER_OF_BULLET_STRUCTS	EQU (*-small_bullet_up)/SIZE_OF_BULLET_STRUCT


rocket_up
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_up_graphics
	dc.l	rocket_up_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_up_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

rocket_down
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_down_graphics
	dc.l	rocket_down_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_down_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
	
rocket_left
	dc.w	12<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_left_graphics
	dc.l	rocket_left_graphics+(12*2*4)*NUM_PLANES
	dc.w	12		;xsize
	dc.w	12		;ysize
	dc.w	12*2*4		;plane size
	dc.w	12*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_left_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
rocket_right
	dc.w	12<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_right_graphics
	dc.l	rocket_right_graphics+(12*2*4)*NUM_PLANES
	dc.w	12		;xsize
	dc.w	12		;ysize
	dc.w	12*2*4		;plane size
	dc.w	12*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_right_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
rocket_down_left
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_down_left_graphics
	dc.l	rocket_down_left_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_down_left_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
rocket_down_right
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_down_right_graphics
	dc.l	rocket_down_right_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_down_right_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
	
rocket_up_left
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_up_left_graphics
	dc.l	rocket_up_left_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_up_left_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0

	
rocket_up_right
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4
	dc.w	1
	dc.l	rocket_up_right_graphics
	dc.l	rocket_up_right_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	rocket_up_right_pat
	dc.l	rocket_die
	dc.l	0
	dc.w	0
	dc.b	SET_MULTI_HIT,0



small_bullet_die
*	dc.w	OBJECT_SOUND_EFFECT_2
*	dc.w	Sound_Thud
	dc.w	OBJECT_ADD
	dc.w	-3,-3
	dc.w	Small_Explosion
	dc.w	OBJECT_KILL,0,0
	
Rocket_Die
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Bang
	dc.w	OBJECT_BULLET_ADD
	dc.w	-8,-8
	dc.l	Missile_Explosion
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Check_Rocket_Explo
	dc.w	OBJECT_KILL,0,0


explosion_pattern
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
	dc.w	OBJECT_KILL,0,0

grenade_explosion_pattern	
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
	dc.w	OBJECT_KILL,0,0



small_explosion_pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0



BULLET_INC	EQU	10

bullet_up_pat
	dc.w	0,-BULLET_INC
	dc.w	0,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_up_pat_b
	dc.w	-2,-BULLET_INC
	dc.w	-1,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART

bullet_up_pat_c
	dc.w	2,-BULLET_INC
	dc.w	1,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART
	
	
bullet_down_pat
	dc.w	0,BULLET_INC
	dc.w	0,BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART		
	
bullet_down_pat_b
	dc.w	-2,BULLET_INC
	dc.w	-1,BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART		

bullet_down_pat_c
	dc.w	2,BULLET_INC
	dc.w	1,BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART		
	
	
	
bullet_left_pat
	dc.w	-BULLET_INC,0
	dc.w	-BULLET_INC,0
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_left_pat_b
	dc.w	-BULLET_INC,-2
	dc.w	-BULLET_INC,-1
	dc.w	OBJECT_PATTERN_RESTART

bullet_left_pat_c
	dc.w	-BULLET_INC,2
	dc.w	-BULLET_INC,1
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_right_pat
	dc.w	BULLET_INC,0
	dc.w	BULLET_INC,0
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_right_pat_b
	dc.w	BULLET_INC,-2
	dc.w	BULLET_INC,-1
	dc.w	OBJECT_PATTERN_RESTART

bullet_right_pat_c
	dc.w	BULLET_INC,2
	dc.w	BULLET_INC,1
	dc.w	OBJECT_PATTERN_RESTART
	
	
	
	
	
bullet_up_left_pat
	dc.w	-BULLET_INC,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_up_left_pat_b
	dc.w	-BULLET_INC+(BULLET_INC/3),-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART

bullet_up_left_pat_c
	dc.w	-BULLET_INC,-BULLET_INC+(BULLET_INC/3)
	dc.w	OBJECT_PATTERN_RESTART
	
	
	
	
bullet_up_right_pat
	dc.w	BULLET_INC,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART					
	
bullet_up_right_pat_b
	dc.w	BULLET_INC,-BULLET_INC+(BULLET_INC/3)
	dc.w	OBJECT_PATTERN_RESTART		

bullet_up_right_pat_c
	dc.w	BULLET_INC-BULLET_INC/3,-BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART	
	
	
	
bullet_down_left_pat
	dc.w	-BULLET_INC,BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART
	
bullet_down_left_pat_b
	dc.w	-BULLET_INC,BULLET_INC-(BULLET_INC/3)
	dc.w	OBJECT_PATTERN_RESTART

bullet_down_left_pat_c
	dc.w	-BULLET_INC+(BULLET_INC/3),BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART

	
	
	
bullet_down_right_pat
	dc.w	BULLET_INC,BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART				

bullet_down_right_pat_b
	dc.w	BULLET_INC,BULLET_INC-(BULLET_INC/3)
	dc.w	OBJECT_PATTERN_RESTART	

bullet_down_right_pat_c
	dc.w	BULLET_INC-(BULLET_INC/3),BULLET_INC
	dc.w	OBJECT_PATTERN_RESTART	

ROCKET_INC	EQU	7
ROCKET_DINC	EQU	6


rocket_up_pat
	dc.w	OBJECT_ADD
	dc.w	0,10
	dc.w	Smoke_Object
	dc.w	0,-rocket_INC/3
	dc.w	0,-rocket_INC/3
	
	dc.w	OBJECT_ADD
	dc.w	0,10
	dc.w	Smoke_Object
	dc.w	0,-rocket_INC/2
	dc.w	0,-rocket_INC/2
	
	dc.w	OBJECT_ADD
	dc.w	0,10
	dc.w	Smoke_Object
	dc.w	0,-(rocket_INC-1)
	dc.w	0,-(rocket_INC-1)

rocket_up_repeat	
	dc.w	OBJECT_ADD
	dc.w	0,10
	dc.w	Smoke_Object
	dc.w	0,-rocket_INC
	dc.w	0,-rocket_INC

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_up_repeat
	
rocket_down_pat
	dc.w	OBJECT_ADD
	dc.w	0,-2
	dc.w	Smoke_Object
	dc.w	0,rocket_INC/3
	dc.w	0,rocket_INC/3
	
	dc.w	OBJECT_ADD
	dc.w	0,-2
	dc.w	Smoke_Object
	dc.w	0,rocket_INC/2
	dc.w	0,rocket_INC/2
	
	dc.w	OBJECT_ADD
	dc.w	0,-2
	dc.w	Smoke_Object
	dc.w	0,rocket_INC-1
	dc.w	0,rocket_INC-1
rocket_down_repeat	
	dc.w	OBJECT_ADD
	dc.w	0,-2
	dc.w	Smoke_Object
	dc.w	0,rocket_INC
	dc.w	0,rocket_INC

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_down_repeat
	
rocket_left_pat
	dc.w	OBJECT_ADD
	dc.w	6,0
	dc.w	Smoke_Object
	dc.w	-rocket_INC/3,0
	dc.w	-rocket_INC/3,0
	
	dc.w	OBJECT_ADD
	dc.w	6,0
	dc.w	Smoke_Object
	dc.w	-rocket_INC/2,0
	dc.w	-rocket_INC/2,0
	
	dc.w	OBJECT_ADD
	dc.w	6,0
	dc.w	Smoke_Object
	dc.w	-(rocket_INC-1),0
	dc.w	-(rocket_INC-1),0

rocket_left_repeat
	dc.w	OBJECT_ADD
	dc.w	6,0
	dc.w	Smoke_Object
	dc.w	-rocket_INC,0
	dc.w	-rocket_INC,0

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_left_repeat
	
rocket_right_pat
	dc.w	OBJECT_ADD
	dc.w	-4,0
	dc.w	Smoke_Object
	dc.w	rocket_INC/3,0
	dc.w	rocket_INC/3,0
	
	dc.w	OBJECT_ADD
	dc.w	-4,0
	dc.w	Smoke_Object
	dc.w	rocket_INC/2,0
	dc.w	rocket_INC/2,0
	
	dc.w	OBJECT_ADD
	dc.w	-4,0
	dc.w	Smoke_Object
	dc.w	rocket_INC-1,0
	dc.w	rocket_INC-1,0
rocket_right_pat_repeat
	dc.w	OBJECT_ADD
	dc.w	-4,0
	dc.w	Smoke_Object
	dc.w	rocket_INC,0
	dc.w	rocket_INC,0

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_right_pat_repeat
	
rocket_up_left_pat
	dc.w	OBJECT_ADD
	dc.w	8,8
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/3,-rocket_DINC/3
	dc.w	-rocket_DINC/3,-rocket_DINC/3
	
	dc.w	OBJECT_ADD
	dc.w	8,8
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/3,-rocket_DINC/3
	dc.w	-rocket_DINC/3,-rocket_DINC/3

	
	dc.w	OBJECT_ADD
	dc.w	8,8
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/2,-rocket_DINC/2
	dc.w	-rocket_DINC/2,-rocket_DINC/2

	dc.w	OBJECT_ADD
	dc.w	8,8
	dc.w	Smoke_Object
	dc.w	-(rocket_DINC-1),-(rocket_DINC-1)
	dc.w	-(rocket_DINC-1),-(rocket_DINC-1)
rocket_up_left_repeat
	dc.w	OBJECT_ADD
	dc.w	8,8
	dc.w	Smoke_Object
	dc.w	-rocket_DINC,-rocket_DINC
	dc.w	-rocket_DINC,-rocket_DINC

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_up_left_repeat
	
rocket_up_right_pat
	dc.w	OBJECT_ADD
	dc.w	0,8
	dc.w	Smoke_Object
	dc.w	rocket_DINC/3,-rocket_DINC/3
	dc.w	rocket_DINC/3,-rocket_DINC/3
	
	dc.w	OBJECT_ADD
	dc.w	0,8
	dc.w	Smoke_Object
	dc.w	rocket_DINC/3,-rocket_DINC/3
	dc.w	rocket_DINC/3,-rocket_DINC/3

	
	dc.w	OBJECT_ADD
	dc.w	0,8
	dc.w	Smoke_Object
	dc.w	rocket_DINC/2,-rocket_DINC/2
	dc.w	rocket_DINC/2,-rocket_DINC/2

	dc.w	OBJECT_ADD
	dc.w	0,8
	dc.w	Smoke_Object
	dc.w	rocket_DINC-1,-(rocket_DINC-1)
	dc.w	rocket_DINC-1,-(rocket_DINC-1)
rocket_up_right_repeat
	dc.w	OBJECT_ADD
	dc.w	0,8
	dc.w	Smoke_Object
	dc.w	rocket_DINC,-rocket_DINC
	dc.w	rocket_DINC,-rocket_DINC

	dc.w	OBJECT_SET_PAT
	dc.l	rocket_up_right_repeat	
						
	
rocket_down_left_pat
	dc.w	OBJECT_ADD
	dc.w	8,0
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/3,rocket_DINC/3
	dc.w	-rocket_DINC/3,rocket_DINC/3
	
	dc.w	OBJECT_ADD
	dc.w	8,0
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/3,rocket_DINC/3
	dc.w	-rocket_DINC/3,rocket_DINC/3

	
	dc.w	OBJECT_ADD
	dc.w	8,0
	dc.w	Smoke_Object
	dc.w	-rocket_DINC/2,rocket_DINC/2
	dc.w	-rocket_DINC/2,rocket_DINC/2
	
	dc.w	OBJECT_ADD
	dc.w	8,0
	dc.w	Smoke_Object
	dc.w	-(rocket_DINC-1),rocket_DINC-1
	dc.w	-(rocket_DINC-1),rocket_DINC-1
rocket_down_left_repeat	
	dc.w	OBJECT_ADD
	dc.w	8,0
	dc.w	Smoke_Object
	dc.w	-rocket_DINC,rocket_DINC
	dc.w	-rocket_DINC,rocket_DINC
	dc.w	OBJECT_SET_PAT
	dc.l	rocket_down_left_repeat



	
rocket_down_right_pat
	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Smoke_Object
	dc.w	rocket_DINC/3,rocket_DINC/3
	dc.w	rocket_DINC/3,rocket_DINC/3
	
	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Smoke_Object
	dc.w	rocket_DINC/3,rocket_DINC/3
	dc.w	rocket_DINC/3,rocket_DINC/3

	
	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Smoke_Object
	dc.w	rocket_DINC/2,rocket_DINC/2
	dc.w	rocket_DINC/2,rocket_DINC/2

	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Smoke_Object
	dc.w	rocket_DINC-1,rocket_DINC-1
	dc.w	rocket_DINC-1,rocket_DINC-1
rocket_down_right_repeat	
	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Smoke_Object
	dc.w	rocket_DINC,rocket_DINC
	dc.w	rocket_DINC,rocket_DINC
	


	dc.w	OBJECT_SET_PAT
	dc.l	rocket_down_right_repeat


*define 1 explosion bullet and then change pattern when added to list

small_explo_bullet
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	10
	dc.w	1
	dc.l	Block_Explosion_Graphics
	dc.l	Block_Explosion_Graphics+(18*2*10)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*10		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	small_explo_bullet_patt
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	SET_NO_EXPLODE,0

*up
explo_bullet_patt1
	dc.w	0,-5,0,-5,0,-5,-0,-5,0,-5,0,-5,0,-4,0,-4,0,-3,0,-3
	dc.w	OBJECT_KILL,0,0

*down	
explo_bullet_patt2
	dc.w	0,5,0,5,0,5,0,5,0,5,0,5,0,4,0,4,0,3,0,3
	dc.w	OBJECT_KILL,0,0
	

*right
explo_bullet_patt3
	dc.w	5,0,5,0,5,0,5,0,5,0,5,0,4,0,4,0,3,0,3,0
	dc.w	OBJECT_KILL,0,0


*left
explo_bullet_patt4
	dc.w	-5,0,-5,0,-5,0,-5,0,-5,0,-5,0,-4,0,-4,0,-3,0,-3,0
	dc.w	OBJECT_KILL,0,0

*up right
explo_bullet_patt5
	dc.w	4,-4,4,-4,4,-4,4,-4,4,-4,4,-4,3,-3,3,-3,2,-2,2,-2
	dc.w	OBJECT_KILL,0,0	

*down right
explo_bullet_patt6
	dc.w	4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,2,2,2,2
	dc.w	OBJECT_KILL,0,0	

*up left
explo_bullet_patt7
	dc.w	-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,-3,-3,-3,-2,-2,-2,-2
	dc.w	OBJECT_KILL,0,0	

*down left
explo_bullet_patt8
	dc.w	-4,4,-4,4,-4,4,-4,4,-4,4,-4,4,-3,3,-3,3,-2,2,-2,2
	dc.w	OBJECT_KILL,0,0	
	

*up
explo_grenade_patt1

	dc.w	0,-2,0,-2,-0,-2,0,-2,0,-2
	dc.w	0,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	0,-2,-0,-2,0,-2,0,-2
	dc.w	0,-2,0,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	0,-2,0,-2,0,-2
	dc.w	0,-2,0,-2,0,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*up right
explo_grenade_patt2

	dc.w	2,-2,2,-2,2,-2,2,-2,2,-2
	dc.w	2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,-2,-2,-2,2,-2,2,-2
	dc.w	2,-2,2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,-2,2,-2,2,-2
	dc.w	2,-2,2,-2,2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*right
explo_grenade_patt3

	dc.w	2,0,2,0,2,0,2,0,2,0
	dc.w	2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,0,2,0,2,0,2,0
	dc.w	2,0,2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,0,2,0,2,0
	dc.w	2,0,2,0,2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*down right
explo_grenade_patt4

	dc.w	2,2,2,2,2,2,2,2,2,2
	dc.w	2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,2,2,2,2,2,2,2
	dc.w	2,2,2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	2,2,2,2,2,2
	dc.w	2,2,2,2,2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*down
explo_grenade_patt5

	dc.w	0,2,0,2,-0,2,0,2,0,2
	dc.w	0,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	0,2,0,2,0,2,0,2
	dc.w	0,2,0,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	0,2,0,2,0,2
	dc.w	0,2,0,2,0,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*down left
explo_grenade_patt6
	dc.w	-2,2,-2,2,-2,2,-2,2,-2,2
	dc.w	-2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,2,-2,2,-2,2,-2,2
	dc.w	-2,2,-2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,2,-2,2,-2,2
	dc.w	-2,2,-2,2,-2,2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*left
explo_grenade_patt7
	dc.w	-2,0,-2,0,-2,0,-2,0,-2,0
	dc.w	-2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,0,-2,0,-2,0,-2,0
	dc.w	-2,0,-2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,0,-2,0,-2,0
	dc.w	-2,0,-2,0,-2,0
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

*up left
explo_grenade_patt8

	dc.w	-2,-2,-2,-2,-2,-2,-2,-2,-2,-2
	dc.w	-2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,-2,-2,-2,-2,-2,-2,-2
	dc.w	-2,-2,-2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	-2,-2,-2,-2,-2,-2
	dc.w	-2,-2,-2,-2,-2,-2
	dc.w	OBJECT_BULLET_ADD
	dc.w	0,0
	dc.l	Quick_Grenade_Explosion_Bullet
	dc.w	OBJECT_KILL,0,0

small_explo_bullet_patt
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0
	