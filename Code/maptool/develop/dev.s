		section test,code_c 
		
		
		incdir "dh0:game/platform/develop/"
		
exec	 equ	4		; amiga executive o/s base


SERPER   equ   $032		; serial port period and control
SERDATR  equ   $018		; serial port data and status read
SERDAT	 equ   $030
INTREQ   equ   $09c		; interrupt request bits
INTENA	 equ   $09a             ; interrupt enable bits


CUSTOM	EQU	$DFF000		; start of amigas hardware
BPLCONO	EQU	$100
BPLCON1	EQU	$102
BPLCON2	EQU	$104
BPL1MOD EQU	$108
BPL2MOD EQU	$10a
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

bpldat	EQU   $110
MODE_OLDFILE	EQU   1005
MODE_NEWFILE	EQU   1006



STARTOFMAINCODE

	bsr	setup
	cmp.w	#0,error_flag
	beq	aok
	rts
aok
	move.l	#colours,a1
	bsr	setup_screen_colours
	bsr	mainroutine
	bsr	winddown	
	rts



mainroutine
	bsr	sync
	bsr	get_stick_readings
	bsr	update_player
	bsr	display_player

	bsr	pause	
	btst	#6,$bfe001
	bne	mainroutine
	rts

pause
	move.w	#10000,d0
wait_p
	dbra	d0,wait_p
		rts	

sync
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	bne.s	sync
	rts

*****************************************************************
*Module Name	:setup						*
*Function	:sets up screen,allocates mem			*
*****************************************************************



setup


	move.l	4,a6			; exec
	move.l	#(40*256)*3,d0 		; mem to allocate 3 planes 258*336 wide two screens for swiching	
	move.l	#1<<1+1<<16,d1	        	; chip and clear
	jsr	-198(a6)	        		; try
	tst.l	d0
	bne	allocated_mem
	move.w	#1,error_flag
	rts				; otherwise quit
allocated_mem
	move.l	d0,backscr1
	add.l	#40*256,d0
	move.l	d0,backscr2
	add.l	#40*256,d0
	move.l	d0,backscr3

	LEA	CUSTOM,A0
	MOVE.W	#$3200,BPLCONO(A0)		;set up 6 planes dual-playfield
	MOVE.W	#0,BPLCON1(A0)			
	MOVE.W	#0,BPL1MOD(A0)		; for 320 wide screen
	MOVE.W	#0,BPL2MOD(A0)
	MOVE.W	#$0038,DDFSTRT(A0)
	MOVE.W	#$00D0,DDFSTOP(A0)
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2CC1,DIWSTOP(A0)
	MOVE.L	#COPPERL,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0
	 
	MOVE.W	#$8380,DMACON(A0)		
	move.w	#$8020,DMACON(a0)	;sprites on
	move.l	backscr1,d0
	MOVE.W	D0,PLANELOW
	SWAP	D0
	MOVE.W	D0,PLANEHIGH

	move.l	backscr2,d0
	MOVE.W	D0,PLANE2LOW
	SWAP	D0
	MOVE.W	D0,PLANE2HIGH

	move.l	backscr3,d0
	MOVE.W	D0,PLANE3LOW
	SWAP	D0
	MOVE.W	D0,PLANE3HIGH
	
	move.l	exec,a6			; use our label
	jsr	-120(a6)		; disable system tasking
	
	
	rts

*****************************************************************
*Module Name	:winddown					*
*Function	:deallocates mem, exits to system		*
*****************************************************************

winddown	

	move.l	4,a6			; deallocate mem
	move.l	#(40*256)*3,d0
	move.l	backscr1,a1
	jsr	-210(a6)
	
	MOVE.L	#graf_name,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		; OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4
	MOVE.L	#$DFF000,A6
	MOVE.L	38(A4),COP1LCH(A6)	; GET SYSTEM COPPER
	CLR.W	COPJMP1(A6)
	MOVE.W	#$8030,$DFF096		; ENABLE SPRITES

	move.l	exec,a6			; use our label
	jsr	-126(a6)		; enable system tasking

	
	RTS 				


COPPERL

	DC.W	$00E0
PLANEHIGH	DC.W	0
	DC.W	$00E2
PLANELOW	DC.W	0

	DC.W	$00E4
PLANE2HIGH	DC.W	0
	DC.W	$00E6
PLANE2LOW	DC.W	0

	DC.W	$00E8
PLANE3HIGH	DC.W	0
	DC.W	$00Ea
PLANE3LOW	DC.W	0

	dc.w $120		;all sprite stuff
sprite0h dc.w $0
	dc.w $122
sprite0l dc.w 0

         dc.w $124
sprite1h dc.w $0
	dc.w $126
sprite1l dc.w 0

         dc.w $128
sprite2h dc.w $0
	dc.w $12a
sprite2l dc.w 0 	

         dc.w $12c
sprite3h dc.w $0
	dc.w $12e
sprite3l dc.w 0	

         dc.w $130
sprite4h dc.w $0
	dc.w $132
sprite4l dc.w 0

         dc.w $134
sprite5h dc.w $0
	dc.w $136
sprite5l dc.w 0

         dc.w $138
sprite6h dc.w $0
	dc.w $13a
sprite6l dc.w 0

         dc.w $13c
sprite7h dc.w $0
	dc.w $13e
sprite7l dc.w 0
	


main_screen_colours
	dc.w	$180
	dc.w	0
	dc.w	$182
	dc.w	0
	dc.w	$184
	dc.w	0
	dc.w	$186
	dc.w	0
	dc.w	$188
	dc.w	0
	dc.w	$18a
	dc.w	0
	dc.w	$18c
	dc.w	0
	dc.w	$18e
	dc.w	0
	dc.w	$190
	dc.w	0
	dc.w	$192
	dc.w	0
	dc.w	$194
	dc.w	0
	dc.w	$196
	dc.w	0
	dc.w	$198
	dc.w	0
	dc.w	$19a
	dc.w	0
	dc.w	$19c
	dc.w	0
	dc.w	$19e
	dc.w	0

other_colours
	dc.w	$1a0
	dc.w	0
	dc.w	$1a2
	dc.w	0
	dc.w	$1a4
	dc.w	0
	dc.w	$1a6
	dc.w	0
	dc.w	$1a8
	dc.w	0
	dc.w	$1aa
	dc.w	0
	dc.w	$1ac
	dc.w	0
	dc.w	$1ae
	dc.w	0
	dc.w	$1b0
	dc.w	0
	dc.w	$1b2
	dc.w	0
	dc.w	$1b4
	dc.w	0
	dc.w	$1b6
	dc.w	0
	dc.w	$1b8
	dc.w	0
	dc.w	$1ba
	dc.w	0
	dc.w	$1bc
	dc.w	0
	dc.w	$1be
	dc.w	0


	DC.W	$ffFF,$FFFE


graf_name dc.b	"graphics.library",0
	EVEN


error_flag	dc.w	0
backscr1	Dc.l	0
backscr2	Dc.l	0
backscr3	Dc.l	0


**********************************
*** SETUP_SCREEN_COLOURS      ****
**********************************
	
setup_screen_colours
***send colour map in a1
	move.l	#main_screen_colours+2,a3
	move.w	#32-1,d0
fill_scr_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_scr_colours

	rts


colours
	dc.w	$080,$fff,$fff,$fff,$fff,$fff,$fff,$fff
	dc.w	0,$fff,$fff,$fff,$fff,$fff,$fff,$fff
	
	dc.w	0,$e35,$f00,$b00,$f78,$d56,$fff,$0cc
	dc.w	$000,$c70,$ff2,$33d,$56f
	dc.w	0,$fff,$fff,$fff,$fff,$fff,$fff,$fff

	include  "glens_code/joy_routines.s"
	include  "glens_code/player_routines1.s"
	
	incdir	"dh0:game/platform/"
	
	include  "graphics/player_graphics.s"


	