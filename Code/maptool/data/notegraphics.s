**************************************************************
****          NOTE GRAPHICS FOR USE IN EDITOR             ****
**************************************************************

BULB_SIZE	EQU 4
STEM_SIZE	EQU 7


	rsreset

note_up  rs.l 1
note_down rs.l 1
note_y_size	rs.w	1
position_information rs.w 1
note_length    rs.w 1

note_table


	dc.l notes4up
	dc.l notes4down
	dc.w 11
	dc.w 0
	dc.w 1

	dc.l notes8up
	dc.l notes8down
	dc.w 11
	dc.w 0
	dc.w 2
	
	dc.l notes16up
	dc.l notes16down
	dc.w 11
	dc.w 0
	dc.w 4

	dc.l quaver_up
	dc.l quaver_down
	dc.w 11
	dc.w 0
	dc.w 8


	dc.l crotchet_up
	dc.l crotchet_down
	dc.w 11
	dc.w 0
	dc.w 16

	dc.l minim_up
	dc.l minim_down
	dc.w 11
	dc.w 0
	dc.w 32

	dc.l semi_breive_graphics
	dc.l semi_breive_graphics
	dc.w 5
	dc.w -1
	dc.w 64

	dc.l breve_graphics
	dc.l breve_graphics
	dc.w 1
	dc.w -1
	dc.w 128


rest_table


	dc.l hemi_rest_graphics
	dc.l hemi_rest_graphics
	dc.w 13
	dc.w 5
	dc.w 1

	dc.l demi_rest_graphics
	dc.l demi_rest_graphics
	dc.w 10
	dc.w 5
	dc.w 2
	
	dc.l semi_rest_graphics
	dc.l semi_rest_graphics
	dc.w 8
	dc.w 5
	dc.w 4

	dc.l quaver_rest_graphics
	dc.l quaver_rest_graphics
	dc.w 8
	dc.w 5
	dc.w 8


	dc.l crotchet_rest_graphics
	dc.l crotchet_rest_graphics
	dc.w 8
	dc.w 5
	dc.w 16

	dc.l minim_and_semibreve_rest_graphics
	dc.l minim_and_semibreve_rest_graphics
	dc.w 2
	dc.w 5
	dc.w 32

	dc.l minim_and_semibreve_rest_graphics
	dc.l minim_and_semibreve_rest_graphics
	dc.w 2
	dc.w 6
	dc.w 64

	dc.l breve_rest_graphics
	dc.l breve_rest_graphics
	dc.w 1
	dc.w 5
	dc.w 128





blank_note
	dc.w	0,0

crotchet_up
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $1F00
 DC.W $7F00
 DC.W $FF00
 DC.W $7E00

minim_up
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $1F00
 DC.W $6300
 DC.W $C300
 DC.W $7E00


minim_down
 DC.W $7E00
 DC.W $C300
 DC.W $C600
 DC.W $F800
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000

crotchet_down
 DC.W $7E00
 DC.W $FF00
 DC.W $FE00
 DC.W $F800
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000


quaver_up
 DC.W $0300
 DC.W $0280
 DC.W $0240
 DC.W $0220
 DC.W $0220
 DC.W $0200
 DC.W $0200
 DC.W $1F00
 DC.W $7F00
 DC.W $FF00
 DC.W $7E00

quaver_down
 DC.W $7E00
 DC.W $FF00
 DC.W $FE00
 DC.W $F800
 DC.W $8000
 DC.W $8000
 DC.W $8800
 DC.W $8800
 DC.W $9000
 DC.W $A000
 DC.W $C000


semi_breive_graphics
 DC.W $1FC0
 DC.W $78F0
 DC.W $E038
 DC.W $78F0
 DC.W $1FC0

breve_graphics
 DC.W $CFE6
 DC.W $FC7E
 DC.W $F01E
 DC.W $FC7E
 DC.W $CFE6


treble_clef
 DC.W $0038,$0000
 DC.W $00FC,$0000
 DC.W $00C2,$0000
 DC.W $0181,$0000
 DC.W $0101,$0000
 DC.W $0103,$0000
 DC.W $0107,$0000
 DC.W $008E,$0000
 DC.W $009E,$0000
 DC.W $00FC,$0000
 DC.W $01F8,$0000
 DC.W $03E0,$0000
 DC.W $07E0,$0000
 DC.W $0F90,$0000
 DC.W $1F10,$0000
 DC.W $3E1F,$E000
 DC.W $783F,$FC00
 DC.W $7078,$1E00
 DC.W $E0F4,$0F00
 DC.W $C0E4,$0700
 DC.W $C0C2,$0700
 DC.W $C062,$0600
 DC.W $6011,$0C00
 DC.W $3001,$1800
 DC.W $0E01,$F000
 DC.W $01FF,$8000
 DC.W $0000,$8000
 DC.W $0000,$4000
 DC.W $0000,$4000
 DC.W $0070,$2000
 DC.W $00F8,$2000
 DC.W $00F8,$2000
 DC.W $0070,$4000
 DC.W $003F,$8000

flat
 DC.W $8000
 DC.W $8000
 DC.W $8000
 DC.W $8000
 DC.W $FE00
 DC.W $C300
 DC.W $8E00
 DC.W $F800

sharp_graphics
 DC.W $0400
 DC.W $4600
 DC.W $7C00
 DC.W $C400
 DC.W $4600
 DC.W $7C00
 DC.W $C400
 DC.W $4000


natural_graphics
 DC.W $C000
 DC.W $C000
 DC.W $FC00
 DC.W $CC00
 DC.W $FC00
 DC.W $0C00
 DC.W $0C00
 dc.w 0


notes16up
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $0200
 DC.W $1F00
 DC.W $7F00
 DC.W $FF00
 DC.W $7E00

notes16down
 DC.W $7E00
 DC.W $FF00
 DC.W $FE00
 DC.W $F800
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $4000
 DC.W $7C00
 DC.W $4000
 DC.W $7C00
notes8up
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $0200
 DC.W $1F00
 DC.W $7F00
 DC.W $FF00
 DC.W $7E00
notes8down
 DC.W $7E00
 DC.W $FF00
 DC.W $FE00
 DC.W $F800
 DC.W $4000
 DC.W $4000
 DC.W $7C00
 DC.W $4000
 DC.W $7C00
 DC.W $4000
 DC.W $7C00


notes4up
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $1F00
 DC.W $7F00
 DC.W $FF00
 DC.W $7E00
notes4down
 DC.W $7E00
 DC.W $FF00
 DC.W $FE00
 DC.W $F800
 DC.W $7C00
 DC.W $4000
 DC.W $7C00
 DC.W $4000
 DC.W $7C00
 DC.W $4000
 DC.W $7C00

notes2up
 DC.W $03E0
 DC.W $0210
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $1F00
 DC.W $7FE0
 DC.W $FF00
 DC.W $7E00
notes2down
 DC.W $3F00
 DC.W $7F80
 DC.W $FE00
 DC.W $7C00
 DC.W $3E00
 DC.W $2000
 DC.W $3E00
 DC.W $2000
 DC.W $3E00
 DC.W $2100
 DC.W $3E00

notes1up
 DC.W $03E0
 DC.W $0210
 DC.W $03E0
 DC.W $0210
 DC.W $03E0
 DC.W $0200
 DC.W $03E0
 DC.W $1F00
 DC.W $7FE0
 DC.W $FF00
 DC.W $7E00
notes1down
 DC.W $3F00
 DC.W $7F80
 DC.W $FE00
 DC.W $7C00
 DC.W $3E00
 DC.W $2000
 DC.W $3E00
 DC.W $2100
 DC.W $3E00
 DC.W $2100
 DC.W $3E00


****extensions
extension1
 DC.W $7000
 DC.W $F800
 DC.W $7000

extension2
 DC.W $7070
 DC.W $F8F8
 DC.W $7070


****insert grap

insert_mark
 DC.W $FD8C,$7800
 DC.W $31CC,$CC00
 DC.W $31EC,$E000
 DC.W $31BC,$7000
 DC.W $319C,$1C00
 DC.W $318C,$CC00
 DC.W $FD8C,$7800
 DC.W $0000,$0000
 DC.W $0070,$0000
 DC.W $0070,$0000
 DC.W $0070,$0000
 DC.W $0070,$0000
 DC.W $03FE,$0000
 DC.W $01FC,$0000
 DC.W $00F8,$0000
 DC.W $0070,$0000
 DC.W $0020,$0000



hemi_rest_graphics
 DC.W $0CC0
 DC.W $0F40
 DC.W $0080
 DC.W $1980
 DC.W $1F00
 DC.W $0100
 DC.W $6600
 DC.W $7A00
 DC.W $0400
 DC.W $CC00
 DC.W $F800
 DC.W $0800
 DC.W $0800



demi_rest_graphics
 DC.W $1980
 DC.W $1E80
 DC.W $0100
 DC.W $3300
 DC.W $3E00
 DC.W $0200
 DC.W $CC00
 DC.W $F400
 DC.W $0800
 DC.W $0800


semi_rest_graphics
 DC.W $6600
 DC.W $7A00
 DC.W $0400
 DC.W $CC00
 DC.W $F800
 DC.W $0800
 DC.W $1000
 DC.W $1000


quaver_rest_graphics
 DC.W $6600
 DC.W $7A00
 DC.W $0400
 DC.W $0400
 DC.W $0800
 DC.W $0800
 DC.W $1000
 DC.W $1000

crotchet_rest_graphics
 DC.W $4000
 DC.W $3000
 DC.W $6000
 DC.W $C000
 DC.W $3000
 DC.W $7800
 DC.W $8000
 DC.W $4000

minim_and_semibreve_rest_graphics
 DC.W $F800
 DC.W $F800


breve_rest_graphics
 DC.W $F000
 DC.W $F000
 DC.W $F000

