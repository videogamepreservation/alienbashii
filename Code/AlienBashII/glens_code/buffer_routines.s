************************************************************
*****           Swap_Buffers                      **********
************************************************************
Swap_Buffers

	move.l	plane1,d0

	move.l	buff_plane1,plane1

	move.l	d0,buff_plane1
	
	move.l	add_size,d0
	move.l	add_size_buff,add_size
	move.l	d0,add_size_buff
	
	rts

************************************************************
*****           Reset_Buffers                     **********
************************************************************
Reset_Buffers

	move.l	resetp1,plane1
	move.l	resetp2,buff_plane1
	move.l	#PLANE_INC*4,add_size
	move.l	#PLANE_INC*8,add_size_buff


	rts
*-------------------Memory and plane pointers-------------------*

Blank	Dc.l	0

Memory_Base	dc.l	0


plane1
	dc.l	0
plane2
	dc.l	0
plane3
	dc.l	0
plane4
	dc.l	0	

resetp1		dc.l	0
resetp2		dc.l	0
	
add_size	dc.l	PLANE_INC*4
add_size_buff	dc.l	PLANE_INC*8


buff_plane1
	dc.l	0
buff_plane2
	dc.l	0
buff_plane3
	dc.l	0
buff_plane4
	dc.l	0	

scroll_area
	dc.l	0

scroll_buff_area
	dc.l	0	
	
copyback_area
	dc.l	0		