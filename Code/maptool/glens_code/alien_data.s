

*--------------------------Data Functions---------------------*

Display_Alien_Name

	tst.w	edit_data_flag
	beq.s	dont_display_name


	move.w	mouse_y,d0
	cmp.w	max_map_screen_pos,d0
	bge	dont_display_name
	
	move.l	current_map_ptr,a2
	move.l	map_alien_mem(a2),a0
	
	moveq	#0,d1
	move.w	last_posx,d1
	move.w	last_posy,d2
	add.l	d1,a0
	move.w	map_xsize(a2),d6
	mulu	d6,d2	
	add.l	d2,a0	;map position

	move.b	(a0),d0
	ext.w	d0
	cmp.w	last_alien_displayed,d0
	beq.s	dont_display_name

	move.w	d0,-(sp)	
	clr.w	d3		;delete
	bsr	Draw_Alien_Name
	move.w	(sp)+,d0
	
	move.w	d0,last_alien_displayed
	move.w	#1,d3
	bsr	Draw_Alien_Name	
dont_display_name	
	rts

Draw_Alien_Name
*send d3 for delete or draw
	move.w	last_alien_displayed,d0
	beq.s	dont_draw_name
	mulu	#17,d0
	move.l	#alien_names,a1
	add.l	d0,a1
	move.l	#button_window_struct,a0
	move.w	#180,d0
	move.w	#THIRD_ROW-FONT_HEIGHT,d1
	move.w	#4,d2
	jsr	write_button_text
	clr.w	d3
	bsr	Display_Alien_Menu
	move.w	#1,d3
	move.w	last_alien_displayed,d0
	move.w	d0,Alien_Menu_Number
	bsr	Display_Alien_Menu
dont_draw_name
	rts


last_alien_displayed
	dc.w	0



bring_up_data_function	
	tst.w	fullscreen_mode
	bne.s	ad_not_in_fs_mode
	move.w	#BUTTON_WINDOW_OFFSET,max_map_screen_pos
	move.w	#BUTTON_WINDOW_OFFSET,map_screen_custom_y
ad_not_in_fs_mode	
	clr.w	last_alien_displayed
	move.w	#1,edit_data_flag
	move.l #top_level_list,a0
	bsr	remove_button_list
	move.l  #data_main_list,a0
	bsr	display_button_list
	bsr	display_map_on_screen
	bsr	display_edit_text
	bsr	display_edit_nums
	move.w	#1,d3
	bsr	display_alien_string
	bsr	display_alien_menu	
	bsr	display_alien_numbers

	rts


exit_data_function
	
	move.w	#0,edit_data_flag
	move.l  #data_main_list,a0
	bsr	remove_button_list
	bsr	remove_edit_text
	bsr	remove_edit_nums
	clr.w	d3
	bsr	display_alien_string
	bsr	display_alien_menu
	clr.w	edit_mode

	move.l  #top_level_list,a0
	bsr	display_button_list
	bsr	clear_screen

	clr.w	d3
	bsr	Draw_Alien_Name
	
	tst.w	fullscreen_mode
	bne.s	exit_ad_not_in_fs_mode
	move.w	#BUTTON_WINDOW_OFFSET-32,max_map_screen_pos
	move.w	#BUTTON_WINDOW_OFFSET-32,map_screen_custom_y
exit_ad_not_in_fs_mode
	
	rts

edit_data_flag	
	dc.w	0


scroll_dat_left
	bsr	scroll_map_left
	bsr	display_alien_numbers
	rts

scroll_dat_right
	bsr	scroll_map_right
	bsr	display_alien_numbers
	rts

scroll_dat_up
	bsr	scroll_map_up
	bsr	display_alien_numbers
	rts

scroll_dat_down
	bsr	scroll_map_down
	bsr	display_alien_numbers
	rts
	

	

*******************************************
****** DISPLAY ALIEN STRING          ******
*******************************************
Display_Alien_String
*delete or draw in d3
	move.w	current_alien_number,d0
	mulu	#17,d0
	move.l	#alien_names,a1
	add.l	d0,a1
	move.l	#button_window_struct,a0
	move.w	#180,d0
	move.w	#THIRD_ROW+FONT_HEIGHT,d1
	move.w	#4,d2
	jsr	write_button_text
	rts

*******************************************
****** DISPLAY ALIEN MENU            ******
*******************************************
Display_Alien_Menu
*send delete or draw in d3

	move.w	Alien_Menu_Number,d0
	mulu	#17,d0
	move.l	#alien_names,a1
	add.l	d0,a1
	move.l	#button_window_struct,a0
	move.w	#385,d0
	move.w	#FIRST_ROW+2,d1
	move.w	#4,d2
	move.w	#6-1,d7
draw_up_alien_menu	
	jsr	write_button_text
	add.l	#17,a1
	add.w	#FONT_HEIGHT,d1
	dbra	d7,draw_up_alien_menu
	rts

Alien_Menu_Number	dc.w	0

*******************************************
****** SELECT ALIEN                  ******
*******************************************
Select_Alien

	moveq	#0,d3
	bsr	Display_Alien_String
	move.l	clicked_button,a0
	move.w	Alien_Menu_Number,d0
	add.b	button_data(a0),d0
	move.w	d0,current_alien_number
	move.w	#1,d3
	bsr	Display_Alien_String
	rts

*******************************************
****** ADD ALIEN DATA                ******
*******************************************
add_alien_data


	move.w	current_alien_number,d7
	bsr	put_in_alien_map
	
	bsr	Convert_mouse_and_store
	move.w	current_alien_number,d2
	bsr	Draw_Number

	
	rts
	
*******************************************
****** REMOVE ALIEN DATA             ******
*******************************************
remove_alien_data

	bsr	Convert_mouse_and_store

	moveq.w	#0,d7
	bsr	put_in_alien_map


	bsr	display_map_on_screen
	bsr	Display_Alien_Numbers

	rts	
		
	
*******************************************
****** PUT IN ALIEN MAP              ******
*******************************************
put_in_alien_map	

	move.l	current_map_ptr,a2
	move.l	map_alien_mem(a2),a0
	
	moveq	#0,d1
	move.w	map_x_position,d1
	add.l	d1,a0
	move.w	map_y_position,d1
	move.w	map_xsize(a2),d6
	mulu	d6,d1	
	add.l	d1,a0	;map position
	
	bsr	convert_mouse_and_store
		
	divu	map_block_size(a2),d0
	swap	d0
	clr.w	d0
	swap	d0

	move.w	d0,d2
	add.w	map_x_position,d2
	addq.w	#1,d2
	add.l	d0,a0
	
	divu	map_block_size(a2),d1
	move.w	d1,d0
	add.w	map_y_position,d0
	addq.w	#1,d0
	mulu	d6,d1
	add.l	d1,a0		;got it !!!!
	move.b	d7,(a0)
	
	rts
	


*******************************************
****** ALIEN UP                      ******
*******************************************
alien_up

	cmp.w	#127-6,Alien_Menu_Number
	beq.s	no_higher
	move.w	#0,d3
	bsr	display_alien_menu
	addq.w	#1,Alien_Menu_Number
	move.w	#1,d3
	bsr	display_alien_menu

no_higher
	rts
	
*******************************************
****** ALIEN DOWN                    ******
*******************************************
alien_down

	tst	Alien_Menu_Number
	beq.s	no_lower
	move.w	#0,d3
	bsr	display_alien_menu
	subq.w	#1,Alien_Menu_Number
	move.w	#1,d3
	bsr	display_alien_menu
no_lower
	rts	
		
*******************************************
****** DISPLAY ALIEN NUMBERS         ******
*******************************************
Display_Alien_Numbers

*bodgy routine that just updates whole map with alien numbers

	move.l	current_map_ptr,a0
	
	
	moveq	#0,d3
	moveq	#0,d1
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d3
	divu	map_block_size(a0),d3	;number of blocks in x
	
	move.w	max_map_screen_pos,d1
	divu	map_block_size(a0),d1	;number of blocks in y
	
	move.l	map_alien_mem(a0),a2
	
	move.w	map_y_position,d4
	mulu	map_xsize(a0),d4
	add.l	d4,a2
	
	move.w	map_x_position,d4
	ext.l	d4
	add.l	d4,a2
	
	move.w	map_block_size(a0),d5
	moveq	#0,d7		;y pos
	
add_alien_num_y

	move.l	a2,a3
	moveq	#0,d6		;x pos
	move.w	d3,d0
add_alien_num_x
	moveq	#0,d2
	move.b	(a3)+,d2
	beq.s	skip_draw
	movem.l	d0-d7/a0-a3,-(sp)
	move.w	d6,d0
	move.w	d7,d1
	bsr	Draw_Number
	movem.l	(sp)+,d0-d7/a0-a3
skip_draw	
	add.w	d5,d6
	
	subq.w	#1,d0
	bne.s	add_alien_num_x
	
	
	add.w	d5,d7
	
*add whole line	
	moveq	#0,d2
	move.w	map_xsize(a0),d2
	add.l	d2,a2
	
	subq.w	#1,d1
	bne	add_alien_num_y
		
	rts
	
*******************************************
****** CLEAR ALIEN DATA              ******
*******************************************
Clear_Alien_Data

	bsr	display_map_on_screen

	move.l	current_map_ptr,a0
	
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	subq.w	#1,d0
	
	move.l	map_alien_mem(a0),a0
clear_al_l	
	clr.b	(a0)+
	dbra	d0,clear_al_l
	
	
	
	rts
	
	
*******************************************
****** DRAW NUMBER                   ******
*******************************************
Draw_Number
*send x and y in d0 and d1
*send number in d2


	move.l	#100,d6		;divider
	ext.l	d2

	
	move.l	#main_screen_struct,a0

	move.w screen_x_size(a0),d7
	asr.w	#3,d7		;bytes per row

	
output_num_loop	
	divu	d6,d2
	
	move.w	d2,d3
	clr.w	d2
	swap	d2		;next number to output

	mulu	#(5*2),d3
	add.l	#small_numbers,d3	;graphics

	move.l	screen_mem(a0),a1

	move.w	d1,d5
	mulu	d7,d5
	
	add.l	d5,a1
	
	
	move.w	d0,d5
	move.w	d5,d4
	andi.w	#$fff0,d4
	andi.w	#$000f,d5
	asr.w	#3,d4
	
	ext.l	d4
	add.l	d4,a1		;screen mem pos
	
	ror	#4,d5
	move.w	d5,d4
	or.w	#$fca,d5
	swap	d5
	move.w	d4,d5
	
	move.w	d7,d4
	subq.w	#4,d4		;mod
	
wait_for_num1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_num1

	move.l	d5,bltcon0(a6)			;shifts etc
	move.l	a1,bltcpt(a6)			;scr pos
	move.l	a1,bltdpt(a6)			;dest
	move.l	d3,bltbpt(a6)
	move.l	d3,bltapt(a6)
	move.w	d4,bltcmod(a6)
	move.w	d4,bltdmod(a6)
	move.l	#$ffff0000,bltafwm(a6)
	move.w	#-2,bltbmod(a6)
	move.w	#-2,bltamod(a6)
	move.w	#5<<6+2,bltsize(a6)

	move.w	screen_y_size(a0),d4
	mulu	d7,d4
	
	add.l	d4,a1
		

wait_for_num2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_num2

	move.l	a1,bltcpt(a6)			;scr pos
	move.l	a1,bltdpt(a6)			;dest
	move.l	d3,bltbpt(a6)
	move.l	d3,bltapt(a6)
	move.w	#5<<6+2,bltsize(a6)

	add.l	d4,a1

wait_for_num3
	btst	#14,dmaconr(a6)
	bne.s	wait_for_num3

	move.l	a1,bltcpt(a6)			;scr pos
	move.l	a1,bltdpt(a6)			;dest
	move.l	d3,bltbpt(a6)
	move.l	d3,bltapt(a6)
	move.w	#5<<6+2,bltsize(a6)

	add.l	d4,a1
	
wait_for_num4
	btst	#14,dmaconr(a6)
	bne.s	wait_for_num4

	move.l	a1,bltcpt(a6)			;scr pos
	move.l	a1,bltdpt(a6)			;dest
	move.l	d3,bltbpt(a6)
	move.l	d3,bltapt(a6)
	move.w	#5<<6+2,bltsize(a6)

wait_for_num_fin
	btst	#14,dmaconr(a6)
	bne.s	wait_for_num_fin


	add.w	#5,d0
	
	cmp.w	#1,d6
	beq.s	done_all_num
	divu	#10,d6
	bra	output_num_loop			

done_all_num
	rts

current_alien_number	dc.w	1

*-------------------------Data function buttons

data_main_list
	dc.l	data_alien_list,data_quit
	dc.l    data_scrollup_map_button,data_scrolldown_map_button
	dc.l    data_scrollleft_map_button,data_scrollright_map_button
	dc.l	data_hit_on_map
	dc.l	down_alien_number,up_alien_number
	dc.l	AlienMenu1,AlienMenu2,AlienMenu3,AlienMenu4,AlienMenu5,AlienMenu6
	dc.l	$ffffffff

data_hit_on_map
	dc.w	0
	dc.w	0
	dc.w	MAIN_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+NO_WAIT_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    map_screen_custom_button
	dc.l	0	;not used
	dc.l	Add_Alien_Data
	dc.b	0
	EVEN


data_alien_list
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	change_colour
	dc.b	"ALIEN LIST",0
	EVEN

data_quit
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	exit_data_function
	dc.b	"EXIT",0
	EVEN


up_alien_number
	dc.w	BUTTON_4+18
	dc.w	SECOND_ROW+4-10
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_up
	dc.l	0	;not used
	dc.l	alien_down
	dc.b	0
	EVEN
	
down_alien_number
	dc.w	BUTTON_4+18
	dc.w	SECOND_ROW+20+10
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_down
	dc.l	0	;not used
	dc.l	alien_up
	dc.b	0
	EVEN



data_scrollup_map_button
	dc.w	BUTTON_5+140
	dc.w	SECOND_ROW+5
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_up
	dc.l	0	;not used
	dc.l	scroll_dat_up
	dc.b	0
	EVEN

data_scrolldown_map_button
	dc.w	BUTTON_5+140
	dc.w	SECOND_ROW+35
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_down
	dc.l	0	;not used
	dc.l	scroll_dat_down
	dc.b	0
	EVEN


data_scrollleft_map_button
	dc.w	BUTTON_5+110
	dc.w	SECOND_ROW+20
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_left
	dc.l	0	;not used
	dc.l	scroll_dat_right
	dc.b	0
	EVEN
	
data_scrollright_map_button
	dc.w	BUTTON_5+167
	dc.w	SECOND_ROW+20
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l    arrow_right
	dc.l	0	;not used
	dc.l	scroll_dat_left
	dc.b	0
	EVEN

alien_names
	dc.b	"000 ------------",0
	dc.b	"001 ------------",0
	dc.b	"002 Smoke Object",0
	dc.b    "003 ------------",0
	dc.b    "004 ------------",0
	dc.b    "005 ------------",0
	dc.b    "006 ------------",0
	dc.b    "007 ------------",0
	dc.b    "008 ------------",0
	dc.b    "009 ------------",0
	dc.b    "010 ------------",0	;10
	dc.b    "011 ------------",0
	dc.b    "012 ------------",0
	dc.b	"013 Hostage     ",0
	dc.b	"014 Normal Pig  ",0
	dc.b	"015 ------------",0
	dc.b	"016 Grenade Pack",0
	dc.b	"017 Missile Pack",0
	dc.b	"018 ------------",0
	dc.b	"019 Extra Life P",0	;19
	dc.b	"020 Extra Energy",0
	dc.b	"021 ------------",0
	dc.b	"022 ------------",0
	dc.b	"023 Red Flower  ",0
	dc.b	"024 Blue Flower ",0
	dc.b	"025 Standard Key",0
	dc.b	"026 PigMissile  ",0
	dc.b	"027 Pig Skull   ",0
	dc.b	"028 Spikey Mine ",0
	dc.b	"029 ------------",0
	dc.b	"030 Gold Coin   ",0
	dc.b	"031 Gold Chest  ",0
	dc.b	"032 GC 4        ",0
	dc.b	"033 GC 3        ",0
	dc.b	"034 GC 2        ",0
	dc.b	"035 GC 1        ",0	;35
	dc.b	"036 GC 0        ",0
	dc.b	"037 Silver Coin ",0
	dc.b	"038 Silver Chest",0
	dc.b	"039 SC 4        ",0
	dc.b	"040 SC 3        ",0
	dc.b	"041 SC 2        ",0
	dc.b	"042 SC 1        ",0
	dc.b	"043 SC 0        ",0
	dc.b	"044 Fish Bob Lef",0
	dc.b	"045 Fish Bob Rig",0
	dc.b	"046 ------------",0
	dc.b	"047 ------------",0
	dc.b	"048 Statue Head ",0
	dc.b	"049 Wasp Nest   ",0
	dc.b	"050 ------------",0
	dc.b	"051 Fish Up Bob ",0
	dc.b	"052 ------------",0
	dc.b	"053 ------------",0	;53
	dc.b	"054 ------------",0
	dc.b	"055 Pig Generato",0
	dc.b	"056 Pig gen 2   ",0
	dc.b	"057 Pig gen 3   ",0
	dc.b	"058 Pig gen 4   ",0
	dc.b	"059 Pig gen 5   ",0
	dc.b	"060 Pig gen no s",0
	dc.b	"061 Maggot      ",0
	dc.b	"062 Maggot spd 2",0
	dc.b	"063 Maggot spd 3",0
	dc.b	"064 Maggot Gener",0
	dc.b	"065 Added maggot",0
	dc.b	"066 The Generato",0
	dc.b	"067 Key Chest   ",0
	dc.b	"068 Fire Key    ",0
	dc.b	"069 Gold Money 1",0
	dc.b	"070 Silver Money",0
	dc.b	"071 Gold Money 2",0
	dc.b	"072 Silver Money",0
	dc.b	"073 Swamp Anim  ",0
	dc.b	"074 Pig guard   ",0
	dc.b	"075 Small potion",0
	dc.b	"076 Butterfly   ",0
	dc.b	"077 Torch Flame ",0
	dc.b	"078 No Shoot Pig",0
	dc.b	"079 Counter Magg",0
	dc.b	"080 Speed Pig   ",0
	dc.b    "081 Spore Right ",0
	dc.b	"082 Spore Left  ",0
	dc.b	"083 Spore Up    ",0
	dc.b	"084 Spore Down  ",0
	dc.b	"085 Spore Frag  ",0
	dc.b	"086 Bush Gener  ",0
	dc.b	"087 ------------",0
	dc.b	"088 ExploPig Gen",0
	dc.b	"089 Explo Pig   ",0
	dc.b	"090 Counter Gen ",0
	dc.b	"091 Fly         ",0
	dc.b	"092 Fly 2       ",0
	dc.b	"093 Spider      ",0 
	dc.b	"094 Spider Bulle",0
	dc.b	"095 Fly 3       ",0
	dc.b	"096 Fly 4       ",0
	dc.b	"097 Red Flip Flo",0
	dc.b	"098 Chain Gen   ",0
max_alien_names equ (*-alien_names)/17	
	ds.b	17*(127-max_alien_names)
	dc.b	"127 END OF LIST  ",0
	even
	
AlienMenu1
	dc.w	385
	dc.w	FIRST_ROW+2
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN			

AlienMenu2
	dc.w	385
	dc.w	FIRST_ROW+2+FONT_HEIGHT
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN						
	
AlienMenu3
	dc.w	385
	dc.w	FIRST_ROW+2+FONT_HEIGHT*2
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN					

AlienMenu4
	dc.w	385
	dc.w	FIRST_ROW+2+FONT_HEIGHT*3
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN					

AlienMenu5
	dc.w	385
	dc.w	FIRST_ROW+2+FONT_HEIGHT*4
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN					

AlienMenu6
	dc.w	385
	dc.w	FIRST_ROW+2+FONT_HEIGHT*5
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Alien
	dc.b	0		
	EVEN					