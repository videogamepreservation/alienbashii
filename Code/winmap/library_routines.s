
OPEN_LIBRARY	EQU	-408
CLOSE_LIBRARY	EQU	-414
EXEC		EQU	4
*Library routines



*****************************************
******         OPEN LIBRARYS         ****
*****************************************
open_librarys

	moveq	#0,d0
	
	bsr	open_intuition_library
	tst.l	d0
	beq.s	error_and_exit
	
	bsr	open_dos_library
	tst.l	d0
	beq.s	error_and_exit


error_and_exit
	moveq	#-1,d0
	rts
exit_without_error
	rts
	
*****************************************
******        CLOSE LIBRARYS         ****
*****************************************
close_librarys

	bsr	close_intuition_library
	bsr	close_dos_library


	rts
	
	
*****************************************
******    OPEN INTUITION LIBRARY     ****
*****************************************
open_intuition_library

	move.l	EXEC,a6			
	moveq	#0,d0	;library version
	lea	intuition_library_name,a1
	jsr	OPEN_LIBRARY(A6)
	move.l	d0,intuition_library

	rts

*****************************************
******    OPEN DOS       LIBRARY     ****
*****************************************
open_dos_library

	move.l	EXEC,a6			
	lea	dos_library_name,a1
	moveq	#0,d0	;library version
	jsr	OPEN_LIBRARY(A6)
	move.l	d0,dos_library

	rts
	
	
*****************************************
******    CLOSE DOS   LIBRARY        ****
*****************************************
close_dos_library

	tst.l	dos_library
	beq.s	cant_close_dos_library
	move.l	EXEC,a6
	move.l	dos_library,a1
	jsr	CLOSE_LIBRARY(a6)
cant_close_dos_library
	
	rts	
	
	
*****************************************
******    CLOSE INTUITION LIBRARY    ****
*****************************************
close_intuition_library

	tst.l	intuition_library
	beq.s	cant_close_intuition_library
	move.l	EXEC,a6
	move.l	intuition_library,a1
	jsr	CLOSE_LIBRARY(a6)
cant_close_intuition_library
	
	rts	

	
*library names

intuition_library_name
	dc.b	"intuition.library",0
	EVEN
		
dos_library_name
	dc.b	"dos.library",0
	EVEN
	
	
	
*library pointers

intuition_library		
	dc.l	0
dos_library
	dc.l	0	