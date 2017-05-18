Clear_scroll_Planes
	move.l	Plane1,a0
	move.l	buffered_Plane1,a1
	move.w	#((BYTES_PER_ROW*SCROLL_HEIGHT*BACKPLANES)/4)-1,d0
clear_memory_loop
	clr.l	(a0)+
	clr.l	(a1)+
	dbra	d0,clear_memory_loop
	rts		
	
Selection_setup

	*bsr	clear_scroll_planes	
	*move.l	Buffered_Plane1,d0
	*move.w	d0,SELECTPLANE1LOW
	*swap	d0
	*move.w	d0,SELECTPLANE1HIGH
	*move.l	Buffered_Plane2,d0
	*move.w	d0,SELECTPLANE2LOW
	*swap	d0
	*move.w	d0,SELECTPLANE2HIGH

	move.l	#Level_Select_Graphics,d0
	move.w	d0,SELECTPLANE1LOW
	swap.w	d0
	move.w	d0,SELECTPLANE1HIGH
	move.l	#Level_Select_Graphics+40*256,d0
	move.w	d0,SELECTPLANE2LOW
	swap.w	d0
	move.w	d0,SELECTPLANE2HIGH
	move.l	#Level_Select_Graphics+40*256*2,d0
	move.w	d0,SELECTPLANE3LOW
	swap.w	d0
	move.w	d0,SELECTPLANE3HIGH
	move.l	#Level_Select_Graphics+40*256*3,d0
	move.w	d0,SELECTPLANE4LOW
	swap.w	d0
	move.w	d0,SELECTPLANE4HIGH

	move.l	#blank_sprite,d0
	
	swap	d0
	
	move.w	d0,blank_sprites+2
	move.w	d0,blank_sprites+10
	move.w	d0,blank_sprites+18
	move.w	d0,blank_sprites+26
	move.w	d0,blank_sprites+34
	move.w	d0,blank_sprites+42
	move.w	d0,blank_sprites+50

	swap	d0
	
	move.w	d0,blank_sprites+6
	move.w	d0,blank_sprites+14
	move.w	d0,blank_sprites+22
	move.w	d0,blank_sprites+30
	move.w	d0,blank_sprites+38
	move.w	d0,blank_sprites+46
	move.w	d0,blank_sprites+54

	move.l	#level_dpaint_cols,a2
	move.l	#level_select_colours_high,a0
	move.l	#level_select_colours_low,a1
	bsr	set_colour_map
	
	move.l	#level_select_copper_list,cop1lc(a6)
	clr.w	copjmp1(a6)

	move.l	#Player1_Selection_Boxes,a0
	move.l	#Player1_Select_Struct,a1
	*bsr	draw_player_box
	move.w	#0,current_pass_count

	move.l	buffered_plane1,a0
	add.l	#70*BYTES_PER_ROW+2,a0
	move.l	#password_entry_text,a5
	*jsr	write_string

	move.l	buffered_plane1,a0
	add.l	#86*BYTES_PER_ROW+2,a0
	move.l	#password_entry_text+psel,a5
	*jsr	write_string

	move.l	buffered_plane1,a0
	add.l	#102*BYTES_PER_ROW+2,a0
	move.l	#password_entry_text+psel*2,a5
	*jsr	write_string

	move.l	buffered_plane1,a0
	add.l	#118*BYTES_PER_ROW+2,a0
	move.l	#password_entry_text+psel*3,a5
	*jsr	write_string

	rts
	
Create_Password
	move.l	#Password_Data,a1
	move.l	#Password_Text,a5
	move.w	#PASSWORD_BYTES-1,d7
calc_password

	move.w	#2-1,d6
	move.b	(a1)+,d0
dig_loop
	move.b	d0,d1
	andi.b	#$f,d1
	cmp.b	#10,d1
	bge.s	not_digit
	add.b	#'0',d1
	bra.s	digit_alright
not_digit
	add.b	#'A'-10,d1
digit_alright	

	move.b	d1,(a5)+
	asr.w	#4,d0
	dbra	d6,dig_loop
	
			
	dbra	d7,calc_password
	rts
		
	
move_stage_player
	bsr	rawreadjoy
	btst	#P1_Fire,d0		; ignore fire button
	beq.s	no_enter_level
	move.w	#-1,d0
	bra	no_exit_selected
	
no_enter_level
	btst	#P1_Up,d0
	beq.s	tryotherexits1
	move.w	#north,d7
	bra.s	check_path_of_exit
tryotherexits1	
	btst	#P1_Right,d0
	beq.s	tryotherexits2
	move.w	#east,d7
	bra.s	check_path_of_exit
tryotherexits2
	btst	#P1_down,d0
	beq.s	tryotherexits3
	move.w	#south,d7
	bra.s	check_path_of_exit
tryotherexits3
	btst	#P1_Left,d0
	beq.s	tryotherexits4
	move.w	#west,d7
	bra.s	check_path_of_exit	
tryotherexits4	

	bra	no_exit_selected

check_path_of_exit	
	move.w	player_at_stage,d6
	subq.w	#1,d6
	lsl.w	#3,d6			; *8 (4 possible exits per stage)
	add.w	d6,d7			; actual exit to test

	move.l	#Stage_Exits,a1
	move.w	(a1,d7.w),d0		; get path to travel on
	tst.w	d0
	beq.s	no_exit_this_way
	
; now check path_flag

	move.l	#Path_Flags,a1
	move.w	d0,d6
	subq.w	#1,d6			; 1 less for bits
	move.w	d6,d7
	asr.w	#5,d6			; divide by 32 (bits per longword)
	andi.w	#%11111,d7		; lower 5 bits 0-31 level
	move.w	#31,d5			; for the old swap round
	sub.w	d7,d5			; get right representation
		
	move.l	(a1,d6.w*8),d7
	btst.l	d5,d7			; check path flag
	beq.s	path_not_drawn_yet

	
; select stage to move to via path

	move.w	player_at_stage,d5	; 'from' stage
	
	move.l	#Stage_Paths,a1
	move.w	d0,d7
	sub.w	#1,d7			; less one for memory
	move.w	(a1,d7.w*4),d6		; get path from
	cmp.w	player_at_stage,d6	; are we at this number already
	bne.s	ok_we_want_this_stage   ; no ok moving back to it
	
	move.w	2(a1,d7.w*4),d6		; else must be other stage
				
ok_we_want_this_stage
	move.w	d6,player_at_stage	; set new stage


; get walk from/to positions

	move.l	#Stage_Paths,a2
	move.l	#Stage_positions,a3
	
	subq.w	#1,d5			; they start at one you know
	subq.w	#1,d6
	
	move.w	(a3,d5.w*4),d0		; get from x co-ord	
	move.w	2(a3,d5.w*4),d1		; get from y co-ord	

	move.w	(a3,d6.w*4),d2		; get to x co-ord	
	move.w	2(a3,d6.w*4),d3		; get to y co-ord	

	bsr	calc_walk_parameters
			
path_not_drawn_yet
no_exit_this_way		
no_exit_selected
	rts

Position_Stage_Player
	move.w	Player_at_Stage,d7
	subq.w	#1,d7
	move.l	#Stage_Positions,a1	

	move.w	(a1,d7.w*4),d0		; get x 	
	move.w	2(a1,d7.w*4),d1		; get y 
		
	*sub.w	#7,d0			; centre
	*sub.w	#7,d1			; centre

	move.w	d0,sprite_x
	move.w	d1,sprite_y
		
	rts
	
draw_paths
	move.l	#path_flags,a1		; whether a path has been allowed
	move.l	#stage_paths,a2		; which two stages the path connects
	move.l	#stage_positions,a3	; position of the stages
	move.w	#NUM_PATHS-1,d7
path_loop
	move.w	d7,d6
	move.w	d7,d4
	asr.w	#5,d6			; divide by 32 (bits per longword)
	andi.w	#%11111,d4		; lower 5 bits 0-31 level
	move.w	#31,d5			; for the old swap round
	sub.w	d4,d5			; get right representation
		
	move.l	(a1,d6.w*8),d4
	btst.l	d5,d4			; check path flag

	beq.s	no_link_for_this_path

	move.w	(a2,d7.w*4),d5		; get 'from' stage number
	move.w	2(a2,d7.w*4),d6		; get 'to' stage number

	subq.w	#1,d5			; they start at one you know
	subq.w	#1,d6
	
	move.w	(a3,d5.w*4),d0		; get from x co-ord	
	move.w	2(a3,d5.w*4),d1		; get from y co-ord	

	move.w	(a3,d6.w*4),d2		; get to x co-ord	
	move.w	2(a3,d6.w*4),d3		; get to y co-ord	

	move.l	buffered_plane1,a0
	bsr	draw_line	
	bra.s	path_done
	
no_link_for_this_path
	
	move.w	(a2,d7.w*4),d5		; get 'from' stage number
	move.w	2(a2,d7.w*4),d6		; get 'to' stage number

	subq.w	#1,d5			; they start at one you know
	subq.w	#1,d6
	
	move.w	(a3,d5.w*4),d0		; get from x co-ord	
	move.w	2(a3,d5.w*4),d1		; get from y co-ord	

	move.w	(a3,d6.w*4),d2		; get to x co-ord	
	move.w	2(a3,d6.w*4),d3		; get to y co-ord	

	move.l	buffered_plane2,a0
	bsr	draw_line	
	
path_done
	dbra	d7,path_loop
	
	rts
	
NUM_STAGES	EQU	4
NUM_PATHS	EQU	4

PassWord_Data

; Password data includes the following
;
; 1. Stage Player is at
; 2. All the links which have been made

Player_at_Stage	
	dc.w	1
path_flags	dc.l	%11111111111111000011100101100111 ; first 32 pathways
PASSWORD_BYTES	EQU	*-PassWord_Data
		dc.l	0
		dc.l	0
		dc.l	0

text_test	
	dc.b	"PASSWORD : <"
Password_Text
	dcb.b	PASSWORD_BYTES*2,"0"
	dc.b	">",0
	even

		
stage_positions
	dc.w	281,256-174	; stage 1
	dc.w	256,256-149	; stage 2
	dc.w	162,256-149	; stage 3
	dc.w	78,256-149	; stage 4
	dc.w	35,256-88	; stage 5
	dc.w	103,256-88	; stage 6
	dc.w	205,256-88	; stage 7
	dc.w	154,256-36	; stage 8
	
stage_paths
	dc.w	1,2
	dc.w	2,3
	dc.w	3,4
	dc.w	3,6
	dc.w	5,6
	dc.w	6,7
	dc.w	7,8

north	equ	0
east	equ	2
south	equ	4
west	equ	6

; Stage exit of zero is null, otherwise path number

Stage_Exits	
	dc.w	0,0,1,0	; stage 1
	dc.w	1,0,0,2	; stage 2
	dc.w	0,2,4,3	; stage 3
	dc.w	0,3,0,0	; stage 4	
	dc.w	0,5,0,0
	dc.w	4,6,0,5
	dc.w	0,0,7,6
	dc.w	7,0,0,0
		
transit_flag
	dc.w	0
		
* a0 pointer to bitmap, d0-d3 coords to draw to/from ok.

calc_walk_parameters
; from d0,d1 to d2,d3
	move.w	#1,transit_flag
	clr.w	neg_x_walk_flag
	clr.w	neg_y_walk_flag

	move.w	d0,d4
	move.w	d1,d5
	asl.w	#7,d4
	asl.w	#7,d5	
	move.w	d4,X_Fixed			; initial scaled x
	move.w	d5,Y_Fixed			; initial scaled y
	
	sub.w	d2,d0
	bpl.s	no_neg_x_walk
	neg.w	d0	
	move.w	#1,neg_x_walk_flag
no_neg_x_walk	

	sub.w	d3,d1
	bpl.s	no_neg_y_walk
	neg.w	d1
	move.w	#1,neg_y_walk_flag
no_neg_y_walk	
	
	cmp.w	d0,d1
	bgt.s	y_greater_walk
x_greater_walk

	ext.l	d0				; for division
	ext.l	d1				; likewise
			
	move.w	#1<<7,X_Increment		; Fixed (16,7)
	tst.l	d1				; check for nasty zero
	beq.s	zero_y
	asl.w	#7,d1				; scale y to (16,7)
	divu.w	d0,d1				; calc y increment
	move.w  d1,Y_Increment	
	bra.s	done_y_walk
zero_y
	clr.w	y_increment
done_y_walk
			
	move.w	d0,walk_countdown

	bra.s	done_walk_calc

y_greater_walk
	ext.l	d0				; for division
	ext.l	d1				; likewise
			
	move.w	#1<<7,Y_Increment		; Fixed (16,7)
	tst.l	d0				; check for nasty zero
	beq.s	zero_x
	asl.w	#7,d0				; scale y to (16,7)
	divu.w	d1,d0				; calc y increment
	move.w  d0,X_Increment	
	bra.s	done_x_walk
zero_x
	clr.w	X_increment
done_x_walk
			
	move.w	d1,walk_countdown

	bra.s	done_walk_calc

done_walk_calc

	tst.w	neg_x_walk_flag
	bne.s	dont_negate_x_walk
	neg.w	X_Increment
dont_negate_x_walk
	tst.w	neg_y_walk_flag
	bne.s	dont_negate_y_walk
	neg.w	Y_Increment
dont_negate_y_walk

	rts

X_Fixed	dc.w	0
Y_Fixed	dc.w	0
walk_countdown	dc.w	0
x_increment	dc.w	0
y_increment	dc.w	0
neg_x_walk_flag	dc.w	0
neg_y_walk_flag	dc.w	0
		
walk_the_line
	move.w	X_Fixed,d0
	move.w	Y_Fixed,d1
		
	add.w	X_Increment,d0
	add.w	Y_Increment,d1
	
	move.w	d0,X_Fixed
	move.w	d1,Y_Fixed
	
	asr.w	#7,d0
	asr.w	#7,d1
	
	move.w	d0,sprite_x
	move.w	d1,sprite_y
		
	subq.w	#1,walk_countdown
	bne.s	not_walked_yet
	move.w	#0,transit_flag	
not_walked_yet
	rts
	
draw_line
	movem.l	d0-d7/a0-a6,-(sp)
	MOVEQ	#0,D6
	MOVEQ	#0,D7
	move.w	D0,-(SP)
	MOVE.W	D0,D6			;STORE FOR USE IN CALCING START POS
	MOVE.W	D1,D7
CALC_OCTANT
	MOVEQ	#0,D5			;USE TO LOCATE OC

	sub.w	d1,d3			;sub y1 from y2
	bpl	y2bigger
	neg.w	d3
	bset    	#2,d5
y2bigger
	sub.w	d0,d2			;x1 from x2
	bpl	x2bigger
	neg.w	d2
	bset	#1,d5
x2bigger
	cmp.w	d2,d3			;is deltax smaller than deltay
	BGe.s	DELTAXSMALLER
	BSET	#0,D5			;D5 CONTAINS OCTANT POS
	move.w	d3,sdelta
	move.w	d2,ldelta
	bra.s	calc_start
DELTAXSMALLER
	move.w	d3,ldelta
	move.w	d2,sdelta

CALC_START
	moveq	#0,d2
	mulu	#bytes_per_row,d7
	
	ADD.L	D7,A0
	andi.w	#$fff0,d6
	asr	#3,d6
	ADD.L	D6,A0			;START POINT HELD IN  A0

	MOVEQ	#0,D6
	move.w	sdelta,d6
	asl	#1,d6
	move.w	d6,sdelta
	MOVE.W	LDELTA,D2
	MOVE.W	d2,length
	SUB.W	D2,D6
	asl	#1,D2			;CON LDELTA
	MOVE.W	SDELTA,D1
	SUB.W	D2,D1			;contains xpres2

	MOVE.W	(SP)+,D0		;INIT BLTCON0
	andi.w	#$000f,d0
	ROR.W	#4,D0
	OR.W	#$0b58,D0

	MOVE.W	SDELTA,D7
	CMP.W	LENGTH,D7
	BGT	NO_SET
	MOVE.W	#$40,D7
	BRA	OR_IN_VAL
NO_SET
	MOVE.W	#0,D7
OR_IN_VAL
	LEA	TABLE,A6		;OCTANT
	OR.B	(A6,D5),D7
BLITTER_IT
	
BLITQ	BTST	#14,$dff002
	BNE	BLITQ

	MOVE.W	#$ffff,$dff072
	MOVE.W	#$8000,$dff074		;MUST BE THIS

	MOVE.L	A0,$dff048		;START ADDRESS
	MOVE.L	A0,$dff054
	MOVE.l	d6,$dff050		;CONTAINS 2*SDELTA-LDELTA
	MOVE.W	SDELTA,$dff062		;2*SDELTA IN HERE
	MOVE.W	d1,$dff064		;CONTAINS 2*SDELTA-2*LDELTA (xpres2)
	
	MOVE.W	D0,$dff040
	
	MOVE.W	#bytes_per_row,$dff066		;SCREEN WIDTH IN BYTES
	MOVE.W	#bytes_per_row,$dff060	
	MOVE.W	D7,$dff042
	MOVE.W	#$ffff,$dff044		;MASK
	MOVE.W	length,D0
	CMPi.W	#0,D0
	BHI	KLM
	MOVE.W	#1,D0
KLM
	asl      #6,D0
	ADDi.W	#2,D0
	MOVE.W	D0,$dff058

	movem.l	(sp)+,d0-d7/a0-a6
	RTS

table
	DC.B	0*4+1
	DC.B	4*4+1
	DC.B	2*4+1
	DC.B	5*4+1
	DC.B	1*4+1
	DC.B	6*4+1
	DC.B	3*4+1
	DC.B	7*4+1
	EVEN

sdelta dc.w 0
length dc.w 0
ldelta dc.w 0


PassWord_Entry_Routine
	move.l	#Player1_Selection_Boxes,a0
	move.l	#Player1_Select_Struct,a1
	bsr	draw_player_box

	moveq	#0,d0
	bsr	rawreadjoy
	move.l	#Player1_Selection_Boxes,a0
	move.l	#Player1_Select_Struct,a1
	bsr	Move_Player_Box
	tst.l	d0
	beq.s	nothing_chosen
	
; button pressed
	move.w	current_pass_count,d0
	
	move.w	Fiddle_Number_Y(a1),d1
	mulu.w	Num_Boxes_X(a0),d1
	add.w	Fiddle_Number_X(a1),d1

	move.l	#Password_Lookup,a1	
	move.l	#Password_Text,a2
	
	move.b	(a1,d1),d3
	
	cmp.b	#'.',d3				; rub character ?
	bne.s	dont_rub
	move.b	#32,d3				; space character
	tst.w	d0
	beq.s	no_char_to_rub
	move.b	d3,-1(a2,d0)
	sub.w	#1,current_pass_count
	bra.s	no_char_to_rub
	
dont_rub
	cmp.w	#PASSWORD_BYTES*2,d0
	bge.s	full_up_password
	
	move.b	d3,(a2,d0)

	add.w	#1,current_pass_count	
no_char_to_rub	
full_up_password	
nothing_chosen
	move.l	#Player1_Selection_Boxes,a0
	move.l	#Player1_Select_Struct,a1
	bsr	draw_player_box
	rts

current_pass_count	dc.w	0
Password_Lookup	dc.b	"0123456789"
		dc.b	"ABCDEFGHIJ"
		dc.b	"KLMNOPQRST"
		dc.b	"UVWXYZ.  <"
	even
	
Move_Player_Box
; joystuff in d0
; boxes struct in a0
; player struct in a1


	move.w	d0,d1
	andi.b	#$f,d1
	bne.s	dont_reset_joy_val
	clr.w	player_frame_count(a1)
dont_reset_joy_val
	tst.w	player_frame_count(a1)
	beq.s	do_the_norm
	subq.w	#1,player_frame_count(a1)
	bra.s	sodit
do_the_norm
	btst	#P1_Left,d0
	beq.s   check_move_right
	tst.w	Fiddle_Number_X(a1)
	beq.s	check_box_y
	subq.w	#1,Fiddle_Number_X(a1)
	move.w	#BOX_FRAME_DELAY,player_frame_count(a1)
check_move_right
	btst	#P1_Right,d0
	beq.s    check_box_y
	move.w	Num_Boxes_X(a0),d1
	subq.w	#1,d1
	cmp.w	Fiddle_Number_X(a1),d1
	beq.s	check_box_y
	addq.w	#1,Fiddle_Number_X(a1)
	move.w	#BOX_FRAME_DELAY,player_frame_count(a1)
check_box_y
	btst	#P1_Up,d0
	beq.s   check_move_down
	tst.w	Fiddle_Number_Y(a1)
	beq.s	sodit
	subq.w	#1,Fiddle_Number_Y(a1)
	move.w	#BOX_FRAME_DELAY,player_frame_count(a1)
check_move_down	
	btst	#P1_Down,d0
	beq.s    sodit
	
	move.w	Num_Boxes_Y(a0),d1
	subq.w	#1,d1
	cmp.w	Fiddle_Number_Y(a1),d1
	beq.s	sodit
	addq.w	#1,Fiddle_Number_Y(a1)
	move.w	#BOX_FRAME_DELAY,player_frame_count(a1)

sodit
	btst	#P1_Fire,d0
	beq.s	no_fire_press
	tst.w	Fire_Button_Toggle(a1)
	bne.s	nothing_doing
	move.w	#-1,Fire_Button_Toggle(a1)
	moveq	#-1,d0
	bra.s	end_fire
no_fire_press
	clr.w	Fire_Button_Toggle(a1)
nothing_doing
	moveq	#0,d0

end_fire	
	rts



BOX_FRAME_DELAY	EQU	8

	rsreset
Box_Start_X	rs.w	1
Box_Start_Y	rs.w	1
Box_Width	rs.w	1
Box_Height	rs.w	1
Num_Boxes_X	rs.w	1
Num_Boxes_Y	rs.w	1
Box_Gap_X	rs.w	1
Box_Gap_Y	rs.w	1

Player1_Selection_Boxes
	dc.w	12,66
	dc.w	15,15
	dc.w	10,4
	dc.w	1,1
	

Player2_Selection_Boxes
	dc.w	160-3+17,255-163	
	dc.w	19,22
	dc.w	6,5
	dc.w	3,3


	dc.w	8,70
	dc.w	71,79
	dc.w	2,2
	dc.w	3,3
	
Draw_Player_Box
; selection boxes in a0
; player struct in a1
	
	move.w	Fiddle_Number_X(a1),d0
	move.w	Fiddle_Number_Y(a1),d1
	move.w	Box_Width(a0),d2
	move.w	Box_Height(a0),d3
	add.w	Box_Gap_X(a0),d2
	add.w	Box_Gap_Y(a0),d3
	mulu.w	d2,d0
	mulu.w	d3,d1
	add.w	Box_Start_X(a0),d0
	add.w	Box_Start_Y(a0),d1
	
	move.w	Box_Width(a0),d2
	move.w	Box_Height(a0),d3
	
	move.l	buffered_Plane1,a0
	add.l	Plane_Offset(a1),a0
	bsr	draw_eor_thick_box
	rts


draw_eor_thick_box
	move.w	d0,d6
	move.w	d1,d7

	move.w	d2,d4
	move.w	d3,d5

	move.w	d0,d2
	add.w	d4,d2
	move.w	d1,d3
	bsr	draw_line

	addq.w	#1,d1
	addq.w	#1,d3	
	bsr	draw_line

	add.w	d5,d1
	add.w	d5,d3	
	subq.w	#3,d1
	subq.w	#3,d3

	bsr	draw_line

	addq.w	#1,d1
	addq.w	#1,d3	
	bsr	draw_line

	move.w	d6,d0
	move.w	d7,d1
	move.w	d0,d2
	move.w	d1,d3

	addq.w	#2,d1
	add.w	d5,d3
	subq.w	#2,d3

	bsr	draw_line

	addq.w	#1,d0
	addq.w	#1,d2	
	bsr	draw_line

	add.w	d4,d0
	add.w	d4,d2	
	subq.w	#3,d0
	subq.w	#3,d2
	bsr	draw_line

	addq.w	#1,d0
	addq.w	#1,d2	
	bsr	draw_line
	
	rts


Player1_Select_Struct
	dc.w	0,0,0,0
	dc.l	0
Player2_Select_Struct
	dc.w	0,0,0,0
	dc.l	40		; plane 2
	
	rsreset
Fiddle_Number_X		rs.w	1
Fiddle_Number_Y		rs.w	1
Fire_Button_Toggle	rs.w	1
player_frame_count	rs.w	1
plane_offset		rs.l	0
P1_Left		EQU	0
P1_Right	EQU	1
P1_Up		EQU	2
P1_Down		EQU	3
P1_Fire		EQU	4

P2_Left		EQU	0
P2_Right	EQU	1
P2_Up		EQU	2
P2_Down		EQU	3
P2_Fire		EQU	4

rawreadjoy
	move.w	$dff00c,d5		
	move.w	#0,d0
	
	btst	#9,d5
	beq	try_right_p1
	bset	#P1_Left,d0
	bra.s	upanddown_p1
try_right_p1
	btst	#1,d5
	beq.s	upanddown_p1
	bset  	#P1_Right,d0
upanddown_p1
	move.w	d5,d6
	rol.w	#1,d5
	eor.w	d5,d6
	btst	#1,d6
	beq.s   tryup_p1
	bset	#P1_Down,d0
	bra	quitjoyread_p1
tryup_p1
	btst	#9,d6
	beq.s	quitjoyread_p1
	bset	#P1_Up,d0
quitjoyread_p1
	btst	#7,$bfe001
	bne.s	no_fire_p1
	bset	#P1_Fire,d0
no_fire_p1
	rts         

rawreadjoy2
	move.w	$dff00a,d5		

	btst	#9,d5
	beq	try_left_p2
	bset	#P2_Right,d0
	bra.s	upanddown_p2
try_left_p2
	btst	#1,d5
	beq.s	upanddown_p2
	bset  	#P2_Left,d0

upanddown_p2

	move.w	d5,d6
	rol.w	#1,d5
	eor.w	d5,d6
	btst	#1,d6
	beq.s   tryup_p2
	bset	#P2_Down,d0
	bra	quitjoyread_p2
tryup_p2
	btst	#9,d6
	beq.s	quitjoyread_p2
	bset	#P2_Up,d0
quitjoyread_p2
	btst	#6,$bfe001
	bne.s	no_fire_p2
	bset	#P2_Fire,d0
no_fire_p2
	rts         

sprite_x	dc.w	160
sprite_y	dc.w	128

sprite_data
	dc.w	0,0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	$ffff,$f0f0
	dc.w	0,0	
	
display_sprite
	move.l	#sprite_data,a0
	ifd   show_demo
	move.l	#blank_sprite,a0
	endc
	move.b	#0,3(a0)
	
	move.w	sprite_y,d0
	subq.w	#8,d0

	add.w	#$2c,d0
	
	btst	#8,d0
	beq.s	no_set_bit
	bset	#2,3(a0)
no_set_bit
	move.b	d0,(a0)	;vertical	
	add.w	#16,d0
	btst	#8,d0
	beq.s	no_set_vstop
	bset	#1,3(a0)
no_set_vstop
	move.b	d0,2(a0) ;vstop value	

	move.w	sprite_x,d0
	subq.w	#8,d0
	add.w	#$80,d0
	
	lsr	#1,d0
	bcc	no_set_vstart_bit
	bset.b	#0,3(a0)	;horizontal lsb
no_set_vstart_bit
	move.b	d0,1(a0)	;horizontal
	
	move.l	a0,d0

	move.w	d0,select_sprite0l
	swap	d0
	move.w	d0,select_sprite0h
	rts
	


PassWord_Entry_Text
	dc.b	"0 1 2 3 4 5 6 7 8 9",0
psel	equ	*-password_entry_text
	dc.b    "A B C D E F G H I J",0 
	dc.b	"K L M N O P Q R S T",0
	dc.b    "U V W X Y Z .     >",0
	even
	
	
blank_sprite
	dc.w	0,0,0,0
	ds.w	16*2
	
	
