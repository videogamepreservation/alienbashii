


show_routine

	move.l	#blank_sprite,d0
	
	swap	d0
	
	move.w	d0,blkspr+2
	move.w	d0,blkspr+10
	move.w	d0,blkspr+18
	move.w	d0,blkspr+26
	move.w	d0,blkspr+34
	move.w	d0,blkspr+42
	move.w	d0,blkspr+50

	swap	d0
	
	move.w	d0,blkspr+6
	move.w	d0,blkspr+14
	move.w	d0,blkspr+22
	move.w	d0,blkspr+30
	move.w	d0,blkspr+38
	move.w	d0,blkspr+46
	move.w	d0,blkspr+54



	bsr	setup_memory

	move.l	#(((BACKGROUND*BACKPLANES*2)+SCENARY)/4)-1,d0
	move.l	memory_base,a0
clear_all_mem_fast
	clr.l	(a0)+
	subq.l	#1,d0
	bne.s	clear_all_mem_fast


	moveq	#0,d2
	move.l	#title_screen,a0
	move.l	plane5,a1
	add.l	#8,a1
	move.w	#((256*40)/4)-1,d0
copy_graphics_in
	move.l	a1,a2
	move.l	a0,a3
	
	move.l	(a3),(a2)
	
	add.l	#256*40,a3
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,a2
	
	move.l	(a3),(a2)

	add.l	#256*40,a3
	add.l	#BYTES_PER_ROW*BACKGROUND_SCROLL_HEIGHT,a2

	move.l	(a3),(a2)

	add.l	#4,a0
	add.l	#4,a1

	addq.w	#1,d2
	cmp.w	#10,d2
	bne.s	not_lined
	moveq	#0,d2
	add.l	#(BYTES_PER_ROW-40),a1
not_lined		
	dbra	d0,copy_graphics_in
			

	move.l	PLANE5,d0
	move.w	d0,SHOWPLANE5LOW
	swap	d0
	move.w	d0,SHOWPLANE5HIGH

	move.l	PLANE6,d0
	move.w	d0,SHOWPLANE6LOW
	swap	d0
	move.w	d0,SHOWPLANE6HIGH

	move.l	PLANE7,d0
	move.w	d0,SHOWPLANE7LOW
	swap	d0
	move.w	d0,SHOWPLANE7HIGH

	move.l	PLANE8,d0
	move.w	d0,SHOWPLANE8LOW
	swap	d0
	move.w	d0,SHOWPLANE8HIGH
	move.l	#$dff000,a6
	move.l	#show_copper_list,cop1lc(a6)
	clr.w	copjmp1(a6)


	move.w	#FALSE,update_player_status
	jsr	setup_firework_data
	bsr	setup_show_screen_colours
keep_going_show
	jsr	sync	
	bsr	show_routine_main
	btst	#7,$bfe001
	bne.s	keep_going_show	
	
	bsr	flush_colours	
	move.w	#TRUE,update_player_status	
	move.w	#Level_selection,game_flags	

	rts
	
**********************************
*** SETUP_SHOW_SCREEN_COLOURS      ****
**********************************
	
setup_SHOW_screen_colours

	move.l	#show_main_screen_colours_high,a0
	move.l	#show_main_screen_colours_low,a1
	move.w	#NUMBER_OF_COLOURS,d0
	move.l	#firecols,a2
	bsr	set_colour_list
	
	move.l	#show_test_scroll_colours_high,a0
	move.l	#show_test_scroll_colours_low,a1
	move.l	#firecols,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	
	move.l	#show_front_scroll_colours_high,a0
	move.l	#show_front_scroll_colours_low,a1
	move.l	#title_colours,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	

	rts   

flush_colours
	move.l	#show_main_screen_colours_high,a0
	move.l	#show_main_screen_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list
	
	move.l	#show_test_scroll_colours_high,a0
	move.l	#show_test_scroll_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	
	move.l	#show_front_scroll_colours_high,a0
	move.l	#show_front_scroll_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	rts	
	
flush_game_colours
	move.l	#main_screen_colours_high,a0
	move.l	#main_screen_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list
	
	move.l	#test_scroll_colours_high,a0
	move.l	#test_scroll_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	
	move.l	#front_scroll_colours_high,a0
	move.l	#front_scroll_colours_low,a1
	move.l	#flush,a2
	move.w	#NUMBER_OF_COLOURS,d0
	bsr	set_colour_list

	rts	

	
show_routine_main

	jsr	add_rockets
	jsr	fire_swap_buffers
	jsr	do_fireworks
	rts
	
		
************************************************************
****       S H O W  C O P P E R    L I S T              ****
************************************************************

Show_Copper_List	
	

	dc.w	$1fc
	dc.w	$3
	dc.w	$10c
	dc.w	$1014

	dc.w	BPLCON0,EIGHT_PLANES+DUAL_PLAYFIELD
	dc.w	BPL2MOD,8
	dc.w	BPL1MOD,8
	dc.w	BPLCON1
	dc.w	0	
	dc.w	DMACON,$8000+BLITTER_PRI	;dma on
	dc.w	DMACON,SPRITE_DMA		;dma off

blkspr
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




	dc.w	BPLCON2
	dc.w	%1100100
	dc.w	DIWSTRT
	dc.w	$2c81
	
	dc.w    DDFSTRT,$0018
	dc.w	DDFSTOP,$00d8

	dc.w	DIWSTOP
	dc.w	$2cc1
	
	dc.w	intreq,$8010
		
	dc.w	$E0
SHOWPLANE1HIGH
	dc.w	0
	dc.w	$E2
SHOWPLANE1LOW
	dc.w	0
	dc.w	$E8
SHOWPLANE2HIGH
	dc.w	0
	dc.w	$Ea
SHOWPLANE2LOW
	dc.w	0
	dc.w	$f0
SHOWPLANE3HIGH
	dc.w	0
	dc.w	$f2
SHOWPLANE3LOW
	dc.w	0

	DC.W	$f8
SHOWPLANE4HIGH	DC.W	0
	DC.W	$fa
SHOWPLANE4LOW	DC.W	0


		
	dc.w	$E4
SHOWPLANE5HIGH
	dc.w	0
	dc.w	$E6
SHOWPLANE5LOW
	dc.w	0
	dc.w	$Ec
SHOWPLANE6HIGH
	dc.w	0
	dc.w	$Ee
SHOWPLANE6LOW
	dc.w	0
	dc.w	$f4
SHOWPLANE7HIGH
	dc.w	0
	dc.w	$f6
SHOWPLANE7LOW
	dc.w	0

	DC.W	$fc
SHOWPLANE8HIGH	DC.W	0
	DC.W	$fe
SHOWPLANE8LOW	DC.W	0

	dc.w	BPLCON1
	dc.w	0	

	dc.w	$106
	dc.w	$040
show_main_screen_colours_high
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
show_main_screen_colours_low
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
show_front_scroll_colours_high	
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
show_front_scroll_colours_low
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
show_test_scroll_colours_high	
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
show_test_scroll_colours_low
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
	
	dc.w	$2cff,$fffe
	
title_colours
	dc.l $000000,$F0F0F0,$B0D0F0,$70C0E0
	dc.l $40A0D0,$2080B0,$006090,$004060
	dc.l $0,$0,$0,$0,$0,$0,$0,$0
	
	
flush
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	