*------------------------------------------------------------------------*
*- I did have some cool code in here for chain re-action block          -*
*- But Myles would not do any graphics especially for them!		-*
*------------------------------------------------------------------------*
*****************************************
****     DRAW BLOCK INTO COPYBACK   *****-
*****************************************	
Draw_Block_Into_CopyBack	
*Send x and y in d0 and d1
*Send graphics in a5

	
Wait_For_Block_Go
	btst	#14,dmaconr(a6)
	bne.s	Wait_For_Block_Go
	
	move.l	#$ffffffff,bltafwm(a6)
	move.l	#$09f00000,bltcon0(a6)
	clr.w	bltamod(a6)
	
	move.l	current_alien_draw_position,a3

	andi.w	#$fff0,d0
	asr.w	#3,d0
	ext.l	d0
	
	move.w	d1,d7
	muls	#BPR,d1

*----test to see if alien over split point---------------

	cmp.w	split_position,d7
	blt	block_not_split
	sub.l	#SCROLL_HEIGHT*BPR,a3	
block_not_split	
	add.l	d1,a3		;y position	
	add.l	add_size,a3	;copy back pos
	add.l	d0,a3		;x position
	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	#BPR-2,bltdmod(a6)
	move.w	#16<<6+1,bltsize(a6)

		
wait_for_block_to_draw_p1
	btst	#14,dmaconr(a6)
	bne.s	wait_for_block_to_draw_p1

	add.l	#PLANE_INC,a3			;next plane
	add.l	#16*2,a5				;next bob plane
	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	#16<<6+1,bltsize(a6)

wait_for_block_to_draw_p2
	btst	#14,dmaconr(a6)
	bne.s	wait_for_block_to_draw_p2

	add.l	#PLANE_INC,a3			;next plane
	add.l	#16*2,a5 				;next bob plane
	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	#16<<6+1,bltsize(a6)

wait_for_block_to_draw_p3
	btst	#14,dmaconr(a6)
	bne.s	wait_for_block_to_draw_p3
	
	add.l	#PLANE_INC,a3			;next plane
	add.l	#16*2,a5 				;next bob plane
	
	move.l	a3,bltdpth(a6)			;dest
	move.l	a5,bltapth(a6)
	move.w	#16<<6+1,bltsize(a6)

wait_for_block_to_draw_p4
	btst	#14,dmaconr(a6)
	bne.s	wait_for_block_to_draw_p4

finished_drawing_single_block
	rts
	
	
**********************************************
****    DRAW 68000 BLOCK INTO COPYBACK   *****
**********************************************	
Draw_68000_Block_Into_CopyBack	
*Send x and y in d0 and d1
*Send block number in d2

	cmp.w	#BLK_X_MIN,d0
	blt	dont_draw_68000_block
	cmp.w	#BLK_X_MAX,d0
	bgt	dont_draw_68000_block
	cmp.w	#BLK_Y_MIN,d1
	blt	dont_draw_68000_block
	cmp.w	#BLK_Y_MAX,d1
	bgt	dont_draw_68000_block

	ext.l	d2
	move.l	background_block_graphics,a5
	asl.l	#7,d2
	add.l	d2,a5	;block graphics	
	move.l	current_alien_draw_position,a3
	
	andi.w	#$fff0,d0
	asr.w	#3,d0
	ext.l	d0
	
	move.w	d1,d7
	muls	#BPR,d1
	
*----test to see if alien over split point---------------

	cmp.w	split_position,d7
	blt	block_not_split68000
	sub.l	#SCROLL_HEIGHT*BPR,a3	
block_not_split68000	
	add.l	d1,a3		;y position	
	add.l	add_size,a3	;copy back pos
	add.l	d0,a3		;x position
	
	move.w	(a5)+,(a3)
	move.w	(a5)+,BPR(a3)
	move.w	(a5)+,BPR*2(a3)
	move.w	(a5)+,BPR*3(a3)
	move.w	(a5)+,BPR*4(a3)
	move.w	(a5)+,BPR*5(a3)
	move.w	(a5)+,BPR*6(a3)
	move.w	(a5)+,BPR*7(a3)
	move.w	(a5)+,BPR*8(a3)
	move.w	(a5)+,BPR*9(a3)
	move.w	(a5)+,BPR*10(a3)
	move.w	(a5)+,BPR*11(a3)
	move.w	(a5)+,BPR*12(a3)
	move.w	(a5)+,BPR*13(a3)
	move.w	(a5)+,BPR*14(a3)
	move.w	(a5)+,BPR*15(a3)
		
	add.l	#PLANE_INC,a3
	
	move.w	(a5)+,(a3)
	move.w	(a5)+,BPR(a3)
	move.w	(a5)+,BPR*2(a3)
	move.w	(a5)+,BPR*3(a3)
	move.w	(a5)+,BPR*4(a3)
	move.w	(a5)+,BPR*5(a3)
	move.w	(a5)+,BPR*6(a3)
	move.w	(a5)+,BPR*7(a3)
	move.w	(a5)+,BPR*8(a3)
	move.w	(a5)+,BPR*9(a3)
	move.w	(a5)+,BPR*10(a3)
	move.w	(a5)+,BPR*11(a3)
	move.w	(a5)+,BPR*12(a3)
	move.w	(a5)+,BPR*13(a3)
	move.w	(a5)+,BPR*14(a3)
	move.w	(a5)+,BPR*15(a3)

	add.l	#PLANE_INC,a3
	
	move.w	(a5)+,(a3)
	move.w	(a5)+,BPR(a3)
	move.w	(a5)+,BPR*2(a3)
	move.w	(a5)+,BPR*3(a3)
	move.w	(a5)+,BPR*4(a3)
	move.w	(a5)+,BPR*5(a3)
	move.w	(a5)+,BPR*6(a3)
	move.w	(a5)+,BPR*7(a3)
	move.w	(a5)+,BPR*8(a3)
	move.w	(a5)+,BPR*9(a3)
	move.w	(a5)+,BPR*10(a3)
	move.w	(a5)+,BPR*11(a3)
	move.w	(a5)+,BPR*12(a3)
	move.w	(a5)+,BPR*13(a3)
	move.w	(a5)+,BPR*14(a3)
	move.w	(a5)+,BPR*15(a3)

	add.l	#PLANE_INC,a3
	
	move.w	(a5)+,(a3)
	move.w	(a5)+,BPR(a3)
	move.w	(a5)+,BPR*2(a3)
	move.w	(a5)+,BPR*3(a3)
	move.w	(a5)+,BPR*4(a3)
	move.w	(a5)+,BPR*5(a3)
	move.w	(a5)+,BPR*6(a3)
	move.w	(a5)+,BPR*7(a3)
	move.w	(a5)+,BPR*8(a3)
	move.w	(a5)+,BPR*9(a3)
	move.w	(a5)+,BPR*10(a3)
	move.w	(a5)+,BPR*11(a3)
	move.w	(a5)+,BPR*12(a3)
	move.w	(a5)+,BPR*13(a3)
	move.w	(a5)+,BPR*14(a3)
	move.w	(a5)+,BPR*15(a3)
dont_draw_68000_block	
	rts	