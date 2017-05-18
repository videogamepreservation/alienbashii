***************************************
****** CHECK KILL                ******
***************************************
check_kill

	bsr	set_original_colours
	move.l	#check_window,a0
	bsr	create_window
	
	move.l	#check_button_list,a0
	bsr	display_button_list
	
	move.l	#check_window,a0
	move.l	#check_text,a1
	moveq	#50,d0
	moveq	#20,d1
	moveq	#2,d2
	move.w	#1,d3
	bsr	write_text

	rts
	
***************************************
****** REMOVE CHECK KILL        ******
***************************************
remove_check_kill

	move.l	#check_button_list,a0
	bsr	remove_button_list

	move.l	#check_window,a0
	bsr	destroy_window
	
	bsr	set_current_page_colours
	rts

	
***************************************
****** KILL WINDOW AND SYSTEM   ******
***************************************
kill_window_and_system

	bsr	remove_check_kill
	bsr	kill_system
	rts
	
	
	
	
check_window
	dc.w 240
	dc.w 44+32
	dc.w 40
	dc.w 80
	dc.l 0
	dc.l 0
	dc.b "CHECK",0
	
	EVEN

check_text
	dc.b	"Are you sure?",0
	EVEN

check_button_list
	dc.l	check_ok_button,check_cancel_button,-1

check_ok_button
	dc.w	40-16
	dc.w	THIRD_ROW+10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
	dc.l	kill_window_and_system
	dc.b	0		
	EVEN						

check_cancel_button
	dc.w	160-32
	dc.w	THIRD_ROW+10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
	dc.l	remove_check_kill
	dc.b	0		
	EVEN		
