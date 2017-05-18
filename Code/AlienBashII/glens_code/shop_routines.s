	
BORDER_SPRITE_HEIGHT	EQU	61
BORDER_SPRITE_WIDTH	EQU	60

PRODUCT_LIST_WINDOW_LENGTH	EQU 	(2+2+8)*9

SHOP_SPRITES_LENGTH	EQU	16128

**********************************************
***      OPEN SHOP                         ***
**********************************************
Open_Shop


	bsr	Clear_Channels	
	bsr	Set_Up_All_Gun_Levels
	
	clr.w	box
	clr.b	nasty_user
	move.w	#BORDER_START_X,box_x_pos
	move.w	#BORDER_START_Y,box_y_pos

	bsr	Copy_Shop_Sprites
	bsr	Load_Shop_Screen_Tune
	bsr	Load_Shop_Picture
	
	bsr	Mt_Init
	move.w	#1,Music_Flag
		
	move.l	#shop_cols1+2,a0
	bsr	Insert_Cols
				
	move.l	memory_base,d0
	move.w	d0,ShopPlane1_Lo
	swap	d0
	move.w	d0,ShopPlane1_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,ShopPlane2_Lo
	swap	d0
	move.w	d0,ShopPlane2_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,ShopPlane3_Lo
	swap	d0
	move.w	d0,ShopPlane3_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0
	move.w	d0,ShopPlane4_Lo
	swap	d0
	move.w	d0,ShopPlane4_Hi
	swap	d0
	add.l	#LO_RES_PLANE,d0	
	move.w	d0,ShopPlane5_Lo
	swap	d0
	move.w	d0,ShopPlane5_Hi
	
	
	move.w	#40,text_bpr
	bsr	Set_Up_Product_List_Memory
	bsr	Set_Up_Product_List	;strings in mem

	add.l	#9*40,product_list_ptr
	
	bsr	Insert_Product_List_Ptr

	
		
	
	move.w	#27-1,d0
	move.w	#$a801,d3
	move.l	#product_cols,a0
	move.l	#product_list_cols,a1
fill_colours

	move.w	#$1a0,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1a2,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1a4,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1a6,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1a8,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1aa,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1ac,(a0)+
	move.w	(a1),(a0)+
	move.w	#$1ae,(a0)+
	move.w	(a1)+,(a0)+
	
	add.w	#$0100,d3
	move.w	d3,(a0)+
	move.w	#$fffe,(a0)+
	
	dbra	d0,fill_colours
		
	move.l	memory_base,d0
	add.l	#LO_RES_PLANE*4,d0
	add.l	#40*(151),d0
	move.w	d0,RestorePlane5_Lo
	swap	d0
	move.w	d0,RestorePlane5_Hi

	move.w	#8-1,d1
	move.l	#shop_cols1+(16*4)+2,a0
	move.l	#restore_cols,a1
	move.w	#$1a0,d0
restore_cols_loop	
	move.w	d0,(a1)+
	move.w	(a0),(a1)+
	add.w	#$2,d0
	addq.l	#4,a0
	dbra	d1,restore_cols_loop		
	
	bsr	Display_Border
	bsr	Insert_Sprite_Data
	jsr	Sync
	move.l	#shop_copper,cop1lch(a6)
	clr.w	copjmp1(a6)
	move.w	#$8000+BIT_PLANE_DMA+SPRITE_DMA,dmacon(a6)
	bsr	Display_Cash_Amount
Shop_Loop
	jsr	Sync
	bsr	Insert_Product_List_Ptr
	bsr	Display_Border
	bsr	Insert_Sprite_Data
	tst.w	Cash_Update_Counter
	beq.s	User_Not_Purchased
	addq.w	#1,current_spr_frame
	andi.w	#$7,current_spr_frame
	move.w	current_item_diff,d0
	sub.w	d0,cash
	subq.w	#1,Cash_Update_Counter	
	bne.s	not_final_update
	move.w	new_cash_amount,cash
not_final_update	
	bsr	Remove_Old_Cash
	bsr	Display_Cash_Amount	
	bra.s	Shop_Loop
User_Not_Purchased	
	bsr	Get_Stick_Readings
	bsr	Test_Buy_Item
	tst	d0
	bne.s	shop_fin
	bsr	Move_Box
	bra.s	Shop_Loop
Shop_Fin
	jsr	Sync
	bsr	Display_Border
	bsr	Insert_Sprite_Data
	addq.w	#1,current_spr_frame
	andi.w	#$7,current_spr_frame
	subq.w	#1,master_volume
	bne.s	Shop_Fin
	bsr	Wait_For_Blit_To_Finish
	clr.w	Music_Flag
	bsr	Mt_End
	move.w	#BIT_PLANE_DMA,dmacon(a6)
	move.w	#NEXT_LEVEL,Schedule_Entry
	rts

****************************************
****    COPY SHOP SPRITES       ********
****************************************
Copy_Shop_Sprites
	move.l	memory_base,a0
	add.l	#(LO_RES_PLANE*5)+40*PRODUCT_LIST_WINDOW_LENGTH,a0
	move.l	a0,sprite_base
	move.l	#Spr_Box_Data,a1
	move.w	#(SHOP_SPRITES_LENGTH/2)-1,d0
copy_spr_data
	move.w	(a1)+,(a0)+
	move.w	(a1)+,(a0)+
	dbra	d0,copy_spr_data
	rts

	
BORDER_START_X	EQU	34
BORDER_START_Y	EQU	90-16-9-1	
BORDER_START_Y2	EQU	150-1-1
BORDER_X_DIST	EQU	64
	
****************************************
****    INSERT SPRITE DATA      ********
****************************************
Insert_Sprite_Data

	move.l	sprite_base,d0
	
	move.w	current_spr_frame,d1
	mulu	#(BORDER_SPRITE_HEIGHT+2)*4*8,d1
	add.l	d1,d0

	move.w	d0,shsprite0l
	swap	d0
	move.w	d0,shsprite0h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite1l
	swap	d0
	move.w	d0,shsprite1h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite2l
	swap	d0
	move.w	d0,shsprite2h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite3l
	swap	d0
	move.w	d0,shsprite3h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0		
	move.w	d0,shsprite4l
	swap	d0
	move.w	d0,shsprite4h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite5l
	swap	d0
	move.w	d0,shsprite5h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite6l
	swap	d0
	move.w	d0,shsprite6h
	swap	d0
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,d0
	move.w	d0,shsprite7l
	swap	d0
	move.w	d0,shsprite7h	
	
	rts	

current_spr_frame
	dc.w	0

current_spr_dir
	dc.w	0
	
	
****************************************
****        DISPLAY_BORDER      ********
****************************************
Display_Border

	move.w	box_x_pos,d0
	move.w	box_y_pos,d1

	
	move.l	sprite_base,a0
	move.w	current_spr_frame,d2
	mulu	#(BORDER_SPRITE_HEIGHT+2)*4*8,d2
	add.l	d2,a0

	move.w	#BORDER_SPRITE_HEIGHT,d2
	
	
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)

	
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
	
	
	add.w	#16,d0
	
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
		

	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
	
	
	add.w	#16,d0
	
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)

	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
	

	add.w	#16,d0
	
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
	
	add.l	#(BORDER_SPRITE_HEIGHT+2)*4,a0
	movem.l	d0-d1,-(sp)
	jsr	Position_Any_Sprite
	movem.l	(sp)+,d0-d1
	bset.b	#ATTACH,3(a0)
	
	
	rts	
		
	
****************************************
****           MOVE BOX         ********
****************************************
Move_Box

	tst.b	nasty_user
	bne	update_slide_box_to_option
box_stopped
	tst	xdirec
	beq.s	test_box_y
	bpl.s	right_box
	tst	box
	beq	box_not_moved
	cmp.w	#4,box
	beq	box_not_moved
	subq.w	#1,box
	move.w	#-1,move_box_dir
	move.b	#1,nasty_user
	bra	slide_box_to_option
right_box
	cmp.w	#3,box
	beq.s	box_not_moved
	cmp.w	#7,box
	beq.s	box_not_moved	
	addq.w	#1,box
	move.w	#1,move_box_dir
	move.b	#1,nasty_user
	bra	slide_box_to_option
test_box_y
	tst	ydirec
	beq.s	box_not_moved
	bpl.s	move_box_up
	cmp.w	#4,box
	bge.s	box_not_moved
	addq.w	#4,box
	move.b	#1,nasty_user
	move.w	#2,move_box_dir
	bra.s	slide_box_to_option
move_box_up
	cmp.w	#3,box
	ble.s	box_not_moved
	subq.w	#4,box	
	move.b	#1,nasty_user	
	move.w	#-2,move_box_dir
	bra.s	slide_box_to_option
box_not_moved
	rts
slide_box_to_option
	move.w	move_box_dir,d0
	bpl.s	dont_negb
	neg	d0
dont_negb
	cmp.w	#2,d0
	blt.s	x_slide
	move.w	#84/12,box_dist
	move.w	#12,box_offset
	
	move.w	#((9*4)/7)+1,prod_dist	;num pixels per movement	
	
	bra.s	update_slide_box_to_option
x_slide				
	move.w	#2,prod_dist		;num pixels per movement
	move.w	#64/8,box_dist
	move.w	#8,box_offset
	tst	move_box_dir
	bmi.s	sld_rght
	move.w	#8,current_spr_frame
	move.w	#-1,current_spr_dir
	bra.s	update_slide_box_to_option
sld_rght
	clr.w	current_spr_frame
	move.w	#1,current_spr_dir
update_slide_box_to_option	
	move.w	box_offset,d0
	move.w	prod_dist,d2
	cmp.w	#2,d2
	beq.s	alter_prod_dist
	cmp.w	#6,d2
	beq.s	alter_prod_dist
	bra.s	skip_prod_dist
alter_prod_dist	
	sub.w	#1,prod_dist		;fix
skip_prod_dist	

	move.w	move_box_dir,d1
	bpl.s	slide_pos
	neg.w	d0
	neg.w	d2
	neg.w	d1
slide_pos

*for planes
	muls	#40,d2
	add.l	d2,product_list_ptr
*****	

	cmp.w	#2,d1
	beq.s	slide_y_update
	add.w	d0,box_x_pos
	move.w	current_spr_dir,d0
not_last_spr_frame	
	add.w	d0,current_spr_frame
	cmp.w	#8,current_spr_frame
	bne.s	test_other_spr_frame
	clr.w	current_spr_frame	
test_other_spr_frame
	cmp.w	#-1,current_spr_frame
	bne.s	test_end_slide
	clr.w	current_spr_frame
	bra.s	test_end_slide		
slide_y_update
	add.w	d0,box_y_pos
test_end_slide
	subq.w	#1,box_dist
	beq.s	end_slide		
	rts
end_slide
	clr.b	nasty_user
	rts	

cash_update_counter	dc.w	0
move_box_dir	dc.w	0
box_dist	dc.w	0
box_offset	dc.w	0
****************************************
****     REMOVE OLD CASH        ********
****************************************
Remove_Old_Cash

	btst	#14,dmaconr(a6)
	bne.s	Remove_Old_Cash
	clr.w	bltadat(a6)
	move.l	memory_base,a0
	add.l	#LO_RES_PLANE*4,a0
	move.w	#CASH_Y,d0
	mulu	#40,d0
	add.l	d0,a0
	move.w	#CASH_X,d0
	andi.w	#$fff0,d0
	asr	#3,d0
	ext.l	d0
	add.l	d0,a0
	
	move.l	a0,bltdpth(a6)
	move.w	#40-CASH_WORDS*2,bltdmod(a6)
	move.l	#$01f00000,bltcon0(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	#(MALFONT_HEIGHT-9)<<6+CASH_WORDS,bltsize(a6)
	rts




	
ITEM_PRICE_X	EQU	138
ITEM_PRICE_Y	EQU	123+18

ITEM_PRICE_WORDS EQU	3

ITEM_DESC_X	EQU	113
ITEM_DESC_Y	EQU	123
ITEM_DESC_WORDS EQU	6

CASH_X		EQU	192
CASH_Y		EQU	221
CASH_WORDS	EQU	3
	
	
****************************************
****    DISPLAY CASH AMOUNT     ********
****************************************
Display_Cash_Amount


	move.w	cash,d0
	move.l	#cash_price,a0
	bsr	Convert_Num_To_String
	
	move.w	#CASH_X,d0
	move.w	#CASH_Y,d1
	move.l	memory_base,a3
	add.l	#LO_RES_PLANE*4,a3
	move.l	#Cash_price,a4
	bsr	Display_String
	rts	

****************************************
****      CONVERT NUM TO STRING ********
****************************************
Convert_Num_To_String
*send num in d0
*send pointer to mem in a0

	clr.w	d7

	ext.l	d0
	move.l	#10000,d1
convert_word_loop
	divu	d1,d0
	move.w	d0,d2	;units
	clr.w	d0
	swap	d0
	
	tst.b	d2
	bne.s	not_a_zero
	tst.w	d7
	bne.s	not_a_zero
	move.b	#' ',(a0)+
	bra.s	carry_on_couting
not_a_zero	
	moveq.w	#1,d7
	add.b	#'0',d2
	move.b	d2,(a0)+
carry_on_couting	
	cmp.w	#1,d1
	beq.s	done_word_convert
	divu	#10,d1
	bra.s	convert_word_loop
done_word_convert		
	rts	


	
long_num_vals
	dc.l	10000000
	dc.l	1000000
	dc.l	100000
	dc.l	10000
	dc.l	1000
	dc.l	100
	dc.l	10
	dc.l	1				
	
****************************************
****       SET UP SHOP PRICES   ********
****************************************
Set_Up_Shop_Prices
	move.l	#default_shop_prices,a0
	move.l	#game_shop_prices,a1
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	rts


****************************************
****        TEST BUY ITEM       ********
****************************************
Test_Buy_Item

	tst.b	nasty_user
	bne.s	quit_buy
	tst.w	fire
	beq.s	quit_buy

	cmp.w	#7,box
	beq.s	player_exit
	
*Test if player has enough money		

	move.l	#game_shop_prices,a0
	moveq	#0,d0
	move.w	box,d0
	asl	d0
	move.w	(a0,d0),d0
	move.w	d0,current_item_price
	cmp.w	cash,d0
	bgt.s	quit_buy
	
	move.l	#purchase_code,a0
	move.w	box,d0
	ext.l	d0
	asl	#2,d0
	move.l	(a0,d0),a0
	jsr	(a0)
	tst.w	d0
	bne.s	quit_buy
	move.w	cash,new_cash_amount
	clr.l	d0
	move.w	current_item_price,d0
	sub.w	d0,new_cash_amount
	move.w	#8*3,cash_update_counter	
	divu.w	#24,d0		;div factor
	move.w	d0,current_item_diff
quit_buy	
	moveq	#0,d0
	rts
player_exit
	moveq	#1,d0
	rts
		
box	dc.w	0
current_item_price	dc.w	0
current_item_diff	dc.w	0
new_cash_amount		dc.w	0


	
purchase_code
	dc.l	Power_Up_Grenade
	dc.l	Power_Up_Rocket
	dc.l	Add_Energy_Module
	dc.l	Gun_Power_Up
	dc.l	Add_Grenade_Pack
	dc.l	Add_Rocket_Pack
	dc.l	fill_up_energy

	
**************************************
***     POWER UP GRENADE          ****
**************************************	
Power_Up_Grenade
	cmp.w	#2,grenade_level
	beq.s	max_grenade_power
	addq.w	#1,grenade_level
	move.l	#game_shop_prices,a0
	cmp.w	#2,grenade_level
	beq.s	maxxed_gren	
	add.w	#500,grenade_price(a0)
	bsr	Set_Up_Grenade_Level_Num
	bra.s	Re_Do_Gren_Line
maxxed_gren	
	move.w	#-1,grenade_price(a0)
Re_Do_Gren_Line
	bsr	Re_Do_Product_Line
	clr.w	d0		;indicate item purchased
	rts
max_grenade_power
	move.w	#1,d0	
	rts
	
**************************************
***     POWER UP ROCKET           ****
**************************************	
Power_Up_Rocket

	cmp.w	#2,rocket_level
	beq.s	max_rocket_power
	addq.w	#1,rocket_level
	move.l	#game_shop_prices,a0
	cmp.w	#2,rocket_level
	blt.s	rock_not_maxxed
	move.w	#-1,rocket_price(a0)
	bra.s	Re_Do_Rock_Line
rock_not_maxxed	
	add.w	#500,rocket_price(a0)
	bsr	Set_Up_Rocket_Level_Num
Re_Do_Rock_Line
	bsr	Re_Do_Product_Line
	clr.w	d0
	rts
max_rocket_power	
	move.w	#1,d0
	rts
	
**************************************
***     FILL UP ENERGY            ****
**************************************
fill_up_energy

	move.w	player_energy_limit,d1
	cmp.w	player_current_energy,d1
	beq.s	cant_buy_full_up
	add.w	#NUMBER_HITS_PER_UNIT*4,player_current_energy
	cmp.w	player_current_energy,d1
	bgt.s	energy_not_maxxed
	move.w	player_energy_limit,player_current_energy
energy_not_maxxed
	bsr	Set_Up_Energy_Num
	bsr	Re_Do_Product_Line
	clr.w	d0
	rts
cant_buy_full_up
	move.w	#1,d0
	rts	
	
**************************************
***     ADD ENERGY MODULE         ****
**************************************
Add_Energy_Module

	cmp.w	#4,current_energy_modules
	beq.s	energy_modules_max
	addq.w	#1,current_energy_modules
	bsr	Set_Up_Energy_Modules_Num
	bsr	Set_Up_Energy_Num
	move.l	#game_shop_prices,a0
	cmp.w	#4,current_energy_modules
	beq.s	Energy_Maxxed
	add.w	#1000,extra_module_price(a0)
	bra.s	Re_Do_Energy_Line
Energy_Maxxed
	move.w	#-1,extra_module_price(a0)	
Re_Do_Energy_Line		
	bsr	Re_Do_Product_Line
	bsr	Frig_Energy_Update
	clr.w	d0
	rts
energy_modules_max	
	move.w	#1,d0
	rts

**************************************
***      GUN POWER UP             ****
**************************************
Gun_Power_Up
	move.l	#game_shop_prices,a0
move_gun_up_power
	cmp.w	#STANDARD_GUN_TRIPLE,gun_type
	beq.s	gun_max_power
	addq.w	#4,gun_type
	cmp.w	#STANDARD_GUN_TRIPLE,gun_type
	beq.s	gun_maxxed
	add.w	#2000,gun_power_price(a0)
	bsr	Set_Up_Gun_Level_Num
	bra.s	Re_Do_Gun_Line
gun_maxxed
	move.w	#-1,gun_power_price(a0)
Re_Do_Gun_Line
	bsr	Re_Do_Product_Line
	clr.w	d0
	rts
gun_max_power
	move.w	#1,d0
	rts

**************************************
***      ADD GRENADE PACK         ****
**************************************
Add_Grenade_Pack
	cmp.w	#4,grenade_packs
	beq.s	max_gren_packs
	tst.w	grenades_in_pack
	bne.s	dont_need_to_init
	move.w	#5,grenades_in_pack
dont_need_to_init	
	addq.w	#1,grenade_packs	
	bsr	Set_Up_Grenade_Pack_Num
	bsr	Re_Do_Product_Line
	clr.w	d0
	rts
max_gren_packs	
	move.w	#1,d0
	rts
	
**************************************
***      ADD ROCKET PACK          ****
**************************************
Add_Rocket_Pack
	cmp.w	#4,rocket_packs
	beq.s	max_rock_packs
	tst.w	rockets_in_pack
	bne.s	dont_need_to_init_rocks
	move.w	#5,rockets_in_pack
dont_need_to_init_rocks

	addq.w	#1,rocket_packs	
	bsr	Set_Up_Rocket_Pack_Num
	bsr	Re_Do_Product_Line
	clr.w	d0
	rts
max_rock_packs	
	move.w	#1,d0
	rts
	
**************************************
***    SET UP ALL GUN LEVELS      ****
**************************************
Set_Up_All_Gun_Levels

	bsr	Set_Up_Rocket_Pack_Num
	bsr	Set_Up_Grenade_Pack_Num
	bsr	Set_Up_Rocket_Level_Num
	bsr	Set_Up_Grenade_Level_Num
	bsr	Set_Up_Energy_Modules_Num
	bsr	Set_Up_Energy_Num
	bsr	Set_Up_Gun_Level_Num
	
	bsr	Set_Up_Cash_Levels
	
	rts
	
**************************************
***    SET UP CASH LEVELS         ****
**************************************	
Set_Up_Cash_Levels

	move.l	#game_shop_prices,a1
	move.l	#product_list_strings,a2
	move.w	#total_prod_prices-1,d7
convert_all_cash	
	move.w	(a1)+,d0
	move.l	#cash_price,a0
	bsr	Convert_Num_To_String
	move.b	cash_price+1,(a2)		;who gives a flying fuck
	move.b	cash_price+2,1(a2)
	move.b	cash_price+3,2(a2)
	move.b	cash_price+4,3(a2)
	add.l	#42,a2
	dbra	d7,convert_all_cash
	rts	
	
**************************************
***    SET UP ROCKET PACK NUM     ****
**************************************
Set_Up_Rocket_Pack_Num
	move.w	rocket_packs,d0
	add.w	#'0',d0
	move.b	d0,prod_rocket_pack+40
	rts
	
**************************************
***    SET UP GRENADE PACK NUM    ****
**************************************
Set_Up_Grenade_Pack_Num
	move.w	grenade_packs,d0
	add.w	#'0',d0
	move.b	d0,prod_grenade_pack+40

	rts

**************************************
***   SET UP ROCKET LEVEL NUM     ****
**************************************
Set_Up_Rocket_Level_Num

	move.w	rocket_level,d0
	add.w	#'1',d0
	move.b	d0,prod_rocket_level+40


	rts
	
**************************************
***   SET UP GRENADE LEVEL NUM    ****
**************************************
Set_Up_Grenade_Level_Num

	move.w	grenade_level,d0
	add.w	#'1',d0
	move.b	d0,prod_grenade_level+40

	rts
	
**************************************
***   SET UP GUN LEVEL NUM        ****
**************************************
Set_Up_Gun_Level_Num

	move.w	gun_type,d0	
	asr	#2,d0
	mulu	#6,d0
	
	move.l	#Gun_Types,a1
	add.l	d0,a1
	move.w	#6-1,d0
	move.l	#prod_gun_level+7,a0
copy_gun_type
	move.b	(a1)+,(a0)+
	dbra	d0,copy_gun_type			
	rts
	
Gun_Types
	dc.b "SINGLE"
	dc.b "DOUBLE"
	dc.b "TRIPLE"
	even	
	
**************************************
***   SET UP ENERGY MODULES NUM   ****
**************************************
Set_Up_Energy_Modules_Num

	move.w	current_energy_modules,d0
	move.w	d0,d1
	add.w	#'0',d0
	move.b	d0,prod_energy_bars+40
	
	asl	#2,d1
	mulu	#NUMBER_HITS_PER_UNIT,d1
	move.w	d1,Player_Energy_Limit

	rts
	
**************************************
***   SET UP ENERGY NUM           ****
**************************************
Set_Up_Energy_Num

	move.w	player_current_energy,d0
	move.w	player_energy_limit,d1
	mulu	#100,d0
	divu	d1,d0
	cmp.w	#100,d0
	bge.s	max_en_limit
	ext.l	d0
	divu	#10,d0
	add.b	#'0',d0
	move.b	#' ',prod_extra_energy+29
	move.b	d0,prod_extra_energy+27
	swap	d0
	add.b	#'0',d0
	move.b	d0,prod_extra_energy+28
	rts		
max_en_limit	
	move.b	#'1',prod_extra_energy+27
	move.b	#'0',prod_extra_energy+28
	move.b	#'0',prod_extra_energy+29
	rts

	
	
	
		
game_shop_prices
	ds.w	8			
	
cash_price
	dc.b	"00000",0
	even	
	
	
	
	
shop_middle_cols
	dc.w	$000,$254,$043,$276
	dc.w	$410,$443,$feb,$c94
	dc.w	$550,$650,$852,$962	
	dc.w	$a72,$b82,$eb5,$ed6
	dc.w	$741,$530,$420,$100
	dc.w	$b7e,$970,$862,$440
	dc.w	$740,$b72,$a83,$751
	dc.w	$9eb,$110,$311,$ba7
	
	
box_x_pos	dc.w	BORDER_START_X
box_y_pos	dc.w	BORDER_START_Y	



*****************************************
***  SET UP PRODUCT LIST              ***
*****************************************
Set_Up_Product_List
	move.w	#SMALLFONT_HEIGHT*2,d1
	move.l	#product_list_strings,a4
	move.l	#game_shop_prices,a5
	moveq.w	#7,d7
draw_product_strings_loop
	move.w	#60,d0
	move.l	product_list_ptr,a3
	movem.l	d1/a4-a5/d7,-(sp)
	cmp.w	#-1,(a5)
	bne.s	prd_not_max
	move.l	#prod_max,a4
prd_not_max	
	bsr	Display_Small_String_Skip	;basic draw
	movem.l	(sp)+,d1/a4-a5/d7	
	addq.l	#2,a5
	add.l	#42,a4
	add.w	#SMALLFONT_HEIGHT,d1
	dbra	d7,draw_product_strings_loop
	rts

****************************************
*** SET UP PRODUCT LIST MEMORY       ***
****************************************
Set_Up_Product_List_Memory

	move.l	memory_base,a0
	add.l	#LO_RES_PLANE*5,a0
	move.l	a0,product_list_ptr
	
	move.w	#((PRODUCT_LIST_WINDOW_LENGTH*40)/4)-1,d0
clear_product_list_mem
	clr.l	(a0)+
	dbra	d0,clear_product_list_mem
	rts

**************************************
***    FRIG ENERGY UPDATE         ****
**************************************
Frig_Energy_Update
*I dont like doing this - but I have given up caring about neat code
	move.w	box,d0
	move.l	product_list_ptr,d1
	movem.l	d0-d1,-(sp)
	move.w	#6,box		;energy
	move.l	memory_base,a0
	add.l	#(LO_RES_PLANE*5)+((SMALLFONT_HEIGHT*40)*7),a0
	move.l	a0,product_list_ptr
	bsr	Re_Do_Frig	
	movem.l	(sp)+,d0-d1
	move.w	d0,box
	move.l	d1,product_list_ptr
	rts

**************************************
***    RE DO PRODUCT LINE         ****
**************************************
Re_Do_Product_line

	bsr	Set_Up_Cash_Levels
	jsr	Sync
Re_Do_Frig	
	move.l	product_list_ptr,a0
	add.l	#(SMALLFONT_HEIGHT)*40,a0
Remove_Old_Product	
	btst	#14,dmaconr(a6)
	bne.s	Remove_Old_Product
	clr.w	bltadat(a6)
	move.l	a0,bltdpth(a6)
	clr.w	bltdmod(a6)		;clear whole screen line
	move.l	#$01f00000,bltcon0(a6)
	move.l	#$ffffffff,bltafwm(a6)
	move.w	#SMALLFONT_HEIGHT<<6+20,bltsize(a6)
	
	clr.l	d0
	move.w	box,d0
	move.l	#game_shop_prices,a4
	lsl.w	d0
	cmp.w	#-1,(a4,d0)
	bne.s	not_a_maxxed_product
	move.l	#prod_max,a4
	bra.s	insert_prod_str
not_a_maxxed_product
	mulu	#21,d0
	move.l	#product_list_strings,a4
	add.l	d0,a4	
insert_prod_str
	move.l	product_list_ptr,a3
	move.w	#SMALLFONT_HEIGHT,d1
	move.w	#60,d0
	bsr	Display_Small_String_Skip		
	rts

	
*****************************************
*** INSERT PRODUCT LIST PTR           ***
*****************************************
Insert_Product_List_Ptr
	move.l	product_list_ptr,d0
	move.w	d0,ProductPlane5_Lo
	swap	d0
	move.w	d0,productPlane5_Hi
	rts

product_list_strings
prod_grenade_level
	dc.b	"0000 : GRENADE POWER UP : CURRENT LEVEL 1",0
prod_rocket_level	
	dc.b	"0000 : ROCKET POWER UP  : CURRENT LEVEL 1",0
prod_energy_bars	
	dc.b	"0000 : ADD ENERGY BAR   : CURRENT BARS  1",0
prod_gun_level	
	dc.b	"0000 : SINGLE POWER UP                   ",0
prod_grenade_pack	
	dc.b	"0000 : GRENADE PACK     : CURRENT PACKS 1",0
prod_rocket_pack	
	dc.b	"0000 : ROCKET PACK      : CURRENT PACKS 1",0
prod_extra_energy	
	dc.b	"0000 : TOP UP ENERGY    : %00  FULL      ",0
	dc.b	"            - EXIT FROM SHOP -           ",0
	even

prod_max
	dc.b	"xxxx :       * MAXIMUM REACHED! *        ",0
	even                   

product_list_ptr	dc.l	0	
sprite_base		dc.l	0
prod_dist		dc.w	0

product_list_cols
	dc.w	$000,$111,$222,$333,$333,$444
	
	dc.w	$555,$777,$999,$bbb,$ddd,$eee,$fff,$fff,$fff
	dc.w	$eee,$ddd,$bbb,$999,$777,$555
	
	dc.w	$444,$333,$333,$222,$111,$000
	
	rsreset
	
grenade_price		rs.w	1
rocket_price		rs.w	1
extra_module_price	rs.w	1
gun_power_price		rs.w	1
grenade_pack_price	rs.w	1
rocket_pack_price	rs.w	1
energy_refill_price	rs.w	1
total_prod_prices	rs.w	1	

default_shop_prices
	dc.w	1000
	dc.w	1100
	dc.w	1500
	dc.w	2000
	dc.w	150
	dc.w	250
	dc.w	300	
	dc.w	0

Spr_Box_Data
	incbin	"data/boxset.spr"	
	