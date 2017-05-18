

*--------------------------HI SCORE ROUTINES-----------------------



**********************************************
***      HI SCORE SCREEN                   ***
**********************************************
Hi_Score_Screen

*To load this straight from game - i need to load in most of the
*title screen stuff so when finished entering name can go back
*to title

	bsr	Shift_Hi_Score_Table
	bsr	Load_Intro_Tune
	bsr	Load_Title_Picture
	bsr	Display_Hi_Res_Planes
	bsr	Set_Up_Title_Sprites
	bsr	keep_subbing
	bsr	Update_Sprites
	bsr	keep_subbing
	bsr	Update_Sprites
	bsr	mt_init
	move.w	#1,music_flag
	clr.l	movey_inc	;set up sprite velocitys
	clr.l	movey_inc+4
	move.w	#1*8,shipx_vel

	bsr	Update_Sprites
	move.w  #BIT_PLANE_DMA+SPRITE_DMA+$8000,dmacon(a6)	
	move.w	#$8204,title_screen_copper+2
	bsr	Start_Up_Copper_List	
	move.l	#Congrats_To_Player,a4		
	bsr	Display_Hi_Scores
	move.w	#$9204,title_screen_copper+2
		
	
Hi_Score_Entry_Loop
	jsr	Sync
	bsr	Display_Hi_Res_Planes
	bsr	Do_Sprites
	bsr	Get_Stick_Readings
	bsr	Get_Chars_For_Name
	bsr	Update_Sprites
	tst.w	name_entered
	beq.s	Hi_Score_Entry_Loop
	tst.w	letter_speed
	beq.s	time_wait_expired
	subq.w	#1,letter_speed
	bne.s	hi_score_entry_loop
time_wait_expired	
	tst.w	fire
	beq.s	hi_score_entry_loop	
	clr.w	shipx_vel
	move.w	#1,Title_Tune_Loaded
	move.w	#CREDITS,schedule_entry			
	rts


*********************************************************
*****        DISPLAY HI SCORES                    *******
*********************************************************
Display_Hi_Scores
*send title in a4 

	move.w	#80,text_bpr
	move.w	#$fff,hires_copper_colours+6
	move.w	#$fff,choice_1_colour
	move.w	#$fff,choice_2_colour
	move.w	#$fff,choice_3_colour

	move.l	#ball_cols2,a1
	move.l	#hi_res_sprite_cols,a0
	jsr	Insert_Sprite_Colours

	move.l	memory_base,a3
	move.l	a3,a1	
*clear one plane
	move.w	#((512*80)/16)-1,d0
hi_score_clear
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	dbra	d0,hi_score_clear	


	move.w	(a4)+,d0
	move.w	(a4)+,d1	
	bsr	Display_String
	
	move.w	#120,d1
	move.l	#hi_score_table,a0

	move.w	#10-1,d2
hi_score_draw_loop
	move.w	#190,d0
	
	move.l	(a0)+,a4
	movem.l	d1/d2/a0,-(sp)
	bsr	Display_String
	movem.l	(sp)+,d1/d2/a0
	
	add.w	#MALFONT_HEIGHT,d1
	dbra	d2,hi_score_draw_loop	
	rts

*********************************************************
*****        DISPLAY HI SCORE PLANES              *******
*********************************************************
Display_Hi_Score_Planes	

	move.l	memory_base,d0
	move.w	vposr(a6),d1
	bpl.s	hiskip_add_to_planes
	add.l	#80,d0
hiskip_add_to_planes
	move.w	d0,HPlane1_Lo
	swap	d0
	move.w	d0,HPlane1_Hi

	rts

*********************************************************
*****           SHIFT HI SCORE TABLE              *******
*********************************************************
Shift_Hi_Score_Table

	move.l	score,d0	;players score
	
	move.l	#hi_score_list,a0
	move.l	#position1,a1
	clr.w	d1
find_higher_score
	cmp.l	(a0),d0
	bgt.s	have_found_position
	addq.l	#4,a0
	add.l	#32,a1
	addq.w	#1,d1
	cmp.w	#10,d1
	bne.s	find_higher_score
	rts	;this should not occur
have_found_position	
	move.w	d1,hi_score_pos		;table pos to enter name		
* d1 = start shift position
	move.l	a0,a4			;save for later
	move.l	a1,name_entry_pos
	
	move.l	#position10,a1
	move.l	#last_score,a0
		
	neg.w	d1
	add.w	#9,d1
shift_entries_down
	tst	d1
	beq.s	done_shifting	
	move.l	-4(a0),(a0)		;move score	
	subq.l	#4,a0
	move.l	a1,a2
	sub.l	#32,a2
	move.w	#32-1,d6
copy_name
	move.b	(a2)+,(a1)+
	dbra	d6,copy_name
	subq.w	#1,d1
	sub.l	#64,a1
	bra.s	shift_entries_down	
done_shifting	
	move.l	score,(a4)		;save new score
	
	move.l	name_entry_pos,a1
	add.l	#21,a1
	move.w	#10-1,d0
clear_out_name
	move.b	#' ',(a1)+
	dbra	d0,clear_out_name	
	
	move.l	name_entry_pos,a5			;convert score to string needs string in a5
	move.w	#1,d7
	bsr	Convert_Score_To_String
	
	clr.w	name_char_pos
	clr.w	name_entered
	move.b	#'A',current_char
	clr.w	fpress
	rts

name_entry_pos
	dc.l	0		;pointer to structure to add name to
	
*********************************************************
*****       GET CHARS FOR NAME                    *******
*********************************************************
Get_Chars_For_Name

	clr.b	skip_draw
*code to read joy and display char
	tst.w	name_entered
	beq.s	not_got_all_chars
	rts
not_got_all_chars
	move.l	name_entry_pos,a4
	clr.l	d0
	move.w	name_char_pos,d0
	add.w	#21,a4

	bsr	Read_Keyboard
	tst.w	d7
	beq.s	User_Not_Touched_Key
	cmp.w	#KEY_DELETE,d7
	bne.s	check_for_return
	move.b	#'@',current_char
	bra.s	key_has_been_pressed
check_for_return
	cmp.b	#KEY_RETURN,d7
	bne.s	send_normal_char
	move.b	#'?',current_char
	bra.s	key_has_been_pressed
send_normal_char
	move.b	d7,current_char
	bra.s	key_has_been_pressed	
User_Not_Touched_Key
	subq.w	#1,letter_speed
	ble.s	test_joypad
	bra	no_char_move	
test_joypad	
	clr.w	letter_speed
	tst.w	fire
	beq	not_all_chars_selected
	tst	fpress
	bne	skip_fire_tests
	move.w	#1,fpress
key_has_been_pressed	
	clr.w	flicker_flag
	cmp.b	#'@',current_char
	bne.s	check_for_end
	tst	name_char_pos
	beq	no_char_move
	addq.b	#1,skip_draw
	move.b	#' ',(a4,d0)
	subq.w	#1,name_char_pos	
	bra	no_char_move
check_for_end
	cmp.b	#'?',current_char
	bne.s	not_name_fin
	addq.b	#1,skip_draw
	move.b	#' ',(a4,d0)
	bra.s	name_fin
not_name_fin	
	addq.w	#1,name_char_pos
	move.w	#6,letter_speed
	move.w	#9,change_speed
	cmp.w	#9,name_char_pos
	bne.s	skip_fire_tests
name_fin	
	move.w	#1,name_entered
	move.w	#25,letter_speed
	clr.w	fire
	bra	no_char_move
not_all_chars_selected
	clr.w	fpress
skip_fire_tests	
	tst.w	xdirec
	beq.s	no_char_move
	bmi.s	going_char_up
	cmp.b	#122,current_char
	beq.s	no_char_move
	addq.b	#1,current_char
	clr.w	flicker_flag
	move.w	#9,change_speed
	move.w	#6,letter_speed	
	bra.s	no_char_move
going_char_up
	cmp.b	#' ',current_char
	beq.s	no_char_move
	subq.b	#1,current_char
	clr.w	flicker_flag
	move.w	#9,change_speed
	move.w	#6,letter_speed
no_char_move

	tst.b	skip_draw
	bne.s	dont_dot_flag 
	
	addq.w	#1,change_speed
	cmp.w	#10,change_speed
	bne.s	dont_dot_flag
						
	clr.w	change_speed				
	tst.w	flicker_flag
	bne.s	display_dot
	move.b	current_char,(a4,d0)
	bra.s	display_entry_string
display_dot
	move.b	#'*',(a4,d0)
display_entry_string
	bchg	#0,flicker_flag
dont_dot_flag		

*first remove old string
	move.w	hi_score_pos,d1
	mulu	#malfont_height,d1
	add.w	#120,d1		;y start of table
	move.w	d1,d2

remove_old_name	
	btst	#14,dmaconr(a6)
	bne.s	Remove_old_name
	clr.w	bltadat(a6)
	move.l	memory_base,a0
	mulu	#80,d2
	add.l	#23*2,d2	;x
	add.l	d2,a0
	
	move.l	a0,bltdpth(a6)
	move.w	#80-6*2,bltdmod(a6)
	move.l	#$01f00000,bltcon0(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	#MALFONT_HEIGHT<<6+6,bltsize(a6)
	
	move.w	#380-1,d0
	move.l	memory_base,a3
	bsr	Display_String
	rts

letter_speed		dc.w	0
name_entered		dc.w	0
change_speed		dc.w	0
flicker_flag		dc.w	0
name_char_pos		dc.w	0
current_char		dc.b	0
skip_draw		dc.b	0
	even
	
hi_score_pos	dc.w	0
fpress		dc.w	0

hi_score_table
	dc.l	position1
	dc.l	position2
	dc.l	position3
	dc.l	position4
	dc.l	position5
	dc.l	position6
	dc.l	position7
	dc.l	position8
	dc.l	position9
	dc.l	position10

position1
	dc.b	"   10000"
	dc.b	"     ---     "
	dc.b	"GLEN      ",0
	
position2
	dc.b	"    9000"
	dc.b	"     ---     "
	dc.b	"MYLES     ",0
	
position3
	dc.b	"    8000"
	dc.b	"     ---     "	
	dc.b	"NEIL      ",0
	
position4
	dc.b	"    7000"
	dc.b	"     ---     "
	dc.b	"R. BROOKS ",0
	
position5
	dc.b	"    6000"
	dc.b	"     ---     "	
	dc.b	"RICHARD   ",0
	
position6
	dc.b	"    5000"
	dc.b	"     ---     "
	dc.b	"TANSIE    ",0
	
position7
	dc.b	"    4000"
	dc.b	"     ---     "	
	dc.b	"ALEX      ",0

position8
	dc.b	"    3000"
	dc.b	"     ---     "
	dc.b	"ANDREW    ",0
	
position9
	dc.b	"    2000"
	dc.b	"     ---     "
	dc.b	"TYSON     ",0
	
position10
	dc.b	"    1000"
	dc.b	"     ---     "
	dc.b	"OLLY      ",0
	even
	
hi_score_titles
	dc.w	230
	dc.w	40
	dc.b	"TODAYS HIGHEST SCORES",0
	EVEN

Congrats_To_Player
	dc.w	120
	dc.w	40
	dc.b	"CONGRATULATIONS PLAYER YOU HAVE A HI SCORE",0
	even		

hi_score_list
	dc.l	10000
	dc.l	9000
	dc.l	8000
	dc.l	7000
	dc.l	6000
	dc.l	5000
	dc.l	4000
	dc.l	3000
	dc.l	2000
last_score	
	dc.l	1000