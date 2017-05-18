*------------------------------------------------------------------*
*-Rough code just to test theory of super fast pixel ring plotting-*
*-This is not optimized, see fasttube.s for even faster drawing   -*
*------------------------------------------------------------------*

	section	Generic,Code_C 
 		OPT C-,D+
 		OPT NODEBUG	
		opt p=68020 		

EXEC		EQU	4 			
BPR		EQU	64
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
	bsr	Tube_Set_Up
	tst.l	d0
	beq.s	quit
	bsr	Allocate_Plane_Memory
	tst.l	d0
	bne.s	Memory_Successfully_Allocated
quit
	rts			;quit out if error
Memory_Successfully_Allocated
	bsr	Setup
	bsr	Add_New_Ring
	bsr	Main_Demo
	bsr	Quit_Out
	rts

QUIT_OUT
	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking
	bsr	Tube_Quit
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
	rts
	
col_list
	dc.w	$000,$115,$127,$359,$57b,$79d,$9bf
	dc.w	$115,$115,$707,$f77,$f7f,$7ff,$777
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


Wait_R_Mouse
	btst.b	#10,$dff016
	beq.s	Wait_R_Mouse
	rts

Click_R_Mouse
	btst.b	#10,$dff016
	bne.s	Click_R_Mouse
Release_R
	btst.b	#10,$dff016
	beq.s	Click_R_Mouse	
	rts



**************************************
*** MAIN DEMO                      ***
**************************************	
Main_Demo

	bsr	sync
	bsr	swap_buffers

	
	btst.b	#6,$bfe001	;has user pressed left mouse button
	beq.s	quit_demo

	bsr	GetMousePosition
*	bsr	Click_R_Mouse

	addq.w	#1,Add_Count
	cmp.w	#2,Add_Count
	bne.s	Dont_Add_New_Ring
	bsr	Add_New_Ring
	clr.w	Add_Count
Dont_Add_New_Ring
	bsr	Clear_Pixels

	bsr	Draw_Rings
		bsr	Swap_Ring_Buffers


	bra.s	Main_Demo		
	
quit_demo	
	rts


**************************************
*** SWAP BUFFERS                   ***
**************************************
Swap_Buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	move.l	plane4,d3
	
	move.l	buff_plane1,plane1
	move.l	buff_plane2,plane2
	move.l	buff_plane3,plane3
	move.l	buff_plane4,plane4
	
	move.l	d0,buff_plane1
	move.l	d1,buff_plane2
	move.l	d2,buff_plane3
	move.l	d3,buff_plane4
	
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

	rsreset

Ring_x	rs.w	1
Ring_y	rs.w	1
Ring_Size	rs.w	1
Ring_Struct_Size rs.w	1


START_RADIUS	EQU	20
END_RADIUS	EQU	200
RADIUS_STEP	EQU	16
START_INC	EQU 	1
NUMBER_OF_RINGS	EQU	70
DOTS_PER_RING	EQU	40
ANGLE_INC	EQU	360/DOTS_PER_RING
COLOUR_INC	EQU	NUMBER_OF_RINGS/7

RING_MEMORY_SIZE EQU	(DOTS_PER_RING*NUMBER_OF_RINGS*6)
RING_STRUCTS_SIZE EQU	NUMBER_OF_RINGS*6
RING_PTR_SIZE	EQU	(NUMBER_OF_RINGS+1)*4		;// extra one for terminator
RING_LIST_SIZE	EQU	NUMBER_OF_RINGS*4
RING_DEL_SIZE	EQU	NUMBER_OF_RINGS*DOTS_PER_RING*4*3

RINGS_TOTAL_MEMORY	EQU	RING_MEMORY_SIZE+RING_STRUCTS_SIZE+RING_PTR_SIZE+RING_LIST_SIZE+RING_DEL_SIZE*2



********************************************************
*****     TUBE SET UP                               ****
********************************************************
Tube_Set_Up

	bsr	Allocate_Memory_For_Rings
	tst.l	d0
	beq.s	Quit_Tube_Set_Up
	bsr	Create_Rings	
	move.w	#NUMBER_OF_RINGS-1,d0
	move.l	Ring_Ptrs,a0
	move.l	Ring_Structs,a1
Set_Up_Ring_Ptrs	
	move.l	a1,(a0)+
	add.l	#Ring_Struct_Size,a1
	dbra	d0,Set_Up_Ring_Ptrs
	move.l	Ring_Ptrs,a0
	move.l	#$ffffffff,-4(a0)
	move.l	Ring_List,a0
	move.l	a0,Current_List_Ptr
	move.l	#$ffffffff,(a0)	;term list ptr
	move.l	Ring_Del_List,a0
	move.l	a0,End_Del_List
	move.l	#$ffffffff,(a0)	;term list
	move.l	Ring_Del_List_Buff,a0
	move.l	a0,End_Del_List_Buff
	move.l	#$ffffffff,(a0)	;term list
Quit_Tube_Set_Up	
	rts	

********************************************************
*****     TUBE QUIT                                 ****
********************************************************
Tube_Quit
	move.l	exec,a6
	move.l	#RINGS_TOTAL_MEMORY,d0
	move.l	Ring_Memory,a1
	jsr	-210(a6)
	rts

********************************************************
***** ALLOCATE MEMORY FOR RINGS                     ****
********************************************************
Allocate_Memory_For_Rings
	move.l	EXEC,a6
	move.l	#RINGS_TOTAL_MEMORY,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)	;try
	tst.l	d0		;memory alloca
	beq.s	could_not_allocate_rings
	move.l	d0,Ring_Memory
	add.l	#RING_MEMORY_SIZE,d0
	move.l	d0,Ring_Structs
	add.l	#RING_STRUCTS_SIZE,d0
	move.l	d0,Ring_Ptrs
	add.l	#RING_PTR_SIZE,d0
	move.l	d0,Ring_List
	add.l	#RING_LIST_SIZE,d0
	move.l	d0,Ring_Del_List
	move.l	d0,End_Del_List
	add.l	#RING_DEL_SIZE,d0
	move.l	d0,Ring_Del_List_Buff
could_not_allocate_rings
	rts


********************************************************
*****          CREATE RINGS                         ****
********************************************************
Create_Rings

	move.l	Ring_Memory,a0
	move.l	#cosradtable,a1
	move.l	#sinradtable,a2
	move.w	#START_RADIUS,init_rad
	clr.l	d3
	move.w	#START_RADIUS,d7
	clr.l	d6
	clr.w	Col_Counter
	clr.w	Current_Col
	
	move.w	#NUMBER_OF_RINGS-1,d0
Create_Rings_Loop
	move.w	#80,Last_y
	move.w	#160,Last_x
	move.w	d6,d1
	move.w	#DOTS_PER_RING-1,d2
Create_Ring_Points
	move.w	d1,d3
	asl	d3
	move.w	(a1,d3),d4
	move.w	(a2,d3),d5
	muls	d7,d4
	muls	d7,d5

	asr.l	#8,d4
	asr.l	#2,d4
	asr.l	#8,d5
	asr.l	#2,d5

	add.w	#160,d4
	add.w	#80,d5

	movem.l	d6/d7,-(sp)
	clr.l	d6
	clr.l	d7
	move.w	Last_X,d6
	move.w	Last_Y,d7
	move.w	d4,Last_X
	move.w	d5,Last_Y

	sub.w	d6,d4
	sub.w	d7,d5

	muls	#BPR,d5		;num lines diff
	move.w	d4,d6
	asr.w	#3,d4
	ext.l	d4
	add.l	d5,d4
	move.l	d4,2(a0)
	
	andi.w	#$7,d6		;remainder diff	
	move.w	d6,(a0)

	movem.l	(sp)+,d6/d7

	addq.l	#6,a0
	add.w	#ANGLE_INC,d1
	cmp.w	#360,d1
	blt.s	not_lapped
	sub.w	#360,d1
not_lapped	
	dbra	d2,Create_Ring_Points
	
	clr.l	d5
	move.l	#Ring_Routine_Table,a3
	move.w	Current_Col,d5
	lsl	#2,d5
	move.l	(a3,d5.l),(-DOTS_PER_RING*6)+2(a0)
	move.w	d7,-DOTS_PER_RING*6(a0)

	addq.w	#1,Col_Counter
	cmp.w	#COLOUR_INC,Col_Counter
	bne.s	Dont_Change_Colour
	clr.w	Col_Counter
	addq.w	#1,Current_Col
Dont_Change_Colour	
	
	addq.w	#1,rad_step
	cmp.w	#RADIUS_STEP,rad_step
	bne.s	dont_inc_rad
	addq.w	#1,rad_inc
	clr.w	rad_step
dont_inc_rad		
	add.w	rad_inc,d7
	dbra	d0,Create_Rings_Loop
	rts			

current_col
	dc.w	0
col_counter
	dc.w	0	

init_rad
	dc.w	0
last_x	
	dc.w	0
last_y
	dc.w	0

rad_step
	dc.w	0
rad_inc	dc.w	START_INC

********************************************************
*****          ADD NEW RING                         ****
********************************************************
Add_New_Ring
	move.l	Ring_Ptrs,a0
	cmp.l	#$ffffffff,(a0)
	beq.s	Cant_Add_New_Ring
	move.l	Current_List_Ptr,a2
	move.l	(a0)+,a1
	move.w	Mouse_X,Ring_X(a1)
	move.w	Mouse_Y,Ring_Y(a1)
	clr.w	Ring_Size(a1)	
	move.l	a1,(a2)+
	move.l	a2,Current_List_Ptr
	move.l	#$ffffffff,(a2)		;term list
	move.l	a0,Ring_Ptrs
Cant_Add_New_Ring	
	rts


********************************************************
*****            DRAW RING                          ****
********************************************************
Draw_Ring
*send ring size in d0
*send initial x,y in d4,d5

	move.l	Ring_Memory,a5
	mulu	#DOTS_PER_RING*6,d3
	add.l	d3,a5
	add.w	(a5)+,d0

	lsl.l	#6,d1		;get y down screen
	move.w	d0,d2		;make copy of x-coord
	asr.w	#3,d0		;get bytes in x
	add.w	d0,d1		;add x in to linear value
	and.w	#%111,d2		;get remainder		
	neg.w	d2		;make value negative
	add.w	#7,d2		;reverse number
		
		
	move.l	(a5)+,a6
	jsr	(a6)		;jump to draw routine
	rts

Draw_Ring_Col1
Draw_Ring_Col7	
	move.l	plane1,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane2,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop
	cmp.l	a6,a0
	bge.s	Draw_Loop
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Loop
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel
increment_mem	
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel	
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)	
	dbra	d7,Draw_Ring_Loop
	rts
Dont_Dr_Point		
	dbra	d7,Draw_Ring_Loop
	rts		


Draw_Ring_Col2		
	move.l	plane2,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane3,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop2
	cmp.l	a6,a0
	bge.s	Draw_Loop2
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Loop2
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop2	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel2
increment_mem2
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel2	
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point2
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point2
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)	
	dbra	d7,Draw_Ring_Loop2
	rts
Dont_Dr_Point2
	dbra	d7,Draw_Ring_Loop2
	rts		

Draw_Ring_Col3
	move.l	plane1,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane2,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop3
	cmp.l	a6,a0
	bge.s	Draw_Loop3
	bset.b	d2,(a0)		;draw initial pixel
	bset.b	d2,BPR*256(a0)
 	move.l	a0,(a3)+
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#BPR*256,(a3)+
Draw_Loop3
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop3
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel3
increment_mem3
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel3
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point3
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point3
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,BPR*256(a0)
	
	dbra	d7,Draw_Ring_Loop3
	rts
Dont_Dr_Point3
	dbra	d7,Draw_Ring_Loop3
	rts		

Draw_Ring_Col4
	move.l	plane3,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane4,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop4
	cmp.l	a6,a0
	bge.s	Draw_Loop4
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Loop4
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop4
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel4
increment_mem4
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel4
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point4
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point4
	move.l	a0,(a3)+	;ring del list
	move.l	a0,(a3)+
 	bset.b	d2,(a0)	
	
	dbra	d7,Draw_Ring_Loop4
	rts
Dont_Dr_Point4
	dbra	d7,Draw_Ring_Loop4
	rts		

Draw_Ring_Col5
	move.l	plane1,a0	;get address of plane1	
	move.l	a0,a1		;temp
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop5
	cmp.l	plane2,a0
	bge.s	Draw_Loop5
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
 	move.l	a0,a6
 	add.l	#BPR*256*2,a6
 	move.l	a6,(a3)+
 	bset.b	d2,(a6)
Draw_Loop5
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop5
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel5
increment_mem5
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel5
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point5
	cmp.l	plane2,a0
	bge.s	Dont_Dr_Point5
	move.l	a0,(a3)+	;ring del list
	move.l	a0,a6
	add.l	#BPR*256*2,a6
	move.l	a6,(a3)+
 	bset.b	d2,(a0)	
	bset.b	d2,(a6)
	dbra	d7,Draw_Ring_Loop5
	rts
Dont_Dr_Point5
	dbra	d7,Draw_Ring_Loop5
	rts		

Draw_Ring_Col6
	move.l	plane2,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane3,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Loop6
	cmp.l	a6,a0
	bge.s	Draw_Loop6
	bset.b	d2,(a0)		;draw initial pixel
	bset.b	d2,BPR*256(a0)
 	move.l	a0,(a3)+
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#BPR*256,(a3)+
Draw_Loop6
	move.w	#DOTS_PER_RING-2,d7
Draw_Ring_Loop6
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel6
increment_mem6
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel6
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point6
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point6
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,BPR*256(a0)
	
	dbra	d7,Draw_Ring_Loop6
	rts
Dont_Dr_Point6
	dbra	d7,Draw_Ring_Loop6
	rts



Ring_Routine_Table
	dc.l	Draw_Ring_Col1
	dc.l	Draw_Ring_Col2
	dc.l	Draw_Ring_Col3
	dc.l	Draw_Ring_Col4
	dc.l	Draw_Ring_Col5
	dc.l	Draw_Ring_Col6
	dc.l	Draw_Ring_Col6
	dc.l	Draw_Ring_Col6

********************************************************
*****            DRAW RINGS                         ****
********************************************************
Draw_Rings
	move.l	a6,-(sp)
	move.l	Ring_List,a4
	move.l	a4,a2
	move.l	Ring_Del_List,a3
Draw_Rings_Loop
	cmp.l	#$ffffffff,(a4)
	beq.s	Quit_Draw_Rings
	move.l	(a4),a5
	move.w	Ring_X(a5),d0		;initial x
	move.w	Ring_Y(a5),d1		;initial y
	move.w	Ring_Size(a5),d3		;size	
	cmp.w	#NUMBER_OF_RINGS,d3
	bge.s	Remove_Ring_From_List
	addq.w	#1,Ring_Size(a5)
	move.l	(a4)+,(a2)+
	bsr	Draw_Ring
	bra.s	Draw_Rings_Loop
Remove_Ring_From_List
	move.l	Ring_Ptrs,a0
	move.l	a5,-(a0)
	move.l	a0,Ring_Ptrs
	addq.l	#4,a4
	bra.s	Draw_Rings_Loop	
Quit_Draw_Rings	
	move.l	#$ffffffff,(a2)		;term current list
	move.l	#$ffffffff,(a3)		;term del list
	move.l	a3,End_Del_List
	move.l	a2,Current_List_Ptr
	move.l	(sp)+,a6
	rts


**************************************
*** SWAP RING BUFFERS              ***
**************************************
Swap_Ring_Buffers
	move.l	Ring_Del_List,d0
	move.l	Ring_Del_List_Buff,Ring_Del_List
	move.l	d0,Ring_Del_List_Buff
	
	move.l	End_Del_List,d0
	move.l	End_Del_List_Buff,End_Del_List
	move.l	d0,End_Del_List_Buff
	rts

*********************************************
***  CLEAR PIXELS                        ****
*********************************************
Clear_Pixels
	move.l	Ring_Del_List,a3
	move.l	End_Del_List,d0
	sub.l	a3,d0
	tst.l	d0
	beq	Skip_Remainder
	lsr.w	#5,d0		;div by 4 and then by 8
	subq.w	#1,d0	
Clear_Loop
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	move.l	(a3)+,a0	
	clr.b	(a0)
	dbra	d0,Clear_Loop

Remainder_Loop
	cmp.l	#$ffffffff,(a3)
	beq.s	Skip_Remainder
	move.l	(a3)+,a0	
	clr.b	(a0)
	bra.s	Remainder_Loop
Skip_Remainder
	rts	

End_Del_List
	dc.l	0
End_Del_List_Buff
	dc.l	0	
Ring_Memory
	dc.l	0
Ring_Structs
	dc.l	0
Ring_Ptrs
	dc.l	0
Ring_List
	dc.l	0	
Current_List_Ptr
	dc.l	0		
Ring_Del_List
	dc.l	0		
Ring_Del_List_Buff
	dc.l	0	
Add_Count	dc.w	0

sinradtable
 DC.W 17,35,53,71,89,107,124,142,160,177
 DC.W 195,212,230,247,265,282,299,316,333,350
 DC.W 366,383,400,416,432,448,464,480,496,511
 DC.W 527,542,557,572,587,601,616,630,644,658
 DC.W 671,685,698,711,724,736,748,760,772,784
 DC.W 795,806,817,828,838,848,858,868,877,886
 DC.W 895,904,912,920,928,935,942,949,955,962
 DC.W 968,973,979,984,989,993,997,1001,1005,1008
 DC.W 1011,1014,1016,1018,1020,1021,1022,1023,1023,1024
 DC.W 1023,1023,1022,1021,1020,1018,1016,1014,1011,1008
 DC.W 1005,1001,997,993,989,984,979,973,968,962
 DC.W 955,949,942,935,928,920,912,904,895,886
 DC.W 877,868,858,848,838,828,817,806,795,784
 DC.W 772,760,748,736,724,711,698,685,671,658
 DC.W 644,630,616,601,587,572,557,542,527,512
 DC.W 496,480,464,448,432,416,400,383,366,350
 DC.W 333,316,299,282,265,247,230,212,195,177
 DC.W 160,142,124,107,89,71,53,35,17,0
 DC.W -18,-36,-54,-72,-90,-108,-125,-143,-161,-178
 DC.W -196,-213,-231,-248,-266,-283,-300,-317,-334,-351
 DC.W -367,-384,-401,-417,-433,-449,-465,-481,-497,-512
 DC.W -528,-543,-558,-573,-588,-602,-617,-631,-645,-659
 DC.W -672,-686,-699,-712,-725,-737,-749,-761,-773,-785
 DC.W -796,-807,-818,-829,-839,-849,-859,-869,-878,-887
 DC.W -896,-905,-913,-921,-929,-936,-943,-950,-956,-963
 DC.W -969,-974,-980,-985,-990,-994,-998,-1002,-1006,-1009
 DC.W -1012,-1015,-1017,-1019,-1021,-1022,-1023,-1024,-1024,-1025
 DC.W -1024,-1024,-1023,-1022,-1021,-1019,-1017,-1015,-1012,-1009
 DC.W -1006,-1002,-998,-994,-990,-985,-980,-974,-969,-963
 DC.W -956,-950,-943,-936,-929,-921,-913,-905,-896,-887
 DC.W -878,-869,-859,-849,-839,-829,-818,-807,-796,-785
 DC.W -773,-761,-749,-737,-725,-712,-699,-686,-672,-659
 DC.W -645,-631,-617,-602,-588,-573,-558,-543,-528,-513
 DC.W -497,-481,-465,-449,-433,-417,-401,-384,-367,-351
 DC.W -334,-317,-300,-283,-266,-248,-231,-213,-196,-178
 DC.W -161,-143,-125,-108,-90,-72,-54,-36,-18,0
cosradtable
 DC.W 1023,1023,1022,1021,1020,1018,1016,1014,1011,1008
 DC.W 1005,1001,997,993,989,984,979,973,968,962
 DC.W 955,949,942,935,928,920,912,904,895,886
 DC.W 877,868,858,848,838,828,817,806,795,784
 DC.W 772,760,748,736,724,711,698,685,671,658
 DC.W 644,630,616,601,587,572,557,542,527,511
 DC.W 496,480,464,448,432,416,400,383,366,350
 DC.W 333,316,299,282,265,247,230,212,195,177
 DC.W 160,142,124,107,89,71,53,35,17,0
 DC.W -18,-36,-54,-72,-90,-108,-125,-143,-161,-178
 DC.W -196,-213,-231,-248,-266,-283,-300,-317,-334,-351
 DC.W -367,-384,-401,-417,-433,-449,-465,-481,-497,-513
 DC.W -528,-543,-558,-573,-588,-602,-617,-631,-645,-659
 DC.W -672,-686,-699,-712,-725,-737,-749,-761,-773,-785
 DC.W -796,-807,-818,-829,-839,-849,-859,-869,-878,-887
 DC.W -896,-905,-913,-921,-929,-936,-943,-950,-956,-963
 DC.W -969,-974,-980,-985,-990,-994,-998,-1002,-1006,-1009
 DC.W -1012,-1015,-1017,-1019,-1021,-1022,-1023,-1024,-1024,-1025
 DC.W -1024,-1024,-1023,-1022,-1021,-1019,-1017,-1015,-1012,-1009
 DC.W -1006,-1002,-998,-994,-990,-985,-980,-974,-969,-963
 DC.W -956,-950,-943,-936,-929,-921,-913,-905,-896,-887
 DC.W -878,-869,-859,-849,-839,-829,-818,-807,-796,-785
 DC.W -773,-761,-749,-737,-725,-712,-699,-686,-672,-659
 DC.W -645,-631,-617,-602,-588,-573,-558,-543,-528,-512
 DC.W -497,-481,-465,-449,-433,-417,-401,-384,-367,-351
 DC.W -334,-317,-300,-283,-266,-248,-231,-213,-196,-178
 DC.W -161,-143,-125,-108,-90,-72,-54,-36,-18,0
 DC.W 17,35,53,71,89,107,124,142,160,177
 DC.W 195,212,230,247,265,282,299,316,333,350
 DC.W 366,383,400,416,432,448,464,480,496,511
 DC.W 527,542,557,572,587,601,616,630,644,658
 DC.W 671,685,698,711,724,736,748,760,772,784
 DC.W 795,806,817,828,838,848,858,868,877,886
 DC.W 895,904,912,920,928,935,942,949,955,962
 DC.W 968,973,979,984,989,993,997,1001,1005,1008
 DC.W 1011,1014,1016,1018,1020,1021,1022,1023,1023,1024
ENDSINRAD



	

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
	dc.w	64-40
	dc.w	bpl2mod
	dc.w	64-40
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


