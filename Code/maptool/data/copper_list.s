***************************************************************
*			S Y S T E M                           *
*                                                             *
*			C O P P E R                           *
*                                                             *
*			  L I S T                             *
***************************************************************

COPPERL
	dc.w	DDFSTRT,$38
	dc.w	DDFSTOP,$d0
	
	dc.w	BPLCON2
sprite_priority
	dc.w	%100100
	dc.w	$1fc
	dc.w	0
*	dc.w	$96
*	dc.w	$81f0	;turn sprites on

	dc.w	BPLCONO
Screen_Mode	dc.w	$0210	;8 planes lo-res

	dc.w	BPLCON1
scroll_value
	dc.w	0	

	dc.w	BPL1MOD
Screen_Mode_Mod1
	dc.w	BYTES_PER_ROW-RES_BYTES

	dc.w	BPL2MOD
Screen_Mode_Mod2
	dc.w	BYTES_PER_ROW-RES_BYTES

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
	


	DC.W	$00E0
PLANEHIGH	DC.W	0
	DC.W	$00E2
PLANELOW	DC.W	0

	DC.W	$00E4
PLANE2HIGH	DC.W	0
	DC.W	$00E6
PLANE2LOW	DC.W	0

	DC.W	$00E8
PLANE3HIGH	DC.W	0
	DC.W	$00Ea
PLANE3LOW	DC.W	0

	DC.W	$00Ec
PLANE4HIGH	DC.W	0
	DC.W	$00Ee
PLANE4LOW	DC.W	0

	DC.W	$00f0
PLANE5HIGH	DC.W	0
	DC.W	$00f2	
PLANE5LOW	DC.W	0

	DC.W	$00f4
PLANE6HIGH	DC.W	0
	DC.W	$00f6
PLANE6LOW	DC.W	0

	DC.W	$00f8
PLANE7HIGH	DC.W	0
	DC.W	$00fa	
PLANE7LOW	DC.W	0

	DC.W	$00fc
PLANE8HIGH	DC.W	0
	DC.W	$00fe
PLANE8LOW	DC.W	0

	dc.w	$106
	dc.w	0		;Select First bank
main_screen_colours
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
	dc.w	$2000		;Select second bank
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
	dc.w	$4000		;Select third bank
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
	dc.w	$6000		;Select fourth bank
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
	dc.w	$8000		;Select fifth bank
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
	dc.w	$a000		;Select sixth bank
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
	dc.w	$c000		;Select seventh bank
	dc.w	$180
	dc.w	$fff
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
	dc.w	$f000		;Select eighth bank
	dc.w	$180
	dc.w	$fff
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
	dc.w	$0200		;Select First bank - lo
main_screen_colours_lo
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
	dc.w	$2200		;Select second bank
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
	dc.w	$4200		;Select third bank
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
	dc.w	$6200		;Select fourth bank
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
	dc.w	$8200		;Select fifth bank
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
	dc.w	$a200		;Select sixth bank
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
	dc.w	$c200		;Select seventh bank
	dc.w	$180
	dc.w	$fff
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
	dc.w	$f200		;Select eighth bank
	dc.w	$180
	dc.w	$fff
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
	dc.w	$0000		;Restore



full_screen
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



button_screen_wait
	dc.b	BUTTON_SCREEN_POSITION
	dc.b	$01
	dc.w	$fffe	

	dc.w	BPLCONO
Button_Screen_Mode	dc.w	$4200+$8000   ;planes med-res


	dc.w	DDFSTRT,$3c
	dc.w	DDFSTOP,$d4
	
	dc.w	BPLCON1
	dc.w	0	
	
	dc.w	BPL1MOD
	dc.w	SECBYTES_PER_ROW-SECRES_BYTES

	dc.w	BPL2MOD
	dc.w	SECBYTES_PER_ROW-SECRES_BYTES


	DC.W	$00E0
BUTTONPLANEHIGH	DC.W	0
	DC.W	$00E2
BUTTONPLANELOW	DC.W	0

	DC.W	$00E4
BUTTONPLANE2HIGH	DC.W	0
	DC.W	$00E6
BUTTONPLANE2LOW	DC.W	0

	DC.W	$00E8
BUTTONPLANE3HIGH	DC.W	0
	DC.W	$00Ea
BUTTONPLANE3LOW	DC.W	0

	DC.W	$00Ec
BUTTONPLANE4HIGH	DC.W	0
	DC.W	$00Ee
BUTTONPLANE4LOW	DC.W	0

button_colours
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




end_copper	
	dc.w	$ff01,$fffe
	dc.w	$ffdd,$ffee
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$1fe,0
	dc.w	$2c01,$fffe
	dc.w	intreq,$8010	
	dc.w	COP1LCH
cophi
	dc.w	0
	dc.w	COP1LCH+2
coplo	
	dc.w	0
	dc.w	COPJMP1	
	dc.w	0
	DC.W	$2CFF,$FFFe

