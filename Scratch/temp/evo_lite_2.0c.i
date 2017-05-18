
		rsreset
_ciapra		rs.b	1	* peripheral data register for port a
_ciaprb		rs.b	1	* peripheral data register for port b
_ciaddra	rs.b	1	* data direction register a
_ciaddrb	rs.b	1	* data direction register b
_ciatalo	rs.b	1	* timer a low byte.
_ciatahi	rs.b	1	* timer a high byte.
_ciatblo	rs.b	1	* timer b low byte.
_ciatbhi	rs.b	1	* timer b high byte.
_ciatodlo	rs.b	1	* time-of-day counter low-byte.
_ciatodmid	rs.b	1	* time-of-day counter mid-byte.
_ciatodhi	rs.b	1	* time-of-day counter high-byte.
_ciatodhr	rs.b	1	* unused - not connected to the amiga
_ciasdr		rs.b	1	* serial data register
_ciaicr		rs.b	1	* interrupt control register
_ciacra		rs.b	1	* control register a
_ciacrb		rs.b	1	* control register b
		rsreset

_ciaa		=	$bfe001	* _ciaa is on an ODD address (the low byte)
_ciab		=	$bfd000	* _ciab is on an EVEN address (the high byte)
_custom		=	$dff000

		include	'include:hardware/adkbits.i'
		include	'include:hardware/cia.i'
		include	'include:hardware/custom.i'
		include	'include:hardware/dmabits.i'
		include	'include:hardware/intbits.i'

esc=$45
_LVOOpenResource=	-498
MR_SERIALPORT	=	0	;Amiga custom chip serial port registers & interrupts
MR_SERIALBITS	=	1	;Serial control bits (DTR,CTS, etc.)
MR_PARALLELPORT	=	2	;The 8 bit parallel data port
MR_PARALLELBITS	=	3	;All other parallel bits & interrupts (BUSY,ACK,etc.)
MR_ALLOCMISCRESOURCE	=	-6
MR_FREEMISCRESOURCE	=	-12

DSKB_DMAON		=	14

AbsExecBase		=	$4
AttnFlags		=	$128

LIB_VERSION		=	$14
LIB_OPENCNT		=	$20

gb_ChipRevBits0		=	$EC
gb_ActiView		=	$22
gb_copinit		=	$26

pr_WindowPtr		=	$B8

_LVOCacheControl	=	-$288
_LVOOpenDevice		=	-$1BC
_LVOVideoControl	=	-$2C4
_LVOSupervisor		=	-$1E
_LVOLoadView		=	-$DE
_LVODisownBlitter	=	-$1CE
_LVORethinkDisplay	=	-$186
_LVODisable		=	-$78
_LVODisplayAlert	=	-$5A
_LVOAddPort		=	-$162
_LVOFreeMem		=	-$D2
_LVOCloseLibrary	=	-$19E
_LVOCacheClearU		=	-$27C
_LVOWaitBlit		=	-$E4
_LVOUserState		=	-$9C
_LVOOwnBlitter		=	-$1C8
_LVOSetTaskPri		=	-$12C
_LVOSuperState		=	-$96
_LVORemove		=	-$FC
_LVOMakeScreen		=	-$17A
_LVOAllocSignal		=	-$14A
_LVOWaitTOF		=	-$10E
_LVORemPort		=	-$168
_LVOOldOpenLibrary	=	-$198
_LVOOpenLibrary		=	-$228
_LVOAllocMem		=	-$C6
_LVOFreeSignal		=	-$150
_LVOUnlockPubScreen	=	-$204
_LVOLockPubScreen	=	-$1FE
_LVOFindTask		=	-$126
_LVOCloseDevice		=	-$1C2
_LVOEnable		=	-$7E
_LVOColdReboot		=	-$2D6
_LVOForbid		=	-132
_LVOPermit		=	-138

