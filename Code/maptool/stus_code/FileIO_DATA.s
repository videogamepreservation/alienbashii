MEM_FIX	EQU	1234567
	rsreset

FH_Filename	rs.l	1	; pointer to null terminated filename
FH_Memory_Type	rs.l	1	; ie MEM_CHIP,FAST,CLEAR etc. or MEM_FIX for fixed addresses
FH_Memory	rs.l	1	; pointer to memory used by that file
FH_Length	rs.l	1	; Length (in bytes) on the file.		

CRLF	dc.b	10,13,0	
	even	

dosbase	dc.l	0
doslib	dc.b	"dos.library",0
	even
Info_Block	dc.l	Info_Structure
		ds.b	4
Info_Structure	ds.b	260
	even	
Directory	dc.b	0	; 0 would be current directory
		ds.b	108	; for when directory is extended
	even

CFile	ds.b	25		
	even
Current_Filename	ds.b	108+108	; just in case of maximum
	even
Protection	dc.b	0,0,0,0,0
	even
Dir_Tag	
	dc.b "(dir)",0
	even 

lock	dc.l	0
Files_In_Dir	dc.w	0
Top_File	dc.w	0

Current_File	dc.l	0
Dir_List	ds.b	(26*300)*2		; 50 filenames, ID + 24 chars + 0
	even

File_Request_Window
	dc.w	304
	dc.w	151
	dc.w	0
	dc.w	20
	dc.l	0
	dc.l	0
	dc.b	"FILE REQUEST",0
	even		

File_Request_Buttons
	dc.l	File_Ok_Button,File_Cancel_Button
	dc.l	File_Up_Button,File_Down_Button,DF0_Button,DH1_Button,DH0_Button,Ram_Button
	dc.l	Parent_Button,FileName0,FileName1,FileName2
	dc.l	FileName3,FileName4,FileName5,FileName6
	dc.l	EnterFileNameButton,-1

File_Ok_Button
	dc.w	11
	dc.w	115
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
File_Routine_Pointer	dc.l	0 ; *SET BY EACH ROUTINE THAT USES IT
	dc.b	0		
	even

Parent_Button
	dc.w	151-64
	dc.w	115
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	parent_custom_button
	dc.l	0	;not used
	dc.l	Parent_Dir
	dc.b	0		
	EVEN						

File_Cancel_Button
	dc.w	185
	dc.w	115
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
	dc.l	Remove_File_Request
	dc.b	0		
	even

File_Up_Button
	dc.w	294-80
	dc.w	20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	Scroll_Files_Down
	dc.b	0		
	EVEN						

DF0_Button
	dc.w	274-80
	dc.w	33
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	DF0_custom_button
	dc.l	0	;not used
	dc.l	Set_Directory_DF0
	dc.b	0		
	even

	


DF1_Button
	dc.w	274-80+6+26
	dc.w	33
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	DF1_custom_button
	dc.l	0	;not used
	dc.l	Set_Directory_DF1
	dc.b	0		
	even


Dh0_Button
	dc.w	274-80
	dc.w	48
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	dh0_custom_button
	dc.l	0	;not used
	dc.l	Set_Directory_Dh0
	dc.b	0		
	even


Dh1_Button
	dc.w	274-80+6+26
	dc.w	48
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	Dh1_custom_button
	dc.l	0	;not used
	dc.l	Set_Directory_Dh1
	dc.b	0		
	even






ram_Button
	dc.w	274-80
	dc.w	63
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ram_custom_button
	dc.l	0	;not used
	dc.l	Set_Directory_ram
	dc.b	0		
	even


File_Down_Button
	dc.w	294-80
	dc.w	80
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	Scroll_Files_Up
	dc.b	0		
	even

FileName0
	dc.w	15
	dc.w	20
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						

FileName1
	dc.w	15
	dc.w	30
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						

FileName2
	dc.w	15
	dc.w	40
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						

FileName3
	dc.w	15
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						
FileName4
	dc.w	15
	dc.w	60
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						
FileName5
	dc.w	15
	dc.w	70
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						

FileName6
	dc.w	15
	dc.w	80
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	6
	dc.b	0	;not used
	dc.l	FileButton ;not used
	dc.l	0	;not used
	dc.l	Select_Filename
	dc.b	0		
	EVEN						

EnterFileNameButton
	dc.w	15
	dc.w	97
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	EnterFileButton ;not used
	dc.l	0	;not used
	dc.l	Enter_Filename
	dc.b	0		
	EVEN						


