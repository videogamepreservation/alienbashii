		section Bashii,CODE
		OPT C-,D+	
	 	opt NODEBUG
		opt p=68000 		

	incdir	"code:AlienBashII"
	include	"glens_code/equates.s"
	include "glens_code/game_equates.s"	


RADIUS_STEP	EQU	12
NUMBER_OF_RINGS	EQU	60
DOTS_PER_RING	EQU	31
ANGLE_INC	EQU	360/(DOTS_PER_RING-1)

A500RADIUS_STEP	EQU	6
A500NUMBER_OF_RINGS	EQU	42
A500START_INC	EQU	2
A500COLOUR_INC	EQU	A500NUMBER_OF_RINGS/7


START_RADIUS	EQU	20
COLOUR_INC	EQU	NUMBER_OF_RINGS/7
START_INC	EQU 	1


TUBE_PATTERN_TIME	EQU	50*15

RING_MEMORY_SIZE EQU	(DOTS_PER_RING*NUMBER_OF_RINGS*6)
RING_STRUCTS_SIZE EQU	NUMBER_OF_RINGS*6
RING_PTR_SIZE	EQU	(NUMBER_OF_RINGS+1)*4		;// extra one for terminator
RING_LIST_SIZE	EQU	NUMBER_OF_RINGS*4
RING_DEL_SIZE	EQU	NUMBER_OF_RINGS*DOTS_PER_RING*4*3

********************************************************
*****     TUBE SET UP                               ****
********************************************************
Tube_Set_Up

	tst.w	Chip_Type
	bne.s	Tube1200
	move.w	#A500NUMBER_OF_RINGS,Ring_Count
	move.w	#A500START_INC,rad_inc
	bra.s	Get_On_With_Setup
Tube1200
	move.w	#NUMBER_OF_RINGS,Ring_Count
	move.w	#START_INC,rad_inc
Get_On_With_Setup


	move.l	Fast_Memory_Base,d0
	
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

	bsr	Create_Rings	
	move.w	Ring_Count,d0
	subq.w	#1,d0
	move.l	Ring_Ptrs,a0
	move.l	Ring_Structs,a1
Set_Up_Ring_Ptrs	
	move.l	a1,(a0)+
	add.l	#Ring_Struct_Size,a1
	dbra	d0,Set_Up_Ring_Ptrs
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
	move.l	Current_Tube_Pattern,a0
	move.l	(a0),Current_Tube_Pattern_Pointer
	rts	

********************************************************
*****          CREATE RINGS                         ****
********************************************************
Create_Rings

	move.w	Ring_Count,d0
	subq.w	#1,d0
	
	move.l	Ring_Memory,a0
	move.l	#cosradtable,a1
	move.l	#sinradtable,a2
	move.w	#START_RADIUS,init_rad
	clr.l	d3
	move.w	#START_RADIUS,d7
	clr.w	d6
	clr.w	Col_Counter
	clr.w	Current_Col
	
Create_Rings_Loop

	move.w	#80,Last_y
	move.w	#160,Last_x
	clr.w	d1
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

	movem.l	d7,-(sp)
	clr.l	d6
	clr.l	d7
	move.w	Last_X,d6
	move.w	Last_Y,d7
	move.w	d4,Last_X
	move.w	d5,Last_Y

	sub.w	d6,d4
	sub.w	d7,d5

	muls	#TUBE_BPR,d5		;num lines diff
	move.w	d4,d6
	asr.w	#3,d4
	ext.l	d4
	add.l	d5,d4
	move.l	d4,2(a0)
	
	andi.w	#$7,d6		;remainder diff	
	move.w	d6,(a0)

	movem.l	(sp)+,d7

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
	tst.w	Chip_Type
	bne.s	Colours1200
	move.w	#A500COLOUR_INC,d5
	bra.s	test_the_cols
Colours1200
	move.w	#COLOUR_INC,d5
test_the_cols		
	cmp.w	Col_Counter,d5
	bne.s	Dont_Change_Colour
	clr.w	Col_Counter
	addq.w	#1,Current_Col
Dont_Change_Colour	
	
	addq.w	#1,rad_step
	tst.w	Chip_Type
	bne	RadStep1200
	move.w	#A500RADIUS_STEP,d5
	bra.s	Check_Rad
RadStep1200
	move.w	#RADIUS_STEP,d5
Check_Rad	
	cmp.w	rad_step,d5
	bne.s	dont_inc_rad
	addq.w	#1,rad_inc
	clr.w	rad_step
dont_inc_rad		
	add.w	rad_inc,d7
	dbra	d0,Create_Rings_Loop
	rts			

current_col	dc.w	0
col_counter	dc.w	0	

init_rad	dc.w	0
last_x		dc.w	0
last_y		dc.w	0

rad_step	dc.w	0
rad_inc		dc.w	0

********************************************************
*****          ADD NEW RING                         ****
********************************************************
Add_New_Ring
	move.l	Current_Tube_Pattern_Pointer,a3
	move.l	Ring_Ptrs,a0
	cmp.l	#$ffffffff,(a0)
	beq.s	Cant_Add_New_Ring
	move.l	Current_List_Ptr,a2
	move.l	(a0)+,a1
	move.w	(a3)+,Ring_X(a1)
	move.w	(a3)+,Ring_Y(a1)
	clr.w	Ring_Size(a1)	
	move.l	a1,(a2)+
	move.l	a2,Current_List_Ptr
	move.l	#$ffffffff,(a2)		;term list
	move.l	a0,Ring_Ptrs
Cant_Add_New_Ring
	cmp.w	#999,(a3)
	bne.s	dont_reset_tube_pattern
	move.l	Current_Tube_Pattern,a3
	move.l	(a3),a3
dont_reset_tube_pattern		
	move.l	a3,Current_Tube_Pattern_Pointer
	rts

Current_Tube_Pattern_Pointer
	dc.l	0


********************************************************
*****            DRAW RINGS                         ****
********************************************************
Draw_Rings
	move.l	a6,-(sp)
	move.l	Ring_List,a4
	move.l	a4,a2
	move.l	Ring_Del_List,a3
	move.w	Ring_Count,d6
	subq.w	#2,d6
Draw_Rings_Loop
	cmp.l	#$ffffffff,(a4)
	beq.s	Quit_Draw_Rings
	move.l	(a4),a5
	move.w	Ring_X(a5),d0		;initial x
	move.w	Ring_Y(a5),d1		;initial y
	move.w	Ring_Size(a5),d3	;size	
	cmp.w	d6,d3			;done all rings??
	bge.s	Remove_Ring_From_List
	addq.w	#1,Ring_Size(a5)
	move.l	(a4)+,(a2)+
	
*--- Code to draw ring	
	move.l	Ring_Memory,a5
	mulu	#DOTS_PER_RING*6,d3
	add.l	d3,a5
	add.w	(a5)+,d0

	lsl.l	#6,d1		;get y down screen
	move.w	d0,d2		;make copy of x-coord
	lsr.w	#3,d0		;get bytes in x
	add.w	d0,d1		;add x in to linear value
	and.w	#%111,d2		;get remainder		
	neg.w	d2		;make value negative
	addq.w	#7,d2		;reverse number
		
	move.w	#(DOTS_PER_RING/2)-1,d7		;set up loop
	move.l	(a5)+,a6
	jsr	(a6)		;jump to draw routine
*----	
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

***************************************************
***** 		DRAW RING COL1		      *****
***************************************************
Draw_Ring_Col1
	move.l	plane1,a0	;get address of plane1	
	add.l	d1,a0		
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Ring_Loop	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel	
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)	
	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel
Second_increment_mem	
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel	
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)		
	dbra	d7,Draw_Ring_Loop
	rts
	

***************************************************
***** 		DRAW RING COL2		      *****
***************************************************
Draw_Ring_Col2		
	move.l	plane2,a0	;get address of plane1	
	add.l	d1,a0
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Ring_Loop2	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel2
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel2	
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)	
	
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel2
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel2	
	move.l	a0,(a3)+	;ring del list
	bset.b	d2,(a0)	
	dbra	d7,Draw_Ring_Loop2
	rts		

***************************************************
***** 		DRAW RING COL3		      *****
***************************************************
Draw_Ring_Col3
	move.l	plane1,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane2,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Ring_Loop3
	cmp.l	a6,a0
	bge.s	Draw_Ring_Loop3
	bset.b	d2,(a0)		;draw initial pixel
	bset.b	d2,TUBE_BPR*256(a0)
 	move.l	a0,(a3)+
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
Draw_Ring_Loop3
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel3
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel3
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point3
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point3
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,TUBE_BPR*256(a0)
	
Dont_Dr_Point3
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel3
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel3
	cmp.l	a1,a0
	blt.s	Second_Dont_Dr_Point3
	cmp.l	a6,a0
	bge.s	Second_Dont_Dr_Point3
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,TUBE_BPR*256(a0)
Second_Dont_Dr_Point3
	dbra	d7,Draw_Ring_Loop3
	rts		

***************************************************
***** 		DRAW RING COL4		      *****
***************************************************
Draw_Ring_Col4
	move.l	plane3,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	a1,a6
	add.l	#TUBE_PLANE_SIZE,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Ring_Loop4
	cmp.l	a6,a0
	bge.s	Draw_Ring_Loop4
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
Draw_Ring_Loop4
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel4
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel4
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point4
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point4
	move.l	a0,(a3)+	;ring del list
 	bset.b	d2,(a0)	
Dont_Dr_Point4
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel4
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel4
	cmp.l	a1,a0
	blt.s	Second_Dont_Dr_Point4
	cmp.l	a6,a0
	bge.s	Second_Dont_Dr_Point4
	move.l	a0,(a3)+	;ring del list
 	bset.b	d2,(a0)	
Second_Dont_Dr_Point4
	dbra	d7,Draw_Ring_Loop4
	rts		

***************************************************
***** 		DRAW RING COL5		      *****
***************************************************
Draw_Ring_Col5
	move.l	plane1,a0	;get address of plane1	
	move.l	a0,a1		;temp
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Ring_Loop5
	cmp.l	plane2,a0
	bge.s	Draw_Ring_Loop5
	bset.b	d2,(a0)		;draw initial pixel
 	move.l	a0,(a3)+
 	move.l	a0,a6
 	add.l	#TUBE_BPR*256*2,a6
 	move.l	a6,(a3)+
 	bset.b	d2,(a6)
Draw_Ring_Loop5
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel5
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel5
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point5
	cmp.l	plane2,a0
	bge.s	Dont_Dr_Point5
	move.l	a0,(a3)+	;ring del list
	move.l	a0,a6
	add.l	#TUBE_BPR*256*2,a6
	move.l	a6,(a3)+
 	bset.b	d2,(a0)	
	bset.b	d2,(a6)
Dont_Dr_Point5
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel5
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel5
	cmp.l	a1,a0
	blt.s	Second_Dont_Dr_Point5
	cmp.l	plane2,a0
	bge.s	Second_Dont_Dr_Point5
	move.l	a0,(a3)+	;ring del list
	move.l	a0,a6
	add.l	#TUBE_BPR*256*2,a6
	move.l	a6,(a3)+
 	bset.b	d2,(a0)	
	bset.b	d2,(a6)
Second_Dont_Dr_Point5
	dbra	d7,Draw_Ring_Loop5
	rts		

***************************************************
***** 		DRAW RING COL6		      *****
***************************************************
Draw_Ring_Col6
	move.l	plane2,a0	;get address of plane1	
	move.l	a0,a1		;temp
	move.l	plane3,a6
	add.l	d1,a0		
	cmp.l	a1,a0
	blt.s	Draw_Ring_Loop6
	cmp.l	a6,a0
	bge.s	Draw_Ring_Loop6
	bset.b	d2,(a0)		;draw initial pixel
	bset.b	d2,TUBE_BPR*256(a0)
 	move.l	a0,(a3)+
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
Draw_Ring_Loop6
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Draw_In_Pixel6
	addq.l	#1,a0
	addq.w	#8,d2	
Draw_In_Pixel6
	cmp.l	a1,a0
	blt.s	Dont_Dr_Point6
	cmp.l	a6,a0
	bge.s	Dont_Dr_Point6
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,TUBE_BPR*256(a0)
Dont_Dr_Point6
	move.w	(a5)+,d0	;remainder value
	add.l	(a5)+,a0
	sub.w	d0,d2
	bge.s	Second_Draw_In_Pixel6
	addq.l	#1,a0
	addq.w	#8,d2	
Second_Draw_In_Pixel6
	cmp.l	a1,a0
	blt.s	Second_Dont_Dr_Point6
	cmp.l	a6,a0
	bge.s	Second_Dont_Dr_Point6
	move.l	a0,(a3)+	;ring del list
 	move.l	a0,(a3)		;not fastest way!!!
 	add.l	#TUBE_BPR*256,(a3)+
	bset.b	d2,(a0)	
	bset.b	d2,TUBE_BPR*256(a0)
Second_Dont_Dr_Point6
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




**********************************************
***    SWAP TUBE BUFFERS                   ***
**********************************************
Swap_Tube_Buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	
	move.l	buff_plane1,plane1
	move.l	buff_plane2,plane2
	move.l	buff_plane3,plane3
	
	move.l	d0,buff_plane1
	move.l	d1,buff_plane2
	move.l	d2,buff_plane3
	
	move.w	d0,Inplane1_lo
	swap	d0
	move.w	d0,Inplane1_hi
	
	move.w	d1,Inplane2_lo
	swap	d1
	move.w	d1,Inplane2_hi

	move.w	d2,Inplane3_lo
	swap	d2
	move.w	d2,Inplane3_hi

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

**************************************
*** DO RINGS                       ***
**************************************
Do_Rings
	bsr	Swap_Tube_Buffers
	bsr	Swap_Ring_Buffers
	tst.w	Tube_Pattern_Counter
	ble.s	Dont_Add_Ring
	tst	Chip_Type
	bne.s	Ignore_Ring_Skip
	bchg	#0,frame_skip
	beq.s	Dont_Add_Ring
Ignore_Ring_Skip
	bsr	Add_New_Ring
Dont_Add_Ring	
	bsr	Clear_Pixels
	bsr	Draw_Rings
	subq.w	#1,Tube_Pattern_Counter
	cmp.w	#-50*2,Tube_Pattern_Counter
	bgt.s	Dont_Change_Pattern
	move.l	Current_Tube_Pattern,a0
	addq.l	#4,a0
	cmp.l	#$ffffffff,(a0)
	bne.s	Dont_Reset_Pattern_List
	move.l	#Pattern_List,a0
Dont_Reset_Pattern_List	
	move.l	a0,Current_Tube_Pattern
	move.l	(a0)+,Current_Tube_Pattern_Pointer
	move.w	#TUBE_PATTERN_TIME,Tube_Pattern_Counter
Dont_Change_Pattern	
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
	lsr.w	#6,d0		;div by 4 and then by 16
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

Ring_Count
	dc.w	0
	
Pattern_List
	dc.l	Tube_Pattern
	dc.l	Tube_Pattern2	2
	dc.l	Tube_Pattern3	3
	dc.l	$ffffffff

Current_Tube_Pattern	dc.l	Pattern_List

Tube_Pattern_Counter	dc.w	TUBE_PATTERN_TIME
	
	
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

	rsreset

Tube_Pattern
	include	"data/patterns/tube1.s"	
Tube_Pattern2
	include	"data/patterns/tube2.s"
Tube_Pattern3
	include	"data/patterns/tube3.s"


Ring_x	rs.w	1
Ring_y	rs.w	1
Ring_Size	rs.w	1
Ring_Struct_Size rs.w	1

		xref.l	Fast_Memory_Base
		xref.w	Chip_Type
		xref.l	Plane1
		xref.l	Plane2
		xref.l	Plane3
		xref.l	buff_Plane1
		xref.l	buff_Plane2
		xref.l	buff_Plane3
		xref.l	InPlane1_lo
		xref.l	InPlane2_lo
		xref.l	InPlane3_lo
		xref.l	InPlane1_hi
		xref.l	InPlane2_hi
		xref.l	InPlane3_hi
		xref.w	frame_skip
	
		xdef	Do_Rings
		xdef	Add_New_Ring
		xdef	Tube_Set_Up