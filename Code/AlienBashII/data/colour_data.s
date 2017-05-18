*--------------Level Palettes------------*

PALETTE_BRIGHT	EQU	0
PALETTE_NORMAL	EQU	1
PALETTE_DIM1	EQU	2
PALETTE_DIM2	EQU	3
PALETTE_DIM3	EQU	4
PALETTE_DIM4	EQU	5

Generator_Palette
	dc.w	$642,$79b,$488,$366
	dc.w	$344,$111,$853,$b86
	dc.w	$962,$742,$532,$321
	dc.w	$cb2,$462,$351,$eed
	

Level_1_Snow_Colour_list
	dc.w	$642,$7ad,$47b,$257
	dc.w	$335,$111,$853,$b86
	dc.w	$962,$742,$532,$321
	dc.w	$cb2,$462,$351,$ace

Level_1_Colour_List_Bright
	dc.w	$975,$bdf,$7ad,$58a
	dc.w	$668,$444,$b86,$eb9
	dc.w	$c95,$a75,$865,$654
	dc.w	$fe5,$795,$684,$fff

Level_1_Colour_list
	dc.w	$642,$8ad,$47a,$255
	dc.w	$335,$111,$853,$b86
	dc.w	$962,$742,$532,$321
	dc.w	$cb2,$462,$351,$eed
Faded_Palettes
	ds.w	16*4

Level_1_Sprite_Colours
	dc.w	$000,$a98,$57b,$468
	dc.w	$356,$345,$334,$132
	dc.w	$531,$0a0,$952,$071
	dc.w	$733,$0a0,$c84,$071

panel_cols
	dc.w	$000,$9dd,$6aa,$488
	dc.w	$366,$053,$132,$741
	dc.w	$952,$733,$622,$510
	dc.w	$310,$043,$bc5,$a72

Loader_Cols
	dc.w	$000,$000,$344,$566
	dc.w	$122,$788,$9bb,$89a
	dc.w	$abb,$455,$233,$011
	dc.w	$677,$799,$9aa,$00a

ball_cols
	dc.w	$000,$637,$410,$423
	dc.w	$426,$639,$313,$415
	dc.w	$526,$529,$35c,$414
	dc.w	$527,$43a,$65d,$68e

ball_cols2
	dc.w	$000,$622,$301,$402
	dc.w	$614,$814,$313,$525
	dc.w	$627,$738,$95c,$414
	dc.w	$527,$43a,$65d,$68d
		