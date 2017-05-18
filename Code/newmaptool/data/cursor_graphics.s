***************************************************************
*****                GRAPHICS FOR CURSOR                  *****
***************************************************************

wait_pointer
 dc.w 0,0
 DC.W $FFF8,$FFF8
 DC.W $FFF8,$8008
 DC.W $F778,$8888
 DC.W $F778,$8888
 DC.W $F578,$8A88
 DC.W $F578,$8A88
 DC.W $F078,$8F88
 DC.W $FFF8,$8008
 DC.W $F078,$8F88
 DC.W $F778,$8888
 DC.W $F078,$8F88
 DC.W $F778,$8888
 DC.W $F778,$8888
 DC.W $FFF8,$8008
 DC.W $F078,$8F88
 DC.W $FDF8,$8208
 DC.W $FDF8,$8208
 DC.W $FDF8,$8208
 DC.W $F078,$8F88
 DC.W $FFF8,$8008
 DC.W $F078,$8F88
 DC.W $FDF8,$8208
 DC.W $FDF8,$8208
 DC.W $FDF8,$8208
 DC.W $FDF8,$8208
 DC.W $FFF8,$8008
 DC.W $FFF8,$FFF8
 dc.w 0,0

mouse_pointer
	dc.w	$0,$0
	dc.w	$8000,$0
	dc.w	$8000,$0
	dc.w	$c000,$0
	dc.w	$c000,$0
	dc.w	$e000,$0
	dc.w	$e000,$0
	dc.w	$f000,$0
	dc.w	$f000,$0
	dc.w	$f800,$0
	dc.w	$f800,$0
	dc.w	$fc00,$0
	dc.w	$fc00,$0
	dc.w	$fe00,$0
	dc.w	$fe00,$0
	dc.w	$ff00,$0
	dc.w	$ff00,$0
pointer_attach_bits
	dc.w	0,0
	ds.w	40*2
	dc.w	0,0

blank_sprite
	dc.w	$0000,$0000	
	dc.w	$0000,$0000	

note_info_data
	ds.w	(32*2)+4


sprite8x8

	dc.w $0,$0
	dc.w $c300,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $c300,$0000
	dc.w $0,0

sprite16x16

	dc.w	$0,$0
	dc.w	$c003,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$c003,0
	dc.w	$0,0

sprite32x321
	dc.w	$0,$0
	dc.w	$c000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$c000,0
	dc.w	$0,0

sprite32x322
	dc.w	$0,$0
	dc.w	$0003,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0003,0
	dc.w	$0,0


sprite8x82

	dc.w $0,$0
	dc.w $c300,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $8100,$0000
	dc.w $c300,$0000
	dc.w $0,0

sprite16x162

	dc.w	$0,$0
	dc.w	$c003,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$8001,0
	dc.w	$c003,0
	dc.w	$0,0

sprite32x3212
	dc.w	$0,$0
	dc.w	$c000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$8000,0
	dc.w	$c000,0
	dc.w	$0,0

sprite32x3222
	dc.w	$0,$0
	dc.w	$0003,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0001,0
	dc.w	$0003,0
	dc.w	$0,0



****************WITH, TO and PICK SPRITE POINTERS

sprwith
	dc.w	$0000,$0000	
	dc.w	$0000,$ffff
	dc.w	$0000,$0000
	dc.w	$5775,$0000
	dc.w	$5225,$0000
	dc.w	$5227,$0000
	dc.w	$7225,$0000
	dc.w	$7225,$0000
	dc.w	$5725,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$ffff
	dc.w	$0000,$0000

sprpick
	dc.w	$0000,$0000	SPRxPOS,SPRxCTL
	dc.w	$0000,$ffff
	dc.w	$0000,$0000
	dc.w	$ce6a,$0000
	dc.w	$a48a,$0000
	dc.w	$a48c,$0000
	dc.w	$c48c,$0000
	dc.w	$848a,$0000
	dc.w	$8e6a,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$ffff
	dc.w	$0000,$0000	Sprite End

sprto
	dc.w	$0000,$0000	SPRxPOS,SPRxCTL
	dc.w	$0000,$ffff
	dc.w	$0000,$0000
	dc.w	$0e40,$0000
	dc.w	$04a0,$0000
	dc.w	$04a0,$0000
	dc.w	$04a0,$0000
	dc.w	$04a0,$0000
	dc.w	$0440,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$ffff
	dc.w	$0000,$0000	Sprite End
