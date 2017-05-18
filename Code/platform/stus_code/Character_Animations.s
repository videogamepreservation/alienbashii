FIRST_COMMAND	EQU	99
LAST_COMMAND	EQU	114

RESTART		EQU	99
FLIP		EQU	100
CYCLE		EQU	101
SET		EQU	102
REPEAT		EQU	103
SPAWN		EQU	104
MODE_SET	EQU	105
MODE_CLEAR	EQU	106
GFX		EQU	107
SPRING_SQUIZ	EQU	108
FREEZE_PLAYER	EQU	109
CHARACTER_TALK	EQU	110
CAST_SLAVES	EQU	111
COMMAND_SLAVES	EQU	112
NEW_ANIM	EQU	113
DONE_FRUIT_BLOCK	EQU	114	

; special values
DATA		EQU	-100
*******************************************************
* Leave as words for ease of code, but consider bytes *
*******************************************************
GlassBlock_Anim
	dc.w	GFX,GLASSBLOCK
	dc.w	SET,0
	dc.w	0,0
	dc.w	0,0
	dc.w	MODE_CLEAR,(1<<No_SaveBack)<<8
	dc.w	SPAWN
	dc.l	glass_Spawn
	dc.w	SET,1
	dc.w	0,-3,0,-3,0,-3,0,-3
	dc.w	0,-2,0,-2,0,-2,0,-2
	dc.w	0,-2,0,-1,0,-1
	dc.w	0,-1
	dc.w	0,-1
	dc.w	MODE_SET
	dc.w	(1<<Ground_Collision)<<8+(1<<Alien_Bonus)
	dc.w	MODE_CLEAR,(1<<Alien_Hit)<<8
	dc.w	0,0
			
	dc.w	RESTART
	dc.l	null_anim

glass_Spawn
	dc.w	$8000+smallglassblock_CHARACTER,0,0,0
	dc.l	glass1_Pat
	dc.w	$8000+smallglassBLOCK_CHARACTER,8,0,0
	dc.l	glass2_Pat
	dc.w	$8000+smallglassBLOCK_CHARACTER,8,8,0
	dc.l	glass3_Pat
	dc.w	$8000+smallglassBLOCK_CHARACTER,0,8,0
	dc.l	glass4_Pat
	dc.w	$ffff

glass1_Pat
	dc.w	GFX,smallglassBLOCK
	dc.w	CYCLE,0,3,2
	include	"stus_code/pattern_data/smallblockspattern 1.s"
	dc.w	restart
	dc.l	null_anim
glass2_Pat
	dc.w	GFX,smallglassBLOCK
	dc.w	0,0
	dc.w	CYCLE,0,3,2
	include	"stus_code/pattern_data/smallblockspattern 4.s"
	dc.w	restart
	dc.l	null_anim
glass3_Pat
	dc.w	GFX,smallglassBLOCK
	dc.w	0,0,0,0
	dc.w	CYCLE,0,3,2
	include	"stus_code/pattern_data/smallblockspattern 2.s"
	dc.w	restart
	dc.l	null_anim
glass4_Pat
	dc.w	GFX,smallglassBLOCK
	dc.w	0,0,0,0,0,0
	dc.w	CYCLE,0,3,2
	include	"stus_code/pattern_data/smallblockspattern 3.s"
	dc.w	restart
	dc.l	null_anim

Goal_Anim
	dc.w	GFX,GOAL
	dc.w	CYCLE,0,3,4
	dc.w	CAST_SLAVES
	dc.l	goal_bits
goal_float
	dc.w	REPEAT,-1,0,20
	dc.w	0,0
	dc.w	REPEAT,1,0,20
	dc.w	0,0	
	dc.w	restart
	dc.l	goal_float
	

goal_bits	
	dc.w	Balloon_Character,-16,-26,0
	dc.w	Balloon_Character,27,-26,0
	dc.w	GoalLog_Character,6,16,0
	dc.w	LogHook_Character,-12,10,0
	dc.w	LogHook_Character,22,10,0
	dc.w	$ffff	
	
Balloon_Anim	
	dc.w	GFX,Balloon
	dc.w	SET,0
balloon_loop	
	dc.w	0,0
	dc.w	restart
	dc.l	balloon_loop	

LogHook_Anim	
	dc.w	GFX,LogHook
	dc.w	SET,0
LogHook_loop	
	dc.w	0,0
	dc.w	restart
	dc.l	LogHook_loop	

GoalLog_Anim	
	dc.w	GFX,LOG
	dc.w	SET,0
GoalLog_loop	
	dc.w	0,0
	dc.w	restart
	dc.l	GoalLog_loop	
		
Log_Fall_Anim
	dc.w	GFX,Log
	dc.w	SET,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	
	dc.w	MODE_CLEAR,1<<No_SaveBack<<8	
	dc.w	0,1,0,1,0,1,0,1,0,1,0,2,0,2,0,3,0,4
dick_head
	dc.w	REPEAT,0,5,100
	dc.w	0,0
	dc.w	RESTART
	dc.l	dick_head

Baseball_Anim
	dc.w	GFX,BASEBALL
	dc.w	CYCLE,0,3,4
ball_loop
	dc.w	8,0
	dc.w	restart
	dc.l	ball_loop	

Baseball_Frig_Anim
	dc.w	mode_clear
	dc.w	1<<alien_hit<<8
	dc.w	restart
	dc.l	ball_loop
	
Baseball_Hit_Anim
	include	"stus_code/pattern_data/pattern_data-6.s"
ball_hit_loop	
	dc.w	0,0
	dc.w	restart
	dc.l	ball_hit_loop	
	
	
Fido_script
	dc.w	WINDOW_POSITION
	dc.w	WINDOW_X,WINDOW_Y
*	dc.w	WINDOW_TALKER
*	dc.l	squiz_talker	
	dc.w	WINDOW_TEXT
	dc.l	fidos_wisdom
	dc.w	WINDOW_GO
	dc.w	WINDOW_DONE
			
fidos_wisdom
	dc.b	"HELLO MY FRIEND, I  "
	dc.b    -1
	dc.b    "AM TOSSPOT, SERVANT "
	dc.b    -1
	dc.b    "TO THE WIZARD JOBBY."
	dc.b    -1
	dc.b    "I CAN SHOW YOU HOW  "
	dc.b    "TO REACH THE CASTLE.",0
	even
	

Arrow_Up_Anim
	dc.w	GFX,ARROW_BLOCK
	dc.w	SET,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,-4
	dc.w	0,-4
	dc.w	0,-4
	dc.w	0,-4
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
	dc.w	restart
	dc.l	Null_Anim

Arrow_Left_Anim
	dc.w	GFX,ARROW_BLOCK
	dc.w	SET,1
	dc.w	0,0
	dc.w	0,0
	dc.w	-4,0
	dc.w	-4,0
	dc.w	-4,0
	dc.w	-4,0
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
	dc.w	restart
	dc.l	Null_Anim
	
Arrow_Right_Anim
	dc.w	GFX,ARROW_BLOCK
	dc.w	SET,2
	dc.w	0,0
	dc.w	0,0
	dc.w	4,0
	dc.w	4,0
	dc.w	4,0
	dc.w	4,0
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
	dc.w	restart
	dc.l	Null_Anim
	
	
Platform_Anim
	dc.w	GFX,PLATFORM
	dc.w	SET,0
platloop
	dc.w	0,0,0,0,1,0,1,0,1,0
	dc.w	REPEAT,2,0,160
	dc.w	1,0,1,0,1,0,0,0,0,0
	dc.w	0,0,0,0,-1,0,-1,0,-1,0
	dc.w	REPEAT,-2,0,160
	dc.w	-1,0,-1,0,-1,0,0,0,0,0
	dc.w	RESTART
	dc.l	Platloop

circle_platform_anim
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
	dc.w	spawn
	dc.l	circle_platforms
	dc.w	MODE_SET,1<<Alien_Dead<<8
	dc.w	restart 
	dc.l	null_anim

circle_platforms

	dc.w	$8000+circle_platform_CHARACTER,15,0,0
	dc.l	circleanim2
	dc.w	$8000+circle_platform_CHARACTER,30,0,0
	dc.l	circleanim3
	dc.w	$8000+circle_platform_CHARACTER,45,0,0
	dc.l	circleanim4
	dc.w	$8000+circle_platform_CHARACTER,60,0,0
	dc.l	circleanim5
	dc.w	$8000+circle_platform_CHARACTER,60-24+7,15,0
	dc.l	circleanim6
	dc.w	$ffff

stillloganim
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
	dc.w	restart
	dc.l	null_anim
		
circleanim2
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
circle3loop
	include	"stus_code/pattern_data/circlepattern 1.s"
	dc.w	restart
	dc.l	circle3loop

circleanim3
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
circle2loop
	include	"stus_code/pattern_data/circlepattern 2.s"
	dc.w	restart
	dc.l	circle2loop

circleanim4
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
circle5loop
	include	"stus_code/pattern_data/circlepattern 3.s"
	dc.w	restart
	dc.l	circle5loop

circleanim5
	dc.w	GFX,LOGLINK
	dc.w	SET,0
	dc.w	MODE_CLEAR,1<<Alien_Platform
circle6loop
	include	"stus_code/pattern_data/circlepattern 4.s"
	dc.w	restart
	dc.l	circle6loop

circleanim6
	dc.w	GFX,PLATFORM
	dc.w	SET,0
	dc.w	restart
	dc.l	circle6loop

Platform_still_Anim
	dc.w	GFX,ELEVATOR
	dc.w	SET,0
elevloop
	dc.w	0,0
	dc.w	restart
	dc.l	elevloop
	
CallButton_Anim
	dc.w	GFX,CALLBUTTON
	dc.w	SET,0
	dc.w	CAST_SLAVES
	dc.l	Elevator_List
	dc.w	RESTART		
	dc.l	null_anim

Elevator_List
	dc.w	Elevator_Character,100,-10,80
	dc.w	$ffff			
	
Press_CallButton_Anim
	dc.w	MODE_CLEAR,1<<Platform_Activate	
	dc.w	COMMAND_SLAVES,NEW_ANIM
	dc.l	Elevator_Down_Anim	
	dc.w	REPEAT,0,0,50
	dc.w	0,0
	dc.w	MODE_SET,1<<Platform_Activate	
	dc.w	RESTART
	dc.l	null_anim

Elevator_Down_Anim
	dc.w	REPEAT,0,1,DATA
	dc.w	MODE_SET,1<<Platform_Activate
	dc.w	0,0
	dc.w	restart
	dc.l	Platform_still_Anim

Elevator_Anim
	dc.w	CYCLE,0,1,10
	dc.w	MODE_CLEAR,1<<Platform_Activate	; dont reenable
	dc.w	REPEAT,1,-1,DATA
	dc.w	0,0
	dc.w	restart
	dc.l	Platform_still_Anim

UpandDown_Anim
	dc.w	GFX,PLATFORM
	dc.w	SET,0
platloop2
	dc.w	REPEAT,0,2,DATA
	dc.w	0,0
	dc.w	REPEAT,0,-2,DATA
	dc.w	0,0
	dc.w	RESTART
	dc.l	Platloop2
	
Fish_Anim
	dc.w	GFX,FISH
fish_loop
	dc.w	MODE_SET,1<<Alien_Left
	dc.w	SET,0
	dc.w	REPEAT,1,0,150
	dc.w	1,0
	dc.w	MODE_CLEAR,1<<Alien_Left

	dc.w	SET,0
	dc.w	REPEAT,1,0,150
	dc.w	1,0
	dc.w	RESTART
	dc.l	Fish_loop


	
Fish_Die
	dc.w	SET,2
	*dc.w	SPAWN
	*dc.l	Score_Spawn
Fish_Loop3
	dc.w	0,1
	dc.w	RESTART
	dc.l	Fish_Loop3

Score_Spawn	
	dc.w	Score_Character,0,0,0
	dc.w	$ffff	

Score_Anim
	dc.w	GFX,SCORE
*	dc.w	SET,0
	dc.w	REPEAT,0,-1,10
	dc.w	0,-1,0,0,0,-1,0,0,0,-1,0,0,0,-1
	dc.w	0,0,0,0,0,-1,0,0,0,0,0,-1,0,0,0,0,0,-1
	dc.w	0,0,0,0,0,-1,0,0,0,0,0,-1,0,0,0,0,0,-1
	dc.w	0,0,0,0,0,-1,0,0,0,0,0,-1,0,0,0,0,0,-1
	dc.w	0,0,0,0,0,-1,0,0,0,0,0,-1,0,0,0,0,0,-1
	dc.w	0,0	
	dc.w	MODE_SET,1<<Alien_Dead<<8
Score_Freeze
	dc.w	0,0
	dc.w	Restart
	dc.l	Score_Freeze
		
Ball_Anim
	dc.w	SET,0
	dc.w	5,-4,0,-4,0,-4,0,-4,0,-4,0,-3,0,-3,0,-3,0,-3,0,-2,0,-2,0,-2,0,-1,0,-1,0,0,0,0,0,0
	dc.w	0,1,0,1,0,2,0,2,0,2,0,3,0,3,0,3,0,3,0,4,0,4,0,4,0,4,0,4
	
	dc.w	RESTART
	dc.l	Ball_Anim
	
Cracked_Block_Anim
	dc.w	GFX,CRACKED_BLOCK
	dc.w	SET,0
	dc.w	0,0
	dc.w	0,0
	dc.w	MODE_SET
	dc.w	1<<Alien_Dead<<8
	dc.w	SPAWN
	dc.l	Small_Spawn

loopcr	dc.w	0,0
	dc.w	RESTART
	dc.l	loopcr		

Small_Spawn
	dc.w	$8000+SMALL_BLOCK_CHARACTER,0,8,0
	dc.l	Test1_Pat
	dc.w	$8000+SMALL_BLOCK_CHARACTER,0,0,0
	dc.l	Test2_Pat
	dc.w	$8000+SMALL_BLOCK_CHARACTER,8,0,0
	dc.l	Test3_Pat
	dc.w	$8000+SMALL_BLOCK_CHARACTER,8,8,0
	dc.l	Test4_Pat
	dc.w	$ffff

Test1_Pat
	dc.w	GFX,SMALL_BLOCK
	include	"stus_code/pattern_data/brick_data-6.s"

Test1_loop
	dc.w	-2,6
	dc.w	RESTART
	dc.l	Test1_loop

Test2_Pat
	dc.w	GFX,SMALL_BLOCK
	include	"stus_code/pattern_data/brick_data-2.s"
Test2_loop
	dc.w	2,6
	dc.w	RESTART
	dc.l	Test2_loop

Test3_Pat
	dc.w	GFX,SMALL_BLOCK
	include	"stus_code/pattern_data/brick_data 2.s"

Test3_loop
	dc.w	-1,5
	dc.w	RESTART
	dc.l	Test3_loop
	
Test4_Pat
	dc.w	GFX,SMALL_BLOCK
	include	"stus_code/pattern_data/brick_data 6.s"
Test4_loop
	dc.w	1,5
	dc.w	RESTART
	dc.l	Test4_loop
		
Smoke_Anim
	dc.w	GFX,SMOKE
	dc.w	CYCLE,0,3,4
	dc.w	REPEAT,0,0,16
	dc.w	0,0

	dc.w	MODE_SET
	dc.w	1<<Alien_Dead<<8
scumD	dc.w	0,0	
	dc.w	RESTART
	dc.l	scumD
	
fruitBlock_Anim1
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn1
fruitblock_bump
	dc.w	0,0
	dc.w	0,0
	dc.w	0,-3
	dc.w	0,-3

*	dc.w	SET,1
	dc.w	0,3
	dc.w	0,3
	dc.w	0,0,0,0
	dc.w	DONE_FRUIT_BLOCK
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
gammy
	dc.w	0,0
	dc.w	RESTART
	dc.l	gammy	

fruitBlock_Anim2
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn2
	dc.w	restart
	dc.l	fruitblock_bump

fruitBlock_Anim3
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn3
	dc.w	restart
	dc.l	fruitblock_bump
	
fruitBlock_Anim4
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn4
	dc.w	restart
	dc.l	fruitblock_bump

fruitBlock_Anim5
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn5
	dc.w	restart
	dc.l	fruitblock_bump

fruitBlock_Anim6
	dc.w	GFX,FRUITBLOCK
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	fruit_Spawn6
	dc.w	0,0
	dc.w	0,0
	dc.w	0,-3
	dc.w	0,-3

	dc.w	GFX,HIT_BLOCK_G
	dc.w	SET,1
	dc.w	0,0
	dc.w	0,3
	dc.w	0,3
	dc.w	0,0,0,0
	dc.w	DONE_FRUIT_BLOCK
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
	dc.w	0,0
	dc.w	RESTART
	dc.l	null_anim

	
fruit_spawn1	
	dc.w	$8000+FRUIT_CHARACTER,0,-16,0
	dc.l	fruit_pattern1
	dc.w	$ffff

fruit_spawn2
	dc.w	$8000+FRUIT_CHARACTER,0,-16,0
	dc.l	fruit_pattern2
	dc.w	$ffff
	
fruit_spawn3	
	dc.w	$8000+FRUIT_CHARACTER,0,-16,0
	dc.l	fruit_pattern3
	dc.w	$ffff

fruit_spawn4
	dc.w	$8000+FRUIT_CHARACTER,0,-16,0
	dc.l	fruit_pattern4
	dc.w	$ffff

fruit_spawn5
	dc.w	$8000+FRUIT_CHARACTER,0,-16,0
	dc.l	fruit_pattern5
	dc.w	$ffff

fruit_spawn6	
	dc.w	SCORE_CHARACTER,0,-16,0
	dc.w	$ffff
		
fruit_pattern1
	dc.w	GFX,FRUIT,SET,0
	include	"stus_code/pattern_data/fruitpattern 1.s"
	dc.w	restart
	dc.l	null_anim
fruit_pattern2
	dc.w	GFX,FRUIT,SET,1
	include	"stus_code/pattern_data/fruitpattern 2.s"
	dc.w	restart
	dc.l	null_anim
fruit_pattern3
	dc.w	GFX,FRUIT,SET,2
	include	"stus_code/pattern_data/fruitpattern 3.s"
	dc.w	restart
	dc.l	null_anim
fruit_pattern4
	dc.w	GFX,FRUIT,SET,3
	include	"stus_code/pattern_data/fruitpattern 4.s"
	dc.w	restart
	dc.l	null_anim
fruit_pattern5
	dc.w	GFX,FRUIT,SET,4
	include	"stus_code/pattern_data/fruitpattern 5.s"
	dc.w	restart
	dc.l	null_anim
	
Null_Anim
	dc.w	0,0
	dc.w	RESTART
	dc.l	Null_Anim
	
Ernie_Anim
	dc.w	MODE_SET,1<<Alien_Left
	dc.w	GFX,ERNIE
	dc.w	FLIP,0,2,4
ernie_loop
	*dc.w	MODE_CLEAR,1<<Alien_Left
	dc.w	REPEAT,1,0,20
	dc.w	1,0
	*dc.w	MODE_SET,1<<Alien_Left
	dc.w	REPEAT,1,0,20
	dc.w	1,0
	dc.w	RESTART
	dc.l	ernie_loop

Ernie_Hit
	dc.w	SPAWN
	dc.l	hat_Spawn
	dc.w	SET,3
	dc.w	MODE_CLEAR,(1<<Ground_Collision)<<8
	*dc.w	SPAWN
	*dc.l	Score_Spawn

ernie_fall
	dc.w	0,-3,0,-2,0,-2,0,-1,0,-1,0,-1,0,0,0,0,0,0,0,0,0,0
	dc.w	0,1,0,1,0,1,0,2,0,2,0,3
	dc.w	REPEAT,0,4,100
	dc.w	RESTART
	dc.l	ernie_Fall

squiz_Anim
	dc.w	MODE_SET,1<<Alien_Left
	dc.w	GFX,SQUIZ
	dc.w	FLIP,0,2,4
	dc.w	REPEAT,0,0,100
squiz_loop
	*dc.w	MODE_CLEAR,1<<Alien_Left
	dc.w	REPEAT,1,0,100
	dc.w	1,0
	*dc.w	MODE_SET,1<<Alien_Left
	dc.w	REPEAT,1,0,100
	dc.w	1,0
	dc.w	RESTART
	dc.l	squiz_loop

squiz_hit
	*dc.w	SPAWN
	*dc.l	squiz_spawn
squiz_hitloop
	dc.w	mode_clear,1<<Ground_Collision<<8
	dc.w	0,-3,0,-2,0,-2,0,-1,0,-1,0,-1,0,0,0,0,0,0,0,0,0,0
	dc.w	0,1,0,1,0,1,0,2,0,2,0,3
	dc.w	REPEAT,0,4,100
	dc.w	RESTART
	dc.l	squiz_hitloop

	dc.w	restart
	dc.l	squiz_hitloop

squiz_spawn
	dc.w	hitstar_character,24-8,8,0
	dc.w	$ffff

HAT_SPAWN
	dc.w	hat_CHARACTER,0,0,0
	dc.w	$FFFF		

Block_Anim
	dc.w	GFX,Hit_Block_G
	dc.w	SET,0
	dc.w	SPAWN
	dc.l	Square_Spawn

	dc.w	0,0
	dc.w	0,0
	dc.w	0,-3
	dc.w	0,-2
	dc.w	0,-1
	dc.w	SET,1
	dc.w	0,0
	dc.w	0,1
	dc.w	0,2
	dc.w	0,3
	dc.w	0,0,0,0
	dc.w	MODE_SET
	dc.w	1<<Alien_Burn<<8
	dc.w	0,0
	dc.w	RESTART
	dc.l	null_anim

Square_Spawn
	*dc.w	DIAMOND_CHARACTER,0,-16,0
	dc.w	$8000+LUCKY_STAR_CHARACTER,0,-5,0
	dc.l	star_pattern1
	dc.w	$8000+LUCKY_STAR_CHARACTER,0,-5,0
	dc.l	star_pattern2
	dc.w	$8000+LUCKY_STAR_CHARACTER,0,-5,0
	dc.l	star_pattern3
	dc.w	$8000+LUCKY_STAR_CHARACTER,0,-5,0
	dc.l	star_pattern4
	dc.w	$8000+LUCKY_STAR_CHARACTER,0,-5,0
	dc.l	star_pattern5
	dc.w	$ffff
	

Square_Fall_Anim
	dc.w	GFX,DIAMOND
	dc.w	SET,0
square_loop
	dc.w	0,-3,0,-2,0,-1,0,0,0,0,0,0
	dc.w	0,1,0,2,0,3
	dc.w	REPEAT,0,4,100
	dc.w	RESTART
	dc.l	square_loop
	
Collect_Anim
	dc.w	MODE_SET,1<<Alien_Dead<<8
	dc.w	SPAWN
	dc.l	Score_Spawn
jax	dc.w	0,0
	dc.w	RESTART
	dc.l	jax
	
HedgeSleep_Anim
	dc.w	GFX,HedgeHog
	dc.w	SET,0
	dc.w	0,0
hedloop
	dc.w	0,0
	dc.w	RESTART
	dc.l	hedloop
		
HedgeKick_Anim
	dc.w	MODE_CLEAR,1<<Alien_Hit<<8
	dc.w	6,-3,6,-3,5,-3,5,-2,4,-1,4,-1,4,0,3,1,3,1,3,2,3,3,3,3,3,3	
	dc.w	3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
	dc.w	3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
	dc.w	3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
	dc.w	3,0,3,0,2,0,2,0,1,0,0,0,1,0,0,0
	dc.w	MODE_CLEAR,1<<Alien_Hit<<8
	dc.w	RESTART
	dc.l	hedgesleep_anim	
	
HedgeDie_Anim
	dc.w	0,1
	dc.w	RESTART
	dc.l	HedgeDie_Anim

hat_anim
	dc.w	GFX,ernie_Hat
	dc.w	SET,0
	include	"stus_code/pattern_data/smallblockspattern 3.s"
	dc.w	REPEAT,0,4,100
	dc.w	RESTART
	dc.l	hat_anim

springboard_anim
	dc.w	GFX,SPRINGBOARD
	dc.w	SET,0
springy
	dc.w	0,0
	dc.w	restart
	dc.l	springy
	
springboard_spring_anim
	dc.w	MODE_CLEAR,1<<Platform_Activate
	dc.w	FREEZE_PLAYER
spring_loop
	dc.w	SET,1,0,2
	dc.w	SET,2,0,3
	dc.w	SET,3,0,4
	dc.w	SET,4,0,2
	dc.w	SPRING_SQUIZ
	dc.w	FREEZE_PLAYER
	dc.w	SET,3,0,-2
	dc.w	SET,2,0,-4
	dc.w	SET,1,0,-3
	dc.w	SET,0,0,-2
	dc.w	MODE_SET,1<<Platform_Activate
	dc.w	RESTART
	dc.l	springboard_anim
	
hitstar_anim
	dc.w	GFX,hitstar	
	dc.w	SET,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	0,0
	dc.w	MODE_SET,1<<Alien_Dead<<8
hitstarloop	
	dc.w	0,0
	dc.w	restart
	dc.l	hitstarloop
star_pattern1
	dc.w	GFX,LUCKY_STAR,CYCLE,0,9,2
	include	"stus_code/pattern_data/starspattern 1.s"
starloop1
	dc.w	MODE_SET,1<<Alien_OffScreen<<8
	dc.w	0,0
	dc.w	restart
	dc.l	starloop1

star_pattern2
	dc.w	GFX,LUCKY_STAR,CYCLE,0,9,2
	include	"stus_code/pattern_data/starspattern 2.s"
	dc.w	restart
	dc.l	starloop1		

star_pattern3
	dc.w	GFX,LUCKY_STAR,CYCLE,0,9,2
	include	"stus_code/pattern_data/starspattern 3.s"
	dc.w	restart
	dc.l	starloop1		
star_pattern4
	dc.w	GFX,LUCKY_STAR,CYCLE,0,9,2
	include	"stus_code/pattern_data/starspattern 4.s"
	dc.w	restart
	dc.l	starloop1		
star_pattern5
	dc.w	GFX,LUCKY_STAR,CYCLE,0,9,2
	include	"stus_code/pattern_data/starspattern 5.s"
	dc.w	restart
	dc.l	starloop1		
