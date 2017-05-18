		OPT	c-
BI_BPR		EQU	80
BI_Width		EQU	640
BI_Height	EQU	200

Start_Processing_Task
	tst.w	Blank_On_Processing
	bmi.s	no_blank_proc
	move.w	#$0200+$0000,Screen_Mode
no_blank_proc
	rts

End_Processing_Task
	move.w	#$4200+$8000,Screen_Mode
	rts

Blank_On_Processing
	dc.w	-1

Toggle_BSM
	neg.w	Blank_On_Processing
	rts
	
Create_Object_Details_Window
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#Object_Details_Window,a0
	bsr	Create_Window	
	move.l	#Object_Details_Buttons,a0
	bsr	Display_Button_List

        move.l	#Object_Details_Window,a0
	move.w	#15,d0
	move.w	#5,d1
	move.w	#16+(19*16),d2
        move.w	#5,d3
   	bsr	Draw_Line

        move.l	#Object_Details_Window,a0
	move.w	#16+(19*16),d0
	move.w	#5,d1
	move.w	#16+(19*16),d2
        move.w	#95,d3
   	bsr	Draw_Line

        move.l	#Object_Details_Window,a0
	move.w	#16+(19*16),d0
	move.w	#95,d1
	move.w	#15,d2
        move.w	#95,d3
   	bsr	Draw_Line

        move.l	#Object_Details_Window,a0
	move.w	#15,d0
	move.w	#95,d1
	move.w	#15,d2
        move.w	#5,d3
   	bsr	Draw_Line


	move.l	#Object_Details_Window,a0
	move.l	#Object_Text,a1
	move.w	#6,d0
	move.w	#110,d1
	move.w	#2,d2
	move.w	#1,d3
	bsr	Write_Text
	
	bsr	disp_obj_num

	movem.l	(sp)+,d0-d7/a0-a6
	rts

Close_Object_Details_Window
	move.l	#Object_Details_Buttons,a0
	bsr	Remove_Button_List
	move.l	#Object_Details_Window,a0
	bsr	Destroy_Window        
	rts	

Sketchy
	btst.b	#10,$dff016
	beq.s	Quit_Draw

	btst.b	#6,$bfe001
	bne.s	Sketchy
	move.w	mouse_x,sketch_x
	move.w	mouse_y,sketch_y
Keep_Drawing
	btst.b	#6,$bfe001
	bne.s	Sketchy
	move.w	mouse_x,d0
	move.w	mouse_y,d1
	move.w	sketch_x,d2
	move.w	sketch_y,d3
	move.w	d0,sketch_x
	move.w	d1,sketch_y

	move.l	#main_screen_struct,a0
	bsr	draw_line
	bra.s	Keep_Drawing

Quit_Draw
	rts

Sketch_X	dc.w	0
Sketch_Y	dc.w	0

Reset_Trace_Variables
	move.w	Image_Start_X,X_Scan
	move.w	Image_Start_Y,Y_Scan
	rts

Set_Image_Window

WD	btst.b	#6,$bfe001
	bne.s	WD			; press down mouse button (start drag)

	move.w	mouse_x,Image_Start_X
	move.w	mouse_y,Image_Start_y

drag_box_loop
	move.l	#main_screen_struct,a0

	move.w	mouse_x,Box_X
	move.w	mouse_y,Box_Y

DrawBoxIn
	move.w	Image_Start_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

	move.w	Box_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Box_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Image_Start_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

Boxsync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	Boxsync		Test for zero (box can't draw past)

Delete_Box
	move.w	Image_Start_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line

	move.w	Box_X,d0
	move.w	Image_Start_Y,d1
	move.w	Box_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Box_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Box_Y,d3
	bsr	EOR_draw_line
	
	move.w	Image_Start_X,d0
	move.w	Box_Y,d1
	move.w	Image_Start_X,d2
	move.w	Image_Start_Y,d3
	bsr	EOR_draw_line
		
	btst.b	#6,$bfe001
	beq	drag_box_loop			; release mouse button (end drag)

	move.w	Box_X,Image_End_X
	move.w	Box_Y,Image_End_Y
	
	move.w	Image_End_X,d0		;
	cmp.w	Image_Start_X,d0
	bge.s	Box_Drawn_Ok_X
	move.w	Image_Start_X,Image_End_X
	move.w	d0,Image_Start_X	
Box_Drawn_Ok_X	
	move.w	Image_End_Y,d0		;
	cmp.w	Image_Start_Y,d0
	bge.s	Box_Drawn_Ok_Y
	move.w	Image_Start_Y,Image_End_Y
	move.w	d0,Image_Start_Y
Box_Drawn_Ok_Y

	bsr	Reset_Trace_Variables	; reset to be sure
	rts
Box_X	dc.w	0
Box_Y	dc.w	0

					
Find_Edges

	move.b	#1,pointer_state
	bsr	Start_Processing_Task

	move.w	Image_Start_X,d0		; x start co-ordinate
	move.w	Image_Start_Y,d1		; y start co-ordinate
	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a0
pixel_loop
	btst.b	#10,$dff016
	beq.s	Done_Edge_Trace

	bsr	Get_Four_Pixels	; into d3 d4 
				;      d5 d6
	
	move.b	d3,d2
	or.b	d4,d2
	or.b	d5,d2
	or.b	d6,d2
	
	and.b	d3,d6
	and.b	d4,d5
	
	or.b	d5,d6
	not.b	d6
	and.b	d6,d2

	bsr	Write_Pixel_Value

	add.w	#1,d0
	cmp.w	Image_End_X,d0
	ble.s	pixel_loop
	move.w	Image_Start_X,d0
	add.w	#1,d1
	cmp.w	Image_End_Y,d1
	ble.s	pixel_loop
Done_Edge_Trace
	move.b	#0,pointer_state
	bsr	End_Processing_Task

	rts
	
Scan_For_Objects

	move.w	X_Scan,d0
	move.w	Y_Scan,d1

	cmp.w	Image_End_X,d0
	blt.s	Not_Finished_linear
	cmp.w	Image_End_Y,d1
	blt.s	not_finished_linear
	move.w	#-1,d2
	bra	Scan_Finished
	
Not_Finished_linear

	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a0
linear_search_loop
	btst.b	#10,$dff016
	bne.s	no_terminate_scan
	move.w	#-1,d2
	bra	Scan_Finished
no_terminate_scan
	bsr	Read_Pixel_Value
	btst	#0,d2			; pixel detected
	beq.s	No_Object_Found
	bsr.s	Trace_Object
	tst.w	d2			; no errors or disqualification?
	bne.s	done_object_scan
No_Object_Found
	
	addq.w	#1,d1
	cmp.w	Image_End_Y,d1
	blt.s	yscanok
	move.w	Image_Start_Y,d1
	addq.w	#1,d0
	cmp.w	Image_End_X,d0
	blt.s	yscanok
	move.w	#-1,d2			; scan ended		
	bsr	Reset_Trace_Variables
	bra.s	Scan_Finished
yscanok	
	move.w	d0,X_Scan
	move.w	d1,Y_Scan
	bra.s	linear_search_loop
Done_Object_Scan
	move.w	#0,d2
	bsr	Write_Pixel_Value		; in case of single pixel situation
Scan_Finished
	rts

	
Trace_Object
	movem.l	d0-d1,-(sp)
	move.w	d0,Start_Of_Object_X
	move.w	d1,Start_Of_Object_Y
	move.w	#0,Number_Of_Links
	move.l	#Object_Chain_Code,a2
	
	move.w	#0,Last_Vector

Trace_loop
	move.w	Last_Vector,d2		; to start searching
	bsr	Get_Vector		; Get Next Vector
	tst.w	d2
	beq	Trace_Error_Occured
	
	addq.w	#1,Number_of_Links
	move.w	d2,Last_Vector		; store for later

	move.w	Number_of_Links,d3
	cmp.w	OBJ_Max_Pixels,d3
	bge	Trace_Error_Occured

	move.w	d2,(a2)+
		
	move.w	Last_Vector,d2
	bsr	Move_In_Vector_Direction	; move to next location

	moveq.w	#0,d2
	bsr	Write_Pixel_Value		; clear current pixel

	cmp.w	Start_Of_Object_X,d0
	bne	trace_loop
	cmp.w	Start_Of_Object_Y,d1
	bne	trace_loop

	move.w	#$ffff,(a2)		; end chain code	
	move.b	#0,pointer_state
	cmp.w	#5,Number_Of_Links
	blt.s	Not_a_valid_object
	bsr	Calculate_Object_Details
	bsr	Radii_Signature
	move.w	#-1,d2
	bra.s	object_valid
Not_a_valid_object
	move.w	#0,d2
object_valid
	movem.l	(sp)+,d0-d1
	rts
	
Trace_Error_Occured
	move.w	#$ffff,(a2)		; end chain code	
	move.w	#0,d2
	movem.l	(sp)+,d0-d1
	rts
	
Get_Vector
	move.l	#Vector_Scan_Table,a5
	move.w	d2,d6
	asl.w	#2,d6		; multiply by 4 to get table offset

	move.w	(a5,d6.w),d3	; where to start vector scan
	move.w	2(a5,d6.w),d4	; where to stop vector scan

vec_check_loop
	move.w	d3,d2		; set d2 to vector to check
	movem.l	d0/d1,-(sp)		; save those regs

	bsr	Move_In_Vector_Direction
	bsr	Read_Pixel_Value	; 
	
	movem.l	(sp)+,d0/d1	; restore those regs

	btst	#0,d2		; pixel was set?
	bne.s	Vector_Found

	cmp.w	d3,d4
	beq.s	Finished_Vector_Sweep

	subq.w	#1,d3		; decrement to next vect
	bne.s	Vec_Not_Reset
	moveq.w	#8,d3
Vec_Not_Reset
	bra.s	vec_check_loop
Vector_Found
	move.w	d3,d2		; set final vector value
	rts
	
Finished_Vector_Sweep
*	move.w	#$fff,$dff180	; NOTE: This should not happen.
	move.w	#0,d2		; set value to 0 to let prog know
	rts
		
Move_In_Vector_Direction
	move.l	#Vector_Pixel_Table,a5
	move.w	d2,d6
	asl.w	#2,d6		; multiply by 4 to get table offset
	add.w	(a5,d6.w),d0
	add.w	2(a5,d6.w),d1
	rts
	
Vector_Pixel_Table
	dc.w	0,0		; first time (vector 0)
	dc.w	1,1
	dc.w	0,1
	dc.w	-1,1
	dc.w	-1,0
	dc.w	-1,-1
	dc.w	0,-1
	dc.w	1,-1
	dc.w	1,0
			 
Vector_Scan_Table
	dc.w	3,5		; first time (vector 0)	
	dc.w	3,6
	dc.w	3,7
	dc.w	5,8
	dc.w	5,1
	dc.w	7,2
	dc.w	7,3
	dc.w	1,4
	dc.w	1,5		
	
Get_Four_Pixels
	
	bsr.s	Read_Pixel_Value
	move.w	d2,d3
	addq.w	#1,d0

	bsr.s	Read_Pixel_Value
	move.w	d2,d4
	addq.w	#1,d1
	
	bsr.s	Read_Pixel_Value
	move.w	d2,d6
	subq.w	#1,d0

	bsr.s	Read_Pixel_Value
	move.w	d2,d5
	subq.w	#1,d1
	
	rts

Read_Pixel_Value
	movem.l	d0/d1/d3/a0,-(sp)

	mulu.w	#BI_BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	move.b	#7,d1	
	sub.b	d3,d1		
	btst.b	d1,(a0,d0.w)	; is it set
	beq.s	Zero
	bset	#0,d2	
	bra.s	One
Zero
	bclr	#0,d2
One	
	movem.l	(sp)+,d0/d1/d3/a0
	rts	

Write_Pixel_Value
	movem.l	d0/d1/d3/a0,-(sp)

	mulu.w	#BI_BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	

	btst	#0,d2
	beq.s	SetZero

	
	bset.b	d1,(a0,d0.w)	;
	bra.s	SetOne
SetZero
	
	bclr.b	d1,(a0,d0.w)	;
SetOne	
	movem.l	(sp)+,d0/d1/d3/a0
	rts	


Sketch_Object_Details

	move.l	#Object_Coordinate_List,a4
	move.l	#object_details_window,a0
	move.l	screen_mem(a0),a0
	move.w	Object_Centroid_X,d3
	move.w	Object_Centroid_X,d4
	add.w	Object_Min_X,d3
	add.w	Object_Min_Y,d4

	sub.w	Start_Of_Object_X,d3
	sub.w	Start_Of_Object_Y,d4
	add.w	#150,d3
	add.w	#50,d4
	
sk_obj_loop
	
	cmp.w	#$ffff,(a4)
	beq.s	sk_object

	move.w	(a4)+,d0
	move.w	(a4)+,d1
*	sub.w	d3,d0
*	sub.w	d4,d1
	
	cmp.w	#10,d0			; clip object x
	blt.s	sk_obj_loop
	cmp.w	#290,d0
	bgt.s	sk_obj_loop

	cmp.w	#6,d1			; clip object y
	blt.s	sk_obj_loop
	cmp.w	#94,d1
	bgt.s	sk_obj_loop
	
	moveq	#1,d2
	bsr	Write_Pixel_Value

	bra.s	sk_obj_loop
sk_object	
	move.w	Object_Centroid_X,d0
	move.w	Object_Centroid_Y,d1
	add.w	Object_Min_X,d0
	add.w	Object_Min_Y,d1
	
*	sub.w	d3,d0
*	sub.w	d4,d1
	
	move.l	#Object_Details_Window,a0
	move.l	#CrossHair,a1
	subq.w	#3,d0
	subq.w	#3,d1
	move.w	#1,d3
	move.w	#1,d2
	bsr	Write_Text
	rts	


Calculate_Object_Details
	
	move.w	#50,d0				; temporary virtual co-ords
	move.w	#50,d1
	move.l	#0,Object_Area
	move.l	#0,Object_Moment_X
	move.l	#0,Object_Moment_Y
	move.w	#32767,Object_Min_X
	move.w	#32767,Object_Min_Y
	move.w	#-32768,Object_Max_X
	move.w	#-32768,Object_Max_Y

	move.l	#Object_Chain_Code,a3
	move.l	#Object_Coordinate_List,a4
	move.l	#object_details_window,a0
	move.l	screen_mem(a0),a0
	
draw_obj_loop
	
	cmp.w	#$ffff,(a3)
	beq.s	redrawn_object

	move.w	d0,Last_X
	move.w	d1,Last_Y
	move.w	d0,(a4)+
	move.w	d1,(a4)+

	move.w	(a3)+,d2
	bsr	Move_In_Vector_Direction

; Min-Max Vars

	cmp.w	Object_Min_X,d0
	bge.s	NotSmallerthanMinX
	move.w	d0,Object_Min_X	
NotSmallerthanMinX
	cmp.w	Object_Max_X,d0
	ble.s	NotBiggerthanMaxX
	move.w	d0,Object_Max_X	
NotBiggerthanMaxX
	cmp.w	Object_Min_Y,d1
	bge.s	NotSmallerthanMinY
	move.w	d1,Object_Min_Y	
NotSmallerthanMinY
	cmp.w	Object_Max_Y,d1
	ble.s	NotBiggerthanMaxY
	move.w	d1,Object_Max_Y
NotBiggerthanMaxY
	
mathtime
	lsl.w	#2,d2
	move.l	#Vector_Maths_Jump_Table,a1
	move.l	(a1,d2.w),a1
	jsr	(a1)				; do mathematics

	bra.s	draw_obj_loop
redrawn_object	
	move.w	#$ffff,(a4)			; end co-ordinate_list

	move.l	Object_Area,d2
	move.l	Object_Moment_Y,d0
	move.l	Object_Moment_X,d1
	divu	d2,d0
	divu	d2,d1
	move.w	d0,Object_Centroid_X
	move.w	d1,Object_Centroid_Y
	
	move.w	Object_Min_X,d0
	sub.w	d0,Object_Centroid_X

	move.w	Object_Min_Y,d0
	sub.w	d0,Object_Centroid_Y
	
	move.w	Object_Max_X,Object_Width
	move.w	Object_Min_X,d0
	sub.w	d0,Object_Width

	move.w	Object_Max_Y,Object_Height
	move.w	Object_Min_Y,d0
	sub.w	d0,Object_Height
	
	move.w	#0,Object_ID

	move.w	Number_Of_Links,Object_Perimeter
	rts

VectorMaths_1

	move.w	Last_Y,d2
	mulu.w	d1,d2
	add.l	d2,Object_Moment_X		; ly*y

	move.w	Last_X,d2
	mulu.w	d0,d2
	sub.l	d2,Object_Moment_Y		; lx*-x

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	add.l	d2,Object_Area			; 2*y
	rts

VectorMaths_2

	move.w	Last_X,d2
	mulu.w	d2,d2
	sub.l	d2,Object_Moment_Y		; (-lx*lx)
	rts

VectorMaths_3
	move.w	Last_Y,d2
	mulu.w	d1,d2
	sub.l	d2,Object_Moment_X		; ly*(-y)

	move.w	Last_X,d2
	mulu.w	d0,d2
	sub.l	d2,Object_Moment_Y		; lx*-x

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	sub.l	d2,Object_Area			; -2*y
	rts

VectorMaths_4
	move.w	Last_Y,d2
	mulu.w	d2,d2
	sub.l	d2,Object_Moment_X		; -ly*ly

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	sub.l	d2,Object_Area			; -2*y
	rts

VectorMaths_5
	move.w	Last_Y,d2
	mulu.w	d1,d2
	sub.l	d2,Object_Moment_X		; ly*-y

	move.w	Last_X,d2
	mulu.w	d0,d2
	add.l	d2,Object_Moment_Y		; lx*x

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	sub.l	d2,Object_Area			; -2*y
	rts

VectorMaths_6

	move.w	Last_X,d2
	mulu.w	d2,d2
	add.l	d2,Object_Moment_Y		; lx*lx
	rts

VectorMaths_7
	move.w	Last_Y,d2
	mulu.w	d1,d2
	add.l	d2,Object_Moment_X		; ly*y

	move.w	Last_X,d2
	mulu.w	d0,d2
	add.l	d2,Object_Moment_Y		; lx*x

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	add.l	d2,Object_Area			; 2*y
	rts

VectorMaths_8
	move.w	Last_Y,d2
	mulu.w	d2,d2
	add.l	d2,Object_Moment_X		; ly*ly

	moveq.l	#0,d2
	move.w	d1,d2
	lsl.l	d2
	add.l	d2,Object_Area			; 2*y
	rts

TEST_CODE
	lsl.w	#1,d2
	move.w	d2,$dff180
	rts

CrossHair	dc.b	"+",0

Vector_Maths_Jump_Table
	dc.l	0		; there is no zero
	dc.l	VectorMaths_1
	dc.l	VectorMaths_2
	dc.l	VectorMaths_3
	dc.l	VectorMaths_4
	dc.l	VectorMaths_5
	dc.l	VectorMaths_6
	dc.l	VectorMaths_7
	dc.l	VectorMaths_8

WaitForMouse

down	btst.b	#6,$bfe001
	bne.s	down
up	btst.b	#6,$bfe001
*	beq.s	up

	rts

Save_New_Image_data
	rts

Read_IFF_Image_File
	movem.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6

	tst.l	d0
	beq.s	couldnt_load_it

	movem.l	d0,-(sp)
	bsr	remove_file_request
	movem.l	(sp)+,d0

	bsr	Load_Graphics
	cmp.l	#-1,a1
	bne.s	no_errors_here		
	bsr	error_routine
	bra.s	no_errors_here
couldnt_load_it
         bsr	display_error
no_errors_here
	rts

Load_an_Image_File
	bsr	reset_planes
	move.l	#Read_IFF_Image_File,File_Routine_Pointer
	bsr	display_file_request
	rts

Set_Recogniser_Screen
	move.l	#top_level_list,a0
	bsr	remove_button_list
	move.l	#recognition_button_list,a0
	bsr	display_button_list
	rts

Exit_Recognition_routine
	move.l	#recognition_button_list,a0
	bsr	remove_button_list
	move.l	#top_level_list,a0
	bsr	display_button_list
	bsr	clear_screen	
	bsr	setup_screen_colours	

	rts


Radii_Signature	
	move.l	#Object_Coordinate_List,a1
	move.l	#Object_Signature,a2	; 
	move.w	#0,Radii_Direction
	move.w	#0,Last_Radii_Point
	move.w	#0,Peak_Count
sig_loop
	cmp.w	#$ffff,(a1)
	beq	Done_Radii_Sig
	
	move.w	(a1)+,d2
	move.w	(a1)+,d3

	sub.w	Object_Centroid_X,d2
	sub.w	Object_Centroid_Y,d3
	sub.w	Object_Min_X,d2
	sub.w	Object_Min_Y,d3

	muls.w	d2,d2
	muls.w	d3,d3
	add.l	d2,d3

	move.l	d3,d0
	bsr	Square_root
	move.w	d0,d2

	move.w	Last_Radii_Point,d3
	move.w	d2,Last_Radii_Point
	sub.w	d2,d3
	beq.s	done_peak
	bpl.s	Going_Down
Going_Up
	tst.w	Radii_Direction
	beq.s	done_peak
	bra.s	Plot_peak
Going_Down
	tst.w	Radii_Direction
	bne.s	done_peak
Plot_Peak
	not.w	Radii_Direction
	cmp.w	#5,Peak_Count
	blt.s	Peak_not_Big_Enough
	clr.w	Peak_Count

	bset	#13,d2			; bit 13 set indicates a peak
	move.w	d2,(a2)+
	bra	sig_loop

Peak_not_Big_Enough	
	clr.w	Peak_Count
done_peak
	addq.w	#1,Peak_Count
	move.w	d2,(a2)+
skip_dot
	bra	sig_loop
Done_Radii_Sig
	move.w	#$ffff,(a2)
	rts

Radii_Direction	dc.w	0
Last_Radii_Point	dc.w	0
Peak_Count	dc.w	0


Draw_Radii_Signature

;a0 - Signature, a1 - Window
	
	move.w	#20,rxpos
	move.w	#80,rypos	
	move.w	#200,sig_pix_count	; object window size
	move.l	a0,a2

draw_sig_loop
	cmp.w	#$ffff,(a2)
	beq	Drawn_Radii_Sig

	move.w	(a2),d2
	btst	#13,d2
	beq.s	no_draw_peak
	bclr	#13,d2			; 
	move.w	rypos,d1
	sub.w	d2,d1 			; 
	move.w	#1,d2
	move.l	a1,-(sp)
	move.l	a1,a0

	move.l	#CrossHair,a1
	move.w	rxpos,d0
	subq.w	#4,d0
	subq.w	#4,d1
	move.w	#1,d3
	bsr	Write_Text
	move.l	(sp)+,a1

no_draw_peak
	move.w	rxpos,d0
	move.w	(a2)+,d2
	bclr	#13,d2			; ignore peak bit
	move.w	rypos,d1
	sub.w	d2,d1
	move.w	#1,d2
	move.l	a1,a0
	move.l	screen_mem(a0),a0
	bsr	Write_Pixel_Value
drawn_radius	
	addq.w	#1,rxpos
	sub.w	#1,sig_pix_count
	beq.s	drawn_radii_sig		; limit the draw to window size
	bra	draw_sig_loop
Drawn_Radii_Sig
	rts

rxpos		dc.w	0
rypos		dc.w	0
sig_pix_count	dc.w	1

Show_Radii_Signature
	move.l	#radii_signature_window,a0
	bsr	create_window
	move.l	#Radii_Button_List,a0
	bsr	display_Button_list
	bsr	force_buttons
	move.l	#Object_Signature,a0
	move.l	#radii_signature_window,a1
	bsr	draw_radii_signature
	rts

End_Radii_Signature
	move.l	#Radii_Button_List,a0
	bsr	remove_button_list
	move.l	#radii_signature_window,a0
	bsr	destroy_window
	rts

