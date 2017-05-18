
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


LockDosList	EQU	-$28e
NextDosEntry	EQU	-$2b2

delay		equ	-168

MAX_FILES	EQU	79*2

open_dos	move.l	4.w,a6			;open dos lib
		lea	DosLib(pc),a1
		jsr	-408(A6)
		move.l	d0,DosBase
		move.l	Info_Block,d0
		andi.l	#$fffffffc,d0
		move.l	d0,Info_Block
		rts

close_dos	move.l	4.w,a6
		move.l	dosbase(pc),a1
		jmp	-414(a6)			;close dos

MEM_FIX		EQU	1234567
		rsreset
FH_Filename	rs.l	1	; pointer to null terminated filename
FH_Memory_Type	rs.l	1	; ie MEM_CHIP,FAST,CLEAR etc. or MEM_FIX for fixed addresses
FH_Memory	rs.l	1	; pointer to memory used by that file
FH_Length	rs.l	1	; Length (in bytes) on the file.		
		rsreset

Current_Filename
		ds.b	108+108	; just in case of maximum
		even
CRLF		dc.b	10,13,0	
		even	
File_Routine_Pointer	dc.l	0 ; *SET BY EACH ROUTINE THAT USES IT
Current_File	dc.l	0
lock		dc.l	0
dosbase		dc.l	0
doslib		dc.b	"dos.library",0
		even
Info_Block	dc.l	Info_Structure
		ds.b	4
Info_Structure	ds.b	260
		even	
	
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

char_position	dc.w	0

get_pressed_key	jmp	Read_Keyboard

;/* Clear_Word_Chunk
  * ----------------
  * $Inputs:	a0.l = Window Structure
  *		d0.w = Top (in words)
  *		d1.w = Left
  *		d2.w = Width (in words)
  *		d3.w = Height
  */
  
Clear_Word_Chunk
	ifnd	hard_only
	bsr	own_the_blitter
	endc
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
	
path.txt:	dc.b	'scratch:',0
		cnop	0,4
display_file_request:
		movem.l	d1-d7/a0-a6,-(sp)
		bsr	switch_screens
		lea	path.txt,a0			;save default path...
		move.l	a0,a1
		lea	current_filename,a2		;filename buffer
		bsr	reqon
		movem.l	(sp)+,d1-d7/a0-a6
		tst.l	d0
		beq.s	no_call
		move.l	File_Routine_Pointer,d0
		beq.s	no_call	
		move.l	a0,-(sp)
		move.l	d0,a0
		jsr	(a0)
		move.l	(sp)+,a0
		tst.l	d0
		rts
no_call:	bsr	Remove_File_Request
		tst.l	d0
		rts

Remove_File_Request
		movem.l	d0-a6,-(sp)
		bsr	DeAllocReqMem
		bsr	CloseReqTools
		bsr	switch_screens
		movem.l	(sp)+,d0-a6
		rts

		cnop	0,4
reqon:		move.l	a2,a5
		lea	path(pc),a3
		move.l	a0,(a3)			;default path...
		move.l	a1,TitlePtr-path(a3)
		bsr	OpenReqTools
		bsr	AllocReqMem

		lea	Wild_Tags(pc),a0	;standard file req
		lea	Blk_Tags(pc),a1		;we want block attr`s
		move.l	TitlePtr(pc),a3		;requester msg
		bsr	_RequestFile
		tst.l	d0
		rts

		cnop	0,4
OpenReqTools:	lea	RTName(pc),a1
		move.l	4.w,a6
		jsr	-408(a6)
		lea	_ReqToolsBase(pc),a0
		move.l	d0,(a0)
		rts

		cnop	0,4
CloseReqTools:	move.l	4.w,a6
		move.l	_ReqToolsBase(pc),d0
		beq.s	RTNotOpen
		move.l	d0,a1
		jsr	-414(a6)
		lea	_ReqToolsBase(pc),a0
		clr.l	(a0)
RTNotOpen	rts

*-------------- Allocate File-Requester structure memory..

RTFI_Dirs		= $80000032
RTFI_Flags		= $80000028
TAG_DONE		= 0

rtfi_Dir		= $10
RT_FILEREQ		= $0

	ifd	TREV	
RT_FLAGS		= $A
	endc

FREQF_PATGAD		= $1

_LVOrtAllocRequestA	= $FFFFFFE2
_LVOrtFreeRequest	= $FFFFFFDC
_LVOrtFileRequestA	= $FFFFFFCA
_LVOrtChangeReqAttrA	= $FFFFFFD0

		cnop	0,4
AllocReqMem	move.l	#RT_FILEREQ,d0
		suba.l	a0,a0
		move.l	_ReqToolsBase(pc),a6
		jsr	_LVOrtAllocRequestA(a6)
		lea	RTReqPtr(pc),a0
		move.l	d0,(a0)
		rts

		cnop	0,4
DeAllocReqMem:	move.l	RTReqPtr(pc),d0
		beq.s	AllocNot
		move.l	d0,a1
		move.l	_ReqToolsBase(pc),d1
		beq.s	AllocNot
		move.l	d1,a6
		jsr	_LVOrtFreeRequest(a6)
		lea	RTReqPtr(pc),a0
		clr.l	(a0)
AllocNot	rts
		
* $Inputs:	a0.l = wildcards, etc . tags
*		a1.l = individual attribute tags
*		a2.l = body of requester..
*		a3.l = title
*
* $Outputs:	d0.l = d0 (result-code)

		cnop	0,4
_RequestFile:	lea	TempName(pc),a2
		sf.b	(a2)
		bsr	Do_FileRequest
		tst.l	d0
		beq.s	no_name
			
		move.l	RTReqPtr(pc),a1			;& a path name!
		move.l	rtfi_Dir(a1),a0
		move.l	a5,a1
bytecopy:	move.b	(a0)+,(a1)+
		bne.s	bytecopy
		cmp.b	#":",-2(a1)
		bne.s	add_slash
		tst.b	-(a1)
		bra.s	no_slash
		
add_slash:	tst.b	-(a1)
		move.b	#"/",(a1)+
no_slash:	move.l	a2,a0
bytecopy2:	move.b	(a0)+,(a1)+
		bne.s	bytecopy2
		clr.b	(a1)+

		move.l	a5,a0
		moveq	#1,d0			;return success on name..
no_name:	tst.l	d0
		rts

		cnop	0,4
Do_FileRequest	movem.l	d1-d7/a0-a6,-(sp)
		move.l	a1,a0
		move.l	RTReqPtr(pc),a1			;& a path name!
		move.l	_ReqToolsBase(pc),a6
		jsr	_LVOrtChangeReqAttrA(a6)
		move.l	RTReqPtr(pc),a1
		jsr	_LVOrtFileRequestA(a6)
		movem.l	(sp)+,d1-d7/a0-a6
		rts

		cnop	0,4
RTName:		dc.b	'reqtools.library',0
		even

Wild_Tags:	dc.l	RTFI_Flags,FREQF_PATGAD
		dc.l	TAG_DONE

Blk_Tags:	dc.l	RTFI_Dirs
path		dc.l	0
		dc.l	TAG_DONE

_ReqToolsBase:	ds.l	1
RTReqPtr:	ds.l	1
TitlePtr:	ds.l	1
LoadPtr:	ds.l	1
TempName:	ds.b	256
		even
