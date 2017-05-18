*------------------------------------------------------------------------*
*- Ohh...messy								-*
*------------------------------------------------------------------------*

*---------------------All demo routines------------------


**********************************************
***      DISPLAY TITLE PICTURE             ***
**********************************************
Display_Title_Picture
*This needs to be done each time we want to display title
*screen - it needs to be very fast

	move.w	#$8204,title_screen_copper+2	;turn off planes
	move.l	#Credit_text,text_pointer
	move.w	#80,text_bpr
	move.w	#SELECTED_COLOUR,choice_1_colour
	move.w	#NON_SELECTED_COLOUR,choice_2_colour
	move.w	#NON_SELECTED_COLOUR,choice_3_colour
	clr.w	current_choice

	move.l	#ball_cols,a1
	move.l	#hi_res_sprite_cols,a0
	jsr	Insert_Sprite_Colours

	tst.w	Title_Tune_Loaded
	bne.s	Dont_Re_Load
	bsr	Load_Intro_Tune
	bsr	mt_init
Dont_Re_Load	
	clr.w	Title_Tune_Loaded
	bsr	Load_Title_Picture
	move.l	#hires_copper_colours+2,a0
	bsr	Insert_Cols
	tst.w	stars_up
	bne.s	Skip_Start_Up
	move.w	#1,stars_up
	bsr	Set_Up_Title_Sprites
Skip_Start_Up		
	move.w  #BIT_PLANE_DMA+SPRITE_DMA+$8000,dmacon(a6)	
	bsr	Start_Up_Copper_List
	bsr	Keep_Subbing
	bsr	Update_Sprites
	bsr	Do_Sprites
	bsr	Keep_Subbing
	bsr	Update_Sprites
	bsr	Do_Sprites	
	move.w	#1,music_flag
	move.w	#$c204,title_screen_copper+2	
Main_Title_Loop
	jsr	Sync
	bsr	Do_Sprites
	bsr	Display_Hi_Res_Planes
	bsr	Update_Scrolly
	tst	fade_music
	bne.s	freeze_options
	bsr	Get_Player_Options
freeze_options	
	bsr	Update_Sprites
	bsr	Keep_Subbing
	
	tst.w	fade_music
	beq.s	dont_demo_fade
	subq.w	#1,master_volume
	tst.w	master_volume
	bne.s	Main_Title_Loop
	bra.s	stop_demo		
dont_demo_fade	
	cmp.b	#$75,$bfec01	;check for escape
	bne.s	no_key_p
	move.w	#QUIT_GAME,schedule_entry
no_key_p
	cmp.w	#CREDITS,schedule_entry
	beq.s	Main_Title_Loop	
	cmp.w	#HI_SCORES,Schedule_Entry
	beq.s	Stop_Demo_Keep_Music_On
	move.w	#1,fade_music
	bra.s	Main_Title_Loop
Stop_Demo	
	bsr	mt_end			;stop the music
	clr.w	music_flag
Stop_Demo_Keep_Music_On
	move.w  #BIT_PLANE_DMA,dmacon(a6)		
	bsr	Test_Two_Button_Joystick				
	rts

**********************************************
***        SHOW HI SCORES                  ***
**********************************************
Show_Hi_Scores	
	clr.l	movey_inc
	clr.l	movey_inc+4
	move.w	#1,fire
	move.w	#1*8,shipx_vel
	bsr	Update_Sprites
	move.w	#$8204,title_screen_copper+2
	move.l	#hi_score_titles,a4	;title for hi scores
	bsr	Display_Hi_Scores
	move.w	#$9204,title_screen_copper+2
	
	move.w  #BIT_PLANE_DMA+$8000,dmacon(a6)

hi_scores_loop	
	jsr	Sync
	bsr	Do_Sprites
	bsr	Display_Hi_Score_Planes
	bsr	Update_Sprites

	btst	#7,$bfe001
	beq.s	hi_scores_fire_pressed
	clr.w	fire
	bra.s	hi_scores_loop
hi_scores_fire_pressed
	tst.w	fire
	bne.s	hi_scores_loop			
	clr.w	shipx_vel
	move.w	#1,Title_Tune_Loaded
	move.w	#CREDITS,schedule_entry
	rts


**********************************************
***  DISPLAY HI RES PLANES                 ***
**********************************************
Display_Hi_Res_Planes	

	move.l	memory_base,d0
	move.w	vposr(a6),d1
	bpl.s	skip_add_to_planes
	add.l	#80,d0
skip_add_to_planes
	move.w	d0,HPlane1_Lo
	swap	d0
	move.w	d0,HPlane1_Hi
	swap	d0
	add.l	#HI_RES_PLANE,d0
	move.w	d0,HPlane2_Lo
	swap	d0
	move.w	d0,HPlane2_Hi
	swap	d0
	add.l	#HI_RES_PLANE,d0
	move.w	d0,HPlane3_Lo
	swap	d0
	move.w	d0,HPlane3_Hi
	swap	d0
	add.l	#HI_RES_PLANE,d0
	move.w	d0,HPlane4_Lo
	swap	d0
	move.w	d0,HPlane4_Hi
	rts


	
**********************************************
***      START UP COPPER LIST              ***
**********************************************
Start_Up_Copper_List
	move.l	#title_screen_copper,cop1lch(a6)
	clr.w	copjmp1(a6)
	rts	
	

	
SPRITE_SIZE	EQU	11
NUM_LAYERS	EQU	3
	
**********************************************
***      SET UP TITLE SPRITES              ***
**********************************************
Set_Up_Title_Sprites

	move.l	memory_base,d0
	add.l	#(HI_RES_PLANE*4)+RAPINA4_TUNE_LENGTH,d0
	
	move.l	d0,sprite_pointer1
	add.l	#(((SPRITE_SIZE+1)*4*23)+4)*NUM_LAYERS,d0
	move.l	d0,sprite_pointerattach1
	add.l	#(((SPRITE_SIZE+1)*4*23)+4)*NUM_LAYERS,d0
	move.l	d0,sprite_pointer2
	add.l	#(((SPRITE_SIZE+1)*4*23)+4)*NUM_LAYERS,d0
	move.l	d0,sprite_pointerattach2

	move.l	sprite_pointer1,a0
	move.l	sprite_pointer2,a1
	move.l	#sprite_graphic,a2
		
*do the first set of sprites		
		
	move.w	#NUM_LAYERS-1,d2
do_layers	
	move.w	#23-1,d0
num_sprites	
	move.w	#((SPRITE_SIZE+1)*2)-1,d1
	move.l	a2,a3
sprite_copy
	move.w	(a3),(a0)+
	move.w	(a3)+,(a1)+
	dbra	d1,sprite_copy
	dbra	d0,num_sprites	
	clr.l	(a0)+
	clr.l	(a1)+
	add.l	#((SPRITE_SIZE+1)*4)*2,a2
	dbra	d2,do_layers
	
* do attached layer
	
	move.l	sprite_pointerattach1,a0
	move.l	sprite_pointerattach2,a1
	move.l	#sprite_graphicattach,a2

	move.w	#NUM_LAYERS-1,d2
attacheddo_layers	
	move.w	#23-1,d0
attachednum_sprites	
	move.w	#((SPRITE_SIZE+1)*2)-1,d1
	move.l	a2,a3
attachedsprite_copy
	move.w	(a3),(a0)+
	move.w	(a3)+,(a1)+
	dbra	d1,attachedsprite_copy
	dbra	d0,attachednum_sprites	
	clr.l	(a0)+
	clr.l	(a1)+
	add.l	#((SPRITE_SIZE+1)*4)*2,a2
	dbra	d2,attacheddo_layers

	
	move.l	memory_base,d0
	add.l	#(HI_RES_PLANE*4)+RAPINA4_TUNE_LENGTH+((((SPRITE_SIZE+1)*4*23)+4)*NUM_LAYERS*4),d0
	
	move.l	#pointer_block,a0
	move.l	d0,(a0)+		;1
	move.l	d0,(a0)+
	add.l	#512,d0
	move.l	d0,(a0)+		;3
	move.l	d0,(a0)+
	add.l	#512,d0
	move.l	d0,(a0)+		;3
	move.l	d0,(a0)+
	add.l	#512,d0
	move.l	d0,(a0)+		;4
	move.l	d0,(a0)+
	add.l	#512,d0
	move.l	d0,(a0)+		;5
	move.l	d0,(a0)+
	
	move.w	#(256*5)-1,d7
	move.l	pointer_block,a0
get_rans
	move.w	#0,d0
	move.w	#320,d1
	bsr	Get_Random_Number
	move.w	d0,(a0)+
	dbra	d7,get_rans
	clr.w	(a0)

	rts		
	
	
**********************************************
***        GET PLAYER OPTIONS              ***
**********************************************
Get_Player_Options


	bsr	Get_Stick_Readings
	
	tst	fire
	beq.s	player_not_selected
	clr.w	fire
	move.l	#choice_schedule_entries,a0
	move.w	current_choice,d0
	ext.l	d0
	asl	d0
	move.w	(a0,d0),schedule_entry
	
	move.l	#choice_table,a0		;ensure choice high-lighted
	move.w	current_choice,d0
	ext.l	d0
	asl	#2,d0	
	move.l	(a0,d0),a1
	move.w	#SELECTED_COLOUR,(a1)
	
	rts	
player_not_selected

	move.l	#choice_table,a0

	subq.w	#1,joy_sample_timer
	bgt.s	flash_prev
	
ok_move_option
	move.w	#JOY_SAMPLE_TIME,joy_sample_timer		
	
	move.w	current_choice,d0
	tst	ydirec
	beq.s	no_movement
	bpl.s	player_up_options
	cmp.w	#2,d0
	beq.s	no_movement
	addq.w	#1,current_choice
	bra.s	flash_new_position
player_up_options
	tst	d0
	beq.s	no_movement
	subq.w	#1,current_choice
flash_new_position
*first reset - old flash option
	ext.l	d0
	asl	#2,d0
	move.l	(a0,d0),a1
	move.w	#NON_SELECTED_COLOUR,(a1)
	move.w	#TIME_TO_FLASH,flash_timer
	clr.w	flash_duration
no_movement	

*check to see if flashing from previous movement
flash_prev
	tst	flash_timer
	beq.s	have_completed_flash

	subq.w	#1,flash_timer
	
	subq.w	#1,flash_duration
	bgt.s	not_time_to_change_colour
	move.w	current_choice,d0
	ext.l	d0
	asl	#2,d0
	move.w	#FLASH_PERIOD,flash_duration
	move.l	(a0,d0),a1
	cmp.w	#SELECTED_COLOUR,(a1)
	beq.s	change_to_non_sc
	move.w	#SELECTED_COLOUR,(a1)
	rts
change_to_non_sc
	move.w	#NON_SELECTED_COLOUR,(a1)		
not_time_to_change_colour
	rts	
have_completed_flash
	move.w	current_choice,d0	;not worried about speed
	ext.l	d0
	asl	#2,d0
	move.l	(a0,d0),a1
	move.w	#SELECTED_COLOUR,(a1)
	rts	

	
choice_table
	dc.l	choice_1_colour
	dc.l	choice_2_colour
	dc.l	choice_3_colour	
	
choice_schedule_entries
	dc.w	GAME_SETUP
	dc.w	INSTRUCTIONS
	dc.w	HI_SCORES
	
TIME_TO_FLASH	EQU	50
FLASH_PERIOD	EQU	2
SELECTED_COLOUR	EQU	$FFF
NON_SELECTED_COLOUR	EQU $555
JOY_SAMPLE_TIME	EQU	8
	
joy_sample_timer	dc.w	0	
current_choice		dc.w	0
flash_timer		dc.w	TIME_TO_FLASH
flash_duration		dc.w	0	


*---------------------------BALL SPRITE CODE---------------------


************************************************************
****            U P D A T E    S P R I T E S            ****
************************************************************
	

update_sprites	
	move.l	a6,-(sp)
	move.l sprite_pointer1,a0
	move.l sprite_pointerattach1,a6
	move.l #movey_inc,a3
	moveq  #4,d3   ;mulu value	;8 used as loop conter , decing by 4
	move.l #pointer_block,a5	;pointer to different screen positions
	move.l #movex_incs,a4	

update_layers
	
	
	move.l (a5),a1
 	move.w #23-1,d5
	
	move.w #$1c+12,d0   ;ypos
	add.w (a3),d0
	
demo_fill_sprite
	
	cmpi.w #-12,(a3)
	bgt.s forget_it
	
	addq.l  #2,a1
	addq.l  #2,(a5)
	move.l	(a5),a2
	cmp.l  12(a5),a2
	blt.s  demo_past
	move.l 4(a5),(a5)
	move.l (a5),a1
	
demo_past	
	addi.w #12,d0
	addi.w #12,(a3)
	bra.s	skip2
forget_it	

	cmp.w #12,(a3)
	blt.s forget_it2
	subq.l #2,a1
	subq.l #2,(a5)
	move.l	(a5),a2
	cmp.l 4(a5),a2
	bge.s  past2
	move.l 12(a5),(a5)
	subq.l #2,(a5)
	move.l (a5),a1

past2
	subi.w #12,d0
	subi.w #12,(a3)
forget_it2	
		
         cmp.l 12(a5),a1
	blt.s	skip
	move.l 4(a5),a1
	bra.s skip2
skip	
	cmp.l 4(a5),a1
	bge.s	skip2
	move.l 12(a5),a1
	subq.l #2,a1
skip2
	
        clr.b	3(a0)
        move.w	shipx_vel,d6
	add.w	d3,d6
	move.w (a4,d6.w),d4
	tst	shipx_vel
	bpl.s	do_nought
	neg.w	d4
do_nought	
	add.w d4,(a1)
past_add_to_x	
	cmpi.w #320+9,(A1)
	ble.s not_bigger
	subi.w #320+18,(A1)
	bra.s finished_that
not_bigger	
	cmpi.w #0-9,(a1)
	bge.s	finished_that
	addi.w #320+18,(a1)
finished_that
	move.w (a1)+,d1	
         addi.w #$81,d1
         lsr  #1,d1
         bcc.s  no_setbit
         bset.b #0,3(a0)
no_setbit
	bset.b	#7,3(a0)	;attach bit
	move.b d1,1(a0)
	
past_setbit
	move.b d0,(a0)
	
	btst #8,d0
	beq.s demo_no_set
	bset.b #2,3(a0)

demo_no_set
         add.w #11,d0
         move.b d0,2(a0)
         
         btst #8,d0
         beq.s no_set2
         bset.b #1,3(a0)

no_set2
	move.l	(a0),(a6)	
	addq.w #1,d0  ; one line gap!!
	add.l #(12*4),a0 
	add.l #(12*4),a6        		         
*The code below fill sprite test to see if a sprite has gone up or down
*by the sprite length, if it has then the code effectively adds or subs
*from a list so a new sprite is being processed top or bottom, hence the
*way sprites appear to 'appear'. In the game this should only happen
*a maximum of once a frame so we don't need to run this code again
*if it cocks up then dbra back to fill_sprite

	dbra  d5,forget_it2
	
	addq.l #2,a3
	addq.l #4,a0
	addq.l #4,a6
	subq #2,d3
	addq.l  #8,a5
	cmpi.w #-2,d3
	bne update_layers
	move.l	(sp)+,a6
	rts	

************************************************************
****            DO    SPRITES                           ****
************************************************************

do_sprites


	move.l	sprite_pointer1,d0	;double buffer sprites
	move.l	sprite_pointer2,d1
	move.l	d1,sprite_pointer1
	move.l	d0,sprite_pointer2

	move.w d0,hsprite0l
	swap d0
	move.w d0,hsprite0h
	swap d0
	add.l #(12*4*23)+4,d0
	move.w d0,hsprite2l
	swap d0
	move.w d0,hsprite2h
	swap d0
	add.l #(12*4*23)+4,d0
	move.w d0,hsprite4l
	swap d0
	move.w d0,hsprite4h
	
		
	move.l	sprite_pointerattach1,d0	;double buffer sprites
	move.l	sprite_pointerattach2,d1
	move.l	d1,sprite_pointerattach1
	move.l	d0,sprite_pointerattach2

	move.w d0,hsprite1l
	swap d0
	move.w d0,hsprite1h
	swap d0
	add.l #(12*4*23)+4,d0
	move.w d0,hsprite3l
	swap d0
	move.w d0,hsprite3h
	swap d0
	add.l #(12*4*23)+4,d0
	move.w d0,hsprite5l
	swap d0
	move.w d0,hsprite5h

	
	move.l	#blank_data,d0
	move.w	d0,hsprite6l
	move.w	d0,hsprite7l
	swap	d0
	move.w	d0,hsprite6h
	move.w	d0,hsprite7h
	rts


keep_subbing
	sub.w	#-4,movey_inc
	sub.w	#-3,movey_inc+2
	sub.w	#-2,movey_inc+4
	sub.w	#-1,movey_inc+6
	rts


shipx_vel
	dc.w	0

movey_inc 	dc.w 0,0,0,0

movex_incs 	  dc.w 0,0,0,0	
	  	  dc.w 1,2,3,4  
	  

stars_up		dc.w	0
title_pic_loaded	dc.w	0
Title_Tune_Loaded	dc.w	0


pointer_block
	ds.l	10
	



sprite_pointer1		dc.l	0
sprite_pointer2		dc.l	0
sprite_pointerattach1	dc.l	0
sprite_pointerattach2	dc.l	0


**********************************************
***        UPDATE SCROLLY                  ***
**********************************************
Update_Scrolly

	subq.w	#2,wait_width
	bgt.s	dont_add_letter
	
	moveq	#0,d2
	move.l	text_pointer,a0
get_letter	
	move.b	(a0)+,d2
	bne.s	not_end_of_message
	move.l	#Credit_Text,a0
	bra.s	get_letter
not_end_of_message
	move.l	a0,text_pointer
	move.w	wait_width,d0
	add.w	#640-12,d0
	move.w	#510-MALFONT_HEIGHT,d1
	move.l	memory_base,a3
	bsr	Draw_Letter
dont_add_letter

*scroll!!

scrolly_wait
	btst	#14,dmaconr(a6)
	bne.s	scrolly_wait
	
	move.l	memory_base,a0
	add.l	#(510-MALFONT_HEIGHT)*80,a0
	
	move.l	a0,bltdpth(a6)
	addq.l	#2,a0
	move.l	a0,bltapth(a6)
	clr.w	bltamod(a6)
	clr.w	bltdmod(a6)
	move.l	#$e9f00000,bltcon0(a6)
	move.l	#$ffff0000,bltafwm(a6)
	move.w	#MALFONT_HEIGHT<<6+40,bltsize(a6)

	

	rts

scroll_pos	dc.w	15

wait_width	dc.w	0
text_pointer	dc.l	Credit_Text
fade_music	dc.w	0	

