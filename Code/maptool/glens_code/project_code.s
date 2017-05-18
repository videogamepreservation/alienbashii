
FILENAME_LENGTH	EQU	216


********************************************
**** SET PROJECT INFORMATION            ****
********************************************
Set_Project_Information
*send struct pos in d0 and string in a0
	movem.l	a0-a1/d1,-(sp)
	
	move.l  #Current_Project_Information,a1
	move.w	#FILENAME_LENGTH-1,d1
copy_name_loop
	cmp.b	#0,(a0)
	beq.s	finished_copy
	move.b	(a0)+,(a1,d0.l)
	addq.w	#1,d0
	dbra	d1,copy_name_loop
finished_copy	
	movem.l	(sp)+,a0-a1/d1
	rts

********************************************
**** SET PROJECT VALUE                  ****
********************************************
Set_Project_Value
*send struct pos in d0 and value in d1

	movem.l	a0,-(sp)	
	move.l  #Current_Project_Information,a0
	add.l	d0,a0
	move.w	d1,(a0)
	movem.l	(sp)+,a0
	rts


**********************************
**** LOAD PROJECT REQUESTER  *****
**********************************
load_project_requester
	move.l	#load_project_file,File_Routine_Pointer
	jsr	display_file_request
	rts


**********************************
**** SAVE PROJECT REQUESTER  *****
**********************************
save_project_requester
	move.l	#save_project_file,File_Routine_Pointer
	jsr	display_file_request
	rts

**********************************
**** SAVE PROJECT FILE       *****
**********************************
Save_Project_File
	
	move.l	#Current_Project_Information,a0
	move.w	sensativity,Project_Mouse_Sense(a0)
	cmp.l	#Map_Details,current_map_ptr
	beq.s	looking_at_first_map
	move.w	map_x_position,Project_Map2_X(a0)
	move.w	map_y_position,Project_Map2_Y(a0)
	move.w	map_details+Map_X_Val,Project_Map1_X(a0)
	move.w	map_details+Map_Y_Val,Project_Map1_Y(a0)
	bra.s	save_prj_Details
looking_at_first_map
	move.w	map_x_position,Project_Map1_X(a0)
	move.w	map_y_position,Project_Map1_Y(a0)
	move.w	map_details2+Map_X_Val,Project_Map2_X(a0)
	move.w	map_details2+Map_Y_Val,Project_Map2_Y(a0)	
save_prj_details	

	move.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_NEW,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	move.l	(sp)+,a6


	tst.l	d0
	beq.s	couldnt_save_project_file

	move.l	a6,-(sp)
	move.l	d0,Project_File_Handle
		
	move.l	d0,d1
	move.l	#Current_Project_Information,d2
	move.l	#Project_Struct_Size,d3
	move.l	dosbase,a6
	jsr	Write(a6)

	move.l	dosbase,a6
	move.l	project_file_handle,d1
	jsr	close(a6)			
	move.l	(sp)+,a6

Couldnt_save_project_file	
	jsr	remove_file_request	
	rts



**********************************
**** LOAD PROJECT FILE       *****
**********************************
Load_Project_File
	move.l	a6,-(sp)
	move.l	#Current_Filename,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	move.l	(sp)+,a6


	tst.l	d0
	beq.s	couldnt_load_project_file

	move.l	a6,-(sp)

	move.l	d0,Project_File_Handle
		
	move.l	d0,d1
	move.l	#Current_Project_Information,d2
	move.l	#Project_Struct_Size,d3
	move.l	dosbase,a6
	jsr	Read(a6)

	move.l	dosbase,a6
	move.l	project_file_handle,d1
	jsr	close(a6)

	move.l	(sp)+,a6
	
couldnt_load_project_file
	jsr	remove_file_request	
	bsr	Load_Project_Files
	
	rts


********************************************
***          LOAD PROJECT FILES          ***
********************************************
Load_Project_Files
	move.l	a6,-(sp)

***	LOAD PAGES

	clr.l	d2
	move.l	#Picture_Pages,a1
	move.l	#Current_Project_Information,a0
	move.w	#4-1,d1
Load_In_Pages
	move.l	(a1,d2),page_pointer

	tst.b	(a0)
	beq.s	no_gfx_page_saved
	movem.l	d1-d2/a0-a1/a6,-(sp)
	move.l	a0,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)

	tst.l	d0
	beq.s	cannot_load_page

	jsr	Load_Graphics
		
cannot_load_page	
	movem.l	(sp)+,d1-d2/a0-a1/a6
no_gfx_page_saved	
	add.l	#FILENAME_LENGTH,a0		;next name
	addq.w	#4,d2
	dbra	d1,Load_In_pages	
	move.l	(a1),page_pointer
	clr.w	current_page

*** LOAD MAPS
	move.l	#map_details,current_map_ptr

	move.l	#Current_Project_Information,a0
	move.w	Project_Map1_X(a0),map_details+Map_X_Val
	move.w	Project_Map1_Y(a0),map_details+Map_Y_Val

	add.l	#Project_Map1,a0

	tst.b	(a0)
	beq.s	cant_load_map1
	movem.l	a6/a0,-(sp)
	move.l	a0,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6/a0
	tst.l	d0
	beq.s	cant_load_map1
	jsr	Load_Map_Proj
cant_load_map1		

	move.l	#map_details2,current_map_ptr
	move.l	#Current_Project_Information,a0
	move.w	Project_Map2_X(a0),map_details2+Map_X_Val
	move.w	Project_Map2_Y(a0),map_details2+Map_Y_Val

	add.l	#Project_Map2,a0

	tst.b	(a0)
	beq.s	cant_load_map2
	movem.l	a6/a0,-(sp)
	move.l	a0,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6/a0
	tst.l	d0
	beq.s	cant_load_map2
	jsr	Load_Map_Proj
	move.l	#Current_Project_Information,a0
cant_load_map2

	move.l	#map_details,current_map_ptr	;reset

*** LOAD BUFFERS
	move.l	#Current_Project_Information,a0
	add.l	#Project_Buffers,a0
	
	tst.b	(a0)
	beq.s	cant_load_buffs
	movem.l	a6/a0,-(sp)
	move.l	a0,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a6/a0
	tst.l	d0
	beq.s	cant_load_buffs
	jsr	Load_Buffers_Proj

cant_load_buffs

*** LOAD BLK DATA LIST
	move.l	#Current_Project_Information,a0
	add.l	#Project_DataList,a0
	
	tst.b	(a0)
	beq.s	cant_load_blk_data_list
	movem.l	a0/a6,-(sp)
	move.l	a0,d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	Open(a6)
	movem.l	(sp)+,a0/a6
	tst.l	d0
	beq.s	cant_load_blk_data_list
	jsr	Load_Block_Data_From_File
cant_load_blk_data_list


****Other info to set up

	move.l	#Current_Project_Information,a0
	move.w	Project_Del_Block(a0),delete_block
	move.w	Project_Mouse_Sense(a0),sensativity
	move.w	Project_Map1_X(a0),map_x_position
	move.w	Project_Map1_Y(a0),map_y_position
	jsr	Convert_Delete_Block_Number_To_Memory	
	move.l	(sp)+,a6
	rts


Project_Page1		rs.b	FILENAME_LENGTH
Project_Page2		rs.b	FILENAME_LENGTH
Project_Page3		rs.b	FILENAME_LENGTH
Project_Page4		rs.b	FILENAME_LENGTH
Project_Map1		rs.b	FILENAME_LENGTH
Project_Map1_X		rs.w	1
Project_Map1_Y		rs.w	1	
Project_Map2		rs.b	FILENAME_LENGTH	
Project_Map2_X		rs.w	1
Project_Map2_Y		rs.w	1
Project_Buffers		rs.b	FILENAME_LENGTH
Project_AlienList	rs.b	FILENAME_LENGTH
Project_DataList	rs.b	FILENAME_LENGTH
Project_Del_Block	rs.w	1
Project_Mouse_sense	rs.w	1
Project_Struct_Size	rs.w	0


Current_Project_Information
	ds.b	Project_Struct_Size


Project_File_Handle
	dc.l	0