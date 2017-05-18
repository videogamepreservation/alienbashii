	SECTION	maptool,Code_c
	opt	c-
	incdir  "dh1:devpac/include/"

	include	"dh1:game/winmap/system.i"


************************************************
****            ENTRY IN THE CODE           ****
************************************************

entry_point

	movem.l	d0-d7/a0-a6,-(sp)
	bsr	open_librarys
	tst.l	d0
	beq.s	exit_system
	
exit_system
	bsr	close_librarys
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
	
	
	include	"library_routines.s"