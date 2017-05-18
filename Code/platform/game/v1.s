

	SECTION	platform,Code_c
	opt	c-
	incdir  "code:platform/"
	include "data/system_equates
	include "data/system_equates2"


****compiler directives defines

col_test	equ	0
music		equ 	0
sound_fx	equ	0
panel_update	equ	0
all_samples	equ	0
map_graphics	equ	0
squiz_mortal	equ	0
show_demo	equ	0


*end directives


intreqr	equ	$01e
TRUE		EQU	1
FALSE		EQU	0
WINDOW_WIDTH		EQU	192
WINDOW_ACTUAL_WIDTH	EQU	189
WINDOW_HEIGHT		EQU	94



ALIEN_BORDER	EQU	48
BYTES_PER_ROW	EQU	64
SAFE_OVERSCROLL_AREA	EQU 50*BYTES_PER_ROW
HEIGHT		EQU	512+ALIEN_BORDER*2
SCROLL_HEIGHT	EQU	HEIGHT
BACKGROUND_SCROLL_HEIGHT	EQU	(256+128)
BACKPLANES	EQU	4
PANEL_SIZE		EQU	(16*BYTES_PER_ROW)
WINDOW_SIZE	EQU 	(WINDOW_WIDTH/8)*WINDOW_HEIGHT*4
WINDOW_ALLOC	EQU	WINDOW_SIZE*2
*-========================================================-

BACKGROUND	EQU (BYTES_PER_ROW*HEIGHT)+SAFE_OVERSCROLL_AREA*2
SCENARY		EQU (BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT*BACKPLANES)+SAFE_OVERSCROLL_AREA

Max_No_Objects	EQU	45	; Maximum 20 (screen drawn) objects
Max_Blit_Width	EQU	4	; Maximum 48 pixels wide + 16 for shift
Max_Blit_Height	EQU	48	; Maximum 48 pixels high
Object_Planes	EQU	4	; 4 planes, 16 colours

SAVEBACK_BUFFER_SIZE EQU Max_Blit_Width*2*Max_Blit_Height*Object_Planes*Max_No_Objects+1


MEMORY_SIZE	EQU ((BACKGROUND*BACKPLANES*2)+SCENARY+(PANEL_SIZE*4))+WINDOW_ALLOC+SAVEBACK_BUFFER_SIZE*2

***********************GAME FLAGS**********************

MAIN_GAME	equ 0
LEVEL_SELECTION	equ 4
SHOW_TITLE_SCREEN	equ	8
QUIT		equ 999


FINISHED_ROUTINE  equ $ff	;for benifit of rotation routine
	
*-==========================================================-


************************************************************
****       SET BALL ROLLING                             ****
************************************************************

	movem.l	d0-d7/a0-a6,-(sp)

*	move.w	#LEVEL_SELECTION,game_flags
	move.w	#Show_Title_screen,game_flags
	move.b	#1,music_flag
***	move.l	#tune,mt_data
	move.l	#tune,a0
	ifd music	
	jsr	mt_init
	endc	
	bra	set_up_darklites_mega_game	   ;set up all system



************************************************************
****       D A R K  L I T E   I N T E R R U P T         ****
************************************************************

darkint
	movem.l	d0-d7/a0-a6,-(sp)	
	
		
	ifd music
	tst.b	music_flag
	beq.s	dont_play_music
	jsr	mt_music	
	endc
dont_play_music
	ifd	panel_update
	tst	update_player_status
	beq.s	dont_update_status
	bsr	do_timer
	bsr	do_coins_total
	bsr	do_score
dont_update_status	
	endc
	move.b	$dff014,d2
	move.b	d2,resistance+1
	move.w  #$0001,$dff034

	movem.l	(sp)+,d0-d7/a0-a6
	dc.w	$4ef9
oldint dc.l	0	
music_flag	dc.b	0
	even
play_colours
	dc.b	0
	even
two_channel_flag	dc.b	0
	even
update_player_status
	dc.w	0
*-========================================================-


************************************************************
****               M A I N      R O U T I N E           ****
************************************************************


mainroutine
	move.w	Game_Flags,d0
	move.l	#routine_jump_table,a0
	move.l	(A0,d0.w),a0
	jsr	(a0)
	cmp.w	#QUIT,Game_Flags
	bne.s	mainroutine
	rts
	
routine_jump_table
	dc.l	main_game_routine		
	dc.l	level_select_routine	
	dc.l	show_routine
*************************************************************
****     E N D     M A I N      R O U T I N E           ****
************************************************************


************************************************************
****              L E V E L     S E L E C T             ****
************************************************************

level_select_routine

	bsr	Selection_Setup	
	*BSR	draw_paths

level_select_loop
	bsr	sync	
	jsr	display_sprite
	*bsr	Password_Entry_Routine
	*bsr	Create_Password
	tst.w	transit_flag
	bne.s	moving_frame
	
	bsr	Position_Stage_Player
	bsr	move_stage_player
	cmp.w	#-1,d0				; level selected
	beq.s	level_selected
	bra.s	done_frame_code

moving_frame
	bsr	walk_the_line
	bsr	walk_the_line
done_frame_code
	bra.s	level_select_loop
level_selected

	move.w	#MAIN_GAME,Game_Flags	
	rts


************************************************************
****               M A I N      G A M E                 ****
************************************************************

Set_Level_Number
	move.l	#Level_Pointers,a0
	*move.w	player_at_stage,d0
	move.w	#1,d0
	subq.w	#1,d0
	move.l	(a0,d0.w*4),a1
	move.l	a1,current_game_level
	rts

main_game_routine
	bsr	Set_Level_Number
	
	bsr	setup_coin_pointers
	bsr	set_up_level_details
	bsr	setup_main_screen_copper
	bsr	setup_sprite_data
	bsr	setup_panel_cols
	bsr	Setup_Enemies
	bsr	setup_screen_colours
	bsr	setup_coin_pointers	;done again after setting up map
	bsr	add_coins_to_screen
	bsr	display_player		;ensure no sprite crap appears	
main_loop
	bsr	sync	
	
	bsr	get_stick_readings	
	bsr	draw_player		;pain pain pain pain pain
		
	
	bsr	test_for_collected_coins
	bsr	swap_buffers
	bsr	update_scroll
	bsr	update_background_scroll
	bsr	add_on_scroll_offsets
	bsr	check_player_velocitys
	
	bsr	replace_savebacks
	bsr	Clear_Nosaves	
	bsr	draw_coins
	

	bsr	Player_Object_Collision
	bsr	object_collision
	bsr	add_player_effects	;smoke etc
	bsr	move_bobs

	bsr	Move_player_On_Object
		
	bsr	draw_blocks_for_front	
	bsr	draw_blocks_for_back
	




	jsr	store_nosaves
	jsr	draw_nosaves
	jsr	SaveBack_Enemies
	jsr	Draw_Enemies_in

	
	bsr	update_the_player		
	bsr	display_player

	bsr	get_catch_up_values
	
	

	bsr	process_coins
	bsr	update_coin_frame
	
	bsr	do_screen_effects_routine
	
	bsr	player_hit
	

	bsr	sound_effects	

	btst.b	#6,$bfe001
	bne.s	not_hit_btt
	move.w	#QUIT,Game_Flags
not_hit_btt
	cmp.w	#MAIN_GAME,Game_Flags
	beq	main_loop
	
	rts


************************************************************
***********          UPDATE THE PLAYER             *********
************************************************************
update_the_player
	cmp.w	#SQUIZ_DYING,player_death_flag
	beq.s	squiz_death_squirm
	
	bsr	update_player
	rts
squiz_death_squirm
	bsr	do_squiz_death
	
	rts

************************************************************
***********          DO SCREEN EFFECTS ROUTINE     *********
************************************************************
do_screen_effects_routine

	dc.w	$4ef9	
screen_effects_routine
	dc.l	0
	rts

     	
***************************************************
**********          SWAP BUFFERS         **********
***************************************************
swap_buffers
	move.l	plane1,d0
	move.l	buffered_plane1,plane1
	move.l	d0,buffered_plane1

* Cripes what a load of lists, Glens a lovely person and i should be lucky to code with him

	move.l	OLDBOB,d0
	move.l	OLDBOB_BUFFER,OLDBOB
	move.l	d0,OLDBOB_BUFFER

	move.l	FRIENDLY,d0
	move.l	FRIENDLY_BUFFER,FRIENDLY
	move.l	d0,FRIENDLY_BUFFER

	move.l	REPLACE_AREA,d0
	move.l	REPLACE_AREA_BUFFER,REPLACE_AREA
	move.l	d0,REPLACE_AREA_BUFFER

	move.l	CLEAR_AREA,d0
	move.l	CLEAR_AREA_BUFFER,CLEAR_AREA
	move.l	d0,CLEAR_AREA_BUFFER

	move.l	SAVEBACK_AREA,d0
	move.l	SAVEBACK_BUFFER,SAVEBACK_AREA
	move.l	d0,SAVEBACK_BUFFER

	move.l	CLEAR_LIST,D0
	move.l	CLEAR_LIST_BUFFER,CLEAR_LIST
	move.l  d0,CLEAR_LIST_BUFFER

	rts


************************************************************
***** S C R E E N      S Y N C                    **********
************************************************************	
	
sync
	
	move.w	#$0010,intreq(a6)	
wait_for_bit	
	btst.b	#4,intreqr+1(a6)
	beq.s	wait_for_bit
	rts


	
************************************************************
****                  P A U S E                         ****
************************************************************
	

pause
	move.w	#30000,d4
force_long_wait
	dbra	d4,force_long_wait
	rts				




***********************************************************
******           REPLACE SYSTEM                        ****
***********************************************************
Replace_System

	move.l	oldint,$6c.w			; replace old interrupt

	move.w	System_Interrupts,d0
	bset.l	#15,d0
	move.w	#$7fff,intena(a6)			;
	move.w	d0,intena(a6) 			; turn on interrupts
	
	MOVE.L	EXEC_BASE,A6			; Exec Base
	JSR	Permit(A6)			; Re-Permit Tasking

	move.l	EXEC_BASE,a6			; get exec location
	lea	GRAF_NAME,a1			; library (graphics)
	moveq	#0,d0				; version 0
	jsr	Open_Library(A6)			; open it
	tst.l	D0				; open unsuccessfull?
	beq 	No_Lib				; yes then get out
	MOVE.L	D0,_GFXBASE			; otherwise store addr

	
	MOVE.L	_GFXBASE,A4
	MOVE.L   38(A4),$DFF000+COP1LC		; Startlist back to copper
	CLR.W	$DFF000+COPJMP1			; Trigger copper

	MOVE.W	#$8020+128,$DFF000+DMACON		; Sprite + Copper ON
	move.w	#$000f,$dff000+dmacon		; sound off
	move.b	#$9b,$bfed01			; keyboard ON	

; 1200 Gay regs

	move.w	#$2100,$dff1e4
	move.w	#0,$dff106
	move.w	#0,$dff10c	
	move.w	#0,$dff1fc	
	
	move.l	exec,a6
	move.l	_GFXBASE,a1
	jsr	-414(a6)
	rts
		


************************************************************
******** I N C L U D E S                             *******
************************************************************

	
	include "glens_code/player_routines.s"
	include "glens_code/player_draw_routines.s"
	include "glens_code/joy_routines.s"
	include "glens_code/update_scroll.s"
	include	"glens_code/block_effects.s"	
	include "glens_code/collision_routines.s"
	include	"glens_code/colour_routines.s"
	include	"glens_code/coin_routines.s"
	include "glens_code/screen_effects.s"
	include	"glens_code/setup_routines.s"
	include "stus_code/alien_routines.s"
	include "stus_code/level_select_routines.s"
	include	"sound/game_sound.s"
	include	"glens_code/window_routines.s"
	include "glens_code/quick_text_routines.s"
	include	"glens_code/show_code.s"

	include "stus_code/alien_variables.s"
	include "stus_code/Character_Animations.s"
	include	"stus_code/random_routine.s"
	
	include	"stus_code/Character_Data.s"
	include "data/game_data.s"
	include "graphics/fsquizleft5.bin"
	include "graphics/fsquizright5.bin"
	include "graphics/newsquizrot.s"


jumpleft
	include "graphics/squizjumpleft.s"
fallrighttail
	include "graphics/squizjumpright.s"
	

		
lefttails	EQU	leftbodys+(SFS/2)
rightbodys	EQU	righttails+(SFS/2)
tailright	EQU	spinright+(SFS/2)

jumplefttail	EQU	jumpleft+(SFS/2)

jumpright	EQU	fallrighttail+(SFS)+SFS/2
jumprighttail	EQU	fallrighttail+(SFS)
fallright	EQU	fallrighttail+SFS/2

fallleft	EQU	jumpleft+(SFS)
falllefttail	EQU	jumpleft+(SFS)+SFS/2

	ifd	sound_fx
	include	"sound/effects.s"
	endc
	even
	include	"sound/replay26.s"
	even
tune	
	ifd music
	incbin "scratch:modules/sweetsong"	
	EVEN
	endc


cave_blocks
*	incbin	"graphics/caveforegraphics"
	even
cave_background_blocks
*	incbin	"graphics/cavebackgraphics"
	even	
	
country_blocks
	incbin	"graphics/dizzyforegroundblocks"
	even
country_background_blocks
	incbin	"graphics/dizzybackblocks"
*	incbin	"graphics/backblocks"
	even		
	
	include "data/block_data_information.s"
	even
	include "glens_code/coin_routine_data.s"
	even
	
textwindowgraphics
	incbin	"graphics/textwindow.s"
	even

	include "data/copper_list.s"


Level_Select_Graphics
	ifd	map_graphics
	*incbin "graphics/levelselectmap.bin"
	incbin	"graphics/showfrigscreen.bin"	
	endc
	even		

window_font
	include	"graphics/font.s"
	even		

	include "glens_code/level_code.s"
	include	"glens_code/map_data.s"	
	include	"data/colour_maps.s"

level_dpaint_cols
	incbin	"stus_code/level_select_cols.bin"	
	even
	
current_game_level		dc.l	another_country_level
current_game_level_number	dc.w	1



show_stuff

	include	"glens_code/fireworks.s"
title_screen
	incbin	"graphics/title.bin"	
	
