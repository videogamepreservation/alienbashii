	section Bashii,CODE
	OPT C-,D+	
	opt NODEBUG
	opt p=68000 		

	incdir	"code:AlienBashII"
	include	"glens_code/equates.s"
	include "glens_code/game_equates.s"	

************************************************
** KEYBOARD READING ROUTINE                   **
************************************************
Read_Keyboard
	clr.l	d7
	move.b	$bfec01,d7
	ror.b	d7
	btst.l	#7,d7
	beq.s	No_Key_Pressed
	andi.b	#$7f,d7
	tst.w	Key_Status
	beq.s	User_Key_Pressed
	cmp.w	Last_Key,d7
	bne.s	User_Key_Pressed
	moveq.l	#0,d7
	rts
No_Key_Pressed
	cmp.w	#KEY_SHIFT1,d7
	beq.s	Shift_Released
	cmp.w	#KEY_SHIFT2,d7
	bne.s	Not_Shift_Released
Shift_Released
	clr.w	Shift_Down		
Not_Shift_Released	
	clr.w	Key_Status	
	moveq.l	#0,d7
	rts
User_Key_Pressed
	cmp.w	#KEY_SHIFT1,d7
	beq.s	Shift_Pressed
	cmp.w	#KEY_SHIFT2,d7
	bne.s	Not_Shift_Pressed
Shift_Pressed	
	move.w	#1,Shift_Down
	clr.l	d7
	rts
Not_Shift_Pressed	
	move.w	d7,Last_Key
	move.w	#1,Key_Status	;key has been pressed	
	
*convert Key code
	cmp.w	#126,d7
	bgt.s	Not_Char_Key
key_in_range	
	sub.w	#63,d7	;start from 0	
	blt.s	Not_Char_Key
	tst.w	Shift_Down
	beq.s	Choose_Shift_Up_Chars
	move.l	#Chars_With_Shift,a0
	bra.s	Get_Key_Char
Choose_Shift_Up_Chars
	move.l	#Chars_No_Shift,a0	
Get_Key_Char	
	move.b	(a0,d7),d7
	rts
Not_Char_Key		
	cmp.w	#KEY_RETURN,d7
	beq.s	valid_code
	cmp.w	#KEY_DELETE,d7
	beq.s	valid_code
	clr.w	d7
valid_code	
	rts
	
Shift_Down
	dc.w	0
Key_Status
	dc.w	0	
Last_Key
	dc.w	0
	
	
Chars_No_Shift
	dc.b	"      /.,mnbvcxz"	;63-78
	dc.b	"      ';lkjhgfds"	;79-94
	dc.b	"a      poiuytrew"	;95-110
	dc.b	"q  \+-0987654321"	;111-126		
	
Chars_With_Shift
	dc.b	"      ?><MNBVCXZ"
	dc.b    "       :LKJHGFDS"
	dc.b	"A      POIUYTREW"
	dc.b	"Q  |+_)(*&^%$#@!"	
	
	xdef	Read_Keyboard