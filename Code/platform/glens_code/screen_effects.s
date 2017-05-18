

********************************************
*******          NULL ROUTINE           ****
********************************************
null_routine
	rts


********************************************
******   CYCLE COLOURS                 *****
********************************************
cycle_colours
	
	moveq	#0,d0
	subq.w	#1,colour_timer
	bne.s	dont_cycle_colours
	move.w	#6,colour_timer

	subq.w	#1,colour_cycle_number
	cmp.w	#-1,colour_cycle_number
	bne.s	not_reached_max_colour
	move.w	#4,colour_cycle_number
not_reached_max_colour

	move.l	#colour_cycle_table,a0
	move.w	colour_cycle_number,d0
	asl.w	#2,d0
	add.l	d0,a0
	move.l	#front_scroll_colours_high+6,a1
	move.l	#front_scroll_colours_low+6,a2
	move.w	#NUM_COLOURS-1,d0
cycle_colours_loop
	move.w	(a0)+,(a1)
	move.w	(a0)+,(a2)
	
	addq.l	#4,a1
	addq.l	#4,a2
	
	dbra	d0,cycle_colours_loop
	
dont_cycle_colours
	rts


NUM_COLOURS	EQU	5


colour_cycle_number
	dc.w	4
	
colour_timer
	dc.w	6	

colour_cycle_table

	dc.w $8af,$17f
	dc.w $68f,$fff
	dc.w $57f,$d7f
	dc.w $45f,$aef
	dc.w $33f,$7ff
	
	dc.w $8af,$17f
	dc.w $68f,$fff
	dc.w $57f,$d7f
	dc.w $45f,$aef
	
	
	