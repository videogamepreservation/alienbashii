************************************************
***** FADE OUT STARS		       *****
************************************************

fade_out_stars
	
	move.l	#sprite_colours,a0
	move.l	#$dff1a0,a1		;sprite cols start
	move.w	#12-1,d1			;amount
	moveq	#0,d0
	
reduce_the_colours
	move.w	(a0),d0	
	bsr	reduce_colour
	move.w	d0,(a1)+
	move.w	d0,(a0)
	addq.l	#2,a0
	dbra	d1,reduce_the_colours
	rts

************************************************
***** FADE OUT BACKGROUND		       *****
************************************************
fade_out_background
	moveq	#0,d0
	move.l	#the_scroll_colours+2,a0
	move.w	#7-1,d1
reduce_scroll_colours
	move.w	(a0),d0
	bsr	reduce_colour
	move.w	d0,(a0)	
	addq.l	#4,a0
	dbra	d1,reduce_scroll_colours
not_done_all_scr	
	rts	
	
	
************************************************
***** FADE OUT PANEL		       *****
************************************************
fade_out_panel
	moveq	#0,d0
	move.l	#panel_colours+2,a0
	move.w	#7-1,d1
reduce_panel_colours
	move.w	(a0),d0
	bsr	reduce_colour
	move.w	d0,(a0)	
	addq.l	#4,a0
	dbra	d1,reduce_panel_colours
	rts		
	
************************************************
***** FADE OUT ALIENS		       *****
************************************************
fade_out_aliens
	moveq	#0,d0
	move.l	#alien_col1,a0
	move.w	#7-1,d1
reduce_aliens_colours
	move.w	(a0),d0
	bsr	reduce_colour
	move.w	d0,(a0)	
	addq.l	#4,a0
	dbra	d1,reduce_aliens_colours
	rts		

************************************************
***** FADE OUT STRIPS		       *****
************************************************	
fade_out_strips
	moveq	#0,d0
	move.l	#scroll_top_colours+2,a0	
	move.l	#scroll_bottom_colours+2,a1
	move.w	#4-1,d1	;number of strips in each
num_strip_loop
	move.w	#7-1,d2	;num of colours in each strip
num_cols_in_strip_loop
	move.w	(a0),d0
	bsr	reduce_colour
	move.w	d0,(a0)
	move.w	(a1),d0
	bsr	reduce_colour
	move.w	d0,(a1)
	addq.l	#4,a0
	addq.l	#4,a1
	dbra	d2,num_cols_in_strip_loop
	addq.l	#8,a0
	addq.l	#8,a1
	dbra	d1,num_strip_loop
	
not_done_all_strip_colours_yet	
	rts
			
************************************************
***** REDUCE COLOUR		       *****
************************************************		
reduce_colour
*send colour in d0
	movem.l	d1-d5,-(sp)
	move.w	d0,d4
	moveq.w	#$0001,d5
	moveq.w	#2,d3
reduce_colour_fade_nybles
	move.w	d4,d1
	andi.w	#$000f,d1
	beq.s	reduce_colour_no_sub_col
	sub.w	d5,d0
reduce_colour_no_sub_col	
	lsr.w	#4,d4
	lsl.w	#4,d5
	dbra	d3,reduce_colour_fade_nybles
	movem.l	(sp)+,d1-d5
	rts
	
	
