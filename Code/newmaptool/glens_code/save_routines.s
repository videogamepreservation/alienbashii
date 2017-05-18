***************************************
*******   SAVE MAP                *****
***************************************
save_map
	move.l	a6,-(sp)

	move.l	d0,save_map_handle
	
	tst.b	save_map_type
	beq.s	dont_save_file_header
	
	move.l	#"DARK",map_save_buffer
	move.l	d0,d1
	move.l	#map_save_buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	-48(a6)
	
	move.l	dosbase,a6
	move.l	save_map_handle,d1
	move.l	current_map_ptr,d2
	move.l	#2+2+2+2+2,d3
	jsr	-48(a6)
dont_save_file_header
	move.l	save_map_handle,d1
	move.l  current_map_ptr,a0
	move.l  map_mem(a0),d2
	move.w	map_xsize(a0),d3
	move.w	map_datasize(a0),d7
	asl.w	d7,d3
	mulu	map_ysize(a0),d3
	move.l	dosbase,a6
	jsr	-48(a6)	

*	---------------------	*

	ifd	USE_ALIEN_DATA
	
*save alien data straight after map

	move.l	save_map_handle,d1
	move.l  current_map_ptr,a0
	move.l  map_alien_mem(a0),d2
	move.w	map_xsize(a0),d3
	mulu	map_ysize(a0),d3
	move.l	dosbase,a6
	jsr	-48(a6)	
	
	endc

*	---------------------	*



	move.l	dosbase,a6
	move.l	save_map_handle,d1
	jsr	-36(a6)
			
	move.l	(sp)+,a6
	rts

save_map_handle
	dc.l	0
save_map_type
	dc.b	1
	EVEN
	
map_save_buffer
	dc.l	0	
	
**********************************
**** SAVE A MAP              *****
**********************************

save_a_map
	bsr	remove_save_map_window
	move.l	#save_map_file,File_Routine_Pointer
	bsr	display_file_request
	rts

***************************************
*******   CHANGE MAP SAVE TYPE    *****
***************************************
change_map_save_type

	bchg.b	#0,save_map_type

	rts

**********************************
**** SAVE MAP FILE           *****
**********************************

save_map_file
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_NEW,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_save_it


	bsr	save_map
	bra.s	close_save_request
couldnt_save_it
         jsr	display_error
         bra.s	skip_save_cl
close_save_request         
        movem.l	d0,-(sp)
	bsr	remove_file_request
	movem.l	(sp)+,d0
skip_save_cl
         rts


*****************************************
********  SET UP SAVE MAP     ***********
*****************************************
set_up_save_map

	bsr	set_original_colours
	move.b	#1,save_map_type
	move.l	#save_map_window,a0
	bsr	create_window
	
	
	move.l	#save_map_window,a0	
	move.l	#save_map_text,a1
	move.w	#15,d0
	move.w	#6,d1
	move.w	#1,d2
	move.w	#1,d3
	bsr	write_text

	move.l	#map_save_buttons,a0
	bsr	display_button_list

	rts
	

*****************************************
********  REMOVE SAVE MAP WINDOW ********
*****************************************
remove_save_map_window

	move.l	#map_save_buttons,a0
	bsr	remove_button_list
	
	move.l	#save_map_window,a0
	bsr	destroy_window
	bsr	set_current_page_colours	
	rts
	
save_map_window
	dc.w 272
	dc.w 120
	dc.w 20
	dc.w 20
	dc.l 0
	dc.l 0
	dc.b "SAVE MAP",0
	EVEN

save_map_text
	dc.b	"Do you want to save",$a
	dc.b	"the file as an editor",$a	
	dc.b	"file or as raw data?",$a,$a,$a,-2,5
	dc.b  	"   Editor File",0
	EVEN
	
	
map_save_buttons
	dc.l	map_save_ok,map_save_cancel,map_save_type,-1
	
	
map_save_ok
	dc.w	32+8
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	save_a_map
	dc.b	0		
	even
	
map_save_cancel
	dc.w	32+96+8
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	remove_save_map_window
	dc.b	0		
	even
	
map_save_type
	dc.w	158+8	
	dc.w	62
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	tick_box_button	
	dc.l	0	;not used
	dc.l	change_map_save_type
	dc.b	0		
	EVEN				
	
	
	
**********************************
**** LOAD A MAP              *****
**********************************

load_a_map
	move.l	#load_map_file,File_Routine_Pointer
	bsr	display_file_request
	rts
	
**********************************
**** LOAD MAP FILE           *****
**********************************

load_map_file
	bsr	remove_undo
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_loadmap_it

	movem.l	d0/a0,-(sp)
	move.w	current_map,d0		;store map filename
	beq.s	looking_at_map1
	move.l	#Project_Map2,d0
	bra.s	set_map_info
looking_at_map1
	move.l	#Project_Map1,d0
set_map_info
	move.l	#Current_Filename,a0
	jsr	Set_Project_Information
	movem.l	(sp)+,d0/a0
				
	bsr	load_map
	tst.w	d0
	beq.s	no_loadmap_errors_here		
	jsr	error_routine
	bra.s	skip_close_req
couldnt_loadmap_it
         jsr	display_error
no_loadmap_errors_here
skip_close_req
	rts

**************************************
******* LOAD MAP               *******
**************************************
load_map
	move.l	d0,load_map_handle
	bsr	remove_edit_nums
	bsr	Load_Map_Data	
	movem.l	d0,-(sp)
	bsr	remove_file_request
	movem.l	(sp)+,d0
	tst	d0
	bne.s	skip_refresh
	bsr	display_map_on_screen
	bsr	display_blocks_on_screen
	moveq	#0,d0
skip_refresh	
	move.l	d0,-(sp)
	bsr	display_edit_nums
	move.l	(sp)+,d0
	rts

**************************************
******* LOAD MAP PROJ          *******
**************************************
load_map_proj
	move.l	d0,load_map_handle
	bsr	Load_Map_Data
	rts


*************************************
*** LOAD MAP DATA		 ****
*************************************
Load_Map_Data
*returns error in d0 (0=noerror)

	move.l	a6,-(sp)

	move.l	load_map_handle,d1
	move.l	#load_map_buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	-42(a6)
	
	cmp.l	#"DARK",load_map_buffer
	beq.s	correct_file_format
	move.w	#4000,d0
	bra	quit_load_map		
correct_file_format
	move.l	dosbase,a6
	move.l	load_map_handle,d1
	move.l	current_map_ptr,d2
	move.l	#2+2+2+2+2,d3
	jsr	Read(a6)
	
	bsr	convert_new_map
	
	move.l	load_map_handle,d1
	move.l	current_map_ptr,a0
	move.l	map_mem(a0),d2
	move.w	map_xsize(a0),d3
	move.w	map_datasize(a0),d4
	asl	d4,d3
	mulu	map_ysize(a0),d3
	jsr	Read(a6)	
	
	
*	---------------------	*

	ifd	USE_ALIEN_DATA
	
	move.l	load_map_handle,d1
	move.l	current_map_ptr,a0
	move.l	map_alien_mem(a0),d2
	move.w	map_xsize(a0),d3
	mulu	map_ysize(a0),d3
	jsr	Read(a6)	
	
	endc
	
*	---------------------	*			
	
	
	moveq	#0,d0
		
quit_load_map

	move.l	d0,-(sp)
	move.l	dosbase,a6
	move.l	load_map_handle,d1
	jsr	-36(a6)
	move.l	(sp)+,d0
	move.l	(sp)+,a6
	rts
	
load_map_handle
	dc.l	0	
load_map_buffer
	dc.l	0	
	
	
	
		
**********************************
**** SAVE BUFFERS            *****
**********************************

save_buffers
	move.l	#save_buffers_file,File_Routine_Pointer
	bsr	display_file_request
	rts


**********************************
**** SAVE BUFFERS FILE       *****
**********************************

save_buffers_file
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_NEW,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_savebuff_it

	bsr	save_buffers_file_to_disk
	bra.s	close_savebuff_request
couldnt_savebuff_it
         jsr	display_error
         bra.s	skip_save_clbuff
close_savebuff_request         
        movem.l	d0,-(sp)
	bsr	remove_file_request
	bsr	set_original_colours
	movem.l	(sp)+,d0
skip_save_clbuff
         rts



***************************************
*******   SAVE BUFFERS FILE TO DISK  **
***************************************
save_buffers_file_to_disk

	move.l	a6,-(sp)

	move.l	d0,save_map_handle
	bsr	set_original_colours		
	
	move.l	#"DBUF",map_save_buffer
	move.l	save_map_handle,d1
	move.l	#map_save_buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	-48(a6)


	move.l	current_map_ptr,a1		;store map block type
	move.w	map_datasize(a1),map_save_buffer	;bytes, words or longwords
	move.l	save_map_handle,d1
	move.l	#map_save_buffer,d2
	move.l	#2,d3
	move.l	dosbase,a6
	jsr	-48(a6)

	move.l	#buffers,a0
	move.w	#8,count	
save_buffers_loop
	
*save data info	
	move.l	save_map_handle,d1
	move.l	a0,d2
	move.l	#buffer_info_size,d3
	movem.l	a0,-(sp)
	move.l	dosbase,a6
	jsr	-48(a6)
	movem.l	(sp)+,a0
	
*save_buffer_data	
	move.l	save_map_handle,d1
	move.l	buffer_mem(a0),d2
	move.w	buffer_xsize(a0),d3
	mulu	buffer_ysize(a0),d3
	move.l	current_map_ptr,a1
	move.w	map_datasize(a1),d4	;bytes, words or longwords
	asl	d4,d3
	movem.l	a0,-(sp)
	move.l	dosbase,a6
	jsr	-48(a6)
	movem.l	(sp)+,a0
	
	add.l	#buffstructsize,a0
	subq.w	#1,count
	bne	save_buffers_loop	

	move.l	dosbase,a6
	move.l	save_map_handle,d1
	jsr	-36(a6)

	
	movem.l	(sp)+,a6
	rts
	
count
	dc.w	0	
	


	
**********************************
**** LOAD BUFFERS             *****
**********************************

load_buffers
	move.l	#load_buffers_file,File_Routine_Pointer
	bsr	display_file_request
	rts
	

	
	
**********************************
**** LOAD BUFFERS FILE       *****
**********************************

load_buffers_file
	bsr	remove_undo
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_loadbuff_it

	movem.l	d0/a0,-(sp)
	move.l	#Project_Buffers,d0
	move.l	#Current_Filename,a0
	jsr	Set_Project_Information	
	movem.l	(sp)+,d0/a0


	bsr	load_buffers_into_mem
	tst.w	d0
	beq.s	no_loadbuff_errors_here		
	jsr	error_routine
	bra.s	skip_close_reqbuff
couldnt_loadbuff_it
         jsr	display_error
no_loadbuff_errors_here
skip_close_reqbuff
	rts

**********************************
**** LOAD BUFFERS INTO MEM   *****
**********************************
load_buffers_into_mem

	move.l	d0,load_map_handle
	bsr	Load_Buffers_Data
	movem.l	d0,-(sp)
	bsr	remove_file_request
	bsr	set_original_colours
	movem.l	(sp)+,d0
		
	rts

**********************************
**** LOAD BUFFERS PROJ       *****
**********************************
load_buffers_proj

	move.l	d0,load_map_handle
	bsr	Load_Buffers_Data		
	rts


*****************************************
**** LOAD BUFFERS DATA  	   ******
*****************************************
Load_Buffers_Data

	move.l	a6,-(sp)

	move.l	load_map_handle,d1
	move.l	#load_map_buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	-42(a6)
	
	cmp.l	#"DBUF",load_map_buffer
	beq.s	correct_buff_format
	move.w	#5000,d0
	bra	quit_load_buff		
correct_buff_format


	move.l	load_map_handle,d1
	move.l	#load_map_buffer,d2
	move.l	#2,d3
	move.l	dosbase,a6
	jsr	-42(a6)

	move.l	current_map_ptr,a1		;store map block type
	move.w	map_datasize(a1),d0
	cmp.w	load_map_buffer,d0	;bytes, words or longwords
	beq.s	map_types_match	

	move.w	#5001,d0
	bra	quit_load_buff

map_types_match
	move.w	#8,count
	move.l	#buffers,a0
load_buff_loop

*read buff info
	move.l	load_map_handle,d1
	move.l	a0,d2
	move.l	#buffer_info_size,d3
	movem.l	a0,-(sp)
	move.l	dosbase,a6
	jsr	-42(a6)
	movem.l	(sp)+,a0

	move.l	load_map_handle,d1
	move.l	buffer_mem(a0),d2
	move.w	buffer_xsize(a0),d3
	mulu	buffer_ysize(a0),d3
	move.l	current_map_ptr,a1
	move.w	map_datasize(a1),d4	;bytes, words or longwords
	asl	d4,d3				

	move.l	a0,-(sp)	
	move.l	dosbase,a6
	jsr	-42(a6)
	movem.l	(sp)+,a0
	
	add.l	#buffstructsize,a0
	subq.w	#1,count
	bne	load_buff_loop	
         
         moveq	#0,d0
		
	
quit_load_buff

	move.l	d0,-(sp)
	move.l	dosbase,a6
	move.l	load_map_handle,d1
	jsr	-36(a6)
	move.l	(sp)+,d0
	movem.l	(sp)+,a6
	rts

Current_Map
	dc.w	0		;indicates which map looking at