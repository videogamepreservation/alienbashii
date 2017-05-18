 

***************************************************
**** SET COLOUR           *************************
***************************************************
set_colour

*send long word with colour in d0 e.g $00ffee55
*send address's in a0 and a1 - thinks copper done like:
*	dc.w	$106
*	dc.w	0
*	dc.w	$180	- a0
*	dc.w	0
*	dc.w	$182
*	dc.w	0
*	dc.w	etc
*
*	dc.w	$106
*	dc.w	0
*	dc.w	$180	- a1
*	dc.w	0	
*	dc.w	$182
*	dc.w	0
*	dc.w	etc
*


	moveq	#0,d2
	moveq	#0,d3
	
	bfextu	d0{8:4},d1	;get high word
	bfins	d1,d2{20:4}
	
	bfextu	d0{16:4},d1
	bfins	d1,d2{24:4}
	
	bfextu	d0{24:4},d1
	bfins	d1,d2{28:4}


	bfextu	d0{12:4},d1	;get low word
	bfins	d1,d3{20:4}
	
	bfextu	d0{20:4},d1
	bfins	d1,d3{24:4}
	
	bfextu	d0{28:4},d1
	bfins	d1,d3{28:4}


	move.w	d2,2(a0)
	move.w	d3,2(a1)
	rts

***************************************************
****  FADE COLOUR         *************************
***************************************************
fade_colour
*send colour to fade in d0
*returns in d0

	move.w	#3-1,d2
	move.l	#$000001,d3
	move.l	#$0000ff,d4
fade_the_colour
	move.l	d0,d1
	and.l	d4,d1
	beq.s	already_at_zero
	sub.l	d3,d0
already_at_zero
	asl.l	#8,d3
	asl.l	#8,d4
	dbra	d2,fade_the_colour
	rts
	
	
***************************************************
****  COPY FADE COLOURS   *************************
***************************************************
*send list 1 in a0 and list 2 in a1 and num in d0
copy_fade_colours

	subq.w	#1,d0
copy_fades_loop
	move.l	(a0)+,(a1)+
	dbra	d0,copy_fades_loop		
	rts
		
***************************************************
****  FADE LIST           *************************
***************************************************
fade_list
*send colour list in a2
*send in copper list hi and low mem start points in a0 and a1
*send no of colours to fade in d0
				
	subq.w	#1,d0
	move.w	d0,d7
fade_the_list	
	move.l	(a2),d0
	bsr	fade_colour
	move.l	d0,(a2)+
	
	movem.l	a0-a2,-(sp)
	bsr	set_colour
	movem.l	(sp)+,a0-a2
	
	addq.l	#4,a0
	addq.l	#4,a1		
	dbra	d7,fade_the_list
	rts


***************************************************
****  SET COLOUR LIST     *************************
***************************************************
set_colour_list			

*send in list in a2
*send copper hi and low start in a0 and a1
*send number in d0

	subq.w	#1,d0
	move.w	d0,d7
set_colour_list_loop
	move.l	(a2)+,d0
	bsr	set_colour		
	addq.l	#4,a0
	addq.l	#4,a1
	dbra	d7,set_colour_list_loop
	rts


***************************************************
****  SET COLOUR MAP      *************************
***************************************************
set_colour_map
*send in dpaint aga colour data in a2
*send address of mem to copy data into to create colour list in a3
* send 0 in a3 if not wanted
*send copper hi and low in a0 and a1

			
	tst	a3
	bne.s	have_sent_colour_area	
	move.l	#colour_area,a3
have_sent_colour_area	

	move.l	a3,a4		;store start location	
	add.l	#44,a2	
	move.l	(a2)+,d0
	divu	#3,d0	;number of colours
	move.w	d0,d7
	subq.w	#1,d0
set_up_colour_list
	moveq	#0,d2
	or.b	(a2)+,d2
	asl.l	#8,d2
	or.b	(a2)+,d2
	asl.l	#8,d2
	or.b	(a2)+,d2
	move.l	d2,(a3)+
	dbra	d0,set_up_colour_list	
	
*	move.w	#31,d0
*	sub.w	d7,d0
*clear_remaining_colours
*	clr.l	(a3)+
*	dbra	d0,clear_remaining_colours

	move.l	a4,a2
	move.w	d7,d0
	bsr	set_colour_list	
	rts
			
	
colour_area
	ds.l	32