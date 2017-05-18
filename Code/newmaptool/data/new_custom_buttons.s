******************************************************************
*****  CUSTOM BUTTON STRUCTURES AND ASSOCIATED GRAPHIC DATA  *****
******************************************************************


FileButton
	dc.w	160
	dc.w	10
	dc.w	160
	dc.w	10
	dc.w	1
	dc.l	0
	dc.l	File_Click_Graphics

MenuButton
	dc.w	112
	dc.w	10
	dc.w	112
	dc.w	10
	dc.w	1
	dc.l	0
	dc.l	File_Click_Graphics


MapSelectButton
	dc.w	128
	dc.w	128
	dc.w	128
	dc.w	128
	dc.w	0
	dc.l	0
	dc.l	0




buffername_get
	dc.w	(7*16)
	dc.w    13
	dc.w	(7*16)
	dc.w	13
	dc.w	1
	dc.l	0
	dc.l	File_Click_Graphics

File_Click_Graphics	dcb.b	38*10,$ff
			

arrow_up
	dc.w	32
	dc.w	11
	dc.w	21
	dc.w	11
	dc.w	3
	dc.l	arrow_up_graphics
	dc.l	arrow_up_graphics

arrow_down
	dc.w	32
	dc.w	11
	dc.w	21
	dc.w	11
	dc.w	3
	dc.l	arrow_down_graphics
	dc.l	arrow_down_graphics


arrow_left
	dc.w	32
	dc.w	11
	dc.w	22
	dc.w	11
	dc.w	3
	dc.l	arrow_left_graphics
	dc.l	arrow_left_graphics

arrow_right
	dc.w	32
	dc.w	11
	dc.w	22
	dc.w	11
	dc.w	3
	dc.l	arrow_right_graphics
	dc.l	arrow_right_graphics


ok_custom_button
	dc.w	64
	dc.w	13
	dc.w	62
	dc.w	13
	dc.w	3
	dc.l	ok_button_graphics
	dc.l	ok_clicked_button_graphics


apply_custom_button
	dc.w	32
	dc.w	12
	dc.w	32
	dc.w	12
	dc.w	3
	dc.l	applyup
	dc.l	applydown

applyup
	incbin	"data/appup.bin"
applydown
	incbin	"data/appdown.bin"	
	even
	
remove_custom_button
	dc.w	32
	dc.w	12
	dc.w	32
	dc.w	12
	dc.w	3
	dc.l	remup
	dc.l	remdown

remup
	incbin	"data/delup.bin"
remdown
	incbin	"data/deldown.bin"
	even

setgroup_custom_button
	dc.w	32
	dc.w	12
	dc.w	32
	dc.w	12
	dc.w	3
	dc.l	setup_gfx
	dc.l	setdown_gfx

setup_gfx
	incbin	"data/setup.bin"
setdown_gfx
	incbin	"data/setdown.bin"
	even

tick_box_button
	dc.w 	16
	dc.w 	7
	dc.w	14
	dc.w 	7
	dc.w	3
	dc.l	tick_box
	dc.l	tick_clicked_box

plus_button
	dc.w 	16
	dc.w 	7
	dc.w	14
	dc.w 	7
	dc.w	3
	dc.l	plus_graphics
	dc.l	plus_clicked_graphics

minus_button
	dc.w 	16
	dc.w 	7
	dc.w	14
	dc.w 	7
	dc.w	3
	dc.l	minus_graphics
	dc.l	minus_clicked_graphics

screen_custom_button
	dc.w 	0
	dc.w    0
	dc.w	ScrPixelWidth
screen_custom_y	
	dc.w 	192
	dc.w	1
	dc.l	0
	dc.l	0


map_screen_custom_button
	dc.w 	0
	dc.w    0
	dc.w	ScrPixelWidth
map_screen_custom_y	
	dc.w 	192-32
	dc.w	1
	dc.l	0
	dc.l	0
	
map_blocks_custom_button
	dc.w 	0
	dc.w    0
	dc.w	ScrPixelWidth
	dc.w 	32
	dc.w	1
	dc.l	0
	dc.l	0

	
page1_button
	dc.w 	32
	dc.w 	13
	dc.w	28
	dc.w 	13
	dc.w	3
	dc.l	page1_graphics
	dc.l	page1_clicked_graphics
	
page2_button
	dc.w 	32
	dc.w 	13
	dc.w	28
	dc.w 	13
	dc.w	3
	dc.l	page2_graphics
	dc.l	page2_clicked_graphics

page3_button
	dc.w 	32
	dc.w 	13
	dc.w	28
	dc.w 	13
	dc.w	3
	dc.l	page3_graphics
	dc.l	page3_clicked_graphics

page4_button
	dc.w 	32
	dc.w 	13
	dc.w	28
	dc.w 	13
	dc.w	3
	dc.l	page4_graphics
	dc.l	page4_clicked_graphics

colour0_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button0
	dc.l	palette_clicked_button0
	
colour1_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button1
	dc.l	palette_clicked_button1

colour2_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button2
	dc.l	palette_clicked_button2
	
colour3_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button3
	dc.l	palette_clicked_button3

colour4_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button4
	dc.l	palette_clicked_button4

colour5_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button5
	dc.l	palette_clicked_button5

colour6_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button6
	dc.l	palette_clicked_button6


colour7_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button7
	dc.l	palette_clicked_button7
	
colour8_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button8
	dc.l	palette_clicked_button8
colour9_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button9
	dc.l	palette_clicked_button9
colour10_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button10
	dc.l	palette_clicked_button10
colour11_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button11
	dc.l	palette_clicked_button11
colour12_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button12
	dc.l	palette_clicked_button12
colour13_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button13
	dc.l	palette_clicked_button13
colour14_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button14
	dc.l	palette_clicked_button14
colour15_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button15
	dc.l	palette_clicked_button15
colour16_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button16
	dc.l	palette_clicked_button16
colour17_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button17
	dc.l	palette_clicked_button17
colour18_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button18
	dc.l	palette_clicked_button18
colour19_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button19
	dc.l	palette_clicked_button19
colour20_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button20
	dc.l	palette_clicked_button20
colour21_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button21
	dc.l	palette_clicked_button21
colour22_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button22
	dc.l	palette_clicked_button22
colour23_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button23
	dc.l	palette_clicked_button23
colour24_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button24
	dc.l	palette_clicked_button24
colour25_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button25
	dc.l	palette_clicked_button25
colour26_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button26
	dc.l	palette_clicked_button26
colour27_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button27
	dc.l	palette_clicked_button27
colour28_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button28
	dc.l	palette_clicked_button28
colour29_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button29
	dc.l	palette_clicked_button29
colour30_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button30
	dc.l	palette_clicked_button30

colour31_button
	dc.w 	16
	dc.w 	8
	dc.w	8
	dc.w 	8
	dc.w	5
	dc.l	palette_button31
	dc.l	palette_clicked_button31



arrow_up_graphics
 DC.W $0000,$0000
 DC.W $0020,$0000
 DC.W $00F8,$0000
 DC.W $03FE,$0000
 DC.W $0FFF,$8000
 DC.W $3FFF,$E000
 DC.W $01FC,$0000
 DC.W $01FC,$0000
 DC.W $01FC,$0000
 DC.W $01DC,$0000
 DC.W $0306,$0000

 DC.W $0060,$0000
 DC.W $01C0,$0000
 DC.W $0700,$0000
 DC.W $1C00,$0000
 DC.W $7000,$0000
 DC.W $C000,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $0400,$0000

 DC.W $0070,$0000
 DC.W $01DC,$0000
 DC.W $0707,$0000
 DC.W $1C01,$C000
 DC.W $7000,$7000
 DC.W $C000,$1800
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $0401,$0000


arrow_down_graphics
 DC.W $0306,$0000
 DC.W $01DC,$0000
 DC.W $01FC,$0000
 DC.W $01FC,$0000
 DC.W $01FC,$0000
 DC.W $3FFF,$E000
 DC.W $0FFF,$8000
 DC.W $03FE,$0000
 DC.W $00F8,$0000
 DC.W $0020,$0000
 DC.W $0000,$0000


 DC.W $0400,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $0600,$0000
 DC.W $C000,$0000
 DC.W $7000,$0000
 DC.W $1C00,$0000
 DC.W $0700,$0000
 DC.W $01C0,$0000
 DC.W $0060,$0000

 
 DC.W $0401,$0000
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $0603,$0000
 DC.W $C000,$1800
 DC.W $7000,$7000
 DC.W $1C01,$C000
 DC.W $0707,$0000
 DC.W $01DC,$0000
 DC.W $0070,$0000



arrow_left_graphics
 DC.W $0000,$0000
 DC.W $0030,$0000
 DC.W $00F0,$0000
 DC.W $03F0,$0C00
 DC.W $0FFF,$F000
 DC.W $3FFF,$C000
 DC.W $0FFF,$F000
 DC.W $03F0,$0C00
 DC.W $00F0,$0000
 DC.W $0030,$0000
 DC.W $0000,$0000

 DC.W $0030,$0000
 DC.W $00C0,$0000
 DC.W $0300,$0000
 DC.W $0C0F,$F000
 DC.W $3000,$0000
 DC.W $C000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000


 DC.W $0030,$0000
 DC.W $00C0,$0000
 DC.W $0300,$0000
 DC.W $0C0F,$F000
 DC.W $3000,$0000
 DC.W $C000,$0000
 DC.W $3000,$0000
 DC.W $0C0F,$F000
 DC.W $0300,$0000
 DC.W $00C0,$0000
 DC.W $0030,$0000

arrow_right_graphics
 DC.W $0000,$0000
 DC.W $0030,$0000
 DC.W $003C,$0000
 DC.W $C03F,$0000
 DC.W $3FFF,$C000
 DC.W $0FFF,$F000
 DC.W $3FFF,$C000
 DC.W $C03F,$0000
 DC.W $003C,$0000
 DC.W $0030,$0000
 DC.W $0000,$0000


 DC.W $0030,$0000
 DC.W $000C,$0000
 DC.W $0003,$0000
 DC.W $3FC0,$C000
 DC.W $0000,$3000
 DC.W $0000,$0C00
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000
 DC.W $0000,$0000

 
 DC.W $0030,$0000
 DC.W $000C,$0000
 DC.W $0003,$0000
 DC.W $3FC0,$C000
 DC.W $0000,$3000
 DC.W $0000,$0C00
 DC.W $0000,$3000
 DC.W $3FC0,$C000
 DC.W $0003,$0000
 DC.W $000C,$0000
 DC.W $0030,$0000


****end of arrow graphics

tick_box

 DC.W $3FFC
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $C000

 DC.W $FFFC
 DC.W $E000
 DC.W $E000
 DC.W $E000
 DC.W $E000
 DC.W $E000
 DC.W $C000

 DC.W $C000
 DC.W $000C
 DC.W $000C
 DC.W $000C
 DC.W $000C
 DC.W $000C
 DC.W $3FFC

 DC.W $3FFC
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $C000


tick_clicked_box

 DC.W $3FFC
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $C000

 DC.W $FFFC
 DC.W $E030
 DC.W $E060
 DC.W $E0C0
 DC.W $F980
 DC.W $E600
 DC.W $C000

 DC.W $C000
 DC.W $003C
 DC.W $006C
 DC.W $00CC
 DC.W $198C
 DC.W $060C
 DC.W $3FFC


*end of tick box

plus_graphics
 DC.W $3FFC
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $C000

 DC.W $FFFC
 DC.W $E300
 DC.W $E300
 DC.W $FFE0
 DC.W $E300
 DC.W $E300
 DC.W $C000

 DC.W $C000
 DC.W $030C
 DC.W $030C
 DC.W $1FEC
 DC.W $030C
 DC.W $030C
 DC.W $3FFC
minus_graphics
 DC.W $3FFC
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $FFF0
 DC.W $C000

 DC.W $FFFC
 DC.W $E000
 DC.W $E000
 DC.W $EFE0
 DC.W $E000
 DC.W $E000
 DC.W $C000

 DC.W $C000
 DC.W $000C
 DC.W $000C
 DC.W $0FEC
 DC.W $000C
 DC.W $000C
 DC.W $3FFC

plus_clicked_graphics
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC

 DC.W $0000
 DC.W $0300
 DC.W $0300
 DC.W $1FE0
 DC.W $0300
 DC.W $0300
 DC.W $0000

 DC.W $0000
 DC.W $0300
 DC.W $0300
 DC.W $1FE0
 DC.W $0300
 DC.W $0300
 DC.W $0000

minus_clicked_graphics
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC
 DC.W $FFFC

 DC.W $0000
 DC.W $0000
 DC.W $0000
 DC.W $0FE0
 DC.W $0000
 DC.W $0000
 DC.W $0000

 DC.W $0000
 DC.W $0000
 DC.W $0000
 DC.W $0FE0
 DC.W $0000
 DC.W $0000
 DC.W $0000

*end of plus minus graphics

page1_graphics 
 DC.W $7FFF,$FFE0
 DC.W $7FFF,$FF80
 DC.W $FFFF,$FE00
 DC.W $FC0F,$9E00
 DC.W $FE67,$1E00
 DC.W $FE67,$9E00
 DC.W $FE0F,$9E00
 DC.W $FE7F,$9E00
 DC.W $FE7F,$9E00
 DC.W $FC3E,$0600
 DC.W $FFFF,$FE00
 DC.W $E000,$0000
 DC.W $8000,$0000
 
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FF80
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $8000,$0000
 
 DC.W $8000,$0000
 DC.W $8000,$0060
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $1FFF,$FFE0
 DC.W $7FFF,$FFE0
 
 
 
 
page2_graphics 
 
 DC.W $7FFF,$FFE0
 DC.W $7FFF,$FF80
 DC.W $FFFF,$FE00
 DC.W $FC0F,$0E00
 DC.W $FE66,$6600
 DC.W $FE67,$E600
 DC.W $FE0F,$8E00
 DC.W $FE7F,$3E00
 DC.W $FE7E,$6600
 DC.W $FC3E,$0600
 DC.W $FFFF,$FE00
 DC.W $E000,$0000
 DC.W $8000,$0000

 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FF80
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $8000,$0000
 
 DC.W $8000,$0000
 DC.W $8000,$0060
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $1FFF,$FFE0
 DC.W $7FFF,$FFE0


page3_graphics

 
 DC.W $7FFF,$FFE0
 DC.W $7FFF,$FF80
 DC.W $FFFF,$FE00
 DC.W $F81E,$1E00
 DC.W $FCCC,$CE00
 DC.W $FCCF,$CE00
 DC.W $FC1F,$1E00
 DC.W $FCFF,$CE00
 DC.W $FCFC,$CE00
 DC.W $F87E,$1E00
 DC.W $FFFF,$FE00
 DC.W $E000,$0000
 DC.W $8000,$0000
 
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FF80
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $8000,$0000

 DC.W $8000,$0000
 DC.W $8000,$0060
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $1FFF,$FFE0
 DC.W $7FFF,$FFE0
 

page4_graphics 
 DC.W $7FFF,$FFE0
 DC.W $7FFF,$FF80
 DC.W $FFFF,$FE00
 DC.W $F81F,$1E00
 DC.W $FCCE,$1E00
 DC.W $FCCC,$9E00
 DC.W $FC19,$9E00
 DC.W $FCF8,$0E00
 DC.W $FCFF,$9E00
 DC.W $F87F,$0E00
 DC.W $FFFF,$FE00
 DC.W $E000,$0000
 DC.W $8000,$0000

   
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FF80
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $E000,$0000
 DC.W $8000,$0000
 
 DC.W $8000,$0000
 DC.W $8000,$0060
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $0000,$01E0
 DC.W $1FFF,$FFE0
 DC.W $7FFF,$FFE0


page1_clicked_graphics

 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FC0F,$9FE0
 DC.W $FE67,$1FE0
 DC.W $FE67,$9FE0
 DC.W $FE0F,$9FE0
 DC.W $FE7F,$9FE0
 DC.W $FE7F,$9FE0
 DC.W $FC3E,$07E0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 
 
 ds.w  13*2*2
page2_clicked_graphics


 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FC0F,$0FE0
 DC.W $FE66,$67E0
 DC.W $FE67,$E7E0
 DC.W $FE0F,$8FE0
 DC.W $FE7F,$3FE0
 DC.W $FE7E,$67E0
 DC.W $FC3E,$07E0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 
 ds.w 13*2*2 
 
page3_clicked_graphics 
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $F81E,$1FE0
 DC.W $FCCC,$CFE0
 DC.W $FCCF,$CFE0
 DC.W $FC1F,$1FE0
 DC.W $FCFF,$CFE0
 DC.W $FCFC,$CFE0
 DC.W $F87E,$1FE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 
 ds.w 13*2*2
 
page4_clicked_graphics 
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $F81F,$1FE0
 DC.W $FCCE,$1FE0
 DC.W $FCCC,$9FE0
 DC.W $FC19,$9FE0
 DC.W $FCF8,$0FE0
 DC.W $FCFF,$9FE0
 DC.W $F87F,$0FE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0
 DC.W $FFFF,$FFE0

 ds.w 13*2*2


palette_button0
 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8

palette_button1

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8




palette_button2

 ds.w 8

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 ds.w   8
 
palette_button3


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 ds.w   8

palette_button4

 ds.w   8
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_button5

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 

palette_button6

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8

palette_button7


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_button8
 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

  ds.w   8

palette_button9

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8




palette_button10

 ds.w 8

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 
palette_button11


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8

palette_button12

 ds.w   8
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_button13

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 

palette_button14

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8

palette_button15


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8




palette_button16
 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button17

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000





palette_button18

 ds.w 8

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 
palette_button19


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button20

 ds.w   8
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000



palette_button21

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 

palette_button22

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button23


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000



palette_button24
 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button25

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000





palette_button26

 ds.w 8

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 
palette_button27


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button28

 ds.w   8
 ds.w   8

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000




palette_button29

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 

palette_button30

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_button31


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000






palette_clicked_button0
 
 dc.w  $ff00
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $ff00

 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8

palette_clicked_button1

 dcb.w  8,$ff00 
 ds.w   8
 ds.w   8
 ds.w   8
 ds.w   8




palette_clicked_button2

  
 dc.w  $ff00
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $8100
 dc.w  $ff00



 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 ds.w   8
 
palette_clicked_button3

 dcb.w 8,$ff00
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 ds.w   8

palette_clicked_button4

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_clicked_button5

 dcb.w 8,$ff00
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 

palette_clicked_button6

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00




 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8

palette_clicked_button7


 dcb.w 8,$ff00
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_clicked_button8
 
 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

  ds.w   8

palette_clicked_button9

  dcb.w 8,$ff00
  ds.w   8
 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8




palette_clicked_button10

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00



 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 
palette_clicked_button11


 dcb.w 8,$ff00
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8

palette_clicked_button12

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8


palette_clicked_button13

 
 dcb.w 8,$ff00
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 

palette_clicked_button14

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00



 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8

palette_clicked_button15


 dcb.w 8,$ff00
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8




palette_clicked_button16
  
 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button17

 dcb.w 8,$ff00
 ds.w   8
 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000





palette_clicked_button18

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 
palette_clicked_button19

 dcb.w 8,$ff00
 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button20

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000



palette_clicked_button21


 dcb.w 8,$ff00
 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 

palette_clicked_button22

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00



 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button23


 dcb.w 8,$ff00
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000



palette_clicked_button24
 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w   8
 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button25

 dcb.w 8,$ff00
 ds.w   8
 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000





palette_clicked_button26

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 ds.w   8
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 
palette_clicked_button27


 dcb.w 8,$ff00 
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 ds.w   8
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button28

  dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00

 ds.w 8
 
  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button29

 dcb.w 8,$ff00

 ds.w   8


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


  dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 

palette_clicked_button30

 dc.w $ff00
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $8100
 dc.w $ff00



 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


palette_clicked_button31


 dcb.w 8,$ff00
 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000


 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

 dc.w $0000
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $7e00
 dc.w $0000

ok_button_graphics
 DC.W $7FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFF0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $FFFF,$FF1C,$67FF,$FFC0
 DC.W $FFFF,$FE4E,$67FF,$FFC0
 DC.W $FFFF,$FCE6,$4FFF,$FFC0
 DC.W $FFFF,$FCE6,$1FFF,$FFC0
 DC.W $FFFF,$FCE6,$4FFF,$FFC0
 DC.W $FFFF,$FE4E,$67FF,$FFC0
 DC.W $FFFF,$FF1C,$67FF,$FFC0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000

 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFF0
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000

 DC.W $8000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$000C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $1FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFFC


ok_clicked_button_graphics
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FF1C,$67FF,$FFFC
 DC.W $FFFF,$FE4E,$67FF,$FFFC
 DC.W $FFFF,$FCE6,$4FFF,$FFFC
 DC.W $FFFF,$FCE6,$1FFF,$FFFC
 DC.W $FFFF,$FCE6,$4FFF,$FFFC
 DC.W $FFFF,$FE4E,$67FF,$FFFC
 DC.W $FFFF,$FF1C,$67FF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC

 ds.w	4*13*2

cancel_custom_button
	dc.w	64
	dc.w	13
	dc.w	62
	dc.w	13
	dc.w	3
	dc.l	cancel_graphics
	dc.l	cancel_clicked_graphics

cancel_graphics
 DC.W $7FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFF0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $FF87,$CE73,$8602,$1FC0
 DC.W $FF33,$8633,$3333,$3FC0
 DC.W $FE7F,$8612,$7F3F,$3FC0
 DC.W $FE7F,$3242,$7F0F,$3FC0
 DC.W $FE7F,$0262,$7F3F,$3BC0
 DC.W $FF32,$7873,$3333,$33C0
 DC.W $FF86,$7873,$8602,$03C0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000

 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFF0
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000

 DC.W $8000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$000C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $1FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFFC

cancel_clicked_graphics
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 DC.W $FF0F,$9CE7,$0C04,$3FF8
 DC.W $FE67,$0C66,$6666,$7FF8
 DC.W $FCFF,$0C24,$FE7E,$7FF8
 DC.W $FCFE,$6484,$FE1E,$7FF8
 DC.W $FCFE,$04C4,$FE7E,$77F8
 DC.W $FE64,$F0E6,$6666,$67F8
 DC.W $FF0C,$F0E7,$0C04,$07F8
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 DC.W $FFFF,$FFFF,$FFFF,$FFF8
 ds.w	4*13*2

save_custom_button
	dc.w	64
	dc.w	13
	dc.w	62
	dc.w	13
	dc.w	3
	dc.l	savegrap
	dc.l	saveclickedgrap

savegrap
 DC.W $7FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFF0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $FFFF,$0F9C,$F007,$FFC0
 DC.W $FFFE,$670C,$F267,$FFC0
 DC.W $FFFE,$3F0E,$667F,$FFC0
 DC.W $FFFF,$1E66,$661F,$FFC0
 DC.W $FFFF,$C607,$0E7F,$FFC0
 DC.W $FFFE,$64F3,$0E67,$FFC0
 DC.W $FFFF,$0CF3,$9C07,$FFC0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000


 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFF0
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000


 DC.W $8000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$000C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $1FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFFC


saveclickedgrap
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$0F9C,$F007,$FFFC
 DC.W $FFFE,$670C,$F267,$FFFC
 DC.W $FFFE,$3F0E,$667F,$FFFC
 DC.W $FFFF,$1E66,$661F,$FFFC
 DC.W $FFFF,$C607,$0E7F,$FFFC
 DC.W $FFFE,$64F3,$0E67,$FFFC
 DC.W $FFFF,$0CF3,$9C07,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC

 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000


 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000

load_custom_button
	dc.w	64
	dc.w	13
	dc.w	62
	dc.w	13
	dc.w	3
	dc.l	loadgrap
	dc.l	loadclickedgrap
	


loadgrap
 DC.W $7FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFF0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $FFFE,$1F8F,$CE0F,$FFC0
 DC.W $FFFF,$3F27,$8727,$FFC0
 DC.W $FFFF,$3E73,$8733,$FFC0
 DC.W $FFFF,$3E73,$3333,$FFC0
 DC.W $FFFF,$3A73,$0333,$FFC0
 DC.W $FFFF,$3326,$7927,$FFC0
 DC.W $FFFE,$038E,$780F,$FFC0
 DC.W $FFFF,$FFFF,$FFFF,$FFC0
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000



 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFF0
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $E000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$0000



 DC.W $8000,$0000,$0000,$0000
 DC.W $8000,$0000,$0000,$000C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $0000,$0000,$0000,$003C
 DC.W $1FFF,$FFFF,$FFFF,$FFFC
 DC.W $7FFF,$FFFF,$FFFF,$FFFC



loadclickedgrap
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFE,$1F8F,$CE0F,$FFFC
 DC.W $FFFF,$3F27,$8727,$FFFC
 DC.W $FFFF,$3E73,$8733,$FFFC
 DC.W $FFFF,$3E73,$3333,$FFFC
 DC.W $FFFF,$3A73,$0333,$FFFC
 DC.W $FFFF,$3326,$7927,$FFFC
 DC.W $FFFE,$038E,$780F,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC
 DC.W $FFFF,$FFFF,$FFFF,$FFFC



 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000


 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000
 DC.W $0000,$0000,$0000,$0000



