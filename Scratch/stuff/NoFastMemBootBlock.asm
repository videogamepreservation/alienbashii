ExecBase         equ 4
_LVOOpenLibrary  equ -408
_LVOCloseLibrary equ -414
_LVODisplayAlert equ -90
_LVOFindResident equ -96
_LVOAvailMem     equ -216
_LVOAllocMem     equ -198
LIB_REVISION     equ 22

start:
  dc.b 'DOS',0                 ; so we can be booted
  dc.l $6e1ebbb3               ; checksum
  dc.l $00000370
  movem.l d0-d7/a0-a6,-(sp)    ; save registers
  bsr message                  ; display the alert
  movem.l (sp)+,d0-d7/a0-a6    ; restore registers
  lea doslibrary,a1
  jsr _LVOFindResident(a6)     ; see if dos.library still exists
  tst.l d0
  beq nodos                    ; it doesn't
  move.l d0,a0                 ; it does!
  move.l LIB_REVISION(a0),a0
  moveq.l #0,d0                ; a return of 0 means we are bootable
returncontrol:
  rts

nodos:
  moveq.l #-1,d0               ; and -1 we aren't
  bra.s returncontrol

doslibrary
  dc.b 'dos.library',0

message:
  move.l ExecBase,a6
  lea    intuitionlibrary,a1
  jsr    _LVOOpenLibrary(a6)   ; open intuition
  move.l d0,a6

  lea    alerttext,a0          ; put address of alert text in a0
  move.l #0,d0                 ; RECOVERABLE_ALERT
  move.l #55,d1                ; height
  jsr    _LVODisplayAlert(a6)  ; display the alert
  move.l d0,d2                 ; save the return in d2
  move.l a6,a1
  move.l ExecBase,a6
  jsr    _LVOCloseLibrary(a6)  ; don't need intuition anymore
  tst.l  d2                    ; see if return from alert was TRUE
  bne.s  nofastmem             ; it was
  rts

nofastmem:
 move.l  #$20004,d1            ; MEMF_FAST|MEMF_LARGEST
 jsr     _LVOAvailMem(a6)      ; how much is there
 tst.l   d0                    ; if none at all, return
 beq.s   nonethere
 jsr     _LVOAllocMem(a6)      ; allocate it
 tst.l   d0                    ; if we didn't fail,
 bne.s   nofastmem             ; go back for the next largest block
nonethere:
  rts

alerttext
  dc.b 0,60,20,'NoFastMem bootblock (c) 1989 by Jonathan Potter',0,1
  dc.b 0,60,30,'Press Left Mouse Button to turn off Fast Memory',0,1
  dc.b 0,60,40,'Press Right Mouse Button to enable Fast Memory.',0,0

intuitionlibrary
  dc.b "intuition.library",0

  end
