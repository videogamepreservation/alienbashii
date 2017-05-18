
*------------------------------------------------------------------------->
*
*	IFF to RAW - V0.1
*
*	This is an IFF to RAW converter for AGA pictures. It will save
*	the raw binary image and copperlist to (hard)disk.
*
*	In this version the following features are available :
*
*	- decrunch and write pictures. ( logical :)
*	  (I2R can only convert IFF to plane RAW (yet))
*	- make a copperlist for use in your code.
*
*	In future versions the following should be included :
*
*	- display of the picture :)
*	- interleaved raw
*	- grabbing a part of an image
*	- sprite grabbing
*	- full support for all machines
*	- full support for all graphics modes
*	- ASCII copperlist for inclusion in source
*	- ability to make copperlists for OCS, ECS and AGA (and AAA ? :)
*	- a nice user interface
*
*	Comments :
*
*	This source is an example of legal and good coding...NOT!
*	No includes are used and some things might not be legal but who
*	cares ? Not me... (Keep children away, and take health precautions :)
*
*	I2R is © 1993 by Michel Vissers. The source and executable can be
*	distrubuted freely as long as NO money is asked for, except for
*	media and post (max. $2.00) and the executable is not modified in
*	any way. Parts of the source may be used in your own program but
*	I am not, and can not be held responsible, for any (brain)damage
*	whatsoever caused by the use of this source... (Mega sync twist,
*	blown up mind, Alice got aids, runaway disk... >;^) Please do not
*	make any changes to this source yourself... leave that part to me !
*
*	If you've got some spare dimes, nickels or whatever, send them !
*	Also bugreports, letters, ideas, flames, goodlooking sisters
*	(about 20 years) and Amiga's are welcome...
*
*			        Michel Vissers
*			     Hobbendonkseweg  100
*				5283 HL Boxtel
*				   Holland.
*
*	Or : S91406013@HSEPM1.HSE.NL  -  MICHEL@AMIGA.HSE.NL
*
*	See I2R.doc for full documentation...
*
*------------------------------------------------------------------------->
*	$VER: IFF2RAW.asm v0.1 (23/3/93) © 1991 Michel Vissers
*------------------------------------------------------------------------->

*------------------------------------------------------------------------->
*
*	Definitions
*
*------------------------------------------------------------------------->

_LVOfindtask		=	-294
_LVOgetmsg		=	-372
_LVOreplymsg		=	-378
_LVOwaitport		=	-384
_LVOforbid		=	-132
_LVOpermit		=	-138
_LVOallocmem		=	-198	; Exec
_LVOfreemem		=	-210
_LVOcloselibrary	=	-414
_LVOopenlibrary		=	-552

_LVOopen		=	-30	; Dos
_LVOclose		=	-36
_LVOread		=	-42
_LVOwrite		=	-48
_LVOdeletefile		=	-72
_LVOlock		=	-84
_LVOunlock		=	-90
_LVOexamine		=	-102
_LVOdelay		=	-198

CALL	MACRO
	jsr	_LVO\1(a6)	; Just lazyness :)
	ENDM

*------------------------------------------------------------------------->
*
*	Initialization (Did I wrote this word correct ?)
*
*------------------------------------------------------------------------->

	section IFF2RAW,code

RUN
	movem.l	d0/a0,-(a7)
	clr.l	RETURNMSG
	sub.l	a1,a1
	move.l	$4.w,a6
	CALL	findtask
	move.l	d0,a4
	tst.l	$ac(a4)
	beq.b	.WBSTARTUP
	movem.l	(a7)+,d0/a0
	bra.b	.ENDSTARTUP
.WBSTARTUP
	lea	$5c(a4),a0
	move.l	$4.w,a6
	CALL	waitport
	lea	$5c(a4),a0
	CALL	getmsg
	move.l	d0,RETURNMSG
	movem.l	(a7)+,d0/a0
.ENDSTARTUP
	bsr.b	_MAIN
	move.l	d0,-(a7)
	tst.l	RETURNMSG
	beq.b	EXIT
	move.l	$4.w,a6
	CALL	forbid
	move.l	RETURNMSG,a1
	CALL	replymsg
	CALL	permit
EXIT
	move.l	(a7)+,d0
	rts

RETURNMSG	dc.l	0

_MAIN
	movem.l	d0-a6,-(a7)

	move.l	$4.w,a6
	lea	DOSNAME,a1
	moveq	#0,d0
	CALL	openlibrary		; Open dos.library
	tst.l	d0
	beq.w	NOLIB
	move.l	d0,DOSBASE

	move.l	#WINDOWNAME,d1
	move.l	#1005,d2	
	move.l	DOSBASE,a6
	CALL	open			; Open CON window
	tst.l	d0
	beq.w	NOWIN
	move.l	d0,WINDOWHANDLE

	bsr.w	BEGIN			; Intro.
LOADER
	move.l	#0,ERR
	bsr.w	LOADFILE		; Load file routine.
	cmp.l	#-1,ERR
	beq.w	LOAD_FILEERR
	cmp.l	#-2,ERR
	beq.w	LOAD_MEMERR
DECRUNCHER
	move.l	#0,ERR
	bsr.w	DECRUNCH		; Decrunch routine.
	cmp.l	#-1,ERR
	beq.w	DECR_IFFERR
	cmp.l	#-2,ERR
	beq.b	CLOSEALL

	bsr.w	WRITEFILE

CLOSEALL
	cmp.l	#1,LOADRESERVED
	bne.b	CLOSEALL1
	move.l	FILEMEMORY,a1
	move.l	FILELENGTH,d0
	move.l	$4.w,a6
	CALL	freemem
CLOSEALL1
	cmp.l	#1,DECRRESERVED
	bne.b	CLOSEALL2
	move.l	RAWMEMORY,a1
	move.l	SIZERAWMEMORY,d0
	move.l	$4.w,a6
	CALL	freemem
CLOSEALL2
	move.l	WINDOWHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close
NOWIN
	move.l	DOSBASE,a1
	CALL	closelibrary
NOLIB
	movem.l	(a7)+,d0-a6
	moveq	#0,d0
	rts

*- Loader Errors --------------------------------------------------------->

LOAD_FILEERR
	move.l	#fileerrortext,d2
	bsr.w	WRITETEXT
	move.l	#50*2,d1
	move.l	DOSBASE,a6
	CALL	delay			; Wait 2 seconds

	cmp.l	#1,LOADRESERVED
	bne.w	LOADER
	move.l	FILEMEMORY,a1
	move.l	FILELENGTH,d0
	move.l	$4.w,a6
	CALL	freemem

	bra.w	LOADER

LOAD_MEMERR
	move.l	#memoryerrortext,d2
	bsr.w	WRITETEXT
	move.l	#50*2,d1
	move.l	DOSBASE,a6
	CALL	delay			; Wait 2 seconds
	bra.b	CLOSEALL2

*- Decruncher Errors ----------------------------------------------------->

DECR_IFFERR
	cmp.l	#1,LOADRESERVED
	bne.w	LOADER
	move.l	FILEMEMORY,a1
	move.l	FILELENGTH,d0
	move.l	$4.w,a6
	CALL	freemem

	bra.w	LOADER

*------------------------------------------------------------------------->
*
*	Actual program
*
*------------------------------------------------------------------------->

BEGIN
	move.l	#introtext,d2		; Show name and copyright.
	bsr.w	WRITETEXT
	rts

*------------------------------------------------------------------------->

LOADFILE
	lea	INPUTBUFFER,a0
	bsr.w	CLEARBLOCK		; Clear INPUTNAME.
	lea	LOADNAME,a0
	bsr.w	CLEARBLOCK		; Clear LOADNAME.

	move.l	#loadfiletext,d2	; Ask for IFF filename to load.
	bsr.w	WRITETEXT
	move.l	#512,d3
	bsr.w	READTEXT

	lea	INPUTBUFFER,a0
	lea	LOADNAME,a1	
	bsr.w	COPYBLOCK		; Copy INPUTBUFFER to LOADNAME.

	move.b	LOADNAME,d0
	beq.b	LOADFILE

	move.l	#LOADNAME,d1
	move.l	#-2,d2
	move.l	DOSBASE,a6
	CALL	lock			; Get a lock on file.
	tst.l	d0
	beq.w	.LOCKERR
	move.l	d0,LOADLOCK

	move.l	d0,d1
	move.l	#EXAMINEBUFFER,d2
	move.l	DOSBASE,a6
	CALL	examine			; Examine file.
	tst.l	d0
	beq.w	.EXAMERR

	move.l	#0,LOADRESERVED
	lea	EXAMINEBUFFER,a4
	move.l	122(a4),d0		; Length of (IFF) file.
	move.l	d0,FILELENGTH
	move.l	#$10000,d1		; Clear mem. Type not important.
	move.l	$4.w,a6
	CALL	allocmem
	tst.l	d0
	beq.b	.MEMERR
	move.l	#1,LOADRESERVED
	move.l	d0,FILEMEMORY

	move.l	#LOADNAME,d1
	move.l	#1005,d2
	move.l	DOSBASE,a6
	CALL	open			; Open file.
	tst.l	d0
	beq.b	.OPENERR
	move.l	d0,READHANDLE
	
	move.l	d0,d1
	move.l	FILEMEMORY,d2
	move.l	FILELENGTH,d3
	move.l	DOSBASE,a6
	CALL	read			; Read file.
	tst.l	d0
	bmi.b	.READERR
	
	move.l	READHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.

	move.l	LOADLOCK,d1
	move.l	DOSBASE,a6
	CALL	unlock			; Unlock file.

	move.l	#0,ERR			; Succesfull load.
	rts

.MEMERR
	move.l	#-2,ERR
	bra.b	.lr
.READERR
	move.l	#-1,ERR
	move.l	READHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.
.OPENERR
	move.l	#-1,ERR
	move.l	FILELENGTH,d0
	move.l	FILEMEMORY,a1
	move.l	$4.w,a6
	CALL	freemem			; Free reserved mem.
.EXAMERR
	move.l	#-1,ERR
.lr	move.l	LOADLOCK,d1
	move.l	DOSBASE,a6
	CALL	unlock			; Unlock file.
	rts
.LOCKERR
	move.l	#-1,ERR
	rts

*------------------------------------------------------------------------->

DECRUNCH
	move.l	FILEMEMORY,a0		; First check if it's a IFF file.
	move.l	(a0),d0
	cmp.l	#'FORM',d0
	bne.b	.NOIFF
	lea	8(a0),a0
	move.l	(a0),d0
	cmp.l	#'ILBM',d0		; Then check if it's a graphics file.
	bne.b	.NOILBM
	bra.b	DECRUNCH2
.NOIFF
	move.l	#noifftext,d2		; Not an IFF file error.
	bsr.w	WRITETEXT
	move.l	#50*2,d1
	move.l	DOSBASE,a6
	CALL	delay			; Wait 2 seconds.
	move.l	#-1,ERR
	rts

.NOILBM
	move.l	#noilbmtext,d2		; Not an ILBM file error.
	bsr.w	WRITETEXT
	move.l	#50*2,d1
	move.l	DOSBASE,a6
	CALL	delay			; Wait 2 seconds.
	move.l	#-1,ERR
	rts

DECRUNCH2
	move.l	#0,DECRRESERVED
	move.l	FILEMEMORY,a0		; Actual decrunching...
	bsr.w	IFF_SIZE		; Get IFFpic size.
	move.w	d0,IFFPLANES
	move.w	d1,IFFWIDTH
	move.w	d2,IFFHEIGH
	mulu	d1,d2			; Calculate size of 1 plane.
	moveq	#0,d1
	subq.w	#1,d0
.loop1	add.l	d2,d1			; Calculate total RAW size.
	dbra	d0,.loop1
	move.l	d1,d0
	move.l	d0,SIZERAWMEMORY
	move.l	#$10000,d1		; Type not important. Clear mem.
	move.l	$4.w,a6
	CALL	allocmem
	tst.l	d0
	beq.b	.NORAWMEM
	move.l	d0,RAWMEMORY
	move.l	#1,DECRRESERVED

	bsr.w	PRINTINFO

	move.w	IFFWIDTH,d0		; Create a bitplane pointer table
	move.w	IFFHEIGH,d1		; for the decruncher.
	mulu	d0,d1
	move.l	RAWMEMORY,d2
	move.w	IFFPLANES,d3
	subq.w	#1,d3
	lea	BPLTABLE,a1
.loop2	move.l	d2,(a1)+
	add.l	d1,d2
	dbra	d3,.loop2

	move.l	FILEMEMORY,a0
	move.l	#BPLTABLE,a1
	lea	COLOURMEMORY,a2
	move.l	a2,a6
	add.l	#[256*2],a6
	moveq	#2,d0
	bsr.w	IFF_DEPACK		; Depack picture...
	bra.b	MAKECOPPER

.NORAWMEM
	move.l	#memoryerrortext,d2
	bsr.w	WRITETEXT
	move.l	#50*2,d1
	move.l	DOSBASE,a6
	CALL	delay			; Wait 2 seconds.
	move.l	#-2,ERR
	rts

MAKECOPPER
	lea	COLOURMEMORY,a0		; Create the copperlist for the
	lea	COPCOLOUR1,a1		; colours. (High-4-bits)
	moveq	#7,d0
.LOOP1
	moveq	#31,d1
	move.w	#$0180,d3
	add.l	#4,a1
.LOOP2
	move.w	d3,(a1)+
	move.w	(a0)+,(a1)+
	add.w	#2,d3
	dbra	d1,.LOOP2

	dbra	d0,.LOOP1
MAKECOPPER2
	lea	COLOURMEMORY,a0		; Create the copperlist for the
	add.l	#[256*2],a0		; colours. (Low-4-bits)
	lea	COPCOLOUR2,a1
	moveq	#7,d0

.LOOP1
	moveq	#31,d1
	move.w	#$0180,d3
	add.l	#4,a1
.LOOP2
	move.w	d3,(a1)+
	move.w	(a0)+,(a1)+
	add.w	#2,d3
	dbra	d1,.LOOP2

	dbra	d0,.LOOP1
	rts

*------------------------------------------------------------------------->

WRITEFILE
	lea	INPUTBUFFER,a0
	bsr.w	CLEARBLOCK		; Clear INPUTBUFFER.
	lea	SAVENAME,a0
	bsr.w	CLEARBLOCK		; Clear SAVENAME.

	move.l	#savefiletext,d2	; Ask for filename to save.
	bsr.w	WRITETEXT
	move.l	#512,d3
	bsr.w	READTEXT

	lea	INPUTBUFFER,a0
	lea	SAVENAME,a1	
	bsr.w	COPYBLOCK		; Copy INPUTBUFFER to SAVENAME

	move.b	SAVENAME,d0
	beq.b	WRITEFILE

	move.l	#SAVENAME,d1
	move.l	#-2,d2
	move.l	DOSBASE,a6
	CALL	lock			; Get a lock on file.
	tst.l	d0
	beq.b	WRITEFILE2		; If it doesn't exist, write data.

	move.l	d0,d1
	move.l	DOSBASE,a6		; Error ! File allready exists.
	CALL	unlock

	lea	INPUTBUFFER,a0
	bsr.w	CLEARBLOCK		; Clear INPUTBUFFER.
	move.l	#fileexiststext,d2
	bsr.w	WRITETEXT
	move.l	#80,d3			; Just for the lunatics who like to
	bsr.w	READTEXT		; write whole sentences. :)
	lea	INPUTBUFFER,a0
	move.b	(a0),d0
	cmp.b	#'Y',d0
	beq.b	.DEL2
	cmp.b	#'y',d0
	beq.b	.DEL2
	bra.w	WRITEFILE
.DEL2	
	move.l	#SAVENAME,d1		; Delete old file.
	move.l	DOSBASE,a6
	CALL	deletefile

WRITEFILE2
	move.l	#SAVENAME,d1		; First write the binary image.
	move.l	#1006,d2
	move.l	DOSBASE,a6
	CALL	open			; Open file.
	tst.l	d0
	beq.b	.OPENERR
	move.l	d0,WRITEHANDLE
	
	move.l	d0,d1
	move.l	RAWMEMORY,d2
	move.l	SIZERAWMEMORY,d3
	move.l	DOSBASE,a6
	CALL	write			; Read file.
	tst.l	d0
	bmi.b	.WRITEERR
	
	move.l	WRITEHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.

	bra.b	WRITEFILE3

.OPENERR
	move.l	#wfileerrtext,d2
	bsr.w	WRITETEXT
	bra.w	WRITEFILE
.WRITEERR
	move.l	WRITEHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.
	move.l	#wfileerrtext,d2
	bsr.w	WRITETEXT
	bra.w	WRITEFILE

WRITEFILE3
	lea	SAVENAME-1,a0		; Write the copperlist.
.LOOP	add.l	#1,a0
	move.b	(a0),d0
	bne.b	.LOOP
	move.b	#'.',(a0)+		; Add the extension '.cop'.
	move.b	#'c',(a0)+
	move.b	#'o',(a0)+
	move.b	#'p',(a0)+
	move.b	#0,(a0)+		; Just to be sure of the ending zero.

	move.l	#SAVENAME,d1
	move.l	#-2,d2
	move.l	DOSBASE,a6
	CALL	lock			; Get a lock on file.
	tst.l	d0
	beq.b	WRITEFILE4		; If it doesn't exist, write data.

	move.l	d0,d1
	move.l	DOSBASE,a6		; Error ! File allready exists.
	CALL	unlock

	lea	INPUTBUFFER,a0
	bsr.w	CLEARBLOCK		; Clear INPUTBUFFER.
	move.l	#copfileextext,d2
	bsr.w	WRITETEXT
	move.l	#80,d3			; Just for the lunatics who like to
	bsr.w	READTEXT		; write whole sentences. :)
	lea	INPUTBUFFER,a0
	move.b	(a0),d0
	cmp.b	#'Y',d0
	beq.b	.DEL3
	cmp.b	#'y',d0
	beq.b	.DEL3
	bra.w	WRITEFILE
.DEL3
	move.l	#SAVENAME,d1		; Delete old file.
	move.l	DOSBASE,a6
	CALL	deletefile

WRITEFILE4
	move.l	#SAVENAME,d1
	move.l	#1006,d2
	move.l	DOSBASE,a6
	CALL	open			; Open file.
	tst.l	d0
	beq.b	.OPENERR
	move.l	d0,WRITEHANDLE
	
	move.l	d0,d1
	move.l	#COPCOLOUR1,d2
	move.l	#[ENDOFCOPPER-COPCOLOUR1],d3
	move.l	DOSBASE,a6
	CALL	write			; Read file.
	tst.l	d0
	bmi.b	.WRITEERR
	
	move.l	WRITEHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.

	rts

.OPENERR
	move.l	#wfileerrcoptext,d2
	bsr.w	WRITETEXT
	bra.w	WRITEFILE
.WRITEERR
	move.l	WRITEHANDLE,d1
	move.l	DOSBASE,a6
	CALL	close			; Close file.
	move.l	#wfileerrcoptext,d2
	bsr.w	WRITETEXT
	bra.w	WRITEFILE

*------------------------------------------------------------------------->

PRINTINFO
	lea	infotext1+10,a2		; Print nr of planes.
	move.w	IFFPLANES,d2
	ext.l	d2
	bsr	CONVERT
	lea	infotext2+10,a2		; Print nr of width in bytes.
	move.w	IFFWIDTH,d2
	ext.l	d2
	bsr	CONVERT
	lea	infotext3+10,a2		; Print nr of lines.
	move.w	IFFHEIGH,d2
	ext.l	d2
	bsr	CONVERT
	move.l	#infotext1,d2
	bsr	WRITETEXT
	move.l	#infotext2,d2
	bsr	WRITETEXT
	move.l	#infotext3,d2
	bsr	WRITETEXT
	rts
	
*------------------------------------------------------------------------->

CONVERT
	moveq	#0,d3
	tst.l	d2
	bpl	.POSITIVE
	neg.l	d2
	moveq	#1,d3
.POSITIVE
	moveq	#7,d0
	lea	1(a2),a0
	lea	DECPARTS,a1
.NEXT
	moveq	#'0',d1
.DEC	
	addq	#1,d1
	sub.l	(a1),d2
	bcc	.DEC
	subq	#1,d1
	add.l	(a1),d2
	move.b	d1,(a0)+
	lea	4(a1),a1
	dbra	d0,.NEXT
	move.l	a2,a0
.REP	
	move.b	#' ',(a0)+
	cmp.b	#'0',(a0)
	beq	.REP
	tst.b	d3
	beq	.DONE
	move.b	#'-',-1(a0)
.DONE
	rts

COPYBLOCK
	move.l	INPUTLENGTH,d0
.loop	move.b	(a0,d0.w),(a1,d0.w)
	dbra	d0,.loop
	rts

CLEARBLOCK
	move.w	#512-1,d0
.loop	move.b	#0,(a0)+
	dbra	d0,.loop
	rts

READTEXT
	move.l	WINDOWHANDLE,d1
	move.l	#INPUTBUFFER,d2
	move.l	DOSBASE,a6
	CALL	read
	subq.l	#2,d0
	move.l	d0,INPUTLENGTH
	rts

WRITETEXT
	move.l	d2,a0
	moveq.l	#-1,d3
	moveq.l	#0,d4

.loop	addq.l	#1,d3
	move.b	(a0)+,d4
	bne.b	.loop

	move.l	WINDOWHANDLE,d1
	move.l	DOSBASE,a6
	CALL	write
	rts

*- IFF Routines ---------------------------------------------------------->

*
*	Routine : IFF_SIZE
*	Input	: A0.l = Start of IFF Picture
*	Ouput	: D0.w = Number of planes
*		  D1.w = Width (bytes)
*		  D2.w = Heigh
*

IFF_SIZE
	move.l	a0,-(sp)
	add.w	#12,a0
.IS_0
	cmp.l	#'BMHD',(a0)
	beq.s	.IS_1
	move.l	4(a0),d0
	lea	8(a0,d0.l),a0
	bra.s	.IS_0
.IS_1
	move.w	8(a0),d1
	move.w	d1,d2
	lsr.w	#4,d1
	and.w	#15,d2
	beq.s	.IS_2
	addq.w	#1,d1
.IS_2
	add.w	d1,d1
	move.w	10(a0),d2
	moveq	#0,d0
	move.b	16(a0),d0
	move.l	(sp)+,a0
	rts

*
*	Routine : IFF_DEPACK
*	Input	: A0.l = Start of IFF Picture
*		  A1.l = Pointer to a table containing pointers to the
*			 bitplanes.
*		  A2.l = Buffer for the colours (high bits)
*		  A6.l = Buffer for the colours (low bits)
*		  D0.w = Colour to buffer offset (normal = 2,
*			 copperlist = 4 (A500))
*

IFF_DEPACK
	movem.l	d0-d7/a0-a6,-(sp)
	add.w	#12,a0
.ID_0
	cmp.l	#'BMHD',(a0)
	beq.s	.ID_1
	move.l	4(a0),d1
	lea	8(a0,d1.l),a0
	bra.s	.ID_0
.ID_1
	move.l	a0,a3
.ID_2
	cmp.l	#'CMAP',(a0)
	beq.s	.ID_3
	move.l	4(a0),d1
	lea	8(a0,d1.l),a0
	bra.s	.ID_2
.ID_3
	moveq	#1,d1
	move.b	16(a3),d2
	lsl.w	d2,d1
	lea	8(a0),a4
	bra.s	.ID_5
.ID_4				; get high four bits of colour
	move.b	(a4),d2
	lsl.w	#4,d2
	and.w	#$0f00,d2
	move.b	1(a4),d2
	and.w	#$0ff0,d2
	move.b	2(a4),d3
	lsr.b	#4,d3
	and.w	#$000f,d3
	or.w	d3,d2
	move.w	d2,(a2)
	add.w	d0,a2
.ID_4b				; get low four bits of colour
	move.b	(a4)+,d2
	lsl.w	#8,d2
	and.w	#$0f00,d2
	move.b	(a4)+,d2
	lsl.b	#4,d2
	and.w	#$0ff0,d2
	move.b	(a4)+,d3
	and.w	#$000f,d3
	or.w	d3,d2
	move.w	d2,(a6)
	add.w	d0,a6
.ID_5
	dbf	d1,.ID_4
.ID_6
	cmp.l	#'BODY',(a0)
	beq.s	.ID_7
	move.l	4(a0),d0
	lea	8(a0,d0.l),a0
	bra.s	.ID_6
.ID_7
	moveq	#0,d7
	move.b	16(a3),d7
	subq.w	#1,d7
	moveq	#0,d0
	move.w	d7,d1
.ID_8
	move.l	(a1,d0.w),-(sp)
	addq.w	#4,d0
	dbf	d1,.ID_8
	move.w	d0,-(sp)
	move.w	8(a3),d6
	move.w	d6,d2
	lsr.w	#4,d6
	and.w	#15,d2
	beq.s	.ID_9
	addq.w	#1,d6
.ID_9
	add.w	d6,d6
	move.l	4(a0),d0
	lea	8(a0,d0.l),a2
	addq.l	#8,a0
.ID_a
	cmp.l	a2,a0
	bge.s	.ID_j
	moveq	#0,d3
	move.w	d7,d2
.ID_b
	move.l	(a1,d3.l),a4
	bsr.s	.ID_c
	move.l	a4,(a1,d3.l)
	addq.l	#4,d3
	dbra	d2,.ID_b
	bra.s	.ID_a
.ID_c
	lea	(a4,d6.w),a5
.ID_d
	cmp.l	a5,a4
	bge.s	.ID_l
	tst.b	18(a3)
	bne.s	.ID_e
	move.w	d6,d0
	bra.s	.ID_g
.ID_e
	move.b	(a0)+,d0
	ext.w	d0
	bmi.s	.ID_h
.ID_f
	move.b	(a0)+,(a4)+
.ID_g
	dbf	d0,.ID_f
	bra.s	.ID_d
.ID_h
	neg.w	d0
	move.b	(a0)+,d1
.ID_i
	move.b	d1,(a4)+
	dbf	d0,.ID_i
	bra.s	.ID_d
.ID_j
	move.w	(sp)+,d0
	move.w	d7,d1
.ID_k
	subq.w	#4,d0
	move.l	(sp)+,(a1,d0.w)
	dbf	d1,.ID_k
	movem.l (sp)+,d0-d7/a0-a6
.ID_l
	rts

*------------------------------------------------------------------------->
*
*	Data Definitions
*
*------------------------------------------------------------------------->

DOSNAME		dc.b	'dos.library',0
WINDOWNAME	dc.b	'CON:0/40/640/170/IFF 2 RAW v0.1',0
VERSIONNR	dc.b	'$VER: IFF2RAW v0.1 (21/3/93) © Michel Vissers',0

introtext
		dc.b	10,9,9,'*------------------------------------------*'
		dc.b	10,9,9,'|                                          |'
		dc.b	10,9,9,'|  IFF 2 RAW v0.1 (for AGA pictures only)  |'
		dc.b	10,9,9,'|                                          |'
		dc.b	10,9,9,'|           © 1993 Michel Vissers          |'
		dc.b	10,9,9,'|                                          |'
		dc.b	10,9,9,'*------------------------------------------*'
		dc.b	10,0

loadfiletext	dc.b	10,'Enter IFF file to load : ',0
savefiletext	dc.b	10,'Enter RAW file to save : ',0
fileexiststext	dc.b	10,'RAW file allready exists ! Overwrite ? ',0
copfileextext	dc.b	10,'Copper file allready exists ! Overwrite ? ',0
infotext1	dc.b	10,'Planes :            ',0
infotext2	dc.b	10,'Width  :            ',0
infotext3	dc.b	10,'Heigh  :            ',10,0
wfileerrtext	dc.b	10,'** Error while writing RAW file !',10,0
wfileerrcoptext	dc.b	10,'** Error while writing copperlist !',10,0
fileerrortext	dc.b	10,'** File error !',10,0
memoryerrortext	dc.b	10,'** Unable to reserve memory !',10,0
noifftext	dc.b	10,'** This is not an IFF format file !',10,0
noilbmtext	dc.b	10,'** This is not an IFF ILBM file !',10,0
		even

DOSBASE		dc.l	0
WINDOWHANDLE	dc.l	0
LOADRESERVED	dc.l	0
DECRRESERVED	dc.l	0
ERR		dc.l	0
IFFPLANES	dc.w	0
IFFWIDTH	dc.w	0
IFFHEIGH	dc.w	0
RAWMEMORY	dc.l	0
SIZERAWMEMORY	dc.l	0
INPUTLENGTH	dc.l	0
LOADLOCK	dc.l	0
FILEMEMORY	dc.l	0
READHANDLE	dc.l	0
WRITEHANDLE	dc.l	0
FILELENGTH	dc.l	0
COLOURMEMORY	blk.w	256*2,0
INPUTBUFFER	blk.b	512,0
LOADNAME	blk.b	512,0
SAVENAME	blk.b	512,0
EXAMINEBUFFER	blk.b	260,0
BPLTABLE	blk.l	8,0		; 8 bitplanes maximum.
DECPARTS
		dc.l	10000000
		dc.l	1000000
		dc.l	100000
		dc.l	10000
		dc.l	1000
		dc.l	100
		dc.l	10
		dc.l	1

COPCOLOUR1
		dc.w	$0106,$0000	; Set high-4-bits colours first
		blk.w	32*2,0
		dc.w	$0106,$2000
		blk.w	32*2,0
		dc.w	$0106,$4000
		blk.w	32*2,0
		dc.w	$0106,$6000
		blk.w	32*2,0
		dc.w	$0106,$8000
		blk.w	32*2,0
		dc.w	$0106,$a000
		blk.w	32*2,0
		dc.w	$0106,$c000
		blk.w	32*2,0
		dc.w	$0106,$e000
		blk.w	32*2,0
COPCOLOUR2
		dc.w	$0106,$0200	; Set low-4-bits colours
		blk.w	32*2,0
		dc.w	$0106,$2200
		blk.w	32*2,0
		dc.w	$0106,$4200
		blk.w	32*2,0
		dc.w	$0106,$6200
		blk.w	32*2,0
		dc.w	$0106,$8200
		blk.w	32*2,0
		dc.w	$0106,$a200
		blk.w	32*2,0
		dc.w	$0106,$c200
		blk.w	32*2,0
		dc.w	$0106,$e200
		blk.w	32*2,0
ENDOFCOPPER

