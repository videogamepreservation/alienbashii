

*--------------------MAN ALIEN COLLISION ROUTINES--------------


*I.e Routines for when an alien hits players

*These routines will need to know that the alien structures are
*contained in a1 and the type pointer in a2



*address regs a0-a3 are used
*data regs d5-d6 are used  (rest can be trashed)


*******************************************
****       PICK UP KEY                *****
*******************************************
Pick_Up_Key

	movem.l	a0-a2/d5-d6,-(sp)

	move.w	Number_of_Keys,d7
	bsr	Display_Key_Char
	 
	addq.w	#1,Number_Of_Keys
	move.w	#Sound_Collect,sound_chan4
	bset.b	#ALIEN_DEAD,alien_flags(a1)

	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	move.l	#CoinDiss_Alien,d2
	addq.w	#2,d1
	bsr	Simple_Add_Alien_To_List
	
	movem.l	(sp)+,a0-a2/d5-d6	
	rts
	
***********************************************
*********   PICK UP EOL KEY           *********
***********************************************
Pick_Up_EOL_Key

	move.w	#1,end_of_level_key
	move.w	#Sound_Collect,sound_chan4
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	
	movem.l	a0-a2/d5-d6,-(sp)
	
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	move.l	#CoinDiss_Alien,d2
	addq.w	#8,d1
	bsr	Simple_Add_Alien_To_List
	bsr	Set_End_Key_On_Scanner
	
	movem.l	(sp)+,a0-a2/d5-d6


	rts

***********************************************
*********   PICK UP GOLD MONEY        *********
***********************************************
Pick_Up_Gold_Money

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	add.w	#10,Cash
	clr.w	Cash_Request
	rts

***********************************************
*********   PICK UP SILVER MONEY      *********
***********************************************
Pick_Up_Silver_Money

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	addq.w	#5,Cash
	clr.w	Cash_Request
	rts
	
***********************************************
*********   PICK UP GOLD MONEYS       *********
***********************************************
Pick_Up_Gold_Moneys

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	add.w	#20,Cash
	clr.w	Cash_Request
	rts

***********************************************
*********   PICK UP SILVER MONEYS     *********
***********************************************
Pick_Up_Silver_Moneys

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	add.w	#10,Cash
	clr.w	Cash_Request
	rts

*******************************************
****       SAP PLAYER ENERGY          *****
*******************************************
Sap_Player_Energy

	tst	Player_Invincible_Timer
	bne.s	cant_hurt_player
	move.w	#Sound_Drain,sound_chan3	
	move.w	#1,Flash_Request
	cmp.w	#4,hit_count
	bge.s	cant_hurt_player
	add.w	#1,hit_count
cant_hurt_player	
	bset.b	#ALIEN_HIT,alien_flags(a1)	;gradually kill alien
	subq.w	#1,alien_hits(a1)
	bge.s	not_killed_by_mans_suit
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	move.l	alien_dead_pattern(a2),alien_pat_ptr(a1)
not_killed_by_mans_suit	
	rts

*******************************************
****       BULLET_HIT_PLAYER          *****
*******************************************
Bullet_Hit_Player

	tst	Player_Invincible_Timer
	bne.s	cant_shoot_player
	move.w	#Sound_Drain,sound_chan3	
	move.w	#1,Flash_Request
	add.w	#4,hit_count
	cmp.w	#4,hit_count
	ble.s	cant_shoot_player
	move.w	#4,hit_count
cant_shoot_player	
	rts

	
*******************************************
****       KILL ALIEN BULLET          *****
*******************************************
Kill_Alien_Bullet
	move.l	alien_dead_pattern(a2),alien_pat_ptr(a1)
	bsr	Bullet_Hit_Player
	rts

*******************************************
****       KILL FISH BULLET           *****
*******************************************
Kill_Fish_Bullet
	move.l	alien_dead_pattern(a2),alien_pat_ptr(a1)
	tst	Player_Invincible_Timer
	bne.s	cant_fish_player
	move.w	#Sound_Drain,sound_chan3	
	move.w	#1,Flash_Request
	add.w	#2,hit_count
	cmp.w	#2,hit_count
	ble.s	cant_fish_player
	move.w	#4,hit_count
cant_fish_player	
	rts

		
	
*******************************************
****       PICKUP EXTRA ENERGY        *****
*******************************************
Pickup_Extra_Energy
	movem.l	a0-a3/d5-d6,-(sp)

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	move.w	#Sound_ExtraEnergy,sound_chan3
	
	move.w	Player_Current_Energy,d7
	add.w	#(4*2)*NUMBER_HITS_PER_UNIT,d7
	cmp.w	Player_Energy_Limit,d7
	ble.s	energy_in_bounds
	move.w	Player_Energy_Limit,d7
energy_in_bounds
	move.w	d7,Player_Current_Energy
	
	bsr	Display_Total_Energy
	movem.l	(sp)+,a0-a3/d5-d6			
	rts						

*******************************************
****       PICKUP SMALL ENERGY        *****
*******************************************
Pickup_Small_Energy
	movem.l	a0-a3/d5-d6,-(sp)

	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	move.w	#Sound_ExtraEnergy,sound_chan3

	
	move.w	Player_Current_Energy,d7
	add.w	#2*NUMBER_HITS_PER_UNIT,d7
	cmp.w	Player_Energy_Limit,d7
	ble.s	small_energy_in_bounds
	move.w	Player_Energy_Limit,d7
small_energy_in_bounds
	move.w	d7,Player_Current_Energy
	
	bsr	Display_Total_Energy
	movem.l	(sp)+,a0-a3/d5-d6			
	rts			

*******************************************
****       PICKUP MISSILE PACK        *****
*******************************************
Pickup_Missile_Pack
	movem.l	a0-a3/d5-d6,-(sp)
	cmp.w	#4,rocket_packs
	beq.s	rocket_pack_at_max
	addq.w	#1,rocket_packs
	tst	rockets_in_pack
	bne.s	dont_up_rocs
	move.w	#5,rockets_in_pack
dont_up_rocs	
	move.w	#Sound_Rockets,sound_chan4
	bset.b	#ALIEN_DEAD,alien_flags(a1)

	bsr	Display_Grenade_Packs
rocket_pack_at_max	
	movem.l	(sp)+,a0-a3/d5-d6	
	rts	

*******************************************
****       PICKUP GRENADE PACK        *****
*******************************************
Pickup_Grenade_Pack
	movem.l	a0-a3/d5-d6,-(sp)
	cmp.w	#4,grenade_packs
	beq.s	grenade_pack_at_max
	addq.w	#1,Grenade_packs
	tst	grenades_in_pack
	bne.s	dont_up_grens
	move.w	#5,grenades_in_pack
dont_up_grens
	move.w	#Sound_Grenades,sound_chan4
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	bsr	Display_Grenade_Packs
Grenade_pack_at_max	
	movem.l	(sp)+,a0-a3/d5-d6	
	rts	
	

*******************************************
****       PICKUP EXTRA LIFE          *****
*******************************************
Pickup_Extra_Life
	movem.l	a0-a3,-(sp)

	cmp.w	#5,player_lives
	beq.s	cant_pickup

	move.w	#Sound_Collect,sound_chan4
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	
	addq.w	#1,Player_Lives
	bsr	Display_Player_Lives
cant_pickup	
	movem.l	(sp)+,a0-a3			
	rts					
	
*******************************************
****       COLLECT HOSTAGE            *****
*******************************************
Collect_Hostage

	move.l	a1,d7
	movem.l	a0/a2/a3/d6,-(sp)
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	move.l	#Thanks_Object,d2
	addq.w	#2,d0
	bsr	Simple_Add_Alien_To_list
	addq.w	#4,d0	;already added 2
	addq.w	#6,d1
	move.l	#CoinDiss_Alien,d2
	bsr	Simple_Add_Alien_To_List
	add.w	#9,d0
	bsr	Simple_Add_Alien_To_List
	add.w	#9,d1
	bsr	Simple_Add_Alien_To_List
	sub.w	#9,d0
	bsr	Simple_Add_Alien_To_List

	move.w	#Sound_Collect,sound_chan3
	move.l	d7,a1			;restore alien
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	bsr	Remove_Hostage_Scanner_Point
	add.w	#1000,inter_score
	movem.l (sp)+,a0/a2/a3/d6
	rts	
	
*******************************************
****       COLLECT SKULLY             *****
*******************************************
Collect_Skully
	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	
	movem.l	a0-a2/d5-d6,-(sp)
	move.l	#Score10_Object,d2
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	bsr	Simple_Add_Alien_To_List

	move.l	#CoinDiss_Alien,d2
	addq.w	#2,d1
	bsr	Simple_Add_Alien_To_List
	
	movem.l	(sp)+,a0-a2/d5-d6
	add.w	#10,cash
	clr.w	cash_request

	rts		
	
*******************************************
****       COLLECT COIN               *****
*******************************************
Collect_Coin
	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	
	movem.l	a0-a2,-(sp)
	move.l	#Score50_Object,d2
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	bsr	Simple_Add_Alien_To_List
	
	subq.w	#4,d0
	subq.w	#1,d1
	move.l	#CoinDiss_Alien,d2
	bsr	Simple_Add_Alien_To_List
	
	movem.l	(sp)+,a0-a2
	add.w	#50,cash
	clr.w	cash_request	
	rts			
	
*******************************************
****       COLLECT SILVER COIN        *****
*******************************************
Collect_Silver_Coin
	move.w	#Sound_Collect,sound_chan3
	bset.b	#ALIEN_DEAD,alien_flags(a1)
	
	movem.l	a0-a2,-(sp)
	move.l	#Score20_Object,d2
	move.w	alien_x(a1),d0
	move.w	alien_y(a1),d1
	bsr	Simple_Add_Alien_To_List
	
	subq.w	#4,d0
	subq.w	#1,d1
	move.l	#CoinDiss_Alien,d2
	bsr	Simple_Add_Alien_To_List
	
	movem.l	(sp)+,a0-a2
	add.w	#20,cash
	clr.w	cash_request		;ask to update cash panel	
	rts			

