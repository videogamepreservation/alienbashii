maggot_graphics_table
	dc.l	maggotup
	dc.l	maggotupright
	dc.l 	maggotright
	dc.l	maggotrightdown
	dc.l	maggotdown
	dc.l	maggotdownleft
	dc.l	maggotleft
	dc.l	maggotleftup

maggot_mask_table
	dc.l	maggotup+(16*2)*4*NUM_PLANES
	dc.l	maggotupright+(16*2)*4*NUM_PLANES
	dc.l 	maggotright+(16*2)*4*NUM_PLANES
	dc.l	maggotrightdown+(16*2)*4*NUM_PLANES
	dc.l	maggotdown+(16*2)*4*NUM_PLANES
	dc.l	maggotdownleft+(16*2)*4*NUM_PLANES
	dc.l	maggotleft+(16*2)*4*NUM_PLANES
	dc.l	maggotleftup+(16*2)*4*NUM_PLANES

wasp_graphics_table
	dc.l	waspup
	dc.l	waspupright
	dc.l 	waspright
	dc.l	wasprightdown
	dc.l	waspdown
	dc.l	waspdownleft
	dc.l	waspleft
	dc.l	waspleftup

wasp_mask_table
	dc.l	waspup+(14*2)*2*NUM_PLANES
	dc.l	waspupright+(14*2)*2*NUM_PLANES
	dc.l 	waspright+(14*2)*2*NUM_PLANES
	dc.l	wasprightdown+(14*2)*2*NUM_PLANES
	dc.l	waspdown+(14*2)*2*NUM_PLANES
	dc.l	waspdownleft+(14*2)*2*NUM_PLANES
	dc.l	waspleft+(14*2)*2*NUM_PLANES
	dc.l	waspleftup+(14*2)*2*NUM_PLANES

alien1_graphics_table
	dc.l	piggraphicsu
	dc.l	piggraphicsur
	dc.l 	piggraphicsr
	dc.l	piggraphicsdr
	dc.l	piggraphicsd
	dc.l	piggraphicsdl
	dc.l	piggraphicsl
	dc.l	piggraphicslu

alien1_mask_table
	dc.l	piggraphicsu+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicsur+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l 	piggraphicsr+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicsdr+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicsd+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicsdl+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicsl+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	dc.l	piggraphicslu+((PIG_ALIEN_HEIGHT*4)*6)*NUM_PLANES
	
FLY_HEIGHT	EQU	5	
	
fly_graphics_table
	dc.l	Fly_Graphics
	dc.l	Fly_Graphics+FLY_HEIGHT*4
	dc.l	Fly_Graphics+(FLY_HEIGHT*4)*2
	dc.l	Fly_Graphics+(FLY_HEIGHT*4)*3
	dc.l	Fly_Graphics
	dc.l	Fly_Graphics+(FLY_HEIGHT*4)
	dc.l	Fly_Graphics+(FLY_HEIGHT*4)*2
	dc.l	Fly_Graphics+(FLY_HEIGHT*4)*3


Fly_mask_table
	dc.l	Fly_Graphics+(FLY_HEIGHT*4*4)*NUM_PLANES
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4*2
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4*3
	dc.l	Fly_Graphics+(FLY_HEIGHT*4*4)*NUM_PLANES
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4*2
	dc.l	Fly_Graphics+((FLY_HEIGHT*4*4)*NUM_PLANES)+FLY_HEIGHT*4*3
