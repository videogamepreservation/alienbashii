*********************************************
*******  FILL BLOCK FUNCTION          *******
*********************************************
fill_block_function
	bsr	make_screen_backup
	bsr	display_undo	
	
	move.l	#fill_stack,a3
	move.w	#$ffff,(a3)+
	move.w	#$ffff,(a3)+	;put on terminator
	bsr	convert_mouse_and_store
	
	move.l	current_map_ptr,a1
	divu	map_block_size(a1),d0
	divu	map_block_size(a1),d1
	add.w	map_x_position,d0	;x in map
	add.w	map_y_position,d1	;y in map
	
	bsr	get_map_position
	moveq	#0,d6
	tst	map_datasize(a1)
	beq.s	we_have_byte
	move.w	(a0),d6			;block type to fill
	bra.s	test_for_same_block
we_have_byte
	move.b	(a0),d6
	
test_for_same_block	
	cmp.w	current_block,d6
	beq	quit_fill	;dest block and fill block are the same
get_going_on_fill	
	move.w	map_x_position,d2	;min x bound
	move.w	map_y_position,d3	;min y bound
	move.l	#main_screen_struct,a2
	moveq	#0,d4
	move.w	screen_x_size(a2),d4
	divu	map_block_size(a1),d4
	add.w	d2,d4			;max x bound
	cmp.w	map_xsize(a1),d4
	ble.s	not_exceedingxmax
	move.w	map_xsize(a1),d4
not_exceedingxmax		
	subq.w	#1,d4
	moveq	#0,d5
	move.w	max_map_screen_pos,d5
	divu	map_block_size(a1),d5
	add.w	d3,d5			;max y bound
	cmp.w	map_ysize(a1),d5
	ble.s	nob_cheese_cracker_jack	
	move.w	map_ysize(a1),d5
nob_cheese_cracker_jack
	subq.w	#1,d5
loop_until_all_filled	
	bsr	determine_fill_locations
	move.w	-(a3),d1
	move.w	-(a3),d0	
	cmp.w	#$ffff,(a3)
	beq.s	done_all_fill
	bsr	get_map_position
	bra.s	loop_until_all_filled
done_all_fill			
	bsr	display_map_on_screen		
quit_fill	
	rts
	
*********************************************
*******  DETERMINE FILL LOCATIONS     *******
*********************************************
determine_fill_locations
*uses all data from above routines

	bsr	stuff_data	;fills current block
		
***to the left
	cmp.w	d2,d0
	ble.s	cant_check_left
	subq.w	#1,d0
	bsr	get_map_position
	bsr	test_data
	cmp.w	d7,d6
	bne.s	cant_use_left
	bsr	stuff_data	
	move.w	d0,(a3)+	;store on stack
	move.w	d1,(a3)+
cant_use_left		
	addq.w	#1,d0	
cant_check_left	
*****check to the right
	cmp.w	d4,d0
	bge.s	cant_check_right
	addq.w	#1,d0
	bsr	get_map_position
	bsr	test_data
	cmp.w	d7,d6
	bne.s	cant_use_right
	bsr	stuff_data	
	move.w	d0,(a3)+	;store on stack
	move.w	d1,(a3)+	
cant_use_right	
	subq.w	#1,d0	
cant_check_right
*****check up
	cmp.w	d3,d1
	ble.s	cant_check_up
	subq.w	#1,d1
	bsr	get_map_position
	bsr	test_data
	cmp.w	d7,d6
	bne.s	cant_use_up
	bsr	stuff_data	
	move.w	d0,(a3)+	;store on stack
	move.w	d1,(a3)+	
cant_use_up
	addq.w	#1,d1
cant_check_up
*****check down
	cmp.w	d5,d1
	bge.s	cant_check_down
	addq.w	#1,d1
	bsr	get_map_position
	bsr	test_data
	cmp.w	d7,d6
	bne.s	cant_use_down
	bsr	stuff_data	
	move.w	d0,(a3)+	;store on stack
	move.w	d1,(a3)+	
cant_use_down
	subq.w	#1,d1
cant_check_down
	rts

	
	
*********************************************
*******  STUFF DATA                    *******
*********************************************
stuff_data	
	tst.w	map_datasize(a1)
	beq.s	map_is_byte_friend
	move.w	current_block,(a0)
	bra.s	done_stuff
map_is_byte_friend
	move.w	current_block,d7
	move.b	d7,(a0)	
done_stuff
	rts


*********************************************
*******  TEST DATA                    *******
*********************************************
test_data	
	moveq	#0,d7
	tst.w	map_datasize(a1)
	beq.s	map_is_byte_friendtest
	move.w	(a0),d7
	bra.s	done_test
map_is_byte_friendtest
	move.b	(a0),d7
done_test
	rts


*********************************************
*******  GET MAP POSITION             *******
*********************************************
get_map_position
*send in d0 and d1 x, y
*returns mem position in a0

	movem.l	a1/d0-d4,-(sp)
	move.w	d0,d2
	move.w	d1,d3
	moveq	#0,d0
	moveq	#0,d1
	move.w	d2,d0
	move.w	d3,d1
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),a1
	move.w	map_datasize(a0),d3
	asl	d3,d0
	move.w	map_xsize(a0),d4
	asl	d3,d4
	mulu	d4,d1	
	
	add.l	d0,a1
	add.l	d1,a1			;block position
	move.l	a1,a0
	movem.l	(sp)+,a1/d0-d4
	rts
