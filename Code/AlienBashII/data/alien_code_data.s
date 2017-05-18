MAX_ALIENS	EQU	80


*------------------------Alien Variables-------------------

alien_pointers
	ds.l	MAX_ALIENS
	dc.l	$ffffffff


active_alien_pointers
	ds.l	MAX_ALIENS
	dc.l	$ffffffff
			
pig_list
	ds.l	MAX_ALIENS
	dc.l	$ffffffff

	
		
alien_draw_ptr
	dc.l	alien_draw_structures
alien_draw_ptr_buff
	dc.l	alien_draw_structures_buff	

pri_alien_draw_ptr
	dc.l	pri_alien_draw_structures
pri_alien_draw_ptr_buff
	dc.l	pri_alien_draw_structures_buff	


current_add_alien_ptr
	dc.l	0
	
current_alien_list_ptr
	dc.l	0	

alien_structures
	ds.b	alien_struct_size*MAX_ALIENS
	EVEN
		
		
alien_draw_structures	
	ds.b	alien_draw_size*MAX_ALIENS
	EVEN
	
alien_draw_structures_buff
	ds.b	alien_draw_size*MAX_ALIENS		
	EVEN

pri_alien_draw_structures	
	ds.b	alien_draw_size*MAX_ALIENS
	EVEN
	
pri_alien_draw_structures_buff
	ds.b	alien_draw_size*MAX_ALIENS		
	EVEN



*---------------Bullet mem-------------------------	
	
bullet_pointers
	ds.l	MAX_BULLETS
	dc.l	$ffffffff


active_bullet_pointers
	ds.l	MAX_BULLETS
	dc.l	$ffffffff
			

end_alien_draw_ptr
	dc.l	0

current_add_bullet_ptr
	dc.l	0
	
current_bullet_list_ptr
	dc.l	0	

bullet_structures
	ds.b	bullet_struct_size*MAX_BULLETS
	EVEN
