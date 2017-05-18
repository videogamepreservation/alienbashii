MALFONT_HEIGHT	EQU	34

*Width table for the malboro proportional font
*p.s font starts at $20

malfont_width_table

	dc.b	9,5,9,10,12,10,10,5,6,6,10,10,5,9,4,10
	dc.b	9,9,9,9,9,9,9,9,9,9,4,4,8,8,9,9,9,9,9,9,9,9
	even
malfont_width_table2	
	dc.b	9,9,9,4,9,9,9,11,9,9,9,9,9,9,10,9,9,11,9,10
	dc.b	9,6,9,6,10,6,10,9,9,9,9,9,9,10,9,4
	even
malfont_width_table3	
	dc.b	9,9,4,12,9,9,9,9,9,9,9,9,9,12,9,9,9
	
	EVEN
	
SMALLFONT_HEIGHT	EQU	9

*Width table for the small proportional font
*p.s fonts starts at $20

smallfont_width_table
	dc.b	5,2,5,6,4,5,5,3
	dc.b	3,3,4,4,3,5,2,5
	dc.b	5,4,5,5,5,5,5,5,5
	dc.b	5,2,3,4,4,4,5,5
	dc.b	5,5,5,5,5,5,5,5,2
	dc.b	5,5,5,6,5,5,5,5
	dc.b	5,5,5,5,6,6,6,6,6
	dc.b	4,5,4,4,6,3
	dc.b	5,5,5,5
	EVEN	
smallfont_width_table2
	dc.b	5,3,5,5,2,3,5,3
	dc.b	6,5,5,5,5,5,5,5,5,6
	dc.b	6,5,5,5,4,4,4	
	EVEN
	