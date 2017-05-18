********************************
***** CREATE HEX WINDOW    *****
********************************
create_hex_window
*send pointer in a0
	move.l	a0,mem_position
	move.l	#hex_window,a0
	bsr	create_window

	move.l	#hex_button_list,a0
	bsr	display_button_list

	bsr	display_hex_text
	rts

********************************
***** DISPLAY HEX TEXT     *****
********************************
display_hex_text
	move.l	mem_position,a0
	move.w	#10-1,d0
	move.l	#hex_text_list,a1
write_hex_text

	move.b	#"$",(a1)+

	move.l	a0,d1
	swap	d1
	bsr	fill_hex
	swap	d1
	bsr	fill_hex

	move.b	#" ",(a1)+	
	move.b	#":",(a1)+
	move.b	#" ",(a1)+	
	move.b	#"$",(a1)+	


	move.l	(a0)+,d1
	swap	d1
	bsr	fill_hex
	swap	d1
	bsr	fill_hex

	

	add.l	#1,a1
	
	dbra	d0,write_hex_text

	move.l	#hex_window,a0
	move.l	#hex_text_list,a1
	move.w	#3,d0
	move.w	#3,d1
	move.w	#2,d2
	bsr	write_text
	rts

********************************
***** FILL HEX             *****
********************************
fill_hex
	movem.l	d1,-(sp)
	move.w	#4-1,d3
get_nybble
	rol.w	#4,d1
	move.w	d1,d4
	andi.w	#$000f,d4
	cmp.w	#9,d4
	bgt.s	add_up_to_hex
	add.w	#48,d4
	bra.s	do_next_nyb
add_up_to_hex
	add.w	#55,d4
do_next_nyb
	move.b	d4,(a1)+
	dbra	d3,get_nybble
	movem.l	(sp)+,d1
	rts

********************************
***** DELETE HEX WINDOW    *****
********************************
delete_hex_window
	move.l	#hex_window,a0
	move.w	#0,d0
	move.w	#0,d1
	move.w	#18,d2
	move.w	#120,d3
	bsr	clear_word_chunk
	rts

********************************
***** SCROLL WINDOW UP     *****
********************************
scroll_window_up
	sub.l	#4,mem_position
	bsr	delete_hex_window
	bsr	display_hex_text
	rts

********************************
***** SCROLL WINDOW DOWN   *****
********************************
scroll_window_down
	add.l	#4,mem_position
	bsr	delete_hex_window
	bsr	display_hex_text
	rts

********************************
***** QUIT HEX ROUTINE     *****
********************************
quit_hex_routine
	move.l	#hex_button_list,a0
	bsr	remove_button_list

	bsr	destroy_window
	rts

mem_position
	dc.l	0


hex_window
	dc.w 320
	dc.w 160
	dc.w 96
	dc.w 20
	dc.l 0
	dc.l 0
	dc.b "HEX DUMP",0
	
	EVEN


hex_text_list
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",$a
	dc.b "                     ",0
	EVEN
