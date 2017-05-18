one_block_buffer
	ds.w	2*32*8	
		
save_file_handle
	dc.l	0
save_buffer
	dc.l	0	

	rsreset
RWIDTH		rs.W	1
RHEIGHT		rs.W	1
XPOS		rs.W	1
YPOS		rs.W	1
NUMPLANES	rs.B	1
PMASK		rs.B	1
TYPECOM		rs.B	1
PAD		rs.B	1
TRANSCOLOUR	rs.W	1
XASPECT		rs.B	1
YASPECT		rs.B	1
PAGEWIDTH	rs.W	1
PAGEHEIGHT	rs.W	1		
BMHDSize	rs.w	1
		EVEN
		
size_of_BMHD EQU BMHDSize   ;8+4+2+2+4+2
		
save_bmhd
	ds.b size_of_BMHD		
	EVEN
				
PICTURE_DETAILS	
	dc.l	0		
buffer
	ds.l	1	
pic_pointer	
	dc.l	0	
header_size	
	dc.l	0		
colour_map_ptr  
	dc.l	0	
num_of_cols
	dc.l	0			
picture_data
	dc.l	0	
size_of_pic
	dc.l	0		
graphics_handle
	dc.l	0	

		
current_plane	dc.w	0	
pixel_count	dc.w	0


plane_positions
	ds.l	8	;maximum ever

picture_struct1
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_1_palette
picture_struct2
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_2_palette

picture_struct3
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_3_palette

picture_struct4
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_4_palette

picture_struct5
	dc.w	0	;pixel size x
	dc.w	0	;pixel size y
	dc.w	0,0	;x and y offsets
	dc.l	0	;mem pointer
	dc.w	0	;number of planes
	dc.l    pic_5_palette



picture_pages
	dc.l picture_struct1
	dc.l picture_struct2
	dc.l picture_struct3
	dc.l picture_struct4
	dc.l picture_struct5
	
page_pointer
	dc.l picture_struct1	


pic_1_palette

	DC.W $000,$787,$565,$aba,$464,$595,$fff,$121
        DC.W $555,$555,$555,$555,$000,$c00,$0c0,$00c
	dc.w  $f00,$fff,$f00,$222,$333,$444,$555,$666
	dc.w  $90f,$f00,$111,$222,$333,$444,$555,$666
	ds.w	224
       	
pic_2_palette

	DC.W $000,$787,$565,$aba,$464,$595,$fff,$121
        DC.W $555,$555,$555,$555,$000,$c00,$0c0,$00c
	dc.w  $f00,$fff,$f00,$222,$333,$444,$555,$666
	dc.w  $90f,$f00,$111,$222,$333,$444,$555,$666
	DC.W 0,$779,$557,$AAc,$446,$FFf,$FFF,$113
 	DC.W $222,$811,$181,$118,$999,$aaa,$bbb,$0CC
	ds.w	224
	ds.w	256

pic_3_palette
	DC.W $000,$787,$565,$aba,$464,$595,$fff,$121
        DC.W $555,$555,$555,$555,$000,$c00,$0c0,$00c
	dc.w  $f00,$fff,$f00,$222,$333,$444,$555,$666
	dc.w  $90f,$f00,$111,$222,$333,$444,$555,$666
	DC.W 0,$779,$557,$AAc,$446,$FFf,$FFF,$113
 	DC.W $222,$811,$181,$118,$999,$aaa,$bbb,$0CC
	ds.w	224
	ds.w	256


pic_4_palette
	DC.W $000,$787,$565,$aba,$464,$595,$fff,$121
        DC.W $555,$555,$555,$555,$000,$c00,$0c0,$00c
	dc.w  $f00,$fff,$f00,$222,$333,$444,$555,$666
	dc.w  $90f,$f00,$111,$222,$333,$444,$555,$666
	ds.w	224
	ds.w	256

pic_5_palette
	DC.W $000,$787,$565,$aba,$464,$595,$fff,$121
        DC.W $555,$555,$555,$555,$000,$c00,$0c0,$00c
	dc.w  $f00,$fff,$f00,$222,$333,$444,$555,$666
	dc.w  $90f,$f00,$111,$222,$333,$444,$555,$666
	ds.w	224
	ds.w	256
