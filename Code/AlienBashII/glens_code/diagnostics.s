
*Diagnostic routine - use panel

***************************************************
*********             WRITE NUM         ***********
***************************************************
write_num
	moveq	#0,d1
	move.w	#1000,d1	;start divide value
number_loop
	divu.w	d1,d0		;divide d0 by d1
	move.l	#panel_font,a1
	move.w	d0,d3
	addq.w	#2,d3
	mulu	#7*2,d3
	add.l	d3,a1		;gets along position of number
	move.w	#7-1,d2
	move.l	a0,a2
draw_num_loop		
	move.b	(a1),(a2)
	add.l	#PANEL_WIDTH,a2
	addq.l	#2,a1
	dbra	d2,draw_num_loop
	addq.l	#1,a0
	move.w	#0,d0
	swap	d0	;get remainder to lower word
	cmp.w	#1,d1
	beq.s	quit_number_routine
	divu	#10,d1		;divide dividor
	bra	number_loop
quit_number_routine	
	rts

output_x_val
	movem.l	d0-d7/a0-a6,-(sp)
	moveq	#0,d0
	move.l	#panel_graphics,a0
	move.w	check_x_add,d0
	bpl	dont_neg_x
	neg	d0
	add.w	#100,d0
dont_neg_x	
	bsr	write_num
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	
output_y_val
	movem.l	d0-d7/a0-a6,-(sp)
	moveq	#0,d0
	move.l	#panel_graphics+10,a0
	move.w	check_y_add,d0
	bpl.s	dont_neg_y
	neg	d0
	add.w	#100,d0
dont_neg_y		
	bsr	write_num
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
	
output_yscroll_pos
	movem.l	d0-d7/a0-a6,-(sp)
	
	moveq	#0,d0
	move.l	#panel_graphics+21,a0
	move.w	scroll_y_position,d0
	bsr	write_num
	movem.l	(sp)+,d0-d7/a0-a6	
	rts

	
output_xscroll_pos
	movem.l	d0-d7/a0-a6,-(sp)
	
	moveq	#0,d0
	move.l	#panel_graphics+16,a0
	move.w	scroll_x_position,d0
	bsr	write_num
	

	movem.l	(sp)+,d0-d7/a0-a6	
	rts	