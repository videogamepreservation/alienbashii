************************************************
*****	READ MOUSE                        *****
************************************************


readmouse
*updates mousex_inc and mousey_inc - it is done this way
*for total flexibility as it can be used to scroll the 
*screen or move an on screen pointer or be used to increase
*levels volume menu options etc etc

	moveq	#0,d0
	move.w	$dff00a,d0	;mouse port
	move.w	d0,d1
	andi.w	#$00ff,d1
	move.w	last_mousex,d3
	sub.w	d1,d3
	cmp.w	#127,d3
	blt.s	test_under
	add.w	#-255,d3
	bra.s	add_to_scrollx
test_under	
	cmp.w	#-127,d3
	bgt.s	add_to_scrollx
	add.w	#255,d3
add_to_scrollx
	neg.w	d3	
	move.w	d3,mousex_inc
test_sp_y		
	move.w	d1,last_mousex
	move.w	last_mousey,d3
	lsr.w	#8,d0
	sub.w	d0,d3
	
	cmp.w	#127,d3
	blt.s	test_under_y
	add.w	#-255,d3
	bra.s	add_to_scrolly
test_under_y	
	cmp.w	#-127,d3
	bgt.s	add_to_scrolly
	add.w	#255,d3
add_to_scrolly
	neg.w	d3
	move.w	d3,mousey_inc	
move_y_value
	move.w	d0,last_mousey
	
	move.w	mousex_inc,d0
	muls	sensativity,d0
	divs	#100,d0
	move.w	d0,mousex_inc
	
	move.w	mousey_inc,d0
	muls	sensativity,d0
	divs	#100,d0
	move.w	d0,mousey_inc
	
	rts         

last_mousex	dc.w	0
last_mousey	dc.w	0
mousex_inc	dc.w	0
mousey_inc	dc.w	0
mouse_x		dc.w	160
mouse_y		dc.w	100

sensativity	dc.w	100	;1 in other words

****************************************
******  GET STICK READINGS         *****
****************************************
get_stick_readings

	tst.w	edit_data_flag		;crap code
	bne.s	set_fire_up			;frigged for time

	cmp.w	#1,edit_mode
	bne	quit_scroll_joy
	
	move.w	#0,fire
	btst	#7,$bfe001
	bne.s	set_fire_up
	move.w	#1,fire
set_fire_up

	
	move.w	$dff00c,d0		;joy1dat
update_joy_values
	btst	#9,d0
	beq.s	tryleft
	move.w	#-1,xdirec
	bra	upanddown
tryleft	
	btst	#1,d0
	beq.s	movezero
	move.w	#1,xdirec
	bra.s	upanddown
movezero	
	move.w	#0,xdirec
upanddown
	move.w	d0,d1
	rol.w	#1,d0
	eor.w	d0,d1
	btst	#1,d1
	beq.s    tryup	
	move.w	#-1,ydirec	
	bra.s	quitjoyread
tryup
	btst	#9,d1
	beq.s	stop_y
	move.w	#1,ydirec
	bra.s quitjoyread
stop_y	
	move.w	#0,ydirec
quitjoyread

	tst	ydirec
	beq.s	testlr
	bpl.s	joy_scroll_up
	bsr	scroll_map_down
	bra.s	testlr
joy_scroll_up	
	bsr	scroll_map_up
testlr
	tst	xdirec
	beq.s	done_scroll_bits
	bpl.s	joy_scroll_right
	bsr	scroll_map_right
	bra.s	done_scroll_bits
joy_scroll_right
	bsr	scroll_map_left
done_scroll_bits
	tst	edit_data_flag
	beq.s	quit_scroll_joy
	jsr	display_alien_numbers
quit_scroll_joy			
		
	rts
	
fire  	 				dc.w	0
fire2					dc.w	0
xdirec 					dc.w	0
ydirec 					dc.w	0
