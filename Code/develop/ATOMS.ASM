

; Watch out! It's The ATOMS game on the Amiga!!!! Done by Tom. Excellent.


openlibrary = -552
allocmem = -198
freemem = -210

logosize = 40*44*3
memsize = 40*200*4+logosize


bplcon0 = $100
bplcon1 = $102
bplcon2 = $104
bpl1mod = $108
bpl2mod = $10a
ddfstrt = $92
ddfstop = $94
diwstrt = $8e
diwstop = $90
bpl1pth = $e0
bpl1ptl = $e2
bpl2pth = $e4
bpl2ptl = $e6
bpl3pth = $e8
bpl3ptl = $ea
bpl4pth = $ec
bpl4ptl = $ee
col00 = $180
col01 = $182
col02 = $184
col03 = $186
col04 = $188
col05 = $18a
col06 = $18c
col07 = $18e
col08 = $190
col09 = $192
col10 = $194
col11 = $196
col12 = $198
col13 = $19a
col14 = $19c
col15 = $19e
col16 = $1a0
col17 = $1a2
col18 = $1a4
col19 = $1a6
spr0pth = $120
spr0ptl = $122
spr1pth = $124
spr1ptl = $126
spr2pth = $128
spr2ptl = $12a
spr3pth = $12c
spr3ptl = $12e
spr4pth = $130
spr4ptl = $132
spr5pth = $134
spr5ptl = $136
spr6pth = $138
spr6ptl = $13a
spr7pth = $13c
spr7ptl = $13e




 section Atoms+++++++++,CODE_C
 
start:
 lea $dff000,a5
 bsr killsystem
 bsr waitblit
 bsr allocate
 tst.l d0
 beq.s error
 bsr initvars2
 bsr newcopper
playagain:
 jsr mt_init
 bsr initvariables
 bsr askplayers
 bsr initcolours
 st musicflag
 bsr startscreen
 bsr mainloop
 tst.b d4
 beq.s playagain
 bsr waitblit
 bsr oldcopper
 bsr free
 jsr mt_end
error:
 bsr freesystem
 clr.l d0
 rts
waitblit:
 btst #14,2(a5)
 bne.s waitblit
 rts
blankplane:
 btst #14,2(a5)
 bne.s blankplane
 move.l planeaddr,$54(a5)
 clr.w $42(a5)
 clr.w $66(a5)
 move.l #-1,$44(a5)
 move.w #%100000000,$40(a5)
 move.w #200*64+20,$58(a5)
 rts
blankplane2:
 btst #14,2(a5)
 bne.s blankplane2
 move.l planeaddr,$54(a5)
 clr.w $42(a5)
 clr.w $66(a5)
 move.l #-1,$44(a5)
 move.w #%100000000,$40(a5)
 move.w #800*64+20,$58(a5)
 rts

askplayers:
 bsr blankplane2
 bsr waitblit
 lea text1,a0
 move.w #40*20,d0
 bsr textoutput
 lea text2,a0
 move.w #40*50+16,d0
 bsr textoutput
wb:
 btst #6,$bfe001
 bne.s wb
 move.w mousex,d0
 move.w mousey,d1
 cmp.w #45,d1
 blt.s wb
 cmp.w #60,d1
 bgt.s wb
 cmp.w #118,d0
 blt.s wb
 moveq #2,d4
 cmp.w #145,d0
 blt.s hit
 moveq #3,d4
 cmp.w #178,d0
 blt.s hit
 moveq #4,d4
 cmp.w #208,d0
 bgt.s wb
hit:
 subq #1,d4
 move.w d4,players
 move.w d4,playerno
 rts
 
textoutput:
 lea font,a2
 move.l planeaddr,a1
 add.w d0,a1
nextchar:
 clr.w d0
 move.b (a0)+,d0
 blt.s endtext
 sub.b #'a',d0
 blt.s space
 add.w d0,d0
 moveq #15,d7
 move.l a1,a3
textloop:
 move.w 0(a2,d0.w),(a3)
 add.w #480/8,d0
 lea 40(a3),a3
 dbf d7,textloop
space:
 lea 2(a1),a1
 bra.s nextchar
endtext:
 rts
 
startscreen:
 cmp.w #1,framecount
 blt.s startscreen
 clr.w framecount
 move.w #1590,d0
 sub.w distance,d0
 move.w d0,rot
 bsr rotateaxis
 bsr blankplane
 bsr drawgrid
 add.w #20,distance
 cmp.w #1610,distance
 ble.s startscreen
 bsr initscreen
 rts

rotateaxis:
 move.w rot,d0
 add.w d0,d0
 lea sinewave,a0
 lea 1800(a0),a1
 move.w 0(a1,d0.w),d1
 move.w 0(a0,d0.w),d0
 move.w d0,sin1+2
 move.w d0,sin2+2
 move.w d1,cos1+2
 move.w d1,cos2+2
 rts
 
rotate:
 movem.w d0-1,-(sp)
 move.w d2,d0
 move.w d3,d1
sin1 muls #0,d2
cos1 muls #0,d3
 add.l d2,d3
 asr.l #7,d3
sin2 muls #0,d1
cos2 muls #0,d0
 sub.l d1,d0
 asr.l #7,d0
 move.w d0,d2
 movem.w (sp)+,d0-1
 rts
  
drawgrid:
 lea coords,a0
 move.w (a0)+,d7
nextline:
 move.w (a0)+,d2
 move.w (a0)+,d3
 bsr rotate
 move.w distance,d4
 move.w d2,d0
 move.w d3,d1
 ext.l d0
 ext.l d1
 asl.l #8,d0
 asl.l #8,d1
 divs d4,d0
 divs d4,d1
 add.w #160,d0
 add.w #96,d1
 move.w (a0)+,d2
 move.w (a0)+,d3
 bsr rotate
 move.w distance,d4
 ext.l d2
 ext.l d3
 asl.l #8,d2
 asl.l #8,d3
 divs d4,d2
 divs d4,d3
 add.w #160,d2
 add.w #96,d3
 bsr drawline
 dbf d7,nextline
 rts
initvars2:
 clr.w musicflag
 clr.w colours+6
 st fadeflag
 clr.w slider
 clr.w framecount
 move.w #-16,slider2
 clr.w mousex
 clr.w mousey
 clr.w oldmousex
 clr.w oldmousey
 rts
 
initvariables:
 clr.w xrot
 move.w #650,yrot
 clr.w rot
 clr.w explosion
 move.w #-1,winner
 move.w #20,distance
 clr.w quitflag
 clr.w player
 lea playersin,a0
 move.l #$01010101,(a0)
 lea startdata,a0
 lea enddata,a1
loop10:
 clr.b (a0)+
 cmp.l a0,a1
 bne.s loop10
 lea blocklookup,a0
 lea tiles+32,a1
 move.w #255,d7
 clr.l d2
loop13:
 move.l d2,d3
 divu #19,d3
 move.l d3,d4
 swap d4
 add.w d4,d4
 mulu #38*16,d3
 add.w d4,d3
 lea  0(a1,d3.w),a2
 move.l a2,(a0)+
 add.w #1,d2
 dbf d7,loop13
 rts

drawline:
 movem.l d0-7/a0-6,-(sp)
 bsr clipping
 tst.w d5
 bne noline
 moveq #40,d4
 muls d1,d4
 moveq #-$10,d5
 and.w d0,d5
 asr.w #3,d5
 add.w d5,d4
 add.l planeaddr,d4
 clr.l d5
 sub.w d1,d3
 roxl.b #1,d5
 tst.w d3
 bge.s y2gy1
 neg.w d3
y2gy1:
 sub.w d0,d2
 roxl.b #1,d5
 tst.w d2
 bge.s x2gx1
 neg.w d2
x2gx1:
 move.w d3,d1
 sub.w d2,d1
 bge.s dygdx
 exg d2,d3
dygdx:
 roxl.b #1,d5
 tst.w d3
 beq noline
wblit:
 btst #14,2(a5)
 bne.s wblit
 move.b octant_table(pc,d5.w),d5
 add.w d2,d2
 move.w d2,$62(a5)
 sub.w d3,d2
 bgt.s signn1
 or.b #$40,d5
signn1:
 move.w d2,$52(a5)
 sub.w d3,d2
 move.w d2,$64(a5)
 move.w #$8000,$74(a5)
 move.w #$ffff,$72(a5)
 move.w #$ffff,$44(a5)
 and.w #$f,d0
 ror.w #4,d0
 or.w #$bca,d0
 move.w d0,$40(a5)
 move.w d5,$42(a5)
 move.l d4,$54(a5)
 move.l d4,$48(a5)
 move.w #40,$66(a5)
 move.w #40,$60(a5)
 lsl.w #6,d3
 addq #2,d3
 move.w d3,$58(a5)
noline:
 movem.l (sp)+,d0-7/a0-6
 rts
octant_table	dc.b 1,17,9,21,5,25,13,29 

initscreen: 
 lea blocksequ,a0
 move.w #59,d7
nextblock6:
 cmp.w #1,framecount
 blt.s nextblock6
 clr.w framecount
 move.w (a0)+,d0
 ext.l d0
 divu #10,d0
 move.l d0,d1
 swap d0
 move.w #19*12,d2
 bsr drawblock
 dbf d7,nextblock6
 lea playersin,a0
 move.w #19*12+2,d2
 clr.w d0
 moveq #6,d1
 move.w players,d7
playerloop:
 bsr drawblock
 addq #1,d0
 addq #1,d2
 dbf d7,playerloop
 rts
 
mainloop:
 cmp.w #1,framecount
 blt.s mainloop
 clr.w framecount
 bsr morphhandle
 bsr leftclick
 bsr playerhandler
 btst #10,$16(a5)
 beq nowinn
 add.w #1,toggler
 and.w #1,toggler
 tst.w quitflag
 beq.s mainloop
 sf musicflag
 jsr mt_end
 lea text3,a0
 move.w #40*8+12,d0
 bsr textoutput
 lea text4,a0
 move.w #40*26+6,d0
 bsr textoutput
wb2:
 btst #6,$bfe001
 bne.s wb2
 cmp.w #25,mousey
 blt.s wb2
 cmp.w #40,mousey
 bgt.s wb2
 cmp.w #230,mousex
 blt.s wb2
 clr.w d4
 cmp.w #260,mousex
 blt.s exit
 st d4
 cmp.w #290,mousex
 bgt.s wb2
exit:
 rts
nowinn:
 st d4
 rts
 
playerhandler:
 move.w player,d0
 lea collook,a0
 add.w d0,d0
 move.w 0(a0,d0.w),pointercol
 rts
 
morphhandle:
 lea sequences,a1
 lea datatable,a2
 lea inusetable,a4
 lea morphtable,a0
 tst.w (a0)
 beq.s nomorphs
 move.w 2(a0),d0
 move.w 4(a0),d1
 move.w d0,d4
 move.w d1,d5
 mulu #10,d5
 add.w d5,d4
 clr.l d5
 move.b 0(a2,d4.w),d5
 add.w d5,d5
 add.w d5,d5
 move.l 0(a1,d5.w),a3
 add.w 6(a0),a3
 add.w #2,6(a0)
 move.w (a3),d2
 blt.s endmorph
 move.w 8(a0),d3
 mulu #19*3,d3
 add.w d3,d2
 bsr drawblock
nomorphs:
 rts
endmorph:
 add.b #1,0(a2,d4.w)
 clr.w (a0)
 clr.b 0(a4,d4.w)
 bsr checkreactions
 bsr rubexplosion
 lea playersin,a0
playerout:
 add.w #1,player
 move.w players,d6
 cmp.w player,d6
 bge.s firstplayer
 clr.w player
firstplayer:
 move.w player,d0
 tst.b 0(a0,d0.w)
 beq.s playerout
 rts
 
noreact:
 rts
checkreactions:
 tst.w quitflag
 bne.s noreact
 movem.l d0-7/a0-6,-(sp)
 move.w d0,d2
 move.w d1,d3
 mulu #10,d3
 add.w d2,d3
 move.w d3,d4
 move.w d0,d2
 move.w d1,d3
 ext.l d2
 ext.l d3
 divu #10,d2
 divu #6,d3
 swap d2
 swap d3
 tst.w d2
 beq.s edge1
 cmp.w #9,d2
 beq.s edge1
 tst.w d3
 beq.s edge2
 cmp.w #5,d3
 beq.s edge2
centre:
 move.w #4,d3
 bra.s checkexplode
edge1:
 tst.w d3
 beq.s corner
 cmp.w #5,d3
 beq.s corner
 bra.s edge3
edge2:
 tst.w d2
 beq.s corner
 cmp.w #9,d2
 beq.s corner
edge3:
 move.w #3,d3
 bra.s checkexplode
corner:
 move.w #2,d3
checkexplode:
 lea datatable,a2
 cmp.b 0(a2,d4.w),d3
 ble.s explode
 movem.l (sp)+,d0-7/a0-6
 rts
explode:
 bsr rubexplosion
 lea ownertable,a3
 lea inusetable,a4
 clr.b 0(a2,d4.w)
 clr.b 0(a4,d4.w)
 clr.b 0(a3,d4.w)
 move.w #19*12+1,d2
 move.w #1,explosion
 move.w d0,explosion+2
 move.w d1,explosion+4
 bsr drawblock
waitframe:
 cmp.w #5,framecount
 blt.s waitframe
 clr.w framecount
 move.w d1,-(sp)
 addq #1,d1
 bsr spread
 subq #2,d1
 bsr spread
 move.w (sp)+,d1
 addq #1,d0
 bsr spread
 subq #2,d0
 bsr spread
 bsr checkforwinner
 movem.l (sp)+,d0-7/a0-6
 rts
 
rubexplosion:
 tst.w explosion
 beq.s oldexplosion
 movem.w d0-2,-(sp)
 move.w explosion+2,d0
 move.w explosion+4,d1
 move.w #19*12,d2
 clr.w explosion
 bsr drawblock
 movem.w (sp)+,d0-2
oldexplosion:
 rts
 
checkforwinner:
 movem.l d3-4/d7/a0,-(sp)
 lea flags,a1
 clr.l (a1)
 lea ownertable,a0
 move.w #10*6-1,d7
loop19:
 clr.w d4
 move.b (a0)+,d4
 subq #1,d4
 blt.s emptysquare2
 add.b #1,0(a1,d4.w)
emptysquare2:
 dbf d7,loop19
 lea playersin,a0
 move.w players,d7
 clr.w d2
loop21:
 tst.b (a0)
 beq.s stillthere
 tst.b (a1)
 bne.s stillthere
 movem.w d0-2,-(sp)
 move.w d2,d0
 add.w #19*12+6,d2
 moveq #6,d1
 bsr drawblock
 movem.w (sp)+,d0-2
 clr.b (a0)
 sub.w #1,playerno
 bne.s stillthere
 st quitflag
 lea playersin,a0
 clr.w d2
testnext:
 move.w d2,winner
 tst.b (a0)+
 bne.s gameover
 addq #1,d2
 bra.s testnext
stillthere: 
 add.l #1,a0
 add.l #1,a1
 addq #1,d2
 dbf d7,loop21
gameover:
 movem.l (sp)+,d3-4/d7/a0
 rts
 
spread:
 movem.w d0-7/a0-2,-(sp)
 tst.w d0
 blt.s nospread
 tst.w d1
 blt.s nospread
 cmp.w #5,d1
 bgt.s nospread
 cmp.w #9,d0
 bgt.s nospread
 move.w d0,d2
 move.w d1,d3
 mulu #10,d3
 add.w d2,d3
 lea ownertable,a0
 lea datatable,a1
 lea sequ,a2
 move.w player,d4
 move.w d4,d5
 addq #1,d4
 move.b d4,0(a0,d3.w)
 add.b #1,0(a1,d3.w)
 clr.w d2
 move.b 0(a1,d3.w),d2
 add.w d2,d2
 move.w 0(a2,d2.w),d2
 mulu #19*3,d5
 add.w d5,d2
 bsr drawblock
 bsr checkreactions
nospread:
 movem.w (sp)+,d0-7/a0-2
 rts
 
 
 
drawblock:
 movem.l d0-7/a0-6,-(sp)
 mulu #40*16,d1
 add.w d0,d0
 add.w d0,d1
 move.l planeaddr,a0
 add.w d1,a0
 add.l #10+48*40,a0
 lea blocklookup,a1
 add.w d2,d2
 add.w d2,d2
 move.l 0(a1,d2.w),a1
 move.w #15,d7
loop12:
 move.w (a1),(a0)
 move.w 208*38(a1),200*40(a0)
 move.w 2*208*38(a1),2*200*40(a0)
 move.w 3*208*38(a1),3*200*40(a0)
 lea 38(a1),a1
 lea 40(a0),a0
 dbf d7,loop12
 movem.l (sp)+,d0-7/a0-6
 rts
 
leftclick:
 btst #6,$bfe001
 beq.s buttondown
 clr.w buttonflag
 rts
buttondown: 
 tst.w buttonflag
 bne.s nohit
 st buttonflag
 move.w mousex,d0
 move.w mousey,d1
 lsr.w #4,d0
 lsr.w #4,d1
 sub.w #5,d0
 blt.s nohit
 sub.w #3,d1
 blt.s nohit
 cmp.w #10,d0
 bge.s nohit
 cmp.w #6,d1
 bge.s nohit
 bsr startmorph
nohit:
 rts
 
startmorph:
 move.w d0,d4
 move.w d1,d5
 mulu #10,d5
 add.w d5,d4
 lea inusetable,a1
 lea datatable,a2
 lea ownertable,a3
 move.w player,d3
 addq.w #1,d3
 move.b 0(a3,d4.w),d2
 beq.s emptysquare
 cmp.b d3,d2
 bne.s inusemate
emptysquare:
 cmp.b #4,0(a2,d4.w)
 beq.s inusemate
 tst.b 0(a1,d4.w)
 bne.s inusemate
 lea morphtable,a0
 tst.w (a0)
 beq.s foundspace
 rts
foundspace:
 move.b #1,0(a1,d4.w)
 move.w #1,(a0)
 move.w d0,2(a0)
 move.w d1,4(a0)
 clr.w 6(a0)
 move.w player,8(a0)
 move.b d3,0(a3,d4.w)
inusemate:
 rts
 
allocate:
 move.l #$10002,d1
 move.l #memsize,d0
 move.l 4,a6
 jsr allocmem(a6)
 move.l d0,planeaddr
 move.l d0,d1
 add.l #40*200*4,d1
 move.l d1,logoaddr
 rts
free:
 move.l planeaddr,a1
 move.l #memsize,d0
 move.l 4,a6
 jsr freemem(a6)
 rts
 
newcopper:
 bsr initplanes
 bsr initcolours2
 bsr initsprites
 move.l #copperlist,$80(a5)
 clr.w $88(a5)
 move.w #$83e0,$96(a5)
 move.w #$c010,$9a(a5)
 rts
 
initsprites:
 lea sprites,a0
 move.l #mousepointer,d0
 move.w d0,2(a0)
 swap d0
 move.w d0,6(a0)
 lea 8(a0),a0
 move.l #blanksprite,d0
 move.w #6,d7
loop7:
 move.w d0,2(a0)
 swap d0
 move.w d0,6(a0)
 swap d0
 lea 8(a0),a0
 dbf d7,loop7
 rts
 
initcolours:
 lea colours,a0
 lea tiles,a1
 moveq #15,d7
loop2:
 move.w (a1)+,2(a0)
 lea 4(a0),a0
 dbf d7,loop2
 rts
initcolours2:
 lea colours2,a0
 moveq #7,d7
loop91:
 clr.w 2(a0)
 lea 4(a0),a0
 dbf d7,loop91
 rts
 
initplanes:
 lea planes,a0
 move.l planeaddr,d0
 moveq #3,d7
loop1:
 move.w d0,2(a0)
 swap d0
 move.w d0,6(a0)
 swap d0
 add.l #40*200,d0
 lea 8(a0),a0
 dbf d7,loop1
 lea planes2,a0
 move.l logoaddr,d0
 moveq #2,d7
loop90:
 move.w d0,2(a0)
 swap d0
 move.w d0,6(a0)
 swap d0
 add.l #44*40,d0
 lea 8(a0),a0
 dbf d7,loop90
 rts
 
oldcopper:
 clr.l d0
 lea grname,a1
 move.l 4,a6
 jsr openlibrary(a6)
 move.l d0,a1
 move.l 38(a1),$80(a5)
 clr.w $88(a5)
 rts
 
 
killsystem:
 move.w 2(a5),d0
 or.w #$8000,d0
 move.w d0,dmasave+2
 move.w $1c(a5),d0
 or.w #$c000,d0
 move.w d0,intsave+2
 move.l $6c,vecsave+2
 move.w #$7fff,d0
 move.w d0,$96(a5)
 move.w d0,$9a(a5)
 move.l #inter,$6c
 rts
 
freesystem:
vecsave move.l #0,$6c
dmasave move.w #0,$96(a5)
intsave move.w #0,$9a(a5)
 rts
 
inter:
 movem.l d0-7/a0-6,-(sp)
 lea $dff000,a5
 add.w #1,framecount
 bsr readmouse
 bsr drawlogo
 bsr fades
 move.w slider,colours+6
 cmp.w #$fff,slider
 beq.s white
 add.w #$111,slider
white:
 tst.w musicflag
 beq.s nomusic
 jsr mt_music
nomusic:
 lea $dff000,a5
 move.w #$10,$9c(a5)
 movem.l (sp)+,d0-7/a0-6
 rte
 
drawlogo:
 btst #14,2(a5)
 bne.s drawlogo
 move.l logoaddr,d0
 add.l #10,d0
 move.l d0,$54(a5)
 clr.w $42(a5)
 move.w #%100000000,$40(a5)
 move.l #-1,$44(a5)
 move.w #40-20,$66(a5)
 move.w #44*3*64+10,$58(a5)
 lea sinewave,a0
 lea 1800(a0),a1
 move.w xrot,d0
 move.w yrot,d2
 add.w d0,d0
 add.w d2,d2
 move.w 0(a1,d0.w),d1
 move.w 0(a0,d0.w),d0
 move.w 0(a1,d2.w),d3
 move.w 0(a1,d2.w),d2
 move.l d2,-(sp)
 add.w #128,d2
 muls d0,d2
 blt.s behind
 move.l (sp)+,d2
 bsr blitlogo
 asr.w #3,d0
 asr.w #3,d1
 asr.w #3,d2
 muls d2,d0
 asr.w #4,d0
 add.w #154,d0
 add.w #16,d1
 bsr bob
 bra.s infront
behind:
 move.l (sp)+,d2
 asr.w #3,d0
 asr.w #3,d1
 asr.w #3,d2
 muls d2,d0
 asr.w #4,d0
 add.w #154,d0
 add.w #16,d1
 bsr bob
 bsr blitlogo
infront: 
 sub.w #100,xrot
 bge.s nolim
 add.w #3600,xrot
nolim:
 sub.w #5,yrot
 bge.s nolim2
 add.w #3600,yrot
nolim2:
 rts
 
blitlogo:
 movem.w d0-3,-(sp)
 move.l #logo+16,d3
 move.l #mask,d4
wblit8:
 btst #14,2(a5)
 bne.s wblit8 
 move.l logoaddr,d0
 add.l #10,d0
 move.l d3,$50(a5)
 move.w #40-20,$60(a5)
 clr.w $42(a5)
 move.w #40-20,$66(a5)
 move.w #4,$64(a5)
 move.w #4,$62(a5)
 move.l #-1,$44(a5)
 move.w #%111111110010,$40(a5)
 moveq #2,d7
wblit7:
 btst #14,2(a5)
 bne.s wblit7
 move.l d0,$54(a5)
 move.l d0,$48(a5)
 move.l d4,$4c(a5)
 move.w #44*64+10,$58(a5)
 add.l #44*40,d0
 dbf d7,wblit7
 movem.w (sp)+,d0-3
 rts
 
bob:
 movem.l d0-7/a0-6,-(sp)
wblt9:
 btst #14,2(a5)
 bne.s wblt9
 mulu #40,d1
 move.l logoaddr,d2
 add.l d1,d2
 move.w d0,d3
 lsr.w #3,d0
 bclr #0,d0
 add.w d0,d2
 and.w #15,d3
 ror.w #4,d3
 move.w d3,$42(a5)
 or.w #%111111110010,d3
 move.w d3,$40(a5)
 move.l #$ffff0000,$44(a5)
 move.l #logo+16+20,d0
 move.l #mask+20,d1
 move.w #40-4,$66(a5)
 move.w #40-4,$60(a5)
 move.w #20,$64(a5)
 move.w #20,$62(a5)
 moveq #2,d7
nextplane:
 btst #14,2(a5)
 bne.s nextplane
 move.l d0,$50(a5)
 move.l d1,$4c(a5)
 move.l d2,$54(a5)
 move.l d2,$48(a5)
 move.w #8*64+2,$58(a5)
 add.l #44*40,d2
 add.l #44*24,d0
 dbf d7,nextplane
 movem.l (sp)+,d0-7/a0-6
 rts
 
fades:
 tst.w fadeflag
 beq.s nomorefades
 tst.w slider2
 beq.s nomorefades
 add.w #1,slider2
 move.w slider2,d4
 lea logo,a0
 lea colours2,a1
 moveq #7,d7
loop901:
 move.w (a0)+,d0
 move.w d0,d1
 move.w d0,d2
 and.w #$f,d0
 and.w #$f0,d1
 and.w #$f00,d2
 lsr.w #4,d1
 lsr.w #8,d2
 add.w d4,d0
 bge.s norm1
 clr.w d0
norm1:
 add.w d4,d1
 bge.s norm2
 clr.w d1
norm2:
 add.w d4,d2
 bge.s norm3
 clr.w d2
norm3: 
 lsl.w #4,d1
 lsl.w #8,d2
 or.w d1,d0
 or.w d2,d0
 move.w d0,2(a1)
 lea 4(a1),a1
 dbf d7,loop901
nomorefades:
 rts
 
readmouse:
 move.w $a(a5),d0
 move.w d0,d1
 and.w #$ff,d0
 lsr.w #8,d1
 move.w oldmousex,d2
 move.w oldmousey,d3
 move.w d0,oldmousex
 move.w d1,oldmousey
 sub.w d2,d0
 sub.w d3,d1
 cmp.w #-127,d0
 bgt.s nounder1
 add.w #255,d0
nounder1:
 cmp.w #-127,d1
 bgt.s nounder2
 add.w #255,d1
nounder2:
 cmp.w #127,d0
 blt.s noover1
 sub.w #255,d0
noover1:
 cmp.w #127,d1
 blt.s noover2
 sub.w #255,d1
noover2:
 add.w mousex,d0
 bge.s border1
 clr.w d0
border1:
 add.w mousey,d1
 bge.s border2
 clr.w d1
border2:
 cmp.w #318,d0
 blt.s border3
 move.w #317,d0
border3:
 cmp.w #148,d1
 blt.s border4
 move.w #147,d1
border4:
 move.w d0,mousex
 move.w d1,mousey
 bsr setsprite
 rts

clipping:
 movem.l d6-7,-(sp)
 move.w d6,d7
 clr.w d5
 cmp.w d1,d3
 blt.s greater
 exg d1,d3
 exg d0,d2
greater:
 tst.w d1
 blt.s offscreen
 cmp.w #200,d3
 bge.s offscreen
 cmp.w #200,d1
 blt.s notd1down
 bsr clipd1down
notd1down:
 tst.w d3
 bge.s notd3up
 bsr clipd3up
notd3up:
 cmp.w d0,d2
 blt.s greater2
 exg d1,d3
 exg d0,d2
greater2:
 tst.w d0
 blt.s offscreen
 cmp.w #320,d2
 bge.s offscreen
 tst.w d2
 bge.s notd2left
 bsr clipd2left
notd2left:
 cmp.w #320,d0
 blt.s notd0right
 bsr clipd0right
notd0right:
 movem.l (sp)+,d6-7
 rts
offscreen:
 move.w #1,d5
 movem.l (sp)+,d6-7
 rts
clipd1down:
 move.w d3,d4
 sub.w d1,d3
 beq.s vertical2
 sub.w #200,d1
 move.w d0,d6
 sub.w d2,d6
 muls d1,d6
 divs d3,d6
 add.w d6,d0
vertical2:
 move.w #199,d1
 move.w d4,d3
 rts
clipd0right:
 move.w d2,d4
 sub.w d0,d2
 beq.s vertical4
 sub.w #320,d0
 move.w d1,d6
 move.w d1,d7
 sub.w d3,d6
 muls d0,d6
 divs d2,d6
 add.w d6,d1
vertical4:
 move.w #319,d0
 move.w d4,d2
 rts
clipd3up:
 move.w d1,d4
 sub.w d3,d1
 beq.s vertical1
 move.w d2,d6
 sub.w d0,d6
 muls d3,d6
 divs d1,d6
 add.w d6,d2
vertical1:
 clr.w d3
 move.w d4,d1
 rts
clipd2left:
 move.w d0,d4
 sub.w d2,d0
 beq.s vertical3
 move.w d3,d6
 sub.w d1,d6
 muls d2,d6
 divs d0,d6
 add.w d6,d3
vertical3:
 clr.w d2
 move.w d4,d0
 rts

 
setsprite:
 add.w #$2c+3*16,d1
 add.w #$81,d0
 move.w d1,d3
 clr.w d2
 lsl.w #8,d1
 roxl.b #1,d2
 add.w #19,d3
 lsl.w #8,d3
 roxl.b #1,d2
 lsr.w #1,d0
 roxl.b #1,d2
 or.w d2,d3
 or.w d0,d1
 lea mousepointer,a0
 move.w d3,2(a0)
 move.w d1,(a0)
 rts
  
copperlist:
sprites:
 dc.w spr0ptl,0,spr0pth,0,spr1ptl,0,spr1pth,0,spr2ptl,0,spr2pth,0,spr3ptl,0,spr3pth,0,spr4ptl,0,spr4pth,0,spr5ptl,0,spr5pth,0,spr6ptl,0,spr6pth,0,spr7ptl,0,spr7pth,0
 dc.w ddfstrt,$38,ddfstop,$d0
 dc.w diwstrt,$3081,diwstop,$0ac1
 dc.w bplcon0,$3000,bplcon1,0,bplcon2,0,bpl1mod,0,bpl2mod,0
planes2:
 dc.w bpl1ptl,0,bpl1pth,0,bpl2ptl,0,bpl2pth,0,bpl3ptl,0,bpl3pth,0
colours2:
 dc.w col00,0,col01,0,col02,0,col03,0,col04,0,col05,0,col06,0,col07,0
 dc.w $5ad9,$fffe
 dc.w bplcon0,$4000,bplcon1,0,bplcon2,%100100,bpl1mod,0,bpl2mod,0
planes:
 dc.w bpl1ptl,0,bpl1pth,0,bpl2ptl,0,bpl2pth,0,bpl3ptl,0,bpl3pth,0,bpl4ptl,0,bpl4pth,0
colours:
 dc.w col00,0,col01,0,col02,0,col03,0,col04,0,col05,0,col06,0,col07,0,col08,0,col09,0,col10,0,col11,0,col12,0,col13,0,col14,0,col15,0
 dc.w col16,0,col17
pointercol:
 dc.w $fff,col18,0,col19,0
 dc.w $d009,$fffe,$9c,$8010
 dc.w $ffff,$fffe
 
blanksprite	dc.w 0,0

mousepointer	dc.w 0,0
		dc.w %0000000000000000,%1100000000000000
		dc.w %0100000000000000,%1010000000000000
		dc.w %0110000000000000,%1001000000000000
		dc.w %0111000000000000,%1000100000000000
		dc.w %0111100000000000,%1000010000000000
		dc.w %0111110000000000,%1000001000000000
		dc.w %0111111000000000,%1000000100000000
		dc.w %0111111100000000,%1000000010000000
		dc.w %0111111110000000,%1000000001000000
		dc.w %0111111100000000,%1000000010000000
		dc.w %0111111000000000,%1000000100000000
		dc.w %0111111100000000,%1000000010000000
		dc.w %0111111100000000,%1000000010000000
		dc.w %0111011110000000,%1000100001000000
		dc.w %0110011110000000,%1001100001000000
		dc.w %0100001111000000,%1010010000100000
		dc.w %0000001110000000,%0100010001000000
		dc.w %0000000000000000,%0000001110000000
		dc.w 0,0

grname		dc.b 'graphics.library',0
		even
planeaddr	dc.l 0
logoaddr	dc.l 0
musicflag	dc.w 0
player		dc.w 0
oldmousex	dc.w 0
slider		dc.w 0
players		dc.w 0
rot		dc.w 0
winner		dc.w 0
distance	dc.w 0
oldmousey	dc.w 0
slider2		dc.w 0
fadeflag	dc.w 0
mousex		dc.w 0
mousey		dc.w 0
quitflag	dc.w 0
toggler		dc.w 0
buttonflag	dc.w 0
framecount	dc.w 0
xrot		dc.w 0
yrot		dc.w 0

startdata:
datatable	dcb.b 10*6,0
inusetable	dcb.b 10*6,0
ownertable	dcb.b 10*6,0
morphtable	dcb.w 1*10,0
enddata:

coords		dc.w 17,-500,-300,500,-300,-500,-200,500,-200,-500,-100,500,-100,-500,0,500,0,-500,100,500,100,-500,200,500,200,-500,300,500,300
		dc.w -500,-300,-500,300,-400,-300,-400,300,-300,-300,-300,300,-200,-300,-200,300,-100,-300,-100,300,0,-300,0,300,100,-300,100,300,200,-300,200,300,300,-300,300,300,400,-300,400,300,500,-300,500,300

blocksequ	dc.w 59,58,49,57,48,39,56,47,38,29,55,46,37,28,19,54,45,36,27,18,09,53,44,35,26,17,08
		dc.w 52,43,34,25,16,07,51,42,33,24,15,06,50,41,32,23,14,05,40,31,22,13,04,30,21,12,03
		dc.w 20,11,02,10,01,00
playersin	dc.b 0,0,0,0
flags		dc.b 0,0,0,0
playerno	dc.w 0
explosion	dc.w 0,0,0
collook		dc.w $f00,$0f0,$f80,$00f
sequences	dc.l sequence1,sequence2,sequence3,sequence4
sequence1	dc.w 0,-1
sequence2	dc.w 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,-1
sequence3	dc.w 19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,-1
sequence4	dc.w 38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,-1
sequ		dc.w 0,0,18,37,56

text1		dc.b '  how many players',-1
text2		dc.b 124,0,125,0,126,-1
text3		dc.b 'well done ',-1
text4		dc.b 'play again  y n',-1
		even

blocklookup	dcb.l 256,0
tiles		incbin "ram:atomtiles.bitmap"
sinewave	incbin "ram:sinewavetable2"
logo		incbin "ram:atomslogo.bitmap"
mask		incbin "ram:atomslogo.mask"
font		incbin "ram:atomfont.bitmap"

mt_init:lea 	mt_data,a0
	lea	$3b8(a0),a1
	moveq	#$7f,d0
	moveq	#0,d2
	moveq	#0,d1
mt_lop2:move.b	(a1)+,d1
	cmp.b	d2,d1
	ble.s	mt_lop
	move.l	d1,d2
mt_lop:	dbf	d0,mt_lop2
	addq.b	#1,d2

	asl.l	#8,d2
	asl.l	#2,d2
	lea	4(a1,d2.l),a2
	lea	mt_samplestarts(pc),a1
	add.w	#42,a0
	moveq	#$1e,d0
mt_lop3:clr.l	(a2)
	move.l	a2,(a1)+
	moveq	#0,d1
	move.w	(a0),d1
	clr.b	2(a0)
	asl.l	#1,d1
	add.l	d1,a2
	add.l	#$1e,a0
	dbf	d0,mt_lop3

	or.b	#2,$bfe001
	move.b	#6,mt_speed
	moveq	#0,d0
	lea	$dff000,a0
	move.w	d0,$a8(a0)
	move.w	d0,$b8(a0)
	move.w	d0,$c8(a0)
	move.w	d0,$d8(a0)
	clr.b	mt_songpos
	clr.b	mt_counter
	clr.w	mt_pattpos
	rts

mt_end:	clr.w	$dff0a8
	clr.w	$dff0b8
	clr.w	$dff0c8
	clr.w	$dff0d8
	move.w	#$f,$dff096
	rts

mt_music:
	lea 	mt_data,a0
	addq.b	#1,mt_counter
	move.b	mt_counter(pc),d0
	cmp.b	mt_speed(pc),d0
	blt	mt_nonew
	clr.b	mt_counter

	lea 	mt_data,a0
	lea	$c(a0),a3
	lea	$3b8(a0),a2
	lea	$43c(a0),a0

	moveq	#0,d0
	moveq	#0,d1
	move.b	mt_songpos(pc),d0
	move.b	(a2,d0.w),d1
	lsl.w	#8,d1
	lsl.w	#2,d1
	add.w	mt_pattpos(pc),d1
	clr.w	mt_dmacon

	lea	$dff0a0,a5
	lea	mt_voice1(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0b0,a5
	lea	mt_voice2(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0c0,a5
	lea	mt_voice3(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0d0,a5
	lea	mt_voice4(pc),a4
	bsr	mt_playvoice

	move.w mt_dmacon(pc),d0
	beq.s	mt_nodma
	bsr	mt_wait
	or.w	#$8000,d0
	move.w	d0,$dff096
	bsr	mt_wait
mt_nodma:
	lea	mt_voice1(pc),a4
	lea	$dff000,a3
	move.l	$a(a4),$a0(a3)
	move.w	$e(a4),$a4(a3)
	move.l	$a+$1c(a4),$b0(a3)
	move.w	$e+$1c(a4),$b4(a3)
	move.l	$a+$38(a4),$c0(a3)
	move.w	$e+$38(a4),$c4(a3)
	move.l	$a+$54(a4),$d0(a3)
	move.w	$e+$54(a4),$d4(a3)

	add.w	#$10,mt_pattpos
	cmp.w	#$400,mt_pattpos
	bne.s	mt_exit
mt_next:clr.w	mt_pattpos
	clr.b	mt_break
	addq.b	#1,mt_songpos
	and.b	#$7f,mt_songpos
	move.b -2(a2),d0
	cmp.b	mt_songpos(pc),d0
	bne.s	mt_exit
	move.b	-1(a2),mt_songpos
mt_exit:tst.b	mt_break
	bne.s	mt_next
	rts

mt_wait:moveq	#3,d3		
mt_wai2:move.b	$dff006,d2	
mt_wai3:cmp.b	$dff006,d2	
	beq.s	mt_wai3
	dbf	d3,mt_wai2	
	moveq	#8,d2
mt_wai4:dbf	d2,mt_wai4
	rts

mt_nonew:
	lea	mt_voice1(pc),a4
	lea	$dff0a0,a5
	bsr	mt_com
	lea	mt_voice2(pc),a4
	lea	$dff0b0,a5
	bsr	mt_com
	lea	mt_voice3(pc),a4
	lea	$dff0c0,a5
	bsr	mt_com
	lea	mt_voice4(pc),a4
	lea	$dff0d0,a5
	bsr	mt_com
	bra.s	mt_exit

mt_mulu:
	dc.w	0,$1e,$3c,$5a,$78,$96,$b4,$d2,$f0,$10e,$12c,$14a
	dc.w	$168,$186,$1a4,$1c2,$1e0,$1fe,$21c,$23a,$258,$276
	dc.w	$294,$2b2,$2d0,$2ee,$30c,$32a,$348,$366,$384,$3a2

mt_playvoice:
	move.l	(a0,d1.l),(a4)
	moveq	#0,d2
	move.b	2(a4),d2
	lsr.b	#4,d2
	move.b	(a4),d0
	and.b	#$f0,d0
	or.b	d0,d2
	beq.s	mt_oldinstr

	lea	mt_samplestarts-4(pc),a1
	asl.w	#2,d2
	move.l	(a1,d2.l),4(a4)
	lsr.w	#1,d2
	move.w	mt_mulu(pc,d2.w),d2
	move.w	(a3,d2.w),8(a4)
	move.w	2(a3,d2.w),$12(a4)
	moveq	#0,d3
	move.w	4(a3,d2.w),d3
	tst.w	d3
	beq.s	mt_noloop
	move.l	4(a4),d0
	asl.w	#1,d3
	add.l	d3,d0
	move.l	d0,$a(a4)
	move.w	4(a3,d2.w),d0
	add.w	6(a3,d2.w),d0
	move.w	d0,8(a4)
	bra.s	mt_hejaSverige
mt_noloop:
	move.l	4(a4),d0
	add.l	d3,d0
	move.l	d0,$a(a4)
mt_hejaSverige:
	move.w	6(a3,d2.w),$e(a4)
	moveq	#0,d0
	move.b	$13(a4),d0
	move.w 	d0,8(a5)

mt_oldinstr:
	move.w	(a4),d0
	and.w	#$fff,d0
	beq	mt_com2
	tst.w	8(a4)
	beq.s	mt_stopsound
	tst.b	$12(a4)
	bne.s	mt_stopsound
	move.b	2(a4),d0
	and.b	#$f,d0
	cmp.b	#5,d0
	beq.s	mt_setport
	cmp.b	#3,d0
	beq.s	mt_setport

	move.w	(a4),$10(a4)
	and.w	#$fff,$10(a4)
	move.w	$1a(a4),$dff096
	clr.b	$19(a4)

	move.l	4(a4),(a5)
	move.w	8(a4),4(a5)
	move.w	$10(a4),6(a5)

	move.w	$1a(a4),d0
	or.w	d0,mt_dmacon
	bra	mt_com2

mt_stopsound:
	move.w	$1a(a4),$dff096
	bra	mt_com2

mt_setport:
	move.w	(a4),d2
	and.w	#$fff,d2
	move.w	d2,$16(a4)
	move.w	$10(a4),d0
	clr.b	$14(a4)
	cmp.w	d0,d2
	beq.s	mt_clrport
	bge	mt_com2
	move.b	#1,$14(a4)
	bra	mt_com2
mt_clrport:
	clr.w	$16(a4)
	rts

mt_port:move.b	3(a4),d0
	beq.s	mt_port2
	move.b	d0,$15(a4)
	clr.b	3(a4)
mt_port2:
	tst.w	$16(a4)
	beq.s	mt_rts
	moveq	#0,d0
	move.b	$15(a4),d0
	tst.b	$14(a4)
	bne.s	mt_sub
	add.w	d0,$10(a4)
	move.w	$16(a4),d0
	cmp.w	$10(a4),d0
	bgt.s	mt_portok
	move.w	$16(a4),$10(a4)
	clr.w	$16(a4)
mt_portok:
	move.w	$10(a4),6(a5)
mt_rts:	rts

mt_sub:	sub.w	d0,$10(a4)
	move.w	$16(a4),d0
	cmp.w	$10(a4),d0
	blt.s	mt_portok
	move.w	$16(a4),$10(a4)
	clr.w	$16(a4)
	move.w	$10(a4),6(a5)
	rts

mt_sin:
	dc.b	0,$18,$31,$4a,$61,$78,$8d,$a1,$b4,$c5,$d4,$e0,$eb,$f4
	dc.b	$fa,$fd
	dc.b	$ff,$fd,$fa,$f4,$eb,$e0,$d4,$c5,$b4,$a1,$8d,$78,$61
	dc.b	$4a,$31,$18

mt_vib:	move.b	$3(a4),d0
	beq.s	mt_vib2
	move.b	d0,$18(a4)

mt_vib2:move.b	$19(a4),d0
	lsr.w	#2,d0
	and.w	#$1f,d0
	moveq	#0,d2
	move.b	mt_sin(pc,d0.w),d2
	move.b	$18(a4),d0
	and.w	#$f,d0
	mulu	d0,d2
	lsr.w	#7,d2
	move.w	$10(a4),d0
	tst.b	$19(a4)
	bmi.s	mt_vibsub
	add.w	d2,d0
	bra.s	mt_vib3
mt_vibsub:
	sub.w	d2,d0
mt_vib3:move.w	d0,6(a5)
	move.b	$18(a4),d0
	lsr.w	#2,d0
	and.w	#$3c,d0
	add.b	d0,$19(a4)
	rts

mt_arplist:
	dc.b	0,1,2,0,1,2,0,1,2,0,1,2,0
	dc.b	1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1

mt_arp:	moveq	#0,d0
	move.b	mt_counter(pc),d0
	move.b	mt_arplist(pc,d0.w),d0
	beq.s	mt_arp0
	cmp.b	#2,d0
	beq.s	mt_arp2
mt_arp1:moveq	#0,d0
	move.b	3(a4),d0
	lsr.b	#4,d0
	bra.s	mt_arpdo
mt_arp2:moveq	#0,d0
	move.b	3(a4),d0
	and.b	#$f,d0
mt_arpdo:
	asl.w	#1,d0
	move.w	$10(a4),d1
	and.w	#$fff,d1
	lea	mt_periods(pc),a0
	moveq	#$24,d2
mt_arp3:cmp.w	(a0)+,d1
	bge.s	mt_arpfound
	dbf	d2,mt_arp3
mt_arp0:move.w	$10(a4),6(a5)
	rts
mt_arpfound:
	move.w	-2(a0,d0.w),6(a5)
	rts

mt_normper:
	move.w	$10(a4),6(a5)
	rts

mt_com:	move.w	2(a4),d0
	and.w	#$fff,d0
	beq.s	mt_normper
	move.b	2(a4),d0
	and.b	#$f,d0
	tst.b	d0
	beq.s	mt_arp
	cmp.b	#1,d0
	beq.s	mt_portup
	cmp.b	#2,d0
	beq.s	mt_portdown
	cmp.b	#3,d0
	beq	mt_port
	cmp.b	#4,d0
	beq	mt_vib
	cmp.b	#5,d0
	beq.s	mt_volport
	cmp.b	#6,d0
	beq.s	mt_volvib
	move.w	$10(a4),6(a5)
	cmp.b	#$a,d0
	beq.s	mt_volslide
	rts

mt_portup:
	moveq	#0,d0
	move.b	3(a4),d0
	sub.w	d0,$10(a4)
	move.w	$10(a4),d0
	cmp.w	#$71,d0
	bpl.s	mt_portup2
	move.w	#$71,$10(a4)
mt_portup2:
	move.w	$10(a4),6(a5)
	rts

mt_portdown:
	moveq	#0,d0
	move.b	3(a4),d0
	add.w	d0,$10(a4)
	move.w	$10(a4),d0
	cmp.w	#$358,d0
	bmi.s	mt_portdown2
	move.w	#$358,$10(a4)
mt_portdown2:
	move.w	$10(a4),6(a5)
	rts

mt_volvib:
	 bsr	mt_vib2
	 bra.s	mt_volslide
mt_volport:
	 bsr	mt_port2

mt_volslide:
	moveq	#0,d0
	move.b	3(a4),d0
	lsr.b	#4,d0
	beq.s	mt_vol3
	add.b	d0,$13(a4)
	cmp.b	#$40,$13(a4)
	bmi.s	mt_vol2
	move.b	#$40,$13(a4)
mt_vol2:moveq	#0,d0
	move.b	$13(a4),d0
	move.w	d0,8(a5)
	rts

mt_vol3:move.b	3(a4),d0
	and.b	#$f,d0
	sub.b	d0,$13(a4)
	bpl.s	mt_vol4
	clr.b	$13(a4)
mt_vol4:moveq	#0,d0
	move.b	$13(a4),d0
	move.w	d0,8(a5)
	rts

mt_com2:move.b	$2(a4),d0
	and.b	#$f,d0
	cmp.b	#$e,d0
	beq.s	mt_filter
	cmp.b	#$d,d0
	beq.s	mt_pattbreak
	cmp.b	#$b,d0
	beq.s	mt_songjmp
	cmp.b	#$c,d0
	beq.s	mt_setvol
	cmp.b	#$f,d0
	beq.s	mt_setspeed
	rts

mt_filter:
	move.b	3(a4),d0
	and.b	#1,d0
	asl.b	#1,d0
	and.b	#$fd,$bfe001
	or.b	d0,$bfe001
	rts

mt_pattbreak:
	move.b	#1,mt_break
	rts

mt_songjmp:
	move.b	#1,mt_break
	move.b	3(a4),d0
	subq.b	#1,d0
	move.b	d0,mt_songpos
	rts

mt_setvol:
	cmp.b	#$40,3(a4)
	bls.s	mt_sv2
	move.b	#$40,3(a4)
mt_sv2:	moveq	#0,d0
	move.b	3(a4),d0
	move.b	d0,$13(a4)
	move.w	d0,8(a5)
	rts

mt_setspeed:
	moveq	#0,d0
	move.b	3(a4),d0
	cmp.b	#$1f,d0
	bls.s	mt_sp2
	moveq	#$1f,d0
mt_sp2:	tst.w	d0
	bne.s	mt_sp3
	moveq	#1,d0
mt_sp3:	move.b	d0,mt_speed
	rts

mt_periods:
	dc.w	$358,$328,$2fa,$2d0,$2a6,$280,$25c,$23a,$21a,$1fc,$1e0
	dc.w	$1c5,$1ac,$194,$17d,$168,$153,$140,$12e,$11d,$10d,$fe
	dc.w	$f0,$e2,$d6,$ca,$be,$b4,$aa,$a0,$97,$8f,$87
	dc.w	$7f,$78,$71,0

mt_speed:	dc.b	6
mt_counter:	dc.b	0
mt_pattpos:	dc.w	0
mt_songpos:	dc.b	0
mt_break:	dc.b	0
mt_dmacon:	dc.w	0
mt_samplestarts:dcb.l	$1f,0
mt_voice1:	dcb.w	13,0
		dc.w	1
mt_voice2:	dcb.w	13,0
		dc.w	2
mt_voice3:	dcb.w	13,0
		dc.w	4
mt_voice4:	dcb.w	13,0
		dc.w	8
mt_data		incbin "df0:mod.mainmod"


end: 

