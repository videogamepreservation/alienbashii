MAX_BULLETS	EQU	50


STANDARD_GUN		EQU	0
STANDARD_DOUBLED	EQU	1*4
STANDARD_GUN_TRIPLE	EQU	2*4
ROCKET_LAUNCHER		EQU	3*4
GRENADE			EQU	4*4


GRENADE_FRAMES		EQU	4

weapon_call_table
	dc.l	Add_Standard_Fire
	dc.l	Add_Double_Fire
	dc.l	Add_Triple_Fire
	dc.l	Add_Rocket
	dc.l	Add_Grenade		


PLAYER_BASIC_BULLET_DELAY	EQU	4
PLAYER_TRIPLE_BULLET_DELAY	EQU	4
PLAYER_GRENADE_DELAY		EQU	15
PLAYER_ROCKET_LAUNCHER_DELAY	EQU	19


player_fire_delay		dc.w	PLAYER_BASIC_BULLET_DELAY

homing_missiles			dc.w	0
current_weapon			dc.w	STANDARD_GUN


	
*-----------------------All code for weapons--------------------

************************************************
******     CHECK PLAYER FIRE              ******
************************************************
Check_Player_Fire


	cmp.w	#GRENADE,current_weapon
	bne.s	regular_fire
	bsr	Add_Sight	
	
regular_fire
	tst	fire
	beq.s	player_not_fired

	tst.w	player_fire_delay
	bne.s	player_not_fired

	moveq	#0,d0
	move.w	current_weapon,d0
	
	move.l	#weapon_call_table,a0
	move.l	(a0,d0),a0
	jsr	(a0)
	
player_not_fired
	tst	player_fire_delay
	beq.s	quit_player_fire
	subq.w	#1,player_fire_delay
quit_player_fire
	rts


************************************************
******     ADD SIGHT                      ******
************************************************
Add_Sight	
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	
*16 to get middle of player and -6 middle of sight (as 13 high)	
	
	add.w	#16-6,d0		;middle of player
	add.w	#16-6,d1
	
	move.w	Grenade_Distance,d5
	move.w	d5,d6
	move.l	#Unit_Table,a0
	moveq	#0,d7
	move.w	last_direction,d7
	asl	#2,d7
	muls	(a0,d7),d5
	muls	2(a0,d7),d6
	
	add.w	d5,d0
	add.w	d6,d1
	
	move.w	d0,sight_x
	move.w	d1,sight_y
	
	move.w	#CrossHair,d2
	bsr	Add_Alien_To_List
	rts

sight_x	dc.w	0
sight_y	dc.w	0
************************************************
******     ADD GRENADE                    ******
************************************************
Add_Grenade
	
	tst	grenades_in_pack
	bne.s	still_grenades_left
	move.w	#Sound_GunEmpty,sound_chan2
	move.w	players_weapon,current_weapon
	move.w	gun_level,weapon_level
	bsr	Display_Weapon_Power_Level
	bsr	Display_Weapon_On_Panel
	bsr	Display_Grenade_Packs
	rts
still_grenades_left
	subq.w	#1,grenades_in_pack	
	bne.s	not_at_end_of_pack
	subq.w	#1,grenade_packs
	beq.s	no_grenade_packs_left
	move.w	#5,grenades_in_pack
no_grenade_packs_left
	bsr	Display_Grenade_Packs
not_at_end_of_pack	

	move.l	#Target_Alien,d2
	move.w	sight_x,d0
	move.w	sight_y,d1
	bsr	Simple_Add_Alien_To_List
	move.l	a1,d7
	
	
	move.w	Grenade_Distance,d3
	move.w	d3,d4
	asr	d4
	ext.l	d4
	divu	#GRENADE_FRAMES,d4
	ror	#8,d4
	or.w	d4,d3		;store data in alien struct
	
	clr.l   d0
	move.w	last_direction,d0
	move.l	#Grenade_table,a0
	asl.w	#2,d0
	move.l	(a0,d0),d2
	move.w	actual_player_map_x_position,d0
	move.w	actual_player_map_y_position,d1
	tst.b	man_direction
	beq.s	skip_inc_add
	move.w	player_x_inc,d6
	add.w	d6,d6
	add.w	d6,d0
	move.w	player_y_inc,d6
	add.w	d6,d6
	add.w	d6,d1
skip_inc_add	
	addq.w	#8,d0
	addq.w	#8,d1
	bsr	Simple_Add_Alien_To_List	
	move.l	d7,alien_work(a1)
		
	move.w	#PLAYER_GRENADE_DELAY,player_fire_delay

	rts

MAX_GRENADE_DISTANCE	EQU	104
DEFAULT_DISTANCE	EQU	60

Grenade_Positioning		dc.w	0
Grenade_Distance		dc.w	DEFAULT_DISTANCE


************************************************
******     ADD STANDARD FIRE              ******
************************************************
Add_Standard_Fire


	
	move.w	#PLAYER_BASIC_BULLET_DELAY,player_fire_delay

	
	move.w	#Sound_GunFire,sound_chan2	
	moveq	#0,d0
	moveq	#0,d1
	move.w	last_direction,d0
	move.l	#basic_bullet_table,a0
	asl.w	#4,d0
	move.l	(a0,d0),d2
	
	
*Do bullet offsets	
	move.l	#player_frame_offsets,a0
	move.w	player_current_frame,d1
	asl	#2,d1
	asr	#2,d0
	move.l	(a0,d1),a0	;offest table for frame
	move.w	2(a0,d0),d1
	move.w	(a0,d0),d0
	
	
	
*End	
	
	add.w	actual_player_map_x_position,d0
	add.w	actual_player_map_y_position,d1
	bsr	add_bullet_to_list	

	rts
	
************************************************
******     ADD DOUBLE  FIRE               ******
************************************************
Add_Double_Fire
	
	move.w	#PLAYER_BASIC_BULLET_DELAY,player_fire_delay

	
	move.w	#Sound_GunFire,sound_chan2	
	moveq	#0,d5
	moveq	#0,d1
	move.w	last_direction,d5
	move.l	#basic_bullet_table,a0
	asl.w	#4,d5
	move.l	(a0,d5),d2
	
	
*Do bullet offsets	
	move.l	#player_frame_offsets,a0
	move.l	#double_fire_offsets,a4
	move.w	player_current_frame,d1
	asl	#2,d1
	asr	#2,d5
	move.l	(a0,d1),a0	;offset table for frame
	move.w	2(a0,d5),d7
	move.w	(a0,d5),d6
*End	
	
	move.w	d6,d0
	move.w	d7,d1
	add.w	(a4,d5),d0
	add.w	2(a4,d5),d1
	
	add.w	actual_player_map_x_position,d0
	add.w	actual_player_map_y_position,d1
	bsr	add_bullet_to_list	
	
	move.w	d6,d0
	move.w	d7,d1
	sub.w	(a4,d5),d0
	sub.w	2(a4,d5),d1
	
	add.w	actual_player_map_x_position,d0
	add.w	actual_player_map_y_position,d1
	bsr	add_bullet_to_list	


	rts

double_fire_offsets
	dc.w	0,0
	dc.w	0,6		;left_offsets
	dc.w	0,6		;right_offsets
	dc.w	0,0
	dc.w	6,0		;up_offsets
	dc.w	-4,4		;up_left_offsets
	dc.w	-4,-4 		;up_right_offsets
	dc.w	0,0
	dc.w	6,0		;down_offsets
	dc.w	4,4		;down_left_offsets
	dc.w	-4,4		;down_right_offsets
		

	
************************************************
******     ADD TRIPLE FIRE                ******
************************************************
Add_Triple_Fire
	
	move.w	#PLAYER_TRIPLE_BULLET_DELAY,player_fire_delay

	
	move.w	#Sound_GunFire,sound_chan2	
	moveq	#0,d7
	move.w	last_direction,d7
	move.l	#basic_bullet_table,a4
	asl.w	#4,d7
	move.l	(a4,d7),d2

*Do bullet offsets	
	move.l	#player_frame_offsets,a0
	move.w	player_current_frame,d1
	asl	#2,d1
	move.w	d7,d0
	asr	#2,d0
	move.l	(a0,d1),a0	;offest table for frame
	move.w	2(a0,d0),d1
	move.w	(a0,d0),d0
*End	

	
	add.w	actual_player_map_x_position,d0
	add.w	actual_player_map_y_position,d1
	bsr	add_bullet_to_list
	move.l	4(a4,d7),d2
	bsr	add_bullet_to_list
	move.l	8(a4,d7),d2	
	bsr	add_bullet_to_list
	
	
	rts
	
	
	
************************************************
******     ADD ROCKET                     ******
************************************************
Add_Rocket
	
	tst	rockets_in_pack
	bne.s	still_rockets_left
	move.w	#Sound_GunEmpty,sound_chan2
	move.w	players_weapon,current_weapon
	move.w	gun_level,weapon_level
	bsr	Display_Weapon_Power_Level
	bsr	Display_Weapon_On_Panel
	bsr	Display_Grenade_Packs
	rts
still_rockets_left
	subq.w	#1,rockets_in_pack	
	bne.s	not_at_end_of_rpack
	subq.w	#1,rocket_packs
	beq.s	no_rocket_packs_left
	move.w	#5,rockets_in_pack
no_rocket_packs_left
	bsr	Display_Grenade_Packs
not_at_end_of_rpack	

	
	
	
	move.w	#PLAYER_ROCKET_LAUNCHER_DELAY,player_fire_delay

	move.w	#Sound_Rocket,sound_chan1	
	moveq	#0,d0
	move.w	last_direction,d0
	move.l	#Rocket_table,a0
	asl.w	#2,d0
	move.l	(a0,d0),d2

*Do bullet offsets	
	move.l	#player_frame_offsets,a0
	move.w	player_current_frame,d1
	asl	#2,d1
	move.l	(a0,d1),a0	;offest table for frame
	move.w	2(a0,d0),d1
	move.w	(a0,d0),d0
*End	
	
	
	add.w	actual_player_map_x_position,d0
	add.w	actual_player_map_y_position,d1
	bsr	add_bullet_to_list	
	rts
	
	
************************************************
******     GRENADE UPDATE                 ******
************************************************
Grenade_Update

*Called by alien routine when updating grenade


	sub.b	#GRENADE_SPEED,alien_data+1(a2)
	bge	dont_kill_grenade
	bset.b	#ALIEN_DEAD,alien_flags(a2)	
	move.l	a2,d7
	move.l	alien_work(a2),a2
	bset.b	#ALIEN_DEAD,alien_flags(a2)	;kill target
	move.l	d7,a2

	movem.l	a0-a3/d0-d1,-(sp)

*Test to see if grenade hit water
	move.l	current_map_pointer,a3


	move.w	alien_x(a2),d6
	move.w	alien_y(a2),d7
	move.w	d6,d0
	move.w	d7,d1
	andi.w	#$fff0,d6	;get block co-cords
	andi.w	#$fff0,d7
	

	asr.w	#3,d6	;word map
	asr.w	#4,d7
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d7
	ext.l	d6
	add.l	d6,a3
	add.l	d7,a3
	
	moveq	#0,d2
	move.w	(a3),d2		;block
	asl	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a3
	move.b	block_details(a3,d2.l),d7	;our data	
	btst	#WATER_FLAG,d7
	beq.s	explode_grenade_shell
	subq.w	#3,d0				;re-position splash
	subq.w	#3,d1	
	move.l	#Generic_Splash_Object,d2
	bsr	Simple_Add_Alien_To_List
	movem.l	(sp)+,a0-a3/d0-d1
	rts
explode_grenade_shell

	moveq	#0,d0
	move.w	grenade_level,d0
	asl	#2,d0
	move.l	#Grenade_Explosion_Types,a0
	move.l	(a0,d0.l),a0
	jsr	(a0)	

	movem.l	(sp)+,a0-a3/d0-d1
	move.w	#Sound_Grenade,Sound_chan2
	rts
dont_kill_grenade
	
	moveq	#0,d6
	moveq	#0,d1
	move.b	alien_data+1(a2),d6
	move.b	alien_data(a2),d1
	divu	d1,d6
	cmp.w	#GRENADE_FRAMES,d6
	blt.s	not_going_down_grenade
	neg.w	d6
	addq.w	#7,d6
not_going_down_grenade
	move.w	d6,alien_frame(a2)	

*Add shadow
	movem.l	a0-a2/d0-d1,-(sp)
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1
	addq.w	#4,d0
	addq.w	#4,d1	
	move.l	#Grenade_Shadow,d2
	bsr	Simple_Add_Alien_To_List	-a1 = alien struct
	move.w	d6,alien_frame(a1)
	movem.l	(sp)+,a0-a2/d0-d1
	rts

Level1_Grenade_Explosion
	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1

	
	moveq	#0,d7
	move.b	alien_type_number(a4),d7

	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	
	move.l	#Extra_Bullets_List_Level1,a2
	mulu	#20,d7
	move.l	(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	4(a2,d7.l),bullet_pat_ptr(a1)

	subq.w	#5,d0
	subq.w	#5,d1
	move.l	#Grenade_Explosion_Bullet,d2
	bsr	Add_Bullet_To_List	;Will need to be a bullet


	rts
	
Level2_Grenade_Explosion	

	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1

	
	moveq	#0,d7
	move.b	alien_type_number(a4),d7

	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	
	move.l	#Extra_Bullets_List_Level1,a2
	mulu	#20,d7
	move.l	(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	4(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	8(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	12(a2,d7.l),bullet_pat_ptr(a1)

	subq.w	#5,d0
	subq.w	#5,d1
	move.l	#Grenade_Explosion_Bullet,d2
	bsr	Add_Bullet_To_List	;Will need to be a bullet


	
	rts
	
Level3_Grenade_Explosion	
	move.w	alien_x(a2),d0
	move.w	alien_y(a2),d1

	
	moveq	#0,d7
	move.b	alien_type_number(a4),d7

	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	
	move.l	#Extra_Bullets_List_Level1,a2
	mulu	#20,d7
	move.l	(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	4(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	8(a2,d7.l),bullet_pat_ptr(a1)
	
	move.l	#small_explo_bullet,d2
	bsr	Add_Bullet_To_List
	move.l	12(a2,d7.l),bullet_pat_ptr(a1)

	subq.w	#5,d0
	subq.w	#5,d1
	move.l	#Grenade_Explosion_Bullet,d2
	bsr	Add_Bullet_To_List	;Will need to be a bullet
	move.l	16(a2,d7.l),bullet_pat_ptr(a1)

	rts


Grenade_Explosion_Types
	dc.l	Level1_Grenade_Explosion
	dc.l	Level2_Grenade_Explosion
	dc.l	Level3_Grenade_Explosion
	
Extra_Bullets_List_Level1
	dc.l	explo_bullet_patt7
	dc.l	explo_bullet_patt5
	dc.l	explo_bullet_patt4
	dc.l	explo_bullet_patt3
	dc.l	explo_grenade_patt1

	
	dc.l	explo_bullet_patt1
	dc.l	explo_bullet_patt3
	dc.l	explo_bullet_patt7
	dc.l	explo_bullet_patt6
	dc.l	explo_grenade_patt2


	
	dc.l	explo_bullet_patt5
	dc.l	explo_bullet_patt6
	dc.l	explo_bullet_patt1
	dc.l	explo_bullet_patt2
	dc.l	explo_grenade_patt3


	
	dc.l	explo_bullet_patt3
	dc.l	explo_bullet_patt2
	dc.l	explo_bullet_patt8
	dc.l	explo_bullet_patt5
	dc.l	explo_grenade_patt4


	
	dc.l	explo_bullet_patt8
	dc.l	explo_bullet_patt6
	dc.l	explo_bullet_patt4
	dc.l	explo_bullet_patt3
	dc.l	explo_grenade_patt5


	
	dc.l	explo_bullet_patt2
	dc.l	explo_bullet_patt4
	dc.l	explo_bullet_patt7
	dc.l	explo_bullet_patt6
	dc.l	explo_grenade_patt6

	
	dc.l	explo_bullet_patt8
	dc.l	explo_bullet_patt7
	dc.l	explo_bullet_patt2
	dc.l	explo_bullet_patt1
	dc.l	explo_grenade_patt7


	
	dc.l	explo_bullet_patt1
	dc.l	explo_bullet_patt4
	dc.l	explo_bullet_patt8
	dc.l	explo_bullet_patt5
	dc.l	explo_grenade_patt8
	

************************************************
******     SETUP BULLET POINTERS          ******
************************************************
Setup_Bullet_Pointers

	move.l	#bullet_pointers,a0
	move.l	#bullet_structures,a1
	move.w	#MAX_BULLETS-1,d0
assign_bullet_mem
	move.l	a1,(a0)+
	add.l	#bullet_struct_size,a1	
	dbra	d0,assign_bullet_mem
	
	move.l	#$ffffffff,active_bullet_pointers	
	move.l	#bullet_pointers,current_add_bullet_ptr
	move.l	#active_bullet_pointers,current_bullet_list_ptr
	rts

************************************************
******     CHECK ROCKET EXPLO             ******
************************************************
Check_Rocket_Explo

	
	cmp.w	#2,rocket_level
	beq.s	do_explosive_tip
	rts
do_explosive_tip

	move.l	a0,d4
	move.l	a1,d5
	move.l	a2,d6
	move.l	a3,d3

	move.l	#Small_Explo_Bullet,d2
	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1
	move.w	#8-1,d7
	
	move.l	current_add_bullet_ptr,a0
	move.l	current_bullet_list_ptr,a3
	move.l	#rocket_full_8,a2
add_rocket_explos_loop	
	cmp.l	#$ffffffff,(a0)
	beq.s	rocket_bullet_list_full
	
	move.l	(a0)+,a1
	
	move.w	d0,bullet_x(a1)
	move.w	d1,bullet_y(a1)
	clr.w	bullet_frame(a1)
	clr.w	bullet_dead_flag(a1)
	move.l	d2,bullet_type_ptr(a1)	
	clr.w	bullet_frame_counter(a1)
	move.l	(a2)+,bullet_pat_ptr(a1)
	move.w	#6,bullet_hits(a1)
	move.l	a1,(a3)+		
	dbra	d7,add_rocket_explos_loop			
rocket_bullet_list_full
	move.l	a0,current_add_bullet_ptr
	move.l	#$ffffffff,(a3)
	move.l	a3,current_bullet_list_ptr
	move.l	d4,a0
	move.l	d5,a1
	move.l	d6,a2
	move.l	d3,a3
	rts

rocket_full_8
	dc.l	explo_bullet_patt1
	dc.l	explo_bullet_patt2
	dc.l	explo_bullet_patt3
	dc.l	explo_bullet_patt4
	dc.l	explo_bullet_patt5
	dc.l	explo_bullet_patt6
	dc.l	explo_bullet_patt7
	dc.l	explo_bullet_patt8


************************************************
******     ADD BULLET TO LIST             ******
************************************************
Add_Bullet_To_List
*send x,y in d0 and d1
*send type in d2 (pointer)

	move.l	current_add_bullet_ptr,a0
	cmp.l	#$ffffffff,(a0)
	beq.s	bullet_list_full
	
	move.l	(a0)+,a1
	move.l	a0,current_add_bullet_ptr
	
	move.w	d0,bullet_x(a1)
	move.w	d1,bullet_y(a1)
	clr.w	bullet_frame(a1)
	clr.w	bullet_dead_flag(a1)
	move.l	d2,bullet_type_ptr(a1)	
	clr.w	bullet_frame_counter(a1)
	move.l	d2,a3
	move.l	alien_pattern_ptr(a3),bullet_pat_ptr(a1)
	move.w	alien_hit_count(a3),bullet_hits(a1)
		
	move.l	current_bullet_list_ptr,a0
	move.l	a1,(a0)+
	move.l	#$ffffffff,(a0)
	move.l	a0,current_bullet_list_ptr
	
bullet_list_full
	rts

LONG_BULLET_HEIGHT	EQU	8
SMALL_BULLET_HEIGHT	EQU	6
GREEN_BULLET_HEIGHT	EQU	7

************************************************
******     SET UP BULLET TYPE             ******
************************************************
Set_Up_Bullet_Type

*First sort out graphics

	move.l 	#small_bullets,a0
	move.w	gun_type,d0
	beq.s	small_bullet_class
	cmp.w	#4,d0
	beq.s	green_bullet_class
	move.l	#long_bullet_type,a1
	move.w	#LONG_BULLET_HEIGHT,d1
	bra.s	copy_bullet_data
green_bullet_class
	move.l	#green_bullet_type,a1
	move.w	#GREEN_BULLET_HEIGHT,d1
	bra.s	copy_bullet_data
small_bullet_class	
	move.l	#small_bullet_type,a1
	move.w	#SMALL_BULLET_HEIGHT,d1	
copy_bullet_data	
	
	move.w	d1,d2
	move.l	a0,a2
	mulu	#(2*5*8)/2,d1	(*5 cos includes mask)
	subq.w	#1,d1
copy_bullet_data_loop
	move.w	(a1)+,(a0)+
	dbra	d1,copy_bullet_data_loop

*calculate data to put into structs
*a2 = graphics
	
	move.w	d2,d4
	asl	d4
	move.w	d4,d5	;frame size
	asl	#3,d4	;plane size
	move.l	#small_bullet_up,a4	;start of structs
	move.w	#NUMBER_OF_BULLET_STRUCTS-1,d7
update_bullet_structs_loop
	moveq	#0,d3
	move.b	alien_type_number(a4),d3		
	move.w	d2,alien_x_size(a4)
	move.w	d2,alien_y_size(a4)
	move.w	d4,alien_plane_size(a4)
	move.w	d5,alien_frame_size(a4)
	move.w	d2,d6
	asl	d6
	mulu	d3,d6	;give offset into data
	move.l	a2,a3
	add.l	d6,a3
	move.l	a3,alien_graphics(a4)
	move.w	d2,d6
	asl	d6
	asl	#5,d6
	ext.l	d6
	add.l	d6,a3
	move.l	a3,alien_mask(a4)
	moveq	#0,d6
	move.w	d2,d6
	asl	#6,d6
	add.w	#2,d6
	move.w	d6,alien_blit_size(a4)
	
	add.l	#SIZE_OF_BULLET_STRUCT,a4
	dbra	d7,update_bullet_structs_loop	
	rts

************************************************
******     SET UP ROCKET TYPE             ******
************************************************
Set_Up_Rocket_Type

	clr.w	d1
	tst	rocket_level
	beq.s	base_rocket_level
	move.w	#10,d1		;hits rocket can withstand
base_rocket_level
	
	move.l	#rocket_up,a0
	move.w	#8-1,d0
set_up_rocket_hits
	move.w	d1,alien_hit_count(a0)
	add.l	#alien_info_struct_size,a0
	dbra	d0,set_up_rocket_hits
	
	rts
	
************************************************
******     PROCESS BULLETS                ******
************************************************
Process_Bullets

*Only a quick version just so can see aliens up and running

	move.l	#active_bullet_pointers,a0
	move.l	end_alien_draw_ptr,a1
	move.l	a0,a3
process_bullet_loop
	cmp.l	#$ffffffff,(a0)
	beq	finished_processing_bullets

	move.l	(a0),a2

*-----------------Is bullet dead---------------------


	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1

	tst.w	bullet_dead_flag(a2)
	bne	bullet_dead

*------------------Has bullet hit a block?--------------

	move.l	alien_type_ptr(a2),a4
	btst.b	#NO_EXPLODE,alien_type_flags(a4)
	bne	bullet_not_hit_block
	
	move.l	current_map_pointer,a4
 	
	moveq	#0,d2
	andi.w	#$fff0,d0	;get block co-cords
	andi.w	#$fff0,d1
	
	move.w	d0,d2
	move.w	d1,d3

	asr.w	#3,d2	;word map
	asr.w	#4,d3
	muls	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,d3
	add.l	d2,a4
	add.l	d3,a4
	
	move.w	(a4),d2		;block
	asl	#BLOCK_STRUCT_MULT,d2
	move.l	#block_data_information,a5
	add.l	d2,a5
	move.b	block_details(a5),d7	;our data
	
	btst	#BULLET_DIE_FLAG,d7
	beq.s	bullet_not_hit_block
	
	move.w	#Sound_Thud,Sound_Chan2		;default sound
	
	clr.l	d7
	move.b	block_type(a5),d7
	andi.w	#$f0,d7
	beq.s	bullet_dead	; no data to act on
	lsr.w	#2,d7		;get data, but leave shifted up by 2
	
	move.l	#bullet_hit_routine_table,a5
	move.l	(a5,d7),a5
	jsr	(a5)		;call bullet hit routine	
	
*----------What happens if bullet dead

bullet_dead
	
	move.l	bullet_type_ptr(a2),a4
	move.l	alien_dead_pattern(a4),a5
	bra	process_bullet_script

bullet_not_hit_block

*-----------------Is bullet out of bounds------------	
	
	sub.w	scroll_x_position,d0
	sub.w	scroll_y_position,d1

	cmp.w	#-16,d1
	ble	kill_off_bullet
	cmp.w	#240+16,d1
	bge	kill_off_bullet
	cmp.w	#-16,d0
	ble	kill_off_bullet
	cmp.w	#320+16,d0
	bge	kill_off_bullet

	
*----------------Great bullet in bounds so update bullet----

	move.l	bullet_type_ptr(a2),a4
	move.l	bullet_pat_ptr(a2),a5
	
process_bullet_script	
	movem.l	a3/a0,-(sp)
	move.l	#Bullet_Commands,a3
process_bullet_commands
	cmp.w	#START_COMMANDS,(a5)
	blt.s	no_bullet_commands
	
	moveq	#0,d7
	move.w	(a5)+,d7
	sub.w	#OBJECT_SET_PAT,d7
	asl.w	#2,d7
	move.l	(a3,d7),a0
	jsr	(a0)
	bra.s	process_bullet_commands	
	
			
no_bullet_commands	
	move.w	(a5)+,d0
	add.w	d0,bullet_x(a2)		
	move.w	(a5)+,d1
	add.w	d1,bullet_y(a2)

done_commands
	move.l	a5,bullet_pat_ptr(a2)

	movem.l	(sp)+,a3/a0
	
	tst	bullet_dead_flag(a2)
	bne.s	kill_off_bullet
	
*----------update bullet frames

	move.w	bullet_frame(a2),alien_draw_frame(a1)

	subq.w	#1,bullet_frame_counter(a2)
	bgt.s	dont_update_bullet_frame
	addq.w	#1,bullet_frame(a2)
	move.w	alien_frame_rate(a4),bullet_frame_counter(a2)	
	move.w	alien_number_frames(a4),d2
	cmp.w	bullet_frame(a2),d2
	bgt.s	dont_update_bullet_frame
	clr.w	bullet_frame(a2)	
dont_update_bullet_frame	

*----------------

	
	move.l	a2,alien_struct_ptr(a1)		

	add.l	#alien_draw_size,a1
	
	move.l	a2,(a3)+
	bra.s	update_bullet_mem
	
kill_off_bullet
*put bullet back into list
	move.l	current_add_bullet_ptr,a4
	subq.l	#4,a4
	move.l	(a0),(a4)
	move.l	a4,current_add_bullet_ptr
update_bullet_mem	
	addq.l	#4,a0
	bra	process_bullet_loop	
finished_processing_bullets
	move.l	#$ffffffff,(a3)
	move.l	#$ffffffff,(a1)			;term draw list
	move.l	a3,current_bullet_list_ptr
	rts

*----------------Bullet Pattern Commmands

Bullet_Commands
	dc.l	Bullet_Object_Set_Pat
	dc.l	Bullet_Object_Set_Frame
	dc.l	Bullet_Object_Kill
	dc.l	Bullet_Object_Add
	dc.l	Bullet_Object_Simple_Add
	dc.l	Bullet_Bullet_List_Add
	dc.l	Bullet_Pattern_Restart
	dc.l	Alien_Sound_Effect_1
	dc.l	Alien_Sound_Effect_2
	dc.l	Alien_Sound_Effect_3
	dc.l	Alien_Sound_Effect_4
	dc.l	Bullet_Execute_Code
	dc.l	Bullet_Add_Lots



		
		
Bullet_Bullet_List_Add
	movem.l	a0-a1/a3,-(sp)
	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Add_Bullet_To_List
	movem.l	(sp)+,a0-a1/a3
	rts		
	
Bullet_Object_Add
	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.w	(a5)+,d2
	bsr	Add_Alien_To_List
	rts	
	
Bullet_Object_Simple_Add
	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
	move.l	(a5)+,d2
	bsr	Simple_Add_Alien_To_List
	rts	
	
	
Bullet_Object_Set_Frame
	move.w	(a5)+,bullet_frame(a2)
	rts
	
Bullet_Object_Set_Pat
	move.l	(a5)+,a5
	rts

Bullet_Pattern_Restart
	move.l	alien_pattern_ptr(a4),a5
	rts
	
Bullet_Object_Kill
	move.w	#1,bullet_dead_flag(a2)
	rts
	
Bullet_Execute_Code
	move.l	(a5)+,d7
	bsr	Check_Rocket_Explo	;only ever be used for this
	rts	

Bullet_Add_Lots
	move.l	a0,d5	;faster than stack
	move.l	a1,d6
	move.l	a3,d7
	move.w	bullet_x(a2),d0
	move.w	bullet_y(a2),d1
	add.w	(a5)+,d0
	add.w	(a5)+,d1
Bullet_Keep_Adding_Simples	
	move.l	(a5)+,d2
	cmp.l	#$ffffffff,d2
	beq.s	bullet_finished_adding_simples
	bsr	Add_Bullet_To_List
	bra.s	Bullet_Keep_Adding_Simples
Bullet_finished_adding_simples	
	move.l	d5,a0	;faster than stack
	move.l	d6,a1
	move.l	d7,a3
	rts
*----------------End Bullet pattern commands




basic_bullet_table
	dc.l	0,0,0,0					;0
	
	dc.l	small_bullet_left,small_bullet_left_b	;1
	dc.l	small_bullet_left_c,0	
	
	dc.l	small_bullet_right,small_bullet_right_b ;2
	dc.l	small_bullet_right_c,0
	
	dc.l	0,0,0,0					;3
	
	dc.l	small_bullet_up,small_bullet_up_b	;4
	dc.l	small_bullet_up_c,0
	
	dc.l	small_bullet_up_left,small_bullet_up_left_b	;5
	dc.l	small_bullet_up_left_c,0
	
	dc.l	small_bullet_up_right,small_bullet_up_right_b	;6
	dc.l	small_bullet_up_right_c,0
	
	dc.l	0,0,0,0					;7
	
	dc.l	small_bullet_down,small_bullet_down_b	;8
	dc.l	small_bullet_down_c,0
	
	dc.l	small_bullet_down_left,small_bullet_down_left_b	;9
	dc.l	small_bullet_down_left_c,0
	
	dc.l	small_bullet_down_right,small_bullet_down_right_b	;10
	dc.l	small_bullet_down_right_c,0

rocket_table
	dc.l	0			;0
	dc.l	rocket_left		;1
	dc.l	rocket_right		;2
	dc.l	0			;3
	dc.l	rocket_up		;4
	dc.l	rocket_up_left		;5
	dc.l	rocket_up_right		;6
	dc.l	0			;7
	dc.l	rocket_down		;8
	dc.l	rocket_down_left	;9
	dc.l	rocket_down_right	;10


Grenade_Table
	dc.l	0			;0
	dc.l	Grenade_Left		;1
	dc.l	Grenade_Right		;2
	dc.l	0			;3
	dc.l	Grenade_Up		;4
	dc.l	Grenade_Up_left		;5
	dc.l	Grenade_Up_right	;6
	dc.l	0			;7
	dc.l	Grenade_down		;8
	dc.l	Grenade_down_left	;9
	dc.l	Grenade_down_right	;10



*basic bullet struct
	rsreset
	
bullet_x		rs.w	1
bullet_y		rs.w	1
bullet_type_ptr		rs.l	1	;same as alien type ptr
bullet_dead_flag	rs.w	1
bullet_pat_ptr		rs.l	1
bullet_frame		rs.w	1
bullet_frame_counter	rs.w	1
bullet_hits		rs.w	1
bullet_struct_size	rs.w	1
	
Unit_Table
	dc.w	0,0
	dc.w	-1,0
	dc.w	1,0
	dc.w	0,0
	dc.w	0,-1
	dc.w	-1,-1
	dc.w	1,-1
	dc.w	0,0
	dc.w	0,1
	dc.w	-1,1
	dc.w	1,1
		
		
player_frame_offsets
	dc.l	player_bullet_offset_table_frame1
	dc.l	player_bullet_offset_table_frame2		
	dc.l	player_bullet_offset_table_frame3	;third
	dc.l	player_bullet_offset_table_frame4
	dc.l	player_bullet_offset_table_frame5
	dc.l	player_bullet_offset_table_frame6
	
		


player_bullet_offset_table_frame1
	dc.w	0,0
	dc.w	BULLET_INC,14	 			;left_offsets
	dc.w	28-BULLET_INC,14 			;right_offsets
	dc.w	0,0
	dc.w	17,1+BULLET_INC				;up_offets
	dc.w	0+BULLET_INC,4+BULLET_INC		;up_left_offsets
	dc.w	28-BULLET_INC,2+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	11,27-BULLET_INC			;down_offsets
	dc.w	4+BULLET_INC,22-BULLET_INC		;down_left_offsets
	dc.w	28-BULLET_INC,25-BULLET_INC		;down_right_offsets
		
player_bullet_offset_table_frame2
	dc.w	0,0
	dc.w	-1+BULLET_INC,13			;left_offsets
	dc.w	28-BULLET_INC,13			;right_offsets
	dc.w	0,0
	dc.w	18,1+BULLET_INC				;up_offets
	dc.w	1+BULLET_INC,3+BULLET_INC		;up_left_offsets
	dc.w	27-BULLET_INC,1+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	11,26-BULLET_INC			;down_offsets
	dc.w	3+BULLET_INC,21-BULLET_INC		;down_left_offsets
	dc.w	29-BULLET_INC,24-BULLET_INC		;down_right_offsets
			
player_bullet_offset_table_frame3
	dc.w	0,0
	dc.w	-1+BULLET_INC,12			;left_offsets
	dc.w	27-BULLET_INC,12			;right_offsets
	dc.w	0,0
	dc.w	19,1+BULLET_INC				;up_offets
	dc.w	2+BULLET_INC,2+BULLET_INC		;up_left_offsets
	dc.w	26-BULLET_INC,1+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	9,26-BULLET_INC				;down_offsets
	dc.w	2+BULLET_INC,20-BULLET_INC		;down_left_offsets
	dc.w	30-BULLET_INC,24-BULLET_INC		;down_right_offsets
					
player_bullet_offset_table_frame4
	dc.w	0,0
	dc.w	0+BULLET_INC,11				;left_offsets
	dc.w	28-BULLET_INC,12			;right_offsets
	dc.w	0,0
	dc.w	20,1+BULLET_INC				;up_offets
	dc.w	3+BULLET_INC,2+BULLET_INC		;up_left_offsets
	dc.w	27-BULLET_INC,1+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	8,27-BULLET_INC				;down_offsets
	dc.w	1+BULLET_INC,20-BULLET_INC		;down_left_offsets
	dc.w	29-BULLET_INC,24-BULLET_INC		;down_right_offsets

		
player_bullet_offset_table_frame5
	dc.w	0,0
	dc.w	-1+BULLET_INC,12			;left_offsets
	dc.w	28-BULLET_INC,13			;right_offsets
	dc.w	0,0
	dc.w	19,1+BULLET_INC				;up_offets
	dc.w	2+BULLET_INC,2+BULLET_INC		;up_left_offsets
	dc.w	28-BULLET_INC,2+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	9,26-BULLET_INC				;down_offsets
	dc.w	2+BULLET_INC,20-BULLET_INC		;down_left_offsets
	dc.w	28-BULLET_INC,25-BULLET_INC		;down_right_offsets
			
player_bullet_offset_table_frame6
	dc.w	0,0
	dc.w	-1+BULLET_INC,13				;left_offsets
	dc.w	27-BULLET_INC,14			;right_offsets
	dc.w	0,0
	dc.w	18,1+BULLET_INC				;up_offets
	dc.w	1+BULLET_INC,3+BULLET_INC		;up_left_offsets
	dc.w	29-BULLET_INC,3+BULLET_INC 		;up_right_offsets
	dc.w	0,0
	dc.w	10,26-BULLET_INC			;down_offsets
	dc.w	3+BULLET_INC,19-BULLET_INC		;down_left_offsets
	dc.w	27-BULLET_INC,26-BULLET_INC		;down_right_offsets