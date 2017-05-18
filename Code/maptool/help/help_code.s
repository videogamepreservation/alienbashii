**************************************
*** MAIN HELP MENU                ****
**************************************
main_help_menu
	move.b	#1,help_on
	move.l	#help_window,a0
	jsr	create_window
	
	move.l	#help_window,a0
	move.l	#main_help_options,a1
	move.w	#5,d0
	move.w	#0,d1
	move.w	#2,d2
	move.w	#1,d3
	jsr	write_text
	
	move.l	#main_help_button_list,a0
	jsr	display_button_list
	rts

**************************************
*** EDITOR HELP MENU              ****
**************************************
editor_help_menu

	rts
	
**************************************
*** SCANNER HELP MENU             ****
**************************************
scanner_help_menu

	rts
	
**************************************
*** RECOGNISE HELP MENU           ****
**************************************
recognise_help_menu

	rts
	
**************************************
*** MISC  HELP MENU               ****
**************************************
misc_help_menu

	rts
	
	
**************************************
*** EXIT MAIN MENU                ****
**************************************
exit_main_menu
	move.l	#main_help_button_list,a0
	jsr	remove_button_list
	jsr	destroy_window
	move.b	#0,help_on
	rts	
	

help_on
	dc.b	0
	EVEN
	
main_help_options
	dc.b $a
	dc.b "                      MAIN HELP MENU                      ",$a,$a,$a,$a
 	dc.b "                         EDITOR                           ",$a		
 	dc.b "                         SCANNER                          ",$a		
 	dc.b "                        RECOGNISE                         ",$a		
 	dc.b "                          MISC                            ",$a,-2,13		
 	dc.b "                          EXIT                            ",$a		
 	dc.b $a,$a,$a,-2,2
 	dc.b "       CLICK ON RELEVANT SUBJECT TITLE USING MOUSE        ",0
	EVEN
	

help_window
	dc.w 630
	dc.w 180
	dc.w 5
	dc.w 0
	dc.l 0
	dc.l 0
	dc.b "HELP WINDOW",0
	EVEN

main_help_button_list
	dc.l	editor_click,scanner_click,recognise_click,misc_click
	dc.l	exit_click
	dc.l	-1

editor_click
	dc.w	21*10
	dc.w	5*11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	help_click	;not used
	dc.l	0	;not used
	dc.l	editor_help_menu
	dc.b	0		
	EVEN						
	
scanner_click
	dc.w	21*10
	dc.w	6*11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	help_click	;not used
	dc.l	0	;not used
	dc.l	scanner_help_menu
	dc.b	0		
	EVEN						
	
recognise_click
	dc.w	21*10
	dc.w	7*11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	help_click	;not used
	dc.l	0	;not used
	dc.l	recognise_help_menu
	dc.b	0		
	EVEN							
	
misc_click
	dc.w	21*10
	dc.w	8*11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	help_click	;not used
	dc.l	0	;not used
	dc.l	misc_help_menu
	dc.b	0		
	EVEN								
	
exit_click
	dc.w	21*10
	dc.w	9*11
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	help_click	;not used
	dc.l	0	;not used
	dc.l	exit_main_menu
	dc.b	0		
	EVEN		
			
