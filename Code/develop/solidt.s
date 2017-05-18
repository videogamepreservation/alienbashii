	section	Solid,Code_C 
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

start:
	move.l	4,a6
	move.l	#(256*64)*3,d0	; 
	move.l	#1<<1+1<<16,d1	;chip and clear
	jsr	-198(a6)		;try
	tst.l	d0
	bne	allocated_mem
	rts			;otherwise quit
allocated_mem
	move.l	d0,Memory_Base
	move.l	d0,Vector_Plane
	add.l	#(256*64),d0
	move.l	d0,Vector_Buffer
	add.l	#(256*64),d0

	move.l	d0,blank

	move.l	4,a6
	jsr	-132(A6)		;DISABLE tasking
	bsr	setup
	bsr	Main_Demo

QUIT_OUT
	MOVE.L	4,A6
	JSR	-138(A6)		;ENABLE tasking

	move.l	4,a6
	move.l	#(256*64)*3,d0
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

	move.l	#sinradtable,a0
loopie
	move.w	(a0),d0
	asr.w	#2,d0
	move.w	d0,(a0)+
	cmpa.l	#endsinrad,a0
	blt	loopie

	LEA	CUSTOM,A0
	MOVE.W	#$1200,BPLCONO(A0)
	MOVE.W	#0,BPLCON1(A0)
	MOVE.W	#22,BPL1MOD(A0)
	MOVE.W	#$0030,DDFSTRT(A0)
	MOVE.W	#$00D0,DDFSTOP(A0)
	MOVE.W	#$2C81,DIWSTRT(A0)
	MOVE.W	#$2CC1,DIWSTOP(A0)
	MOVE.W	#$0000,COLOUR0(A0)
	MOVE.W	#$0bbb,COLOUR1(A0)
	MOVE.W	#$0f02,COLOUR2(A0)
	MOVE.W	#$0f02,COLOUR3(A0)
	MOVE.W	#$0a02,$dff188	
	MOVE.W	#$0a02,$dff18a
	MOVE.W	#$0602,$dff18c
	MOVE.W	#$0602,$dff18e
	MOVE.W	#$0000,$dff190
	MOVE.W	#$0ccc,$dff192
	MOVE.W	#$0aaa,$dff194
	MOVE.W	#$0666,$dff196	
	MOVE.W	#$024c,$dff198
	MOVE.W	#$0444,$dff19A
	MOVE.W	#$000a,$dff19C
	MOVE.W	#$008d,$dff19E

	MOVE.L	#COPPERL,COP1LCH(A0)
	MOVE.W	COPJMP1(A0),D0

	MOVE.W	#$8380,DMACON(A0)
	move.w	#32,dmacon(a0)		; sprites off
	move.b	#$7f,$bfed01
	
	move.l	Blank,d0

	move.w	d0,Plane2_Lo
	move.w	d0,Plane3_Lo
	move.w	d0,Plane4_Lo
	move.w	d0,Plane5_Lo
	move.w	d0,Plane6_Lo
	
	swap	d0
	
	move.w	d0,Plane2_Hi
	move.w	d0,Plane3_Hi
	move.w	d0,Plane4_Hi
	move.w	d0,Plane5_Hi
	move.w	d0,Plane6_Hi
	rts
	
Main_Demo

	move.l	#$dff000,a6
	bsr	vectors
	
wait	btst.b	#6,$bfe001
	bne.s	main_demo
	btst.b	#10,$dff016
	bne.s	main_demo
	rts


Vectors	
	move.w	$dff006,d0
	andi.w	#$ff00,d0
	cmp.w	#$0000,d0
	bne.s	vectors
	
	move.l	Vector_Buffer,d0
	move.l	Vector_Plane,d1
	move.l	d1,Vector_Buffer

	move.l	d0,Vector_Plane

	MOVE.W	D0,Plane1_Lo
	SWAP	D0
	MOVE.W	D0,Plane1_Hi


clear	BTST	#14,DMACONR(a6)
	BNE.s	clear
	
	MOVE.W	#$00,BLTDDAT(a6)
	MOVE.W	#$00,BLTADAT(a6)
	MOVE.L	Vector_Buffer,BLTDPT(a6)
	MOVE.W	#24,BLTDMOD(a6)
	move.l	#-1,BLTAFWM(a6)
	MOVE.l	#$01f00000,BLTCON0(a6)
	MOVE.W	#clearsize,BLTSIZE(a6)

	cmp.w	#50,appearance_timer
	bhi.s	no_fade
	move.w	#1,start_fade
no_fade
	*subi.w	#1,Appearance_Timer
	bne.s	dont_change_object
	move.w	#2,start_fade
	move.l	Object_Pointer,A0			; Current object block
	add.l	#ParameterSize,A0			; Next object (nice)
	cmp.l	#thisisthelastblockmatey,A0
	bne.s	sodoffresetting
	move.l	#Parameters_for_3d_images,A0
sodoffresetting
	move.l	A0,Object_Pointer
	move.w	12(A0),rotate1
	move.w	14(A0),rotate2
	move.w	16(A0),rotate3
	move.w	24(A0),Appearance_Timer
	move.w	30(a0),oe			;forget ee
	move.w	32(a0),$182(a6)

dont_change_object	
	
	move.l	Object_Pointer,A0
	move.l	(A0),a3			;shape data
	move.w	rotate1,d0		;rotation factor 0 - x, 1- y, 2 - z
	move.w	rotate2,d1		;no of degrees to rotate
	move.w	rotate3,d2
	move.w	8(A0),d5			;no of points to rotate

	btst.b	#6,$bfe001
	bne.s	dont_rotate
	add.w	18(a0),d0
	add.w	20(a0),d1
	add.w	22(a0),d2
dont_rotate
	move.w	#1,d3			; lower limits
	move.w	#360,d4			; upper limits

	cmp.w	d3,d0
	bge.s	test2
	add.w	d4,d0
	bra.s	test3
test2
	cmp.w	d4,d0
	ble.s	test3
	sub.w	d4,d0
test3
	cmp.w	d4,d1
	ble.s	test4
	sub.w	d4,d1
	bra.s	test5
test4
	cmp.w	d3,d1
	bge.s	test5
	add.w	d4,d1	
test5
	cmp.w	d4,d2
	ble.s	last_test
	sub.w	d4,d2
	bra.s	finished_vectors
last_test
	cmp.w	d3,d2
	bge.s	finished_vectors
	add.w	d4,d2
	
finished_vectors	

	move.w	d0,rotate1
	move.w	d1,rotate2
	move.w	d2,rotate3

	BSR	ROTATE

	move.l	Object_Pointer,A0
	move.l	4(a0),a1			;shape line connections
	move.l	#temps,a2		;shape to plot
	move.w	10(a0),d4		;num of points

	bsr	plotpoints

	move.l	Object_Pointer,A0
	move.l	#temps,a1		;shape to plot
	move.w	10(a0),d4		;num of pixels

*	bsr	Remove_Pixels

* Fill the Object
	
waitfill	BTST	#14,DMACONR(a6)
	BNE.s	waitfill

	MOVE.W	#$00,BLTADAT(a6)
	MOVE.W	#$00,BLTBDAT(a6)	
	MOVE.W	#$00,BLTCDAT(a6)
	MOVE.W	#$00,BLTDDAT(a6)

	move.l	Vector_Buffer,d0
	add.l	#(64*255)+38,d0
	
	MOVE.L	d0,BLTAPT(a6)
	MOVE.L	d0,BLTBPT(a6)
	MOVE.L	d0,BLTCPT(a6)
	MOVE.L	d0,BLTDPT(a6)

	MOVE.W	#24,BLTAMOD(a6)
	MOVE.W	#24,BLTBMOD(a6)
	MOVE.W	#24,BLTCMOD(a6)
	MOVE.W	#24,BLTDMOD(a6)

	move.l	#-1,BLTAFWM(a6)
	MOVE.l	#$09f00012,BLTCON0(a6)
	btst	#10,$dff016
	beq.s	dont_fill_now
	MOVE.W	#clearsize,BLTSIZE(a6)
dont_fill_now
		
	rts
	
	
ROTATE
	subq.w	#1,d0
	subq.w	#1,d1
	subq.w	#1,d2
	
	asl.w	#1,d0
	asl.w	#1,d1
	asl.w	#1,d2
	lea	sinradtable(pc),a4
	lea	cosradtable(pc),a5
	move.w	(a4,d0),sin1	
	move.w	(a5,d0),cos1
	move.w	(a4,d1),sin2
	move.w	(a5,d1),cos2
	move.w	(a4,d2),d0
	move.w   (a5,d2),d1
	
	lea	temps,a1
rotate_loop	

	move.w	(a3),(a1)	;store some values in temp

	move.w	2(a3),d6	;num 1	;calc for x rotation
	move.w	d6,d4
	move.w	4(a3),d7	;num 2
	move.w	d7,d2		;faster than doing another 4(a3) down below
	muls	cos1(pc),d6		;num by cos
	muls	sin1(pc),d7		;num two by sin
	sub.l	d7,d6		;got num 2
	asr.l	#8,d6
	move.w	d6,2(a1)		;store num 1
	move.w	d4,d6		;faster again than doing another 2(a3)
	move.w	d2,d7		;faster
	muls	sin1(pc),d6		;num by sin
	muls	cos1(pc),d7		;num two by cos
	add.l	d7,d6		;got num 1	
	asr.l	#8,d6
	move.w	d6,d2		;store result for further action

do_y_rotation
	
	move.w	(a1),d7		;num2
	muls	cos2(pc),d6		;d6 contains new z num
	muls	sin2(pc),d7		;num two by sin for y
	sub.l	d7,d6		;got num 
	asr.l	#8,d6
	move.w	d2,d4		;contains old z num
	move.w	(a1),d7	;num 2
	muls	sin2(pc),d4		;num by sin 2 for y
	muls	cos2(pc),d7		;num two by cos 2 for y
	add.l	d7,d4		;got num 1	
	asr.l	#8,d4
	move.w	d6,d2			;save new z in d2 again
	move.w	d4,(a1)			;store num 2
	
do_z_rotation

	move.w	2(a1),d7	;num 2
	muls	d1,d4		;num by cos for y
	muls	d0,d7		;num two by sin for y
	sub.l	d7,d4		;got num 3
	asr.l	#8,d4
	move.w	(a1),d6		;num 1
	move.w	2(a1),d7	;num 3
	muls	d0,d6		;num by sin 3 for y
	muls	d1,d7		;num two by cos 3 for y
	add.l	d7,d6		;got num 1	
	asr.l	#8,d6
	move.w	d4,(a1)		;store num 1
	move.w	d6,2(a1)	;store num 2

Perspective_loop
	
	muls	#300,d4
	add.w	oe(pc),d2		-d2 = z 
	divs    d2,d4
	move.w	d4,d3
	muls	#300,d6
	divs	d2,d6		;got num 1
	addi.w	#125,d6		;y - do here rather than twice in plot loop
	move.w	d6,2(a1)	;store num 2
	addi.w	#176,d3		;same as for y
	move.w	d3,(a1)		;no need to save z as not used for drawing		
	addq.l	#6,a3		;next set
	addq.l	#4,a1
	dbeq	d5,rotate_loop  ;few

	rts

PLOTPOINTS
	subq.w	#1,d4		;use as counter
	move.w	d4,d5
	asl	#2,d5
	move.w	(a1,d5),d1
	move.w	2(a1,d5),d3
	asl	#2,d1
	move.w	2(a2,d1.w),d1	;
	asl	#2,d3
	move.w	2(a2,d3.w),d3	;

	sub.w	d3,d1
	move.w	d1,store_val
	
	
plot_loop
	
	move.w	(a1)+,d5
	asl	#2,d5
	move.w	(a2,d5),d0	;point 1
	move.w	2(a2,d5),d1	;point 2
	move.w	(a1)+,d5
	asl	#2,d5
	move.w	(a2,d5),d2	;point  3
	move.w	2(a2,d5),d3	;point  4
	move.l	Vector_Buffer,a0	;current drawing plane
	
	bsr.s	DARKLINE
	dbra	d4,plot_loop
	rts

Remove_Pixels
	
	subq.w	#1,d4		;use as counter
pix_loop
	move.w	d4,d5
	lsl.w	#2,d5
	move.w	(a1,d5),d0	
	move.w	2(a1,d5),d1	
	move.l	Vector_Buffer,a0	;current drawing plane
	moveq.w	#0,d2
	bsr	Write_Pixel_Value
	dbra	d4,pix_loop
	rts




DARKLINE

	 ext.l	d3
	 moveq #64,d4
	 muls d1,d4
	 moveq #-$10,d5
	 and.w	d0,d5
	 asr.w #3,d5
	 add.w d5,d4
	 add.l a0,d4	;got pos
 
 
	 clr.l d5
	 sub.w d1,d3
	 roxl.b #1,d5
	 tst.w d3
	 bge.s y2gy1
	 neg.w d3
y2gy1
	 sub.w d0,d2
	 roxl.b #1,d5
	 tst.w d2
	 bge.s x2gx1
	 neg.w d2
x2gx1
	 move.w d3,d1
	 sub.w d2,d1
	 bge.s dygdx
	 exg d2,d3
dygdx
	 roxl.b #1,d5
	 tst.w d3
	 beq noline
wblit
	 btst #14,2(a6)
	 bne.s wblit
	 move.l	#octant_table,a5
	 move.b (a5,d5.w),d5
	 add.w d2,d2
	 move.w d2,$62(a6)
	 sub.w d3,d2
	 bgt.s signn1
	 or.b #$40,d5
signn1
	 move.w d2,$52(a6)
	 sub.w d3,d2
	 move.w d2,$64(a6)
	 move.w #$8000,$74(a6)
	 move.w #$ffff,$72(a6)
	 move.w #$ffff,$44(a6)
	 and.w #$f,d0
	 ror.w #4,d0
	 or.w #$bca,d0
	 move.w d0,$40(a6)
	 move.w d5,$42(a6)
	 move.l d4,$54(a6)
	 move.l d4,$48(a6)
	 move.w #64,$66(a6)
	 move.w #64,$60(a6)
	 lsl.w #6,d3
	 addq #2,d3
	 move.w d3,$58(a6)
noline 

 	rts
 	
octant_table	dc.b 1,17,9,21,5,25,13,29 
	even



Single_Mouse_Press
	btst	#6,$BFE001
	Bne	Single_Mouse_Press
not_released
	btst	#6,$BFE001
	Beq	not_released
	rts


type	dc.w	14
masky	dc.w	$ffff
faders	
	dc.w	$0000,$0000,$0000,$f000,$f000,$f000
	dc.w	$ff00,$ff00,$ff00,$fff0,$fff0,$fff0
	dc.w	$ffff,$ffff,$ffff

DELTAX		DC.W	0
DELTAY		DC.W	0
SDELTA		DC.W	0
LDELTA		DC.W	0
XPRES		DC.l	0
XPRES2		DC.W	0
length		dc.w	0

COPPERL
	dc.w	$1fc,0
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
	DC.W	$00f0
Plane5_Hi	DC.W	0
	DC.W	$00f2
Plane5_Lo	DC.W	0
	DC.W	$00f4
Plane6_Hi	DC.W	0
	DC.W	$00f6
Plane6_Lo	DC.W	0

	DC.W	$2cff,$FFFE


TABLE
	DC.B	0*4+1,1
	DC.B	4*4+1,1
	DC.B	2*4+1,1
	DC.B	5*4+1,1
	DC.B	1*4+1,1
	DC.B	6*4+1,1
	DC.B	3*4+1,1
	DC.B	7*4+1,1
	EVEN

Blank	Dc.l	0

Vector_Plane
	dc.l	0
Vector_Buffer
	dc.l	0
Appearance_Timer
	dc.w	500

Object_Pointer
	DC.L	Parameters_for_3d_images

Parameters_for_3d_images

LINEFADE	EQU	1
SHRINK		EQU	2
COLOURFADE	EQU	3

	dc.l	GB			; Image
	dc.l	GBcons			; Connections 
	dc.w	GBpoints		; No of points
	dc.w	GBnumcons		; No of connection lines
	dc.w	180			; Start rotation pos x
	dc.w	180			; Start rotation pos y
	dc.w	180			; Start rotation pos z
	dc.w	-4			; Rotation factor    x
	dc.w	0			; Rotation factor    y
	dc.w	0			; Rotation factor    z
	dc.w	500			; Length of appearance
	dc.w	LINEFADE		; Fading bit
	dc.w	3000			;ee
	dc.w	3000			;oe
	dc.w	$0f0
ParameterSize	EQU	*-Parameters_for_3d_images

thisisthelastblockmatey


GB	
	dc.w	-40,200,0
	dc.w	-40,-200,0
	dc.w	40,-200,0
	dc.w	40,200,0
	
	dc.w	-240,280,0
	dc.w	240,280,0
	dc.w	240,200,0
	dc.w	160,200,0
	dc.w	160,-200,0
	dc.w	240,-200,0
	dc.w	240,-280,0
	dc.w	-240,-280,0
	dc.w	-240,-200,0
	dc.w	-160,-200,0
	dc.w	-160,200,0
	dc.w	-240,200,0


GBpoints	EQU	(*-GB)/6
	
GBcons

*must overlap lines properly to remove end line points
	
	dc.w	3,0,0,1,1,2,2,3
	
	dc.w	4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12
	dc.w	12,13,13,14,14,15,15,4

	
GBnumcons	EQU	(*-GBcons)/4




sinradtable
 DC.W 17,35,53,71,89,107,124,142,160,177
 DC.W 195,212,230,247,265,282,299,316,333,350
 DC.W 366,383,400,416,432,448,464,480,496,511
 DC.W 527,542,557,572,587,601,616,630,644,658
 DC.W 671,685,698,711,724,736,748,760,772,784
 DC.W 795,806,817,828,838,848,858,868,877,886
 DC.W 895,904,912,920,928,935,942,949,955,962
 DC.W 968,973,979,984,989,993,997,1001,1005,1008
 DC.W 1011,1014,1016,1018,1020,1021,1022,1023,1023,1024
 DC.W 1023,1023,1022,1021,1020,1018,1016,1014,1011,1008
 DC.W 1005,1001,997,993,989,984,979,973,968,962
 DC.W 955,949,942,935,928,920,912,904,895,886
 DC.W 877,868,858,848,838,828,817,806,795,784
 DC.W 772,760,748,736,724,711,698,685,671,658
 DC.W 644,630,616,601,587,572,557,542,527,512
 DC.W 496,480,464,448,432,416,400,383,366,350
 DC.W 333,316,299,282,265,247,230,212,195,177
 DC.W 160,142,124,107,89,71,53,35,17,0
 DC.W -18,-36,-54,-72,-90,-108,-125,-143,-161,-178
 DC.W -196,-213,-231,-248,-266,-283,-300,-317,-334,-351
 DC.W -367,-384,-401,-417,-433,-449,-465,-481,-497,-512
 DC.W -528,-543,-558,-573,-588,-602,-617,-631,-645,-659
 DC.W -672,-686,-699,-712,-725,-737,-749,-761,-773,-785
 DC.W -796,-807,-818,-829,-839,-849,-859,-869,-878,-887
 DC.W -896,-905,-913,-921,-929,-936,-943,-950,-956,-963
 DC.W -969,-974,-980,-985,-990,-994,-998,-1002,-1006,-1009
 DC.W -1012,-1015,-1017,-1019,-1021,-1022,-1023,-1024,-1024,-1025
 DC.W -1024,-1024,-1023,-1022,-1021,-1019,-1017,-1015,-1012,-1009
 DC.W -1006,-1002,-998,-994,-990,-985,-980,-974,-969,-963
 DC.W -956,-950,-943,-936,-929,-921,-913,-905,-896,-887
 DC.W -878,-869,-859,-849,-839,-829,-818,-807,-796,-785
 DC.W -773,-761,-749,-737,-725,-712,-699,-686,-672,-659
 DC.W -645,-631,-617,-602,-588,-573,-558,-543,-528,-513
 DC.W -497,-481,-465,-449,-433,-417,-401,-384,-367,-351
 DC.W -334,-317,-300,-283,-266,-248,-231,-213,-196,-178
 DC.W -161,-143,-125,-108,-90,-72,-54,-36,-18,0
cosradtable
 DC.W 1023,1023,1022,1021,1020,1018,1016,1014,1011,1008
 DC.W 1005,1001,997,993,989,984,979,973,968,962
 DC.W 955,949,942,935,928,920,912,904,895,886
 DC.W 877,868,858,848,838,828,817,806,795,784
 DC.W 772,760,748,736,724,711,698,685,671,658
 DC.W 644,630,616,601,587,572,557,542,527,511
 DC.W 496,480,464,448,432,416,400,383,366,350
 DC.W 333,316,299,282,265,247,230,212,195,177
 DC.W 160,142,124,107,89,71,53,35,17,0
 DC.W -18,-36,-54,-72,-90,-108,-125,-143,-161,-178
 DC.W -196,-213,-231,-248,-266,-283,-300,-317,-334,-351
 DC.W -367,-384,-401,-417,-433,-449,-465,-481,-497,-513
 DC.W -528,-543,-558,-573,-588,-602,-617,-631,-645,-659
 DC.W -672,-686,-699,-712,-725,-737,-749,-761,-773,-785
 DC.W -796,-807,-818,-829,-839,-849,-859,-869,-878,-887
 DC.W -896,-905,-913,-921,-929,-936,-943,-950,-956,-963
 DC.W -969,-974,-980,-985,-990,-994,-998,-1002,-1006,-1009
 DC.W -1012,-1015,-1017,-1019,-1021,-1022,-1023,-1024,-1024,-1025
 DC.W -1024,-1024,-1023,-1022,-1021,-1019,-1017,-1015,-1012,-1009
 DC.W -1006,-1002,-998,-994,-990,-985,-980,-974,-969,-963
 DC.W -956,-950,-943,-936,-929,-921,-913,-905,-896,-887
 DC.W -878,-869,-859,-849,-839,-829,-818,-807,-796,-785
 DC.W -773,-761,-749,-737,-725,-712,-699,-686,-672,-659
 DC.W -645,-631,-617,-602,-588,-573,-558,-543,-528,-512
 DC.W -497,-481,-465,-449,-433,-417,-401,-384,-367,-351
 DC.W -334,-317,-300,-283,-266,-248,-231,-213,-196,-178
 DC.W -161,-143,-125,-108,-90,-72,-54,-36,-18,0
 DC.W 17,35,53,71,89,107,124,142,160,177
 DC.W 195,212,230,247,265,282,299,316,333,350
 DC.W 366,383,400,416,432,448,464,480,496,511
 DC.W 527,542,557,572,587,601,616,630,644,658
 DC.W 671,685,698,711,724,736,748,760,772,784
 DC.W 795,806,817,828,838,848,858,868,877,886
 DC.W 895,904,912,920,928,935,942,949,955,962
 DC.W 968,973,979,984,989,993,997,1001,1005,1008
 DC.W 1011,1014,1016,1018,1020,1021,1022,1023,1023,1024
ENDSINRAD
sin1	dc.w	0
sin2	dc.w	0
cos1	dc.w	0
cos2	dc.w	0
xvect	dc.w	160
yvect	dc.w	127
ee	dc.w	300
oe	dc.w	1200
temps	ds.w	300	;safe not sorry said the vicar to the
			
temp1	dc.w	0	;pork pie which had a rather off
rotate1 dc.w	180	;brown crust and looked a bit
rotate2 dc.w	180	;green so he gave it to an old begger
rotate3	dc.w	180	;who kindly accepted it ate it and died the next day

clearsize	equ	256<<6+20 ; of motorola. Suddenly as if it were

Memory_Base	dc.l	0

start_fade	dc.w	0	

Write_Pixel_Value
	movem.l	d0/d1/d3/a0,-(sp)

	mulu.w	#BPR,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	

	btst	#0,d2
	beq.s	SetZero

	
	bset.b	d1,(a0,d0.w)	;
	bra.s	SetOne
SetZero
	
	bclr.b	d1,(a0,d0.w)	;
SetOne	
	movem.l	(sp)+,d0/d1/d3/a0
	rts	

go
	dc.w	0


store_val
	dc.w	0
