
****************************************************
***** SET UP LEVEL DETAILS                    ******
****************************************************
set_up_level_details

	move.l	current_game_level,a0
	move.l	level_background_struct(a0),a0
	move.l	background_effects_routine(a0),screen_effects_routine
	bsr	set_up_map_details	;copies/converts maps, zeros pointers etc
	rts



************************************************************
****         SET UP MAP DETAILS                         ****
************************************************************
set_up_map_details


	
	clr.w	old_px	
	clr.w	current_map_position			
	clr.w	current_background_map_position		
	clr.w	current_alien_map_position
	clr.w	screen_x_position		
	clr.w	screen_y_position		
	clr.w	background_screen_x_position		
	clr.w	background_screen_y_position	
	clr.w	background_x_pixel_leftover	
	clr.w	background_y_pixel_leftover
	clr.w   last_x_position			
	clr.w   last_background_x_position
	clr.w 	check_add			
	clr.w   check_add_background			


	move.w	#1,player_falling_flag
	
	move.l	current_game_level,a0
	move.w	level_player_x_start(a0),d0
	mulu	#SCALE_FACTOR,d0
	move.w	d0,player_y_scaled 

	move.l	level_blocks(a0),front_blocks
	move.l	level_background_struct(a0),a0
	move.l	background_blocks(a0),back_blocks

	move.l	current_game_level,a0
	bsr	set_up_max_scroll_values
	

	
	clr.w	player_x_scaled 				
	clr.w	player_x  				
	clr.w	player_y  			
	clr.w	player_fall_velocity		
	clr.w	default_jump				
	clr.w	start_jump			
	clr.w	player_timer			
	clr.w	supress_repeat_jump		
	clr.w	player_x_velocity  			
	clr.w	player_y_velocity  			
	clr.w	lastx_direc				
	clr.w	lasty_direc				


	bsr	copy_map_to_back_up
	bsr	copy_back_map_to_back_up
	bsr	copy_alien_map_to_back_up
	
	bsr	fill_screen_with_blocks
	bsr	player_on_ground
	bsr	convert_alien_map	
	bsr	clean_coin_map

	bsr	do_lives
	bsr	do_coins_total
	bsr	do_score
	bsr	set_title
	bsr	set_up_timer
	bsr	set_up_coin_count
	rts
	
**************************************************
*******     SET UP MAX SCROLL VALUES        ******
**************************************************
set_up_max_scroll_values
*send struct in a0
	
	
	move.l	level_foreground_map(a0),a1
	move.w	map_data_x(a1),d0
	sub.w	#20,d0	
	cmp.w	#20,d0
	bge.s	not_smaller_than_screen
	move.w	#20,d0
not_smaller_than_screen	
	asl.w	#4,d0
	subq.w	#1,d0
	move.w	d0,max_scroll_x_position
	
	move.w	map_data_y(a1),d0
	cmp.w	#16,d0
	bge.s	not_smaller_than_y_screen
	move.w	#16,d0
not_smaller_than_y_screen
	sub.w	#15,d0	
	asl.w	#4,d0
	move.w	d0,max_scroll_y_position

	move.l	level_background_struct(a0),a1
	move.l	background_map(a1),a1
	move.w	map_data_x(a1),d0
	sub.w	#20,d0	
	cmp.w	#20,d0
	bge.s	not_smaller_than_back_screen
	move.w	#20,d0
not_smaller_than_back_screen	
	asl.w	#4,d0
	subq.w	#1,d0
	move.w	d0,max_background_scroll_x_position
	
	move.w	map_data_y(a1),d0
	sub.w	#15,d0	
	cmp.w	#16,d0
	bge.s	not_smaller_than_back_y_screen
	move.w	#16,d0
not_smaller_than_back_y_screen
	asl.w	#4,d0
	move.w	d0,max_background_scroll_y_position
	
	rts

***********************************************
********* SETUP PANEL COLS   ******************
***********************************************
setup_panel_cols


	move.w	#$2c01,d2
	move.l	#panel_copper_cols,a0
	move.l	#simple_range,a1
	move.w	#14-1,d0
panel_cols_loop
	move.w	d2,(a0)+
	move.w	#$fffe,(a0)+
	move.w	#$1a2,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$0100,d2
	dbra	d0,panel_cols_loop

	rts

simple_range
	dc.w	$f00,$f00,$e00,$d00,$c00,$a00,$900
	dc.w	$800,$700,$600,$500,$400,$400,$300


***********************************************
********* SETUP SPRITE DATA  ******************
***********************************************
setup_sprite_data

*sets up the sprite data in the copper list so squiz can be drawn

	moveq	#0,d7
	move.l	#copper_sprite_mem,a0
	move.w	#$3c01,d0
	
	move.w	#(255-16)-1,d1
setup_sprs

	cmp.w	#$0001,d0
	bne.s	not_dodgy_line
	move.w	#$ffd1,WAIT_POS(a0)
	move.w	#$fffe,WAIT_POS+2(a0)
	bra.s	past_dodgy_line	
not_dodgy_line	
	move.w	d0,WAIT_POS(a0)
	move.w	#$fffe,WAIT_POS+2(a0)
past_dodgy_line	
	move.w	#$146,SPRITE1B(a0)
	move.w	#$0,SPRITE1B+2(a0)
	move.w	#$144,SPRITE1A(a0)
	move.w	#$0,SPRITE1A+2(a0)
	
	move.w	#$14E,SPRITE2B(a0)
	move.w	#$0,SPRITE2B+2(a0)
	move.w	#$14C,SPRITE2A(a0)
	move.w	#$0,SPRITE2A+2(a0)
	
	move.w	#$156,SPRITE3B(a0)
	move.w	#$0,SPRITE3B+2(a0)
	move.w	#$154,SPRITE3A(a0)
	move.w	#$0,SPRITE3A+2(a0)
	
	move.w	#$15e,SPRITE4B(a0)
	move.w	#$0,SPRITE4B+2(a0)
	move.w	#$15c,SPRITE4A(a0)
	move.w	#$0,SPRITE4A+2(a0)


	move.w	#$106,CONTROL_HIGH(a0)
	move.w	#$1000,CONTROL_HIGH+2(a0)
	move.w	#$1a0,HIGHCOL(a0)	
	move.w	#0,HIGHCOL+2(a0)
	move.w	#$106,CONTROL_LOW(a0)
	move.w	#$1200,CONTROL_LOW+2(a0)
	move.w	#$1a0,LOWCOL(a0)
	move.w	#0,LOWCOL+2(a0)
	
	addq.w	#1,d7
	
	add.w	#$0100,d0
	
	add.l	#SIZE_COP,a0
	
	dbra	d1,setup_sprs
	
	
	bsr	setup_range
	rts

************************************************************
****     SETUP MEMORY                                   ****
************************************************************
	
Setup_Memory
	
	move.l	MEMORY_BASE,d0
	add.l	#SAFE_OVERSCROLL_AREA,d0
	move.l	d0,PLANE1
	
	
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,PLANE2
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,PLANE3
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,PLANE4
			

	add.l	#(HEIGHT*BYTES_PER_ROW),d0
	move.l	d0,Buffered_PLANE1
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,Buffered_PLANE2
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,Buffered_PLANE3
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,Buffered_PLANE4
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	add.l	#SAFE_OVERSCROLL_AREA,d0
	
	move.l	d0,PLANE5
	move.l	d0,scroll_back_plane
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d0
	move.l	d0,PLANE6
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d0
	move.l	d0,PLANE7
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d0
	move.l	d0,PLANE8
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d0
	
	add.l	#SAFE_OVERSCROLL_AREA,d0		
	
	move.l	d0,panel_plane1
	add.l	#PANEL_SIZE,d0
	move.l	d0,panel_plane2
	add.l	#PANEL_SIZE,d0
	move.l	d0,panel_plane3
	add.l	#PANEL_SIZE,d0
	move.l	d0,panel_plane4
	add.l	#PANEL_SIZE,d0
	
	move.l	d0,windowsavebackmem
	add.l	#WINDOW_SIZE,d0
	move.l	d0,windowsavebackmembuff

	add.l	#WINDOW_SIZE,d0
	move.l	d0,SAVEBACK_AREA
	add.l	#SAVEBACK_BUFFER_SIZE,D0
	move.l	d0,SAVEBACK_BUFFER


*add gap at top to allow for aliens going off screen
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,plane1
	move.l	plane1,scroll_front_plane
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,plane2
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,plane3
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,plane4
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,buffered_plane1
	move.l	buffered_plane1,scroll_front_buff_plane
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,buffered_plane2
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,buffered_plane3
	add.l	#ALIEN_BORDER*BYTES_PER_ROW,buffered_plane4


	rts

************************************************************
****     SETUP SYSTEM                                   ****
************************************************************
Setup_System

	move.l	EXEC_BASE,a6
	jsr	Forbid(a6)		; Shutoff Tasking

	MOVE.L	#$DFF000,a6
	move.w	intenar(a6),System_Interrupts
	move.w	#$7fff,intreq(a6)
	move.w	#%0011100000000111,intena(a6) ; turn off interrupts
	
	bset	#1,$bfe001			; filter OFF
*	move.b	#127,$bfed01			; keyboard OFF
	
* Setup blitter bits that do not change

SetBobs	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	bne.s	SetBobs
	move.w	#-2,BLTAMOD(a6)
	move.w	#-2,BLTBMOD(a6)
	move.l	#$FFFF0000,BLTAFWM(a6)		; mask off last word

	move.l	$6c.w,oldint			; save interrupt
	move.l	#darkint,$6c.w			; new interrupt
	rts
	
NUMBER_OF_COLOURS	EQU	16	
	
**********************************
*** SETUP_SCREEN_COLOURS      ****
**********************************
	
setup_screen_colours
	move.l	current_game_level,a3

	move.l	#main_screen_colours_high,a0
	move.l	#main_screen_colours_low,a1
	move.l	level_colour_map(a3),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list
	
	move.l	#test_scroll_colours_high,a0
	move.l	#test_scroll_colours_low,a1
	move.l	level_player_colour_map(a3),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	
	move.l	level_background_struct(a3),a4
	
	move.l	#front_scroll_colours_high,a0
	move.l	#front_scroll_colours_low,a1
	move.l	background_colour_map(a4),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	

	rts   

**********************************
*** FADE_OUT_BACKGROUND       ****
**********************************
fade_out_background

	move.l	current_game_level,a3
	
	move.l	level_background_struct(a3),a4
	
	move.l	#front_scroll_colours_high,a0
	move.l	#front_scroll_colours_low,a1
	move.l	background_colour_map(a4),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	fade_list


	rts
	
**********************************
*** FADE_OUT_FOREGROUND       ****
**********************************
fade_out_foreground

	move.l	current_game_level,a3

	move.l	#main_screen_colours_high,a0
	move.l	#main_screen_colours_low,a1
	move.l	level_colour_map(a3),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	fade_list

	rts


**********************************
*** FADE_OUT_SQUIZ            ****
**********************************
fade_out_squiz

	move.l	current_game_level,a3

	move.l	#test_scroll_colours_high,a0
	move.l	#test_scroll_colours_low,a1
	move.l	level_player_colour_map(a3),a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	fade_list

	rts

**********************************
***   SETUP RANGE             ****
**********************************
setup_range

	move.l	#$0082ff,d0
	move.l	#copper_sprite_mem,a0
	move.l	a0,a1
	add.l	#HIGHCOL,a0
	add.l	#LOWCOL,a1	
	move.w	#(255-16)-1,d1
col_loop_set

	movem.l	d0-d1,-(sp)
	bsr	set_colour
	movem.l	(sp)+,d0-d1
	
	add.l	#$010000,d0
	add.l	#SIZE_COP,a0
	add.l	#SIZE_COP,a1
	dbra	d1,col_loop_set		

	rts

	

************************************************************
****     SET UP DARKLITES MEGA GAME                     ****
************************************************************

set_up_darklites_mega_game
	

	bra.s	Initialise			; get init going		

GRAF_NAME
	DC.B	"graphics.library",0
	even
_GFXBASE	
	DC.L	0

Initialise

	MOVE.L	EXEC_BASE,A6			; Exec Base
	MOVE.L 	#MEMORY_SIZE,D0
	MOVE.L	#(1<<1)+(1<<16),D1		; MemfChip + MemfClear
	JSR	-198(A6)				; ALLOCMEM
	TST.L	D0				; Memory obtained?
	BEQ	NO_MEMORY
	MOVE.L	D0,MEMORY_BASE

	move.l	#$dff000,a6		
	bsr	Setup_Memory			; into pointers
	bsr	Setup_System			; hardware etc
	MOVE.L	#$DFF000,a6
	move.w	#$000f,dmacon(a6)
			
	bsr	mainroutine			; main program
	jsr	mt_end

	move.l	EXEC_BASE,a6			; exec
	MOVE.L	MEMORY_BASE,A1			; Memory for bobs
	MOVE.L 	#MEMORY_SIZE,D0			; size
	JSR	-210(A6)				; DeAllocate Memory	
	MOVE.L	#$DFF000,a6
	bsr	Replace_System			; for os

NO_MEMORY
No_Lib
	movem.l	(sp)+,d0-d7/a0-a6
	rts					; back to os


*******************************************************
**********            SETUP PLANES      ***************
*******************************************************
setup_planes
	move.l	PLANE1,d0
	move.w	d0,PLANE1LOW
	swap	d0
	move.w	d0,PLANE1HIGH

	move.l	PLANE2,d0
	move.w	d0,PLANE2LOW
	swap	d0
	move.w	d0,PLANE2HIGH

	move.l	PLANE3,d0
	move.w	d0,PLANE3LOW
	swap	d0
	move.w	d0,PLANE3HIGH

	move.l	PLANE4,d0
	move.w	d0,PLANE4LOW
	swap	d0
	move.w	d0,PLANE4HIGH		


	move.l	PLANE5,d0
	move.w	d0,PLANE5LOW
	swap	d0
	move.w	d0,PLANE5HIGH

	move.l	PLANE6,d0
	move.w	d0,PLANE6LOW
	swap	d0
	move.w	d0,PLANE6HIGH

	move.l	PLANE7,d0
	move.w	d0,PLANE7LOW
	swap	d0
	move.w	d0,PLANE7HIGH

	move.l	PLANE8,d0
	move.w	d0,PLANE8LOW
	swap	d0
	move.w	d0,PLANE8HIGH		
	

	move.l	panel_PLANE1,d0
	move.w	d0,PANELPLANE1LOW
	swap	d0
	move.w	d0,PANELPLANE1HIGH

	move.l	panel_PLANE2,d0
	move.w	d0,PANELPLANE2LOW
	swap	d0
	move.w	d0,PANELPLANE2HIGH

	move.l	panel_PLANE3,d0
	move.w	d0,PANELPLANE3LOW
	swap	d0
	move.w	d0,PANELPLANE3HIGH

	move.l	panel_PLANE4,d0
	move.w	d0,PANELPLANE4LOW
	swap	d0
	move.w	d0,PANELPLANE4HIGH		


	move.l	panel_PLANE1,d0
	move.w	d0,PANELPLANE5LOW
	swap	d0
	move.w	d0,PANELPLANE5HIGH

	move.l	panel_PLANE2,d0
	move.w	d0,PANELPLANE6LOW
	swap	d0
	move.w	d0,PANELPLANE6HIGH

	move.l	panel_PLANE3,d0
	move.w	d0,PANELPLANE7LOW
	swap	d0
	move.w	d0,PANELPLANE7HIGH

	move.l	panel_PLANE4,d0
	move.w	d0,PANELPLANE8LOW
	swap	d0
	move.w	d0,PANELPLANE8HIGH		
	
		

* Buffer Bobs
	
	rts

***********************************************************
******    SETUP MAIN SCREEN COPPER                     ****
*********************************************************** 
setup_main_screen_copper	
	bsr	setup_planes
	move.l	#$dff000,a6
		
	move.l	#Copper_List,COP1LC(a6)
	clr.w	COPJMP1(a6)
	rts

	
	
		
memory_base	dc.l	0
system_interrupts	dc.l	0
error_flag	dc.w	0

PLANE1		dc.l	0
PLANE2		dc.l	0
PLANE3		dc.l	0
PLANE4		dc.l	0
PLANE5		dc.l	0
PLANE6		dc.l	0
PLANE7		dc.l	0
PLANE8		dc.l	0


Buffered_Plane1	dc.l	0
Buffered_Plane2	dc.l	0
Buffered_Plane3	dc.l	0
Buffered_Plane4	dc.l	0

panel_plane1	dc.l	0
panel_plane2	dc.l	0
panel_plane3	dc.l	0
panel_plane4	dc.l	0




scroll_front_plane	dc.l	0
scroll_back_plane	dc.l	0
scroll_front_buff_plane	dc.l	0
scroll_front_trip_plane	dc.l	0

Game_Flags	dc.w	0
		
	
	