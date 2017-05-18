load_music_button
	dc.w	BUTTON_5
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	change_colour
	dc.b	"LOAD MUSIC",0		
	EVEN						
