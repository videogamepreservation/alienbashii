
**********************************
**** DISPLAY_GRAPHIC_LIST    *****
**********************************

display_graphic_buttons

  move.l #top_level_list,a0
  bsr	remove_button_list

  move.l #graphic_page_buttons,a0     ;depress current page
  moveq	#0,d0
  move.w current_page,d0
  asl.w #2,d0
  move.l (a0,d0.w),a0
  move.b #1,button_start(a0)
  
  move.w  #2,edit_mode
  move.l #graphic_list,a0
  bsr	display_button_list
  bsr   clear_screen
  bsr	reset_all_page_positions
  bsr   display_graphic_page
  rts

**********************************
**** REMOVE_GRAPHIC_LIST    *****
**********************************

remove_graphic_buttons

  move.l #graphic_list,a0
  bsr	remove_button_list

   move.w  #0,edit_mode
   move.w  #0,sprite_to_attach
   tst	generic_button_up
   beq.s	button_not_up
   move.l #detect_generic_button,a0
   bsr    remove_button  
button_not_up  
  move.l #top_level_list,a0
  bsr	display_button_list
  bsr   clear_screen
  bsr	reset_all_page_positions
  rts


**********************************
**** CANCEL BLOCK OPS        *****
**********************************
cancel_block_ops

	move.l #detect_generic_button,a0
  	bsr    remove_button
	move.w	#0,generic_button_up
	move.w	#0,sprite_to_attach
	rts

**********************************
**** RESET ALL PAGE POSITIONS *****
**********************************
reset_all_page_positions

	move.l	#picture_pages,a0
	move.w	#5-1,d0
reset_all
	move.l	(a0),a1
	
	move.w	#0,screen_y_pos(a1)
	addq.l	#4,a0
	dbra	d0,reset_all
			
	
	rts
**********************************
**** LOAD AN IMAGE FILE      *****
**********************************

Load_an_Image_File
	move.l	#Read_IFF_Image_File,File_Routine_Pointer
	bsr	display_file_request
	rts

**********************************
**** READ IFF IMAGE FILE     *****
**********************************

Read_IFF_Image_File
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_load_it

	movem.l	d0,-(sp)
	bsr	remove_file_request
	movem.l	(sp)+,d0

	movem.l	d0/a0,-(sp)
	move.w	current_page,d0
	mulu	#FILENAME_LENGTH,d0
	move.l	#Current_Filename,a0
	jsr	Set_Project_Information
	movem.l	(sp)+,d0/a0
	
	bsr	Load_Graphics
	cmp.l	#-1,a1
	bne.s	no_errors_here		
	bsr	error_routine
	rts
couldnt_load_it
         bsr	display_error
         rts
no_errors_here
	bsr	display_graphic_page
	rts


************************************
**** DISPLAY GRAPHIC PAGE       ****
************************************
display_graphic_page
	move.l  page_pointer,a0
	move.l  screen_palette(a0),a1
	bsr	setup_screen_colours
	move.l  #main_screen_struct,a2
	move.w	screen_y_pos(a0),d0
	move.w	screen_x_size(a2),d1
	asr.w	#3,d1
	mulu	d0,d1
	move.w  number_of_planes(a0),d7
	
	move.l  screen_mem(a0),a0
	beq.s   quit_display_page
data_present
        add.l   d1,a0
	move.l  screen_mem(a2),a1
	move.w  screen_x_size(a2),d0
	asr.w	#3,d0
	mulu    screen_y_size(a2),d0
	mulu    d7,d0
	asr.l   #2,d0
	subq.w	#1,d0
fill_loop
	move.l  (a0)+,(a1)+
	dbra	d0,fill_loop
quit_display_page
	jsr	Display_Overlays
	rts
	
********************************
**** CHANGE PAGE           *****
********************************
change_page

  	move.l clicked_button,a0
  	moveq	#0,d0
  	move.b  button_data(a0),d0
  	subq.w	#1,d0
  	cmp.w   current_page,d0
  	bne.s   not_clicked_on_same_butt
  	move.b  #DEPRESSED,button_start(a0)
  	bra.s   update_gr_button
not_clicked_on_same_butt 
	moveq	#0,d1 	
        move.w  current_page,d1
  	move.w  d0,current_page
  	
  	move.l  #graphic_page_buttons,a0
  	asl.w   #2,d1
  	move.l  (a0,d1.w),a0
  	move.b  #NOT_DEPRESSED,button_start(a0)
update_gr_button  	
  	bsr     remove_button
  	bsr     display_button  	
  	move.l  #picture_pages,a0
  	moveq	#0,d0
  	move.w  current_page,d0
  	asl.w	#2,d0
  	move.l  (a0,d0.w),page_pointer
  	bsr	display_graphic_page
	rts
	
current_page
      dc.w   0		
	
	
	
***************************************
****  CHANGE GRAPHICS POSITION UP *****
***************************************
change_graphics_position_up

	move.l #main_screen_struct,a0
	move.w screen_y_size(a0),d0
	sub.w #BUTTON_WINDOW_OFFSET,d0   ; gives part of screen hiding
	move.l page_pointer,a0
	tst.l  screen_mem(a0)
	beq.s  no_more_scroll
	cmp.w  screen_y_pos(a0),d0
	beq.s  no_more_scroll
	move.l current_map_ptr,a1
	move.w  map_block_size(a1),d0
	add.w  d0,screen_y_pos(a0)
	bsr    display_graphic_page
no_more_scroll	
	rts
	
		
******************************************
****  CHANGE GRAPHICS POSITION DOWN  *****
******************************************
change_graphics_position_down

        move.l page_pointer,a0
        tst.l  screen_mem(a0)
	beq.s  no_more_scroll
	cmp.w  #0,screen_y_pos(a0)
	ble.s  no_more_scrolld
	move.l current_map_ptr,a1
	move.w  map_block_size(a1),d0
	sub.w   d0,screen_y_pos(a0)
	bsr    display_graphic_page
no_more_scrolld	

	rts
	
	
store_x  dc.w  0
store_y  dc.w  0
store_off_y dc.w 0
store_page dc.l 0
	
******************************************
****     CONVERT MOUSE AND STORE     *****
******************************************
convert_mouse_and_store
	move.l	a0,-(sp)	
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.w mouse_x,d0
	move.w mouse_y,d1
	
	move.w store_x,d2
	move.w store_y,d3
	
	move.l current_map_ptr,a0
	
	cmp.w #8,map_block_size(a0)
	bne.s  check_if_16
	andi.w	#$fff8,d0
 	andi.w  #$fff8,d1
 	andi.w  #$fff8,d2
 	andi.w  #$fff8,d3
 	bra.s   done_blocks
check_if_16 		
	cmp.w   #16,map_block_size(a0)
	bne.s   check_if_32
	andi.w	#$fff0,d0
 	andi.w  #$fff0,d1
 	andi.w  #$fff0,d2
 	andi.w  #$fff0,d3
 	bra.s  done_blocks
check_if_32
	andi.w	#$ffe0,d0
 	andi.w  #$ffe0,d1
 	andi.w  #$ffe0,d2
 	andi.w  #$ffe0,d3
done_blocks
	move.l (sp)+,a0
	rts 	

	
******************************************
****     COPY BLOCK TO BLOCK         *****
******************************************
copy_block_to_block
*send a0 and a1 as start and dest
*send number of planes in d7

		movem.l a0-a5/d0-d7,-(sp)
	
		move.l  current_map_ptr,a2
		move.l  #main_screen_struct,a3
		subq.w	#1,d7

		moveq	#0,d5
		move.w screen_x_size(a3),d5
		asr.w	#3,d5
		move.l	d5,d6
		mulu	screen_y_size(a3),d6

		move.w  map_block_size(a2),d0
		cmp.w	#8,d0
		beq.s	do_8bit_pl
		cmp.w	#16,d0
		beq.s	do_16bit_pl

do_32bit_pl	move.l  a0,a4
		move.l  a1,a5	
		move.w  d0,d3
		subq.w	#1,d3
do_32bit	move.l	(a4),(a5)		* copy LONGWORD (32 bits)
		add.l	d5,a4
		add.l	d5,a5
		dbf	d3,do_32bit
		add.l	d6,a1
		add.l	d6,a0
		dbf	d7,do_32bit_pl
		movem.l (sp)+,a0-a5/d0-d7
		rts	

		cnop	0,4
do_8bit_pl	move.l  a0,a4
		move.l  a1,a5	
		move.w  d0,d3
		subq.w	#1,d3
do_8bit		move.b  (a4),(a5)		* copy BYTE (8 bits)
		add.l	d5,a4
		add.l	d5,a5
		dbf	d3,do_8bit
		add.l	d6,a1
		add.l	d6,a0
		dbf	d7,do_8bit_pl
		movem.l (sp)+,a0-a5/d0-d7
		rts	

		cnop	0,4
do_16bit_pl	move.l  a0,a4
		move.l  a1,a5	
		move.w  d0,d3
		subq.w	#1,d3
do_16bit	move.w	(a4),(a5)		* copy WORD (16 bits)
		add.l	d5,a4
		add.l	d5,a5
		dbf	d3,do_16bit
		add.l	d6,a1
		add.l	d6,a0
		dbf	d7,do_16bit_pl
		movem.l (sp)+,a0-a5/d0-d7
		rts	
	
******************************************
****     COPY BLOCK TO BUFFER        *****
******************************************
copy_block_to_buffer
*send a0 and a1 as start and dest
*send number of planes in d7
*a1 contains buffer addr

	movem.l a0-a5/d0-d3/d7,-(sp)
	
	move.l  current_map_ptr,a2
	move.l  #main_screen_struct,a3
	subq.w	#1,d7
	move.w  map_block_size(a2),d0
buffcopy_planes	
	move.l  a0,a4
	move.w  d0,d1
	move.w  d0,d3
	subq.w	#1,d3
buffcopy_to_new_position
	cmp.w	#8,d1
	bne.s	buffcopy16
	move.b  (a4),(a1)+
	bra.s   buffupdate_line
buffcopy16
	cmp.w  #16,d1
	bne.s   buffmust_be_32
	move.w  (a4),(a1)+
	bra.s   buffupdate_line
buffmust_be_32
	move.l  (a4),(a1)+
buffupdate_line
	moveq	#0,d2	
	move.w screen_x_size(a3),d2
	asr.w	#3,d2
	add.l  d2,a4
	dbra   d3,buffcopy_to_new_position 
	
	move.w   screen_x_size(a3),d2
	asr.w    #3,d2
	mulu	screen_y_size(a3),d2
	add.l    d2,a0
	dbra    d7,buffcopy_planes
	movem.l (sp)+,a0-a5/d0-d3/d7
	rts	

******************************************
****     COPY BUFFER  TO BLOCK       *****
******************************************
copy_buffer_to_block
*send a0 and a1 as start and dest
*send number of planes in d7
*a0 contains buffer addr

	movem.l a0-a5/d0-d3/d7,-(sp)
	
	move.l  current_map_ptr,a2
	move.l  #main_screen_struct,a3
	subq.w	#1,d7
	move.w  map_block_size(a2),d0
bloccopy_planes	
	move.l  a1,a4
	move.w  d0,d1
	move.w  d0,d3
	subq.w	#1,d3
bloccopy_to_new_position
	cmp.w	#8,d1
	bne.s	bloccopy16
	move.b  (a0)+,(a4)
	bra.s   blocupdate_line
bloccopy16
	cmp.w  #16,d1
	bne.s   blocmust_be_32
	move.w  (a0)+,(a4)
	bra.s   blocupdate_line
blocmust_be_32
	move.l  (a0)+,(a4)
blocupdate_line
	moveq	#0,d2	
	move.w screen_x_size(a3),d2
	asr.w	#3,d2
	add.l  d2,a4
	dbra   d3,bloccopy_to_new_position 
	
	move.w   screen_x_size(a3),d2
	asr.w    #3,d2
	mulu	screen_y_size(a3),d2
	add.l    d2,a1
	dbra    d7,bloccopy_planes
	movem.l (sp)+,a0-a5/d0-d3/d7
	rts	




*****CODE TO MOVE A BLOCK	
	
******************************************
****     GET BLOCK POSITION          *****
******************************************
get_block_position
        move.w mouse_x,store_x
        move.w mouse_y,store_y
        move.l page_pointer,a0
        move.w screen_y_pos(a0),store_off_y
        move.l page_pointer,store_page
        move.w #TO,sprite_to_attach
        move.w #MODE_TO_MOVE_BLOCK,block_mode
      	rts	



*******************PLEASE NOTE

*when a picture is loaded it is always loaded into five planes
*of memory this way when copying blocks around there is no
*problem if a block is copied from a five plane picture
*to a one plane picture
*it is up to the user 

	
******************************************
****     FIND MOVE TO POSITION       *****
******************************************
find_move_to_position

	bsr	convert_mouse_and_store
	
	move.l  page_pointer,a0		
	move.w  d1,d6     ; store for later use
	add.w   screen_y_pos(a0),d1
	move.l  screen_mem(a0),a1
	asr.w	#3,d0
	move.l	#main_screen_struct,a2
	move.w	screen_x_size(a2),d4
	asr.w	#3,d4
	mulu	d4,d1		;get position down screen
	add.l	d1,a1
	add.l	d0,a1		; a1 contains dest address
	move.l  a1,a5
		
	move.l  store_page,a3	
	move.w  number_of_planes(a2),d7
	move.w  d3,d5
	add.w   store_off_y,d3
	move.l  screen_mem(a3),a0
	asr.w	#3,d2			
	mulu	d4,d3
	add.l   d3,a0
	add.l   d2,a0           ;a0 contains start address

	move.l  #block_buffer,a1
	bsr	copy_block_to_buffer ;in buffer
	
	move.l  a0,a1
	move.l  #blank_buffer,a0
	bsr     copy_buffer_to_block  ; clear out source
	
	move.l  #block_buffer,a0
	move.l  a5,a1
	bsr     copy_buffer_to_block ; copy to dest

***blank out position on screen	
	move.l  screen_mem(a2),a1
	mulu	d4,d5
	add.l   d5,a1
	add.l   d2,a1
	
	move.l  #blank_buffer,a0
	bsr     copy_buffer_to_block
	


	
	move.l  #block_buffer,a0		
	move.l  screen_mem(a2),a1
	add.l   d0,a1		
	mulu	d4,d6
	add.l	d6,a1
	
	bsr	copy_buffer_to_block; copy to screen
	
	
*now put back to pick stage
quit_move_block
	move.w #PICK,sprite_to_attach
	move.w #MODE_MOVE_BLOCK,block_mode					
	
	rts	
	
******************************************
****     GET COPY BLOCK POSITION     *****
******************************************
get_copy_block_position
        move.w mouse_x,store_x
        move.w mouse_y,store_y
        move.l page_pointer,a0
        move.w screen_y_pos(a0),store_off_y
        move.l page_pointer,store_page
        move.w #TO,sprite_to_attach
        move.w #MODE_TO_COPY_BLOCK,block_mode
      	rts	


	
******************************************
****     FIND COPY TO POSITION       *****
******************************************
find_copy_to_position

	bsr	convert_mouse_and_store
	
	move.l  page_pointer,a0
	move.w  d1,d6     ; store for later use
	add.w   screen_y_pos(a0),d1
	move.l  screen_mem(a0),a1
	asr.w	#3,d0
	move.l	#main_screen_struct,a2
	move.w	screen_x_size(a2),d4
	asr.w	#3,d4
	mulu	d4,d1		;get position down screen
	add.l	d1,a1
	add.l	d0,a1		; a1 contains dest address
	
	move.l  store_page,a3	
	move.w  number_of_planes(a2),d7
	add.w store_off_y,d3	;add on old offset
	move.l screen_mem(a3),a0
	asr.w	#3,d2			
	mulu	d4,d3
	add.l   d3,a0
	add.l   d2,a0           ;a0 contains start address

	bsr	copy_block_to_block   ; copy into page
	
	move.l  screen_mem(a2),a1
	add.l   d0,a1		
	mulu	d4,d6
	add.l	d6,a1
	
	bsr	copy_block_to_block; copy to screen
	
*now put back to pick stage
quit_copy_block
	move.w #PICK,sprite_to_attach
	move.w	#MODE_COPY_BLOCK,block_mode				
	rts	
	


*****CODE TO EXCHANGE A BLOCK	
******************************************
****     GET EXCHANGE BLOCK POSITION *****
******************************************
get_exchange_block_position
        move.w mouse_x,store_x
        move.w mouse_y,store_y
        move.l page_pointer,a0
        move.w screen_y_pos(a0),store_off_y
        move.l page_pointer,store_page
        move.w #TO,sprite_to_attach
        move.w #MODE_TO_EXCHANGE_BLOCK,block_mode
      	rts	


	
******************************************
****     FIND EXCHANGE TO POSITION   *****
******************************************
find_exchange_to_position

	bsr	convert_mouse_and_store
	
	move.l  page_pointer,a0
	move.w  d1,d6     ; store for later use
	add.w   screen_y_pos(a0),d1
	move.l  screen_mem(a0),a1
	asr.w	#3,d0
	move.l	#main_screen_struct,a2
	move.w  number_of_planes(a2),d7
	move.w	screen_x_size(a2),d4
	asr.w	#3,d4
	mulu	d4,d1		;get position down screen
	add.l	d1,a1
	add.l	d0,a1		; a1 contains dest address
	
	move.l  a1,a0
	move.l  #block_buffer,a1
	bsr	copy_block_to_buffer
	move.l  a0,a4 	;store dest address      
	
	move.l  store_page,a3
	move.w  d3,d5
	add.w store_off_y,d3	;add on old offset
	move.l screen_mem(a3),a0
	asr.w	#3,d2			
	mulu	d4,d3
	add.l   d3,a0
	add.l   d2,a0           ;a0 contains start address

	move.l  #block_buffer2,a1
	bsr     copy_block_to_buffer
	
	move.l  a4,a1     ;dest address
	move.l  a0,a4     ;store start address    
	move.l  #block_buffer2,a0
	bsr	copy_buffer_to_block
	
	move.l  a4,a1
	move.l  #block_buffer,a0
	bsr     copy_buffer_to_block
	
	move.l  #block_buffer2,a0
	move.l  screen_mem(a2),a1
	add.l   d0,a1		
	mulu	d4,d6
	add.l	d6,a1
	bsr	copy_buffer_to_block ; copy to screen position 1
	
	move.l screen_mem(a2),a1
	add.l   d2,a1
	mulu	d4,d5
	add.l	d5,a1
	move.l  #block_buffer,a0
	bsr	copy_buffer_to_block ; copy to screen position 2

	
*now put back to pick stage
	move.w #PICK,sprite_to_attach
	move.w #MODE_EXCHANGE_BLOCK,block_mode			
	rts	
	
**** xflip,yflip and rotate funcs



******************************************
**** GET BLOCK OPS POSITION          *****
******************************************
get_block_ops_position

	move.l #block_op_routines,a0
	moveq	#0,d0
	move.w current_block_op,d0
	add.l   d0,a0
	move.l  (a0),a0
	jsr     (a0)

	rts

******************************************
**** XFLIP THE BLOCK                 *****
******************************************
xflip_the_block

	bsr	convert_mouse_and_store
	move.l  page_pointer,a0
	move.l  #main_screen_struct,a1
	move.w	screen_x_size(a1),d2
	asr.w	#3,d2
	move.w	d2,d3
	move.w  d0,-(sp)
	move.w	d1,-(sp)
	add.w	screen_y_pos(a0),d1   ; add on offset
	move.l  screen_mem(a0),a0
	asr.w	#3,d0
	add.l	d0,a0
	move.w  d3,d5     ;for later
	mulu	screen_y_size(a1),d3	;for later
	move.w	number_of_planes(a1),d0
	mulu	d1,d2     ; y offset on page
	add.l	d2,a0     ; block position
	move.l  a0,a4     ;  store
	
	move.l #block_buffer,a1   ; dest
	move.l current_map_ptr,a2
	move.w	map_block_size(a2),d2
	subq.w	#1,d0     ; number of planes
xflip_planes_loop
	move.w	d2,d6     ; map block size
	subq.w	#1,d6
	move.l  a0,a2

block_lines_loop

	cmp.w	#8,d2
	bne.s	not_8x8
	bsr	xflip_8x8
	bra.s	update_xflip_planes
not_8x8
	cmp.w	#16,d2
	bne.s	not_16x16
	bsr	xflip_16x16
	bra.s   update_xflip_planes
not_16x16
	bsr	xflip_32x32
update_xflip_planes					
	
	add.l  d5,a2   ;move down one page line
	dbra	d6,block_lines_loop
	add.l  d3,a0     ;plane size
	
	dbra    d0,xflip_planes_loop
	
	
	move.l a4,a1
	move.l #block_buffer,a0
	move.l #main_screen_struct,a2
	move.w number_of_planes(a2),d7
	bsr	copy_buffer_to_block
	
	move.l #main_screen_struct,a1
	move.l screen_mem(a1),a1
	move.w	(sp)+,d0
	mulu	d5,d0
	add.l	d0,a1
	moveq	#0,d0
	move.w	(sp)+,d0
	asr.w	#3,d0
	add.l	d0,a1
	bsr	copy_buffer_to_block
	
	rts

	
xflip_8x8
	movem.l a2-a3/d0,-(sp)
	moveq	#7,d7
	move.b  (a2),d4
xflip_8x8_loop	
	ror.b     d4	
	roxl.b    d0
	dbra	d7,xflip_8x8_loop
	move.b    d0,(a1)+
	movem.l (sp)+,a2-a3/d0
	rts
	
xflip_16x16
	movem.l a2-a3/d0,-(sp)
	moveq	#15,d7
	move.w  (a2),d4
xflip_16x16_loop
	roxr.w   d4
	roxl.w  d0
	dbra	d7,xflip_16x16_loop
	move.w  d0,(a1)+
	movem.l (sp)+,a2-a3/d0
	rts
		
xflip_32x32
	movem.l a2-a3/d0,-(sp)
	moveq	#31,d7
	move.l  (a2),d4
xflip_32x32_loop
	roxr.l     d4
	roxl.l    d0
	dbra	d7,xflip_32x32_loop
	move.l    d0,(a1)+
	movem.l (sp)+,a2-a3/d0
	rts
		
		
******************************************
**** YFLIP THE BLOCK                 *****
******************************************
yflip_the_block

	bsr  convert_mouse_and_store	
	move.l page_pointer,a0
	move.w screen_y_pos(a0),d2
	move.l screen_mem(a0),a0    
	asr.w  #3,d0
	add.l  d0,a0
	move.l #main_screen_struct,a1
	move.w screen_x_size(a1),d3
	asr.w	#3,d3
	move.w  d1,d4
	add.w   d2,d4
	mulu	d3,d4
	add.l   d4,a0     ;source
	move.l  a0,a4     ;store
	
	move.l  current_map_ptr,a2
	move.w  map_block_size(a2),d4
	move.w  number_of_planes(a1),d5
	subq.w	#1,d5
yflip_planes
	move.l a0,a5
	move.w	d4,d7
	subq.w	#1,d7
	mulu	d3,d7	;end of block
	add.l   d7,a5   ; end of block
	
	move.w  d4,d7
	asr.w	d7
	subq.w	#1,d7
	move.l  a0,a3
yflip_lines
	cmp.w	#8,d4
	bne.s	yflip_16
	move.b  (a3),d6
	move.b  (a5),(a3)
	move.b  d6,(a5)
	bra.s	update_block_line	
yflip_16
	cmp.w	#32,d4
	beq.s	yflip_32
	move.w  (a3),d6
	move.w  (a5),(a3)
	move.w  d6,(a5)
	bra.s	update_block_line	
yflip_32
	move.l  (a3),d6
	move.l  (a5),(a3)
	move.l  d6,(a5)
update_block_line
	add.l	d3,a3
	sub.l   d3,a5
	dbra	d7,yflip_lines
	
	move.w   d3,d7
	mulu	screen_y_size(a1),d7
	add.l	d7,a0
	dbra	d5,yflip_planes
		
	move.w  number_of_planes(a1),d7	
	move.l  screen_mem(a1),a1
	mulu	d3,d1
	add.l   d1,a1
	add.l	d0,a1
	move.l  a4,a0
	bsr	copy_block_to_block				
		
	rts

******************************************
**** ROTATE THE BLOCK                *****
******************************************
rotate_the_block

	
	bsr  convert_mouse_and_store	
	move.l page_pointer,a0
	move.w screen_y_pos(a0),d2
	move.l screen_mem(a0),a0    
	asr.w  #3,d0
	add.l  d0,a0
	move.l #main_screen_struct,a1
	moveq	#0,d3
	move.w screen_x_size(a1),d3
	asr.w	#3,d3
	move.w  d1,d4
	move.w  d1,-(sp)
	add.w   d2,d4
	mulu	d3,d4
	add.l   d4,a0     ;source
	move.l  a0,a5     ;store
	
	move.l  current_map_ptr,a2
	move.w  map_block_size(a2),d4
	move.w  number_of_planes(a1),d5
	subq.w	#1,d5
	move.l  #block_buffer,a4     ;dest
	
rotate_planes_loop
	move.w	d4,d2
	subq.w	#1,d2
	move.l  a0,a2
rotate_lines_loop
	move.l  a4,a3
	move.w  d4,d7	
	subq.w	#1,d7
rotate_bits_loop
	
	cmp.w	#8,d4
	bne.s   check_rot16
	move.b  (a2),d6
	roxl.b	d6
	move.b  d6,(a2)
	move.b	(a3),d6
	roxr.b  d6
	move.b  d6,(a3)+
	bra.s	update_rot_line
check_rot16
	cmp.w	#16,d4
	bne.s	rotate_32
	move.w  (a2),d6
	roxl.w	d6
	move.w  d6,(a2)
	move.w   (a3),d6
	roxr.w  d6
	move.w  d6,(a3)+
	bra.s	update_rot_line
rotate_32
	move.l  (a2),d6
	roxl.l	d6
	move.l  d6,(a2)
	move.l  (a3),d6
	roxr.l  d6
	move.l  d6,(a3)+
update_rot_line
	dbra	d7,rotate_bits_loop
	
	add.l	d3,a2	; next line of block
	
	dbra	d2,rotate_lines_loop	
		
	move.w   d3,d7
	mulu	screen_y_size(a1),d7
	add.l	d7,a0
	
	move.w  d4,d7
	asr.w	#3,d7
	mulu	d4,d7
	add.l   d7,a4  
	
	dbra	d5,rotate_planes_loop
	
	move.w	number_of_planes(a1),d7
	move.l  #block_buffer,a0
	move.l  a5,a1
	bsr	copy_buffer_to_block		

	move.l  #main_screen_struct,a1
	move.l  screen_mem(a1),a1
	move.w  (sp)+,d4
	mulu	d3,d4
	add.l   d4,a1
	add.l   d0,a1
	bsr	copy_buffer_to_block

	rts

	
	
*****CODE TO COMBINE A BLOCK	
	
	
******************************************
****     GET COMBINE BLOCK POSITION *****
******************************************
get_combine_block_position
        move.w mouse_x,store_x
        move.w mouse_y,store_y
        move.l page_pointer,a0
        move.w screen_y_pos(a0),store_off_y
        move.l page_pointer,store_page
        move.w #WITH,sprite_to_attach
        move.w #MODE_TO_COMBINE_BLOCK,block_mode
      	rts	


	
******************************************
****     FIND COMBINE WITH POSITION   *****
******************************************
find_combine_with_position

	bsr	convert_mouse_and_store
	
	move.l  a6,-(sp)
	moveq	#0,d4
	move.l  page_pointer,a0
	move.w  d1,-(sp)     ; store for later use
	add.w   screen_y_pos(a0),d1
	move.l  screen_mem(a0),a1
	asr.w	#3,d0
	move.l  d0,-(sp)
	move.l	#main_screen_struct,a2
	move.w  number_of_planes(a2),d7
	move.w	screen_x_size(a2),d4
	asr.w	#3,d4
	mulu	d4,d1		;get position down screen
	add.l	d1,a1
	add.l	d0,a1		; a1 contains dest address

	move.l  store_page,a3
	move.w  d3,d5
	add.w store_off_y,d3	;add on old offset
	move.l screen_mem(a3),a0
	asr.w	#3,d2			
	mulu	d4,d3
	add.l   d3,a0
	add.l   d2,a0           ;a0 contains start address

	move.w	#31,d3
	move.l  #block_buffer,a6
clear_mask_out
	clr.l   (a6)+
	dbra	d3,clear_mask_out
		
		
	move.l  current_map_ptr,a4
	move.w  map_block_size(a4),d2
	
	move.l  a0,a6
	move.w   number_of_planes(a2),d6
	subq.w	#1,d6
make_mask_planes	
	move.l  #block_buffer,a3
	move.l  a6,a4
	move.w  d2,d3
	subq.w  #1,d3
make_mask
	cmp.w	#8,d2
	bne.s	try16gfd
	move.b   (a3),d5
	or.b	(a4),d5
	move.b  d5,(a3)+
	bra.s	fuck_this
try16gfd
	cmp.w	#16,d2
	bne.s	try32fdfds
	move.w   (a3),d5
	or.w     (a4),d5
	move.w   d5,(a3)+
	bra.s    fuck_this
try32fdfds
	move.l  (a3),d5
	or.l    (a4),d5
	move.l  d5,(a3)+
fuck_this	
	add.l   d4,a4		;next line
	dbra	d3,make_mask
	move.l  d4,d5
	mulu	screen_y_size(a2),d5
	add.l   d5,a6
	dbra	d6,make_mask_planes
**********finish	


	move.l  a1,a5
	move.l  current_map_ptr,a4
	move.w  map_block_size(a4),d2
	subq.w	#1,d7
combine_planes_loop
	move.l  a0,a3
	move.l  a1,a4
	move.l  #block_buffer,a6	
	move.w  d2,d3
	subq.w	#1,d3
combine_planes_lines_loop		

****add so block buffer in referenced for block mask		
	cmp.w	#8,d2
	bne.s	combine_16
	move.b  (a4),d6
	move.b  (a6)+,d5
	not.b   d5
	and.b   d5,d6
	or.b    (a3),d6
	move.b  d6,(a4)
	bra.s	update_combine_line
combine_16
	cmp.w	#16,d2
	bne.s	combine_32
	move.w  (a4),d6
	move.w  (a6)+,d5
	not.w	d5
	and.w   d5,d6
	or.w    (a3),d6
	move.w  d6,(a4)
	bra.s	update_combine_line
combine_32
	move.l  (a4),d6
	move.l  (a6)+,d5
	not.l	d5
	and.l   d5,d6
	or.l    (a3),d6
	move.l  d6,(a4)
update_combine_line
	add.l	d4,a4
	add.l   d4,a3
	dbra	d3,combine_planes_lines_loop
	
	move.l  d4,d5
	mulu	screen_y_size(a2),d5
	add.l   d5,a0
	add.l   d5,a1
	dbra	d7,combine_planes_loop

	move.l screen_mem(a2),a1
	move.w number_of_planes(a2),d7
	move.l  (sp)+,d2
	add.l   d2,a1
	move.w  (sp)+,d2
	mulu	d4,d2
	add.l	d2,a1
	move.l  a5,a0
	bsr	copy_block_to_block ; copy to screen position 2

	move.l  (sp)+,A6	
*now put back to pick stage
*user must click exit to get out
	move.w #PICK,sprite_to_attach
	move.w #MODE_COMBINE_BLOCK,block_mode					
	rts	
	
current_block_op
	dc.w 0
	
block_op_routines
	dc.l xflip_the_block
	dc.l yflip_the_block
	dc.l rotate_the_block	
	dc.l enter_block_into_group
	dc.l edit_single_block

XFLIP EQU 0
YFLIP EQU 1
ROTATE EQU 2	
	
	
PICK EQU 1
WITH EQU 2
TO   EQU 3
	
sprite_to_attach		
	dc.w 0
	
block_buffer
	ds.w  32*5*2	
	
block_buffer2
	ds.w  32*5*2
	
blank_buffer
	ds.w  32*5*2		
	
	
	
***************************************
***** SELECT BLOCK MODE            ****
***************************************
select_block_mode

	move.l #detect_generic_button,a0
	bsr    display_button

	move.l	clicked_button,a0
	moveq	#0,d0
	move.b	button_data(a0),d0
	move.w	d0,block_mode
	sub.w	#MODE_XFLIP_BLOCK,d0
	move.w	d0,current_block_op	
	move.w	#PICK,sprite_to_attach
	move.w	#1,generic_button_up
	rts	


generic_button_up
	dc.w	0
	
***************************************
***** SELECT RELAVANT MODE         ****
***************************************
select_relavant_mode	

	move.l	#block_mode_table,a0
	moveq	#0,d0
	move.w	block_mode,d0
	move.l	(a0,d0),a0
	jsr	(a0)	;call function	
	rts
	
block_mode
	dc.w	0	

	

	
MODE_COPY_BLOCK		EQU 0
MODE_EXCHANGE_BLOCK	EQU 4
MODE_MOVE_BLOCK		EQU 8
MODE_COMBINE_BLOCK	EQU 12
MODE_TO_COPY_BLOCK	EQU 16
MODE_TO_EXCHANGE_BLOCK	EQU 20
MODE_TO_MOVE_BLOCK	EQU 24
MODE_TO_COMBINE_BLOCK	EQU 28
MODE_XFLIP_BLOCK	EQU 32
MODE_YFLIP_BLOCK	EQU 36
MODE_ROTATE_BLOCK	EQU 40
MODE_EDIT_BLOCK		EQU 44
MODE_EDIT_SINGLE_BLOCK	EQU 48

block_mode_table

	dc.l	get_copy_block_position
	dc.l	get_exchange_block_position
	dc.l	get_block_position
	dc.l	get_combine_block_position
	
	dc.l	find_copy_to_position
	dc.l	find_exchange_to_position
	dc.l	find_move_to_position
	dc.l	find_combine_with_position
	
	dc.l	get_block_ops_position
	dc.l	get_block_ops_position	
	dc.l	get_block_ops_position	
	dc.l	get_block_ops_position
	dc.l	get_block_ops_position
