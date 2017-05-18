**************************************
****     RESET LEVEL              ****
**************************************
Reset_Level
	move.b	#'A',level_number
	move.l	#level_list,current_level_list_ptr
	rts

**************************************
****     SET UP LEVEL POINTERS    ****
**************************************
Set_Up_Level_Pointers

*level_graphics_ptr should be changed so it can act as a flag
*to see if new graphics need to be loaded for the level

	move.l	current_level_list_ptr,a0
	cmp.l	#$ffffffff,(a0)
	bne.s	not_end_of_level_list
	move.l	#Level_List,current_level_list_ptr
	move.b	#'A',level_number	
	bra.s	Set_Up_Level_Pointers
not_end_of_level_list	
	move.l	(a0),a0
	move.l	a0,current_level
	move.l	background_block_graphics,level_background_blocks
	move.l	level_palette_ptr(a0),level_palette
	move.l	level_sprite_palette_ptr(a0),sprite_palette
	move.w	level_map_x_start(a0),scroll_x_position
	move.w	level_map_y_start(a0),scroll_y_position
		
	move.w	#144,d0	;player always starts in middle
	move.w	#120,d1

	asl	#PLAYER_SCALE,d0
	asl	#PLAYER_SCALE,d1
	
	move.w	d0,player_x_position
	move.w	d1,player_y_position
	
	asr	#PLAYER_SCALE,d0
	asr	#PLAYER_SCALE,d1
	
	move.w	d0,actual_x_position
	move.w	d1,actual_y_position
	add.w	level_map_x_start(a0),d0
	add.w	level_map_y_start(a0),d1
	move.w	d0,actual_player_map_x_position
	move.w	d1,actual_player_map_y_position
	
	move.w	d0,last_scrollx_position
	move.w	d1,last_scrolly_position
	
	rts

**************************************
****    DO_LEVEL_COLOURS          ****
**************************************
Do_Level_Colours
	
	move.l	#copper_colours,a0
	move.l	level_palette,a1
	bsr	Insert_Colours
	rts

**************************************
****    DO_SPRITE_COLOURS         ****
**************************************
Do_Sprite_Colours

	move.l	#sprite_cols,a0
	move.l	sprite_palette,a1
	bsr	Insert_Sprite_Colours
	rts

**************************************
****     INITIALISE_LEVEL         ****
**************************************
Initialise_Level

*Set up custom base
	move.l	#$dff000,a6

*free scroll
	clr.w	freeze_scroll

*Set up alien strength
	bsr	Set_Up_Alien_Strengths
	
*Set up bullet data
	bsr	Set_Up_Bullet_Type	
	bsr	Set_Up_Rocket_Type
*Set up Variables

	bsr	Set_Up_Variables		
	bsr	Set_Up_Gun_Power
	bsr	Do_Sprite_Colours
	bsr	Setup_Bullet_Pointers
	bsr	Switch_Setup
	bsr	Set_Up_Panel
	bsr	Display_Total_Energy_Bars
	bsr	Display_Total_Energy
	bsr	Display_Player_Lives
	bsr	Display_Weapon_Power_Level
	bsr	Display_Grenade_Packs
	bsr	Display_Weapon_On_Panel
	bsr	Do_Money_Update	;clears cash indicator	
	bsr	Fill_Random_Table
	move.w	#100,Player_Invincible_Timer	;start flashing buddy
	
*Load in map data

	bsr	Load_Map_Data	
	
	bsr	Setup_Scanner		
	bsr	Setup_Scanner_Data	;dependent on new map
		
*Setup and draw map onto screen

	bsr	Setup_Alien_Pointers
	bsr	set_up_scroll_position
	
	move.l	loader_pic_data,a0
	add.l	#size_of_iff_header+4,a0
	move.l	#black_list,a1
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	move.w	#1,fade_speed
	bsr	Fade_32_List_To_List
	
	move.l	current_level,a0
	move.w	level_map_x_start(a0),d0
	move.w	level_map_y_start(a0),d1
	
*Insert specific sound player routine depending on level
	cmp.w	#OFF,xtra_fx	;dont bother if sfx not loaded
	beq.s	Insert_Regular_Player	
	cmp.b	#'B',level_number
	beq.s	Insert_3_Chan_Player
	cmp.b	#'G',level_number
	beq.s	Insert_3_Chan_Player	
Insert_Regular_Player
	move.l	#Sound_Effects_Normal,sound_effects_code
	bra.s	Turn_On_Screen
Insert_3_Chan_Player	
	move.l	#Sound_Effects_3_Chan,sound_effects_code	
Turn_On_Screen
	move.w  #BIT_PLANE_DMA,dmacon(a6)	;hide sins
	bsr	fill_screen_with_blocks
	rts

**************************************
****     SET UP VARIABLES         ****
**************************************
Set_Up_Variables

	move.w	gun_level,weapon_level
	move.w	gun_type,weapon_power
	move.w	#DEFAULT_DISTANCE,grenade_distance
	clr.w	wasps_on_screen
	clr.w	pigs_on_screen
	clr.w	number_of_keys
	clr.w	Inter_Score
	clr.w	End_of_level_key
	clr.w	last_x_direc
	clr.w	last_y_direc
	clr.w	player_x_inc
	clr.w	player_y_inc
	clr.w	generator_activate
	move.l	current_level,a5
	move.l	level_generator_pattern(a5),Generator_Level_Pattern		
	move.l	level_generator_pattern(a5),Chain_Generator_Level_Pattern	;botch
	move.b	#PLAYER_DOWN,man_direction
	move.w	#PLAYER_DOWN,last_direction
	clr.w	player_current_frame
	clr.w	sound_chan1
	clr.w	sound_chan2
	clr.w	sound_chan3
	clr.w	sound_chan4
	bsr	Clear_Key_Indicators	
	rts
	
**************************************
****     RESET MAIN GAME VARS     ****
**************************************
Reset_Main_Game_Vars

	
	bsr	Reset_Energy_Bars
	
	move.w	#2,current_energy_modules
	move.w	current_energy_modules,d0
	asl	#2,d0
	mulu	#NUMBER_HITS_PER_UNIT,d0
	move.w	d0,Player_Current_Energy
	move.w	d0,Player_Energy_Limit

	clr.w	QuitFromGame	
	move.w	#3,Player_Lives		;*****
	move.w	#3,Continue_Credits
	
	clr.w	Cash
	clr.l	score	
	clr.w	stars_up
	clr.w	title_pic_loaded

	move.w	#STANDARD_GUN,weapon_power
	clr.w	gun_level
	move.w	#STANDARD_GUN,gun_type
	clr.w	rocket_level
	clr.w	grenade_level
	clr.w	weapon_level
	clr.w	rocket_packs		
	clr.w	rockets_in_pack		
	clr.w	grenade_packs		
	clr.w	grenades_in_pack 	
	
	bsr	Set_Up_Shop_Prices
	rts

**************************************
****    FILL RANDOM TABLE         ****
**************************************
Fill_Random_Table

*Get number for seed
	move.w	$dff006,old_seed	;good for a laugh

	move.l	#random_direction_table,a4
	move.l	a4,random_direction_ptr		;reset
	move.l	#get_direction_from_num_table,a5
	move.w	#NUMBER_OF_RAN_DIRS-1,d7
get_random_dir
	moveq	#0,d0
	move.w	#7,d1
	bsr	Get_Random_Number
	ext.l	d0
	move.b	(a5,d0),(a4)+
	dbra	d7,get_random_dir
	rts
	
get_direction_from_num_table	
	dc.b	%0000	;up
	dc.b	%0001	;down right
	dc.b	%0010	;right
	dc.b	%0101	;down left
	dc.b	%1000	;down
	dc.b	%0110	;left
	dc.b	%1001	;up right	
	dc.b	%1101	;up left
		
****************************************
******  SET UP GUN POWER           *****
****************************************
Set_Up_Gun_Power

*STANDARD GUN - TRIPLE

	move.w	weapon_power,d0
	asr	#2,d0
	addq.w	#1,d0

	move.w	gun_level,d1
	addq.w	#1,d1
	mulu	d1,d0	

	move.w	d0,gun_power
	
	
	move.w	weapon_power,current_weapon
	
	rts

****************************************
******  CHANGE LEVEL               *****
****************************************
Change_Level
	bsr	Black_Out_Everything
	addq.l	#4,current_level_list_ptr
	addq.b	#1,level_number
	bsr	Game_Set_Up
	bsr	Setup_System
	rts


*******************************************
*****    LEVEL LOADING ROUTINE      *******
*******************************************
Level_Loading_Routine

*just for now clear planes

	move.w	#$5200,shareware_screen_copper+2
	move.w	#$38,sharestart
	move.w	#$d0,sharestop

	move.w	#((LO_RES_PLANE*5)/4)-1,d1
	move.l	memory_base,a0
	tst	loader_type
	bne.s	skip_add_map
	add.l	#(BIGGEST_MAP_X*BIGGEST_MAP_Y*3),a0
skip_add_map	
	move.l	a0,d0
clear_temp
	clr.l	(a0)+
	dbra	d1,clear_temp
	
	move.l	#plane_positions,a2
	move.l	d0,(a2)
	move.w	d0,SHPlane1_lo
	swap	d0
	move.w	d0,SHPlane1_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.l	d0,4(a2)
	move.w	d0,SHPlane2_lo
	swap	d0
	move.w	d0,SHPlane2_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.l	d0,8(a2)
	move.w	d0,SHPlane3_lo
	swap	d0
	move.w	d0,SHPlane3_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.l	d0,12(a2)
	move.w	d0,SHPlane4_lo
	swap	d0
	move.w	d0,SHPlane4_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.l	d0,16(a2)
	move.w	d0,SHPlane5_lo
	swap	d0
	move.w	d0,SHPlane5_hi

**********decompress nebula background*********
	moveq	#0,d3		;index into plane table
	move.w	#320,d4		;screen x size
	move.w  #5*4,d7		;number of planes ( *4 cos compare d3 with it - will inc by 4)
	move.w	#320,d6     	; pixel count ( count down )
	move.w	#320,d5		; image loaded size
	move.l  (a2,d3),a4	;get first plane
	move.l	loader_pic_data,a1
	addq.l	#4,a1		;skip ident
	move.w	iff_cols(a1),d0
	move.l	pic_data_size(a1),size_of_pic
	ext.l	d0
	asl	d0
	add.l	#size_of_iff_header,a1
	add.l	d0,a1
	move.l	a1,picture_data	
	moveq	#0,d0		;clear
	move.l	size_of_pic,d2
	bsr	compressed_data		;Display pic
***********Finished decompressing nebula pic*********	

	bsr	Clear_Black_Colours
	bsr	Clear_Game_Colours


	move.l	#Share_Cols,a0		
	move.l	#Black_List,a1
	bsr	Insert_32Colours
	
	move.l	#shareware_screen_copper,cop1lch(a6)
	clr.w	copjmp1(a6)
	jsr	Sync
	move.w  #BIT_PLANE_DMA+SPRITE_DMA+$8000,dmacon(a6)	

	
	move.l	#black_list,a0
	move.l	loader_pic_data,a1
	add.l	#size_of_iff_header+4,a1
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	move.w	#1,fade_speed
	bsr	Fade_32_List_To_List
	
	bsr	Wait_For_Blit_To_Finish
	move.w	#1,FadeAfterLoading
	clr.w	loader_type	
	rts

loader_type		dc.w	0	;0=level load, 1=general load 
level_loading_flag	dc.w	0	
	
*******************************************
*****    WAIT FOR BLIT TO FINISH    *******
*******************************************
Wait_For_Blit_To_Finish
	btst	#14,dmaconr(a6)
	bne.s	Wait_For_Blit_To_Finish
	rts


**************************************
**** SET UP ALIEN STRENGTHS       ****
**************************************
Set_Up_Alien_Strengths
	move.l	current_level,a0
	move.l	level_strength_table(a0),a0
	cmp.l	#0,a0
	beq.s	finished_strengths
Set_Up_Strengths_Loop
	cmp.l	#$ffffffff,(a0)
	beq.s	finished_strengths
	move.l	(a0)+,a1
	move.w	(a0)+,alien_hit_count(a1)
	bra.s	Set_Up_Strengths_Loop
finished_strengths	
	rts

level_background_blocks	dc.l	0
level_map			dc.l	0		
current_level			dc.l	Level_1
level_palette			dc.l	0
sprite_palette			dc.l	0

map_x_size			dc.w	0
map_y_size			dc.w	0


Generator_Activate	dc.w	0
Continue_Credits	dc.w	0
Enable_Continues	dc.w	0
