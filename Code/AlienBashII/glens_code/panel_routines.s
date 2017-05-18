
PANEL_MOD	EQU	0

PANEL_HEIGHT	EQU	15
PANEL_WIDTH	EQU	40	;bytes

PANEL_PLANE	EQU	PANEL_HEIGHT*PANEL_WIDTH

KEY_CURSOR_UP	EQU	51
KEY_CURSOR_DOWN	EQU	50
P_KEY		EQU	102	
F1_KEY		EQU	47
F2_KEY		EQU	46
F3_KEY		EQU	45
F4_KEY		EQU	44
F5_KEY		EQU	43
ESCAPE_KEY	EQU	58

*******************************************
***	SET UP PANEL                    ***
*******************************************
Set_Up_Panel
	bsr	Set_Up_Panel_Planes
	bsr	Set_Up_Panel_Colours
	rts

*******************************************
***	SET UP PANEL PLANES             ***
*******************************************
Set_Up_Panel_Planes

	move.l	#panel_graphics,d0
	move.w	d0,panel_plane1l
	swap	d0
	move.w	d0,panel_plane1h
	swap	d0
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,d0
	move.w	d0,panel_plane2l
	swap	d0
	move.w	d0,panel_plane2h
	swap	d0
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,d0
	move.w	d0,panel_plane3l
	swap	d0
	move.w	d0,panel_plane3h
	swap	d0
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,d0
	move.w	d0,panel_plane4l
	swap	d0
	move.w	d0,panel_plane4h
	rts
	
*******************************************
***	SET UP PANEL COLOURS            ***
*******************************************
Set_Up_Panel_Colours
	
	move.l	#panel_colours,a0
	move.l	#panel_cols,a1
	bsr	Insert_Colours
	rts
		
*******************************************
***	UPDATE PANEL                    ***
*******************************************
Update_Panel

	bsr	Beat_Heart
	move.w	inter_score,d0
	ext.l	d0
	add.l	d0,score
	clr.w	inter_score
	bsr	Display_Cash
	rts

*******************************************
***   CONTINUE GAME IF ENOUGH LIVES     ***
*******************************************
Continue_Game_If_Enough_Lives
	subq.w	#1,Player_Lives
	beq.s	Game_Over_For_Player
	move.w	Player_Energy_Limit,Player_Current_Energy
	movem.l	a0-a5/d0-d7,-(sp)
	bsr	Display_Total_Energy
	bsr	Display_Player_Lives
	movem.l	(sp)+,a0-a5/d0-d7
	move.w	#GAME_LOOP,Schedule_Entry
	rts	
Game_Over_For_Player	
	move.w	#GAME_OVER,Schedule_Entry	;else it freezes

	rts

*******************************************
***	RESET ENERGY BARS               ***
*******************************************
Reset_Energy_Bars
	move.l	#panel_graphics+27,a0
	move.l	#panel_graphics+31,a1	;blank energy module
	move.w	#4-1,d0
Reset_Bars_Planes_Loop
	move.w	#14-1,d1
	move.l	a0,a2
	move.l	a1,a3	
Reset_Bars_Loop	
	move.b	(a3),(a2)
	move.b	(a3),1(a2)
	move.b	(a3),2(a2)
	move.b	(a3),3(a2)
	add.l	#PANEL_WIDTH,a3
	add.l	#PANEL_WIDTH,a2
	dbra	d1,Reset_Bars_Loop	
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a0
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a1
	dbra	d0,Reset_Bars_Planes_Loop
	rts

*******************************************
***	DISPLAY TOTAL ENERGY BARS       ***
*******************************************
Display_Total_Energy_Bars
*This routine is the height of laziness - rather than write
*a decent routine to display player energy and other blank bars
*I call this one to set them up and then another to fill them up
*but its at the end now and I REALLY DONT CARE!!!!

	move.l	#panel_graphics+27,a0
	move.l	#panel_energy,a1	;blank energy module
	move.w	#4-1,d0
Disp_Bars_Planes_Loop
	move.w	#14-1,d1
	move.l	a0,a2
	move.l	a1,a3	
Disp_Bars_Loop	
	clr.l	d2
Fill_Bars_Loop	
	move.b	(a3),(a2,d2)
	addq.w	#1,d2
	cmp.w	current_energy_modules,d2
	bne.s	Fill_Bars_Loop
	addq.l	#2,a3
	add.l	#PANEL_WIDTH,a2
	dbra	d1,Disp_Bars_Loop	
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a0
	add.l	#(14*5)*2,a1
	dbra	d0,Disp_Bars_Planes_Loop
	rts


*******************************************
***	UPDATE PLAYER ENERGY            ***
*******************************************
Update_Player_Energy
*Called if a flash request is made

	moveq	#0,d0
	move.w	Player_Current_Energy,d0
	sub.w	hit_count,d0
	ble.s	player_has_died
	move.w	d0,Player_Current_Energy
	subq.w	#1,d0	;else wont work
	asr	#2,d0	;number of hits per bar divide
	move.w	d0,d1
	asr	#2,d0	;bar to update		
	andi.w	#$3,d1
	move.l	#panel_energy,a1
	mulu	#(14*2),d1
	add.l	d1,a1		
	move.l	#panel_graphics+27,a0
	add.l	d0,a0		;get position
	
*now copy in graphics to reflect new energy level (d1)
	
	move.w	#4-1,d1
copy_current_into_panel_plane_loop
	move.l	a0,a3
	move.w	#14-1,d3
copy_current_energy_bar
	move.b	(a1),(a3)		
	addq.l	#2,a1
	add.l	#PANEL_WIDTH,a3
	dbra	d3,copy_current_energy_bar
	add.l	#((14*2)*5)-(14*2),a1
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a0
	dbra	d1,copy_current_into_panel_plane_loop	
	clr.w	hit_count

	rts
			
player_has_died
	move.w	#MAN_DEATH,Schedule_Entry
	move.w	#50,count_down_to_death
	clr.w	player_x_inc
	clr.w	player_y_inc
	move.w	#Sound_Manscream,sound_chan4
	clr.w	hit_count

	move.w	scroll_x_position,old_sx
	move.w	scroll_y_position,old_sy
	rts

hit_count
	dc.w	0		
	
*******************************************
***	DISPLAY PLAYER LIVES            ***
*******************************************
Display_Player_Lives
	move.l	#panel_graphics+19,a0
	move.w	Player_Lives,d0
	subq.w	#1,d0
	bmi.s	end_of_game
	move.l	#panel_lives,a1
	mulu	#(14*2),d0
	add.l	d0,a1
	
	move.w	#4-1,d0
lives_planes_loop
	move.l	a0,a2
	move.l	a1,a3
	move.w	#14-1,d1
lives_copy_loop
	move.b	(a3)+,(a2)
	move.b	(a3)+,1(a2)
	add.l	#PANEL_WIDTH,a2
	dbra	d1,lives_copy_loop
	add.l	#(14*2)*5,a1
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a0
	dbra	d0,lives_planes_loop	
	rts
end_of_game
	rts	

POWER_PLANE	EQU	14*2*3

*******************************************
***	DISPLAY WEAPON POWER LEVEL      ***
*******************************************
Display_Weapon_Power_Level

	move.l	#panel_graphics+8,a0
	move.w	weapon_level,d0
	move.l	#panel_gun_levels,a1
	mulu	#(14*2),d0
	add.l	d0,a1
	
	move.w	#14-1,d0
power_level_loop
	move.w	POWER_PLANE(a1),PANEL_PLANE(a0)
	move.w	POWER_PLANE*2(a1),PANEL_PLANE*2(a0)
	move.w	POWER_PLANE*3(a1),PANEL_PLANE*3(a0)
	move.w	(a1)+,(a0)
	add.l	#PANEL_WIDTH,a0
	dbra	d0,power_level_loop

	rts
	
GRENADE_PLANE	EQU	14*2*5
*******************************************
***	DISPLAY GRENADE PACKS           ***
*******************************************
Display_Grenade_Packs

	move.l	#panel_graphics+10,a0
	
	cmp.w	#ROCKET_LAUNCHER,current_weapon
	bne.s	is_it_grenade
	move.w	rocket_packs,d0
	bra.s	display_the_packs
is_it_grenade
	cmp.w	#GRENADE,current_weapon
	bne.s	not_grenade
	move.w	grenade_packs,d0
	bra.s	display_the_packs
not_grenade
	clr.w	d0	

display_the_packs	
	move.l	#panel_packs,a1
	mulu	#(14*2),d0
	add.l	d0,a1
	
	move.w	#14-1,d0
pack_loop
	move.w	GRENADE_PLANE(a1),PANEL_PLANE(a0)
	move.w	GRENADE_PLANE*2(a1),PANEL_PLANE*2(a0)
	move.w	GRENADE_PLANE*3(a1),PANEL_PLANE*3(a0)
	move.w	(a1)+,(a0)
	add.l	#PANEL_WIDTH,a0
	dbra	d0,pack_loop

	rts
	

	
*******************************************
***	DISPLAY TOTAL ENERGY            ***
*******************************************
Display_Total_Energy
*Routine adds all the energy to the panel

	
	move.l	#panel_graphics+27,a1
	move.w	Player_Current_Energy,d0
	asr	#2,d0
add_energy_to_panel
	tst	d0
	ble.s	finished_adding_energy
	cmp.w	#4,d0
	bge.s	more_than_one_bar
	move.w	d0,d7
	bra.s	calc_bar_type
more_than_one_bar	
	move.w	#4,d7
calc_bar_type	
	subq.w	#4,d0
		
	move.l	#panel_energy,a0
	mulu	#(14*2),d7
	add.l	d7,a0
	
	move.l	a1,a2	
	move.w	#4-1,d1
copy_into_panel_plane_loop
	move.l	a2,a3
	move.w	#14-1,d3
copy_energy_bar
	move.b	(a0),(a3)		
	addq.l	#2,a0
	add.l	#PANEL_WIDTH,a3
	dbra	d3,copy_energy_bar
	add.l	#PANEL_WIDTH*PANEL_HEIGHT,a2
	add.l	#((14*2)*5)-(14*2),a0
	dbra	d1,copy_into_panel_plane_loop	
	addq.l	#1,a1
	bra.s	add_energy_to_panel
finished_adding_energy	
	rts	
	
	
*******************************************
***	BEAT_HEART                      ***
*******************************************
Beat_Heart		

	subq.w	#1,beat_counter
	bne	dont_update_heart_frame
	move.w	#2,beat_counter
	
	
	addq.w	#1,beat_pattern
	cmp.w	#10,beat_pattern
	bne.s	not_reached_end_of_pattern
	clr.w	beat_pattern
not_reached_end_of_pattern	
	move.w	beat_pattern,d0
	move.l	#Panel_Liquid,a0
	mulu	#14*2,d0
	add.l	d0,a0
	
	move.l	#panel_graphics+24,a1

wait_for_old_blit		
	btst	#14,dmaconr(a6)
	bne.s	wait_for_old_blit

	clr	bltamod(a6)
	move.w	#PANEL_WIDTH-2,bltdmod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09f00000,bltcon0(a6)
	
	move.l	a0,bltapth(a6)
	move.l	a1,bltdpth(a6)
	move.w	#14<<6+1,bltsize(a6)
	
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,a1
	add.l	#(14*2)*10,a0
	
wait_for_heart1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_heart1

	move.l	a0,bltapth(a6)
	move.l	a1,bltdpth(a6)
	move.w	#14<<6+1,bltsize(a6)
	
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,a1
	add.l	#(14*2)*10,a0
	
wait_for_heart2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_heart2

	move.l	a0,bltapth(a6)
	move.l	a1,bltdpth(a6)
	move.w	#14<<6+1,bltsize(a6)
	
	add.l	#PANEL_HEIGHT*PANEL_WIDTH,a1
	add.l	#(14*2)*10,a0
	
wait_for_heart3
	btst	#14,dmaconr(a6)
	bne.s	wait_for_heart3

	move.l	a0,bltapth(a6)
	move.l	a1,bltdpth(a6)
	move.w	#14<<6+1,bltsize(a6)
dont_update_heart_frame
		
	rts
		
Beat_Pattern
	dc.w	0
	
Beat_Counter
	dc.w	2


WEAPON_NUMBER	EQU	5
WEAPON_PLANE	EQU	14*4*WEAPON_NUMBER
	
*******************************************
***	DISPLAY WEAPON ON PANEL         ***
*******************************************
Display_Weapon_On_Panel
	move.l	#panel_graphics+4,a0
	
	move.w	current_weapon,d0
	mulu	#14,d0		;get to place in graphics
	move.l	#panel_weapons,a1
	add.l	d0,a1

	move.w	#14-1,d0
fast_weapon_copy_loop

	move.l	WEAPON_PLANE(a1),PANEL_PLANE(a0)
	move.l	WEAPON_PLANE*2(a1),PANEL_PLANE*2(a0)
	move.l	WEAPON_PLANE*3(a1),PANEL_PLANE*3(a0)
	move.l	(a1)+,(a0)
	
	add.l	#PANEL_WIDTH,a0
	
	dbra	d0,fast_weapon_copy_loop
	
	rts	

PANEL_DIGITS_PLANE	EQU 10*14*2

*******************************************
***	DISPLAY CASH                    ***
*******************************************
Display_Cash

	tst	Cash_Request
	beq.s	there_is_an_update_request
	rts
there_is_an_update_request	
	subq.w	#1,cash_frame_wait
	ble.s	do_money_update
	rts	
	
do_money_update	
	move.w	#CASH_FRAME_NUM,cash_frame_wait
	move.w	#1,Cash_Request


	move.l	#panel_graphics+35,a2
	move.l	#panel_digits,a3

	clr.l	d0
	move.w	cash,d0
	move.l	#10000,d1
cash_loop

	move.l	a2,a1
	move.l	a3,a0	
	divu	d1,d0
	move.w	d0,d2
	clr.w	d0
	swap	d0
	
	mulu	#14*2,d2
	add.l	d2,a0
	
	moveq.w	#14-1,d3
quick_cash_copy
	move.b	PANEL_DIGITS_PLANE(a0),PANEL_PLANE(a1)	
	move.b	PANEL_DIGITS_PLANE*2(a0),PANEL_PLANE*2(a1)
	move.b	PANEL_DIGITS_PLANE*3(a0),PANEL_PLANE*3(a1)
	move.b	(a0),(a1)
	add.l	#PANEL_WIDTH,a1
	addq.l	#2,a0
	dbra	d3,quick_cash_copy
	
	add.l	#14*2*10*4,a3
	
	addq.l	#1,a2
	cmp.w	#1,d1
	beq.s	done_money
	divu	#10,d1
	bra.s	cash_loop
done_money	
	rts	

****************************************
******  Check_Change_Weapon        *****
****************************************
Check_Change_Weapon
	tst	weapon_wait
	ble.s	test_for_key
	subq.w	#1,weapon_wait
	rts
test_for_key
	btst.b	#6,$bfe001
	beq.s	key_pressed	
	tst.w	use_2_butt
	bne.s	dont_test_2_butt
	tst.w	resistance
	bne.s	not_p_pressed
dont_test_2_butt	
	clr.l	d0
	move.b	$bfec01,d0
	ror.b	d0
	btst	#7,d0
	bne.s	key_pressed
	rts
key_pressed	


*Has P for pause been pressed
	andi.b	#$7f,d0
	cmp.b	#P_KEY,d0
	bne.s	not_p_pressed

	bsr	Pause_The_Game
	rts

not_p_pressed
	cmp.w	#GRENADE,current_weapon
	bne.s	dont_check_gren_keys
	cmp.b	#KEY_CURSOR_UP,d0
	beq	increase_sight_pos
	cmp.b	#KEY_CURSOR_DOWN,d0
	beq	decrease_sight_pos
dont_check_gren_keys	
	cmp.b	#F1_KEY,d0
	beq	select_control_method_1
	cmp.b	#F2_KEY,d0
	beq	select_control_method_2
	cmp.b	#F3_KEY,d0
	beq	select_control_method_3
	ifnd	final_version
	cmp.b	#F4_KEY,d0
	beq	skip_level_cheat
	cmp.b	#F5_KEY,d0
	beq	inc_lives_cheat
	endc		
	cmp.b	#ESCAPE_KEY,d0
	beq	escape_from_game
	bsr	Check_Secret_Code
	move.w	#Sound_Change,sound_chan3
	move.w	#WEAPON_TIME,weapon_wait
	cmp.w	#ROCKET_LAUNCHER,current_weapon
	blt	store_weapon
	cmp.w	#GRENADE,current_weapon
	beq	reset_weapon
	move.w	#GRENADE,current_weapon
	move.w	grenade_level,weapon_level
	bsr	Display_Weapon_On_Panel
	bsr	Display_Grenade_Packs
	bsr	Display_Weapon_Power_Level
	rts
increase_sight_pos
	addq.w	#4,grenade_distance
	cmp.w	#MAX_GRENADE_DISTANCE,grenade_distance
	ble.s	gren_not_max
	move.w	#MAX_GRENADE_DISTANCE,grenade_distance	
gren_not_max	
	rts
decrease_sight_pos
	subq.w	#4,grenade_distance
	cmp.w	#DEFAULT_DISTANCE,grenade_distance
	bge.s	gren_not_min
	move.w	#DEFAULT_DISTANCE,grenade_distance	
gren_not_min
	rts		
escape_from_game
	move.w	#1,QuitFromGame
	clr.l	score
	move.w	#GAME_OVER,Schedule_Entry
	rts	
	ifnd	final_version	
skip_level_cheat
	move.w	#SKIP_LEVEL,Schedule_Entry
	rts	
inc_lives_cheat
	addq.w	#1,Player_Lives
	bsr	Display_Player_Lives
	endc
select_control_method_1
	move.l	#Control_Method_1,current_control_method
	bra.s	selected_method
select_control_method_2
	move.l	#Control_Method_2,current_control_method
	bra.s	selected_method
select_control_method_3
	move.l	#Control_Method_3,current_control_method
selected_method	
	move.w	#Sound_Collect,sound_chan3
	move.w	#WEAPON_TIME,weapon_wait
	rts	
		
reset_weapon	
	move.w	players_weapon,current_weapon
	move.w	gun_level,weapon_level
	bsr	Display_Weapon_On_Panel
	bsr	Display_Grenade_Packs
	bsr	Display_Weapon_Power_Level
	rts
store_weapon	
	move.w	current_weapon,players_weapon
	move.w	#ROCKET_LAUNCHER,current_weapon
	move.w	rocket_level,weapon_level
	bsr	Display_Weapon_On_Panel
	bsr	Display_Grenade_Packs
	bsr	Display_Weapon_Power_Level
	rts
	
Check_Secret_Code
	move.l	current_code_ptr,a0
	cmp.b	(a0),d0
	bne.s	reset_code
	addq.l	#1,a0
	cmp.b	#$ff,(a0)
	bne.s	not_all_code
	move.w	#1,Enable_Continues
reset_code	
	move.l	#secret_code,current_code_ptr
	rts
not_all_code
	move.l	a0,current_code_ptr	
	rts

secret_code
	dc.b	107,108,106,73,103,107,107,103,74,108,109,95,107,90,109,$ff		;trynottobreath
	even
	
current_code_ptr
	dc.l	secret_code
			
WEAPON_TIME	equ	5
	
weapon_wait
	dc.w	0	
	
players_weapon
	dc.w	STANDARD_GUN
	


****************************************
******  Pause_The_Game             *****
****************************************
Pause_The_Game

	bsr	Clear_Channels
	move.w	#Sound_Change,sound_chan1
	move.w	#Sound_Change,sound_chan3
	bsr	sound_effects
	bsr	Remove_Player
	bsr	Set_Up_Text_Sprite_Cols	
	
	
	bsr	clear_black_colours
	
	move.w	#1,fade_speed
	move.l	level_palette,a0
	move.l	#black_list,a1
	move.l	#copper_colours+2,a2
	move.w	#6-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List
	
	move.w	#16-1,d0
	move.l	#copper_colours+2,a0
	move.l	#black_list,a1
obtain_current_shades	
	move.w	(a0),(a1)+
	addq.l	#4,a0
	dbra	d0,obtain_current_shades
		
	move.w	#10,fire
Wait_For_Event
	
	bsr	Sync
	bsr	Flash_Pause
	btst	#7,$bfe001
	beq.s	Escape_Pause
	
	tst	fire
	beq.s	test_for_unpause
	subq.w	#1,fire
	bra.s	Wait_For_Event
test_for_unpause	
	clr.l	d0
	move.b	$bfec01,d0
	ror.b	d0
	btst	#7,d0
	beq.s	Wait_For_Event
*Has P for unpause been pressed
	andi.b	#$7f,d0
	cmp.b	#P_KEY,d0
	beq.s	Escape_Pause	
	bra.s	Wait_For_Event
Escape_Pause	
	move.b	$bfec01,d1	; wait for key release
	ror.b	#1,d1
	btst.l	#7,d1
	bne.s	Escape_Pause

	bsr	Remove_Sprite_Text
	bsr	Do_Sprite_Colours
	bsr	Sync	
	move.w	#16-1,d0
	move.l	#copper_colours+2,a0
	move.l	level_palette,a1
copy_cols_back
	move.w	(a1)+,(a0)
	addq.l	#4,a0
	dbra	d0,copy_cols_back	
	bsr	Display_Player
	clr.w	Fire
	rts
	
cash_request
	dc.w	0	;clear to update panel
	
CASH_FRAME_NUM	EQU	10
	
cash_frame_wait
	dc.w	0
	
		
		
*Panel variables
NUMBER_HITS_PER_UNIT	EQU	4

Player_Current_Energy
	dc.w	((2*4)*NUMBER_HITS_PER_UNIT)
Player_Energy_Limit
	dc.w	((2*4)*NUMBER_HITS_PER_UNIT)
Player_Lives
	dc.w	3	


GRENADE_PACK_NUMNER	EQU	5

weapon_power		dc.w	STANDARD_GUN
gun_power		dc.w	0
Score			dc.l	0
Cash			dc.w	0
inter_score		dc.w	0
gun_level		dc.w	0
rocket_level		dc.w	0
grenade_level		dc.w	0
weapon_level		dc.w	0	;general
rocket_packs		dc.w	0
rockets_in_pack		dc.w	0
grenade_packs		dc.w	0
grenades_in_pack 	dc.w	0
gun_type		dc.w	STANDARD_GUN	;gun type - use for init level - only use for guns
Number_Of_Keys		dc.w	0
End_Of_Level_Key	dc.w	0
Number_Of_Hostages	dc.w	0
current_energy_modules	dc.w	2
QuitFromGame		dc.w	0
