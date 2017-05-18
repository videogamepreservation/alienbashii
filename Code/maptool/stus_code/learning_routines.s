Display_Object_Parameters
	move.l	#Object_Parameters_Window,a0
	bsr	create_window
	move.l	#Object_Parameters_Button_List,a0
	bsr	display_button_list

	move.l	#Object_Parameters_Window,a0
	move.l	#Object_Parameter_Text,a1
	move.w	#10,d0
	move.w	#5,d1
	move.w	#2,d2
	move.w	#1,d3
	bsr	Write_Text
	
	move.w	#0,d0
	move.l	#Object_Wide_Parameters,a1
print_par_loop
	move.w	d0,d2
	mulu.w	#6,d2	
	bsr	Draw_Parameter
	addq.w	#1,d0
	cmp.w	#7,d0
	blt.s	print_par_loop
	rts

Remove_Object_Parameters
	move.l	#Object_Parameters_Button_List,a0
	bsr	remove_button_list
	move.l	#Object_Parameters_Window,a0
	bsr	destroy_window
	rts

Increase_Object_Parameter
	move.l	clicked_button,a0
	moveq	#0,d0
	move.b	button_data(a0),d0
	move.w	d0,d2
	mulu.w	#6,d2
	
	move.l	#Object_Wide_Parameters,a1
	move.w	(a1,d2.w),d1
	cmp.w	4(a1,d2.w),d1
	bge.s	Cant_Increment_Parameter
	bsr	Delete_Parameter
	addq.w	#1,(a1,d2.w)
	bsr	Draw_Parameter
Cant_Increment_Parameter
	rts

Decrease_Object_Parameter
	move.l	clicked_button,a0
	moveq	#0,d0
	move.b	button_data(a0),d0
	move.w	d0,d2
	mulu.w	#6,d2
	
	move.l	#Object_Wide_Parameters,a1
	move.w	(a1,d2.w),d1
	cmp.w	2(a1,d2.w),d1
	ble.s	Cant_Decrement_Parameter
	bsr	Delete_Parameter
	subq.w	#1,(a1,d2.w)
	bsr	Draw_Parameter
Cant_Decrement_Parameter
	rts

Draw_Parameter
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#Object_Parameters_Window,a0
	move.w	d0,d1
	move.w	#140,d0
	mulu.w	#11,d1
	add.w	#5,d1
	move.w	(a1,d2.w),d3
	move.w	#1,d2
	move.w	#1,d4
	bsr	Write_Num
	movem.l	(sp)+,d0-d7/a0-a6
	rts

Delete_Parameter
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#Object_Parameters_Window,a0
	move.w	d0,d1
	move.w	#140,d0
	mulu.w	#11,d1
	add.w	#5,d1
	move.w	(a1,d2.w),d3
	move.w	#1,d2
	move.w	#0,d4
	bsr	Write_Num
	movem.l	(sp)+,d0-d7/a0-a6
	rts

	
load_object_memory
	move.l	#Load_Object_Data,File_Routine_Pointer
	bsr	display_file_request
	rts

Load_Object_Data
	move.l	#Object_File_Structure,a0
	bsr	LoadAnyOldFile
	moveq.w	#0,d0
	tst.l	d0			; error occured?
	bne.s	error_while_object_load
	bsr	remove_file_request
	clr.w	Object_Selected
	cmp.l	#"OBJ.",Object_Base
	beq.s	obj_file_right_type
	move.w	#4000,d0
	bsr	Erase_Learned_Objects
	bra.s	error_while_object_load
obj_file_right_type	
	move.l	#Object_File_Structure,a0
	move.l	#Object_Base,d0
	add.l	FH_Length(a0),d0
	move.l	d0,End_Of_Object_Memory

	bsr	count_objects
	bra.s	done_object_load

error_while_object_load		
	jsr	error_routine		; error already in d0
done_object_load
	rts

save_object_memory
	move.l	End_Of_Object_Memory,d0
	sub.l	#Object_Base,d0
	move.l	d0,Object_File_Structure+12		; length
	move.l	#Save_Object_Data,File_Routine_Pointer
	bsr	display_file_request
	rts

Save_Object_Data
	move.l	#Object_File_Structure,a0
	bsr	SaveAnyOldFile
	moveq.w	#0,d0
	tst.l	d0			; error occured?
	bne.s	error_while_object_save
	bsr	remove_file_request
	bra.s	done_object_save

error_while_object_save		
	jsr	error_routine		; error already in d0
done_object_save
	rts

count_objects
	move.l	Object_Memory,d2		; first entry
	sub.l	#Object_Store,d2		; difference in memory
	move.w	#0,d0
	move.l	#Object_Memory,a0
count_obj_loop
	cmp.l	#$ffffffff,(a0)+
	beq.s	done_obj_count
	addq.w	#1,d0
	sub.l	d2,-4(a0)
	bra.s	count_obj_loop
done_obj_count
	move.w	d0,Number_Learned_Objects
	rts		
	
Display_Stored_Object
	bsr	show_stored_signature
	bsr	show_object_specification
	rts
	
show_object_specification

	move.l	#Object_Details_Window,a0
	move.w	#6,d0
	move.w	#110,d1
	move.w	#3,d2
	move.w	#44,d3
	bsr	Clear_Word_Chunk

	move.l	#Object_Details_Window,a0
	move.w	#15,d0
	move.w	#110,d1
	move.w	#7,d2
	move.w	#44,d3
	bsr	Clear_Word_Chunk

	tst.w	Object_Selected
	beq	Cant_Show_Object	
	move.l	#Object_Memory,a0
	move.w	Object_Selected,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	move.l	(a0,d0.w),a1
	
	move.l	#Object_Details_Window,a0
	move.w	#4+9*10,d0
	move.w	#110,d1
	move.w	#2,d2
	move.w	OD_Width(a1),d3
	move.w	#1,d4
	bsr	Write_Num

	move.l	#Object_Details_Window,a0
	move.w	#4+9*10,d0
	move.w	#121,d1
	move.w	#2,d2
	move.w	OD_Height(a1),d3
	move.w	#1,d4
	bsr	Write_Num

	move.l	#Object_Details_Window,a0
	move.w	#4+9*10,d0
	move.w	#132,d1
	move.w	#2,d2
	move.w	OD_Perimeter(a1),d3
	move.w	#1,d4
	bsr	Write_Num


	move.l	#Object_Details_Window,a0
	move.w	#4+9*10,d0
	move.w	#143,d1
	move.w	#2,d2
	move.l	OD_Area(a1),d3
	lsr.w	d3			; was *2, now is not
	move.w	#1,d4
	bsr	Write_Num

	move.l	#Object_Details_Window,a0
	move.w	#4+24*10,d0
	move.w	#110,d1
	move.w	#2,d2
	move.w	OD_Centroid_X(a1),d3
	move.w	#1,d4
	bsr	Write_Num

	move.l	#Object_Details_Window,a0
	move.w	#4+24*10,d0
	move.w	#121,d1
	move.w	#2,d2
	move.w	OD_Centroid_Y(a1),d3
	move.w	#1,d4
	bsr	Write_Num

	move.w	OD_ID(a1),d0
	move.l	#Object_Names,a1
	mulu.w	#Object_Name_Length,d0
	lea.l	(a1,d0.w),a1

	move.l	#Object_Details_Window,a0
	move.w	#4+24*10,d0
	move.w	#132,d1
	move.w	#2,d2
	move.w	#1,d3
	bsr	Write_Text

	jsr	disp_obj_num
	
Cant_Show_Object
	rts
		
Show_Stored_Signature
	move.l	#Object_Details_Window,a0
	move.w	#1,d0
	move.w	#6,d1
	move.w	#19,d2
	move.w	#89,d3
	bsr	Clear_Word_Chunk
	
	tst.w	Object_Selected
	beq.s	Cant_Draw_Signature	
	move.l	#Object_Memory,a0
	move.w	Object_Selected,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	move.l	(a0,d0.w),a0
	add.l	#OD_Signature,a0
	move.l	#Object_Details_Window,a1
	jsr	draw_radii_signature
Cant_Draw_Signature
	rts
	
Erase_Learned_Objects
	clr.w	Number_Learned_Objects
	move.l	#$ffffffff,Object_Memory
	move.l	#Object_Store,End_Of_Object_Memory
	rts
	
Increase_Object_Type
	move.l	#Object_Memory,a0
	move.w	Object_Selected,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	move.l	(a0,d0.w),a1

	addq.w	#1,OD_ID(a1)
	cmp.w	#No_Object_Types,OD_ID(a1)
	blt.s	no_type_cycle
	move.w	#0,OD_ID(a1)
no_type_cycle
	bsr	Show_Object_Specification
	rts
	
Increase_Object_Number
	bsr	erase_obj_num
	move.w	Object_Selected,d0
	cmp.w	Number_Learned_Objects,d0
	blt.s	ion
	move.w	Number_Learned_Objects,Object_Selected
	bra.s	ioned
ion	
	addq.w	#1,Object_Selected
ioned
	bsr	disp_obj_num
	bsr	Display_Stored_Object
	rts

Decrease_Object_Number
	cmp.w	#1,Object_Selected
	ble.s	dont_don
	bsr	erase_obj_num
	subq.w	#1,Object_Selected
	bsr	disp_obj_num
dont_don
	bsr	Display_Stored_Object
	rts

disp_obj_num
	move.l	#Object_Details_Window,a0
	move.w	#390+50,d0
	move.w	#20,d1
	move.w	#1,d2
	move.w	Object_Selected,d3
	move.w	#1,d4
	jsr	Write_Num
	rts

erase_obj_num
	move.l	#Object_Details_Window,a0
	move.w	#390+50,d0
	move.w	#20,d1
	move.w	#1,d2
	move.w	Object_Selected,d3
	move.w	#0,d4
	jsr	Write_Num
	rts
	
Delete_Object
	move.w	Object_Selected,d0
	beq.s	Cant_Delete_Object
	cmp.w	Number_Learned_Objects,d0
	bgt.s	Cant_Delete_Object
	subq.w	#1,d0
	lsl.w	#2,d0			; get longwords
	move.l	#Object_Memory,a0
	move.l	(a0,d0.w),a1		; where the object is
	lea.l	(a0,d0.w),a2		; pointer to objects
	move.l	4(a0,d0.w),a3		; where next object is
	cmp.l	#$ffffffff,a3		; last in the list
	beq.s	done_shift_up
shift_up_loop
	cmp.l	End_Of_Object_Memory,a3
	bge.s	Done_Shift_Up	
	move.w	(a3)+,d0			
	cmp.w	#$ffff,d0		; found end of an object?
	bne.s	object_not_reached
	move.l	a3,(a2)+			; put start of next object in pointer
object_not_reached
	move.w   d0,(a1)+	
	bra.s	shift_up_loop
Done_Shift_Up
	move.l	a1,End_Of_Object_Memory
	move.l	#$ffffffff,(a2)
	subq.w	#1,Number_Learned_Objects
	bsr	Increase_Object_Number	; makes sure object_selected <= max objects
Cant_Delete_Object
	rts	
	
Learn_Object
	move.w	Number_Learned_Objects,d0
	cmp.w	#Max_Stored_Objects,d0
	bge.s	No_Object_Store_Left
	lsl.w	#2,d0			; get longwords offset
	move.l	#Object_Memory,a0	; pointers to the objects
	move.l	End_Of_Object_Memory,a1	; end of the object memory
	move.l	a1,(a0,d0.w)		; is now where object starts
	move.l	#$ffffffff,4(a0,d0.w)	; put new list terminator in
	move.l	a1,a0			; where to copy the data in
	bsr	Copy_Object_to_Store
	addq.w	#1,Number_Learned_Objects
	bra.s	Object_Stored
No_Object_Store_Left
	move.w	#3000,d0			; means could'nt store
	jsr	error_routine
Object_Stored
	rts	

Copy_Object_to_Store

* Send Store Start in a0
	move.l	#Current_Object_Data,a1
learn_loop
	cmp.w	#$ffff,(a1)
	beq.s	Object_Learnt
	move.w	(a1)+,(a0)+
	bra.s	learn_loop
	
Object_Learnt
	move.w	#$ffff,(a0)+
	move.l	a0,End_Of_Object_Memory	; new object pointer
	rts


Baseline_Object
	btst.b	#6,$bfe001
	beq.s	Set_Baseline

         move.w	Mouse_Y,Baseline
	sub.w	#8,BaseLine
	
	cmp.w	#6,Baseline
	blt.s	No_Base_Line
	cmp.w	#94,Baseline
	bgt.s	No_Base_Line

	move.l	#Object_Details_Window,a0
	move.w	#50,d0
	move.w	Baseline,d1
	move.w	#280,d2
	move.w	d1,d3
	bsr 	EOR_Draw_Line

BaseSync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	Basesync		

	move.l	#Object_Details_Window,a0
	move.w	#50,d0
	move.w	Baseline,d1
	move.w	#280,d2
	move.w	d1,d3
	bsr 	EOR_Draw_Line

No_Base_Line	
	bra	Baseline_Object

Set_Baseline
	move.w	Baseline,d0
	sub.w	Object_Min_X,d0
	move.w	d0,Object_Baseline
	rts

BaseLine
	dc.w	0

Auto_Find_Staves

	move.b	#1,pointer_state
	bsr	Start_Processing_Task

	move.w	Image_Start_Y,d1		; y start co-ordinate

top_stave_search_loop
	btst.b	#10,$dff016
	beq.s	Done_stave_search
	bsr	check_for_stave
	tst.l	d3			; found stave
	beq.s	found_top_stave
		
	addq.w	#1,d1
	cmp.w	Image_End_Y,d1
	ble.s	top_stave_search_loop
	bra.s	stave_find_error
found_top_stave
	move.w	d1,top_stave_pos	
	move.w	Image_End_Y,d1		; y start co-ordinate

bot_stave_search_loop
	btst.b	#10,$dff016
	beq.s	Done_stave_search
	bsr	check_for_stave
	tst.l	d3			; found stave
	beq.s	found_bot_stave
		
	subq.w	#1,d1
	cmp.w	Image_Start_Y,d1
	bge.s	bot_stave_search_loop
	bra.s	stave_find_error
found_bot_stave
	sub.w	#2,d1
	move.w	d1,bot_stave_pos	

	move.w	bot_stave_pos,d0
	move.w	top_stave_pos,d1
	move.w	d1,d2
	sub.w	d1,d0
	move.w	d0,rec_stave_gap
	sub.w	d0,d1
	move.w	d1,rec_staves_start
	
	mulu.w	#300,d0		  	times 3 for 3 staves (*10 more accuracy)
	move.w	d0,rec_octave_span
	divu.w	#28,d0			; number of segments in 3 staves
	move.w	d0,rec_note_distance	; still * 10	
	
done_stave_search
stave_find_error
	move.b	#0,pointer_state
	bsr	End_Processing_Task

	move.w	#500,d0
	move.w	top_stave_pos,d1
	move.w	d1,d3
	move.w	#630,d2
	move.l	#Main_Screen_Struct,a0
	bsr	Draw_Line

	move.w	#500,d0
	move.w	bot_stave_pos,d1
	move.w	d1,d3
	move.w	#630,d2
	move.l	#Main_Screen_Struct,a0
	bsr	Draw_Line
	rts

top_stave_pos	dc.w	0
bot_stave_pos	dc.w	0

check_for_stave
	move.w	Image_Start_X,d0		; x start co-ordinate
	clr.w	Stave_Pix_Count
check_stave_loop
	move.l	#Main_Screen_Struct,a0
	move.l	Screen_Mem(a0),a0
	
	bsr	Get_Stave_Grey
	cmp.w	#8,d3
	blt.s	no_stave_point
	add.w	#1,Stave_Pix_Count
no_stave_point
	add.w	#1,d0
	cmp.w	Image_End_X,d0
	ble.s	check_stave_loop
	
	move.w	Image_End_X,d3
	sub.w	Image_Start_X,d3		; image width

	move.w	Stave_Pix_Count,d4
	mulu.w	#100,d4
	divu.w	d3,d4				; 50% percent
	cmp.w	#70,d4
	blt.s	no_stave_line
	moveq.l	#0,d3
	bra.s	done_123
no_stave_line
	moveq.l	#-1,d3
done_123
	rts
	
Stave_Pix_Count	dc.w	0

Get_Stave_Grey
	move.w	#3,d4		; 4 planes 
	add.l	#3*(80*256),a0	; point to last plane
	moveq	#0,d3
grey_stave_pix_loop
	lsl.b	d3		
	bsr	Read_Pixel_Value
	btst	#0,d2
	beq.s	no_stave_grey_set
	bset	#0,d3
no_stave_grey_set

	sub.l	#80*256,a0
	dbra	d4,grey_stave_pix_loop
	rts


Set_Stave_Position
	bra	auto_find_staves
	btst.b	#10,$dff016
	bne.s	no_expand_staves
	addq.w	#1,rec_stave_gap
	cmp.w	#60,rec_stave_gap
	ble.s	stave_size_ok
	move.w	#1,rec_stave_gap
stave_size_ok	
no_expand_staves

	move.w	mouse_y,d0

	btst.b	#6,$bfe001
	beq	Quit_Set_Staves
	cmp.w	#170,d0
	bgt	Stave_Pos_Too_Low

	move.l	#main_screen_struct,a0

	move.w	#3,d4
	move.w	d0,d1
	move.w	d0,d3
	move.w	#320,d0
	move.w	#639,d2
draw_staves_loop
	movem.l	a0-a6/d0-d7,-(sp)
	bsr	EOR_draw_line
	movem.l	(sp)+,a0-a6/d0-d7

	add.w	rec_stave_gap,d1
	add.w	rec_stave_gap,d3
	dbra	d4,draw_staves_loop
	
	move	#8000,d4
stavpause
*	dbra	d4,stavpause	

	
StavSync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	Stavsync		

Delete_Stav
	move.w	#3,d4
	move.w	#320,d0
	move.w	#639,d2
del_staves_loop
	sub.w	rec_stave_gap,d1
	sub.w	rec_stave_gap,d3
	movem.l	a0-a6/d0-d7,-(sp)
	bsr	EOR_draw_line
	movem.l	(sp)+,a0-a6/d0-d7
	dbra	d4,del_staves_loop
Stave_Pos_Too_Low
	bra	Set_Stave_Position
Quit_Set_Staves
	move.w	d0,rec_staves_start	; top of the very highest note
	move.w	rec_stave_gap,d0
	mulu.w	#30,d0		  	times 3 for 3 staves (*10 more accuracy)
	move.w	d0,rec_octave_span
	divu.w	#28,d0			; number of segments in 3 staves
	move.w	d0,rec_note_distance	; still * 10	
	rts

rec_stave_gap	dc.w	1	
rec_octave_span	dc.w	0
rec_note_distance	dc.w	1
rec_staves_start	dc.w	0

Guess_Object
	move.w	#0,d0			; object number
comp_obj_loop
	addq.w	#1,d0
	cmp.w	Number_Learned_Objects,d0
	bgt.s	all_objects_compared
	bsr	Compare_Object
	tst.l	d1
	beq.s	comp_obj_loop

Object_Matched	
	move.w	d0,Object_Selected
	bsr	Display_Stored_Object	; see what match is made		
all_objects_compared
	rts

Compare_Object	
	move.l	d0,-(sp)

	subq.w	#1,d0
	lsl.w	#2,d0			; get longwords offset
	move.l	#Object_Memory,a0		; pointers to the objects
	move.l	(a0,d0.w),a0		; start of the object
	
	move.w	Object_Width,d0
	sub.w	OD_Width(a0),d0
	bpl.s	width_diff_pos
	neg.w	d0

width_diff_pos
	cmp.w	OBJ_Width_Tol,d0		; compare to width tolerance
	bgt	Object_Not_Recognised

	move.w	Object_Height,d0
	sub.w	OD_Height(a0),d0
	bpl.s	height_diff_pos
	neg.w	d0
height_diff_pos
	cmp.w	OBJ_Height_Tol,d0		; compare to width tolerance
	bgt	Object_Not_Recognised

        move.w	Object_Perimeter,d0
        sub.w	OD_Perimeter(a0),d0
        bpl.s	perim_diff_pos
	neg.w	d0
perim_diff_pos
	cmp.w	OBJ_Perim_Tol,d0		; compare to perimeter tolerance
	bgt	Object_Not_Recognised

        move.l	Object_Area,d0
        sub.l	OD_Area(a0),d0
        bpl.s	area_diff_pos
	neg.w	d0
area_diff_pos
	cmp.w	OBJ_Area_Tol,d0		; compare to area tolerance
	bgt	Object_Not_Recognised
         
Object_Recognised
	moveq.l	#-1,d1			; indicates object match	
	bra.s	Object_Compared
Object_Not_Recognised
	moveq.l	#0,d1			; indicates objects unmatched 
Object_Compared
	move.l	(sp)+,d0
	rts
