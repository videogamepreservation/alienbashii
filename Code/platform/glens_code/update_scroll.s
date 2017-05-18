

RING_NUMBER		EQU	39


***if scroll going right then draw blocks one line down at position
***44 in scroll so they will move one block up as they scroll one
SCROLL_GOING_RIGHT	EQU	-8	;-2
SCROLL_GOING_LEFT	EQU 	42+8




**following is the value to add to the map pointer so it draws
*the map correctly on the right hand side of the screen

MAX_SCROLL_SPEED	EQU	5

MAP_SCREEN_OFFSET	EQU	21+4
MAP_SCREEN_OFFSET_LEFT	EQU	4


PLAYER_WINDOW_X		EQU	130
PLAYER_WINDOW_X_SIZE	EQU	60

PLAYER_WINDOW_Y		EQU	50
PLAYER_WINDOW_Y_SIZE	EQU	50
WAIT_DRAW_BLOCKS		EQU 0
START_DRAW_BLOCKS		EQU 1




************************************************************
****        GET CATCH UP VALUES                         ****
************************************************************
get_catch_up_values

	move.w	#0,d2	
	move.w	player_x,d3
	
		
player_not_on_an_object	
	move.w	player_scroll_window_x_min,d0
	move.w	player_scroll_window_x_max,d1
	
	cmp.w	#RIGHT_DIRECTION,catch_up_x
	beq.s	catch_up_right_direction
	
	cmp.w	d1,d3
	blt.s	not_trying_to_go_other_way
	move.w	#90,d0
	move.w	#90+70,d1
	move.w	#RIGHT_DIRECTION,catch_up_x
	bra.s	do_y_catch
not_trying_to_go_other_way
	cmp.w	d0,d3
	bgt.s	do_y_catch	
	move.w	d3,d2
	sub.w	d0,d2		;distance player from boundary
	cmp.w	#-MAX_SCROLL_SPEED,d2
	bge.s	do_y_catch
	move.w	#-MAX_SCROLL_SPEED,d2	;offset value			
	bra.s	do_y_catch

catch_up_right_direction			
	cmp.w	d0,d3
	bgt.s	not_trying_to_go_other_way2
	move.w	#320-90-70,d0
	move.w	#320-90,d1
	move.w	#LEFT_DIRECTION,catch_up_x
	bra.s	do_y_catch
not_trying_to_go_other_way2
	cmp.w	d1,d3
	blt.s	do_y_catch	
	move.w	d3,d2
	sub.w	d1,d2		;distance player from boundary
	cmp.w	#MAX_SCROLL_SPEED,d2
	ble.s	do_y_catch
	move.w	#MAX_SCROLL_SPEED,d2	;offset value			

do_y_catch

*put back x values
	move.w	d2,scroll_adjust_value
	move.w	d0,player_scroll_window_x_min
	move.w	d1,player_scroll_window_x_max

do_y_scrolling

	moveq	#0,d1
	
	cmp.w	#PLAYER_Y_MAX,player_y
	bge.s	scroll_y_down
	
	cmp.w	#PLAYER_Y_MIN,player_y
	ble.s	scroll_y_up
	move.w	#0,hit_platform
	bra.s	done_y	
scroll_y_up	
	cmp.w	#ACTION_PLAYER_SPRINGING,player_action
	beq.s	overide_platform_check
	tst.w	hit_platform
	bne.s	overide_platform_check
	cmp.w	#ACTION_PLAYER_ON_GROUND,player_action
	bne.s	done_y	
	move.w	#1,hit_platform
overide_platform_check	
	move.w	player_y,d1
	sub.w	#PLAYER_Y_MIN,d1
	cmp.w	#-MAX_DROP_VELOCITY,d1
	bge.s	y_in_bound
	move.w	#-MAX_DROP_VELOCITY,d1
y_in_bound
	bra.s	done_y		
	
	
	
scroll_y_down

	move.w	player_y,d1
	sub.w	#PLAYER_Y_MAX,d1
	cmp.w	#MAX_DROP_VELOCITY,d1
	ble.s	y_in_bound2
	move.w	#MAX_DROP_VELOCITY,d1
y_in_bound2

done_y	
	move.w	d1,scroll_y_adjust_value
	
	move.w	player_x,old_px
	
	rts

old_px
	dc.w	0	

LEFT_DIRECTION	EQU	0
RIGHT_DIRECTION	EQU	1

UP_DIRECTION	EQU 	0
DOWN_DIRECTION	EQU	1


scroll_adjust_value
	dc.w	0
scroll_y_adjust_value
	dc.w	0	


catch_up_x
	dc.w	LEFT_DIRECTION
catch_up_y
	dc.w	UP_DIRECTION	

hit_platform
	dc.w	0
	
player_scroll_window_x_min
	dc.w	320-90-70
player_scroll_window_x_max
	dc.w	320-90

player_scroll_window_y_min
	dc.w	256-90-30
player_scroll_window_y_max
	dc.w	256-90

PLAYER_Y_MIN	EQU	85
PLAYER_Y_MAX	EQU	140-16

************************************************************
****        UPDATE SCROLL                               ****
************************************************************
update_scroll
*scrolls screen depending on players velocity
	
	
	move.w	scroll_adjust_value,d0
	move.w	screen_x_position,d1
	add.w	d0,d1	
	
****ensure have not hit min or max scroll points	
	
	cmp.w	#0,d1
	bge.s	not_hit_min_scroll_bound
	
*calculate space scroll has moved and use for scroll offset	
	move.w	#0,d1
	move.w	screen_x_position,d0	;?????
	neg.w	d0
	bra.s	not_hit_max_scroll_bound
not_hit_min_scroll_bound	
****replace equate with a variable
	cmp.w	max_scroll_x_position,d1
	ble.s	not_hit_max_scroll_bound
*recaluclate scroll offset value
	move.w	max_scroll_x_position,d0
	move.w	d0,d1
	sub.w	screen_x_position,d0
*	
not_hit_max_scroll_bound	
	move.w	d0,scroll_adjust_value
	move.w	d1,screen_x_position


	move.w	scroll_y_adjust_value,d0	
	move.w	screen_y_position,d1
	add.w	d0,d1	
	
****ensure have not hit min or max y scroll point	
	
	cmp.w	#0,d1
	bge.s	not_hit_min_y_scroll_bound
	move.w	#0,d1
	move.w	screen_y_position,d0
	neg.w d0
	bra.s	not_hit_max_y_scroll_bound
not_hit_min_y_scroll_bound	
	
	cmp.w	max_scroll_y_position,d1
	ble.s	not_hit_max_y_scroll_bound
	move.w	max_scroll_y_position,d0
	move.w	d0,d1
	sub.w	screen_y_position,d0
not_hit_max_y_scroll_bound	
	
	move.w	d1,screen_y_position
	move.w	d0,scroll_y_adjust_value	
	
	move.w	screen_x_position,d0
	move.w	d0,d2
	move.w	last_x_position,d1

*see which way scroll has gone
	
	sub.w	d0,d1
	
*result will be plus or minus - magnitude will be size of movement
	
****************see if new blocks need to be put down
**when check_add_new either +17 or -17 then add new blocks

*see scroll notes for reason why this is

	add.w	d1,check_add
	cmp.w	#17,check_add
	blt.s	check_min_add
	sub.w	#16,check_add
	move.w	#START_DRAW_BLOCKS,ready_flag
	move.l	#SCROLL_GOING_RIGHT,add_block_direction
	bra.s	drawing_please_wait
check_min_add
	cmp.w	#-17,check_add
	bgt.s	drawing_please_wait
	move.w	#START_DRAW_BLOCKS,ready_flag		
	move.l	#SCROLL_GOING_LEFT,add_block_direction
	add.w	#16,check_add
drawing_please_wait	


*****************************************************	
	
	
update_scroll_value			


	moveq	#0,d3
	move.w	d2,d3
	andi.w	#$3f,d2
	move.w	d2,d4
	andi.w	#$f,d2
	neg.w	d2
	add.w	#$f,d2
	move.w	scroll_value,d5
	andi.w	#$f0f0,d5
	or.w	d2,d5
	move.w	d2,current_scroll_pixel_offset
*update scroll register 	
	andi.w	#$0030,d4
	neg.w	d4
	add.w	#$0030,d4
	asl.w	#6,d4
	or.w	d4,d5		
	move.w	d5,scroll_value			
	
	
	
	
******************position scroll correctly on screen
	moveq	#0,d2	
	move.w	d3,d2
	andi.w	#$fff0,d2
	andi.w	#$ffc0,d3
	asr.w	#3,d3
	asr.w	#3,d2
	move.l	scroll_front_plane,a1
	move.l	buffered_plane1,scroll_plane_position
	move.l	scroll_front_buff_plane,a5
	add.l	d2,a1		;draw position scroll value
	add.l	d2,scroll_plane_position	;for stu
	add.l	d2,a5
	move.l	a5,scroll_draw_buff_position
	move.l	a1,scroll_draw_position
	moveq	#0,d0	
	move.w	screen_y_position,d0
	asl.w	#6,d0			;mulu 64
	move.l	buffered_plane1,a4
	add.l	d3,a4
	add.l	d0,a4
	bsr	update_scroll_planes
	
*************************************	
	
***get current map position	

	move.l	map_pointer,a1
	asr.w	d2
	add.l	d2,a1
	move.l	a1,front_map_position
	
	move.l	the_alien_map_pointer,a1
	add.l	d2,a1
	move.l	a1,alien_map_pointer_position


*******************************	

	
*store last screen position as this and the last one can be used to
*determine direction of scroll

store_position_of_screen		
	move.w	screen_x_position,last_x_position


	rts	

************************************************************
****        DRAW BLOCKS FOR FRONT                       ****
************************************************************


draw_blocks_for_front
	tst	ready_flag	;no blocks to draw?
	beq.s	quit_draw_blocks_for_front
	
**draw_blocks at position	
	move.l	front_blocks,a4
	move.l	front_map_position,a1
	move.l	scroll_draw_position,a0
	move.l	scroll_draw_buff_position,a5
	bsr	draw_blocks
	
	bsr	add_aliens_from_map
quit_draw_blocks_for_front	
	rts

*current map location variables

front_map_position
	dc.l	0
alien_map_pointer_position
	dc.l	0	


***********************************************************
********************update_planes**************************
***********************************************************


update_scroll_planes
*send in plane in a4
	move.l	a4,d0
	move.l	d0,d1
	move.w	d0,PLANE1LOW
	swap	d0
	move.w	d0,PLANE1HIGH
	add.l	#BYTES_PER_ROW*HEIGHT,d1
	move.l	d1,d0
	move.w	d1,PLANE2LOW
	swap	d1
	move.w	d1,PLANE2HIGH
	add.l	#BYTES_PER_ROW*HEIGHT,d0
	move.l	d0,d1	
	move.w	d0,PLANE3LOW
	swap	d0
	move.w	d0,PLANE3HIGH
	add.l	#BYTES_PER_ROW*HEIGHT,d1
	move.l	d1,d0
	move.w	d1,PLANE4LOW
	swap	d1
	move.w	d1,PLANE4HIGH
	rts	
	
***********************************************************
********************update_background_planes***************
***********************************************************
update_background_planes
	
	move.l	a4,d0
	move.l	d0,d1
	move.w	d0,PLANE5LOW
	swap	d0
	move.w	d0,PLANE5HIGH
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d1
	move.l	d1,d0
	move.w	d1,PLANE6LOW
	swap	d1
	move.w	d1,PLANE6HIGH
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d0
	move.l	d0,d1	
	move.w	d0,PLANE7LOW
	swap	d0
	move.w	d0,PLANE7HIGH
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,d1
	move.l	d1,d0
	move.w	d1,PLANE8LOW
	swap	d1
	move.w	d1,PLANE8HIGH

	
	rts


**********************************************************
***********   DRAW BLOCKS                      ***********
**********************************************************
draw_blocks
*current screen mem position in a0
*current map position in a1
*send blocks in a4
*send buff in a5
	

		
**d4 and d5 are used to hold x and y for rings		
		
**make it draw always on right
	
	add.l	add_block_direction,a0
	add.l	add_block_direction,a5	;buff

	tst.l	add_block_direction
	bmi.s	scroll_going_towards_right
	add.l	#MAP_SCREEN_OFFSET,a1
	bra.s	draw_blocks_straight
scroll_going_towards_right	
	subq.l	#MAP_SCREEN_OFFSET_LEFT,a1
draw_blocks_straight

*------GET BLOCK WORD POSITION AND Y PIXEL POSITION ---------
	move.w	screen_x_position,d4
	asr.w	#3,d4
	add.l	add_block_direction,d4
	asr	d4	;contains word position of scroll
	
	move.w	current_map_position,d5
	asl.w	#4,d5		;mult up by 16
	
	
*------------------------------------

	moveq	#0,d0
	move.w   current_map_position,d0
	move.w	d0,d1
	mulu	#MAP_LINE_SIZE,d0
	add.l	d0,a1	;get to current line
	mulu	#BYTES_PER_ROW*16,d1
	add.l	d1,a0	;current screen block position
	add.l	d1,a5	;buff
	move.l	a0,start_of_blocks
	move.w	total_number_of_blocks_to_draw,d2	
	moveq	#0,d7	;count number of blocks drawn
init_blit_values	
	btst	#14,dmaconr(a6)
	bne.s	init_blit_values	


	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	
	
	moveq	#NUMBER_OF_BLOCKS_PER_FRAME-1,d0
draw_loop
	move.l	a4,a2
	moveq	#0,d1
	move.b	(a1),d1
	cmp.b	#RING_NUMBER,d1
	bne.s	not_a_ring

*-----------------------------ADDING A RING--------------
	movem.l	d0-d2/a0-a3,-(sp)
	move.w	d4,d0
	move.w	d5,d1
	bsr	add_coin	
	movem.l	(sp)+,d0-d2/a0-a3
*-----------------------------ADDING A RING END-----------	
	move.b	#0,d1		;so blank is drawn where coin will appear - else as coin only 2 planes - shit can appeat behind coin
not_a_ring	
	asl.w	#7,d1		;same as mulu (16*2)*4
	add.l	d1,a2	;get to correct position in block data
	
draw_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screen
	move.l	a0,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels
	move.l	a0,a3
	
	add.l	#BYTES_PER_ROW*HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp2
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp2
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BYTES_PER_ROW*HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp3
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp3
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BYTES_PER_ROW*HEIGHT,a3
	add.l	#16*2,a2
draw_block_on_screenp4
	btst	#14,dmaconr(a6)
	bne.s	draw_block_on_screenp4
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

done_a_block
	add.w	#16,d5		;current y pixel position
	add.l	#BYTES_PER_ROW*16,a0
	add.l	#MAP_LINE_SIZE,a1
	addq.w	#1,current_map_position
	addq.w	#1,d7		;count number blocks drawn	
	cmp.w	current_map_position,d2
	bne.s	not_yet_done_line
	move.w	#0,current_map_position
	move.w	#WAIT_DRAW_BLOCKS,ready_flag	;done our line now wait for screen to scroll 16
	bra.s	done_all_blocks
not_yet_done_line
	dbra	d0,draw_loop	
done_all_blocks	
	
**********************DRAW TO BUFF*****************************

draw_buffer_blocks
	btst	#14,dmaconr(a6)
	bne.s	draw_buffer_blocks

	
	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#BYTES_PER_ROW-2,bltamod(a6)
	asl.w	#6,d7	;mulu up	
	asl.w	#4,d7	;by 16 
	move.l	start_of_blocks,a4
	addq.w	#1,d7	;blit size
draw_block_buff_on_screen_p1
	btst	#14,dmaconr(a6)
	bne.s	draw_block_buff_on_screen_p1
	move.l	a5,bltdpth(a6)		
	move.l	a4,bltapth(a6)		
	move.w	d7,bltsize(a6)	
	
	add.l	#BYTES_PER_ROW*HEIGHT,a4
	add.l	#BYTES_PER_ROW*HEIGHT,a5


draw_block_buff_on_screen_p2
	btst	#14,dmaconr(a6)
	bne.s	draw_block_buff_on_screen_p2
	move.l	a5,bltdpth(a6)		
	move.l	a4,bltapth(a6)		
	move.w	d7,bltsize(a6)	
	
	add.l	#BYTES_PER_ROW*HEIGHT,a4
	add.l	#BYTES_PER_ROW*HEIGHT,a5


draw_block_buff_on_screen_p3
	btst	#14,dmaconr(a6)
	bne.s	draw_block_buff_on_screen_p3
	move.l	a5,bltdpth(a6)		
	move.l	a4,bltapth(a6)		
	move.w	d7,bltsize(a6)	
	
	add.l	#BYTES_PER_ROW*HEIGHT,a4
	add.l	#BYTES_PER_ROW*HEIGHT,a5

draw_block_buff_on_screen_p4
	btst	#14,dmaconr(a6)
	bne.s	draw_block_buff_on_screen_p4
	move.l	a5,bltdpth(a6)		
	move.l	a4,bltapth(a6)		
	move.w	d7,bltsize(a6)	
	
*****done draw to buff


	rts

total_number_of_blocks_to_draw	dc.w	32

start_of_blocks
	dc.l	0

ALIEN_BUSY	EQU	7


************************************************************
****        ADD ALIENS FROM MAP                         ****
************************************************************
add_aliens_from_map
	move.l	alien_map_pointer_position,a1
	
*---------------GET ALIEN X POS	
	move.l	add_block_direction,d0
	asl.w	#3,d0
	add.w	screen_x_position,d0		;x position of alien
	
*---------------
	
	tst.l	add_block_direction
	bmi.s	alien_scroll_going_towards_right
	add.l	#MAP_SCREEN_OFFSET,a1
	bra.s	add_aliens_to_list
alien_scroll_going_towards_right	
	subq.l	#MAP_SCREEN_OFFSET_LEFT,a1
add_aliens_to_list

*---------GET ALIEN Y POS
	move.w	current_alien_map_position,d1
	move.w	d1,d2
	asl.w	#4,d1				;y position of alien
	
*------------	
	mulu	#MAP_LINE_SIZE,d2
	add.l	d2,a1

	move.w	total_number_of_blocks_to_draw,d7
	moveq	#NUMBER_OF_BLOCKS_PER_FRAME-1,d6
alien_add_loop

	moveq	#0,d2
	move.b	(a1),d2
	tst.b	d2
	beq.s	not_alien_in_map
	btst.l	#ALIEN_BUSY,d2
	bne.s	not_alien_in_map
	move.l	a1,alien_map_position	;temporay until better solu found
	subq.w	#1,d2			;temporary until map set up better
	andi.w	#$fff0,d0
	andi.w	#$fff0,d1
	bsr	Add_An_Enemy	
	*move.w	#Sound_Bumhit,sound_chan1
	bset.b	#ALIEN_BUSY,(a1)	;set as on screen now	
not_alien_in_map	
	
	add.w	#16,d1
	addq.w	#1,current_alien_map_position
	add.l	#MAP_LINE_SIZE,a1
	cmp.w	current_alien_map_position,d7
	bne.s	not_yet_done_alien_line
	move.w	#0,current_alien_map_position
	bra.s	done_adding_aliens
not_yet_done_alien_line
	dbra	d6,alien_add_loop
done_adding_aliens
	clr.l	alien_map_position
	rts

current_alien_map_position
	dc.w	0


************************************************************
****   UPDATE BACKGROUND SCROLL                         ****
************************************************************
update_background_scroll

	move.w	background_screen_x_position,d0
	move.w	scroll_adjust_value,d1
	add.w	background_x_pixel_leftover,d1
	asr.w	d1
	bcc.s	no_carry_pixel_x
	move.w	#1,background_x_pixel_leftover
	bra.s	update_back_x_scroll
no_carry_pixel_x	
	move.w	#0,background_x_pixel_leftover
update_back_x_scroll	
	add.w	d1,d0
	cmp.w	#0,d0
	bge.s	check_greater_x_b
	moveq.w	#0,d0
	bra.s	done_x_back_checks
check_greater_x_b
	cmp.w	max_background_scroll_x_position,d0
	ble.s	done_x_back_checks
	move.w	max_background_scroll_x_position,d0
done_x_back_checks
	
	move.w	d0,background_screen_x_position

	move.w	background_screen_y_position,d0
	move.w	scroll_y_adjust_value,d1
	add.w	background_y_pixel_leftover,d1
	asr.w	d1
	bcc.s	no_carry_pixel_y
	move.w	#1,background_y_pixel_leftover
	bra.s	update_back_y_scroll
no_carry_pixel_y
	move.w	#0,background_y_pixel_leftover
update_back_y_scroll	

	add.w	d1,d0
	cmp.w	#0,d0
	bge.s	check_greater_bound
	move.w	#0,d0
	bra.s	done_back_y_check
check_greater_bound
	cmp.w	max_background_scroll_y_position,d0
	ble.s	done_back_y_check
	move.w	max_background_scroll_y_position,d0
done_back_y_check			
	move.w	d0,background_screen_y_position
nothing_to_add_to_background_y
	
	move.w	background_screen_x_position,d0	
	move.w	d0,d2
	move.w	last_background_x_position,d1

	sub.w	d0,d1
	
	add.w	d1,check_add_background
	cmp.w	#17,check_add_background
	blt.s	check_min_add_background
	sub.w	#16,check_add_background
	move.w	#START_DRAW_BLOCKS,ready_flag_background
	move.l	#SCROLL_GOING_RIGHT,add_block_direction_background
	bra.s	drawing_background_please_wait
check_min_add_background
	cmp.w	#-17,check_add_background
	bgt.s	drawing_background_please_wait
	move.w	#START_DRAW_BLOCKS,ready_flag_background
	move.l	#SCROLL_GOING_LEFT,add_block_direction_background
	add.w	#16,check_add_background
drawing_background_please_wait	



	moveq	#0,d3
	move.w	d2,d3
	andi.w	#$3f,d2
	move.w	d2,d4
	andi.w	#$f,d2
	neg.w	d2
	add.w	#$f,d2
	move.w	scroll_value,d5
	andi.w	#$0f0f,d5
	bfins	d2,d5{24:4}	;insert shift

*update scroll register 		
	andi.w	#$0030,d4
	neg.w	d4
	add.w	#$0030,d4
	ror.w	#6,d4
	or.w	d4,d5
	move.w	d5,scroll_value			


		
	moveq	#0,d2
	move.w	d3,d2		
	andi.w	#$ffc0,d3
	andi.w	#$fff0,d2
	move.l	plane5,a4
	asr.w	#3,d3
	asr.w	#3,d2
	move.l	scroll_back_plane,a0
	add.l	d2,a0	
	move.l	a0,scroll_back_draw_position
	add.l	d3,a4
	moveq	#0,d0
	move.w	background_screen_y_position,d0
	asl.w	#6,d0		;mulu 64
	add.l	d0,a4
	bsr	update_background_planes
	
	tst	ready_flag_background	;no blocks to draw?
	beq	store_position_of_background_screen
	move.l	background_map_pointer,a1
	asr.w	d2
	add.l	d2,a1
	move.l	a1,scroll_back_map_pointer
	
**draw_blocks at position	
	move.l	back_blocks,a4
	bsr	draw_background_blocks

store_position_of_background_screen		
	move.w	background_screen_x_position,last_background_x_position
	rts

************************************************************
****   DRAW BLOCKS FOR BACK                             ****
************************************************************
draw_blocks_for_back

	tst	ready_flag_background	;no blocks to draw?
	beq.s	quit_draw_blocks_for_back
**draw_blocks at position	
	move.l	back_blocks,a4
	move.l	scroll_back_draw_position,a0
	move.l	scroll_back_map_pointer,a1
	bsr	draw_background_blocks

	
quit_draw_blocks_for_back	


	rts


scroll_back_draw_position	dc.l	0
scroll_back_map_pointer		dc.l	0



**********************************************************
***********   DRAW BACKGROUND BLOCKS           ***********
**********************************************************
draw_background_blocks
*current screen mem position in a0
*current map position in a1
*send blocks in a4
	

	
**make it draw always on right

	add.l	add_block_direction_background,a0

	tst.l	add_block_direction_background
	bmi.s	background_scroll_going_towards_right
	add.l	#MAP_SCREEN_OFFSET,a1
	bra.s	draw_background_blocks_straight
background_scroll_going_towards_right	
	subq.l	#MAP_SCREEN_OFFSET_LEFT,a1
draw_background_blocks_straight
	moveq	#0,d0
	move.w   current_background_map_position,d0
	move.w	d0,d1
	mulu	#MAP_LINE_SIZE,d0
	add.l	d0,a1	;get to current line
	mulu	#BYTES_PER_ROW*16,d1
	add.l	d1,a0	;current screen block position
	move.w	total_number_of_background_blocks_to_draw,d2	
init_back_blit_values	
	btst	#14,dmaconr(a6)
	bne.s	init_back_blit_values	
	
	move.w	#BYTES_PER_ROW-2,bltdmod(a6)	
	move.w	#0,bltamod(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09F00000,bltcon0(A6)	
	
	moveq	#NUMBER_OF_BACKGROUND_BLOCKS_PER_FRAME-1,d0
draw_background_loop
	move.l	a4,a2
	moveq	#0,d1
	move.b	(a1),d1
	asl.w	#7,d1		;same as mulu (16*2)*4
	add.l	d1,a2	;get to correct position in block data
	
		
draw_back_block_on_screen
	btst	#14,dmaconr(a6)
	bne.s	draw_back_block_on_screen
	move.l	a0,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels
	move.l	a0,a3
	
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_back_block_on_screenp2
	btst	#14,dmaconr(a6)
	bne.s	draw_back_block_on_screenp2
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_back_block_on_screenp3
	btst	#14,dmaconr(a6)
	bne.s	draw_back_block_on_screenp3
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels

	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,a3
	add.l	#16*2,a2
draw_back_block_on_screenp4
	btst	#14,dmaconr(a6)
	bne.s	draw_back_block_on_screenp4
	move.l	a3,bltdpth(a6)			;screen
	move.l	a2,bltapth(a6)			;graphics
	move.w	#16<<6+1,bltsize(a6)	;1 word by 16 pixels



	add.l	#BYTES_PER_ROW*16,a0
	add.l	#MAP_LINE_SIZE,a1
	addq.w	#1,current_background_map_position
	
	cmp.w	current_background_map_position,d2
	bne.s	not_yet_done_background_line
	move.w	#0,current_background_map_position
	move.w	#WAIT_DRAW_BLOCKS,ready_flag_background	;done our line now wait for screen to scroll 16
	bra.s	done_all_background_blocks
not_yet_done_background_line
	dbra	d0,draw_background_loop	
done_all_background_blocks	
	rts



total_number_of_background_blocks_to_draw	dc.w	24




************************************************************
****   FILL SCREEN WITH BLOCKS                          ****
************************************************************
fill_screen_with_blocks
	
	move.w	#22+4-1,d0
	move.l	scroll_front_plane,a0
	move.l	scroll_front_buff_plane,a5
	move.l	map_pointer,a1
	move.w	#START_DRAW_BLOCKS,ready_flag
fill_x_loop
	movem.l	d0/a0/a1/a5,-(sp)	
	move.l	front_blocks,a4
	bsr	draw_blocks_straight
	movem.l	(sp)+,d0/a0/a1/a5
	tst	ready_flag
	bne.s	fill_x_loop
	move.w	#START_DRAW_BLOCKS,ready_flag
	addq.l	#1,a1
	addq.l	#2,a0
	addq.l	#2,a5
	dbra	d0,fill_x_loop
	move.l	scroll_front_plane,a4
	bsr	update_scroll_planes
	move.w	#WAIT_DRAW_BLOCKS,ready_flag
	
	move.w	#22+4-1,d0
	move.l	plane5,a0
	move.l	background_map_pointer,a1
	move.w	#START_DRAW_BLOCKS,ready_flag_background
fill_back_x_loop
	movem.l	d0/a0-a1,-(sp)	
	move.l	back_blocks,a4
	bsr	draw_background_blocks_straight
	movem.l	(sp)+,d0/a0-a1
	tst	ready_flag_background
	bne.s	fill_back_x_loop
	move.w	#START_DRAW_BLOCKS,ready_flag_background
	addq.l	#1,a1
	addq.l	#2,a0
	dbra	d0,fill_back_x_loop
	move.w	#WAIT_DRAW_BLOCKS,ready_flag_background
	move.l	plane5,a4
	bsr	update_background_planes
	
	rts

************************************************************
****   COPY MAP TO BACK UP                              ****
************************************************************
copy_map_to_back_up

	move.w	#(MAP_LINE_SIZE*(MAP_HEIGHT_SIZE))-1,d0
	move.l	#map1,a0
clean_map	
	clr.b	(a0)+
	dbra	d0,clean_map
	
	move.l	current_game_level,a0
	move.l	level_foreground_map(a0),a1
	move.w	map_data_x(a1),d2
	subq.w	#1,d2
	move.w	map_data_y(a1),d3
	subq.w	#1,d3
	add.l	#map_data_start,a1
	move.l	map_pointer,a0
copy_map_y_loop
	move.l	a0,a2
	move.w	d2,d4
copy_map_x_loop	
	move.b	(a1)+,(a2)+
	dbra	d4,copy_map_x_loop
	add.l	#MAP_LINE_SIZE,a0
	dbra	d3,copy_map_y_loop
	rts
	
************************************************************
****   COPY BACK MAP TO BACK UP                         ****
************************************************************
copy_back_map_to_back_up

	move.w	#(MAP_LINE_SIZE*(BACKGROUND_MAP_HEIGHT_SIZE))-1,d0
	move.l	#back_map,a0
clean_back_map	
	clr.b	(a0)+
	dbra	d0,clean_back_map
	
	move.l	current_game_level,a0
	move.l	level_background_struct(a0),a0
	move.l	background_map(a0),a1
	
	move.w	map_data_x(a1),d2
	subq.w	#1,d2
	move.w	map_data_y(a1),d3
	subq.w	#1,d3
	add.l	#map_data_start,a1
	move.l	background_map_pointer,a0
copy_back_map_y_loop
	move.l	a0,a2
	move.w	d2,d4
copy_back_map_x_loop	
	move.b	(a1)+,(a2)+
	dbra	d4,copy_back_map_x_loop
	add.l	#MAP_LINE_SIZE,a0
	dbra	d3,copy_back_map_y_loop
	rts


************************************************************
****   COPY ALIEN MAP TO BACK UP                        ****
************************************************************
copy_alien_map_to_back_up

	move.w	#(MAP_LINE_SIZE*(BACKGROUND_MAP_HEIGHT_SIZE))-1,d0
	move.l	#alien_map,a0
	move.l	#alien_collision_map,a4
clean_alien_map	
	clr.b	(a0)+
	clr.b	(a4)+
	dbra	d0,clean_alien_map
	
	move.l	current_game_level,a0
	move.l	level_alien_map(a0),a1
	
	move.w	map_data_x(a1),d2
	subq.w	#1,d2
	move.w	map_data_y(a1),d3
	subq.w	#1,d3
	add.l	#map_data_start,a1
	move.l	the_alien_map_pointer,a0
	move.l	alien_collision_map_ptr,a4
copy_alien_map_y_loop
	move.l	a0,a2
	move.l	a4,a5
	move.w	d2,d4
copy_alien_map_x_loop	
	move.b	(a1),(a2)+
	move.b	(a1)+,(a5)+
	dbra	d4,copy_alien_map_x_loop
	add.l	#MAP_LINE_SIZE,a0
	add.l	#MAP_LINE_SIZE,a4
	dbra	d3,copy_alien_map_y_loop
	rts

************************************************************
****   CLEAN COIN MAP                                   ****
************************************************************
clean_coin_map
	move.w	#(MAP_LINE_SIZE*(BACKGROUND_MAP_HEIGHT_SIZE))-1,d0
	move.l	#coin_map,a0
clean_coin_map_loop
	clr.b	(a0)+
	dbra	d0,clean_coin_map_loop
	rts


************************************************************
****   CONVERT ALIEN MAP                                ****
************************************************************
convert_alien_map

*temporary function until map editor can edit alien maps


	move.l	the_alien_map_pointer,a0
	move.w	#(MAP_LINE_SIZE*(MAP_HEIGHT_SIZE))-1,d0
convert_alien_map_loop
	moveq	#0,d1
	move.b	(a0),d1
	cmp.b	#101,d1
	blt.s	not_an_alien_block
	cmp.b	#106,d1
	bgt.s	not_an_alien_block	
	sub.b	#100,(a0)
	bra.s	done_convert
not_an_alien_block		
	move.b	#0,(a0)
done_convert
	addq.l	#1,a0
	dbra	d0,convert_alien_map_loop
	rts

current_map_position			dc.w	0

current_background_map_position		dc.w	0	
	
map_block_position			dc.l	0	
	
scroll_plane_position			dc.l	0		;used by alien routine

scroll_draw_position			dc.l	0	

scroll_draw_buff_position		dc.l	0	
	
current_scroll_pixel_offset		dc.w	0

screen_x_position			dc.w	0	

screen_y_position			dc.w	0	

background_screen_x_position		dc.w	0	

background_screen_y_position		dc.w	0	
	
background_x_pixel_leftover		dc.w	0
	
background_y_pixel_leftover		dc.w	0
		
	
last_x_position				dc.w	0

last_background_x_position		dc.w	0


	
add_block_direction			dc.l	0		

add_block_direction_background		dc.l	0
	
check_add				dc.w	0
	
check_add_background			dc.w	0


ready_flag      	   		dc.w	WAIT_DRAW_BLOCKS

ready_flag_background      		dc.w	WAIT_DRAW_BLOCKS


max_scroll_x_position			dc.w	0
max_scroll_y_position			dc.w	0

max_background_scroll_x_position			dc.w	0
max_background_scroll_y_position			dc.w	0
