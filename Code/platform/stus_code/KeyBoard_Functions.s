KeyBoard_Functions

	move.b	$bfec01,d0
	ror.b	#1,d0
	btst	#7,d0
	beq.s	End_Keys
	andi.b	#$7f,d0

	cmp.b	#102,d0			; P Pressed
	bne.s	End_Keys
pause_game_loop
	move.b	$bfec01,d0
	ror.b	#1,d0
	btst	#7,d0
	bne.s	pause_game_loop
wait_for_restart_key
	move.b	$bfec01,d0
	ror.b	#1,d0
	btst	#7,d0
	beq.s	wait_for_restart_key	

	andi.b	#$7f,d0
	cmp.b	#47,d0			; F1 Pressed
	bne.s	notkey0
	btst	#7,$bfe001
	bne.s	notkey0
	bset	#WAVE_COMPLETED,Status_Flags
notkey0

	
End_Keys
	*move.b  #0,$bfec01
	rts
