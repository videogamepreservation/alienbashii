	section	Generic,Code_C 
 		OPT C-,D+	
		opt p=68020 		
 			
BPR		EQU	64
GRAPHICS_MOD	EQU	0
XSIZE		EQU	4
YSIZE		EQU	36
XDEST		EQU	42
YDEST		EQU	164
SCROLL_WIDTH	EQU	27

NOP	EQU	18
NOC	EQU	0

CUSTOM	EQU	$DFF000
BPLCONO	EQU	$100
BPLCON1	EQU	$102
BPLCON2	EQU	$104
BPL1MOD  EQU	$108
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
clxdat	EQU   $00E

bltcon0	EQU   $040
bltcon1	EQU   $042
bltafwm	EQU   $044
bltalwm	EQU   $046
bltcpth	EQU   $048
bltbpth	EQU   $04C
bltapth	EQU   $050
bltdpth	EQU   $054
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

bpl2mod	EQU   $10A

bpldat	EQU   $110

intreq	EQU   $09c
intreqr	EQU   $01e

MODE_OLDFILE	EQU   1005
MODE_NEWFILE	EQU   1006


SCROLL_HEIGHT	EQU	256+64

start:

	move.l	4,a6
	jsr	-132(A6)		;DISABLE tasking


	move.l	4,a6
	move.l	#(SCROLL_HEIGHT*BPR)*8,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)		;try
	tst.l	d0
	bne	allocated_mem
	rts			;otherwise quit
allocated_mem
	move.l	d0,Memory_Base
	move.l	d0,Plane1
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,plane2
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,plane3
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,plane4
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,buff_plane1
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,buff_plane2
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,buff_plane3
	add.l	#(SCROLL_HEIGHT*BPR),d0
	move.l	d0,buff_plane4




	bsr	setup
	move.w	#$0,$dff106
	move.l	#$dff000,a6
	bsr	fill_screen_with_blocks
	bsr	set_up_scroll_position
	bsr	Main_Demo

QUIT_OUT


	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking

	move.l	oldint,$6c
	move.l	4,a6
	move.l	#(SCROLL_HEIGHT*BPR)*8,d0
	move.l	Memory_Base,a1
	jsr	-210(a6)

	MOVE.L	#graf_NAME,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		;OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4

	MOVE.W	#$8020,DMACON+$dff000	; sprites back
	
	move.l	38(a4),$dff080
	clr.w	$dff088
	move.b	#$9b,$bfed01

	rts
graf_NAME	dc.b	"graphics.library",0
	even

setup

	bsr	setup_colours

	LEA	CUSTOM,A0
	MOVE.W	#0,BPLCON1(A0)
	move.w	#%1000000,BPLCON2(a0)
	move.w	#$83a0,DMACON(a0)
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2cC1,DIWSTOP(A0)


	
	MOVE.L	#COPPERL,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0


	
	move.l	$6c,oldint
	move.l	#darkint,$6c	
	rts
	


setup_colours

	move.w	#$180,d0
	move.l	#copper_colours,a0
	move.l	#col_list,a1
	move.w	#16-1,d1
col_loop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$2,d0
	dbra	d1,col_loop
	rts
	
col_list
	dc.w	$000,$f00,$0f0,$00f,$ff0,$0ff,$f0f
	dc.w	$fff,$77f,$707,$f77,$f7f,$7ff,$777
	dc.w	$707,$070	
		

************************************************************
****       D A R K  L I T E   I N T E R R U P T         ****
************************************************************

darkint
	movem.l	d0-d7/a0-a6,-(sp)	

	movem.l	(sp)+,d0-d7/a0-a6
	dc.w	$4ef9
oldint dc.l	0	
mt_data	dc.l	0
music_flag	dc.b	0
	even
play_colours
	dc.b	0
	even
two_channel_flag	dc.b	0
	even




************************************************************
***** S C R E E N      S Y N C                    **********
************************************************************	
	
sync
	move.l	#$dff000,a6	
	move.w	#$0010,intreq(a6)	
wait_for_bit	
	btst.b	#4,intreqr+1(a6)
	beq.s	wait_for_bit
	rts



home	
Main_Demo

	bsr	sync
	bsr	get_stick_readings
	bsr	calculate_scroll_movement
	bsr	move_scroll
	bsr	draw_blocks_for_scroll
wait	btst.b	#6,$bfe001
	bne.s	main_demo
	btst.b	#10,$dff016
	bne.s	main_demo
	rts




Single_Mouse_Press
	btst	#6,$BFE001
	Bne	out
*	move.w	#$11,jobba
not_released
	btst	#6,$BFE001
	Beq	not_released
out
	rts



COPPERL
	dc.w	bplcono
	dc.w	$4200
	dc.w	$102		; scrolly bit
	dc.w	$000
	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d8
	dc.w	bpl1mod
	dc.w	16
	dc.w	bpl2mod
	dc.w	16
	dc.w	$1e4
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$f


copper_colours	
	ds.w	16*2		
************sprites

	dc.w	$180,$0
         dc.w $120		;all sprite stuff
sprite0h dc.w $0
	dc.w $122
sprite0l dc.w 0

         dc.w $124
sprite1h dc.w $0
	dc.w $126
sprite1l dc.w 0

         dc.w $128
sprite2h dc.w $0
	dc.w $12a
sprite2l dc.w 0 	

         dc.w $12c
sprite3h dc.w $0
	dc.w $12e
sprite3l dc.w 0	

         dc.w $130
sprite4h dc.w $0
	dc.w $132
sprite4l dc.w 0

         dc.w $134
sprite5h dc.w $0
	dc.w $136
sprite5l dc.w 0

         dc.w $138
sprite6h dc.w $0
	dc.w $13a
sprite6l dc.w 0

         dc.w $13c
sprite7h dc.w $0
	dc.w $13e
sprite7l dc.w 0
		

top_of_screen	
	DC.W	$00E0		;top bank of plane initialisers
Plane1_Hi	DC.W	0
	DC.W	$00E2
Plane1_Lo	DC.W	0
	DC.W	$00E4
Plane2_Hi	DC.W	0
	DC.W	$00E6
Plane2_Lo	DC.W	0
	DC.W	$00E8
Plane3_Hi	DC.W	0
	DC.W	$00Ea
Plane3_Lo	DC.W	0
	DC.W	$00Ec
Plane4_Hi	DC.W	0
	DC.W	$00Ee
Plane4_Lo	DC.W	0

scroll_bank_1
	dc.w	$2c01,$fffe
	DC.W	$00E0		
	DC.W	0
	DC.W	$00E2
	DC.W	0
	DC.W	$00E4
	DC.W	0
	DC.W	$00E6
	DC.W	0
	DC.W	$00E8
	DC.W	0
	DC.W	$00Ea
	DC.W	0
	DC.W	$00Ec
	DC.W	0
	DC.W	$00Ee
	DC.W	0

	dc.w	$180,$fff


	dc.w	$ffdf,$fffe
	
	
scroll_bank_2
	dc.w	$2c01,$fffe
	DC.W	$00E0		
	DC.W	0
	DC.W	$00E2
	DC.W	0
	DC.W	$00E4
	DC.W	0
	DC.W	$00E6
	DC.W	0
	DC.W	$00E8
	DC.W	0
	DC.W	$00Ea
	DC.W	0
	DC.W	$00Ec
	DC.W	0
	DC.W	$00Ee
	DC.W	0
	
	
	dc.w	intreq
	dc.w	$8010

	DC.W	$2cff,$FFFE


	ds.w	1000*2



display_buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	move.l	plane4,d3
	
	move.w	d0,plane1_lo
	swap	d0
	move.w	d0,plane1_hi
	
	move.w	d1,plane2_lo
	swap	d1
	move.w	d1,plane2_hi

	move.w	d2,plane3_lo
	swap	d2
	move.w	d2,plane3_hi

	move.w	d3,plane4_lo
	swap	d3
	move.w	d3,plane4_hi

	rts
	

Blank	Dc.l	0

Memory_Base	dc.l	0


draw_pixel

	mulu.w	#BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	
	bset.b	d1,(a0,d0.w)	;
	rts	

clear_pixel

	mulu.w	#BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	
	bclr.b	d1,(a0,d0.w)	;

	rts	

plane1
	dc.l	0
plane2
	dc.l	0
plane3
	dc.l	0
plane4
	dc.l	0	
	
	
buff_plane1
	dc.l	0
buff_plane2
	dc.l	0
buff_plane3
	dc.l	0
buff_plane4
	dc.l	0	


*----------------------------SCROLL CODE----------------------

	reset
wait_pos  rs.w	1
wait_mask rs.w	1
plane_1_hi_ptr	rs.w	1
plane_1_hi_val	rs.w	1
plane_1_lo_ptr	rs.w	1
plane_1_lo_val	rs.w	1

plane_2_hi_ptr	rs.w	1
plane_2_hi_val	rs.w	1
plane_2_lo_ptr	rs.w	1
plane_2_lo_val	rs.w	1

plane_3_hi_ptr	rs.w	1
plane_3_hi_val	rs.w	1
plane_3_lo_ptr	rs.w	1
plane_3_lo_val	rs.w	1

plane_4_hi_ptr	rs.w	1
plane_4_hi_val	rs.w	1
plane_4_lo_ptr	rs.w	1
plane_4_lo_val	rs.w	1



TEST_SPEED	EQU	4

WAIT_DRAW_BLOCKS	EQU	0
START_DRAW_BLOCKS	EQU	1

MAP_LINE_SIZE			EQU	100


SCROLL_GOING_DOWN	EQU	-48*BPR	;up from bottom of scroll
SCROLL_GOING_UP		EQU	-16*BPR

MAP_SCREEN_OFFSET_UP	EQU	17*MAP_LINE_SIZE
MAP_SCREEN_OFFSET_DOWN	EQU	-1*MAP_LINE_SIZE

NUMBER_OF_BLOCKS_PER_FRAME	EQU	7

******************************************
****    CALCULATE SCROLL MOVEMENT    *****
******************************************
calculate_scroll_movement

*separate stick from scroll thus this routine can send 
*any value to scroll allowing velocity scrolls etc

	move.w	#0,d0
	tst.w	xdirec
	beq.w	no_x_movement
	bpl.s	scroll_moving_to_right
	move.w	#-TEST_SPEED,d0
	bra.s	no_x_movement
scroll_moving_to_right
	move.w	#TEST_SPEED,d0	
no_x_movement	
	move.w	#0,d1
	tst.w	ydirec
	beq.w	no_y_movement
	bmi.s	scroll_moving_down
	move.w	#-TEST_SPEED,d1
	bra.s	no_y_movement
scroll_moving_down
	move.w	#TEST_SPEED,d1
no_y_movement	


	rts


******************************************
****            MOVE SCROLL          *****
******************************************
move_scroll
*send in x and y increments in d0 and d1

	add.w	d0,scroll_x_position
	add.w	d1,scroll_y_position
	cmp.w	#0,scroll_y_position
	bge.s	scroll_not_hit_bounds
	move.w	scroll_y_position,d2
	neg.w	d2
	add.w	d2,d1	;give proper speed
	move.w	#0,scroll_y_position	
	
scroll_not_hit_bounds
	bsr	check_add_blocks	
	bsr	position_scroll
*do various boundary checks
	rts
	

******************************************
****    CHECK ADD BLOCKS             *****
******************************************
check_add_blocks
	add.w	d1,check_add
	cmp.w	#17,check_add
	blt.s	check_min_add
	sub.w	#16,check_add
	move.w	#START_DRAW_BLOCKS,ready_flag
	move.l	#SCROLL_GOING_DOWN,add_block_direction
	bra.s	drawing_please_wait
check_min_add
	cmp.w	#-17,check_add
	bgt.s	drawing_please_wait
	move.w	#START_DRAW_BLOCKS,ready_flag		
	move.l	#SCROLL_GOING_UP,add_block_direction
	add.w	#16,check_add
drawing_please_wait	
	rts

add_block_direction		dc.l	0	
check_add			dc.w	0
ready_flag			dc.w	0	
	
******************************************
****        POSITION SCROLL          *****
******************************************
position_scroll

*Positions scroll by the x and y values stored

	move.w	scroll_x_position,d0
	move.w	scroll_y_position,d1

position_scroll_along_x	
*ignor x for now


position_scroll_along_y

*---
	moveq	#0,d2
	move.w	d1,d2
	asr.w	#4,d2
	mulu	#MAP_LINE_SIZE,d2
	move.l	#map_data,a0
	add.l	d2,a0
	move.l	a0,current_map_mem_position	
*---

	ext.l	d1
	divu	#SCROLL_HEIGHT,d1
	swap	d1	;this is all we want - split position down screen

	neg.w	d1		;so scroll goes right way
	add.w	#SCROLL_HEIGHT,d1

*---calc where to draw
	
	moveq	#0,d3
	move.w	#SCROLL_HEIGHT,d3		;position above buffer area	
	sub.w	d1,d3		;position of buffer area
	andi.w	#$fff0,d3	
	asl.w	#6,d3
	add.l	plane1,d3
	move.l	d3,current_screen_position
	
*------
	move.w	d1,d2
			
	add.w	#$2c,d1	
	moveq	#0,d0
	cmp.w	#$ff,d1
	ble.s	not_over_dodgy_line
	moveq	#1,d0
not_over_dodgy_line
	cmp.w	#$ff+$2c,d1
	ble.s	not_off_copper
	
	move.w	#-1,d0	
	bra.s	calc_screen_split
not_off_copper	
	andi.w	#$ff,d1	;so values wraps round
	asl.w	#8,d1
	addq.w	#1,d1	; = wait value
calc_screen_split	
	neg.w	d2
	add.w	#SCROLL_HEIGHT,d2
	
	asl.w	#6,d2		;mulu by 64 - get line down
	ext.l	d2
	add.l	plane1,d2	;to display at top
	move.l	plane1,d3	;top display at split
	
	bsr	insert_plane_pointers		
	rts

******************************************
****     INSERT PLANE POINTERS       *****
******************************************
insert_plane_pointers
*d0 indicates if inserting after 255 gap
*d1 contains wait value
*d2	=	top of display
*d3	=	split part of display
	
	tst	d0
	bmi	clear_all_banks
	beq.s	insert_before_line
	
insert_after_line	
	move.l	#scroll_bank_2,a0
	move.l	#scroll_bank_1,a1
	bsr	fill_banks
	rts
insert_before_line	
	move.l	#scroll_bank_1,a0
	move.l	#scroll_bank_2,a1			
	bsr	fill_banks
	rts
clear_all_banks
	move.l	#scroll_bank_1,a0
	move.l	#scroll_bank_2,a1			
	bsr	clear_banks
		
	rts
	
******************************************
****     FILL BANKS                  *****
******************************************
fill_banks
*a0 = bank to fill
*a1 = bank to clear
*d1 = wait
*d2 = top of display
*d3 = split display
	
*change to copper jump later - but get it working first!!!	
	
*		IN USE SPLIT POINTERS	
	
	move.w	d1,wait_pos(a0)
	move.w	#$fffe,wait_mask(a0)
	move.w	#$e2,plane_1_lo_ptr(a0)	
	move.w	d3,plane_1_lo_val(a0)
	swap	d3
	move.w	#$e0,plane_1_hi_ptr(a0)
	move.w	d3,plane_1_hi_val(a0)
	swap	d3
	
	add.l	#SCROLL_HEIGHT*BPR,d3
	
	move.w	#$e6,plane_2_lo_ptr(a0)
	move.w	d3,plane_2_lo_val(a0)
	swap	d3
	move.w	#$e4,plane_2_hi_ptr(a0)
	move.w	d3,plane_2_hi_val(a0)
	swap	d3

	add.l	#SCROLL_HEIGHT*BPR,d3
	
	move.w	#$ea,plane_3_lo_ptr(a0)
	move.w	d3,plane_3_lo_val(a0)
	swap	d3
	move.w	#$e8,plane_3_hi_ptr(a0)
	move.w	d3,plane_3_hi_val(a0)
	swap	d3
	
	add.l	#SCROLL_HEIGHT*BPR,d3
	
	move.w	#$ee,plane_4_lo_ptr(a0)
	move.w	d3,plane_4_lo_val(a0)
	swap	d3
	move.w	#$ec,plane_4_hi_ptr(a0)
	move.w	d3,plane_4_hi_val(a0)

*		UNUSED SET OF SPLIT POINTERS	
	
	move.w	#$1f0,wait_pos(a1)
	
	move.w	#$1f0,plane_1_hi_ptr(a1)
	move.w	#$1f0,plane_1_lo_ptr(a1)

	move.w	#$1f0,plane_2_hi_ptr(a1)
	move.w	#$1f0,plane_2_lo_ptr(a1)

	move.w	#$1f0,plane_3_hi_ptr(a1)
	move.w	#$1f0,plane_3_lo_ptr(a1)

	move.w	#$1f0,plane_4_hi_ptr(a1)
	move.w	#$1f0,plane_4_lo_ptr(a1)

*		TOP OF SCREEN


	move.l	#top_of_screen-4,a0	;so rs.w's work
	move.w	d2,plane_1_lo_val(a0)
	swap	d2
	move.w	d2,plane_1_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_2_lo_val(a0)
	swap	d2
	move.w	d2,plane_2_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_3_lo_val(a0)
	swap	d2
	move.w	d2,plane_3_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_4_lo_val(a0)
	swap	d2
	move.w	d2,plane_4_hi_val(a0)

	rts
		
******************************************
****     CLEAR BANKS                 *****
******************************************
clear_banks

*		UNUSED SET OF SPLIT POINTERS	1
	
	move.w	#$1f0,wait_pos(a1)
	
	move.w	#$1f0,plane_1_hi_ptr(a1)
	move.w	#$1f0,plane_1_lo_ptr(a1)

	move.w	#$1f0,plane_2_hi_ptr(a1)
	move.w	#$1f0,plane_2_lo_ptr(a1)

	move.w	#$1f0,plane_3_hi_ptr(a1)
	move.w	#$1f0,plane_3_lo_ptr(a1)

	move.w	#$1f0,plane_4_hi_ptr(a1)
	move.w	#$1f0,plane_4_lo_ptr(a1)
	
*		UNUSED SET OF SPLIT POINTERS	2
	
	move.w	#$1f0,wait_pos(a0)
	
	move.w	#$1f0,plane_1_hi_ptr(a0)
	move.w	#$1f0,plane_1_lo_ptr(a0)

	move.w	#$1f0,plane_2_hi_ptr(a0)
	move.w	#$1f0,plane_2_lo_ptr(a0)

	move.w	#$1f0,plane_3_hi_ptr(a0)
	move.w	#$1f0,plane_3_lo_ptr(a0)

	move.w	#$1f0,plane_4_hi_ptr(a0)
	move.w	#$1f0,plane_4_lo_ptr(a0)



*		TOP OF SCREEN


	move.l	#top_of_screen-4,a0	;so rs.w's work
	move.w	d2,plane_1_lo_val(a0)
	swap	d2
	move.w	d2,plane_1_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_2_lo_val(a0)
	swap	d2
	move.w	d2,plane_2_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_3_lo_val(a0)
	swap	d2
	move.w	d2,plane_3_hi_val(a0)
	swap	d2
	add.l	#SCROLL_HEIGHT*BPR,d2
	move.w	d2,plane_4_lo_val(a0)
	swap	d2
	move.w	d2,plane_4_hi_val(a0)


	rts
		
scroll_x_position		dc.w	0
scroll_y_position		dc.w	0	


**********************************************************
***********   DRAW BLOCKS FOR SCROLL           ***********
**********************************************************
draw_blocks_for_scroll

	tst.w	ready_flag
	beq.s	quit_draw_blocks_for_scroll
	
	move.l	current_screen_position,a0
	move.l	current_map_mem_position,a1
	bsr	draw_blocks
quit_draw_blocks_for_scroll
	
	rts
	
current_screen_position		dc.l	0
current_map_mem_position	dc.l	0	

**********************************************************
***********   DRAW BLOCKS                      ***********
**********************************************************
draw_blocks
*current screen mem position in a0
*current map position in a1
	
				
	
	add.l	add_block_direction,a0

	cmp.l	plane1,a0
	bge.s	draw_inside_plane_area
	add.l	#SCROLL_HEIGHT*BPR,a0
draw_inside_plane_area

	cmp.l	#SCROLL_GOING_UP,add_block_direction
	bne.s	scroll_down	
	add.l	#MAP_SCREEN_OFFSET_DOWN,a1
	bra.s	draw_blocks_up
scroll_down
	add.l	#MAP_SCREEN_OFFSET_UP,a1
draw_blocks_up

*-----------draw blocks loop-------------
draw_blocks_main

	moveq	#0,d0
	move.w  current_map_position,d0
	ext.l	d0
	add.l	d0,a1	;current map position
	asl	d0	;get into bytes
	add.l	d0,a0	;get to current line
	
	move.w	total_number_of_blocks_to_draw,d2	
	moveq	#0,d7	;count number of blocks drawn
init_blit_values	
	btst	#14,dmaconr(a6)
	bne.s	init_blit_values	


	move.w	#BPR-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	
	
	moveq	#NUMBER_OF_BLOCKS_PER_FRAME-1,d0
draw_loop
	move.l	#blocks,a2
	moveq	#0,d1
	move.b	(a1),d1
	asl.w	#7,d1		;same as mulu (16*2)*4
	add.l	d1,a2	;get to correct position in block data
	
draw_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screen
	move.l	a0,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels
	move.l	a0,a3
	
	add.l	#BPR*SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp2
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp2
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BPR*SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp3
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp3
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BPR*SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp4
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp4
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

done_a_block
	addq.l	#2,a0	;next block position along screen
	addq.l	#1,a1	;next map position
	addq.w	#1,current_map_position
	addq.w	#1,d7		;count number blocks drawn	
	cmp.w	current_map_position,d2
	bne.s	not_yet_done_line
	move.w	#0,current_map_position
	move.w	#WAIT_DRAW_BLOCKS,ready_flag	;done our line now wait for screen to scroll 16
	bra.s	done_all_blocks
not_yet_done_line
	dbra	d0,draw_loop	
done_all_blocks	
	

	rts

total_number_of_blocks_to_draw	dc.w	20
current_map_position		dc.w	0
	
********************************************************
****  FILL SCREEN WITH BLOCKS                       ****
********************************************************
fill_screen_with_blocks

	move.l	plane1,a0
	move.l	#map_data,a1
	move.w	#18-1,d0
do_all_blocks	
	move.w	#START_DRAW_BLOCKS,ready_flag
keep_drawing
	movem.l	a0-a1/d0,-(sp)
	bsr	draw_blocks_main
	movem.l	(sp)+,a0-a1/d0
	tst	ready_flag
	bne.s	keep_drawing
	add.l	#16*BPR,a0
	add.l	#MAP_LINE_SIZE,a1
	dbra	d0,do_all_blocks
	move.w	#WAIT_DRAW_BLOCKS,ready_flag
	rts

********************************************************
****  SET UP SCROLL POSITION                        ****
********************************************************
set_up_scroll_position
	move.w	#0,scroll_y_position
	rts

	include "code:platform/glens_code/joy_routines.s"

blocks
	incbin	"scratch:empty/testblks"
	EVEN
map_data
	incbin	"scratch:empty/testmapraw"
	EVEN	