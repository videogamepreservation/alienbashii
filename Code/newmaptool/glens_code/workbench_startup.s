
* WB Startup code

startup:	movem.l	d0/a0,-(sp)
		suba.l	a1,a1
		move.l  4.w,a6
		jsr	_LVOFindTask(a6)
		move.l	d0,a4
		tst.l	pr_CLI(a4)	; was it called from CLI?
		bne.s   fromCLI		; if so, skip out this bit...

		lea	pr_MsgPort(a4),a0
		jsr	_LVOWaitPort(A6)
		lea	pr_MsgPort(a4),a0
		jsr	_LVOGetMsg(A6)
		move.l	d0,returnMsg

fromCLI		movem.l	(sp)+,d0/a0
		bsr	_main
		tst.l	returnMsg		; Is there a message?
		beq.s	exitToDOS		; if not, skip...

		move.l	4.w,a6
	        jsr	_LVOForbid(a6)          ; note! No Permit needed!
		move.l	returnMsg(pc),a1
		jsr	_LVOReplyMsg(a6)
exitToDOS:	moveq	#0,d0
		rts

returnMsg:	dc.l	0

