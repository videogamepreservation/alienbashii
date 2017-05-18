



SOUND_DMA	EQU	$f
SPRITE_DMA	EQU	$20
DISK_DMA	EQU	$10
BLITTER_PRI	EQU	$400


EIGHT_PLANES	EQU	$0010
TWO_PLANES	EQU	$2000
FOUR_PLANES	EQU	$4000
DUAL_PLAYFIELD	EQU	$0400

amiga1200	equ	1



WAIT_POS	EQU	0
SPRITE1B	EQU	4
SPRITE1A	EQU	8
SPRITE2B	EQU	12
SPRITE2A	EQU	16
SPRITE3B	EQU	20
SPRITE3A	EQU	24
SPRITE4B	EQU	28
SPRITE4A	EQU	32
CONTROL_HIGH	EQU	36
HIGHCOL		EQU	40
CONTROL_LOW	EQU	44
LOWCOL		EQU	48


SIZE_COP	EQU	LOWCOL+4



	
Level_Select_Copper_List	

	dc.w	$120
select_sprite0h
	dc.w	0
	dc.w	$122
select_sprite0l
	dc.w	0

blank_sprites
	dc.w	$124,0
	dc.w	$126,0
	dc.w	$128,0
	dc.w	$12a,0
	dc.w	$12c,0
	dc.w	$12e,0
	dc.w	$130,0
	dc.w	$132,0
	dc.w	$134,0
	dc.w	$136,0
	dc.w	$138,0
	dc.w	$13A,0
	dc.w	$13C,0
	dc.w	$13E,0

	dc.w	$106,$000
level_select_colours_high		
	dc.w	$180,$fff
	dc.w	$182,$f0f
	dc.w	$184,$ff0
	dc.w	$186,$0ff
	dc.w	$188,$0
	dc.w	$18a,$0
	dc.w	$18c,$0
	dc.w	$18e,$0
	dc.w	$190,$0
	dc.w	$192,$0
	dc.w	$194,$0
	dc.w	$196,$0
	dc.w	$198,$0
	dc.w	$19a,$0
	dc.w	$19c,$0
	dc.w	$19e,$0

	dc.w	$106,$0200
level_select_colours_low		
	dc.w	$180,$0
	dc.w	$182,$0
	dc.w	$184,$0
	dc.w	$186,$0
	dc.w	$188,$0
	dc.w	$18a,$0
	dc.w	$18c,$0
	dc.w	$18e,$0
	dc.w	$190,$0
	dc.w	$192,$0
	dc.w	$194,$0
	dc.w	$196,$0
	dc.w	$198,$0
	dc.w	$19a,$0
	dc.w	$19c,$0
	dc.w	$19e,$0
	dc.w	$106,0


		
	dc.w	$1fc
	dc.w	$0
	dc.w	$10c
	dc.w	$11

	dc.w	BPLCON2
	dc.w	%100100
	dc.w	DIWSTRT
	dc.w	$2c81
	dc.w	DIWSTOP
	dc.w	$2cc1
	
	dc.w    DDFSTRT,$0038
	dc.w	DDFSTOP,$00d0

; main_planes
	dc.w	BPLCON0,FOUR_PLANES
	dc.w	BPL2MOD,-0
	dc.w	BPL1MOD,-0
	dc.w	BPLCON1
	dc.w	0	
	dc.w	DMACON,$8000+BLITTER_PRI+SPRITE_DMA	;dma on

	
	dc.w	$E0
SELECTPLANE1HIGH
	dc.w	0
	dc.w	$E2
SELECTPLANE1LOW
	dc.w	0
	dc.w	$E4
SELECTPLANE2HIGH
	dc.w	0
	dc.w	$E6
SELECTPLANE2LOW
	dc.w	0
	dc.w	$e8
SELECTPLANE3HIGH
	dc.w	0
	dc.w	$Ea
SELECTPLANE3LOW
	dc.w	0
	dc.w	$ec
SELECTPLANE4HIGH
	dc.w	0
	dc.w	$ee
SELECTPLANE4LOW
	dc.w	0

	dc.w	$1e4
	dc.w	$2100
	
	dc.w	intreq,$8010
			
	dc.w	$106,$1000

	dc.w	$fffd,$fffe
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$ff01,$fffe
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$2c01,$fffe
	
	

************************************************************
****            C O P P E R    L I S T                  ****
************************************************************

Copper_List	
	

	
	dc.w	$140
SPR0POS	dc.w	0	
	dc.w	$148
SPR1POS	dc.w	0	
	dc.w	$150
SPR2POS	dc.w	0	
	dc.w	$158
SPR3POS	dc.w	0	

	dc.w	$142
SPR0CTL
	dc.w	1<<ATTACH
	dc.w	$14a
SPR1CTL
	dc.w	1<<ATTACH
	dc.w	$152
SPR2CTL
	dc.w	1<ATTACH
	dc.w	$15a
SPR3CTL
	dc.w	1<<ATTACH



	
	dc.w	$1fc
	dc.w	$3
	dc.w	$10c
	dc.w	$1014




	dc.w	BPLCON2
	dc.w	%100100
	dc.w	DIWSTRT
	dc.w	$2c81
	dc.w	DIWSTOP
	dc.w	$3ac1
	
	dc.w    DDFSTRT,$0018
	dc.w	DDFSTOP,$00d8

main_planes
	dc.w	BPLCON0,EIGHT_PLANES+DUAL_PLAYFIELD
	dc.w	BPL2MOD,8
	dc.w	BPL1MOD,8
	dc.w	BPLCON1
	dc.w	0	
	dc.w	DMACON,$8000+BLITTER_PRI	;dma on
	dc.w	DMACON,SPRITE_DMA		;dma off

	
	dc.w	$E0
PANELPLANE1HIGH
	dc.w	0
	dc.w	$E2
PANELPLANE1LOW
	dc.w	0
	dc.w	$E8
PANELPLANE2HIGH
	dc.w	0
	dc.w	$Ea
PANELPLANE2LOW
	dc.w	0
	dc.w	$f0
PANELPLANE3HIGH
	dc.w	0
	dc.w	$f2
PANELPLANE3LOW
	dc.w	0

	DC.W	$f8
PANELPLANE4HIGH	DC.W	0
	DC.W	$fa
PANELPLANE4LOW	DC.W	0


		
	dc.w	$E4
PANELPLANE5HIGH
	dc.w	0
	dc.w	$E6
PANELPLANE5LOW
	dc.w	0
	dc.w	$Ec
PANELPLANE6HIGH
	dc.w	0
	dc.w	$Ee
PANELPLANE6LOW
	dc.w	0
	dc.w	$f4
PANELPLANE7HIGH
	dc.w	0
	dc.w	$f6
PANELPLANE7LOW
	dc.w	0
	DC.W	$fc
PANELPLANE8HIGH	DC.W	0
	DC.W	$fe
PANELPLANE8LOW	DC.W	0


	dc.w	$106,$0
panel_backcol
	dc.w	$1a0,$08f	

panel_copper_cols 
	ds.w	14*4

	dc.w	$1e4
	dc.w	$2000
	dc.w	$3a01,$fffe

	dc.w	DIWSTRT
	dc.w	$3c81
	dc.w	DIWSTOP
	dc.w	$2cc1
	
	dc.w	intreq,$8010
		
	dc.w	$E0
PLANE1HIGH
	dc.w	0
	dc.w	$E2
PLANE1LOW
	dc.w	0
	dc.w	$E8
PLANE2HIGH
	dc.w	0
	dc.w	$Ea
PLANE2LOW
	dc.w	0
	dc.w	$f0
PLANE3HIGH
	dc.w	0
	dc.w	$f2
PLANE3LOW
	dc.w	0

	DC.W	$f8
PLANE4HIGH	DC.W	0
	DC.W	$fa
PLANE4LOW	DC.W	0


		
	dc.w	$E4
PLANE5HIGH
	dc.w	0
	dc.w	$E6
PLANE5LOW
	dc.w	0
	dc.w	$Ec
PLANE6HIGH
	dc.w	0
	dc.w	$Ee
PLANE6LOW
	dc.w	0
	dc.w	$f4
PLANE7HIGH
	dc.w	0
	dc.w	$f6
PLANE7LOW
	dc.w	0

	DC.W	$fc
PLANE8HIGH	DC.W	0
	DC.W	$fe
PLANE8LOW	DC.W	0

	dc.w	BPLCON1
scroll_value
	dc.w	0	

	dc.w	$106
	dc.w	$040
main_screen_colours_high
	dc.w	$1a0
	dc.w	0
	dc.w	$1a2
	dc.w	0
	dc.w	$1a4
	dc.w	0
	dc.w	$1a6
	dc.w	0
	dc.w	$1a8
	dc.w	0
	dc.w	$1aa
	dc.w	0
	dc.w	$1ac
	dc.w	0
	dc.w	$1ae
	dc.w	0
	dc.w	$1b0
	dc.w	0
	dc.w	$1b2
	dc.w	0
	dc.w	$1b4
	dc.w	0
	dc.w	$1b6
	dc.w	0
	dc.w	$1b8
	dc.w	0
	dc.w	$1ba
	dc.w	0
	dc.w	$1bc
	dc.w	0
	dc.w	$1be
	dc.w	0
	
	dc.w	$106
	dc.w	$240
main_screen_colours_low
	dc.w	$1a0
	dc.w	0
	dc.w	$1a2
	dc.w	0
	dc.w	$1a4
	dc.w	0
	dc.w	$1a6
	dc.w	0
	dc.w	$1a8
	dc.w	0
	dc.w	$1aa
	dc.w	0
	dc.w	$1ac
	dc.w	0
	dc.w	$1ae
	dc.w	0
	dc.w	$1b0
	dc.w	0
	dc.w	$1b2
	dc.w	0
	dc.w	$1b4
	dc.w	0
	dc.w	$1b6
	dc.w	0
	dc.w	$1b8
	dc.w	0
	dc.w	$1ba
	dc.w	0
	dc.w	$1bc
	dc.w	0
	dc.w	$1be
	dc.w	0


	dc.w	$106
	dc.w	$000
front_scroll_colours_high	
	dc.w	$180
	dc.w	0
	dc.w	$182
	dc.w	0
	dc.w	$184
	dc.w	0
	dc.w	$186
	dc.w	0
	dc.w	$188
	dc.w	0
	dc.w	$18a
	dc.w	0
	dc.w	$18c
	dc.w	0
	dc.w	$18e
	dc.w	0
	dc.w	$190
	dc.w	0
	dc.w	$192
	dc.w	0
	dc.w	$194
	dc.w	0
	dc.w	$196
	dc.w	0
	dc.w	$198
	dc.w	0
	dc.w	$19a
	dc.w	0
	dc.w	$19c
	dc.w	0
	dc.w	$19e
	dc.w	0

	dc.w	$106
	dc.w	$0200
front_scroll_colours_low
	dc.w	$180
	dc.w	0
	dc.w	$182
	dc.w	0
	dc.w	$184
	dc.w	0
	dc.w	$186
	dc.w	0
	dc.w	$188
	dc.w	0
	dc.w	$18a
	dc.w	0
	dc.w	$18c
	dc.w	0
	dc.w	$18e
	dc.w	0
	dc.w	$190
	dc.w	0
	dc.w	$192
	dc.w	0
	dc.w	$194
	dc.w	0
	dc.w	$196
	dc.w	0
	dc.w	$198
	dc.w	0
	dc.w	$19a
	dc.w	0
	dc.w	$19c
	dc.w	0
	dc.w	$19e
	dc.w	0


	dc.w	$106
	dc.w	$4000
test_scroll_colours_high	
	dc.w	$180
	dc.w	0
	dc.w	$182
	dc.w	0
	dc.w	$184
	dc.w	0
	dc.w	$186
	dc.w	0
	dc.w	$188
	dc.w	0
	dc.w	$18a
	dc.w	0
	dc.w	$18c
	dc.w	0
	dc.w	$18e
	dc.w	0
	dc.w	$190
	dc.w	0
	dc.w	$192
	dc.w	0
	dc.w	$194
	dc.w	0
	dc.w	$196
	dc.w	0
	dc.w	$198
	dc.w	0
	dc.w	$19a
	dc.w	0
	dc.w	$19c
	dc.w	0
	dc.w	$19e
	dc.w	0

	dc.w	$106
	dc.w	$4200
test_scroll_colours_low
	dc.w	$180
	dc.w	0
	dc.w	$182
	dc.w	0
	dc.w	$184
	dc.w	0
	dc.w	$186
	dc.w	0
	dc.w	$188
	dc.w	0
	dc.w	$18a
	dc.w	0
	dc.w	$18c
	dc.w	0
	dc.w	$18e
	dc.w	0
	dc.w	$190
	dc.w	0
	dc.w	$192
	dc.w	0
	dc.w	$194
	dc.w	0
	dc.w	$196
	dc.w	0
	dc.w	$198
	dc.w	0
	dc.w	$19a
	dc.w	0
	dc.w	$19c
	dc.w	0
	dc.w	$19e
	dc.w	0


	dc.w	$106,$1000
	
copper_sprite_mem
	ds.w	(255-16)*SIZE_COP/2
copper_sprite_mem_end
	dc.w	$2cff,$fffe
	

