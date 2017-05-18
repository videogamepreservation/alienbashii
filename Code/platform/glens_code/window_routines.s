
WINDOW_Y		EQU	(256-WINDOW_HEIGHT)/2
WINDOW_X		EQU	4*16
WINDOW_START_X	EQU	64+5
WINDOW_START_Y	EQU	WINDOW_Y+3
MAX_LETTERS	EQU	20



***************************************************
*******  CHARACTER SPEAK                     ******	
***************************************************
	
character_speak
*send struct pointer in d4
	
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$dff000,a6
	move.l	d4,-(sp)
	move.w	#Sound_cowbell,sound_chan1
	bsr	sound_effects
	bsr	pause
	move.w	#0,fire
	bsr	sync
	move.l	(sp)+,d4
	move.l	d4,a0	
	bsr	start_script
	movem.l	(sp)+,d0-d7/a0-a6
	rts		


**********************************************************
*****             START SCRIPT                      ******
**********************************************************
start_script
*send pointer to script in a0

	move.w	#DO_TEXT,window_status
	move.l	a0,script_pointer
	bsr	main_script_routine
	rts


**********************************************************
*****             MAIN SCRIPT ROUTINE               ******
**********************************************************
main_script_routine

	move.l	script_pointer,a0
	move.w	(a0)+,d0
	move.l	a0,script_pointer
	
	move.l	#window_procs,a1
	move.l	(a1,d0.w*4),a1
	jsr	(a1)	;call routine
	cmp.w	#QUIT_TEXT,window_status
	bne.s	main_script_routine	
	rts


**********************************************************
*****             DISPLAY TEXT WINDOW               ******
**********************************************************
display_text_window
*send in x and y in d2 and d3
*send plane to draw into in a0
*send back area in a1
*window_start pos pointer in a2

	move.w	#4-1,d1
	moveq	#0,d0
	move.w	screen_y_position,d0
	add.w	d3,d0
	move.w	d0,current_window_y
	addq.w	#3,current_window_y
	asl	#6,d0
	add.l	d0,a0
	ext.l	d2
	add.w	screen_x_position,d2
	andi.w	#$fff0,d2
	move.w	d2,current_window_x
	addq.w	#5,current_window_x
	asr.w	#3,d2
	add.l	d2,a0
	move.l	a0,(a2)
	


save_window_background
	btst	#14,DMACONR(a6)
	bne.s	save_window_background
	
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	

	move.l	a1,bltdpth(a6)
	move.l	a0,bltapth(a6)
	move.w  #BYTES_PER_ROW-(WINDOW_WIDTH/8),bltamod(a6)
	move.w	#0,bltdmod(a6)
	move.w	#((WINDOW_HEIGHT)<<6)+(WINDOW_WIDTH/16),bltsize(a6)

	add.l	#BYTES_PER_ROW*HEIGHT,a0
	add.l	#WINDOW_HEIGHT*(WINDOW_WIDTH/8),a1
	dbra	d1,save_window_background
	

	move.w	#4-1,d1
	move.l	(a2),a0	;restore a0
	move.l	#textwindowgraphics+(WINDOW_HEIGHT*(WINDOW_WIDTH/8)*4),a1	;mask
	move.l	#textwindowgraphics,a2
	

display_window
	btst	#14,DMACONR(a6)
	bne.s	display_window
	
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$0fca0000,bltcon0(A6)	
	move.l	a1,bltapth(a6)
	move.l	a2,bltbpth(a6)
	move.l	a0,bltdpth(a6)
	move.l	a0,bltcpth(a6)
	move.w  #BYTES_PER_ROW-(WINDOW_WIDTH/8),bltdmod(a6)
	move.w  #BYTES_PER_ROW-(WINDOW_WIDTH/8),bltcmod(a6)
	move.w	#0,bltamod(a6)
	move.w	#0,bltbmod(a6)
	move.w	#((WINDOW_HEIGHT)<<6)+(WINDOW_WIDTH/16),bltsize(a6)


	add.l	#BYTES_PER_ROW*HEIGHT,a0
	add.l	#WINDOW_HEIGHT*(WINDOW_WIDTH/8),a2
	dbra	d1,display_window
	rts

**********************************************************
*****             REMOVE TEXT WINDOW                ******
**********************************************************
remove_text_window
*send window start pos in a0
*send buff area in a1

	move.w	#4-1,d1
	
remove_window
	btst	#14,DMACONR(a6)
	bne.s	remove_window
	
	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	

	move.l	a1,bltapth(a6)
	move.l	a0,bltdpth(a6)
	move.w  #BYTES_PER_ROW-(WINDOW_WIDTH/8),bltdmod(a6)
	move.w	#0,bltamod(a6)
	move.w	#((WINDOW_HEIGHT)<<6)+(WINDOW_WIDTH/16),bltsize(a6)

	add.l	#BYTES_PER_ROW*HEIGHT,a0
	add.l	#WINDOW_HEIGHT*(WINDOW_WIDTH/8),a1
	dbra	d1,remove_window

	rts
	
FONT_HEIGHT	EQU	11
	


**********************************************************
*****            DRAW TEXT                          ******
**********************************************************
draw_text

	moveq	#0,d0
	moveq	#0,d1
	
	move.w	current_window_x,d0
	move.w	current_window_y,d1
	move.l	text_pointer,a2	
	move.w	#0,d3	;x counter
add_letters_loop

	moveq	#0,d2
	move.b	(a2)+,d2
	beq.s	done_text
	cmp.b	#-1,d2
	beq.s	new_line
	cmp.b	#32,d2
	beq.s	dont_draw_letter
	movem.l	d0-d3/a2,-(sp)
	
	move.l	buffered_plane1,a0
	bsr	draw_letter	
	movem.l	(sp)+,d0-d3/a2
	
	movem.l	d0-d3/a2,-(sp)
	move.l	plane1,a0
	bsr	draw_letter
	
	move.w	#Sound_Click,sound_chan1
	bsr	sound_effects
	movem.l	(sp)+,d0-d3/a2
	
dont_draw_letter	
	add.w	#9,d0
	addq.w	#1,d3
	cmp.w	#MAX_LETTERS,d3
	blt.s	not_a_line
new_line	
	moveq	#0,d3
	move.w	current_window_x,d0
	add.w	#FONT_HEIGHT,d1
not_a_line	
	moveq	#3,d4
wait_loop	
	movem.l	d0-d1,-(sp)
	bsr	sync
	bsr	get_stick_readings
	movem.l	(sp)+,d0-d1
	tst	fire
	bne.s	skip_wait	
	dbra	d4,wait_loop
skip_wait	
	bra.s	add_letters_loop	
done_text	
	rts
	

**********************************************************
*****            DRAW LETTER                        ******
**********************************************************
draw_letter	
*send x and  in d0 and d1
*send letter in d2
*send plane pointer in a0	
	
	asl.w	#6,d1
	add.l	d1,a0
	moveq	#0,d1
	move.w	d0,d1
	andi.w	#$fff0,d0
	andi.w	#$000f,d1
	ror.l	#4,d1
	or.l	#$0d0c0000,d1
	asr.w	#3,d0
	add.l	d0,a0		;start position
	move.l	a0,a2
	
	move.l	#fontplane1,a1
	sub.w	#32,d2
	mulu	#(FONT_HEIGHT*2),d2
	add.l	d2,a1
	move.l	a1,a3
	
	move.w	#4-1,d0
clear_text	
	move.w	#4-1,d2
clear_font_area
	btst	#14,DMACONR(a6)
	bne.s	clear_font_area
	
	move.l	#$ffff0000,bltafwm(a6)
	move.l	d1,bltcon0(A6)	
	move.l	a1,bltapth(a6)	;font
	move.l	a0,bltdpth(a6)	;screen
	move.l	a0,bltbpth(a6)
	move.w  #BYTES_PER_ROW-4,bltdmod(a6)
	move.w  #BYTES_PER_ROW-4,bltbmod(a6)
	move.w	#-2,bltamod(a6)
	move.w	#((FONT_HEIGHT)<<6)+2,bltsize(a6)

	add.l	#FONT_SIZE,a1
	dbra	d2,clear_font_area
	move.l	a3,a1
	add.l	#BYTES_PER_ROW*HEIGHT,a0
	
	
	dbra	d0,clear_text
	
	
	andi.l	#$f0000000,d1
	or.l	#$0dfc0000,d1
	move.l	a3,a1	;font
	move.l	a2,a0	;screen
	
	
	move.w	#4-1,d0
draw_font_in_window
	btst	#14,DMACONR(a6)
	bne.s	draw_font_in_window
	
	move.l	#$ffff0000,bltafwm(a6)
	move.l	d1,bltcon0(A6)	
	move.l	a1,bltapth(a6)	;font
	move.l	a0,bltdpth(a6)	;screen
	move.l	a0,bltbpth(a6)	;screen
	move.w  #BYTES_PER_ROW-4,bltdmod(a6)
	move.w  #BYTES_PER_ROW-4,bltbmod(a6)
	move.w	#-2,bltamod(a6)
	move.w	#((FONT_HEIGHT)<<6)+2,bltsize(a6)

	add.l	#BYTES_PER_ROW*HEIGHT,a0
	add.l	#FONT_SIZE,a1
	
	dbra	d0,draw_font_in_window	
	
	rts
	
	
**********************************************************
*****         REMOVE WINDOW AND EXIT                ******
**********************************************************
remove_window_and_exit

	tst.w	window_up_flag
	beq.s	window_not_up
	move.l	window_start_pos,a0
	move.l	windowsavebackmem,a1
	bsr	remove_text_window
	move.l	window_start_pos_buff,a0
	move.l	windowsavebackmembuff,a1
	bsr	remove_text_window
	
window_not_up	
	move.w	#0,window_up_flag
	move.w	#QUIT_TEXT,window_status
	rts
	
**********************************************************
*****          REMOVE AND REDRAW WINDOW             ******
**********************************************************
remove_and_redraw_window

	tst.w	window_up_flag
	beq.s	not_already_up
	
	move.l	window_start_pos,a0
	move.l	windowsavebackmem,a1
	bsr	remove_text_window
	move.l	window_start_pos_buff,a0
	move.l	windowsavebackmembuff,a1
	bsr	remove_text_window

not_already_up
	
	move.l	script_pointer,a0
	moveq	#0,d2
	moveq	#0,d3
	move.w	(a0)+,d2
	move.w	(a0)+,d3	
	move.l	a0,script_pointer
	movem.l	d2-d3,-(sp)
	move.l	buffered_plane1,a0
	move.l	windowsavebackmem,a1
	move.l	#window_start_pos,a2
	bsr	display_text_window
	movem.l	(sp)+,d2-d3
	move.l	plane1,a0
	move.l	windowsavebackmembuff,a1
	move.l	#window_start_pos_buff,a2
	bsr	display_text_window
	move.w	#1,window_up_flag

	rts
	
**********************************************************
*****          SET WINDOW TALKER                    ******
**********************************************************
set_window_talker

	move.l	script_pointer,a0
	move.l	(a0)+,a1
	move.l	a0,script_pointer
	rts
	
	
**********************************************************
*****         PERFORM WINDOW EVENT                  ******
**********************************************************
perform_window_event
	
	move.l	script_pointer,a0
	move.l	(a0)+,a1
	move.l	a0,script_pointer
	jsr	(a1)
	rts
	
**********************************************************
*****          CHANGE WINDOW MUSIC                  ******
**********************************************************
change_window_music

	move.l	script_pointer,a0
	move.l	(a0)+,a1
	move.l	a0,script_pointer
*	bsr	change_music
	rts
	
**********************************************************
*****            SET WINDOW TEXT                    ******
**********************************************************
set_window_text
	move.l	script_pointer,a0
	move.l	(a0)+,text_pointer
	move.l	a0,script_pointer
	rts
	
**********************************************************
*****            DO DISPLAY TEXT                    ******
**********************************************************
do_display_text

	bsr	draw_text

	rts
	
DO_TEXT				EQU	0	
QUIT_TEXT			EQU	1	
	
window_status			dc.w	0	
window_start_pos		dc.l	0
window_start_pos_buff		dc.l	0
current_window_y		dc.w	0
current_window_x		dc.w	0		
window_up_flag			dc.w	0
script_pointer			dc.l	0



windowsavebackmem		dc.l	0		
windowsavebackmembuff		dc.l	0


*EMBEDDED WINDOW AND TEXT COMMANDS

WINDOW_DONE	EQU	0
WINDOW_POSITION	EQU	1	;followed by x and y words
WINDOW_TALKER	EQU	2	;followed by pointer to name
WINDOW_EVENT	EQU	3	;followed by routine to call
WINDOW_MUSIC	EQU	4	;followed by tune position
WINDOW_TEXT	EQU	5	;followed by pointer to text
WINDOW_GO	EQU	6	;start routine


window_procs
	dc.l	remove_window_and_exit
	dc.l	remove_and_redraw_window
	dc.l	set_window_talker
	dc.l	perform_window_event
	dc.l	change_window_music
	dc.l	set_window_text
	dc.l	do_display_text
	

*EMBEDED COMMANDS WHEN WRITING OUT TEXT

TEXT_DONE	EQU	0
TEXT_EVENT	EQU	1	;followed by byte which points to table
TEXT_WAIT_USER	EQU	2
TEXT_CLEAR	EQU	3		
	
*Example conversation list




Squiz_intro_script
	dc.w	WINDOW_POSITION
	dc.w	WINDOW_X,WINDOW_Y
*	dc.w	WINDOW_TALKER
*	dc.l	squiz_talker	
	dc.w	WINDOW_TEXT
	dc.l	hello_squiz
	dc.w	WINDOW_GO
	dc.w	WINDOW_DONE
	
		
squiz_talker
	dc.b	"SQUIZ",0
	EVEN	
	
text_pointer
	dc.l	hello_squiz	
		
hello_squiz
	dc.b	"  DARKLITE PRESENT  "
	dc.b    -1
	dc.b    "  --=S Q U I Z=--   "
	dc.b    -1
	dc.b    "        BY :-       "
	dc.b    -1
	dc.b    "  GLEN CUMMING AND  "
	dc.b    "     STUART LAW     ",TEXT_DONE
	even
	