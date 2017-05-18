****** INTRO LEVEL SWITCH AND EVENT INFO *****


*----------Switch info---------------------*

Level6_switch_table
	dc.l	Level6_Switch1
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	0
	dc.l	Level6_Switch9
	dc.l	$ffffffff	;terminate event list if less than 20

		
Level6_Activate_Table
	dc.l	Level6_Event1
	dc.l	Level6_Event2
	dc.l	Level6_Event3
	dc.l	Level6_Event4
	dc.l	Level6_Event5
	dc.l	Level6_Event6
	dc.l	Level6_Event7
	dc.l	Level6_Event8
	dc.l	Level6_Event9
	dc.l	Level6_Event10
	dc.l	Level6_Event11		
	dc.l	Level6_Event12
	dc.l	Level6_Event13
	dc.l	Level6_Event14
	dc.l	Level6_Event15
	dc.l	Level6_Event16
	dc.l	Level6_Event17
	dc.l	Level6_Event18
	dc.l	Level6_Event19
	dc.l	Level6_Event20
	dc.l	Rain_Script
	dc.l	$ffffffff	;terminate switch list if less than 60


*activate event lists - these are the same as switch lists


Level6_Event1
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(37*16),(62*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(43*16),(62*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level6_Event2
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(36*16),(67*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(40*16),(71*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level6_Event12
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(33*16),(77*16)
	dc.l	Fast_Running_Appear_Pig_Object
	dc.w	SWITCH_END

Level6_Event3
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	36,99
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	44,99
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	36,100
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	44,100
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	36,101
	dc.w	1,1,1,$ffff
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;bottom bush
	dc.w	44,101
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	
	dc.w	SWITCH_ADD_ALIEN		;Add top Pig
	dc.w	(37*16),(99*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN		;Add bottom Pig
	dc.w	(45*16),(99*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END


Level6_Event4
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(29*16)+8,(110*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

Level6_Event5
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(45*16),(117*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(52*16),(117*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END


Level6_Event6
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(34*16),(113*16)
	dc.l	Jump_Fish_Appear_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(34*16),(120*16)
	dc.l	Jump_Fish_Appear_Object
	dc.w	SWITCH_END
	
Level6_Event7	
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	43,131
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	43,132
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	dc.w	SWITCH_ADD_EXPLO_BLOCK_ROW	;top bush
	dc.w	43,133
	dc.w	1,1,1,$ffff
	dc.w	Switch_Wait
	dc.w	Switch_Wait
	
	dc.w	SWITCH_ADD_ALIEN		;Add top Pig
	dc.w	(44*16),(131*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level6_Event8
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(42*16),(142*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(39*16),(151*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(47*16),(151*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level6_Event9
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(76*16),(152*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(78*16),(159*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END
	
Level6_Event10
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(104*16),(126*16)+12
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(105*16),(128*16)
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(105*16)+12,(127*16)
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(104*16)+4,(127*16)+12
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(104*16)+12,(126*16)+4
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(103*16)+12,(128*16)+4
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT		
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(105*16)+4,(127*16)+12
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(104*16)+12,(128*16)+8
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(104*16)+12,(127*16)+4
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(103*16)+12,(127*16)+4
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(105*16)+8,(128*16)+8
	dc.l	CoinDiss_Alien
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_TEST
	dc.l	Level6_Bodge
	dc.w	1
	dc.l	End_Level6_Script
	dc.w	SWITCH_JUMP
	dc.l	Level6_Event10	
End_Level6_Script
	dc.w	SWITCH_END					

Level6_Event11
	*** Leaf generator 100, 115
	
Level6_Event13
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(86*16),(107*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(91*16),(107*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END


Level6_Event14
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(85*16),(91*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(94*16),(92*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

Level6_Event15
	dc.w	SWITCH_ADD_ALIEN_TO_MAP
	dc.w	Pig_Generator3
	dc.w	(83*16),(83*16)
	dc.l	Pig_Generator_Object3
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	83,83+1,444
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	83+1,83+1,445
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(83*16)+12,((83+2)*16)+8
	dc.l	Block_Split_Object_3
	dc.w	SWITCH_ADD_ALIEN
	dc.w	(83*16)+20,((83+2)*16)+8
	dc.l	Block_Split_Object_4
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	83,83,424
	dc.w	SWITCH_ADD_FIRE_BLOCK
	dc.w	83+1,83,425
	dc.w	SWITCH_END

Level6_Event16
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(105*16),(76*16)
	dc.l	Fast_Appear_Pig_Object
	dc.w	SWITCH_END

Level6_Event17
	*** leaf gen appear 187,82
	dc.w	SWITCH_END
	
Level6_Event18
	*** leaf gen appear 179, 80
	dc.w	SWITCH_END

	
Level6_Event19
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,65
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,64
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,63
	dc.w	918,1,1,834,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,62
	dc.w	898,1,1,814,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,61
	dc.w	944,1,1,945,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,60
	dc.w	924,925,926,20,$ffff
	
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(140*16),(64*16)
	dc.l	Jump_Fish_Appear_Object
	dc.w	SWITCH_ADD_ALIEN	;second Pig
	dc.w	(145*16),(64*16)
	dc.l	Jump_Fish_Appear_Object
	
	dc.w	Switch_Set_Count
	dc.w	75
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,61
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,60
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,59
	dc.w	918,1,1,834,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,58
	dc.w	898,1,1,814,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,57
	dc.w	944,1,1,945,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,56
	dc.w	924,925,926,20,$ffff
	
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(140*16),(59*16)
	dc.l	Jump_Fish_Appear_Object
	dc.w	SWITCH_ADD_ALIEN	
	dc.w	(145*16),(59*16)
	dc.l	Jump_Fish_Appear_Object
	
	dc.w	Switch_Set_Count
	dc.w	75
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,57
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,56
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,55
	dc.w	918,1,1,834,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,54
	dc.w	898,1,1,814,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,53
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,52
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,51
	dc.w	916,1,1,913,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,50
	dc.w	896,1,1,893,$ffff
	
	dc.w	Switch_Set_Count
	dc.w	75
	dc.w	Switch_Wait
	dc.w	Switch_Count
	dc.w	0

	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,48
	dc.w	956,1,1,953,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,47
	dc.w	936,1,1,933,$ffff

	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,46
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,45
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,44
	dc.w	918,1,1,834,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,43
	dc.w	898,1,1,814,$ffff
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,42
	dc.w	958,1,1,874,$ffff
	dc.w	SWITCH_WAIT	
	dc.w	SWITCH_ADD_BLOCK_ROW
	dc.w	141,41
	dc.w	938,1,1,854,$ffff
	dc.w	SWITCH_END

Level6_Event20
	dc.w	SWITCH_SCROLL_GOTO
	dc.w	133*16,0*16
	dc.w	SWITCH_JUMP
	dc.l	End_Of_Level_Sequence
	dc.w	SWITCH_END
	
		
*-----------------------------Switches---------------*

Level6_Switch1
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	103,126
	dc.w	620,621,622,623,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	103,127
	dc.w	600,601,602,603,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_CHANGE_BLOCK_ROW
	dc.w	103,128
	dc.w	405,406,407,408,$ffff
	dc.w	SWITCH_SET_VAR
	dc.l	Level6_Bodge
	dc.w	1
	dc.w	SWITCH_END
	
Level6_Bodge
	dc.w	0	
	
Level6_Switch9
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	127,121
	dc.w	481,501,521,541,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	126,121
	dc.w	566,586,606,626,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	125,121
	dc.w	565,585,605,625,$ffff
	dc.w	SWITCH_WAIT
	dc.w	SWITCH_ADD_BLOCK_COLUMN
	dc.w	124,121
	dc.w	480,500,520,540,$ffff
	dc.w	SWITCH_END			
	
	