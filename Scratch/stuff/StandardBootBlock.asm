_LVOFindResident  equ -96
LIB_REVISION      equ 22

Start:
  dc.b    'DOS',0
  dc.l    $C0200F19
  dc.l    $00000370
  lea     DosLibrary,a1
  jsr     _LVOFindResident(a6)
  tst.l   d0
  beq.s   NoDOS
  move.l  d0,a0
  move.l  LIB_REVISION(a0),a0
  moveq.l #0,d0
ReturnControl:
  rts
NoDOS:
  moveq.l #-1,d0
  bra.s   ReturnControl
DosLibrary
  dc.b    'dos.library',0
