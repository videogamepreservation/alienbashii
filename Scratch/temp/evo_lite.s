
;/* Evolution System-Kernal (LITE EDITION!) v2.0d
  * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  * Copyright © 1991-1996 By Trevor Leigh Mensah / Centillion Software.
  * All Rights Are Reserved.
  *
  * This software is provided as-is and is subject to change without notice;
  * No warranties are made or implied.  All use is entirely at your own risk. 
  * Absolutely no liability or responsibility is assumed whatsoever.
  *
  * Provided Kernal functions: (All Program counter relative)
  * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  * _LVOAllocSystem	: Operating System friendly takeover functions.
  * _LVOFreeSystem	: Restore Operating System to its original state.
  * _LVOAddIrqServer	: Install an interrupt (0-13) handler into cpu vectors
  * _LVORemIrqServer	: Remove interrupt handlers installed with AddIrqServer
  * _LVOSetIrqBits	: Set irq control bits (kernel compatible method)
  * _LVOClrIrqBits	: Clear irq control bits (kernel compatible method)
  * _LVOCopperIrqSync	: Replacement vblank function, use with clist retrigger
  * _LVOGetVBR		: Return address of the current cpu vectorbase
  * _LVODiskDone	: If disk (hardware) is doing a write, pause until done
  * _LVONewCopper	: Activate a new Copperlist in copper address 1
  * _LVONewCopper2	: Activate a new Copperlist in copper address 2
  * _LVOBlitDone	: Simple hardware wait until blitter is free.
  * _LVOSetVolume	: Just set volume of all sound channels (not dma)
  * _LVOSaveCIA		: Save current contents of ciaa/b chip registers
  * _LVORestoreCIA	: Restore ciaa/b chip registers from copy of originals
  * *_LVOAllocCIAB	: Allocate either Timer A or Timer B in ciab
  * *_LVOSetCIABSpeed	: Set Timer Speed for either Timer A or Timer B in ciab
  * *_LVOUpdateCIAB	: Interrupt call to check Timer A or Timer B in ciab
  * *_LVOAllocCIAA	: Allocate either Timer A or Timer B in ciaa
  * *_LVOSetCIAASpeed	: Set Timer Speed for either Timer A or Timer B in ciaa
  * *_LVOUpdateCIAA	: Interrupt call to check Timer A or Timer B in ciaa
  * *_LVOScanConfig	: Check for type of custom chips, cpu, kickstart, etc.
  * *_LVOSoftReset	: OS friendly enforced system reboot.
  * *_LVOSetCaches	: OS friendy setting of caches (via _LVOCacheControl)
  * *_LVOClearCaches	: OS friendy flush of caches (via _LVOCacheClearU)
  * *_LVOFindAssign	: Does file exist? (supresses insert disk requesters)
  * *_LVOLoadDosFile	: Load file (OS mounted device) into any address.
  * *_LVOSaveDosFile	: Save file (OS mounted device) from any address.
  * *_LVOLockDisk	: Wait for user to insert a disk/device (OS friendly)
  * *_LVOLockFile	: Attempt to lock a file on any device (OS friendly)
  * *_LVOHunkRelocate	: Relocate dos format executable file into raw code.
  * *_LVOHunkLength	: Calculate the memory required for a relocated file
  *
  */
		section	lite_engine,code

		include	'sys:evo_lite_2.0c.i'
	
Begin:		bsr.w	_LVOAllocSystem		* Take Over System..
		beq.s	exit_now

		lea	readkb(pc),a0		* Add Keyboard Interrupt
		moveq	#INTB_PORTS,d0
		bsr.w	_LVOAddIrqServer

;/* MainVBL()
  *
  */
;		bsr	ActivateSystem

MainVBL:	btst	#CIAB_GAMEPORT0,_ciaa	* Left Mouse?
		beq.s	.exit_vbl

		move.b	Key(pc),d0		
		cmp.b	#esc,d0			* Escape Key?
		bne.s	MainVBL
.exit_vbl
;		bsr	DeactivateSystem

		bsr.w	_LVOFreeSystem		* Restore the System..
exit_now:	rts

		cnop	0,4
readkb:		lea	KeyMatrix(pc),a0
		bsr.w	_LVOGetKeys
		rts
		
;/* AllocSystem() v2.0d (SAFE-MODE VERSION)
  * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  * Copyright © 1991-1996 By Trevor Leigh Mensah / Centillion Software.
  * All Rights Are Reserved.
  *
  * $Notes:
  * ¯¯¯¯¯¯¯
  * This is a full system takeover that tries to be as safe as it possibly can
  * considering there is no 'official' way of taking over the amiga`s custom
  * hardware. First it attempts to allocate as much as it can from the system
  * (this includes the 'serial port', 'parallel port' and 'audio channels')
  * doing this addes an extra margin of saftey since now we wont start if the
  * user was say printing, accessing parnet or downloading on a modem, etc. 
  * Taking over with these activies going on could make us crash on re-entry.
  *
  * Eventually we disables multitasking and preserve the state of custom chip
  * hardware registers and complex interface adaptors (was tricky!). Once this
  * is complete a full installation of all 14 interrupts is done. Also null
  * exception handlers are installed to prevent gurus. Your code should return
  * back to the OS (safely) without any crash and with everything intact. No
  * dissassembler / tracer / monitor functions are in the LITE version.
  *  
  * Once takeover has occured the OS will be completely HALTED. All interrupts
  * and custom hardware will be in use by our system. We have complete access
  * to ALL the hardware and the total control of the machine at our disposal.
  * All interrupts are running under our software. To allocate an interrupt you
  * must use the provided 'AddIrqServer' function as this automatically handles
  * all 14 multiplexed interrupts so you can specify any amiga interrupt to
  * install. eg. ports interrupt, blitter queue interrupt, and so on. Note we
  * are running at the lowest level possible (bashing at the bare metal) with
  * no system interaction whatsoever so no use of any of the amiga operating
  * system functions are allowed other than those provided through our kernal
  * (such as device loading/saving) etc.
  *
  * $Takeover Steps:
  * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  * Firstly in AllocSystem() we;
  *
  * 01.System friendly opening of used libraries, dos, graphics, etc.
  * 02.System friendly allocation of audio channels and hardware..
  * 03.System friendly allocation of serial port & registers hardware..
  * 04.System friendly allocation of parallel port & registers hardware..
  * 05.System friendly reset of sprite-res (as _LVOLoadView is bugged)..
  * 06.System friendly load view to create a 'null view' - zero aga+ registers
  * 07.System friendly setting of our task to highest priority..
  * 08.System friendly disabling of operating system requesters..
  *
  * Now in the Shared Part, DeactivateSystem() we ;
  *
  * 09.System friendly allocation of blitter hardware..
  * 10.System friendly disable of multitasking..
  * 11.System friendly call to Supervisor - I am the Law!
  * 12.Wait for hardware custom register disk dma to finish..
  * 13.Wait for hardware custom register blit dma to finish..
  * 14.Preserve hardware custom register status of dmacon..
  * 15.Preserve hardware custom register status of intreq..
  * 16.Preserve hardware custom register status of intena..
  * 17.Preserve hardware custom register status of adkcon..
  * 18.Preserve hardware custom register status of ciaa hardware..
  * 19.Preserve hardware custom register status of ciab hardware..
  * 20.Preserve entire vectorbase include old cpu interrupts & traps..
  * 21.Install our custom irq/trap/exception handlers
  *
  * And finally from AllocSystem();
  *
  * 22.Install null copperlist views.
  *
  * then Return..
  */
Version:	dc.b	"$VER: Evolution System Kernal v2.0d (Lite Edition)",$a
		dc.b	"Copyright © 1991-1996 By Trevor Leigh Mensah.",$a
		dc.b	"All Rights Reserved.",0

		cnop	0,4
VecList:	dc.w	SimpleRevive-VecList	* $08 (Bus Error)
		dc.w	SimpleRevive-VecList	* $0C (Address Error)
		dc.w	SimpleRevive-VecList	* $10 (Illega Instruction)
		dc.w	SimpleRevive-VecList	* $14 (Divide by Zero)
		dc.w	SimpleRevive-VecList	* $18 (CHK Exception)
		dc.w	SimpleRevive-VecList	* $1C (TRAPV Error)
		dc.w	SimpleRevive-VecList	* $20 (Privilege Violation)
		dc.w	SimpleRevive-VecList	* $24 (Trace Exception)
		dc.w	SimpleRevive-VecList	* $28 (Axxx inst Emulation)
		dc.w	SimpleRevive-VecList	* $2C (Fxxx inst Emulation)
		dc.w	SimpleRevive-VecList	* $30 (Unassigned)
		dc.w	SimpleRevive-VecList	* $34 (CP-Protocol Violation)
		dc.w	SimpleRevive-VecList	* $38 (Format Error)
		dc.w	SimpleRevive-VecList	* $3C (Uninitialised irq)
		dc.w	SimpleRevive-VecList	* $40 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $44 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $48 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $4C (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $50 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $54 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $58 (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $5C (Unassigned, Reserved)
		dc.w	SimpleRevive-VecList	* $60 (Spurious Interrupt) 
		dc.w	Level1_IRQ-VecList	* $64 (Level 1 Interrupt)
		dc.w	Level2_IRQ-VecList	* $68 (Level 2 Interrupt)
		dc.w	Level3_IRQ-VecList	* $6C (Level 3 Interrupt)
		dc.w	Level4_IRQ-VecList	* $70 (Level 4 Interrupt)
		dc.w	Level5_IRQ-VecList	* $74 (Level 5 Interrupt)
		dc.w	Level6_IRQ-VecList	* $78 (Level 6 Interrupt)
		dc.w	Level7_IRQ-VecList	* $7C (Level 7 Interrupt)
		dc.w	NullVec-VecList		* $80 (Trap 00 Ptr -TRAP #0)
		dc.w	NullVec-VecList		* $84 (Trap 01 Ptr -TRAP #1)
		dc.w	NullVec-VecList		* $88 (Trap 02 Ptr -TRAP #2)
		dc.w	NullVec-VecList		* $8C (Trap 03 Ptr -TRAP #3)
		dc.w	NullVec-VecList		* $90 (Trap 04 Ptr -TRAP #4)
		dc.w	NullVec-VecList		* $94 (Trap 05 Ptr -TRAP #5)
		dc.w	NullVec-VecList		* $98 (Trap 06 Ptr -TRAP #6)
		dc.w	NullVec-VecList		* $9C (Trap 07 Ptr -TRAP #7)
		dc.w	NullVec-VecList		* $A0 (Trap 08 Ptr -TRAP #8)
		dc.w	NullVec-VecList		* $A4 (Trap 09 Ptr -TRAP #9)
		dc.w	NullVec-VecList		* $A8 (Trap 10 Ptr -TRAP #10)
		dc.w	NullVec-VecList		* $AC (Trap 11 Ptr -TRAP #11)
		dc.w	NullVec-VecList		* $B0 (Trap 12 Ptr -TRAP #12)
		dc.w	NullVec-VecList		* $B4 (Trap 13 Ptr -TRAP #13)
		dc.w	NullVec-VecList		* $B8 (Trap 14 Ptr -TRAP #14)
		dc.w	NullVec-VecList		* $BC (Trap 15 Ptr -TRAP #15)
		dc.w	NullVec-VecList		* $C0 (FPCP Bra/Set Unordered Condition)
		dc.w	NullVec-VecList		* $C4 (FPCP Inexact Result)
		dc.w	NullVec-VecList		* $C8 (FPCP Divide by Zero)
		dc.w	NullVec-VecList		* $CC (FPCP Underflow)
		dc.w	NullVec-VecList		* $D0 (FPCP Operand Error)
		dc.w	NullVec-VecList		* $D4 (FPCP Signalling Not-A-Number)
		dc.w	NullVec-VecList		* $D8 (Unassigned, Reserved)
		dc.w	NullVec-VecList		* $DC (PMMU Configuration Error)
		dc.w	NullVec-VecList		* $E0 (PMMU Illegal Operation)
		dc.w	NullVec-VecList		* $E4 (PMMU Illegal Operation)
		dc.w	NullVec-VecList		* $E8 (PMMU Access Level Violation)
		dc.w	NullVec-VecList		* $EC (Unassigned, Reserved)
		dc.w	NullVec-VecList		* $F0 (Unassigned, Reserved)
		dc.w	NullVec-VecList		* $F4 (Unassigned, Reserved)
		dc.w	NullVec-VecList		* $F8 (Unassigned, Reserved)
		dc.w	NullVec-VecList		* $FC (Unassigned, Reserved)
		dc.w	-1			*  End of Vector Table
		cnop	0,4
_LVOAllocSystem:
		movem.l	d1-a6,-(sp)
		lea	error(pc),a0
		sf.b	(a0)			* an error as default
		
*-------------- Open dos library..

		move.l	(AbsExecBase).w,a6	* get execbase
		lea	DosName(pc),a1
		jsr	_LVOOldOpenLibrary(a6)
		tst.l	d0			* did dos fail?
		beq.w	Close_Libs
		lea	_DOSBase(pc),a0
		move.l	d0,(a0)			* save dosbase

*-------------- Open intuition library..

		lea	IntName(pc),a1
		jsr	_LVOOldOpenLibrary(a6)
		tst.l	d0			* did intuition fail?
		beq.w	Close_Libs
		lea	_IntuitionBase(pc),a0
		move.l	d0,(a0)			* save dosbase

*-------------- Open graphics library..

		lea	GfxName(pc),a1
		jsr	_LVOOldOpenLibrary(a6)
		tst.l	d0			* did graphics fail?
		beq.w	Close_Libs
		lea	_GfxBase(pc),a0
		move.l	d0,(a0)			* save dosbase

		bsr.w	_GetVBR			* get current vectorbase addr

*-------------- Find address of our task..

		suba.l	a1,a1			* find *our* task
		jsr	_LVOFindTask(a6)	* get it..
		tst.l	d0			* got our task correctly?
		beq.w	Close_Libs
		lea	our_task(pc),a0
		move.l	d0,(a0)			* save task address

*-------------- Allocate audio hardware..

		lea	aud_chanmap(pc),a0
		lea	channel_map(pc),a1
		move.l	a1,(a0)
		lea	aud_messageport(pc),a1
		move.l	a1,aud_msgport-aud_chanmap(a0)

		sf.b	audio_alloc-aud_chanmap(a0)	* default is `not_allocated'

*-------------- Allocate an audio signal bit..

		moveq	#-1,d0
		jsr	_LVOAllocSignal(a6)	* allocate a signal bit...
		tst.b	d0			* did we get a signal?
		bmi.w	aud_noalloc		* no! we didn`t get one!
		lea	aud_signal(pc),a0
		move.b	d0,(a0)			* save into audio struct..

*-------------- Now create audio port..

		lea	aud_messageport(pc),a1
		jsr	_LVOAddPort(a6)		* now try to create audio port
		tst.l	d0
		beq.w	noport			* error creating audio port?

*-------------- Open audio device..

		moveq	#0,d0
		move.l	d0,d1
		lea	audn(pc),a0
		lea	aud_ioreq(pc),a1
		jsr	_LVOOpenDevice(a6)	* try to open audio.device..
		tst.l	d0
		bne.w	nodev
		lea	audio_alloc(pc),a0
		st.b	(a0)			* set audio as 'allocated'

*-------------- Open the misc resource..

		move.l	(AbsExecBase).w,a6	* Prepare to use exec
                lea	MiscName(pc),a1
		jsr	_LVOOpenResource(a6)	* Open "misc.resource"
		tst.l	d0
		beq.w	misc_failed
		lea	_MiscBase(pc),a0
		move.l	d0,(a0)
		move.l	d0,a6

*-------------- Allocate serial control bits (DTR,CTS, etc.)

		moveq	#MR_SERIALBITS,d0	* We want these bits
		lea	SerName(pc),a1		* This is our name
		jsr	MR_ALLOCMISCRESOURCE(a6)
		tst.l	d0
		bne.w	no_serial_bits		* Someone else has it...

*-------------- Allocate serial port registers & interrupts

		moveq	#MR_SERIALPORT,d0
		lea	SerName(pc),a1
		jsr	MR_ALLOCMISCRESOURCE(a6)
		tst.l	d0
		bne.w	no_serial_port		* Someone else has it...

*-------------- Allocate parallel bits & interrupts (BUSY,ACK,etc.)

		moveq	#MR_PARALLELBITS,d0	* We want these bits
		lea	ParName(pc),a1		* This is our name
		jsr	MR_ALLOCMISCRESOURCE(a6)
		tst.l	d0
		bne.w	no_parallel_bits	* Someone else has it...

*-------------- Allocate 8 bit parallel data port (CIAAPRA & CIAADDRA only!)

		moveq	#MR_PARALLELPORT,d0
		lea	ParName(pc),a1
		jsr	MR_ALLOCMISCRESOURCE(a6)
		tst.l	d0
		bne.w	no_parallel_port	* Someone else has it...

*-------------- Give our task maximum cpu priority..

		move.l	d0,a1			* a1.l = our task address..
		moveq	#127,d0			* MAXIMUM priority please!
		move.l	(AbsExecBase).w,a6
		jsr	_LVOSetTaskPri(a6)	* set it..
		lea	old_taskpri(pc),a0
		move.l	d0,(a0)			* save our old priority...

*-------------- Disable operating system requesters..

		lea	old_WindowPtr(pc),a0
		move.l	our_task(pc),a1		* our task address
		move.l	pr_WindowPtr(a1),(a0)	* save old window ptr..

		moveq	#-1,d0			* No Requestors allowed..
		move.l	d0,pr_WindowPtr(a1)	* Disable OS Requesters now!

*-------------- Flushes graphics hardware to basic state (according to system).

		lea	wbscreen(pc),a0
		clr.l	(a0)

*-------------- Are we running on Kickstart V39 + (if so reset sprite`s)

		move.w	LIB_VERSION(a6),d0	* get operating system version
		cmp.w	#39,d0			* if <39 we don`t have to flush
		bcs.b	not_ks3			* sprite res to fix an os bug!

*-------------- Lock workbench screen & reset sprite resolution`s..

		move.l	#$80000032,taglist-wbscreen(a0)
		clr.l	res-wbscreen(a0)
		move.l	_IntuitionBase(pc),a6
		lea	wbn(pc),a0
		move.l	our_task(pc),a1
		jsr	_LVOLockPubScreen(a6)
		tst.l	d0
		beq.s	not_ks3
		lea	wbscreen(pc),a0
		move.l	d0,(a0)

		move.l	d0,a0
		move.l	48(a0),a0
		lea	taglist(pc),a1
		move.l	_GfxBase(pc),a6
		jsr	_LVOVideoControl(a6)

		lea	oldres(pc),a0
		move.l	res-oldres(a0),(a0)
		move.l	#$80000031,taglist-oldres(a0)
		move.l	#1,res-oldres(a0)

		move.l	wbscreen(pc),a0
		move.l	48(a0),a0
		lea	taglist(pc),a1
		jsr	_LVOVideoControl(a6)

*-------------- Force system to refresh screen()

		move.l	wbscreen(pc),a0
		move.l	_IntuitionBase(pc),a6
		jsr	_LVOMakeScreen(a6)
		jsr	_LVORethinkDisplay(a6)

*-------------- Wait for 2 top of frames (2 incase of laceframe)

		move.l	_GfxBase(pc),a6
		jsr	_LVOWaitTOF(a6)
		jsr	_LVOWaitTOF(a6)

*-------------- Hardware sprites are now at 140ns!
not_ks3
*-------------- Load a 'null' view to reset remaining hardware registers...

		move.l	_GfxBase(pc),a6
		lea	sysview(pc),a1
		move.l	gb_ActiView(a6),(a1)
		suba.l	a1,a1
		jsr	_LVOLoadView(a6)
		jsr	_LVOWaitTOF(a6)
		jsr	_LVOWaitTOF(a6)

*-------------- Call SHARED Take over functions; DeactivaeSystem()

		bsr	DeactivateSystem

*-------------- Install `nullview' copperlist into BOTH copperlist pointers..

		lea	nullcopper(pc),a1
		bsr.w	_LVONewCopper
		bsr.w	_LVONewCopper2

*-------------- Now reset audio channel`s

		moveq	#0,d0			* no volume..
		bsr.w	_LVOSetVolume
		
		move.w	#$444,color(a0)		* paper dark-grey (default)

		lea	error(pc),a0
		st.b	(a0)			* no error occured

		movem.l	(sp)+,d1-a6
		moveq	#0,d0
		move.b	error(pc),d0		* error occured?
		rts

;/* DeactivateSystem()
  * ------------------
  * Shared Part:
  *
  * 01.System friendly allocation of blitter hardware..
  * 02.System friendly disable of multitasking..
  * 03.System friendly call to Supervisor - I am the Law!
  * 04.Wait for hardware custom register disk dma to finish..
  * 05.Wait for hardware custom register blit dma to finish..
  * 06.Preserve hardware custom register status of dmacon..
  * 07.Preserve hardware custom register status of intreq..
  * 08.Preserve hardware custom register status of intena..
  * 09.Preserve hardware custom register status of adkcon..
  * 10.Preserve hardware custom register status of ciaa hardware..
  * 11.Preserve hardware custom register status of ciab hardware..
  * 12.Preserve entire vectorbase include old cpu interrupts & traps..
  * 13.Install our custom irq/trap/exception handlers
  */		

DeactivateSystem
*-------------- Allocate the blitter from the system...

		move.l	_GfxBase(pc),a6
		jsr	_LVOOwnBlitter(a6)
		jsr	_LVOWaitBlit(a6)
		jsr	_LVOWaitBlit(a6)

*-------------- Turn off multitasking capabilities..

		move.l	(AbsExecBase).w,a6	* disable multitasking
		jsr	_LVOForbid(a6)

*-------------- Go into full supervisor mode now.. I AM THE LAW!

		jsr	_LVOSuperState(a6)	* Go to supervisor mode
		lea	oldsysstack(pc),a0
		move.l	d0,(a0)			* save old system stackptr

*-------------- Make sure a disk read/write isn`t too dangerous..

		bsr.w	_LVODiskDone

*-------------- Wait for blitter (hardware method - for ultra saftey)...

		bsr.w	_LVOBlitDone

*-------------- Restore/set dma control,interrupts,requests, audio,uart,etc

		bsr.w	SaveCustom

*-------------- Freeze all dma and interrupts..

		bsr.w	StopCustom

*-------------- Save CIAA Hardware Range

		lea	_ciaa,a0
		lea	ciaa_store(pc),a1
		bsr.w	_LVOSaveCIA

*-------------- Save CIAB Hardware Range

		lea	_ciab,a0
		lea	ciab_store(pc),a1
		bsr.w	_LVOSaveCIA

*-------------- Save old vectors & interrupts...

		lea	VecStore(pc),a1		;ptr to vector storage
		move.l	_VBR(pc),a0
		moveq	#62-1,d0		;no. of vectors to save
_SaveVec:	move.l	(a0)+,(a1)+		;save vector ptr
		dbra	d0,_SaveVec		;save until all 40 done

*-------------- Install null interrupts..

		lea	VecList(pc),a0		;get vectorbase ptr
		move.l	a0,a2			;a2=vectorbase
		move.l	_VBR(pc),a1
		addq.l	#8,a1			;ptr $8(a1) in memory
.next_entry:	moveq	#0,d0			;erase d0
		move.w	(a2)+,d0		;get entry from table
		cmp.w	#-1,d0			;reached end of table?
		beq.s	.table_done		;if so were done!
		add.l	a0,d0			;fix (relocate) ptr
		move.l	d0,(a1)+		;save into vectorbase
		bra.s	.next_entry			
.table_done:
		bsr	SetCurrIntena		* set current intena
		rts

;/* _LVOFreeSystem()
  * ----------------
  * This function restore the operating system back to normal. Its original
  * screen will be re-installed and multitasking operational.
  *
  * First we ActivateSystem();
  *
  * 1. Wait for blitter to finish.
  * 2. Disable all interrupt activities.
  * 3. Restore system ciaa & ciab settings.
  * 4. Restore system interrupts and vectorbase.
  * 5. Restore system dma, intena, intreq and adkcon.
  * 6. Back into userstate (for multitasking)
  * 7. Permit Multitasking (multitasking now reactivated)
  * 8. Give the blitter back to the system.
  *
  * And finally the FreeSystem() Part;
  *
  * 9. Restore Sprite Resolution to that of the Workbench (if >= KS39)
  * 10.Restore Old Workbench view (screen)
  * 11.Give Audio channels back to the system. (if allocated)
  * 12.Give Parallel Port & Registers back to the system. (if allocated)
  * 13.Give Serial Port & Registers back to the system. (if allocated)
  * 14.Restore our task priority to normality. (from highest possible)
  * 15.Close all opened libraries.
  *
  * Now ready to exit back to system.
  */
		cnop	0,4
_LVOFreeSystem:	movem.l	d1-a6,-(sp)
		bsr	ActivateSystem		* partially revive system
						* but not its display or audio
*-------------- restore graphics hardware to original status..

		move.l	wbscreen(pc),d0
		beq.s	exit2

		move.l	d0,a0
		lea	res(pc),a1
		move.l	oldres(pc),(a1)

		lea	taglist(pc),a1
		move.l	48(a0),a0
		move.l	_GfxBase(pc),a6
		jsr	_LVOVideoControl(a6)

		move.l	_IntuitionBase(pc),a6
		move.l	wbscreen(pc),a0
		jsr	_LVOMakeScreen(a6)

		move.l	wbscreen(pc),a1
		sub.l	a0,a0
		jsr	_LVOUnlockPubScreen(a6)

*-------------- restore system`s old copperlist display views..

exit2		move.l	_GfxBase(pc),a6
		move.l	sysview(pc),a1
		jsr	_LVOLoadView(a6)
		jsr	_LVOWaitTOF(a6)
		jsr	_LVOWaitTOF(a6)
		move.l	gb_copinit(a6),_custom+cop1lc

		move.l	_IntuitionBase(pc),a6
		jsr	_LVORethinkDisplay(a6)

*-------------- restore our system task priority to its original state..

		move.l	our_task(pc),a1
		move.l	old_taskpri(pc),d0
		move.l	(AbsExecBase).w,a6
		jsr	_LVOSetTaskPri(a6)

*-------------- free parallel port...
free_parallel_port
                moveq	#MR_PARALLELPORT,d0
		move.l	_MiscBase(pc),a6
                jsr	MR_FREEMISCRESOURCE(a6)

*-------------- free parallel registers...
no_parallel_port:
                moveq	#MR_PARALLELBITS,d0
		move.l	_MiscBase(pc),a6
                jsr	MR_FREEMISCRESOURCE(a6)

*-------------- free serial port.
no_parallel_bits:
                moveq	#MR_SERIALPORT,d0
		move.l	_MiscBase(pc),a6
                jsr	MR_FREEMISCRESOURCE(a6)

*-------------- free serial registers..
no_serial_port:	moveq	#MR_SERIALBITS,d0
		move.l	_MiscBase(pc),a6
                jsr	MR_FREEMISCRESOURCE(a6)
no_serial_bits:
misc_failed:

*-------------- now deallocate() audio hardware..

FreeAudio:	move.b	audio_alloc(pc),d0
		beq.s	aud_noalloc

*-------------- now reset audio channel`s

		moveq	#0,d0
		bsr	_LVOSetVolume

*-------------- close audio device..

		move.b	audio_alloc(pc),d0
		lea	aud_ioreq(pc),a1
		move.l	(AbsExecBase).w,a6
		jsr	_LVOCloseDevice(a6)

*-------------- free audio message port

nodev		lea	aud_messageport(pc),a1
		move.l	(AbsExecBase).w,a6
		jsr	_LVORemPort(a6)

*-------------- free audio signal

noport		moveq	#0,d0
		move.b	aud_signal(pc),d0
		move.l	(AbsExecBase).w,a6
		jsr	_LVOFreeSignal(a6)
aud_noalloc

*-------------- Re-enable Operating System requesters..

		move.l	our_task(pc),a1
		move.l	old_WindowPtr(pc),pr_WindowPtr(a1)

*-------------- Close graphics library..

Close_Libs:	move.l	_GfxBase(pc),d0
		beq.s	closeint
		move.l	d0,a1
		move.l	(AbsExecBase).w,a6
		jsr	_LVOCloseLibrary(a6)

*-------------- Close intuition library..

closeint	move.l	_IntuitionBase(pc),d0
		beq.s	closedos
		move.l	d0,a1
		move.l	(AbsExecBase).w,a6
		jsr	_LVOCloseLibrary(a6)

*-------------- Close dos library..

closedos:	move.l	_DOSBase(pc),d0
		beq.s	exitfast
		move.l	d0,a1
		move.l	(AbsExecBase).w,a6
		jsr	_LVOCloseLibrary(a6)

*-------------- no command line return code for us..

exitfast:	movem.l	(sp)+,d1-a6
		moveq	#0,d0
		rts

;/* ActivateSystem
  * --------------
  * Shared part: This function will re-activate the system upto the point
  * where AmigaDOS is functional and able to grant us access to load / save
  * files. This system function will not restore the operating system display.
  * To do this a full restoration is required. Operating system requesters
  * are still suppressed in this mode so they will not interfere. This is
  * to prevent any 'please insert volume', requesters on the WB, etc.
  *
  * 1. Wait for blitter to finish.
  * 2. Disable all interrupt activities.
  * 3. Restore system ciaa & ciab settings.
  * 4. Restore system interrupts and vectorbase.
  * 5. Restore system dma, intena, intreq and adkcon.
  * 6. Back into userstate (for multitasking)
  * 7. Permit Multitasking (multitasking now reactivated)
  * 8. Give the blitter back to the system.
  */

ActivateSystem:
*-------------- Wait until Blitter finished..

		bsr.w	_LVOBlitDone

*-------------- Turn off all Interrupts and dma, etc.

		bsr.w	StopCustom

*-------------- Restore CIAA Hardware Range..

		lea	_ciaa,a0
		lea	ciaa_store(pc),a1
		bsr.w	_LVORestoreCIA

*-------------- Restore CIAB Hardware Range

		lea	_ciab,a0
		lea	ciab_store(pc),a1
		bsr.w	_LVORestoreCIA
				
*-------------- now restore old interrupts & vectors..

		lea	VecStore(pc),a1		;ptr to vector storage
		move.l	_VBR(pc),a2		;Get VBR Offset in memory
		moveq	#62/2-1,d0		;no. of vecs to restore
_RestoreVec:	move.l	(a1)+,(a2)+		;restore one vector ptr
		move.l	(a1)+,(a2)+		;restore one vector ptr
		dbra	d0,_RestoreVec		;restore until all done
		
*-------------- restore/set dma control,interrupts,requests, audio,uart,etc

		bsr.w	SaveCustom

*-------------- back into userstate()... OS gets control once more..

		move.l	(AbsExecBase).w,a6
		move.l	oldsysstack(pc),d0
		beq.s	.not_in_user
		jsr	_LVOUserState(a6)
		lea	oldsysstack(pc),a0
		clr.l	(a0)			* kill old sys stack addr
.not_in_user:
		
*-------------- re-enable multitasking()... Hold you breath...

		jsr	_LVOPermit(a6)
		
*-------------- give the blitter back to the system...

		move.l	_GfxBase(pc),a6
		jsr	_LVOWaitBlit(a6)
		jsr	_LVOWaitBlit(a6)
		jmp	_LVODisownBlitter(a6)

;/* GetCPU Vectorbase
  * -----------------
  */
		cnop	0,4
_GetVBR:	movem.l	d1-a6,-(a7)
		move.l	(AbsExecBase).w,a6
		moveq	#15,d7
		and.w	AttnFlags(a6),d7
		beq.s	Basic68k
		lea	PutBase(pc),a5
		jsr	_LVOSupervisor(a6)
Basic68k:	lea	_VBR(pc),a5		* ptr to base...
		move.l	d7,(a5)			* save it for later.
		move.l	d7,d0
BadExec:	movem.l	(a7)+,d1-a6
		rts

		cnop	0,4
_LVOGetVBR:	move.l	_VBR(pc),d0		* return address of current vbr
		rts
		
		cnop	0,4
PutBase		movec	vbr,d7
SimpleRevive:
NullVec:	nop				* don`t smash 060 pipeline!
		rte				* exit interrupt/exception

*-------------- disable all dma,interrupts, etc..

		cnop	0,4
StopCustom:	lea	_custom,a0		* custom base in a0..
		move.w	#All_Off,d0
		move.w	d0,dmacon(a0)
		move.w	d0,intena(a0)
		move.w	d0,intreq(a0)
		move.w	d0,adkcon(a0)
		rts

*-------------- Wait for disk dma to complete..

		cnop	0,4
_LVODiskDone:	lea	_custom,a0		* custom base in a0..
		btst	#DSKB_DMAON,dskbytr(a0)	* Wait disk dma for maximum
		beq.s	.nodiskdma		* certainty
.diskdma:	btst	#INTB_DSKBLK,intreqr(a0)* DO NOT clear the bit, system
		beq.s	.diskdma		* may be expecting it...
.nodiskdma:	rts

*-------------- Wait for blitter to complete..

		cnop	0,4
_LVOBlitDone:	lea	_custom,a0		* custom base in a0..
		btst	#DMAB_BLTDONE,dmaconr(a0) * bit test twice due to bug
.wblit		btst	#DMAB_BLTDONE,dmaconr(a0) * in some agnus chip`s.. DOH!
		bne.s	.wblit
		rts

*-------------- Clear volume on all channels..

		cnop	0,4
_LVOSetVolume:	lea	_custom,a0
		move.w	d0,aud0+ac_vol(a0)	* channel 0 audio volume = 0
		move.w	d0,aud1+ac_vol(a0)	* channel 1 audio volume = 0
		move.w	d0,aud2+ac_vol(a0)	* channel 2 audio volume = 0
		move.w	d0,aud3+ac_vol(a0)	* channel 3 audio volume = 0
		rts

*-------------- Install Copperlist into copper ptr 1

		cnop	0,4
_LVONewCopper:	lea 	_custom,a0		* a6=custom hardware
		move.w	#DMAF_COPPER,dmacon(a0)	* now turn off copper dma
.vb1:		btst	#0,vposr+1(a0)
		beq.s	.vb1
.vb2:		btst	#0,vposr+1(a0)
		bne.s	.vb2
		move.l	a1,cop1lc(a0)		* install new copperlist ptr
		move.w	#0,copjmp1(a0)		* strobe copper
		move.w  #Our_Dmacon,dmacon(a0)	* copper display..
		rts

*-------------- Install Copperlist into copper ptr 2

		cnop	0,4
_LVONewCopper2:	lea 	_custom,a0		* a6=custom hardware
		move.w	#DMAF_COPPER,dmacon(a0)	* now turn off copper dma
.vb1:		btst	#0,vposr+1(a0)
		beq.s	.vb1
.vb2:		btst	#0,vposr+1(a0)
		bne.s	.vb2
		move.l	a1,cop2lc(a0)		* install new copperlist ptr
		move.w	#0,copjmp2(a0)		* strobe copper
		move.w  #Our_Dmacon,dmacon(a0)	* copper display..
		rts

*-------------- preserve/set dma control ..

		cnop	0,4
SaveCustom:	lea	_custom,a0
		lea	old_dmacon(pc),a1
		move.w	dmaconr(a0),d1
		move.w	old_dmacon(pc),d0
		move.w	d1,(a1)
		bset	#DMAB_SETCLR,d0
		andi.w	#%1000011111111111,d0
		move.w	d0,dmacon(a0)
		not.w	d0
		andi.w	#%1000011111111111,d0
		move.w	d0,dmacon(a0)

*-------------- preserve/set interrupt enable ..

		move.w	intenar(a0),d1
		move.w	old_intena(pc),d0
		move.w	d1,old_intena-old_dmacon(a1)
		bset	#INTB_SETCLR,d0
		move.w	d0,intena(a0)
		not.w	d0
		move.w	d0,intena(a0)

*-------------- preserve/set interrupt requests ..
		
		move.w	intreqr(a0),d1
		move.w	old_intreq(pc),d0
		move.w	d1,old_intreq-old_dmacon(a1)
		bset	#INTB_SETCLR,d0
		move.w	d0,intreq(a0)
		not.w	d0
		move.w	d0,intreq(a0)

*-------------- preserve audio, disk, uart control ..

		move.w	adkconr(a0),d1
		move.w	old_adkcon(pc),d0
		move.w	d1,old_adkcon-old_dmacon(a1)
		bset	#ADKB_SETCLR,d0
		move.w	d0,adkcon(a0)
		not.w	d0
		move.w	d0,adkcon(a0)
		rts

;/* Save_CIA (Preservation for $bfe0001 & $bfd000 cia/cib chips!)
  * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  * The (CIA Timers A & B L/H Bytes) timer registers (two for each timer) have
  * different functions depending on whether you reading from or writing to 
  * them. When you read from the registers, you get the present value of the
  * Timer Counter (which counts down from its initial value to zero).  When 
  * you write to these registers, the value is stored in the Timer Latch, and
  * from there it can be used to LOAD the Timer Counter using the LOAD bit of 
  * the CRA or CRB registers (see code below).
  *
  * Hence the ordering of the A & B Timer save/restoring is important due
  * to the Timer Latch. (Caution must be taken if modifying the below routines)
  */
		cnop	0,4
_LVOSaveCIA:	move.b	ciacra(a0),_ciacra(a1)
		move.b	ciacrb(a0),_ciacrb(a1)
		bclr	#CIACRAB_START,ciacra(a0)
		bclr	#CIACRBB_START,ciacrb(a0)
		bset	#CIACRAB_LOAD,ciacra(a0)
		bset	#CIACRBB_LOAD,ciacrb(a0)
		move.b	ciatahi(a0),_ciatahi(a1)
		move.b	ciatalo(a0),_ciatalo(a1)
		move.b	ciatbhi(a0),_ciatbhi(a1)
		move.b	ciatblo(a0),_ciatblo(a1)
		move.b	ciaicr(a0),_ciaicr(a1)
		move.b	_ciaicr(a1),ciaicr(a0)
		move.b	ciasdr(a0),_ciasdr(a1)
		move.b	ciatodhi(a0),_ciatodhi(a1)
		move.b	ciatodmid(a0),_ciatodmid(a1)
		move.b	ciatodlow(a0),_ciatodlo(a1)
		move.b	ciaddrb(a0),_ciaddrb(a1)
		move.b	ciaddra(a0),_ciaddra(a1)
		move.b	ciaprb(a0),_ciaprb(a1)
		move.b	ciapra(a0),_ciapra(a1)
		rts

		cnop	0,4
_LVORestoreCIA:	bclr	#CIACRAB_START,ciacra(a0)
		bclr	#CIACRBB_START,ciacrb(a0)
		move.b	_ciatahi(a1),ciatahi(a0)
		move.b	_ciatalo(a1),ciatalo(a0)
		move.b	_ciatbhi(a1),ciatbhi(a0)
		move.b	_ciatblo(a1),ciatblo(a0)
		move.b	_ciacra(a1),ciacra(a0)
		move.b	_ciacrb(a1),ciacrb(a0)
		move.b	_ciasdr(a1),ciasdr(a0)
		move.b	_ciatodhi(a1),ciatodhi(a0)
		move.b	_ciatodmid(a1),ciatodmid(a0)
		move.b	_ciatodlo(a1),ciatodlow(a0)
		move.b	_ciaddrb(a1),ciaddrb(a0)
		move.b	_ciaddra(a1),ciaddra(a0)
		move.b	_ciaprb(a1),ciaprb(a0)
		move.b	_ciapra(a1),ciapra(a0)
		bset	#CIACRAB_START,ciacra(a0)
		bset	#CIACRBB_START,ciacrb(a0)
		move.b	_ciaicr(a1),ciaicr(a0)
		rts

Our_Dmacon = %1000001111110000
*             |     ||||||
*             |     ||||||        AUD0EN  Audio channel 0 Enable
*             |     ||||||        AUD1EN  Audio channel 1 Enable
*             |     ||||||        AUD2EN  Audio channel 2 Enable
*             |     ||||||        AUD3EN  Audio channel 3 Enable
*             |     |||||+-----   DSKEN   Disk DMA Enable
*             |     ||||+------   SPREN   Sprite DMA Enable
*             |     |||+-------   BLTEN   Blitter DMA Enable
*             |     ||+--------   COPEN   Copper DMA Enable
*             |     |+---------   BPLEN   Bitplane DMA Enable
*             |     +----------   DMAEN   Enable all DMA below
*             |                   BLTPRI  Blitter DMA Priority (1=blit nasty)
*             |                   BZERO   Blitter Logic Zero status bit 
*             |                   BBUSY   Blitter Busy status byte
*             +----------------   SET/CLR control bit

All_Off    = %0111111111111111    * all other bits on..
*             |
*             +----------------   SET/CLR control bit

		cnop	0,4
_LVORemIrqServer:
		lea	irqtab(pc),a1			* ptr to irq table..
		moveq	#0,d1				* erase d1
		move.w	d0,d2				* copy of irq
		add.w	d2,d2				* x2 (68k Compatible)
		move.w	(a1,d2.w),d1			* get offset
		add.l	d1,a1				* a1= adr irq jmpptr
		clr.l	(a1)				* clear new jmp ptr
		bsr.s	_LVOClrIrqBit
		rts

		cnop	0,4
_LVOClrIrqBit:	move.w	#All_Off,_custom+intena		* disable all irq`s
		lea	ourint(pc),a1			* ptr to our int bits..
		moveq	#0,d1				* erase d1
		move.w	(a1),d1				* get active irqs
		bclr	d0,d1				* set this irq`s bit
		or.w	#INTF_SETCLR!INTF_INTEN,d1	* make sure set/clr on!
		move.w	d1,(a1)				* save current irq bits
		move.w	d1,_custom+intena		* enable required irq`s
		rts

		cnop	0,4
_LVOAddIrqServer:
		cmp.w	#15,d0				* if >15.. invalid irq
		bgt.s	invalid_irq
		lea	irqtab(pc),a1			* ptr to irq table..
		moveq	#0,d1				* erase d1
		move.w	d0,d2				* copy of irq into d2
		add.w	d2,d2				* x2 (68k compatible)
		move.w	(a1,d2.w),d1			* get offset (not 020)
		add.l	d1,a1				* a1= adr irq jmpptr
		move.l	a0,(a1)				* set new jmp ptr
		bsr.s	_LVOSetIrqBit
invalid_irq:	rts

		cnop	0,4
_LVOSetIrqBit:	move.w	#All_Off,_custom+intena		* disable all irq`s
		lea	ourint(pc),a1			* ptr to our int bits..
		moveq	#0,d1				* erase d1
		or.w	(a1),d1				* get active irqs
		bset	d0,d1				* set this irq`s bit
		or.w	#INTF_SETCLR!INTF_INTEN,d1	* make sure set/clr on!
		move.w	d1,(a1)				* save current irq bits
		move.w	d1,_custom+intena		* enable required irq`s
		rts

SetCurrIntena:	move.w	#All_Off,_custom+intena		* disable all irq`s
		move.w	ourint(pc),d1			* get active irqs
		ori.w	#INTF_SETCLR!INTF_INTEN,d1	* make sure set/clr on!
		move.w	d1,_custom+intena		* enable required irq`s
		rts
		
;/* Level 1: Transmit Buffer Empty (IRQ 0)
  * -------------------------------------
  */
		cnop	0,4
Level1_IRQ:	movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_TBE,d0
		beq.s	.not_tbe

		move.l	irq0jmp(pc),d0
		beq.s	.nojmp0
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp0
		move.w	#INTF_TBE,_custom+intreq
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 1: Disk Block (IRQ 1)
  * ---------------------------
  */
		cnop	0,4
.not_tbe:	btst	#INTB_DSKBLK,d0
		beq.s	.not_dskblk

		move.l	irq1jmp(pc),d0
		beq.s	.nojmp1
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp1
		move.w	#INTF_DSKBLK,_custom+intreq
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 1: Soft Interrupt (IRQ 2)
  * -------------------------------
  */
		cnop	0,4
.not_dskblk	btst	#INTB_SOFTINT,d0
		beq.s	.not_softint

		move.l	irq2jmp(pc),d0
		beq.s	.nojmp2
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp2
		move.w	#INTF_SOFTINT,_custom+intreq
.not_softint:	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 2: I/O Ports Interrupt (IRQ 3)
  * ------------------------------------
  */
		cnop	0,4
Level2_IRQ:	movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_PORTS,d0
		beq.s	.not_ports

		btst	#3,_ciaa+ciaicr			* sp_mode?
		beq.s	.not_irc

		move.l	irq3jmp(pc),d0
		beq.s	.nojmp3
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp3
.not_irc	move.w	#INTF_PORTS,_custom+intreq

.not_ports:	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 3: Copper Interrupt (IRQ 4)
  * ---------------------------------
  */
		cnop	0,4
Level3_IRQ:	movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_COPER,d0
		beq.s	.notcopper

		move.l	irq4jmp(pc),d0
		beq.s	.nojmp4
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp4
		move.w	#INTF_COPER,_custom+intreq
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 3: Vertical Blank Interrupt (IRQ 5)
  * -----------------------------------------
  */
		cnop	0,4
.notcopper	btst	#INTB_VERTB,d0
		beq.s	.notvb

		move.l	irq5jmp(pc),d0
		beq.s	.nojmp5
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp5
		move.w	#INTF_VERTB,_custom+intreq
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 3: Blitter Finished Interrupt (IRQ 6)
  * -------------------------------------------
  */
		cnop	0,4
.notvb		btst	#INTB_BLIT,d0			* next blit in queue?
		beq.s	.notblitter

		move.l	irq6jmp(pc),d0			* blit queue code ptr
		beq.s	.nojmp6
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp6
		move.w	#INTF_BLIT,_custom+intreq
.notblitter	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 4: Audio Channel 0 Interrupt (IRQ 7)
  * ------------------------------------------
  */
		cnop	0,4
Level4_IRQ:	movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_AUD0,d0
		beq.s	.not_aud3

		move.l	irq7jmp(pc),d0
		beq.s	.nojmp7
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp7
		move.w	#INTF_AUD0,_custom+intreq	* clear request
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 4: Audio Channel 1 Interrupt (IRQ 8)
  * ------------------------------------------
  */
		cnop	0,4
.not_aud3:	btst	#INTB_AUD1,d0
		beq.s	.not_aud2

		move.l	irq8jmp(pc),d0
		beq.s	.nojmp8
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp8
		move.w	#INTF_AUD1,_custom+intreq	* clear request
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 4: Audio Channel 2 Interrupt (IRQ 9)
  * ------------------------------------------
  */
		cnop	0,4
.not_aud2:	btst	#INTB_AUD2,d0
		beq.s	.not_aud1

		move.l	irq9jmp(pc),d0
		beq.s	.nojmp9
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp9
		move.w	#INTF_AUD2,_custom+intreq	* clear request
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 4: Audio Channel 3 Interrupt (IRQ 10)
  * -------------------------------------------
  */
		cnop	0,4
.not_aud1:	btst	#INTB_AUD3,d0
		beq.s	.not_aud0

		move.l	irq10jmp(pc),d0
		beq.s	.nojmp10
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp10
		move.w	#INTF_AUD3,_custom+intreq	* clear request
.not_aud0:	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 5: Read Buffer Full Interrupt (IRQ 11)
  * --------------------------------------------
  */
		cnop	0,4
Level5_IRQ:	movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_RBF,d0
		beq.s	.not_rbf

		move.l	irq11jmp(pc),d0
		beq.s	.nojmp11
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp11
		move.w	#INTF_RBF,_custom+intreq	* clear request
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 5: Disk Sync Interrupt (IRQ 12)
  * ------------------------------------
  */
		cnop	0,4
.not_rbf:	btst	#INTB_DSKSYNC,d0
		beq.s	.not_dsk

		move.l	irq12jmp(pc),d0
		beq.s	.nojmp12
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp12
		move.w	#INTF_DSKSYNC,_custom+intreq	* clear request
.not_dsk	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 6: External Interrupt (IRQ 13)
  * ------------------------------------
  */
		cnop	0,4
Level6_IRQ:	tst.b	_ciab+ciaicr			* trigger cia..

		movem.l	d0-a6,-(sp)
		move.w	_custom+intreqr,d0
		btst	#INTB_EXTER,d0
		beq.s	.not_exter

		move.l	irq13jmp(pc),d0
		beq.s	.nojmp13
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp13
		move.w	#INTF_EXTER,_custom+intreq	* clear request
.not_exter:	movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

 ;/* Level 7: Non-Maskable Interrupt (IRQ 14)
  * -----------------------------------------
  */
		cnop	0,4
Level7_IRQ:	movem.l	d0-a6,-(sp)

		move.l	irq14jmp(pc),d0
		beq.s	.nojmp14
		move.l	d0,a0
		jsr	(a0)				* call codehook
.nojmp14
		movem.l	(sp)+,d0-a6
		nop					* dont smash the
		rte					* 040/060 pipelines!

;/* Level 3: (Sync) from Copperlist Generated Interrupt (IRQ 5)
  * -----------------------------------------------------------
  */
		cnop	0,4
CopperIrqSync:	lea	_custom,a5
		move.w	#INTF_COPER,intreq(a5)
wait_for_bit:	btst	#INTB_COPER,intreqr+1(a5)
		beq.s	wait_for_bit
		rts

		cnop	0,4
_LVOGetKeys:	move.b	_ciaa+ciasdr,d0			* get key
		not.b	d0				* normalise key..
		ror.b	#1,d0				* shift to correct bits
		swap	d0				* put in upper word
		move.b	#CIACRAF_TODIN+CIACRAF_SPMODE+CIACRAF_LOAD,_ciaa+ciacra
		lea	_custom+vhposr,a1
		move.b	(a1),d0
.waitvb1:	cmp.b	(a1),d0				* wait 1 scanline
		beq.s	.waitvb1
		move.b	(a1),d0
.waitvb2:	cmp.b	(a1),d0				* wait 1 scanline
		beq.s	.waitvb2
		move.b	(a1),d0
.waitvb3:	cmp.b	(a1),d0				* wait 1 scanline
		beq.s	.waitvb3
		swap	d0				* restore key from word
		move.b	#CIACRAF_START+CIACRAF_RUNMODE,_ciaa+ciacra
		btst	#7,d0
		bne.s	KeyUp				* key released?
		andi.w	#%01111111,d0			* mask keyrelease bit 7
		move.b	d0,Key-KeyMatrix(a0)		* store current key..
		st.b	(a0,d0.w)			* set key in matrix..
		rts
		cnop	0,4
KeyUp:		andi.w	#%01111111,d0			* mask keyrelease bit 7
		st.b	Key-KeyMatrix(a0)		* store keyup for key..
		sf.b	(a0,d0.w)			* clear key
		rts

*-------------- Note: This copperlist *must* be in chipram to be shown!

nullcopper:	dc.w	bplcon0,$0200		* no bitplanes
		dc.w	color,$0000		* black paper color
		dc.w	color,$0000		* black paper color
		dc.w	$ffff,$fffe		* terminate copperlist

DosName		dc.b	'dos.library',0
GfxName		dc.b	'graphics.library',0
IntName		dc.b	'intuition.library',0
wbn		dc.b	'Workbench',0
audn		dc.b	'audio.device',0
MiscName        dc.b    'misc.resource',0
SerName		dc.b    'serial.hog',0
ParName		dc.b    'parallel.hog',0

*                       Jump Address	   Level  No  Description
*			------------	   -----  --  -------------------------
		cnop	0,4
irqtab:		dc.w	irq0jmp-irqtab	     1	  00: Transmit Buffer Empty IRQ
		dc.w	irq1jmp-irqtab	     1	  01: Disk Block IRQ
		dc.w	irq2jmp-irqtab	     1	  02: Software Generated IRQ
		dc.w	irq3jmp-irqtab	     2	  03: I/O Ports IRQ
		dc.w	irq4jmp-irqtab	     3	  04: Copper Triggered IRQ
		dc.w	irq5jmp-irqtab	     3	  05: Vertical Blank IRQ
		dc.w	irq6jmp-irqtab	     3	  06: Blitter Finished IRQ
		dc.w	irq7jmp-irqtab	     4	  07: Audio Channel 0 IRQ
		dc.w	irq8jmp-irqtab	     4	  08: Audio Channel 1 IRQ
		dc.w	irq9jmp-irqtab	     4	  09: Audio Channel 2 IRQ
		dc.w	irq10jmp-irqtab	     4	  10: Audio Channel 3 IRQ
		dc.w	irq11jmp-irqtab	     5	  11: Read Buffer Full IRQ
		dc.w	irq12jmp-irqtab	     5	  12: Disk Sync IRQ
		dc.w	irq13jmp-irqtab	     6	  13: External CIA-B IRQ
		dc.w	irq14jmp-irqtab	     7	  14: Non Maskable IRQ
		dc.w	nullcode-irqtab	     -	  15: -- not used

irq0jmp:	ds.l	1
irq1jmp:	ds.l	1
irq2jmp:	ds.l	1
irq3jmp:	ds.l	1
irq4jmp:	ds.l	1
irq5jmp:	ds.l	1
irq6jmp:	ds.l	1
irq7jmp:	ds.l	1
irq8jmp:	ds.l	1
irq9jmp:	ds.l	1
irq10jmp:	ds.l	1
irq11jmp:	ds.l	1
irq12jmp:	ds.l	1
irq13jmp:	ds.l	1
irq14jmp:	ds.l	1
nullcode:	ds.l	1
ourint:		ds.w	1

		cnop	0,4
aud_ioreq:	dc.l	0,0
		dc.b	5,127			* type, pri
		dc.l	0			* name
aud_msgport:	dc.l	0			* replyport
		dc.w	68			* length
		dc.l	0			* io_Device
		dc.l	0			* io_Unit
aud_cmd:	dc.w	0			* io_Command
aud_flags:	dc.b	0			* io_Flags
aud_error:	dc.b	0			* io_Error
aud_allockey:	dc.w	0			* ioa_AllocKey
aud_chanmap	dc.l	0			* ioa_Data
		dc.l	1			* ioa_Length
		dc.w	0,0,0			* ioa_Period, Volume, Cycles
		dc.w	0,0,0,0,0,0,0,0,0,0	* ioa_WriteMsg

aud_messageport:dc.l	0,0			* succ,pred
		dc.b	4,0			* type = NT_MSGPORT, priority
		dc.l	0			* name
		dc.b	0			* flags
aud_signal:	dc.b	0			* signal bit = PA_SIGNAL
aud_task:	dc.l	0			* task
		dc.l	0,0,0			* head,tail,tailpred
		dc.b	5,0			* type

		cnop	0,4
_VBR:		ds.l	1			* cpu vectorbase address
_DOSBase:	ds.l	1			* dos base
_GfxBase:	ds.l	1			* graphics base
_IntuitionBase:	ds.l	1			* intuition base
_MiscBase:	dc.l	0			* misc resource base
oldres:		ds.l	1			* Old sprite resolution
wbscreen:	ds.l	1			* WB screen
taglist:	ds.l	1			* VTAG cm (set resn/get resn)
res:		ds.l	1			* resolution
tagdone:	ds.l	2			* TAG_DONE,0
flags:		ds.l	1			* Takeover input flags
zero_copy:	ds.l	1			* zeropage copy address
old_VBR:	ds.l	1			* old VBR
old_taskpri:	ds.l	1			* old task priority
our_task:	ds.l	1			* old task address
sysview:	ds.l	1			* system view address
oldsysstack:	ds.l	1			* old sp:superstate/userstate
old_cachebits:	ds.l	1			* old cache control bits
old_WindowPtr:	ds.l	1			* old window ptr address
VecStore:	ds.l	64			* preserve buffer	
old_dmacon:	ds.w	1			* custom chip dma control bits
old_intena:	ds.w	1			* custom chip interrupt bits
old_intreq:	ds.w	1			* custom chip irq requests
old_adkcon:	ds.w	1			* custom chip uart control bits
error:		ds.b	1			* if = 0 an error occured
padding:	ds.b	1			* else takeover was successful
audio_alloc:	ds.b	1			* Flag: audio was allocated succesfully
ciaa_store:	ds.b	16			* ciaa settings (stored)
ciab_store:	ds.b	16			* ciab settings (stored)
KeyMatrix	ds.b	256
Key		ds.b	2
channel_map:	dc.b	%1111			* all 4 channels or nothing (alloc map)

