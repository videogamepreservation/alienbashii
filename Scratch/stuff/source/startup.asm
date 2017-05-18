
*
* Startup.asm  - A working tested version of startup from Howtocode6
*
* Written by CJ of SAE... Freeware. Share and Enjoy!
*
* This code sets up one of two copperlists (one for PAL and one for NTSC)
* machines. It shows something to celebrate 3(?) years since the Berlin
* wall came down :-) Press left mouse button to return to normality.
* Tested on Amiga 3000 (ECS/V39 Kickstart) and Amiga 1200 (AGA/V39)
*
* $VER: startup.asm V6.tested (17.4.92)
* Valid on day of purchase only. No re-admission. No rain-checks.
* Now less bugs and more likely to work.
*
* Tested with Hisoft Devpac V3 and Argasm V1.09d

	opt	l-,o+             	; auto link, optimise on

 	opt	o3-			; add this for Devpac 2+
	machine mc68000			; and this for Devpac 3

	section	mycode,code		; need not be in chipram

	incdir	"include:"
	include	"exec/types.i"
	include	"exec/funcdef.i"	; keep code simple and
	include	"exec/exec_lib.i"	; easy to read - use
	include	"exec/exec.i"          	; the includes!
        include	"libraries/dosextens.i"
	include	"graphics/gfxbase.i"
	include	"graphics/graphics_lib.i"

	include "iconstartup.i"	; Allows startup from icon


	move.l	4.w,a6
	sub.l   a1,a1          	; Zero - Find current task
	jsr	_LVOFindTask(a6)

	move.l	d0,a1
	moveq	#127,d0  	; task priority to very high...
	jsr	_LVOSetTaskPri(a6)

	move.l	4.w,a6		; get ExecBase
	lea	gfxname(pc),a1	; graphics name
	moveq	#33,d0		; Kickstart 1.2 or higher
	jsr	_LVOOpenLibrary(a6)
	tst.l	d0
	beq	End		; failed to open? Then quit

	move.l	d0,gfxbase
	move.l	d0,a6
	move.l	gb_ActiView(a6),wbview
				; store current view address

	sub.l	a1,a1		; clear a1
	jsr 	_LVOLoadView(a6) 	; Flush View to nothing
	jsr	_LVOWaitTOF(a6) 	; Wait once
	jsr	_LVOWaitTOF(a6) 	; Wait again.

; Note: Something could come along inbetween the LoadView and
; your copper setup. But only if you decide to run something
; else after you start loading the demo. That's far to stupid
; to bother testing for in my opininon!!!  If you want
; to stop this, then a Forbid() won't work (WaitTOF() disables
; Forbid state) so you'll have to do Forbid() *and* write your
; own WaitTOF() replacement. No thanks... I'll stick to running
; one demo at a time :-)

        move.l	4.w,a6
        cmp.w	#36,LIB_VERSION(a6)     ; check for Kickstart 2
        blt.s	.oldks			; nope...

; kickstart 2 or higher.. We can check for NTSC properly...

	move.l  GfxBase,a6
	btst	#2,gb_DisplayFlags(a6)  ; Check for PAL
	bne.s   .pal
	bra.s	.ntsc

.oldks	; you really should upgrade!  Check for V1.x kickstart


	move.l	4.w,a6			; execbase
	cmp.b	#50,VBlankFrequency(a6) ; Am I *running* PAL?
	bne.s	.ntsc

.pal	move.l	#mycopper,$dff080 	; bang it straight in.
	bra.s	.lp

.ntsc	move.l	#mycopperntsc,$dff080


.lp	btst	#6,$bfe001              ; ok.. I'll do an input
	bne.s	.lp                     ; handler next time.


CloseDown:
	move.l	wbview(pc),a1
	move.l	gfxbase,a6
	jsr	_LVOLoadView(a6) 	; Fix view
        jsr	_LVOWaitTOF(a6)
        jsr	_LVOWaitTOF(a6)         ; wait for LoadView()

	move.l	gb_copinit(a6),$dff080	 ; Kick it into life

	move.l	a6,a1
	move.l	4.w,a6
	jsr	_LVOCloseLibrary(a6) 	; close graphics.library

End:    moveq   #0,d0			; clear d0 for exit
	rts                             ; back to workbench/cli


wbview  	dc.l	0
gfxbase 	dc.l	0
gfxname 	dc.b	"graphics.library",0



	section mydata,data_c	        ;  keep data & code seperate!

mycopper	dc.w	$100,$0200	; otherwise no display!
        	dc.w	$180,$00
        	dc.w	$8107,$fffe    	; wait for $8107,$fffe
		dc.w	$180
co		dc.w	$f0f      	; background red
		dc.w	$d607,$fffe	; wait for $d607,$fffe
		dc.w	$180,$ff0      	; background yellow
        	dc.w	$ffff,$fffe
        	dc.w	$ffff,$fffe

mycopperntsc
		dc.w	$100,$0200	; otherwise no display!
        	dc.w	$180,$00
        	dc.w	$6e07,$fffe    	; wait for $6e07,$fffe
        	dc.w	$180,$f00      	; background red
		dc.w	$b007,$fffe	; wait for $b007,$fffe
		dc.w	$180,$ff0      	; background yellow
        	dc.w	$ffff,$fffe
		dc.w	$ffff,$fffe

