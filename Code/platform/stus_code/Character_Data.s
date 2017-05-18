****	Name, Graphics Pointer, Width in words, Height, Frames
****    \1    \2	  	\3	  	\4	\5
DEFINE_GRAPHICS		MACRO \1,\2,\3,\4,\5
\1	EQU	(*-Alien_Species)/Graphics_Size
	dc.l	\2
	dc.l	\2+\3*2*\4*\5*4
	dc.w	BYTES_PER_ROW-(\3+1)*2
	dc.w	\3
	dc.w	\4
	dc.l	\4*(\3*2)
	dc.l	\4*(\3*2)*\5
	dc.w	\4<<6+\3+1
	ENDM

	rsreset
Character_Standard	rs.l	1	; pointer to standard Anim
Character_Hit		rs.l	1       ; pointer to hit Anim
Character_Dead		rs.l	1	; pointer to death Anim
Character_Flags		rs.w	1	; what it does where
Character_Coll_Box_X	rs.w	1	; based on standard anim as this-
Character_Coll_Box_Y	rs.w	1	; is the only one (as yet)-
Character_Coll_Box_DX	rs.w	1	; where collision applies
Character_Coll_Box_DY	rs.w	1	

alien_test_height	rs.w	1
alien_test_width	rs.w	1
x_in		rs.w	1
y_in		rs.w	1		
character_height	rs.w	1
character_width		rs.w	1

Character_Control_Size	rs.w	1

Character_Control_Block

Ernie_Character	EQU	0
	dc.l	Ernie_Anim
	dc.l	Ernie_Hit
	dc.l	Null_Anim
	dc.w	(1<<Ground_Collision)<<8
	dc.w	1,1,15,30  	; full collision block (1 pixel in)
	dc.w	16	
	dc.w	8
	dc.w	4
	dc.w	4
	dc.w	28
	dc.w	16


Fish_Character	EQU 1
	dc.l	Fish_Anim
	dc.l	Fish_Die
	dc.l	Null_Anim
	dc.w	0
	dc.w	1,4,30,11
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

circle_platform_Character	EQU	2
	dc.l	circle_platform_Anim
	dc.l	null_anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform+(1<<Alien_Hit<<8)
	dc.w	0,0,46,10
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS


Diamond_Character	EQU 3
	dc.l	Square_Fall_Anim
	dc.l	Collect_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_OffScreen)<<8+1<<Alien_Bonus
	dc.w	0,0,14,14
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Cracked_Block_Character	EQU 4
	dc.l	Cracked_Block_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<Alien_OffScreen+1<<No_SaveBack)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Small_Block_Character	EQU 5
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<Alien_OffScreen)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Smoke_Character	EQU 6
	dc.l	Smoke_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<Alien_OffScreen)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Spawn_Character	EQU	7
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	0		  ; make sure spawns do not delete
	dc.w	10,1,16,26	  ; full collision block (1 pixel in)
	dc.w	0,0,0,0,0,0

Score_Character	EQU	8
	dc.l	Score_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<Alien_Offscreen)<<8
	dc.w	1,4,30,11
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

		
Hit_Block_Character	EQU 9
	dc.l	Block_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Offscreen+1<<Alien_Hit+1<<No_Saveback)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0

Platform2_Character	EQU	10
	dc.l	UpAndDown_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform
	dc.w	0,0,47,9
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

HedgeHog_Character	EQU	11
	dc.l	HedgeSleep_Anim
	dc.l	HedgeKick_Anim
	dc.l 	HedgeDie_Anim
	dc.w	(1<<Alien_Object)+1<<Ground_Collision<<8
	dc.w	0,0,15,15
	dc.w	12,12,2,2,12,16	  ; BOLLOCKS

Hat_Character	EQU	12
	dc.l	Hat_anim
	dc.l	HedgeKick_Anim
	dc.l 	HedgeDie_Anim
	dc.w	(1<<Alien_hit)<<8
	dc.w	0,0,15,15
	dc.w	12,12,2,2,12,0	  ; BOLLOCKS

Springboard_Character	EQU	13
	dc.l	springboard_anim
	dc.l	springboard_spring_anim
	dc.l 	Null_Anim
	dc.w	1<<Alien_Platform+1<<Platform_Activate
	dc.w	0,0,28,5
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

elevator_Character	EQU	14
	dc.l	Platform_still_Anim
	dc.l	elevator_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform+1<<Platform_Activate
	dc.w	0,0,47,9
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

LUCKY_STAR_Character	EQU 15
	dc.l	Null_Anim
	dc.l	Collect_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit)<<8
	dc.w	0,0,14,14
	dc.w	12,12,2,2,16,0 ; BOLLOCKS

SQUIZ_Character	EQU 16
	dc.l	squiz_Anim
	dc.l	squiz_hit
	dc.l	Null_Anim
	dc.w	(1<<Ground_Collision)<<8
	dc.w	0,0,47,53
	*dc.w	16,8,20,48,54 ; BOLLOCKS
	dc.w	15	;test height
	dc.w	15	;test width
	dc.w	16	;x in
	dc.w	52-15	;y in
	dc.w	54	;actual height
	dc.w	48

hitstar_Character	EQU 17
	dc.l	Hitstar_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<Alien_OffScreen)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Arrow_Up_Block_Character	EQU 18
	dc.l	Arrow_Up_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Arrow_left_Block_Character	EQU 19
	dc.l	Arrow_left_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Arrow_right_Block_Character	EQU 20
	dc.l	Arrow_Right_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Fido_Character	EQU 21
	dc.l	null_anim
	dc.l	null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Bonus
	dc.w	-27,0,27,54
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

BaseBallBat1	EQU 22
	dc.l	null_anim
	dc.l	null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit)<<8
	dc.w	18,0,11,7
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

BaseBallBat2	EQU 23
	dc.l	null_anim
	dc.l	null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit)<<8
	dc.w	18,0,11,7
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

BaseBallBat3	EQU 24
	dc.l	null_anim
	dc.l	Null_Anim
	dc.l	null_Anim
	dc.w	1<<Alien_Object
	dc.w	18,0,11,7
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Caterpillar_Character	EQU 25
	dc.l	null_anim
	dc.l	null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Master
	dc.w	0,0,38,33
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Caterpillar_Tail_Character	EQU 26
	dc.l	null_anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	0
	dc.w	0,0,33,25
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

CallButton_Character	EQU 27
	dc.l	CallButton_Anim
	dc.l	Press_CallButton_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform+1<<Platform_Activate		; not really platform
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0 ; BOLLOCKS

Baseball_Character	EQU 28
	dc.l	Baseball_Anim
	dc.l	Baseball_Frig_Anim
	dc.l	Baseball_Hit_Anim
	dc.w	1<<Alien_Object+1<<Alien_Offscreen<<8		; not really platform
	dc.w	0,0,9,9
	dc.w	9,0,3,0,9,9 ; BOLLOCKS

Log_Character	EQU	29
	dc.l	Log_Fall_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform+(1<<No_SaveBack+1<<Alien_OffScreen)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Goal_Character	EQU	30
	dc.l	Goal_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Hit<<8+1<<Alien_Master
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Balloon_Character	EQU	31
	dc.l	Balloon_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Hit<<8
	dc.w	0,0,0,0
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

LogHook_Character	EQU	32
	dc.l	LogHook_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform
	dc.w	0,5,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

GoalLog_Character	EQU	33
	dc.l	GoalLog_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS


Fruit_Character	EQU	34
	dc.l	Fruitblock_Anim1
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_OffScreen+1<<Alien_Hit)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

GlassBlock_Character	EQU	35
	dc.l	GlassBlock_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<No_SaveBack+1<<Alien_Hit)<<8+1<<Alien_Object
	dc.w	4,4,10,10
	dc.w	8,8,4,4,10,10	  ; BOLLOCKS

SmallGlassBlock_Character	EQU	36
	dc.l	GlassBlock_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_OffScreen+1<<Alien_Hit)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Fruitblock_Character1	EQU	37
	dc.l	Fruitblock_Anim1
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Fruitblock_Character2	EQU	38
	dc.l	Fruitblock_Anim2
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS
	
Fruitblock_Character3	EQU	39
	dc.l	Fruitblock_Anim3
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS
Fruitblock_Character4	EQU	40
	dc.l	Fruitblock_Anim4
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS
Fruitblock_Character5	EQU	41
	dc.l	Fruitblock_Anim5
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS
Fruitblock_Character6	EQU	42
	dc.l	Fruitblock_Anim6
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	(1<<Alien_Hit+1<<No_SaveBack)<<8
	dc.w	0,0,15,15
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS

Platform_Character	EQU	43
	dc.l	Platform_Anim
	dc.l	Null_Anim
	dc.l	Null_Anim
	dc.w	1<<Alien_Platform
	dc.w	0,0,47,9
	dc.w	0,0,0,0,0,0	  ; BOLLOCKS


Alien_Species	
	DEFINE_GRAPHICS ERNIE,Ernie_right_Graphics,1,28,4
	DEFINE_GRAPHICS ERNIE_LEFT,Ernie_left_Graphics,1,28,4
	DEFINE_GRAPHICS ERNIE_HAT,Erniehat_Graphics,1,9,1
	DEFINE_GRAPHICS ERNIE_HAT_LEFT,Erniehat_left_Graphics,1,9,1
	
	DEFINE_GRAPHICS	FISH,FISH_right_Graphics,2,19,3
	DEFINE_GRAPHICS	FISH_LEFT,FISH_left_Graphics,2,19,3
	DEFINE_GRAPHICS	SQUIZ,squiz_right_Graphics,3,54,3
	DEFINE_GRAPHICS	SQUIZ_LEFT,squiz_left_Graphics,3,54,3
	
	DEFINE_GRAPHICS	HIT_BLOCK_G,Hit_Block_Graphics,1,16,2
	DEFINE_GRAPHICS	SQUARE,Square_Graphics,1,16,6
	DEFINE_GRAPHICS	CRACKED_BLOCK,Cracked_Graphics,1,16,1
	DEFINE_GRAPHICS	SMALL_BLOCK,SmallBlock_Graphics,1,8,1
	DEFINE_GRAPHICS	SMOKE,Smoke_Graphics,1,6,4
	DEFINE_GRAPHICS	SCORE,SCORE_Graphics,1,12,13
	DEFINE_GRAPHICS	Platform,Platform_Graphics,3,11,1
	DEFINE_GRAPHICS Diamond,Diamond_Graphics,1,16,1
	DEFINE_GRAPHICS	Hedgehog,Hedgehog_graphics,1,14,1
	DEFINE_GRAPHICS	HedgehogDummy,Hedgehog_graphics,1,14,1
	DEFINE_GRAPHICS	SPRINGBOARD,springboard_graphics,2,20,5
	DEFINE_GRAPHICS LUCKY_STAR,luckystar_graphics,1,16,10
	DEFINE_GRAPHICS ELEVATOR,elevator_graphics,3,10,2
	DEFINE_GRAPHICS HITSTAR,hitstar_graphics,1,16,1
	DEFINE_GRAPHICS ARROW_BLOCK,arrow_block_graphics,1,16,3
	DEFINE_GRAPHICS	CALLBUTTON,callbutton_graphics,1,16,1
	DEFINE_GRAPHICS	BASEBALL,baseball_graphics,1,9,4
	DEFINE_GRAPHICS	BASEBALL_LEFT,baseball_graphics,1,9,4
	DEFINE_GRAPHICS	LOG,log_graphics,1,16,1
	DEFINE_GRAPHICS	GOAL,goal_graphics,2,8,4
	DEFINE_GRAPHICS	BALLOON,balloon_graphics,1,36,1
	DEFINE_GRAPHICS	LOGHOOK,loghook_graphics,1,20,1
	DEFINE_GRAPHICS	LOGHOOK_LEFT,loghook_left_graphics,1,20,1
	DEFINE_GRAPHICS	FRUITBLOCK,fruitblock_graphics,1,16,1
	DEFINE_GRAPHICS	FRUIT,fruit_graphics,1,16,5	
	DEFINE_GRAPHICS	GLASSBLOCK,glassblock_graphics,1,16,2
	DEFINE_GRAPHICS	GLASSBLOCK_LEFT,glassblock_graphics,1,16,2
	DEFINE_GRAPHICS	SMALLGLASSBLOCK,smallglassblock_graphics,1,8,4
	DEFINE_GRAPHICS LOGLINK,loglink_graphics,1,15,1
	DEFINE_GRAPHICS	ANTI_CRASH_DUMMY,Hedgehog_graphics,1,14,1

loglink_graphics
	incbin	"graphics/loglink.bin"
glassblock_graphics
	incbin	"graphics/glassblock.bin"
smallglassblock_graphics	
	incbin	"graphics/smallglassblock.bin"
fruit_graphics
	incbin	"graphics/fruits.bin"
fruitblock_graphics	
	incbin	"graphics/fruitblock.bin"		
goal_graphics
	incbin	"graphics/goalcycle.bin"
balloon_graphics
	incbin	"graphics/balloon.bin"
loghook_graphics
	incbin	"graphics/loghookr.bin"
loghook_left_graphics
	incbin	"graphics/loghookl.bin"
	
log_graphics
	incbin	"graphics/log.bin"	
callbutton_graphics
	incbin	"graphics/callbutton.bin"
	
caterpillar_head_graphics
	incbin	"graphics/caterpillarhead.bin"
	
caterpillar_tail_graphics
	incbin	"graphics/caterpillartail.bin"

baseballbat_graphics
	incbin	"graphics/baseballbat.bin"
	
baseball_graphics
	incbin	"graphics/baseball.bin"	

fido_graphics
	incbin	"graphics/fido.bin"

arrow_block_graphics
	incbin	"graphics/arrowblocks.bin"
hitstar_graphics
	incbin	"graphics/hitsta.bin"
	
squiz_left_graphics
	incbin	"graphics/squizalienleft.bin"
squiz_right_graphics
	incbin	"graphics/squizalienright.bin"
elevator_graphics
	incbin	"graphics/elevator.bin"
luckystar_graphics
	incbin	"graphics/luckystar.bin"
springboard_graphics	
	incbin	"graphics/springboard.bin"

ErnieHat_left_graphics
	incbin	"graphics/hatleft.bin"
ErnieHat_Graphics
	incbin	"graphics/hat.bin"
Hedgehog_graphics
	incbin	"graphics/hedgehog.bin"
	even	
Platform_graphics
	incbin	"graphics/logplatform.bin"
	even	
fish_left_graphics
	incbin	"graphics/afishleft.bin"
	even	
fish_Right_graphics
	incbin	"graphics/afishright.bin"
	even	

Ernie_Right_graphics
	incbin	"graphics/ernie.bin"
	even	
Ernie_left_graphics
	incbin	"graphics/ernieleft.bin"
	even	
Score_Graphics
	incbin	"graphics/scores.bin"
	even	
Smoke_Graphics
	incbin	"graphics/smoke.bin"
	even

SmallBlock_Graphics
	incbin	"graphics/smallblock.bin"
	even

Cracked_Graphics
	incbin	"graphics/crackedblock.bin"
	even

Square_Graphics
	incbin	"graphics/squarerotation.bin"
	even	

Diamond_Graphics
	incbin	"graphics/diamond.bin"
	even	

Squiz_Alien_Graphics
	incbin	"graphics/squizalien.bin"
	even
	
Hit_Block_Graphics
	incbin  "graphics/alienhitblock.bin"
	even