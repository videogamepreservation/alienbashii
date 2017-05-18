*****************************************************************
* MODULE TITLE     :button_routines                             *
*                                                               *
* DESCRIPTION      :Button display and handling software        *
*                                                               *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :setup_button_list                           *
*                   check_for_call_routine                      *
*                   check_to_see_hit                            *
*                   draw_buttons                                *
*                   delete_buttons                              *
*                   display_button                              *
*                   remove_button                               *
*                   display_button_list                         *
*                   remove_button_list                          *
*                                                               *
*****************************************************************

NOT_DEPRESSED	equ 0
DEPRESSED	equ 1

CUSTOM_BUTTON	equ 1
STANDARD_BUTTON	equ 0
TOGGLE_BUTTON	equ 2
HOLD_BUTTON	equ 4
NO_WAIT_BUTTON  equ 8

BUTTON_WIDTH	equ 112
BUTTON_HEIGHT	equ 16

OFFSET	equ 3	;to position in middle of button
EDGE	equ 4	;bass relief edge size



**************************************
***** SETUP BUTTON LIST          *****
**************************************
setup_button_list
	move.l	#$FFFFFFFF,button_list
	move.l	#$FFFFFFFF,button_delete_list
	move.l	#$FFFFFFFF,button_draw_list
	move.w	#0,button_counter
	rts

**************************************
***** CHECK FOR CALL ROUTINE     *****
**************************************
check_for_call_routine
	cmp.l	#$ffffffff,jump_routine
	beq.s	end_call_routine
	move.l	jump_routine,a0
	jsr	(a0)
end_call_routine	
	move.l	#$ffffffff,jump_routine
	rts
	
jump_routine
	dc.l	$ffffffff
		
**************************************
***** CHECK TO SEE HIT           *****
**************************************
check_to_see_hit

	
	cmp.w	#1,mouse_button_ind
	bne	button_not_down
	move.l	clicked_button,a0	;
	move.b	button_type(a0),d0	;
	btst	#2,d0			;
	beq.s	not_a_hold_button	;
	btst	#6,$bfe001		;
	bne.s	has_been_released	;
	btst	#3,d0
	bne.s	execute_button_proc
	cmp.w	#0,button_wait_counter
	beq	execute_button_proc
	subq.w	#1,button_wait_counter
	bra	quit_check_buttons
execute_button_proc
	move.l	button_proc(a0),jump_routine
	bra	quit_check_buttons	;
not_a_hold_button			;
	btst	#6,$bfe001
	beq	quit_check_buttons
has_been_released			;
	
	move.w	#0,mouse_button_ind
	move.l	clicked_button,a1
	btst	#1,button_type(a1)	;toggle button test
	bne.s	jump_to_button_routine	
	move.b	#0,button_clicked(a1)
	move.l	button_draw_ptr,a2
	move.l	button_delete_ptr,a3
	move.l	a1,(a2)+
	move.l	a1,(a3)+
	move.l	#$ffffffff,(a2)
	move.l	#$ffffffff,(a3)
	move.l	a2,button_draw_ptr
	move.l	a3,button_delete_ptr
jump_to_button_routine	
	btst	#2,button_type(a1)		;
	beq.s	not_hold_button			;
	cmp.w	#0,button_wait_counter
	bne.s	not_hold_button			;give nice feel to hold button
	move.w	#BUTTON_HOLD_WAIT,button_wait_counter
	move.l	#$ffffffff,jump_routine		;
	bra	quit_check_buttons		;
not_hold_button				
	move.w	#BUTTON_HOLD_WAIT,button_wait_counter	;
	move.l	button_proc(a1),jump_routine
	bra	quit_check_buttons
button_not_down	
	btst	#6,$bfe001		;test only
	beq	check_hits_by_user	;frig for editor only
	move.w	#0,left_first	
	bra	quit_check_buttons
check_hits_by_user	
	move.l	#button_list,a0	
check_buttons_loop	
	cmp.l	#$ffffffff,(a0)
	beq	quit_check_buttons		
	move.l	(a0),a1
	move.w	button_x(a1),d0
	move.w	button_y(a1),d1

test_current_window	
	cmp.w	#MAIN_BUTTON_SCREEN,current_frame	;jiggery pokery
	bne.s	window_up
	cmp.w	#MAIN_SCREEN,frame_type(a1)
	beq.s	check_button_frame_type
window_up
	move.w	frame_type(a1),d7
	cmp.w	current_frame,d7
	bne	not_a_hit

check_button_frame_type
	cmp.w	#WINDOW,frame_type(a1)	;is button in window
	bne.s	not_test_in_window
	cmp.w	#0,window_count		;any windows up??
	beq.s	check_that_button	
	move.l	window_list_ptr,a3
	move.l	-(a3),a4
	cmp.l	button_window(a1),a4
	bne	not_a_hit
	move.w	window_x(a4),d2
	add.w	d2,d0
	add.w	#BORDER_X,d0	;allow for border
	add.w	window_y(a4),d1	
	add.w	#BORDER_Y,d1	;allow for window y border
	bra.s	check_that_button
not_test_in_window
	cmp.w	#MAIN_BUTTON_SCREEN,frame_type(a1)
	bne.s	check_that_button
***---	STUFF TO ALLOW MYLES FULLSCREEN MODE
	tst.w	fullscreen_mode	
	beq.s	not_in_fc_mode
	bra	not_a_hit
not_in_fc_mode	
***---
	add.w	#BUTTON_WINDOW_OFFSET,d1
check_that_button
	move.w	d0,d2
	move.w	d1,d3
	btst	#0,button_type(a1)	;standard button test
	beq	normal_check_button
	***else get details***
	move.l	button_custom(a1),a2
	add.w	custom_button_x_size(a2),d2
	add.w	custom_button_y_size(a2),d3
	bra.s	check_for_click_in_button
normal_check_button	
	add.w	#BUTTON_WIDTH,d2	
	add.w	#BUTTON_HEIGHT,d3
	
check_for_click_in_button
	move.w	mouse_x,d7
***---	Another frig for fullscreen mode	
	cmp.w	#MAIN_BUTTON_SCREEN,frame_type(a1)
	bne.s	no_asr_needed
***---	
	cmp.w	#BUTTON_WINDOW_OFFSET,mouse_y
	ble.s	no_asr_needed
	asl.w	#1,d7
no_asr_needed
	cmp.w	d7,d0
	bgt.s	not_a_hit		
	cmp.w	d7,d2
	blt.s	not_a_hit
	cmp.w	mouse_y,d1
	bgt.s	not_a_hit
	cmp.w	mouse_y,d3
	blt.s	not_a_hit
	move.l	a1,clicked_button
	move.w	#1,mouse_button_ind
	cmp.b	#1,button_clicked(a1)
	beq.s	button_already_down
	move.b	#1,button_clicked(a1)
	bra.s	put_button_in_list
button_already_down	
	move.b	#0,button_clicked(a1)
put_button_in_list	
	move.l	button_draw_ptr,a2
	move.l	button_delete_ptr,a3
	move.l	a1,(a2)+
	move.l	a1,(a3)+
	move.l	#$ffffffff,(a2)
	move.l	#$ffffffff,(a3)
	move.l	a2,button_draw_ptr
	move.l	a3,button_delete_ptr
	bra.s	quit_check_buttons
not_a_hit				
	add.l	#4,a0
	bra	check_buttons_loop
quit_check_buttons			
	rts	
	
*delete buttons should always be run before draw buttons	
	
**************************************
***** DRAW BUTTONS               *****
**************************************	

*takes in the draw button list and draws these, clearing
*the list as it goes. It is done like this (and for delete)
*because then it will be synced up proper;y

draw_buttons
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	#button_draw_list,a0
draw_buttons_loop	
	cmp.l	#$ffffffff,(a0)
	beq	quit_draw_buttons		
	*****DRAW BLITS****

	move.l	#button_window_struct,a4 ;default structure	
	move.l	screen_mem(a4),a2	 ;default place to draw
	move.l	(a0),a1

	cmp.w	#WINDOW,frame_type(a1)	;are we drawing in window?
	bne.s	not_window_button
	move.l	window_list_ptr,a3
	move.l	-(a3),a4
	move.l	screen_mem(a4),a2	;replace place to draw
	move.l	#main_screen_struct,a4
not_window_button
	
	moveq	#0,d0
	moveq	#0,d1
	move.w	button_x(a1),d0
	move.w	button_y(a1),d1
	move.w	screen_x_size(a4),d4
	asr.w	#3,d4
	mulu	d4,d1		;y pos
	add.l	d1,a2
	move.w	d0,d1
	andi.w	#$000f,d1
	andi.w	#$fff0,d0
	asr.w	#3,d0
	move.l	a2,a5			;save for later
	add.l	d0,a2			;x pos
	ror.w	#4,d1			;shift
	or.w	#$0dfc,d1		;or blit
	btst.b	#0,button_type(a1)	;standard button test
	beq.s	normal_button

	*******get details about custom button

	move.l	button_custom(a1),a5
	cmp.b	#0,button_clicked(a1)
	beq.s	unclicked_custom_butt
	tst.l	custom_button_click_graphics(a5)
	beq	do_next_button	;null graphics button
	move.l	custom_button_click_graphics(a5),a3
	bra.s	calc_custom_blit_details
unclicked_custom_butt
	tst.l	custom_button_graphics(a5)
	beq	do_next_button	;null graphics button
	move.l	custom_button_graphics(a5),a3
calc_custom_blit_details	
	move.w	custom_planes(a5),d4
	subq.w	#1,d4

	move.w	custom_button_height(a5),d3	;calc custom blit size
	asl.w	#6,d3
	move.w	custom_button_width(a5),d0
	add.w	#16,d0
	asr.w	#4,d0
	add.w	d0,d3

	moveq	#0,d6

	move.w	screen_x_size(a4),d0	;calculate custom modulus
	asr.w	#3,d0
	move.w	custom_button_width(a5),d7
	asr.w	#3,d7
	move.w	d7,d6
	addq.w	#2,d7
	sub.w	d7,d0

	mulu.w	custom_button_height(a5),d6

	bra.s	blit_on_button
	

normal_button	
	cmp.b	#0,button_clicked(a1)
	beq.s	unclicked_butt
	move.l	#button_clicked_plane1,a3
	bra.s	draw_the_butt
unclicked_butt	
	move.l	#button_plane1,a3
draw_the_butt	
	move.w	#3-1,d4		;number of planes for normal_button

	move.w	#BUTTON_HEIGHT,d3	;calc blit size
	asl.w	#6,d3
	move.w	#BUTTON_WIDTH+16,d0
	asr.w	#4,d0
	add.w	d0,d3

	move.w	screen_x_size(a4),d0	;calculate modulus
	asr.w	#3,d0
	sub.w	#(BUTTON_WIDTH+16)/8,d0

	move.l	#BUTTON_WIDTH/8*BUTTON_HEIGHT,d6

blit_on_button
	btst	#14,DMACONR(a6)
	bne.s	blit_on_button
	move.l	a3,bltapt(a6)
	move.l	a2,bltdpt(a6)
	move.l	a2,bltbpt(a6)
	move.w	d0,bltdmod(a6)
	move.w	d0,bltbmod(a6)
	move.w	#-2,bltamod(a6)
	move.w	d1,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffff0000,bltafwm(a6)
	move.w	d3,bltsize(a6)

	
	add.l	d6,a3
	moveq	#0,d7
	move.w	screen_x_size(a4),d7
	asr.w	#3,d7
	mulu	screen_y_size(a4),d7
	add.l	d7,a2
	dbra	d4,blit_on_button

	btst.b	#0,button_type(a1)	;custom button test
	bne	do_next_button	

***a5 contains y position on screen

	moveq	#0,d7
	move.w	screen_x_size(a4),d7
	asr.w	#3,d7
	mulu	#OFFSET,d7
	add.l	d7,a5
	move.l   a1,a3
	add.l    #button_text,a3
	move.l	a3,a2	;**used to be a4 but i want to keep a4
	moveq	#0,d7
count_letters	
	cmp.b	#0,(a2)+
	beq.s	counted_letters
	addq.w	#1,d7
	bra.s	count_letters
counted_letters	
	mulu	#FONT_PIX_WIDTH,d7
	move.w	#BUTTON_WIDTH-(EDGE*2),d6
	sub.w	d7,d6
	asr.w	#1,d6
	moveq	#0,d0
	move.w	button_x(a1),d7
	add.w	#EDGE,d7		;start in a bit
	add.w	d6,d7		;to centre text
draw_in_text
	move.w	d7,d0
	move.l	a5,a2
	moveq	#0,d1	
	move.w	d0,d1
	andi.w	#$000f,d0
	andi.w	#$fff0,d1
	ror.w	#4,d0
	or.w	#$0d0c,d0	;not and b
	asr.w	#3,d1
	add.l	d1,a2
	moveq	#0,d4
	move.b	(a3)+,d4
	beq.s	do_next_button
	movem.l	a5,-(sp)
	move.l	#button_font,a5
	sub.w	#32,d4
	mulu	#FONT_HEIGHT*4,d4	;get letter in font
	add.l	d4,a5
	
	
blit_on_text
	btst	#14,DMACONR(a6)
	bne.s	blit_on_text
	move.l	a5,bltapt(a6)
	move.l	a2,bltdpt(a6)
	move.l	a2,bltbpt(a6)
	move.w	screen_x_size(a4),d4
	asr.w	#3,d4
	subq.w	#4,d4
	move.w	d4,bltdmod(a6)
	move.w	d4,bltbmod(a6)
	clr.w	bltamod(a6)
	move.w	d0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	#11<<6+2,bltsize(a6)
	
	movem.l	(sp)+,a5

	add.w	#FONT_PIX_WIDTH,d7
	bra.s	draw_in_text 
	
do_next_button	
	addq.l	#4,a0
	bra	draw_buttons_loop
quit_draw_buttons			
	move.l	#$ffffffff,button_draw_list
	move.l	#button_draw_list,button_draw_ptr
	
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts
	
	
**************************************
***** DELETE BUTTONS             *****
**************************************	
delete_buttons
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	#button_delete_list,a0
delete_buttons_loop	
	cmp.l	#$ffffffff,(a0)
	beq	quit_delete_buttons		
	*****CLEAR BLITS****
	
	move.l	#button_window_struct,a4
	move.l	screen_mem(a4),a2
	move.l	(a0),a1
	cmp.w	#WINDOW,frame_type(a1)	;are we checking in window?
	bne.s	delete_not_window_button
	move.l	window_list_ptr,a3
	move.l	-(a3),a4
	move.l	window_start(a4),a2	;replace default drawing position
	move.l	#main_screen_struct,a4
delete_not_window_button
	moveq	#0,d0
	moveq	#0,d1
	move.w	button_x(a1),d0
	move.w	button_y(a1),d1
	move.w	screen_x_size(a4),d3
	asr.w	#3,d3
	mulu	d3,d1		;y pos
	add.l	d1,a2
	move.w	d0,d1
	andi.w	#$000f,d1
	andi.w	#$fff0,d0
	asr.w	#3,d0
	add.l	d0,a2			;x pos
	ror.w	#4,d1			;shift
	or.w	#$0d0c,d1		;not a and b
	btst.b	#0,button_type(a1)	;standard button test
	beq.s	normal_delete_button
	
	*******get details about custom button
	
	move.l	button_custom(a1),a5	;get our pointer
	
	cmp.b	#0,button_clicked(a1)
	beq	delete_unclicked_custom_butt
	tst.l	custom_button_graphics(a5)
	beq	delete_next_button	;null graphics button
	move.l	custom_button_graphics(a5),a3
	bra	delete_calc_custom_blit_details
delete_unclicked_custom_butt
	tst.l	custom_button_click_graphics(a5)
	beq	delete_next_button	;null graphics button
	move.l	custom_button_click_graphics(a5),a3
delete_calc_custom_blit_details	
	move.w	custom_planes(a5),d4
	subq.w	#1,d4
	move.w	custom_button_height(a5),d3	;calc custom blit size
	asl.w	#6,d3
	move.w	custom_button_width(a5),d0
	add.w	#16,d0
	asr.w	#4,d0
	add.w	d0,d3

	moveq	#0,d6

	move.w	screen_x_size(a4),d0	;calculate custom modulus
	asr.w	#3,d0
	move.w	custom_button_width(a5),d7
	asr.w	#3,d7
	move.w	d7,d6
	addq.w	#2,d7
	sub.w	d7,d0

	mulu.w	custom_button_height(a5),d6

	bra.s	delete_on_button

normal_delete_button	
	cmp.b	#0,button_clicked(a1)
	beq.s	delete_clicked_butt
	move.l	#button_plane1,a3
	bra.s	delete_the_butt
delete_clicked_butt	
	move.l	#button_clicked_plane1,a3
delete_the_butt	
	moveq.w	#3-1,d4		;number of planes for normal_button

	move.w	#BUTTON_HEIGHT,d3
	asl.w	#6,d3
	move.w	#BUTTON_WIDTH+16,d0
	asr.w	#4,d0
	add.w	d0,d3

	move.w	screen_x_size(a4),d0
	asr.w	#3,d0
	sub.w	#(BUTTON_WIDTH+16)/8,d0

	move.l	#(BUTTON_WIDTH/8)*BUTTON_HEIGHT,d6


delete_on_button
	btst	#14,DMACONR(a6)
	bne.s	delete_on_button
	move.l	a3,bltapt(a6)
	move.l	a2,bltdpt(a6)
	move.l	a2,bltbpt(a6)
	move.w	d0,bltdmod(a6)
	move.w	d0,bltbmod(a6)
	move.w	#-2,bltamod(a6)
	move.w	d1,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffff0000,bltafwm(a6)

	move.w	d3,bltsize(a6)
	add.l	d6,a3

	moveq	#0,d7
	move.w	screen_x_size(a4),d7
	asr.w	#3,d7
	mulu	screen_y_size(a4),d7
	add.l	d7,a2
	dbra	d4,delete_on_button
delete_next_button	
	addq.l	#4,a0
	bra	delete_buttons_loop
quit_delete_buttons			
	move.l	#$ffffffff,button_delete_list
	move.l	#button_delete_list,button_delete_ptr
	
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts	
	
**************************************
***** DISPLAY BUTTON             *****
**************************************
display_button

*send button pointer in a0
	movem.l	a0-a3/d0/d7,-(sp)
	cmp.w	#99,button_counter
	beq.s	no_more_buttons_available
	move.l	button_head_ptr,a1
	move.l	button_draw_ptr,a2
	move.b	button_start(a0),d7
	move.b	d7,button_clicked(a0)	;reset
	move.l	window_list_ptr,a3
	move.l	-(a3),button_window(a0)
	move.l	a0,(a1)+
	move.l	a0,(a2)+
	move.l	#$ffffffff,(a2)
	move.l	#$ffffffff,(a1)
	move.l	a2,button_draw_ptr
	move.l	a1,button_head_ptr
	add.w	#1,button_counter
	moveq	#0,d0
	bra.s	quit_display_button
no_more_buttons_available	
	moveq	#-1,d0
quit_display_button	
	movem.l	(sp)+,a0-a3/d0/d7
	rts


**************************************
***** REMOVE BUTTON              *****
**************************************
remove_button
*send button in a0
	movem.l	a0-a4/d0,-(sp)
	moveq	#-1,d0
	move.l	#button_list,a1
	move.l	a1,a2
check_for_button
	cmp.l	#$ffffffff,(a1)
	beq.s	quit_remove_button
	cmp.l	(a1),a0
	beq.s	found_button
	move.l	(a1)+,(a2)+
	bra.s	check_for_button
found_button
	move.l	button_delete_ptr,a4
	cmp.b	#1,button_clicked(a0)
	beq.s	set_to_zero
	move.b	#1,button_clicked(a0)
	bra.s	move_into_delete
set_to_zero
	move.b	#0,button_clicked(a0)	
move_into_delete	
	move.l	a0,(a4)+
	move.l	#$ffffffff,(a4)
	move.l	a4,button_delete_ptr
	moveq	#0,d0		;found ok
	sub.w	#1,button_counter
	addq.l	#4,a1
	bra.s	check_for_button		
quit_remove_button
	move.l	#-1,(a2)
        move.l  a2,button_head_ptr
	movem.l	(sp)+,a0-a4/d0
	rts


**************************************
***** DISPLAY BUTTON LIST        *****
**************************************
display_button_list
*list in a0
	movem.l	d0-d7/a1-a6,-(sp)
	move.l	a0,a1
insert_loop	
	move.l	(a1)+,a0
	cmp.l	#$ffffffff,a0
	beq.s	done_all_list
	bsr	display_button
	bra.s	insert_loop
done_all_list
	movem.l	(sp)+,d0-d7/a1-a6
	rts

**************************************
***** REMOVE BUTTON LIST         *****
**************************************
remove_button_list
*list in a0
	movem.l	d0-d7/a1-a6,-(sp)
	move.l	a0,a1
insert_loop2	
	move.l	(a1)+,a0
	cmp.l	#$ffffffff,a0
	beq.s	done_all_remove_list
	bsr	remove_button
	bra.s	insert_loop2
done_all_remove_list
	movem.l	(sp)+,d0-d7/a1-a6
	rts

Force_Buttons
	bsr	delete_buttons
	bsr	draw_buttons
	rts
	
*button details

FIRST_ROW		equ 0
SECOND_ROW		equ 16
THIRD_ROW		equ 32
FOURTH_ROW		equ 48

BUTTON_1		equ 0
BUTTON_2		equ 112
BUTTON_3		equ 224
BUTTON_4		equ 336
BUTTON_5		equ 448

MAIN_BUTTON_SCREEN	equ 0
WINDOW			equ 1
MAIN_SCREEN		equ 2

BUTTON_HOLD_WAIT	EQU 10

**************B U T T O N   S T R U C T U R E *****************

	rsreset
	
button_x		rs.w	1
button_y		rs.w	1
frame_type	rs.w	1	;specifies which buttons to search through
button_type	rs.b	1	;0- standard, 1-custon
button_start	rs.b	1	;0 or 1, 1 = down already
button_data	rs.b	1	;associated button data
button_clicked	rs.b	1
button_custom	rs.l	1	;if custom = pointer to custom struct
button_window	rs.l	1	;if custom not required
button_proc	rs.l	1
button_text	rs.b	1	;not if custom
	even
	
**************C U S T O M  B U T T O N   S T R U C T U R E *****************

	rsreset

custom_button_width	rs.w	1
custom_button_height    rs.w	1
custom_button_x_size	rs.w	1
custom_button_y_size	rs.w	1
custom_planes		rs.w	1
custom_button_graphics rs.l	1
custom_button_click_graphics	rs.l 1


current_frame
	dc.w	0

mouse_button_ind
	dc.w	0
	
clicked_button
	dc.l	0
	
button_list
	ds.l	100	
button_draw_list
	ds.l	100
button_delete_list
	ds.l	100	
			
button_head_ptr
	dc.l	button_list
button_draw_ptr
	dc.l	button_draw_list
button_delete_ptr
	dc.l	button_delete_list

button_wait_counter
	dc.w	BUTTON_HOLD_WAIT
			
button_counter
	dc.w	0		
	


	
