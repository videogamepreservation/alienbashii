

********************************************
******** SCROLL SCREEN                ******
********************************************
scroll_screen
***when player in scroll box the velocitys of x and y
***shall be passed to this routine in d0 and d1

	add.w	d0,scroll_x_position
	add.w	d1,scroll_y_position


	rts
	
	
scroll_x_position
	dc.w	0
	
scroll_y_position
	dc.w	0	