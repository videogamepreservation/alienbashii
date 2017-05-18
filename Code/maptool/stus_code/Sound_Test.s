Load_Soundtracker_File
	move.l	#Load_St,File_Routine_Pointer
	bsr	Display_File_Request	
	rts

Load_St
	move.l	#Soundtracker_File_Structure,a0
	bsr	LoadAnyOldFile
	tst.l	d0			; error occured?
	beq.s	st_load_ok
	jsr	error_routine
	bra.s	st_load_end
st_load_ok
	bsr	Remove_File_Request
	move.b	#1,pointer_state
	bsr	st_to_music
	bsr	redisplay_music
	move.b	#0,pointer_state
st_load_end
	rts

st_to_music
        move.w	#6,Music_Tempo
	move.l	#Soundtracker_File_Structure,a0
	move.l	FH_Memory(a0),a0

	move.l	channel_1_data,channel_1_tracker
	move.l	channel_2_data,channel_2_tracker
	move.l	channel_3_data,channel_3_tracker
	move.l	channel_4_data,channel_4_tracker

	move.l	a0,-(sp)
	
	add.l	#20,a0
	move.l	#Instrument_Names,a1
	move.l	#Sound_File_Structure,a2
	move.w	#Max_Inst_No-1,d4			;
st_inst_loop
	move.w	#22-1,d0
st_name_loop
	move.b	(a0)+,(a1)+			; name char
	dbra	d0,st_name_loop	
	
	move.w	(a0)+,d1				; length dont need
	move.w	(a0)+,d1
	andi.w	#$00ff,d1			; just volume byte
	move.w	d1,INST_Volume(a2)
	move.w	(a0)+,INST_Repeat(a2)
	move.w	(a0)+,INST_Rep_Len(a2)
	
	add.l	#3,a1
	add.l	#INST_Struct_Size,a2	
	dbra	d4,st_inst_loop
	
	move.l	(sp)+,a0
	move.l	a0,a1
	add.l	#(31*30)+20,a1
	moveq.l	#0,d6
	move.b	(a1)+,d6		; number of patterns
	addq.l	#1,a1		; extra byte

	add.l	#1084,a0		; start of patterns
	subq.w	#1,d6		; 1 less for dbra
pattern_loop
	moveq.w	#0,d0
	move.b	(a1)+,d0
	bsr	do_track
	dbra	d6,pattern_loop

	bsr	chain_in_instruments
	
	rts

do_track
; pattern start in a0
; pattern number in d0
	movem.l	a0-a1,-(sp)

	mulu.w	#64*16,d0
	add.l	d0,a0		; address of track
	
	move.l	a0,a1
	move.l	channel_1_tracker,a0
	bsr	Do_ST_Channel
	move.l	a0,channel_1_tracker

	addq.l	#4,a1
	move.l	channel_2_tracker,a0
	bsr	Do_ST_Channel
	move.l	a0,channel_2_tracker

	addq.l	#4,a1
	move.l	channel_3_tracker,a0
	bsr	Do_ST_Channel
	move.l	a0,channel_3_tracker

	addq.l	#4,a1
	move.l	channel_4_tracker,a0
	bsr	Do_ST_Channel
	move.l	a0,channel_4_tracker
	movem.l	(sp)+,a0-a1
	rts

channel_1_tracker	dc.l	0
channel_2_tracker	dc.l	0
channel_3_tracker	dc.l	0
channel_4_tracker	dc.l	0

Do_ST_Channel
	move.l	a1,-(sp)
	move.w	#64-1,d1		; number of slots in track
slot_loop
	move.w	(a1),d0			; frequency
	andi.w	#$0fff,d0
	bsr	Trans			; last effect returns in d4
	andi.w	#$f000,d3		; to test effect
	cmp.w	#$d000,d3		; pattern break?
	beq.s	break_pattern
	add.l	#16,a1
	dbra	d1,slot_loop
break_pattern
	move.l	(sp)+,a1
	rts

trans
	move.l	#ST_Freq_Table,a2
	move.w	#0,d2
tcon_loop
	tst.w	(a2,d2.w)
	bmi.s	note_error
	cmp.w	(a2,d2.w),d0
	beq.s	f_note
	addq.w	#2,d2
	bra.s	tcon_loop
f_note
	lsl	d2
	move.l	#ST_Conversion_Table,a2

	move.w	2(a2,d2.w),note_value(a0)
	move.w	(a2,d2.w),d3
	move.b	d3,note_octave(a0)
	move.w	#HEMI_DEMI_SEMI_QUAVER,note_duration(a0)
	move.b	#0,note_tie(a0)
	move.w	#0,note_extension(a0)

	move.w	2(a1),d3
	rol.w	#4,d3
	move.w	d3,note_instrument(a0)
	add.l	#10,a0
	move.w	#-1,(a0)

	bra.s	done_trans		
note_error
	move.w	#$f00,$dff180
done_trans
	rts
	
Setup_Monitor_Window
	move.l	#Monitor_Window,a0
	bsr	create_window
	move.l	#monitor_button_list,a0
	bsr	display_button_list
	bsr	sound_analyser
	rts

remove_Monitor_Window
	move.l	#monitor_button_list,a0
	bsr	remove_button_list
	move.l	#Monitor_Window,a0
	bsr	destroy_window
	rts

Set_Instrument_Details
	move.l	#Instrument_Window,a0
	bsr	create_window
	move.l	#Instrument_button_list,a0
	bsr	display_button_list

	move.l	#Instrument_Window,a0		; write in filename
	move.l	#Instrument_Window_Text,a1
	move.w	#2,d2
	move.w	#10,d0
	move.w	#5,d1
	move.w	#1,d3
	bsr	Write_Text
	bsr	Display_Instrument_Details
	rts

Remove_Instrument_Details
	move.l	#Instrument_button_list,a0
	bsr	remove_button_list
	move.l	#Instrument_Window,a0
	bsr	destroy_window
	rts

Load_Instrument
	move.w	current_selected_instrument,d0
	subq.w	#1,d0
	move.w	d0,channel_to_load
	bsr	Load_Channel_Sample		
	move.w	Current_Selected_Instrument,d0
	move.w	#0,d1
	bsr	Change_Instrument
	rts
	
current_Selected_Instrument
	dc.w	1

Display_Instrument_Details
	move.l	#Instrument_Window,a0
	move.w	#6,d0
	move.w	#5,d1
	move.w	#10,d2
	move.w	#6*11,d3
	bsr	Clear_Word_Chunk

	move.l	#Instrument_Names,a1
	moveq.l	#0,d0
	move.w	Current_Selected_Instrument,d0
	subq.w	#1,d0
	mulu.w	#25,d0
	add.l	d0,a1
	move.w	#10*10+10,d0
	move.w	#5,d1
	move.w	#1,d2
	move.w	#1,d3
	bsr	Write_Text

	move.w	Current_Selected_Instrument,d0
	subq.w	#1,d0
	mulu.w	#INST_Struct_Size,d0
	move.l	#Sound_File_Structure,a1
	add.l	d0,a1
	
	move.w	Current_Selected_Instrument,d3
	move.w	#10*10+10,d0
	move.w	#5+22,d1
	move.w	#1,d2
	move.w	#1,d4
	bsr	Write_Num

	move.w	INST_Volume(a1),d3
	move.w	#10*10+10,d0
	move.w	#5+33,d1
	move.w	#1,d2
	move.w	#1,d4
	bsr	Write_Num

	move.w	INST_Repeat(a1),d3
	move.w	#10*10+10,d0
	move.w	#5+44,d1
	move.w	#1,d2
	move.w	#1,d4
	bsr	Write_Num

	move.w	INST_Rep_Len(a1),d3
	move.w	#10*10+10,d0
	move.w	#5+55,d1
	move.w	#1,d2
	move.w	#1,d4
	bsr	Write_Num

	rts

Select_Instrument
	move.l	clicked_button,a0
	move.b	button_data(a0),d0
	ext.w	d0
	move.w	Current_Selected_Instrument,d1
	add.w	d0,d1
	cmp.w	#1,d1
	bge.s	sizok
	moveq.w	#1,d1
sizok
	cmp.w	#Max_Inst_No-1,d1
	ble.s	simok	
	move.w	#Max_Inst_No-1,d1
simok
	move.w	d1,Current_Selected_Instrument	
	bsr	Display_Instrument_Details
	move.w	Current_Selected_Instrument,d0
	move.w	#0,d1
	bsr	Change_Instrument
	rts
		
Change_Instrument
; instrument in d0
; channel in d1

	movem.l	d0-d7/a0-a6,-(sp)
	subq.w	#1,d0
	mulu.w	#INST_Struct_Size,d0		; offset for instrument
	mulu.w	#SSSize,d1			; offset for channel structs
	move.l	#Sound_File_Structure,a0
	add.l	d0,a0
	move.l	#Samples,a1
	add.l	d1,a1
	
	move.l	FH_Memory(a0),d2
	beq.s	Blank_Channel_Sample
	move.l	d2,Sound_Ptr(a1)
	move.l	FH_Length(a0),d2
	lsr.w	d2
	move.w	d2,Sound_Length(a1)
	move.w	INST_Volume(a0),Sound_Volume(a1)
	move.w	INST_Repeat(a0),Sound_Repeat(a1)
	move.w	INST_Rep_Len(a0),Sound_Rep_Len(a1)
			
	bra.s	sample_changed
blank_channel_sample
	move.l	#Blank,Sound_Ptr(a1)
	move.w	#1,Sound_Length(a1)
	move.w	#64,Sound_Volume(a1)	; if error occurs we can hear
	move.w	#0,Sound_Repeat(a1)
	move.w	#1,Sound_Rep_Len(a1)

sample_changed
	movem.l	(sp)+,d0-d7/a0-a6
	rts

Indicators
	move.l	pos_list_ptr,a4

	move.w	#30,d0	; x
	move.w	#50,d1	; y
	move.w	#0,d2	; channel
	bsr	draw_volume_indicator
	move.w	#250,d0	; x
	move.w	#50,d1	; y
	move.w	#1,d2	; channel
	bsr	draw_volume_indicator
	move.w	#30,d0	; x
	move.w	#180,d1	; y
	move.w	#2,d2	; channel
	bsr	draw_volume_indicator
	move.w	#250,d0	; x
	move.w	#180,d1	; y
	move.w	#3,d2	; channel
	bsr	draw_volume_indicator
	rts
	
draw_volume_indicator
	move.w	d2,d3
	mulu.w	#SSSize,d3		; for channel structs
	lsl.w	#1,d2	; get words
	move.l	#Samples,a0		; channel base
	move.l	#Volume_Levels,a1
	move.l	#Indicator_Levels,a2
	tst.w	6(a0,d3.w)		; new note
	beq.s	no_new_volume
	clr.w	6(a0,d3.w)		; clear note
	move.w	8(a0,d3.w),(a1,d2.w)	; set volume level
no_new_volume
	move.w	(a2,d2.w),d4		; indicator level
	move.w	(a1,d2.w),d5		; destination
	cmp.w	d5,d4
	bne.s	check_ind_direction
	clr.w	(a1,d2.w)		; clear volume level
	bra.s	display_ind
check_ind_direction
	blt.s	raise_ind
	subq.w	#4,d4	;was 3
	bpl.s    display_ind
	move.w	d5,d4	
	bra.s	display_ind
raise_ind
	add.w	#14,d4		;was 7
	cmp.w	d5,d4
	ble.s	display_ind
	move.w	d5,d4
display_ind
	move.w	d4,(a2,d2.w)

	move.l	#Vol_Indicator_Points,a0
        lsl.w	#2,d4		; two words
	move.w	d0,(a4)+
	move.w	d1,(a4)+
        move.w	d0,d2
        move.w	d1,d3
        add.w	(a0,d4.w),d2	; x
        add.w	2(a0,d4.w),d3	; y
	move.w	d2,(a4)+
	move.w	d3,(a4)+
	move.l	a4,-(sp)
        jsr	EOR_Draw_Demo_Line
	move.l	(sp)+,a4
        rts

pos_list
	ds.w	4*4

pos_list2
	ds.w	4*4

pos_list_ptr
	dc.l	pos_list
pos_list_ptr2
	dc.l	pos_list2

delete_indicators

	move.l	pos_list_ptr2,a0
	moveq.w	#3,d4
delete_indicators_loop
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	movem.l	d4/a0,-(sp)
	jsr	EOR_Delete_Demo_Line
	movem.l	(sp)+,d4/a0
	dbra	d4,delete_indicators_loop
	rts

Frequency_Levels	dc.w	0,0,0,0
Volume_Levels	dc.w	32,64,18,64
Indicator_Levels	dc.w	0,0,0,0

Vol_Indicator_Points	dc.w	-32,-40
         		dc.w	-31,-40
         		dc.w	-30,-40
         		dc.w	-29,-40
         		dc.w	-28,-40
         		dc.w	-27,-40
         		dc.w	-26,-40
         		dc.w	-25,-40
         		dc.w	-24,-40
         		dc.w	-23,-40
         		dc.w	-22,-40
         		dc.w	-21,-40
         		dc.w	-20,-40
         		dc.w	-19,-40
         		dc.w	-18,-40
         		dc.w	-17,-40
         		dc.w	-16,-40
         		dc.w	-15,-40
         		dc.w	-14,-40
         		dc.w	-13,-40
         		dc.w	-12,-40
         		dc.w	-11,-40
         		dc.w	-10,-40
         		dc.w	-9,-40
         		dc.w	-8,-40
         		dc.w	-7,-40
         		dc.w	-6,-40
         		dc.w	-5,-40
         		dc.w	-4,-40
         		dc.w	-3,-40
         		dc.w	-2,-40
         		dc.w	-1,-40
         		dc.w	-0,-40
         		dc.w	1,-40
         		dc.w	2,-40
         		dc.w	3,-40
         		dc.w	4,-40
         		dc.w	5,-40
         		dc.w	6,-40
         		dc.w	7,-40
         		dc.w	8,-40
         		dc.w	9,-40
         		dc.w	10,-40
         		dc.w	11,-40
         		dc.w	12,-40
         		dc.w	13,-40
         		dc.w	14,-40
         		dc.w	15,-40
         		dc.w	16,-40
         		dc.w	17,-40
         		dc.w	18,-40
         		dc.w	19,-40
         		dc.w	20,-40
         		dc.w	21,-40
         		dc.w	22,-40
         		dc.w	23,-40
         		dc.w	24,-40
         		dc.w	25,-40
         		dc.w	26,-40
         		dc.w	26,-40
         		dc.w	28,-40
         		dc.w	29,-40
         		dc.w	30,-40
			dc.w	31,-40
			dc.w	32,-40	; just in case         
         

sound_analyser
	move.l	#Monitor_Window,a0
	move.w	#1,d0
	move.w  #20,d1
	move.w	#20,d2
	move.w	#100,d3
	bsr	Clear_Word_Chunk

	bsr	indicators
	
	move.l	#monitor_window,a0
	move.l	screen_mem(a0),a0
	
	move.w	#20,d0
	move.w	#1,d2
chan_anal
	move.w	$dff006,d1
	andi.w	#$00ff,d1
	asr.b	#3,d1
	add.b	#100,d1
	bsr	Write_Pixel_Value
	addq.w	#1,d0
	cmp.w	#160,d0
	bne.s	chan_anal
	btst.b	#6,$bfe001
	bne.s	sound_analyser
	rts
			
Toggle_Low_Pass_Filter
	bchg.b	#1,$bfe001
	rts
	
Load_Channel_Sample
	move.l	#Load_Sound_File,File_Routine_Pointer
	bsr	display_file_request
	rts

Load_Sound_File
	move.l	#Sound_File_Structure,a0
	move.w	Current_Selected_Instrument,d0
	subq.w	#1,d0
	mulu.w	#INST_Struct_Size,d0
	lea.l	(a0,d0.w),a0
	move.l	#MEM_CHIP,FH_Memory_Type(a0)	; force chip ram
	move.l	#Current_FileName,FH_FileName(a0)	; selected from requester	
	move.w	#64,INST_Volume(a0)		; init vol
	move.w	#0,INST_Repeat(a0)		; init repeat
	move.w	#1,INST_Rep_Len(a0)		; init repeat length
	
	bsr	LoadAnyOldFile
	tst.l	d0			; error occured?
	bne.s	error_while_sample_load
	bsr	remove_file_request
	bsr	delete_chan		;re-draw current instrument
	
	move.l  #CFile,a0
	move.l	#Instrument_Names,a1
	move.w	Current_Selected_Instrument,d0
	subq.w	#1,d0
	mulu.w	#25,d0
	add.l	d0,a1

instr_copy_loop
	tst.b	(a0)
	beq.s	exit_copy_loop
	move.b	(a0)+,(a1)+
	bra.s	instr_copy_loop
exit_copy_loop
	move.b	#0,(a1)+				; terminate text

	bsr	Display_Instrument_Details
	bsr	draw_chan	
	
	bra.s	done_sample_load

error_while_sample_load		
	move.l	#0,FH_Memory(a0)			; set memory 0	
	jsr	error_routine		; error already in d0
done_sample_load
	rts


Deallocate_All_Instruments
	move.l	a6,-(sp)
	moveq.w	#0,d0
dealloc_inst_loop
	bsr	Deallocate_instrument
	addq.w	#1,d0
	cmp.w	#Max_Inst_No,d0
	blt.s	dealloc_inst_loop	
	move.l	a6,(sp)+

	rts	

Deallocate_instrument
	move.l	d0,-(sp)

	move.l	#Sound_File_Structure,a0	
	mulu.w	#INST_Struct_Size,d0
	lea.l	(a0,d0.w),a0

	tst.l	FH_Memory(a0)
	beq	Dont_Deallocate_Instrument
	
	move.l	FH_Memory(a0),a1
	move.l	FH_Length(a0),d0
	clr.l	FH_Memory(a0)			; clear mem pointer
	clr.l	FH_Length(a0)			; clear length pointer

	move.l	EXEC,a6
	jsr	-210(a6)			; de-allocate
	
Dont_Deallocate_Instrument
	move.l	(sp)+,d0
	rts

null_instrument_pointers

	movem.l	d0/a0,-(sp)
	moveq.w	#15,d0
	move.l	#Sound_File_Structure,a0		

null_loop
	clr.l	FH_Memory(a0)			; clear mem pointer
	clr.l	FH_Length(a0)			; clear length pointer
	add.l	#INST_Struct_Size,a0
	dbra	d0,null_loop
	movem.l	(sp)+,d0/a0
	rts

Chain_in_Instruments
	move.w	#0,d0
chain_inst_loop
	bsr	chain_instrument
	addq.w	#1,d0
	cmp.w	#Max_Inst_No,d0
	blt.s	chain_inst_loop
	rts
	
chain_instrument	
	move.w	d0,-(sp)
	move.w	d0,d1
	mulu.w	#25,d1
	move.l	#Chain_Filename,a1
	move.l	#Instrument_Names,a0
	add.l	d1,a0
	move.w	#24,d2
cnl
	move.b	(a0)+,(a1)+
	dbra	d2,cnl

	move.l	#Sound_File_Structure,a0	
	mulu.w	#INST_Struct_Size,d0
	lea.l	(a0,d0.w),a0
	move.l	#MEM_CHIP,FH_Memory_Type(a0)	; force chip ram
	move.l	#ChainName,FH_FileName(a0)	; selected from requester	
	cmp.b	#0,ChainName			; is a instrument present
	beq.s	chained_ok
	bsr	LoadAnyOldFile
	tst.l	d0				; error occured?
	beq.s	chained_ok
	
error_while_chain_inst	
	nop
*	move.w	#$00f,$dff180
chained_ok
	move.w	(sp)+,d0
	rts
	

Play_Channel_Freq
* freq in d0
* channel in d1
* Octave in d2

	move.l	#0,play0			; clears all channels

	cmp.w	#0,d1
	bne.s	notk0
	move.b	#1,play0
	bra.s   goplayit
notk0
	cmp.w	#1,d1
	bne.s	notk1
	move.b	#1,play1
	bra.s   goplayit
notk1
	cmp.w	#2,d1
	bne.s	notk2
	move.b	#1,play2
	bra.s   goplayit
notk2
	cmp.w	#3,d1
	bne.s	notk3
	move.b	#1,play3
notk3
goplayit

	move.l	#Frequency_Table,a1
	lsl.w	#1,d0			; get words
	move.w	(a1,d0),d0

	cmp.w	#1,d2
	bne.s	not_octave1
	lsl.w	d0			; octave
not_octave1
	cmp.w	#3,d2
	bne.s	not_octave3
	lsr.w	d0
not_octave3

	move.l	#Samples,a0
	mulu.w	#SSSIZE,d1

	lea.l	(a0,d1.w),a4
	move.w	d0,Sound_Period(a4)

	move.l	#Samples,a5

	bsr	Play_Sounds
	rts


KeyBoard_Test
	cmp.b	#1,call_scan_routine
	beq	endkbtest
	tst.b	key_release_flag
	beq.s	play_keyboard

	move.b	$bfec01,d0	; Read Keypress
	ror.b	#1,d0		; shuffle
	btst.l	#7,d0
	bne	endkbtest
	move.b	#0,key_release_flag

play_keyboard	
	moveq.l	#0,d0
	move.b	$bfec01,d0	; Read Keypress
	ror.b	#1,d0		; shuffle
	btst.l	#7,d0
	beq.s	not_found_key
	andi.b	#$7f,d0		; 
	
	move.w	#0,d1
	move.l	#KeyNumbers,a0
check_key
	cmp.b	#-1,(a0)
	beq.s	not_found_key
	cmp.b	(a0)+,d0
	beq.s	found_key
	addq.w	#1,d1
	bra.s    check_key
not_found_key
	
	bra.s	endkbtest	

found_key
	move.b	#-1,key_release_flag
	move.w	d1,d0
	move.w	#0,d1
	move.w	#1,d2
	bsr	Play_Channel_Freq	
	
endkbtest
	rts
	
key_release_flag	dc.b	0
	even
KeyNumbers
	dc.b	78,94,77,93,76,75,91,74,90,73,89,72,71,87,70,86,69
	dc.b	-1
	even
	
Keyboard_channel	dc.w	0

Play_Channel_Sample
	move.l	clicked_button,a0
	move.b	button_data(a0),d1

	move.b	#0,play0		; just in case
	move.b	#0,play1
	move.b	#0,play2
	move.b	#0,play3

	cmp.b	#0,d1
	bne.s	skipchan
	move.b	#1,play0
skipchan	
	cmp.b	#1,d1
	bne.s	skipchan1
	move.b	#1,play1
skipchan1
	cmp.b	#2,d1
	bne.s	skipchan2
	move.b	#1,play2
skipchan2
	cmp.b	#3,d1
	bne.s	skipchan3
	move.b	#1,play3
skipchan3
	move.l	#Samples,a5
	bsr	Play_Sounds
	rts

channel_to_load
	dc.b	0
	even
	
Set_Channel_Screen
	move.l	#editor_button_list,a0
	bsr	remove_button_list
	move.l	#Sound_Test_button_list,a0
	bsr	display_button_list
	rts

Exit_Channel_routine
	move.l	#Sound_Test_button_list,a0
	bsr	remove_button_list
	move.l	#editor_button_list,a0
	bsr	display_button_list
	bsr	stop_music
	rts


aud	EQU   $0A0
aud0	EQU   $0A0
aud1	EQU   $0B0
aud2	EQU   $0C0
aud3	EQU   $0D0

ac_ptr	EQU   $00
ac_len	EQU   $04
ac_per	EQU   $06
ac_vol	EQU   $08
ac_dat	EQU   $0A
ac_SIZEOF	EQU   $10
	
	rsreset
Sound_Ptr	rs.l	1
Sound_Length	rs.w	1
Sound_Period	rs.w	1
Sound_Volume	rs.w	1
Sound_Repeat	rs.w	1
Sound_Rep_Len	rs.w	1

Samples
	dc.l	blank		; Address of Sample
	dc.w	1		; Length of sample (in words)
Freq0	dc.w	1 		; Period (frequency)
	dc.w	64		; Volume
	dc.w	0		; Repeat
	dc.w	1		; Repeat length
SSSize	EQU	*-Samples

*Chan1
	dc.l	blank		; Address of Sample
	dc.w	1		; Length of sample (in words)
Freq1	dc.w	214		; Period (frequency)
	dc.w	64		; Volume
	dc.w	0		; Repeat
	dc.w	1		; Repeat length

*Chan2
	dc.l	blank		; Address of Sample
	dc.w	1		; Length of sample (in words)
Freq2	dc.w	214		; Period (frequency)
	dc.w	64		; Volume
	dc.w	0		; Repeat
	dc.w	1		; Repeat length

*Chan3
	dc.l	blank		; Address of Sample
	dc.w	1		; Length of sample (in words)
Freq3	dc.w	214		; Period (frequency)
	dc.w	64		; Volume
	dc.w	0		; Repeat
	dc.w	1		; Repeat length

Frequency_Table

	dc.w 428,404,381,360,339,320,302,285,269,254,240,226,214
	dc.w 202,190,180,170,160,151,143,135,127,120,113,107,101
	dc.w 95,90,85,80,75,71,67,63,60,56,53

ST_Freq_Table

 dc.w $0358,$0328,$02fa,$02d0,$02a6,$0280,$025c,$023a,$021a,$01fc,$01e0
 dc.w $01c5,$01ac,$0194,$017d,$0168,$0153,$0140,$012e,$011d,$010d,$00fe
 dc.w $00f0,$00e2,$00d6,$00ca,$00be,$00b4,$00aa,$00a0,$0097,$008f,$0087
 dc.w $007f,$0078,$0071,$0000,-1

ST_Conversion_Table
	dc.w	1,"C ",1,"C#",1,"D ",1,"D#",1,"E ",1,"F ",1,"F#",1
        dc.w    "G ",1,"G#",2,"A ",2,"A#",2,"B "
	dc.w	2,"C ",2,"C#",2,"D ",2,"D#",2,"E ",2,"F ",2,"F#",2
        dc.w    "G ",2,"G#",3,"A ",3,"A#",3,"B "
	dc.w	3,"C ",3,"C#",3,"D ",3,"D#",3,"E ",3,"F ",3,"F#",3
        dc.w    "G ",3,"G#",3,"RE",3,"RE",3,"RE",3,"RE",3,"RE",3,"RE"

put_up_music_buttons
	move.l	#editor_button_list,a0
	bsr	remove_button_list

	move.l	#music_play_buttons,a0
	bsr	display_button_list
	rts

exit_play_screen

	move.l	#music_play_buttons,a0
	bsr	remove_button_list
	move.l	#editor_button_list,a0
	bsr	display_button_list
	rts

stop_music
	move.w	#$f,$96(a6)	; kill audio DMA
	clr.b 	player_flag
	move.w	#0,Effect0
	move.w	#0,Effect1
	move.w	#0,Effect2
	move.w	#0,Effect3	
	rts

