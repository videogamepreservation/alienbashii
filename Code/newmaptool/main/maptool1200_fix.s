
;/* $Revision Header *********************************************************
  *
  * Main-Programming :
  * Copyright © 1989-1992 Glen Cumming. All Rights Are Reserved.
  *
  * Additional-Programming :
  * Copyright © 1996 Trevor L. Mensah. All Rights Are Reserved.
  *
  * $Creation Language : MC68000 assembly
  * $File              : scratch:maptool/maptool1200_fix.s
  * $Created on        : Thursday, 15-Aug-96 20:03:12
  * $Created by        : Trevor L. Mensah
  * $Current revision  : V1.14
  *
  * $Purpose
  * --------
  * 	A basic block map editor for creation and design of new game 
  *     level maps. For use on ECS/AGA games.
  *
  * $Revision V1.00
  * ---------------
  * created on Thursday 15-Aug-96 20:03:32  by  Trevor Mensah.   LogMessage :
  *     --- Initial history ---
  *
  * $Revision V1.14
  * ---------------
  * 1.  Replaced hardwired interrupts with system friendly calls just so I
  *     could get it working on my system! Now the editor is multitasking and
  *     the self-modifying code for the interrupt gone making it work! Hurray!
  * 2.  Reworked scrolling routines a bit for slightly improved refresh rate
  * 3.  Most direct references to 320 pixels hardwired screenwidth replaced
  *     with screen structure access for autosensitivity (screenmode switch)
  * 4.  Replaced old `inbuilt' file-requesters with a new system friendly and
  *     standard 'reqtools' requesters. Now finally we are able to load and
  *     save data to/from hard-disks.
  * 5.  All blit routines now use blit nasty during blitting for a little
  *     extra performance.
  * 6.  Print routines modified to use 7 pixel print width instead of 10
  *     to enable more descriptive text in gadgets and make them look a bit
  *     nicer on the eye.
  * 7.  Screen display copperlist now uses 64-Bit AGA fetchmode`s for some
  *     additional screen refresh speed.
  * 8.  Added a check to the mouse x-scaling factor for when running in high
  *     resolution screen mode so that the the gadget coordinates are correct.
  * 9.  All window x-start positions are now ignored, instead the windows
  *     are now centred on the screen dependent on the screen pixel width.
  *     This feature really should be added as an option to the window flags
  *     but for now I have simply bypassed the window`s xstart regardless.
  *     This is a simple fix to make windows appear in the centre of the screen
  *     for when running in high-resolution mode.
  * 10. Preview scaling now works in high-resolution mode.
  * 11. Moved workbench startup code into its own file for asm-one direct
  *     to support `assemble-run' feature.
  * 12. Code hunks sectioned into public memory, now only graphics data and 
  *     copperlists in chipmem (along with screen buffers). This speeds up
  *     the code a fair bit on my system now that the code is in fast-ram 
  *     and also saves 100k of chipram and lots on filesize.
  * 13. Removed unneccessary button gadget data`s and changed gadgets imagery
  *     to look a little more modern.
  * 14. Minor changes to copper display code to reflect the newlook gadgets.
  *
  * $Revision V1.15
  * ---------------
  * Few minor adjustments to allow hi-res editing
  *
  * 1.  Adjusted code to correctly handle lo/hi res screen modes - note it
  *     should be possible to make this dynamically changeable whilst
  *     running the editor - a possible future enhancement
  * 2.  Moved some equates from main file to equates.s
  * 3.  Modified change 8 of Revision 1.14, to make a more 'hi-level' change
  * 4.  Added docs directory to contain instructions file
  * 5.  Added conditional assemble option to turn off saving of byte map
  *     overlay data (normally used for aliens). This feature could be implemented
  *     as a check button when saving the map - possible future enhancement
  * 6.  Project structure had no rsreset, this has now been added
  *     Note: Old project files should no longer be used!
  *************************************************************************/

		ifd	TREV
			incdir	"includes:"
		else
			opt c-
			incdir	"tools:devpac/include"
		endc
		
		include "exec/exec_lib.i"
		include	"exec/exec.i"
		include	"libraries/dosextens.i"
		include	"hardware/intbits.i"
		
		ifnd	TREV
			incdir	"code:newmaptool/"	
		endc
		
		include	"glens_code/equates.s"

	 	section  maptool,code

		include	"glens_code/workbench_startup.s"
	
_main:		bsr	setup			* take over and setup
		bne	quit_prog

		jsr	setup_button_list	* setup buttons

		lea	top_level_list,a0
		jsr	display_button_list	* render buttons

		bsr	Calculate_Blocks_In_One_Page
		bsr	display_info_window
	
		bsr	mainroutine		* call main function loop

		bsr	winddown	
quit_prog:	rts

;/* System VBlank Interrupt
  * -----------------------
  */
  
interrupt	movem.l	d0-a6,-(sp)
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

dont_switch	movem.l	(sp)+,d0-a6
		lea	$dff000,a0		* fix bug in os..
		moveq	#0,d0
		rts

***********************************************
*****	MAINROUTINE                       *****
***********************************************

mainroutine	tst.w	Workbench_Mode
		bne.s	skip_extras

		bsr	Wait_For_Decent_Pos
		bsr	button_handler	
		tst.w	window_count
		bne.s	skip_extras
		bsr	get_stick_readings
		bsr	Display_X_Y	
		jsr	Display_Alien_Name
		bsr	Read_Keys

skip_extras	tst.b	quit_system
		beq.s	mainroutine	
       		rts

sync
		bsr	Wait_For_Decent_Pos
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
setup	pea	exitsetup(pc)
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
	
	lea	interrupt(pc),a0	* interrupt code (exit RTS, not RTE!)
	lea	VertB_Server(pc),a1	* ptr to int server for VERTB..
	lea	VertB_Name(pc),a2	* ptr to int server name
	moveq	#INTB_VERTB,d0		* intNum
	move.l	a2,10(a1)		* set name of server..
	move.l	a0,18(a1)		* set address of server..
	move.l	4.w,a6			* execbase
	jsr	_LVOAddIntServer(a6)	* add interrupt into system chain..

	bsr	Wait_For_Decent_Pos

	move.l	#COPPERL,d0
	lea	CUSTOM,a0
	move.l	d0,COP1LCH(a0)
	move.w	d0,COPJMP1(a0)
	move.w	d0,coplo
	swap	d0
	move.w	d0,cophi
	
	move.l	#button_window_struct,a0
	move.l	screen_mem(a0),d0
	moveq	#0,d1
	move.w	screen_x_size(a0),d1
	asr.w	#3,d1
	mulu	screen_y_size(a0),d1

	move.w	d0,Buttonplanelow
	swap	d0
	move.w	d0,buttonplanehigh
	swap	d0
	
	add.l	d1,d0
	move.w	d0,buttonplane2low
	swap	d0
	move.w	d0,buttonplane2high
	swap	d0

	add.l	d1,d0
	move.w	d0,buttonplane3low
	swap	d0
	move.w	d0,buttonplane3high
	swap	d0

	add.l	d1,d0
	move.w	d0,buttonplane4low
	swap	d0
	move.w	d0,buttonplane4high

*------ if screen pixel width >320 set "highres" screen_mode

	lea	main_screen_struct,a0
	bclr	#INTB_HIRES,screen_mode
	cmp.w	#320,screen_x_size(a0)
	ble.s	no_set_hires
	bset	#INTB_HIRES,screen_mode
	bsr	SetHiResSprite
	bra.s	DoneResSetup
no_set_hires
	bsr	SetLoResSprite
DoneResSetup
	
	bsr	blank_sprites
	bsr	setup_colours
	bsr	low_pas_filter_off
	
	ifd	hard_only
	move.l	4.w,a6
	jsr	forbid(a6)
	endc

	rts

error_with_allocation
	move.w	#1,error_flag
	rts	
exitsetup
	tst.w	error_flag
	lea	$dff000,a6
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
	move.l	4.w,a6
	move.l	#MAX_BLOCKS_MEM,d0
	jsr	allocmem(a6)	;get mem
	tst.l	d0
	bne.s	got_block_data_mem
	moveq	#0,d0
	rts
got_block_data_mem
	move.l	d0,block_data_ptr
	rts

**********************************
*** DEALLOCATE BLOCK DATA  MEM****
**********************************
deallocate_block_data_mem
	move.l	4.w,a6
	move.l	block_data_ptr(pc),a1
	move.l	#MAX_BLOCKS_MEM,d0
	jmp	freemem(a6)	;free mem

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
	move.l	4.w,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,d7/a6/a0
	tst.l	d0
	bne.s	al_new_map_mem
*raise error
	moveq	#0,d0
	bra	end_map_al
al_new_map_mem
	move.l  d0,map_mem(a0)

*alocate alien map mem
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.l	#MEM_FAST+MEM_CLEAR,d1
	movem.l	d7/a6/a0,-(sp)
	move.l	4.w,a6
	jsr	-198(a6)	;get mem
	movem.l	(sp)+,d7/a6/a0
	tst.l	d0
	bne.s	al_new_al_map_mem
*raise error
	moveq	#0,d0
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
	bra	Free_Mem_Resources

**********************************
*** FREE MEM RESOURCES        ****
**********************************
Free_Mem_Resources	
	move.l	4.w,a6
	move.l	map_mem(a0),a1
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	move.w	map_datasize(a0),d1
	lsl.l	d1,d0	;mulu by data size (0=byte)
	move.l	a0,-(sp)
	jsr	freemem(a6)
	move.l	(sp)+,a0

	move.l	4.w,a6
	move.l	map_alien_mem(a0),a1
	move.w	map_xsize(a0),d0
	mulu	map_ysize(a0),d0
	jmp	freemem(a6)

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
	move.l  4.w,a6
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
	move.l  4.w,a6
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

	move.w	d0,planelow
	swap	d0
	move.w	d0,planehigh
	swap	d0
	add.l	d1,d0

	move.w	d0,plane2low
	swap	d0
	move.w	d0,plane2high
	swap	d0
	add.l	d1,d0

	move.w	d0,plane3low
	swap	d0
	move.w	d0,plane3high
	swap	d0
	add.l	d1,d0

	move.w	d0,plane4low
	swap	d0
	move.w	d0,plane4high

	swap	d0
	add.l	d1,d0

	move.w	d0,plane5low
	swap	d0
	move.w	d0,plane5high
	
	swap	d0
	add.l	d1,d0

	move.w	d0,plane6low
	swap	d0
	move.w	d0,plane6high

	swap	d0
	add.l	d1,d0

	move.w	d0,plane7low
	swap	d0
	move.w	d0,plane7high

	swap	d0
	add.l	d1,d0

	move.w	d0,plane8low
	swap	d0
	move.w	d0,plane8high
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
	moveq	#2-1,d2
set_hi_lo	
	moveq	#8-1,d1
load_banks	
	moveq	#32-1,d0
fill_scr_colours
	move.w	(a1)+,(a3)
	addq.l	#4,a3
	dbra	d0,fill_scr_colours
	addq.l	#4,a3	;skip bank
	dbra	d1,load_banks
	dbra	d2,set_hi_lo
	rts

**********************************
*** SETUP_GREY_COLOURS        ****
**********************************
	
setup_grey_colours
	move.l	#main_screen_colours+2,a3
	move.l	#grey_colour_map,a1
	moveq	#16-1,d0
fill_gscr_colours
	move.w	(a1)+,(a3)
	addq.l	#4,a3
	dbra	d0,fill_gscr_colours

	rts

**********************************
*** SETUP BUTTON COLOURS      ****
**********************************

setup_button_colours
	move.l	#button_colours+2,a3
	move.l	#button_colour_map,a1
	moveq	#16-1,d0
fill_butt_colours
	move.w	(a1)+,(a3)
	addq.l	#4,a3
	dbra	d0,fill_butt_colours
	rts

*****************************************************************
*Module Name	:winddown					*
*Function	:deallocates mem, exits to system		*
*****************************************************************

winddown	
	lea	VertB_Server(pc),a1
	moveq	#INTB_VERTB,d0
	move.l	4.w,a6
	jsr	_LVORemIntServer(a6)

	bsr	deallocate_map_mem
	bsr	deallocate_block_data_mem
	bsr	deallocate_picstruct_mem
	move.l	#main_screen_struct,a0
	jsr	deallocate_screen_memory

	move.l	#button_window_struct,a0
	jsr	deallocate_screen_memory

	bsr	return_workbench_screen
		
	move.w	#$8030,$dff096		; enable sprites
	move.w	#$f,$dff096		; turn off audio
	ifd	hard_only
	move.l	4.w,a6
	jsr	permit(a6)
	endc
	rts

VertB_Server:	dc.l	0,0			* pred,succ
		dc.b	2			* interrupt type
		dc.b	3			* interrupt priority
		dc.l	0			* interrupt name
		dc.l	0			* 
		dc.l	0			* interrupt jump address

VertB_Name:	dc.b	'MapTool IRQ',0
		even
pressed		dc.w	0

**********************************
*** RETURN WORKBENCH SCREEN   ****
**********************************
Return_Workbench_Screen
	move.l	4.w,a6
	jsr	permit(a6)
	move.l	graphics_lib_ptr,a4
	lea	$dff000,a6
	move.l	38(a4),cop1lch(a6)	; get system copper
	move.w	d0,copjmp1(a6)		; strobe copper. force new copper on..
	rts	

**********************************
*** SWITCH SCREENS             ***
**********************************
switch_screens
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
	move.l	4.w,a6
	jsr	forbid(a6)
	move.l	#$dff000,a6
	move.l	#copperl,cop1lch(a6)
	move.w	d0,copjmp1(a6)
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
	ifd	TREV			
LDF_VOLUMES=$8
dol_Name=$28
	endc
		
	include	"glens_code/info_routines.s"
	include "glens_code/new_FileIO.s"
	include	"glens_code/input_routines.s"
	include	"glens_code/key_handler.s"
	include "glens_code/text_routines.s"
	include "glens_code/darkline.s"
	include "glens_code/window_routines.s"
	include "glens_code/screen_routines.s"
	include "glens_code/button_routines.s"
	include "glens_code/iffroutine.s"
	include "glens_code/cursor_routines.s"
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
	include "glens_code/buffer_setup.s"
	include	"glens_code/show_whole_map.s"
	include	"glens_code/project_code.s"
	include	"glens_code/keyboard_reader.s"
	include	"glens_code/block_data_manip.s"


blank	dc.w	0
	include	"data/picinfo.s"	
	
*******SCREEN SETUPS
	
main_screen_struct
	dc.w  	ScrPixelWidth
	dc.w	ScrPixelHeight
	dc.w	0,0
	dc.l	0
main_screen_planes
	dc.w     ScrDepth

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

		section  maptoolbss,bss
error_flag	ds.w	1
	ifd	TREV
		cnop	0,4
	endc		
graphics_lib_ptr
		ds.l	1
screen_pointer	ds.l	1
backscr1	ds.l	1
backscr2	ds.l	1
backscr3	ds.l	1
backscr4	ds.l	1
fill_stack	ds.w	((ScrPixelWidth/8)*(ScrPixelWidth/8))*2
buff1		ds.b	(ScrPixelWidth/8)*32*2
buff2		ds.b	(ScrPixelWidth/8)*32*2
buff3		ds.b	(ScrPixelWidth/8)*32*2
buff4		ds.b	(ScrPixelWidth/8)*32*2
buff5		ds.b	(ScrPixelWidth/8)*32*2
buff6		ds.b	(ScrPixelWidth/8)*32*2	
buff7		ds.b	(ScrPixelWidth/8)*32*2
buff8		ds.b	(ScrPixelWidth/8)*32*2
scr1b		ds.b	(ScrPixelWidth/8)*32*2
scr2b		ds.b	(ScrPixelWidth/8)*32*2
Current_Project_Information
		ds.b	Project_Struct_Size

		section  maptooldata,data_c
		include "data/copper_list.s"
		include	"data/new_custom_buttons.s"
		include "data/new_buttongraphics.s"
		include "data/cursor_graphics.s"
small_numbers	incbin	"data/nums.bin"

