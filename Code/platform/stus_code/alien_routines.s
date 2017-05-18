Setup_Enemies 

; Just in case (Glen will probably corrupt memory at some point)

	move.l	#$ffffffff,BOBBACK1
	move.l	#$ffffffff,BOBBACK2
	move.l	#$ffffffff,FRIEND1
	move.l	#$ffffffff,FRIEND2
	move.l	#$ffffffff,CLEAR1
	move.l	#$ffffffff,CLEAR2
	move.l	#$ffffffff,SAVE1
	move.l	#$ffffffff,SAVE2
	move.l	#$ffffffff,LIST1
	move.l	#$ffffffff,LIST2
	move.l	#$ffffffff,Enemy_Store1
	move.l	#$ffffffff,Enemy_Store2	
	clr.l	alien_map_position
	move.w	#0,current_bonus
	move.w	#1,current_bonus_counter

****
; Sets up virtual positions, later on the game will not work this way
****

	bsr	Create_Enemy_Pointers
	move.l	#Level_1_Enemies,a3		; presets
	bsr	Stuff_Preset_Enemies

End_Setup_Aliens


	rts

Create_Enemy_Pointers
	move.l	Enemy_List,Last_Alien_in_list	; initialise tail var
	move.l	#$ffffffff,([Enemy_List])	; initialise list

	
	move.l	#Enemy_Memory,a0
		
	move.l	#Available_List,a1
	move.w	#Max_No_Objects-1,d0		; Alien store
thingyi
	move.l	a0,(a1)+
	add.l	#Store_Size,a0
	dbra	d0,thingyi
no_space_left
	move.l	a1,Available_Pointer
	rts

Stuff_Preset_Enemies
; presets in a3
	
	cmp.w	#$ffff,(a3)
	beq.s	preset_enemies_done

	move.w	(a3)+,d2		; character
	move.w	(a3)+,d0		; X position
	move.w	(a3)+,d1		; Y position
	move.w	(a3)+,d3		; special data & mode2 bits
	bsr	Add_An_Enemy

	bra.s	stuff_preset_enemies
preset_enemies_done	
	
	rts

Spawn_Preset_Enemies
; presets in a3
; alienX in d0
; alienY in d1
	
	move.w	d0,d6
	move.w	d1,d7
spawny_loop
	cmp.w	#$ffff,(a3)
	beq.s	spawny_enemies_done
	move.w	(a3)+,d2		; character
	move.w	(a3)+,d0		; X offset
	move.w	(a3)+,d1		; Y offset
	move.w	(a3)+,d3		; Special data and mode bits
	btst.l	#15,d2			; custom needed
	beq.s	no_thanks_custom
	move.l	(a3)+,d4		; custom bit ? nice eh
	
no_thanks_custom
	add.w	d6,d0			; co-ords
	add.w	d7,d1			; co-ords
	bsr	Add_An_Enemy		; stick it in
	bra.s	spawny_loop
spawny_enemies_done	
	move.w	d6,d0
	move.w	d7,d1
	rts

Create_Master_Slave_Chain

; presets in a3
; alienX in d0
; alienY in d1

	clr.w	ms_first_time		; flag for first time through
		
	move.w	d0,d6
	move.w	d1,d7
spawny_loop2
	cmp.w	#$ffff,(a3)
	beq.s	spawny_enemies_done2
	move.w	(a3)+,d2		; character
	move.w	(a3)+,d0		; X offset
	move.w	(a3)+,d1		; Y offset
	move.w	(a3)+,d3		; Special data and mode bits
	btst.l	#15,d2			; custom needed
	beq.s	no_thanks_custom2
	move.l	(a3)+,d4		; custom bit ? nice eh
	
no_thanks_custom2
	add.w	d6,d0			; co-ords
	add.w	d7,d1			; co-ords
	bsr	Add_An_Enemy		; stick it in

	tst.l	Add_Enemy_pointer	; *** Check if it was added
	beq.s	serious_cock_up		; *** If this ever happens 
					; *** The game will look shit!	
	tst.w	ms_first_time
	bne.s	not_first_time

	move.l	a1,Master_Pointer	; ie alien which is generating
	move.w	#1,ms_first_time	; this stuff is the master.
	
not_first_time	
	move.l	a1,-(sp)
	
	move.l	Master_Pointer,a1
	move.l	Add_Enemy_Pointer,d3
	move.l	d3,Alien_Slave_Pointer(a1)	
	
	move.l	(sp)+,a1
					
	move.l	Add_Enemy_Pointer,d3	; last added pointer
	move.l	d3,Master_Pointer	; now becomes the master!
	
	bra.s	spawny_loop2
spawny_enemies_done2
	move.l	Master_Pointer,a3
	clr.l	Alien_Slave_Pointer(a3)	; has now more slaves in chain
serious_cock_up
	move.w	d6,d0
	move.w	d7,d1
	rts

ms_first_time	dc.w	0
Master_Pointer	dc.l	0

Replace_SaveBacks

****************************************************************
* Function : Removes all alien bobs from a double buffered bob *
****************************************************************

DoReplacePrelims
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	DoReplacePrelims
	clr.w	BLTAMOD(a6)			; to a buffer	 		
	MOVE.l	#$09f00000,BLTCON0(a6)		; straight D=A blit
	move.l	#-1,BLTAFWM(a6)			; we want all the bits



	move.l	REPLACE_AREA_BUFFER,a2	; aliens draw at frame-2

Replace_Next_Bob
	cmp.l	#$ffffffff,(a2)		; last alien to erase?
	beq.s	Aliens_Replaced		; yes then exit
	
	move.l	(a2)+,a0			; screen memory pointer
	move.l	(a2)+,a5			; graphics memory pointer
	move.l	(a2)+,a1			; graphics struct pointer
	
WaitforlastReplace
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	WaitforlastReplace
 		
	move.w	Alien_Mod(a1),BLTDMOD(a6)	; copying from the screen

	move.l	Alien_Frame_Size(a1),d2		; 
	move.w	Alien_Height(a1),d3		;
	add.w	d3,d2				; add extra byte
	add.w	d3,d2				; add extra byte for padding
		
	move.w	#4-1,d7			; planes
repl_plane_loop	
replP	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	replP
		
 	MOVE.L	a5,BLTAPTH(a6) 			; a0 graphics on screen
	MOVE.L	a0,BLTDPTH(a6)			; a5 pointer to saveback mem

	MOVE.W	Alien_D_Blit(a1),BLTSIZE(a6)		

	add.l	#BYTES_PER_ROW*SCROLL_HEIGHT,a0
	add.l	d2,a5
		
	dbra	d7,repl_plane_loop
	
	bra.s	Replace_Next_Bob 		; branch for next alien
Aliens_Replaced
	rts
	
*************
Clear_NoSaves

DoClearPrelims
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	DoClearPrelims

	move.w	#-2,BLTAMOD(a6)			; to a buffer
	move.w	#-2,BLTBMOD(a6)			; to a buffer
	clr.w	BLTBDAT(a6)			; sort this bollocks out
	move.l	#$ffff0000,BLTAFWM(a6)			

	move.l	CLEAR_AREA_BUFFER,a2	; aliens draw at frame-2

Clear_Next_Bob
	cmp.l	#$ffffffff,(a2)		; last alien to erase?
	beq.s	Aliens_Replaced		; yes then exit
	
	move.l	(a2)+,a0			; screen memory pointer
	move.l	(a2)+,a5			; mask memory pointer
	move.l	(a2)+,a1			; graphics struct pointer
	move.l	#$00000bca,d0			; disable b (graphics)
	or.w	(a2)+,d0			; or shift
	swap.w	d0				; swap so in order
	MOVE.l	d0,BLTCON0(a6)		

		
Waitforlastclear
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	Waitforlastclear

	move.w	Alien_Mod(a1),BLTCMOD(a6)	; copying from the screen 		
	move.w	Alien_Mod(a1),BLTDMOD(a6)	; copying from the screen

	move.w	#4-1,d7			; planes
clear_plane_loop	
clearP	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	clearP
		
 	MOVE.L	a5,BLTAPTH(a6) 	; mask
* 	MOVE.L  a5,BLTBPTH(a6) 	; graphics	; not used
	move.l	a0,BLTCPTH(a6)	; screen address
	MOVE.L	a0,BLTDPTH(a6)	; screen address

	MOVE.W	Alien_D_Blit(a1),BLTSIZE(a6)		

	add.l	#BYTES_PER_ROW*SCROLL_HEIGHT,a0
		
	dbra	d7,clear_plane_loop
	
	bra.s	Clear_Next_Bob 		; branch for next alien
Aliens_Cleared
	rts


Object_Collision

* This code really needs sorting out so that
* types of aliens which collide are defined 
* correctly. ie We do not wish to kill platforms.

	move.l	#Temporary_Object_List,a0
next_object
	cmp.l	#$ffffffff,(a0)		; end of list?
	beq	object_collision_complete
		
	move.l	(a0)+,a2		
	move.l	Enemy_List,a1			
next_object2
	cmp.l	#$ffffffff,(a1)		; 
	beq	current_object_complete
	move.l	(a1)+,a3		; 
	
	cmp.l	a2,a3			; same object ?
	beq.s	next_object2	
	
	btst.b	#Alien_hit,Alien_Mode(a2)	; object already hit?
	bne.s	next_object2
	btst.b	#Alien_hit,Alien_Mode(a3)	; same again with obj 2
	bne.s	next_object2
** Test Collision Pair **
	move.w	Alien_Number(a2),d0
	move.w	Alien_Number(a3),d1
	mulu.w	#Character_Control_Size,d0
	mulu.w	#Character_Control_Size,d1

	move.l	d0,a4
	add.l	#Character_Control_Block,a4
	move.l	d1,a5
	add.l	#Character_Control_Block,a5

	move.w	Alien_X(a2),d0
	move.w	Alien_Y(a2),d1							
	add.w	Character_Coll_Box_X(a4),d0
	add.w	Character_Coll_Box_Y(a4),d1
	move.w	d0,d2
	move.w	d1,d3	
	add.w	Character_Coll_Box_DX(a4),d2
	add.w	Character_Coll_Box_DY(a4),d3

	
	move.w	Alien_X(a3),d4
	move.w	Alien_Y(a3),d5
	add.w	Character_Coll_Box_X(a5),d4
	add.w	Character_Coll_Box_Y(a5),d5
	move.w	d4,d6
	move.w	d5,d7
	add.w	Character_Coll_Box_DX(a5),d6
	add.w	Character_Coll_Box_DY(a5),d7

	cmp.w	d0,d4
	blt.s	test_x_to_the_lefto
text_x_to_the_righto
	cmp.w	d2,d4
	blt.s	x_in_boxo
	bra	no_object_hit_alien
test_x_to_the_lefto
	cmp.w	d0,d6
	blt	no_object_hit_alien
x_in_boxo
* Y collision
	cmp.w	d1,d5
	blt.s	test_y_aboveo
text_y_belowo
	cmp.w	d3,d5
	blt.s	y_in_boxo
	bra	no_object_hit_alien
test_y_aboveo
	cmp.w	d1,d7
	blt	no_object_hit_alien
	
y_in_boxo	
collision_happened	

	btst.b	#Alien_Object,Alien_Mode2(a3)	; did it hit another object?
	beq.s	hit_an_alien_thats_all_right_then	
	btst.b	#Alien_Platform,Alien_Mode2(a3)	; did it hit a platform
	bne	next_object2			; do something about this shit code	

	move.w 	Repeat_X(a2),d0
	tst.w	d0
	bmi.s	test_left_movement
	cmp.w	Repeat_X(a3),d0
	blt.s	object2wins
	bra.s	object1wins
test_left_movement
	cmp.w	Repeat_X(a3),d0
	bgt.s	object2wins
object1wins
	move.l	Character_Dead(a5),a4
	move.l	a4,Alien_Flight(a3)	; set hit anim
	clr.w	Repeat_Counter(a3)	
	bset.b	#Alien_OffScreen,Alien_Mode(a3)
	bset.b	#Alien_Hit,Alien_Mode(a3)
*	bsr	do_score_chance
	bra	next_object2		
object2wins
		
	move.l	Character_Dead(a4),a4
	move.l	a4,Alien_Flight(a2)	; set hit anim
	clr.w	Repeat_Counter(a2)	
	bset.b	#Alien_OffScreen,Alien_Mode(a2)
	bset.b	#Alien_Hit,Alien_Mode(a2)
*	bsr	do_score_chance
	bra	next_object2


hit_an_alien_thats_all_right_then
	move.l	Character_Hit(a5),a5
	move.l	a5,Alien_Flight(a3)	; set hit anim
	clr.w	Repeat_Counter(a3)	
	bset.b	#Alien_OffScreen,Alien_Mode(a3)
	bset.b	#Alien_Hit,Alien_Mode(a3)
	move.w	#Sound_Slap,sound_chan1

	move.w	d4,d0
	move.w	d5,d1
	bsr	do_score_chance	
	cmp.w	#BaseBall_Character,Alien_Number(a2)
	bne.s	no_baseball
	move.l	Character_Dead(a4),a4
	move.l	a4,Alien_Flight(a2)	; set hit anim
	clr.w	Repeat_Counter(a2)	
	bset.b	#Alien_OffScreen,Alien_Mode(a2)
	bset.b	#Alien_Hit,Alien_Mode(a2)

no_baseball


no_object_hit_alien		
	bra	next_object2
current_object_complete
	bra	next_object
object_collision_complete
	rts



Player_Object_Collision

	tst.w	current_bonus_counter
	beq.s	reset_bonus
	subq.w	#1,current_bonus_counter
	bra.s	its1052
reset_bonus
	move.w	#0,current_bonus
its1052	
	clr.l	Player_Object

	move.l	Enemy_List,a0
	move.l	#Temporary_Object_List,a1
next_player_object
	cmp.l	#$ffffffff,(a0)		; end of list?
	beq	player_object_collision_complete

* Must try to get this out of the loop

	move.w	player_x,d0
	move.w	player_y,d1
	add.w	screen_x_position,d0
	add.w	screen_y_position,d1
	move.w	d0,d2
	move.w	d1,d3
	add.w	#15,d2			; player width
	add.w	#PLAYER_HEIGHT,d3	; player height
	
	move.l	(a0)+,a2		; object1

	move.w	Alien_Number(a2),d4
	mulu.w	#Character_Control_Size,d4
	move.l	d4,a4
	add.l	#Character_Control_Block,a4


	btst.b	#Alien_Platform,Alien_Mode2(a2)
	beq	not_a_platform
** Test Alien Co-ordinates with that of the player

	add.w	#8,d0
	add.w	#PLAYER_HEIGHT,d1			; feet co-ords

	move.w	Alien_X(a2),d4
	move.w	Alien_Y(a2),d5
	add.w	Character_Coll_Box_X(a4),d4
	add.w	Character_Coll_Box_Y(a4),d5
	move.w	d4,d6
	move.w	d5,d7
	add.w	Character_Coll_Box_DX(a4),d6
	add.w	Character_Coll_Box_DY(a4),d7

	cmp.w	d4,d0
	blt.s	no_pl_collision1
	cmp.w	d5,d1
	blt.s	no_pl_collision_test_y
	cmp.w	d6,d0
	bgt.s	no_pl_collision1
	cmp.w	d7,d1
	bgt.s	no_pl_collision1
	bra.s	collision_happened_on_player
no_pl_collision_test_y

*This code checks player cannot fall through platform
	bsr	check_player_fall_onto_platform
	tst	d7
	bne.s	collision_happened_on_player
no_pl_collision1	
	bra.s	nothing_touching_player
	
collision_happened_on_player
; set player y co-ordinate to that of the alien - height of player


	bsr	check_player_on_platform	
	tst	d7
	beq.s	nothing_touching_player	 
player_hit_plat	
	move.b	#0,y_collision_jump_struct+in_air
	move.b	#0,y_collision_fall_struct+in_air
	move.w	#0,player_fall_velocity
	move.w	#0,start_jump
	move.w	#0,player_falling_flag
	move.w	#ACTION_PLAYER_ON_GROUND,player_action

	move.w	d5,d1
	sub.w	#PLAYER_HEIGHT,d1
	sub.w	screen_y_position,d1
	mulu.w	#SCALE_FACTOR,d1
	move.w	d1,player_y_scaled
	move.l	a2,Player_Object		; player object address

	btst.b	#Platform_Activate,Alien_Mode2(a2)
	beq.s	dont_bother
	move.l	Character_Hit(a4),a4
	move.l	a4,Alien_Flight(a2)	; set hit anim
	clr.w	Repeat_Counter(a2)	

dont_bother	

nothing_touching_player
	bra	next_player_object

not_a_platform
	btst.b	#Alien_Hit,Alien_Mode(a2)
	bne	next_player_object

	btst.b	#Alien_Object,Alien_Mode2(a2)
	beq.s	not_an_object
	move.l	a2,(a1)+
not_an_object
	
* is a normal alien so do test for death and also jump on head
	move.w	Alien_X(a2),d4
	move.w	Alien_Y(a2),d5
	add.w	Character_Coll_Box_X(a4),d4
	add.w	Character_Coll_Box_Y(a4),d5
	move.w	d4,d6
	move.w	d5,d7		
	add.w	Character_Coll_Box_DX(a4),d6
	add.w	Character_Coll_Box_DY(a4),d7

	btst.b	#Alien_Bonus,Alien_Mode2(a2)   ; for the baseball shit
	bne.s	no_jump_collision

	cmp.w	#ACTION_PLAYER_FALLING,player_action
	bne.s	no_jump_collision

* Test Jump on alien
	addq.w	#2,d0
	subq.w	#2,d2			; mid of player
	subq.w	#5,d3			; feet box
	cmp.w	d0,d4
	blt.s	jumptest_x_to_the_left	
jumptest_x_to_the_right
	cmp.w	d2,d4
	blt.s	jumpx_in_box
	bra.s	no_jp_collision1	
jumptest_x_to_the_left
	cmp.w	d0,d6
	blt.s	no_jp_collision1
jumpx_in_box
* Y collision				; test Y strip in alien
	cmp.w	d3,d5
	blt.s	jumptest_y_above
jumptest_y_below
	add.w	#5,d3
	cmp.w	d3,d5
	blt.s	player_jumped_on_alien	
	bra.s	no_jp_collision1
jumptest_y_above
	*add.w	#5,d3
	cmp.w	d3,d7
	blt.s	frig_code


	bra	player_jumped_on_alien
			
	*cmp.w	d4,d2
	*blt.s	no_jp_collision1
	*cmp.w	d5,d3
	*blt.s	no_jp_collision1	
	*cmp.w	d6,d2
	*bgt.s	no_jp_collision1
	*cmp.w	d7,d3
	*bgt.s	no_jp_collision1
	*bra	player_jumped_on_alien
frig_code
	*add.w	#5,d3
no_jp_collision1
	subq.w	#2,d0
	addq.w	#2,d2
		
* Test player hit
no_jump_collision
	cmp.w	d0,d4
	blt.s	test_x_to_the_left	
text_x_to_the_right
	cmp.w	d2,d4
	blt.s	x_in_box
	bra.s	no_ob_collision		
test_x_to_the_left
	cmp.w	d0,d6
	blt.s	no_ob_collision
x_in_box
* Y collision
	cmp.w	d1,d5
	blt.s	test_y_above
text_y_below
	cmp.w	d3,d5
	blt.s	y_in_box
	bra.s	no_ob_collision		
test_y_above
	cmp.w	d1,d7
	blt.s	no_ob_collision
	
y_in_box
collision_happened_on_object
	btst.b	#Alien_object,Alien_Mode2(a2)
	beq.s	try_bonus
	bra.s	hit_character_but_not_die
try_bonus	
	btst.b	#Alien_Bonus,Alien_Mode2(a2)
	beq.s	hit_nasty
hit_character_but_not_die
	cmp.w	#GlassBLOCK_CHARACTER,Alien_Number(a2)
	bne.s	dont_bodge_it
	move.w	#Sound_Cowbell,sound_chan1
	bset.b	#Alien_Dead,Alien_Mode(a2)
	move.w	#BASE_BALL,player_holding_object
dont_bodge_it	
	move.l	Character_Hit(a4),a4
	move.l	a4,Alien_Flight(a2)	; set hit anim
	clr.w	Repeat_Counter(a2)	
	bra	next_player_object
hit_nasty
	move.w	#1,player_has_been_hit
	bra	next_player_object
			
no_ob_collision
	bra	next_player_object
	

player_jumped_on_alien
	move.b	#0,y_collision_jump_struct+in_air
	move.b	#0,y_collision_fall_struct+in_air
	move.w	#0,player_fall_velocity
	move.w	#0,start_jump
	move.w	#0,player_falling_flag
	move.w	#0,supress_repeat_jump
	move.w	#1,fire
	tst.w	ydirec
	bmi.s	player_attempting_bum_flatten
	move.w	#Sound_alienhit,sound_chan1
	bra.s	done_player_alien_sounds
player_attempting_bum_flatten	
	move.w	#Sound_bumhit,sound_chan1
	move.w	player_x_velocity,d0
	asl	d0
	move.w	d0,player_x_velocity
*we set both these bits - SPRING as there is code to bypass
*various things if player sitting down - also set BOUNCE so only
*a small jump is perfromed and not a SPRING jump - i.e clear it	
	bset.b	#BOUNCE_FLAG,player_control_bits
	bset.b	#SPRING_FLAG,player_control_bits
done_player_alien_sounds

Set_alien_hit_anim
	move.l	Character_Hit(a4),a4
	move.l	a4,Alien_Flight(a2)	; set hit anim
	clr.w	Repeat_Counter(a2)	
	bset.b	#Alien_OffScreen,Alien_Mode(a2)
	bset.b	#Alien_Hit,Alien_Mode(a2)

	move.w	d4,d0
	move.w	d5,d1
	bsr	do_score_chance
	move.w	d2,d0
	subq.w	#8,d0			; centre star
	move.w	d3,d1
	move.w	#hitstar_character,d2
	bsr	add_an_enemy
	
	bra	next_player_object
	
player_object_collision_complete
	move.l	#$FFFFFFFF,(a1)		; end object list
	rts

do_score_chance
; NOTE: buggers up a5
	tst.w	ydirec
	bpl.s	no_double_bum
	addq.w	#1,current_bonus
no_double_bum

	move.w	#score_character,d2
	bsr	add_an_enemy
	move.l	add_enemy_pointer,a5	
	move.w	current_bonus,frame_number(a5)

	addq.w	#1,current_bonus
check_max_bonus	
	cmp.w	#12,current_bonus
	ble.s	bonus_ok
	move.w	#12,current_bonus
bonus_ok	
	move.w	#50*3,current_bonus_counter
	rts

current_bonus	
	dc.w	1
current_bonus_counter	
	dc.w	0
	
Move_Player_On_Object
	
	move.l	Player_Object,a0
	tst.l	a0
	beq.s	no_object_on
	move.w	Repeat_X(a0),d0
	move.w	Repeat_Y(a0),d1
	mulu.w	#SCALE_FACTOR,d0
	mulu.w	#SCALE_FACTOR,d1
	add.w	d0,player_x_scaled
	add.w	d1,player_y_scaled
no_object_on
	rts
		
Move_Bobs

*******************************************************************
* Function : Handles the movement addition and deletion of aliens *
*            from an existance list 			   	  *
* Limits   : So far this section has the following abilities	  * 
*            Move Absolute/Relative, Speed			  *
* Addition : This routine has been modified to include the Place  *
*	     bob procedure as this was found to be faster 	  *
*******************************************************************

	move.l	Enemy_List,a0		; all aliens to be processed
	move.l	#Alien_Species,a2	; all the varieties
	move.l	OLDBOB_BUFFER,a3	; planes to draw objects
	move.l	CLEAR_LIST_BUFFER,a5	; no saveback objects
	move.l	Enemy_List_Buffer,a4	; pointer for alien list processing
	
New_Bob

*-Next-Alien--------------------------------------------------------------

	cmp.l	#$FFFFFFFF,(a0)		; no aliens left?
	beq	aliens_processed	; yes then wrap up 
	
	move.l	(a0),a1			; alien details

co_ords
	
	move.w	Alien_X(a1),d0		; get last x pos of alien
	move.w	Alien_Y(a1),d1		; get last y pos of alien

	btst.b	#Alien_Dying,Alien_Mode(a1) ; has alien already started to snuff it
*	bne.s	Dont_Move_While_Dying
	bne	dont_move_while_dying
.
	move.w	Screen_X_Position,d2
	move.w	Screen_Y_Position,d3

********************
*no boundary check *
********************
	*bra.s	no_boundary_check
	

no_boundary_check              
	move.l	a4,Last_Alien_in_List
	bsr	Process_Character_Animation	; spawning etc
	move.l	Last_Alien_in_List,a4
	
	btst.b	#Alien_Dead,Alien_Mode(a1)	; remove if finally dead
	bne	Remove_Alien
		
	move.w	d0,Alien_X(a1)		; store new X
	move.w	d1,Alien_Y(a1)		; store new Y
Dont_Move_While_Dying

Movement_Done
	*bra.s	check_screen_visability
; Test for alien returning to map
; NOTE: Only testing x for now, this needs to be updated for 
;       maps which vary in the y axis 

	move.w	Screen_X_Position,d2	
	sub.w	#16*16,d2			; 4 words
	
	cmp.w	d2,d0
	blt.s	out_of_screen_range
	add.w	#16*16+320+16*16,d2			; map window
	cmp.w	d2,d0
	bgt.s	out_of_screen_range
	bra.s	check_screen_visability

out_of_screen_range

	tst.l	Alien_map_pointer(a1)		; has entry in map
	beq.s	no_erase_from_map2		; no then no bother
	bclr.b	#ALIEN_BUSY,([Alien_map_pointer,a1])	; clear busy flag
	bra.s	remove_alien				; and remove alien
	
no_erase_from_map2	

check_screen_visability
	move.w	Screen_X_Position,d2
	move.w	Screen_Y_Position,d3
	
	sub.w	#48,d2				; so it scrolls on smooth
	sub.w	#0,d3				; for use later
	
	cmp.w	d2,d0
	blt.s	NotVisable
	cmp.w	d3,d1
	blt.s	NotVisable

	add.w	#320+48,d2			; window width 
	add.w	#256-16,d3			; for use later
	cmp.w	d2,d0
	bgt.s	NotVisable
	cmp.w	d3,d1
	bgt.s	NotVisable

	sub.w	Screen_X_Position,d0		; get a screen pos	
	add.w	#15,d0				; NASTY
	sub.w	current_scroll_pixel_offset,d0	; SEE GLEN


	*sub.w	Screen_Y_Position,d1	; for the aliens
	
	bsr	Place_Alien		; draw in the alien
	bra.s	Visable
NotVisable
	btst.b	#Alien_OffScreen,Alien_Mode(a1) ; if alien should go now
	beq.s	keep_processing
	tst.l	Alien_map_pointer(a1)	; pos in map
	beq.s	keep_in_map
	clr.b	([Alien_map_pointer,a1])	
keep_in_map
	bra.s	Remove_Alien		     	; best remove it while it
keep_processing
Visable	                     
	move.l	a1,(a4)+			     ; put alien back in 
	bra.s	Alien_Remains
Remove_Alien
	
no_erase_from_map
alien_can_come_back_later	
	
	move.l	available_pointer,a6
	move.l	a1,(a6)+
	move.l	a6,available_pointer

Alien_Remains
	
	addq.l	#$4,a0			; next alien post-box
	bra	New_Bob

aliens_processed	

	move.l	#$ffffffff,(a4)		; end of alien list marker
	move.l	a4,Last_Alien_In_List	; its only polite really
	move.l	#$ffffffff,(a3)		; end of aliens
	move.l	#$ffffffff,(a5)		; end of nosaves
	move.l	#$dff000,a6

	move.l	Enemy_List,a0
	move.l	Enemy_List_Buffer,Enemy_List	; replace list pointer
	move.l	a0,Enemy_List_Buffer		; can be buffer next time
	RTS

Add_An_Enemy
; Send Data d0 - x pos		
; 	    d1 - y pos		
; 	    d2 - character	- corrupt
;	    d3 - Special Data	
;	    Bit 15 in d2 set = Custom pattern in d4

; Then I will do the rest
	
	movem.l	a0-a1,-(sp)

	clr.l	Add_Enemy_Pointer		; for post-add manipulation
	
	move.l	Available_Pointer,a0
	cmp.l	#Available_List,a0		; physically not possible to
	beq	Cant_Add_Alien			; hold more data
	
	move.l	-(a0),a1
	move.l	a0,Available_Pointer		; save new stack pointer

	move.l	Last_Alien_in_List,a0		; 
	move.l	a1,(a0)+			; store new alien pointer
	move.l	a0,Last_Alien_In_List		; store new list pointer
	move.l	#$ffffffff,(a0)			; put new tail marker

	btst.l	#15,d2				; custom pattern to set
	beq.s	no_custom_pattern		; 
	bclr.l	#15,d2
 	move.l	d4,Alien_Flight(a1)		; custom pattern address

	move.w	d2,Alien_Number(a1)		; character type 
	mulu.w	#Character_Control_Size,d2
	move.l	#Character_Control_Block,a0
	add.l	d2,a0
	move.l	Character_Standard(a0),d2	; default animation
	bra.s	custom_was_set

no_custom_pattern
	move.w	d2,Alien_Number(a1)		; character type 
	mulu.w	#Character_Control_Size,d2
	move.l	#Character_Control_Block,a0
	add.l	d2,a0
	move.l	Character_Standard(a0),d2	; default animation

 	move.l	d2,Alien_Flight(a1)		
custom_was_set

	move.w	Character_Flags(a0),d2		; anim flags
	move.w	d2,Alien_Mode(a1)

	move.b	d3,Alien_Data+1(a1)		; only a byte
	*lsr.w	#8,d3				; get top byte
	*move.b	d3,Alien_Mode2(a1)		; use as new mode bits

	clr.w	alien_fall_velocity(a1)	
	move.w	#1,alien_in_air(a1)
	clr.w	Alien_GFX_Number(a1)		
	clr.w	Frame_Number(a1)
	clr.w	Frame_Counter(a1)
	clr.w	Repeat_Counter(a1)
	move.w	d0,Alien_X(a1)
	move.w	d1,Alien_Y(a1)
	
	move.w	#SET,Animation_Mode(a1)
	clr.w	Animation_LoFrame(a1)
	clr.w	Animation_HiFrame(a1)
	clr.w	Animation_Speed(a1)
	clr.w	Animation_Flags(a1)

	move.w	#1,Alien_Hits(a1)		; needs work

	move.l	alien_map_position,alien_map_pointer(a1)
	clr.l	Alien_Slave_Pointer(a1)		; aliens under control
	move.l	a1,add_enemy_pointer
		
Cant_Add_Alien
	movem.l	(sp)+,a0-a1

	rts		

add_enemy_pointer	dc.l	0
alien_map_position	dc.l	0

Place_Alien
	
	move.w	Alien_GFX_Number(a1),d6		; separate to char number
	btst.b	#Alien_Left,Alien_Mode2(a1)
	beq.s	walking_right
	addq.w	#1,d6	
walking_right
	mulu.w	#Graphics_Size,d6			

	move.l	a2,d5				; alien species start
	add.l	d6,d5				; add offset
	move.l	d5,Store_G_Pointer(a1)		; store species pointer
	
	move.l	Alien_Graphics(a2,d6.w),d2	; base of graphics
	move.l	Alien_Mask(a2,d6.w),d3		; mask

	move.l  Alien_Frame_Size(a2,d6.w),d7	

	mulu.w	Frame_Number(a1),d7		; 

	add.l	d7,d2				; get graph pos
	add.l	d7,d3
	
Blit_Graphics
	MOVE.W	D0,D6
	AND.W	#$000F,D0
	AND.w	#$FFF0,D6			
	ASR.w	#3,D6				
	ext.l	d6				; could be negative so make long
	ROR.W	#4,D0
	move.w	d0,d7
	OR.W	#$0fca,d0
	swap	d0
	move.w	d7,d0
	mulu.w	#BYTES_PER_ROW,d1

SORT_OUT_GRAPHICS

	ADD.l	d1,D6

	add.l	scroll_plane_position,d6
	
	MOVE.L	d6,Store_Destination(a1)	; destination
	move.l	d3,Store_Mask(a1)		; alien mask
	move.l	d0,Store_Shift(a1)	; shift bits
	move.l	a1,Store_Pointer(a1)	; alien pointer
	move.l	d2,Store_Graphics(a1)	; graphics pointer

***
*** Use this for separating on screen lists ? objects/aliens etc.
***	
	btst.b	#No_Saveback,Alien_Mode(a1) ; is it a friendly or ex
	bne.s	dont_save
	
	move.l	a1,(a3)+

	bra.s	saved_as_required
dont_save
	move.l	a1,(a5)+		
	
saved_as_required
	rts
	

Process_Character_Animation
	move.l	a2,-(sp)			; need this

	move.l	Alien_Flight(a1),a2

** Do frame Animation

	cmp.w	#FLIP,Animation_Mode(a1)	; is it flip frame?
	bne.s	no_flip_frame
		
	tst.w	Frame_Counter(a1)
	beq.s   reset_frame_counter
	subq.w	#1,Frame_Counter(a1)
	bra.s	Done_flip_Frame
reset_frame_counter
	move.w	Animation_Speed(a1),d4	
	move.w	d4,Frame_Counter(a1)

	move.w	Frame_Number(a1),d4
	tst.w	Animation_Flags(a1)		; going up or down?
	bne.s	flip_down
	addq.w	#1,d4
	cmp.w	Animation_HiFrame(a1),d4	; reached topframe?
	bne.s	set_new_frame
	move.w	#-1,Animation_Flags(a1)		; set down frame
	bra.s	set_new_frame
flip_down
	subq.w	#1,d4	
	cmp.w	Animation_LoFrame(a1),d4	; reached lowframe?
	bne.s	set_new_frame
	move.w	#0,Animation_Flags(a1)
set_new_frame
	move.w	d4,Frame_Number(a1)
	bra.s	done_flip_frame
no_flip_frame
	
	cmp.w	#CYCLE,Animation_Mode(a1)	; is it cycle frame?
	bne.s	no_cycle_frame
			
	tst.w	Frame_Counter(a1)
	beq.s   reset_CYCLE_frame
	subq.w	#1,Frame_Counter(a1)
	bra.s	Done_cycle_Frame
reset_CYCLE_frame

	move.w	Animation_Speed(a1),d4	
	move.w	d4,Frame_Counter(a1)
	move.w	Frame_Number(a1),d4
	cmp.w	Animation_HiFrame(a1),d4
	bne.s	cycle_frame_ok
	move.w	Animation_LoFrame(a1),d4
	bra.s	set_cycle_frame	
cycle_frame_ok
	addq.w	#1,d4
set_cycle_frame	
	move.w	d4,Frame_Number(a1)

no_cycle_frame
done_flip_frame
done_cycle_frame
no_set_frame
	
	tst.w	Repeat_Counter(a1)		; is movement in repeat?
	beq.s	no_repeat_mode

	move.w	Repeat_X(a1),d4
	move.w	Repeat_Y(a1),d5
	bsr	Add_Object_Deltas

	subq.w	#1,Repeat_Counter(a1)		; decrement the counter
	bra	repeat_increments
no_repeat_mode	
check_command
	cmp.w	#FIRST_COMMAND,(a2)
	blt.s	no_new_command
	cmp.w	#LAST_COMMAND,(a2)
	bgt.s	no_new_command
	
	move.w	(a2)+,d4
	sub.w	#FIRST_COMMAND,d4
	move.l	#Command_Pointers,a6
	move.l	(a6,d4.w*4),a6
	
	jsr	(a6)
	bra.s	check_command		; DANGER of infinite loop	
	
no_new_command		

******************
* Move Character *
******************

	tst.w	Repeat_Counter(a1)		; in case was set this time
	bne.s	repeat_increments
	
	move.w	(a2)+,d4
	move.w	(a2)+,d5
	
	move.w	d4,Repeat_X(a1)		; for player on object
	move.w	d5,Repeat_Y(a1)
	
	bsr	Add_Object_Deltas
	
	cmp.w	#BaseBall_Character,Alien_Number(a1)
	bne.s	repeat_increments
repeat_increments
	cmp.w	#BaseBall_Character,Alien_Number(a1)
	bne.s	dont_do_ball
	btst.b	#Alien_Hit,Alien_Mode(a1)
	bne.s	dont_do_ball
	movem.l	d3-d6/a0/a1/a3/a4,-(sp)	
	move.w	Alien_Number(a1),d2		; character type 
	mulu.w	#Character_Control_Size,d2
	move.l	#Character_Control_Block,a0
	add.l	d2,a0
	bsr	BaseBall_Collision		; a2 gets set if ball hits block
	movem.l	(sp)+,d3-d6/a0/a1/a3/a4

	
dont_do_ball

	btst.b	#Ground_Collision,Alien_mode(a1)
	beq.s	animation_done	
	movem.l	d3-d6/a0-a4,-(sp)	
	move.w	Alien_Number(a1),d2		; character type 
	mulu.w	#Character_Control_Size,d2
	move.l	#Character_Control_Block,a0
	add.l	d2,a0
	bsr	alien_ground_collision
	movem.l	(sp)+,d3-d6/a0-a4
	
animation_done
	move.l	a2,Alien_Flight(a1)		; store new pointer

	move.l	(sp)+,a2			; restore
	rts	

Add_Object_Deltas
; Co-ords in d0,d1, alien pointer in a1
; delta-X in d4, delta-Y in d5

	btst.b	#Alien_Left,Alien_Mode2(a1)	; is it going left
	beq.s	delta_x_going_right
	neg.w	d4				; could add to a few more
delta_x_going_right
	
	add.w	d4,d0				; add x delta to co-ord
	add.w	d5,d1				; add y delta to co-ord

	btst.b	#Alien_Master,Alien_Mode2(a1)
	beq.s	no_master_required
	
	movem.l	a1,-(sp)
slave_loop
	tst.l	Alien_Slave_Pointer(a1)
	beq.s	slaves_done
	move.l	Alien_Slave_Pointer(a1),a1
	add.w	d4,Alien_X(a1)
	add.w	d5,Alien_Y(a1)	
	bra.s	slave_loop
slaves_done	
	movem.l	(sp)+,a1
no_master_required	
	rts
	
Command_Pointers
	dc.l	Restart_Command
	dc.l	Flip_Command
	dc.l	Cycle_Command
	dc.l	Set_Command
	dc.l	Repeat_Command
	dc.l	Spawn_Command
	dc.l	Mode_Set_Command
	dc.l	Mode_Clear_Command
	dc.l	GFX_Command
	dc.l	spring_block		; glens code
	dc.l	freeze_command
	dc.l	dog_talk 
	dc.l	Cast_Master_Slaves
	dc.l	command_slaves_command
	dc.l	new_anim_command	
	dc.l	activate_fruit_block    ; glens code
Restart_Command
	move.l	(a2),a2			; get address of start
	rts

Flip_Command			
	move.w	#FLIP,Animation_Mode(a1)
	bra.s	flip_params
Cycle_Command
	move.w	#CYCLE,Animation_Mode(a1)
flip_params
	move.w	(a2)+,d5
	move.w	d5,Animation_LoFrame(a1)
	move.w	d5,Frame_Number(a1)
	move.w	(a2)+,Animation_HiFrame(a1)
	move.w	(a2)+,d4
	move.w	d4,Animation_Speed(a1)
	move.w	d4,Frame_Counter(a1)
	clr.w	Animation_Flags(a1)
	rts

SET_command
	move.w	#SET,Animation_Mode(a1)		; "SET" keyword
	move.w	(a2)+,Frame_Number(a1)		; Frame to set
	rts		


Mode_Set_Command
	move.w	(a2)+,d4			; get mode bits
	or.w	d4,Alien_Mode(a1)		; and then set them
	rts

Mode_Clear_Command
	move.w	(a2)+,d4			; get mode bits
	not.w	d4				; invert the bits
	and.w	d4,Alien_Mode(a1)		; and then clear them
	rts
		
GFX_Command
	move.w	(a2)+,d4			; get new graphics
	move.w	d4,Alien_GFX_Number(a1)		; and set it
	rts
		

Spawn_command
	move.l	a3,-(sp)
	move.l	(a2)+,a3			; list of aliens to spawn
	bsr	spawn_preset_enemies		; oh no loops
	move.l	(sp)+,a3			; restore ol faithful
	rts
	
Repeat_command
	move.w	(a2)+,d4
	move.w	d4,Repeat_X(a1)		 
	move.w	(a2)+,d5
	move.w	d5,Repeat_Y(a1)

	cmp.w	#DATA,(a2)			; is it special data
	bne.s	not_special_data
	move.w	Alien_Data(a1),Repeat_Counter(a1)
	addq.l	#2,a2				; add on index 
	bra.s	special_data
not_special_data
	move.w	(a2)+,Repeat_Counter(a1)
special_data

	bsr	Add_Object_Deltas
	rts		

freeze_command	
	move.b	player_control_bits,d4
	bchg	#stuck_flag,d4
	move.b	d4,player_control_bits
	rts

dog_talk
	move.l  (a2)+,d4			; talk pointer
	bsr	character_speak
	rts

Cast_Master_Slaves
	move.l	a3,-(sp)
	move.l	(a2)+,a3			; list of aliens to spawn
	bsr	create_master_slave_chain	; oh no loops
	move.l	(sp)+,a3			; restore ol faithful
	rts

Command_Slaves_Command

	move.w	(a2)+,d4
	sub.w	#FIRST_COMMAND,d4
	move.l	#Command_Pointers,a6
	move.l	(a6,d4.w*4),a6

	move.l	Alien_Slave_Pointer(a1),d4
	tst.l	d4				; check before entering loop
	beq.s	no_slaves_ooh

	movem.l	a1/d0-d1,-(sp)
	move.l	d4,a1				; for first pass
slave_command_loop
	tst.l	a1
	beq.s	done_slave_commands		; should only call
						; routines which 
						; set structure data! ie. a1
							
	move.l	a2,-(sp)			; save master anim pointer
	jsr	(a6)				; call anim routine
	move.l	a2,d3				; save pointer to next
						; command for master
	move.l	(sp)+,a2			; restore pointer for next

	move.l	Alien_Slave_Pointer(a1),a1	; for next loop
	bra.s	slave_command_loop	
done_slave_commands
	move.l	d3,a2				

	movem.l	(sp)+,a1/d0-d1
no_slaves_ooh	
	rts

; SLAVE ONLY commands
	
new_anim_command
	move.l	(a2)+,Alien_Flight(a1)
	rts
		
Store_NoSaves
	move.l	CLEAR_LIST_BUFFER,a2
	move.l	CLEAR_AREA_BUFFER,a5	; objects which clear


Store_Next_Bob
	cmp.l	#$ffffffff,(a2)		; last alien to save?
	beq.s	Aliens_stored		; yes then exit

	move.l	(a2)+,a4
	move.l	Store_G_Pointer(a4),a1
	move.l	Store_Destination(a4),a0

	btst.b	#Alien_Burn,Alien_Mode(a4)	; leave it in scroll?
	beq.s	do_clear_save
	btst.b	#Alien_Burn2,Alien_Mode(a4)
	bne.s	ok_really_burned
	bset.b	#Alien_Burn2,Alien_Mode(a4)
	bra.s	store_next_bob
ok_really_burned
	bset.b	#Alien_Dead,Alien_mode(a4)	; set dead
	bra.s	store_next_bob			; dont erase it	
do_clear_save	
	move.l	a0,(a5)+			; screen memory pointer
	move.l	Store_Mask(a4),(a5)+		; graphics memory pointer
	move.l	a1,(a5)+			; graphics struct pointer
	move.l	Store_Shift(a4),d0		; get shift
	move.w	d0,(a5)+			; only want pure shift		
	
	bra.s	store_next_bob
aliens_stored
	move.l	#$ffffffff,(a5)			; end the clear list
	rts	
	

SaveBack_Enemies

	move.l	SAVEBACK_BUFFER,d5	; an address count of saveback graphics
	move.l	OLDBOB_BUFFER,a2
	move.l	REPLACE_AREA_BUFFER,a3	; objects which saveback

PreSaveSetup
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	PreSaveSetup
        move.l	#-1,BLTAFWM(a6)		; all data stored
	clr.w	BLTDMOD(a6)		; to a buffer
	MOVE.l	#$09f00000,BLTCON0(a6)		; straight D=A blit

Save_Next_Bob
	cmp.l	#$ffffffff,(a2)		; last alien to save?
	beq	Aliens_Saved		; yes then exit

	move.l	(a2)+,a4
	move.l	Store_G_Pointer(a4),a1
	move.l	Store_Destination(a4),a0

* Save parameters in replace list first

save_required
	move.l	a0,(a3)+			; screen memory pointer
	move.l	d5,(a3)+			; graphics memory pointer
	move.l	a1,(a3)+			; graphics struct pointer

Waitforlastsave
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	Waitforlastsave
 		
	move.w	Alien_Mod(a1),BLTAMOD(a6)	; copying from the screen

	move.l	Alien_Frame_Size(a1),d2		; 
	move.w	Alien_Height(a1),d3		;
	add.w	d3,d2				; add extra byte
	add.w	d3,d2				; add extra byte for padding
		
	move.w	#4-1,d7				; planes
save_plane_loop	
saveP	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	saveP
		
 	MOVE.L	a0,BLTAPTH(a6) 			; a0 graphics on screen
	MOVE.L	d5,BLTDPTH(a6)			; d5 pointer to saveback mem

	MOVE.W	Alien_D_Blit(a1),BLTSIZE(a6)		

	add.l	#BYTES_PER_ROW*SCROLL_HEIGHT,a0
	add.l	d2,d5
		
	dbra	d7,save_plane_loop
	bra	Save_Next_Bob
Aliens_Saved
	move.l	#$ffffffff,(a3)			; end the saveback list
	rts	
	
	
Draw_Enemies_In
	move.l	OLDBOB_BUFFER,a2		; aliens draw at frame-2
	bsr.s	Draw_New_Bobs
	rts

Draw_NoSaves
	move.l	CLEAR_LIST_BUFFER,a2
	bsr.s	Draw_New_Bobs
	rts
	

Draw_New_Bobs

PreDrawSetup

	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	PreDrawSetup
        move.l	#$FFFF0000,BLTAFWM(a6)	; mask off last word
	move.w	#-2,BLTAMOD(a6)
	move.w	#-2,BLTBMOD(a6)
	
Draw_Next_Bob
	cmp.l	#$ffffffff,(a2)		; last alien to draw?
	beq	Aliens_Drawn		; yes then exit

	move.l	(a2)+,a4
	move.l	Store_G_Pointer(a4),a1
	move.l	Store_Destination(a4),a0

WaitforlastDraw
	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	WaitforlastDraw
 		
	move.w	Alien_Mod(a1),BLTCMOD(a6)	
	move.w	Alien_Mod(a1),BLTDMOD(a6)
	
 	MOVE.L	Store_Mask(a4),d2 	
 	MOVE.L  Store_Graphics(a4),d3	
	MOVE.l	Store_Shift(a4),BLTCON0(a6)

	move.w	#4-1,d7			; planes
enemy_plane_loop	
DrawP	BTST	#DMAB_BLTDONE-8,DMACONR(a6)
	BNE.s	DrawP
		
 	MOVE.L	d2,BLTAPTH(a6) 	; mask
 	MOVE.L  d3,BLTBPTH(a6) 	; graphics
	move.l	a0,BLTCPTH(a6)	; screen address
	MOVE.L	a0,BLTDPTH(a6)	; screen address

	MOVE.W	Alien_D_Blit(a1),BLTSIZE(a6)		

	add.l	#BYTES_PER_ROW*SCROLL_HEIGHT,a0
	add.l	Alien_Plane_Size(a1),d3
		
	dbra	d7,enemy_plane_loop
	
	bra	Draw_Next_Bob
Aliens_Drawn
	rts
