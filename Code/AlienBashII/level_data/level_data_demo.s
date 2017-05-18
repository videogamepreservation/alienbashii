POST_UP		EQU	167
POST_UP_SHAD	EQU	187
POST_DOWN	EQU	166
POST_DOWN_SHAD	EQU	186
POST_HOLE	EQU	166
POST_SHAD_HOLE	EQU	186

	rsreset
	
level_graphics_ptr	 rs.l	1
level_palette_ptr	 rs.l	1
level_sprite_palette_ptr rs.l	1	
level_map_x_start	 rs.w	1	;MUST BE FACTOR OF 16 ;LEFT HAND CORNER
level_map_y_start	 rs.w	1	;MUST BE FACTOR OF 16
level_generator_pattern	 rs.l	1	;generator attack pattern
level_switch_table	 rs.l	1
level_activator_table	 rs.l	1
level_copy_table	 rs.l	1


Level_1
	dc.l	0
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	18*16		;must be factor of 16
	dc.w	100*16		;must be factor of 16
	dc.l	Generator_Shoot_Player
	dc.l	Intro_Level_Switch_Table
	dc.l	Intro_Level_Activate_Table
	dc.l	0
	EVEN

Level_2
	dc.l	0
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	47*16		;must be factor of 16
	dc.w	59*16		;must be factor of 16
	dc.l	Generator_Shoot_Player
	dc.l	Level2_Switch_Table
	dc.l	Level2_Activate_Table
	dc.l	0
	EVEN

Level_3
	dc.l	0
	dc.l	Level_1_Colour_List
	dc.l	Level_1_Sprite_Colours
	dc.w	60*16		;must be factor of 16
	dc.w	182*16		;must be factor of 16
	dc.l	Generator_Shoot_Player
	dc.l	Level3_Switch_Table
	dc.l	Level3_Activate_Table
	dc.l	0
	EVEN


Level_list
*	dc.l	Level_1
	dc.l	Level_2
*	dc.l	Level_3
	dc.l	$ffffffff
	
current_level_list_ptr
	dc.l	Level_List	

*--------------Level Palettes------------*

Level_1_Colour_list
	dc.w	$642,$8ad,$47a,$257
	dc.w	$335,$111,$853,$b86
	dc.w	$962,$742,$532,$321
	dc.w	$cb2,$462,$351,$eed

			
Level_1_Sprite_Colours
	dc.w	$000,$cdd,$6bd,$58a
	dc.w	$368,$245,$134,$000
	dc.w	$521,$0a0,$961,$071
	dc.w	$741,$0a0,$d95,$071

panel_cols
	dc.w	$000,$9dd,$6aa,$488
	dc.w	$366,$053,$132,$741
	dc.w	$952,$733,$622,$510
	dc.w	$310,$043,$bc5,$a72


Loader_Cols
	dc.w	$000,$000,$344,$566
	dc.w	$122,$788,$9bb,$89a
	dc.w	$abb,$455,$233,$011
	dc.w	$677,$799,$9aa,$00a


Level_Toggle
	dc.w	0		;General toggle for use in scripts
	
************************* LEVEL INCLUDES *************************
	include	"level_data/special_switch_scripts.s"
	include	"level_data/level1data.s"
	include	"level_data/level2data.s"
	include	"level_data/level3data.s"


	




