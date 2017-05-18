**************************************************
***      INSTRUCTION SCREEN COPPER LIST        ***
**************************************************

instr_copper
	dc.w	bplcono 
	dc.w	$6400		;
	dc.w	BPLCON2
	dc.w	%1000100
	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d0
	dc.w	DIWSTRT
	dc.w	$2C81  
	dc.w	DIWSTOP
	dc.w	$2cc1  
	dc.w	bpl1mod
	dc.w	64-40		
	dc.w	bpl2mod
	dc.w	0		;
	dc.w	$1e4		;1200 stuff
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$0

	DC.W	$00E0		
InPlane1_Hi	DC.W	0
	DC.W	$00E2
InPlane1_Lo	DC.W	0

	DC.W	$00E4
InPlane4_Hi	DC.W	0
	DC.W	$00E6
InPlane4_Lo	DC.W	0

	DC.W	$00E8		
InPlane2_Hi	DC.W	0
	DC.W	$00Ea
InPlane2_Lo	DC.W	0

	DC.W	$00Ec		
InPlane5_Hi	DC.W	0
	DC.W	$00Ee
InPlane5_Lo	DC.W	0

	DC.W	$00f0		
InPlane3_Hi	DC.W	0
	DC.W	$00f2
InPlane3_Lo	DC.W	0

	DC.W	$00f4		
InPlane6_Hi	DC.W	0
	DC.W	$00f6
InPlane6_Lo	DC.W	0

	dc.w $120		;all sprite stuff
insprite0h dc.w $0
	dc.w $122
insprite0l dc.w 0

         dc.w $124
insprite1h dc.w $0
	dc.w $126
insprite1l dc.w 0

         dc.w $128
insprite2h dc.w $0
	dc.w $12a
insprite2l dc.w 0 	

         dc.w $12c
insprite3h dc.w $0
	dc.w $12e
insprite3l dc.w 0	

         dc.w $130
insprite4h dc.w $0
	dc.w $132
insprite4l dc.w 0

         dc.w $134
insprite5h dc.w $0
	dc.w $136
insprite5l dc.w 0

         dc.w $138
insprite6h dc.w $0
	dc.w $13a
insprite6l dc.w 0

         dc.w $13c
insprite7h dc.w $0
	dc.w $13e
insprite7l dc.w 0

instr_cols
	dc.w	$180,0
	dc.w	$182,$012
	dc.w	$184,$124
	dc.w	$186,$136
	dc.w	$188,$158
	dc.w	$18a,$17a
	dc.w	$18c,$1ac
	dc.w	$18e,$012
	

	
Instr_Cols2	
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0
	
	dc.w	$7d01+$0900,$fffe	

	DC.W	$00E4
PagePlane1_Hi	DC.W	0
	DC.W	$00E6
PagePlane1_Lo	DC.W	0

	DC.W	$00Ec		
PagePlane2_Hi	DC.W	0
	DC.W	$00Ee
PagePlane2_Lo	DC.W	0

Instr_Text_Cols
	ds.w	9*9*8


Instr_Cols4
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0

	DC.W	$00E4
PageReset1_Hi	DC.W	0
	DC.W	$00E6
PageReset1_Lo	DC.W	0

	DC.W	$00Ec		
PageReset2_Hi	DC.W	0
	DC.W	$00Ee
PageReset2_Lo	DC.W	0

	dc.w	$ff01,$fffe
	dc.w	$ffdf,$fffe	

	dc.w	$2c01,$fffe		
	dc.w	intreq
	dc.w	$8010

	DC.W	$2cff,$FFFE

	ds.w	3
	
**************************************************
***          SHOP SCREEN COPPER LIST           ***
**************************************************
shop_copper
	dc.w	bplcono 
	dc.w	$5200		;
	dc.w	BPLCON2
	dc.w	%100000
	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d0
	dc.w	DIWSTRT
	dc.w	$2C81  
	dc.w	DIWSTOP
	dc.w	$2cc1  
	dc.w	bpl1mod
	dc.w	0		
	dc.w	bpl2mod
	dc.w	0		;
	dc.w	$1e4		;1200 stuff
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$0

	DC.W	$00E0		
ShopPlane1_Hi	DC.W	0
	DC.W	$00E2
ShopPlane1_Lo	DC.W	0

	DC.W	$00E4
ShopPlane2_Hi	DC.W	0
	DC.W	$00E6
ShopPlane2_Lo	DC.W	0

	DC.W	$00E8		
ShopPlane3_Hi	DC.W	0
	DC.W	$00Ea
ShopPlane3_Lo	DC.W	0

	DC.W	$00Ec		
ShopPlane4_Hi	DC.W	0
	DC.W	$00Ee
ShopPlane4_Lo	DC.W	0

	DC.W	$00f0		
ShopPlane5_Hi	DC.W	0
	DC.W	$00f2
ShopPlane5_Lo	DC.W	0

	dc.w $120		;all sprite stuff
shsprite0h dc.w $0
	dc.w $122
shsprite0l dc.w 0

         dc.w $124
shsprite1h dc.w $0
	dc.w $126
shsprite1l dc.w 0

         dc.w $128
shsprite2h dc.w $0
	dc.w $12a
shsprite2l dc.w 0 	

         dc.w $12c
shsprite3h dc.w $0
	dc.w $12e
shsprite3l dc.w 0	

         dc.w $130
shsprite4h dc.w $0
	dc.w $132
shsprite4l dc.w 0

         dc.w $134
shsprite5h dc.w $0
	dc.w $136
shsprite5l dc.w 0

         dc.w $138
shsprite6h dc.w $0
	dc.w $13a
shsprite6l dc.w 0

         dc.w $13c
shsprite7h dc.w $0
	dc.w $13e
shsprite7l dc.w 0



shop_cols1
	dc.w	$180,0
	dc.w	$182,0
	dc.w	$184,0
	dc.w	$186,0
	dc.w	$188,0
	dc.w	$18a,0
	dc.w	$18c,0
	dc.w	$18e,0
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0
	dc.w	$1a0,0
	dc.w	$1a2,0
	dc.w	$1a4,0
	dc.w	$1a6,0
	dc.w	$1a8,0
	dc.w	$1aa,0
	dc.w	$1ac,0
	dc.w	$1ae,0
	dc.w	$1b0,0
	dc.w	$1b2,0
	dc.w	$1b4,0
	dc.w	$1b6,0
	dc.w	$1b8,0
	dc.w	$1ba,0
	dc.w	$1bc,0
	dc.w	$1be,0

	
	dc.w	$a801,$fffe
	DC.W	$00f0		
ProductPlane5_Hi	DC.W	0
	DC.W	$00f2
ProductPlane5_Lo	DC.W	0

product_cols	
	ds.w	18*27

	dc.w	$c301,$fffe
	DC.W	$00f0		
RestorePlane5_Hi	DC.W	0
	DC.W	$00f2
RestorePlane5_Lo	DC.W	0

restore_cols
	ds.w	2*8
	

	
	dc.w	$ff01,$fffe
	dc.w	$ffdf,$fffe	


	dc.w	$2c01,$fffe	
	dc.w	intreq
	dc.w	$8010

	dc.w	$2cff,$fffe


**************************************************
***        SHAREWARE SCREEN COPPER LIST        ***
**************************************************

shareware_screen_copper
	dc.w	bplcono 
	dc.w	$B200		;hi-res 
	dc.w	BPLCON2
	dc.w	%000100
	dc.w	$102
	dc.w	$0
	dc.w	DDFSTRT
sharestart	
	dc.w	$003c
	dc.w	DDFSTOP
sharestop	
	dc.w	$00d4
	dc.w	DIWSTRT
	dc.w	$2C81  
	dc.w	DIWSTOP
	dc.w	$2cc1  
	dc.w	bpl1mod
	dc.w	0		
	dc.w	bpl2mod
	dc.w	0		;
	dc.w	$1e4		;1200 stuff
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$0

	dc.w $120		;all sprite stuff
swsprite0h dc.w $0
	dc.w $122
swsprite0l dc.w 0

         dc.w $124
swsprite1h dc.w $0
	dc.w $126
swsprite1l dc.w 0

         dc.w $128
swsprite2h dc.w $0
	dc.w $12a
swsprite2l dc.w 0 	

         dc.w $12c
swsprite3h dc.w $0
	dc.w $12e
swsprite3l dc.w 0	

         dc.w $130
swsprite4h dc.w $0
	dc.w $132
swsprite4l dc.w 0

         dc.w $134
swsprite5h dc.w $0
	dc.w $136
swsprite5l dc.w 0

         dc.w $138
swsprite6h dc.w $0
	dc.w $13a
swsprite6l dc.w 0

         dc.w $13c
swsprite7h dc.w $0
	dc.w $13e
swsprite7l dc.w 0

 
	DC.W	$00E0		
SHPlane1_Hi	DC.W	0
	DC.W	$00E2
SHPlane1_Lo	DC.W	0
	DC.W	$00E4	
SHPlane2_Hi	DC.W	0
	DC.W	$00E6
SHPlane2_Lo	DC.W	0
	DC.W	$00E8	
SHPlane3_Hi	DC.W	0
	DC.W	$00Ea
SHPlane3_Lo	DC.W	0
	DC.W	$00Ec	
SHPlane4_Hi	DC.W	0
	DC.W	$00Ee
SHPlane4_Lo	DC.W	0
	DC.W	$00f0	
SHPlane5_Hi	DC.W	0
	DC.W	$00f2
SHPlane5_Lo	DC.W	0


share_cols
	dc.w	$180,0
	dc.w	$182,0
	dc.w	$184,0
	dc.w	$186,0
	dc.w	$188,0
	dc.w	$18a,0
	dc.w	$18c,0
	dc.w	$18e,0
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0
	dc.w	$1a0,0
	dc.w	$1a2,0
	dc.w	$1a4,0
	dc.w	$1a6,0
	dc.w	$1a8,0
	dc.w	$1aa,0
	dc.w	$1ac,0
	dc.w	$1ae,0
	dc.w	$1b0,0
	dc.w	$1b2,0
	dc.w	$1b4,0
	dc.w	$1b6,0
	dc.w	$1b8,0
	dc.w	$1ba,0
	dc.w	$1bc,0
	dc.w	$1be,0
	
	dc.w	$ff01,$fffe
	dc.w	$ffdf,$fffe		
		
	dc.w	$1801,$fffe		
	dc.w	$182
show_fire
	dc.w	$0	
	

	dc.w	$2c01,$fffe	
	dc.w	intreq
	dc.w	$8010

	dc.w	$2cff,$fffe
		

**************************************************
***              GAME COPPER LIST              ***
**************************************************

COPPERL
	dc.w	bplcono 
plane_control	
	dc.w	$4200
	dc.w	BPLCON2
	dc.w	%100100
	dc.w	DDFSTRT
	dc.w	$0030
	dc.w	DDFSTOP
	dc.w	$00d0
	dc.w	DIWSTRT
	dc.w	$2C81  ;+15
	dc.w	DIWSTOP
	dc.b	$2c
	dc.b	$c1  ;-16
	dc.w	bpl1mod
	dc.w	(BPR-(40+2))
	dc.w	bpl2mod
	dc.w	(BPR-(40+2))
	dc.w	$1e4		;1200 stuff
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$0


copper_colours	
	dc.w	$180,0
	dc.w	$182,0
	dc.w	$184,0
	dc.w	$186,0
	dc.w	$188,0
	dc.w	$18a,0
	dc.w	$18c,0
	dc.w	$18e,0
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0


	
sprite_cols
	dc.w	$1a0,0
	dc.w	$1a2,0
	dc.w	$1a4,0
	dc.w	$1a6,0
	dc.w	$1a8,0
	dc.w	$1aa,0
	dc.w	$1ac,0
	dc.w	$1ae,0
	dc.w	$1b0,0
	dc.w	$1b2,0
	dc.w	$1b4,0
	dc.w	$1b6,0
	dc.w	$1b8,0
	dc.w	$1ba,0
	dc.w	$1bc,0
	dc.w	$1be,0
************sprites

         dc.w $120		;all sprite stuff
sprite0h dc.w $0
	dc.w $122
sprite0l dc.w 0

         dc.w $124
sprite1h dc.w $0
	dc.w $126
sprite1l dc.w 0

         dc.w $128
sprite2h dc.w $0
	dc.w $12a
sprite2l dc.w 0 	

         dc.w $12c
sprite3h dc.w $0
	dc.w $12e
sprite3l dc.w 0	

         dc.w $130
sprite4h dc.w $0
	dc.w $132
sprite4l dc.w 0

         dc.w $134
sprite5h dc.w $0
	dc.w $136
sprite5l dc.w 0

         dc.w $138
sprite6h dc.w $0
	dc.w $13a
sprite6l dc.w 0

         dc.w $13c
sprite7h dc.w $0
	dc.w $13e
sprite7l dc.w 0

	dc.w	$102
scroll_value
	dc.w	0

	DC.W	$00f0
Plane5_Hi	DC.W	0
	DC.W	$00f2
Plane5_Lo	DC.W	0

				

top_of_screen	
	DC.W	$00E0		;top bank of plane initialisers
Plane1_Hi	DC.W	0
	DC.W	$00E2
Plane1_Lo	DC.W	0
	DC.W	$00E4
Plane2_Hi	DC.W	0
	DC.W	$00E6
Plane2_Lo	DC.W	0
	DC.W	$00E8
Plane3_Hi	DC.W	0
	DC.W	$00Ea
Plane3_Lo	DC.W	0
	DC.W	$00Ec
Plane4_Hi	DC.W	0
	DC.W	$00Ee
Plane4_Lo	DC.W	0

scroll_bank_1
	dc.w	$2c01,$fffe
	DC.W	$00E0		
	DC.W	0
	DC.W	$00E2
	DC.W	0
	DC.W	$00E4
	DC.W	0
	DC.W	$00E6
	DC.W	0
	DC.W	$00E8
	DC.W	0
	DC.W	$00Ea
	DC.W	0
	DC.W	$00Ec
	DC.W	0
	DC.W	$00Ee
	DC.W	0

	dc.w	$ffdf,$fffe
	
	
scroll_bank_2
	dc.w	$2c01,$fffe
	DC.W	$00E0		
	DC.W	0
	DC.W	$00E2
	DC.W	0
	DC.W	$00E4
	DC.W	0
	DC.W	$00E6
	DC.W	0
	DC.W	$00E8
	DC.W	0
	DC.W	$00Ea
	DC.W	0
	DC.W	$00Ec
	DC.W	0
	DC.W	$00Ee
	DC.W	0

panel_split
	dc.b	$2c-16	
	dc.b	$01
	dc.w	$fffe

	dc.w	bplcono 
	dc.w	$0200



	dc.w	DIWSTRT
	dc.w	$2C81-$1400
	dc.w	DIWSTOP
	dc.b	$2c
	dc.b	$c1
			

	dc.w	DDFSTRT
	dc.w	$0038
	dc.w	DDFSTOP
	dc.w	$00d0

panel_colours
	dc.w	$180,0
	dc.w	$182,0
	dc.w	$184,0
	dc.w	$186,0
	dc.w	$188,0
	dc.w	$18a,0
	dc.w	$18c,0
	dc.w	$18e,0
	dc.w	$190,0
	dc.w	$192,0
	dc.w	$194,0
	dc.w	$196,0
	dc.w	$198,0
	dc.w	$19a,0
	dc.w	$19c,0
	dc.w	$19e,0

	dc.b	$2c-15	
	dc.b	$01
	dc.w	$fffe

	dc.w	bplcono 
	dc.w	$4200

	
	dc.w	bpl1mod
	dc.w	PANEL_MOD
	dc.w	bpl2mod
	dc.w	PANEL_MOD

	dc.w	$102
	dc.w	0



	DC.W	$00E0
panel_plane1h				
	DC.W	0
	DC.W	$00E2
panel_plane1l
	DC.W	0
	DC.W	$00E4
panel_plane2h	
	DC.W	0
	DC.W	$00E6
panel_plane2l
	DC.W	0
	DC.W	$00E8
panel_plane3h	
	DC.W	0
	DC.W	$00Ea
panel_plane3l	
	DC.W	0
	DC.W	$00Ec
panel_plane4h	
	DC.W	0
	DC.W	$00Ee
panel_plane4l		
	DC.W	0


		
	dc.w	$2c01,$fffe		
	dc.w	intreq
	dc.w	$8010

	DC.W	$2cff,$FFFE

	ds.w	10*2


**************************************************
***        TITLE SCREEN COPPER LIST            ***
**************************************************

title_screen_copper
	dc.w	bplcono 
	dc.w	$c204		;hi-res interlaced
	dc.w	BPLCON2
	dc.w	%000100
	dc.w	DDFSTRT
	dc.w	$003c
	dc.w	DDFSTOP
	dc.w	$00d4
	dc.w	DIWSTRT
	dc.w	$2C81  
	dc.w	DIWSTOP
	dc.w	$2cc1  
	dc.w	bpl1mod
	dc.w	80		;because interlaced
	dc.w	bpl2mod
	dc.w	80		;ditto
	dc.w	$1e4		;1200 stuff
	dc.w	$2100
	dc.w	$10c
	dc.w	$11
	dc.w	$1fc
	dc.w	$0

    dc.w $120		;all sprite stuff
hsprite0h dc.w $0
	dc.w $122
hsprite0l dc.w 0

         dc.w $124
hsprite1h dc.w $0
	dc.w $126
hsprite1l dc.w 0

         dc.w $128
hsprite2h dc.w $0
	dc.w $12a
hsprite2l dc.w 0 	

         dc.w $12c
hsprite3h dc.w $0
	dc.w $12e
hsprite3l dc.w 0	

         dc.w $130
hsprite4h dc.w $0
	dc.w $132
hsprite4l dc.w 0

         dc.w $134
hsprite5h dc.w $0
	dc.w $136
hsprite5l dc.w 0

        dc.w $138
hsprite6h dc.w $0
	dc.w $13a
hsprite6l dc.w 0

         dc.w $13c
hsprite7h dc.w $0
	dc.w $13e
hsprite7l dc.w 0


hires_copper_colours	
	dc.w	$180,0
	dc.w	$182,$fff
	dc.w	$184,$eee
	dc.w	$186,$ddd
	dc.w	$188,$ccc
	dc.w	$18a,$bbb
	dc.w	$18c,$aaa
	dc.w	$18e,$999
	dc.w	$190,$888
	dc.w	$192,$777
	dc.w	$194,$666
	dc.w	$196,$555
	dc.w	$198,$444
	dc.w	$19a,$333
	dc.w	$19c,$222
	dc.w	$19e,$111


	
hi_res_sprite_cols
	dc.w	$1a0,0
	dc.w	$1a2,0
	dc.w	$1a4,0
	dc.w	$1a6,0
	dc.w	$1a8,0
	dc.w	$1aa,0
	dc.w	$1ac,0
	dc.w	$1ae,0
	dc.w	$1b0,0
	dc.w	$1b2,0
	dc.w	$1b4,0
	dc.w	$1b6,0
	dc.w	$1b8,0
	dc.w	$1ba,0
	dc.w	$1bc,0
	dc.w	$1be,0
************sprites

     

	DC.W	$00E0		;top bank of plane initialisers
HPlane1_Hi	DC.W	0
	DC.W	$00E2
HPlane1_Lo	DC.W	0
	DC.W	$00E4
HPlane2_Hi	DC.W	0
	DC.W	$00E6
HPlane2_Lo	DC.W	0
	DC.W	$00E8
HPlane3_Hi	DC.W	0
	DC.W	$00Ea
HPlane3_Lo	DC.W	0
	DC.W	$00Ec
HPlane4_Hi	DC.W	0
	DC.W	$00Ee
HPlane4_Lo	DC.W	0

	dc.w	$e001,$fffe	;choice 1 wait
	dc.w	$182
choice_1_colour
	dc.w	SELECTED_COLOUR
	
	dc.w	$ec01,$fffe	;choice 2 wait
	dc.w	$182
choice_2_colour
	dc.w	NON_SELECTED_COLOUR

	dc.w	$FC01,$fffe	;choice 3 wait	
	dc.w	$182
choice_3_colour
	dc.w	NON_SELECTED_COLOUR

	dc.w	$ffdf,$fffe
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	
	dc.w	$1901,$fffe
	dc.w	$182,$556
	dc.w	$184,$000
	dc.w	$186,$445
	dc.w	$188,$000
	dc.w	$18a,$445
	dc.w	$18c,$000
	dc.w	$18e,$334
	dc.w	$190,$000
	dc.w	$192,$223
	dc.w	$194,$000
	dc.w	$196,$112
	dc.w	$198,$000
	dc.w	$19a,$001
	dc.w	$19c,$000
	dc.w	$19e,$000

	dc.w	$1b01,$fffe
	dc.w	$182,$666
	dc.w	$184,$000
	dc.w	$186,$555
	dc.w	$188,$000
	dc.w	$18a,$555
	dc.w	$18c,$000
	dc.w	$18e,$444
	dc.w	$190,$000
	dc.w	$192,$333
	dc.w	$194,$000
	dc.w	$196,$222
	dc.w	$198,$000
	dc.w	$19a,$111
	dc.w	$19c,$000
	dc.w	$19e,$000
	
	dc.w	$1c01,$fffe
	dc.w	$182,$777
	dc.w	$184,$000
	dc.w	$186,$666
	dc.w	$188,$000
	dc.w	$18a,$555
	dc.w	$18c,$000
	dc.w	$18e,$444
	dc.w	$190,$000
	dc.w	$192,$333
	dc.w	$194,$000
	dc.w	$196,$222
	dc.w	$198,$000
	dc.w	$19a,$111
	dc.w	$19c,$000
	dc.w	$19e,$000
	
	dc.w	$2001,$fffe
	dc.w	$182,$666
	dc.w	$184,$000
	dc.w	$186,$555
	dc.w	$188,$000
	dc.w	$18a,$555
	dc.w	$18c,$000
	dc.w	$18e,$444
	dc.w	$190,$000
	dc.w	$192,$333
	dc.w	$194,$000
	dc.w	$196,$222
	dc.w	$198,$000
	dc.w	$19a,$111
	dc.w	$19c,$000
	dc.w	$19e,$000

	
	dc.w	$2201,$fffe
	dc.w	$182,$556
	dc.w	$184,$000
	dc.w	$186,$445
	dc.w	$188,$000
	dc.w	$18a,$445
	dc.w	$18c,$000
	dc.w	$18e,$334
	dc.w	$190,$000
	dc.w	$192,$223
	dc.w	$194,$000
	dc.w	$196,$112
	dc.w	$198,$000
	dc.w	$19a,$001
	dc.w	$19c,$000
	dc.w	$19e,$000


	dc.w	$2301,$fffe
	dc.w	$182,$344
	dc.w	$184,$000
	dc.w	$186,$233
	dc.w	$188,$000
	dc.w	$18a,$233
	dc.w	$18c,$000
	dc.w	$18e,$122
	dc.w	$190,$000
	dc.w	$192,$122
	dc.w	$194,$000
	dc.w	$196,$011
	dc.w	$198,$000
	dc.w	$19a,$011
	dc.w	$19c,$000
	dc.w	$19e,$000
	
	dc.w	$2401,$fffe
	dc.w	$182,$133
	dc.w	$184,$000
	dc.w	$186,$133
	dc.w	$188,$000
	dc.w	$18a,$122
	dc.w	$18c,$000
	dc.w	$18e,$022
	dc.w	$190,$000
	dc.w	$192,$022
	dc.w	$194,$000
	dc.w	$196,$011
	dc.w	$198,$000
	dc.w	$19a,$011
	dc.w	$19c,$000
	dc.w	$19e,$000

		
	dc.w	$2c01,$fffe		
	dc.w	intreq
	dc.w	$8010

	DC.W	$2cff,$FFFE

	dc.w	0,0,0,0