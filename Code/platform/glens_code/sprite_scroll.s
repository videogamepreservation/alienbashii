SCREEN_SPRITE_HEIGHT	EQU	250
MIN_SPRITE_FRAME	EQU	0
MAX_SPRITE_FRAME	EQU	2


************************************************************
****   UPDATE SPRITE SCROLL                             ****
************************************************************
update_sprite_scroll
	
	move.w	sprite_screen_x_position,d0
	move.w	scroll_adjust_value,d1
	add.w	d1,d0
	cmp.w	#0,d0
	bge.s	check_greater_x_sprite
	moveq.w	#0,d0
	bra.s	done_x_sprite_checks
check_greater_x_sprite
	cmp.w	#((MAP_LINE_SIZE*16)-20*16)-1,d0
	ble.s	done_x_sprite_checks
	move.w	#((MAP_LINE_SIZE*16)-20*16)-1,d0
done_x_sprite_checks
	
	move.w	d0,sprite_screen_x_position

	move.w	sprite_screen_y_position,d0
	move.w	scroll_y_adjust_value,d1
	add.w	d1,d0
	cmp.w	#0,d0
	bge.s	check_greater_bound_spr
	move.w	#0,d0
	bra.s	done_sprite_y_check
check_greater_bound_spr
	cmp.w	#((MAP_HEIGHT_SIZE*16)-16*16),d0
	ble.s	done_sprite_y_check
	move.w	#((MAP_HEIGHT_SIZE*16)-16*16),d0
done_sprite_y_check			
	move.w	d0,sprite_screen_y_position
	
	move.w	sprite_screen_x_position,d0	
	move.w	d0,d2
	move.w	last_sprite_x_position,d1

	sub.w	d0,d1
	
	add.w	d1,check_add_sprite
	cmp.w	#17,check_add_sprite
	blt.s	check_min_add_sprite
	sub.w	#16,check_add_sprite
	move.w	#START_DRAW_BLOCKS,ready_flag_sprite
	move.l	#SCROLL_GOING_RIGHT,add_block_direction_sprite
	bra.s	drawing_sprites_please_wait
check_min_add_sprite
	cmp.w	#-17,check_add_sprite
	bgt.s	drawing_sprites_please_wait
	move.w	#START_DRAW_BLOCKS,ready_flag_sprite
	move.l	#SCROLL_GOING_LEFT,add_block_direction_sprite
	add.w	#16,check_add_sprite
drawing_sprites_please_wait	



	moveq	#0,d3
	move.w	d2,d3
	andi.w	#$3f,d2	;64 pix shift
		
				
	move.w	d3,d2		
	andi.w	#$ffc0,d3	;pixels into scroll
	

		
		
	tst	ready_flag_sprite	;no blocks to draw?
	beq	store_position_of_sprite_screen
	move.l	map_pointer,a1
	asr.w	d2
	add.l	d2,a1

**draw_blocks at position	
	move.l	#map_block_data,a4
	bsr	draw_sprite_blocks

store_position_of_sprite_screen		
	move.w	sprite_screen_x_position,last_sprite_x_position
	rts

**********************************************************
***********   DRAW SPRITE BLOCKS               ***********
**********************************************************
draw_sprite_blocks
*current map position in a1
*send blocks in a4
*pixels into scroll in d3	

	
**make it draw always on right

	add.l	add_block_direction_sprite,a0

	tst.l	add_block_direction_sprite
	bmi.s	sprite_scroll_going_towards_right
	add.l	#MAP_SCREEN_OFFSET,a1
	bra.s	draw_sprite_blocks_straight
sprite_scroll_going_towards_right	
	subq.l	#1,a1
draw_sprite_blocks_straight
	moveq	#0,d0
	move.w  current_sprite_map_position,d0
	move.w	d0,d1
	mulu	#MAP_LINE_SIZE,d0
	add.l	d0,a1	;get to current line
	
	
******calculate where to draw blocks here and put into a0
	
	mulu	#BYTES_PER_ROW*16,d1
	add.l	d1,a0	;current screen block position
	
	
	
	move.w	total_number_of_sprite_blocks_to_draw,d2	
init_sprite_blit_values	
	btst	#14,dmaconr(a6)
	bne.s	init_sprite_blit_values	
	
	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	
	
	moveq	#NUMBER_OF_BLOCKS_PER_FRAME-1,d0
draw_sprite_loop
	move.l	a4,a2
	moveq	#0,d1
	move.b	(a1),d1
	mulu	#(16*2)*4,d1	
	add.l	d1,a2	;get to correct position in block data
	
*********example blit to work on		
draw_sprite_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	draw_sprite_block_on_screen
	move.l	a0,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels
	move.l	a0,a3

	
	add.l	#MAP_LINE_SIZE,a1
	addq.w	#1,current_sprite_map_position
	
	cmp.w	current_sprite_map_position,d2
	bne.s	not_yet_done_sprite_line
	move.w	#0,current_sprite_map_position
	move.w	#WAIT_DRAW_BLOCKS,ready_flag_sprite	;done our line now wait for screen to scroll 16
	bra.s	done_all_sprite_blocks
not_yet_done_sprite_line
	dbra	d0,draw_sprite_loop	
done_all_sprite_blocks	
	rts

**********************************************************
***********   DISPLAY SCROLL AS SPRITES        ***********
**********************************************************
display_scroll_as_sprites
	
*takes scroll - adds on height position 
*then calculates where sprites should be in relation to position of scroll
*i.e each sprite maps onto part of the scroll - as scroll moves position
*of sprites will move

*need to save 2 words of data from each sprite before displaying - needed
*for control words - these are words 0 and 8
*dont forget to replace the old ones before doing these ones

	bra	soup
*------------------------REPLACE OLD SPRITE DATA------------------

	move.l	#sprite_table,a0
	move.w	sprite_frame,d0
	move.l	(a0,d0.w*4),a0		;current sprite table

	move.l	#sprite_save_words,a2	
	moveq	#0,d1
	move.w	old_sprite_height,d1
	asl.w	#4,d1		;mulu by 16 bytes - one line of sprite data	
	move.w	#6-1,d0
replace_command_word_loop
	move.l	(a0)+,a1	;sprite data
	move.w	(a2)+,(a1,d1)	
	move.w	(a2)+,8(a1,d1)			
	dbra	d0,replace_command_word_loop
	
*-------------------------------------------------------------------	
	
*--------------------------UPDATE FRAME-----------------------------
	
	move.w	sprite_height,old_sprite_height
	move.w	sprite_frame,d0
	add.w	sprite_frame_inc,d0
	cmp.w	#MAX_SPRITE_FRAME,d0
	blt.s	try_sprite_lower
	neg.w	sprite_frame_inc
	bra.s	update_new_sprites
try_sprite_lower
	cmp.w	#MIN_SPRITE_FRAME,d0
	bgt.s	update_new_sprites
	neg.w	sprite_frame_inc
update_new_sprites	
	move.w	d0,sprite_frame	
	
*-------------------------------------------------------------------
	
*----------------------SAVE NEW SPRITE DATA-------------------------

	move.l	#sprite_table,a0
	move.l	(a0,d0.w*4),a0		;current sprite table

	move.l	#sprite_save_words,a2	
	moveq	#0,d1
	move.w	sprite_height,d1
	asl.w	#4,d1		;mulu by 16 bytes - one line of sprite data	
	move.w	#6-1,d0
save_command_word_loop
	move.l	(a0)+,a1	;sprite data
	move.w	(a1,d1),(a2)+	
	move.w	8(a1,d1),(a2)+			
	dbra	d0,save_command_word_loop

*-------------------------------------------------------------------

*---------------------DISPLAY NEW SPRITES---------------------------
soup
	move.l	#sprite_table,a2
	move.w	sprite_frame,d0
	move.l	(a2,d0.w*4),a2		;current sprite table

	moveq.w	#0,d0		;x co-ord
	moveq.w	#0,d1		;y co-ord
	
	move.l	#sprite_frame_table1,a2
	move.l	#sprite2h,a3
	move.w	sprite_height,d3
	asl.w	#4,d3		;mulu by 16 bytes - one line of sprite data	
	move.w	#1-1,d5
display_sprites_loop
	move.l	(a2)+,a0
	move.l	#arse,a0
	move.w	#SCREEN_SPRITE_HEIGHT,d2
	movem.w	d0/d1,-(sp)
	bsr	position_any_64_sprite	
	movem.w	(sp)+,d0/d1

*------------------------------Shove into sprite regs--------	
	move.l	a0,d4
	move.w	d4,4(a3)
	swap	d4
	move.w	d4,(a3)
	addq.l	#8,a3
	
*------------------------------------------------------------

	add.w	#64,d0	
	dbra	d5,display_sprites_loop

	rts


arse
	dcb.w	8*256,$f0f0

sprite_height				dc.w	0
old_sprite_height			dc.w	0
sprite_frame				dc.w	0
sprite_frame_inc			dc.w	1

sprite_save_words			ds.w	6*2

total_number_of_sprite_blocks_to_draw	dc.w	26

ready_flag_sprite			dc.w	0
	
add_block_direction_sprite		dc.l	0

sprite_screen_x_position		dc.w	0

sprite_screen_y_position		dc.w	0

last_sprite_x_position			dc.w	0

current_sprite_map_position		dc.w	0

check_add_sprite			dc.w	0


sprite_frame_table1	;frame1
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	

sprite_frame_table2	;frame2
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	

sprite_frame_table3	;frame3
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0		
	
sprite_table
	dc.l	sprite_frame_table1
	dc.l	sprite_frame_table2
	dc.l	sprite_frame_table3