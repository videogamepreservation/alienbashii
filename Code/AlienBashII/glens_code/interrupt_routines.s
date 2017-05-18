************************************************************
****       D A R K  L I T E   I N T E R R U P T         ****
************************************************************

darkint

	movem.l	d0-d7/a0-a6,-(sp)
	move.b	$dff014,d2
	move.b	d2,resistance+1
	move.w  #$0001,$dff034
	tst.w	music_flag
	beq.s	dont_play_music
	jsr	mt_music
dont_play_music	
	movem.l	(sp)+,d0-d7/a0-a6

	dc.w	$4ef9
oldint dc.l	0	

music_flag	dc.w	0
