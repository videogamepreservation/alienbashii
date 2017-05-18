*****************************************************************
* MODULE TITLE     :cursor_routines                             *
*                                                               *
* DESCRIPTION      :software to move cursor and display         *
*                   additional information at the cursor        *
*                   when neccessary                             *
*                                                               *
*                        NAME                          DATE     *
*                                                               *
* LIST OF ROUTINES :position_cursor                             *
*                   position_note_info                          *
*                   attach_pointer                              *
*                   attach_note                                 *
*                   attach_graphics                             *
*                   detach_pointer                              *
*                   SetHiResSprite                              *
*                   SetLoResSprite                              *
*****************************************************************


***********************************************
*****	   SET HI RES SPRITE              *****
***********************************************	
SetHiResSprite
	move	#HI_RES_SPRITES,d0
	bsr	SetCon3InCopperList
	rts

***********************************************
*****	   SET LO  RES SPRITE             *****
***********************************************	
SetLoResSprite
	move	#LO_RES_SPRITES,d0
	bsr	SetCon3InCopperList
	rts

***********************************************
*****  SET CON3 IN COPPER LIST            *****
***********************************************	
SetCon3InCopperList
*Not very good code practice, but beats having a label for each
*occurance in the copperl list and setting one by one!

*D0 contains LO/HI res bit information to or into BPLCON3 occurances

	move.l	#Copperl,a0
CheckForCon3
	cmp.w	#BPLCON3,(a0)
	bne.s	NotCon3
	or.w	d0,2(a0)	;Set sprite res
NotCon3
	addq.w	#4,a0
	cmp.l	#end_copper,a0
	blt.s	CheckForCon3			
	rts

***********************************************
*****	   COMPENSATE FOR RES             *****
***********************************************	
CompensateForRes
;assumes d0 is mouse x position
	btst	#INTB_HIRES,screen_mode
	beq.s	DontCompensate
	lsr.w	d0
DontCompensate	
	rts

**********************************************
*****	   POSITION CURSOR                *****
***********************************************	
position_cursor

	move.w	mousex_inc,d0	
	add.w	d0,mouse_x	
	
	btst	#INTB_HIRES,screen_mode		;Ok not a great way to do it!!!
	beq.s	Check320Bounds
	cmp.w	#639,mouse_x	
	ble.s	in_rangex
	move.w	#639,mouse_x
	bra.s	in_rangex
Check320Bounds	
	cmp.w	#319,mouse_x	
	ble.s	in_rangex
	move.w	#319,mouse_x
in_rangex
	cmp.w	#0,mouse_x
	bge.s	still_range_x
	move.w	#0,mouse_x
still_range_x
	move.w	mousey_inc,d0
	add.w	d0,mouse_y	
	cmp.w	#256,mouse_y
	ble.s	in_range_y
	move.w	#256,mouse_y
in_range_y
	cmp.w	#0,mouse_y
	bge.s	still_range_y
	move.w	#0,mouse_y
still_range_y
	cmp.b	#0,pointer_state
	beq.s	normal_state
	move.l	#wait_pointer,a0
	move.w	#27,d7
	bra.s	do_other_mouse_stuff
normal_state
	move.l	#mouse_pointer,a0
	move.w	#16,d7
do_other_mouse_stuff
	move.w	mouse_x,d0
	bsr	CompensateForRes
	add.w	#$81-1,d0	;tricky positioning
	move.b	#0,3(A0)
	asr.w	#1,d0
	bcc.s	no_bit_set
	bset	#0,3(a0)
no_bit_set	
	move.b	d0,1(a0)
	
	move.w	mouse_y,d0
	add.w	#$2c,d0
	btst	#8,d0
	beq.s	not_vert_set
	bset	#2,3(a0)		
not_vert_set	
	move.b	d0,(a0)
	
	add.w	d7,d0
	btst	#8,d0
	beq.s	not_vstop_set
	bset	#1,3(a0)
not_vstop_set	
	move.b	d0,2(a0)
	

	cmp.b	#0,pointer_state
	beq.s	normal_pointer
	move.l	#wait_pointer,d0
	bra.s	stuff_spr_data
normal_pointer
	move.l	#mouse_pointer,d0
stuff_spr_data
	move.w	d0,sprite0l
	swap	d0
	move.w	d0,sprite0h


	rts

***********************************************
*****	   ATTACH POINTER                 *****
***********************************************	
attach_pointer

*routine for anyone to use

**send sprite y size in d0
**send sprite graphics in a0

	move.w	d0,attach_pointer_size
	move.l	#pointer_attach_bits+4,a2
	subq.w	#1,d0
fill_mouse_pointer
	move.w	(a0)+,(a2)+
	move.w	(a0)+,(a2)+	
	dbra	d2,fill_mouse_pointer
	move.l	#$0,(a2)
	move.b	#1,attach_information
	
	rts	
	
***********************************************
*****	   ATTACH GRAPHICS                *****
***********************************************	
attach_graphics
	move.w  attach_pointer_size,d2
	move.l	#pointer_attach_bits,a0
	move.l	mouse_pointer,(a0)
	add.b	#17,(a0)	;add to x
	bcc.s	no_set_ex
	bset.b	#2,3(a0)
no_set_ex
	add.w	#1,d2
	add.b	d2,2(a0)
	bcc.s	no_vstop_ex
	bset.b	#1,3(a0)
no_vstop_ex
	rts

attach_pointer_size
	dc.w	0

attach_information
	dc.b	0
	EVEN

pointer_state
	dc.b	0
	EVEN


********************************
*** POSITION BOX SPRITE     ****
********************************
position_box_sprite
	move.w	mouse_x,d0
	move.w	mouse_y,d1
	cmp.w	#1,show_box
	bne.s	blank_out_sprite
	cmp.w	max_screen_pos,d1
	blt.s	display_box_sprite
blank_out_sprite
	move.l	#blank,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	move.l	#blank,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h
	rts
display_box_sprite

	move.l	current_map_ptr,a0
	cmp.w	#8,map_block_size(a0)
	beq.s	position_sprite8x8
	cmp.w	#16,map_block_size(a0)
	beq.s	position_sprite16x16
	cmp.w	#32,map_block_size(a0)
	beq	position_sprite32x32

position_sprite8x8
	and.w	#$fff8,d0
	and.w	#$fff8,d1
	bsr	CompensateForRes	
	move.w	#8,d2
	move.l	#sprite8x8,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	move.l	#blank,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h
	rts
	
position_sprite16x16
	and.w	#$fff0,d0
	and.w	#$fff0,d1
	bsr	CompensateForRes
	move.w	#16,d2
	move.l	#sprite16x16,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	move.l	#blank,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h
	rts
	
position_sprite32x32
	and.w	#$ffe0,d0
	and.w	#$ffe0,d1
	bsr	CompensateForRes
	move.w	#32,d2
	move.l	#sprite32x321,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite2l
	swap	d0
	move.w	d0,sprite2h
	move.w	mouse_x,d0
	move.w	mouse_y,d1
	and.w	#$ffe0,d0
	and.w	#$ffe0,d1	
	bsr	CompensateForRes
	btst	#INTB_HIRES,screen_mode
	beq.s	AddCurLoRes
	add.w	#8,d0
	bra.s	Position32Cur
AddCurLoRes	
	add.w	#16,d0
Position32Cur
	move.w	#32,d2
	move.l	#sprite32x322,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite3l
	swap	d0
	move.w	d0,sprite3h
	rts

show_box
	dc.w	1
show_box2
	dc.w	1	

********************************
*** POSITION BOX SPRITE2    ****
********************************
position_box_sprite2
	cmp.w	#1,show_box2
	beq.s   display_box_sprite2
blank_box2	
	move.l	#blank,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	move.l	#blank,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h
	rts
display_box_sprite2


	move.w	current_block,d0
	move.w	current_page,d1
	mulu	num_blocks_in_page,d1
	sub.w	d1,d0
	move.l	current_map_ptr,a0
	move.l	#main_screen_struct,a1
	move.w	screen_x_size(a1),d1
	divu	map_block_size(a0),d1	;divide factor
	divu	d1,d0
	move.w	d0,d1		;y
	swap	d0		;x
	mulu	map_block_size(a0),d1	;y
	mulu	map_block_size(a0),d0	;x
	add.w	#BUTTON_WINDOW_OFFSET-32,d1
	
	move.l	page_pointer,a1
	move.w	screen_y_pos(a1),d2
	add.w	#BUTTON_WINDOW_OFFSET-32,d2
	cmp.w	d2,d1
	blt	blank_box2	
	add.w	#32,d2
	sub.w	map_block_size(a0),d2
	cmp.w	d2,d1
	bgt	blank_box2
	
	sub.w	screen_y_pos(a1),d1
	move.w	d0,d6
	move.w	d1,d7


	cmp.w	#8,map_block_size(a0)
	beq.s	position_sprite8x82
	cmp.w	#16,map_block_size(a0)
	beq.s	position_sprite16x162
	cmp.w	#32,map_block_size(a0)
	beq	position_sprite32x322

position_sprite8x82
	and.w	#$fff8,d0
	and.w	#$fff8,d1
	bsr	CompensateForRes
	move.w	#8,d2
	move.l	#sprite8x82,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	move.l	#blank,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h
	rts
position_sprite16x162
	and.w	#$fff0,d0
	and.w	#$fff0,d1
	bsr	CompensateForRes
	move.w	#16,d2
	move.l	#sprite16x162,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	move.l	#blank,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h
	rts
position_sprite32x322
	and.w	#$ffe0,d0
	and.w	#$ffe0,d1
	bsr	CompensateForRes
	move.w	#32,d2
	move.l	#sprite32x3212,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite6l
	swap	d0
	move.w	d0,sprite6h
	move.w	d6,d0
	move.w	d7,d1
	bsr	CompensateForRes
	btst	#INTB_HIRES,screen_mode
	beq.s	AddBoxLoRes
	add.w	#8,d0
	bra.s	Position32Box
AddBoxLoRes	
	add.w	#16,d0
Position32Box	
	move.w	#32,d2
	move.l	#sprite32x3222,a0
	bsr	position_any_sprite
	move.l	a0,d0
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite7h
	rts

position_any_sprite
*send in data in a0
*x in d0

*y in d1
*height in d2

gendo_other_mouse_stuff
	add.w	#$81-1,d0	;tricky positioning
	move.b	#0,3(A0)
	asr.w	#1,d0
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


******************************************
****     DISPLAY HELPFUL CURSOR      *****
******************************************
display_helpful_cursor
*	cmp.w	#BUTTON_WINDOW_OFFSET,mouse_y
*	bge.s	blank_out_help
	cmp.w	#0,sprite_to_attach
	bne.s   attach_help
blank_out_help	
	move.l #blank,d0
	move.w d0,sprite4l
        swap	d0
        move.w d0,sprite4h
	bra.s   quit_display_helpful
attach_help	
	cmp.w   #WITH,sprite_to_attach
	bne.s	check_next
	move.l  #sprwith,a0
	bra.s   position_it
check_next
	cmp.w   #TO,sprite_to_attach
	bne.s   default_last
	move.l  #sprto,a0
	bra.s   position_it
default_last
	move.l  #sprpick,a0
position_it		
        move.w  mouse_x,d0
        move.w  mouse_y,d1
	bsr	CompensateForRes
        add.w   #18,d1
        move.w  #10,d2
        bsr    position_any_sprite
        move.l a0,d0
        move.w d0,sprite4l
        swap	d0
        move.w d0,sprite4h	
quit_display_helpful
	rts	

**********************************
*** BLANK SPRITES             ****
**********************************
blank_sprites
	move.l	#blank_sprite,d0
	move.w	d0,sprite1l
	move.w	d0,sprite2l
	move.w	d0,sprite3l
	move.w	d0,sprite4l
	move.w	d0,sprite5l
	move.w	d0,sprite6l
	move.w	d0,sprite7l
	swap	d0
	move.w	d0,sprite1h
	move.w	d0,sprite2h
	move.w	d0,sprite3h
	move.w	d0,sprite4h
	move.w	d0,sprite5h
	move.w	d0,sprite6h
	move.w	d0,sprite7h
	rts
	