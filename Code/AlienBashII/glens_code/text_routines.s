GET_READY_WORDS		EQU	10
GET_READY_HEIGHT	EQU	61
GET_READY_PLANE		EQU	GET_READY_HEIGHT*GET_READY_WORDS*2

GET_READY_Y_POS		EQU	70
GET_READY_BYTE_POS	EQU	((20-GET_READY_WORDS)/2)*2


*****************************************
***	TEXT TEST		    *****
*****************************************
Text_Test

	bsr	Copy_In_Level_Name
	move.w	#$ff,scroll_value
	bsr	Work_Out_Scroll_Movement	;dont ask - makes player appear in right place
	bsr	Black_Colours
	bsr	Draw_Initial_Aliens_On_Screen
	bsr	Show_BackGround
	bsr	Display_Scanner
	move.w	#Sound_GetReady,sound_chan1
	bsr	Sound_Effects
	bsr	Wait_For_Fire_Press
	bsr	Remove_Get_Ready
	bsr	Do_Sprite_Colours
	bsr	Do_Level_Colours
	rts

*****************************************
***  COPY IN LEVEL NAME             *****
*****************************************
Copy_In_Level_Name

	clr.l	d0
	move.b	level_number,d0
	sub.w	#'A',d0

	move.l	#Get_Ready_Names,a0
	move.l	a0,a1
	add.l	#16*9*4*8,a1	
	add.l	d0,a1	;get number
	
	mulu	#18*8,d0	;get name
	add.l	d0,a0
	
	move.l	#Get_Ready_Graphics,a2
	add.l	#((GET_READY_WORDS*2)*37)+12,a2
	
	move.w	#4-1,d1
insert_level_number
	move.l	a1,a3	
	move.l	a2,a4
	move.w	#8-1,d2
insert_number_lines
	move.b	(a3),(a4)
	add.l	#8,a3		;next line
	add.l	#GET_READY_WORDS*2,a4
	dbra	d2,insert_number_lines
	add.l	#8*8,a1		;next plane
	add.l	#GET_READY_PLANE,a2
	dbra	d1,insert_level_number

	move.l	#Get_Ready_Graphics,a2
	add.l	#((GET_READY_WORDS*2)*53)+2,a2

	move.w	#4-1,d1
insert_level_name
	move.l	a0,a3	
	move.l	a2,a4
	
	move.w	#8-1,d2
insert_name_lines

	movem.l	a3-a4,-(sp)
	move.w	#9-1,d3
insert_name_words		
	move.w	(a3)+,(a4)+
	dbra	d3,insert_name_words
	movem.l	(sp)+,a3-a4
	
	add.l	#18,a3		;next line
	add.l	#GET_READY_WORDS*2,a4
	
	dbra	d2,insert_name_lines
	add.l	#16*9*8,a0		;next plane
	add.l	#GET_READY_PLANE,a2
	dbra	d1,insert_level_name
	
	
	rts

*****************************************
***  DRAW INITIAL ALIENS ON SCREEN  *****
*****************************************
Draw_Initial_Aliens_On_Screen

	jsr	Run_Alien_Code	;get aliens to draw on screen
	jsr	Run_Alien_Code
	bsr	Display_Get_Ready
	jsr	Run_Alien_Code
	jsr	Run_Alien_Code
	rts



*****************************************
***	WHITE COLOURS               *****
*****************************************
White_Colours

	move.w	#16-1,d0
	move.l	#copper_colours+2,a0
blank_them_all
	move.w	#$fff,(a0)
	addq.l	#4,a0
	dbra	d0,blank_them_all
	rts	

*****************************************
***	CLEAR BLACK COLOURS         *****
*****************************************
Clear_Black_Colours
	move.w	#32-1,d0
	move.l	#black_list,a0
clear_bls
	clr.w	(a0)+
	dbra	d0,clear_bls
	rts	

*****************************************
***	SET  COLOURS                *****
*****************************************
Set_Colours
*list in a0
*col in d0
	move.w	#16-1,d1
set_bls
	move.w	d0,(a0)+
	dbra	d1,set_bls
	rts	

*****************************************
***	SET  COPPER COLOURS         *****
*****************************************
Set_Copper_Colours
*copper list in a0
*col in d0
	move.w	#16-1,d1
	addq.l	#2,a0
set_cbls
	move.w	d0,(a0)
	addq.l	#4,a0
	dbra	d1,set_cbls
	rts	


*****************************************
***	CLEAR GAME COLOURS          *****
*****************************************
Clear_Game_Colours
	move.w	#32-1,d0
	move.l	#game_list,a0
clear_gcs
	clr.w	(a0)+
	dbra	d0,clear_gcs
	rts	

	
*****************************************
***	BLACK COLOURS               *****
*****************************************
Black_Colours

	move.w	#16-1,d0
	move.l	#copper_colours+2,a0
black_them_all
	clr.w	(a0)
	addq.l	#4,a0
	dbra	d0,black_them_all
	rts	
	

*****************************************
***	FADE TEXT TO BACKGROUND     *****
*****************************************
Fade_Text_To_Background

	move.l	#white_list,a0
	move.l	level_palette,a1
	move.l	#sprite_cols+2,a2
	move.w	#8-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List
	rts

*****************************************
***  FADE REST OF TEXT TO BACKGROUND*****
*****************************************
Fade_Rest_Of_Text_To_Background

	jsr	Sync
	move.l	#sprite_cols+2,a2
	move.w	#8-1,d7
	move.l	#store_text_nums,a3
	bsr	Reduce_All_Colours
	rts


*****************************************
***	SHOW    BACK GROUND         *****
*****************************************
Show_BackGround
	
	move.l	level_palette,a1
	move.l	#copper_colours+2,a2
	move.w	#16-1,d7
stick_in_cols
	move.w	(a1)+,(a2)
	addq.l	#4,a2	
	dbra	d7,stick_in_cols
	rts

*****************************************
***	FADE LIST TO LIST           *****
*****************************************
Fade_List_To_List
*send current colour list in a0, dest colour in a1
*send copper list ptr in a2
*send store list in a3

	move.l	a3,a5
	move.w	#16-1,d0
init_list_loop
*init list
	move.w	(a0)+,d1
	move.w	(a1)+,d4
	
	move.w	d1,d2
	move.w	d2,d3
	andi.w	#$f00,d1	;get rgb of source
	lsr	#8,d1
	andi.w	#$f0,d2
	lsr	#4,d2
	andi.w	#$f,d3
	
	asl	#6,d1
	asl	#6,d2
	asl	#6,d3
	
	move.w	d1,(a5)+	;store scaled values
	move.w	d2,(a5)+
	move.w	d3,(a5)+
	
	asr	#6,d1
	asr	#6,d2
	asr	#6,d3

	
	move.w	d4,d5		;get rgb of dest
	move.w	d5,d6
	andi.w	#$f00,d4
	lsr	#8,d4
	andi.w	#$f0,d5
	lsr	#4,d5
	andi.w	#$f,d6
	
	sub.w	d4,d1		;get diff
	sub.w	d5,d2
	sub.w	d6,d3
	
	asl	#6-4,d1		;(vals *64)/16
	asl	#6-4,d2
	asl	#6-4,d3
	
	move.w	d1,(a5)+	;store reduce values
	move.w	d2,(a5)+
	move.w	d3,(a5)+
	
	dbra	d0,init_list_loop
		
reduce_all_colours	
	move.w	fade_speed,d0
	subq.w	#1,d0
wait_fade_speed
	jsr	Sync
	dbra	d0,wait_fade_speed
		
	move.l	a2,a5		;copper
	move.l	a3,a4
	move.w	#16-1,d1
reduce_loop

	move.w	6(a4),d2
	move.w	8(a4),d3
	move.w	10(a4),d4
	
	sub.w	d2,(a4)
	sub.w	d3,2(a4)
	sub.w	d4,4(a4)
	
	move.w	(a4),d2
	move.w	2(a4),d3
	move.w	4(a4),d4
	
	asr	#6,d2
	asr	#6,d3
	asr	#6,d4
	
	lsl	#8,d2
	lsl	#4,d3
	or.w	d2,d4
	or.w	d3,d4
	
	move.w	d4,(a5)
	
	addq.l	#4,a5
	add.l	#12,a4
	
	dbra	d1,reduce_loop
	
	dbra	d7,reduce_all_colours

	rts


*****************************************
***	CREATE FADE PALETTES        *****
*****************************************
Create_Fade_Palettes
	move.l	#Level_1_Colour_List,a0
	move.l	#Faded_Palettes,a1

	move.w	#16-1,d0
cr_fade_loop
	move.w	(a0)+,d1
	
	move.w	d1,d2
	move.w	d2,d3
	andi.w	#$f00,d1	;get rgb of source
	lsr	#8,d1
	andi.w	#$f0,d2
	lsr	#4,d2
	andi.w	#$f,d3
	
	move.w	d1,d4		;store
	move.w	d2,d5
	move.w	d3,d6
	
	asl	#6,d1
	asl	#6,d2
	asl	#6,d3
		
	asl	#6-4,d4		;(vals *64)/16
	asl	#6-4,d5
	asl	#6-4,d6
	
	move.l	a1,a2
	move.w	#4-1,d7
store_fade_cols
	
	sub.w	d4,d1
	sub.w	d5,d2
	sub.w	d6,d3
	
	movem.l	d1-d3,-(sp)	
	asr	#6,d1
	asr	#6,d2
	asr	#6,d3
	
	lsl	#8,d1
	lsl	#4,d2
	or.w	d1,d3
	or.w	d2,d3
	
	move.w	d3,(a2)
	add.l	#32,a2		;next palette
	movem.l	(sp)+,d1-d3
	dbra	d7,store_fade_cols
	addq.l	#2,a1	
	dbra	d0,cr_fade_loop
	rts


*****************************************
***	FADE 32 LIST TO LIST        *****
*****************************************
Fade_32_List_To_List
*send current colour list in a0, dest colour in a1
*send copper list ptr in a2
*send store list in a3

	move.l	a3,a5
	move.w	#32-1,d0
init_list_loop32
*init list
	move.w	(a0)+,d1
	move.w	(a1)+,d4
	
	move.w	d1,d2
	move.w	d2,d3
	andi.w	#$f00,d1	;get rgb of source
	lsr	#8,d1
	andi.w	#$f0,d2
	lsr	#4,d2
	andi.w	#$f,d3
	
	asl	#6,d1
	asl	#6,d2
	asl	#6,d3
	
	move.w	d1,(a5)+	;store scaled values
	move.w	d2,(a5)+
	move.w	d3,(a5)+
	
	asr	#6,d1
	asr	#6,d2
	asr	#6,d3

	
	move.w	d4,d5		;get rgb of dest
	move.w	d5,d6
	andi.w	#$f00,d4
	lsr	#8,d4
	andi.w	#$f0,d5
	lsr	#4,d5
	andi.w	#$f,d6
	
	sub.w	d4,d1		;get diff
	sub.w	d5,d2
	sub.w	d6,d3
	
	asl	#6-4,d1		;(vals *64)/16
	asl	#6-4,d2
	asl	#6-4,d3
	
	move.w	d1,(a5)+	;store reduce values
	move.w	d2,(a5)+
	move.w	d3,(a5)+
	
	dbra	d0,init_list_loop32
		
reduce_all_colours32	
	move.w	fade_speed,d0
	subq.w	#1,d0
wait_fade_speed32
	jsr	Sync
	dbra	d0,wait_fade_speed32
		
	move.l	a2,a5		;copper
	move.l	a3,a4
	move.w	#32-1,d1
reduce_loop32

	move.w	6(a4),d2
	move.w	8(a4),d3
	move.w	10(a4),d4
	
	sub.w	d2,(a4)
	sub.w	d3,2(a4)
	sub.w	d4,4(a4)
	
	move.w	(a4),d2
	move.w	2(a4),d3
	move.w	4(a4),d4
	
	asr	#6,d2
	asr	#6,d3
	asr	#6,d4
	
	lsl	#8,d2
	lsl	#4,d3
	or.w	d2,d4
	or.w	d3,d4
	
	move.w	d4,(a5)
	
	addq.l	#4,a5
	add.l	#12,a4
	
	dbra	d1,reduce_loop32
	
	dbra	d7,reduce_all_colours32

	rts
	

*****************************************
***	Wait_For_Fire_Press	    *****
*****************************************
Wait_For_Fire_Press
	
	clr.w	Fire
Wait_For_User_To_Get_Bored	
	jsr	Sync
	bsr	get_stick_readings
	tst	fire
	beq.s	Wait_For_User_To_Get_Bored
	bsr	Clear_Stick
	rts

*****************************************
***	TAKE COPY OF AREA	    *****
*****************************************
Take_Copy_Of_Area

	move.l	copyback_area,a0
	move.l	copy_store_area,a1
		
	move.w	#(SINGLE_PLANE/4)-1,d0
make_copy
	move.l	(a0),(a1)+
	clr.l	(a0)+
	dbra	d0,make_copy			
	rts
	
*****************************************
***	RESTORE COPY AREA	    *****
*****************************************
Restore_Copy_Area

	move.l	copyback_area,a1
	move.l	copy_store_area,a0
	move.w	#(SINGLE_PLANE/4)-1,d0
restore_copy
	move.l	(a0)+,(a1)+
	dbra	d0,restore_copy			
	rts

*****************************************
***	WHITE_ALL_PALETTE	    *****
*****************************************
White_All_Palette

	move.l	#sprite_cols+2,a0
	move.w	#16-1,d0
white_all
	move.w	#$fff,(a0)
	addq.l	#4,a0
	dbra	d0,white_all		
	rts

*****************************************
***	SWITCH ON TEXT SCREEN	    *****
*****************************************
Switch_On_Text_Screen

	jsr	Sync
	move.l	copyback_area,d0	;insert into copper
	move.w	d0,plane5_lo
	swap	d0
	move.w	d0,plane5_hi

	move.w	#$5200,plane_control	;pow!
	rts	
	
*****************************************
***	SWITCH OFF TEXT SCREEN	    *****
*****************************************
Switch_Off_Text_Screen

	jsr	Sync
	move.w	#$4200,plane_control

	rts	

*****************************************
***	CENTER TEXT      	    *****
*****************************************
Center_Text
*send text in a4, will set d0 = position


	moveq	#0,d0
	moveq	#0,d5
	moveq	#0,d7
	move.l	a4,a5	
center_loop	
	move.b	(a5)+,d7
	ble.s	got_the_cent_pos
	cmp.b	#"j",d7
	bge.s	cent_last_line
	cmp.b	#"F",d7
	bge.s	cent_middle_line
	move.l	#malfont_width_table,a1
	sub.b	#" ",d7
	bra.s	get_cent_pos	
cent_middle_line	
	move.l	#malfont_width_table2,a1
	sub.b	#"F",d7
	bra.s	get_cent_pos		
cent_last_line
	move.l	#malfont_width_table3,a1
	sub.b	#"j",d7
get_cent_pos
	move.b	(a1,d7),d5
	add.w	d5,d0	
	bra.s	center_loop
got_the_cent_pos
	neg.w	d0
	add.w	#320,d0
	asr	d0
	
	move.w	scroll_value,d7
	andi.w	#$f,d7
	sub.w	#$f,d7
	neg.w	d7
	
	add.w	d7,d0

	
	rts

*****************************************
***	DISPLAY STRING      	    *****
*****************************************
Display_String
*Send in null terminated string along with start x and y co-ords in a4,d0,d1
*mem area in a3

	move.w	d0,d3		;save
letter_extract_and_draw	
	clr.l	d2
	move.b	(a4)+,d2
	beq.s	finished_drawing_string
	bpl.s	not_a_new_line
	cmp.b	#CENTER_LINE,d2
	beq.s	cent_line
	move.w	d3,d0
	add.w	#MALFONT_HEIGHT,d1
	bra.s	letter_extract_and_draw
cent_line
	bsr	Center_Text	
	bra.s	letter_extract_and_draw
not_a_new_line			
	bsr	Draw_Letter
	bra.s	letter_extract_and_draw
finished_drawing_string	
	rts


*****************************************
***	DRAW LETTER      	    *****
*****************************************
Draw_Letter
*send in x and y in d0 and d1
*letter in d2
*mem in a3

	movem.l	d0-d1/d3/a3,-(sp)

	cmp.b	#"j",d2
	bge.s	last_line
	cmp.b	#"F",d2
	bge.s	middle_line
	move.l	#malfont,a0
	move.l	#malfont_width_table,a1
	sub.b	#" ",d2
	bra.s	get_letter_pos	
middle_line	
	move.l	#malfont+MALFONT_HEIGHT*40,a0
	move.l	#malfont_width_table2,a1
	sub.b	#"F",d2
	bra.s	get_letter_pos		
last_line
	move.l	#malfont+(MALFONT_HEIGHT*2)*40,a0
	move.l	#malfont_width_table3,a1
	sub.b	#"j",d2
get_letter_pos
	
	moveq	#0,d5
	moveq	#0,d3		;pix pos in reg
	moveq	#0,d4
	move.b	(a1,d2),d4	;the width of char
	move.w	d4,wait_width	;title screen scroll stuff
	move.w	d4,d7
	tst.b	d2
	beq.s	pix_at_zero
find_pix_position				
	move.b	(a1)+,d5
	add.w	d5,d3
	subq.w	#1,d2
	bne.s	find_pix_position
pix_at_zero	

*Right, d4 = width, d3 = pixel position of char in graphics

	move.w	d3,d5
	andi.w	#$f,d5		;shift of char
	
	andi.w	#$fff0,d3
	asr	#3,d3		;bytes in
	add.l	d3,a0		;graphics position
	
	move.l	#malfont_mask_table,a2
	asl	#2,d4
	move.l	(a2,d4),d4
		
	ror.l	d5,d4
	
*right so now work out where graphics have to go

	mulu	text_bpr,d1
	add.l	d1,a3
	
	sub.w	d5,d0		;sub char offset from desired pix dest
	bpl.s	no_problem
	move.w	text_bpr,d1
	move.w	d1,d6
	ext.l	d6
	asl	#3,d1
	add.w	d1,d0	;if minus treat as on prev line
	sub.l	d6,a3	
no_problem	
	move.w	d0,d1
	ext.l	d1
	andi.w	#$fff0,d1	;work out bytes in (word bound)
	asr	#3,d1
	add.l	d1,a3
	andi.w	#$f,d0		;shift
	
	ror	#4,d0
	move.w	d0,d1
	ori.w	#$0fea,d0	;AB+C=D
	swap	d0		;blit shift
	move.w	d1,d0		;b's shift
	
wait_for_all_blits	
	btst	#14,dmaconr(a6)
	bne.s	wait_for_all_blits
	
	move.l	d4,malfont_mask
	move.l	d0,bltcon0(a6)
	move.w	text_bpr,d0
	subq.w	#6,d0
	move.w	d0,bltcmod(a6)
	move.w	d0,bltdmod(a6)
	move.w	#-6,bltbmod(a6)
	move.w	#40-6,bltamod(a6)
	
	move.l	a3,bltcpth(a6)
	move.l	a3,bltdpth(a6)
	move.l	a0,bltapth(a6)	;graphics
	move.l	#malfont_mask,bltbpth(a6)	;char mask
	
	move.l	#$ffffffff,bltafwm(a6)
	
	move.w	#MALFONT_HEIGHT<<6+3,bltsize(a6)			
	
	movem.l	(sp)+,d0-d1/d3/a3
	add.w	d7,d0	;update x position
	
	rts

	
*Text Commands
CENTER_LINE	EQU	-2
CHANGE_COLOUR	EQU	-3	
	
*****************************************
***	CENTER SMALL TEXT      	    *****
*****************************************
Center_Small_Text
*send text in a4, will set d0 = position

	moveq	#0,d0
	moveq	#0,d5
	moveq	#0,d7
	move.l	a4,a5	
center_small_loop	
	move.b	(a5)+,d7
	cmp.b	#-1,d7
	beq.s	got_the_small_cent_pos
	cmp.b	#CHANGE_COLOUR,d7
	bne.s	not_change_c
	move.b	(a5)+,d7
	bra.s	center_small_loop
not_change_c	
	cmp.b	#"e",d7
	bge.s	small_cent_last_line
	move.l	#smallfont_width_table,a1
	sub.b	#" ",d7
	bra.s	get_small_cent_pos	
small_cent_last_line
	move.l	#smallfont_width_table2,a1
	sub.b	#"e",d7
get_small_cent_pos
	move.b	(a1,d7),d5
	add.w	d5,d0	
	bra.s	center_small_loop
got_the_small_cent_pos
	neg.w	d0
	move.w	text_bpr,d7
	asl	#3,d7
	add.w	d7,d0
	asr	d0
	rts

*****************************************
***	DISPLAY SMALL STRING   	    *****
*****************************************
Display_Small_String
*Send in null terminated string along with start x and y co-ords in a4,d0,d1
*mem area in a3


	
	move.w	#WHITE,default_colour
Display_Small_String_Skip	

small_wait_for_all_blits_before_start	
	btst	#14,dmaconr(a6)
	bne.s	small_wait_for_all_blits_before_start
	move.w	text_bpr,d2
	subq.w	#6,d2
	move.w	d2,bltcmod(a6)
	move.w	d2,bltdmod(a6)
	move.w	#-6,bltbmod(a6)
	move.w	#40-6,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)


	move.w	d0,d3		;save
small_letter_extract_and_draw	
	clr.l	d2
	move.b	(a4)+,d2
	beq.s	finished_drawing_small_string
	bpl.s	not_a_new_small_line
	cmp.b	#CHANGE_COLOUR,d2
	bne.s	not_col_change
	move.b	(a4)+,d2
	ext.w	d2
	move.w	d2,default_colour
	bra.s	small_letter_extract_and_draw
not_col_change	
	cmp.b	#CENTER_LINE,d2
	beq.s	cent_small_line
	move.w	d3,d0
	add.w	#SMALLFONT_HEIGHT,d1
	bra.s	small_letter_extract_and_draw
cent_small_line
	bsr	Center_Small_Text	
	bra.s	small_letter_extract_and_draw
not_a_new_small_line			
	bsr	Draw_Small_Letter
	bra.s	small_letter_extract_and_draw
finished_drawing_small_string	
	rts

default_colour	dc.w	WHITE

*****************************************
***	DRAW SMALL LETTER      	    *****
*****************************************
Draw_Small_Letter
*send in x and y in d0 and d1
*letter in d2
*mem in a3

	cmp.b	#' ',d2
	bne.s	not_a_space
	addq.w	#5,d0
	rts
not_a_space
	movem.l	d0-d1/d3/a3,-(sp)


	cmp.b	#"e",d2
	bge.s	last_small_line
	move.l	#smallfont,a0
	move.l	#smallfont_width_table,a1
	sub.b	#" ",d2
	bra.s	get_small_letter_pos	
last_small_line
	move.l	#smallfont+SMALLFONT_HEIGHT*40,a0
	move.l	#smallfont_width_table2,a1
	sub.b	#"e",d2
get_small_letter_pos
	
	moveq	#0,d5
	moveq	#0,d3		;pix pos in reg
	moveq	#0,d4
	move.b	(a1,d2),d4	;the width of char
	move.w	d4,d7
	tst.b	d2
	beq.s	small_pix_at_zero
small_find_pix_position				
	move.b	(a1)+,d5
	add.w	d5,d3
	subq.w	#1,d2
	bne.s	small_find_pix_position
small_pix_at_zero	

*Right, d4 = width, d3 = pixel position of char in graphics

	move.w	d3,d5
	andi.w	#$f,d5		;shift of char
	
	andi.w	#$fff0,d3
	asr	#3,d3		;bytes in
	add.l	d3,a0		;graphics position
	
	move.l	#malfont_mask_table,a2
	asl	#2,d4
	move.l	(a2,d4),d4
		
	ror.l	d5,d4
	
*right so now work out where graphics have to go

	mulu	text_bpr,d1
	add.l	d1,a3
	
	sub.w	d5,d0		;sub char offset from desired pix dest
	bpl.s	small_no_problem
	move.w	text_bpr,d1
	move.w	d1,d6
	ext.l	d6
	asl	#3,d1
	add.w	d1,d0	;if minus treat as on prev line
	sub.l	d6,a3	
small_no_problem	
	move.w	d0,d1
	ext.l	d1
	andi.w	#$fff0,d1	;work out bytes in (word bound)
	asr	#3,d1
	add.l	d1,a3
	andi.w	#$f,d0		;shift
	
	ror	#4,d0
	move.w	d0,d1
	ori.w	#$0fea,d0	;AB+C=D
	swap	d0		;blit shift
	move.w	d1,d0		;b's shift
	
	move.w	default_colour,d6
draw_coloured_text
	lsr.w	d6
	bcc.s	dont_draw_plane
small_wait_for_all_blits	
	btst	#14,dmaconr(a6)
	bne.s	small_wait_for_all_blits

	move.l	d4,malfont_mask
	move.l	d0,bltcon0(a6)

	move.l	a3,bltcpth(a6)
	move.l	a3,bltdpth(a6)
	move.l	a0,bltapth(a6)	;graphics
	move.l	#malfont_mask,bltbpth(a6)	;char mask
		
	move.w	#SMALLFONT_HEIGHT<<6+3,bltsize(a6)			
	
dont_draw_plane	
	add.l	Plane_Skip_Size,a3
	tst.w	d6
	bne.s	draw_coloured_text
	movem.l	(sp)+,d0-d1/d3/a3
	add.w	d7,d0		;update x position
	
	rts

Plane_Skip_Size
	dc.l	LO_RES_PLANE	

*****************************************
***	SET SPRITE TO SCREEN	    *****
*****************************************
Set_Sprite_To_Screen
*send in colour to make in d0	
*Set the sprite colours to the game colours	
	move.l	#sprite_cols+2,a0
	move.l	#copper_colours+2,a2
	move.l	#black_list,a1
	move.l	#game_list,a3
	move.w	#16-1,d1
set_sprite_to_game
	move.w	(a2),(a0)
	move.w	(a2),(a3)+
	move.w	d0,(a1)+	
	addq.l	#4,a0
	addq.l	#4,a2
	dbra	d1,set_sprite_to_game
	rts

*****************************************
***	CHECK FOR CONTINUE	    *****
*****************************************
Check_For_Continue
	
	move.w	Continue_Credits,d0
	add.w	#48,d0
	move.b	d0,Number_Of_Continues+14

	move.w	#BPR,text_bpr
	bsr	Take_Copy_Of_Area
	bsr	Remove_Scanner
	bsr	Remove_Player

	bsr	White_All_Palette
	move.l	#Continue_Text,a4
	move.w	scroll_value,d0
	andi.w	#$f,d0
	sub.w	#$f,d0
	neg.w	d0
	
	add.w	#40,d0
	move.w	#90,d1
	move.l	copyback_area,a3
	bsr	Display_String
	bsr	Switch_On_Text_Screen
Wait_For_Response	
	jsr	Sync
	bsr	Read_Keyboard
	cmp.w	#'N',d7
	beq.s	Dont_Continue_Game
	cmp.w	#'n',d7
	beq.s	Dont_Continue_Game
	cmp.w	#'Y',d7
	beq.s	Continue_With_Game
	cmp.w	#'y',d7
	beq.s	Continue_With_Game
	bra.s	Wait_For_Response
Continue_With_Game
	subq.w	#1,Continue_Credits
	clr.w	Cash
	clr.w	Cash_Request
	clr.l	Score
	clr.w	Inter_Score	
	bsr	Switch_Off_Text_Screen
	bsr	Restore_Copy_Area
	move.w	#3,Player_Lives		
	move.w	Player_Energy_Limit,Player_Current_Energy
	bsr	Display_Total_Energy
	bsr	Display_Player_Lives
	move.w	#GAME_LOOP,Schedule_Entry
	bsr	Do_Sprite_Colours
	bsr	Display_Scanner
	bsr	Display_Player	
	move.w	#1,d0
	rts
Dont_Continue_Game
	bsr	Switch_Off_Text_Screen
	clr.w	d0
	rts
	
*****************************************
***	GAME OVER SCREEN	    *****
*****************************************
Game_Over_Screen

	move.w	#BPR,text_bpr
	bsr	Take_Copy_Of_Area
	bsr	Remove_Scanner
	bsr	Remove_Player
	bsr	Delete_Points_From_Scanner
	
	move.l	#Game_Over_Text,a4
	move.w	scroll_value,d0
	andi.w	#$f,d0
	sub.w	#$f,d0
	neg.w	d0
	
	add.w	#60,d0
	move.w	#90,d1
	move.l	copyback_area,a3
	bsr	Display_String

	move.l	#black_list,a0
	move.w	#16-1,d0
fill_bl_wr
	move.w	#$a00,(a0)+
	dbra	d0,fill_bl_wr	
	move.w	#1,Fade_Speed
	jsr	Sync
	move.l	level_palette,a0
	move.l	#black_list,a1
	move.l	#copper_colours+2,a2
	move.w	#10-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List

	bsr	Switch_On_Text_Screen
	move.w	#$fff,d0
	bsr	Set_Sprite_To_Screen
	
*Fade text screen colours to black
	move.w	#3,Fade_Speed
	jsr	Sync
	move.l	#Game_list,a0
	move.l	#black_list,a1
	move.l	#sprite_cols+2,a2
	move.w	#12-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List
	bsr	Wait_For_Fire_Press
	rts
	
Fade_Speed	dc.w	1	
		
*****************************************
***	BLACK OUT EVERYTHING	    *****
*****************************************
Black_Out_Everything

	move.l	#copper_colours+2,a0
	move.l	#sprite_cols+2,a1
	move.l	#panel_colours+2,a2
	move.w	#16-1,d0
black_out_loop
	clr.w	(a0)
	clr.w	(a1)
	clr.w	(a2)
	addq.l	#4,a0
	addq.l	#4,a1
	addq.l	#4,a2
	dbra	d0,black_out_loop
	rts

*****************************************
***	WAIT FOR USER FIRE PRESS    *****
*****************************************

Wait_For_User_Fire_Press
	btst	#7,$bfe001
	bne.s	Wait_For_User_Fire_Press
	rts

*****************************************
***	LEVEL OVER SCREEN	    *****
*****************************************
Level_Over_Screen

	bsr	Remove_Scanner
	bsr	Remove_Player
	bsr	Convert_Cash_To_String
	move.l	#score_line+11,a5
	clr.w	d7	;convert zero's
	bsr	Convert_Score_To_String

	move.w	#BPR,text_bpr
	bsr	Take_Copy_Of_Area

	move.l	#Level_Over_Text,a4
	move.w	#0,d0
	move.w	#0,d1
	move.l	copyback_area,a3
	bsr	Display_String

	bsr	Clear_Black_Colours	
	move.w	#1,Fade_Speed
	jsr	Sync
	move.l	level_palette,a0
	move.l	#black_list,a1
	move.l	#copper_colours+2,a2
	move.w	#4-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List


	bsr	Switch_On_Text_Screen
	
	move.w	#$fff,d0
	bsr	Set_Sprite_To_Screen

*Fade text screen colours to black
	move.w	#3,Fade_Speed
	jsr	Sync
	move.l	#Game_list,a0
	move.l	#black_list,a1
	move.l	#sprite_cols+2,a2
	move.w	#8-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List
	bsr	Wait_For_Fire_Press
	bsr	Switch_Off_Text_Screen
	rts

*****************************************
***	DISPLAY END GAME            *****
*****************************************
Display_End_Game

	bsr	Clear_Black_Colours	
	move.w	#1,Fade_Speed
	move.l	#black_list,a1
	move.l	#panel_cols,a0
	move.l	#panel_colours+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List	;fade to black

	move.w	#3,Fade_Speed
	move.l	#black_list,a1
	move.l	level_palette,a0
	move.l	#copper_colours+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_List_To_List	;fade to black

	move.w  #BIT_PLANE_DMA+SPRITE_DMA,dmacon(a6)
	
	move.l	memory_base,d0
	move.w	d0,SHPlane1_lo
	swap	d0
	move.w	d0,SHPlane1_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,SHPlane2_lo
	swap	d0
	move.w	d0,SHPlane2_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,SHPlane3_lo
	swap	d0
	move.w	d0,SHPlane3_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,SHPlane4_lo
	swap	d0
	move.w	d0,SHPlane4_hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,SHPlane5_lo
	swap	d0
	move.w	d0,SHPlane5_hi

	bsr	Clear_Black_Colours
	bsr	Clear_Game_Colours

	bsr	Load_EndGame_Picture

	move.l	#shareware_screen_copper,cop1lch(a6)
	clr.w	copjmp1(a6)
	jsr	Sync
	move.w  #BIT_PLANE_DMA+$8000,dmacon(a6)

	move.l	#black_list,a0
	move.l	colour_map_ptr,a1
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_32_List_To_List
	
	bsr	Wait_For_Fire_Press
	
	move.l	#black_list,a1
	move.l	colour_map_ptr,a0
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	bsr	Fade_32_List_To_List
	rts

*****************************************
***	DISPLAY GET READY           *****
*****************************************
Display_Get_Ready

	move.w	split_position,d3
	cmp.w	#GET_READY_Y_POS,d3
	bgt.s	gr_before_split
	move.l	current_alien_split_draw_position,a3
	move.w	#GET_READY_Y_POS,d2
	move.w	d2,d4
	sub.w	d3,d4
	mulu	#BPR,d4
	add.l	d4,a3	
	bra.s	do_the_bis
gr_before_split
	move.l	current_alien_draw_position,a3
	add.l	#GET_READY_Y_POS*BPR,a3
	move.w	#GET_READY_Y_POS,d2
do_the_bis
	add.l	#GET_READY_BYTE_POS,a3
	
	move.w	d2,get_ready_split
	move.l	a3,get_ready_mem_pos

	move.l	#get_ready_graphics,a1
	move.l	copy_store_area,a0
	move.w	#GET_READY_HEIGHT-1,d0
get_ready_y_loop	
	move.w	#GET_READY_WORDS-1,d1
copy_back_and_in

*make mask
	move.w	(a1),d4
	or.w	GET_READY_PLANE(a1),d4
	or.w	GET_READY_PLANE*2(a1),d4
	or.w	GET_READY_PLANE*3(a1),d4	
	not.w	d4
	
	move.w	(a3),(a0)+	;back
	
	and.w	d4,(a3)
	move.w	(a1),d5
	or.w	d5,(a3)	;in
	
	move.w	PLANE_INC(a3),(a0)+	;back
	and.w	d4,PLANE_INC(a3)
	move.w	GET_READY_PLANE(a1),d5
	or.w	d5,PLANE_INC(a3)	;in

	add.l	#PLANE_INC*2,a3
	move.w	(a3),(a0)+		;back
	and.w	d4,(a3)
	move.w	GET_READY_PLANE*2(a1),d5
	or.w	d5,(a3)	;in

	
	move.w	PLANE_INC(a3),(a0)+	;back
	and.w	d4,PLANE_INC(a3)
	move.w	GET_READY_PLANE*3(a1),d5
	or.w	d5,PLANE_INC(a3)	;in
	

	sub.l	#(PLANE_INC*2)-2,a3
	addq.l	#2,a1
	
	dbra	d1,copy_back_and_in
	add.l	#BPR-(GET_READY_WORDS*2),a3
	addq.w	#1,d2
	cmp.w	d2,d3
	bne.s	gr_stillbefore_split
	move.l	current_alien_split_draw_position,a3
	add.l	#GET_READY_BYTE_POS,a3
gr_stillbefore_split
	dbra	d0,get_ready_y_loop
	rts

get_ready_mem_pos
	dc.l	0
get_ready_split
	dc.w	0	

*****************************************
***	REMOVE GET READY            *****
*****************************************
Remove_Get_Ready
	move.w	#$8080,d7	;mask
	
	
keep_going_until_mask_complete
	jsr	Sync
	move.w	d7,d4
	not.w	d4

	move.l	get_ready_mem_pos,a3
	move.w	split_position,d3
	move.w	get_ready_split,d2

	move.l	copy_store_area,a0
	move.w	#GET_READY_HEIGHT-1,d0
get_rep_ready_y_loop	
	move.w	#GET_READY_WORDS-1,d1
copy_rep_back
	
	move.w	(a0)+,d6
	move.w	(a3),d5
	and.w	d7,d6
	and.w	d4,d5
	or.w	d5,d6
	move.w	d6,(a3)
	
	move.w	(a0)+,d6
	move.w	PLANE_INC(a3),d5
	and.w	d7,d6
	and.w	d4,d5
	or.w	d5,d6
	move.w	d6,PLANE_INC(a3)
	
	add.l	#PLANE_INC*2,a3
	
	move.w	(a0)+,d6
	move.w	(a3),d5
	and.w	d7,d6
	and.w	d4,d5
	or.w	d5,d6
	move.w	d6,(a3)
	
	move.w	(a0)+,d6
	move.w	PLANE_INC(a3),d5
	and.w	d7,d6
	and.w	d4,d5
	or.w	d5,d6
	move.w	d6,PLANE_INC(a3)



	sub.l	#(PLANE_INC*2)-2,a3
	dbra	d1,copy_rep_back
	add.l	#BPR-(GET_READY_WORDS*2),a3
	addq.w	#1,d2	
	cmp.w	d2,d3
	bne.s	gr_rep_stillbefore_split
	move.l	current_alien_split_draw_position,a3
	add.l	#GET_READY_BYTE_POS,a3
gr_rep_stillbefore_split
	dbra	d0,get_rep_ready_y_loop
	cmp.w	#$ffff,d7
	beq.s	finished_wipe
	ror.w	d7
	or.w	#$8080,d7
	bra	keep_going_until_mask_complete	
finished_wipe
	rts
	
	
****************************************
****     CONVERT CASH TO STRING ********
****************************************
Convert_Cash_To_String
	move.w	cash,d0
	move.l	#cash_line+10,a0
	ext.l	d0
	move.l	#10000,d1
convert_csh_loop
	divu	d1,d0
	move.w	d0,d2	;units
	clr.w	d0
	swap	d0
	
	add.b	#'0',d2
	move.b	d2,(a0)+
	cmp.w	#1,d1
	beq.s	done_csh_convert
	divu	#10,d1
	bra.s	convert_csh_loop
done_csh_convert		
	rts	

****************************************
****    CONVERT SCORE TO STRING ********
****************************************
Convert_Score_To_String
*send string in a5
*leading zero flag in d7 - 0 = keep zeros
	move.l	score,d0
	clr.w	d3	
	move.l	#long_num_vals,a1
	move.l	(a1)+,d1	
convert_scr_loop
	clr.w	d2
instance_count
	sub.l	d1,d0
	bmi.s	reached_end_c
	addq.w	#1,d2
	bra.s	instance_count
reached_end_c
	add.l	d1,d0				
	tst	d7
	beq.s	forget_zeros

	tst	d2
	bne.s	forget_zeros
	tst	d3
	bne.s	forget_zeros
	move.b	#' ',(a5)+
	bra.s	done_z_tst	
forget_zeros
	move.w	#1,d3	
	add.b	#'0',d2
	move.b	d2,(a5)+	
done_z_tst	
	cmp.w	#1,d1
	beq.s	done_scr_loop	
	move.l	(a1)+,d1	
	bra.s	convert_scr_loop
done_scr_loop
	rts
	
	
