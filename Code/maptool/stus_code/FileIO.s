LockDosList	EQU	-$28e
NextDosEntry	EQU	-$2b2

delay		equ	-168

MAX_FILES	EQU	79*2

open_dos	
	move.l	4,a6			;open dos lib
	lea	DosLib,a1
	jsr	-408(A6)
	move.l	d0,DosBase

	move.l	Info_Block,d0
	andi.l	#$fffffffc,d0
	move.l	d0,Info_Block
	rts

close_dos
	move.l	4,a6
	move.l	dosbase,a1
	jsr	-414(a6)			;close dos
	rts

LoadAnyOldFile
; a0 sent with pointer to file handle structure
; d0 returned with error number, d0 = 0 = no errors

	movem.l	d1-d7/a0-a6,-(sp)

	move.l	a0,File_Handle_Structure
	cmp.l	#MEM_FIX,FH_Memory_Type(a0) ; requires allocation?
	beq	Dont_Need_To_Deallocate
	tst.l	FH_Memory(a0)
	beq	Dont_Need_To_Deallocate
	
	move.l	FH_Memory(a0),a1
	move.l	FH_Length(a0),d0
	move.l	EXEC,a6
	jsr	-210(a6)			; de-allocate
	
	move.l	File_Handle_Structure,a0
	clr.l	FH_Memory(a0)
	clr.l	FH_Length(a0)
Dont_Need_To_Deallocate	

	move.l	FH_FileName(a0),d1
	move.l   #-2,d2			; mode read
	move.l	dosbase,a6
	jsr	-84(a6)			; lock
	tst.l	d0
	beq	DOS_Error_while_loading
	move.l	d0,lock
	
	move.l	lock,d1
	move.l	Info_Block,d2
	move.l	dosbase,a6
	jsr	-102(a6)
	tst.l	d0	
	beq	DOS_Error_while_loading
	
	move.l	Info_Block,a1
	move.l	124(a1),d0
	move.l	File_Handle_Structure,a0
	move.l	d0,FH_Length(a0)

	cmp.l	#MEM_FIX,FH_Memory_Type(a0) ; requires allocation?
	beq	Dont_Need_To_allocate
	
	move.l	exec,a6
	move.l	File_Handle_Structure,a0
	move.l	FH_Memory_Type(a0),d1
	jsr	-198(a6)			; allocate
	tst.l	d0
	beq	Couldnt_Allocate_File	

	move.l	File_Handle_Structure,a0
	move.l	d0,FH_Memory(a0)

Dont_Need_To_allocate	
	move.l	FH_FileName(a0),d1
	move.l	#MODE_OLD,d2
	move.l	dosbase,a6
	jsr	OPEN(a6)
	tst.l	d0
	beq	DOS_Error_while_loading
	move.l	d0,Current_File_Handle

	move.l	File_Handle_Structure,a0
	move.l	Current_File_Handle,d1
	move.l	FH_Memory(a0),d2
	move.l	FH_Length(a0),d3
	move.l	dosbase,a6
	jsr	READ(a6)
	tst.l	d0
	bne.s	File_Loaded_Ok
		
	move.l	Current_File_Handle,d1
	move.l	dosbase,a6
	jsr	CLOSE(a6)
 		move.l	lock,d1
	move.l	dosbase,a6
	jsr	-90(a6)			; Un-lock

	bra.s	DOS_Error_while_loading

File_Loaded_Ok
	move.l	Current_File_Handle,d1
	move.l	dosbase,a6
	jsr	CLOSE(a6)
	move.l	lock,d1
	move.l	dosbase,a6
	jsr	-90(a6)			; Un-lock

	moveq.l	#0,d0
	bra.s	exit_load_routine

Couldnt_Allocate_File
	move.l	#1001,d0
	bra.s	exit_load_routine

	move.l	lock,d1
	move.l	dosbase,a6
	jsr	-90(a6)			; Un-lock
		
DOS_Error_while_loading
	movem.l	a0-a6/d0-d7,-(sp)
	move.l	dosbase,a6
	move.l	#50*5,d1
	jsr	delay(a6)
	move.l	dosbase,a6
	jsr	-132(a6)
	movem.l	(sp)+,a0-a6/d0-d7
	
exit_load_routine		
	
	movem.l	(sp)+,d1-d7/a0-a6
	rts


SaveAnyOldFile
; a0 sent with pointer to file handle structure
; d0 returned with error number, d0 = 0 = no errors

	movem.l	d1-d7/a0-a6,-(sp)

	move.l	a0,File_Handle_Structure
	
	move.l	FH_FileName(a0),d1
	move.l	#MODE_NEW,d2
	move.l	dosbase,a6
	jsr	OPEN(a6)
	tst.l	d0
	beq	DOS_Error_while_saving
	move.l	d0,Current_File_Handle

	move.l	File_Handle_Structure,a0
	move.l	Current_File_Handle,d1
	move.l	FH_Memory(a0),d2
	move.l	FH_Length(a0),d3
	move.l	dosbase,a6
	jsr	Write(a6)
	tst.l	d0
	bne.s	File_Saved_Ok
		
	move.l	Current_File_Handle,d1
	move.l	dosbase,a6
	jsr	CLOSE(a6)

	bra.s	DOS_Error_while_saving

File_Saved_Ok
	move.l	Current_File_Handle,d1
	move.l	dosbase,a6
	jsr	CLOSE(a6)
	moveq.l	#0,d0
	bra.s	exit_save_routine
		
DOS_Error_while_saving

	movem.l	a0-a6/d0-d7,-(sp)
	move.l	dosbase,a6
	move.l	#50*5,d1
	jsr	delay(a6)
	move.l	dosbase,a6
	jsr	-132(a6)
	movem.l	(sp)+,a0-a6/d0-d7

	
exit_save_routine		
	
	movem.l	(sp)+,d1-d7/a0-a6
	rts


File_Handle_Structure	dc.l	0
Current_File_Handle	dc.l	0

RETURN		EQU	59
BACKSPACE 	EQU	62
	
Enter_FileName
	move.b	#0,Typed_Filename
	move.w	#0,char_position

	move.l	#File_Request_Window,a0
	move.w	#1,d0
	move.w	#97,d1
	move.w	#15,d2
	move.w	#10,d3
	bsr	Clear_Word_Chunk		; clear text
	
key_in_loop
	btst.b	#6,$bfe001
	beq	end_enter_file

	bsr	get_pressed_key			; key in d0
	tst.b	d0	
	beq.s	key_in_loop


	cmp.b	#KEY_RETURN,d0
	beq	end_enter_file
	
	cmp.b	#KEY_DELETE,d0
	bne.s	nobackspace
	cmp.w	#0,char_position
	ble.s	nobackspace
	subq.w	#1,char_position
	move.l	#Typed_Filename,a0
	move.w	char_position,d1
	move.b	#0,(a0,d1.w)			; terminate string
	bra.s	print_fname
nobackspace

	move.l	#Typed_Filename,a0
	move.w	char_position,d1

	cmp.w	#24,char_position
	bge.s	filename_to_big
	add.w	#1,char_position

	move.b	d0,(a0,d1.w)			; put character in
terminator
	move.b	#0,1(a0,d1.w)			; terminate string
filename_to_big
print_fname
	move.l	#File_Request_Window,a0
	move.w	#1,d0
	move.w	#97,d1
	move.w	#15,d2
	move.w	#10,d3
	bsr	Clear_Word_Chunk		; clear text
	
	move.l	#File_Request_Window,a0		; write in filename
	move.l	#typed_filename,a1
	move.w	#2,d2
	move.w	#16,d0
	move.w	#97,d1
	bsr	Write_Text
	bra	key_in_loop

end_enter_file
	move.l	#typed_filename,a1
	bra	concat_filename		;  
	rts

typed_filename	dc.b	0
		ds.b	35
	even
current_character	dc.b	0,0
char_position	dc.w	0

get_pressed_key
	jsr Read_Keyboard
	rts

Get_and_Display_Dir
	movem.l	a6,-(sp)
	move.l	4,a6
	jsr	permit(a6)	;stop clashes with workbench
	movem.l	(sp)+,a6
	bsr	load_directory		
	movem.l	a6/d0,-(sp)
	move.l	4,a6
	jsr	forbid(a6)	;stop clashes with workbench
	movem.l	(sp)+,a6/d0
	tst.l	d0
	beq.s	Error_Occured_Dont_Bother
	bsr	display_directory
Error_Occured_Dont_Bother
	rts

Get_and_Display_Vols
	bsr	load_volumes
	tst.l	d0
	beq.s	Vol_Error_Occured_Dont_Bother
	bsr	display_directory
Vol_Error_Occured_Dont_Bother
	rts


Select_Filename
	move.l	clicked_button,a0	; which filename was selected	
	moveq.w	#0,d0
	move.b	Button_Data(a0),d0
	
	move.w	Files_In_Dir,d1
	cmp.w	d1,d0
	bgt	No_FileName_Selected
	
	add.w	Top_File,d0
	move.l	#Dir_List,a0
	mulu.w	#32,d0
	add.l	d0,a0
	move.l	a0,Current_File		; pointer to filename
	cmp.b	#'D',(a0)		; directory selected ?
	bne.s	File_Selected
	
	move.l	#Directory,a1
dir_end_loop
	tst.b	(a1)+
	bne.s	dir_end_loop
	cmp.b	#':',-2(a1)		; root last?
	bne.s	no_root_device
	subq.l	#1,a1			; to overwrite the 0
	bra.s	root_device
no_root_device
	move.b	#'/',-1(a1)		; stick slash in
root_device
	addq.l	#1,a0			; point to text

new_dir_loop
	move.b	(a0)+,(a1)+
	tst.b	-1(a0)			; so that zero is copied as well!!
	bne.s	new_dir_loop

	bsr	Get_and_Display_Dir

	bra.s	Select_Done

File_Selected
	move.l	a0,a1
	addq.l	#1,a1			

concat_filename				
; filename in a1, will append to dirname
	move.l	a1,a2			; copy full file and path name
	move.l	#Directory,a3
	move.l	#Current_Filename,a4
	move.l	#CFile,a5

copy_dir_loop
	move.b	(a3)+,(a4)+
	tst.b	(a3)
	bne.s	copy_dir_loop

	cmp.b	#':',-1(a3)		; is it a root dir name
	beq.s	copy_file_loop
	move.b	#'/',(a4)+
copy_file_loop
	move.b	(a2),(a4)+
	move.b	(a2)+,(a5)+		; filename keepsake
	tst.b	-1(a2)			; copy 0 as well!!
	bne.s	copy_file_loop

	move.l	#File_Request_Window,a0
	move.w	#1,d0
	move.w	#97,d1
	move.w	#15,d2
	move.w	#10,d3
	bsr	Clear_Word_Chunk
	
	move.l	#File_Request_Window,a0
	move.w	#2,d2
	move.w	#16,d0
	move.w	#97,d1
	bsr	Write_Text
	
No_Filename_Selected
Select_Done
	rts

Set_Directory_DF0
	move.l	#"DF0:",Directory
	move.b	#0,Directory+4

	bsr	Get_and_Display_Dir
	rts

Set_Directory_DF1
	move.l	#"DF1:",Directory
	move.b	#0,Directory+4
	
	bsr	Get_and_Display_Dir
	rts

Set_Directory_DH0
	move.l	#"DH0:",Directory
	move.b	#0,Directory+4
	bsr	Get_and_Display_Dir

	rts

Set_Directory_DH1
	move.l	#"DH1:",Directory
	move.b	#0,Directory+4
	bsr	Get_and_Display_Dir

	rts


Set_Directory_Ram
	move.l	#"RAM:",Directory
	move.b	#0,Directory+4
	bsr	Get_and_Display_Dir

	rts
			
Parent_Dir
	move.l	#Directory,a0
search_loop
	cmp.b	#'/',(a0)		;directory slash found?
	bne.s	not_found_slash_delimiter
	move.l	a0,a1			;save last
not_found_slash_delimiter
	cmp.b	#':',(a0)		;directory slash found?
	bne.s	not_found_delimiter
	move.l	a0,a1			;save last

not_found_delimiter
	tst.b	(a0)+
	bne.s	search_loop
	cmp.b	#':',-2(a0)		; reached root ?
	beq.s	Root_Reached
	
	cmp.b	#':',(a1)		; Root next level?
	bne.s	Set_Parent
	move.b	#0,1(a1)			; leave ':' in	
	bra.s	Do_New_Dir
Set_Parent
	move.b	#0,(a1)			; just cut off from last slash
Do_New_Dir		
	bsr	Get_and_display_dir
	
Root_Reached
	rts

Clear_Word_Chunk
	ifnd	hard_only
	bsr	own_the_blitter
	endc
; Window Struct in a0
; Top Left in d0,d1      (d0 in words)
; Width Height in d2,d3  (d2 in words)
	movem.l	a1-a6,-(sp)

	move.l	screen_mem(a0),a2
	move.l	#main_screen_struct,a1

	andi.l	#$FFFF,d0
	asl.w	#1,d0
	add.l	d0,a2
	asl.w	#1,d2
	
	move.w	screen_x_size(a1),d4
	asr.w	#3,d4
	mulu.w	d4,d1
	
	add.l	d1,a2
	sub.w	d2,d4	;overall modulus
	asl.w	#6,d3
	lsr.w	#1,d2	; put back to words for blit
	or.w	d2,d3

	move.w	#2-1,d7	; only first two planes
clear_chunk
	btst	#14,DMACONR(a6)
	bne.s	clear_chunk
	move.w	#$0000,bltadat(a6)
	move.l	a2,bltdpt(a6)
	move.w	d4,bltdmod(a6)
	move.w	#$01f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	d3,bltsize(a6)

	moveq	#0,d0
	move.w	screen_x_size(a1),d0
	asr.w	#3,d0
	mulu	screen_y_size(a1),d0
	add.l	d0,a2
	dbra	d7,clear_chunk
	movem.l	(sp)+,a1-a6
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts
	
own_the_blitter
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	graphics_lib_ptr,a6
	jsr	ownblitter(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	
disown_the_blitter
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	graphics_lib_ptr,a6
	jsr	disownblitter(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
	
	
Print_Dir_Name
	move.l	#File_Request_Window,a0
	move.w	#1,d0
	move.w	#5,d1
	move.w	#15,d2
	move.w	#10,d3
	bsr	Clear_Word_Chunk
	  
	moveq	#16,d0
	moveq	#5,d1
	moveq	#1,d2		

check_length
	moveq.l	#0,d3
	move.l	#Directory,a1
trunc_loop
	tst.b	(a1)+
	beq.s	fin_trunc
	addq.l	#1,d3
	bra.s	trunc_loop
fin_trunc
	sub.l	#24,d3
	bmi.s	small_enough	
	move.l	#Directory,a1
	add.l	d3,a1
	bra.s	disp_dir
small_enough
	move.l	#Directory,a1		; directory name
disp_dir
	move.l	#File_Request_Window,a0	;
	bsr	Write_Text		; print directory
	rts
	
Load_Directory
	bsr	Print_Dir_Name
	movem.l	a6,-(sp)
	move.l	#Directory,d1
	move.l   #-2,d2			; mode read
	move.l	dosbase,a6
	jsr	-84(a6)			; examine
	tst.l	d0
	beq	CantLoadDir
	move.l	d0,lock

	move.l	lock,d1
	move.l	Info_Block,d2
	move.l	dosbase,a6
	jsr	-102(a6)			; examine
	tst.l	d0
	beq 	CantLoadDir

	move.l	#Dir_List,Current_File	; file entry pointer
	clr.w	Files_In_Dir		; reset file count
	clr.w	Top_File			; reset file display pointer
Next_File
	move.l	lock,d1
	move.l	Info_Block,d2
	move.l	dosbase,a6
	jsr	-108(a6)			; ex-next
	tst.l	d0
	beq.s	NoMoreEntries
	
Copy_Name_To_List
	move.l	Current_File,a0
	move.l	Info_Block,a1
	tst.l	4(a1)
	bmi.s	Its_a_File
	move.b	#'D',(a0)+
	bra.s	Its_a_Directory
Its_a_File
	move.b	#'F',(a0)+
Its_a_Directory

	move.l	Info_Block,a1
	add.l	#8,a1
	move.w	#24-1,d1			; Max 24 chars
copy_filename
	move.b	(a1)+,(a0)+

	dbra	d1,copy_filename
	move.b	#0,(a0)			; null terminate just
					; in case it was truncated
	add.w	#1,Files_In_Dir
	add.l	#32,Current_File				
	cmp.w	#MAX_FILES,Files_In_Dir		; max store reached ?
	bge.s	NoMoreEntries
	bra	Next_File
NoMoreEntries
	move.l	Current_File,a0
	move.b	#'E',(a0)		; end of list

	move.l	lock,d1
	move.l	dosbase,a6
	jsr	-90(a6)			; Un-lock

	bsr	Sort_File_Names
	
	movem.l	(sp)+,a6
	moveq	#-1,d0
	rts

Load_Volumes
	bsr	Print_Dir_Name
	movem.l	a6,-(sp)

	move.l	#Dir_List,Current_File	; file entry pointer
	clr.w	Files_In_Dir		; reset file count
	clr.w	Top_File			; reset file display pointer
	
	move.l	#LDF_VOLUMES,d1
	move.l	dosbase,a6
	jsr	LockDosList(a6)			
Vol_Next_File
	tst.l	d0
	beq.s	VolNoMoreEntries
	move.l	d0,a1
	move.l	d0,DosLst
	move.l	dol_name(a1),a1			; get string
Vol_Copy_Name_To_List
	move.l	Current_File,a0
	move.b	#'D',(a0)+

	move.w	#'X',(a0)
	move.w	#24-1,d0
Vol_copy_filename
	tst.b	(a1)
	beq.s	Vol_End_Name
	move.b	(a1)+,(a0)+
	dbra	d1,Vol_copy_filename
Vol_End_Name	
	move.b	#0,(a0)			; null terminate just
					; in case it was truncated
	add.w	#1,Files_In_Dir
	add.l	#32,Current_File				
	cmp.w	#MAX_FILES,Files_In_Dir		; max store reached ?
	bge.s	VolNoMoreEntries
	move.l	DosLst,d1
	move.l	#LDF_VOLUMES,d2
	move.l	dosbase,a6
	jsr	NextDosEntry(a6)		; get next entry
	bra	Vol_Next_File
VolNoMoreEntries
	move.l	Current_File,a0
	move.b	#'E',(a0)		; end of list

	bsr	Sort_File_Names
	
	movem.l	(sp)+,a6
	moveq	#-1,d0
	rts

DosLst	dc.l	0


CantLoadDir
	movem.l	(sp)+,a6
	bsr	display_error
	moveq	#0,d0
	rts

Sort_File_Names
	move.w	Files_In_Dir,d2
Bubble_Loop
	cmp.w	#1,d2
	ble.s	noboff
	
	move.w	d2,d3			; copy files to go
	subq.w	#1,d3			; sub 1 for sort-1 for dbra
	move.l	#Dir_List,a0		; start of list
bub_bit
	move.l	a0,a1
	add.l	#32,a1			; next file
	bsr	sort_couple		
	move.l	a1,a0			; a0 points to next entry
	subq.w	#1,d3
	bgt.s	bub_bit				
	
	subq.w	#1,d2
	bgt.s	bubble_loop
noboff
	rts
	
Sort_Couple
* name1 in a0, name2 in a1, it will compare strings.
	movem.l	d0-d3/a0-a3,-(sp)

	move.l	a0,a2
	move.l	a1,a3
	moveq.l	#0,d3			; d3 is equal flag
name_comp_loop
	move.b	(a0)+,d0
	move.b	(a1)+,d1
	or.b	#$20,d0	
	or.b	#$20,d1
	cmp.b	d0,d1
	blt.s	swap_em_over				
	bgt.s	fin_sort_names
	moveq.l	#-1,d3	
equaloknames		
	tst.b	(a1)
	beq.s	end_of_name_2
	tst.b	(a0)
	beq.s	fin_sort_names
	bra.s	name_comp_loop
end_of_name_2
	cmp.l	#-1,d3
	bne.s	fin_sort_names
			
swap_em_over
	move.l	a2,a0
	move.l	a3,a1
	bsr	Swap_Names
fin_sort_names	
	movem.l	(sp)+,d0-d3/a0-a3
	rts

Swap_Names
* name1 in a0, name2 in a1, it will swap 32 chars.
	movem.l	d0-d1,-(sp)
	move.w	#32-1,d0
name_swap_loop
	move.b	(a0),d1
	move.b	(a1),(a0)+
	move.b	d1,(a1)+
	dbra	d0,name_swap_loop
	movem.l (sp)+,d0-d1
	rts
	

Display_Directory

	move.l	#File_Request_Window,a0
	move.w	#1,d0
	move.w	#21,d1
	move.w	#10,d2
	move.w	#70,d3
	bsr	Clear_Word_Chunk
	
	move.l	#Dir_List,a0
	move.w	Top_File,d0
	mulu.w	#32,d0
	add.l	d0,a0
	move.l	a0,Current_File

	moveq	#21,d1
	moveq	#2,d2
	moveq	#6,d4			;  num of files to display
print_loop
	move.l	Current_File,a2
	cmp.b	#'E',(a2)
	beq.s	files_printed
	
	move.w	#16,d0

	move.l	#16,name_length
	cmp.b	#'D',(a2)
	bne.s	no_dir
	move.l	#16-6,name_length	; 6 chars for "(Dir) "
	move.l	#Dir_Tag,a1
	move.w	#3,d2
	move.l	#File_Request_Window,a0	;
	bsr	Write_Text		; Write '(Dir)' Tag
	add.w	#60,d0			; get co-ords right
	move.w	#2,d2
no_dir
	
	addq.l	#1,a2
	move.l	a2,a1
        add.l	name_length,a2
        move.b	(a2),nob_char
        clr.b	(a2)       
	move.l	#File_Request_Window,a0	;-
	bsr	Write_Text		; print filename

	move.b	nob_char,(a2)
			
	add.l	#32,Current_File
	add.w	#10,d1

	dbra	d4,print_loop

files_printed
	rts

nob_char
	dc.w	0
name_length	dc.l	16
Scroll_Files_Up
	move.w	Top_File,d0
	add.w	#7,d0
	cmp.w   Files_In_Dir,d0
	bge.s	CantScrollFiles
	add.w	#1,Top_File
	bsr	Display_Directory
CantScrollFiles
	rts

Scroll_Files_Down
	tst.w	Top_File
	ble.s	CantScrollFilesD
	sub.w	#1,Top_File
	bsr	Display_Directory
CantScrollFilesD
	rts


display_file_request
	
	move.l	#$dff000,a6
	bsr	set_original_colours
	move.l	#File_Request_Window,a0
	bsr	Create_Window
	move.l	#File_Request_Buttons,a0
	bsr	Display_Button_List
	bsr	Force_Buttons
	
	move.l	#File_Request_Window,a0
	move.w	#11,d0
	move.w	#3,d1
	move.w	#339-80,d2
	move.w	#15,d3
	bsr	Draw_Box

	move.l	#File_Request_Window,a0
	move.w	#11,d0
	move.w	#19,d1
	move.w	#257-80,d2
	move.w	#91,d3
	bsr	Draw_Box

	move.l	#File_Request_Window,a0
	move.w	#11,d0
	move.w	#95,d1
	move.w	#339-80,d2
	move.w	#107,d3
	bsr	Draw_Box
	
	tst.b	Directory		; directory not set ?
	beq.s	No_Dir_Yet
	clr.w	Top_File
	bsr	Print_Dir_Name
	bsr	Display_Directory
No_Dir_Yet
	rts

Remove_File_Request
	ifd	hard_only
	move.l	4,a6
	jsr	forbid(a6)
	endc
	move.l	#$dff000,a6
	
	move.l	#File_Request_Buttons,a0
	bsr	Remove_Button_List
	move.l	#File_Request_Window,a0
	bsr	Destroy_Window      
	bsr	set_current_page_colours  
	rts
	
draw_box
	move.l	a0,Box_BMAP
	move.w	d0,Box_TLx
	move.w	d1,Box_TLy
	move.w	d2,Box_BRx
	move.w	d3,Box_BRy
	
	move.w	Box_TLx,d0
	move.w	Box_TLy,d1
	move.w	Box_BRx,d2
	move.w	Box_TLy,d3	
	bsr	Draw_Line

	move.l	Box_BMAP,a0	
	move.w	Box_BRx,d0
	move.w	Box_TLy,d1
	move.w	Box_BRx,d2
	move.w	Box_BRy,d3	
	bsr	Draw_Line

	move.l	Box_BMAP,a0	
	move.w	Box_BRx,d0
	move.w	Box_BRy,d1
	move.w	Box_TLx,d2
	move.w	Box_BRy,d3	
	bsr	Draw_Line
	
	move.l	Box_BMAP,a0	
	move.w	Box_TLx,d0
	move.w	Box_BRy,d1
	move.w	Box_TLx,d2
	move.w	Box_TLy,d3	
	bsr	Draw_Line

	rts

Box_BMAP	dc.l	0	
Box_TLx	dc.w	0
Box_TLy	dc.w	0
Box_BRx	dc.w	0
Box_BRy	dc.w	0



