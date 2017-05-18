POST_UP		EQU	167
POST_UP_SHAD	EQU	187
POST_DOWN	EQU	166
POST_DOWN_SHAD	EQU	186
POST_HOLE	EQU	166
POST_SHAD_HOLE	EQU	186

	rsreset
	
level_palette_ptr	 rs.l	1
level_sprite_palette_ptr rs.l	1	
level_map_x_start	 rs.w	1	;MUST BE FACTOR OF 16 ;LEFT HAND CORNER
level_map_y_start	 rs.w	1	;MUST BE FACTOR OF 16
level_generator_pattern	 rs.l	1	;generator attack pattern
level_switch_table	 rs.l	1
level_activator_table	 rs.l	1
level_strength_table	 rs.l	1
level_switch_list	 rs.l	1

Level_1
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	18*16		;must be factor of 16
	dc.w	100*16		;must be factor of 16
	dc.l	Level1_Generator
	dc.l	Intro_Level_Switch_Table
	dc.l	Intro_Level_Activate_Table
	dc.l	Level1_Alien_Strengths
	dc.l	0
	EVEN

Level_2
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	47*16		;must be factor of 16
	dc.w	59*16		;must be factor of 16
	dc.l	Level2_Generator
	dc.l	Level2_Switch_Table
	dc.l	Level2_Activate_Table
	dc.l	0
	dc.l	0
	EVEN

Level_3
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	60*16		;must be factor of 16
	dc.w	182*16		;must be factor of 16
	dc.l	Level3_Generator
	dc.l	Level3_Switch_Table
	dc.l	Level3_Activate_Table
	dc.l	Level3_Alien_Strengths
	dc.l	0
	EVEN

Level_4
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	64*16		;must be factor of 16
	dc.w	101*16		;must be factor of 16
	dc.l	Level4_Generator
	dc.l	Level4_Switch_Table
	dc.l	Level4_Activate_Table
	dc.l	0
	dc.l	0
	EVEN

Level_5
	dc.l	Level_1_Snow_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	27*16		;must be factor of 16
	dc.w	182*16		;must be factor of 16
	dc.l	Level5_Generator
	dc.l	Level5_Switch_Table
	dc.l	Level5_Activate_Table
	dc.l	0
	dc.l	0
	EVEN

Level_6
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	29*16		;must be factor of 16
	dc.w	41*16		;must be factor of 16
	dc.l	Level6_Generator
	dc.l	Level6_Switch_Table
	dc.l	Level6_Activate_Table
	dc.l	Level6_Alien_Strengths
	dc.l	0
	EVEN

Level_7
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	82*16		;must be factor of 16
	dc.w	91*16		;must be factor of 16
	dc.l	Level7_Generator
	dc.l	Level7_Switch_Table
	dc.l	Level7_Activate_Table
	dc.l	0
	dc.l	0
	EVEN

Level_8
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	67*16		;must be factor of 16
	dc.w	148*16		;must be factor of 16
	dc.l	Level8_Generator
	dc.l	Level8_Switch_Table
	dc.l	Level8_Activate_Table
	dc.l	0
	dc.l	0
	EVEN



Level_list
	dc.l	Level_1
	dc.l	Level_2
	dc.l	Level_3
	dc.l	Level_4
	dc.l	Level_5
	dc.l	Level_6
	dc.l	Level_7
	dc.l	Level_8
	dc.l	$ffffffff
	
current_level_list_ptr
	dc.l	Level_List	



Level_Toggle
	dc.w	0		;General toggle for use in scripts

level_number	dc.b	0	;Do not need to set here
		even

	
************************* LEVEL INCLUDES *************************
	include	"level_data/special_switch_scripts.s"
	include "level_data/level_alien_strengths.s"
	include	"level_data/level1data.s"
	include	"level_data/level2data.s"
	include	"level_data/level3data.s"
	include "level_data/level4data.s"
	include	"level_data/level5data.s"
	include	"level_data/level6data.s"
	include	"level_data/level7data.s"
	include	"level_data/level8data.s"	


	




