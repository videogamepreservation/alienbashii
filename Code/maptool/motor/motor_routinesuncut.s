RES_BYTES	equ	80
RES_HEIGHT	equ	256


PLANE_HEIGHT	equ	256
PIXEL_WIDTH	equ	480
BYTES_PER_ROW	equ 	PIXEL_WIDTH/8




***********************************************
*****	MAINROUTINE                      *****
***********************************************


mainroutine
	cmp.w	#-1,direction
	beq.s	speed_up_move
	bsr	sync
	bsr	read_resis
speed_up_move		
	bsr	check_to_see_hit
	bsr	readmouse
	bsr	position_screen
	bsr	step_scan_motor
	bsr	inc_position
	bsr	test_for_turn
	btst	#10,$dff016
	bne.s	no_save
	bra	save_the_pic
	
no_save	
	btst	#6,$bfe001
         bne      mainroutine
         bra	no_savey
save_the_pic         
         bsr	save_pic
no_savey         
       	rts


***********************************************
*****	POSITION SCAN HEAD               *****
***********************************************

position_scan_head
	bsr	set_scan_motor_read_direction
	move.w	#10,d7
move_motor_away_from_sensor		
	bsr	sync
	bsr	step_scan_motor
	dbra	d7,move_motor_away_from_sensor		
	
	bsr	set_scan_motor_rewind_direction
	move.w	#0,d7
find_sensor_touch
	add.w	#1,d7
	cmp.w	#PIXEL_WIDTH*2,d7		;should find button by then
	beq.s	error_scanner_not_attached	
	bsr	sync
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
	moveq	#0,d0
	move.w	$bfe101,d1
	btst	#3,d1
	beq.s	no_click
	moveq	#1,d0
	bra	quit_check_joy
no_click
	moveq	#0,d0
quit_check_joy
	rts

***********************************************
*****	READ RESIS                       *****
***********************************************


read_resis
	moveq	#0,d0
	move.b	resistance,d0
	move.l	backscr2,a0
	add.l	#150*BYTES_PER_ROW,a0
	bsr	draw_pixel
	rts


***********************************************
*****	SAVE PIC                         *****
***********************************************

save_pic
	move.l	exec,a6			; use our label
	jsr	-138(a6)			; enable system tasking
	
	MOVE.L	#graf_name,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		; OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4
	MOVE.L	#$DFF000,A6
	MOVE.L	38(A4),COP1LCH(A6)	; GET SYSTEM COPPER
	CLR.W	COPJMP1(A6)		
	bsr	open_file
	cmp.l	#0,d0
	beq.s	no_save_the_file
	bsr	write_file
	cmp.l	#0,d0
	beq.s	no_save_the_file
	bsr	close_file	
no_save_the_file	
	*move.l	exec,a6			; use our label
	*jsr	-132(a6)			; disable system tasking
	
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
*****	SET UP VARIABLES                 *****
***********************************************

set_up_variables
	move.l	backscr4,a0
	move.l	a0,screen_position
	move.w	#0,line_pos
	rts


***********************************************
*****	SET UP PARALLEL PORT             *****
***********************************************

set_up_parallel_port	
	move.b	#$ff,$bfe301
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
	moveq	#0,d0
	move.l	backscr2,a0
	add.l	#100*BYTES_PER_ROW,a0
	move.w	line_pos,d0

	move.b	motor_bits,d0
	bset.l	#0,d0	;high trigger for mot 1
	move.b	d0,$bfe101
	bsr	pause
	bclr.l	#0,d0	;low trigger for mot 1
	move.b	d0,$bfe101
	bsr	pause
	rts
	
***********************************************
*****	STEP PAPER FEED MOTOR            *****
***********************************************
step_paper_feed_motor
	moveq	#0,d0
	move.l	backscr2,a0
	add.l	#50*BYTES_PER_ROW,a0
	move.w	line_pos,d0
	move.b	motor_bits,d0
	bset.l	#2,d0	;high trigger for mot 2
	move.b	d0,$bfe101
	bsr	pause
	bclr.l	#2,d0	;low trigger for mot 2
	move.b	d0,$bfe101
	bsr	pause
	rts

***********************************************
*****	MOVE PAPER                        *****
***********************************************
move_paper
	move.l	button_clicked,a0
	cmp.b	#0,button_data(a0)
	beq.s	motor_forward
	move.b	motor_bits,d0
	bclr.l	#1,d0
	move.b	d0,motor_bits
	bra.s	pusle_motor
motor_forward
	move.b	motor_bits,d0
	bset.l	#1,d0
	move.b	d0,motor_bits
pulse_motor
	moveq	#0,d0
	move.l	backscr2,a0
	add.l	#50*BYTES_PER_ROW,a0
	move.w	line_pos,d0
	move.b	motor_bits,d0
	bset.l	#2,d0	;high trigger for mot 2
	move.b	d0,$bfe101
	bsr	pause
	bclr.l	#2,d0	;low trigger for mot 2
	move.b	d0,$bfe101
	bsr	pause
	rts
	
***********************************************
*****	   PAUSE                         *****
***********************************************	
pause
	move.l	d0,-(sp)
	move.w	#1000,d0
wait
	dbra	d0,wait
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
*****	CHECK FOR BIT                     *****
************************************************	
check_for_bit
	move.b	$bfe001,d1
	btst	#$7,d1
	bne	bumtit
	moveq	#0,d0
	bra	large
bumtit
	moveq	#1,d0	
large	
	bsr	draw_pixel
	rts

************************************************
*****	MOVE DOWN LINE                    *****
************************************************
move_down_line
	add.l	#BYTES_PER_ROW,screen_position
	move.l	backscr4,a0
	add.l	#BYTES_PER_ROW*PLANE_HEIGHT,a0
	cmp.l	screen_position,a0
	bgt.s	not_end_bitmap
	move.l	backscr4,a0
	move.l	a0,screen_position
not_end_bitmap	
	bsr	step_paper_feed_motor
	rts

************************************************
*****	DRAW PIXEL                        *****
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
	
*	sub.w	#39,d0
*	move.w	#15,d4
*	sub.w	d0,d4
*	move.b	d4,d0

	sub.b	#60,d0
	asr.w	#4,d0
	move.w	#3,d4
draw_in_colour
	btst	d4,d0
	beq.s	clear_the_pixel
	bset.b	d1,(a0)			
	bra.s	do_rest_planes
clear_the_pixel	
	bclr.b	d1,(a0)
do_rest_planes	
	sub.l	#BYTES_PER_ROW*256,a0
	dbra	d4,draw_in_colour
	rts


************************************************
*****	POSITION SCREEN                   *****
************************************************
position_screen
	move.w	mousex_inc,d3
	add.w	d3,scrollx_position
	
	move.w	mousey_inc,d3
	add.w	d3,scrolly_position

	cmp.w	#0,scrolly_position
	bge.s	lowy_bound_ok	
	move.w	#0,scrolly_position
lowy_bound_ok	

	cmp.w	#(PLANE_HEIGHT-RES_HEIGHT),scrolly_position
	ble.s	highy_bound_ok
	move.w	#(PLANE_HEIGHT-RES_HEIGHT),scrolly_position
	
highy_bound_ok	
	cmp.w	#0,scrollx_position
	bge.s	low_bound_ok
	move.w	#0,scrollx_position
low_bound_ok	
	cmp.w	#(BYTES_PER_ROW-RES_BYTES)*8,scrollx_position
	ble.s	high_bounds_ok
	move.w	#(BYTES_PER_ROW-RES_BYTES)*8,scrollx_position
high_bounds_ok	
	
	moveq	#0,d1
	moveq	#0,d0
	move.w	scrollx_position,d0
*asr d0 as in high res increase scroll values 2 at a time 
*so an increase of 1 pixel = 2 pixels
	asr.w	#1,d0
	move.w	d0,d1
	andi.w	#$0007,d0	;pixel shift
	andi.w	#$fff8,d1
	asr.w	#2,d1		;words shifted
	
	moveq	#0,d2
	move.w	scrolly_position,d2
	asr.w	#1,d2		;cos high res increase by 2
	mulu	#BYTES_PER_ROW,d2
	add.l	d2,d1
	
	move.l	backscr1,d2
	move.l	backscr2,d3
	move.l	backscr3,d4
	move.l	backscr4,d5
	
	add.l	d1,d2
	add.l	d1,d3
	add.l	d1,d4
	add.l	d1,d5
	
	move.w	d0,d1
	move.w	#15,d0
	sub.w	d1,d0
	move.w	d0,d1
	rol.w	#4,d1
	or.w	d1,d0
	move.w	d0,scroll_value
	
	MOVE.W	D2,PLANELOW
	SWAP	D2
	MOVE.W	D2,PLANEHIGH

	MOVE.W	D3,PLANE2LOW
	SWAP	D3
	MOVE.W	D3,PLANE2HIGH

	MOVE.W	D4,PLANE3LOW
	SWAP	D4
	MOVE.W	D4,PLANE3HIGH
	
	MOVE.W	D5,PLANE4LOW
	SWAP	D5
	MOVE.W	D5,PLANE4HIGH
		
	rts


open_file
**file name in d1
	move.l	#file_name,d1
	move.l	#mode_new,d2
	move.l	dos_handle,a6
	jsr	open(a6)
	beq.s	no_file_opened
	move.l	d0,file_ptr	
no_file_opened	
	rts
	
write_file
	move.l	file_ptr,d1
	move.l	backscr1,d2
	move.l	#(BYTES_PER_ROW*256)*4,d3
	move.l	dos_handle,a6
	jsr	write(a6)	
	rts
	
close_file
	move.l	dos_handle,a6
	move.l	file_ptr,d1
	jsr	close(a6)	
	rts
	
write_string
*send data in d2
*send length in d3
	movem.l d1-d3/a0,-(sp)
	move.l printer_handle,d1
	move.l dos_handle,a0
	jsr write(a0)       
	movem.l (sp)+,d1-d3/a0
	rts



last_mousex	dc.w	0
last_mousey	dc.w	0
scrollx_position	dc.w	0
scrolly_position	dc.w	0
mousex_inc	dc.w	0
mousey_inc	dc.w	0
line_pos dc.w 0	



current_task dc.l 0
dos_handle dc.l 0
printer_handle dc.l 0
printer_count dc.w 0
screen_position dc.l 0
direction	dc.w	1
direc		dc.w	-1
resistance	dc.b	0
		EVEN
file_ptr	dc.l	0

motor_bits
	dc.b	0
	EVEN
dos_name dc.b "dos.library",0
	even 
file_name dc.b "df1:piccy.pic",0
	EVEN	
	
