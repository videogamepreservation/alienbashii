**** Man this code is ROUGH!!!!!

 	section  maptool,code_c
	opt NODEBUG
	opt p=68000 	
	opt c-
	
	incdir	"tools:devpac/include"
	include "exec/exec_lib.i"
	include	"exec/exec.i"
	include	"libraries/dosextens.i"

	
	incdir	"code:maptool/"	
	include	"glens_code/equates.s"



STARTOFMAINCODE

	movem.l	d0/a0,-(sp)
	
	sub.l	a1,a1
	move.l  4.w,a6
	jsr	_LVOFindTask(a6)

	move.l	d0,a4

	tst.l	pr_CLI(a4)	; was it called from CLI?
	bne.s   fromCLI		; if so, skip out this bit...

	lea	pr_MsgPort(a4),a0
	move.l  4.w,a6
	jsr	_LVOWaitPort(A6)
	lea	pr_MsgPort(a4),a0
	jsr	_LVOGetMsg(A6)
	move.l	d0,returnMsg
	

fromCLI
	movem.l	(sp)+,d0/a0
	bsr	setup

	cmp.w	#0,error_flag
	bne	quit_prog
	
	move.l	$6c,oldint
	move.l	#interrupt,$6c
	
crap

	move.l	#$dff000,a6
	jsr	setup_button_list	 ;required for buttons to work

	
	move.l	#top_level_list,a0
	jsr	display_button_list		

	bsr  Calculate_Blocks_In_One_Page

	bsr	display_info_window
	
	bsr	mainroutine
	bsr	winddown	
quit_prog	
	tst.l	returnMsg		; Is there a message?
	beq.s	exitToDOS		; if not, skip...

	move.l	4.w,a6
        jsr	_LVOForbid(a6)          ; note! No Permit needed!

	move.l	returnMsg(pc),a1
	jsr	_LVOReplyMsg(a6)

exitToDOS
	rts

returnMsg dc.l	0

**********************************
*** INTERRUPT                 ****
**********************************
interrupt
	movem.l	d0-d7/a0-a6,-(sp)
	
	jsr	position_cursor
	bsr	readmouse
	bsr	position_box_sprite
	bsr     display_helpful_cursor
	tst.w	pressed
	bne.s	wait_for_frelease
	btst.b	#7,$bfe001
	bne.s	dont_switch
	move.w	#1,pressed
	bsr	switch_screens
	bra.s	dont_switch
wait_for_frelease	
	btst.b	#7,$bfe001
	beq.s	dont_switch
	clr.w	pressed
dont_switch	
	movem.l	(sp)+,d0-d7/a0-a6
	dc.w	$4ef9 
oldint	dc.l	0

pressed	dc.w	0

***********************************************
*****	MAINROUTINE                       *****
***********************************************


mainroutine
	tst.w	WorkBench_Mode
	bne.s	Skip_Extras

	bsr	sync
	bsr	button_handler	
	tst.w	window_count
	bne.s	skip_extras
	bsr	get_stick_readings
	bsr	Display_X_Y	
	jsr	Display_Alien_Name
	bsr	Read_keys
Skip_Extras	
	tst.b	quit_system
	beq.s	mainroutine	
       	rts

	
***********************************************
*****	SYNC                             *****
**********************************************	
sync
	move.w	#$0010,intreq(a6)
sc_sync	
	btst	#4,intreqr+1(a6)
	beq.s	sc_sync	
	rts


***********************************************
*****	   BUTTON  HANDLER                *****
***********************************************	
button_handler

	jsr	check_for_call_routine
	jsr	check_to_see_hit
	jsr	frig_for_editor
	jsr	delete_buttons
	jsr	draw_buttons
	rts
	
***********************************************
*****	   FRIG FOR EDITOR                *****
***********************************************	
frig_for_editor

***routine that breaks rules but is neccessary for
***editor system

	btst	#10,$dff016	;mouse button
	bne.s	right_not_hit
	cmp.w	#1,edit_data_flag
	bne.s	check_other_flag
	jsr	remove_alien_data
	bra	right_not_hit_by_user
check_other_flag	
	cmp.w	#1,edit_mode
	bne.s	check_graphic
	bsr	delete_map_block
	rts
check_graphic
	cmp.w	#2,edit_mode
	bne.s	right_not_hit_by_user
	bsr	cancel_block_ops	
	rts
right_not_hit		
	move.w	#0,right_first
right_not_hit_by_user	
	rts	
	
			

		
*****************************************************************
*Module Name	:setup						*
*Function	:sets up screen,allocates mem			*
*****************************************************************
setup
	bsr	open_dos

	bsr	open_graphics_library
	tst.l	d0
	beq	error_with_allocation

	move.l	#main_screen_struct,a0
	jsr	setup_screen_memory
	move.l	screen_mem(a0),d0
	
	tst.l	d0
	bne	allocated_screen_mem
	bra	error_with_allocation

				; otherwise quit

allocated_screen_mem


	bsr	allocate_picstruct_mem
	tst.l	d0
	beq	error_with_allocation
	
	bsr	allocate_map_mem
	tst.l	d0
	beq	error_with_allocation
	
	bsr	allocate_block_data_mem
	tst.l	d0
	beq	error_with_allocation

	move.l	#button_window_struct,a0
	jsr	setup_screen_memory
	move.l	screen_mem(a0),d0
	
	tst.l	d0
	bne	allocated_window_mem

	move.l	#main_screen_struct,a0		;give back screen mem
	jsr	deallocate_screen_memory
	bra	error_with_allocation

allocated_window_mem

	bsr	put_planes_in_copper
	
	bsr	Wait_For_Decent_Pos
	LEA	CUSTOM,A0

	move.l	#Copperl,d0
	move.w	d0,coplo
	swap	d0
	move.w	d0,cophi
	swap	d0
	
	MOVE.L	d0,COP1LCH(A0)
	
	MOVE.W	COPJMP1(A0),D0
	 
	
	move.l	#button_window_struct,a0
	move.l	screen_mem(a0),d0
	moveq	#0,d1
	move.w	screen_x_size(a0),d1
	asr.w	#3,d1
	mulu	screen_y_size(a0),d1


	MOVE.W	D0,BUTTONPLANELOW
	SWAP	D0
	MOVE.W	D0,BUTTONPLANEHIGH
	swap	d0
	
	add.l	d1,d0
	MOVE.W	D0,BUTTONPLANE2LOW
	SWAP	D0
	MOVE.W	D0,BUTTONPLANE2HIGH
	swap	d0

	add.l	d1,d0
	MOVE.W	D0,BUTTONPLANE3LOW
	SWAP	D0
	MOVE.W	D0,BUTTONPLANE3HIGH
	swap	d0

	add.l	d1,d0
	MOVE.W	D0,BUTTONPLANE4LOW
	SWAP	D0
	MOVE.W	D0,BUTTONPLANE4HIGH
	
	bsr	blank_sprites
	bsr	setup_colours
	bsr	low_pas_filter_off
	
	ifd	hard_only
	move.l	exec,a6
	jsr	forbid(a6)
	endc
	rts

error_with_allocation
	move.w	#1,error_flag
	rts	

**********************************
**** OPEN GRAPHICS LIBRARY    ****
**********************************
open_graphics_library
	move.l	exec,a6
	MOVE.L	#graf_name,A1
	jsr	-408(A6)		; OPEN GRAPHICS LIBRARY
	MOVE.L	D0,graphics_lib_ptr
	rts

**********************************
*** LOW PAS FILTER OFF        ****
**********************************
low_pas_filter_off
	bset #1,$bfe001
	rts


**********************************
*** ALLOCATE MAP  MEM         ****
**********************************
allocate_map_mem

	move.l	#map_details,a0
	bsr	Get_Map_Resources
	
	move.l	#map_details2,a0	;buffer map
	bsr	Get_Map_Resources
	rts	

MAX_DATA_BLOCKS	EQU	320*4		
MAX_BLOCKS_MEM	EQU	MAX_DATA_BLOCKS*2

**********************************
*** ALLOCATE BLOCK DATA  MEM  ****
**********************************
allocate_block_data_mem

	move.l	#MEM_FAST+MEM_CLEAR,d1
	move.l	exec,a6
	move.l	#MAX_BLOCKS_MEM,d0
	jsr	allocmem(a6)	;get mem
	tst.l	d0
	bne.s	got_block_data_mem
	move.l	#0,d0
	rts
got_block_data_mem
	move.l	d0,block_data_ptr
	rts

**********************************
*** DEALLOCATE BLOCK DATA  MEM****
**********************************
deallocate_block_data_mem

	move.l	exec,a6
	move.l	block_data_ptr,a1
	move.l	#MAX_BLOCKS_MEM,d0
	jsr	freemem(a6)	;free mem
	rts


block_data_ptr
	dc.l	0



**********************************
*** GET MAP RESOURCES         ****
**********************************
Get_Map_Resources	
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	tst	map_datasize(a0)
	beq.s	albyte_map
	asl.l	d0	;mulu again by 2 for word map	
albyte_map
	move.l	#MEM_FAST+MEM_CLEAR,d1
	movem.l	d7/a6/a0,-(sp)
	move.l	4,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,d7/a6/a0
	tst.l	d0
	bne.s	al_new_map_mem
*raise error
	move.l	#0,d0
	bra	end_map_al
al_new_map_mem
	move.l  d0,map_mem(a0)

*alocate alien map mem
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.l	#MEM_FAST+MEM_CLEAR,d1
	movem.l	d7/a6/a0,-(sp)
	move.l	4,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,d7/a6/a0
	tst.l	d0
	bne.s	al_new_al_map_mem
*raise error
	move.l	#0,d0
	bra	end_map_al
al_new_al_map_mem
	move.l	d0,map_alien_mem(a0)	
	move.w	map_datasize(a0),map_allocdatasize(a0)
	move.w	map_xsize(a0),map_allocx(a0)
	move.w	map_ysize(a0),map_allocy(a0)
end_map_al
	rts

**********************************
*** DEALLOCATE MAP MEM        ****
**********************************
Deallocate_Map_Mem
	move.l	#Map_Details,a0
	bsr	Free_Mem_Resources
	
	move.l	#Map_Details2,a0
	bsr	Free_Mem_Resources
	rts

**********************************
*** FREE MEM RESOURCES        ****
**********************************
Free_Mem_Resources	
	move.l	exec,a6
	move.l	map_mem(a0),a1
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.w	map_datasize(a0),d1
	lsl.l	d1,d0	;mulu by data size (0=byte)
	move.l	a0,-(sp)
	jsr	freemem(a6)
	move.l	(sp)+,a0
	move.l	exec,a6
	move.l	map_alien_mem(a0),a1
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	jsr	freemem(a6)

	rts


**********************************
*** ALLOCATE PICSTRUCT MEM    ****
**********************************
allocate_picstruct_mem

	movem.l a6,-(sp)
	
	move.l #main_screen_struct,a1
	move.w screen_x_size(a1),d3
	asr.w	#3,d3
	mulu	screen_y_size(a1),d3
	mulu	number_of_planes(a1),d3
	
	move.l  #picture_pages,a0
	moveq	#3,d2
allocate_piccy_mem
	move.l  #MEM_FAST+MEM_CLEAR,d1
	move.l  4,a6
	move.l  d3,d0
	movem.l  d2-d3/a0-a1,-(sp)
	jsr     -198(a6)
	movem.l  (sp)+,d2-d3/a0-a1
	tst.l	d0
	beq.s	pa_exit_with_error
	move.l  (a0),a1
	move.l	#main_screen_struct,a2
	move.l  d0,screen_mem(a1)
	move.w  number_of_planes(a2),number_of_planes(a1)
	move.w  screen_x_size(a2),screen_x_size(a1)
	move.w  screen_y_size(a2),screen_y_size(a1)
	
	addq.l	#4,a0		;next struct
	dbra    d2,allocate_piccy_mem
	moveq	#1,d0
pa_exit_with_error		
	movem.l (sp)+,a6
	rts

**********************************
*** DEALLOCATE PICSTRUCT MEM  ****
**********************************
deallocate_picstruct_mem

	movem.l a6,-(sp)
	move.l  #picture_pages,a0
	moveq	#3,d2
deallocate_piccy_mem
	move.l  (a0),a1
	move.l  screen_mem(a1),a1
	move.l  #main_screen_struct,a2
	move.w  screen_x_size(a2),d0
	asr.w	#3,d0
	mulu	screen_y_size(a2),d0
	mulu	number_of_planes(a2),d0
	move.l  4,a6
	movem.l  d2/a0,-(sp)
	jsr     -210(a6)
	movem.l  (sp)+,d2/a0
	addq.l	#4,a0		;next struct
	dbra    d2,deallocate_piccy_mem	
	movem.l (sp)+,a6
	rts


**********************************
*** PUT PLANES IN COPPER      ****
**********************************
put_planes_in_copper
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d1
	asr.w	#3,d1
	mulu	screen_y_size(a0),d1
	move.l	screen_mem(a0),d0
	MOVE.W	D0,PLANELOW
	SWAP	D0
	MOVE.W	D0,PLANEHIGH
	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE2LOW
	SWAP	D0
	MOVE.W	D0,PLANE2HIGH
	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE3LOW
	SWAP	D0
	MOVE.W	D0,PLANE3HIGH
	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE4LOW
	SWAP	D0
	MOVE.W	D0,PLANE4HIGH

	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE5LOW
	SWAP	D0
	MOVE.W	D0,PLANE5HIGH
	
	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE6LOW
	SWAP	D0
	MOVE.W	D0,PLANE6HIGH

	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE7LOW
	SWAP	D0
	MOVE.W	D0,PLANE7HIGH

	swap	d0
	add.l	d1,d0

	MOVE.W	D0,PLANE8LOW
	SWAP	D0
	MOVE.W	D0,PLANE8HIGH

	
	rts

**********************************
***  SETUP COLOURS            ****
**********************************
	
setup_colours
	move.l  #main_screen_colour_map,a1
	bsr	setup_screen_colours
	bsr	setup_button_colours
	rts

**********************************
*** SETUP_SCREEN_COLOURS      ****
**********************************
	
setup_screen_colours
***send colour map in a1
	move.l	#main_screen_colours+2,a3
	move.w	#2-1,d2
set_hi_lo	
	move.w	#8-1,d1
load_banks	
	move.w	#32-1,d0
fill_scr_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_scr_colours
	add.l	#4,a3	;skip bank
	dbra	d1,load_banks
	dbra	d2,set_hi_lo
	rts

**********************************
*** SETUP_GREY_COLOURS        ****
**********************************
	
setup_grey_colours
	move.l	#main_screen_colours+2,a3
	move.l	#grey_colour_map,a1
	move.w	#16-1,d0
fill_gscr_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_gscr_colours

	rts

**********************************
*** SETUP BUTTON COLOURS      ****
**********************************

setup_button_colours
	move.l	#button_colours+2,a3
	move.l	#button_colour_map,a1
	move.w	#16-1,d0
fill_butt_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_butt_colours
	rts

*****************************************************************
*Module Name	:winddown					*
*Function	:deallocates mem, exits to system		*
*****************************************************************

winddown	
	move.l	oldint,$6c

	bsr	deallocate_map_mem
	bsr	deallocate_block_data_mem
	bsr	deallocate_picstruct_mem
	move.l	#main_screen_struct,a0
	jsr	deallocate_screen_memory

	move.l	#button_window_struct,a0
	jsr	deallocate_screen_memory

	bsr	return_workbench_screen
		
	MOVE.W	#$8030,$DFF096		; ENABLE SPRITES
	move.w	#$f,$dff096		; turn off audio
	ifd	hard_only
	move.l	4,a6
	jsr	permit(a6)
	endc
	RTS 				

**********************************
*** RETURN WORKBENCH SCREEN   ****
**********************************
Return_Workbench_Screen
	move.l	4,a6
	jsr	permit(a6)
	move.l	graphics_lib_ptr,a4
	MOVE.L	#$DFF000,A6
	MOVE.L	38(A4),COP1LCH(A6)	; GET SYSTEM COPPER
	CLR.W	COPJMP1(A6)
	rts	

**********************************
*** SWITCH SCREENS             ***
**********************************
Switch_Screens
	tst.w	Workbench_Mode
	beq.s	switch_workbench
	bsr	Wait_For_Decent_Pos
	bsr	Switch_Back_To_Main
	rts
		
**********************************
*** WAIT FOR DECENT POS       ****
**********************************	
Wait_For_Decent_Pos	
	move.w	vhposr+$dff000,d0
	andi.w	#$ff00,d0
	cmp.w	#$4000,d0
	bne.s	Wait_For_Decent_Pos
	rts

**********************************
*** SWITCH WORKBENCH          ****
**********************************	
Switch_Workbench
	move.w	#1,WorkBench_Mode
	bsr	return_workbench_screen
	rts

**********************************
*** SWITCH BACK TO MAIN       ****
**********************************
Switch_Back_To_Main
	move.l	4,a6
	jsr	forbid(a6)
	move.l	#$dff000,a6
	MOVE.L	#COPPERL,COP1LCH(A6)
	clr.w	COPJMP1(A6)
	clr.w	WorkBench_Mode
	rts

**********************************
*** KILL SYSTEM               ****
**********************************
kill_system
	move.l	#top_level_list,a0
	jsr	remove_button_list
	move.b	#1,quit_system
	rts


change_colour
	move.w	#$fff,$dff180
	rts
		
	include	"glens_code/input_routines.s"
	include	"glens_code/info_routines.s"
	include	"glens_code/key_handler.s"
	include "glens_code/text_routines.s"
	include "glens_code/darkline.s"
	include	"glens_code/hex_screen_routines.s"
	include "stus_code/FileIO.s"
	include "glens_code/window_routines.s"
	include "glens_code/screen_routines.s"
	include "glens_code/button_routines.s"
	include "glens_code/iffroutinebk.s"
	include "glens_code/cursor_routines.s"
	include "glens_code/hex_data.s"	
	include "glens_code/button_data.s"
	include "glens_code/graphic_routines.s"	
	include "glens_code/mapsetup.s"
	include "glens_code/map_routines_buttons.s"
	include "glens_code/map_routines.s"
	include "glens_code/palette_setup.s"
	include "glens_code/fill_routines.s"
	include "glens_code/check_routines.s"
	include "glens_code/savepic_setup.s"
	include "glens_code/save_routines.s"
	include "glens_code/buffer_routines.s"
	include	"glens_code/alien_data.s"
	include "stus_code/FileIO_DATA.s"
	include "glens_code/buffer_setup.s"
	include	"glens_code/show_whole_map.s"
	include	"glens_code/project_code.s"
	include	"glens_code/keyboard_reader.s"
	include	"glens_code/block_data_manip.s"
	
blank	dc.w	0
	include "data/copper_list.s"
	include	"data/custom_buttons.s"
	include "data/buttongraphics.s"
	include "data/cursor_graphics.s"
small_numbers	
	incbin	"data/nums.bin"
	EVEN

	section  maptool,data


	include	"data/picinfo.s"	
*******SCREEN SETUPS
	
main_screen_struct
	dc.w  	320
	dc.w	256
	dc.w	0,0
	dc.l	0
main_screen_planes
	dc.w     8

button_window_struct
	dc.w  	640
	dc.w	4*BUTTON_HEIGHT
	dc.w	0,0
	dc.l	0
button_window_planes
	dc.w     4

quit_system
	dc.b	0		
	EVEN

Workbench_Mode
	dc.w	0	
		

graf_name dc.b	"graphics.library",0
	EVEN

graphics_lib_ptr
	dc.l	0

error_flag	dc.w	0
screen_pointer	dc.l	0
backscr1	Dc.l	0
backscr2	Dc.l	0
backscr3	Dc.l	0
backscr4	Dc.l	0

	
fill_stack
	ds.w	(40*40)*2
