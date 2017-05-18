VirtualhorizHi	EQU	100
VirtualhorizLo	EQU	100
VirtualVertHi	EQU	100
VirtualVertlo	EQU	100
BS2		DC.W	0
mask_shift	dc.w	0

OLDBOB		DC.L	BOBBACK1
OLDBOB_BUFFER	DC.L	BOBBACK2
FRIENDLY	DC.L	FRIEND1
FRIENDLY_BUFFER	DC.L	FRIEND2
REPLACE_AREA	DC.L	SAVE1
REPLACE_AREA_BUFFER	DC.L	SAVE2
CLEAR_AREA	dc.l	CLEAR1
CLEAR_AREA_BUFFER	dc.l	CLEAR2
SAVEBACK_AREA	dc.l	0
SAVEBACK_BUFFER	dc.l	0
CLEAR_LIST	dc.l	LIST1
CLEAR_LIST_BUFFER	dc.l	LIST2
Temporary_Object_LIST	ds.l	Max_No_Objects+1

Available_Pointer	dc.l	0
Last_Alien_In_List	dc.l	0

	rsreset
SaveBack_Screen_Ptr		rs.l	1
SaveBack_Memory_Ptr		rs.l	1
SaveBack_Graphics_Struct	rs.l	1
SaveBack_Struct_Size		rs.l	1

	rsreset
Clear_Screen_Pointer	rs.l	1
Clear_Mask_Pointer	rs.l	1
Clear_Graphics_Struct	rs.l	1
Clear_Shift_Value	rs.w	1
Clear_Struct_Size	rs.w	1



BOBBACK1	DS.L	Max_No_Objects+1
BOBBACK2	DS.L	Max_No_Objects+1
FRIEND1		DS.L	Max_No_Objects+1
FRIEND2		DS.L	Max_No_Objects+1
LIST1		DS.L	Max_No_Objects+1
LIST2		DS.L	Max_No_Objects+1
SAVE1		DS.L	Max_No_Objects*SaveBack_Struct_Size+1
SAVE2		DS.L	Max_No_Objects*SaveBack_Struct_Size+1
CLEAR1		DS.l	Max_No_Objects*Clear_Struct_Size+1
CLEAR2		DS.l	Max_No_Objects*Clear_Struct_Size+1


Alien_Dead	EQU	0
Alien_Hit	EQU	1
Alien_Dying	EQU	2
Alien_OffScreen	EQU	3
Ground_Collision	EQU	4
No_Saveback	EQU	5
Alien_Burn	EQU	6
Alien_Burn2	EQU	7

* New Extra Modes
Alien_Left	EQU	0
Alien_Platform	EQU	1
Alien_Bonus	EQU	2
Alien_Object	EQU	3
Platform_Activate	EQU	4
Alien_Master	EQU	5

FLAG_OBJECT	EQU	1<<Alien_Object

* Modes For Guardians

Kill_Me_First EQU 6
Death_To_All EQU 7

	rsreset
Alien_Number	rs.w	1		; character type
Alien_GFX_Number	rs.w	1	; what graphics it uses
Alien_Data	rs.w	1
Frame_Number	rs.w	1
Frame_Counter	rs.w	1
Repeat_Counter	rs.w	1
Repeat_X	rs.w	1
Repeat_Y	rs.w	1
Alien_X		rs.w	1
Alien_Y		rs.w	1
Alien_Mode	rs.b	1
Alien_Mode2     rs.b	1
alien_in_air	rs.w	1
alien_fall_velocity	rs.w	1
alien_map_pointer	rs.l	1
Alien_Slave_Pointer	rs.l	1
Alien_Flight	rs.l	1
Animation_Mode	rs.w	1
Animation_LoFrame	rs.w	1
Animation_HiFrame	rs.w	1
Animation_Speed		rs.w	1
Animation_Flags		rs.w	1
Alien_Speed	rs.b	1
Alien_Hits	rs.b	1
Store_Destination	rs.l	1
Store_G_Pointer	rs.l	1
Store_Mask	rs.l	1
Store_Shift	rs.l	1
Store_Pointer	rs.l	1
Store_Graphics	rs.l	1
Store_Size	rs.w	1


	rsreset
Alien_Graphics	rs.l	1
Alien_Mask	rs.l	1
Alien_Mod	rs.w	1
Alien_Width	rs.w	1
Alien_Height	rs.w	1
Alien_Frame_Size	rs.l	1
Alien_Plane_Size	rs.l	1
Alien_D_Blit	rs.w	1

Graphics_Size	rs.w	1

Player_Object	dc.l	0

Enemy_List
	dc.l	Enemy_Store1
Enemy_List_Buffer
	dc.l	Enemy_Store2
		
Enemy_Store1
	ds.l	Max_No_Objects+1
Enemy_Store2
	ds.l	Max_No_Objects+1	

Available_List	ds.l	Max_No_Objects+1

Enemy_Memory	ds.b	Store_Size*Max_No_Objects
	even
	

Level_1_Enemies
	*dc.w	hedgehog_character,140,200,0
	*dc.w	platform_character,100,240,0
*	dc.w	circle_platform_character,160,240,0

*	dc.w	circle_platform_character,400,240,0
*	dc.w	circle_platform_character,700,240,0	
*	dc.w	goal_character,200,410,1
	*dc.w	springboard_character,160,460,0
	*dc.w	springboard_character,200,460,0
	*dc.w	fish_character,325,470,50
	*dc.w	elevator_character,340,300,50
*	dc.w	callbutton_character,400,420,0
	*dc.w	elevator_character,400,350,60
	*dc.w	elevator_character,460,290,100
	*dc.w	squiz_character,550,100,0
	*dc.w	squiz_character,400,340,0
	*dc.w	$ffff

	dc.w	$ffff
