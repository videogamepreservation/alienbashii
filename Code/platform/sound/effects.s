
	rsreset

Sound_Ptr	rs.l	1
Sound_length	rs.w	1
Sound_Period	rs.w	1
Sound_Volume	rs.w	1	

blank
	dc.w	0,0

HeadButt_Noise
	dc.l	HeadButt_Sample
	dc.w	HeadButt_Length	; length
	dc.w	214	; period
	dc.w	64	; volume


HeadButt_Sample
	ifd	all_samples
	incbin	"game_samples/Headbutt.sound"		
	endc
	even
HeadButt_length	EQU (*-HeadButt_Sample)/2

Jump_Water_Noise
	dc.l	Jump_Sample
	dc.w	Jump_Length	; length
	dc.w	153	; period
	dc.w	64	; volume


Jump_Sample
	ifd	all_samples

	incbin	"game_samples/newJump"		
	even
	endc
Jump_length	EQU (*-Jump_Sample)/2

Jump_Noise
	dc.l	Jump_Sample
	dc.w	Jump_Length	; length
	dc.w	128	; period
	dc.w	64	; volume



Coin_Noise
	dc.l	Coin_Sample
	dc.w	Coin_Length	; length
	dc.w	180	; period
	dc.w	55	; volume


Coin_Sample
	ifd	all_samples

	incbin	"game_samples/coincollect"		
	even
	endc
Coin_length	EQU (*-Coin_Sample)/2




Spangle_Noise
	dc.l	Spangle_Sample
	dc.w	Spangle_Length	; length
	dc.w	150	; period
	dc.w	64	; volume


Spangle_Sample
	ifd	all_samples

	incbin	"game_samples/spangle"		
	even
	endc
spangle_length	EQU (*-spangle_Sample)/2

Alienhit_Noise
	dc.l	Alienhit_Sample
	dc.w	Alienhit_Length	; length
	dc.w	170	; period
	dc.w	64	; volume


Alienhit_Sample
	ifd	all_samples

	incbin	"game_samples/alienhit"		
	even
	endc
alienhit_length	EQU (*-alienhit_Sample)/2

blocksplit_Noise
	dc.l	blocksplit_Sample
	dc.w	blocksplit_Length	; length
	dc.w	180	; period
	dc.w	64	; volume


blocksplit_Sample
	ifd	all_samples

	incbin	"game_samples/blocksplit"		
	even
	endc
blocksplit_length	EQU (*-blocksplit_Sample)/2

bumhit_Noise
	dc.l	bumhit_Sample
	dc.w	bumhit_Length	; length
	dc.w	254	; period
	dc.w	64	; volume


bumhit_Sample
	ifd	all_samples

	incbin	"game_samples/bumhit"		
	even
	endc
bumhit_length	EQU (*-bumhit_Sample)/2

SquizHurt_Noise
	dc.l	SquizHurt_Sample
	dc.w	SquizHurt_Length	; length
	dc.w	226	; period
	dc.w	64	; volume


SquizHurt_Sample
	ifd	all_samples

	incbin	"game_samples/SquizHurt"		
	even
	endc
SquizHurt_length	EQU (*-SquizHurt_Sample)/2


Click_Noise
	dc.l	Click_Sample
	dc.w	Click_Length	; length
	dc.w	180	; period
	dc.w	64	; volume


Click_Sample
	ifd	all_samples

	incbin	"game_samples/Click"		
	even
	endc
Click_length	EQU (*-Click_Sample)/2

Cowbell_Noise
	dc.l	Cowbell_Sample
	dc.w	Cowbell_Length	; length
	dc.w	134	; period
	dc.w	64	; volume


Cowbell_Sample
	ifd	all_samples

	incbin	"game_samples/Cowbell"		
	even
	endc
Cowbell_length	EQU (*-Cowbell_Sample)/2

Spring_Noise
	dc.l	Spring_Sample
	dc.w	Spring_Length	; length
	dc.w	268	; period
	dc.w	64	; volume


Spring_Sample
	ifd	all_samples

	incbin	"game_samples/Spring"		
	even
	endc
Spring_length	EQU (*-Spring_Sample)/2

Slide_Noise
	dc.l	Slide_Sample
	dc.w	Slide_Length	; length
	dc.w	180	; period
	dc.w	64	; volume


Slide_Sample
	ifd	all_samples
	incbin	"game_samples/Slide"		
	even
	endc
Slide_length	EQU (*-Slide_Sample)/2


Swoosh_Noise
	dc.l	Swoosh_Sample
	dc.w	Swoosh_Length	; length
	dc.w	340	; period
	dc.w	64	; volume


Swoosh_Sample
	ifd	all_samples
	incbin	"game_samples/Swoosh"		
	endc
	even
Swoosh_length	EQU (*-Swoosh_Sample)/2


Chuck_Noise
	dc.l	Chuck_Sample
	dc.w	Chuck_Length	; length
	dc.w	147	; period
	dc.w	64	; volume


Chuck_Sample
	ifd	all_samples
	incbin	"game_samples/Chuck"		
	endc
	even
Chuck_length	EQU (*-Chuck_Sample)/2


Slap_Noise
	dc.l	Slap_Sample
	dc.w	Slap_Length	; length
	dc.w	276	; period
	dc.w	64	; volume


Slap_Sample
	ifd	all_samples
	incbin	"game_samples/Slap1"		
	endc
	even
Slap_length	EQU (*-Slap_Sample)/2


Bat_Noise
	dc.l	Bat_Sample
	dc.w	Bat_Length	; length
	dc.w	276	; period
	dc.w	64	; volume


Bat_Sample
	ifd	all_samples
	incbin	"game_samples/crack1"		
	endc
	even
Bat_length	EQU (*-Bat_Sample)/2


Wallhit_Noise
	dc.l	Wallhit_Sample
	dc.w	Wallhit_Length	; length
	dc.w	124	; period
	dc.w	64	; volume


Wallhit_Sample
	ifd	all_samples
	incbin	"game_samples/wallhit"		
	endc
	even
Wallhit_length	EQU (*-Wallhit_Sample)/2


Fruit_Noise
	dc.l	Fruit_Sample
	dc.w	Fruit_Length	; length
	dc.w	77	; period
	dc.w	64	; volume


Fruit_Sample
	ifd	all_samples
	incbin	"game_samples/Fruit"		
	endc
	even
Fruit_length	EQU (*-Fruit_Sample)/2
