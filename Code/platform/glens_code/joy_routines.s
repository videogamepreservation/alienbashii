

****************************************
******  GET STICK READINGS         *****
****************************************
get_stick_readings

	move.w	#0,fire2
	tst	resistance
	beq.s	no_fire_2
	move.w	#1,fire2
no_fire_2
	
	move.w	#0,fire
	btst	#7,$bfe001
	bne.s	set_fire_up
	move.w	#1,fire
set_fire_up

	
	move.w	$dff00c,d0		;joy1dat
update_joy_values
	btst	#9,d0
	beq.s	tryleft
	move.w	#-1,xdirec
	bra	upanddown
tryleft	
	btst	#1,d0
	beq.s	movezero
	move.w	#1,xdirec
	bra.s	upanddown
movezero	
	move.w	#0,xdirec
upanddown
	move.w	d0,d1
	rol.w	#1,d0
	eor.w	d0,d1
	btst	#1,d1
	beq.s    tryup	
	move.w	#-1,ydirec	
	bra.s	quitjoyread
tryup
	btst	#9,d1
	beq.s	stop_y
	move.w	#1,ydirec
	bra.s quitjoyread
stop_y	
	move.w	#0,ydirec
quitjoyread

	rts


	
fire  	 				dc.w	0

fire2					dc.w	0

xdirec 					dc.w	0

ydirec 					dc.w	0

resistance				dc.w	0

force_fire				dc.w	0		