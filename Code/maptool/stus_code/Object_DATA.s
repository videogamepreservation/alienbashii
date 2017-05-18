Obj_Type_Sig	EQU	1
Obj_Type_Note	EQU	2
Obj_Type_Rest	EQU	3
Obj_Type_Blah	EQU	4
Obj_Type_Tie	EQU	5

Max_Pixels_Per_Object	EQU	1000

Max_Stored_Objects	EQU	20
	
Object_Chain_Code	dc.w	$ffff
			ds.w	Max_Pixels_Per_Object

Object_Coordinate_List	dc.w	$ffff
		ds.w	Max_Pixels_Per_Object*2

Current_Object_Data
Object_Width		dc.w	0
Object_Height		dc.w	0
Object_Perimeter	dc.w	0
Object_Area		dc.l	0
Object_Moment_X		dc.l	0
Object_Moment_Y		dc.l	0
Object_Centroid_X	dc.w	0
Object_Centroid_Y	dc.w	0
Object_ID		dc.w	0
Object_Baseline		dc.w	0
Object_Signature	dc.w	$ffff
			ds.w	Max_Pixels_Per_Object

	rsreset
OD_Width		rs.w	1
OD_Height	rs.w	1
OD_Perimeter	rs.w	1
OD_Area		rs.l	1
OD_Moment_X	rs.l	1
OD_Moment_Y	rs.l	1
OD_Centroid_X	rs.w	1
OD_Centroid_Y	rs.w	1
OD_ID		rs.w	1
OD_Baseline	rs.w	1
OD_Signature	rs.w	1

OD_SIZE		rs.w	0

Number_Learned_Objects	dc.w	0

Object_Selected 	dc.w	0

Object_File_Structure
	dc.l	Current_Filename
	dc.l	MEM_FIX
	dc.l	Object_Base
	dc.l	0

Object_Base	dc.b	"OBJ."

Object_Wide_Parameters

OBJ_Max_Width	dc.w	100,1,100
OBJ_Max_Height	dc.w	60,1,60
OBJ_Max_Pixels	dc.w	Max_Pixels_Per_Object,5,Max_Pixels_Per_Object
OBJ_Width_Tol	dc.w	5,1,20
OBJ_Height_Tol	dc.w	5,1,20
OBJ_Perim_Tol	dc.w	20,1,30
OBJ_Area_Tol	dc.w	30,1,30
		dc.w	1,1,10
		dc.w	1,1,10
		dc.w	1,1,10
		dc.w	1,1,10
		dc.w	1,1,10

Object_Memory	ds.l	Max_Stored_Objects
		dc.l	$ffffffff


Object_Store	ds.w	(((Max_Pixels_Per_Object+1)*2)+OD_Size)*Max_Stored_Objects

End_Of_Object_Memory	dc.l	Object_Store

Object_Parameter_Text
	dc.b "Max Width  :",$a
	dc.b "Max Height :",$a
	dc.b "Max Perim  :",$a
	dc.b "Width  Tol :",$a
	dc.b "Height Tol :",$a
	dc.b "Perim  Tol :",$a
	dc.b "Area   Tol :",$a
	dc.b 0
	even

Object_Names
	dc.b	"Sign",$a,"Treble-Clef",0,Obj_Type_Sig,1
Object_Name_Length	EQU	*-Object_Names
	dc.b     "Sign",$a,"Bass-Clef  ",0,Obj_Type_Sig,2
	dc.b	"Note",$a,"Breive     ",0,Obj_Type_Note,Breive
	dc.b	"Note",$a,"Semi-Breive",0,Obj_Type_Note,SEMI_Breive
	dc.b	"Note",$a,"Minim      ",0,Obj_Type_Note,Minim
	dc.b	"Note",$a,"Crotchet   ",0,Obj_Type_Note,Crotchet
	dc.b	"Note",$a,"Quaver     ",0,Obj_Type_Note,Quaver
	dc.b	"Note",$a,"Semi-Quaver",0,Obj_Type_Note,SEMI_Quaver
	dc.b	"Note",$a,"DS-Quaver  ",0,Obj_Type_Note,DEMI_SEMI_Quaver
	dc.b	"Note",$a,"HDS-Quaver ",0,Obj_Type_Note,HEMI_DEMI_SEMI_Quaver
	dc.b	"Note",$a,"Note-Tie   ",0,Obj_Type_Tie,0


	dc.b	"Rest",$a,"Breive     ",0,Obj_Type_Rest,Breive
	dc.b	"Rest",$a,"Semi-Breive",0,Obj_Type_Rest,SEMI_Breive
	dc.b	"Rest",$a,"Minim      ",0,Obj_Type_Rest,Minim
	dc.b	"Rest",$a,"Crotchet   ",0,Obj_Type_Rest,Crotchet
	dc.b	"Rest",$a,"Quaver     ",0,Obj_Type_Rest,Quaver
	dc.b	"Rest",$a,"Semi-Quaver",0,Obj_Type_Rest,SEMI_Quaver
	dc.b	"Rest",$a,"DS-Quaver  ",0,Obj_Type_Rest,DEMI_SEMI_QUAVER
	dc.b	"Rest",$a,"HDS-Quaver ",0,Obj_Type_Rest,HEMI_DEMI_SEMI_QUAVER

	dc.b	"Acci",$a,"Sharp      ",0,Obj_Type_Blah,"#"
	dc.b     "Acci",$a,"Flat       ",0,Obj_Type_Blah,"b"
	dc.b     "Acci",$a,"Natural    ",0,Obj_Type_Blah," "
No_Object_Types	EQU	(*-Object_Names)/Object_Name_Length
	even	
	
Recognition_Stave_Table
 	dc.b	"B",5,"A",5
 	dc.b     "G",4,"F",4,"E",4,"D",4,"C",4,"B",4,"A",4
 	dc.b	"G",3,"F",3,"E",3,"D",3,"C",3,"B",3,"A",3
 	dc.b	"G",2,"F",2,"E",2,"D",2,"C",2,"B",2,"A",2
 	dc.b	"G",1,"F",1,"E",1,"D",1,"C",1,"B",1,"A",1
Recognition_Table_Length	EQU	*-Recognition_Stave_Table 
	even


