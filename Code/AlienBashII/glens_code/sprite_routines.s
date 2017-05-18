SCANNER_X	EQU	16
SCANNER_Y	EQU	185
SCANNER_HEIGHT	EQU	46

PAUSE_X		EQU	139
PAUSE_Y		EQU	115
PAUSE_HEIGHT	EQU	9

***************************************
*****  SETUP SCANNER              *****
***************************************
Setup_Scanner

	move.w	#SCANNER_X,d0
	move.w	#SCANNER_Y,d1
	move.w	#SCANNER_HEIGHT,d2
	move.l	#scanner1,a0
	movem.l	d0-d2,-(sp)
	bsr	Position_Any_Sprite		
	movem.l	(sp)+,d0-d2
	add.w	#16,d0
	
	move.l	#scanner2,a0
	movem.l	d0-d2,-(sp)
	bsr	Position_Any_Sprite		
	movem.l	(sp)+,d0-d2
	add.w	#16,d0

	rts

***************************************
*****  DISPLAY SCANNER            *****
***************************************
Display_Scanner

	move.l	#scanner1,d0
	move.w	d0,sprite4l
	swap	d0
	move.w	d0,sprite4h
	
	move.l	#scanner2,d0
	move.w	d0,sprite5l
	swap	d0
	move.w	d0,sprite5h
	
	move.l	#blank_data,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	
	move.l	#blank_data,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h

	
	rts

***************************************
*****  REMOVE  SCANNER            *****
***************************************
Remove_Scanner

	move.l	#blank_data,d0
	move.w	d0,sprite4l
	swap	d0
	move.w	d0,sprite4h
	
	move.l	#blank_data,d0
	move.w	d0,sprite5l
	swap	d0
	move.w	d0,sprite5h
		
	move.l	#blank_data,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	
	move.l	#blank_data,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h

	rts

blank_sprite
	ds.w	6

***************************************
*****  POSITION ANY SPRITE        *****
***************************************
Position_Any_Sprite
*send in data in a0
*x in d0
*y in d1
*height in d2

	add.w	#$81-1,d0	;tricky positioning
	move.b	#0,3(A0)
	asr.w	d0
	bcc.s	genno_bit_set
	bset	#0,3(a0)
genno_bit_set
	move.b	d0,1(a0)
	
	add.w	#$2c,d1
	btst	#8,d1
	beq.s	gennot_vert_set
	bset	#2,3(a0)
gennot_vert_set
	move.b	d1,(a0)	
	add.w	d2,d1
	btst	#8,d1
	beq.s	gennot_vstop_set
	bset	#1,3(a0)
gennot_vstop_set
	move.b	d1,2(a0)

	rts

*****************************************
***       Display_Pause  	    *****
*****************************************
Display_Pause

	move.w	#PAUSE_X,d0
	move.w	#PAUSE_Y,d1
	move.w	#PAUSE_HEIGHT,d2
	move.l	#pause1,a0
	movem.l	d0-d2,-(sp)
	bsr	Position_Any_Sprite		
	movem.l	(sp)+,d0-d2
	add.w	#16,d0
	
	move.l	#pause2,a0
	movem.l	d0-d2,-(sp)
	bsr	Position_Any_Sprite		
	movem.l	(sp)+,d0-d2
	add.w	#16,d0
	
	move.l	#pause3,a0
	movem.l	d0-d2,-(sp)
	bsr	Position_Any_Sprite		
	movem.l	(sp)+,d0-d2

	move.l	#pause1,d0
	move.w	d0,sprite0l
	swap	d0
	move.w	d0,sprite0h
	
	move.l	#pause2,d0
	move.w	d0,sprite1l
	swap	d0
	move.w	d0,sprite1h

	move.l	#pause3,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	
	move.l	#Blank_Data,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h


	rts

***************************************
*****  SET UP TEXT SPRITE COLS    *****
***************************************
Set_Up_Text_Sprite_Cols

	move.w	#$1A0,d0
	move.w	#8-1,d1
	move.l	#sprite_cols,a0
	move.l	#text_cols,a1
sp_text_col_loop
	move.w	d0,(a0)+
	move.w	(a1)+,(a0)+
	add.w	#$2,d0
	dbra	d1,sp_text_col_loop
	rts

text_cols
	dc.w	0,$b11,0,$f00
	dc.w	0,$b11,0,$f00
	
	
***************************************
*****  REMOVE  SPRITE TEXT        *****
***************************************
Remove_Sprite_Text

	move.l	#blank_sprite,d0
	move.w	d0,sprite0l
	swap	d0
	move.w	d0,sprite0h
	
	move.l	#blank_sprite,d0
	move.w	d0,sprite1l
	swap	d0
	move.w	d0,sprite1h
		
	move.l	#blank_sprite,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	
	rts

***************************************
*****   FLASH  PAUSE             ******
***************************************
Flash_Pause

	subq.w	#1,pause_wait_count
	bgt.s	dont_change_flag
	move.w	#PAUSE_WAIT,pause_wait_count
	bchg.b	#0,pause_flag
	beq.s	display_the_pause
	bsr	Remove_Sprite_Text
	bra.s	dont_change_flag
display_the_pause
	bsr	Display_Pause	
dont_change_flag
	rts	
	

	rts
PAUSE_WAIT	EQU	15

pause_wait_count
	dc.w	PAUSE_WAIT
pause_flag
	dc.w	0
	even	
