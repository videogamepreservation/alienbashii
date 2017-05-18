*------------------------------------------------------------------------*					
*- This is a bit misleading - never got round to putting any in 	-*
*------------------------------------------------------------------------*
ON	equ	1
OFF	equ	0

IN_GAME_MUSIC_BUFFER	EQU 100*1024
* routines for AGA enhanements

***********************************************
** AGA ENHANCEMENTS                          **
***********************************************
AGA_Enhancements

	clr.w	chip_type
	move.l	exec,a0
	btst.b	#1,AttnFlags+1(a0)
	beq.s	chip_68000
	move.w	#SOUND_WAIT_1200,sound_wait
	move.w	#1,chip_type
	bra.s	continue_set_up
chip_68000	
	move.w	#SOUND_WAIT_500,sound_wait
	move.l	#Rain_Script500,Level2_Rain_Script
	move.l	#SnowStorm500,Level5_Snow_Script
	move.l	#ThunderStorm500,Level7_Activate_Table
	move.l	#ThunderStormRepeat500,Lightning1_500
	move.l	#ThunderStormRepeat500,Lightning2_500
	move.l	#ThunderStormRepeat500,Lightning3_500	
	
continue_set_up

	tst	chip_type
	bne.s	aga_only
	move.w	#OFF,music_option
	move.w	#OFF,xtra_music
	rts
aga_only
	move.l	EXEC,a6
	move.l	#IN_GAME_MUSIC_BUFFER,d0	
	move.l	#MEM_CHIP+MEM_CLEAR,d1	;chip and clear
	jsr	-198(a6)		;try
	tst.l	d0
	bne	allocated_music_mem
	rts			;otherwise quit
allocated_music_mem
	move.l	d0,in_game_music
	move.w	#ON,music_option	
	move.w	#ON,xtra_music
	rts



music_option
	dc.w	ON	
xtra_music
	dc.w	OFF	

in_game_music
	dc.l	0
		