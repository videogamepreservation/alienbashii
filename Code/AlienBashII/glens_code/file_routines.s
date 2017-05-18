open equ -30
close equ -36
read  equ -42
forbid equ -132
permit equ -138
disable equ -120
examine	equ	-$66
setprogramdir	equ	-$252
getprogramdir	equ	-$258

MODE_OLD	EQU   1005
MODE_NEW	EQU   1006

DRUGS_TUNE_LENGTH	EQU	20048
RAPINA4_TUNE_LENGTH	EQU	32834


*---------------------------Loading routines----------------

*************************************************
****      FIND PROGRAM DIRECTORY	    *****
*************************************************
Find_Program_Directory
	move.l	dosbase,a6
	jsr	getprogramdir(a6)	
	tst.l	d0
	beq.s	dont_move_dir
	move.l	d0,d1		;move to program dir
	move.l	dosbase,a6
	jsr	setprogramdir(a6)	
	move.l	d0,old_dir
dont_move_dir
	rts


*************************************************
****      RESET TO OLD DIRECTORY	    *****
*************************************************
Reset_To_Old_Directory
	tst.l	old_dir
	beq.s	dont_reset_dir	
	move.l	old_dir,d1
	move.l	dosbase,a6
	jsr	setprogramdir(a6)	
dont_reset_dir
	rts

old_dir		dc.l	0

*************************************************
****          LOAD SOUND EFFECTS	    *****
*************************************************
Load_Sound_Effects

	movem.l	a0-a6/d0-d7,-(sp)
		
	move.l	#Normal_Sound_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq	could_not_load_fx
	
	move.l	d0,-(sp)
	bsr	Return_Norm_Fx_Size	;get bytes to load
	move.l	(sp)+,d0
	move.l	d1,d3			; put in right reg
	move.l	d0,d1			; put handle in right reg
	move.l	sfx_mem,d2		; where to load
	move.l	dosbase,a6
	move.l	d1,-(sp)
	jsr	READ(a6)		;read in normal sfx
	move.l	(sp)+,d1
		
	move.l	dosbase,a6	
	jsr	close(a6)	
	
*ok do we load any xtra fx
	cmp.w	#OFF,xtra_fx
	beq.s	no_more_data_to_load
	
	move.l	#Extra_Sound_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq.s	could_not_load_fx

	move.l	d0,-(sp)
	bsr	Return_Norm_Fx_Size
	move.l	sfx_mem,d2
	add.l	d1,d2			;get to proper place
	bsr	Return_Extra_Fx_Size	;get bytes to load
	move.l	(sp)+,d0

	move.l	d1,d3			; put in right reg
	move.l	d0,d1			; put handle in right reg
	move.l	dosbase,a6
	move.l	d1,-(sp)
	jsr	READ(a6)		;read in normal sfx
	move.l	(sp)+,d1	
	move.l	dosbase,a6	
	jsr	close(a6)	
	
no_more_data_to_load	
	movem.l	(sp)+,a0-a6/d0-d7
	rts
could_not_load_fx
	move.w	#$777,$dff180
	bra.s	could_not_load_fx

Normal_Sound_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"snd.dat",0
	even

Extra_Sound_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"xsnd.dat",0
	even


*************************************************
****          LOAD BLOCK PAGE   	    *****
*************************************************
Load_Block_Page

	movem.l	a0-a6/d0-d7,-(sp)

	add.b	#48,d0
	move.b	d0,BlkPage_str+5		;set up filename

	move.l	Fast_Memory_Base,a0
	add.l	#LO_RES_PLANE*4,a0	;cos data is loaded into base of fast
	move.l	#plane_positions,a1
	move.l	a0,(a1)+		;set up explode planes
	add.l	#LO_RES_PLANE,a0
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	move.l	a0,(a1)+

	move.w	#320,screen_size
	move.w	#4,d7
		
	move.l	#Background_Blocks_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq.s	could_not_load_blocks
	bsr	Load_Graphics
	jsr	Release_System			;Load graphics stops it!!
	movem.l	(sp)+,a0-a6/d0-d7
	rts
could_not_load_blocks
	move.w	#$ff0,$dff180
	bra.s	could_not_load_blocks

BackGround_Blocks_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
BlkPage_Str	
	dc.b	"blkpgx.pic",0
	even


*************************************************
****          LOAD LOADER PIC    	    *****
*************************************************
Load_Loader_Pic

	movem.l	a0-a6/d0-d7,-(sp)
		
	move.l	#Loader_Pic_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq.s	could_not_load_piccy

	move.l	d0,d1
	move.l	loader_pic_data,d2
	move.l	#LOADER_PIC_SIZE,d3
	move.l	dosbase,a6
	move.l	d1,-(sp)
	jsr	READ(a6)		;read in details
	move.l	(sp)+,d1
	
	move.l	dosbase,a6	
	jsr	close(a6)	
	movem.l	(sp)+,a0-a6/d0-d7
	rts
could_not_load_piccy
	move.w	#$f7f,$dff180
	bra.s	could_not_load_piccy

Loader_Pic_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"nebula.pic",0
	even

loader_pic_data	dc.l	0
*************************************************
****          LOAD MAP FOR LEVEL	    *****
*************************************************
Load_Map_For_Level

	movem.l	a0-a6/d0-d7,-(sp)
	bsr	Wait_For_Blit_To_Finish
	
	jsr	release_system

	move.b	level_number,block_level
		
	move.l	#Blocks_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq.s	couldnt_loadmap_it

	move.l	d0,load_map_handle

	move.l	load_map_handle,d1
	move.l	#generic_map_header,d2
	move.l	#14,d3
	move.l	dosbase,a6
	jsr	READ(a6)		;read in details
	
	move.l	#generic_map_header,a0
	cmp.l	#"COMP",map_file_header(a0)
	beq.s	load_compressed_map_data
	move.w	map_data_x(a0),d3
	mulu	map_data_y(a0),d3
	mulu	#3,d3
	bra.s	load_the_map_data
load_compressed_map_data	
	move.l	map_planes(a0),d3	;actually map filesize for compressed

load_the_map_data	
	move.l	load_map_handle,d1
	move.l	memory_base,d2
	move.l	dosbase,a6
	jsr	READ(a6)		;read in all of data
				
	move.l	dosbase,a6	
	move.l	load_map_handle,d1
	jsr	close(a6)	
	jsr	stop_system
	movem.l	(sp)+,a0-a6/d0-d7
	rts
couldnt_loadmap_it	
	move.w	#$f00,$dff180
	bra.s	couldnt_loadmap_it
	

Blocks_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"level"
block_level
	dc.b	0
	dc.b	".cmp",0
	even
	
load_map_handle		dc.l 	0

*************************************************
****          LOAD INTRO TUNE    	    *****
*************************************************
Load_Intro_Tune

	jsr	Release_System

	move.l	#Title_Tune_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_title_tune
	move.l	d0,tune_handle
	move.l	d0,d1	;read into map buffer area
	move.l	memory_base,d2
	add.l	#HI_RES_PLANE*4,d2
	move.l	d2,current_song_ptr
	move.l	#DRUGS_TUNE_LENGTH,d3
	move.l	dosbase,a6
	jsr	READ(a6)
	
		
	move.l	dosbase,a6	;thank you
	move.l	tune_handle,d1
	jsr	close(a6)

	
	jsr	Stop_System
error_loading_title_tune
	move.l	#$dff000,a6
	rts

*************************************************
****          LOAD SHOP SCREEN TUNE    	    *****
*************************************************
Load_Shop_Screen_Tune

	jsr	Release_System

	move.l	#HiScore_Tune_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_hiscore_tune
	move.l	d0,tune_handle
	move.l	d0,d1	;read into map buffer area
	move.l	memory_base,d2
	add.l	#(LO_RES_PLANE*5)+40*PRODUCT_LIST_WINDOW_LENGTH+SHOP_SPRITES_LENGTH,d2
	move.l	d2,current_song_ptr
	move.l	#RAPINA4_TUNE_LENGTH,d3
	move.l	dosbase,a6
	jsr	READ(a6)
	
		
	move.l	dosbase,a6	;thank you
	move.l	tune_handle,d1
	jsr	close(a6)

	
	jsr	Stop_System
error_loading_hiscore_tune
	move.l	#$dff000,a6
	rts


tune_handle	dc.l	0	
	
Title_Tune_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"mod.drugs1",0
	even		
	
HiScore_Tune_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"mod.rapina4",0
	even		
	
	
*************************************************
****          LOAD TITLE PICTURE       	    *****
*************************************************
Load_Title_Picture

*set up information

	move.l	memory_base,a0
	move.l	#plane_positions,a1
	move.w	#4-1,d1
set_up_pic_planes
	move.l	a0,(a1)+
	add.l	#HI_RES_PLANE,a0
	dbra	d1,set_up_pic_planes
	move.w	#640,screen_size
	move.w	#4,d7	; no of planes


	tst	title_pic_loaded
	beq.s	load_the_pic
	bsr	display_the_picture
	rts	
	
load_the_pic
	move.w	#1,title_pic_loaded
	move.l	a6,-(sp)
	
	jsr	Release_System

	move.l	#Title_Picture_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_picture	
	bsr	Load_Graphics	
	move.l	(sp)+,a6
	rts	
error_loading_picture
	move.w	#$f,$dff180
	bra.s	error_loading_picture	

*************************************************
****      LOAD INSTRUCTIONS PICTURE         *****
*************************************************
Load_Instructions_Picture

*set up information

	move.l	memory_base,a0
	add.l	#TUBE_PLANE_SIZE*6,a0	;get past buffers!!
	move.l	#plane_positions,a1
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	move.l	a0,(a1)+

	move.w	#320,screen_size
	move.w	#3,d7

	move.l	a6,-(sp)
	
	jsr	Release_System

	move.l	#Instructions_Picture_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_instr
	bsr	Load_Graphics
	move.l	(sp)+,a6
	rts
error_loading_instr	
	move.w	#$0ff,$dff180
	bra.s	error_loading_instr


Instructions_Picture_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"Instructions.pic",0
	even		

*************************************************
****      LOAD END GAME PICTURE             *****
*************************************************
Load_EndGame_Picture

	move.l	memory_base,a0
	move.l	#plane_positions,a1
	move.w	#5-1,d0
insert_endgame_planes	
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	dbra	d0,insert_endgame_planes
	move.w	#320,screen_size
	move.w	#5,d7
	
	move.l	a6,-(sp)
	
	jsr	Release_System

	move.l	#Endgame_Picture_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_endgame
	bsr	Load_Graphics
	move.l	(sp)+,a6
	rts
error_loading_endgame
	move.w	#$0ff,$dff180
	bra.s	error_loading_endgame

EndGame_Picture_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"EndGame.pic",0
	even		


*************************************************
****      LOAD SHOP   PICTURE               *****
*************************************************
Load_Shop_Picture

*set up information

	move.l	memory_base,a0
	move.l	#plane_positions,a1
	move.w	#5-1,d1
set_shop_pic_planes
	move.l	a0,(a1)+
	add.l	#LO_RES_PLANE,a0
	dbra	d1,set_shop_pic_planes
	move.w	#320,screen_size
	move.w	#5,d7

	move.l	a6,-(sp)
	
	jsr	Release_System

	move.l	#Shop_Picture_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	tst.l	d0
	beq.s	error_loading_shop
	bsr	Load_Graphics	
	move.l	(sp)+,a6
	rts
error_loading_shop
	move.w	#$f0f,$dff180
	bra.s	error_loading_shop

Shop_Picture_Filename
	ifd	LOAD_FROM_HARD_DISK
	dc.b	"scratch:Game_Files/"
	endc
	dc.b	"Shop_Scr.pic",0
	even		

********************************
**** LOAD GRAPHICS         ***** 		
********************************
load_graphics
	
*send in file handle in d0
*returns pointer to struct containing pic mem pointers in a0
	move.l	d0,graphics_handle
	
	move.l	graphics_handle,d1	;read size of file
	move.l	#buffer,d2
	move.l	#4,d3
	move.l	dosbase,a6
	jsr	READ(a6)
	

	move.l	buffer_map_memory,d2
	move.l	buffer,d3
	move.l	graphics_handle,d1
	move.l	dosbase,a6
	jsr	READ(a6)	;read in all data
	
	move.l	buffer_map_memory,picture_details
	
	move.l	dosbase,a6	;thank you
	move.l	graphics_handle,d1
	jsr	close(a6)
	
	jsr	Stop_System	;turn off tasking


	move.l	picture_details,a1	
	
	move.w	iff_cols(a1),num_of_cols
	move.l	a1,colour_map_ptr
	add.l	#size_of_iff_header,colour_map_ptr
	move.w	iff_cols(a1),d0
	ext.l	d0
	asl	d0
	move.l	colour_map_ptr,picture_data
	add.l	d0,picture_data
	

	move.l	pic_data_size(a1),size_of_pic
	
*I know this is crap - but time is short

	tst.w	FadeAfterLoading
	beq	Display_The_Picture
	clr.w	FadeAfterLoading	
	move.l	#$dff000,a6
	movem.l	d0-d7/a0-a6,-(sp)
	tst	level_loading_flag
	beq.s	not_level_cols
	move.l	loader_pic_data,a0
	add.l	#size_of_iff_header+4,a0
	clr.w	level_loading_flag
	move.l	#black_list,a1
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	move.w	#2,fade_speed
	bsr	Fade_32_List_To_List	
	bra.s	skip_16_fade
not_level_cols		
	move.l	#game_list,a0
fade_the_cols	
	move.l	#black_list,a1
	move.l	#share_cols+2,a2
	move.w	#16-1,d7
	move.l	#store_text_nums,a3
	move.w	#2,fade_speed
	bsr	Fade_List_To_List
skip_16_fade	
	movem.l	(sp)+,d0-d7/a0-a6
	move.w	#BIT_PLANE_DMA+SPRITE_DMA,$dff000+DMACON
Display_The_Picture	
	
**set up pointers and variables so decompression is super quick	

	moveq	#0,d3		;index into plane table
	move.w	screen_size,d4		;screen x size
	
	asl	#2,d7	;number of planes ( *4 cos compare d3 with it - will inc by 4)
	
	move.w	d4,d6     ; pixel count size ( count down )
	
	move.l	picture_details,a3
	move.w	RWIDTH(a3),d5	; image loaded size
	add.w	#15,d5
	andi.w	#$fff0,d5
	
	move.l	#plane_positions,a2

	moveq	#0,d0		;clear
	
	move.l  (a2,d3),a4	;get first plane
	
	move.l	size_of_pic,d2


***Finished setup


		
	move.l	picture_data,a1
	move.l	picture_details,a0	
	cmp.b	#0,comp_type(a0)
	beq.s	call_uncom
	
	bsr	compressed_data
	bra.s	finished_uncom
call_uncom	
	bsr	uncompressed_data
finished_uncom	
	rts	

compressed_data
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,d2

	move.b	d0,d1
	bmi	repeat_data
	addq.b	#1,d1
	bra.s	read_and_insert
loop_read
	tst.l	d2
	bgt.s	compressed_data
	rts
read_and_insert
	move.b	(a1)+,(a4)+		;pointer to pic data
	subq.l	#1,d2

	subq.b	#1,d1
	
	subq.w	#8,d6		;pixel count
	bne.s	dont_up_p1
	bsr	Update_Planes
dont_up_p1	
	tst.b	d1
	bne.s	read_and_insert
	bra	loop_read
repeat_data		
	cmp.b	#-128,d1
	bne.s	do_something
	subq.l	#1,d2
	bgt.s	loop_read
	rts
do_something	
	neg.b	d1
	addq.b	#1,d1
	move.b	(a1)+,d0		;pointer to pic data
	subq.l	#1,d2

repeat_loop
	move.b	d0,(a4)+
	subq.w	#8,d6
	bne.s	dont_update_p2
	bsr	Update_Planes
dont_update_p2
	subq.b	#1,d1		
	bne.s	repeat_loop
	bra.s	loop_read
	
uncompressed_data	
	move.b	(a1)+,(a4)+		;pointer to pic data
	subq.w	#8,d6		;pixel count
	bne.s	dont_update_uncom_planes
	bsr	Update_Planes
dont_update_uncom_planes		
	subq.l	#1,d2
	bgt.s	uncompressed_data
	rts


********************************
**** UPDATE PLANES         ***** 		
********************************
update_planes
	move.l	a4,(a2,d3)
	move.w	d4,d6
	addq.w	#4,d3
	cmp.w	d7,d3	;compare curent plane with number of planes
	bne.s	not_done_yet
	clr.l	d3
not_done_yet	
	move.l	(a2,d3),a4	
	rts

	
********************************
**** INSERT COLS           ***** 		
********************************
insert_cols
***send place to put palette in  a0
	movem.l	d5/a0-a1,-(sp)
	move.w	num_of_cols,d5
	sub.w	#1,d5
	move.l  colour_map_ptr,a1
insert_dpaint_colours
	move.w	(a1)+,(a0)
	addq.l	#4,a0	;skip next copper instruction
	dbra d5,insert_dpaint_colours	
	movem.l	(sp)+,d5/a0-a1
	rts
	
colour_map_ptr		dc.l	0	

plane_positions		ds.l	5
	
screen_size		dc.w	0	

graphics_handle		dc.l	0
	
picture_details		dc.l	0

picture_data		dc.l	0

header_size		dc.l	0

colour_map_pointer	dc.l	0

number_of_cols		dc.l	0

size_of_pic		dc.l	0

num_of_cols		dc.w	0		
	
buffer			ds.l	1	

Title_Picture_Filename	
			ifd	LOAD_FROM_HARD_DISK
			dc.b	"scratch:Game_Files/"
			endc
			dc.b	"AlienBashTitle.pic",0
			even		


*************************************************
****          OPEN DOS           	    *****
*************************************************
Open_Dos	
	move.l	exec,a6			;open dos lib
	lea	DosLib,a1
	clr.l	d0
	jsr	-408(A6)
	move.l	d0,DosBase
	rts

*************************************************
****          CLOSE DOS           	    *****
*************************************************
Close_Dos
	move.l	4,a6
	move.l	dosbase,a1
	jsr	-414(a6)			;close dos
	rts


dosbase	dc.l	0
doslib	dc.b	"dos.library",0
	even

	rsreset
	
RWIDTH		rs.W	1
RHEIGHT		rs.W	1
NUMPLANES	rs.b	1
comp_type	rs.b	1
iff_cols	rs.w	1
pic_data_size	rs.l	1
size_of_iff_header	rs.l	1
		
		EVEN
