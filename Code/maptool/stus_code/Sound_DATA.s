Max_Inst_No	EQU	16

SoundTracker_File_Structure
	dc.l	Current_FileName
	dc.l	MEM_FAST
	dc.l	0
	dc.l	0

	rsreset
	rs.l	1
	rs.l	1
	rs.l	1
	rs.l	1
INST_Repeat	rs.w	1
INST_Rep_Len	rs.w	1
INST_Volume	rs.w	1
INST_Struct_Size	rs.w	0

Instrument_Names        
	ds.b	25*31
	even

Sound_File_Structure
	ds.b	INST_Struct_Size*Max_Inst_No
	even

Sound_File_End
	dc.l	0
	
ChainName	dc.b	"instruments/"	default device
Chain_FileName	ds.b	25
	even

Monitor_window
	dc.w 600
	dc.w 150
	dc.w 20
	dc.w 20
	dc.l 0
	dc.l 0
	dc.b "SOUND STUDIO",0
	
	EVEN

music_play_buttons
	
	dc.l	Play_Exit_Button,prms_butt
	dc.l	start_the_music,stop_the_music
	dc.l	chill_out_button
	dc.l	KeyBoard_Test_Button,-1

sound_test_button_list
	dc.l	Channel_Exit_Button
	dc.l	Instrument_Button,Channel_Exit_Button
	dc.l	st_load_button,Chain_Inst_Button,-1


Chain_Inst_Button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Chain_in_Instruments ; 
	dc.b	"GET INST'S",0		
	even

prms_butt
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0	;not used
	dc.l	0	;not used
	dc.l	display_change_details_window
	dc.b	"MUSIC PRMS",0		
	EVEN						


start_the_music
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	play_music 
	dc.b	"START MUS",0		
	even

stop_the_music
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	stop_music 
	dc.b	"STOP MUS",0		
	even

chill_out_button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	drop_the_hi_res_and_get_wicked 
	dc.b	"CHILL OUT",0		
	even
	
Channel_Exit_Button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Exit_Channel_Routine ; 
	dc.b	"EXIT",0		
	even	

Play_Exit_Button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Exit_Play_Screen ; 
	dc.b	"EXIT",0		
	even	

KeyBoard_Test_Button
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	KeyBoard_Test 
	dc.b	"KEYBOARD",0		
	even	

LowPass_Button
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON+TOGGLE_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Toggle_Low_Pass_Filter 
	dc.b	"FILTER",0		
	even	

Monitor_Button
	dc.w	BUTTON_5
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Setup_Monitor_Window 
	dc.b	"MONITOR",0		
	even	

Monitor_Button_List	dc.l	Monitor_Exit_Button,-1

Monitor_Exit_Button
	dc.w	270
	dc.w	130
	dc.w	WINDOW
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Remove_Monitor_Window
	dc.b	"EXIT",0		
	even	

Instrument_window
	dc.w 460
	dc.w 100
	dc.w 40
	dc.w 10
	dc.l 0
	dc.l 0
	dc.b "INSTRUMENT SETTINGS",0
	EVEN

Instrument_Button
	dc.w	BUTTON_5
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Set_Instrument_Details
	dc.b	"INSTRUMENT",0
	even	

Instrument_Button_List
	dc.l	Instrument_Exit_Button,Instr_Load_Button
	dc.l	I_Up_Butt,I_Down_Butt
	dc.l	-1

I_Up_Butt
	dc.w	310
	dc.w	10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	arrow_up ;not used
	dc.l	0	;not used
	dc.l	Select_Instrument
	dc.b	0		
	EVEN						
I_Down_Butt
	dc.w	340
	dc.w	10
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	-1
	dc.b	0	;not used
	dc.l	arrow_down ;not used
	dc.l	0	;not used
	dc.l	Select_Instrument
	dc.b	0		
	EVEN						
	
Instrument_Exit_Button
	dc.w	280
	dc.w	60
	dc.w	WINDOW
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Remove_Instrument_Details
	dc.b	"OK",0		
	even	


Instr_Load_Button
	dc.w	280
	dc.w	30
	dc.w	WINDOW
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Load_Instrument
	dc.b	"LOAD",0		
	even	



Instrument_Window_Text
	dc.b	"Name    : ",$a,$a
	dc.b	"Number  : ",$a
	dc.b    "Volume  : ",$a    
	dc.b	"Repeat  : ",$a     
	dc.b    "Rep Len : ",$a
       	dc.b	0
       	even         






