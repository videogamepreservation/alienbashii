
*Remember the alien map is byte but the main map is word!!!!!


*------------------MAP ROUTINES--------------------------*

MAP_BLOCK_SIZE	EQU	2	;word map



;hey I dont care if the routines could be combined into 1 - I am on
; a tight time budget

****************************************************
*****            DECOMPRESS WORD MAP           *****
****************************************************
Decompress_Word_Map


	move.l	memory_base,a0
	move.l	(a0)+,d2	;total size of compressed map data in bytes
	asr.l	d2		;cos word

	move.l	buffer_map_memory,a2	
	add.l	#((BUFFER_OFFSET*BIGGEST_MAP_X)*MAP_BLOCK_SIZE)+BUFFER_OFFSET*MAP_BLOCK_SIZE,a2
	
	move.l	#generic_map_header,a5
	move.w	map_data_x(a5),d0	;map x size
	move.w	map_data_y(a5),d1	;map y size
	

	move.l	a2,a3
	move.w	d0,d5
get_word_byte
	subq.l	#1,d2
	ble	finished_word_read
	move.w	(a0)+,d4
	bclr	#15,d4
	beq	read_word_repeat_data
	subq.w	#1,d4
straight_loop
	move.w	(a0)+,(a3)+

	ifnd	final_version
	cmp.l	Buffer_Alien_Memory,a3
	blt.s	not_overwritting2
signal_error_and_wait2
	move.w	#$f0f,$dff180
	btst.b	#6,$bfe001
	bne.s	signal_error_and_wait2
not_overwritting2
	endc
	
	subq.l	#1,d2
	ble.s	finished_word_read
	subq.w	#1,d5
	bgt.s	dont_reset_pointer
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a2
	move.l	a2,a3
	move.w	d0,d5
dont_reset_pointer
	dbra	d4,straight_loop	
	bra.s	get_word_byte	
		
read_word_repeat_data
	subq.w	#1,d4
	move.w	(a0)+,d6
read_repeat_word_loop	
	move.w	d6,(a3)+

	ifnd	final_version
	cmp.l	buffer_alien_memory,a3
	blt.s	not_overwritting
signal_error_and_wait
	move.w	#$fff,$dff180
	btst.b	#6,$bfe001
	bne.s	signal_error_and_wait	
not_overwritting	
	endc

	subq.w	#1,d5
	bgt.s	dont_reset_repeat_word_pointer
	add.l	#BIGGEST_MAP_X*MAP_BLOCK_SIZE,a2
	move.l	a2,a3
	move.w	d0,d5
dont_reset_repeat_word_pointer
	dbra	d4,read_repeat_word_loop	
	subq.l	#1,d2
	ble.s	finished_word_read

	
	bra	get_word_byte
finished_word_read		
	rts		

****************************************************
*****            DECOMPRESS BYTE MAP           *****
****************************************************
Decompress_Byte_Map
	
	move.l	memory_base,a0
	move.l	(a0)+,d0
	add.l	d0,a0		;alien map data
	move.l	(a0)+,d2
	
	move.l	buffer_alien_memory,a2
	
* Clear the alien memory just to ensure no unwanted aliens appear	
	move.l	a2,a1
	move.w	#((BIGGEST_MAP_X*BIGGEST_MAP_Y)/16)-1,d7
Clear_Map_Memory
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	dbra	d7,Clear_Map_Memory		
	
	
	add.l	#(BUFFER_OFFSET*BIGGEST_MAP_X)+BUFFER_OFFSET,a2

	move.l	#generic_map_header,a5
	move.w	map_data_x(a5),d0	;map x size
	move.w	map_data_y(a5),d1	;map y size


	move.l	a2,a3
	move.w	d0,d5
get_byte_byte
	subq.l	#1,d2
	ble.s	finished_byte_read
	moveq	#0,d4
	move.b	(a0)+,d4
	bclr	#7,d4
	beq.s	read_byte_repeat_data
	subq.w	#1,d4
straight_byte_loop
	move.b	(a0)+,(a3)+
	
	ifnd	final_version
	cmp.l	Copy_Store_area,a3
	blt.s	not_boverwritting
bsignal_error_and_wait
	move.w	#$0ff,$dff180
	btst.b	#6,$bfe001
	bne.s	bsignal_error_and_wait
not_boverwritting	
	endc

	
	subq.l	#1,d2
	ble.s	finished_byte_read
	subq.w	#1,d5
	bgt.s	dont_reset_byte_pointer
	add.l	#BIGGEST_MAP_X,a2
	move.l	a2,a3
	move.w	d0,d5
dont_reset_byte_pointer
	dbra	d4,straight_byte_loop	
	bra.s	get_byte_byte
		
read_byte_repeat_data
	subq.w	#1,d4
	move.b	(a0)+,d6
read_repeat_byte_loop	
	move.b	d6,(a3)+
	
	ifnd	final_version
	cmp.l	Copy_Store_area,a3
	blt.s	not_boverwritting2
bsignal_error_and_wait2
	move.w	#$00f,$dff180
	btst.b	#6,$bfe001
	bne.s	bsignal_error_and_wait2	
not_boverwritting2	
	endc

	
	subq.w	#1,d5
	bgt.s	dont_reset_repeat_byte_pointer
	add.l	#BIGGEST_MAP_X,a2
	move.l	a2,a3
	move.w	d0,d5
dont_reset_repeat_byte_pointer
	dbra	d4,read_repeat_byte_loop	
	subq.l	#1,d2
	ble.s	finished_byte_read

	bra.s	get_byte_byte
finished_byte_read		
	rts

****************************************************
*****            LOAD MAP DATA                 *****
****************************************************
Load_Map_Data

*First clear out map buffers

	move.l	buffer_map_memory,a0
	move.w	#(((BIGGEST_MAP_X*BIGGEST_MAP_Y)*MAP_BLOCK_SIZE)/4)-1,d0
clear_map_buffers
	clr.l	(a0)+
	dbra	d0,clear_map_buffers

*clear out alien data buffer	

	move.l	buffer_alien_memory,a0
	move.w	#((BIGGEST_MAP_X*BIGGEST_MAP_Y)/4)-1,d0
clear_alien_map_buffers
	clr.l	(a0)+
	dbra	d0,clear_alien_map_buffers


	bsr	Load_Map_For_Level
	tst.l	d0
	beq.s	error_loading_blocks
	move.l	#Generic_Map_Header,a5
	cmp.l	#"COMP",map_file_header(a5)
	bne.s	set_up_pointers		;ooops's not correct map type
load_compressed_map	
	bsr	Decompress_Word_Map
	bsr	Decompress_Byte_Map
set_up_pointers	
	move.l	buffer_map_memory,a0
	move.l	buffer_alien_memory,a1	
	add.l	#((BUFFER_OFFSET*BIGGEST_MAP_X)*MAP_BLOCK_SIZE)+BUFFER_OFFSET*MAP_BLOCK_SIZE,a0
	add.l	#(BUFFER_OFFSET*BIGGEST_MAP_X)+BUFFER_OFFSET,a1
	move.l	a0,current_map_pointer
	move.l	a1,current_alien_map_pointer
	
error_loading_blocks	
	rts
	

****************************************************
*****      CONSTRUCT MAP PAGES                 *****
****************************************************
Construct_Map_Pages

	move.w	#1,d0
	bsr	Load_Block_Page
	clr.w	d0
	move.w	#320,d1
	bsr	Construct_Map_Page
	
	move.w	#2,d0
	bsr	Load_Block_Page
	move.w	#320,d0
	move.w	#320,d1
	bsr	Construct_Map_Page

	move.w	#3,d0
	bsr	Load_Block_Page
	move.w	#640,d0
	move.w	#320,d1
	bsr	Construct_Map_Page

	move.w	#4,d0
	bsr	Load_Block_Page
	move.w	#960,d0
	move.w	#220,d1
	bsr	Construct_Map_Page

	rts	
	
	
****************************************************
*****      CONSTRUCT MAP PAGE                  *****
****************************************************
Construct_Map_Page
*send block start number in d0
*send numbers of blocks in d1

	movem.l	d0-d3/a0-a2,-(sp)

	subq.w	#1,d1				;prime block count
	move.l	Fast_Memory_Base,a0		;location of block page
	add.l	#LO_RES_PLANE*4,a0
	move.l	Background_Block_Graphics,a1
	mulu	#16*2*4,d0
	add.l	d0,a1		;get to dest block
	clr.w	d2		;word in page pos
Convert_Block_Mem
	move.w	#4-1,d3
	move.l	a0,a2
Convert_Block_Mem_Loop
	move.w	(a2),(a1)+
	move.w	40(a2),(a1)+		
	move.w	80(a2),(a1)+		
	move.w	120(a2),(a1)+	
	move.w	160(a2),(a1)+	
	move.w	200(a2),(a1)+	
	move.w	240(a2),(a1)+	
	move.w	280(a2),(a1)+	
	move.w	320(a2),(a1)+
	move.w	360(a2),(a1)+		
	move.w	400(a2),(a1)+		
	move.w	440(a2),(a1)+	
	move.w	480(a2),(a1)+	
	move.w	520(a2),(a1)+	
	move.w	560(a2),(a1)+	
	move.w	600(a2),(a1)+	
	add.l	#LO_RES_PLANE,a2
	dbra	d3,Convert_Block_Mem_Loop
	addq.l	#2,a0
	addq.w	#1,d2
	cmp.w	#20,d2
	blt.s	not_line_yet
	clr.w	d2
	add.l	#(40*15),a0
not_line_yet
	dbra	d1,Convert_Block_Mem		
	
	movem.l	(sp)+,d0-d3/a0-a2
	rts	