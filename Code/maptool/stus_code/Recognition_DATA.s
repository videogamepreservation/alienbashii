Last_X	dc.w	0
Last_Y	dc.w	0
Start_Of_Object_X	dc.w	0
Start_Of_Object_Y dc.w	0
Last_Vector	dc.w	0
Image_Start_X	dc.w	0
Image_Start_Y	dc.w	0
Image_End_X	dc.w	BI_WIDTH
Image_End_Y	dc.w	BI_HEIGHT
X_Scan	dc.w	0
Y_Scan	dc.w	0
Object_Min_X	dc.w	0
Object_Max_X	dc.w	0
Object_Min_Y	dc.w	0
Object_Max_Y	dc.w	0
Number_Of_Links	dc.w	0


Recognition_Button_List
	dc.l	Load_Image_Button,Save_New_Image,Edges_Button,Trace_Button
	dc.l	Threshold_Button,Object_Parameters_Button,staves_button
	dc.l	Reset_Trace_Button,Set_Image_Button,Sketch_Image_Button
	dc.l	ObjMem_Button,Auto_Rec_Button
	dc.l	scroll_rec_up,scroll_rec_down
	dc.l	Exit_Button,-1


scroll_rec_up
	dc.w	BUTTON_5+40+70+20
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_up	;not used
	dc.l	0	;not used
	dc.l	scroll_screen_up
	dc.b	0		
	EVEN						

scroll_rec_down
	dc.w	BUTTON_5+40+70+20
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	arrow_down	;not used
	dc.l	0	;not used
	dc.l 	scroll_screen_down
	dc.b	0		
	EVEN						



Load_Image_Button
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Load_an_Image_File ; 
	dc.b	"LOAD IMAGE",0		
	even

Save_New_Image
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l    Save_New_Image_Data 
	dc.b	"SAVE MUSIC",0		
	even

Edges_Button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Find_Edges ; 
	dc.b	"DO EDGES",0		
	even

Trace_Button
	dc.w	BUTTON_4
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Manual_Scan ; 
	dc.b	"DO TRACE",0		
	even

Reset_Trace_Button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Reset_Trace_Variables ; 
	dc.b	"RESET TR.",0		
	even

Set_Image_Button
	dc.w	BUTTON_3
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Set_Image_Window ; 
	dc.b	"SET SIZE",0		
	even

Sketch_Image_Button
	dc.w	BUTTON_4
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Sketchy ; 
	dc.b	"SKETCH",0		
	even

Threshold_Button
	dc.w	BUTTON_3
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Display_Threshold ; 
	dc.b	"THRESHOLD",0		
	even

Object_Parameters_Button
	dc.w	BUTTON_4
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Display_Object_Parameters
	dc.b	"OBJ PARAM",0		
	EVEN		

EXIT_Button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Exit_Recognition_Routine 
	dc.b	"EXIT",0		
	even

Threshold_Button_List
	dc.l	scroll_rec_up,scroll_rec_down,Set_Image_Button,staves2_button
	dc.l	Threshold_Up_Button,Threshold_Down_Button,thresh_button
	dc.l	Threshold_Grey_Scales_Button,Exit_Threshold_Button,-1

Staves2_Button
	dc.w	BUTTON_3
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Set_Stave_Position ; 
	dc.b	"STAVES",0		
	even


Staves_Button
	dc.w	BUTTON_5
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Set_Stave_Position ; 
	dc.b	"STAVES",0		
	even

ObjMem_Button
	dc.w	BUTTON_5
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	create_object_details_window ; 
	dc.b	"OBJ MEM",0		
	even
	
Auto_Rec_Button
	dc.w	BUTTON_5
	dc.w	THIRD_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	auto_scan ; 
	dc.b	"AUTO REC",0		
	even

Threshold_Up_Button
	dc.w	BUTTON_1
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Threshold_Up ; 
	dc.b	"THR. UP",0		
	even

Threshold_Down_Button
	dc.w	BUTTON_1
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Threshold_Down 
	dc.b	"THR. DOWN",0		
	even

Threshold_Grey_Scales_Button
	dc.w	BUTTON_2
	dc.w	FIRST_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON+TOGGLE_BUTTON ;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Set_Grey_Scales
	dc.b	"GREY SCALE",0		
	even

Thresh_Button
	dc.w	BUTTON_2
	dc.w	SECOND_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	 	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Threshold_Image
	dc.b	"DO IMAGE",0		
	even

EXIT_Threshold_Button
	dc.w	BUTTON_1
	dc.w	FOURTH_ROW
	dc.w	MAIN_BUTTON_SCREEN	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Remove_Threshold ; 
	dc.b	"EXIT",0		
	even

Object_Details_Window
	dc.w	600
	dc.w	180
	dc.w	20
	dc.w	0
	dc.l	0
	dc.l	0
	dc.b	"OBJECT CLASSIFICATION DETAILS",0
	even		

Object_Details_Buttons
	dc.l	Object_Ok_Button
	dc.l	Learn_Object_Button,Delete_Object_Button
	dc.l	Guess_Object_Button,increase_obj_button
	dc.l	decrease_obj_button,Load_Objects_Button,Base_Line_Button
	dc.l	type_inc_button
	dc.l	Save_Objects_Button,-1

type_inc_button
	dc.w	190
	dc.w	144
	dc.w	WINDOW ;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	plus_button
	dc.l	0	;not used
	dc.l	Increase_Object_Type
	dc.b	0
	even

Base_Line_Button
	dc.w	BUTTON_4+50
	dc.w	40
	dc.w	WINDOW ;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Baseline_Object
	dc.b	"BASELINE",0
	even
	
Learn_Object_Button
	dc.w	button_4+50
	dc.w	56
	dc.w	WINDOW ;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Learn_Object
	dc.b	"LEARN",0
	even
	
Guess_Object_Button
	dc.w	button_4+50
	dc.w	72
	dc.w	WINDOW ;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Guess_Object
	dc.b	"GUESS",0
	even

increase_obj_button
	dc.w	340+50
	dc.w	21
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_number
	dc.b	0		
	EVEN						

decrease_obj_button
	dc.w	360+50
	dc.w	21
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_number
	dc.b	0		
	EVEN		

Delete_Object_Button
	dc.w	button_4+50
	dc.w	88
	dc.w	WINDOW ;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Delete_Object
	dc.b	"DELETE",0
	even
	
Load_Objects_button
	dc.w	button_4+50
	dc.w	104
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	load_object_memory
	dc.b	"LOAD",0		
	EVEN		

Save_Objects_button
	dc.w	button_4+50
	dc.w	120
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	save_object_memory
	dc.b	"SAVE",0		
	EVEN		


Object_Ok_Button
	dc.w	button_4+50
	dc.w	136
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Close_Object_Details_Window
	dc.b	"EXIT",0
	even

Object_Text
	dc.b	"Width  :        Cen-X :",$a
	dc.b	"Height :        Cen-Y :",$a
	dc.b	"Perim  :        Ident :",$a
	dc.b	"Area   :",$a,0
	even

	
Radii_Button_List
	dc.l	Signature_Ok_Button,-1
	
	
Radii_Signature_Window
	dc.w	500
	dc.w	140
	dc.w	50
	dc.w	50
	dc.l	0
	dc.l	0
	dc.b	"RADII SIGNATURE",0
	even		

Signature_Ok_Button
	dc.w	BUTTON_1
	dc.w	85
	dc.w	WINDOW ;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	End_Radii_Signature
	dc.b	"OK",0
	even

Object_Parameters_Window
	dc.w	484
	dc.w	100
	dc.w	40
	dc.w	10
	dc.l	0
	dc.l	0
	dc.b	"OBJECT RECOGNITION PARAMETERS",0
	even		

Object_Parameters_Button_List
	dc.l	Object_Parameters_Ok_Button
	dc.l	ParPlusButton0,ParMinusButton0
	dc.l	ParPlusButton1,ParMinusButton1
	dc.l	ParPlusButton2,ParMinusButton2
	dc.l	ParPlusButton3,ParMinusButton3
	dc.l	ParPlusButton4,ParMinusButton4
	dc.l	ParPlusButton5,ParMinusButton5
	dc.l	ParPlusButton6,ParMinusButton6
	dc.l	BSM_Button
	dc.l	-1


ParPlusButton0
	dc.w	200
	dc.w	6
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton0
	dc.w	220
	dc.w	6
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						

ParPlusButton1
	dc.w	200
	dc.w	17
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton1
	dc.w	220
	dc.w	17
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	1
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						
ParPlusButton2
	dc.w	200
	dc.w	28
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton2
	dc.w	220
	dc.w	28
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	2
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						

ParPlusButton3
	dc.w	200
	dc.w	39
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton3
	dc.w	220
	dc.w	39
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	3
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						
ParPlusButton4
	dc.w	200
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton4
	dc.w	220
	dc.w	50
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	4
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						

ParPlusButton5
	dc.w	200
	dc.w	61
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton5
	dc.w	220
	dc.w	61
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	5
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						

ParPlusButton6
	dc.w	200
	dc.w	72
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	6
	dc.b	0	;not used
	dc.l	plus_button	;not used
	dc.l	0	;not used
	dc.l	increase_object_parameter
	dc.b	0		
	EVEN						

ParMinusButton6
	dc.w	220
	dc.w	72
	dc.w	WINDOW	;frame type
	dc.b	CUSTOM_BUTTON+HOLD_BUTTON
	dc.b	NOT_DEPRESSED	
	dc.b	6
	dc.b	0	;not used
	dc.l	minus_button	;not used
	dc.l	0	;not used
	dc.l	decrease_object_parameter
	dc.b	0		
	EVEN						

Object_Parameters_Ok_Button

	dc.w	BUTTON_3+60
	dc.w	40
	dc.w	WINDOW	;frame type
	dc.b	STANDARD_BUTTON	;standard
	dc.b	NOT_DEPRESSED
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Remove_Object_Parameters
	dc.b	"OK",0
	even

BSM_Button
	dc.w	BUTTON_3+60
	dc.w	20
	dc.w	WINDOW	
	dc.b	STANDARD_BUTTON+TOGGLE_BUTTON	;standard
	dc.b	NOT_DEPRESSED	
	dc.b	0
	dc.b	0	;not used
	dc.l	0
	dc.l	0	;not used
	dc.l	Toggle_BSM ; 
	dc.b	"FAST PROC",0		
	even
	
