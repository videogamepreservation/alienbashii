TIMER_POSITION	EQU	(BYTES_PER_ROW*4)+(64/8)+36
SCORE_POSITION	EQU	(BYTES_PER_ROW*4)+(64/8)+1
LIVES_POSITION	EQU	(BYTES_PER_ROW*4)+(64/8)+10
COINS_POSITION	EQU	(BYTES_PER_ROW*4)+(64/8)+32
TITLE_POSITION	EQU	(BYTES_PER_ROW*4)+(64/8)+14

****pass this routine num in d0 and screen start address in a0

***************************************************
*********             WRITE NUM         ***********
***************************************************
write_num
	moveq	#0,d1
	move.w	#10,d1	;start divide value
number_loop
	divu.w	d1,d0		;divide d0 by d1
	move.l	#panel_font,a1
	move.w	d0,d3
	addq.w	#2,d3
	mulu	#7*2,d3
	add.l	d3,a1		;gets along position of number
	move.w	#7-1,d2
	move.l	a0,a2
draw_num_loop		
	move.b	(a1),(a2)
	add.l	#BYTES_PER_ROW,a2
	addq.l	#2,a1
	dbra	d2,draw_num_loop
	addq.l	#1,a0
	move.w	#0,d0
	swap	d0	;get remainder to lower word
	cmp.w	#1,d1
	beq.s	quit_number_routine
	divu	#10,d1		;divide dividor
	bra	number_loop
quit_number_routine	
	rts


write_bin_num
*send a0 screen
*send d0 - num
	moveq	#0,d1
	move.w	#16-1,d7
bin_loop
	asl.w	d0
	bcc.s	write_zero
	move.w	#1,d3
	bra.s	didddly
write_zero	
	move.w	#0,d3
didddly	
	move.l	#panel_font,a1
	addq.w	#2,d3
	mulu	#7*2,d3
	add.l	d3,a1		;gets along position of number
	move.w	#7-1,d2
	move.l	a0,a2
bindraw_num_loop		
	move.b	(a1),(a2)
	add.l	#BYTES_PER_ROW,a2
	addq.l	#2,a1
	dbra	d2,bindraw_num_loop
	addq.l	#1,a0
	dbra	d7,bin_loop
	rts



****pass this routine num in d0 and screen start address in a0
**string in a5

***************************************************
*********             WRITE STRING      ***********
***************************************************
write_string


	move.l	#panel_font,a1
	moveq	#0,d0
	move.b	(a5)+,d0
	beq.s	quit_string_routine
	cmp.b	#" ",d0
	bne.s	not_panel_space
	move.l	#panel_space,a1
	bra.s	write_panel_font
not_panel_space
	sub.w	#$2e,d0
	mulu	#7*2,d0
	add.l	d0,a1		;gets along position of number
write_panel_font
	move.w	#7-1,d2
	move.l	a0,a2
draw_letter_loop		
	move.b	(a1),(a2)
	addq.l	#2,a1
	add.l	#BYTES_PER_ROW,a2
	dbra	d2,draw_letter_loop
	addq.l	#1,a0
	bra	write_string
quit_string_routine	
	
	rts




***************************************************
*********          WRITE LONG NUM       ***********
***************************************************
write_long_num

*send in d0
*memposition in a0

	move.l	#divide_table,a1
write_long_loop	
	move.l	(a1)+,d1
	moveq	#0,d2
count_long_loop
	sub.l	d1,d0
	bmi.s	found_number
	addq.w	#1,d2		
	bra.s	count_long_loop
found_number	
	add.l	d1,d0	;make pos again
	
****d2 now contains value to write out

	move.l	#panel_font,a5
	addq.w	#2,d2
	mulu	#7*2,d2
	add.l	d2,a5		;gets along position of number
	move.w	#7-1,d2
	move.l	a0,a2
draw_long_loop		
	move.b	(a5),(a2)
	add.l	#BYTES_PER_ROW,a2
	addq.l	#2,a5
	dbra	d2,draw_long_loop
	addq.l	#1,a0
	cmp.l	#1,d1
	bne.s	write_long_loop
	rts	
	
	
	
divide_table
	dc.l	1000000
	dc.l	100000
	dc.l	10000
	dc.l	1000
	dc.l	100
	dc.l	10
	dc.l	1	


************************************************
******            SET TITLE             ********
************************************************
set_title

	move.l	current_game_level,a5
	add.l	#level_title,a5
	move.l	panel_plane1,a0
	add.l	#TITLE_POSITION,a0
	bsr	write_string
	rts

************************************************
******            SET UP TIMER          ********
************************************************	
set_up_timer

	move.l	current_game_level,a5
	move.w	level_time_limit(a5),d0
	
	move.l	#timer_text,a0

	moveq	#0,d1	
	move.w	d0,d1
	divu	#100,d1
	add.w	#48,d1
	move.b	d1,(a0)+
	swap	d1
	move.w	d1,d0
	
	moveq	#0,d1	
	move.w	d0,d1
	divu	#10,d1
	add.w	#48,d1
	move.b	d1,(a0)+
	swap	d1
	move.w	d1,d0

	moveq	#0,d1	
	move.w	d0,d1
	add.w	#48,d1
	move.b	d1,(a0)+

	rts

************************************************
******           SET UP COIN COUNT      ********
************************************************
set_up_coin_count

	move.l	#coins_text,a5
	move.l	panel_plane1,a0
	add.l	#COINS_POSITION-2,a0
	bsr	write_string
	rts

************************************************
******            INCREASE LIVES        ********
************************************************
increase_lives

	move.l	#lives_text,a0
	addq.b	#1,1(a0)
	cmp.b	#"9"+1,1(a0)
	blt.s	lives_low
	move.b	#"0",1(a0)
	cmp.b	#"9",(a0)
	beq.s	lives_low	
	addq.b	#1,(a0)
lives_low	
	rts	
	
************************************************
******            DECREASE LIVES        ********
************************************************
decrease_lives
	move.l	#lives_text,a0
	subq.b	#1,1(a0)
	cmp.b	#48,1(a0)
	bge.s	lives_high
	move.b	#"9",1(a0)
	cmp.b	#"0",(a0)
	beq.s	lives_high
	subq.b	#1,(a0)
lives_high
	rts	
	
	
************************************************
******            DO LIVES              ********
************************************************
do_lives

	move.l	panel_plane1,a0
	add.l	#LIVES_POSITION,a0
	move.l	#lives_text,a5
	bsr	write_string
	rts
	
************************************************
******            DO COINS TOTAL        ********
************************************************	
do_coins_total

	move.l	panel_plane1,a0
	add.l	#COINS_POSITION,a0
	moveq	#0,d0
	move.w	number_of_collected_coins,d0
	bsr	write_num	

	rts
	
************************************************
******            DO SCORE               *******
************************************************	
do_score

	move.w	frame_score,d0
	clr.w	frame_score
	ext.l	d0
	add.l	d0,game_score

	tst	ready_flag	;only do score when not drawing blocks
	bne.s	dont_update_score
	move.l	game_score,d0
	move.l	panel_plane1,a0
	add.l	#SCORE_POSITION,a0
	bsr	write_long_num
dont_update_score	
	rts
	

************************************************
******            DO TIMER              ********
************************************************	
do_timer
	subq.w	#1,time_count
	bne.s	done_timer
	move.w	#TIME_FRAME,time_count
	move.l	#timer_text,a5
	subq.b	#1,2(a5)
	cmp.b	#47,2(a5)
	bne.s	dig_not_zero
	move.b	#"9",2(a5)
	subq.b	#1,1(a5)
	cmp.b	#47,1(a5)
	bne.s	dig_not_zero
	move.b	#"9",1(a5)
	subq.b	#1,(a5)
	cmp.b	#47,(a5)
	bne.s	dig_not_zero
	move.b	#"9",(a5)
dig_not_zero

	move.l  panel_plane1,a0
	add.l	#TIMER_POSITION,a0
	bsr	write_string		
done_timer	
	rts	

frame_score
	dc.w	0

game_score
	dc.l	0
	
TIME_FRAME	EQU	25

time_count	dc.w	TIME_FRAME

timer_text
	dc.b	"999",0
	EVEN

lives_text
	dc.b    "03",0
	EVEN
	
coins_text
	dc.b	"OX",0
	even	
	


	
	
	