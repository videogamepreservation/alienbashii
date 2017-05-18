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


MEM_CHIP	EQU $02
MEM_FAST EQU $04
MEM_CLEAR EQU $10000

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
	move.l	#MEM_FAST+MEM_CLEAR,d1	        	; chip and clear
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

	bsr	clear_old_data	
	bsr	setup_plane_offsets
	
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
	move.b	#0,pointer_state
	move.l	(sp)+,a6
	move.l  page_pointer,a0
	move.l  screen_palette(a0),a1
	bsr	setup_screen_colours
	bsr     display_graphic_page    ;display picture
	rts	

compressed_data
	bsr	loadabit	
	move.b	d0,d1
	tst.b	d1		;loop
	bmi	repeat_data
	addq.b	#1,d1
	bra.s	read_and_insert
loop_read
	cmp.l	#0,size_of_pic
	bgt.s	compressed_data
	rts
read_and_insert
	bsr	loadabit
	subq.b	#1,d1
	bsr	insert_byte	
	cmp.b	#0,d1
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
	bsr	loadabit
repeat_loop
	bsr	insert_byte
	subq.b	#1,d1		
	bne.s	repeat_loop
	bra.s	loop_read
uncompressed_data	
	bsr	loadabit
	bsr	insert_byte
	cmp.l	#0,size_of_pic
	bgt.s	uncompressed_data
	rts
	
********************************
**** INSERT BYTE           ***** 		
********************************
insert_byte	
        move.l  page_pointer,a0
	move.l	screen_mem(a0),a0
	moveq	#0,d2
	moveq	#0,d3
	move.w	current_plane,d3
	move.l	#plane_positions,a2
	asl.w	#2,d3
	
	move.l	(a2,d3.l),d4
	move.b	d0,(a0,d4.l)
        move.l  #main_screen_struct,a5
	addq.l	#1,(a2,d3.l)
	addq.w	#8,pixel_count
	move.w	screen_x_size(a5),d3
	cmp.w	pixel_count,d3
	bne.s	not_done_line
	bra.s	update_planes
not_done_line
        move.l  page_pointer,a5
	move.w	RWIDTH(a5),d2
	add.w	#15,d2
	andi.w	#$fff0,d2
	cmp.w	pixel_count,d2
	bne.s	not_done_yet
	moveq	#0,d2
	move.w	#320,d2            ;naughty naughty
	sub.w	pixel_count,d2
	asr.w	#3,d2
	move.w  current_plane,d3
	asl.w	#2,d3
	add.l	d2,(a2,d3.l)	move onto next line
update_planes
	move.w	#0,pixel_count
	addq.w	#1,current_plane
	move.l  page_pointer,a5
	move.w	number_of_planes(a5),d3
	cmp.w	current_plane,d3
	bne.s	not_done_line
	move.w	#0,current_plane
not_done_yet	
	rts
	
loadabit
	moveq	#0,d0
	move.b	(a1)+,d0		;pointer to pic data
	sub.l	#1,size_of_pic
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
	move.l	#MEM_FAST+MEM_CLEAR,d1
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
	move.w screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	mulu	number_of_planes(a0),d0
	asr.l	#2,d0
	move.l  page_pointer,a0
	move.l  screen_mem(a0),a0
clear_old_data_loop	
	clr.l   (a0)+
	subq.l  #1,d0
	bne.s  clear_old_data_loop
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
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	move.w	number_of_planes(a0),d1
	subq.w	#1,d1
	moveq	#0,d2
	move.l	#plane_positions,a0
calculate_offsets	
	move.l	d2,(a0)+
	add.l	d0,d2
	dbra	d1,calculate_offsets

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


***write out header
	move.l	#"FORM",save_buffer	
	move.l	d0,d1
	move.l	#save_buffer,d2
	move.l   #4,d3
	jsr	WRITE(a6)
	
***calculate size of file
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	mulu	screen_y_size(a0),d0
	mulu	number_of_planes(a0),d0	;size of pic	
	add.l	#4+4+4+4+4+4+4,d0	;BMHD,CMAP,BODY text, BMHDSIZE and BODY SIZE  + number of colours
	add.l	#size_of_bmhd,d0
	add.l	#3*16,d0		;colours	(16)
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
	
	move.l	#16*3,save_buffer	;number of colours
	move.l	save_file_handle,d1
	move.l	#save_buffer,d2
	move.l  #4,d3
	jsr	WRITE(a6)
	
	move.l	save_file_handle,d1
	move.l	#Default_Colours,d2
	move.l  #16*3,d3
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
	mulu	number_of_planes(a0),d0
	
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
	move.l	screen_mem(a0),a1
	subq.w	#1,d0
write_pic_loop
	move.l	a1,a2
	move.w	number_of_planes(a0),d2
	subq.w	#1,d2	
write_plane_pic_loop

	movem.l	a0-a2/d0-d2,-(sp)		;write line 
	move.l	d1,d3	;size
	move.l	save_file_handle,d1  ;handle
	move.l	a2,d2		;place to get from
	jsr	write(a6)
	movem.l	(sp)+,a0-a2/d0-d2
	
	move.l	d1,d4
	mulu	screen_y_size(a0),d4	;plane size
	add.l	d4,a2
	dbra	d2,write_plane_pic_loop
	
	add.l	d1,a1
	dbra	d0,write_pic_loop
	
	move.l	save_file_handle,d1
	jsr	CLOSE(a6)
quit_save_pic
	movem.l	(sp)+,a6
exit_save_pic
	move.b	#0,pointer_state
	rts
	
********************************
**** SETUP BMHD            ***** 		
********************************	
setup_bmhd
	move.l #main_screen_struct,a0
	move.l #save_bmhd,a1
	move.w screen_x_size(a0),RWIDTH(a1)
	move.w screen_y_size(a0),RHEIGHT(a1)
	move.w #0,XPOS(a1)
	move.w #0,YPOS(a1)
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
	move.b #16*3,ALLOCCOLS(a1)
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
	movem.l	d0-d5/a0-a1,-(sp)
	move.l	num_of_cols,d5
	divu	#3,d5
	sub.w	#1,d5
	move.l  colour_map_ptr,a1
insert_colours
	moveq	#0,d3
	moveq	#0,d4
	move.b	(a1)+,d3
	lsl.w	#4,d3
	or.b	(a1)+,d3
	move.b	(a1)+,d4
	lsr.w	#4,d4
	or.w	d4,d3
	move.w d3,(a0)+
	moveq	#0,d0
	dbra d5,insert_colours	
	movem.l	(sp)+,d0-d5/a0-a1
	rts

		
save_file_handle
	dc.l	0
save_buffer
	dc.l	0	

	rsreset
	

RWIDTH		rs.W	1
RHEIGHT		rs.W	1
XPOS		rs.W	1
YPOS		rs.W	1
NUMPLANES	rs.B	1
PMASK		rs.B	1
TYPECOM		rs.B	1
PAD		rs.B	1
TRANSCOLOUR	rs.W	1
XASPECT		rs.B	1
YASPECT		rs.B	1
PAGEWIDTH	rs.W	1
PAGEHEIGHT	rs.W	1
ALLOCCOLS	rs.B	1
		
		EVEN
		
size_of_BMHD EQU 8+4+2+2+4+2
		
save_bmhd
	ds.b size_of_BMHD		
	EVEN
				
PICTURE_DETAILS	
	dc.l	0		
buffer
	ds.l	1	
pic_pointer	
	dc.l	0	
header_size	
	dc.l	0		
colour_map_ptr  
	dc.l	0	
num_of_cols
	dc.l	0			
picture_data
	dc.l	0	
size_of_pic
	dc.l	0		
graphics_handle
	dc.l	0	

		
current_plane	dc.w	0	
pixel_count	dc.w	0


plane_positions
	ds.l	6	;maximum ever

picture_struct1
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_1_palette
picture_struct2
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_2_palette

picture_struct3
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_3_palette

picture_struct4
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_4_palette

picture_struct5
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_5_palette

pic_1_palette
        DC.W $222,$888,$555,$bbb,$666,$f33,$fff,$121
        DC.W $22d,$22d,$22d,$22d,$000,$c00,$0c0,$00c
        dc.w  $f00,$f00,$f00,$f00
        dc.w  $c00,$b00,$b00,$b00
        dc.w  $900,$700,$700,$700
        dc.w  $700,$700,$700,$700
	
pic_2_palette
           DC.W $222,$888,$555,$bbb,$666,$f33,$fff,$121
        DC.W $22d,$22d,$22d,$22d,$000,$c00,$0c0,$00c
	dc.w  $f00,$f00,$f00,$f00
 	dc.w  $c00,$b00,$b00,$b00
	dc.w  $900,$700,$700,$700
	dc.w  $700,$700,$700,$700

pic_3_palette
        DC.W $222,$888,$555,$bbb,$666,$f33,$fff,$121
	DC.W $22d,$22d,$22d,$22d,$000,$c00,$0c0,$00c
	dc.w  $f00,$f00,$f00,$f00
	dc.w  $c00,$b00,$b00,$b00
	dc.w  $900,$700,$700,$700
	dc.w  $700,$700,$700,$700

pic_4_palette
        DC.W $222,$888,$555,$bbb,$666,$f33,$fff,$121
	DC.W $22d,$22d,$22d,$22d,$000,$c00,$0c0,$00c

	dc.w  $f00,$f00,$f00,$f00
	dc.w  $c00,$b00,$b00,$b00
	dc.w  $900,$700,$700,$700
	dc.w  $700,$700,$700,$700

pic_5_palette
         DC.W $222,$888,$555,$bbb,$666,$f33,$fff,$121
	DC.W $22d,$22d,$22d,$22d,$000,$c00,$0c0,$00c


	dc.w  $f00,$f00,$f00,$f00
	dc.w  $c00,$b00,$b00,$b00
	dc.w  $900,$700,$700,$700
	dc.w  $700,$700,$700,$700





Default_Colours
	dc.b $f0,$f0,$f0
	dc.b $e0,$e0,$e0
	dc.b $d0,$d0,$d0
	dc.b $c0,$c0,$c0
	dc.b $b0,$b0,$b0
	dc.b $a0,$a0,$a0
	dc.b $90,$90,$90
	dc.b $80,$80,$80
	dc.b $70,$70,$70
	dc.b $60,$60,$60
	dc.b $50,$50,$50
	dc.b $40,$40,$40
	dc.b $30,$30,$30
	dc.b $20,$20,$20
	dc.b $10,$10,$10
	dc.b $00,$00,$00
	EVEN


picture_pages
	dc.l picture_struct1
	dc.l picture_struct2
	dc.l picture_struct3
	dc.l picture_struct4
	dc.l picture_struct5
	
page_pointer
	dc.l picture_struct1	
