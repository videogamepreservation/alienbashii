
display_scanner_buttons
	move.l	#top_level_list,a0
	bsr	remove_button_list

	move.l	#scan_button_list,a0
	bsr	display_button_list

	rts

remove_scanner_buttons
	bsr	stop_scanning
	move.l	#scan_button_list,a0
	bsr	remove_button_list

	move.l	#top_level_list,a0
	bsr	display_button_list


	rts

*****SCAN BUTTONS



scan_music
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	start_scanning
	dc.b	"SCAN MUSIC",0		
	EVEN						

stop_scan
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	stop_scanning
	dc.b	"STOP SCAN",0		
	EVEN						

save_image
	dc.w	BUTTON_5
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	save_pic
	dc.b	"SAVE IMAGE",0		
	EVEN						

paper_feed
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	move_paper
	dc.b	"PAPER FEED",0		
	EVEN						

paper_reverse
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	move_paper
	dc.b	"PAPER REV.",0		
	EVEN						

exit_scan
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0	
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	remove_scanner_buttons
	dc.b	"EXIT",0		
	EVEN	

scroll_up
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up	;not used
	dc.l	0	;not used
	dc.l	scroll_screen_up
	dc.b	0		
	EVEN						

scroll_down
	dc.w	BUTTON_4
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down	;not used
	dc.l	0	;not used
	dc.l 	scroll_screen_down
	dc.b	0		
	EVEN						

scan_button_list
	dc.l	save_image,scan_music
	dc.l	scroll_down,scroll_up
	dc.l	exit_scan,stop_scan,paper_feed,paper_reverse
	dc.l	$ffffffff

