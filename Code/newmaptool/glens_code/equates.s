;----------------------------------------------------------------
;* MAPTOOL related equates
;----------------------------------------------------------------


;USE_ALIEN_DATA	equ	1		* Comment out to remove alien data

ScrPixelWidth	=	320*2		* change pixelwidth to 640 for HIRES
ScrPixelHeight	=	256		* or use 320 width for LORES modes..
ScrDepth	=	8

ScrByteWidth	=	ScrPixelWidth/8	* screen width in bytes..

INTB_HIRES	=	15


COPPER_SCREEN_OFFSET	EQU $2c
BUTTON_WINDOW_OFFSET	EQU 192

BUTTON_SCREEN_POSITION EQU BUTTON_WINDOW_OFFSET+COPPER_SCREEN_OFFSET

RES_BYTES	equ	ScrPixelWidth/8
RES_HEIGHT	equ	256


PLANE_HEIGHT	equ	200
BYTES_PER_ROW	equ 	ScrPixelWidth/8

SECRES_BYTES	equ	80
SECRES_HEIGHT	equ	256


SECBYTES_PER_ROW	equ 	640/8

;----------------------------------------------------------------
;* SYSTEM related equates
;----------------------------------------------------------------

exec	 equ	4		; amiga executive o/s base

SERPER   equ   $032		; serial port period and control
SERDATR  equ   $018		; serial port data and status read
SERDAT	 equ   $030
INTREQ   equ   $09c		; interrupt request bits
intreqr	equ    $01e
INTENA	 equ   $09a             	; interrupt enable bits


CUSTOM	EQU	$DFF000		; start of amigas hardware
BPLCONO	EQU	$100
BPLCON1	EQU	$102
BPLCON2	EQU	$104
BPLCON3	EQU	$106
BPL1MOD EQU	$108
BPL2MOD EQU	$10a
DDFSTRT	EQU	$092
DDFSTOP	EQU	$094
DIWSTRT	EQU	$08E
DIWSTOP	EQU	$090
VPSOR	EQU	$004
COLOUR0 EQU	$180
COLOUR1 EQU	$182
COLOUR2	EQU	$184
COLOUR3	EQU	$186
DMACON	EQU	$096
COP1LCH	EQU	$080
COPJMP1	EQU	$088

COP2LCH	EQU	$084
COPJMP2	EQU	$08a

DMAF_BLITTER	EQU   $0040

DMAF_BLTDONE	EQU   $4000
DMAF_BLTNZERO	EQU   $2000

DMAB_BLTDONE	EQU   14
bltddat	EQU   $000
dmaconr	EQU   $002
vposr	EQU   $004
vhposr	EQU   $006
dskdatr	EQU   $008
joy0dat	EQU   $00A
joy1dat	EQU   $00C
joytest	equ   $036
clxdat	EQU   $00E

bltcon0	EQU   $040
bltcon1	EQU   $042
bltafwm	EQU   $044
bltalwm	EQU   $046
bltcpt	EQU   $048
bltbpt	EQU   $04C
bltapt	EQU   $050
bltdpt	EQU   $054
bltsize	EQU   $058

bltcmod	EQU   $060
bltbmod	EQU   $062
bltamod	EQU   $064
bltdmod	EQU   $066

bltcdat	EQU   $070
bltbdat	EQU   $072
bltadat	EQU   $074

dsksync	EQU   $07E

cop1lc	EQU   $080
cop2lc	EQU   $084

bpldat	EQU   $110
MODE_OLD	EQU   1005
MODE_NEW	EQU   1006

hard_only	equ	0
save_alien_data	equ	0



output equ -60
openlibrary equ -408
closelibrary equ -414
exec_base equ 4
find_task equ -294
write equ -48
open equ -30
close equ -36
read  equ -42
forbid equ -132
permit equ -138
disable equ -120
freemem	equ	-$d2
allocmem equ	-$c6
ownblitter	equ	-456
disownblitter	equ	-462

MEM_CHIP	EQU $02
MEM_FAST EQU MEM_CHIP
MEM_PUBLIC	EQU	$01
MEM_CLEAR EQU $10000

LO_RES_SPRITES	equ	$0000		;Bit7=0, Bit6=0
HI_RES_SPRITES	equ	$0080		;Bit7=1, Bit6=0

LO_RES_MODE	equ	0
MED_RES_MODE	equ	1