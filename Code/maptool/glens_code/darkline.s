*****************************************************************
* MODULE TITLE     :darkline                                    *
*                                                               *
* DESCRIPTION      :consists of line drawing routines           *
*                                                               *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :draw_line                                   *
*                   EOR_draw_line                               *
*                                                               *
*****************************************************************

draw_line
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	movem.l	a6,-(sp)
	move.l  screen_mem(a0),a0
do_line_bits	
	MOVEQ	#0,D6
	MOVEQ	#0,D7
	MOVE.W	D0,-(SP)
	MOVE.W	D0,D6			;STORE FOR USE IN CALCING START POS
	MOVE.W	D1,D7
CALC_OCTANT
	MOVEQ	#0,D5			;USE TO LOCATE OC

	sub.w	d1,d3			;sub y1 from y2
	bpl	y2bigger
	neg.w	d3
	bset    #2,d5
y2bigger
	sub.w	d0,d2			;x1 from x2
	bpl	x2bigger
	neg.w	d2
	bset	#1,d5
x2bigger
	cmp.w	d2,d3			;is deltax smaller than deltay
	BGe.s	DELTAXSMALLER
	BSET	#0,D5			;D5 CONTAINS OCTANT POS
	move.w	d3,sdelta
	move.w	d2,ldelta
	bra.s	calc_start
DELTAXSMALLER
	move.w	d3,ldelta
	move.w	d2,sdelta

CALC_START
	moveq	#0,d2
	move.l	#main_screen_struct,a6
	move.w	screen_x_size(a6),d2
	asr.w	#3,d2
	mulu	d2,d7
	
	ADD.L	D7,A0
	andi.w	#$fff0,d6
	asr	#3,d6
	ADD.L	D6,A0			;START POINT HELD IN  A0

	MOVEQ	#0,D6
	move.w	sdelta,d6
	asl	#1,d6
	move.w	d6,sdelta
	MOVE.W	LDELTA,D2
	MOVE.W	d2,length
	SUB.W	D2,D6
	asl	#1,D2			;CON LDELTA
	MOVE.W	SDELTA,D1
	SUB.W	D2,D1			;contains xpres2

	MOVE.W	(SP)+,D0		;INIT BLTCON0
	andi.w	#$000f,d0
	ROR.W	#4,D0
	OR.W	#$0Bca,D0

	MOVE.W	SDELTA,D7
	CMP.W	LENGTH,D7
	BGT	NO_SET
	MOVE.W	#$40,D7
	BRA	OR_IN_VAL
NO_SET
	MOVE.W	#0,D7
OR_IN_VAL
	LEA	TABLE,A6		;OCTANT
	OR.B	(A6,D5),D7
BLITTER_IT
	
BLITQ	BTST	#14,$dff002
	BNE	BLITQ

	MOVE.W	#$ffff,$dff072
	MOVE.W	#$8000,$dff074		;MUST BE THIS

	MOVE.L	A0,$dff048		;START ADDRESS
	MOVE.L	A0,$dff054
	MOVE.l	d6,$dff050		;CONTAINS 2*SDELTA-LDELTA
	MOVE.W	SDELTA,$dff062		;2*SDELTA IN HERE
	MOVE.W	d1,$dff064		;CONTAINS 2*SDELTA-2*LDELTA (xpres2)
	
	MOVE.W	D0,$dff040
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	MOVE.W	d0,$dff066		;SCREEN WIDTH IN BYTES
	MOVE.W	d0,$dff060	
	MOVE.W	D7,$dff042
	MOVE.W	#$ffff,$dff044		;MASK
	MOVE.W	length,D0
	CMPi.W	#0,D0
	BHI	KLM
	MOVE.W	#1,D0
KLM
	asl     #6,D0
	ADDi.W	#2,D0
	MOVE.W	D0,$dff058

	movem.l	(sp)+,a6
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	RTS

dark_line

	movem.l	a6,-(sp)
	bra	do_line_bits

eor_dark_line
	movem.l	a6,-(sp)
	bra	eor_line_bits


table
	DC.B	0*4+1
	DC.B	4*4+1
	DC.B	2*4+1
	DC.B	5*4+1
	DC.B	1*4+1
	DC.B	6*4+1
	DC.B	3*4+1
	DC.B	7*4+1
	EVEN

sdelta dc.w 0
length dc.w 0
ldelta dc.w 0


EOR_draw_line
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	movem.l	a6,-(sp)
	move.l  screen_mem(a0),a0
eor_line_bits
	MOVEQ	#0,D6
	MOVEQ	#0,D7
	MOVE.W	D0,-(SP)
	MOVE.W	D0,D6			;STORE FOR USE IN CALCING START POS
	MOVE.W	D1,D7
E_CALC_OCTANT
	MOVEQ	#0,D5			;USE TO LOCATE OC

	sub.w	d1,d3			;sub y1 from y2
	bpl	e_y2bigger
	neg.w	d3
	bset    #2,d5
e_y2bigger
	sub.w	d0,d2			;x1 from x2
	bpl	e_x2bigger
	neg.w	d2
	bset	#1,d5
e_x2bigger
	cmp.w	d2,d3			;is deltax smaller than deltay
	BGe.s	e_DELTAXSMALLER
	BSET	#0,D5			;D5 CONTAINS OCTANT POS
	move.w	d3,sdelta
	move.w	d2,ldelta
	bra.s	e_calc_start
e_DELTAXSMALLER
	move.w	d3,ldelta
	move.w	d2,sdelta

e_CALC_START
	moveq	#0,d2
	move.l	#main_screen_struct,a6
	move.w	screen_x_size(a6),d2
	asr.w	#3,d2
	mulu	d2,d7
	
	ADD.L	D7,A0
	andi.w	#$fff0,d6
	asr	#3,d6
	ADD.L	D6,A0			;START POINT HELD IN  A0

	MOVEQ	#0,D6
	move.w	sdelta,d6
	asl	#1,d6
	move.w	d6,sdelta
	MOVE.W	LDELTA,D2
	MOVE.W	d2,length
	SUB.W	D2,D6
	asl	#1,D2			;CON LDELTA
	MOVE.W	SDELTA,D1
	SUB.W	D2,D1			;contains xpres2

	MOVE.W	(SP)+,D0		;INIT BLTCON0
	andi.w	#$000f,d0
	ROR.W	#4,D0
	OR.W	#$0B5a,D0

	MOVE.W	SDELTA,D7
	CMP.W	LENGTH,D7
	BGT	e_NO_SET
	MOVE.W	#$40,D7
	BRA	e_OR_IN_VAL
e_NO_SET
	MOVE.W	#0,D7
e_OR_IN_VAL
	LEA	TABLE,A6		;OCTANT
	OR.B	(A6,D5),D7
e_BLITTER_IT
	
e_BLITQ	BTST	#14,$dff002
	BNE	e_BLITQ

	MOVE.W	#$ffff,$dff072
	MOVE.W	#$8000,$dff074		;MUST BE THIS

	MOVE.L	A0,$dff048		;START ADDRESS
	MOVE.L	A0,$dff054
	MOVE.l	d6,$dff050		;CONTAINS 2*SDELTA-LDELTA
	MOVE.W	SDELTA,$dff062		;2*SDELTA IN HERE
	MOVE.W	d1,$dff064		;CONTAINS 2*SDELTA-2*LDELTA (xpres2)
	
	MOVE.W	D0,$dff040
	move.l	#main_screen_struct,a0
	move.w	screen_x_size(a0),d0
	asr.w	#3,d0
	MOVE.W	d0,$dff066		;SCREEN WIDTH IN BYTES
	MOVE.W	d0,$dff060	
	MOVE.W	D7,$dff042
	MOVE.W	#$ffff,$dff044		;MASK
	MOVE.W	length,D0
	CMPi.W	#0,D0
	BHI	e_KLM
	MOVE.W	#1,D0
e_KLM
	asl     #6,D0
	ADDi.W	#2,D0
	MOVE.W	D0,$dff058

	movem.l	(sp)+,a6
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	RTS


