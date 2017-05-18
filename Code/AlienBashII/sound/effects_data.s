GunFire_Sample		equ	0
GunFire_length		equ	1034

Pling_Sample		equ	1
Pling_length		equ	3034

Rocket_Sample		equ	2
Rocket_length		equ	7126

Rocket_Explosion_Sample	equ	3
Rocket_Explosion_length equ	6200

Thud_Sample		equ	4
Thud_length		equ	1262

Grenade_Sample		equ	5
Grenade_length		equ	5492

crapexplo_Sample	equ	6
crapexplo_length	equ	3802

Drain_Sample		equ	7
Drain_length		equ	1822

ShortExplo_Sample	equ	8
ShortExplo_length	equ	3920

Collect_Sample		equ	9
Collect_length		equ	2306

PigDie_Sample		equ	10
PigDie_length		equ	8514

PigShoot_Sample		equ	11
PigShoot_Length		equ	1450

Slide_Sample		equ	12
Slide_Length		equ	2182

Pop_Sample		equ	13
Pop_Length		equ	1462

GunEmpty_Sample		equ	14
GunEmpty_length		equ	760

ThrowSwitch_Sample	equ	15
ThrowSwitch_length	equ	1682

Splash_Sample		equ	16
Splash_length		equ	5184

Swoosh_Sample		equ	17
Swoosh_length		equ	1472

Wood_Sample		equ	18
Wood_Length		equ	724

*extra stuff

OverHere_Sample		equ	19
OverHere_Length		equ	5010

GetReady_Sample		equ	20
GetReady_Length		equ	16174

ExtraEnergy_Sample	equ	21
ExtraEnergy_Length	equ	7680

Grenades_Sample		equ	22
Grenades_Length		equ	8270

Rockets_Sample		equ	23
Rockets_Length		equ	7544

Appear_Sample		equ	24
Appear_Length		equ	3950

Manscream_Sample	equ	25
Manscream_length	equ	7266

Whistle_Sample		equ	26
Whistle_length		equ 	11362	

Thunder_Sample		equ	27
Thunder_Length		equ	19604

Rain_Sample		equ	28
Rain_Length		equ	25480

Chink_Sample		equ	29
Chink_Length		equ	2826

Sample_Lengths_Table
	dc.w	GunFire_length		
	dc.w	Pling_length		
	dc.w	Rocket_length		
	dc.w	Rocket_Explosion_length 
	dc.w	Thud_length		
	dc.w	Grenade_length		
	dc.w	crapexplo_length	
	dc.w	Drain_length		
	dc.w	ShortExplo_length
	dc.w	Collect_length	
	dc.w	PigDie_length	
	dc.w	PigShoot_Length	
	dc.w	Slide_length
	dc.w	Pop_Length	
	dc.w	GunEmpty_length	
	dc.w	ThrowSwitch_length
	dc.w	Splash_length	
	dc.w	Swoosh_length	
	dc.w	Wood_Length		
Extra_Samples	
	dc.w	OverHere_Length	
	dc.w	GetReady_Length	
	dc.w	ExtraEnergy_Length	
	dc.w	Grenades_Length	
	dc.w	Rockets_Length	
	dc.w	Appear_Length	
	dc.w	Manscream_Length
	dc.w	Whistle_Length
	dc.w	Thunder_Length
	dc.w	Rain_Length
	dc.w	Chink_Length
	dc.w	0		;end table	

	rsreset
Sound_Pos	rs.w	1
Sound_Ptr	rs.l	1
Sound_length	rs.w	1
Sound_Period	rs.w	1
Sound_Volume	rs.w	1	
Sound_Fx_Size	rs.w 	1


GunFire_Noise
	dc.w	GunFire_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	380	; period
	dc.w	48	; volume

Splat_Noise
	dc.w	Pop_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	680	; period
	dc.w	64	; volume


Pling_Noise
	dc.w	Pling_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	100	; period
	dc.w	64	; volume

Pling_NoiseV2
	dc.w	Pling_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	100	; period
	dc.w	44	; volume
	
Pling_NoiseV3
	dc.w	Pling_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	100	; period
	dc.w	24	; volume
	
Pling_NoiseV4
	dc.w	Pling_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	100	; period
	dc.w	14	; volume

PigShoot_Noise
	dc.w	PigShoot_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	582	; period
	dc.w	64	; volume


Change_Noise
	dc.w	Pling_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	127	; period
	dc.w	64	; volume
	
Rocket_Noise
	dc.w	Rocket_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	428	; period
	dc.w	40	; volume

Bomb_Rocket_Noise
	dc.w	Rocket_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	528	; period
	dc.w	45	; volume

Rocket_Explosion_Noise
	dc.w	Rocket_Explosion_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	498	; period
	dc.w	64	; volume

Thud_Noise
	dc.w	Thud_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	340	; period
	dc.w	32	; volume

Thud_Noise2
	dc.w	Thud_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	360	; period
	dc.w	16	; volume


Skull_Bounce_Noise
	dc.w	Thud_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	83	; period
	dc.w	64	; volume

Grenade_Noise
	dc.w	Grenade_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	428	; period
	dc.w	64	; volume

crapexplo_Noise
	dc.w	crapexplo_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	868	; period
	dc.w	48	; volume

Drain_Noise
	dc.w	Drain_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	180	; period
	dc.w	10	; volume

ShortExplo_Noise
	dc.w	ShortExplo_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	395	; period
	dc.w	32	; volume

BlockExplo_Noise
	dc.w	Grenade_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	318	; period
	dc.w	64	; volume

Collect_Noise
	dc.w	Collect_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	268	; period
	dc.w	55	; volume

PigDie_Noise
	dc.w	PigDie_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	313	; period
	dc.w	64	; volume

PigDie_Noise2
	dc.w	PigDie_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	333	; period
	dc.w	64	; volume

PigDie_Noise3
	dc.w	PigDie_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	394	; period
	dc.w	64	; volume

PigDie_Noise4
	dc.w	PigDie_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	372	; period
	dc.w	64	; volume

Slide_Noise
	dc.w	Slide_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	284	; period
	dc.w	64	; volume

GunEmpty_Noise
	dc.w	GunEmpty_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	254	; period
	dc.w	12	; volume

door_Noise
	dc.w	ThrowSwitch_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	320	; period
	dc.w	40	; volume

ThrowSwitch_Noise
	dc.w	ThrowSwitch_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	600	; period
	dc.w	40	; volume

Splash_Noise
	dc.w	Splash_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	452	; period
	dc.w	32	; volume

Swoosh_Noise
	dc.w	Swoosh_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	340	; period
	dc.w	64	; volume

Wood_Noise
	dc.w	Wood_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	404	;284	; period
	dc.w	40	; volume

Wood_Noise2
	dc.w	Wood_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	380	;268	; period
	dc.w	40	; volume



OverHere_Noise
	dc.w	Overhere_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	253	; period
	dc.w	30

Getready_Noise
	dc.w	GetReady_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	180	; period
	dc.w	64


ExtraEnergy_Noise
	dc.w	ExtraEnergy_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	253	; period
	dc.w	64

Grenades_Noise
	dc.w	Grenades_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	253	; period
	dc.w	64


Rockets_Noise
	dc.w	Rockets_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	253	; period
	dc.w	64

Appear_Noise
	dc.w	Appear_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	380	; period
	dc.w	64
	
Manscream_Noise
	dc.w	Manscream_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	568	; period
	dc.w	64	; volume

Whistle_Noise
	dc.w	Whistle_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	210	; period
	dc.w	30	; volume

Thunder_Noise
	dc.w	Thunder_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	654	; period
	dc.w	64	; volume

Rain_Noise
	dc.w	Rain_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	332	; period
	dc.w	0	; volume

Chink_Noise
	dc.w	Chink_Sample
	dc.l	0
	dc.w	0	; length
	dc.w	180	; period
	dc.w	32	; volume

	
End_Of_Samples 

Blank_Noise
	dc.w	0
	dc.l	Sound_Blank
	dc.w	4	; length
	dc.w	332	; period
	dc.w	0	; volume
