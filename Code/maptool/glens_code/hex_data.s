hex_button_list
	dc.l	scroll_hex_up_button,scroll_hex_down_button
	dc.l	hex_quit_button,-1

scroll_hex_up_button
	dc.w	BUTTON_1
	dc.w	130
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up	;not used
	dc.l	0	;not used
	dc.l	scroll_window_up
	dc.b	0		
	EVEN						

scroll_hex_down_button
	dc.w	BUTTON_1+25
	dc.w	130
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down	;not used
	dc.l	0	;not used
	dc.l	scroll_window_down
	dc.b	0		
	EVEN						

hex_quit_button
	dc.w	BUTTON_1+50
	dc.w	130
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button  ;not used
	dc.l	0	;not used
	dc.l	quit_hex_routine
	dc.b	0		
	EVEN						
