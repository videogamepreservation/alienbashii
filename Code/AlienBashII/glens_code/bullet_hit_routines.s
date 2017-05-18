LEFT_OVER_HOLE	EQU	129

bullet_hit_routine_table
	dc.l	0	
	dc.l	Pot_Empty_Routine		
	dc.l	Activate_Bullet_Switch1
	dc.l	Activate_Bullet_Switch2
	dc.l	Activate_Bullet_Switch3
	dc.l	Activate_Bullet_Switch4
	dc.l	Pot_Gold_Routine		
	dc.l	Pot_Silver_Routine		
	dc.l	Pot_Explosion_Routine		
	dc.l	Pot_Maggot_Routine		
	dc.l	Pot_Energy_Routine		
	dc.l	Gold_Wall_Coin_Routine		
	dc.l	Silver_Wall_Coin_Routine	
	dc.l	Double_Silver_Wall_Coin_Routine	
	dc.l	Wall_Potion_Bonus		
	dc.l	Make_Chink_Sound


;a4 = block memory
;d0 and d1 = block position
	
*********************************************
***      MAKE CHINK SOUND                 ***
*********************************************
Make_Chink_Sound
	move.w	#Sound_Chink,sound_chan2
	rts	
	
*********************************************
***       GOLD WALL COIN                  ***
*********************************************
Gold_Wall_Coin_Routine
	movem.l	a0-a3/d0-d3,-(sp)
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#LEFT_OVER_HOLE,d2
	bsr	Change_Block
	addq.w	#6,d0
	add.w	#10,d1	
	move.l	#Gold_Wall_Coin_Object,d2
	bsr	Simple_Add_Alien_To_List	
	move.l	#Block_Split_Object_3,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Block_Split_Object_4,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_Crap,sound_chan4
	movem.l	(sp)+,a0-a3/d0-d3
	rts

*********************************************
***       SILVER WALL COIN                ***
*********************************************
Silver_Wall_Coin_Routine
	movem.l	a0-a3/d0-d3,-(sp)
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#LEFT_OVER_HOLE,d2
	bsr	Change_Block
	addq.w	#5,d0
	add.w	#10,d1	
	move.l	#Silver_Wall_Coin_Object,d2
	bsr	Simple_Add_Alien_To_List	
	move.l	#Block_Split_Object_3,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Block_Split_Object_4,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_Crap,sound_chan4
	movem.l	(sp)+,a0-a3/d0-d3
	rts

*********************************************
***       DOUBLE SILVER WALL COIN         ***
*********************************************
Double_Silver_Wall_Coin_Routine
	movem.l	a0-a3/d0-d3,-(sp)
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#LEFT_OVER_HOLE,d2
	bsr	Change_Block
	addq.w	#4,d0
	add.w	#8,d1	
	move.l	#Silver_Wall_CoinLeft_Object,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Silver_Wall_CoinRight_Object,d2
	bsr	Simple_Add_Alien_To_List	
	move.l	#Block_Split_Object_3,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Block_Split_Object_4,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_Crap,sound_chan4
	movem.l	(sp)+,a0-a3/d0-d3
	rts

*********************************************
***       POTION WALL BONUS               ***
*********************************************
Wall_Potion_Bonus
	movem.l	a0-a3/d0-d3,-(sp)
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#LEFT_OVER_HOLE,d2
	bsr	Change_Block
	addq.w	#2,d0
	add.w	#14,d1	
	move.l	#Wall_Potion_Object,d2
	bsr	Simple_Add_Alien_To_List	
	move.l	#Block_Split_Object_3,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Block_Split_Object_4,d2
	bsr	Simple_Add_Alien_To_List
	move.w	#Sound_Crap,sound_chan4
	movem.l	(sp)+,a0-a3/d0-d3
	rts
		
*********************************************
***         ACTIVATE_BULLET_SWITCHES      ***
*********************************************
Activate_Bullet_Switch1
	clr.w	d4
	bra.s	Activate_Bullet_Switch
Activate_Bullet_Switch2
	moveq	#4,d4
	bra.s	Activate_Bullet_Switch
Activate_Bullet_Switch3
	moveq	#8,d4
	bra.s	Activate_Bullet_Switch
Activate_Bullet_Switch4
	clr	d4
	move.w	#12,d4
Activate_Bullet_Switch

	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#switch_table,a1
	move.l	(a1,d4),d5
	beq.s	bullet_empty_switch_entry	
	move.l	switch_list_pointer,a1
	move.l	d5,(a1)+
	move.l	#$ffffffff,(a1)
	move.l	a1,switch_list_pointer
bullet_empty_switch_entry
	
	move.w	#Sound_Switch,sound_chan2
	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List
	
	move.w	scroll_x_position,d2
	andi.w	#$fff0,d2
	sub.w	d2,d0	
	move.w	scroll_y_position,d2
	sub.w	d2,d1
	
	move.w	#188,(a4)		;clear block	
	move.w	#188,d2
	bsr	Draw_68000_Block_Into_Copyback
	movem.l	(sp)+,d0-d3/a0-a3

	rts	

*********************************************
***         POT EMPTY  	                  ***
*********************************************
Pot_Empty_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts	

	
*********************************************
***         POT GOLD   	                  ***
*********************************************
Pot_Gold_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#Pot_Gold_Coin_Object,d2
	addq.w	#4,d0
	addq.w	#5,d1
	bsr	Simple_Add_Alien_To_List
	subq.w	#4,d0
	subq.w	#5,d1
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts	

*********************************************
***         POT SILVER 	                  ***
*********************************************
Pot_Silver_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#Pot_Silver_Coin_Object,d2
	addq.w	#4,d0
	addq.w	#5,d1
	bsr	Simple_Add_Alien_To_List
	subq.w	#4,d0
	subq.w	#5,d1
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts	

*********************************************
***         POT Explosion                 ***
*********************************************
Pot_Explosion_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#Spore_Fragment_Object1,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Spore_Fragment_Object2,d2
	bsr	Simple_Add_Alien_To_List
	move.l	#Spore_Fragment_Object3,d2
	bsr	Simple_Add_Alien_To_List
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts	

*********************************************
***         POT Maggot 	                  ***
*********************************************
Pot_Maggot_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#Maggot_Alien,d2
	bsr	Simple_Add_Alien_To_List
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts		

*********************************************
***         POT ENERGY 	                  ***
*********************************************
Pot_Energy_Routine
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	#Small_Potion_Object,d2
	bsr	Simple_Add_Alien_To_List
	bsr	Blow_Up_Split_Block
	movem.l	(sp)+,d0-d3/a0-a3
	rts		
	
*********************************************
***         BLOW UP SPLIT BLOCK	          ***
*********************************************
Blow_Up_Split_Block	

	move.w	#Sound_Crap,sound_chan4
	
	moveq.w	#1,d2
	bsr	Change_Block

	move.l	#Block_Chain_Explosion,d2
	bsr	Simple_Add_Alien_To_List	

	move.l	#Block_Split_Object_1,d2
	bsr	Simple_Add_Alien_To_List
	addq.w	#8,d0
	move.l	#Block_Split_Object_2,d2
	bsr	Simple_Add_Alien_To_List
	addq.w	#8,d1
	move.l	#Block_Split_Object_3,d2
	bsr	Simple_Add_Alien_To_List
	subq.w	#8,d0
	move.l	#Block_Split_Object_4,d2
	bsr	Simple_Add_Alien_To_List

	rts 
	
*******************************************
** CHANGE BLOCK                          **
*******************************************	
Change_Block		
*send block in d2

	move.w	d0,d5
	move.w	d1,d6
	
	move.w	scroll_x_position,d3
	andi.w	#$fff0,d3
	sub.w	d3,d0
	
	move.w	scroll_y_position,d3
	sub.w	d3,d1

	move.w	d2,(a4)		;clear block	
	bsr	Draw_68000_Block_Into_Copyback
	
	move.w	d5,d0	;restore co-ords
	move.w	d6,d1
	rts
	