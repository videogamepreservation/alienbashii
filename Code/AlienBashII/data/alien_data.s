 

******* PUT ALL NON AGGRESSOR ALIENS IN HERE  *******

DONT_ANIMATE	EQU	-1


*Always do one extra frame for alien and make that the hit frame

Small_Explosion		EQU	0
Dome_Object		EQU	1
Smoke_Object		EQU	2
Grenade_Pickup		EQU	3
Homing_Missile_Pickup	EQU	4
Rocket_Launcher_Pickup	EQU	5
Double_Pickup		EQU	6
Standard_Gun_Pickup	EQU	7
Triple_Gun_Pickup	EQU	8
Grenade_Explosion	EQU	9
Crosshair		EQU	10
Dome_Explosion		EQU	11
Block_Explosion		EQU	12
Hostage			EQU	13
Pig_Alien_Object	EQU	14
Weapon_Capsule_Extra	EQU	15
Weapon_Capsule_Grenade	EQU	17
Weapon_Capsule_Missile	EQU	16
Weapon_Capsule_Standard EQU	18
Extra_Life_Pickup	EQU	19
Extra_Energy_Pickup	EQU	20
Alien_Bullet		EQU	21
Middle_Explosion	EQU	22
RedJumpFlower		EQU	23
BlueJumpFlower		EQU	24
Standard_Key		EQU	25
PigMissile		EQU	26
Skully_Collect		EQU	27
Spikey			EQU	28
Spinny			EQU	29
Coin			EQU	30
Chest			EQU	31
Chest4			EQU	32
Chest3			EQU	33
Chest2			EQU	34
Chest1			EQU	35
Chest0			EQU	36
Silver_Coin		EQU	37
Silver_Chest		EQU	38
SChest4			EQU	39
SChest3			EQU	40
SChest2			EQU	41
SChest1			EQU	42
SChest0			EQU	43
Fish_Bob_Left		EQU	44
Fish_Bob_Right		EQU	45
Fish_Dl			EQU	46
Fish_Dr			EQU	47
Statue_Head		EQU	48
Wasp_Nest		EQU	49
Waspy			EQU	50
FishUpBob		EQU	51
FishBullet		EQU	52
Added_Pig		EQU	53
Pig_Out_Cave		EQU	54
Pig_Generator		EQU	55
Pig_Generator2		EQU	56
Pig_Generator3		EQU	57
Pig_Generator4		EQU	58
Pig_Generator5		EQU	59
Pig_GeneratorNoSkull	EQU	60
Maggot			EQU	61
Maggot2			EQU	62
Maggot3			EQU	63
Maggot_Generator	EQU	64
Added_Maggot		EQU	65
Generator		EQU	66
Key_Chest		EQU	67
Fire_Key		EQU	68
GoldMoney1		EQU	69
SilverMoney1		EQU	70
GoldMoney2		EQU	71
SilverMoney2		EQU	72
Swamp_Anim		EQU	73
Pig_Guard		EQU	74
Small_Potion		EQU	75
Blue_Butterfly		EQU	76
Torch_Flame		EQU	77
Pig_No_Shoot		EQU	78
Counter_Maggot		EQU	79
Speed_Pig		EQU	80
Spore_Bomber_Right	EQU	81
Spore_Bomber_Left	EQU	82
Spore_Bomber_Up		EQU	83
Spore_Bomber_Down	EQU	84
Spore_Fragment		EQU	85
Bush_Pig_Generator	EQU	86
Special_Statue		EQU	87
Exploding_Pig_Gen	EQU	88
Exploding_Pig		EQU	89
Gen_Count		EQU	90
Fly			EQU	91
Fly2			EQU	92
Spider			EQU	93
Spider_Missile		EQU	94
Fly3			EQU	95
Fly4			EQU	96
RedFlipFlower		EQU	97
ChainGenerator		EQU	98

Species_Table
	dc.l	small_bullet_explosion
	dc.l	Pig_Alien
	dc.l	Smoke
	dc.l	Grenade_Object
	dc.l	Home_Object
	dc.l	Rocket_Object
	dc.l	Double_Object
	dc.l	Standard_Object
	dc.l	Triple_Object
	dc.l	Grenade_Explosion_Object
	dc.l	Crosshair_Object
	dc.l	Dome_Explosion_Object
	dc.l	Block_Chain_Explosion
	dc.l	Hostage_Object
	dc.l	Pig_Alien
	dc.l	Weapon_Capsule_Object_Extra
	dc.l	Weapon_Capsule_Object_Grenade
	dc.l	Weapon_Capsule_Object_Missile
	dc.l	Weapon_Capsule_Object_Standard
	dc.l	Extra_Life
	dc.l	Extra_Energy
	dc.l	Alien_Bullet_Object
	dc.l	Block_Chain_Explosion
	dc.l	RedJumpFlower_Object
	dc.l	BlueJumpFlower_Object
	dc.l	Standard_Key_Alien
	dc.l	PigMissile_Object
	dc.l	Skully
	dc.l	Spikey_Object
	dc.l	Spinny_Object
	dc.l	Coin_Object
	dc.l	Chest_Object
	dc.l	Chest_Object4
	dc.l	Chest_Object3
	dc.l	Chest_Object2
	dc.l	Chest_Object1
	dc.l	Chest_Object0
	dc.l	Silver_Coin_Object
	dc.l	Silver_Chest_Object
	dc.l	Silver_Chest_Object4
	dc.l	Silver_Chest_Object3
	dc.l	Silver_Chest_Object2
	dc.l	Silver_Chest_Object1
	dc.l	Silver_Chest_Object0
	dc.l	Fish_Bob_Left_Object
	dc.l	Fish_Bob_Right_Object
	dc.l	Fish_Dive_Left
	dc.l	Fish_Dive_Right
	dc.l	Statue_Object
	dc.l	WaspNest_Object
	dc.l	Wasp_Alien
	dc.l	FishUpBob_Alien
	dc.l	Fish_Bullet_Object
	dc.l	Added_Pig_Alien
	dc.l	Pig_Out_Cave_Object
	dc.l	Pig_Generator_Object
Pig_Gen_List	
	dc.l	Pig_Generator_Object2
	dc.l	Pig_Generator_Object3
	dc.l	Pig_Generator_Object4
	dc.l	Pig_Generator_Object5
	dc.l	Pig_Generator_No_Skull_Object
	dc.l	Maggot_Alien	
	dc.l	Maggot_Alien2
	dc.l	Maggot_Alien3
	dc.l	Maggot_Generator_Alien
	dc.l	Added_Maggot_Alien
	dc.l	Generator_Alien	;generator	
	dc.l	Key_Chest_Object
	dc.l	Fire_Key_Object
	dc.l	Small_Gold_Coin
	dc.l	Small_Silver_Coin
	dc.l	Small_Gold_Coins
	dc.l	Small_Silver_Coins
	dc.l	Swamp_Anim_Alien
	dc.l	Pig_Guard_Object
	dc.l	Small_Potion_Object
	dc.l	Blue_Butterfly_Object
	dc.l	Torch_Flame_Object
	dc.l	Pig_No_Shoot_Alien
	dc.l	Counter_Maggot_Alien
	dc.l	Fast_Pig_Alien
	dc.l	Spore_Bomber_Right_Object
	dc.l	Spore_Bomber_Left_Object
	dc.l	Spore_Bomber_Up_Object	
	dc.l	Spore_Bomber_Down_Object
	dc.l	Spore_Fragment_Object1
	dc.l	Bush_Generator		
	dc.l	Statue_Head_Counter_Object
	dc.l	Exploding_Pig_Generator_No_Skull_Object
	dc.l	Ex_Pig_No_Skull_Alien		
	dc.l	Pig_Generator_No_Skull_Counter_Object
	dc.l	Fly_Object
	dc.l	Fly_Object2
	dc.l	Spider_Object	
	dc.l	Spider_Missile_Object
	dc.l	Fly_Object3
	dc.l	Fly_Object4
	dc.l	redflipflower_object
	dc.l	Chain_Generator_Object
			
*Species Number is index into table	
Man_Alien_Collision_Table	
	dc.l	0
	dc.l	Sap_Player_Energy
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Collect_Hostage
	dc.l	Sap_Player_Energy
	dc.l	0
	dc.l	Pickup_Missile_Pack
	dc.l	Pickup_Grenade_Pack
	dc.l	0
	dc.l	Pickup_Extra_Life
	dc.l	Pickup_Extra_Energy
	dc.l	Kill_Alien_Bullet	;alien bullet
	dc.l	0
	dc.l	0		;rj f
	dc.l	0		;bj f
	dc.l	Pick_Up_Key	;flame key
	dc.l	Kill_Alien_Bullet	;pig missile
	dc.l	Collect_Skully		;skull
	dc.l	0
	dc.l	Kill_Alien_Bullet	;spinny
	dc.l	Collect_Coin
	dc.l	0		;chest
	dc.l	0		;chest
	dc.l	0		;chest
	dc.l	0		;chest
	dc.l	0		;chest
	dc.l	0		;chest
	dc.l	Collect_Silver_Coin	;silver_coin
	dc.l	0		;schest
	dc.l	0		;schest
	dc.l	0		;schest
	dc.l	0		;schest
	dc.l	0		;schest
	dc.l	0		;schest
	dc.l	0		;bob f
	dc.l	0		;bob f
	dc.l	Sap_Player_Energy	;fish
	dc.l	Sap_Player_Energy	;fish
	dc.l	0		;Statue
	dc.l	0		;Wasp nest
	dc.l	Sap_Player_Energy	;wasp
	dc.l	0		;fishup bob
	dc.l	Kill_Fish_Bullet	;fish bullet
	dc.l	Sap_Player_Energy	;added pig
	dc.l	Sap_Player_Energy
	dc.l	0		;pig generator
	dc.l	0		;pig generator
	dc.l	0		;pig generator
	dc.l	0		;pig generator
	dc.l	0		;pig generator
	dc.l	0		;pig gen no skull
	dc.l	Sap_Player_Energy	;maggot
	dc.l	Sap_Player_Energy	;maggot
	dc.l	Sap_Player_Energy	;maggot
	dc.l	0			;maggot generator
	dc.l	Sap_Player_Energy	;added maggot
	dc.l	0			;generator
	dc.l	0			;key chest
	dc.l	Pick_Up_EOL_Key		;end of level key
	dc.l	Pick_Up_Gold_Money	;gold coin
	dc.l	Pick_Up_Silver_Money	;silver coin
	dc.l	Pick_Up_Gold_Moneys	;gold coins
	dc.l	Pick_Up_Silver_Moneys	;silver coins
	dc.l	0
	dc.l	Sap_Player_Energy	;pig guard
	dc.l	Pickup_Small_Energy
	dc.l	0			;blue butterfly
	dc.l	0			;torch flame
	dc.l	Sap_Player_Energy	;no shoot pig
	dc.l	Sap_Player_Energy	;counter maggot
	dc.l	Sap_Player_Energy
	dc.l	0			; SporeBomber right
	dc.l	0			; SporeBomber right
	dc.l	0			; SporeBomber up
	dc.l	0			; SporeBomber down
	dc.l	Sap_Player_Energy	;Spore Fragment
	dc.l	Sap_Player_Energy
	dc.l	0			;special statue
	dc.l	0			;exploding pig generator
	dc.l	Sap_Player_Energy	;exploding pig
	dc.l	0			;counter gen object
	dc.l	0			;fly 
	dc.l	0			;fly 2
	dc.l	Sap_Player_Energy	;spider
	dc.l	Sap_Player_Energy	;spider missile
	dc.l	0			;fly 3 
	dc.l	0			;fly 4
	dc.l	0			;red flip flower
	dc.l	0
				
Alien_Out_Call_Table
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Added_Wasp_Off_Screen	;wasp
	dc.l	0
	dc.l	0
	dc.l	Added_Pig_Off_Screen
	dc.l	Added_Pig_off_Screen	;pig out of cave
	dc.l	0			;pig generator
	dc.l	0			;pig generator
	dc.l	0			;pig generator
	dc.l	0			;pig generator
	dc.l	0			;pig generator
	dc.l	0			;pig gen no skull
	dc.l	0			;maggot
	dc.l	0			;maggot
	dc.l	0			;maggot
	dc.l	0			;maggot generator
	dc.l	Added_Maggot_Off_Screen	;added maggot
	dc.l	0			;generator
	dc.l	0			;key chest
	dc.l	0			;eol key
	dc.l	0			;gold coin
	dc.l	0			;silver coin
	dc.l	0			;gold coins
	dc.l	0			;silver coins
	dc.l	0
	dc.l	0			;pig guard
	dc.l	0			;small potion
	dc.l	0			;blue butterfly
	dc.l	0			;torch flame
	dc.l	0			;pig no shoot	
	dc.l	0			;Counter maggot
	dc.l	0			;speed pig
	dc.l	0			;Spore bomber right
	dc.l	0			;Spore bomber left
	dc.l	0			;Spore bomber up
	dc.l	0			;Spore bomber down
	dc.l	0			;Spore fragment
	dc.l	0			;Bush
	dc.l	0			;Statue head
	dc.l	0			;exploding pig gen
	dc.l	0			;exploding pig
	dc.l	0			;counter gen
	dc.l	0			;fly
	dc.l	0			;fly 2
	dc.l	0			;spider
	dc.l	0			;spider missile
	dc.l	0			;fly 3
	dc.l	0			;fly 4
	dc.l	0			;red flip flower
	dc.l	0			;chain gen
	
*---Alien info structure

	rsreset
	
alien_blit_size		rs.w	1
alien_mod		rs.w	1
alien_number_frames	rs.w	1
alien_frame_rate	rs.w	1
alien_graphics		rs.l	1
alien_mask		rs.l	1
alien_x_size		rs.w	1
alien_y_size		rs.w	1
alien_plane_size	rs.w	1	
alien_frame_size	rs.w	1
alien_x_words		rs.w	1
alien_pattern_ptr	rs.l	1	
alien_dead_pattern	rs.l	1
alien_hit_pattern	rs.l	1
alien_hit_count		rs.w	1
alien_type_flags	rs.b	1
alien_type_number	rs.b	1
alien_info_struct_size	rs.w	1

	
*------Alien type flags

ALIEN_NO_COLLISION	EQU	0
ALIEN_NO_COLLISION_SET	EQU	1	

PLAYER_NO_COLLISION	EQU	1
PLAYER_NO_COLLISION_SET	EQU	2

ALIEN_PRI		EQU	2
ALIEN_PRI_SET		EQU	4

OFF_SCREEN_ALIEN	EQU	3
OFF_SCREEN_SET		EQU	8	

DIRECTION_ALIEN		EQU	4
DIRECTION_ALIEN_SET	EQU	16

ATTACHED_ALIEN		EQU	5
ATTACH_SET		EQU	32

HIT_PATTERN		EQU	6
HIT_PATTERN_SET		EQU	64

ONE_HIT			EQU	7
ONE_HIT_SET		EQU	128

NUM_PLANES	EQU	4


Smoke
	dc.w	12<<6+2
	dc.w	BPR-4
	dc.w	8		;number of frames
	dc.w	1		;frame rate
	dc.l	smoke_graphics
	dc.l	smoke_graphics+(12*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	12		;ysize
	dc.w	(12*2)*8	;plane size
	dc.w	(12*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	smoke_pattern	;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Crosshair_Object
	dc.w	13<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	1		;frame rate
	dc.l	Crosshair_graphics
	dc.l	Crosshair_graphics+(13*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	13		;ysize
	dc.w	(13*2)	;plane size
	dc.w	(13*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	die_pattern	;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


			
Grenade_Explosion_Object
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
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Dome_Explosion_Object
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
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	
Quick_Explosion_Object
	dc.w	27<<6+3
	dc.w	BPR-6
	dc.w	8		;number of frames
	dc.w	1	;frame rate
	dc.l	Grenade_Explosion_Graphics
	dc.l	Grenade_Explosion_Graphics+(27*4*9)*NUM_PLANES
	dc.w	27		;xsize
	dc.w	27		;ysize
	dc.w	(27*4)*9	;plane size
	dc.w	(27*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	Quick_Explo_Pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number
	

		
small_bullet_explosion
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	7		;six frames
	dc.w	1		;update anim frame every 2 frames
	dc.l	small_explo
	dc.l	small_explo+((8*2)*7)*NUM_PLANES
	dc.w	8		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*7	;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	small_explosion_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

	


*------------------------Bonus Objects--------------------

BONUS_HEIGHT	EQU	14


Extra_Energy
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Energy_Graphics
	dc.l	Energy_Graphics+(15*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	key_chest_pattern	;does not go anywhere
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Extra_Energy_Pickup
	
Small_Potion_Object
	dc.w	12<<6+2
	dc.w	BPR-4
	dc.w	1		
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Small_Energy_Graphics
	dc.l	Small_Energy_Graphics+(12*2)*NUM_PLANES
	dc.w	13		;xsize
	dc.w	12		;ysize
	dc.w	12*2		;plane size
	dc.w	12*2		;frame size
	dc.w	2		;alien x words
	dc.l	key_chest_pattern	;does not go anywhere
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Small_Potion
	

Extra_Life
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Extra_Life_Graphics
	dc.l	Extra_Life_Graphics+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	key_chest_pattern	;does not go anywhere
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Extra_Life_Pickup


Grenade_Object
Home_Object
Rocket_Object
Double_Object
Standard_Object
Triple_Object
Weapon_Capsule_Object_Standard

Weapon_Capsule_Object_Extra


Weapon_Capsule_Object_Grenade
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_Pack_Graphics
	dc.l	Grenade_Pack_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	key_chest_pattern	;does not go anywhere
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Weapon_Capsule_Grenade

Weapon_Capsule_Object_Missile
	dc.w	21<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Missile_Pack_Graphics
	dc.l	Missile_Pack_Graphics+(21*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	21		;ysize
	dc.w	21*2		;plane size
	dc.w	21*2		;frame size
	dc.w	2		;alien x words
	dc.l	missile_pack_pattern	;boosts up 4 pix
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Weapon_Capsule_Missile

Missile_pack_pattern
	dc.w 0,-4
	dc.w 0,0
	dc.w OBJECT_DONT_GO_ANYWHERE

Grenade_Up
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Up_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	0

Grenade_Down
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Down_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	4

Grenade_Left
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Left_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	6	



Grenade_Up_Left
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Up_Left_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	7


Grenade_Down_Left
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Down_Left_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	5


Grenade_Right
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Right_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	2


Grenade_Up_Right
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Up_Right_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	1

	
Grenade_Down_Right
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_graphics
	dc.l	Grenade_Graphics+(15*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2*4		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Grenade_Down_Right_Pat
	dc.l	Grenade_Die
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+ALIEN_PRI_SET+OFF_SCREEN_SET
	dc.b	3



Grenade_Shadow
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;has got four but will set in pattern
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Grenade_Shadow_graphics
	dc.l	Grenade_Shadow_Graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2*4		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Die_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

GRENADE_SPEED	EQU	5

Grenade_Die	
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Grenade
	dc.w	OBJECT_KILL,0,0

Grenade_Up_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	0,-GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART
		

Grenade_Down_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	0,GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART


Grenade_left_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	-GRENADE_SPEED,0
		dc.w	OBJECT_PATTERN_RESTART

	
Grenade_Right_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	GRENADE_SPEED,0
	dc.w	OBJECT_PATTERN_RESTART



Grenade_Up_Left_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	-GRENADE_SPEED,-GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART


Grenade_Down_Left_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	-GRENADE_SPEED,GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART


Grenade_Down_Right_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	GRENADE_SPEED,GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART

	
Grenade_Up_Right_Pat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Grenade_Update
	dc.w	GRENADE_SPEED,-GRENADE_SPEED
	dc.w	OBJECT_PATTERN_RESTART





*------------------------Patterns------------------

instant_die
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


boring_pattern
	dc.w	0,1,0,2,0,3,0,5
	dc.w	0,5,0,3,0,2,0,1
	dc.w	0,-1,0,-2,0,-3,0,-5
	dc.w	0,-5,0,-3,0,-2,0,-1
	dc.w	OBJECT_PATTERN_RESTART
	
smoke_pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0
	
splash_pattern	
	
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
	
	
dome_explosion_pattern	
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


	
Weapon_Bonus_Pattern
	dc.w	0,0,0,1,0,1,0,2,0,3,0,3
	dc.w	0,3,0,3,0,2,0,1,0,1,0,0,0,-1
	dc.w	0,-1,0,-2,0,-3,0,-3
	dc.w	0,-3,0,-3,0,-2,0,-1,0,-1
	dc.w	OBJECT_PATTERN_RESTART



	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

	
Die_Pattern
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0	
	
dome_death
	dc.w	OBJECT_ADD
	dc.w	0,0
	dc.w	Dome_Explosion
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL,0,0	

Gun_Turret_death
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
	dc.w	OBJECT_KILL,0,0	
	
	
	
Block_Chain_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	1		;so will never animate
	dc.l	Block_Death_Graphics
	dc.l	Block_Death_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Block_Chain_Die
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Block_Cover_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	1		;so will never animate
	dc.l	Block_Blank_Graphics
	dc.l	Block_Blank_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Block_Cover_Die
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Switch_Cover_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	1		;so will never animate
	dc.l	Switch_Down_Graphics
	dc.l	Switch_Down_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Block_Cover_Die
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
Switch_Blue_Cover_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	1		;so will never animate
	dc.l	Switch_Blue_Down_Graphics
	dc.l	Switch_Blue_Down_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	16*2		;plane size
	dc.w	16*2		;frame size
	dc.w	2		;alien x words
	dc.l	Block_Cover_Die
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	


Block_Chain_Explosion
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	10		;
	dc.w	1		;
	dc.l	Block_Explosion_Graphics
	dc.l	Block_Explosion_Graphics+(18*2*10)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*10		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Block_Explo_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


Block_Explo_Pattern
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

Block_Cover_Die
	dc.w	0,0,0,0
	dc.w	OBJECT_KILL,0,0
	
Block_Chain_Die
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Small_Explosion_Object
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Explo
	dc.w	OBJECT_KILL,0,0
	
	
small_explosion_object
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
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
	
Hostage_Object
	dc.w	29<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Hostage_Graphics
	dc.l	Hostage_Graphics+(29*4)*5*NUM_PLANES
	dc.w	32		;xsize
	dc.w	29		;ysize
	dc.w	29*4*5		;plane size
	dc.w	29*4		;frame size
	dc.w	3		;alien x words
	dc.l	Hostage_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Hostage
	
Add_Hostage_Object
	dc.w	29<<6+3
	dc.w	BPR-6
	dc.w	1		;
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Hostage_Graphics
	dc.l	Hostage_Graphics+(29*4)*5*NUM_PLANES
	dc.w	32		;xsize
	dc.w	29		;ysize
	dc.w	29*4*5		;plane size
	dc.w	29*4		;frame size
	dc.w	3		;alien x words
	dc.l	Hostage_Repeat
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Hostage
	
	
Wave_Hostage_Object
	dc.w	32<<6+3
	dc.w	BPR-6
	dc.w	2		;
	dc.w	3
	dc.l	PrisonerWave_Graphics
	dc.l	PrisonerWave_Graphics+(32*4)*2*NUM_PLANES
	dc.w	32		;xsize
	dc.w	32		;ysize
	dc.w	32*4*2		;plane size
	dc.w	32*4		;frame size
	dc.w	3		;alien x words
	dc.l	Hostage_Wave_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Hostage

HOSTAGE_WAVE_DIST	EQU	80


Hostage_Wave_Pattern
	dc.w	0,0
	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	HOSTAGE_WAVE_DIST+5
	dc.l	Dont_Change_Hostage
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	-2,3
	dc.l	Add_Hostage_Object
	dc.w	OBJECT_KILL
	dc.w	0,0
Dont_Change_Hostage
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

Hostage_Pattern
	dc.w	0,4
Hostage_Repeat
	dc.w	0,0	
	dc.w	OBJECT_SET_COUNTER,40
Hostage_Repeat1	
	dc.w	0,0

	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	HOSTAGE_WAVE_DIST
	dc.l	Change_To_Wave
	dc.w	0,0

	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Hostage_Repeat1
	dc.w	OBJECT_FRAME_SET,1
	dc.w	0,0,0,0
	dc.w	OBJECT_FRAME_SET,2
	dc.w	OBJECT_SET_COUNTER,33
Hostage_Repeat2
	
	dc.w	0,0

	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	HOSTAGE_WAVE_DIST
	dc.l	Change_To_Wave
	dc.w	0,0

	
	dc.w	0,0

	
	dc.w	OBJECT_UNTIL
	dc.l	Hostage_Repeat2
	dc.w	OBJECT_FRAME_SET,3
	dc.w	0,0,0,0
	dc.w	OBJECT_FRAME_SET,4
	dc.w	OBJECT_SET_COUNTER,33
Hostage_Repeat3
	dc.w	0,0

	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	HOSTAGE_WAVE_DIST
	dc.l	Change_To_Wave
	dc.w	0,0

	
	dc.w	0,0

	dc.w	OBJECT_UNTIL
	dc.l	Hostage_Repeat3	
	dc.w	OBJECT_FRAME_SET,3
	dc.w	0,0,0,0
	dc.w	OBJECT_FRAME_SET,2
	dc.w	OBJECT_SET_COUNTER,33
Hostage_Repeat4
	dc.w	0,0

	dc.w	OBJECT_CHECK_DISTANCE
	dc.w	HOSTAGE_WAVE_DIST
	dc.l	Change_To_Wave
	dc.w	0,0

	
	dc.w	0,0

	dc.w	OBJECT_UNTIL
	dc.l	Hostage_Repeat4
	dc.w	OBJECT_FRAME_SET,1
	dc.w	0,0,0,0
	dc.w	OBJECT_FRAME_SET,0
	dc.w	OBJECT_SET_PAT
	dc.l	Hostage_Repeat
Change_To_Wave
	dc.w	OBJECT_SIMPLE_ADD_TRANSFORM
	dc.w	2,-3
	dc.l	Wave_Hostage_Object
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_OverHere
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Block_Split_Object_1
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	7		;
	dc.w	0
	dc.l	Block_Fragment_Graphics
	dc.l	Block_Fragment_Graphics+(7*2*7)*NUM_PLANES
	dc.w	7		;xsize
	dc.w	7		;ysize
	dc.w	7*2*7		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Split_Bounce_Pattern1
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0
	

Split_Bounce_Pattern1	
	dc.w	2,-5
	dc.w	2,-3
	dc.w	2,-2
	dc.w	2,-2
	dc.w	2,-1
	dc.w	2,0
	dc.w	2,1
	dc.w	2,2
	dc.w	2,2
	dc.w	2,4
	dc.w	2,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	2,-4
	dc.w	2,-2
	dc.w	2,-1
	dc.w	2,-1
	dc.w	2,0
	dc.w	2,1
	dc.w	2,1
	dc.w	2,3
	dc.w	2,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	2,-2
	dc.w	2,-1
	dc.w	2,1
	dc.w	2,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4
	dc.w	OBJECT_KILL,0,0
	

Block_Split_Object_2
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	7		;
	dc.w	0
	dc.l	Block_Fragment_Graphics
	dc.l	Block_Fragment_Graphics+(7*2*7)*NUM_PLANES
	dc.w	7		;xsize
	dc.w	7		;ysize
	dc.w	7*2*7		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Split_Bounce_Pattern2
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Split_Bounce_Pattern2	
	dc.w	-2,-5
	dc.w	-2,-3
	dc.w	-2,-2
	dc.w	-2,-1
	dc.w	-2,0
	dc.w	-2,1
	dc.w	-2,2
	dc.w	-2,4
	dc.w	-2,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	-2,-3
	dc.w	-2,-2
	dc.w	-2,-1
	dc.w	-2,0
	dc.w	-2,1
	dc.w	-2,2
	dc.w	-2,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	-2,-2
	dc.w	-2,-1
	dc.w	-2,1
	dc.w	-2,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4
	dc.w	OBJECT_KILL,0,0


Block_Split_Object_3
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	7		;
	dc.w	0
	dc.l	Block_Fragment_Graphics
	dc.l	Block_Fragment_Graphics+(7*2*7)*NUM_PLANES
	dc.w	7		;xsize
	dc.w	7		;ysize
	dc.w	7*2*7		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Split_Bounce_Pattern3
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Split_Bounce_Pattern3
	dc.w	-2,-5+1
	dc.w	-2,-3+1
	dc.w	-1,-2+1
	dc.w	-1,0+1
	dc.w	-1,2+1
	dc.w	-2,4+1
	dc.w	-1,4+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	-2,-3+1
	dc.w	-1,-2+1
	dc.w	-2,-1+1
	dc.w	-1,0+1
	dc.w	-2,1+1
	dc.w	-1,2+1
	dc.w	-2,3+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	-1,-2+1
	dc.w	-2,-1+1
	dc.w	-1,-1+1
	dc.w	-2,1+1
	dc.w	-1,1+1
	dc.w	-2,2+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4
	dc.w	OBJECT_KILL,0,0


Block_Split_Object_4
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	7		;
	dc.w	0
	dc.l	Block_Fragment_Graphics
	dc.l	Block_Fragment_Graphics+(7*2*7)*NUM_PLANES
	dc.w	7		;xsize
	dc.w	7		;ysize
	dc.w	7*2*7		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Split_Bounce_Pattern4
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Split_Bounce_Pattern4
	dc.w	2,-5+1
	dc.w	1,-3+1
	dc.w	2,-2+1
	dc.w	1,-1+1
	dc.w	2,0+1
	dc.w	1,1+1
	dc.w	2,2+1
	dc.w	1,4+1
	dc.w	2,4+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	1,-3+1
	dc.w	2,-2+1
	dc.w	1,-1+1
	dc.w	2,0+1
	dc.w	1,1+1
	dc.w	2,2+1
	dc.w	1,3+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	2,-2+1
	dc.w	1,-1+1
	dc.w	2,1+1
	dc.w	1,2+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4
	dc.w	OBJECT_KILL,0,0


Block_Split_Pattern1
	dc.w	-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,-3,-2,-2
	dc.w	OBJECT_KILL,0,0

Block_Split_Pattern2
	dc.w	4,-4,4,-4,4,-4,4,-4,4,-4,4,-4,4,-4,3,-3,2,-2
	dc.w	OBJECT_KILL,0,0

Block_Split_Pattern3
	dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,2,2
	dc.w	OBJECT_KILL,0,0

Block_Split_Pattern4
	dc.w	-4,4,-4,4,-4,4,-4,4,-4,4,-4,4,-4,4,-3,3,-2,2
	dc.w	OBJECT_KILL,0,0


*straight down
Block_Split_Pattern5
	dc.w	0,5,0,5,0,5,0,5,0,5,0,5,0,5,0,4,0,3
	dc.w	OBJECT_KILL,0,0

*right
Block_Split_Pattern6
	dc.w	5,0,5,0,5,0,5,0,5,0,5,0,5,0,4,0,3,0
	dc.w	OBJECT_KILL,0,0
	
Block_Split_Pattern7
	dc.w	-5,0,-5,0,-5,0,-5,0,-5,0,-5,0,-5,0,-4,0,-3,0
	dc.w	OBJECT_KILL,0,0
	
	
	

Explo_Split_Object_1
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
	dc.l	Block_Split_Pattern1	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_2
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
	dc.l	Block_Split_Pattern2	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_3
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
	dc.l	Block_Split_Pattern3	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_4
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
	dc.l	Block_Split_Pattern4	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_5
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
	dc.l	Block_Split_Pattern5	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_6
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
	dc.l	Block_Split_Pattern6	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

Explo_Split_Object_7
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
	dc.l	Block_Split_Pattern7	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number


Small_Explo_Split1
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	10		;
	dc.w	1		;
	dc.l	Block_Explosion_Graphics
	dc.l	Block_Explosion_Graphics+(18*2*10)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*10		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Small_Split_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Small_Explo_Split2
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	10	;
	dc.w	1		;
	dc.l	Block_Explosion_Graphics
	dc.l	Block_Explosion_Graphics+(18*2*10)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*10		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Small_Split_Pattern2
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Small_Explo_Split3
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	10		;
	dc.w	1		;
	dc.l	Block_Explosion_Graphics
	dc.l	Block_Explosion_Graphics+(18*2*10)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*10		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Small_Split_Pattern3
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


Small_Split_Pattern
	dc.w	4,4,4,4,4,4,4,4,4,4,3,3,2,2
	dc.w	OBJECT_KILL,0,0

Small_Split_Pattern2
	dc.w	-4,4,-4,4,-4,4,-4,4,-4,4,-3,3,-2,2
	dc.w	OBJECT_KILL,0,0


Small_Split_Pattern3
	dc.w	0,5,0,5,0,5,0,5,0,5,0,4,0,3
	dc.w	OBJECT_KILL,0,0



Alien_Bullet_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Alien_Update_Bullet	
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART

	
Quick_Explo_Pattern
	dc.w	OBJECT_FRAME_SET,2,0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL
	dc.w	0,0


redjumpflower_object
	dc.w	13<<6+2
	dc.w	BPR-4
	dc.w	8		
	dc.w	2		;update anim frame every 2 frames
	dc.l	redflower_graphics
	dc.l	redflower_graphics+((13*2)*8)*NUM_PLANES
	dc.w	13		;xsize
	dc.w	13		;ysize
	dc.w	(13*2)*8	;plane size	- so can get to next alien
	dc.w	(13*2)		;frame size
	dc.w	2		;alien x words
	dc.l	flower_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

bluejumpflower_object
	dc.w	13<<6+2
	dc.w	BPR-4
	dc.w	8		
	dc.w	2		;update anim frame every 2 frames
	dc.l	blueflower_graphics
	dc.l	blueflower_graphics+((13*2)*8)*NUM_PLANES
	dc.w	13		;xsize
	dc.w	13		;ysize
	dc.w	(13*2)*8	;plane size	- so can get to next alien
	dc.w	(13*2)		;frame size
	dc.w	2		;alien x words
	dc.l	flower_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


flower_pattern

	dc.w	OBJECT_EXECUTE_CODE
	dc.l	delay_animation
flower_wait	
	dc.w	0,0		;flower do nothing
	dc.w	OBJECT_UNTIL
	dc.l	flower_wait


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
	dc.w	OBJECT_PATTERN_RESTART
	dc.w	0,0
	
	
Fire_Key_Object
	dc.w	33<<6+2
	dc.w	BPR-4
	dc.w	8		;number of frames
	dc.w	2		;frame rate
	dc.l	Fire_Key_Graphics
	dc.l	Fire_Key_Graphics+(33*2*8)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	33		;ysize
	dc.w	(33*2)*8	;plane size
	dc.w	(33*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	fire_pattern	;pattern pointer
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+ATTACH_SET+ALIEN_PRI_SET		;off screen not set - so keeps going
	dc.b	Fire_key	;alien type number
	
fire_pattern
	dc.w	OBJECT_SIMPLE_ADD_CONNECT
	dc.w	0,152
	dc.l	Key_Shadow

	dc.w	0,3
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien
	dc.w	0,3
	dc.w	0,4
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien	
	dc.w	0,4
	dc.w	0,5
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien	
	dc.w	0,6
	dc.w	0,6
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien	
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien	
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	CoinDiss_Alien

	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling

	
	dc.w	0,-8
	dc.w	0,-6
	dc.w	0,-4
	dc.w	0,-4
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,1
	dc.w	0,2
	dc.w	0,2
	dc.w	0,3
	dc.w	0,3
	dc.w	0,3
	dc.w	0,4
	dc.w	0,5
	dc.w	0,5
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2

	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,2
	dc.w	0,2
	dc.w	0,2
	dc.w	0,1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE

Key_Shadow
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
	dc.l	Key_Shad_Pattern
	dc.l	0
	dc.l	0
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET	
	dc.b	0

Key_Shad_Pattern
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE
		
		
		
*--                 BONUS SCORES            --*

SCORE_HEIGHT	EQU	7
SCORE_NUMBER	EQU	16

Score10_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score20_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*1
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*1
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score50_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*2
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*2
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0



Score100_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*3
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*3
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score200_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*4
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*4
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score300_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*5
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*5
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score400_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*6
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*6
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score500_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*7
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*7
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score600_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*8
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*8
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score700_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*9
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*9
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score800_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*10
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*10
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score900_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*11
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*11
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score1000_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*12
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*12
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0
		
Score2000_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*13
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*13
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score4000_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*14
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*14
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Score8000_Object
	dc.w	SCORE_HEIGHT<<6+2
	dc.w	BPR-4
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Bonus_Graphics+(SCORE_HEIGHT*2)*15
	dc.l	Bonus_Graphics+((SCORE_HEIGHT*2)*SCORE_NUMBER*NUM_PLANES)+(SCORE_HEIGHT*2)*15
	dc.w	16		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*2)*SCORE_NUMBER	;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0
		
Thanks_Object
	dc.w	SCORE_HEIGHT<<6+3
	dc.w	BPR-6
	dc.w	1
	dc.w	DONT_ANIMATE		;update anim frame every 2 frames
	dc.l	Thanks_Graphics
	dc.l	Thanks_Graphics+(SCORE_HEIGHT*4)*NUM_PLANES
	dc.w	32		;xsize
	dc.w	SCORE_HEIGHT		;ysize
	dc.w	(SCORE_HEIGHT*4)		;plane size	- so can get to next alien
	dc.w	(SCORE_HEIGHT*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Bonus_Score_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0
		
Bonus_Score_Pattern
	dc.w	0,-5
	dc.w	0,-4
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-3
	dc.w	0,-3
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL
	dc.w	0,0	
	
Pot_Gold_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Coin_Graphics
	dc.l	Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Pot_Coin_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Coin

Pot_Silver_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Pot_Coin_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Silver_Coin


Pot_Coin_Pattern
	dc.w	OBJECT_SET_COUNTER
	dc.w	50
Pot_Coin_Wait	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Pot_Coin_Wait
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,-1
	dc.l	CoinDiss_Alien
	
	dc.w	OBJECT_KILL
	dc.w	0,0

	

Gold_Wall_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Coin_Graphics
	dc.l	Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Wall_Coin_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Coin

Silver_Wall_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Wall_Coin_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Silver_Coin

Wall_Potion_Object
	dc.w	12<<6+2
	dc.w	BPR-4
	dc.w	1		
	dc.w	DONT_ANIMATE		;so will never animate
	dc.l	Small_Energy_Graphics
	dc.l	Small_Energy_Graphics+(12*2)*NUM_PLANES
	dc.w	13		;xsize
	dc.w	12		;ysize
	dc.w	12*2		;plane size
	dc.w	12*2		;frame size
	dc.w	2		;alien x words
	dc.l	Wall_Coin_Pattern	;does not go anywhere
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Small_Potion

Silver_Wall_CoinLeft_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Wall_Coin_Pattern_Left
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Silver_Coin

Silver_Wall_CoinRight_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	Wall_Coin_Pattern_Right
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Silver_Coin


Wall_Coin_Pattern
	dc.w	0,-5+3
	dc.w	0,-3+3
	dc.w	0,-2+3
	dc.w	0,0+2
	dc.w	0,2+2
	dc.w	0,4+2
	dc.w	0,4+2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	0,-3+2
	dc.w	0,-2+2
	dc.w	0,-1+2
	dc.w	0,0+1
	dc.w	0,1+1
	dc.w	0,2+1
	dc.w	0,3+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	0,-2+0
	dc.w	0,-1+1
	dc.w	0,-1
	dc.w	0,1+1
	dc.w	0,1
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4
	
Wall_Patt_Wait	
	dc.w	OBJECT_SET_COUNTER
	dc.w	50
w_coin_wait	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	w_coin_wait		
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,-1
	dc.l	CoinDiss_Alien
	
	dc.w	OBJECT_KILL
	dc.w	0,0

Wall_Coin_Pattern_Left
	dc.w	-1,-5+3
	dc.w	0,-3+3
	dc.w	-1,-2+3
	dc.w	0,0+2
	dc.w	-1,2+2
	dc.w	0,4+2
	dc.w	-1,4+2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	0,-3+2
	dc.w	-1,-2+2
	dc.w	0,-1+2
	dc.w	-1,0+1
	dc.w	0,1+1
	dc.w	-1,2+1
	dc.w	0,3+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	-1,-2+0
	dc.w	0,-1+1
	dc.w	-1,-1
	dc.w	0,1+1
	dc.w	-1,1
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4

	dc.w	OBJECT_SET_PAT
	dc.l	Wall_Patt_Wait		

Wall_Coin_Pattern_Right
	dc.w	1,-5+3
	dc.w	0,-3+3
	dc.w	1,-2+3
	dc.w	0,0+2
	dc.w	1,2+2
	dc.w	0,4+2
	dc.w	1,4+2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	0,-3+2
	dc.w	1,-2+2
	dc.w	0,-1+2
	dc.w	1,0+1
	dc.w	0,1+1
	dc.w	1,2+1
	dc.w	0,3+1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV3
	dc.w	1,-2+0
	dc.w	0,-1+1
	dc.w	1,-1
	dc.w	0,1+1
	dc.w	1,1
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV4

	dc.w	OBJECT_SET_PAT
	dc.l	Wall_Patt_Wait		
	

Bonus_Coins_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	drop_coins_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	Silver_Coin

drop_coins_pattern
	dc.w	0,0
	dc.w	0,1
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	8,0
	dc.l	Bonus_Coin_Object
	dc.w	0,2
	dc.w	0,3
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	4,4
	dc.l	Bonus_Coin_Object
	dc.w	0,4
	dc.w	0,5
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling
	dc.w	0,-5
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv2
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,1
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv4
	dc.w	0,-1
	dc.w	0,1
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Pot_Silver_Coin_Object
	dc.w	OBJECT_KILL,0,0

Bonus_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	coin_drop_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	Silver_Coin

coin_drop_pattern
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	0,5
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling
	dc.w	0,-5
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv2
	dc.w	0,-4
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	0,1
	dc.w	0,2
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv4
	dc.w	0,-1
	dc.w	0,1
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Pot_Silver_Coin_Object
	dc.w	OBJECT_KILL,0,0

	
Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Coin_Graphics
	dc.l	Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	coin_bounce
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Coin
	
Silver_Coin_Object
	dc.w	8<<6+2
	dc.w	BPR-4
	dc.w	6
	dc.w	2		;update anim frame every 2 frames
	dc.l	Silver_Coin_Graphics
	dc.l	Silver_Coin_Graphics+(8*2)*6*NUM_PLANES
	dc.w	9		;xsize
	dc.w	8		;ysize
	dc.w	(8*2)*6		;plane size	- so can get to next alien
	dc.w	(8*2)		;frame size
	dc.w	2		;alien x words
	dc.l	coin_bounce
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Silver_Coin
	
	

coin_bounce
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin
	
	dc.w	0,-4
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	
	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,4
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin
	
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling

	dc.w	0,-3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv2



	dc.w	0,-2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin
	
	
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv3

	

	dc.w	0,-1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin

	dc.w	0,1
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	move_coin
	
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv4


	
	dc.w	OBJECT_SET_COUNTER
	dc.w	100
coin_wait	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	coin_wait		
	
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-4,-1
	dc.l	CoinDiss_Alien
	
	dc.w	OBJECT_KILL
	dc.w	0,0

Key_Chest_Object	
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	key_chest_pattern	;pattern pointer
	dc.l	key_chest_die
	dc.l	0
	dc.w	4
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0	;alien type number

key_chest_pattern
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE

Chest_Key_Object
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Standard_Key_Graphics
	dc.l	Standard_Key_Graphics+15*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	chest_key_pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Standard_Key


chest_key_pattern

	dc.w	OBJECT_PUT_IN_MAP
	dc.w	0,-5,0,-5,0,-4,0,-3,0,-3,0,-2,0,-1,0,-1
	dc.w	0,1,0,2
	dc.w	0,3,0,4
	dc.w	0,3,0,3
	dc.w	0,4
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Pling

	dc.w	0,-3,0,-2
	dc.w	0,-2,0,-1,0,-1
	dc.w	0,-1,0,0
	
	
	
	dc.w	0,1,0,0
	dc.w	0,1,0,1
	dc.w	0,1,0,2
	dc.w	0,3
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_PlingV2
	dc.w	0,0
	
	

	dc.w	0,-1,0,0
	dc.w	0,-1
	dc.w	0,0
	

	
	dc.w	0,1,0,0
	dc.w	0,0,0,1
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv3

	dc.w	0,-1,0,0

	dc.w	0,0,0,0
	dc.w	0,1
		
	dc.w	OBJECT_SOUND_EFFECT_2
	dc.w	Sound_Plingv4
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE



	
key_chest_die
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-3,1
	dc.l	Pig_Explosion
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	5,-0
	dc.l	Chest_Key_Object
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Remove_Blocks_On_Chest
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL		
	dc.w	0,0
	
		
	
Chest_Object	
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern	
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number
	
Chest_Object4	
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0		;alien type number
	
Chest_Object3
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern
	dc.w	4
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Chest_Object2
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern
	dc.w	3
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Chest_Object1
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Chest_Object0
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	chest_hit_pattern	
	dc.w	1
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

	
		
	
Silver_Chest_Object	
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	6
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number
	
Silver_Chest_Object4	
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	5
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number
	
Silver_Chest_Object3
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	4
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Silver_Chest_Object2
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	3
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Silver_Chest_Object1
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	2
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number

Silver_Chest_Object0
	dc.w	13<<6+3
	dc.w	BPR-6
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Chest_Graphics
	dc.l	Chest_Graphics+(13*4)*NUM_PLANES
	dc.w	18		;xsize
	dc.w	13		;ysize
	dc.w	(13*4)		;plane size
	dc.w	(13*4)    	;frame size	
	dc.w	3		;alien x words
	dc.l	silver_chest_pattern	;pattern pointer
	dc.l	chest_die
	dc.l	silver_chest_hit_pattern
	dc.w	1
	dc.b	PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+HIT_PATTERN_SET+ONE_HIT_SET
	dc.b	0	;alien type number


	
	
chest_die
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-3,1
	dc.l	Pig_Explosion
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Remove_Blocks_On_Chest
	dc.w	OBJECT_SOUND_EFFECT_3
	dc.w	Sound_Crap
	dc.w	OBJECT_KILL		
	dc.w	0,0
	
chest_pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART
	
chest_hit_pattern
	
		
			
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,-3


	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,-1


	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,0

	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,3

	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,1

	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_coin	
	dc.w	0,0
	
	dc.w	OBJECT_HIT_PATTERN_RESTART

	
silver_chest_pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,0
	dc.w	OBJECT_PATTERN_RESTART
	
silver_chest_hit_pattern
	
		
			
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,-3


	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,-1


	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,0

	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,3

	
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,1

	dc.w	OBJECT_EXECUTE_CODE
	dc.l	test_chuck_out_silver_coin	
	dc.w	0,0
	
	dc.w	OBJECT_HIT_PATTERN_RESTART
	
	
	
Generic_Splash_Object
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
	dc.l	Generic_Splash_Pat
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Generic_Splash_Pat
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

	dc.w	OBJECT_KILL
	dc.w	0,0
	
	
Shrapnel_Alien
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	0		;
	dc.l	Shrapnel_Graphics
	dc.l	Shrapnel_Graphics+7*2*6*NUM_PLANES
	dc.w	6		;xsize
	dc.w	7		;ysize
	dc.w	7*2*6		;plane size
	dc.w	7*2		;frame size
	dc.w	2		;alien x words
	dc.l	Shrapnel_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Shrapnel_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Up_Shrap_Pat
Shrapnel_Repeat
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Shrap
	dc.w	0,2
	dc.w	OBJECT_UNTIL
	dc.l	Shrapnel_Repeat
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Shrapnel_Pattern2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Up_Shrap_Pat
Shrapnel_Repeat2
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Shrap
	dc.w	-2,2
	dc.w	OBJECT_UNTIL
	dc.l	Shrapnel_Repeat2
	dc.w	OBJECT_KILL
	dc.w	0,0
	
Shrapnel_Pattern3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Set_Up_Shrap_Pat
Shrapnel_Repeat3
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Update_Shrap
	dc.w	2,2
	dc.w	OBJECT_UNTIL
	dc.l	Shrapnel_Repeat3
	dc.w	OBJECT_KILL
	dc.w	0,0

	

Shrap_Patt	
	dc.w	1
	dc.w	2
	dc.w	3
	dc.w	4
	dc.w	5
	dc.w	Sound_Pling
	dc.w	-5
	dc.w	-3
	dc.w	-2
	dc.w	-1
	dc.w	0
	dc.w	1
	dc.w	2
	dc.w	4
	dc.w	4
	dc.w	Sound_PlingV2
	dc.w	-3
	dc.w	-2
	dc.w	-1
	dc.w	0
	dc.w	1
	dc.w	2
	dc.w	3
	dc.w	Sound_PlingV3
	dc.w	-2
	dc.w	-1
	dc.w	1
	dc.w	2
	dc.w	Sound_PlingV4
	
Shrap_Pat_Size	equ	 ((*-Shrap_Patt)/2)-4		;for sfx
	
Appear_Object
	dc.w	24<<6+3
	dc.w	BPR-6
	dc.w	10
	dc.w	2		;update anim frame every 2 frames
	dc.l	Appear_Graphics
	dc.l	Appear_Graphics+(24*4)*10*NUM_PLANES
	dc.w	32		;xsize
	dc.w	24		;ysize
	dc.w	(24*4)*10		;plane size	- so can get to next alien
	dc.w	(24*4)		;frame size
	dc.w	3		;alien x words
	dc.l	Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET
	dc.b	0

Appear_Pattern
	dc.w	OBJECT_SET_COUNTER,20
Appear_Wait	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Appear_Wait
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Start_Explosions
	dc.w	OBJECT_KILL,0,0

Fast_Appear_Object
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
	dc.l	Fast_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	2
	dc.b	OFF_SCREEN_SET+ALIEN_PRI_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Fast_Appear_Pattern
	dc.w	0,0,0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0,0,0
	dc.w	OBJECT_KILL,0,0

	
CoinDiss_Alien
	dc.w	10<<6+2
	dc.w	BPR-4
	dc.w	11		;
	dc.w	1		;
	dc.l	Coin_Dissapear_Graphics
	dc.l	Coin_Dissapear_Graphics+10*2*11*NUM_PLANES
	dc.w	16		;xsize
	dc.w	10		;ysize
	dc.w	10*2*11		;plane size
	dc.w	10*2		;frame size
	dc.w	2		;alien x words
	dc.l	CoinDiss_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	OFF_SCREEN_SET+PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

CoinDiss_Pattern
	dc.w	OBJECT_SET_COUNTER,11
CoinDiss_Repeat	
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	CoinDiss_Repeat
	dc.w	OBJECT_KILL,0,0	
	
Generic_Block_Alien
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
	dc.l	Generic_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Generic_Pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0

Jump_Fish_Appear_Object
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
	dc.l	Jump_Fish_Appear_Pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	PLAYER_NO_COLLISION_SET+ALIEN_NO_COLLISION_SET
	dc.b	0

Jump_Fish_Appear_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	FishUpBob_Alien
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0



Standard_Key_Alien
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	1		;
	dc.w	DONT_ANIMATE		;
	dc.l	Standard_Key_Graphics
	dc.l	Standard_Key_Graphics+15*2*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	15*2		;plane size
	dc.w	15*2		;frame size
	dc.w	2		;alien x words
	dc.l	Standard_Key_Pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	Standard_Key

Standard_Key_Pattern
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE	

Small_Gold_Coin
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	2		;
	dc.l	smallgold_Graphics
	dc.l	smallgold_Graphics+5*2*6*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*6		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	jewel_pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	GoldMoney1

Small_Silver_Coin
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	2		;
	dc.l	smallsilver_Graphics
	dc.l	smallsilver_Graphics+5*2*6*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	5*2*6		;plane size
	dc.w	5*2		;frame size
	dc.w	2		;alien x words
	dc.l	jewel_pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	SilverMoney1

Small_Gold_Coins
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	2		;
	dc.l	smallgoldlots_Graphics
	dc.l	smallgoldlots_Graphics+11*2*6*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	11*2*6		;plane size
	dc.w	11*2		;frame size
	dc.w	2		;alien x words
	dc.l	jewel_pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	GoldMoney2

Small_Silver_Coins
	dc.w	9<<6+2
	dc.w	BPR-4
	dc.w	6		;
	dc.w	2		;
	dc.l	smallsilverlots_Graphics
	dc.l	smallsilverlots_Graphics+9*2*6*NUM_PLANES
	dc.w	16		;xsize
	dc.w	9		;ysize
	dc.w	9*2*6		;plane size
	dc.w	9*2		;frame size
	dc.w	2		;alien x words
	dc.l	jewel_pattern
	dc.l    0
	dc.l	0
	dc.w	1
	dc.b	OFF_SCREEN_SET+ALIEN_NO_COLLISION_SET
	dc.b	SilverMoney2

jewel_pattern
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE
	
Swamp_Anim_Alien
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	4		;number of frames
	dc.w	2		;frame rate
	dc.l	Swamp_Anim_graphics
	dc.l	Swamp_Anim_graphics+(16*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)*4	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	swamp_anim_patt	;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

swamp_anim_patt
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE
	
Target_Alien
	dc.w	13<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	1		;frame rate
	dc.l	Grenade_Target_graphics
	dc.l	Grenade_Target_graphics+(13*2*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	13		;ysize
	dc.w	(13*2)*2	;plane size
	dc.w	(13*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	target_patt	;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

target_patt
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE	
	
Blue_Butterfly_Object
	dc.w	22<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	2		;frame rate
	dc.l	Blue_Butterfly_graphics
	dc.l	Blue_Butterfly_graphics+(22*2*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	22		;ysize
	dc.w	(22*2)*2	;plane size
	dc.w	(22*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Butterfly_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+ALIEN_PRI_SET
	dc.b	0
	
Butterfly_Pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Find_Random_Direction_And_Time
Butterfly_Repeat_Point
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	Butterfly_Follow_Direction
	dc.w	0,0
	dc.w	OBJECT_UNTIL
	dc.l	Butterfly_Repeat_Point
	dc.w	OBJECT_PATTERN_RESTART	
	
	
Post_Move_Up_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Down_Graphics
	dc.l	Post_Down_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_Move_Up_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Post_Move_Up_Pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_Up_Object
	dc.w	OBJECT_KILL,0,0

Post_Up_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Up_Graphics
	dc.l	Post_Up_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_Up_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Post_Up_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_RUp_Object
	dc.w	OBJECT_KILL,0,0


Post_RUp_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_RUp_Graphics
	dc.l	Post_RUp_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Burn_Up_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Burn_Up_Pattern
	dc.w	0,0
	dc.w	OBJECT_BURN_BLOCK
	dc.w	POST_UP
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0	



Post_Move_UpShad_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Down_Graphics
	dc.l	Post_Down_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_Move_UpShad_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
Post_Move_UpShad_Pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_UpShad_Object
	dc.w	OBJECT_KILL,0,0
	
Post_UpShad_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Up_Graphics
	dc.l	Post_Up_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_UpShad_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Post_UpShad_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_RUP_Shad_Object
	dc.w	OBJECT_KILL,0,0

Post_RUp_Shad_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_RUp_Graphics
	dc.l	Post_RUp_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Burn_Shad_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
Burn_Shad_Pattern
	dc.w	0,0
	dc.w	OBJECT_BURN_BLOCK
	dc.w	POST_UP_SHAD		;what a friggin palarva
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0

	
Post_Move_Down_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_RUp_Graphics
	dc.l	Post_RUp_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_Move_Down_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
Post_Move_Down_Pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_GoingDown_Object
	dc.w	OBJECT_KILL,0,0	
	
Post_GoingDown_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Up_Graphics
	dc.l	Post_Up_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_GoingDown_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0
	
Post_GoingDown_Pattern	
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Post_Down_Object
	dc.w	OBJECT_KILL,0,0	
	
Post_Down_Object
	dc.w	16<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	-1		;frame rate
	dc.l	Post_Down_Graphics
	dc.l	Post_Down_Graphics+(16*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	16		;ysize
	dc.w	(16*2)	;plane size
	dc.w	(16*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Post_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Post_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0	
	
	
Big_Rain_Drop
	dc.w	11<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Large_Rain
	dc.l	Large_Rain+(11*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	11		;ysize
	dc.w	(11*2)	;plane size
	dc.w	(11*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Big_Rain_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Big_Rain_Pattern
	dc.w	-4,4
	dc.w	-4,4
	dc.w	-5,5
	dc.w	-5,5
	dc.w	-5,5
	dc.w	-6,6
	dc.w	-7,7
	dc.w	-7,7
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,0
	dc.l	Rain_Drop_Anim	
	dc.w	OBJECT_KILL,0,0


Small_Rain_Drop
	dc.w	7<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Small_Rain
	dc.l	Small_Rain+(7*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	7		;ysize
	dc.w	(7*2)	;plane size
	dc.w	(7*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Small_Rain_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Small_Rain_Pattern
	dc.w	-5,5
	dc.w	-5,5
	dc.w	-5,5
	dc.w	-6,6
	dc.w	-7,7
	dc.w	-7,7
	dc.w	-8,8
	dc.w	-9,9
	dc.w	OBJECT_KILL,0,0


Rain_Drop_Anim
	dc.w	10<<6+2
	dc.w	BPR-4
	dc.w	4		;number of frames
	dc.w	1		;frame rate
	dc.l	Spot_Anim
	dc.l	Spot_Anim+(10*2*4)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	10		;ysize
	dc.w	(10*2*4)	;plane size
	dc.w	(10*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Rain_Drop_Anim_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Rain_Drop_Anim_Pattern
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_KILL,0,0


Snow_Flake
	dc.w	9<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Snow_Graphics
	dc.l	Snow_Graphics+(9*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	9		;ysize
	dc.w	(9*2)	;plane size
	dc.w	(9*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Snow_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Snow_Pattern
	dc.w	OBJECT_SET_COUNTER,15
Snow_Pattern_Repeat	
	dc.w	0,10
	dc.w	0,10
	dc.w	OBJECT_UNTIL
	dc.l	Snow_Pattern_Repeat
	dc.w	OBJECT_KILL,0,0

Snow_Flake2
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Snow_Graphics2
	dc.l	Snow_Graphics2+(5*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)	;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Snow_Pattern2 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Snow_Pattern2
	dc.w	OBJECT_SET_COUNTER,14
Snow_Pattern_Repeat2	
	dc.w	0,8
	dc.w	0,8
	dc.w	OBJECT_UNTIL
	dc.l	Snow_Pattern_Repeat2
	dc.w	OBJECT_KILL,0,0


Snow_Flake3
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	1		;number of frames
	dc.w	DONT_ANIMATE		;frame rate
	dc.l	Snow_Graphics2
	dc.l	Snow_Graphics2+(5*2)*NUM_PLANES
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)	;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Snow_Pattern3 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0


Snow_Pattern3
	dc.w	OBJECT_SET_COUNTER,18
Snow_Pattern_Repeat3	
	dc.w	0,6
	dc.w	0,6
	dc.w	OBJECT_UNTIL
	dc.l	Snow_Pattern_Repeat3
	dc.w	OBJECT_KILL,0,0


Fly_Object
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	2		;frame rate
	dc.l	Fly_Graphics_Table
	dc.l	Fly_Mask_Table
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)*8		;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Fly_Pattern ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+DIRECTION_ALIEN_SET
	dc.b	0
	
Fly_Object2
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	2		;frame rate
	dc.l	Fly_Graphics_Table
	dc.l	Fly_Mask_Table
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)*8		;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Fly_Pattern_2 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+DIRECTION_ALIEN_SET
	dc.b	0

Fly_Object3
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	2		;frame rate
	dc.l	Fly_Graphics_Table
	dc.l	Fly_Mask_Table
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)*8		;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Fly_Pattern_3 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+DIRECTION_ALIEN_SET
	dc.b	0
	
Fly_Object4
	dc.w	5<<6+2
	dc.w	BPR-4
	dc.w	2		;number of frames
	dc.w	2		;frame rate
	dc.l	Fly_Graphics_Table
	dc.l	Fly_Mask_Table
	dc.w	16		;xsize
	dc.w	5		;ysize
	dc.w	(5*2)*8		;plane size
	dc.w	(5*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Fly_Pattern_4 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET+DIRECTION_ALIEN_SET
	dc.b	0


FLY_LEFT	EQU	1
FLY_RIGHT	EQU	-1
FLY_UP		EQU	-1
FLY_DOWN	EQU	1

Fly_Pattern
	dc.w	OBJECT_SET_DIRECTION
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION
	dc.w	5
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION
	dc.w	3
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION
	dc.w	7
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_PATTERN_RESTART

Fly_Pattern_2
	dc.w	3,0
Fly_Pattern_Repeat2	
	dc.w	OBJECT_SET_DIRECTION	;1
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION	;2
	dc.w	5
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;3
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;4
	dc.w	3
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;5
	dc.w	2
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	OBJECT_SET_DIRECTION	;6
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;7
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;8
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;9
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;10
	dc.w	7
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;11
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION	;12
	dc.w	5	
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;13
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;14
	dc.w	5
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;15
	dc.w	6	
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION	;16
	dc.w	7
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;17
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;18
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;19
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;20
	dc.w	7
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_PAT
	dc.l	Fly_Pattern_Repeat2

Fly_pattern_3
	dc.w	OBJECT_SET_DIRECTION	;1
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION	;2
	dc.w	5
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;3
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;4
	dc.w	3
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;5
	dc.w	2
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	FLY_RIGHT,0
	dc.w	OBJECT_SET_DIRECTION	;6
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;7
	dc.w	2
	dc.w	FLY_RIGHT,0
	dc.w	OBJECT_SET_DIRECTION	;8
	dc.w	3
	dc.w	FLY_RIGHT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;9
	dc.w	4
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	0,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;10
	dc.w	5
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	FLY_LEFT,FLY_DOWN
	dc.w	OBJECT_SET_DIRECTION	;11
	dc.w	6
	dc.w	FLY_LEFT,0
	dc.w	FLY_LEFT,0
	dc.w	OBJECT_SET_DIRECTION	;12
	dc.w	7	
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	FLY_LEFT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;13
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;14
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;15
	dc.w	2	
	dc.w	FLY_RIGHT,0
	dc.w	OBJECT_SET_DIRECTION	;16
	dc.w	1
	dc.w	FLY_RIGHT,FLY_UP
	dc.w	OBJECT_SET_DIRECTION	;17
	dc.w	0
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	0,FLY_UP
	dc.w	OBJECT_SET_PAT
	dc.l	Fly_Pattern_3

Fly_pattern_4
	dc.w	2,5
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	-2,-5
	dc.l	Fly_Object2
	dc.w	OBJECT_SET_PAT
	dc.l	Fly_Pattern_3

Gas_Spurt_Object1
	dc.w	42<<6+2
	dc.w	BPR-4
	dc.w	3		;number of frames
	dc.w	1		;frame rate
	dc.l	Gas_Spurt1
	dc.l	Gas_Spurt1+(42*2)*3*NUM_PLANES
	dc.w	16		;xsize
	dc.w	42		;ysize
	dc.w	(42*2)*3	;plane size
	dc.w	(42*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Gas_Spurt_Pattern1 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Gas_Spurt_Object2
	dc.w	15<<6+2
	dc.w	BPR-4
	dc.w	7		;number of frames
	dc.w	1		;frame rate
	dc.l	Gas_Spurt2
	dc.l	Gas_Spurt2+(15*2)*7*NUM_PLANES
	dc.w	16		;xsize
	dc.w	15		;ysize
	dc.w	(15*2)*7	;plane size
	dc.w	(15*2)    	;frame size	
	dc.w	2		;alien x words
	dc.l	Gas_Spurt_Pattern2 ;pattern pointer
	dc.l	0		;death pattern
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

Gas_Spurt_Pattern1
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	OBJECT_SIMPLE_ADD
	dc.w	0,-5
	dc.l	Gas_Spurt_Object2
	dc.w	OBJECT_KILL,0,0
	
Gas_Spurt_Pattern2
	dc.w	0,0
	dc.w	0,-3
	dc.w	0,-4
	dc.w	0,-2
	dc.w	0,-2
	dc.w	0,-3
	dc.w	0,-4
	dc.w	OBJECT_KILL,0,0


redflipflower_object
	dc.w	10<<6+2
	dc.w	BPR-4
	dc.w	11		
	dc.w	2		;update anim frame every 2 frames
	dc.l	RedFlipFlower_Graphics
	dc.l	RedFlipFlower_Graphics+((10*2)*11)*NUM_PLANES
	dc.w	13		;xsize
	dc.w	10		;ysize
	dc.w	(10*2)*11	;plane size	- so can get to next alien
	dc.w	(10*2)		;frame size
	dc.w	2		;alien x words
	dc.l	flip_flower_pattern
	dc.l	0
	dc.l	0
	dc.w	0
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	0

flip_flower_pattern
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	delay_animation
	dc.w	OBJECT_STOP_ANIM
flip_flower_wait	
	dc.w	0,0		;flower do nothing
	dc.w	OBJECT_UNTIL
	dc.l	flip_flower_wait
	dc.w	OBJECT_START_ANIM
	dc.w	0,0,0,0
	dc.w	0,-2,0,-2
	dc.w	0,-1,0,-1
	dc.w	0,-2,0,-1
	dc.w	0,-1,0,0
	dc.w	0,0,0,0
	dc.w	0,1,0,1
	dc.w	0,1,0,1
	dc.w	0,1,0,1
	dc.w	0,2,0,1
	dc.w	0,1,0,1
	dc.w	OBJECT_FRAME_SET,0
	dc.w	OBJECT_EXECUTE_CODE
	dc.l	delay_animation
	dc.w	0,-1,0,0
	dc.w	OBJECT_STOP_ANIM		
	dc.w	OBJECT_SET_PAT
	dc.l	flip_flower_wait
	
Torch_Flame_Object
	dc.w	18<<6+2
	dc.w	BPR-4
	dc.w	3		;
	dc.w	2		;
	dc.l	Spore_Fragment_Graphics+(18*2*3)
	dc.l	Spore_Fragment_Graphics+(18*2*8)*NUM_PLANES+(18*2*3)
	dc.w	16		;xsize
	dc.w	18		;ysize
	dc.w	18*2*8		;plane size
	dc.w	18*2		;frame size
	dc.w	2		;alien x words
	dc.l	Torch_Pattern	;this will do
	dc.l	0
	dc.l	0
	dc.w	4
	dc.b	ALIEN_NO_COLLISION_SET+PLAYER_NO_COLLISION_SET+OFF_SCREEN_SET
	dc.b	Torch_Flame

Torch_Pattern
	dc.w	2,-1
	dc.w	0,0
	dc.w	OBJECT_DONT_GO_ANYWHERE	