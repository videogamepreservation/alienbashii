


*---------------------GLENS ALIEN ROUTINES-------------------*



************************************************
******     SETUP ALIEN POINTERS           ******
************************************************
Setup_Alien_Pointers

	move.l	#alien_pointers,a0
	move.l	#alien_structures,a1
	move.w	#MAX_ALIENS-1,d0
assign_alien_mem
	move.l	a1,(a0)+
	add.l	#alien_struct_size,a1	
	dbra	d0,assign_alien_mem
	
	move.l	#$ffffffff,alien_draw_structures
	move.l	#$ffffffff,alien_draw_structures_buff
	move.l	#$ffffffff,pri_alien_draw_structures
	move.l	#$ffffffff,pri_alien_draw_structures_buff
	move.l	#alien_draw_structures,alien_draw_ptr
	move.l	#alien_draw_structures_buff,alien_draw_ptr_buff
	move.l	#pri_alien_draw_structures,pri_alien_draw_ptr
	move.l	#pri_alien_draw_structures_buff,pri_alien_draw_ptr_buff
	move.l	#$ffffffff,active_alien_pointers	
	move.l	#alien_pointers,current_add_alien_ptr
	move.l	#active_alien_pointers,current_alien_list_ptr
	rts

************************************************
******     BUFFER ALIEN LISTS             ******
************************************************
Buffer_Alien_Lists

	move.l	alien_draw_ptr,d0
	move.l	alien_draw_ptr_buff,alien_draw_ptr
	move.l	d0,alien_draw_ptr_buff
	
	move.l	pri_alien_draw_ptr,d0
	move.l	pri_alien_draw_ptr_buff,pri_alien_draw_ptr
	move.l	d0,pri_alien_draw_ptr_buff


	rts

************************************************
******     DRAW CURRENT ALIEN LIST        ******
************************************************
Draw_Current_Alien_List

	move.w	#BLITTER_NASTY+$8000,dmacon(a6)

	move.l	alien_draw_ptr,a0
	bsr	Split_Draw_Aliens

	move.l	pri_alien_draw_ptr,a0
	bsr	Split_Draw_Aliens	
	
	move.w	#BLITTER_NASTY,dmacon(a6)
	
	rts


************************************************
******     SPLIT DRAW ALIENS              ******
************************************************
Split_Draw_Aliens
*send list pointer in a0

*Will not require tests to see if can draw on screen as alien
*will not be in list if not on screen

blits_not_fin
	btst	#14,dmaconr(a6)
	bne.s	blits_not_fin
	
	move.l	#$ffff0000,bltafwm(a6)
	move.w	#-2,bltamod(a6)
	move.w	#-2,bltbmod(a6)
	
draw_aliens_loop
	cmp.l	#$ffffffff,(a0)
	beq	finished_drawing_aliens
	
	move.l	current_alien_draw_position,a3
	move.l	current_alien_split_draw_position,a4
	move.l	alien_struct_ptr(a0),a1		;pointer to alien struct	
	move.w	alien_x(a1),d0
	sub.w	scroll_x_position,d0
	add.w	alien_shift,d0
	move.w	d0,d1
	andi.w	#$fff0,d0
	asr.w	#3,d0
	ext.l	d0
	add.l	d0,a3				;x position calc
	add.l	d0,a4
	
	andi.w	#$f,d1				;calc shift
	ror.w	#4,d1
	move.w	d1,d0
	or.w	#$FCA,d0
	swap	d0
	move.w	d1,d0
	
	move.w	alien_y(a1),d1
	sub.w	scroll_y_position,d1
	move.w	d1,d7
	muls	#BPR,d1
	add.l	d1,a3				;y position
	move.l	a3,alien_scr_pos(a0)		;store for later

	move.l	alien_type_ptr(a1),a2		;reference

	
*----test to see if alien over split point---------------
	move.w	split_position,d2

	move.w	d7,d1		;alien y
	cmp.w	d2,d1
	bge	alien_not_split_but_below_split
*alien is below split line	
	add.w	alien_y_size(a2),d1
	cmp.w	d2,d1
	ble	alien_not_split	
	
*--------------------Code if alien is split---------------------
		
	sub.w	d7,d2			;portion above split
	move.w	alien_y_size(a2),d1
	sub.w	d2,d1				;remaining height
	move.w	#1,alien_split(a0)
	move.w	alien_x_words(a2),d7
	asl.w	#6,d2
	add.w	d7,d2
	move.w	d2,alien_draw_height(a0)	;blit size 1

	asl.w	#6,d1
	add.w	d7,d1
	move.w	d1,alien_draw_height2(a0)	;blit size 2
	move.l	a4,alien_split_scr(a0)

*d1 and d2 are blit sizes for the two blits

	
	btst.b	#DIRECTION_ALIEN,alien_type_flags(a2)
	beq.s	not_a_directional_alien
	moveq	#0,d7
	move.w	alien_direction(a1),d7
	asl	#2,d7
	move.l	alien_mask(a2),a5
	move.l	(a5,d7),d6
	move.l	alien_graphics(a2),a5
	move.l	(a5,d7),a5
	bra.s	finished_getting_graphics
			
not_a_directional_alien		
	move.l	alien_graphics(a2),a5
	move.l	alien_mask(a2),d6
finished_getting_graphics

	move.w	alien_draw_frame(a0),d7
	

	btst	#7,d7		;alien hit
	beq.s	alien_not_split_hit

	bclr	#7,d7	
	mulu	alien_frame_size(a2),d7
	move.l	d6,a5
	add.l	d7,d6
	move.l	d6,a5
	moveq	#0,d7	;no inc for graphics
	bra.s	get_on_with_split_blit	
alien_not_split_hit
	mulu	alien_frame_size(a2),d7
	add.l	d7,a5
	add.l	d7,d6
	moveq	#0,d7
	move.w	alien_plane_size(a2),d7

get_on_with_split_blit	
		

*assume blit a pointer will be pointing to next part of alien
*graphics and mask - therefore dont re-init
	
	move.l	d0,bltcon0(a6)			;shifts etc
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	alien_mod(a2),bltcmod(a6)
	move.w	alien_mod(a2),bltdmod(a6)
	move.w	d2,bltsize(a6)

		
wait_for_alien_to_draw_p1_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p1_part1
	
	move.l	a4,bltcpth(a6)			;scr pos
	move.l	a4,bltdpth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_draw_p1_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p1_part2
	

	
	add.l	d7,a5
	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4
	
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_draw_p2_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p2_part1
	
	move.l	a4,bltcpth(a6)			;scr pos
	move.l	a4,bltdpth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_draw_p2_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p2_part2
	
	add.l	d7,a5
	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4


	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_draw_p3_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p3_part1
	
	move.l	a4,bltcpth(a6)			;scr pos
	move.l	a4,bltdpth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_draw_p3_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p3_part2
	
	add.l	d7,a5
	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4


	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_draw_p4_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p4_part1
	
	move.l	a4,bltcpth(a6)			;scr pos
	move.l	a4,bltdpth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_draw_p4_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p4_part2
	
	
	bra	finished_drawing_single_alien

	
*--------------------Code if alien not split--------------------	
alien_not_split_but_below_split
	sub.l	#SCROLL_HEIGHT*BPR,a3
	move.l	a3,alien_scr_pos(a0)		;store for later
alien_not_split	
	clr.w	alien_split(a0)

	btst.b	#DIRECTION_ALIEN,alien_type_flags(a2)
	beq.s	not_a_directional_normal_alien
	moveq	#0,d7
	move.w	alien_direction(a1),d7
	asl	#2,d7
	move.l	alien_mask(a2),a4
	move.l	(a4,d7),d6
	move.l	alien_graphics(a2),a4
	move.l	(a4,d7),a4
	bra.s	finished_getting_normal_graphics
	
not_a_directional_normal_alien	
	move.l	alien_graphics(a2),a4
	move.l	alien_mask(a2),d6
finished_getting_normal_graphics	
	move.w	alien_draw_frame(a0),d7
		
	
	btst	#7,d7
	beq.s	alien_not_hit_normal
	
	bclr	#7,d7
	mulu	alien_frame_size(a2),d7
	add.l	d7,d6
	move.l	d6,a4
	moveq	#0,d7
	bra.s	get_on_with_normal_blit
alien_not_hit_normal	
	mulu	alien_frame_size(a2),d7
	add.l	d7,a4
	add.l	d7,d6
	move.w	alien_plane_size(a2),d7

get_on_with_normal_blit
	
	move.l	d0,bltcon0(a6)			;shifts etc
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a4,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	alien_mod(a2),bltcmod(a6)
	move.w	alien_mod(a2),bltdmod(a6)
	move.w	alien_blit_size(a2),bltsize(a6)

		
wait_for_alien_to_draw_p1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p1

	add.l	#PLANE_INC,a3			;next plane
	add.l	d7,a4				;next bob plane
	
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a4,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_draw_p2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p2

	add.l	#PLANE_INC,a3			;next plane
	add.l	d7,a4 				;next bob plane
	
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a4,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_draw_p3
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p3
	
	add.l	#PLANE_INC,a3			;next plane
	add.l	d7,a4 				;next bob plane
	
	move.l	a3,bltcpth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.l	a4,bltbpth(a6)
	move.l	d6,bltapth(a6)
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_draw_p4
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_draw_p4


finished_drawing_single_alien		

*delete does not require struct pointer but only type struct ptr - so 
*write into the struct ptr (saves defining another one in the struct)		
	move.l	a2,alien_struct_ptr(a0)	
	
	add.l	#alien_draw_size,a0
	bra	draw_aliens_loop
finished_drawing_aliens
	rts



alien_shift				dc.w	0

current_alien_draw_position		dc.l	0

current_alien_split_draw_position	dc.l	0	
		
************************************************
******     DELETE ALIEN LIST              ******
************************************************
Delete_Alien_List

	move.l	alien_draw_ptr,a0
	bsr	Delete_Split_Aliens
	move.l	pri_alien_draw_ptr,a0
	bsr	Delete_Split_Aliens

	rts

************************************************
******     DELETE SPLIT ALIENS            ******
************************************************
Delete_Split_Aliens
*send list in a0

*Copy bitmap from copyback scroll area over aliens
delete_blits_not_fin
	btst	#14,dmaconr(a6)
	bne.s	delete_blits_not_fin
	
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09f00000,bltcon0(a6)
		
delete_aliens_loop
	cmp.l	#$ffffffff,(a0)
	beq	finished_deleting_aliens

*--------------------->
	
*the alien type struct is now contained in alien_struct_ptr
*this is because delete does not need it and it may have been 
*grabbed by an alien that has been added


	move.l	alien_struct_ptr(a0),a2	

*---------------------|

	move.l	alien_scr_pos(a0),a3
	move.l	a3,a5
	add.l	add_size,a5	;copy back position
		
	
	
*----test to see if alien over split point---------------

	tst.w	alien_split(a0)
	beq	delete_alien_not_split
	move.w	alien_draw_height(a0),d2  	;blit size 1
	move.w	alien_draw_height2(a0),d1 	;blit size 1
	
*--------------------Code if alien is split---------------------
	
*d1 and d2 are blit sizes for the two blits

	move.l	alien_split_scr(a0),a4
	move.l	a4,d7
	add.l	add_size,d7	;copy back position


	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	alien_mod(a2),bltamod(a6)
	move.w	alien_mod(a2),bltdmod(a6)
	move.w	d2,bltsize(a6)


		
wait_for_alien_to_delete_p1_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p1_part1
	
	move.l	a4,bltdpth(a6)			;scr pos
	move.l	d7,bltapth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_delete_p1_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p1_part2
	
	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4
	add.l	#PLANE_INC,a5
	add.l	#PLANE_INC,d7
	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_delete_p2_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p2_part1
	
	move.l	a4,bltdpth(a6)			;scr pos
	move.l	d7,bltapth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_delete_p2_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p2_part2
	
	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4
	add.l	#PLANE_INC,a5
	add.l	#PLANE_INC,d7


	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_delete_p3_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p3_part1
	
	move.l	a4,bltdpth(a6)			;scr pos
	move.l	d7,bltapth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_delete_p3_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p3_part2
	

	add.l	#PLANE_INC,a3
	add.l	#PLANE_INC,a4
	add.l	#PLANE_INC,a5
	add.l	#PLANE_INC,d7


	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	d2,bltsize(a6)
	
wait_for_alien_to_delete_p4_part1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p4_part1
	
	move.l	a4,bltdpth(a6)			;scr pos
	move.l	d7,bltapth(a6)			;dest
	move.w	d1,bltsize(a6)
	
wait_for_alien_to_delete_p4_part2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p4_part2
	
	bra	finished_deleting_single_alien

	
*--------------------Code if alien not split--------------------	
delete_alien_not_split
	
		
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	alien_mod(a2),bltamod(a6)
	move.w	alien_mod(a2),bltdmod(a6)
	move.w	alien_blit_size(a2),bltsize(a6)

		
wait_for_alien_to_delete_p1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p1

	add.l	#PLANE_INC,a3			;next plane
	add.l	#PLANE_INC,a5
	
	move.l	a5,bltapth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_delete_p2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p2

	add.l	#PLANE_INC,a3			;next plane
	add.l	#PLANE_INC,a5
	
	move.l	a5,bltapth(a6)			;scr pos
	move.l	a3,bltdpth(a6)			;dest
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_delete_p3
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p3
	
	add.l	#PLANE_INC,a3			;next plane
	add.l	#PLANE_INC,a5
	
	move.l	a3,bltdpth(a6)			;scr pos
	move.l	a5,bltapth(a6)			;dest
	move.w	alien_blit_size(a2),bltsize(a6)

wait_for_alien_to_delete_p4
	btst	#14,dmaconr(a6)
	bne.s	wait_for_alien_to_delete_p4


finished_deleting_single_alien				
	add.l	#alien_draw_size,a0
	bra	delete_aliens_loop
finished_deleting_aliens

	rts


************************************************
******     ADD ALIEN TO LIST              ******
************************************************
Add_Alien_To_List
*send x,y in d0 and d1
*send type in d2

*send in data in d3 - optional

	movem.l	a0-a2,-(sp)
	move.l	current_add_alien_ptr,a0
	cmp.l	#$ffffffff,(a0)
	beq.s	alien_list_full
	
	move.l	(a0)+,a1
	move.l	a0,current_add_alien_ptr
	
	move.w	d0,alien_x(a1)
	move.w	d1,alien_y(a1)
	clr.w	alien_frame(a1)
	clr.w	alien_flags(a1)  ;clears alien_c_pad as well
	clr.l	alien_map_pos(a1)
	move.l	#Species_Table,a0
	ext.l	d2
	asl	#2,d2
	move.l	(a0,d2.w),alien_type_ptr(a1)
	move.l	alien_type_ptr(a1),a2
	move.l	alien_pattern_ptr(a2),alien_pat_ptr(a1)
	move.w	alien_frame_rate(a2),alien_frame_counter(a1)
	move.w	alien_hit_count(a2),alien_hits(a1)
	move.w	d3,alien_data(a1)
	move.l	current_alien_list_ptr,a0
	move.l	a1,(a0)+
	move.l	#$ffffffff,(a0)
	move.l	a0,current_alien_list_ptr
	movem.l	(sp)+,a0-a2
	
alien_list_full
	rts


************************************************
******     SIMPLE ADD ALIEN TO LIST       ******
************************************************
Simple_Add_Alien_To_List
*send x,y in d0 and d1
*send pointer in d2

*d3 alien data is optional

*no stack saves made

	move.l	current_add_alien_ptr,a0
	cmp.l	#$ffffffff,(a0)
	beq.s	salien_list_full
	
	move.l	(a0)+,a1
	move.l	a0,current_add_alien_ptr
	
	move.w	d0,alien_x(a1)
	move.w	d1,alien_y(a1)
	clr.l	alien_map_pos(a1)	;make non-map alien
	clr.b	alien_work(a1)		;do we need this?
	clr.l	alien_frame(a1)		'clears and flags & cpad as well
	move.w	#4,alien_direction(a1)	;test
	move.l	d2,alien_type_ptr(a1)
	move.l	alien_type_ptr(a1),a2
	move.l	alien_pattern_ptr(a2),alien_pat_ptr(a1)
	move.w	alien_frame_rate(a2),alien_frame_counter(a1)
	move.w	alien_hit_count(a2),alien_hits(a1)
	move.w	d3,alien_data(a1)
	
	move.l	current_alien_list_ptr,a0
	move.l	a1,(a0)+
	move.l	#$ffffffff,(a0)
	move.l	a0,current_alien_list_ptr
	
salien_list_full
	rts



************************************************
******     PROCESS ALIENS                 ******
************************************************
Process_Aliens

*Only a quick version just so can see aliens up and running

	move.l	#active_alien_pointers,a0
	move.l	alien_draw_ptr,a1
	move.l	pri_alien_draw_ptr,a6
	
	move.l	a0,a3
process_loop
	cmp.l	#$ffffffff,(a0)
	beq	finished_processing_aliens

	move.l	(a0),a2
	
*Dont draw alien if out of screen

	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	sub.w	scroll_x_position,d0
	sub.w	scroll_y_position,d1
	
	move.l	alien_type_ptr(a2),a4
	
	
	move.w	alien_frame(a2),alien_draw_frame(a1)
	move.w	alien_frame(a2),alien_draw_frame(a6)


*-----------------Test Alien Flags----------------

	btst.b	#ALIEN_HIT,alien_flags(a2)
	beq.s	alien_not_hit
	btst.b	#ALIEN_PRI,alien_type_flags(a4)
	beq.s	using_norm_list
	bset.b	#7,alien_draw_frame+1(a6)
	bra.s	alien_not_hit
using_norm_list
	bset.b	#7,alien_draw_frame+1(a1)
alien_not_hit
		
*-----------------Update alien frame-------------

	tst	alien_frame_rate(a4)
	bmi.s	dont_update_alien_frame	
	subq.w	#1,alien_frame_counter(a2)
	bgt.s	dont_update_alien_frame
	addq.w	#1,alien_frame(a2)
	move.w	alien_frame_rate(a4),alien_frame_counter(a2)	
	move.w	alien_number_frames(a4),d2
	cmp.w	alien_frame(a2),d2
	bgt.s	dont_update_alien_frame
	clr.w	alien_frame(a2)	
dont_update_alien_frame	

*---

*-----------------Process alien pattern-------------

	movem.l	a3/a1,-(sp)
	move.l	#Alien_Commands,a3

	move.l	alien_pat_ptr(a2),a5
process_alien_pattern_loop	
	cmp.w	#START_COMMANDS,(a5)
	bgt.s	process_alien_command

*else update alien position using x and y values

	move.w	(a5)+,d2
	add.w	d2,alien_x(a2)	
	move.w	(a5)+,d2	
	add.w	d2,alien_y(a2)	
	bra.s	done_alien_process
process_alien_command
	moveq	#0,d7	
	move.w	(a5)+,d7
	sub.w	#OBJECT_SET_PAT,d7
	asl.w	#2,d7
	move.l	(a3,d7),a1
	jsr	(a1)
	bra.s	process_alien_pattern_loop
	
done_alien_process
	movem.l	(sp)+,a3/a1

	move.l	a5,alien_pat_ptr(a2)

	btst.b	#ALIEN_DEAD,alien_flags(a2)
	bne	kill_off_alien



*---------Only draw alien if on screen----------------

	btst.b	#OFF_SCREEN_ALIEN,alien_type_flags(a4)
	beq.s	dont_bother_checking_off_Screen
	cmp.w	#-48-64,d0
	ble.s	set_alien_map_bit
	cmp.w	#320+64,d0
	bge.s	set_alien_map_bit
	cmp.w	#-48-64,d1
	ble.s	set_alien_map_bit
	cmp.w	#240+32+64,d1
	bge.s	set_alien_map_bit
	bra.s	dont_bother_checking_off_Screen
set_alien_map_bit	
	tst	alien_map_pos(a2)
	beq.s	see_if_alien_needs_to_call_anything
	move.l	alien_map_pos(a2),a5
	bclr.b	#ALIEN_BUSY,(a5)
see_if_alien_needs_to_call_anything	

* Call routine for alien going out

	moveq	#0,d7
	move.b	alien_type_number(a4),d7
	asl.w	#2,d7
	move.l	#Alien_Out_Call_Table,a5
	move.l	(a5,d7.w),d7
	beq.s	remove_alien_from_list
	move.l	d7,a5
	jsr	(a5)	

	bra.s	remove_alien_from_list
	
dont_bother_checking_off_Screen	
	cmp.w	#-48,d0
	ble.s	dont_draw_alien
	cmp.w	#320+32,d0
	bge.s	dont_draw_alien
	cmp.w	#-48,d1
	ble.s	dont_draw_alien
	cmp.w	#240+32,d1
	bge.s	dont_draw_alien
	
	btst.b	#ALIEN_PRI,alien_type_flags(a4)
	bne.s	add_to_pri_list
	move.l	a2,alien_struct_ptr(a1)		
	add.l	#alien_draw_size,a1
	bra.s	dont_draw_alien
add_to_pri_list
	move.l	a2,alien_struct_ptr(a6)		
	add.l	#alien_draw_size,a6	
dont_draw_alien	

	move.l	a2,(a3)+	;so will be processed next time round
	bra.s	get_next_alien
kill_off_alien	
	tst.l	alien_map_pos(a2)
	beq.s   remove_alien_from_list  ;alien not added via map
	move.l	alien_map_pos(a2),a5
	clr.b	(a5)			     ;never coming back
remove_alien_from_list

	move.l	current_add_alien_ptr,a5
	subq.l	#4,a5
	move.l	a2,(a5)
	
	btst.b	#ATTACHED_ALIEN,alien_type_flags(a4)
	beq.s	not_an_attached_alien
	move.l	alien_work+4(a2),a4	;kill any attached aliens
	cmp.l	#0,a4			;ensure alien still attached (must do cmp as move to an does not set flags)
	beq.s	not_an_attached_alien
	bset.b	#ALIEN_DEAD,alien_flags(a4)
not_an_attached_alien
	move.l	a5,current_add_alien_ptr
get_next_alien

	clr.b	alien_flags(a2)

	addq.l	#4,a0
	bra	process_loop	
finished_processing_aliens		
	move.l	#$ffffffff,(a1)			;term draw list
	move.l	#$ffffffff,(a6)
	move.l	a6,end_alien_draw_ptr
	move.l	#$dff000,a6
	move.l	#$ffffffff,(a3)			;active aliens list
	move.l	a3,current_alien_list_ptr
	rts



*----------------Alien Pattern Commmands

Alien_Commands
	dc.l	Alien_Object_Set_Pat
	dc.l	Alien_Object_Set_Frame
	dc.l	Alien_Object_Kill
	dc.l	Alien_Object_Add
	dc.l	Alien_Object_Simple_Add
	dc.l	Alien_Bullet_List_Add
	dc.l	Alien_Pattern_Restart
	dc.l	Alien_Sound_Effect_1
	dc.l	Alien_Sound_Effect_2
	dc.l	Alien_Sound_Effect_3
	dc.l	Alien_Sound_Effect_4
	dc.l	Alien_Execute_Code
	dc.l	Alien_Object_Simple_Add_Lots
	dc.l	Alien_Object_Set_Counter
	dc.l	Alien_Object_Until
	dc.l	Alien_Hit_Pattern_Restart
	dc.l	Alien_Dont_Go_Anywhere
	dc.l	Alien_Pause_Anim
	dc.l	Alien_Cont_Anim
	dc.l	Alien_Object_Simple_Add_Transform
	dc.l	Alien_Update_Score
	dc.l	Alien_Attach_X
	dc.l	Alien_Kill_Next_Alien
	dc.l	Alien_Object_Simple_Add_Connect
	dc.l	Alien_Attach_Y
	dc.l	Alien_Attach_XY
	dc.l	Alien_Object_Decrease
	dc.l	Alien_Object_Test
	dc.l	Alien_Object_Increase
	dc.l	Alien_Get_Random_Pig_Noise
	dc.l	Alien_Add_To_Map
	dc.l	Alien_Restart_Pattern_Skip_Pos
	dc.l	Alien_Distance_Check
	dc.l	Alien_Start_Script
	dc.l	Alien_Wave_Test
	dc.l	Alien_Object_Simple_Add_Transform_Wave
	dc.l	Alien_Burn_Block_Routine
	dc.l	Alien_Activate_Script
	dc.l	Alien_Check_Hits
	dc.l	Alien_Object_Set_Random_Counter
	dc.l	Alien_Set_Alien_Direction
	dc.l	Alien_Set_Variable
	dc.l	Alien_BlowUp_Next_Alien
	dc.l	Alien_Botch	
	dc.l	Alien_Pattern_Botch
	dc.l	Alien_Change_Type

Alien_Change_Type
	move.l	(a5)+,alien_type_ptr(a2)
	rts

Alien_Set_Variable
	move.l	a4,d7
	move.l	(a5)+,a4	
	move.w	(a5)+,(a4)
	move.l	d7,a4
	rts
	
Alien_Set_Alien_Direction
	move.w	(a5)+,alien_direction(a2)
	rts

Alien_Object_Set_Counter
	move.w	(a5)+,alien_counter(a2)
	rts

Alien_Object_Set_Random_Counter
	move.w	d0,d6
	move.w	d1,d7
	move.w	(a5)+,d0
	move.w	(a5)+,d1
	bsr	Get_Random_Number
	move.w	d0,alien_counter(a2)
	move.w	d6,d0
	move.w	d7,d1	
	rts

	
Alien_Object_Until
	subq.w	#1,alien_counter(a2)
	bne.s	alien_counter_not_zero
	addq.l	#4,a5
	rts	
alien_counter_not_zero		
	move.l	(a5)+,a5
	rts
		
Alien_Sound_Effect_1
	move.w	(a5)+,sound_chan1
	rts		

Alien_Sound_Effect_2
	move.w	(a5)+,sound_chan2
	rts	
		
Alien_Sound_Effect_3
	move.w	(a5)+,sound_chan3
	rts		
	
Alien_Sound_Effect_4
	move.w	(a5)+,sound_chan4
	rts		
		
Alien_Bullet_List_Add
	movem.l	a0-a1/a3/d0/d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Add_Bullet_To_List
	movem.l	(sp)+,a0-a1/a3/d0/d1
	rts		
	
Alien_Object_Add
	movem.l	d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.w	(a5)+,d2
	bsr	Add_Alien_To_List
	movem.l	(sp)+,d0-d1
	rts	
	
Alien_Object_Simple_Add
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	movem.l	(sp)+,a0-a2/d0-d1
	rts	

Alien_Object_Simple_Add_Lots
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
Keep_Adding_Simples	
	move.l	(a5)+,d2
	cmp.l	#$ffffffff,d2
	beq.s	finished_adding_simples
	bsr	Simple_Add_Alien_To_List
	bra.s	Keep_Adding_Simples
finished_adding_simples	
	movem.l	(sp)+,a0-a2/d0-d1
	rts	
	
	
Alien_Object_Set_Frame
	move.w	(a5)+,alien_frame(a2)
	rts
	
Alien_Object_Set_Pat
	move.l	(a5)+,a5
	rts

Alien_Pattern_Restart
	move.l	alien_pattern_ptr(a4),a5
	rts
	
Alien_Object_Kill
	bset.b	#ALIEN_DEAD,alien_flags(a2)
	rts

Alien_Execute_Code
	move.l	(a5)+,a1
	jsr	(a1)
	rts

Alien_Hit_Pattern_Restart
	move.l	alien_pattern_ptr(a4),a5
	bclr.b	#ALIEN_HIT_PAT,alien_hit_info(a2)
	rts
	

Alien_Dont_Go_Anywhere
	subq.l	#6,a5
	rts

Alien_Pause_Anim
	move.w	#30000,alien_frame_counter(a2)
	rts
	
Alien_Cont_Anim
	clr.w	alien_frame_counter(a2)
	rts
				
Alien_Object_Simple_Add_Transform
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.l	alien_map_pos(a2),d7
	clr.l	alien_map_pos(a2)
	move.w	alien_hits(a2),d6
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	move.l	d7,alien_map_pos(a1)
	move.w	d6,alien_hits(a1)	
	movem.l	(sp)+,a0-a2/d0-d1
	rts	

Alien_Botch
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.l	alien_work+4(a2),d7
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	move.l	d7,alien_work+4(a1)
	movem.l	(sp)+,a0-a2/d0-d1
	rts	

Alien_Pattern_Botch
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	move.l	(a5)+,alien_pat_ptr(a1)
	movem.l	(sp)+,a0-a2/d0-d1
	rts	

				
Alien_Update_Score
	move.w	(a5)+,d7
	add.w	d7,inter_score
	rts			
	
Alien_Attach_X
	move.l	a0,d7
	move.l	alien_work+8(a2),a0
	move.w	alien_x(a0),alien_x(a2)
	move.l	d7,a0
	rts

Alien_Kill_Next_Alien
	move.l	a0,d7	;kill attached alien
	move.l	alien_work+4(a2),a0
	bset.b	#ALIEN_DEAD,alien_flags(a0)
	clr.l	alien_work+4(a2)	;clear - i.e no attached
	move.l	d7,a0
	rts	

Alien_BlowUp_Next_Alien
	move.l	a0,d7	;kill attached alien
	move.l	a1,d6
	move.l	alien_work+4(a2),a0
	move.l	alien_type_ptr(a0),a1
	move.l	alien_dead_pattern(a1),alien_pat_ptr(a0)
	clr.l	alien_work+4(a2)	;clear - i.e no attached
	move.l	d7,a0
	move.l	d6,d1
	rts	


Alien_Object_Simple_Add_Connect
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	move.l	a2,d7
	bsr	Simple_Add_Alien_To_List
	move.l	d7,alien_work+8(a1)	;reference to master
	move.l	a1,d7
	movem.l	(sp)+,a0-a2/d0-d1
	move.l	d7,alien_work+4(a2)	;reference to slave (for killing)
	rts	
	
Alien_Attach_Y
	move.l	a0,d7
	move.l	alien_work+8(a2),a0
	move.w	alien_y(a0),alien_y(a2)
	move.l	d7,a0
	rts

Alien_Attach_XY
	move.l	a0,d7
	move.l	alien_work+8(a2),a0
	move.w	alien_x(a0),alien_x(a2)
	move.w	alien_y(a0),alien_y(a2)
	move.l	d7,a0
	rts
	
	
Alien_Object_Decrease
	move.l	a6,d7
	move.l	(a5)+,a6	
	subq.w	#1,(a6)
	move.l	d7,a6
	rts
	
Alien_Object_Test
	move.l	a6,d7
	move.l	(a5)+,a6
	move.w	(a5)+,d6
	cmp.w	(a6),d6
	beq.s	use_the_pointer
	move.l	d7,a6
	addq.l	#4,a5
	rts	
use_the_pointer
	move.l	(a5)+,a5
	move.l	d7,a6
	rts	
		
Alien_Object_Increase
	move.l	a6,d7
	move.l	(a5)+,a6	
	addq.w	#1,(a6)
	move.l	d7,a6
	rts
		
Alien_Get_Random_Pig_Noise
	moveq	#0,d5
	move.l	a1,d7
	move.l	random_direction_ptr,a1	
	move.b	(a1)+,d5
	cmp.b	#-1,(a1)
	bne.s	not_end_get_pn
	move.l	#random_direction_table,a1
not_end_get_pn
	move.l	a1,random_direction_ptr	
	lsl.w	d5
	move.l	#Random_Pig_Noise_Table,a1
	move.w	(a1,d5),sound_chan3
	move.l	d7,a1
	rts

Random_Pig_Noise_Table
	dc.w	Sound_PigDie
	dc.w	Sound_PigDie4		
	dc.w	Sound_PigDie3
	dc.w	Sound_PigDie3
	dc.w	Sound_PigDie2
	dc.w	Sound_PigDie
	dc.w	Sound_PigDie4
	dc.w	Sound_PigDie2
	dc.w	Sound_PigDie3
	dc.w	Sound_PigDie4
	dc.w	Sound_PigDie
	dc.w	Sound_PigDie
	dc.w	Sound_PigDie2
	dc.w	Sound_PigDie3
	
Alien_Object_Simple_Add_Transform_Wave
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.l	alien_script(a2),d7
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	move.l	d7,alien_script(a1)
	movem.l	(sp)+,a0-a2/d0-d1
	rts	
	

Alien_Add_To_Map
	move.l	a5,d7

	moveq	#0,d4
	move.w	alien_x(a2),d4	
	move.w	alien_y(a2),d3	

	move.l	current_alien_map_pointer,a5
	asr	#4,d4
	asr	#4,d3
	mulu	#BIGGEST_MAP_X,d3
	add.l	d4,d3
	move.b	alien_type_number(a4),d2
	add.b	#128,d2		;i.e active at moment
	add.l	d3,a5
	move.b	d2,(a5)
	move.l	a5,alien_map_pos(a2)
	
	
	move.l	d7,a5
	rts

Alien_Restart_Pattern_Skip_Pos	
	move.l	alien_pattern_ptr(a4),a5
	addq.l	#4,a5
	rts
	
Alien_Distance_Check
	move.w	(a5)+,d5
	move.w	alien_x(a2),d6
	move.w	alien_y(a2),d7
	
	sub.w	actual_player_map_x_position,d6
	bpl.s	dont_neg_guard_x
	neg.w	d6
dont_neg_guard_x
	cmp.w	d5,d6
	bgt.s	dont_add_guard	
	sub.w	actual_player_map_y_position,d7
	bpl.s	dont_neg_guard_y
	neg.w	d7
dont_neg_guard_y	
	cmp.w	d5,d7
	bgt.s	dont_add_guard	
	move.l	(a5)+,a5
	rts
dont_add_guard
	addq.l	#4,a5
	rts	

Alien_Start_Script
	movem.l	a0/a1,-(sp)
	move.l	(a5)+,a0	;var containing address
	move.l	switch_list_pointer,a1
	move.l	(a0),(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
	movem.l	(sp)+,a0/a1
	rts

Alien_Wave_Test
	move.l	a1,d7
	move.l	alien_script(a2),a1
	subq.w	#1,(a1)+
	bne.s	dont_jump_in_script
	move.l	(a1),a5		;do bonus part of script
dont_jump_in_script
	move.l	d7,a1
	rts	

Alien_Activate_Script
	movem.l	a0/a1,-(sp)
	move.l	switch_list_pointer,a1
	move.l	(a5)+,(a1)+	;var containing address
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
	movem.l	(sp)+,a0/a1
	rts

Alien_Check_Hits
	move.w	(a5)+,d7
	move.l	(a5)+,d6
	cmp.w	alien_hits(a2),d7
	beq.s	No_Problem_Hits_Intact
	move.l	d6,a5
No_Problem_Hits_Intact			
	rts

********************************************
**	BURN POST BLOCK                  ***
********************************************
Alien_Burn_Block_Routine
	move.w	(a5)+,d2	;block to add
	movem.l	d0-d1/a3/a5,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	sub.w	scroll_y_position,d1
	bsr	Draw_68000_Block_Into_CopyBack
	movem.l	(sp)+,d0-d1/a3/a5
	rts		

*----------------End Alien pattern commands


************************************************
******     DO ALIEN COLLISION             ******
************************************************
Do_Alien_Collision

*Test aliens against bullets

	move.l	#Active_Alien_Pointers,a0
test_alien_loop
	move.l	(a0)+,a1
	cmp.l	#$ffffffff,a1
	beq	finished_testing_aliens
	
	move.l	alien_type_ptr(a1),a4
	btst.b	#ALIEN_NO_COLLISION,alien_type_flags(a4)
	bne.s	test_alien_loop
	
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	move.w	d0,d2
	move.w	d1,d3
	add.w	alien_x_size(a4),d2
	add.w	alien_y_size(a4),d3
	
	move.l	#Active_Bullet_Pointers,a2
test_bullet_loop	
	move.l	(a2)+,a3
	cmp.l	#$ffffffff,a3
	beq	finished_testing_bullets
	
	tst.w	bullet_dead_flag(a3)
	bne.s	test_bullet_loop
	
	move.l	bullet_type_ptr(a3),a5
	
	
*test x side	
	cmp.w	bullet_x(a3),d2
	blt.s	test_bullet_loop	;not hit
				
	move.w	bullet_x(a3),d4
	add.w	alien_x_size(a5),d4
	
	cmp.w	d4,d0
	bgt.s	test_bullet_loop	;not hit
	
*test y 	
	cmp.w	bullet_y(a3),d3
	blt.s	test_bullet_loop	;not hit
		
	move.w	bullet_y(a3),d4
	add.w	alien_y_size(a5),d4
	cmp.w	d4,d1
	bgt.s	test_bullet_loop	;not hit
	
*----Bullet has hit alien---	

	btst	#NO_EXPLODE,alien_type_flags(a5)	;bullet
	bne.s	bullet_no_die				
	
	tst.w	alien_hit_count(a5)
	ble.s	bullet_dead_pal
	move.w	alien_hits(a1),d4
	sub.w	d4,bullet_hits(a3)
	bgt.s	bullet_no_die
bullet_dead_pal	
	move.w	#Sound_Thud2,sound_chan2
	move.w	#1,bullet_dead_flag(a3)				
bullet_no_die	

	btst.b	#ONE_HIT,alien_type_flags(a4)
	beq.s	not_a_one_hit_alien
	btst.b	#ALIEN_HIT,alien_flags(a1)	
	bne.s	test_bullet_loop
	

not_a_one_hit_alien

	subq.w	#1,alien_hits(a1)	;no longer gun power
	bgt.s	alien_not_dead_yet
	move.l	alien_dead_pattern(a4),alien_pat_ptr(a1)
	
	bra.s	not_a_hit_pattern_alien
		
alien_not_dead_yet	
	bset.b	#ALIEN_HIT,alien_flags(a1)
	btst.b	#HIT_PATTERN,alien_type_flags(a4)
	beq.s	not_a_hit_pattern_alien
	bset.b	#ALIEN_HIT_PAT,alien_hit_info(a1) ;test bit and set
	bne	test_bullet_loop
ignor_test	
	move.l	alien_hit_pattern(a4),alien_pat_ptr(a1)
not_a_hit_pattern_alien	

	bra	test_bullet_loop	
finished_testing_bullets
	bra	test_alien_loop
		
finished_testing_aliens	
	
	rts

************************************************
******     DO PLAYER ALIEN COLLISION      ******
************************************************
Do_Player_Alien_Collision

*Test aliens against player


	move.w	actual_player_map_x_position,d5
	add.w	player_x_in,d5
	move.w	actual_player_map_y_position,d6
	add.w	player_y_in,d6
	
	move.l	#Man_Alien_Collision_Table,a3
	move.l	#Active_Alien_Pointers,a0
test_player_alien_loop
	move.l	(a0)+,a1
	cmp.l	#$ffffffff,a1
	beq.s	finished_testing_player_aliens
	
	move.l	alien_type_ptr(a1),a2
	btst.b	#PLAYER_NO_COLLISION,alien_type_flags(a2)
	bne.s	test_player_alien_loop
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	move.w	d0,d2
	move.w	d1,d3
	add.w	alien_x_size(a2),d2
	add.w	alien_y_size(a2),d3
	
		
*test x side	
	cmp.w	d5,d2
	blt	test_player_alien_loop	;not hit
				
	move.w  d5,d4
	add.w	#16,d4			;***for now
	
	cmp.w	d4,d0
	bgt	test_player_alien_loop	;not hit
	
*test y 	
	cmp.w	d6,d3
	blt	test_player_alien_loop	;not hit
		
	move.w	d6,d4
	add.w	#16,d4
	cmp.w	d4,d1
	bgt.s	test_player_alien_loop	;not hit
	
*----Player has hit alien---	
	moveq	#0,d7
	move.b	alien_type_number(a2),d7
	lsl.w	#2,d7
	move.l	(a3,d7.l),d7
	beq.s	dont_call_hit_routine
	move.l	d7,a4
	jsr	(a4)
dont_call_hit_routine	
*----------			
	bra	test_player_alien_loop
		
finished_testing_player_aliens	
	
	rts

************************************************
******     EXTRACT PIGS FROM ALIEN LIST   ******
************************************************
Extract_Pigs_From_Alien_List

	move.l	#pig_list,a0
	move.l	#Active_Alien_Pointers,a1
	move.l	#Alien1_Graphics_Table,d0
extract_pig_loop
	move.l	(a1)+,a2
	cmp.l	#$ffffffff,a2
	beq.s	end_extract_pig

	move.l	alien_type_ptr(a2),a3
	cmp.l	alien_graphics(a3),d0
	bne.s	extract_pig_loop
add_pig_to_loop	
	move.l	a2,(a0)+
	bra.s	extract_pig_loop
end_extract_pig		
	move.l	#$ffffffff,(a0)
	rts


************************************************
******     DO PIG ON PIG COLLISION        ******
************************************************
Do_Pig_On_Pig_Collision
*send alien structure pointer in a2
*send x and y incs in d0 and d1
*will return if hit another alien in variable pig_hit_flags

*This is rather sloppy collision, but I dont want to waste
*to much CPU time testing pigs on pigs becuase its such a small
*enhancement and such a lot of processing.

*--set up test values

	move.w	d0,d5	;move inc values
	move.w	d1,d6

	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	move.l	alien_type_ptr(a2),a3
	move.w	d0,d2
	move.w	d1,d3
	addq.w	#4,d0
	addq.w	#4,d1
	add.w	#PIG_ALIEN_WIDTH-4,d2
	add.w	#PIG_ALIEN_HEIGHT-4,d3
	
*--	


	clr.b	pig_hit_flags
	move.l	#Pig_list,a4
test_alien_on_alien_loop
	move.l	(a4)+,a5
	cmp.l	#$ffffffff,a5
	beq	finished_testing_pigs_on_pigs

	cmp.l	a2,a5
	beq.s	test_alien_on_alien_loop	;dont test self on self
		
*-- Need to do two tests -one for x and one for y		
		
*-- First test for when X added on		
			
*test x side	
	movem.w	d0/d2,-(sp)
	add.w	d5,d0
	add.w	d5,d2
	move.w	alien_x(a5),d4
	addq.w	#4,d4
	cmp.w	d4,d2
	blt.s	test_for_y_added_on	;not hit
				
	add.w	#PIG_ALIEN_WIDTH-8,d4
	cmp.w	d4,d0
	bgt.s	test_for_y_added_on	;not hit
	
*test y 	
	move.w	alien_y(a5),d4
	addq.w	#4,d4
	cmp.w	d4,d3
	blt.s	test_for_y_added_on	;not hit
		
	add.w	#PIG_ALIEN_HEIGHT-8,d4
	cmp.w	d4,d1
	bgt.s	test_for_y_added_on	;not hit
	
	
	bset.b	#0,pig_hit_flags			;x hit
test_for_y_added_on	

	movem.w	(sp)+,d0/d2		;restore x

*test x side	
	movem.w	d1/d3,-(sp)
	add.w	d6,d1
	add.w	d6,d3
	
	move.w	alien_x(a5),d4
	addq.w	#4,d4
	cmp.w	d4,d2
	blt	no_hit_on_alien_y	;not hit
				
	add.w	#PIG_ALIEN_WIDTH-8,d4
	
	cmp.w	d4,d0
	bgt.s	no_hit_on_alien_y	;not hit
	
*test y 	
	move.w	alien_y(a5),d4
	addq.w	#4,d4
	cmp.w	d4,d3
	blt.s	no_hit_on_alien_y	;not hit
		
	add.w	#PIG_ALIEN_HEIGHT-8,d4
	cmp.w	d4,d1
	bgt.s	no_hit_on_alien_y	;not hit


	bset.b	#1,pig_hit_flags
no_hit_on_alien_y
	movem.w	(sp)+,d1/d3
	cmp.w	#3,d7
	bne	test_alien_on_alien_loop	;exit if x,y hit	
		
finished_testing_pigs_on_pigs
	
	rts
	
pig_hit_flags
	dc.b	0
	even	






*--------------------Alien structure definition------------------

*---Alien Bit Flags

ALIEN_DEAD			EQU	0
ALIEN_HIT			EQU	1
ALIEN_PRIORITY			EQU	2
ALIEN_HIT_PAT			EQU	3

*---Alien map flags

ALIEN_BUSY			EQU	7


*---Alien add list structure

	rsreset

Add_Alien_Number rs.w   1	
Add_X_Position	 rs.w	1
Add_Y_Position   rs.w   1
Add_Map_Position rs.l   1
Add_Struct_Size  rs.w   1

*---Alien Structure

	rsreset
	
alien_x			rs.w	1
alien_y			rs.w	1
alien_type_ptr		rs.l	1		;pointer to struct containing info	
alien_pat_ptr		rs.l	1
alien_frame_counter	rs.w	1
alien_frame		rs.w	1						
alien_flags		rs.b	1
alien_c_pad		rs.b	1
alien_hit_info		rs.w	1
alien_hits		rs.w	1
alien_counter		rs.w	1
alien_direction		rs.w	1		;only used for such aliens
alien_data		rs.w	1		;for working on
alien_data_extra	rs.w	1
alien_work		rs.w	6
*alien_list_data		rs.w	20		;list data - christ this should have been re-written
alien_script		rs.l	1		;in case needs to have user defined script
alien_map_pos		rs.l	1		;if added via map != 0
alien_struct_size	rs.w	1

*---Alien Draw Structure

	rsreset

*---  ^ = filled in at draw time

alien_struct_ptr   	rs.l	1	
alien_draw_frame	rs.w 	1
alien_scr_pos	   	rs.l	1	;^
alien_split	   	rs.w 	1	;^
alien_split_scr    	rs.l	1	;^
alien_draw_height  	rs.w 	1	;^
alien_draw_height2 	rs.w	1	;^
alien_draw_size	   	rs.w	1	


