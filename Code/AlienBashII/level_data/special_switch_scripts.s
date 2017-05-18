*Special case scripts

Use_Key_On_Door
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,240,241,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,220,221,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,200,201,$ffff
	dc.w	SWITCH_END

*This is the script for blowing up the main door - i do not
*have the graphics for the blown up door but when you do replace
*the 1's - It assumes the door is four blocks wide and three high
*the bottom line of door blocks is the first set in the script

Blow_Up_Big_Door
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,290,291,292,293,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,270,271,272,273,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,250,251,252,253,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_DESTROY_BLOCK_ROW
	dc.w	0,0,230,231,232,233,$ffff
	dc.w	SWITCH_END
	


Generator_Appear_Example
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(44*16),(77*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	44,78,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45,78,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(44*16)+12,(79*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(44*16)+20,(79*16)+8
	dc.l	Block_Split_Object_4

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	44,77,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	45,77,425
	dc.w	SWITCH_END


Rain_Script
*start by spotting
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Start_Looping_Sample
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	5
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	10
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	15
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	20
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	25
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	30
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	35
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	40
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	45
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	50
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
*start raining properly
Full_Rain
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	Full_Rain
	dc.w	SWITCH_END

Rain_Script500
*start by spotting
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	5
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	10
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	15
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	20
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	25
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	30
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	40
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Start_Looping_Sample
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	45
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	50
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
*start raining properly
Full_Rain500
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	Full_Rain500
	dc.w	SWITCH_END
	


ThunderStorm
*gradually darken the screen
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM1
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM3
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


*start by spotting
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Start_Looping_Sample
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	5
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	10
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	15
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	20
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	25
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	30
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	35
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	40
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	45
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	50
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4
*start raining properly
ThunderStormRepeat
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Random_Flash
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	ThunderStormRepeat
*stop thunderstorm
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM3
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM1
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_NORMAL
	dc.w	SWITCH_END

ThunderStorm500
*gradually darken the screen
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM1
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM3
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


*start by spotting
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	5
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	10
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	15
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	20
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	25
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	30
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	35
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	40
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	45
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SET_RAIN_VOL
	dc.w	50
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4

*start raining properly
ThunderStormRepeat500
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Random_Flash
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	ThunderStormRepeat500
*stop thunderstorm
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM3
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM1
	
	dc.w	Switch_Set_Count
	dc.w	80
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_NORMAL
	dc.w	SWITCH_END


		
	
Lightning1
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_BRIGHT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Big_Rain_Drop
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_BRIGHT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_SOUND_THUN
	dc.w	SWITCH_JUMP
Lightning1_500	
	dc.l	ThunderStormRepeat


Lightning2
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_BRIGHT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
Lightning2_500	
	dc.l	ThunderStormRepeat

Lightning3
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_NORMAL
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Small_Rain_Drop
	dc.w	SWITCH_SOUND_THUN
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM2
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_INSERT_PALETTE
	dc.w	PALETTE_DIM4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
Lightning3_500	
	dc.l	ThunderStormRepeat


	
SnowStorm
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0

	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

SnowStormRepeat
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake2
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake3
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	SnowStormRepeat
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake2
	dc.w	SWITCH_END

SnowStorm500
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	0

	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

SnowStormRepeat500
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake2
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake3
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	WeatherFx
	dc.w	0
	dc.l	SnowStormRepeat500
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT

	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_EXECUTE_CODE
	dc.l	Add_Snow_Flake2
	dc.w	SWITCH_END



StopStorm
	dc.w	SWITCH_SET_VAR
	dc.l	WeatherFx
	dc.w	1
	dc.w	SWITCH_END

WeatherFx
	dc.w	0	



	

Spurty	
	dc.w	SWITCH_ADD_ALIEN
Spurt1_X	
	dc.w	(23*16)-4
Spurt1_Y	
	dc.w	(12*16)-42+5
	dc.l	Gas_Spurt_Object1
	dc.w	SWITCH_WAIT

	dc.w	Switch_Set_Count
Spurt_Speed1	
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0


	dc.w	SWITCH_ADD_ALIEN
Spurt2_X	
	dc.w	(27*16)+4
Spurt2_Y
	dc.w	(12*16)-42+5
	dc.l	Gas_Spurt_Object1
	dc.w	SWITCH_WAIT

	dc.w	Switch_Set_Count
Spurt_Speed2
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0
	
	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	0
	dc.l	Spurty
	dc.w	SWITCH_END

SpurtFlag
	dc.w	0
	

End_Of_Level_Sequence
	dc.w	SWITCH_INSERT_GEN_PALETTE
End_Of_Level_Repeat
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	goto_flag
	dc.w	1
	dc.l	End_Of_Level_Repeat		
	dc.w	SWITCH_SET_VAR
	dc.l	generator_activate
	dc.w	1		
	dc.w	SWITCH_END

Level3_Pig_Platforms
	dc.w	SWITCH_SET_VAR
	dc.l	Level_Gen_Wave_Counter
	dc.w	2
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(94*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(99*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT

Level_3_Gen_Pig_Plats	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level3_Gen_Pp_End

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	Level_Gen_Wave_Counter
	dc.w	0
	dc.l	Level3_Pig_Platforms
	dc.w	SWITCH_JUMP
	dc.l	Level_3_Gen_Pig_Plats	
Level3_Gen_Pp_End
	dc.w	SWITCH_END
	
Level_Gen_Wave_Counter	
	dc.w	2
	dc.l	Level_Gen_Wave_Bonus
	
Level_Gen_Wave_Bonus
	dc.w	OBJECT_KILL,0,0	


Level5_Pig_Platforms
	dc.w	SWITCH_SET_VAR
	dc.l	Level_Gen_Wave_Counter
	dc.w	2
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(151*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(162*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT

Level_5_Gen_Pig_Plats	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level5_Gen_Pp_End

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	Level_Gen_Wave_Counter
	dc.w	0
	dc.l	Level5_Pig_Platforms
	dc.w	SWITCH_JUMP
	dc.l	Level_5_Gen_Pig_Plats	
Level5_Gen_Pp_End
	dc.w	SWITCH_END
	
Level7_Pig_Platforms
	dc.w	SWITCH_SET_VAR
	dc.l	Level_Gen_Wave_Counter
	dc.w	2
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(85*16)+4,(45*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(98*16)+4,(45*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT

Level_7_Gen_Pig_Plats	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level7_Gen_Pp_End

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	Level_Gen_Wave_Counter
	dc.w	0
	dc.l	Level7_Pig_Platforms
	dc.w	SWITCH_JUMP
	dc.l	Level_7_Gen_Pig_Plats	
Level7_Gen_Pp_End
	dc.w	SWITCH_END


Level8_Pig_Platforms
	dc.w	SWITCH_SET_VAR
	dc.l	Level_Gen_Wave_Counter
	dc.w	2
	
	dc.w	Switch_Set_Count
	dc.w	60
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(70*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object
	
	dc.w	Switch_Set_Count
	dc.w	70
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_SET_WAVE
	dc.l	Level_Gen_Wave_Counter
	dc.w	(80*16)+4,(7*16)-4
	dc.l	Fast_Appear_Wave_Pig_Object		
	dc.w	SWITCH_WAIT

Level_8_Gen_Pig_Plats	
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level8_Gen_Pp_End

	dc.w	SWITCH_WAIT
	dc.w	SWITCH_TEST
	dc.l	Level_Gen_Wave_Counter
	dc.w	0
	dc.l	Level8_Pig_Platforms
	dc.w	SWITCH_JUMP
	dc.l	Level_8_Gen_Pig_Plats	
Level8_Gen_Pp_End
	dc.w	SWITCH_END


Level4_Bomb_Attack
	dc.w	Switch_Set_Count
	dc.w	50
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level4_Gen_End

	dc.w	SWITCH_JUMP_RANDOM
	dc.w	2		;0-2
	dc.l	Level4_Bomb1
	dc.l	Level4_Bomb2
	dc.l	Level4_Bomb3
Level4_Gen_End
	dc.w	SWITCH_END
	

Level4_Bomb1
	dc.w	SWITCH_ADD_ALIEN
	dc.w	185*16,25*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_JUMP
	dc.l	Level4_Bomb_Attack

Level4_Bomb2
	dc.w	SWITCH_ADD_ALIEN
	dc.w	191*16,25*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_JUMP
	dc.l	Level4_Bomb_Attack	
	
Level4_Bomb3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	188*16,29*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
	dc.l	Level4_Bomb_Attack	
	
Level6_Bomb_Attack
	dc.w	Switch_Set_Count
	dc.w	40
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level6_Gen_End

	dc.w	SWITCH_JUMP_RANDOM
	dc.w	2		;0-2
	dc.l	Level6_Bomb1
	dc.l	Level6_Bomb2
	dc.l	Level6_Bomb3
Level6_Gen_End
	dc.w	SWITCH_END
	

Level6_Bomb1
	dc.w	SWITCH_ADD_ALIEN
	dc.w	135*16,12*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
	dc.l	Level6_Bomb_Attack

Level6_Bomb2
	dc.w	SWITCH_ADD_ALIEN
	dc.w	142*16,12*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
	dc.l	Level6_Bomb_Attack	
	
Level6_Bomb3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	148*16,12*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
	dc.l	Level6_Bomb_Attack		
	
Level8_Bomb_Attack
	dc.w	Switch_Set_Count
	dc.w	70
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_TEST
	dc.l	SpurtFlag
	dc.w	1
	dc.l	Level8_Gen_End

	dc.w	SWITCH_ADD_ALIEN
	dc.w	75*16,11*16
	dc.l	Bomb_Launch_Object
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_JUMP
	dc.l	Level8_Bomb_Attack

Level8_Gen_End
	dc.w	SWITCH_END
	