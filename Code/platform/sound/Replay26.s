**********************************************
*
* Soundtracker Module-Player
*   for Soundtracker V2.6
*
* SEKA version
* (Devpac: replace 'blk' with 'dcb' (sic!) )
*
* last change: 03-Nov-90 mtn
*
**********************************************
* Note: mt_init has to be called up with the
* address of the module in A0 !!
**********************************************

* equates for voice-structure *
mt_cmdperiod=0				;period
mt_cmd=2				;instr/cmd
mt_cmdpar=3				;cmd-parameter
mt_sampleadr=4				;address of sample
mt_samplelen=8				;length of sample
mt_samplerep=$a				;address of repeat-part
mt_samplerepl=$e			;length of repeat-part
mt_period=$10				;period to play
mt_volume=$12				;volume to set
mt_dmabit=$14				;dmabit for channel
mt_slidedir=$16				;slide up/down
mt_slidespeed=$17			;speed of slide
mt_slidedest=$18			;slide to period x
mt_vibamp=$1a				;vibrato amplitude
mt_vibcount=$1b				;counter for vibrato
mt_voicelen=$1c

* equates for global player data-structure *
mt_data=0				;address of module
mt_pattpos=4				;current position
mt_dmacon=6				;dma-bits
mt_speedEven=8				;current speed (even frames)
mt_speedOdd=9				; -"- (odd frames)
mt_songpos=$a				;position-counter
mt_counter=$b				;frame-counter
mt_break=$c				;flag for pattern-break
mt_datalen=$e

mt_init:
	movem.l	d0-d1/a0-a2/a4,-(SP)
	lea	mt_playerdata(PC),a4
	clr.l	mt_data(a4)
	cmp.l	#'MTN'*256,$5b8(a0)
	bne	mt_initerror
	move.l	a0,mt_data(a4)

	lea	$3b8(a0),a1
	moveq	#0,d1
	move.w	#$1ff,d0
mt_loop:
	cmp.b	(a1,d0.w),d1
	bhi.s	mt_nothigh
	move.b	(a1,d0.w),d1
mt_nothigh:
	dbf	d0,mt_loop
	addq.b	#1,d1

	lea	mt_samplestarts(PC),a1
	lsl.l	#8,d1
	lea	(a0,d1.l),a2
	add.w	#$5bc,a2
	moveq	#$1e,d0
mt_lop3:clr.l	(a2)
	move.l	a2,(a1)+
	moveq	#0,d1
	move.w	42(a0),d1
	add.l	d1,d1
	add.l	d1,a2
	add.w	#$1e,a0
	dbf	d0,mt_lop3

	or.b	#2,$bfe001
	move.b	#$06,mt_speedEven(a4)
	move.b	#$06,mt_speedOdd(a4)
	lea	mt_voice1(PC),a0
	move.w	#$0001,mt_dmabit(a0)
	lea	mt_voice2(PC),a0
	move.w	#$0002,mt_dmabit(a0)
	lea	mt_voice3(PC),a0
	move.w	#$0004,mt_dmabit(a0)
	lea	mt_voice4(PC),a0
	move.w	#$0008,mt_dmabit(a0)
	lea	$dff0a8,a0
	clr.w	(a0)
	clr.w	$10(a0)
	clr.w	$20(a0)
	clr.w	$30(a0)
	clr.b	mt_songpos(a4)
	clr.b	mt_counter(a4)
	clr.w	mt_pattpos(a4)
mt_initerror:
	movem.l	(SP)+,d0-d1/a0-a2/a4
	rts

mt_end:
	move.l	a0,-(SP)
	lea	$dff0a8,a0
	clr.w	(a0)
	clr.w	$10(a0)
	clr.w	$20(a0)
	clr.w	$30(a0)
	move.w	#$f,$96-$a8(a0)
	move.l	(SP)+,a0
	rts

mt_music:
	movem.l	d0-d5/a0-a6,-(SP)
	lea	mt_playerdata(PC),a4
	move.l	mt_data(a4),d0
	beq	mt_playerror
	move.l	d0,a0
	addq.b	#1,mt_counter(a4)
	move.b	mt_counter(a4),d0
	move.w	mt_pattpos(a4),d1
	lsr.w	#2,d1
	and.w	#1,d1
	move.b	mt_speedEven(a4,d1.w),d1
	cmp.b	d1,d0
	blt.s	mt_nonew
	clr.b	mt_counter(a4)
	bra	mt_getnew

mt_nonew:
	lea	mt_voice1(PC),a6
	lea	$dff0a0,a5
	bsr	mt_checkcom
	lea	mt_voice2(PC),a6
	lea	$dff0b0,a5
	bsr	mt_checkcom
	lea	mt_voice3(PC),a6
	lea	$dff0c0,a5
	bsr	mt_checkcom
	lea	mt_voice4(PC),a6
	lea	$dff0d0,a5
*	bsr	mt_checkcom
	bra	mt_endr

mt_arpeggio:
	moveq	#0,d0
	move.b	mt_counter(a4),d0
	divu	#$3,d0
	swap	d0
	tst.w	d0
	beq.s	mt_arp2
	cmp.w	#2,d0
	beq.s	mt_arp1

	moveq	#0,d0
	move.b	mt_cmdpar(a6),d0
	lsr.b	#4,d0
	bra.s	mt_arp3
mt_arp1:moveq	#0,d0
	move.b	mt_cmdpar(a6),d0
	and.b	#$f,d0
	bra.s	mt_arp3
mt_arp2:move.w	mt_period(a6),d2
	bra.s	mt_arp4
mt_arp3:add.w	d0,d0
	moveq	#0,d1
	move.w	mt_period(a6),d1
	lea	mt_periods(PC),a0
	moveq	#$24,d3
mt_arploop:
	move.w	(a0,d0.w),d2
	cmp.w	(a0),d1
	bge.s	mt_arp4
	addq.l	#2,a0
	dbf	d3,mt_arploop
	rts
mt_arp4:move.w	d2,6(a5)
	rts

mt_getnew:
	clr.w	mt_dmacon(a4)

	lea	$dff0a0,a5
	lea	mt_voice1(pc),a6
	moveq	#0,d5
	bsr.s	mt_playvoice
	lea	$dff0b0,a5
	lea	mt_voice2(pc),a6
	moveq	#1,d5
	bsr.s	mt_playvoice
	lea	$dff0c0,a5
	lea	mt_voice3(pc),a6
	moveq	#2,d5
	bsr.s	mt_playvoice
	lea	$dff0d0,a5
	lea	mt_voice4(pc),a6
	moveq	#3,d5
*	bsr.s	mt_playvoice
	bra	mt_setdma

mt_playvoice:
	move.l	mt_data(a4),a0
	lea	12(a0),a3
	lea	$3b8(a0),a2
	lea	$5bc(a0),a0

	moveq	#0,d0
	moveq	#0,d1
	move.b	mt_songpos(a4),d0
	lsl.w	#2,d0
	add.w	d0,a2
	move.b	(a2,d5.w),d1
	lsl.l	#8,d1
	add.w	mt_pattpos(a4),d1

	move.l	(a0,d1.l),mt_cmdperiod(a6)
	addq.l	#4,d1
	moveq	#0,d2
	move.b	mt_cmd(a6),d2
	and.b	#$f0,d2
	lsr.b	#4,d2
	move.b	mt_cmdperiod(a6),d0
	and.b	#$f0,d0
	or.b	d0,d2
	tst.b	d2
	beq.s	mt_setregs
	moveq	#0,d3
	lea	mt_samplestarts(PC),a1
	move.l	d2,d4
	subq.l	#$1,d2
	lsl.l	#2,d2
	mulu	#$1e,d4
	move.l	(a1,d2.l),mt_sampleadr(a6)
	move.w	(a3,d4.l),mt_samplelen(a6)
	move.w	$2(a3,d4.l),mt_volume(a6)
	move.w	$4(a3,d4.l),d3
	tst.w	d3
	beq.s	mt_noloop
	move.l	mt_sampleadr(a6),d2
	add.w	d3,d3
	add.l	d3,d2
	move.l	d2,mt_samplerep(a6)
	move.w	$4(a3,d4.l),d0
	add.w	$6(a3,d4.l),d0
	move.w	d0,mt_samplelen(a6)
	move.w	$6(a3,d4.l),mt_samplerepl(a6)
	move.w	mt_volume(a6),8(a5)
	bra.s	mt_setregs
mt_noloop:
	move.l	mt_sampleadr(a6),d2
	add.l	d3,d2
	move.l	d2,mt_samplerep(a6)
	move.w	$6(a3,d4.l),mt_samplerepl(a6)
	move.w	mt_volume(a6),8(a5)
mt_setregs:
	move.w	mt_cmdperiod(a6),d0
	and.w	#$fff,d0
	beq	mt_checkcom2
	move.b	mt_cmd(a6),d0
	and.b	#$f,d0
	cmp.b	#$3,d0
	bne.s	mt_setperiod
	bsr	mt_setmyport
	bra	mt_checkcom2
mt_setperiod:
	move.w	mt_cmdperiod(a6),mt_period(a6)
	and.w	#$fff,mt_period(a6)
	move.w	mt_dmabit(a6),$dff096
	clr.b	mt_vibcount(a6)

	move.l	mt_sampleadr(a6),(a5)
	move.w	mt_samplelen(a6),4(a5)
	move.w	mt_period(a6),d0
	and.w	#$fff,d0
	move.w	d0,6(a5)
	move.w	mt_dmabit(a6),d0
	or.w	d0,mt_dmacon(a4)
	bra	mt_checkcom2

mt_setdma:
	lea	$dff000,a5
	moveq	#8,d3				;less than this can cause trouble
	bsr	mt_waitscan
	move.w	mt_dmacon(a4),d0
	or.w	#$8000,d0
	move.w	d0,$96(a5)
	moveq	#1,d3
	bsr	mt_waitscan
*	lea	mt_voice4(pc),a6
*	move.l	mt_samplerep(a6),$d0(a5)
*	move.w	mt_samplerepl(a6),$d4(a5)
	lea	mt_voice3(pc),a6
	move.l	mt_samplerep(a6),$c0(a5)
	move.w	mt_samplerepl(a6),$c4(a5)
	lea	mt_voice2(pc),a6
	move.l	mt_samplerep(a6),$b0(a5)
	move.w	mt_samplerepl(a6),$b4(a5)
	lea	mt_voice1(pc),a6
	move.l	mt_samplerep(a6),$a0(a5)
	move.w	mt_samplerepl(a6),$a4(a5)

	addq.w	#4,mt_pattpos(a4)
	cmp.w	#$100,mt_pattpos(a4)
	bne.s	mt_endr
mt_nex:	clr.w	mt_pattpos(a4)
	clr.b	mt_break(a4)
	addq.b	#1,mt_songpos(a4)
	and.b	#$7f,mt_songpos(a4)
	move.b	mt_songpos(a4),d1
	move.l	mt_data(a4),a0
	cmp.b	$3b6(a0),d1
	bne.s	mt_endr
	clr.b	mt_songpos(a4)
mt_endr:tst.b	mt_break(a4)
	bne.s	mt_nex
mt_playerror:
	movem.l	(SP)+,d0-d5/a0-a6
	rts

mt_waitscan:
	move.b	6(a5),d1
mt_scanloop:
	cmp.b	6(a5),d1
	beq.s	mt_scanloop
	dbf	d3,mt_waitscan
	rts

mt_setmyport:
	move.w	mt_cmdperiod(a6),d2
	and.w	#$fff,d2
	move.w	d2,mt_slidedest(a6)
	move.w	mt_period(a6),d0
	clr.b	mt_slidedir(a6)
	cmp.w	d0,d2
	beq.s	mt_clrport
	bge.s	mt_rt
	move.b	#$1,mt_slidedir(a6)
	rts
mt_clrport:
	clr.w	mt_slidedest(a6)
mt_rt:	rts

mt_myport:
	move.b	mt_cmdpar(a6),d0
	beq.s	mt_myslide
	move.b	d0,mt_slidespeed(a6)
	clr.b	mt_cmdpar(a6)
mt_myslide:
	tst.w	mt_slidedest(a6)
	beq.s	mt_rt
	moveq	#0,d0
	move.b	mt_slidespeed(a6),d0
	tst.b	mt_slidedir(a6)
	bne.s	mt_mysub
	add.w	d0,mt_period(a6)
	move.w	mt_slidedest(a6),d0
	cmp.w	mt_period(a6),d0
	bgt.s	mt_myok
	move.w	mt_slidedest(a6),mt_period(a6)
	clr.w	mt_slidedest(a6)
mt_myok:move.w	mt_period(a6),$6(a5)
	rts
mt_mysub:
	sub.w	d0,mt_period(a6)
	move.w	mt_slidedest(a6),d0
	cmp.w	mt_period(a6),d0
	blt.s	mt_myok
	move.w	mt_slidedest(a6),mt_period(a6)
	clr.w	mt_slidedest(a6)
	move.w	mt_period(a6),$6(a5)
	rts

mt_vib:	move.b	mt_cmdpar(a6),d0
	beq.s	mt_vi
	move.b	d0,mt_vibamp(a6)

mt_vi:	move.b	mt_vibcount(a6),d0
	lea	mt_sin(PC),a0
	lsr.w	#$2,d0
	and.w	#$1f,d0
	moveq	#0,d2
	move.b	(a0,d0.w),d2
	move.b	mt_vibamp(a6),d0
	and.w	#$f,d0
	mulu	d0,d2
	lsr.w	#$6,d2
	move.w	mt_period(a6),d0
	tst.b	mt_vibcount(a6)
	bmi.s	mt_vibmin
	add.w	d2,d0
	bra.s	mt_vib2
mt_vibmin:
	sub.w	d2,d0
mt_vib2:move.w	d0,$6(a5)
	move.b	mt_vibamp(a6),d0
	lsr.w	#$2,d0
	and.w	#$3c,d0
	add.b	d0,mt_vibcount(a6)
	rts

mt_nop:	move.w	mt_period(a6),$6(a5)
	rts

mt_checkcom:
	move.w	mt_cmd(a6),d0
	and.w	#$fff,d0
	beq.s	mt_nop
	move.b	mt_cmd(a6),d0
	and.b	#$f,d0
	tst.b	d0
	beq	mt_arpeggio
	cmp.b	#$1,d0
	beq.s	mt_portup
	cmp.b	#$2,d0
	beq	mt_portdown
	cmp.b	#$3,d0
	beq	mt_myport
	cmp.b	#$4,d0
	beq	mt_vib
	move.w	mt_period(a6),$6(a5)
	cmp.b	#$a,d0
	beq.s	mt_volslide
	rts

mt_volslide:
	moveq	#0,d0
	move.b	mt_cmdpar(a6),d0
	lsr.b	#4,d0
	tst.b	d0
	beq.s	mt_voldown
	add.w	d0,mt_volume(a6)
	cmp.w	#$40,mt_volume(a6)
	bmi.s	mt_vol2
	move.w	#$40,mt_volume(a6)
mt_vol2:move.w	mt_volume(a6),$8(a5)
	rts

mt_voldown:
	moveq	#0,d0
	move.b	mt_cmdpar(a6),d0
	and.b	#$f,d0
	sub.w	d0,mt_volume(a6)
	bpl.s	mt_vol3
	clr.w	mt_volume(a6)
mt_vol3:move.w	mt_volume(a6),$8(a5)
	rts

mt_portup:
	moveq	#0,d0
	move.b	mt_cmdpar(a6),d0
	sub.w	d0,mt_period(a6)
	move.w	mt_period(a6),d0
	and.w	#$fff,d0
	cmp.w	#$71,d0
	bpl.s	mt_por2
	and.w	#$f000,mt_period(a6)
	or.w	#$71,mt_period(a6)
mt_por2:move.w	mt_period(a6),d0
	and.w	#$fff,d0
	move.w	d0,$6(a5)
	rts

mt_portdown:
	clr.w	d0
	move.b	mt_cmdpar(a6),d0
	add.w	d0,mt_period(a6)
	move.w	mt_period(a6),d0
	and.w	#$fff,d0
	cmp.w	#$358,d0
	bmi.s	mt_por3
	and.w	#$f000,mt_period(a6)
	or.w	#$358,mt_period(a6)
mt_por3:move.w	mt_period(a6),d0
	and.w	#$fff,d0
	move.w	d0,$6(a5)
	rts

mt_checkcom2:
	move.b	mt_cmd(a6),d0
	and.b	#$f,d0
	cmp.b	#$e,d0
	beq.s	mt_setfilt
	cmp.b	#$d,d0
	beq.s	mt_pattbreak
	cmp.b	#$b,d0
	beq.s	mt_posjmp
	cmp.b	#$c,d0
	beq.s	mt_setvol
	cmp.b	#$f,d0
	beq.s	mt_setspeed
	rts

mt_setfilt:
	move.b	mt_cmdpar(a6),d0
	and.b	#1,d0
	add.b	d0,d0
	and.b	#$fd,$bfe001
	or.b	d0,$bfe001
	rts
mt_pattbreak:
	st	mt_break(a4)
	rts
mt_posjmp:
	move.b	mt_cmdpar(a6),d0
	subq.b	#1,d0
	move.b	d0,mt_songpos(a4)
	st	mt_break(a4)
	rts
mt_setvol:
	cmp.b	#$40,mt_cmdpar(a6)
	ble.s	mt_vol4
	move.b	#$40,mt_cmdpar(a6)
mt_vol4:move.b	mt_cmdpar(a6),$8(a5)
	rts
mt_setspeed:
	move.b	mt_cmdpar(a6),d0
	and.w	#$ff,d0
	beq.s	mt_rts2
	move.b	d0,d1
	and.b	#$f0,d1
	beq.s	mt_speed1
	lsr.b	#4,d1
	bra.s	mt_speed3
mt_speed1:
	move.b	d0,d1
mt_speed3:
	and.b	#$f,d0
	bne.s	mt_speed2
	move.b	d1,d0
mt_speed2:
	move.b	d0,mt_speedEven(a4)
	move.b	d1,mt_speedOdd(a4)
	clr.b	mt_counter(a4)
mt_rts2:rts

mt_sin:
	dc.b $00,$18,$31,$4a,$61,$78,$8d,$a1,$b4,$c5,$d4,$e0,$eb,$f4,$fa,$fd
	dc.b $ff,$fd,$fa,$f4,$eb,$e0,$d4,$c5,$b4,$a1,$8d,$78,$61,$4a,$31,$18

mt_periods:
	dc.w $0358,$0328,$02fa,$02d0,$02a6,$0280,$025c,$023a,$021a,$01fc,$01e0
	dc.w $01c5,$01ac,$0194,$017d,$0168,$0153,$0140,$012e,$011d,$010d,$00fe
	dc.w $00f0,$00e2,$00d6,$00ca,$00be,$00b4,$00aa,$00a0,$0097,$008f,$0087
	dc.w $007f,$0078,$0071,$0000,$0000

mt_playerdata:	dcb.b	mt_datalen,0
mt_samplestarts:dcb.l	31,0
mt_voice1:	dcb.b	mt_voicelen,0
mt_voice2:	dcb.b	mt_voicelen,0
mt_voice3:	dcb.b	mt_voicelen,0
mt_voice4:	dcb.b	mt_voicelen,0

