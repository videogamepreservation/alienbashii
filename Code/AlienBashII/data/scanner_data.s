SCANNER_WINDOW_WIDTH		EQU	576
SCANNER_WINDOW_HEIGHT		EQU	480

SCANNER_MAX_POINTS	EQU	20


	rsreset
	
scanner_point_x		rs.w	1	;scanner co-ords
scanner_point_y		rs.w	1
scanner_map_pos		rs.l	1
scanner_data_size 	rs.w	1	

	rsreset
	
scanner_mem_pos		rs.l	1	;pointer to byte
scanner_pix_pos		rs.b	1
scanner_sprpos		rs.b	1
scanner_pixels_size	rs.w	1

scanner_point_data
	ds.b	scanner_data_size*SCANNER_MAX_POINTS
	
points_on_scanner
	ds.b	scanner_pixels_size*SCANNER_MAX_POINTS		
	
scanner_x_clip_data
	dc.w	13,13
	dc.w	12,19
	dc.w	9,22
	dc.w	7,24
	dc.w	6,25
	dc.w	5,26
	dc.w	4,27
	dc.w	3,28
	dc.w	3,28
	dc.w	2,29
	dc.w	2,29
	dc.w	2,29
	dc.w	1,30
	dc.w	1,30
	dc.w	1,30
	
	dc.w	1,30
	dc.w	1,30
	dc.w	1,30
	dc.w	1,30
	dc.w	2,29
	dc.w	2,29
	dc.w	2,29
	dc.w	3,28
	dc.w	3,28
	dc.w	4,27
	dc.w	5,26
	dc.w	6,25
	dc.w	7,24
	dc.w	9,22
	dc.w	12,19
	dc.w	13,13	