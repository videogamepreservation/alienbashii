	section	Generic,Code_C 
 		OPT C-,D+	
		opt p=68020 		
 			
BPR		EQU	64
GRAPHICS_MOD	EQU	0
XSIZE		EQU	4
YSIZE		EQU	36
XDEST		EQU	42
YDEST		EQU	164
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




start:

	move.l	4,a6
	jsr	-132(A6)		;DISABLE tasking


	move.l	4,a6
	move.l	#(256*64)*8,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)		;try
	tst.l	d0
	bne	allocated_mem
	rts			;otherwise quit
allocated_mem
	move.l	d0,Memory_Base
	move.l	d0,Plane1
	add.l	#(256*64),d0
	move.l	d0,plane2
	add.l	#(256*64),d0
	move.l	d0,plane3
	add.l	#(256*64),d0
	move.l	d0,plane4
	add.l	#(256*64),d0
	move.l	d0,buff_plane1
	add.l	#(256*64),d0
	move.l	d0,buff_plane2
	add.l	#(256*64),d0
	move.l	d0,buff_plane3
	add.l	#(256*64),d0
	move.l	d0,buff_plane4




	bsr	setup
	move.w	#$0,$dff106
	bsr	Main_Demo

QUIT_OUT


	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking

	move.l	oldint,$6c
	move.l	4,a6
	move.l	#(256*64)*8,d0
	move.l	Memory_Base,a1
	jsr	-210(a6)

	MOVE.L	#graf_NAME,A1
	MOVEQ	#0,D0
	JSR	-552(A6)		;OPEN GRAPHICS LIBRARY
	MOVE.L	D0,a4

	MOVE.W	#$8020,DMACON+$dff000	; sprites back
	
	move.l	38(a4),$dff080
	clr.w	$dff088
	move.b	#$9b,$bfed01

	rts
graf_NAME	dc.b	"graphics.library",0
	even

setup

	bsr	setup_colours

	LEA	CUSTOM,A0
	MOVE.W	#0,BPLCON1(A0)
	move.w	#%1000000,BPLCON2(a0)
	move.w	#$83a0,DMACON(a0)
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2cC1,DIWSTOP(A0)


	
	MOVE.L	#COPPERL,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0


	
	move.l	$6c,oldint
	move.l	#darkint,$6c	
	rts
	


setup_colours

	move.w	#$180,d0
	move.l	#copper_colours,a0
	move.l	#col_list,a1
	move.w	#16-1,d1
col_loop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$2,d0
	dbra	d1,col_loop
	rts
	
col_list
	dc.w	$000,$f00,$0f0,$00f,$ff0,$0ff,$f0f
	dc.w	$fff,$77f,$707,$f77,$f7f,$7ff,$777
	dc.w	$707,$070	
		

************************************************************
****       D A R K  L I T E   I N T E R R U P T         ****
************************************************************

darkint
	movem.l	d0-d7/a0-a6,-(sp)	

	movem.l	(sp)+,d0-d7/a0-a6
	dc.w	$4ef9
oldint dc.l	0	
mt_data	dc.l	0
music_flag	dc.b	0
	even
play_colours
	dc.b	0
	even
two_channel_flag	dc.b	0
	even




************************************************************
***** S C R E E N      S Y N C                    **********
************************************************************	
	
sync
	move.l	#$dff000,a6	
	move.w	#$0010,intreq(a6)	
wait_for_bit	
	btst.b	#4,intreqr+1(a6)
	beq.s	wait_for_bit
	rts



	
Main_Demo

	bsr	sync
	bsr	display_whole_map
	bsr	swap_buffers
wait	btst.b	#6,$bfe001
	bne.s	main_demo
	btst.b	#10,$dff016
	bne.s	main_demo
	rts




Single_Mouse_Press
	btst	#6,$BFE001
	Bne	out
*	move.w	#$11,jobba
not_released
	btst	#6,$BFE001
	Beq	not_released
out
	rts



COPPERL
	dc.w	bplcono
	dc.w	$4200
	dc.w	$102		; scrolly bit
	dc.w	$000
	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d8
	dc.w	bpl1mod
	dc.w	16
	dc.w	bpl2mod
	dc.w	16
	dc.w	$1e4
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$f


copper_colours	
	ds.w	16*2		
************sprites

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
		
	
	DC.W	$00E0
Plane1_Hi	DC.W	0
	DC.W	$00E2
Plane1_Lo	DC.W	0
	DC.W	$00E4
Plane2_Hi	DC.W	0
	DC.W	$00E6
Plane2_Lo	DC.W	0
	DC.W	$00E8
Plane3_Hi	DC.W	0
	DC.W	$00Ea
Plane3_Lo	DC.W	0
	DC.W	$00Ec
Plane4_Hi	DC.W	0
	DC.W	$00Ee
Plane4_Lo	DC.W	0



	dc.w	$2c01,$ff00	
	dc.w	intreq
	dc.w	$8010

	DC.W	$2cff,$FFFE


	ds.w	1000*2



swap_buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	move.l	plane4,d3
	
		
	move.l	buff_plane1,plane1
	move.l	buff_plane2,plane2
	move.l	buff_plane3,plane3
	move.l	buff_plane4,plane4
	
	move.l	d0,buff_plane1
	move.l	d1,buff_plane2
	move.l	d2,buff_plane3
	move.l	d3,buff_plane4
	

	
	move.w	d0,plane1_lo
	swap	d0
	move.w	d0,plane1_hi
	
	move.w	d1,plane2_lo
	swap	d1
	move.w	d1,plane2_hi

	move.w	d2,plane3_lo
	swap	d2
	move.w	d2,plane3_hi

	move.w	d3,plane4_lo
	swap	d3
	move.w	d3,plane4_hi

	rts
	

Blank	Dc.l	0

Memory_Base	dc.l	0



clear_pixel

	mulu.w	#BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	
	bclr.b	d1,(a0,d0.w)	;

	rts	

plane1
	dc.l	0
plane2
	dc.l	0
plane3
	dc.l	0
plane4
	dc.l	0	
	
	
buff_plane1
	dc.l	0
buff_plane2
	dc.l	0
buff_plane3
	dc.l	0
buff_plane4
	dc.l	0	
	

WHOLE_ACR	EQU	6	;accuracy	
ACCURACY	EQU	64


crap1	dc.w	11
inc	dc.w	4
******************************************
*****	 DISPLAY WHOLE MAP           *****
******************************************
display_whole_map

clear_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	clear_block_on_screen

	move.w	#BPR-40,bltdmod(a6)	
	move.w	#0,bltadat(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$01F00000,bltcon0(A6)	
	move.l	plane1,bltdpt(a6)			;screen
	move.w	#256<<6+20,bltsize(a6)	;1 word by 16 pixels

wait_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	wait_block_on_screen

	move.w	inc,d0
	add.w	d0,crap1
	
	cmp.w	#10,crap1
	bgt.s	ok_x
	neg.w	inc
ok_x
	cmp.w	#200,crap1
	blt.s	ok_x2
	neg.w	inc	
ok_x2			
	
	move.w	crap1,y_show_size
	move.w	crap1,x_show_size
	

	moveq	#0,d2		;increment values
	moveq	#0,d3
	
	moveq	#16,d5		;y

	move.l	plane1,a0
	
	

	
	move.w	#100,d0
	asl.w	#WHOLE_ACR,d0
	ext.l	d0
	move.w	d0,d1
	divu	x_show_size,d0

	move.w	#100,d1
	asr.w	#WHOLE_ACR,d1
	add.w	d1,x_show_size		

	move.w	#100,d1
	asl.w	#WHOLE_ACR,d1
	ext.l	d1
	divu	y_show_size,d1
		
	move.w	#100,d2
	asr.w	#WHOLE_ACR,d2
	add.w	d2,y_show_size		


	
	
	add.w	#16,x_show_size
	add.w	#16,y_show_size
		
	move.l	#map_data,a2
	move.l	a2,a4	;store for later
do_pixel_y	
	move.w	#16,d4
	moveq	#0,d2
do_pixel_x	
	tst.b	(a2)
	bne.s	draw_a_pixel
	bra.s	get_next	
draw_a_pixel
	move.w	d4,d6
	move.w	d5,d7
	move.l	a0,a5
	bsr	draw_pixel	
get_next
	addq.w	#1,d4
	cmp.w	x_show_size,d4
	bgt.s	done_x_line	
	
*calculate block step for x	
	add.w	d0,d2
	move.w	d2,d7
	andi.w	#ACCURACY-1,d2
	asr.w	#WHOLE_ACR,d7
	
	tst	d7
	beq.s	do_pixel_x
	ext.l	d7
	add.l	d7,a2
	bra.s	do_pixel_x
done_x_line	

	addq.w	#1,d5
	cmp.w	y_show_size,d5
	bgt.s	done_y_line	
	
*calculate block step for y
	add.w	d1,d3
	move.w	d3,d7
	andi.w	#ACCURACY-1,d3
	asr.w	#WHOLE_ACR,d7
	
	tst	d7
	beq.s	dont_increase_y_block
	move.w	#100,d6
	mulu	d7,d6			;number of lines to add
	add.l	d6,a4
dont_increase_y_block
	move.l	a4,a2	
	bra	do_pixel_y
done_y_line	

	rts	

x_show_size	dc.w	0
y_show_size	dc.w	0
******************************************
*****	 DRAW PIXEL                  *****
******************************************
draw_pixel	

*send mem in a0, x and y in d0 and d1
	
	mulu	#BPR,d7
	add.l	d7,a5
	move.w	d6,d7
	lsr.w	#3,d6		; get bytes
	andi.b	#%111,d7		; pixel bits
	neg.w	d7
	addq.w	#7,d7
	ext.l	d6
	bset.b	d7,(a5,d6)	
	rts	
	
graphics	
	incbin	"scratch:empty/grap.bin"
	even

map_data
	incbin	"scratch:empty/testmapraw"
	even
	

