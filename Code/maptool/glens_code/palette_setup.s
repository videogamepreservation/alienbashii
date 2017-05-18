

************************************
**** SET UP PALETTE WINDOW      ****
************************************
set_up_palette_window

	move.l  #backup_palette,a1
	move.l	page_pointer,a0
	move.l  screen_palette(a0),a0
	move.w	#31,d0
copy_palette
	move.w	(a0)+,(a1)+
	dbra	d0,copy_palette	

	move.l	#pal_butts,a0
	moveq	#0,d0
	move.w	colour_selected,d0
	asl.w   #2,d0
	move.l  (a0,d0),a0
	move.b	#DEPRESSED,button_start(a0)
	move.l #palette_window,a0
	bsr	create_window
	
	move.l #palette_button_list,a0
	bsr	display_button_list
	
	move.l	#Palette_Window,a0		; write in filename
	move.l	#palette_text,a1
	move.w	#2,d2
	move.w	#6,d0
	move.w	#6,d1
	bsr	Write_Text	
	bsr	get_colour_attribs
	bsr	display_colour_attributes

	rts


************************************
**** CANCEL PALETTE WINDOW      ****
************************************
cancel_palette_window

	move.l  page_pointer,a2
	move.l screen_palette(a2),a0
	move.l #backup_palette,a1
	move.w #31,d0
copy_back_palette
	move.w (a1)+,(a0)+
	dbra d0,copy_back_palette
	move.l screen_palette(a2),a1
	bsr	setup_screen_colours
        bsr	remove_palette_window
	rts	

************************************
**** REMOVE PALETTE WINDOW      ****
************************************
remove_palette_window
	
	move.l #palette_button_list,a0
	bsr    remove_button_list
	
	move.l #palette_window,a0
	bsr	destroy_window
	
	rts

************************************
**** DISPLAY COLOUR ATTRIBUTES  ****
************************************
display_colour_attributes

	move.l	#Palette_Window,a0		; write in filename
	move.l	#palette_numbers,a1
	move.w	#2,d2
	move.w	#106,d0
	move.w	#9+20,d1
	move.w	#1,d3
	bsr	Write_Text
	rts
	
************************************
**** DELETE COLOUR ATTRIBUTES  ****
************************************
delete_colour_attributes

	move.l	#Palette_Window,a0		; write in filename
	move.l	#palette_numbers,a1
	move.w	#2,d2
	move.w	#106,d0
	move.w	#9+20,d1
	move.w	#0,d3
	bsr	Write_Text
	rts

convert_col_to_hex
	
	cmp.w	#9,d1
	ble.s	all_num
	add.w	#48+7,d1
	bra.s	done_convert_col
all_num	
	add.w	#48,d1
done_convert_col
	rts	
************************************
**** GET COLOUR ATTRIBS         ****
************************************
get_colour_attribs
	moveq  #0,d0
	move.w colour_selected,d0
	move.l page_pointer,a0
	move.l screen_palette(a0),a0
	asl.w  #1,d0
	move.w (a0,d0),d0	; current colour
	
	move.w	d0,d1
	andi.w	#$0f00,d1
	asr.w	#8,d1
	bsr	convert_col_to_hex
	move.b	d1,red_inten
	move.w	d0,d1
	andi.w	#$00f0,d1
	asr.w	#4,d1
	bsr	convert_col_to_hex
	move.b  d1,green_inten
	andi.w	#$00f,d0
	move.w  d0,d1
	bsr	convert_col_to_hex
	move.b  d1,blue_inten

	rts	

************************************
**** COLOUR UP                  ****
************************************
colour_up

	move.l clicked_button,a0
	moveq	#0,d0
	move.b button_data(a0),d0
	
	move.w colour_selected,d1
	asl.w	#1,d1
	move.l page_pointer,a0
	move.l screen_palette(a0),a0
	move.w (a0,d1),d2   ; colour
	
	cmp.w	#0,d0
	bne.s	could_be_green
	andi.w	#$f00,d2
	asr.w   #8,d2
	cmp.w	#$f,d2
	beq.s	done_colour_update
	addq.w	#1,d2
	asl.w	#8,d2
	andi.w	#$0ff,(a0,d1)
	or.w    d2,(a0,d1)	
	bra.s   done_colour_update
could_be_green
	cmp.w	#1,d0
	bne.s	must_be_blue
	andi.w	#$0f0,d2
	asr.w   #4,d2
	cmp.w	#$f,d2
	beq.s	done_colour_update
	addq.w	#1,d2
	asl.w	#4,d2
	andi.w	#$f0f,(a0,d1)
	or.w    d2,(a0,d1)
	bra.s   done_colour_update
must_be_blue	
	andi.w	#$00f,d2
	cmp.w	#$f,d2
	beq.s	done_colour_update
	addq.w	#1,d2
	andi.w	#$ff0,(a0,d1)
	or.w    d2,(a0,d1)
done_colour_update

	bsr	delete_colour_attributes
	bsr	get_colour_attribs
	bsr	display_colour_attributes
	bsr	set_current_page_colours

	rts

**************************************
*****  SET CURRENT PAGE COLOURS  *****
**************************************
set_current_page_colours

	move.l  page_pointer,a0
	move.l  screen_palette(a0),a0
	move.l	a0,a1
	bsr	setup_screen_colours
	rts


**************************************
*****  SET ORIGINAL COLOURS      *****
**************************************
set_original_colours

	move.l	#main_screen_colour_map,a1
	move.l	#main_screen_colours+2,a3
	move.w	#8-1,d0
fill_ori_colours
	move.w	(a1)+,(a3)
	add.l	#4,a3
	dbra	d0,fill_ori_colours


	rts

************************************
**** COLOUR DOWN                  ****
************************************
colour_down

	move.l clicked_button,a0
	moveq	#0,d0
	move.b button_data(a0),d0
	
	move.w colour_selected,d1
	asl.w	#1,d1
	move.l page_pointer,a0
	move.l screen_palette(a0),a0
	move.w (a0,d1),d2   ; colour
	
	cmp.w	#0,d0
	bne.s	dcould_be_green
	andi.w	#$f00,d2
	asr.w   #8,d2
	cmp.w	#$0,d2
	beq.s	ddone_colour_update
	subq.w	#1,d2
	asl.w	#8,d2
	andi.w	#$0ff,(a0,d1)
	or.w    d2,(a0,d1)	
	bra.s   ddone_colour_update
dcould_be_green
	cmp.w	#1,d0
	bne.s	dmust_be_blue
	andi.w	#$0f0,d2
	asr.w   #4,d2
	cmp.w	#$0,d2
	beq.s	ddone_colour_update
	subq.w	#1,d2
	asl.w	#4,d2
	andi.w	#$f0f,(a0,d1)
	or.w    d2,(a0,d1)
	bra.s   ddone_colour_update
dmust_be_blue	
	andi.w	#$00f,d2
	cmp.w	#$0,d2
	beq.s	ddone_colour_update
	subq.w	#1,d2
	andi.w	#$ff0,(a0,d1)
	or.w    d2,(a0,d1)
ddone_colour_update

	bsr	delete_colour_attributes
	bsr	get_colour_attribs
	bsr	display_colour_attributes
	move.l  page_pointer,a0
	move.l  screen_palette(a0),a0

	move.l	a0,a1
	bsr	setup_screen_colours
	rts

************************************
**** SET NEW COLOUR             ****
************************************
set_new_colour

	move.l clicked_button,a0
	moveq	#0,d0
	move.b button_data(a0),d0
	
	move.l  #pal_butts,a0
	cmp.w	colour_selected,d0
	bne.s	new_colour_selected
	move.w  colour_selected,d1
	asl.w	#2,d1
	move.l  (a0,d1),a0
	move.b  #DEPRESSED,button_start(a0)
	bra.s	redisplay_colour
new_colour_selected
	move.w  colour_selected,d1
	asl.w	#2,d1
	move.l  (a0,d1),a0
	move.b  #NOT_DEPRESSED,button_start(a0)
	move.w	d0,colour_selected
redisplay_colour		
	bsr	remove_button
	bsr	display_button	
	bsr	delete_colour_attributes
	bsr	get_colour_attribs
	bsr	display_colour_attributes
	rts	

*****************************palette stuff



palette_text
	dc.b  "    Intensitys  ",$a,$a
	dc.b  "   Red   : ",$a,$a
	dc.b  "   Green : ",$a,$a
	dc.b  "   Blue  : ",0
	EVEN



palette_numbers
red_inten
        dc.b 0,$a,$a
green_inten	
        dc.b  0,$a,$a
blue_inten	
       dc.b  0,0
	EVEN
	
colour_selected
	dc.w	0
		
**********palette window


Palette_Window
	dc.w	240
	dc.w	144
	dc.w	40
	dc.w	20
	dc.l	0
	dc.l	0
	dc.b	"PALETTE EDITOR",0
	even		


palette_button_list
	dc.l palette_ok_button,palette_cancel_button
	dc.l red_up_button,red_down_button
	dc.l blue_up_button,blue_down_button
	dc.l green_up_button,green_down_button
pal_butts	
	dc.l palette_colour0_button
	dc.l palette_colour1_button
        dc.l palette_colour2_button
        dc.l palette_colour3_button
        dc.l palette_colour4_button
        dc.l palette_colour5_button
        dc.l palette_colour6_button
        dc.l palette_colour7_button
        dc.l palette_colour8_button
	dc.l palette_colour9_button
        dc.l palette_colour10_button
        dc.l palette_colour11_button
        dc.l palette_colour12_button
        dc.l palette_colour13_button
        dc.l palette_colour14_button
        dc.l palette_colour15_button
        dc.l palette_colour16_button
	dc.l palette_colour17_button
        dc.l palette_colour18_button
        dc.l palette_colour19_button
        dc.l palette_colour20_button
        dc.l palette_colour21_button
        dc.l palette_colour22_button
        dc.l palette_colour23_button
        dc.l palette_colour24_button
	dc.l palette_colour25_button
        dc.l palette_colour26_button
        dc.l palette_colour27_button
        dc.l palette_colour28_button
        dc.l palette_colour29_button
        dc.l palette_colour30_button
        dc.l palette_colour31_button
        dc.l -1


*****palette buttons

palette_Ok_Button
	dc.w	24
	dc.w	110
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	ok_custom_button
	dc.l	0	;not used
        dc.l	remove_palette_window
	dc.b	0		
	even

palette_cancel_Button
	dc.w	240-104
	dc.w	110
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	cancel_custom_button
	dc.l	0	;not used
        dc.l	cancel_palette_window
	dc.b	0		
	even

Red_Up_Button
	dc.w	130
	dc.w	30
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	colour_up
	dc.b	0		
	EVEN		
	
Red_Down_Button
	dc.w	130+20
	dc.w	30
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	colour_down
	dc.b	0		
	EVEN	


Green_Up_Button
	dc.w	130
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	colour_up
	dc.b	0		
	EVEN		
	
Green_Down_Button
	dc.w	130+20
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l	colour_down
	dc.b	0		
	EVEN	

Blue_Up_Button
	dc.w	130
	dc.w	70
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	arrow_up
	dc.l	0	;not used
	dc.l	colour_up
	dc.b	0		
	EVEN		
	
Blue_Down_Button
	dc.w	130+20
	dc.w	70
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	arrow_down
	dc.l	0	;not used
	dc.l    colour_down
	dc.b	0		
	EVEN	

palette_colour0_button
	dc.w	56
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	colour0_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour1_button
	dc.w	56+8
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	colour1_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour2_button
	dc.w	56+16
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	colour2_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	
	
palette_colour3_button
	dc.w	56+24
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	colour3_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	


palette_colour4_button
	dc.w	56+32
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	colour4_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour5_button
	dc.w	56+40
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	colour5_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour6_button
	dc.w	56+48
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	6
	dc.b	0	;not used
	dc.l	colour6_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour7_button
	dc.w	56+56
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	7
	dc.b	0	;not used
	dc.l	colour7_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour8_button
	dc.w	56+64
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	8
	dc.b	0	;not used
	dc.l	colour8_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour9_button
	dc.w	56+64
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	9
	dc.b	0	;not used
	dc.l	colour9_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour10_button
	dc.w	56+72
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	10
	dc.b	0	;not used
	dc.l	colour10_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour11_button
	dc.w	56+80
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	11
	dc.b	0	;not used
	dc.l	colour11_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour12_button
	dc.w	56+88
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	12
	dc.b	0	;not used
	dc.l	colour12_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour13_button
	dc.w	56+96
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	13
	dc.b	0	;not used
	dc.l	colour13_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour14_button
	dc.w	56+104
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	14
	dc.b	0	;not used
	dc.l	colour14_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour15_button
	dc.w	56+112
	dc.w	90
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	15
	dc.b	0	;not used
	dc.l	colour15_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour16_button
	dc.w	56
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	16
	dc.b	0	;not used
	dc.l	colour16_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour17_button
	dc.w	56+8
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	17
	dc.b	0	;not used
	dc.l	colour17_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour18_button
	dc.w	56+16
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	18
	dc.b	0	;not used
	dc.l	colour18_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	
	
palette_colour19_button
	dc.w	56+24
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	19
	dc.b	0	;not used
	dc.l	colour19_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	


palette_colour20_button
	dc.w	56+32
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	20
	dc.b	0	;not used
	dc.l	colour20_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour21_button
	dc.w	56+40
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	21
	dc.b	0	;not used
	dc.l	colour21_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour22_button
	dc.w	56+48
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	22
	dc.b	0	;not used
	dc.l	colour22_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour23_button
	dc.w	56+56
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	23
	dc.b	0	;not used
	dc.l	colour23_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour24_button
	dc.w	56+64
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	24
	dc.b	0	;not used
	dc.l	colour24_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour25_button
	dc.w	56+64
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	25
	dc.b	0	;not used
	dc.l	colour25_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour26_button
	dc.w	56+72
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	26
	dc.b	0	;not used
	dc.l	colour26_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour27_button
	dc.w	56+80
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	27
	dc.b	0	;not used
	dc.l	colour27_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour28_button
	dc.w	56+88
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	28
	dc.b	0	;not used
	dc.l	colour28_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour29_button
	dc.w	56+96
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	29
	dc.b	0	;not used
	dc.l	colour29_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour30_button
	dc.w	56+104
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	30
	dc.b	0	;not used
	dc.l	colour30_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

palette_colour31_button
	dc.w	56+112
	dc.w	98
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+TOGGLE_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	31
	dc.b	0	;not used
	dc.l	colour31_button
	dc.l	0	;not used
	dc.l	set_new_colour  
	dc.b	0		
	EVEN	

backup_palette
	ds.w 32