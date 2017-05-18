Manual_Scan
	move.w	#1,pointer_state
	bsr	Scan_For_Objects
	move.w	#0,pointer_state
	tst.w	d2
	bmi.s	no_display_for_manual
	bsr	Create_Object_Details_Window	
	bsr	Sketch_Object_Details
no_display_for_manual
	rts
	
Auto_Scan
	move.w	#1,pointer_state
	bsr	Initialise_Music_Data
music_recognition_loop
	bsr	Scan_For_Objects
	tst.w	d2
	bmi.s	Music_Conversion_Complete
	bsr	Translate_Object		; will recognise or learn if necessary
	bra.s	music_recognition_loop	
Music_Conversion_Complete
	move.w	#0,pointer_state
	rts
	
Initialise_Music_Data
	move.l	channel_1_data,a0
	move.w	#-1,(a0)
	move.l	channel_2_data,a0
	move.w	#-1,(a0)
	move.l	channel_3_data,a0
	move.w	#-1,(a0)
	move.l	channel_4_data,a0
	move.w	#-1,(a0)
	move.w 	#1,page_number

	move.l	Channel_1_Data,Recognised_Music_Channel
	move.w	#"A ",recognised_note_value
	move.w	#0,recognised_note_duration
	move.b	#1,recognised_note_octave

	rts
	
Translate_Object
	move.w	#0,d0			; object number
trans_obj_loop
	addq.w	#1,d0
	cmp.w	Number_Learned_Objects,d0
	bgt	no_object_match
	bsr	Compare_Object
	tst.l	d1
	beq.s	trans_obj_loop

Trans_Part	
	subq.w	#1,d0
	lsl.w	#2,d0
	move.l	#Object_Memory,a0
	move.l	(a0,d0.w),a0
	move.w	OD_ID(a0),d0
	
	mulu.w	#Object_Name_Length,d0
	move.l	#Object_Names,a0
	add.l	d0,a0
	move.b	17(a0),d1
	
	cmp.b	#Obj_Type_Sig,d1		; part of key signature ?
	bne.s	not_recognised_signature
	bra.s	note_trans_complete
not_recognised_signature		
	cmp.b	#Obj_Type_Blah,d1		; sharp/flat etc?
         bne.s	not_recognised_blah
     	move.b	18(a0),recognised_note_value+1
     	bra.s	note_trans_complete
not_recognised_blah
	cmp.b	#Obj_Type_Tie,d1		; sharp/flat etc?
         bne.s	not_recognised_Tie
     	bsr	Tie_Last_Note
     	bra.s	note_trans_complete
not_recognised_tie

*	btst.b	#6,$bfe001
*	bne.s	not_recognised_blah
	
	moveq.w	#0,d2
	move.b	18(a0),d2
	move.w	d2,recognised_note_duration
	
	move.w	Start_of_Object_Y,d0	; cunning
	move.w	rec_staves_start,d1
	sub.w	d1,d0			; get point of note
	mulu.w	#100,d0			; scale up by hundred
	divu.w	rec_note_distance,d0

	lsl.w	d0			; by 2 for (note,octave)
	cmp.w	#Recognition_Table_Length,d0
	bge.s	note_out_of_range
	move.l	#Recognition_Stave_Table,a0
	move.b	(a0,d0.w),recognised_note_value
	move.b	1(a0,d0.w),recognised_note_octave
note_out_of_range
	bsr	Insert_Recognised_Note
note_trans_complete
no_object_match
	rts

Tie_Last_Note
	move.l	Recognised_Music_Channel,a0
	cmp.l	channel_1_data,a0
	beq.s	not_note_yet
	sub.l	#10,a0
	move.b	#1,note_tie(a0)
not_note_yet
	rts
Insert_Recognised_Note
	move.l	Recognised_Music_Channel,a0
	move.w	#1,note_instrument(a0)
	move.w	recognised_note_value,note_value(a0)
	move.w	recognised_note_duration,note_duration(a0)
	move.w	#0,note_extension(a0)
	move.b	recognised_note_octave,note_octave(a0)
	move.b	#0,note_tie(a0)
	
	add.l	#10,a0
	move.w	#-1,(a0)
	move.l	a0,Recognised_Music_Channel
	move.w	#"A ",recognised_note_value
	move.w	#0,recognised_note_duration
	move.b	#1,recognised_note_octave
	rts
	
Recognised_Music_Channel	dc.l	0

recognised_note_value		dc.w	"  "
recognised_note_duration		dc.w	0
recognised_note_octave		dc.b	1
	even
