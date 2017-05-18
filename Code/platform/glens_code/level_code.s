
***************************LEVEL INFORMATION********************


*LEVEL TYPES

PARALLAX	EQU	0
MAP_ON_BACK	EQU	1
FORE_MASK	EQU	2
ANIMATE		EQU	3
DARKNESS	EQU	4

*---------------DEFINITION OF LEVEL STRUCT---------------------
	rsreset

level_player_x_start	rs.w	1
level_player_y_start	rs.w	1
level_foreground_map	rs.l	1
level_background_struct	rs.l	1
level_alien_map		rs.l	1
level_colour_map	rs.l	1
level_player_colour_map rs.l	1
level_music		rs.l	1
level_copper		rs.l	1	;0 = no copper
level_blocks		rs.l	1
level_data		rs.w	1
level_time_limit	rs.w    1
level_type		rs.w	1
level_title		rs.w	1

*----------------DEFINITION OF BACKGROUND STRUCT--------------

	rsreset

background_map			rs.l	1
background_colour_map		rs.l	1
background_effects_routine	rs.l	1	;colour cycling code etc
background_blocks		rs.l	1

*----------------------LEVEL DEFINITIONS-------------------

	rsreset
map_file_header	rs.l	1
map_block_size	rs.w	1	
map_data_x	rs.w	1
map_data_y	rs.w	1
map_planes	rs.w	1
map_datasize	rs.w	1
map_data_start	rs.w	1	


		
country_background
	dc.l	country_back
	dc.l	country_background_colour_map
	dc.l	null_routine   ;cycle_colours
	dc.l	country_background_blocks
	
another_country_level
	dc.w	20
	dc.w	400
	dc.l	country_spikey
	dc.l	country_background
	dc.l	country_alien_map
	dc.l	country_foreground_colour_map
	dc.l	player_colour_map
	dc.l    0
	dc.l	0
	dc.l	country_blocks
	dc.w	0
	dc.w    200
	dc.w	PARALLAX
	dc.b	" HELLO  WORLD ",0
	even
	
	
Level_Pointers
	dc.l another_country_level

MAX_LEVEL_NUM	EQU	(*-Level_Pointers)/4


