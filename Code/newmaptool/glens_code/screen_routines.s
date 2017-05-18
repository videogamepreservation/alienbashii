*****************************************************************
* MODULE TITLE     :screen_routines                             *
*                                                               *
* DESCRIPTION      :memory allocation and deallocation, basic   *
*                   screen handling                             *
*                                                               *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :setup_screen_memory                         *
*                   deallocate_screen_memory                    *
*                   clear_screen                                *
*                                                               *
*                                                               *
*****************************************************************

***********************SCREEN ROUTINES*********************


***********************************************
*****	SETUP SCREEN MEMORY              *****
***********************************************

setup_screen_memory
*send MAINSCREEN struct in a0
*allocates memory
	move.l	a6,-(sp)
	move.l	EXEC,a6			; exec
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	asr.l	#3,d0
	mulu	screen_y_size(a0),d0
	mulu	number_of_planes(a0),d0	
	move.l	#MEM_CHIP+MEM_CLEAR,d1	        	; chip and clear
	move.l	a0,-(sp)
	jsr	-198(a6)	        		; try
	move.l	(sp)+,a0
	move.l	(sp)+,a6
	tst.l	d0
	bne.s	grabbed_mem
	rts
grabbed_mem
	move.l	d0,screen_mem(a0)	
	rts
	
	
***********************************************
*****	DEALLOCATE SCREEN MEMORY         *****
***********************************************

deallocate_screen_memory
*send MAINSCREEN struct in a0
*deallocates memory

	move.l	a6,-(sp)
	move.l	EXEC,a6			; exec
	moveq	#0,d0
	move.w	screen_x_size(a0),d0
	asr.l	#3,d0
	mulu	screen_y_size(a0),d0
	mulu	number_of_planes(a0),d0	
	move.l	screen_mem(a0),a1
	jsr	-210(a6)	        		; try
	move.l	(sp)+,a6
	rts
	

***********************************************
*****	CLEAR SCREEN                      *****
***********************************************
clear_screen
	ifnd	hard_only
	bsr	own_the_blitter
	endc

	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a1
	move.w	number_of_planes(a0),d0
	subq.w	#1,d0
	move.w	screen_y_size(a0),d1
	asl.w	#6,d1
	move.w	screen_x_size(a0),d2
	asr.w	#3,d2
	move.w	d2,d3
	asr.w	#1,d2
	add.w	d2,d1
	mulu	screen_y_size(a0),d3
clear_the_screen	
	btst	#14,DMACONR(a6)
	bne.s	clear_the_screen
	move.w	#0,bltadat(a6)
	move.l	a1,bltdpt(a6)
	clr.w	bltdmod(a6)
	move.w	#$01f0,bltcon0(a6)
	clr.w	bltcon1(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	d1,bltsize(a6)
	add.l	d3,a1
	dbra	d0,clear_the_screen

wait_clear_the_screen	
	btst	#14,DMACONR(a6)
	bne.s	wait_clear_the_screen
	ifnd	hard_only
	bsr	disown_the_blitter
	endc

	rts

	
	
	rsreset

screen_x_size     rs.w 1
screen_y_size     rs.w 1
screen_x_pos      rs.w 1 ;for future
screen_y_pos	  rs.w 1 ;for future
screen_mem        rs.l 1
number_of_planes  rs.w 1
screen_palette    rs.l 1
