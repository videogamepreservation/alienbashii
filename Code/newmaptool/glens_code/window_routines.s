*****************************************************************
* MODULE TITLE     :window_routines                             *
*                                                               *
* DESCRIPTION      :window display and handling software        *
*                                                               *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :create_window                               *
*                   destroy_window                              *
*                   draw_lines_round_window                     *
*                                                               *
*****************************************************************



***********************************************
*****	CREATE WINDOW                     *****
***********************************************
create_window
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	cmp.w	#MAX_NUM_WINDOWS,window_count
	beq.s	window_create_error

	move.l	a0,-(sp)
	bsr	draw_buttons	
	move.l	(sp)+,a0
	move.w	#0,show_box		;turn off
*send in window descriptor in a0

	moveq	#0,d0
	move.w	window_x_size(a0),d0

	andi.w	#$fff0,d0
	move.w	d0,window_x_size(a0)	;just to make sure nothing can go wrong
	asr.w	#3,d0
	mulu	window_y_size(a0),d0
	move.l	#main_screen_struct,a1
	mulu	number_of_planes(a1),d0	
	move.l	#1<<1+1<<16,d1	        	; chip and clear
	movem.l	a0/a1/a6,-(sp)
	move.l	4.w,a6
	jsr	-198(a6)	        		; try
	movem.l	(sp)+,a0/a1/a6
	tst.l	d0
	bne	got_window_mem
window_create_error
	move.w	#-1,d0
	move.w	#$f00,$dff180
	rts
got_window_mem	

	move.w	#WINDOW,current_frame
	move.l	d0,window_pointer(a0)

	move.l	window_list_ptr,a2	;update list
	move.l	a0,(a2)+
	move.l	a0,current_window_ptr   ;current window
	move.l	#$ffffffff,(a2)
	move.l	a2,window_list_ptr

	addq.w	#1,window_count
	
	
****get start pos	
	move.l	screen_mem(a1),a2

	moveq	#0,d0
;;;	move.w	window_x(a0),d0
;;;	andi.w	#$fff0,d0		* on a word aligned boundary
;;;	move.w	d0,window_x(a0)	

*------ discard original window x placement (CENTRE WINDOW INSTEAD)

	move.w	screen_x_size(a1),d0	* screen width
	sub.w	window_x_size(a0),d0	* minus window width
	asr.w	#1,d0			* divided by 2  = CENTRE POSITION
	andi.w	#$fff0,d0		* on a word aligned boundary
	move.w	d0,window_x(a0)	

	asr.w	#3,d0			* /8 = bytewidth position


	moveq	#0,d1
	move.w	screen_x_size(a1),d1
	asr.w	#3,d1
	move.l	d1,d3

	mulu	window_y(a0),d1
	add.l	d1,d0
	add.l	d0,a2	;start position on screen
	move.l	a2,window_start(a0)

	move.w	window_x_size(a0),d6	;calculate modulus for all
	asr.w	#3,d6
	sub.w	d6,d3

****done

****save background
	move.w	number_of_planes(a1),d7
	subq.w	#1,d7
	move.l	window_pointer(a0),a2
	move.l	window_start(a0),a3
save_area_on_screen
	btst	#14,DMACONR(a6)
	bne.s	save_area_on_screen
	move.l	a2,bltdpt(a6)
	move.l	a3,bltapt(a6)
	move.w	d3,bltamod(a6)
	clr.w	bltdmod(a6)
	move.w	#$09f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	moveq	#0,d0
	move.w	window_y_size(a0),d0
	asl.w	#6,d0
	move.w	window_x_size(a0),d1
	asr.w	#4,d1
	add.w	d1,d0
	move.w	d0,bltsize(a6)

	moveq	#0,d0
	move.w	window_x_size(a0),d0
	asr.w	#3,d0
	mulu	window_y_size(a0),d0
	add.l	d0,a2

	moveq	#0,d0
	move.w	screen_x_size(a1),d0
	asr.w	#3,d0
	mulu	screen_y_size(a1),d0
	add.l	d0,a3

	dbra	d7,save_area_on_screen

****set up blitter to slap a plane of graphics on
	move.w	number_of_planes(a1),d7
	subq.w	#1,d7
	move.w	d7,d6
	move.l	window_start(a0),a2
clear_area_on_screen
	btst	#14,DMACONR(a6)
	bne.s	clear_area_on_screen
	cmp.w	d6,d7
	bne.s	clear_as_normal
	move.w	#$ffff,bltadat(a6)
	bra.s	do_the_clear
clear_as_normal
	move.w	#$0000,bltadat(a6)
do_the_clear
	move.l	a2,bltdpt(a6)
	move.w	d3,bltdmod(a6)
	move.w	#$01f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	moveq	#0,d0
	move.w	window_y_size(a0),d0
	asl.w	#6,d0
	move.w	window_x_size(a0),d1
	asr.w	#4,d1
	add.w	d1,d0
	move.w	d0,bltsize(a6)
	
	moveq	#0,d0
	move.w	screen_x_size(a1),d0
	asr.l	#3,d0
	mulu	screen_y_size(a1),d0
	add.l	d0,a2
	dbra	d7,clear_area_on_screen


	move.l	window_start(a0),a5
	move.l	a0,a2
	add.l	#window_name,a2
	move.l	a2,a3
	moveq	#0,d7
window_count_letters	
	cmp.b	#0,(a2)+
	beq.s	window_counted_letters
	addq.w	#1,d7
	bra.s	window_count_letters
window_counted_letters	
	mulu	#FONT_PIX_WIDTH,d7
	move.w	window_x_size(a0),d6
	sub.w	d7,d6
	asr.w	#1,d6
	moveq	#0,d0
	move.w	d6,d7
window_draw_in_text
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
	beq.s	done_window_text
	move.l	#button_font,a4
	sub.w	#32,d4
	mulu	#FONT_HEIGHT*4,d4	;get letter in font
	add.l	d4,a4	
	
	
window_blit_on_text
	btst	#14,DMACONR(a6)
	bne.s	window_blit_on_text
	move.l	a4,bltapt(a6)
	move.l	a2,bltdpt(a6)
	move.l	a2,bltbpt(a6)
	move.w	#BYTES_PER_ROW-4,bltdmod(a6)
	move.w	#BYTES_PER_ROW-4,bltbmod(a6)
	clr.w	bltamod(a6)
	move.w	d0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	#11<<6+2,bltsize(a6)
	
	add.w	#FONT_PIX_WIDTH,d7
	bra.s	window_draw_in_text 

done_window_text


****make frame

	move.l	window_start(a0),a2

	moveq	#0,d0
	move.w	screen_x_size(a1),d0
	add.l	d0,a2
	add.l	#BORDER_X/8,a2	;one word in
	move.l	a2,window_start(a0)

	addq.w	#BORDER_X/4,d3	;two word shorter now
clear_frame_on_screen
	btst	#14,DMACONR(a6)
	bne.s	clear_frame_on_screen
	move.w	#$0000,bltadat(a6)
	move.l	a2,bltdpt(a6)
	move.w	d3,bltdmod(a6)
	move.w	#$01f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$00ffff00,bltafwm(a6)
	moveq	#0,d0
	move.w	window_y_size(a0),d0
	sub.w	#BORDER_Y*2,d0		;allow for border
	asl.w	#6,d0
	move.w	window_x_size(a0),d1
	asr.w	#4,d1
	subq.w	#2,d1			;allow for border
	add.w	d1,d0
	move.w	d0,bltsize(a6)

	bsr	draw_lines_round_window

******done
FF 	btst	#14,dmaconr(a6)
	bne.s	FF

	move.w	#1,d0	;so user knows it has worked
	
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts

***********************************************
*****	DRAW LINES ROUND WINDOW           *****
***********************************************
draw_lines_round_window
	move.l	a0,a1
	move.l	#main_screen_struct,a0	
	move.w	window_x(a1),d0
	move.w	window_y(a1),d1
	move.w	d1,d3
	move.w	d0,d2
	add.w	window_x_size(a1),d2	
	
	movem.l d0-d3/a0,-(sp)
	bsr	eor_draw_line	;line across_top
	movem.l (sp)+,d0-d3/a0

	add.w	window_y_size(a1),d3
	add.w	window_x_size(a1),d0
	subq.w	#1,d0
	addq.w  #1,d1
	subq.w	#1,d2
	movem.l d0-d3/a0,-(sp)
	bsr	eor_draw_line	;top right to bottom
	movem.l (sp)+,d0-d3/a0

	add.w	window_y_size(a1),d1
	subq.w	#2,d1	;
	subq.w	#1,d3
        subq.w  #1,d0
	sub.w	window_x_size(a1),d2
	addq.w	#1,d2
	movem.l d0-d3/a0,-(sp)
	bsr	eor_draw_line	;bottom right to bottom left
	movem.l (sp)+,d0-d3/a0

	move.w	window_x(a1),d0
	move.w	window_y(a1),d1
        addq.w  #1,d1	;
        addq.w	#1,d3
	*subq.w	#2,d3
	movem.l d0-d3/a0,-(sp)
	bsr	eor_draw_line	;join up	
	movem.l (sp)+,d0-d3/a0

	rts



***********************************************
*****	DESTROY WINDOW                    *****
***********************************************
destroy_window
	ifnd	hard_only
	bsr	own_the_blitter
	endc

*no need to send anything as it always destroys last window displayed

	move.l	a0,-(sp)
	bsr	delete_buttons
	move.l	(sp)+,a0


	move.l	window_list_ptr,a0
	move.l	-(a0),a1	;window_ptr
	move.l	-4(a0),current_window_ptr
	move.l	#$ffffffff,(a0)	;delete entry in list
	move.l	a0,window_list_ptr

	move.l	a1,a0

	move.l	#main_screen_struct,a1

	move.w	screen_x_size(a1),d3
	asr.w	#3,d3
	move.w	window_x_size(a0),d6	;calculate modulus for all
	asr.w	#3,d6
	sub.w	d6,d3


****restore background

	move.w	number_of_planes(a1),d7
	subq.w	#1,d7
	move.l	window_pointer(a0),a3
	move.l	window_start(a0),a2

	moveq	#0,d0		;reposition screen start for border
	move.w	screen_x_size(a1),d0
	asr.w	#3,d0
	mulu	#BORDER_Y,d0
	add.w	#BORDER_X/8,d0
	sub.l	d0,a2

restore_area_on_screen
	btst	#14,DMACONR(a6)
	bne.s	restore_area_on_screen
	move.l	a2,bltdpt(a6)
	move.l	a3,bltapt(a6)
	move.w	d3,bltdmod(a6)
	clr.w	bltamod(a6)
	move.w	#$09f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	moveq	#0,d0
	move.w	window_y_size(a0),d0
	asl.w	#6,d0
	move.w	window_x_size(a0),d1
	asr.w	#4,d1
	add.w	d1,d0
	move.w	d0,bltsize(a6)

	moveq	#0,d0
	move.w	window_x_size(a0),d0
	asr.w	#3,d0
	mulu	window_y_size(a0),d0
	add.l	d0,a3

	moveq	#0,d0
	move.w	screen_x_size(a1),d0
	asr.l	#3,d0
	mulu	screen_y_size(a1),d0
	add.l	d0,a2

	dbra	d7,restore_area_on_screen

****deallocate mem

	moveq	#0,d0
	move.w	window_x_size(a0),d0
	asr.w	#3,d0
	mulu	window_y_size(a0),d0
	mulu	number_of_planes(a1),d0
	
	move.l	window_pointer(a0),a1
	movem.l	a6,-(sp)
	move.l	EXEC,a6
	jsr	-210(a6)
	movem.l	(sp)+,a6

	subq.w	#1,window_count
	bne.s	windows_still_active
	move.w	#MAIN_BUTTON_SCREEN,current_frame
	move.w	#1,show_box
windows_still_active

FF2 	btst	#14,dmaconr(a6)
	bne.s	FF2
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts

	
MAX_NUM_WINDOWS EQU 9

BORDER_X	equ 16
BORDER_Y	equ 8

window_count	dc.w	0

window_list
	dc.l	$ffffffff
	ds.l	10

window_list_ptr
	dc.l	window_list

current_window_ptr
	dc.l	0
	rsreset
	

window_x_size rs.w 1		;multiple of 16
window_y_size rs.w 1
window_x   rs.w 1		;multiple of 16
window_y   rs.w 1
window_start  rs.l 1
window_pointer rs.l 1
window_name rs.b 1

	even
