 	section  maptool,code_c
	opt NODEBUG
	opt p=68000 	
	incdir	"code:maptool/"	
	opt c-	

exec	 equ	4		; amiga executive o/s base


SERPER   equ   $032		; serial port period and control
SERDATR  equ   $018		; serial port data and status read
SERDAT	 equ   $030
INTREQ   equ   $09c		; interrupt request bits
intreqr	equ    $01e
INTENA	 equ   $09a             	; interrupt enable bits


CUSTOM	EQU	$DFF000		; start of amigas hardware
BPLCONO	EQU	$100
BPLCON1	EQU	$102
BPLCON2	EQU	$104
BPL1MOD EQU	$108
BPL2MOD EQU	$10a
DDFSTRT	EQU	$092
DDFSTOP	EQU	$094
DIWSTRT	EQU	$08E
DIWSTOP	EQU	$090
VPSOR	EQU	$004
COLOUR0 EQU	$180
COLOUR1 EQU	$182
COLOUR2	EQU	$184
COLOUR3	EQU	$186
DMACON	EQU	$096
COP1LCH	EQU	$080
COPJMP1	EQU	$088

DMAF_BLITTER	EQU   $0040

DMAF_BLTDONE	EQU   $4000
DMAF_BLTNZERO	EQU   $2000

DMAB_BLTDONE	EQU   14
bltddat	EQU   $000
dmaconr	EQU   $002
vposr	EQU   $004
vhposr	EQU   $006
dskdatr	EQU   $008
joy0dat	EQU   $00A
joy1dat	EQU   $00C
joytest	equ   $036
clxdat	EQU   $00E

bltcon0	EQU   $040
bltcon1	EQU   $042
bltafwm	EQU   $044
bltalwm	EQU   $046
bltcpt	EQU   $048
bltbpt	EQU   $04C
bltapt	EQU   $050
bltdpt	EQU   $054
bltsize	EQU   $058

bltcmod	EQU   $060
bltbmod	EQU   $062
bltamod	EQU   $064
bltdmod	EQU   $066

bltcdat	EQU   $070
bltbdat	EQU   $072
bltadat	EQU   $074

dsksync	EQU   $07E

cop1lc	EQU   $080
cop2lc	EQU   $084

bpldat	EQU   $110
MODE_OLD	EQU   1005
MODE_NEW	EQU   1006

hard_only	equ	0
save_alien_data	equ	0



output equ -60
openlibrary equ -408
closelibrary equ -414
exec_base equ 4
find_task equ -294
write equ -48
open equ -30
close equ -36
read  equ -42
forbid equ -132
permit equ -138
disable equ -120

ownblitter	equ	-456
disownblitter	equ	-462

MEM_CHIP	EQU $02
MEM_FAST EQU 	$04
MEM_PUBLIC	EQU	$01
MEM_CLEAR EQU $10000

COPPER_SCREEN_OFFSET	EQU $2c
BUTTON_WINDOW_OFFSET	EQU 192

BUTTON_SCREEN_POSITION EQU BUTTON_WINDOW_OFFSET+COPPER_SCREEN_OFFSET

RES_BYTES	equ	40
RES_HEIGHT	equ	256


PLANE_HEIGHT	equ	200
BYTES_PER_ROW	equ 	320/8

SECRES_BYTES	equ	80
SECRES_HEIGHT	equ	256


SECBYTES_PER_ROW	equ 	640/8


STARTOFMAINCODE

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


	bsr	display_info_window
	
	bsr	mainroutine
	bsr	winddown	
quit_prog	
	rts

**********************************
*** INTERRUPT                 ****
**********************************
interrupt
	movem.l	d0-d7/a0-a6,-(sp)
	
	jsr	position_cursor
	bsr	readmouse
	bsr	position_box_sprite
	bsr     display_helpful_cursor

	movem.l	(sp)+,d0-d7/a0-a6
	dc.w	$4ef9
oldint	dc.l	0

***********************************************
*****	MAINROUTINE                      *****
***********************************************


mainroutine
	bsr	sync
	bsr	button_handler	
	bsr	get_stick_readings
	bsr	read_keys
	cmp.b	#0,quit_system
	beq.s	mainroutine	
       	rts


read_keys

	cmp.w	#1,edit_mode
	bne.s	no_key_pressed
	bsr	get_pressed_key
	cmp.b	#51,d0
	beq	move_cursor_up
	cmp.b	#50,d0
	beq	move_cursor_down
	cmp.b	#48,d0
	beq	move_cursor_left
	cmp.b	#49,d0
	beq	move_cursor_right
	cmp.b	#40,d0
	blt.s	not_num_key
	cmp.b	#47,d0
	bgt.s	not_num_key
	bra.s	select_key_buffer	
not_num_key	
	rts
no_key_pressed	
	
	rts
	
select_key_buffer
	ext.w	d0
	sub.w	#40,d0
	neg	d0
	add.w	#7,d0
	move.w	d0,-(sp)	
	jsr	remove_current_buff_name
	move.w	(sp)+,d0
	move.w	d0,current_buffer
	jsr	calculate_buffer_mem
	jsr	display_current_buff_name

	rts
	
move_cursor_up
	bsr	Remove_Selected_Block_Num
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	move.l	#map_details,a0
	divu	map_block_size(a0),d0
	
	sub.w	d0,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num
	rts

move_cursor_down
	bsr	Remove_Selected_Block_Num
	move.l	#main_screen_struct,a0
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	move.l	#map_details,a0
	divu	map_block_size(a0),d0
	
	add.w	d0,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num
	rts
	
move_cursor_left
	bsr	Remove_Selected_Block_Num
	subq.w	#1,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num

	rts
	
move_cursor_right
	bsr	Remove_Selected_Block_Num
	addq.w	#1,current_block
	bsr	convert_block_number_to_memory
	bsr	position_box_sprite2
	bsr	Display_Selected_Block_Num


	rts				
	
***********************************************
*****	SYNC                             *****
***********************************************

	
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
	
***********************************************
*****	   PAUSE                         *****
***********************************************	
pause

	move.w	#4000,d0
wait
	dbra	d0,wait
	rts
			

************************************************
*****	READ MOUSE                        *****
************************************************


readmouse
*updates mousex_inc and mousey_inc - it is done this way
*for total flexibility as it can be used to scroll the 
*screen or move an on screen pointer or be used to increase
*levels volume menu options etc etc

	moveq	#0,d0
	move.w	$dff00a,d0	;mouse port
	move.w	d0,d1
	andi.w	#$00ff,d1
	move.w	last_mousex,d3
	sub.w	d1,d3
	cmp.w	#127,d3
	blt.s	test_under
	add.w	#-255,d3
	bra.s	add_to_scrollx
test_under	
	cmp.w	#-127,d3
	bgt.s	add_to_scrollx
	add.w	#255,d3
add_to_scrollx
	neg.w	d3	
	move.w	d3,mousex_inc
test_sp_y		
	move.w	d1,last_mousex
	move.w	last_mousey,d3
	lsr.w	#8,d0
	sub.w	d0,d3
	
	cmp.w	#127,d3
	blt.s	test_under_y
	add.w	#-255,d3
	neg.w	d3
	bra.s	add_to_scrolly
test_under_y	
	cmp.w	#-127,d3
	bgt.s	add_to_scrolly
	add.w	#255,d3
add_to_scrolly
	neg.w	d3
	move.w	d3,mousey_inc	
move_y_value
	move.w	d0,last_mousey
	rts         


****************************************
******  GET STICK READINGS         *****
****************************************
get_stick_readings

	tst.w	edit_data_flag		;crap code
	bne.s	set_fire_up			;frigged for time

	cmp.w	#1,edit_mode
	bne	quit_scroll_joy
	
	move.w	#0,fire
	btst	#7,$bfe001
	bne.s	set_fire_up
	move.w	#1,fire
set_fire_up

	
	move.w	$dff00c,d0		;joy1dat
update_joy_values
	btst	#9,d0
	beq.s	tryleft
	move.w	#-1,xdirec
	bra	upanddown
tryleft	
	btst	#1,d0
	beq.s	movezero
	move.w	#1,xdirec
	bra.s	upanddown
movezero	
	move.w	#0,xdirec
upanddown
	move.w	d0,d1
	rol.w	#1,d0
	eor.w	d0,d1
	btst	#1,d1
	beq.s    tryup	
	move.w	#-1,ydirec	
	bra.s	quitjoyread
tryup
	btst	#9,d1
	beq.s	stop_y
	move.w	#1,ydirec
	bra.s quitjoyread
stop_y	
	move.w	#0,ydirec
quitjoyread

	tst	ydirec
	beq.s	testlr
	bpl.s	joy_scroll_up
	bsr	scroll_map_down
	bra.s	testlr
joy_scroll_up	
	bsr	scroll_map_up
testlr
	tst	xdirec
	beq.s	done_scroll_bits
	bpl.s	joy_scroll_right
	bsr	scroll_map_right
	bra.s	done_scroll_bits
joy_scroll_right
	bsr	scroll_map_left
done_scroll_bits
	tst	edit_data_flag
	beq.s	quit_scroll_joy
	jsr	display_alien_numbers
quit_scroll_joy			
		
	rts


	
fire  	 				dc.w	0

fire2					dc.w	0

xdirec 					dc.w	0

ydirec 					dc.w	0



		
*****************************************************************
*Module Name	:setup						*
*Function	:sets up screen,allocates mem			*
*****************************************************************



setup
	bsr	open_dos

	bsr	open_graphics_library
	tst.l	d0

	move.l	#main_screen_struct,a0
	jsr	setup_screen_memory
	move.l	screen_mem(a0),d0
	
	tst.l	d0
	bne	allocated_screen_mem

error_with_allocation
	move.w	#1,error_flag
	rts					; otherwise quit

allocated_screen_mem


	bsr	allocate_picstruct_mem
	tst.l	d0
	beq.s	error_with_allocation
	
	bsr	allocate_map_mem
	tst.l	d0
	beq.s	error_with_allocation

	move.l	#button_window_struct,a0
	jsr	setup_screen_memory
	move.l	screen_mem(a0),d0
	
	tst.l	d0
	bne	allocated_window_mem

	move.l	#main_screen_struct,a0		;give back screen mem
	jsr	deallocate_screen_memory
	bra.s	error_with_allocation

allocated_window_mem

	bsr	put_planes_in_copper
	
	LEA	CUSTOM,A0
	
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2CC1,DIWSTOP(A0)
	
	MOVE.L	#COPPERL,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0
	 
	MOVE.W	#$8380,DMACON(A0)		
	
	
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

	moveq	#0,d0
	move.l	#map_details,a0
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
	
	moveq	#0,d0
	move.l	#map_details,a0
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
*** BLANK SPRITES             ****
**********************************
blank_sprites
	move.l	#blank_sprite,d0
	move.w	d0,sprite1l
	move.w	d0,sprite2l
	move.w	d0,sprite3l
	move.w	d0,sprite4l
	move.w	d0,sprite5l
	move.w	d0,sprite6l
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite1h
	move.w	d0,sprite2h
	move.w	d0,sprite3h
	move.w	d0,sprite4h
	move.w	d0,sprite5h
	move.w	d0,sprite6h
	move.w	d0,sprite7h
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
	move.w	#32-1,d0
fill_scr_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_scr_colours

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

	bsr	deallocate_picstruct_mem
	move.l	#main_screen_struct,a0
	jsr	deallocate_screen_memory

	move.l	#button_window_struct,a0
	jsr	deallocate_screen_memory
	
	move.l	graphics_lib_ptr,a4
	MOVE.L	#$DFF000,A6
	MOVE.L	38(A4),COP1LCH(A6)	; GET SYSTEM COPPER
	CLR.W	COPJMP1(A6)
	MOVE.W	#$8030,$DFF096		; ENABLE SPRITES
	move.w	#$f,$dff096		; turn off audio
	ifd	hard_only
	move.l	4,a6
	jsr	permit(a6)
	endc
	RTS 				

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


last_mousex	dc.w	0
last_mousey	dc.w	0
mousex_inc	dc.w	0
mousey_inc	dc.w	0
mouse_x		dc.w	160
mouse_y		dc.w	100

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
	


*******SCREEN SETUPS
	
main_screen_struct
	dc.w  	320
	dc.w	256
	dc.w	0,0
	dc.l	0
main_screen_planes
	dc.w     5

button_window_struct
	dc.w  	640
	dc.w	4*BUTTON_HEIGHT
	dc.w	0,0
	dc.l	0
button_window_planes
	dc.w     4


*********WINDOW SETUPS


error_window
	dc.w 320
	dc.w 44+32
	dc.w 0
	dc.w 80
	dc.l 0
	dc.l 0
	dc.b "ERROR",0
	
	EVEN


ok_button
	dc.w	BUTTON_2-16
	dc.w	THIRD_ROW
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	remove_error_window
	dc.b	"OK",0		
	EVEN						


info_window
	dc.w 200
	dc.w 180
	dc.w 60
	dc.w 10
	dc.l 0
	dc.l 0
	dc.b "INFO",0
	EVEN


quit_info_button
	dc.w	55
	dc.w	140
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_info_window
	dc.b	0		
	even


**************************************
**** DISPLAY INFO WINDOW          ****
**************************************

display_info_window
	move.l	#info_window,a0
	bsr	create_window

	move.l	#quit_info_button,a0
	jsr	display_button

	move.l	#info_window,a0	
	move.l	#info_text,a1
	move.w	#5,d0
	move.w	#3,d1
	move.w	#1,d2
	move.w	#1,d3
	bsr	write_text
	rts

**************************************
**** REMOVE INFO WINDOW           ****
**************************************

remove_info_window
	move.l	#quit_info_button,a0
	jsr	remove_button
	bsr	destroy_window
	rts

info_text
	dc.b $a,$a,-2,8
	dc.b "   ECLIPSE SW  ",$a
	dc.b "   Map Editor  ",$a,-2,9
	dc.b "               ",$a,-2,10
	dc.b "  Internal use ",$a,-2,11
	dc.b "     only.     ",$a,$a,-2,9
	dc.b "     v1.0      ",$a
	dc.b "               ",$a,-2,10
	dc.b "   (c) 1992    ",0
	EVEN

display_error
	bsr	set_original_colours	
	move.l	#error_window,a0
	bsr	create_window

	move.l	#ok_button,a0
	jsr	display_button

	movem.l	a6,-(sp)
	move.l	dosbase,a6
	jsr	-132(a6)
	movem.l	(sp)+,a6

	bsr	get_error_message

	move.l	#error_window,a0
	moveq	#10,d0
	moveq	#10,d1
	moveq	#2,d2
	bsr	write_text	
	rts

error_routine
*send error in d0
	move.l	d0,-(sp)		
	bsr	set_original_colours
	move.l	#error_window,a0
	bsr	create_window

	move.l	#ok_button,a0
	jsr	display_button
	move.l	(sp)+,d0

	bsr	get_error_message

	move.l	#error_window,a0
	moveq	#20,d0
	moveq	#10,d1
	moveq	#2,d2
	bsr	write_text
	rts


get_error_message
*returns pointer to string in a1
*error numin d0
	
	move.l	#error_list,a0
error_search
	cmp.w #-1,(a0)
	beq.s	no_error_found
	cmp.w	(a0),d0
	bne.s	not_the_error
	move.l	2(a0),a1
	rts
not_the_error
	addq.l	#6,a0
	bra.s	error_search
no_error_found
	move.l	#no_error,a1
	rts

error_list
	dc.w 103
	dc.l e1
	dc.w 204
	dc.l e2
	dc.w 205
	dc.l e3 
	dc.w 210
	dc.l e4
	dc.w 211
	dc.l e5
	dc.w 213
	dc.l e6
	dc.w 214
	dc.l e7
	dc.w 221
	dc.l e8
	dc.w 225
	dc.l e9
	dc.w 226
	dc.l e10
	dc.w	1000
	dc.l	e11
	dc.w	1001
	dc.l	e12
	dc.w	1002
	dc.l	e13
	dc.w	2000
	dc.l	e14
	dc.w	3000
	dc.l	e15
	dc.w	4000
	dc.l	e16
	dc.w	5000
	dc.l	e17
	dc.w	5001
	dc.l	e18
	dc.w -1

e1
	dc.b "INSUFFICIENT FREE STORE.",0
	EVEN
e2
	dc.b "DIRECTORY NOT FOUND.",0
	EVEN
e3
	dc.b "OBJECT NOT FOUND.",0
	EVEN
e4
	dc.b "INVALID STREAM COMPONENT NAME.",0
	EVEN
e5
	dc.b "INVALID OBJECT LOCK.",0
	EVEN
e6
	dc.b "DISK NOT VALIDATED.",0
	EVEN
e7
	dc.b "DISK WRITE PROTECTED.",0
	EVEN
e8
	dc.b "DISK FULL.",0
	EVEN
e9
	dc.b "NOT A DOS DISK.",0
	EVEN
e10
	dc.b "NO DISK IN DRIVE.",0
	EVEN
e11
	dc.b	"NOT AN IFF FILE.",0
	EVEN

e12
	dc.b	"CANNOT ALLOCATE FILE MEM.",0
	EVEN
e13
	dc.b	"CANNOT ALLOCATE PIC MEM.",0
	EVEN

e14
	dc.b	"SCANNER NOT CONNECTED!",0
	EVEN
e15
	dc.b    "NOT A MUSIC DATA FILE!",0
	EVEN
	
e16
	dc.b	"NOT AN EDITOR MAP FILE!",0
	EVEN	
e17
	dc.b	"NOT A EDITOR BUFFER FILE!",0
	EVEN
e18
	dc.b	"DATA SIZE INCOMPATIBLE ",0
	EVEN		
		

no_error
	dc.b "NOT A VALID ERROR.",0
	EVEN

remove_error_window

	move.l	#ok_button,a0
	jsr	remove_button
	bsr	destroy_window	
	bsr	set_current_page_colours
	rts

	
quit_system
	dc.b	0		
	EVEN

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
	
blank	dc.w	0
	include "data/copper_list.s"
	include	"data/custom_buttons.s"
	include "data/buttongraphics.s"
	include "data/cursor_graphics.s"
small_numbers	
	incbin	"data/nums.bin"
	EVEN


	
fill_stack
	ds.w	(40*30)*2
