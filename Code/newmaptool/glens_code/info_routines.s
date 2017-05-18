
**************************************
**** DISPLAY INFO WINDOW          ****
**************************************

display_info_window
	move.l	#info_window,a0
	bsr	create_window

	move.l	#quit_info_button,a0
	jsr	display_button

	move.l	#info_window,a0	
	move.l	#info_text,a1
	move.w	#5,d0
	move.w	#3,d1
	move.w	#1,d2
	move.w	#1,d3
	bsr	write_text
	rts

**************************************
**** REMOVE INFO WINDOW           ****
**************************************

remove_info_window
	move.l	#quit_info_button,a0
	jsr	remove_button
	bsr	destroy_window
	rts


*********************************
*** DISPLAY  ERROR           ****
*********************************
Display_Error
	bsr	set_original_colours	
	move.l	#error_window,a0
	bsr	create_window

	move.l	#ok_button,a0
	jsr	display_button

	movem.l	a6,-(sp)
	move.l	dosbase,a6
	jsr	-132(a6)
	movem.l	(sp)+,a6

	bsr	get_error_message

	move.l	#error_window,a0
	moveq	#10,d0
	moveq	#10,d1
	moveq	#2,d2
	bsr	write_text	
	rts

*********************************
*** ERROR ROUTINE            ****
*********************************
Error_Routine
*send error in d0
	move.l	d0,-(sp)		
	bsr	set_original_colours
	move.l	#error_window,a0
	bsr	create_window

	move.l	#ok_button,a0
	jsr	display_button
	move.l	(sp)+,d0

	bsr	get_error_message

	move.l	#error_window,a0
	moveq	#20,d0
	moveq	#10,d1
	moveq	#2,d2
	bsr	write_text
	rts

*********************************
*** GET ERROR MESSAGE        ****
*********************************
Get_Error_Message
*returns pointer to string in a1
*error numin d0
	
	move.l	#error_list,a0
error_search
	cmp.w #-1,(a0)
	beq.s	no_error_found
	cmp.w	(a0),d0
	bne.s	not_the_error
	move.l	2(a0),a1
	rts
not_the_error
	addq.l	#6,a0
	bra.s	error_search
no_error_found
	move.l	#no_error,a1
	rts

*********************************
*** REMOVE ERROR WINDOW      ****
*********************************
Remove_Error_Window
	move.l	#ok_button,a0
	jsr	remove_button
	bsr	destroy_window	
	bsr	set_current_page_colours
	rts


error_list
	dc.w 103
	dc.l e1
	dc.w 204
	dc.l e2
	dc.w 205
	dc.l e3 
	dc.w 210
	dc.l e4
	dc.w 211
	dc.l e5
	dc.w 213
	dc.l e6
	dc.w 214
	dc.l e7
	dc.w 221
	dc.l e8
	dc.w 225
	dc.l e9
	dc.w 226
	dc.l e10
	dc.w	1000
	dc.l	e11
	dc.w	1001
	dc.l	e12
	dc.w	1002
	dc.l	e13
	dc.w	2000
	dc.l	e14
	dc.w	3000
	dc.l	e15
	dc.w	4000
	dc.l	e16
	dc.w	5000
	dc.l	e17
	dc.w	5001
	dc.l	e18
	dc.w -1

e1
	dc.b "INSUFFICIENT FREE STORE.",0
	EVEN
e2
	dc.b "DIRECTORY NOT FOUND.",0
	EVEN
e3
	dc.b "OBJECT NOT FOUND.",0
	EVEN
e4
	dc.b "INVALID STREAM COMPONENT NAME.",0
	EVEN
e5
	dc.b "INVALID OBJECT LOCK.",0
	EVEN
e6
	dc.b "DISK NOT VALIDATED.",0
	EVEN
e7
	dc.b "DISK WRITE PROTECTED.",0
	EVEN
e8
	dc.b "DISK FULL.",0
	EVEN
e9
	dc.b "NOT A DOS DISK.",0
	EVEN
e10
	dc.b "NO DISK IN DRIVE.",0
	EVEN
e11
	dc.b	"NOT AN IFF FILE.",0
	EVEN

e12
	dc.b	"CANNOT ALLOCATE FILE MEM.",0
	EVEN
e13
	dc.b	"CANNOT ALLOCATE PIC MEM.",0
	EVEN

e14
	dc.b	"SCANNER NOT CONNECTED!",0
	EVEN
e15
	dc.b    "NOT A MUSIC DATA FILE!",0
	EVEN
	
e16
	dc.b	"NOT AN EDITOR MAP FILE!",0
	EVEN	
e17
	dc.b	"NOT A EDITOR BUFFER FILE!",0
	EVEN
e18
	dc.b	"DATA SIZE INCOMPATIBLE ",0
	EVEN		
		

no_error
	dc.b "NOT A VALID ERROR.",0
	EVEN


*********WINDOW SETUPS


error_window
	dc.w 320
	dc.w 44+32
	dc.w 0
	dc.w 80
	dc.l 0
	dc.l 0
	dc.b "ERROR",0
	
	EVEN

ok_button
	dc.w	BUTTON_2-16
	dc.w	THIRD_ROW
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	remove_error_window
	dc.b	"OK",0		
	EVEN						


info_window
	dc.w 200
	dc.w 180
	dc.w 60
	dc.w 10
	dc.l 0
	dc.l 0
	dc.b "INFO",0
	EVEN

quit_info_button
	dc.w	55
	dc.w	140
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_info_window
	dc.b	0		
	even

info_text
;	dc.b $a,$a,-2,8
;	dc.b " Glen Cumming's",$a
;	dc.b "   Map Editor  ",$a,-2,9
;	dc.b "               ",$a,-2,10
;	dc.b "  Internal use ",$a,-2,11
;	dc.b "     only.     ",$a,$a,-2,9
;	dc.b "     v1.0      ",$a
;	dc.b "               ",$a,-2,10
;	dc.b "   (c) 1992    ",0

	dc.b $a,$a,-2,8
	dc.b "Game Map-Editor v1.01",$a
	dc.b "                     ",$a,-2,9
	dc.b "   Main Programming  ",$a,-2,10
	dc.b "     Glen Cumming    ",$a,-2,11
	dc.b "                     ",$a,-2,9
	dc.b "   Additional Code   ",$a
	dc.b "    Trevor Mensah    ",$a,$a,-2,10

	dc.b "    (c) 1992-1996    ",0
	EVEN
