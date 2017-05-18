SCROLL_HEIGHT	EQU 254-190

***********************************************
*****	SCAN IMAGE                        *****
***********************************************
scan_image

	cmp.w	#-1,direction
	beq.s	speed_up_move
	jsr	motor_sync
	bsr	read_resis
speed_up_move		
	bsr	step_scan_motor
	bsr	inc_position
	bsr	test_for_turn	
	rts
***********************************************
*****	MOTOR SYNC                        *****
***********************************************
motor_sync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	cmp.w	#$2c00,d0
	bne.s	motor_sync
	rts

***********************************************
*****	POSITION SCAN HEAD               *****
***********************************************

position_scan_head
	bsr	set_scan_motor_read_direction
	move.w	#10,d7
move_motor_away_from_sensor		
	jsr	sync
	bsr	step_scan_motor
	dbra	d7,move_motor_away_from_sensor		
	
	bsr	set_scan_motor_rewind_direction
	move.w	#0,d7
find_sensor_touch
	add.w	#1,d7
	cmp.w	#PIXEL_WIDTH*2,d7		;should find button by then
	beq.s	error_scanner_not_attached	
	jsr	sync
	bsr	step_scan_motor
	bsr	check_joy
	cmp.w	#0,d0
	beq.s	find_sensor_touch		
	bsr	set_scan_motor_read_direction	
	moveq	#1,d0
	rts
error_scanner_not_attached	
	moveq	#0,d0
	
	rts

***********************************************
*****	CHECK JOY                        *****
***********************************************
	
check_joy
	move.l	#0,d0
	move.b	$bfe101,d1
	btst	#4,d1
	beq.s	quit_check_joy
	move.l	#1,d0
quit_check_joy
	rts


***********************************************
*****	TEST FOR TURN                    *****
***********************************************

test_for_turn
	
	cmp.w	#0,line_pos
	ble.s	flip_direc
	cmp.w	#(PIXEL_WIDTH)-1,line_pos
	bge.s	flip_direc
	bra.s	quit_test_turn
flip_direc
	
	cmp.w	#1,direction
	bne.s	test2
	bsr	set_scan_motor_read_direction
	bra.s	no_way
test2
	bsr	set_scan_motor_rewind_direction
no_way	

quit_test_turn
	
	rts




***********************************************
*****	SET UP PARALLEL PORT             *****
***********************************************

set_up_parallel_port	
	move.b	#$ef,$bfe301
	rts
		
***********************************************
*****	SET SCAN MOTOR REWIND DIRECTION  *****
***********************************************
set_scan_motor_rewind_direction

	move.b	motor_bits,d0
	bset.l	#1,d0
	move.b	d0,motor_bits
	rts
	
***********************************************
*****	SET PAPER REWIND                 *****
***********************************************
set_paper_rewind

	move.b	motor_bits,d0
	bset.l	#3,d0
	move.b	d0,motor_bits
	rts
	
***********************************************
*****	SET SCAN MOTOR READ DIRECTION    *****
***********************************************
set_scan_motor_read_direction
	move.b	motor_bits,d0
	bclr.l	#1,d0
	move.b	d0,motor_bits
	rts
	
***********************************************
*****	SET PAPER FEED                   *****
***********************************************
set_paper_feed

	move.b	motor_bits,d0
	bclr.l	#3,d0
	move.b	d0,motor_bits
	rts
	
***********************************************
*****	STEP SCAN MOTOR                  *****
***********************************************
step_scan_motor

	move.b	motor_bits,d0
	bset.l	#0,d0	;high trigger for mot 1
	move.b	d0,$bfe101
	bsr	motor_pause
	bclr.l	#0,d0	;low trigger for mot 1
	move.b	d0,$bfe101
	bsr	motor_pause
	rts
	
***********************************************
*****	STEP PAPER FEED MOTOR            *****
***********************************************
step_paper_feed_motor
	move.b	motor_bits,d0
	bset.l	#3,d0
	move.b	d0,motor_bits
	move.w	#4,d1
buxom_wench
	move.b	motor_bits,d0
	bclr.l	#2,d0	;high trigger for mot 2
	move.b	d0,$bfe101
	bsr	motor_pause
	bset.l	#2,d0	;low trigger for mot 2
	move.b	d0,$bfe101
	bsr	motor_pause
	dbra	d1,buxom_wench

	rts

***********************************************
*****	MOVE PAPER                        *****
***********************************************
move_paper
	cmp.b	#1,call_scan_routine
	beq.s	quit_move_paper
	move.l	clicked_button,a0
	cmp.b	#0,button_data(a0)
	beq.s	motor_forward
	move.b	motor_bits,d0
	bclr.l	#3,d0
	move.b	d0,motor_bits
	bra.s	pulse_motor
motor_forward
	move.b	motor_bits,d0
	bset.l	#3,d0
	move.b	d0,motor_bits
pulse_motor
	move.w	#50,d2
move_paper_man
	move.b	motor_bits,d0
	bset.l	#2,d0	;high trigger for mot 2
	move.b	d0,$bfe101
	bsr	motor_pause
	bclr.l	#2,d0	;low trigger for mot 2
	move.b	d0,$bfe101
	bsr	motor_pause
	dbra	d2,move_paper_man
quit_move_paper
	rts
	
***********************************************
*****	   MOTOR PAUSE                    *****
***********************************************	
motor_pause
	move.l	d0,-(sp)
	move.w	#1000,d0
motor_wait
	dbra	d0,motor_wait
	move.l	(sp)+,d0
	rts
			
************************************************
*****	INC POSITION                      *****
************************************************
inc_position
	cmp.w	#1,direction
	beq.s	scan_forward
	bsr	check_joy
	cmp.w	#1,d0
	bne.s	no_sensor_hit
	move.w	#0,line_pos
	bra.s	reverse_direction
no_sensor_hit	
	cmp.w	#0,line_pos
	ble.s	quit_inc_position
	sub.w	#1,line_pos
	bra.s	quit_inc_position
scan_forward
	cmp.w	#(PIXEL_WIDTH)-1,line_pos
	bge	reverse_direction
	add.w	#1,line_pos
	bra	quit_inc_position
reverse_direction	
	neg	direction
	tst	direction
	bmi	arrrg
	bsr	move_down_line
arrrg	
quit_inc_position
	rts
************************************************
*****	MOVE DOWN LINE                    *****
************************************************
move_down_line
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.l	#3,d0
	add.l	d0,screen_position
	bsr	step_paper_feed_motor
	rts

************************************************
*****	START SCANNING                     *****
************************************************
start_scanning
	bsr	setup_grey_colours
	bsr	position_scan_head
	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),screen_position
	move.b	#1,call_scan_routine
	rts

************************************************
*****	STOP SCANNING                     *****
************************************************
stop_scanning
	move.b	#0,call_scan_routine
	bsr	setup_screen_colours
	rts


***********************************************
*****	READ RESIS                       *****
***********************************************


read_resis
	moveq	#0,d0
	move.b	resistance,d0
	bsr	draw_pixel
	rts


************************************************
*****	DRAW PIXEL                         *****
************************************************

draw_pixel
	tst	direction
	bpl	draw
	rts
draw	
*send in bit value to d0
	move.l	screen_position,a0
	moveq	#0,d1
	move.w	line_pos,d1
	move.w	d1,d2
	andi.w	#$0007,d2
	asr	#3,d1
	add.l	d1,a0
	move.w	#7,d1
	sub.w	d2,d1
        cmp.w    #15,d0
        ble.s    gogo
        move.w   #15,d0
gogo
	moveq	#0,d4
draw_in_colour
	btst	d4,d0
	beq.s	clear_the_pixel
	bset.b	d1,(a0)			
	bra.s	do_rest_planes
clear_the_pixel	
	bclr.b	d1,(a0)
do_rest_planes	
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d2
	asr.w	#3,d2
	mulu	screen_y_size(a1),d2
	add.l	d2,a0
        addq.w #1,d4
	cmp.w	#4,d4
	bne.s	draw_in_colour
	rts


***********************************************
*****	SCROLL SCREEN UP                  *****
***********************************************
scroll_screen_up
	cmp.w	#0,scroll_position
	beq.s	do_not_scroll_up
	subq.w	#2,scroll_position
	moveq	#0,d0
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#2,d0
	sub.l	d0,screen_mem(a0)
	bsr	put_planes_in_copper
do_not_scroll_up
	rts

***********************************************
*****	SCROLL SCREEN DOWN                *****
***********************************************
scroll_screen_down
	cmp.w	#SCROLL_HEIGHT,scroll_position
	beq.s	do_not_scroll_down
	addq.w	#2,scroll_position
	moveq	#0,d0
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#2,d0
	add.l	d0,screen_mem(a0)
	bsr	put_planes_in_copper
do_not_scroll_down
	rts

scroll_position
	dc.w	0

line_pos
	dc.w	0

direction	
	dc.w	1

resistance
	dc.w 0

screen_position
	dc.l	0

call_scan_routine
	dc.b	0
	EVEN
motor_bits
	dc.b	0
	EVEN

	
