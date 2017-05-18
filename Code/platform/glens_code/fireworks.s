**********************************************
********  FIRE SWAP BUFFERS          *********
**********************************************	
fire_swap_buffers

	move.l	plane1,d0
	move.l	plane2,d1
	move.l	plane3,d2
	move.l	plane4,d3
	
	move.l	buffered_plane1,plane1
	move.l	buffered_plane2,plane2
	move.l	buffered_plane3,plane3
	move.l	buffered_plane4,plane4
	
	move.l	d0,buffered_plane1
	move.l	d1,buffered_plane2
	move.l	d2,buffered_plane3
	move.l	d3,buffered_plane4

	subq.l	#8,d0
	subq.l	#8,d1
	subq.l	#8,d2	
	subq.l	#8,d3	

	move.w	d0,showplane1low
	swap	d0
	move.w	d0,showplane1high
	
	move.w	d1,showplane2low
	swap	d1
	move.w	d1,showplane2high

	move.w	d2,showplane3low
	swap	d2
	move.w	d2,showplane3high

	move.w	d3,showplane4low
	swap	d3
	move.w	d3,showplane4high

	rts
	
**********************************************
********  FIREWORKS GET RANDOM NUMBER*********
**********************************************	

*This is the same as the random routine but for speed this version
*does not do any stack saves

FireWorks_Get_Random_Number

* D0 - Lower Bound, D1 - Upper Bound, number returned in d0

fmult	equ	34564
finc	equ	7682
fseed	equ	12032 
fmod 	equ	65535

	moveq	#0,d2
	sub.w	d0,d1	
	addq.w	#1,d1
	move.w	fold_seed,d2

	mulu.w	#fmult,d2
	add.l	#finc,d2
	divu.w	#fmod,d2
	swap	d2		
	move.w	d2,fold_seed		
	
	mulu.w	d1,d2
	divu.w	#fmod,d2
	add.w	d2,d0	
	rts
fold_seed	dc.w	fseed
	
	
	

*Fireworks code
**********************************************
********  DO FIREWORKS               *********
**********************************************		
do_fireworks	
	bsr	delete_firework_list
	bsr	buffer_firework_lists
	bsr	process_firework_list
	bsr	draw_firework_list
	bsr	add_new_fireworks_to_list
	rts
	
**********************************************
********  ADD ROCKETS                *********
**********************************************	
add_rockets
	subq.w	#1,rocket_add_timer
	bne.s	dont_add_new_rocket
	move.w	#20,d0
	move.w	#30,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,rocket_add_timer
	move.w	#160*FIRE_SCALE,d0
	move.w	#254*FIRE_SCALE,d1
	move.w	#ROCKET,d2
	bsr	add_a_firework	
dont_add_new_rocket
	rts	
	
**********************************************
********  SETUP FIREWORK DATA        *********
**********************************************				
setup_firework_data
	move.l	#fire_work_structures,a0
	move.l	#fire_work_pointers,a1
	move.w	#400-1,d0
fire_work_set_loop
	move.l	a0,(a1)+
	add.l	#fire_struct_size,a0
	dbra	d0,fire_work_set_loop
	
	move.w	#400,firework_count
	move.l	#fire_work_pointers,current_firework_list_pointer
	
	move.w	#$ffff,fire_draw_data
	move.w	#$ffff,fire_draw_data_buff						
	move.w	#$ffff,fire_add_structures
	move.l	#$ffffffff,dynamic_firework_list
	move.l	#dynamic_firework_list,dynamic_list_ptr
	bsr	create_random_list
	rts

**********************************************
******* BUFFER FIREWORK LISTS        *********
**********************************************	
buffer_firework_lists

	move.l	fire_draw,d0
	move.l	fire_draw_buff,fire_draw
	move.l	d0,fire_draw_buff

	rts
	
		
**********************************************
******* ADD FIREWORK FIXED           *********
**********************************************
add_firework_fixed
*send x,y in d0 and d1
*send vel for x and y in d3 and d4
*send type in d2
*send col in d5
*send time in d6

	tst.w	firework_count
	beq	sorry_firework_list_full2
	move.l	current_firework_list_pointer,a0
	move.l	(a0)+,a1
	move.l	a0,current_firework_list_pointer
	move.l	dynamic_list_ptr,a2
	move.l	a1,(a2)+
	move.l	#$ffffffff,(a2)
	move.l	a2,dynamic_list_ptr
	subq.w	#1,firework_count

	move.w	d2,fire_type(a1)	
	move.w	d0,fire_x(a1)
	move.w	d1,fire_y(a1)
	clr.w	fire_descent(a1)
	move.w	d3,fire_x_vel(a1)
	move.w	d4,fire_y_vel(a1)
	tst	d4
	bmi.s	not_going_down_fire
	move.w	#1,fire_descent(a1)	
not_going_down_fire	
	
	move.w	d5,fire_colour(a1)
	move.w	d6,fire_time(a1)
	move.w	#FIRE_COL_SPEED,fire_col_time(a1)
sorry_firework_list_full2	
	rts	

	
	
**********************************************
******* ADD A FIREWORK               *********
**********************************************
add_a_firework
*send x,y in d0 and d1
*send type in d2

	tst.w	firework_count
	beq	sorry_firework_list_full
	move.l	current_firework_list_pointer,a0
	move.l	(a0)+,a1
	move.l	a0,current_firework_list_pointer
	move.l	dynamic_list_ptr,a2
	move.l	a1,(a2)+
	move.l	#$ffffffff,(a2)
	move.l	a2,dynamic_list_ptr
	subq.w	#1,firework_count

	move.w	d2,fire_type(a1)	
	move.w	d0,fire_x(a1)
	move.w	d1,fire_y(a1)
	clr.w	fire_descent(a1)
	
	move.w	#0,d0
	move.w	#4,d1
	bsr	FireWorks_Get_Random_Number
	move.l	#colour_choice,a0
	move.w	(a0,d0.w*2),d0
	move.w	d0,fire_colour(a1)
	
	move.w	#-64*3,d0
	move.w	#64*3,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,fire_x_vel(a1)
	
	move.w	#-64*6,d0
	move.w	#64*6,d1
	cmp.w	#ROCKET,fire_type(a1)
	bne.s	ignor_sign
	move.w	#-64*4,d1
	move.w	#-64*7,d0

ignor_sign
	bsr	FireWorks_Get_Random_Number
	move.w	d0,fire_y_vel(a1)
	
	move.l	#fire_times,a0
	move.w	fire_type(a1),d0
	move.w	(a0,d0.w*2),fire_time(a1)
sorry_firework_list_full	
	rts	

**********************************************
******* REMOVE A FIREWORK            *********
**********************************************
remove_a_firework
*send pointer in a4

	move.l	current_firework_list_pointer,a1
	move.l	a4,-(a1)
	move.l	a1,current_firework_list_pointer
	addq.w	#1,firework_count
	rts


**********************************************
******* ADD NEW FIREWORKS TO LIST    *********
**********************************************
add_new_fireworks_to_list

	move.l	#fire_add_structures,a3

add_to_fire_list
	cmp.w	#$ffff,(a3)
	beq.s	finished_adding_fireworks
	
	move.w	fire_x(a3),d0
	move.w	fire_y(a3),d1
	move.w	fire_type(a3),d2
	move.w	fire_x_vel(a3),d3
	move.w	fire_y_vel(a3),d4
	move.w	fire_time(a3),d6
	move.w	fire_colour(a3),d5
	bsr	add_firework_fixed
	add.l	#fire_struct_size,a3	
	bra.s	add_to_fire_list	
finished_adding_fireworks	
	move.l	#fire_add_structures,fire_add_list_ptr
	move.w	#400,add_fire_number
	move.w	#$ffff,fire_add_structures
	rts

**********************************************
******* PROCESS FIREWORK LIST        *********
**********************************************
process_firework_list

	move.l	fire_draw,a5
	move.l	fire_add_list_ptr,a0
	move.l	#dynamic_firework_list,a2
	move.l	a2,a3
process_list
	move.l	(a2),a4
	cmp.l	#$ffffffff,a4
	beq	finished_processing_fireworks		
	
	subq.w	#1,fire_time(a4)
	beq	kill_firework
	
	move.w	fire_x_vel(a4),d0
	bpl.s	fire_x_pl
	add.w	#FIRE_DECREASE_X,d0
	ble.s	done_fire_x
	clr.w	d0
	bra.s	done_fire_x
fire_x_pl	
	sub.w	#FIRE_DECREASE_X,d0
	bge.s	done_fire_x
	clr.w	d0
done_fire_x
	move.w	d0,fire_x_vel(a4)
	add.w	d0,fire_x(a4)
	
	move.w	fire_y_vel(a4),d0
	tst	fire_descent(a4)
	bne.s	fire_fall
	tst	d0
	bpl.s	fire_y_pl
fire_fall	
	add.w	#FIRE_DECREASE_Y,d0
	bra.s	done_fire_y
fire_y_pl	
	sub.w	#FIRE_DECREASE_Y,d0
	bpl.s	done_fire_y
	move.w	#1,fire_descent(a4)

done_fire_y
	move.w	d0,fire_y_vel(a4)
	add.w	d0,fire_y(a4)

	cmp.w	#0,fire_x(a4)
	ble	kill_firework_completely
	
	cmp.w	#320*FIRE_SCALE,fire_x(a4)
	bge	kill_firework_completely
	
		
	cmp.w	#0,fire_y(a4)
	ble	kill_firework_completely
	
	cmp.w	#256*FIRE_SCALE,fire_y(a4)
	bge	kill_firework_completely

	move.w	fire_x(a4),d0
	asr	#FIRE_DIVU,d0
	move.w	d0,(a5)+		;draw details
	move.w	fire_y(a4),d0
	asr.w	#FIRE_DIVU,d0
	move.w	d0,(a5)+
	move.w	fire_colour(a4),(a5)+
	move.w	fire_type(a4),(a5)+

	cmp.w	#ROCKET,fire_type(a4)
	bne.s	cant_add_anymore
	tst	add_fire_number
	beq.s	cant_add_anymore
	subq.w	#1,add_fire_number	
		
	
	move.w	#DUST_PARTICLE,fire_type(a0)
	
	move.w	fire_x(a4),fire_x(a0)
	move.w	fire_y(a4),fire_y(a0)

	clr.l	fire_x_vel(a0)	;clear y as well as data follows
	move.w	fire_colour(a4),fire_colour(a0)
	addq.w	#1,fire_colour(a0)
	move.w	#4,fire_time(a0)
	add.l	#Fire_struct_size,a0
	
dont_add_trail			
	
cant_add_anymore	
	move.l	(a2)+,(a3)+
	bra	process_list
kill_firework
	
	cmp.w	#ROCKET,fire_type(a4)
	bne.s	do_not_explode_this

*Rocket splits up into dust and shells

	move.w	#DUST_MIN_CLOUD,d0		;get number of dust particles
	move.w	#DUST_MAX_CLOUD,d1
	bsr	FireWorks_Get_Random_Number
	

	move.w	d0,d7
	move.w	#0,d0
	move.w	#999,d1
	bsr	FireWorks_Get_Random_Number
	ext.l	d0
	asl	#3,d0
	move.l	#random_fire_list_initializers,a1
	add.l	d0,a1
add_new_particles

	tst	add_fire_number
	beq.s	do_not_explode_this
	subq.w	#1,add_fire_number
	
	move.w	#DUST_PARTICLE,fire_type(a0)
	move.w	fire_x(a4),fire_x(a0)
	move.w	fire_y(a4),fire_y(a0)
	
	move.w	(a1)+,fire_time(a0)
	
	move.l	(a1)+,fire_x_vel(a0)	;x and y follow in data so move lw
	

	move.w	fire_colour(a4),d0
	add.w	(a1)+,d0
	move.w	d0,fire_colour(a0)

	cmp.w	#$ffff,(a1)
	bne.s	not_end_of_list
	move.l	#random_fire_list_initializers,a1
not_end_of_list


	add.l	#fire_struct_size,a0
	dbra	d7,add_new_particles
	
do_not_explode_this	
kill_firework_completely
	bsr	remove_a_firework

	addq.l	#4,a2
	bra	process_list	
	
finished_processing_fireworks	
	move.w	#$ffff,(a5)
	move.l	a3,dynamic_list_ptr
	move.l	#$ffffffff,(a3)
	move.w	#$ffff,(a0)
	move.l	a0,fire_add_list_ptr
	rts



**********************************************
******* DRAW FIREWORK LIST           *********
**********************************************
draw_firework_list

	move.l	fire_draw,a5
draw_the_fireworks
	cmp.w	#$ffff,(a5)
	beq.s	drawn_firework_list	
	
	move.w	(a5)+,d0
	move.w	(a5)+,d1
	move.w	(a5)+,d2
	move.w	(a5)+,d7
	cmp.w	#ROCKET,d7
	bne.s	not_a_rocket
	move.w	d0,d5
	move.w	d1,d6
	bsr	draw_firework_pixel
	addq.w	#1,d5
	move.w	d5,d0
	move.w	d6,d1
	bsr	draw_firework_pixel
	addq.w	#1,d6
	move.w	d5,d0
	move.w	d6,d1
	bsr	draw_firework_pixel
	subq.w	#1,d5	
	move.w	d5,d0
	move.w	d6,d1
not_a_rocket	
	bsr	draw_firework_pixel
	
		
	bra.s	draw_the_fireworks
drawn_firework_list
	rts
	
**********************************************
******* DELETE FIREWORK LIST         *********
**********************************************
delete_firework_list

	move.l	fire_draw_buff,a1
delete_the_fireworks
	cmp.w	#$ffff,(a1)
	beq.s	deleted_firework_list	
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	move.w	(a1)+,d2
	move.w	(a1)+,d7
	cmp.w	#ROCKET,d7
	bne.s	not_a_clear_rocket
	move.w	d0,d5
	move.w	d1,d6
	bsr	clear_firework_pixel
	addq.w	#1,d5
	move.w	d5,d0
	move.w	d6,d1
	bsr	clear_firework_pixel
	addq.w	#1,d6
	move.w	d5,d0
	move.w	d6,d1
	bsr	clear_firework_pixel
	subq.w	#1,d5	
	move.w	d5,d0
	move.w	d6,d1
not_a_clear_rocket	
	bsr	clear_firework_pixel

	bra.s	delete_the_fireworks
deleted_firework_list
	rts
	

**********************************************
******* DRAW FIREWORK PIXEL          *********
**********************************************

draw_firework_pixel
*send d0 and d1
*send colour in d2

	move.l	buffered_plane1,a0
	ext.l	d1
	asl.w	#6,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1	
	move.w	#0,d3
	ext.l	d0
	add.l	d0,a0
draw_pix_loop
	btst	d3,d2
	beq.s	dont_draw_pixel	
	bset.b	d1,(a0)	;
dont_draw_pixel		
	add.l	#SIZE_OF_PLANE,a0
	addq.w	#1,d3	
	cmp.w	#4,d3
	bne.s	draw_pix_loop
	rts	

**********************************************
******* CLEAR FIREWORK PIXEL         *********
**********************************************

clear_firework_pixel
*send d0 and d1
*send colour in d2

	move.l	buffered_plane1,a0
	ext.l	d1
	asl.w	#6,d1
	add.l	d1,a0
	move.w	d0,d3
	lsr.w	#3,d0		; get bytes
	andi.b	#%111,d3		; pixel bits
	moveq	#7,d1	
	sub.b	d3,d1
	ext.l	d0
	add.l	d0,a0
clear_pix_loop

*Ok code like this sucks but its faster than using a loop

	bclr.b	d1,(a0)	
	add.l	#SIZE_OF_PLANE,a0
	bclr.b	d1,(a0)	
	add.l	#SIZE_OF_PLANE,a0
	bclr.b	d1,(a0)	
	add.l	#SIZE_OF_PLANE,a0
	bclr.b	d1,(a0)	
	
	rts	


**********************************************
******* CREATE RANDOM LIST           *********
**********************************************
create_random_list

	move.l	#random_fire_list_initializers,a0
	move.w	#1000-1,d7
get_rands
	
	move.w	#45,d0
	move.w	#65,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,(a0)+
	
	move.w	#-170,d0
	move.w	#130,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,(a0)+
	
	move.w	#-160,d0
	move.w	#130,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,(a0)+


	move.w	#0,d0
	move.w	#2,d1
	bsr	FireWorks_Get_Random_Number
	move.w	d0,(a0)+

	dbra	d7,get_rands	



	rts



SIZE_OF_PLANE	EQU	BYTES_PER_ROW*HEIGHT

SEC		EQU	50


DUST_PARTICLE	EQU	0
SHELL		EQU	1
MINI_SHELL	EQU	2
ROCKET		EQU	3


FIRE_SCALE	EQU	64
FIRE_DIVU	EQU	6

FIRE_DECREASE_Y	EQU	6
FIRE_DECREASE_X	EQU	1
FIRE_Y_VEL_BASE	EQU	2*FIRE_SCALE


DUST_TIME	EQU	45
SHELL_TIME	EQU	35
MINI_TIME	EQU	25
ROCKET_TIME	EQU	80


FIRE_CHOOSE	EQU	-30000

fire_times
	dc.w	DUST_TIME
	dc.w	SHELL_TIME
	dc.w	MINI_TIME
	dc.w	ROCKET_TIME


	rsreset

fire_type	rs.w	1	
fire_x		rs.w	1
fire_y		rs.w	1
fire_x_vel	rs.w	1	;always decreasing
fire_y_vel	rs.w	1	;always decreasing
fire_time	rs.w	1
fire_colour	rs.w	1
fire_descent	rs.w	1
fire_col_time	rs.w	1	
fire_colour_start	rs.w	1
fire_struct_size	rs.w	1
	
	rsreset
	
fire_draw_x	rs.w	1
fire_draw_y	rs.w	1
fire_draw_colour	rs.w	1	
fire_draw_type		rs.w	1
fire_draw_struct_size	rs.w	1		
	
MAX_PIXELS	equ	500	
	
		
fire_work_pointers
	ds.l	MAX_PIXELS

dynamic_firework_list
	ds.l	MAX_PIXELS
	
dynamic_list_ptr
	dc.l	0	
	
fire_draw_data
	ds.b fire_draw_struct_size*MAX_PIXELS	
	
fire_draw_data_buff
	ds.b fire_draw_struct_size*MAX_PIXELS	


fire_add_list_ptr	dc.l	fire_add_structures

fire_draw	dc.l	fire_draw_data
fire_draw_buff	dc.l	fire_draw_data_buff		
	
fire_work_structures
	ds.b	fire_struct_size*MAX_PIXELS
	even
	
fire_add_structures
	ds.b	fire_struct_size*MAX_PIXELS
	even
	
	
current_firework_list_pointer
	dc.l	0
		
FIRE_COL_SPEED	EQU	8
		
firework_count
	dc.w	MAX_PIXELS-10		

add_fire_number
	dc.w	MAX_PIXELS-10


DUST_MIN_CLOUD	EQU	70
DUST_MAX_CLOUD	EQU	85

rocket_add_timer
	dc.w	30
		
random_fire_list_initializers
	ds.w	4*1000	
	dc.w	$ffff
	
	
colour_choice
	dc.w	1
	dc.w	4
	dc.w	7
	dc.w	10
	dc.w	13
	



col_list
firecols
	dc.l	$000000
	dc.l	$f0f0f0,$a0a0a0,$606060
	dc.l	$f04000,$a02000,$600030
	dc.l	$00f010,$10a020,$000704
	dc.l	$0070f0,$0070b0,$500080
	dc.l	$f0f000,$f07000,$f0a000
