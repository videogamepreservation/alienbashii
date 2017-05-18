

**********************************************
***    DISPLAY INSTRUCTIONS PICTURE        ***
**********************************************
Display_Instructions_Picture

	move.l	#((TOTAL_PAGE_MEM+80)/16)-1,d0
	move.l	memory_base,a0
Clear_Instr_Planes
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	dbra	d0,Clear_Instr_Planes	

	move.w	#BIT_PLANE_DMA,dmacon(a6)
	clr.w	title_pic_loaded
	clr.w	stars_up
	bsr	Load_Instructions_Picture

	move.l	#instr_cols2+2,a0
	bsr	Insert_Cols
	move.l	#instr_cols4+2,a0
	bsr	Insert_Cols

			
	move.l	memory_base,d0
	move.l	d0,plane1
	move.w	d0,InPlane1_Lo
	swap	d0
	move.w	d0,InPlane1_Hi
	swap	d0
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,plane2
	move.w	d0,InPlane2_Lo
	swap	d0
	move.w	d0,InPlane2_Hi
	swap	d0
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,plane3
	move.w	d0,InPlane3_Lo
	swap	d0
	move.w	d0,InPlane3_Hi
	swap	d0
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,Buff_plane1
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,Buff_plane2
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,Buff_plane3
	add.l	#TUBE_PLANE_SIZE,d0
	move.l	d0,d1
	move.w	d0,InPlane4_Lo
	swap	d0
	move.w	d0,InPlane4_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,InPlane5_Lo
	swap	d0
	move.w	d0,InPlane5_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,InPlane6_Lo
	swap	d0
	move.w	d0,InPlane6_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.l	d0,Page_Mem
	
	move.l	d1,d0
	add.l	#(162+9)*40,d0		;get past titles
	move.w	d0,PageReset1_Lo	;insert
	swap	d0
	move.w	d0,PageReset1_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,PageReset2_Lo
	swap	d0
	move.w	d0,PageReset2_Hi
	move.w	#40,text_bpr
	bsr	Draw_All_Pages
	bsr	Set_Current_Page
	bsr	Set_Up_Text_Copper
	bsr	Tube_Set_up
	bsr	Add_New_Ring

	move.l	#blank_data,d0
	move.w	d0,insprite0l
	move.w	d0,insprite1l
	move.w	d0,insprite2l
	move.w	d0,insprite3l
	move.w	d0,insprite4l
	move.w	d0,insprite5l
	move.w	d0,insprite6l
	move.w	d0,insprite7l
	swap	d0
	move.w	d0,insprite0h
	move.w	d0,insprite1h
	move.w	d0,insprite2h
	move.w	d0,insprite3h
	move.w	d0,insprite4h
	move.w	d0,insprite5h
	move.w	d0,insprite6h
	move.w	d0,insprite7h

	clr.b	nasty_user


	move.l	#instr_copper,cop1lch(a6)
	clr.w	copjmp1(a6)
	jsr	Sync
	move.w	#$8000+BIT_PLANE_DMA,dmacon(a6)
wait_for_exit_instr
	jsr	Sync
	bsr	Do_Rings
	bsr	Set_Current_Page
	jsr	Get_Stick_Readings
	bsr	Check_Pages
	tst	fire
	beq.s	wait_for_exit_instr		
	move.w	#BIT_PLANE_DMA,dmacon(a6)
	move.w	#CREDITS,Schedule_Entry
	rts


**********************************************
***    SET UP TEXT COPPER                  ***
**********************************************
Set_Up_Text_Copper

	move.w	#$7d01+$0900,d0
	move.l	#Instr_Text_Cols,a0
	move.w	#9-1,d2
Instr_Cols_Loop
	move.w	#9-1,d1
	move.l	#Instr_Colours,a1	
Inner_Cols_Loop
	move.w	#$192,(a0)+
	move.w	(a1)+,(a0)+
	move.w	#$194,(a0)+
	move.w	(a1)+,(a0)+
	move.w	#$196,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$0100,d0
	move.w	d0,(a0)+
	move.w	#$fffe,(a0)+
	dbra	d1,Inner_Cols_Loop
	dbra	d2,Instr_Cols_Loop
	rts

Instr_Colours
	dc.w	$888,$800,$080
	dc.w	$999,$900,$090
	dc.w	$aaa,$a00,$0a0
	dc.w	$ccc,$c00,$0c0
	dc.w	$eee,$e00,$0e0
	dc.w	$eee,$e00,$0e0
	dc.w	$ccc,$c00,$0c0
	dc.w	$aaa,$a00,$0a0
	dc.w	$999,$900,$090



**********************************************
***    SET CURRENT PAGE                    ***
**********************************************
Set_Current_Page
	
	move.l	page_mem,a0
	move.w	page_number,d0
	mulu	#PAGE_PLANE*2,d0
	add.l	a0,d0
	
	move.w	d0,PagePlane1_Lo	;insert
	swap	d0
	move.w	d0,PagePlane1_Hi
	swap	d0
	add.l	#PAGE_PLANE,d0
	move.w	d0,PagePlane2_Lo
	swap	d0
	move.w	d0,PagePlane2_Hi

	rts

**********************************************
***    DRAW ALL PAGES                      ***
**********************************************
Draw_All_Pages

	move.l	#PAGE_PLANE,Plane_Skip_Size

	move.l	Page_Mem,a3
	move.l	#Instruction_Pages,a0
	move.w	#MAX_PAGES-1,d2
Draw_Pages_Loop	
	move.l	(a0)+,a4
	move.w	#3,d0
	clr.w	d1
	movem.l	d0-d2/a0/a3,-(sp)
	bsr	Display_Small_String
	movem.l	(sp)+,d0-d2/a0/a3
	add.l	#PAGE_PLANE*2,a3
	dbra	d2,Draw_Pages_Loop

	move.l	#LO_RES_PLANE,Plane_Skip_Size
	rts

**********************************************
***    CHECK PAGES                        ***
**********************************************
Check_Pages

	tst.w	xdirec
	beq.s	no_page_movement
	tst.b	nasty_user
	beq.s	scan_page_move
	rts
scan_page_move
	tst.w	xdirec
	bmi.s	turn_page_left
	cmp.w	#NUMBER_OF_PAGES-1,page_number
	beq.s	no_page_movement
	move.w	#Sound_Pling,sound_chan2
	jsr	Sound_Effects
	addq.w	#1,page_number
	move.b	#1,Nasty_User
	rts
turn_page_left		
	tst	page_number
	beq.s	no_page_movement
	move.w	#Sound_Pling,sound_chan2
	jsr	Sound_Effects
	subq.w	#1,page_number
	move.b	#1,nasty_user
	rts
no_page_movement
	clr.b	nasty_user
	rts
		
Nasty_User
	dc.b	0
	even
	

Page_Mem		dc.l	0
Page_number		dc.w	0
		
