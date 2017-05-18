	section	Generic,Code_C 
 		OPT C-,D+	
		opt p=68020 		
 			
BPR		EQU	40
GRAPHICS_MOD	EQU	0
XSIZE		EQU	4
YSIZE		EQU	36
XDEST		EQU	42
YDEST		EQU	164
SCROLL_WIDTH	EQU	27

NOP	EQU	18
NOC	EQU	0

CUSTOM	EQU	$DFF000			;start of amiga custom hardware
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

bpl2mod	EQU   $10A

bpldat	EQU   $110

intreq	EQU   $09c
intreqr	EQU   $01e





start:

	bsr	Turn_Off_Tasking
	bsr	Allocate_Plane_Memory
	tst.l	d0
	bne.s	Memory_Successfully_Allocated
	rts			;quit out if error
Memory_Successfully_Allocated
	bsr	Setup
	
	bsr	Main_Demo
	bsr	Quit_Out
	rts

QUIT_OUT
	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking
	move.l	4,a6
	move.l	#(256*BPR)*8,d0
	move.l	Memory_Base,a1
	jsr	-210(a6)
	MOVE.L	#graf_NAME,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		;OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4
	MOVE.W	#$8020,DMACON+$dff000	; sprites back	
	move.l	38(a4),$dff080
	clr.w	$dff088
	rts
	
graf_NAME	dc.b	"graphics.library",0
	even


********************************
*** SET UP                   ***
********************************
setup
	bsr	Setup_Colours
	LEA	CUSTOM,A6
	MOVE.W	#0,BPLCON1(A6)
	move.w	#%1000000,BPLCON2(a6)
	move.w	#$83a0,DMACON(a6)
	MOVE.W	#$2C81,DIWSTRT(A6)
	MOVE.W	#$2cC1,DIWSTOP(A6)	
	MOVE.L	#COPPERL,COP1LCH(A6)
	clr.w	COPJMP1(A6)
	rts

********************************************
**** ALLOCATE PLANE MEMORY               ***
********************************************
Allocate_Plane_Memory
	move.l	4,a6
	move.l	#(256*BPR)*8,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)	;try
	tst.l	d0		;memory allocated?
	bne	allocated_mem
	rts			;otherwise quit
allocated_mem
	move.l	d0,Memory_Base
	move.l	d0,Plane1
	add.l	#(256*BPR),d0
	move.l	d0,plane2
	add.l	#(256*BPR),d0
	move.l	d0,plane3
	add.l	#(256*BPR),d0
	move.l	d0,plane4
	add.l	#(256*BPR),d0
	move.l	d0,buff_plane1
	add.l	#(256*BPR),d0
	move.l	d0,buff_plane2
	add.l	#(256*BPR),d0
	move.l	d0,buff_plane3
	add.l	#(256*BPR),d0
	move.l	d0,buff_plane4
	rts

	
*************************************
** TURN OFF TASKING               ***
*************************************
Turn_Off_Tasking
	move.l	4,a6
	jsr	-132(A6)		;DISABLE tasking
	rts

************************************
*** SET UP COLOURS               ***
************************************
Setup_Colours
	move.w	#$180,d0
	move.l	#copper_colours,a0
	move.l	#col_list,a1
	move.w	#16-1,d1
col_loop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$2,d0
	dbra	d1,col_loop
	move.w	#$182,copper_colours
	rts
	
col_list
	dc.w	$000,$fff,$0f0,$00f,$ff0,$0ff,$f0f
	dc.w	$fff,$77f,$707,$f77,$f7f,$7ff,$777
	dc.w	$707,$070	
		

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

**************************************
*** MAIN DEMO                      ***
**************************************	
Main_Demo

	bsr	sync
	bsr	swap_buffers

	btst.b	#6,$bfe001	;has user pressed left mouse button
	beq.s	quit_demo
		
	move.w	#$fff,$dff180				
	move.w	#160,d0
	move.w	#125,d1
	move.w	mouse_x,d2
	move.w	mouse_y,d3
	move.l	plane1,a0
	bsr	Draw_Slice_Line


	bsr	GetMousePosition		
	move.w	#160,d0
	move.w	#125,d1
	move.w	mouse_x,d2
	move.w	mouse_y,d3
	move.l	plane1,a0
	bsr	Draw_Slice_Line
	move.w	#$000,$dff180

	bra	Main_Demo
		
quit_demo	
	rts

x_pos	dc.w	10
y_pos	dc.w	10
counter	dc.w	100	

**************************************
*** DRAW PIXEL                     ***
**************************************
Draw_Pixel
*send x and y in d0,d1

	

	mulu	#BPR,d1		;get y down the screen
	move.w	d0,d2		;make copy of x-coord
	asr.w	#3,d0		;get bytes in x
	add.w	d0,d1		;add x in to linear value
	and.w	#%0000000000000111,d2		;get remainder		
	neg.w	d2		;make value negative
	add.w	#7,d2		;reverse number

	move.l	plane1,a0	;get address of plane1	

	bset.b	d2,(a0,d1.l)	;set value
	
	rts
			
	include	"code:develop/slice_line2.s"	
	
			
x_incy	dc.w	0
	
crap	dc.w	0	
	
**************************************
*** CLEAR PIXEL                    ***
**************************************
Clear_Pixel
*send x and y in d0,d1

	mulu	#BPR,d1		;get y down the screen
	move.w	d0,d2		;make copy of x-coord
	asr.w	#3,d0		;get bytes in x
	add.w	d0,d1		;add x in to linear value
	and.w	#%0000000000000111,d2		;get remainder		
	neg.w	d2		;make value negative
	add.w	#7,d2		;reverse number

	move.l	plane1,a0	;get address of plane1	

*	add.l	d1,a0		;same as below
*	bclr.b	d2,(a0)
	
	bclr.b	d2,(a0,d1.l)	;set value
	rts		
	

**************************************
*** SWAP BUFFERS                   ***
**************************************
Swap_Buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	move.l	plane4,d3
	
*	move.l	buff_plane1,plane1
*	move.l	buff_plane2,plane2
*	move.l	buff_plane3,plane3
*	move.l	buff_plane4,plane4
	
*	move.l	d0,buff_plane1
*	move.l	d1,buff_plane2
*	move.l	d2,buff_plane3
*	move.l	d3,buff_plane4
	
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
************************************************
***** GET MOUSE POSITION                     ***	
************************************************
GetMousePosition

	bsr	ReadMouse
	move.w	mouse_x,d0
	move.w	mouse_y,d1
	add.w	mousex_inc,d0
	add.w	mousey_inc,d1
	move.w	d0,mouse_x
	move.w	d1,mouse_y
	rts
	
***********************************************
*****	READ MOUSE                        *****
************************************************
ReadMouse
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


last_mousey	dc.w	0
last_mousex	dc.w	0
mousex_inc	dc.w	0
mousey_inc	dc.w	0
mouse_x		dc.w	160
mouse_y		dc.w	125

Blank	Dc.l	0

Memory_Base	dc.l	0



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
	

COPPERL
	dc.w	bplcono
	dc.w	$4200
	dc.w	$102		; scrolly bit
	dc.w	$000
	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d0
	dc.w	bpl1mod
	dc.w	0
	dc.w	bpl2mod
	dc.w	0
	dc.w	$1e4
	dc.w	$2100
	dc.w	$1fc
	dc.w	$0
	dc.w	$106,0
	
copper_colours	
	ds.w	16*2		
************sprites

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
		
	
	DC.W	$00E0
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


	dc.w	$ffdf,$fffe

	dc.w	$2c01,$fffe	
	dc.w	intreq
	dc.w	$8010



	DC.W	$2cff,$FFFE

