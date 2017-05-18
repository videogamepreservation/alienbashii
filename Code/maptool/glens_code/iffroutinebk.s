*****************************************************************
* MODULE TITLE     :iffroutine                                  *
*                                                               *
* DESCRIPTION      :iff loader and iff saver                    *
*                                                               *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :load_graphics                               *
*                   insert_byte                                 *
*                   dealloc_pic_mem                             *
*                   find_in_mem                                 *
*                   setup_plane_offsets                         *
*                   save_graphics                               *
*                   setup_bmhd                                  *
*                   save_pic                                    *
*                                                               *
*****************************************************************



********************************
**** LOAD GRAPHICS         ***** 		
********************************
load_graphics
	move.b	#1,pointer_state
	move.l	a6,-(sp)
*send in file handle in d0
*returns pointer to struct containing pic mem pointers in a0
	move.l	d0,graphics_handle
	move.l	d0,d1
	move.l	#buffer,d2
	move.l	#4,d3
	move.l	dosbase,a5
	jsr	READ(a5)
	cmp.l	#'FORM',buffer
	beq.s	ok_so_far
	move.w	#1000,d0
	bra	exit_with_error		
ok_so_far
	
	move.l	graphics_handle,d1	;read size of file
	move.l	#buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	READ(a6)
	

	move.l	4,a6			; exec
	move.l	buffer,d0 		; mem to allocate 
	move.l	#MEM_PUBLIC+MEM_CLEAR,d1	        	; chip and clear
	jsr	-198(a6)	        		; try
	tst.l	d0
	bne	alloc_pic_size
	move.w	#1001,d0
	bra	exit_with_error
alloc_pic_size	

	move.l	d0,pic_pointer
	move.l	d0,d2
	move.l	buffer,d3
	move.l	graphics_handle,d1
	move.l	dosbase,a6
	jsr	READ(a6)	;read in all data
	
	move.l	pic_pointer,a1
	move.l	#'BMHD',d0
	bsr	find_in_mem
	move.l	(a1)+,header_size
	move.l	a1,picture_details
	move.l	#'CMAP',d0
	bsr	find_in_mem
	move.l	(a1)+,num_of_cols
	move.l	a1,colour_map_ptr
	move.l  page_pointer,a3
	move.l  screen_palette(a3),a0
	bsr	insert_cols
	move.l	#'BODY',d0
	bsr	find_in_mem
	move.l	(a1)+,size_of_pic
	move.l	a1,picture_data	;at last we are here	
	
	move.l	picture_details,a0
	move.w	RWIDTH(a0),screen_x_size(a3)
	move.w	RHEIGHT(a0),screen_y_size(a3)
	moveq	#0,d0
	move.b	NUMPLANES(a0),d0
	move.w	d0,number_of_planes(a3)
	move.w	#0,screen_y_pos(a3)
	move.l  page_pointer,a0
	move.l  screen_palette(a0),a1
	bsr	setup_screen_colours


	bsr	setup_plane_offsets
	bsr	clear_old_data	
	
**set up pointers and variables so decompression is super quick	
	move.l  page_pointer,a3
	move.l  #main_screen_struct,a5
	moveq	#0,d3

	move.l  current_plane,d3
	asl.w	#2,d3	
	move.w	screen_x_size(a5),d4
		

	move.w  number_of_planes(a3),d7
	asl.w	#2,d7
	
	moveq	#0,d6     ; pixel count
	
	move.w	RWIDTH(a3),d5	; image loaded size
	add.w	#15,d5
	andi.w	#$fff0,d5
	
	move.l	#plane_positions,a2


***Finished setup
		
	move.l	picture_data,a1
	move.l	picture_details,a0	
	cmp.b	#0,TYPECOM(a0)
	beq.s	call_uncom
	
	bsr	compressed_data
	bra.s	finished_uncom
call_uncom	
	bsr	uncompressed_data
finished_uncom	

	bsr	dealloc_pic_mem
	
	bra.s	quit_ld_grap
exit_with_error		
	move.l	#-1,a1
quit_ld_grap
	move.l	dosbase,a6
	move.l	graphics_handle,d1
	jsr	close(a6)
	bsr	general_delay
	move.b	#0,pointer_state
	
	move.l	(sp)+,a6
	rts	

compressed_data
	moveq	#0,d0
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,size_of_pic

	move.b	d0,d1
	bmi	repeat_data
	addq.b	#1,d1
	bra.s	read_and_insert
loop_read
	tst.l	size_of_pic
	bgt.s	compressed_data
	rts
read_and_insert
	moveq	#0,d0
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,size_of_pic

	subq.b	#1,d1
	bsr	insert_byte	
	tst.b	d1
	bne.s	read_and_insert
	bra	loop_read
repeat_data		
	cmp.b	#-128,d1
	bne.s	do_something
	subq.l	#1,size_of_pic
	bra	loop_read
do_something	
	neg.b	d1
	addq.b	#1,d1
	moveq	#0,d0
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,size_of_pic

repeat_loop
	bsr	insert_byte
	subq.b	#1,d1		
	bne.s	repeat_loop
	bra.s	loop_read
uncompressed_data	
	moveq	#0,d0
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,size_of_pic

	bsr	insert_byte
	cmp.l	#0,size_of_pic
	bgt.s	uncompressed_data
	rts
	
********************************
**** INSERT BYTE           ***** 		
********************************
insert_byte	
    	move.l  (a2,d3),a4
	move.b	d0,(a4)
	addq.l  #1,(a2,d3)
	addq.w	#8,d6		;pixel count
	cmp.w	d6,d4		;pix count
	bne.s	not_done_line
	bra.s	update_planes
not_done_line
	cmp.w	d6,d5
	bne.s	not_done_yet
	moveq	#0,d2
	move.w	#320,d2            ;naughty naughty
	sub.w	d6,d2
	asr.w	#3,d2
	add.l	d2,(a2,d3)	move onto next line
update_planes
	moveq.w	#0,d6
	addq.w	#4,d3
	cmp.w	d7,d3	;compare curent plane with number of planes
	bne.s	not_done_line
	moveq	#0,d3
not_done_yet	
	rts
		
********************************
**** DEALLOC PIC MEM       ***** 		
********************************
dealloc_pic_mem	
	move.l	4,a6			; deallocate mem
	move.l	buffer,d0
	move.l	pic_pointer,a1
	jsr	-210(a6)
	rts

********************************
**** ALLOCATE SCREEN MEM   ***** 		
********************************

allocate_screen_mem
****PLEASE NOTE - bodgy code is about
****THE picture structs allocate the same size as the screen
****but the x and y size contained in the struct are that of the 
****graphic image

	movem.l	a0-a6/d0-d7,-(sp)


*** SEE IF NEED TO DEALLOCATE OLD PICTURE
	
	move.l  page_pointer,a0
	tst.l   screen_mem(a0)
	beq.s   no_need_to_deallocate
	move.l  #main_screen_struct,a4
	move.w	screen_x_size(a4),d0
	asr.w	#3,d0
	mulu	screen_y_size(a4),d0
	mulu	number_of_planes(a0),d0
	move.l  screen_mem(a0),a1
	move.l  4,a6
	jsr    -210(a6)
no_need_to_deallocate	

*****NOW TRY AND ALLOCATE NEW ONE	
	
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	move.l  page_pointer,a0
	mulu	number_of_planes(a0),d0
	move.l  4,a6
	move.l	#MEM_PUBLIC+MEM_CLEAR,d1
	jsr	-198(a6)
	tst.l	d0
	bne.s	got_the_mem
	move.l  #main_screen_colours+2,a2
	move.w	#$fff,(a2)
got_the_mem
	move.l  page_pointer,a0
	move.l  d0,screen_mem(a0)
	movem.l (sp)+,a0-a6/d0-d7
	rts

********************************
**** CLEAR_OLD_DATA        ***** 		
********************************
clear_old_data
	movem.l a0/d0,-(sp)
	move.l #main_screen_struct,a0
	moveq	#0,d0
	move.w screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	asr.w   #2,d0
	mulu	number_of_planes(a0),d0
	move.l  page_pointer,a0
	move.l  screen_mem(a0),a0
	subq.w	#1,d0
clear_old_data_loop	
	clr.l   (a0)+
	dbra	d0,clear_old_data_loop
no_clear_old	
	movem.l (sp)+,a0/d0

********************************
**** FIND IN MEM           ***** 		
********************************
find_in_mem
	move.l	a1,a0
set_up_loop	
	move.w	#3,d2
	moveq	#0,d1
test_in_loop	
	rol.l	#8,d1
	or.b	(a0)+,d1
	dbra	d2,test_in_loop
	cmp.l	d1,d0
	beq.s	found_the_text
	add.l	#1,a1
	bra.s	find_in_mem
found_the_text	
	add.l	#4,a1	;get past text
	rts
	
********************************
**** SETUP PLANE OFFSETS   ***** 		
********************************
setup_plane_offsets
	movem.l a0-a1/d0-d1,-(sp)
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	move.w	number_of_planes(a0),d1
	subq.w	#1,d1
	move.l	#plane_positions,a0
	move.l  page_pointer,a1
	move.l  screen_mem(a1),a1
calculate_offsets	
	move.l	a1,(a0)+
	add.l	d0,a1
	dbra	d1,calculate_offsets
	movem.l (sp)+,a0-a1/d0-d1

	rts

********************************
**** SAVE GRAPHICS         ***** 		
********************************
save_graphics
	move.b	#1,pointer_state
	bsr	remove_file_request
	movem.l	a6,-(sp)
	move.l	dosbase,a6
	
	move.l	#current_filename,d1
	move.l	#MODE_NEW,d2
	jsr	OPEN(a6)
	tst.l	d0
	bne.s	go_and_save_pic
	movem.l	(sp)+,a6
	bsr	display_error
	bra	exit_save_pic
go_and_save_pic	
	move.l d0,save_file_handle

	tst.b	save_format
	bne.s	save_dpaint_file
	bsr	save_raw_data	
	bra	fin_save_pic
save_dpaint_file	
***write out header
	move.l	#"FORM",save_buffer	
	move.l	d0,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
***calculate size of file
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	
	mulu	number_of_planes_to_save,d0	;size of pic	
	add.l	#4+4+4+4+4+4+4,d0	;BMHD,CMAP,BODY text, BMHDSIZE and BODY SIZE  + number of colours
	add.l	#size_of_bmhd,d0
	move.w	number_of_planes_to_save,d1
	move.w	#1,d2
	asl.w	d1,d2
	mulu	#3,d2
	add.l	d2,d0		;colours	
	move.l	d0,save_buffer
	
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
****write bmhd	
	move.l	#"ILBM",save_buffer
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)


	move.l	#"BMHD",save_buffer
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)

	move.l	#size_of_bmhd,save_buffer
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)	
	
	bsr	setup_bmhd
	
	move.l	save_file_handle,d1
	move.l	#save_bmhd,d2
	move.l  #size_of_bmhd,d3
	jsr	WRITE(a6)
	
****do colourmap

	move.l	#"CMAP",save_buffer
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
	move.w	number_of_planes_to_save,d1
	move.w	#1,d2
	asl.w	d1,d2
	mulu	#3,d2
	move.l	d2,save_buffer
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
	move.w	number_of_planes_to_save,d1
	move.w	#1,d2
	asl.w	d1,d2
	move.l  d2,d3
	bsr	convert_to_dpaint_colours 	;uses d2
	mulu	#3,d3				;number of bytes
	move.l	save_file_handle,d1
	move.l	#dpaint_colours,d2
	jsr	WRITE(a6)
	
	
****do body	
	move.l	#"BODY",save_buffer		
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
	
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	mulu	number_of_planes_to_save,d0
	
	move.l	d0,save_buffer		
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l   #4,d3
	jsr	WRITE(a6)
	
****write out body data	
	move.l	#main_screen_struct,a0
	move.w	screen_y_size(a0),d0
	moveq	#0,d1
	move.w	screen_x_size(a0),d1
	asr.w	#3,d1
	move.l	page_pointer,a0
	move.l	screen_mem(a0),a1
	subq.w	#1,d0
write_pic_loop
	move.l	a1,a2
	move.w	number_of_planes_to_save,d2
	subq.w	#1,d2	
write_plane_pic_loop

	movem.l	a0-a2/d0-d2,-(sp)		;write line 
	move.l	d1,d3	;size
	move.l	save_file_handle,d1  ;handle
	move.l	a2,d2		;place to get from
	jsr	write(a6)
	movem.l	(sp)+,a0-a2/d0-d2
	
	move.l	d1,d4
	move.l	#main_screen_struct,a0
	mulu	screen_y_size(a0),d4	;plane size
	add.l	d4,a2
	dbra	d2,write_plane_pic_loop
	
	add.l	d1,a1
	dbra	d0,write_pic_loop

fin_save_pic	
	move.l	save_file_handle,d1
	jsr	CLOSE(a6)
*	bsr	general_delay
quit_save_pic
	movem.l	(sp)+,a6
exit_save_pic
	move.b	#0,pointer_state
	rts


general_delay
	movem.l	d0-d7/a0-a6,-(sp)
	
	move.l	dosbase,a6
	move.l	#50*5,d1
	jsr	delay(a6)
	
	movem.l	(sp)+,d0-d7/a0-a6	
	rts
	
********************************
**** CONVERT TO DPAINT COLOURS * 		
********************************	
convert_to_dpaint_colours
****d2 contains number
	movem.l	a0-a1/d0-d3,-(sp)
	move.l	page_pointer,a0
	move.l	screen_palette(a0),a0
	move.l	#dpaint_colours,a1
	subq.w	#1,d2
convert_dpaint_loop
	move.w	(a0)+,d1
	move.w	d1,d3
	lsr	#8,d3
	andi.w	#$f,d3
	lsl.w	#4,d3
	move.b	d3,(a1)+	;read
	move.w	d1,d3
	lsr.w	#4,d3
	andi.w	#$f,d3
	lsl.w	#4,d3
	move.b	d3,(a1)+	;green
	andi.w	#$f,d1
	lsl.w	#4,d1
	move.b	d1,(a1)+	;blue
	dbra	d2,convert_dpaint_loop	
	movem.l	(sp)+,a0-a1/d0-d3
	rts
	
dpaint_colours
	ds.b	3*256	;max
	EVEN		
********************************
**** SETUP BMHD            ***** 		
********************************	
setup_bmhd
	move.l	d1,-(sp)
	move.l #main_screen_struct,a0
	move.l #save_bmhd,a1
	move.w screen_x_size(a0),RWIDTH(a1)
	move.w screen_y_size(a0),RHEIGHT(a1)
	move.w #0,XPOS(a1)
	move.w #0,YPOS(a1)
	move.l	page_pointer,a0
	move.w number_of_planes(a0),d0
	move.b d0,numplanes(a1)
	move.b #0,PMASK(a1)
	move.b #0,TYPECOM(a1)
	move.b #0,PAD(a1)
	move.w #0,TRANSCOLOUR(a1)
	move.b #0,XASPECT(a1)
	move.b #0,YASPECT(a1)
	move.w #0,PAGEWIDTH(a1)
	move.w #0,PAGEHEIGHT(a1)
	move.l	(sp)+,d1
	rts
	

********************************
**** SAVE PIC              ***** 		
********************************	
save_pic
	move.l	#save_graphics,file_routine_pointer
	bsr	display_file_request
	rts


********************************
**** INSERT COLS           ***** 		
********************************
insert_cols
***send place to put palette in  a0
	movem.l	d0-d7/a0-a2,-(sp)
	move.l	a0,a2
	add.l	#256*2,a2	;lo colour attributes
	move.l	num_of_cols,d5
	divu	#3,d5
	sub.w	#1,d5
	move.l  colour_map_ptr,a1
insert_colours
	moveq	#0,d3		;hi colour
	moveq	#0,d6		;lo colour
	moveq	#0,d4
	move.b	(a1)+,d3
	move.b	d3,d6
	andi.b	#$f,d6
	andi.b	#$f0,d3
	lsl.w	#4,d3
	lsl.w	#8,d6
	move.b	(a1)+,d4
	move.w	d4,d7
	andi.b	#$f,d7
	lsl.b	#4,d7
	or.b	d7,d6	
	andi.b	#$f0,d4
	or.b	d4,d3
	move.b	(a1)+,d4
	move.b	d4,d7
	andi.b	#$f,d7
	or.b	d7,d6
	andi.b	#$f0,d4
	lsr.w	#4,d4
	or.w	d4,d3
	move.w	d6,(a2)+	;lo colour attrib
	move.w  d3,(a0)+	;hi colour attrib
	moveq	#0,d0
	dbra d5,insert_colours	
	movem.l	(sp)+,d0-d7/a0-a2
	rts


********************************
**** SAVE RAW DATA         ***** 		
********************************
save_raw_data

	moveq	#0,d6		;picture pages offset num
	move.w	number_of_blocks_to_write_out,d0
	move.l	#picture_pages,a0
	move.w	#4-1,d1		;page count
	move.w	#0,d2		;block count
	move.l	#main_screen_struct,a1
	move.l	current_map_ptr,a2
	moveq	#0,d5
	moveq	#0,d3
	move.w	screen_x_size(a1),d3
	moveq	#0,d7
	move.w	d3,d7
	asr.w	#3,d7			;x size of screen
	divu	map_block_size(a2),d3		;x blocks
	move.w	screen_y_size(a1),d5
	divu	map_block_size(a2),d5		;y blocks
	move.w	d3,d4	
	mulu	d5,d4		;number of blocks in page
	move.l	(a0,d6),a3	;page
	move.l	screen_mem(a3),a3
	moveq	#0,d0
	moveq	#0,d3
write_out_pages
	bsr	write_out_block

***  - See if all blocks of a page done	
	addq.w	#1,d2
	cmp.w	d2,d4
	bne.s	not_done_page_yet
	add.w	d4,d3		;d3 = value to sub from block count
	moveq	#0,d2
	addq.l	#4,d6
	move.l	(a0,d6),a3	;get new page
	move.l	screen_mem(a3),a3
****	
not_done_page_yet
	addq.w	#1,d0
	cmp.w	number_of_blocks_to_write_out,d0
	bne.s	write_out_pages
	
	rts								
	
	
********************************
**** WRITE OUT BLOCK       ***** 		
********************************
write_out_block
***takes in a3	as current page
	movem.l	d0-d3/d6/a3-a6,-(sp)
	
*d0 = number of block
	sub.w	d3,d0		;get	block in page
	ext.l	d0	
	moveq	#0,d3
	move.w	screen_x_size(a1),d3
	divu	map_block_size(a2),d3
	divu.w	d3,d0	
	swap	d0
	move.w	d0,d2		;x blocks in
	swap	d0
	move.w	d0,d1		= number of lines down
	mulu	map_block_size(a2),d1
	mulu	d7,d1	
	move.w	map_block_size(a2),d0	;8 16 32
	asr.w	#3,d0
	mulu	d0,d2		;block in
	move.l	a3,a4
	
	add.l	d2,a4
	add.l	d1,a4		;block
	move.l	a4,a6	
*******code to write out		
			
	move.w	map_planes(a2),d0
	subq.w	#1,d0		;number of planes
	move.l	#one_block_buffer,a5
plane_loop	
	move.w	map_block_size(a2),d1	
	subq.w	#1,d1
block_line_loop
	cmp.w	#8,map_block_size(a2)
	bne.s	check_16_pos
	move.b	(a4),(a5)+
	bra.s	do_all_planes
check_16_pos
	cmp.w	#16,map_block_size(a2)
	bne.s	block_write_be_32
	move.w	(a4),(a5)+
	bra.s	do_all_planes
block_write_be_32
	move.l	(a4),(a5)+
do_all_planes
	tst.b	sliced
	bne.s	sliced_save
	add.l	d7,a4		;next line down
	bra.s	carry_on_collect
sliced_save
	move.w	d7,d6
	mulu	screen_y_size(a2),d6
	add.l	d7,a4	
carry_on_collect		
	dbra	d1,block_line_loop					
	
	tst.b	sliced
	bne.s	sliced_save2
	move.w	d7,d1
	mulu	screen_y_size(a1),d1
	add.l	d1,a6
	move.l	a6,a4
	bra.s	jump_past_sliced_save
sliced_save2
	add.l	d7,a6
	move.l	a6,a4
jump_past_sliced_save
		
	dbra	d0,plane_loop

	movem.l	(sp)+,d0-d3/d6/a3-a6
***data now in one_block_buffer	
	
	
************write block out	
	movem.l	d0-d7/a0-a6,-(sp)
	
	move.l	dosbase,a6
	move.l	save_file_handle,d1
	move.l	#one_block_buffer,d2
	move.w	map_block_size(a2),d3
	asr.w	#3,d3
	mulu	map_block_size(a2),d3
	mulu.w	map_planes(a2),d3
	jsr	write(a6)
	
	movem.l	(sp)+,d0-d7/a0-a6
**************write block out	
	
	
not_done_line_write_block		
	rts
	
	
