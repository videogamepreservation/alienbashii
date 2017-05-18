Display_Threshold
	move.l	#Recognition_Button_List,a0
	bsr	remove_button_list
	move.l	#Threshold_Button_List,a0
	bsr	display_button_list
	bsr	Set_Threshold
	rts	

Remove_Threshold
	move.l	#Threshold_Button_List,a0
	bsr	remove_button_list	
	move.l	#Recognition_Button_List,a0
	bsr	display_button_list
	jsr	setup_screen_colours	
	rts
	
Threshold_Up
	cmp.w	#15,Threshold_Value
	bge.s	No_Increase_Threshold
	addq.w	#1,Threshold_Value
	bsr	Set_Threshold
No_Increase_Threshold	
	rts

Threshold_Down
	cmp.w	#1,Threshold_Value
	ble.s	No_Decrease_Threshold
	subq.w	#1,Threshold_Value
	bsr	Set_Threshold
No_Decrease_Threshold	
	rts
	
Set_Threshold
	move.l	#Main_Screen_Colours+2,a0	; first logical colour
	
	moveq	#0,d0
	move.w	#$fff,d1
Set_Loop
	cmp.w	Threshold_Value,d0
	blt.s	Thresh_Lower
	move.w	#0,(a0)

	tst.w	Grey_Scale_Flag
	bmi.s	No_Grey_Scales
	move.w	d1,(a0)
No_Grey_Scales
	bra.s	done_thresh_colour
Thresh_Lower	
	move.w	#$fff,(a0)
done_thresh_colour
 	
 	sub.w	#$111,d1
	addq.l	#4,a0
	addq.w	#1,d0
	
	cmp.w	#15,d0
	ble.s	Set_Loop
	rts
	
Threshold_Value
	dc.w	1
	
Set_Grey_Scales
	neg.w	Grey_Scale_Flag
	bsr	Set_Threshold 
	rts
	
Grey_Scale_Flag
	dc.w	-1
	

Threshold_Image

	move.b	#1,pointer_state
	bsr	Start_Processing_Task

	move.w	Image_Start_X,d0		; x start co-ordinate
	move.w	Image_Start_Y,d1		; y start co-ordinate
thresh_loop
	btst.b	#10,$dff016
	beq.s	Done_Threshold

	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a0
	bsr	Get_Grey_Shade		; into d3 d4 
					;      d5 d6
	cmp.w	Threshold_Value,d3
	blt.s	no_thresh_pixel
		
	move.l	#main_screen_struct,a0
	move.l	screen_mem(a0),a0
	move.w	#1,d2
	bsr	Write_Pixel_Value
no_thresh_pixel

	add.w	#1,d0
	cmp.w	Image_End_X,d0
	ble.s	thresh_loop
	move.w	Image_Start_X,d0
	add.w	#1,d1
	cmp.w	Image_End_Y,d1
	ble.s	thresh_loop
Done_Threshold
	bsr	End_Processing_Task
	move.b	#0,pointer_state
	rts

Get_Grey_Shade

	move.w	#3,d4		; 4 planes 
	add.l	#3*(80*256),a0	; point to last plane
	moveq	#0,d3
grey_pix_loop
	lsl.b	d3		
	bsr	Read_Pixel_Value
	btst	#0,d2
	beq.s	no_grey_set
	bset	#0,d3
	move.w	#0,d2
	bsr	Write_Pixel_Value
no_grey_set

	sub.l	#80*256,a0
	dbra	d4,grey_pix_loop
	
	rts
	
