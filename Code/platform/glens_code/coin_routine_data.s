	rsreset
	
coin_word_x		rs.w	1
coin_line		rs.w	1
coin_map_pos		rs.l	1
coin_main_map_pos	rs.l	1
coin_spangle_frame	rs.w	1
coin_spangle_timer	rs.w	1
coin_struct_size	rs.w	1

MAX_COIN	EQU	200
COIN_HEIGHT	EQU	15
SPIN_TIME	EQU	4
SPANGLE_TIME	EQU	3
MIN_COIN_FRAME	EQU	0
MAX_COIN_FRAME	EQU	3

SPANGLE_NUM_FRAME	EQU	10
SPANGLE_HEIGHT		EQU	15

coin_structs			ds.w	coin_struct_size*MAX_COIN
	
coin_pointers			ds.l	MAX_COIN	

active_coins			ds.l	MAX_COIN

drawn_coin_list			ds.l	MAX_COIN
				

current_coin_pointer		dc.l	active_coins
active_coin_pointer		dc.l	0

coin_spaces_left		dc.w	MAX_COIN
current_graphic_frame		dc.l	coin_frames


coin_frame_number	dc.w	0
coin_frame_inc		dc.w	1
coin_timer		dc.w	SPIN_TIME

TOTAL_COIN_FRAMES	EQU	5
NUM_COINS		EQU	6

coin_frame_table
	dc.l	coin_frames
	dc.l	coin_frames+((1+COIN_HEIGHT)*2)
	dc.l	coin_frames+((1+COIN_HEIGHT)*2)*2
	dc.l	coin_frames+((1+COIN_HEIGHT)*2)*3
	dc.l	coin_frames+((1+COIN_HEIGHT)*2)*4
	dc.l	coin_frames+((1+COIN_HEIGHT)*2)*5



spangle_frame_table
	dc.l	sparkle
	dc.l	sparkle+(SPANGLE_HEIGHT*2)
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*2
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*3
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*4
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*5
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*6
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*7
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*8
	dc.l	sparkle+(SPANGLE_HEIGHT*2)*9
	

coin_frames
	incbin	"graphics/coins.bin"
	EVEN
sparkle
	incbin	"graphics/sparkle.bin"	
	even