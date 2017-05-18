Get_Random_Number

* D0 - Lower Bound, D1 - Upper Bound, number returned in d0

mult	equ	34564
inc	equ	7682
seed	equ	12032 
mod 	equ	65535

	move.l	d2,-(sp)
	sub.w	d0,d1	
	addq.w	#1,d1
	move.w	old_seed,d2

	mulu.w	#mult,d2
	add.l	#inc,d2
	divu.w	#mod,d2
	swap	d2		
	move.w	d2,old_seed		
	
	mulu.w	d1,d2
	divu.w	#mod,d2
	add.w	d2,d0	
	move.l	(sp)+,d2
	rts
old_seed	dc.w	seed
