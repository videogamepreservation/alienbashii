
INT_to_FFP		equ	-36
FFP_to_INT		equ	-30
SQRT		equ	-96


square_root
	movem.l	d1/a6,-(sp)
*send value in d0
	move.l	math_handle,a6
	jsr	INT_to_FFP(a6)
*d0 now contains FFP
	move.l	mathtrans_handle,a6
	jsr	SQRT(a6)
*do now containts sqrt root in ffp
	move.l	math_handle,a6
	jsr	FFP_to_INT(a6)
*d0 now contains answer	
	movem.l	(sp)+,d1/a6
	rts

open_math_lib
	move.l exec,a6
	move.l #math_name,a1
	jsr openlibrary(a6)
	move.l d0,math_handle
	tst.l	d0
	beq.s	quit_open_math	
	move.l exec,a6
	move.l #mathtrans_name,a1
	jsr openlibrary(a6)
	move.l d0,mathtrans_handle
quit_open_math		
	rts	
	
math_handle dc.l 0
mathtrans_handle dc.l 0
	
math_name dc.b "mathffp.library",0
	even 	
	
mathtrans_name dc.b "mathtrans.library",0
	even 		
	

