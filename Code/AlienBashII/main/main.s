*-(c) Glen Cumming 1993/1994/1995/1996                          -*
*-								-*
*-Hello and welcome to another episode in wasted opportunitys   -*
*-I hereby condem this code to the same hell as Squiz - a 1200  -*
*-only game which I had ready a few months after the launch of  -*
*-the 1200 which had parallax scrolling, lots of colours all    -*
*-running at 50Hz - but no bastard was interested in helping me -*
*-and Stuart develop it 					-*
*-Well I bid the Amiga and games programming goodbye, its   	-*
*-too much sodding work for naff all appreciation (CU AMIGA),   -*
*-I might as well spend my time writting shitty 'C' programs for-*
*-a big company, working 37.5 hours a week and getting paid 18K -*
*-or upwards. Games programming...I'd be lucky to get taken on  -*
*-at 12K and the hours - who wants to work 18 hours a day??     -*
*-								-*
*-So here is the complete code for ABII, do with it what you    -*
*-like, I do not claim that it is much good, but someone out    -*
*-there may find a use for bits of it....towards the end of the -*
*-game I got very sloppy - normally my code looks quite nice.   -*
*-If you do find it useful, give me a credit somewhere, or send -*
*-me something you have done, if anyone wants anything          -*
*-explained (it is all simple though) drop me a line at :       -*
*-WHITEHOUSE BARN FARM, ENGLISH BICKNOR, NR.COLEFORD, GLOS,     -*
*-GL16 7PA, Tele: 01594 861453                                  -*

  		section Bashii,CODE
		OPT C-,D+	
	 	opt NODEBUG
		opt p=68000 		

	incdir	"tools:devpac/include"
	include "exec/exec_lib.i"
	include	"exec/exec.i"
	include	"libraries/dosextens.i"

	incdir	"code:AlienBashII"
	include	"glens_code/equates.s"
	include "glens_code/game_equates.s"	

*Assembler directions

LOAD_FROM_HARD_DISK	EQU	0
*final_version		EQU	0


*-----------Entry point to AlienBashII----------------*

	movem.l	d0/a0,-(sp)

	jsr	Open_Dos

	sub.l	a1,a1
	move.l  4.w,a6
	jsr	_LVOFindTask(a6)

	move.l	d0,a4

	tst.l	pr_CLI(a4)	; was it called from CLI?
	bne.s   fromCLI		; if so, skip out this bit...

	lea	pr_MsgPort(a4),a0
	move.l  4.w,a6
	jsr	_LVOWaitPort(A6)
	lea	pr_MsgPort(a4),a0
	jsr	_LVOGetMsg(A6)
	move.l	d0,returnMsg

	jsr	Find_Program_Directory
	

fromCLI
	movem.l	(sp)+,d0/a0

	bsr	Stop_System		;Stop tasking
	bsr	Allocate_Game_Memory
	tst.l	d0	
	beq.s	cant_start_game
	bsr	Allocate_SFX		; have we lots of chip mem??
	tst.l	d0			;OK?
	beq.s	cant_start_game
	jsr	AGA_Enhancements	; can we have music during game - enough speed??
	bsr	Setup_Int
	bsr	Blank_Out_Workbench
	jsr	Create_Fade_Palettes
	bsr	Set_Up_Sound_Fx		; get offsets into allocted data
	bsr	Convert_Clip_Data	; Set up scanner stuff (only needs doing once)
	bsr	Load_Game_Basics	
	bsr	low_pas_filter_off
	bsr	Scheduler
	bsr	Replace_System		;Dealloc mem etc
cant_start_game	
	bsr	Release_System		;Enable tasking again

	move.l	d0,-(sp)

	tst.l	returnMsg		; Is there a message?
	beq.s	exitToDOS		; if not, skip...

	jsr	Reset_To_Old_Directory

	move.l	4.w,a6
        jsr	_LVOForbid(a6)          ; note! No Permit needed!

	move.l	returnMsg(pc),a1
	jsr	_LVOReplyMsg(a6)

exitToDOS
	jsr	Close_Dos
	move.l	(sp)+,d0		; exit code
	rts

returnMsg dc.l	0


QUIT_GAME	EQU	-99
GAME_LOOP	EQU	0	
MAN_DEATH	EQU	1*4
INTRO		EQU	2*4
GAME_SETUP	EQU	3*4
CREDITS		EQU	4*4
HI_SCORES	EQU	5*4
GAME_OVER	EQU	6*4
INSTRUCTIONS	EQU	7*4
END_LEVEL	EQU	8*4
SHOP_SCREEN	EQU	9*4
HI_SCORE_ENTRY	EQU	10*4
NEXT_LEVEL	EQU	11*4
LEVEL_LOADING	EQU	12*4
SKIP_LEVEL	EQU	13*4
	

******************************************
*****     SCHEDULER                  *****
******************************************
Scheduler

	cmp.w	#QUIT_GAME,Schedule_entry
	beq.s	Finished_Game
	moveq	#0,d0
	move.w	Schedule_entry,d0
	move.l	#schedule_table,a0
	move.l	(a0,d0),a0
	jsr	(a0)
	bra.s	Scheduler
Finished_Game
	rts
	
Schedule_Entry
	dc.w	CREDITS
		
Schedule_table
	dc.l	Main_Game_Routine	
	dc.l	Man_Death_Routine
	dc.l	Intro_Routine
	dc.l	Set_Game_Environment
	dc.l	Title_Screen
	dc.l	Show_Hi_Scores
	dc.l	Game_Over_Routine
	dc.l	Show_Instructions
	dc.l	End_Of_Level_Routine
	dc.l	Open_Shop
	dc.l	Enter_Hi_Score
	dc.l	Set_Up_Next_Level
	dc.l	Level_Loading_Routine
	dc.l	Display_End_Text

************************************************************
*****           MAIN GAME ROUTINE                 **********
************************************************************
Main_Game_Routine
	bsr	sync
 	bsr	Get_Stick_Readings
	bsr	Process_Player_Movement	
	bsr	Frame_Dependant_Code	
	bsr	draw_blocks_for_scroll
	bsr	Flash_Player
	bsr	Sound_Effects	
	cmp.w	#GAME_LOOP,Schedule_Entry
	bne.s	Exit_Game_Loop
	ifnd	final_version
	btst.b	#6,$bfe001
	bne.s	Main_Game_Routine
	move.w	#QUIT_GAME,Schedule_Entry
	endc
Exit_Game_Loop	
	rts

************************************************************
*****            MAN DEATH ROUTINE                 **********
************************************************************
Man_Death_Routine
	bsr	sync
	
	tst	count_down_to_death
	beq.s	do_death_routine
	
	bsr	Spin_Player
	bsr	Flash_Red_Player
	bsr	Display_Player
	subq.w	#1,count_down_to_death
	bgt.s	keep_spinning
	
	bsr	Explode_Player
	bsr	Remove_Player
	bra.s	keep_spinning
do_death_routine	
	
	bsr	Shake_Screen
keep_spinning	
	bsr	Position_Scroll   
	tst.b	frame_skip
	bne.s	MD_Speed_25_Hz_2
MD_Speed_25_Hz_1	
	bsr	Buffer_Alien_Lists
	bsr	Delete_Alien_List
		
	bsr	Do_Alien_Collision
	bsr	Extract_Pigs_From_Alien_List   ;bah humbug
	bsr	Process_Switch_Lists
	
	bsr	Process_Aliens
	bsr	Process_Bullets
	bra.s	MD_Speed_50_Hz
MD_Speed_25_Hz_2
	bsr	Swap_Buffers
	bsr	Draw_Current_Alien_List
MD_Speed_50_Hz
	bchg	#0,frame_skip
		
	bsr	Sound_Effects	
	cmp.w	#MAN_DEATH,Schedule_Entry
	beq.s	Man_Death_Routine
	move.w	#150,Player_Invincible_Timer
	bsr	Restore_Colours_Norm
	move.w	old_sx,scroll_x_position
	move.w	old_sy,scroll_y_position
	clr.w	last_x_direc	;stop any unwanted velocity
	clr.w	last_y_direc
	rts

************************************************************
***** 		INTRO ROUTINE                     **********
************************************************************	
Intro_Routine
	jsr	Text_Test
	move.w	#GAME_LOOP,Schedule_Entry
	rts

******************************************
********    SET GAME ENVIRONMENT    ******
******************************************
Set_Game_Environment
	bsr	Reset_Main_Game_Vars
	bsr	Reset_Level
	bsr	Game_Set_Up		; set up pointers, lists, screens
	bsr	Setup_System		; set up copper etc
	move.w	#INTRO,Schedule_Entry
	rts	

******************************************
********    TITLE SCREEN            ******
******************************************
Title_Screen	
	jsr	Display_Title_Picture	
	rts

******************************************
********    GAME OVER ROUTINE       ******
******************************************
Game_Over_Routine
	tst.w	QuitFromGame
	bne.s	Continues_Not_Enabled_So_Continue
	tst.w	Enable_Continues
	beq.s	Continues_Not_Enabled_So_Continue
	tst.w	Continue_Credits
	beq.s	Continues_Not_Enabled_So_Continue
	jsr	Check_For_Continue
	tst.w	d0
	beq.s	Continues_Not_Enabled_So_Continue
	rts
Continues_Not_Enabled_So_Continue	
	jsr	Stop_Looping_Sample	;just in case
	jsr	Game_Over_Screen
	bsr	Return_From_Game
	rts
	

******************************************
********    RETURN FROM GAME        ******
******************************************	
Return_From_Game
	jsr	Black_Out_Everything
	jsr	Switch_Off_Text_Screen
	move.w	#BIT_PLANE_DMA,dmacon(a6)	;turn off screen
	move.l	last_score,d0
	cmp.l	score,d0
	bge.s	no_hi_score
	move.w	#HI_SCORE_ENTRY,schedule_entry
	bra.s	dont_return_to_credits
no_hi_score	
	move.w	#CREDITS,schedule_entry
dont_return_to_credits	
	bsr	Reset_Buffers
	clr.l	Sound_chan1
	clr.l	Sound_Chan3
	move.w	#1,loader_type
	move.w	#1,level_loading_flag
	bsr	Level_Loading_Routine
	rts

******************************************
********    SHOW INSTRUCTIONS       ******
******************************************
Show_Instructions
	jsr	Display_Instructions_Picture
	rts	


************************************************************
*****            END OF LEVEL ROUTINE             **********
************************************************************
End_Of_Level_Routine
	bsr	sync

	tst.w	count_down_to_death
	bpl.s	player_run_away
	subq.w	#1,count_down_to_death
	bra.s	Add_Rand_Expl	
player_run_away	
	cmp.w	#1,count_down_to_death
	bne.s	player_not_safe
	clr.w	count_down_to_death
	bsr	Delete_Points_From_Scanner
	bsr	Remove_Player
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	addq.w	#5,d0
	addq.w	#4,d1
	move.l	#Appear_Object,d2
	bsr	Simple_Add_Alien_To_List
	bra.s	player_not_safe	

Add_Rand_Expl	
	bsr	Add_Random_Explodes
	cmp.w	#-100,count_down_to_death
	beq.s	Display_End_Text
	
player_not_safe
	bsr	Shake_Screen	
	bsr	Position_Scroll   
	tst.b	frame_skip
	bne.s	EL_Speed_25_Hz_2
EL_Speed_25_Hz_1	
	bsr	Buffer_Alien_Lists
	bsr	Delete_Alien_List
	bsr	Process_Aliens
	bsr	Process_Bullets
	bra.s	EL_Speed_50_Hz
EL_Speed_25_Hz_2
	bsr	Swap_Buffers
	bsr	Draw_Current_Alien_List
EL_Speed_50_Hz
	bchg	#0,frame_skip
		
	bsr	Sound_Effects	
	cmp.w	#END_LEVEL,Schedule_Entry
	beq	End_Of_Level_Routine	
	
Display_End_Text
	cmp.b	#'H',Level_Number
	beq.s	Completed_Game
	jsr	Level_Over_Screen		
	jsr	Black_Out_Everything
	bsr	Reset_Buffers
	move.w	#1,level_loading_flag
	move.w	#1,loader_type
	bsr	Level_Loading_Routine
	move.w	#SHOP_SCREEN,Schedule_Entry
	rts
Completed_Game
	bsr	Remove_Scanner
	bsr	Remove_Player
	jsr	Display_End_Game
	bsr	Return_From_Game
	rts	

start_explosions
	move.w	#-1,count_down_to_death
	rts


******************************************
********    ENTER HI SCORE          ******
******************************************
Enter_Hi_Score
	jsr	Hi_Score_Screen
	rts
	
******************************************
********    SET UP NEXT LEVEL       ******
******************************************
Set_Up_Next_Level
	bsr	Change_Level
	move.w	#INTRO,schedule_entry
	rts	

******************************************
********    GAME SET UP             ******
******************************************
Game_Set_Up	
	clr.b	frame_skip
	bsr	Reset_Buffers
	bsr	Level_Loading_Routine
	bsr	Set_Up_Level_Pointers
	bsr	Initialise_Level
	rts


************************************************************
***** S C R E E N      S Y N C                    **********
************************************************************	
	
sync
	move.w	#$0010,intreq(a6)	
wait_for_bit	
	btst.b	#4,intreqr+1(a6)
	beq.s	wait_for_bit
	ifnd	final_version
Wait_R_Release
	btst.b	#6,$bfe001
	beq.s	Skip_R_Mouse
	btst.b	#10,$dff016
	beq.s	Wait_R_Release
	rts
Skip_R_Mouse		
	btst.b	#6,$bfe001
	beq.s	Skip_R_Mouse
	endc
	rts



Wait_R_Mouse
	btst.b	#10,$dff016
	beq.s	Wait_R_Mouse
	rts


************************************************************
*****           FRAME DEPENDANT CODE              **********
************************************************************
Frame_Dependant_Code
	tst.b	frame_skip
	bne.s	Speed_25_Hz_2
Speed_25_Hz_1	
	bsr	Buffer_Alien_Lists
	bsr	Delete_Alien_List
	bsr	Do_Alien_Collision
	bsr	Do_Player_Alien_Collision
	bsr	Extract_Pigs_From_Alien_List   ;bah humbug
	bsr	Process_Switch_Lists
	bsr	Process_Aliens
	bsr	Process_Bullets
	bsr	Check_Player_Fire
	bsr	Delete_Points_From_Scanner
	bsr	Display_Points_On_Scanner
	bra.s	Speed_50_Hz
Speed_25_Hz_2
	bsr	Swap_Buffers
	bsr	Check_Change_Weapon 
	bsr	Update_Panel
	bsr	Draw_Current_Alien_List
Speed_50_Hz

	bchg	#0,frame_skip


	rts

************************************************************
*****           RUN ALIEN CODE                    **********
************************************************************
Run_Alien_Code

	bsr	Move_Scroll
	
	tst	frame_skip
	bne.s	skip25
	bsr	Buffer_Alien_Lists
	bsr	Delete_Alien_List
	bsr	Process_Aliens
	bra.s	skip50
skip25
	bsr	Swap_Buffers
	bsr	Draw_Current_Alien_List
skip50

	bchg	#0,frame_skip


	rts

*************************************************************
***               PROCESS PLAYER MOVEMENT                 ***
*************************************************************
Process_Player_Movement
	

	bsr     Move_Scroll	
	tst.b	Invincible_Flag
	bne.s	dont_display_player
	bra.s	done_check_for_invin
dont_display_player
	bsr	Remove_Player
	bra.s	perform_player_code
done_check_for_invin		
	bsr	Display_Player

perform_player_code	


	bsr	What_Is_Player_Standing_On
	bsr	Move_Player
	bsr	Work_Out_Scroll_Movement
	
	rts


frame_skip
	dc.b	0
	EVEN

*************************************************************
***                  GAME INCLUDES                        ***
*************************************************************

*----------------CODE------------------

	include "glens_code/object_code.s"
	include "glens_code/setup_routines.s"
	include	"glens_code/interrupt_routines.s"
	include "glens_code/four_way_scrolltest.s"
	include "glens_code/buffer_routines.s"
	include	"glens_code/sprite_routines.s"
	include	"glens_code/player_routines.s"
	include	"glens_code/collision_routines.s"
	include "glens_code/alien_routines.s"
	include	"glens_code/bullet_routines.s"
	include	"glens_code/bullet_hit_routines.s"
	include "glens_code/joy_routines.s"
	include	"glens_code/player_alien_collisions.s"
	include	"glens_code/panel_routines.s"
	include	"glens_code/level_code.s"
	include	"glens_code/map_routines.s"
	include	"glens_code/block_effects.s"
	include	"glens_code/alien_intelligence.s"
	include "glens_code/pig_intelligence.s"
	include	"sound/game_sound.s"
	include	"glens_code/scanner_routines.s"
	include	"glens_code/switch_routines.s"
	include	"glens_code/text_routines.s"
	include	"glens_code/file_routines.s"
	include	"glens_code/demo_routines.s"
	include	"glens_code/hi_score_routines.s"
	include	"glens_code/shop_routines.s"
	include	"glens_code/instructions.s"
	include	"glens_code/aga_stuff.s"
	
*----------------DATA------------------

	section ALIENBASHII,DATA
	include	"level_data/level_data.s"		
	include	"data/block_data_information.s"
	include	"data/alien_data.s"
	include	"data/alien_data2.s"
	include	"data/alien_special_data.s"
	include	"data/generator_attacks.s"
	include	"data/weapon_data.s"
	include	"data/map_buffer_data.s"
	include	"data/scanner_data.s"
	include	"data/man_explode_data.s"
	include	"data/generator_explode_data.s"
	include	"data/font_info_data.s"
	include	"data/switch_data.s"
	include	"data/alien_code_data.s"
	include	"graphics/panel_graphics.s"	;fast mem graphics	
	include	"data/direc_data.s"	
shareware_pic
	incbin	"graphics/reminder.pic"	
	even	
	include	"graphics/stars.s"
	include "data/scrolly_data.s"
	include	"data/instruction_pages.s"
	include	"data/alien_graphics_data.s"
	include	"sound/effects_data.s"
	include	"data/text_routines_data.s"
	include	"data/colour_data.s"
small_bullet_type
	incbin	"graphics/smallbulls.bin"
green_bullet_type
	incbin	"graphics/greenbulls.bin"
long_bullet_type
	incbin	"graphics/longbulls.bin"
	even		
Get_Ready_Graphics
	incbin	"graphics/get_ready.bin"	
	even
Get_Ready_Names
	incbin	"graphics/level_names.bin"
	incbin	"graphics/level_numbers.bin"
	even
	
	 	
*----------------GRAPHICS--------------
	
	section	AlienBashII,Code_C

scanner3
	include	"graphics/newscanner.s"
	include	"graphics/pause.s"
	include "graphics/alien_graphics.s"
	include "graphics/player_graphics.s"
	include	"data/copper_list.s"
malfont	
	incbin	"graphics/malfont.bin"
smallfont
	incbin	"graphics/smallerfont.bin"		
panel_graphics
	incbin	"graphics/crappanel.bin"
	even	

Sound_Blank		
blank_data
	ds.w	4

*- When I was planning on expanding this game, I started to split the 	-*
*- game up into chunks for linking, however I did not finish so only 	-*
*- a few bits have been done.....oh well				-*
	
	xref	Read_Keyboard
	xref	Do_Rings
	xref	Add_New_Ring
	xref	Tube_Set_Up
	xref	mt_init
	xref	mt_end
	xref	mt_music
	xref.w	master_volume
	xdef.w	music_chans_2
	xref.l	current_song_ptr
	
	xdef.l	Fast_Memory_Base
	xdef.w	Chip_Type
	xdef.l	Plane1
	xdef.l	Plane2
	xdef.l	Plane3
	xdef.l	buff_Plane1
	xdef.l	buff_Plane2
	xdef.l	buff_Plane3
	xdef.l	InPlane1_lo
	xdef.l	InPlane2_lo
	xdef.l	InPlane3_lo
	xdef.l	InPlane1_hi
	xdef.l	InPlane2_hi
	xdef.l	InPlane3_hi
	xdef.w	frame_skip
	xdef.w	fade_music
	
		
