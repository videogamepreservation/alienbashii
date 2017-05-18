

EMPTY_SLOT	EQU	0
COIN_IN		EQU	1
COIN_DEAD	EQU	-2
COIN_SPARKLE	EQU	-1

******ALL CODE TO DO WITH COINS*******


*FOR COLLISION - use the coin map - if player x,y hits a 1 in
*coin map then put to -1 - this will be detected by processing routine
*which will kill off the coin


*******************************************
**** SET UP COIN POINTERS              ****
*******************************************
setup_coin_pointers

	move.l	#coin_pointers,a0
	move.l	#coin_structs,a1
	move.w	#MAX_COIN-1,d0
set_up_pointers_loop
	move.l	a1,(a0)+
	add.l	#coin_struct_size,a1
	dbra	d0,set_up_pointers_loop
	
	subq.l	#4,a0
	move.l	a0,current_coin_pointer	;bottom of list of pointers to structs
	
	move.w	#MAX_COIN,coin_spaces_left	
	
	
	move.l	#$ffffffff,active_coins
	move.l	#$ffffffff,drawn_coin_list
	
	move.l	#active_coins,active_coin_pointer

	rts


*******************************************
**** ADD COIN                          ****
*******************************************
add_coin
*d0 - word position
*d1 - line	;send in pixel
*a1 - position in main map

	tst	coin_spaces_left
	beq.s	no_coin_spaces_left
	
*---------------CHECK COIN NOT ALREADY BEING PROCESSED
	
	move.l	coin_map_pointer,a3
	moveq	#0,d2
	move.w	d1,d2
	asr.w	#4,d2
	muls	#MAP_LINE_SIZE,d2
	add.l	d2,a3
	move.w	d0,d2			;so top clear
	add.l	d2,a3
	tst.b	(a3)
	bne.s	no_coin_spaces_left
	move.b	#1,(a3)	

*-----------------------------------------------------	
	
	move.l	a1,d2	;position in map
	move.l	current_coin_pointer,a0	;stack of pointers
	move.l	active_coin_pointer,a1
	move.l	(a0),a2	;our new struct
	move.w	d0,coin_word_x(a2)
	clr.w	coin_spangle_frame(a2)
	move.w	#SPANGLE_TIME,coin_spangle_timer(a2)
	move.l	d2,coin_main_map_pos(a2)
	asl.w	#6,d1			;mulu 64
	move.w	d1,coin_line(a2)
	move.l	a3,coin_map_pos(a2)
	subq.l	#4,a0
	move.l	a2,(a1)+	;new entry in list
	move.l	#$ffffffff,(a1)
	move.l	a1,active_coin_pointer
	move.l	a0,current_coin_pointer
	subq.w	#1,coin_spaces_left
no_coin_spaces_left
	rts


*******************************************
**** REMOVE COIN                       ****
*******************************************
remove_coin
*mem pointer in a0

	cmp.w	#MAX_COIN,coin_spaces_left
	beq.s	quit_remove_coin
	addq.w	#1,coin_spaces_left
	move.l	current_coin_pointer,a1
	addq.l	#4,a1	;becuase always points to new entry 
	move.l	a0,(a1)
	move.l	coin_map_pos(a0),a5
	clr.b	(a5)	;clear in coin map
	move.l	a1,current_coin_pointer	
quit_remove_coin
	rts

*******************************************
**** PROCESS COINS                     ****
*******************************************
process_coins
	
	move.w	screen_x_position,d0	;get values for testing bounds
	asr.w	#4,d0	
	move.w	d0,d1
	add.w	#22+4,d1	;max x
	subq.w	#4+4,d0	;min x
	

	move.l	#active_coins,a2
	move.l	a2,a3	;second pointer for updating list
process_each_coin
	move.l	(a2),a0
	cmp.l	#$ffffffff,a0
	beq.s	done_all_coins
	
	cmp.w	coin_word_x(a0),d0
	bge.s	kill_coin
	cmp.w	coin_word_x(a0),d1
	blt.s	kill_coin
	move.l	coin_map_pos(a0),a4
	cmp.b	#COIN_DEAD,(a4)	;if player sets this to -2 it kills coin
	beq.s	kill_coin
	
	move.l	(a2)+,(a3)+
	bra.s	process_each_coin
kill_coin
	addq.l	#4,a2		;update main list	
	bsr	remove_coin	;coin pointer in a0
	bra.s	process_each_coin		

done_all_coins
	move.l	#$ffffffff,(a3)	;term new list
	move.l	a3,active_coin_pointer	;place to add new coins
	rts	
	
*******************************************
**** DRAW COINS                        ****
*******************************************
draw_coins


	move.w	screen_y_position,d4
	asl.w	#6,d4				;mulu 64
	move.w	d4,d5
	sub.l	#BYTES_PER_ROW*16,d4		;min y
	add.l	#BYTES_PER_ROW*HEIGHT,d5	;max y to test
	
	move.w	screen_x_position,d7
	asr.w	#4,d7
	move.w	d7,d3
	subq.w	#2+4,d7				;min x draw position
	add.w	#21+4,d3				;max x draw position
	
******must prevent same coin from being added to list when old
******coin already being processed - could have map of level - 
******and put 1 or -1 or  in to signify if coin is being updated already

wait_for_fin_blit
	btst	#14,DMACONR(a6)
	bne.s	wait_for_fin_blit
	
	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	
	
	
	move.l	#active_coins,a0
	move.l	#drawn_coin_list,a3
draw_all_coins
	cmp.l	#$ffffffff,(a0)
	beq	have_draw_all_coins
	move.l	(a0)+,a1
	
	move.l	buffered_plane1,a2
	moveq	#0,d0
	move.w	coin_line(a1),d0
	
*------------- BOUNDARY CHECKS-----------------------------	
	cmp.w	d4,d0
	bge.s	test_for_lower	;coin higher than screen
	bra.s	test_for_sparkle
test_for_lower	
	cmp.w	d5,d0
	ble.s	coins_within_y_limit	;coin lower than screen
	bra.s	coins_within_y_limit
test_for_sparkle	
	move.l	coin_map_pos(a1),a4	;if off screen and sparkling then turn off
	cmp.b	#COIN_SPARKLE,(a4)
	bne.s	draw_all_coins
	move.b	#COIN_DEAD,(a4)
	bra.s	draw_all_coins		;if coin sparkling but off screen - just kill it
coins_within_y_limit	
	cmp.w	coin_word_x(a1),d7
	bge.s	test_for_sparkle
	cmp.w	coin_word_x(a1),d3
	ble.s	test_for_sparkle
*----------------------------------------------------------
		
	move.w	coin_word_x(a1),d1
	asl	d1		;get bytes
	add.w	d1,d0
	add.l	d0,a2
	move.l	a2,(a3)+

	move.l	coin_map_pos(a1),a4
	cmp.b	#COIN_SPARKLE,(a4)
	beq.s	doing_spangle
	bra.s	doing_coin
doing_spangle
	move.w	coin_spangle_frame(a1),d4
	subq.w	#1,coin_spangle_timer(a1)
	bne.s	not_done_spangle
	move.w	#SPANGLE_TIME,coin_spangle_timer(a1)
	addq.w	#1,coin_spangle_frame(a1)
	cmp.w	#SPANGLE_NUM_FRAME,coin_spangle_frame(a1)
	bne.s	not_done_spangle
	move.b	#COIN_DEAD,(a4)
	move.l	coin_main_map_pos(a1),a4
	clr.b	(a4)	;clear in main map

not_done_spangle	
	move.l	#spangle_frame_table,a4
	move.l	(a4,d4.w*4),a4
	move.l	#((SPANGLE_HEIGHT)*2)*(SPANGLE_NUM_FRAME),d6
	bra.s	draw_coin_on_screenp1
doing_coin	
	move.l	current_graphic_frame,a4
	move.l	#((1+COIN_HEIGHT)*2)*(NUM_COINS),d6
draw_coin_on_screenp1
	btst	#14,dmaconr(a6)
	bne.s	draw_coin_on_screenp1
	move.l	a2,bltdpth(a6)			;screen
	move.l	a4,bltapth(a6)			;graphics
	move.w	#COIN_HEIGHT<<6+1,bltsize(a6)	;1 word by 16 pixels
	
	add.l	#BYTES_PER_ROW*HEIGHT,a2
	add.l	d6,a4
draw_coin_on_screenp2
	btst	#14,dmaconr(a6)
	bne.s	draw_coin_on_screenp2
	move.l	a2,bltdpth(a6)			;screen
	move.l	a4,bltapth(a6)			;graphics
	move.w	#COIN_HEIGHT<<6+1,bltsize(a6)	;1 word by 16 pixels
	
	bra	draw_all_coins
have_draw_all_coins	
	move.l	#$ffffffff,(a3)
	rts
	


*******************************************
**** UPDATE COIN FRAME                 ****
*******************************************
update_coin_frame

	subq.w	#1,coin_timer
	bne.s	not_time_for_frame_change
	move.w	#SPIN_TIME,coin_timer
	
	move.w	coin_frame_number,d0
	addq.w	#1,d0
	cmp.w	#TOTAL_COIN_FRAMES,d0
	ble.s	not_done_cycle
	moveq	#0,d0
not_done_cycle	

	move.w	d0,coin_frame_number
	
	move.l	#coin_frame_table,a0
	move.l	(a0,d0.w*4),current_graphic_frame

not_time_for_frame_change
	rts
	

*******************************************
**** ADD COINS TO SCREEN               ****
*******************************************
add_coins_to_screen
	
	move.l	map_pointer,a4
	move.w	#MAP_HEIGHT_SIZE-1,d6
	move.w	#0,d4
add_coin_y
	move.w	#0,d5
	move.l	a4,a5
	move.w	#22-1,d7
add_coin_x
	move.b	(a5),d0
	cmp.b	#RING_NUMBER,d0
	bne.s	not_a_ring_to_add
	move.w	d5,d0
	move.w	d4,d1
	move.l	a5,a1
	bsr	add_coin
not_a_ring_to_add
	addq.l	#1,a5
	addq.w	#1,d5
	dbra	d7,add_coin_x
	add.w	#16,d4
	add.l	#MAP_LINE_SIZE,a4
	dbra	d6,add_coin_y


	rts	

WATER_START		EQU	32
WATER_STOP		EQU	33
	
*******************************************
**** TEST FOR COLLECTED COINS          ****
*******************************************
test_for_collected_coins


*---------------TESTS FOR COINS---------------------	
	moveq	#0,d0
	moveq	#0,d1
	move.w	player_x,d0
	add.w	screen_x_position,d0
	
	move.w	player_y,d1
	add.w	#PLAYER_HEIGHT/4,d1	;so tests done in middle
	add.w	screen_y_position,d1
	
	move.w	d0,d2
	andi.w	#$f,d2		;save 
	subq.w	#4,d2		;pixel offset
	
	asr.w	#4,d0
	asr.w	#4,d1
	muls	#MAP_LINE_SIZE,d1
		
	move.l	coin_map_pointer,a0
	add.l	d0,d1
	add.l	d1,a0
	
	move.l	map_pointer,a1
	add.l	d1,a1
	addq.l	#1,a1	;frig
	
	cmp.b	#COIN_IN,(a0)
	bne.s	not_hit_coin
	move.b	#COIN_SPARKLE,(a0)
	move.w	#Sound_coin,Sound_chan1
	addq.w	#1,number_of_collected_coins
	add.w	#10,frame_score
not_hit_coin		
	tst	d2
	bmi.s	test_lower_word
	cmp.b	#COIN_IN,1(a0)
	bne.s	test_lower_word
	move.b	#COIN_SPARKLE,1(a0)
	move.w	#Sound_coin,Sound_chan1
	addq.w	#1,number_of_collected_coins
	add.w	#10,frame_score
test_lower_word
	
	cmp.b	#COIN_IN,MAP_LINE_SIZE(a0)
	bne.s	test_last_coin
	move.b	#COIN_SPARKLE,MAP_LINE_SIZE(a0)
	move.w	#Sound_coin,Sound_chan1
	addq.w	#1,number_of_collected_coins
	add.w	#10,frame_score
test_last_coin
	tst	d2
	bmi.s	done_all_checks
	cmp.b	#COIN_IN,MAP_LINE_SIZE+1(a0)
	bne.s	done_all_checks
	move.b	#COIN_SPARKLE,MAP_LINE_SIZE+1(a0)				
	move.w	#Sound_coin,Sound_chan1
	addq.w	#1,number_of_collected_coins
	add.w	#10,frame_score
done_all_checks

	cmp.w	#100,number_of_collected_coins
	blt.s	have_not_got_100_coins
	sub.w	#100,number_of_collected_coins	
	bsr	increase_lives
	bsr	do_lives
have_not_got_100_coins
*------------------DONE COIN CHECKS-----------------

*------------CHECK TO SEE IF PLAYER IN WATER------

	cmp.b	#WATER_START,MAP_LINE_SIZE(a1)
	blt.s	second_water_test
	cmp.b	#WATER_STOP,MAP_LINE_SIZE(a1)
	bgt.s	second_water_test
	bra.s	player_floating	
second_water_test	
	cmp.b	#WATER_START,(a1)
	blt.s	test_other_side_for_water
	cmp.b	#WATER_STOP,(a1)
	bgt.s	test_other_side_for_water
	bra.s	player_floating
test_other_side_for_water
	cmp.b	#WATER_START,MAP_LINE_SIZE-1(a1)
	blt.s	fourth_water_test
	cmp.b	#WATER_STOP,MAP_LINE_SIZE-1(a1)
	bgt.s	fourth_water_test
	bra.s	player_floating	
fourth_water_test	
	cmp.b	#WATER_START,-1(a1)
	blt.s	player_not_in_water
	cmp.b	#WATER_STOP,-1(a1)
	bgt.s	player_not_in_water
player_floating	

	tst	player_in_water	
	bne.s	player_already_out_of_water
	bsr	player_under_water
	move.w	player_fall_velocity,d0
	asr	#3,d0		;reduce velocity to look like hit water
	move.w	d0,player_fall_velocity
	bra.s	player_already_out_of_water	
player_not_in_water	
	tst	player_in_water
	beq.s	player_already_out_of_water
	
	bsr	player_on_ground
player_already_out_of_water	
	rts	
	 
		
	
number_of_collected_coins	dc.w	0
	

	
	