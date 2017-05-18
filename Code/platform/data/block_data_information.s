***************************************************
********* BLOCK DATA INFORMATION FILE     *********
***************************************************


**************Block types*************************

STANDARD	EQU	0
FILLER		EQU 	1
SLOPE_UP	EQU 	2
SLOPE_DOWN	EQU 	3
BUMP_BLOCK	EQU	4
KNOCK_BLOCK	EQU	5
EXPLODE_BLOCK	EQU	6
INFO_BLOCK	EQU	7
JUMP_BLOCK	EQU	8
FIRE_BLOCK	EQU	9
ARROW_UP	EQU	10
ARROW_LEFT	EQU	11
ARROW_RIGHT	EQU	12
FIN_BLOCK	EQU	13
FALL_LOG	EQU	14
FRUIT_BONUS5	EQU	15
FRUIT_BONUS4	EQU	16
FRUIT_BONUS3	EQU	17
FRUIT_BONUS2	EQU	18
FRUIT_BONUS1	EQU	19
FRUIT_BONUS0	EQU	20
BALL_IN_GLASS_BLOCK	EQU	21
*other flags
SOLID		EQU 	0
JUMPTHROUGH	EQU 	1


*bits to test in code

SLOPE_FLAG		EQU 0
X_COLLISION_FLAG	EQU 1
Y_COLLISION_FLAG	EQU 2
HEAD_BUTT_FLAG		EQU 3


*bits to set in structure

SLOPE_BLOCK		EQU 1	
X_COLLISION_ON		EQU 2
Y_COLLISION_ON		EQU 4
HEAD_BUTT_ON		EQU 8
FILLER_BLOCK		EQU 16	
	
BLOCK_STRUCT_MULT	EQU	3	(for asl)	


	rsreset	

block_type	 rs.b	1
block_details	 rs.b	1
position_data	 rs.l	1	;if slope pointer to data else use first word for data
jump_through	 rs.b	1
velocity	 rs.b	1
	EVEN

block_data_information
blocks0to10
blank_block
	ds.b	8*11

BLUE_BLOCK	EQU	11

metal_block11	
	dc.b	KNOCK_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16		
	dc.b	SOLID,0

starblock12
	dc.b	BUMP_BLOCK,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0
	
metal_block13
	dc.b	KNOCK_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16		
	dc.b	SOLID,0
	
	
fireblocks14
	dc.b	FIRE_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0
	
fireblock15
	dc.b	FIRE_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

exploding_block16
	dc.b	EXPLODE_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

ARROW_UP_NUM	EQU	17
ARROW_DOWN_NUM	EQU 	18
ARROW_LEFT_NUM	EQU	19
ARROW_RIGHT_NUM	EQU	31

arrow_block_up17
	dc.b	ARROW_UP,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

arrow_block_down18
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

arrow_block_left19
	dc.b	ARROW_LEFT,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0



blocks20to30
	ds.b	8*11

arrow_block_right31
	dc.b	ARROW_RIGHT,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0



water_top32
	dc.b	0,0
	dc.l	0
	dc.b	0,0

water_body33
	dc.b	0,0
	dc.l	0
	dc.b	0,0

sand_block34
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

log_block35	
	dc.b	FALL_LOG,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

BORING_BLOCK	EQU	36

moresolidblocks36
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0
soldidblocks37
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0


textwindow_block38
	dc.b	INFO_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

ring_block39
	dc.b	0,0
	dc.l	0
	dc.b	0,0



blocks40to50
	ds.b	8*11



block51jumpblock
	dc.b	JUMP_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

spike52
	dc.b	FIRE_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

goal153
	dc.b	FIN_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

goal254
	dc.b	FIN_BLOCK,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

alien_bump_block55
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

earth56
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank57	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0

	
blank58;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0

ballinblock59
	dc.b	BALL_IN_GLASS_BLOCK,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0

	
	

blocks60to70
	ds.b	8*11

blank71
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank72
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank73
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank74
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank75
	dc.b	0,0
	dc.l	0
	dc.b	0,0
	
frigblock76	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0

block77
	dc.b	SLOPE_UP,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope45up
	dc.b	JUMPTHROUGH,-8
	
block78
	dc.b	SLOPE_DOWN,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope45down
	dc.b	JUMPTHROUGH,8
	
frigblock79	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0
	

blocks80to90
	ds.b	8*11

blank91
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank92
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank93
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank94
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank95
	dc.b	0,0
	dc.l	0
	dc.b	0,0

block96
	dc.b	SLOPE_UP,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope45up
	dc.b	JUMPTHROUGH,-8

slope97upfiller
	dc.b	SLOPE_UP,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	slope45upfillerdata
	dc.b	JUMPTHROUGH,-5
	
block98filler
	dc.b	SLOPE_DOWN,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	slope45downfillerdata
	dc.b	JUMPTHROUGH,8

	
block99
	dc.b	SLOPE_DOWN,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope45down
	dc.b	JUMPTHROUGH,8



blocks100to110
	ds.b	8*11

blank111
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank112
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank113
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank114
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank115
	dc.b	0,0
	dc.l	0
	dc.b	0,0


slope116upfiller
	dc.b	SLOPE_UP,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	slope45upfillerdata
	dc.b	JUMPTHROUGH,-5
	
blank117
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank118
	dc.b	0,0
	dc.l	0
	dc.b	0,0

block119filler
	dc.b	SLOPE_DOWN,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	slope45downfillerdata
	dc.b	JUMPTHROUGH,8


blocks120to130
	ds.b	8*11

blank131
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank132
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank133
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank134
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank135
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank136
	dc.b	0,0
	dc.l	0
	dc.b	0,0

	
frigblock137	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0
	
	
frigblock138	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0
	

blank139
	dc.b	0,0
	dc.l	0
	dc.b	0,0


blocks140to150
	ds.b	8*11

blank151
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank152
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank153
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank154
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0

blank155
	dc.b	0,0
	dc.l	0
	dc.b	0,0

slopemildup156

	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope1a
	dc.b	JUMPTHROUGH,-5
slopemildup157
	
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope1b
	dc.b	JUMPTHROUGH,-5


slopemilddown158
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope1adown
	dc.b	JUMPTHROUGH,5
slopemilddown159
	
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope1bdown
	dc.b	JUMPTHROUGH,5


blocks160to170
	ds.b	8*11

blank171
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank172
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank173
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank174
	dc.b	0,X_COLLISION_ON+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0


blank175
	dc.b	0,0
	dc.l	0
	dc.b	0,0


mildslopeupfiller176
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,-5

mildslopeupfiller177
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,-5

mildslopedownfiller178
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,5

mildslopedownfiller179
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,5

treestump180
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0
	
treestump181
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0

treestump182
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0
	


blocks183to189
	ds.b	8*7

blank190
	dc.b	0,0
	dc.l	0
	dc.b	0,0


blank191
	dc.b	0,0
	dc.l	0
	dc.b	0,0


blank192
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank193
	dc.b	0,X_COLLISION+Y_COLLISION_ON
	dc.l	16
	dc.b	SOLID,0



blank194
	dc.b	0,0
	dc.l	0
	dc.b	0,0


	
blank195
	dc.b	0,0
	dc.l	0
	dc.b	0,0

frigblock196	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0
	
frigblock197	;frig		;above slope blocks - for when running down
	dc.b	0,SLOPE_BLOCK
	dc.l    fillertest2
	dc.b	JUMPTHROUGH,0
	

blank198
	dc.b	0,0
	dc.l	0
	dc.b	0,0
	
blank199
	dc.b	0,0
	dc.l	0
	dc.b	0,0


blocks200to208
	ds.b	8*9
	
FRUIT_FINAL_BLOCK	EQU	209	
	
fruit_block_final209	
	dc.b	FRUIT_BONUS0,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0

	
blank210
	dc.b	0,Y_COLLISION_ON
	dc.l	16
	dc.b	JUMPTHROUGH,0



blank211
	dc.b	0,Y_COLLISION_ON
	dc.l	16
	dc.b	JUMPTHROUGH,0



blank212
	dc.b	0,Y_COLLISION_ON
	dc.l	16
	dc.b	JUMPTHROUGH,0
	
blank213
	dc.b	0,0
	dc.l	0
	dc.b	0,0
	

verymildslopeup214
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2a
	dc.b	JUMPTHROUGH,-4
verymildslopeup215
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2b
	dc.b	JUMPTHROUGH,-4
verymildslopeup216
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2c
	dc.b	JUMPTHROUGH,-4

verymildslopeup217
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2adown
	dc.b	JUMPTHROUGH,4
verymildslopeup218
	
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2bdown
	dc.b	JUMPTHROUGH,4
	
verymildslopeup219
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON
	dc.l	slope2cdown
	dc.b	JUMPTHROUGH,4


treestump220
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0
	
treestump221
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0

treestump222
	dc.b	0,Y_COLLISION_ON+X_COLLISION
	dc.l	16
	dc.b	SOLID,0
	



blocks223to226
	ds.b	8*4

FRUIT_BLOCK1	EQU	227
FRUIT_BLOCK2	EQU	228
FRUIT_BLOCK3	EQU	229
FRUIT_BLOCK4	EQU	230
FRUIT_BLOCK5	EQU	231



fruit_block_227
	dc.b	FRUIT_BONUS1,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0


fruit_block228	
	dc.b	FRUIT_BONUS2,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0

fruit_block229
	dc.b	FRUIT_BONUS3,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0

fruit_block230
	dc.b	FRUIT_BONUS4,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0

	
fruit_block231
	dc.b	FRUIT_BONUS5,X_COLLISION_ON+Y_COLLISION_ON+HEAD_BUTT_ON
	dc.l	16		
	dc.b	SOLID,0



blank232
	dc.b	0,0
	dc.l	0
	dc.b	0,0

blank233
	dc.b	0,0
	dc.l	0
	dc.b	0,0

verymildslopefiller234
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4

verymildslopefiller235

	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4
	
verymildslopefiller236
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4

verymildslopefiller237
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4

verymildslopefiller238

	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4
	
verymildslopefiller239
	dc.b	0,SLOPE_BLOCK+Y_COLLISION_ON+FILLER_BLOCK
	dc.l	fillertest
	dc.b	JUMPTHROUGH,4


fillup_left_over_blocks
	ds.b	8*16


	
slope45down
	dc.w	16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,1
	
slope45up
	dc.w	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

slope45upfillerdata
	dc.w	17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
	
slope45downfillerdata
	dc.w	32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17	
	
fillertest
	dcb.w	17,17

fillertest2
	dcb.w	17,-1	
	dc.w	-1,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2
slope1a
	dc.w	1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8
slope1b
	dc.w	9,9,10,10,11,11,12,12,13,13,14,14,15,15,16,16

slope2a
	dc.w	1,1,2,2,2,3,3,4,4,4,4,5,5,5,6,6	
slope2b
	dc.w	6,6,7,7,8,8,8,9,9,9,9,10,10,10,11,11
slope2c
	dc.w	11,12,12,12,13,13,13,14,14,14,14,15,15,15,16,16
	

slope1adown
	dc.w	16,16,15,15,14,14,13,13,12,12,11,11,10,10,9,9
slope1bdown
	dc.w	8,8,7,7,6,6,5,5,4,4,3,3,2,2,1,1

slope2adown	
	dc.w	16,16,15,15,14,14,14,14,13,13,13,12,12,12,11
slope2bdown
	dc.w	11,11,10,10,10,9,9,9,9,8,8,8,7,7,6,6
slope2cdown
	dc.w	6,6,5,5,5,4,4,4,4,3,3,2,2,2,1,1
	
	
arse
	dc.w	-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16