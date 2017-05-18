*****************************************************************
* MODULE TITLE     :text_routines                               *
*                                                               *
* DESCRIPTION      :text and number drawing routines            *
*                                                               *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :write_text                                  *
*                   write_num                                   *
*                                                               *
*                                                               *
*                                                               *
*****************************************************************


***************************************
***** WRITE TEXT                  *****
***************************************
write_text
*send in struct in a0 be it window or screen
*send string (null terminated) in a1
*position of text in d0,d1
*colour of text in d2 - 0 - 15
*delete or draw in d3
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	movem.l	d0-d7/a0-a2/a4/a5,-(sp)
	move.w	d2,d5
	move.l	screen_mem(a0),a5	;place to write text
	move.l	#main_screen_struct,a4  
	moveq	#0,d6
	move.w	d1,d6
	move.w	screen_x_size(a4),d1
	asr.w	#3,d1
	mulu	d1,d6
	add.l	d6,a5
	move.w	d0,d7
	move.w	d0,d2	;store for resetting later
write_in_text
	move.w	d7,d0
	move.l	a5,a2
	moveq	#0,d1	
	move.w	d0,d1
	andi.w	#$000f,d0
	andi.w	#$fff0,d1
	ror.w	#4,d0
	tst	d3
	beq.s	delete_the_text
	or.w	#$0dFC,d0	;a or b
	bra.s	do_rest_of_text_blit
delete_the_text
	or.w	#$0d0c,d0	;a or b
do_rest_of_text_blit
	asr.w	#3,d1
	add.l	d1,a2
get_byte_of_text
	moveq	#0,d4
	move.b	(a1)+,d4
	beq	text_is_done
	cmp.b	#-2,d4
	bne.s	test_to_see_if_line
	move.b	(a1)+,d5
	bra.s	 get_byte_of_text
test_to_see_if_line	
	cmp.b	#$a,d4
	bne.s	not_new_line
	move	screen_x_size(a4),d4
	asr.w	#3,d4
	mulu	#FONT_HEIGHT+1,d4
	add.l	d4,a5
	move.w	d2,d7
	bra.s	write_in_text
	
not_new_line
	move.l	#button_font,a0
	sub.w	#32,d4
	mulu	#FONT_HEIGHT*4,d4	;get letter in font
	add.l	d4,a0
	
	move.w	#0,d6
get_correct_colour
	btst	d6,d5
	beq.s	skip_this_text_blit
blit_on_write_text
	btst	#14,DMACONR(a6)
	bne.s	blit_on_write_text
	move.l	a0,bltapt(a6)
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
	move.w	#FONT_HEIGHT<<6+2,bltsize(a6)
skip_this_text_blit
	
	move.w	screen_x_size(a4),d4
	asr.w	#3,d4
	mulu	screen_y_size(a4),d4
	add.l	d4,a2

	addq.w	#1,d6
	cmp.w   number_of_planes(a4),d6
	blt 	get_correct_colour

	add.w	#FONT_PIX_WIDTH,d7
	bra	write_in_text 

text_is_done
	movem.l	(sp)+,d0-d7/a0-a2/a4/a5

	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts




**************************************
**** WRITE NUM                    ****
**************************************


write_num
*struct in a0
*send num in d3
*x,y in d0,d1
*colour in d2
*delete or write in d4

	movem.l	d0-d7/a0-a6,-(sp)	
	move.l	#num_str,a1
	moveq	#0,d6
	move.w	d3,d6
	move.l	#10000,d5	;start divide value
number_loop
	divu	d5,d6		;divide d0 by d1
	move.b	d6,(a1)
	add.b	#48,(a1)+
	move.w	#0,d6
	swap	d6		;get remainder to lower word
	cmp.w	#1,d5
	beq	quit_number_routine
	divu	#10,d5	;divide dividor
	bra	number_loop
quit_number_routine	
	move.w	d4,d3
	move.l	#num_str,a1
	bsr	write_text
	movem.l	(sp)+,d0-d7/a0-a6
	rts

num_str
	dc.b "00000",0
	EVEN	


******************FRIGS ONLY FOR MAP EDITOR

***************************************
***** WRITE BUTTON TEXT           *****
***************************************
write_button_text
*send in struct in a0 be it window or screen
*send string (null terminated) in a1
*position of text in d0,d1
*colour of text in d2 - 0 - 15
*delete or draw in d3

	ifnd	hard_only
	bsr	own_the_blitter
	endc

	movem.l	d0-d7/a0-a2/a4/a5,-(sp)
	move.w	d2,d5
	move.l	screen_mem(a0),a5	;place to write text
	move.l	#button_window_struct,a4  
	moveq	#0,d6
	move.w	d1,d6
	move.w	screen_x_size(a4),d1
	asr.w	#3,d1
	mulu	d1,d6
	add.l	d6,a5
	move.w	d0,d7
	move.w	d0,d2	;store for resetting later
bwwrite_in_text
	move.w	d7,d0
	move.l	a5,a2
	moveq	#0,d1	
	move.w	d0,d1
	andi.w	#$000f,d0
	andi.w	#$fff0,d1
	ror.w	#4,d0
	tst	d3
	beq.s	bwdelete_the_text
	or.w	#$0dFC,d0	;a or b
	bra.s	bwdo_rest_of_text_blit
bwdelete_the_text
	or.w	#$0d0c,d0	;a or b
bwdo_rest_of_text_blit
	asr.w	#3,d1
	add.l	d1,a2
bwget_byte_of_text
	moveq	#0,d4
	move.b	(a1)+,d4
	beq	bwtext_is_done
	cmp.b	#-2,d4
	bne.s	bwtest_to_see_if_line
	move.b	(a1)+,d5
	bra.s	 bwget_byte_of_text
bwtest_to_see_if_line	
	cmp.b	#$a,d4
	bne.s	bwnot_new_line
	move	screen_x_size(a4),d4
	asr.w	#3,d4
	mulu	#FONT_HEIGHT+1,d4
	add.l	d4,a5
	move.w	d2,d7
	bra.s	bwwrite_in_text
	
bwnot_new_line
	move.l	#button_font,a0
	sub.w	#32,d4
	mulu	#FONT_HEIGHT*4,d4	;get letter in font
	add.l	d4,a0
	
	move.w	#0,d6
bwget_correct_colour
	btst	d6,d5
	beq.s	bwskip_this_text_blit
bwblit_on_write_text
	btst	#14,DMACONR(a6)
	bne.s	bwblit_on_write_text
	move.l	a0,bltapt(a6)
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
	move.w	#FONT_HEIGHT<<6+2,bltsize(a6)
bwskip_this_text_blit
	
	move.w	screen_x_size(a4),d4
	asr.w	#3,d4
	mulu	screen_y_size(a4),d4
	add.l	d4,a2

	addq.w	#1,d6
	cmp.w   number_of_planes(a4),d6
	blt 	bwget_correct_colour

	add.w	#FONT_PIX_WIDTH,d7
	bra	bwwrite_in_text 

bwtext_is_done
	movem.l	(sp)+,d0-d7/a0-a2/a4/a5
	
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts




**************************************
**** WRITE BUTTON NUM             ****
**************************************


write_button_num
*struct in a0
*send num in d3
*x,y in d0,d1
*colour in d2
*delete or write in d4

	movem.l	d0-d7/a0-a6,-(sp)	
	move.l	#num_str,a1
	moveq	#0,d6
	move.w	d3,d6
	move.l	#10000,d5	;start divide value
bwnumber_loop
	divu	d5,d6		;divide d0 by d1
	move.b	d6,(a1)
	add.b	#48,(a1)+
	move.w	#0,d6
	swap	d6		;get remainder to lower word
	cmp.w	#1,d5
	beq	bwquit_number_routine
	divu	#10,d5	;divide dividor
	bra	bwnumber_loop
bwquit_number_routine	
	move.w	d4,d3
	move.l	#num_str,a1
	bsr	write_button_text
	movem.l	(sp)+,d0-d7/a0-a6
	rts

