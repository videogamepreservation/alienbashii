
		section test,code_c
		OPT C-,D+	
BPR		EQU	64
GRAPHICS_MOD	EQU	0
SCREEN_MOD	EQU	56
XSIZE		EQU	4
YSIZE		EQU	36
XDEST		EQU	42
YDEST		EQU	1
SCROLL_WIDTH	EQU	27

NOP	EQU	18
NOC	EQU	0

CUSTOM	EQU	$DFF000
BPLCONO	EQU	$100
BPLCON1	EQU	$102
BPLCON2	EQU	$104
BPL1MOD  EQU	$108
DDFSTRT	EQU	$092
DDFSTOP	EQU	$094
DIWSTRT	EQU	$08E
DIWSTOP	EQU	$090
VPSOR	EQU	$004
COLOUR0 EQU	$180
COLOUR1 EQU	$182
COLOUR2	EQU	$184
COLOUR3	EQU	$186
DMACON	EQU	$096
COP1LCH	EQU	$080
COPJMP1	EQU	$088

DMAF_BLITTER	EQU   $0040

DMAF_BLTDONE	EQU   $4000
DMAF_BLTNZERO	EQU   $2000

DMAB_BLTDONE	EQU   14
bltddat	EQU   $000
dmaconr	EQU   $002
vposr	EQU   $004
vhposr	EQU   $006
dskdatr	EQU   $008
joy0dat	EQU   $00A
joy1dat	EQU   $00C
clxdat	EQU   $00E

bltcon0	EQU   $040
bltcon1	EQU   $042
bltafwm	EQU   $044
bltalwm	EQU   $046
bltcpt	EQU   $048
bltbpt	EQU   $04C
bltapt	EQU   $050
bltdpt	EQU   $054
bltsize	EQU   $058

bltcmod	EQU   $060
bltbmod	EQU   $062
bltamod	EQU   $064
bltdmod	EQU   $066

bltcdat	EQU   $070
bltbdat	EQU   $072
bltadat	EQU   $074

dsksync	EQU   $07E

cop1lc	EQU   $080
cop2lc	EQU   $084

bpl2mod	EQU   $10A

bpldat	EQU   $110

intreq	EQU   $09c
intreqr	EQU   $01e

MODE_OLDFILE	EQU   1005
MODE_NEWFILE	EQU   1006

	move.l	4,a6
	move.l	#(256*80)*4,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)		;try
	tst.l	d0
	bne	allocated_mem
	rts
allocated_mem
	move.l	d0,Memory_base

	move.l	4,a6
	jsr	-132(A6)		;DISABLE tasking

	bsr	setup
	bsr	Main_Demo

QUIT_OUT
	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking

	move.l	4,a6
	move.l	#(256*80)*4,d0
	move.l	Memory_Base,a1
	jsr	-210(a6)


	MOVE.L	#graf_NAME,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		;OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4

	MOVE.W	#$8020,$dff000+DMACON	; sprites back
	
	move.l	38(a4),$dff080
	clr.w	$dff088
	move.b	#$9b,$bfed01

	rts
graf_NAME	dc.b	"graphics.library",0
	even

setup


	LEA	CUSTOM,A0
	MOVE.W	#$1200,BPLCONO(A0)
	MOVE.W	#0,BPLCON1(A0)
	MOVE.W	#0,BPL1MOD(A0)
	MOVE.W	#$0038,DDFSTRT(A0)
	MOVE.W	#$00D0,DDFSTOP(A0)
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2CC1,DIWSTOP(A0)
	MOVE.W	#$0000,COLOUR0(A0)
	MOVE.W	#$0fff,COLOUR1(A0)

	MOVE.L	#Copper_List,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0

	MOVE.W	#$8380,DMACON(A0)
	move.w	#32,dmacon(a0)		; sprites off
*	move.b	#$7f,$bfed01	

	move.l	memory_base,d0
	move.w	d0,plane1_lo
	swap	d0
	move.w	d0,plane1_hi

	rts
	
Main_Demo
	move.w	$dff006,d0
	and.w	#$ff00,d0
	cmp.w	#$5000,d0
	bne.s	Main_Demo
		
	moveq.l	#0,d0
	move.b	$bfec01,d0
	ror.b	#1,d0
	andi.b	#$7f,d0
	
	move.l	memory_base,a0
	bsr	write_num

	btst.b	#6,$bfe001
	bne.s	main_demo

	rts

Copper_List	
	dc.w	$e0
plane1_hi
	dc.w	0
	dc.w	$e2
Plane1_lo
	dc.w	0
	dc.w	$ffff,$fffe
Memory_Base	dc.l	0


****pass this routine num in d0 and screen start address in a0

write_num
	movem.l  d0-d2/a0-a2,-(sp)
	move.l	#10000,d1	;start divide value
number_loop
	divu	d1,d0		;divide d0 by d1
	move.l	#numbers,a1
	add.w	d0,a1		;gets along position of number
	move.w	#7,d2
	move.l	a0,a2
draw_loop_num		
	move.b	(a1),(a2)
	add.l	#40,a2
	add.l	#10,a1
	dbra	d2,draw_loop_num
	add.l	#1,a0
	move.w	#0,d0
	swap	d0		;get remainder to lower word
	cmp.w	#1,d1
	beq	quit_number_routine
	divu	#10,d1		;divide dividor
	bra	number_loop
quit_number_routine	
	movem.l  (sp)+,d0-d2/a0-a2
	rts


numbers

 DC.W $3C38,$7C7C,$0C7E,$3C7E,$3C3C
 DC.W $7E38,$7E7E,$1C7E,$7C7E,$7E7E
 DC.W $6618,$0606,$3C60,$600E,$6666
 DC.W $6618,$3E3C,$6C7C,$7C1C,$3C7E
 DC.W $6618,$7C3E,$4C7E,$7E18,$7E3E
 DC.W $6618,$6006,$7E06,$6638,$6606
 DC.W $7E18,$7E7E,$7E7E,$7E30,$7E7E
 DC.W $3C18,$7E7C,$0C7C,$3C30,$3C7C
