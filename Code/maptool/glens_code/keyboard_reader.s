KEY_SHIFT1	EQU	30
KEY_SHIFT2	EQU	31

KEY_RETURN	EQU	59-63
KEY_DELETE	EQU	62-63
CURSOR_UP	EQU	51-63
CURSOR_DOWN	EQU	50-63
CURSOR_LEFT	EQU	48-63
CURSOR_RIGHT	EQU	49-63
F1_KEY		EQU	47-63
F2_KEY		EQU	46-63
F3_KEY		EQU	45-63
F4_KEY		EQU	44-63
F5_KEY		EQU	43-63
F6_KEY		EQU	42-63
F7_KEY		EQU	41-63
F8_KEY		EQU	40-63

************************************************
** KEYBOARD READING ROUTINE                   **
************************************************
Read_Keyboard
	clr.l	d0
	move.b	$bfec01,d0
	ror.b	d0
	btst.l	#7,d0
	beq.s	Key_Not_Pressed
	andi.b	#$7f,d0
	tst.w	Key_Status
	beq.s	User_Key_Pressed
	cmp.w	Last_Key,d0
	bne.s	User_Key_Pressed
	moveq.l	#0,d0
	rts
Key_Not_Pressed
	cmp.w	#KEY_SHIFT1,d0
	beq.s	Shift_Released
	cmp.w	#KEY_SHIFT2,d0
	bne.s	Not_Shift_Released
Shift_Released
	clr.w	Shift_Down		
Not_Shift_Released	
	clr.w	Key_Status	
	moveq.l	#0,d0
	rts
User_Key_Pressed
	cmp.w	#KEY_SHIFT1,d0
	beq.s	Shift_Pressed
	cmp.w	#KEY_SHIFT2,d0
	bne.s	Not_Shift_Pressed
Shift_Pressed	
	move.w	#1,Shift_Down
	clr.l	d0
	rts
Not_Shift_Pressed	
	move.w	d0,Last_Key
	move.w	#1,Key_Status	;key has been pressed	
	
*convert Key code
	cmp.w	#126,d0
	bgt.s	Not_Char_Key
key_in_range	
	sub.w	#63,d0	;start from 0	
	blt.s	Not_Char_Key
	tst.w	Shift_Down
	beq.s	Choose_Shift_Up_Chars
	move.l	#Chars_With_Shift,a0
	bra.s	Get_Key_Char
Choose_Shift_Up_Chars
	move.l	#Chars_No_Shift,a0	
Get_Key_Char	
	move.b	(a0,d0),d0
	rts
Not_Char_Key		
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
	dc.b	"q  \=-0987654321"	;111-126		
	
Chars_With_Shift
	dc.b	"      ?><MNBVCXZ"
	dc.b    "       :LKJHGFDS"
	dc.b	"A      POIUYTREW"
	dc.b	"Q  |+_)(*&^%$#@!"	