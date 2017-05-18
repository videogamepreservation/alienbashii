**************************************
*** DRAW SLICE LINE                ***
**************************************
Draw_Slice_Line
*send x1,y1,x2,y2 in d0,d1,d2,d3
*bitmap in a0

	ext.l	d0
	ext.l	d1
*make copies	
	move.w	d0,d4
	move.w	d1,d5
	move.w	#-1,d7
		
	sub.w	d2,d0	;deltax
	beq	draw_horiz_line
	bpl.s	do_y		;is line going left to right
	neg.w	d0	;make deltax positive		
	move.w	#1,d7	;xinc
do_y
	sub.w	d3,d1	;deltay
	beq	draw_vert_line
	bmi.s	line_going_down
	neg.w	d7	;neg xinc
	move.w	d2,d4	;swap x start value
	move.w	d3,d5	;swap y start value
	bra.s	test_major	
line_going_down	
	neg.w	d1	;make y delta positive
test_major

*Calculate start position in bitmap
	mulu	#BPR,d5
	move.w	d4,d6
	lsr.w	#3,d6
	add.w	d6,d5
	add.l	d5,a0		;start pos
	andi.w	#$7,d4		;start pixel pos
	move.w	#$80,d6
	lsr	d4,d6		;get pixel pos
	move.w	d6,d4	
	
	cmp.w	d1,d0
	blt.s	y_major
x_major	
	move.w	d7,d5		;x inc

*get x step value
	divu	d1,d0		;divide deltax by deltay
	move.w	d1,d7
	move.w	d0,d2		;get x step value
	subq.w	#1,d2
	swap	d0		;error step
	move.w	d1,d3
	lsr	d3		;error value
	neg	d3
	subq.w	#1,d1
	
x_delta_loop		
	move.w	d2,d6		;loop value
	add.w	d0,d3
	blt.s	x_step_loop
	addq.w	#1,d6		;extra pixel
	sub.w	d7,d3		;reset error value
x_step_loop	
	or.b	d4,(a0)		;set pix
	tst.w	d5		;test x_direc
	bmi.s	xgoing_left	
	ror.b	d4
	bge.s	dont_inc_x_byte1
	addq.l	#1,a0
dont_inc_x_byte1	
	dbra	d6,x_step_loop
	add.l	#BPR,a0
	dbra	d1,x_delta_loop
	rts
xgoing_left
	rol.b	d4
	bcc.s	dont_dec_x_byte1
	subq.l	#1,a0
dont_dec_x_byte1		
	dbra	d6,x_step_loop
	add.l	#BPR,a0
	dbra	d1,x_delta_loop
	rts
	
y_major		
	move.w	d7,d5	;get x inc

*get x step value
	divu	d0,d1		;divide deltay by deltax
	move.w	d0,d7
	move.w	d1,d2		;get x step value
	subq.w	#1,d2
	swap	d1		;error step
	move.w	d0,d3
	lsr	d3		;error value
	neg	d3
	subq.w	#1,d0		
	
y_delta_loop		
	move.w	d2,d6		;loop value
	add.w	d1,d3
	blt.s	y_step_loop
	addq.w	#1,d6		;extra pixel
	sub.w	d7,d3		;reset error value
y_step_loop	
	or.b	d4,(a0)
	add.l	#BPR,a0
	dbra	d6,y_step_loop
	tst	d5
	bmi.s	xgoing_left_y
	ror.b	d4
	bge.s	dont_inc_x_byte
	addq.l	#1,a0
dont_inc_x_byte	
	dbra	d0,y_delta_loop
	rts
xgoing_left_y
	rol.b	d4
	bcc.s	dont_dec_x_byte
	subq.l	#1,a0
dont_dec_x_byte	
	dbra	d0,y_delta_loop
	rts		
	
draw_horiz_line
	rts
draw_vert_line
	rts
