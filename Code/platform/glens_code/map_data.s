MAP_X_BORDER		EQU 5

MAP_LINE_SIZE		EQU 600+(MAP_X_BORDER*2)
MAP_HEIGHT_SIZE		EQU 32
BACKGROUND_MAP_HEIGHT_SIZE	 EQU	24
NUMBER_OF_BLOCKS_PER_FRAME EQU 11
NUMBER_OF_BACKGROUND_BLOCKS_PER_FRAME EQU 3


*Each map has a border - this is so instead of doing bound checking
*on collecting coins and adding aliens instead the data in that part
*of the map will be all 0's and theredfore do nothing.
*However we must make the map pointer start in a bit and only allow
*it to scroll up to the border point and not past it else its
*all for nothing

*------------------GRAPHIC POINTERS--------------------------

front_blocks	dc.l	0
back_blocks	dc.l	0


*------------------MAP POINTERS - SET UP ONCE NEVER CHANGED AGAIN

map_pointer				dc.l	map1+MAP_X_BORDER
		
background_map_pointer			dc.l	back_map+MAP_X_BORDER
	
the_alien_map_pointer			dc.l	alien_map+MAP_X_BORDER

alien_collision_map_ptr			dc.l	alien_collision_map+MAP_X_BORDER
	
coin_map_pointer			dc.l	coin_map+MAP_X_BORDER	

*-----------------THE FIXED MAP DEFINITIONS - ALL MAPS COPIED INTO THESE

	ds.b	MAP_LINE_SIZE*4		;cover
alien_map
	ds.b	MAP_LINE_SIZE*MAP_HEIGHT_SIZE
	even

	ds.b	MAP_LINE_SIZE*4		;cover
alien_collision_map
	ds.b	MAP_LINE_SIZE*MAP_HEIGHT_SIZE
	even

	
	ds.b	MAP_LINE_SIZE*10		;cover
map1
	ds.b	MAP_LINE_SIZE*MAP_HEIGHT_SIZE
	EVEN
	ds.b	MAP_LINE_SIZE*10		;cover


back_map
	ds.b	MAP_LINE_SIZE*MAP_HEIGHT_SIZE
	even

	ds.b	MAP_LINE_SIZE*10		;cover
coin_map
	ds.b	MAP_LINE_SIZE*(MAP_HEIGHT_SIZE)
	EVEN
	ds.b	MAP_LINE_SIZE*4		;bottom cover

*----------------------USERS MAPS------------------------------------

actual_cave_back
*	incbin	"data/cavebackmap"
	EVEN			
	
cave_map
*	incbin	"data/cavefrontmap"
	even
cave_map2

*	incbin	"data/johnycake" 
	EVEN
Shite_map

*	incbin	"data/shite" 
	EVEN

cave_alien_map
*	incbin	"data/alienmap"	
	even
	

country_spikey
	incbin	"data/countrytwo"
	even
	
country_back
	incbin	"data/dizzyback"
	even	
	
country_alien_map
	incbin	"data/alienmap"
	even	