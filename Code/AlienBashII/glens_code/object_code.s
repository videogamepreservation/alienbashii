

*General bullet and alien commands

START_COMMANDS		EQU	49

OBJECT_SET_PAT		EQU	51
*	- Followed by dc.l <pattern>
*	- Loop round

OBJECT_FRAME_SET	EQU	52
*	- Followed by dc.w <frame>
*	- Loop round
	
OBJECT_KILL		EQU	53
*	- Followed by nothing
*	- Dont loop
	
OBJECT_ADD		EQU	54
*	- Followed by dc.w	<x inc>
*		      dc.w	<y inc>
*	              dc.w	<Alien Species Number>
*	- Loop

OBJECT_SIMPLE_ADD	EQU	55
*	- Followed by dc.w	<x inc>
*		      dc.w	<y inc>
*	              dc.l	<Alien Species Struct>
*	- Loop


OBJECT_BULLET_ADD	EQU	56
*	- Followed by dc.w	<x inc>
*		      dc.w	<y inc>
*	              dc.w	<Bullet Species Number>   (diff from Alien)
*	- Loop

OBJECT_PATTERN_RESTART	EQU	57
*	- Followed by nothing
*	- Loop

OBJECT_SOUND_EFFECT_1	EQU	58
*	- Followed by dc.w	<sound effect number>
*	- Loop round
	
OBJECT_SOUND_EFFECT_2	EQU	59
*	- Followed by dc.w	<sound effect number>
*	- Loop round
	
OBJECT_SOUND_EFFECT_3	EQU	60
*	- Followed by dc.w	<sound effect number>
*	- Loop round
	
OBJECT_SOUND_EFFECT_4	EQU	61
*	- Followed by dc.w	<sound effect number>
*	- Loop round

OBJECT_EXECUTE_CODE	EQU	62
*	- Followed by dc.l	<routine to call>
*	- Loop round

OBJECT_SIMPLE_ADD_LOTS	EQU	63
*	- Followed by dc.w	<x offset>
*	- Followed by dc.w	<y offset>
*	- Followed by dc.l	<Simple Object Struct>
*	-     ....
*	- Until 		<ffffffff>		
OBJECT_SET_COUNTER	EQU	64
*	- Followed by dc.w	<num>

OBJECT_UNTIL		EQU	65
*	- Followed by dc.l	<pattern pos to jump back to>

OBJECT_HIT_PATTERN_RESTART	EQU	66
*	- Loop

OBJECT_DONT_GO_ANYWHERE		EQU	67
*	Followed by nothing

OBJECT_STOP_ANIM		EQU	68
*	Followed by nothing

OBJECT_START_ANIM		EQU	69
*	-Followed by nothing

OBJECT_SIMPLE_ADD_TRANSFORM	EQU	70
*	- As simple ADD except new-alien = old alien map wise

OBJECT_UPDATE_SCORE		EQU	71
*	- Followed by	dc.w	<score to add>

OBJECT_ATTACH_X		EQU	72
*	- Followed by nothing

OBJECT_KILL_ATTACHED_OBJECT		EQU	73
*	- Followed by nothing

OBJECT_SIMPLE_ADD_CONNECT	EQU	74
*	- As simple ADD except pointer in each struct to each other

OBJECT_ATTACH_Y		EQU	75
*	- Followed by nothing

OBJECT_ATTACH_BOTH_XY		EQU	76
*	- Followed by nothing

OBJECT_DECREASE		EQU	77
*	- Followed by dc.l	- shall decrease by 1

OBJECT_TEST		EQU	78
*	- Followed by   dc.l    - address of thing to test
*	-               dc.w	- value to test
*	-	        dc.l	where to go if test is true

OBJECT_INCREASE		EQU	79
*	- Followed by   dc.l	- address of thing to inc by 1

OBJECT_RANDOM_PIG_SQUEAL EQU	80
*	- Followed by nothing

OBJECT_PUT_IN_MAP	EQU	81
*	- Followed by nothing - burns itself into map at current location

OBJECT_RESTART_PATTERN_SKIP_POS EQU 82
*	- followed by nought

OBJECT_CHECK_DISTANCE	EQU	83
*	- followed by dc.w	- check value
*		      dc.l	- where to jump if true
OBJECT_START_SCRIPT	EQU	84
*	- followed by dc.l	- pointer to var holding script address
OBJECT_WAVE_TEST	EQU	85
*	- followed by dc.l	- pointer to script to jump if not equal to script counter
OBJECT_SIMPLE_ADD_WAVE_TRANSFER	equ	86
*	- same as transform
OBJECT_BURN_BLOCK		equ	87
*	- followed by dc.w	blok num
OBJECT_ACTIVATE_SCRIPT		equ	88
*	-followed by address of script
OBJECT_CHECK_HITS		equ	89
*	-followed by dc.w	hits to compare
*		     dc.l	address of script to go if not equal
OBJECT_SET_RANDOM_COUNTER	equ	90
*	-followed by dc.w	min value
*		     dc.w	max value

OBJECT_SET_DIRECTION		EQU	91
*	-followed by dc.w	<direction>

OBJECT_SET_VARIABLE		EQU	92
*	-followed by dc.l	<var>
*	- dc.w		<value>

OBJECT_BLOW_UP_ATTACHED		EQU	93
*	- followed by nothing

OBJECT_TRANSFORM_BOTCH		EQU	94
*	- dc.l		<alien>

OBJECT_TRANSFORM_PATTERN	EQU	95
*	- dc.l		<alien>	
*	- dc.l		<pattern>

OBJECT_CHANGE_TYPE		EQU	96
*	- dc.l		<new type ptr>