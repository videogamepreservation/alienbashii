
*----------------------------------- --- -- -  -   -

*
*	Example source of how to display an AGA picture...
*
*	Hmmm, I'm afraid it will show some real shit with smaller pictures
*	and I really don't know what it will do when using a larger one :(
*	A better viewer will be made later. (Or not :)
*
*	$VER: AGAshow.asm v0.1 (23/03/93) © M. Vissers.
*

*----------------------------------- --- -- -  -   -

PLANES	SET	8			; Change the values to the ones
WIDTH	SET	40			; displayed by I2R.
HEIGH	SET	256

	IF HEIGH>256
HEIGH2	SET	256			; Maximum lines on display but keep
	ELSE				; original for calculation of the
HEIGH2	SET	HEIGH			; bitplane pointers.
	ENDC

	IF PLANES>8
PLANES	SET	8			; Maximum planes.
	ENDC

*----------------------------------- --- -- -  -   -

_LVOopenlibrary		=	-552
_LVOcloselibrary	=	-414
_LVOloadview		=	-222
_LVOwaitTOF		=	-270

CALL	MACRO
	jsr	_LVO\1(a6)
	ENDM

WBLIT	MACRO
.WB1\@	btst	#14,$dff002
	bne	.WB1\@
.WB2\@	btst	#14,$dff002
	bne	.WB2\@
	ENDM

*----------------------------------- --- -- -  -   -

RUN
	movem.l	d0-a6,-(a7)

	move.w	$dff07c,d0		; Test if there is an AGA chipset.
	cmp.b	#$f8,d0
	bne.w	NOAGA

	move.l	$4.w,a6			; Open graphics.library v39+.
	lea	GFXNAME,a1
	moveq	#39,d0
	CALL	openlibrary
	tst.l	d0
	beq.w	NOAGA			; Error or version<39.
	move.l	d0,GFXBASE
	move.l	d0,a6

	move.l	34(a6),OLDVIEW
	move.l	#0,a1
	CALL	loadview		; Send current view to nowhere.
	CALL	waitTOF
	CALL	waitTOF

	move.w	#0,$dff1fc		; Little v39 bug.

	move.w	$dff002,DMACON		; Save DMACON and INTENA.
	move.w	$dff01c,INTENA

	WBLIT

	move.w	#$7fff,$dff09a		; Switch everything off.
	move.w	#$7fff,$dff096

	bsr.w	SETBPL			; Initialize the bitplane pointers.

	move.l	#MYCOPPER,$dff080	; Set the copperlist.
	move.w	#0,$dff088

	move.w	#%1000001110000000,$dff096

.mouse1	btst	#6,$bfe001
	bne.b	.mouse1
.mouse2	btst	#6,$bfe001
	beq.b	.mouse2

	move.w	#$7fff,$dff096		; Set everything back to normal.
	move.w	DMACON,d0
	or.w	#$8000,d0
	move.w	d0,$dff096
	move.w	INTENA,d0
	or.w	#$c000,d0
	move.w	d0,$dff09a

	move.l	OLDVIEW,a1		; Restore old view.
	move.l	GFXBASE,a6
	CALL	loadview
	move.l	38(a6),$dff080
	move.w	#0,$dff088

	move.l	GFXBASE,a1
	move.l	$4.w,a6
	CALL	closelibrary		; Close graphics.library.
NOAGA
	movem.l	(a7)+,d0-a6
	moveq	#0,d0
	rts

*----------------------------------- --- -- -  -   -

CBPL	SET	6
OFFSET	SET	0

SBPL	MACRO
	move.l	#\1,d0
	move.w	d0,BPL+CBPL
	swap	d0
	move.w	d0,BPL+CBPL-4
CBPL	SET	CBPL+8
	ENDM

SETBPL						; Fill the bitplane pointers
	REPT	PLANES				; in the copperlist.
	SBPL	PICTURE+OFFSET
OFFSET	SET	OFFSET+[HEIGH*WIDTH]
	ENDR
	rts

*----------------------------------- --- -- -  -   -

GFXNAME		dc.b	'graphics.library',0,0
OLDVIEW		dc.l	0
INTENA		dc.w	0
DMACON		dc.w	0
GFXBASE		dc.l	0

*----------------------------------- --- -- -  -   -

MYCOPPER	dc.w	$0100,$0200,$0102,$0000,$0104,$0000,$0106,$0000
		dc.w	$0108,WIDTH-40,$010a,WIDTH-40
		dc.w	$008e,$2c81,$0090,$2cc1,$0092,$0038,$0094,$00d0
BPL		dc.w	$00e0,$0000,$00e2,$0000,$00e4,$0000,$00e6,$0000
		dc.w	$00e8,$0000,$00ea,$0000,$00ec,$0000,$00ee,$0000
		dc.w	$00f0,$0000,$00f2,$0000,$00f4,$0000,$00f6,$0000
		dc.w	$00f8,$0000,$00fa,$0000,$00fc,$0000,$00fe,$0000

		incbin	ram:agatest.cop

		dc.w	$2c0f,$fffe,$0100,$0210

	IF HEIGH2<211			; Check if the picture passes line $ff.

BOTTOM	SET	HEIGH2+$2c
BOTTOM	SET	BOTTOM<<8

		dc.w	BOTTOM!$000f

	ELSE
	
		dc.w	$ffdf,$fffe

BOTTOM	SET	HEIGH2-212
BOTTOM	SET	BOTTOM<<8

		dc.w	BOTTOM!$000f

	ENDC

		dc.w	$fffe,$0100,$0200
		dc.w	$ffff,$fffe,$ffff,$fffe

*----------------------------------- --- -- -  -   -

PICTURE		incbin	ram:agatest

*----------------------------------- --- -- -  -   -

