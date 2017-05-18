
BLOCK_STRUCT_MULT	EQU	1

FIRST_SWITCH_BLOCK	EQU	380
FIRST_EVENT_BLOCK	EQU	320
DOOR_ACTIVATE_BLOCK	EQU	401
CHEST_SOLID_BLOCK	EQU	400

*block types - for standing on - between 0 and 15

NULL_BLOCK		EQU	0
Wood_Block		EQU	1
Gem_Block		EQU	2
Star_Block		EQU	3
Shield_Block		EQU	4
Switch_Block		EQU	5
Activate_Block		EQU	6
Activate_Door_Block	EQU	7
Activate_Door_Block2	EQU	8
Activate_Big_Door_Block	EQU	9
Check_For_Hostages	EQU	10


*block types for shooting - hi nybble data

Empty_Pot		EQU	1<<4
Bullet_Switch1		EQU	2<<4	;first 4 switches
Bullet_Switch2		EQU	3<<4
Bullet_Switch3		EQU	4<<4
Bullet_Switch4		EQU	5<<4
Pot_Gold_Coin		EQU	6<<4
Pot_Silver_Coin		EQU	7<<4
Pot_Explosion		EQU	8<<4
Pot_Maggot		EQU	9<<4	;relative of pot noddle
Pot_Energy		EQU	10<<4
Wall_Gold_Coin		EQU	11<<4
Wall_Silver_Coin	EQU	12<<4
Wall_Double_Silver	EQU	13<<4
Wall_Potion		EQU	14<<4
Chink_Block		EQU	15<<4
*block attrib flags

BLOCK_SOLID	EQU	1
BLOCK_WATER	EQU	2
BLOCK_CHAIN	EQU	4
EXPLODE_BLOCK	EQU	8
BULLET_KILL	EQU	16
*block test flags

COLLISION_FLAG	EQU	0
WATER_FLAG	EQU	1
CHAIN_FLAG	EQU	2
EXPLODE_BLOCK_FLAG EQU	3
BULLET_DIE_FLAG	EQU	4


	rsreset
	
block_details	rs.b	1
block_type	rs.b	1
	even
	
	
block_data_information

block0
	dc.b	0
	dc.b	NULL_BLOCK	
	
block1
	dc.b	0
	dc.b	NULL_BLOCK
	
block2
	dc.b	0
	dc.b	NULL_BLOCK		

block3
	dc.b	0
	dc.b	NULL_BLOCK			

block4
	dc.b	0
	dc.b	NULL_BLOCK			
	
block5
	dc.b	0
	dc.b	NULL_BLOCK

block6
	dc.b	0
	dc.b	NULL_BLOCK

block7
	dc.b	0
	dc.b	NULL_BLOCK

block8
	dc.b	0
	dc.b	NULL_BLOCK	
	
block9
	dc.b	0
	dc.b	NULL_BLOCK		

block10
	dc.b	0
	dc.b	NULL_BLOCK		

block11
	dc.b	0
	dc.b	NULL_BLOCK		
	
block12
	dc.b	0
	dc.b	NULL_BLOCK	
	
block13
	dc.b	0
	dc.b	NULL_BLOCK		

block14
	dc.b	0
	dc.b	NULL_BLOCK		

block15
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block16
	dc.b	BLOCK_SOLID+BULLET_KILL		;+BLOCK_CHAIN	;door
	dc.b	NULL_BLOCK	
	
block17
	dc.b	BLOCK_SOLID+BULLET_KILL		;+BLOCK_CHAIN	;door
	dc.b	NULL_BLOCK		

block18
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block19
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK				
	
block20
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block21
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block22
	dc.b	0
	dc.b	NULL_BLOCK		

block23
	dc.b	0
	dc.b	NULL_BLOCK			

block24
	dc.b	0
	dc.b	NULL_BLOCK			
	
block25
	dc.b	0
	dc.b	NULL_BLOCK

block26
	dc.b	0
	dc.b	NULL_BLOCK

block27
	dc.b	0
	dc.b	NULL_BLOCK

block28
	dc.b	0
	dc.b	NULL_BLOCK	
	
block29
	dc.b	0
	dc.b	NULL_BLOCK		

block30
	dc.b	0
	dc.b	NULL_BLOCK		

block31
	dc.b	0
	dc.b	NULL_BLOCK		
	
block32
	dc.b	0
	dc.b	NULL_BLOCK	
	
block33
	dc.b	0
	dc.b	NULL_BLOCK	

block34
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block35
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block36
	dc.b	BLOCK_SOLID+BULLET_KILL	;+BLOCK_CHAIN	;door
	dc.b	NULL_BLOCK	
	
block37
	dc.b	BLOCK_SOLID+BULLET_KILL	;+BLOCK_CHAIN	;door
	dc.b	NULL_BLOCK		

block38
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block39
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK				
	
block40
	dc.b	BLOCK_SOLID	;Top Of Bush1
	dc.b	NULL_BLOCK	
	
block41
	dc.b	BLOCK_SOLID	;Top Of Bush1
	dc.b	NULL_BLOCK		

block42
	dc.b	0
	dc.b	NULL_BLOCK		
	
block43
	dc.b	0
	dc.b	NULL_BLOCK	
	
block44
	dc.b	0
	dc.b	NULL_BLOCK		

block45
	dc.b	0
	dc.b	NULL_BLOCK		

block46
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block47
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block48
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block49
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block50
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK				
		
block51
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block52
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block53
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block54
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block55
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block56
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block57
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block58
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block59
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block60
	dc.b	BLOCK_SOLID	;Bottom Of Bush1
	dc.b	NULL_BLOCK	
	
block61
	dc.b	BLOCK_SOLID	;Bottom Of Bush1
	dc.b	NULL_BLOCK		

block62
	dc.b	0
	dc.b	NULL_BLOCK		
	
block63
	dc.b	0
	dc.b	NULL_BLOCK	
	
block64
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block65
	dc.b	0
	dc.b	NULL_BLOCK		

block66
	dc.b	0
	dc.b	NULL_BLOCK			
	
block67
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block68
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block69
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		


block70
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block71
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block72
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block73
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block74
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block75
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block76
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK			
	
block77
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block78
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block79
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block80
	dc.b	0
	dc.b	NULL_BLOCK	
	
block81
	dc.b	0
	dc.b	NULL_BLOCK		

block82
	dc.b	0
	dc.b	NULL_BLOCK		
	
block83
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Wall_Silver_Coin
	
block84
	dc.b	0
	dc.b	NULL_BLOCK		

block85
	dc.b	0
	dc.b	NULL_BLOCK		

block86
	dc.b	0
	dc.b	NULL_BLOCK			
	
block87
	dc.b	0
	dc.b	NULL_BLOCK	
	
block88
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block89
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			

block90
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block91
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block92
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
	
block93
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block94
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block95
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block96
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Bullet_Switch2
	
block97
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Bullet_Switch3
	
block98
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block99
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block100
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block101
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block102
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block103
	dc.b	0
	dc.b	NULL_BLOCK	
	
block104
	dc.b	0
	dc.b	NULL_BLOCK		

block105
	dc.b	0
	dc.b	NULL_BLOCK	

block106
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block107
	dc.b	0
	dc.b	NULL_BLOCK	
	
block108
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block109
	dc.b	0
	dc.b	NULL_BLOCK		
	
block110
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block111
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block112
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
	
block113
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block114
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block115
	dc.b	BLOCK_SOLID+BULLET_KILL		;+BLOCK_CHAIN+EXPLODE_BLOCK
	dc.b	NULL_BLOCK		

block116
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block117
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block118
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block119
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK			
	
block120
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block121
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block122
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block123
	dc.b	0
	dc.b	NULL_BLOCK	
	
block124
	dc.b	0			;pentagram middle
	dc.b	Check_For_Hostages		
		
block125
	dc.b	0
	dc.b	NULL_BLOCK		

block126
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK			
	
block127
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block128
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block129
	dc.b	BLOCK_SOLID+BULLET_KILL	;left over block
	dc.b	NULL_BLOCK
	
block130
	dc.b	0
	dc.b	NULL_BLOCK	
	
block131
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block132
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
	
block133
	dc.b	BLOCK_SOLID		;	dc.b	BLOCK_SOLID+BULLET_KILL+BLOCK_CHAIN
	dc.b	NULL_BLOCK	
	
block134
	dc.b	BLOCK_SOLID			;	dc.b	BLOCK_SOLID+BULLET_KILL+BLOCK_CHAIN
	dc.b	NULL_BLOCK		

block135
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block136
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block137
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block138
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK		

block139
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block140
	dc.b	BLOCK_SOLID+BULLET_KILL			;dc.b	BLOCK_SOLID+BULLET_KILL+EXPLODE_BLOCK+SPLIT_BLOCK
	dc.b	NULL_BLOCK	
	
block141
	dc.b	BLOCK_SOLID				;K_SOLID+BULLET_KILL+BLOCK_CHAIN	
	dc.b	NULL_BLOCK		

block142
	dc.b	0			;BLOCK_SOLID+BULLET_KILL+BLOCK_CHAIN+EXPLODE_BLOCK
	dc.b	NULL_BLOCK		
	
block143
	dc.b	0
	dc.b	NULL_BLOCK	
	
block144
	dc.b	0
	dc.b	NULL_BLOCK		

block145
	dc.b	0
	dc.b	NULL_BLOCK		

block146
	dc.b	0
	dc.b	NULL_BLOCK			
	
block147
	dc.b	0
	dc.b	NULL_BLOCK	
	
block148
	dc.b	0
	dc.b	NULL_BLOCK		

block149
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK						


block150
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block151
	dc.b	0
	dc.b	NULL_BLOCK

block152
	dc.b	0
	dc.b	NULL_BLOCK
	
block153
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block154
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block155
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block156
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block157
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Empty_Pot
	
block158
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Empty_Pot		

block159
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Empty_Pot
	
block160
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block161
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block162
	dc.b	0
	dc.b	NULL_BLOCK		
	
block163
	dc.b	0
	dc.b	NULL_BLOCK	
	
block164
	dc.b	0
	dc.b	NULL_BLOCK		

block165
	dc.b	0
	dc.b	NULL_BLOCK		

block166
	dc.b	0
	dc.b	NULL_BLOCK			
	
block167
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block168
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Bullet_Switch1

block169
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block170
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
	
block171
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block172
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block173
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block	
	
block174
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block175
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block176
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block177
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Wall_Double_Silver
		
block178
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Wall_Potion

block179
	dc.b	0
	dc.b	Activate_Door_Block								
	
block180
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block181
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block182
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK		
	
block183
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block184
	dc.b	0
	dc.b	NULL_BLOCK		

block185
	dc.b	0
	dc.b	NULL_BLOCK		

block186
	dc.b	0
	dc.b	NULL_BLOCK			
	
block187
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block188
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block189
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block190
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
	
block191
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block192
	dc.b	BLOCK_SOLID+BULLET_KILL		
	dc.b	NULL_BLOCK
	
block193
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
	
block194
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block195
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block196
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block197
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block198
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Gold_Coin

block199
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Explosion

	
block200
	dc.b	0
	dc.b	NULL_BLOCK	
	
block201
	dc.b	0
	dc.b	NULL_BLOCK		

block202
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK		
	
block203
	dc.b	0
	dc.b	NULL_BLOCK	
	
block204
	dc.b	0
	dc.b	NULL_BLOCK		

block205
	dc.b	0
	dc.b	NULL_BLOCK		

block206
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block207
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block208
	dc.b	0
	dc.b	NULL_BLOCK		

block209
	dc.b	0
	dc.b	NULL_BLOCK		;Switch up
	

block210
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block211
	dc.b	0
	dc.b	Activate_Door_Block		

block212
	dc.b	0		
	dc.b	Activate_Door_Block2
		
block213
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block214
	dc.b	0
	dc.b	NULL_BLOCK		

block215
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block216
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block217
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block218
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Silver_Coin		

block219
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Explosion			
	
block220
	dc.b	0
	dc.b	NULL_BLOCK	
	
block221
	dc.b	0
	dc.b	NULL_BLOCK		

block222
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block223
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block224
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK		

block225
	dc.b    0
	dc.b	NULL_BLOCK		

block226
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			
	
block227
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block228
	dc.b	0
	dc.b	NULL_BLOCK		

block229
	dc.b	0
	dc.b	NULL_BLOCK
	
block230
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block231
	dc.b	0
	dc.b	NULL_BLOCK

block232
	dc.b	0
	dc.b	NULL_BLOCK
	
block233
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block234
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block235
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block236
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block237
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block238
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block239
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Maggot		
	
block240
	dc.b	0
	dc.b	NULL_BLOCK	
	
block241
	dc.b	0
	dc.b	NULL_BLOCK		

block242
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block243
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block244
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block

block245
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block		

block246
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block			
	
block247
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block	
	
block248
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block249
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block250
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block	
	
block251
	dc.b	0
	dc.b	NULL_BLOCK		

block252
	dc.b	0
	dc.b	NULL_BLOCK		
	
block253
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block	
	
block254
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block255
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		

block256
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK			
	
block257
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block258
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block259
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Pot_Energy

block260
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block261
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block262
	dc.b	0
	dc.b	NULL_BLOCK
block263
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
block264
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
block265
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
block266
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
block267
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
block268
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
block269
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
block270
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block
block271
	dc.b	0
	dc.b	NULL_BLOCK

block272
	dc.b	0
	dc.b	NULL_BLOCK
block273
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block			
block274
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
block275
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
block276
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
block277
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
block278
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK			
block279
	dc.b	0
	dc.b	NULL_BLOCK		
block280
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
block281
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
block282
	dc.b	0
	dc.b	NULL_BLOCK			
block283
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
block284
	dc.b	0
	dc.b	NULL_BLOCK		
block285
	dc.b	0
	dc.b	Activate_Big_Door_Block
block286
	dc.b	0
	dc.b	Activate_Big_Door_Block
block287
	dc.b	0
	dc.b	NULL_BLOCK			
block288
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
block289	
	dc.b	0			;BLOCK_SOLID+BULLET_KILL+EXPLODE_BLOCK+SPLIT_BLOCK	;teeth
	dc.b	NULL_BLOCK		
block290
	dc.b	0
	dc.b	NULL_BLOCK	
block291
	dc.b	0
	dc.b	NULL_BLOCK		
block292
	dc.b	0
	dc.b	NULL_BLOCK		
block293
	dc.b	0
	dc.b	NULL_BLOCK	
block294
	dc.b	0
	dc.b	NULL_BLOCK
block295
	dc.b	0
	dc.b	NULL_BLOCK
block296
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
block297
	dc.b	0
	dc.b	NULL_BLOCK
block298
	dc.b	0
	dc.b	NULL_BLOCK	
	
block299
	dc.b	0
	dc.b	NULL_BLOCK
		
block300
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Wall_Gold_Coin
	
block301
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Wall_Gold_Coin
	
block302
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block303
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block304
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block305
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
block306
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
block307
	dc.b	0
	dc.b	NULL_BLOCK	
block308
	dc.b	0
	dc.b	NULL_BLOCK	
block309
	dc.b	0
	dc.b	NULL_BLOCK	
block310
	dc.b	0
	dc.b	NULL_BLOCK	
block311
	dc.b	0
	dc.b	NULL_BLOCK	
block312
	dc.b	0
	dc.b	NULL_BLOCK	
block313			
	dc.b	BLOCK_SOLID+BULLET_KILL   ;the pot
	dc.b	Empty_Pot		  ;bullet hit info
block314
	dc.b	0
	dc.b	NULL_BLOCK	
block315
	dc.b	0
	dc.b	NULL_BLOCK	
block316
	dc.b	0
	dc.b	NULL_BLOCK	
block317
	dc.b	0
	dc.b	NULL_BLOCK	
block318
	dc.b	0
	dc.b	NULL_BLOCK	
block319
	dc.b	0
	dc.b	NULL_BLOCK	
	
block320
	dc.b	0
	dc.b	Activate_Block
	
block321
	dc.b	0
	dc.b	Activate_Block

block322
	dc.b	0
	dc.b	Activate_Block
	
block323
	dc.b	0
	dc.b	Activate_Block
	
block324
	dc.b	0
	dc.b	Activate_Block
	
block325
	dc.b	0
	dc.b	Activate_Block


block326
	dc.b	0
	dc.b	Activate_Block
	
block327
	dc.b	0
	dc.b	Activate_Block
	
block328
	dc.b	0
	dc.b	Activate_Block
	
block329
	dc.b	0
	dc.b	Activate_Block

block330
	dc.b	0
	dc.b	Activate_Block
	
block331
	dc.b	0
	dc.b	Activate_Block

block332
	dc.b	0
	dc.b	Activate_Block
	
block333
	dc.b	0
	dc.b	Activate_Block
	
block334
	dc.b	0
	dc.b	Activate_Block
	
block335
	dc.b	0
	dc.b	Activate_Block

block336
	dc.b	0
	dc.b	Activate_Block

block337
	dc.b	0
	dc.b	Activate_Block
	
block338
	dc.b	0
	dc.b	Activate_Block
	
block339
	dc.b	0
	dc.b	Activate_Block
		
block340
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block341
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK

block342
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block343
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block344
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block345
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block346
	dc.b	0
	dc.b	NULL_BLOCK
	
block347
	dc.b	0
	dc.b	NULL_BLOCK
	
block348
	dc.b	0
	dc.b	NULL_BLOCK
	
block349
	dc.b	0
	dc.b	NULL_BLOCK

block350
	dc.b	0
	dc.b	NULL_BLOCK
	
block351
	dc.b	0
	dc.b	NULL_BLOCK

block352
	dc.b	0
	dc.b	NULL_BLOCK
	
block353
	dc.b	0
	dc.b	NULL_BLOCK
	
block354
	dc.b	0
	dc.b	NULL_BLOCK
	
block355
	dc.b	0
	dc.b	NULL_BLOCK

block356
	dc.b	0
	dc.b	NULL_BLOCK

block357
	dc.b	0
	dc.b	NULL_BLOCK
	
block358
	dc.b	0
	dc.b	NULL_BLOCK
	
block359
	dc.b	0
	dc.b	NULL_BLOCK
	
block360		
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK
	
block361
	dc.b	BLOCK_WATER			
	dc.b	NULL_BLOCK
	
block362
	dc.b	BLOCK_WATER	
	dc.b	NULL_BLOCK

block363
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block364
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block365
	dc.b	0
	dc.b	NULL_BLOCK

block366
	dc.b	0
	dc.b	NULL_BLOCK

block367
	dc.b	0
	dc.b	NULL_BLOCK

block368
	dc.b	0
	dc.b	NULL_BLOCK

block369
	dc.b	0
	dc.b	NULL_BLOCK	

block370
	dc.b	0
	dc.b	NULL_BLOCK
	
block371
	dc.b	0
	dc.b	NULL_BLOCK

block372
	dc.b	0
	dc.b	NULL_BLOCK

block373
	dc.b	0
	dc.b	NULL_BLOCK

block374
	dc.b	0
	dc.b	NULL_BLOCK	

block375
	dc.b	0
	dc.b	NULL_BLOCK

block376
	dc.b	0
	dc.b	NULL_BLOCK
	
block377
	dc.b	0
	dc.b	NULL_BLOCK

block378
	dc.b	0
	dc.b	NULL_BLOCK

block379
	dc.b	0
	dc.b	NULL_BLOCK

block380		
	dc.b	0
	dc.b	Switch_Block
	
block381
	dc.b	0			
	dc.b	Switch_Block
	
block382
	dc.b	0		
	dc.b	Switch_Block

block383
	dc.b	0
	dc.b	Switch_Block

block384
	dc.b	0
	dc.b	Switch_Block		

block385
	dc.b	0
	dc.b	Switch_Block	

block386
	dc.b	0
	dc.b	Switch_Block

block387
	dc.b	0
	dc.b	Switch_Block	

block388
	dc.b	0
	dc.b	Switch_Block

block389
	dc.b	0
	dc.b	Switch_Block	

block390
	dc.b	0
	dc.b	Switch_Block		
	
block391
	dc.b	0
	dc.b	Switch_Block	

block392
	dc.b	0
	dc.b	Switch_Block	

block393
	dc.b	0
	dc.b	Switch_Block	

block394
	dc.b	0
	dc.b	Switch_Block	

block395
	dc.b	0
	dc.b	Switch_Block	

block396
	dc.b	0
	dc.b	Switch_Block	
	
block397
	dc.b	0
	dc.b	Switch_Block	

block398
	dc.b	0
	dc.b	Switch_Block	

block399
	dc.b	0
	dc.b	Switch_Block	

block400
	dc.b	BLOCK_SOLID	;chest block
	dc.b	NULL_BLOCK

block401				
	dc.b	0		
	dc.b	NULL_BLOCK

block402
	dc.b	0		
	dc.b	NULL_BLOCK

block403
	dc.b	0			
	dc.b	NULL_BLOCK
	
block404
	dc.b	0			
	dc.b	NULL_BLOCK

block405
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block406
	dc.b	0
	dc.b	Wood_Block		

block407
	dc.b	0
	dc.b	Wood_Block	

block408
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block409
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block410
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block411
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block412
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
	
block413
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block414
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block415
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block416
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block417
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block418
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block419
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block420
	dc.b	0
	dc.b	NULL_BLOCK
	
block421
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN			
	dc.b	NULL_BLOCK
	
block422
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN			
	dc.b	NULL_BLOCK

block423
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN
	dc.b	NULL_BLOCK

block424
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block425
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block426
	dc.b	0
	dc.b	NULL_BLOCK

block427
	dc.b	0
	dc.b	NULL_BLOCK	

block428
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block429
	dc.b	0
	dc.b	NULL_BLOCK	

block430
	dc.b	0
	dc.b	NULL_BLOCK		
	
block431
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK	

block432
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK	

block433
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block434
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block435
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block436
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block437
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block438
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block439
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block440		
	dc.b	BLOCK_SOLID+BULLET_KILL	;+BLOCK_CHAIN
	dc.b	NULL_BLOCK
	
block441
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN			
	dc.b	NULL_BLOCK
	
block442
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN			
	dc.b	NULL_BLOCK

block443
	dc.b	BLOCK_SOLID+BULLET_KILL ;+BLOCK_CHAIN
	dc.b	NULL_BLOCK

block444
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block445
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block446
	dc.b	0
	dc.b	NULL_BLOCK

block447
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block448
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	Chink_Block

block449
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block450
	dc.b	0
	dc.b	NULL_BLOCK		
	
block451
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK	

block452
	dc.b	BLOCK_WATER
	dc.b	NULL_BLOCK	

block453
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block454
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block455
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block456
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block457
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block458
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block459
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block460		
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block461
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block462
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block463
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block464
	dc.b	0
	dc.b	NULL_BLOCK		

block465
	dc.b	0
	dc.b	NULL_BLOCK	

block466
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block467
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block468
	dc.b	0
	dc.b	NULL_BLOCK

block469
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block470
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK		
	
block471
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block472
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block473
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block474
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block475
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block476
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block477
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block478
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block479
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block480		
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block481
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block482
	dc.b	BLOCK_SOLID+BULLET_KILL			
	dc.b	NULL_BLOCK

block483
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block484
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		

block485
	dc.b	0
	dc.b	NULL_BLOCK	

block486
	dc.b	0
	dc.b	NULL_BLOCK

block487
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block488
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block489
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block490
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK		
	
block491
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block492
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block493
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block494
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block495
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block496
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block497
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block498
	dc.b	0
	dc.b	NULL_BLOCK	

block499
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block500
	dc.b	0
	dc.b	Wood_Block
	
block501
	dc.b	0
	dc.b	Wood_Block
	
block502
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK			

block503
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block504
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block505
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block506
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block507
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block508
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block509
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block510
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block511
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block512
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block513
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block514
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block515
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block516
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block517
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block518
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block519
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block520
	dc.b	0
	dc.b	Wood_Block

block521
	dc.b	0
	dc.b	Wood_Block

block522
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
	
block523
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block524
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block525
	dc.b	0
	dc.b	NULL_BLOCK	

block526
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block527
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block528
	dc.b	0
	dc.b	NULL_BLOCK	
	
block529
	dc.b	0
	dc.b	NULL_BLOCK	
	
block530
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block531
	dc.b	0
	dc.b	NULL_BLOCK	

block532
	dc.b	0
	dc.b	NULL_BLOCK	

block533
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block534
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block535
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block536
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block537
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block538
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block539
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block540
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block541
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block542
	dc.b 	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block543
	dc.b	0
	dc.b	NULL_BLOCK	
	
block544
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block545
	dc.b	0
	dc.b	NULL_BLOCK	

block546
	dc.b	0
	dc.b	NULL_BLOCK	

block547
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block548
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block549
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block550
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block551
	dc.b	0
	dc.b	NULL_BLOCK	
	
block552
	dc.b	0
	dc.b	NULL_BLOCK	

block553
	dc.b	0
	dc.b	NULL_BLOCK	
	
block554
	dc.b	0
	dc.b	NULL_BLOCK	
	
block555
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block556
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block557
	dc.b	0
	dc.b	NULL_BLOCK	

block558
	dc.b	0
	dc.b	NULL_BLOCK	
	
block559
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block560
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block561
	dc.b	0
	dc.b	Wood_Block	
	
block562
	dc.b    0
	dc.b	Wood_Block
	
block563
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block564
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block565
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block566
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block567
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block568
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block569
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block570
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	

block571
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block572
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block573
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
	
block574
	dc.b	0
	dc.b	NULL_BLOCK	

block575
	dc.b	0
	dc.b	NULL_BLOCK	
	
block576
	dc.b	0
	dc.b	NULL_BLOCK	

block577
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block578
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block579
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block580
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block581
	dc.b	0
	dc.b	Wood_Block
	
block582
	dc.b	0
	dc.b	Wood_Block	
	
block583
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block584
	dc.b	0
	dc.b	Wood_Block	
	
block585
	dc.b	0
	dc.b	Wood_Block	

block586
	dc.b	0
	dc.b	Wood_Block	

block587
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block588
	dc.b	0
	dc.b	NULL_BLOCK	
	
block589
	dc.b	0
	dc.b	NULL_BLOCK	
	
block590
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block591
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block592
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block593
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block594
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block595
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block596
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block597
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block598
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block599
	dc.b	0
	dc.b	NULL_BLOCK	
	
block600	
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block601
	dc.b	0
	dc.b	Wood_Block	
	
block602
	dc.b	0
	dc.b	Wood_Block	

block603
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block604
	dc.b	0
	dc.b	Wood_Block	

block605
	dc.b	0
	dc.b	Wood_Block	

block606
	dc.b	0
	dc.b	Wood_Block	

block607
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block608
	dc.b	0
	dc.b	NULL_BLOCK	

block609
	dc.b	0
	dc.b	NULL_BLOCK	

block610
	dc.b	0
	dc.b	NULL_BLOCK	
	
block611
	dc.b	0
	dc.b	NULL_BLOCK	

block612
	dc.b	0
	dc.b	NULL_BLOCK	

block613
	dc.b	0
	dc.b	NULL_BLOCK	

block614
	dc.b	0
	dc.b	NULL_BLOCK	

block615
	dc.b	0
	dc.b	NULL_BLOCK	
	
block616
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block617
	dc.b	0
	dc.b	NULL_BLOCK	

block618
	dc.b	0
	dc.b	NULL_BLOCK	
	
block619
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block620
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	

block621
	dc.b	0
	dc.b	Wood_Block	
	
block622
	dc.b	0
	dc.b	Wood_Block	
	
block623
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block624
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block625
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block626
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block627
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block628
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block629
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block630
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK 	
	
block631
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block632
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block633
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block634
	dc.b	0
	dc.b	NULL_BLOCK	

block635
	dc.b	0
	dc.b	NULL_BLOCK
	
block636
	dc.b	0
	dc.b	NULL_BLOCK	

block637
	dc.b	0
	dc.b	NULL_BLOCK		
	
block638
	dc.b	0
	dc.b	NULL_BLOCK	
	
block639
	dc.b	0
	dc.b	NULL_BLOCK	
	
block640
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block641
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block642
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block643
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block644
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block645
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block646
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block647
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block648
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block649
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	

***

block650
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block651
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block652
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block653
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block654
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block655
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block656
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block657
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block658
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block659
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

***

block660
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block661
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block662
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block663
	dc.b	0
	dc.b	NULL_BLOCK	

block664
	dc.b	0
	dc.b	NULL_BLOCK	

block665
	dc.b	0
	dc.b	NULL_BLOCK	

block666
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block667
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block668
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block669
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

****
block670
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block671
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block672
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block673
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block674
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block675
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block676
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block677
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block678
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block679
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

***
block680
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block681
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block682
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block683
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block684
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block685
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block686
	dc.b	0
	dc.b	NULL_BLOCK	

block687
	dc.b	0
	dc.b	NULL_BLOCK	

block688
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block689
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	


***
block690
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block691
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block692
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block693
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block694
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block695
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block696
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block697
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block698
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block699
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

***
block700
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block701
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block702
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block703
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block704
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block705
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block706
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block707
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block708
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block709
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

**
block710
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block711
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block712
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block713
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block714
	dc.b	0
	dc.b	NULL_BLOCK	

block715
	dc.b	0
	dc.b	NULL_BLOCK	

**
block716
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block717
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block718
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block719
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block720
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block721
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block722
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block723
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block724
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block725
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block726
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block727
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block728
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block729
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block730
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	0	

block731
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block732
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block733
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block734
	dc.b	0
	dc.b	NULL_BLOCK	

block735
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block736
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block737
	dc.b	0
	dc.b	NULL_BLOCK	
	
block738
	dc.b	0
	dc.b	NULL_BLOCK		
	
block739
	dc.b	0
	dc.b	NULL_BLOCK			
	
block740
	dc.b	0
	dc.b	NULL_BLOCK	
	
block741
	dc.b	0
	dc.b	NULL_BLOCK		
	
block742
	dc.b	0
	dc.b	NULL_BLOCK	 															
	
block743
	dc.b	0
	dc.b	NULL_BLOCK		
	
block744
	dc.b	0
	dc.b	NULL_BLOCK			
	
block745
	dc.b	0
	dc.b	NULL_BLOCK	
	
block746
	dc.b	0
	dc.b	NULL_BLOCK		
	
block747
	dc.b	0
	dc.b	NULL_BLOCK	 																

block748
	dc.b	0
	dc.b	NULL_BLOCK		
	
block749
	dc.b	0
	dc.b	NULL_BLOCK	
	
block750
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block751
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK		
block752
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK		

block753
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK		

block754
	dc.b	0
	dc.b	NULL_BLOCK	

block755
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block756
	dc.b	0
	dc.b	NULL_BLOCK	

block757
	dc.b	0
	dc.b	NULL_BLOCK	

block758
	dc.b	0
	dc.b	NULL_BLOCK	

block759
	dc.b	0
	dc.b	NULL_BLOCK	

block760
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block761
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block762
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block763
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block764
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block765
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block766
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block767
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
		
block768
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block769
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block770
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block771
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block772
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block773
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block774
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block775
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block776
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block777
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block778
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block779
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block780
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block781
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block782
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block783
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block784
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block785
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block786
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block787
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block788
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block789
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block790
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block791
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block792
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block793
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block794
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block795
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block796
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block797
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block798
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block799
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block800
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block801
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block802
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block803
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block804
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block805
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block806
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block807
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block808
	dc.b	0
	dc.b	NULL_BLOCK	

block809
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	
	
block810
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block811
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block812
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block813
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block814
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block815
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	
	
block816
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block817
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block818
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block819
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block820
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block821
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block822
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block823
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block824
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block825
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block826
	dc.b	0
	dc.b	NULL_BLOCK	

block827
	dc.b	0
	dc.b	NULL_BLOCK	
	
block828
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block829
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	
	
block830
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block831
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block832
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block833
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block834
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block835
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	
	
block836
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block837
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block838
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block839
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block840
	dc.b	0
	dc.b	NULL_BLOCK	

block841
	dc.b	0
	dc.b	NULL_BLOCK	
	
block842
	dc.b	0
	dc.b	NULL_BLOCK	

block843
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block844
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block845
	dc.b	0
	dc.b	NULL_BLOCK	
	
block846
	dc.b	0
	dc.b	NULL_BLOCK	

block847
	dc.b	0
	dc.b	NULL_BLOCK	

block848
	dc.b	0
	dc.b	NULL_BLOCK	

block849
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block850
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block851
	dc.b	0
	dc.b	NULL_BLOCK	

block852
	dc.b	0
	dc.b	NULL_BLOCK	
	
block853
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block854
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block855
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block856
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block857
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block858
	dc.b	BLOCK_WATER+BLOCK_SOLID
	dc.b	NULL_BLOCK	

block859
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block860
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block861
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block862
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block863
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block864
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block865
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block866
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block867
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block868
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block869
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block870
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block871
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block872
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	


block873
	dc.b	0
	dc.b	NULL_BLOCK	

block874
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block875
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block876
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block877
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block878
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block879
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block880
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block881
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block882
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block883
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	


block884
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block885
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block886
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block887
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block888
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	

block889
	dc.b	0
	dc.b	NULL_BLOCK	

block890
	dc.b	0
	dc.b	NULL_BLOCK	

block891
	dc.b	0
	dc.b	NULL_BLOCK	

block892
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block893
	dc.b	0
	dc.b	NULL_BLOCK	

block894
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block895
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block896
	dc.b	0
	dc.b	NULL_BLOCK	

block897
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block898
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK	

block899
	dc.b	0
	dc.b	NULL_BLOCK	
	
block900
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block901
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block902
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block903
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block904
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block905
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	

block906
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
block907
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK	
	
block908
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block909
	dc.b	0
	dc.b	NULL_BLOCK	

block910
	dc.b	0
	dc.b	NULL_BLOCK	

block911
	dc.b	0
	dc.b	NULL_BLOCK	

block912
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block913
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block914
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block915
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block916
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block917
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block918
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block919
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block920
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block921
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block922
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block923
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block924
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block925
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block926
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block927
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block928
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block929
	dc.b	0
	dc.b	NULL_BLOCK	

block930
	dc.b	0
	dc.b	NULL_BLOCK	

block931
	dc.b	0
	dc.b	NULL_BLOCK	
	
block932
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block933
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block934
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block935
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block936
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block937
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block938
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block939
	dc.b	0
	dc.b	NULL_BLOCK	
	
block940
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block941
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block942
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block943
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block944
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block945
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block946
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block947
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK
	
block948
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block949
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block950
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block951
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block952
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block953
	dc.b	0
	dc.b	NULL_BLOCK	
	
block954
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block955
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block956
	dc.b	0
	dc.b	NULL_BLOCK	

block957
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	
	
block958
	dc.b	BLOCK_SOLID+block_water
	dc.b	NULL_BLOCK	

block959
	dc.b	0
	dc.b	NULL_BLOCK	

block960
	dc.b	0
	dc.b	NULL_BLOCK	
	
block961
	dc.b	0
	dc.b	NULL_BLOCK	

block962
	dc.b	0
	dc.b	NULL_BLOCK
	
block963
	dc.b	0
	dc.b	NULL_BLOCK

block964
	dc.b	0
	dc.b	NULL_BLOCK	
	
block965
	dc.b	0
	dc.b	NULL_BLOCK	

block966
	dc.b	0
	dc.b	NULL_BLOCK
	
block967
	dc.b	0
	dc.b	NULL_BLOCK

block968
	dc.b	0
	dc.b	NULL_BLOCK	
	
block969
	dc.b	0
	dc.b	NULL_BLOCK	

block970
	dc.b	0
	dc.b	NULL_BLOCK
	
block971
	dc.b	0
	dc.b	NULL_BLOCK

block972
	dc.b	0
	dc.b	NULL_BLOCK	

block973
	dc.b	0
	dc.b	NULL_BLOCK	

block974
	dc.b	0
	dc.b	NULL_BLOCK
	
block975
	dc.b	0
	dc.b	NULL_BLOCK

block976
	dc.b	0
	dc.b	NULL_BLOCK	
	
block977
	dc.b	0
	dc.b	NULL_BLOCK	

block978
	dc.b	0
	dc.b	NULL_BLOCK
	
block979
	dc.b	0
	dc.b	NULL_BLOCK

block980
	dc.b	0
	dc.b	NULL_BLOCK	
	
block981
	dc.b	0
	dc.b	NULL_BLOCK	

block982
	dc.b	0
	dc.b	NULL_BLOCK
	
block983
	dc.b	0
	dc.b	NULL_BLOCK

block984
	dc.b	0
	dc.b	NULL_BLOCK	
	
block985
	dc.b	0
	dc.b	NULL_BLOCK	

block986
	dc.b	0
	dc.b	NULL_BLOCK
	
block987
	dc.b	0
	dc.b	NULL_BLOCK

block988
	dc.b	0
	dc.b	NULL_BLOCK

block989
	dc.b	0
	dc.b	NULL_BLOCK

block990
	dc.b	0
	dc.b	NULL_BLOCK

block991
	dc.b	0
	dc.b	NULL_BLOCK

block992
	dc.b	0
	dc.b	NULL_BLOCK

block993
	dc.b	0
	dc.b	NULL_BLOCK	

block994
	dc.b	0
	dc.b	NULL_BLOCK	

block995
	dc.b	0
	dc.b	NULL_BLOCK

block996
	dc.b	0
	dc.b	NULL_BLOCK

block997
	dc.b	0
	dc.b	NULL_BLOCK

block998
	dc.b	0
	dc.b	NULL_BLOCK

block999
	dc.b	0
	dc.b	NULL_BLOCK

block1000
	dc.b	0
	dc.b	NULL_BLOCK

block1001
	dc.b	0
	dc.b	NULL_BLOCK
	
block1002
	dc.b	0
	dc.b	NULL_BLOCK
	
block1003
	dc.b	0
	dc.b	NULL_BLOCK
	
block1004
	dc.b	0
	dc.b	NULL_BLOCK

block1005
	dc.b	0
	dc.b	NULL_BLOCK

block1006
	dc.b	0
	dc.b	NULL_BLOCK
	
block1007
	dc.b	0
	dc.b	NULL_BLOCK
	
block1008
	dc.b	0
	dc.b	NULL_BLOCK
	
block1009
	dc.b	0
	dc.b	NULL_BLOCK

block1010
	dc.b	0
	dc.b	NULL_BLOCK

block1011
	dc.b	0
	dc.b	NULL_BLOCK
	
block1012
	dc.b	0
	dc.b	NULL_BLOCK
	
block1013
	dc.b	0
	dc.b	NULL_BLOCK
	
block1014
	dc.b	0
	dc.b	NULL_BLOCK

block1015
	dc.b	0
	dc.b	NULL_BLOCK

block1016
	dc.b	0
	dc.b	NULL_BLOCK
	
block1017
	dc.b	0
	dc.b	NULL_BLOCK
	
block1018
	dc.b	0
	dc.b	NULL_BLOCK
	
block1019
	dc.b	0
	dc.b	NULL_BLOCK


block1020
	dc.b	0
	dc.b	NULL_BLOCK

block1021
	dc.b	0
	dc.b	NULL_BLOCK
	
block1022
	dc.b	0
	dc.b	NULL_BLOCK
	
block1023
	dc.b	0
	dc.b	NULL_BLOCK
	
block1024
	dc.b	0
	dc.b	NULL_BLOCK

block1025
	dc.b	0
	dc.b	NULL_BLOCK

block1026
	dc.b	0
	dc.b	NULL_BLOCK
	
block1027
	dc.b	0
	dc.b	NULL_BLOCK
	
block1028
	dc.b	0
	dc.b	NULL_BLOCK
	
block1029
	dc.b	0
	dc.b	NULL_BLOCK

block1030
	dc.b	0
	dc.b	NULL_BLOCK

block1031
	dc.b	0
	dc.b	NULL_BLOCK
	
block1032
	dc.b	0
	dc.b	NULL_BLOCK

block1033
	dc.b	0
	dc.b	NULL_BLOCK
	
block1034
	dc.b	0
	dc.b	NULL_BLOCK

block1035
	dc.b	0
	dc.b	NULL_BLOCK

block1036
	dc.b	0
	dc.b	NULL_BLOCK

block1037
	dc.b	0
	dc.b	NULL_BLOCK

block1038
	dc.b	0
	dc.b	NULL_BLOCK

block1039
	dc.b	0
	dc.b	NULL_BLOCK

block1040
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1041
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK
	
block1042
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1043
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK
	
block1044
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1045
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1046
	dc.b	0
	dc.b	NULL_BLOCK

block1047
	dc.b	0
	dc.b	NULL_BLOCK

block1048
	dc.b	0
	dc.b	NULL_BLOCK

block1049
	dc.b	0
	dc.b	NULL_BLOCK

block1050
	dc.b	0
	dc.b	NULL_BLOCK

block1051
	dc.b	0
	dc.b	NULL_BLOCK
	
block1052
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1053
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1054
	dc.b	0
	dc.b	NULL_BLOCK

block1055
	dc.b	0
	dc.b	NULL_BLOCK

block1056
	dc.b	0
	dc.b	NULL_BLOCK

block1057
	dc.b	0
	dc.b	NULL_BLOCK

block1058
	dc.b	0
	dc.b	NULL_BLOCK

block1059
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1060
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1061
	dc.b	0
	dc.b	NULL_BLOCK
	
block1062
	dc.b	BLOCK_SOLID+BLOCK_WATER
	dc.b	NULL_BLOCK

block1063
	dc.b	0
	dc.b	NULL_BLOCK
	
block1064
	dc.b	0
	dc.b	NULL_BLOCK

block1065
	dc.b	0
	dc.b	NULL_BLOCK

block1066
	dc.b	0
	dc.b	NULL_BLOCK

block1067
	dc.b	0
	dc.b	NULL_BLOCK

block1068
	dc.b	0
	dc.b	NULL_BLOCK

block1069
	dc.b	0
	dc.b	NULL_BLOCK

block1070
	dc.b	0
	dc.b	NULL_BLOCK

block1071
	dc.b	0
	dc.b	NULL_BLOCK
	
block1072
	dc.b	0
	dc.b	NULL_BLOCK

block1073
	dc.b	0
	dc.b	NULL_BLOCK
	
block1074
	dc.b	0
	dc.b	NULL_BLOCK

block1075
	dc.b	0
	dc.b	NULL_BLOCK

block1076
	dc.b	0
	dc.b	NULL_BLOCK

block1077
	dc.b	0
	dc.b	NULL_BLOCK

block1078
	dc.b	0
	dc.b	NULL_BLOCK

block1079
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1080
	dc.b	0
	dc.b	NULL_BLOCK

block1081
	dc.b	0
	dc.b	NULL_BLOCK
	
block1082
	dc.b	0
	dc.b	NULL_BLOCK

block1083
	dc.b	0
	dc.b	NULL_BLOCK
	
block1084
	dc.b	0
	dc.b	NULL_BLOCK

block1085
	dc.b	0
	dc.b	NULL_BLOCK

block1086
	dc.b	0
	dc.b	NULL_BLOCK

block1087
	dc.b	0
	dc.b	NULL_BLOCK

block1088
	dc.b	0
	dc.b	NULL_BLOCK

block1089
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1090
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1091
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1092
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1093
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1094
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1095
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1096
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1097
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1098
	dc.b	0
	dc.b	NULL_BLOCK

block1099
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK


block1100
	dc.b	0
	dc.b	NULL_BLOCK

block1101
	dc.b	0
	dc.b	NULL_BLOCK
	
block1102
	dc.b	0
	dc.b	NULL_BLOCK
	
block1103
	dc.b	0
	dc.b	NULL_BLOCK
	
block1104
	dc.b	0
	dc.b	NULL_BLOCK

block1105
	dc.b	0
	dc.b	NULL_BLOCK

block1106
	dc.b	0
	dc.b	NULL_BLOCK
	
block1107
	dc.b	0
	dc.b	NULL_BLOCK
	
block1108
	dc.b	0
	dc.b	NULL_BLOCK
	
block1109
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1110
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1111
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1112
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1113
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1114
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1115
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1116
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1117
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1118
	dc.b	0
	dc.b	NULL_BLOCK
	
block1119
	dc.b	0
	dc.b	NULL_BLOCK

block1120
	dc.b	0
	dc.b	NULL_BLOCK

block1121
	dc.b	0
	dc.b	NULL_BLOCK
	
block1122
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
		
block1123
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1124
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1125
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1126
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1127
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1128
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1129
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1130
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1131
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1132
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1133
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1134
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1135
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1136
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1137
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1138
	dc.b	0
	dc.b	NULL_BLOCK

block1139
	dc.b	0
	dc.b	NULL_BLOCK

block1140
	dc.b	0
	dc.b	NULL_BLOCK

block1141
	dc.b	0
	dc.b	NULL_BLOCK
	
block1142
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1143
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK
	
block1144
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1145
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1146
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1147
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1148
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1149
	dc.b	BLOCK_SOLID+BULLET_KILL
	dc.b	NULL_BLOCK

block1150
	dc.b	0
	dc.b	NULL_BLOCK

block1151
	dc.b	0
	dc.b	NULL_BLOCK
	
block1152
	dc.b	0
	dc.b	NULL_BLOCK

block1153
	dc.b	0
	dc.b	NULL_BLOCK
	
block1154
	dc.b	0
	dc.b	NULL_BLOCK

block1155
	dc.b	0
	dc.b	NULL_BLOCK

block1156
	dc.b	0
	dc.b	NULL_BLOCK

block1157
	dc.b	0
	dc.b	NULL_BLOCK

block1158
	dc.b	0
	dc.b	NULL_BLOCK

block1159
	dc.b	0
	dc.b	NULL_BLOCK

block1160
	dc.b	0
	dc.b	NULL_BLOCK

block1161
	dc.b	0
	dc.b	NULL_BLOCK
	
block1162
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1163
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK
	
block1164
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1165
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1166
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1167
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1168
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK

block1169
	dc.b	BLOCK_SOLID
	dc.b	NULL_BLOCK	
	
block1170
	dc.b	0
	dc.b	NULL_BLOCK

block1171
	dc.b	0
	dc.b	NULL_BLOCK
	
block1172
	dc.b	0
	dc.b	NULL_BLOCK

block1173
	dc.b	0
	dc.b	NULL_BLOCK
	
block1174
	dc.b	0
	dc.b	NULL_BLOCK

block1175
	dc.b	0
	dc.b	NULL_BLOCK

block1176
	dc.b	0
	dc.b	NULL_BLOCK

block1177
	dc.b	0
	dc.b	NULL_BLOCK

block1178
	dc.b	0
	dc.b	NULL_BLOCK

block1179
	dc.b	0
	dc.b	NULL_BLOCK	

	
