*TREV:
*When re-coding the only thing you need to be aware of is the
*routine Select_Map_Area, which allows the user to select a
*position on the zoomed-out map to jump to.


******************************************
*****	SHOW WHOLE MAP               *****
******************************************
show_whole_map

	move.l	#show_map_window,a0
	jsr	create_window
	move.l	#show_map_buttons,a0
	jsr	display_button_list

	bsr	display_whole_map
	rts
	
	
******************************************
*****	REMOVE SHOW MAP WINDOW       *****
******************************************
remove_show_map_window

	move.l	#show_map_buttons,a0
	jsr	remove_button_list
	move.l	#show_map_window,a0
	jsr	destroy_window
	rts
	

MAP_SHOW_SIZE	EQU	128
WHOLE_ACR	EQU	5	;accuracy	
ACCURACY	EQU	32

******************************************
*****	 DISPLAY WHOLE MAP           *****
******************************************
display_whole_map
	btst	#14,dmaconr(a6)
	bne.s	display_whole_map
*work out map ratio


	move.l	current_map_ptr,a1

	moveq	#0,d0
	moveq	#0,d1
	move.w	map_xsize(a1),d0
	move.w	map_ysize(a1),d1
	
	cmp.w	d0,d1
	ble.s	y_less_than_x
x_less_than_y
	divu	d0,d1
	move.w	d1,d0		
	moveq	#1,d1		;ratio divide value
	bra.s	calc_ratio
y_less_than_x
	divu	d1,d0
	move.w	d0,d1
	moveq	#1,d0	
calc_ratio
	move.w	#MAP_SHOW_SIZE,d2
	ext.l	d2
	divu	d0,d2
	move.w	d2,x_show_size		;x size
	
	move.w	#MAP_SHOW_SIZE,d2
	ext.l	d2
	divu	d1,d2
	move.w	d2,y_show_size		;y size


	moveq	#0,d2		;increment values
	moveq	#0,d3
	
	moveq	#16,d5		;y
	move.l	#show_map_window,a0
	move.l	window_start(a0),a0	;mem start pos

	move.w	map_xsize(a1),d0
	asl.w	#WHOLE_ACR,d0
	ext.l	d0
	divu	x_show_size,d0	

		

	move.w	map_ysize(a1),d1
	asl.w	#WHOLE_ACR,d1
	ext.l	d1
	divu	y_show_size,d1

		
	add.w	#16,x_show_size
	add.w	#16,y_show_size		
		
	move.l	map_mem(a1),a2
	move.l	a2,a4	;store for later
do_pixel_y	
	move.w	#16,d4
	moveq	#0,d2
	moveq	#0,d7
do_pixel_x	
	tst	map_datasize(a1)
	bne.s	word_map
	move.b	(a2),d7
	bra.s	draw_coloured_pixel
word_map
	move.w	(a2),d7
draw_coloured_pixel
*need to find what colour to draw pixel
	bsr	Find_Pixel_Colour
	bsr	draw_pixel	
	addq.w	#1,d4
	cmp.w	x_show_size,d4
	bge.s	done_x_line	
	
*calculate block step for x	
	add.w	d0,d2
	move.w	d2,d7
	andi.w	#ACCURACY-1,d2
	asr.w	#WHOLE_ACR,d7
	
	tst	d7
	beq.s	do_pixel_x
	move.w	map_datasize(a1),d6
	ext.l	d7
	asl.w	d6,d7	;number of bytes to increase
	add.l	d7,a2
	bra.s	do_pixel_x
done_x_line	

	addq.w	#1,d5
	cmp.w	y_show_size,d5
	bge.s	done_y_line	
	
*calculate block step for y
	add.w	d1,d3
	move.w	d3,d7
	andi.w	#ACCURACY-1,d3
	asr.w	#WHOLE_ACR,d7
	movem.l	d5,-(sp)
	
	tst	d7
	beq.s	dont_increase_y_block
	move.w	map_xsize(a1),d6
	move.w	map_datasize(a1),d5
	asl.w	d5,d6	;size of one line
	mulu	d7,d6			;number of lines to add
	add.l	d6,a4
dont_increase_y_block
	move.l	a4,a2	
	movem.l	(sp)+,d5	
	bra	do_pixel_y
done_y_line	

	rts	

x_show_size	dc.w	0
y_show_size	dc.w	0

******************************************
*****	 FIND PIXEL COLOUR           *****
******************************************
Find_Pixel_Colour
*send block number in d7
*map details in a1
*returns colour in d7

	movem.l	a0/d0-d2,-(sp)	
	ext.l	d7
	tst	d7
	bne.s	pix_blk_not_0
	moveq	#0,d0
	move.w	#0,d2
	bra.s	dont_do_pix_calc	
pix_blk_not_0	
	divu	num_blocks_in_page,d7
	move.l	d7,d2
	move.w	d2,d0	;page number
	asl	#2,d0
	clr.w	d2
	swap	d2	;block number
dont_do_pix_calc	
	
	move.l   #picture_pages,a0		
	move.l	(a0,d0),a0	;first page
	move.l  screen_mem(a0),a0    ; page mem
	
	divu	d1,d2	;blocks in line / block number
	move.w	d2,d1	;number of lines down
	clr.w	d2
	swap	d2	;position in line
	mulu	map_block_size(a1),d1	;lines down

	mulu	#ScrPixelWidth/8,d1
	add.l	d1,a0
	
	mulu	map_block_size(a1),d2	;in
	asr	#3,d2			;get to bytes
	add.l	d2,a0			;our block

	clr.w	d7
	moveq	#0,d0
	moveq	#4-1,d1
plane_loop_bit
	btst.b	#0,(a0)
	beq.s	dont_set_col_bit
	bset	d0,d7
dont_set_col_bit
	addq.w	#1,d0
	add.l	#(ScrPixelWidth/8)*ScrPixelHeight,a0
	dbra	d1,plane_loop_bit
	movem.l	(sp)+,a0/d0-d2
	rts
	
colour_info
	ds.w	16	


******************************************
*****	 DRAW PIXEL                  *****
******************************************
draw_pixel	

*send mem in a0, x and y in d0 and d1
*colour in d7
	
	movem.l	a0/d4-d5/d1,-(sp)
	mulu	#RES_BYTES,d5
	add.l	d5,a0
	move.w	d4,d5
	lsr.w	#3,d4		; get bytes
	andi.b	#%111,d5		; pixel bits
	moveq	#7,d1	
	sub.b	d5,d1	
	ext.l	d4
	add.l	d4,a0
	move.w	#4-1,d5
	moveq	#0,d4
set_pix_col	
	btst.l	d4,d7
	beq.s	skip_pix_set
	bset.b	d1,(a0)	
skip_pix_set
	addq.w	#1,d4
	add.l	#RES_BYTES*256,a0
	dbra	d5,set_pix_col	
	movem.l	(sp)+,a0/d4-d5/d1
	rts	
	
	
	
*********************************************
****   SELECT MAP AREA                   ****
*********************************************
Select_Map_Area


*calculate box display size

	move.l	current_map_ptr,a0
	move.w	map_xsize(a0),d0
	move.l	#MAP_SHOW_SIZE*128,d6
	divu	d0,d6
	mulu	num_x_blocks_in_page,d6
	asr.l	#7,d6

	move.w	map_ysize(a0),d0
	move.l	#MAP_SHOW_SIZE*128,d7
	divu	d0,d7
	mulu	num_y_blocks_in_page,d7
	asr.l	#7,d7
	
*Define box boundarys
	move.l	#show_map_window,a0
	move.w	window_x(a0),d2
	move.w	window_y(a0),d3
	add.w	#32,d2
	add.w	#32-8,d3
	move.w	d2,d4
	move.w	d3,d5
	add.w	#MAP_SHOW_SIZE,d4
	add.w	#MAP_SHOW_SIZE,d5
	sub.w	d6,d4
	sub.w	d7,d5
	
	clr.w	Box_X
	
display_area_box

	jsr	Sync
	
	tst.w	Box_X
	beq.s	Dont_Delete_Map_Win_Box
	move.w	Box_X,d0
	move.w	Box_Y,d1
	bsr	Eor_Draw_Win_Box
Dont_Delete_Map_Win_Box
	
	
	move.l	#main_screen_struct,a0

	move.w	mouse_x,d0
	move.w	mouse_y,d1

	cmp.w	d2,d0
	bge.s	x_min_ok
	move.w	d2,d0
	bra.s	test_box_y
x_min_ok
	cmp.w	d4,d0
	ble.s	test_box_y
	move.w	d4,d0	
test_box_y
	cmp.w	d3,d1
	bge.s	y_max_ok
	move.w	d3,d1
	bra.s	draw_win_box
y_max_ok
	cmp.w	d5,d1
	ble.s	draw_win_box
	move.w	d5,d1		

draw_win_box	
		
	move.w	d0,Box_X
	move.w	d1,Box_Y
	
	bsr	Eor_Draw_Win_Box
	
	btst.b	#6,$bfe001
	bne	display_area_box	;wait until release
	
	move.l	#show_map_window,a0
	sub.w	window_x(a0),d0
	sub	#32,d0
						
	sub.w	#16+8,d1
	
	move.l	current_map_ptr,a0
	mulu	map_xsize(a0),d0
	mulu	map_ysize(a0),d1
	asr.l	#7,d0	;should be map pos
	asr.l	#7,d1

	move.w	d0,map_x_position
	move.w	d1,map_y_position
	
	bsr	Remove_Show_Map_Window
	jsr	display_map_on_screen
	
	rts

Eor_Draw_Win_Box
	movem.l	d0-d3,-(sp)

	move.w	d0,d2
	move.w	d1,d3
	
	add.w	d6,d2
	movem.l	d0-d7,-(sp)
	jsr	EOR_Draw_Line
	movem.l	(sp)+,d0-d7
	sub.w	d6,d2
	add.w	d7,d3
	movem.l	d0-d7,-(sp)
	jsr	EOR_Draw_Line
	movem.l	(sp)+,d0-d7
	
	add.w	d7,d1
	add.w	d6,d2
	movem.l	d0-d7,-(sp)
	jsr	EOR_Draw_Line
	movem.l	(sp)+,d0-d7
	
	add.w	d6,d0
	sub.w	d7,d3
	movem.l	d0-d7,-(sp)
	jsr	EOR_Draw_Line
	movem.l	(sp)+,d0-d7
	
	movem.l	(sp)+,d0-d3
	rts

selected_x_pos
	dc.w	0
selected_y_pos
	dc.w	0	

show_map_buttons

	dc.l	show_whole_ok_button,SelectMapArea
	dc.l	-1	

	
show_map_window
	dc.w	128+32+32
	dc.w	128+32+32
	dc.w	80-16
	dc.w	0
	dc.l	0
	dc.l	0
	dc.b	"WHOLE MAP",0
	even		
	
show_whole_Ok_Button
	dc.w	90-48
	dc.w	128+32-8
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_show_map_window
	dc.b	0		
	even
	
SelectMapArea
	dc.w	16
	dc.w	16
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	MapSelectButton ;not used
	dc.l	0	;not used
	dc.l	Select_Map_Area
	dc.b	0		
	EVEN					