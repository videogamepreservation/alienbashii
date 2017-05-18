SOUND_WAIT_1200	EQU	8
SOUND_WAIT_500	EQU	6

aud	EQU   $0A0
aud0	EQU   $0A0
aud1	EQU   $0B0
aud2	EQU   $0C0
aud3	EQU   $0D0

ac_ptr	EQU   $00
ac_len	EQU   $04
ac_per	EQU   $06
ac_vol	EQU   $08
ac_dat	EQU   $0A
ac_SIZEOF	EQU   $10


Sound_GunFire 	EQU	1*4
Sound_Pling	EQU	2*4
Sound_Rocket	EQU	3*4
Sound_Bang	EQU	4*4
Sound_Thud	EQU	5*4
Sound_Grenade	EQU	6*4
Sound_Explo     EQU	7*4
Sound_Crap	EQU	8*4
Sound_Drain	EQU	9*4
Sound_SExplo	EQU	10*4
Sound_Beat	EQU	11*4
Sound_Collect	EQU	12*4
Sound_PigDie	EQU	13*4
Sound_PlingV2	EQU	14*4
Sound_PlingV3	EQU	15*4
Sound_PlingV4	EQU	16*4
Sound_PigShoot	EQU	17*4
Sound_Slide	EQU	18*4 
Sound_Change	EQU	19*4
Sound_GunEmpty	EQU	20*4
Sound_Splat	EQU	21*4
Sound_Switch	EQU	22*4
Sound_Splash	EQU	23*4
Sound_PigDie2	EQU	24*4
Sound_PigDie3	EQU	25*4
Sound_PigDie4	EQU	26*4
Sound_Swoosh	EQU	27*4
Sound_Bomb	EQU	28*4
Sound_Thud2	EQU	29*4
Sound_Wood	EQU	30*4
Sound_Wood2	EQU	31*4

*extras
Sound_OverHere	EQU	32*4
Sound_GetReady	EQU	33*4
Sound_ExtraEnergy EQU	34*4
Sound_Grenades	EQU	35*4
Sound_Rockets	EQU	36*4
Sound_Appear	EQU	37*4
Sound_ManScream EQU	38*4
Sound_Whistle	EQU	39*4
Sound_Thunder	EQU	40*4
Sound_Rain	EQU	41*4
Sound_Chink	EQU	42*4

***********************************************
** RETURN NORM FX SIZE                       **
***********************************************
Return_Norm_Fx_Size

	clr.l	d1
	move.l	#Sample_Lengths_Table,a0
add_up_fx_loop
	clr.l	d0
	move.w	(a0)+,d0
	add.l	d0,d1
	cmpa.l	#Extra_Samples,a0
	bne.s	add_up_fx_loop	
	rts
	
***********************************************
** RETURN EXTRA FX SIZE                      **
***********************************************
Return_Extra_Fx_Size
	clr.l	d1
	move.l	#Extra_Samples,a0
add_up_xfx_loop
	clr.l	d0
	move.w	(a0)+,d0
	beq.s	got_xfx_size
	add.l	d0,d1
	bra.s	add_up_xfx_loop	
got_xfx_size
	rts
	
	
***********************************************
** Allocate SFX                              **
***********************************************
Allocate_SFX

*first find out amount of mem needed
*must be run before 'set up sound fx'

	bsr	Return_Norm_Fx_Size
	move.l	d1,d6		;size of data for norm samples
	bsr	Return_Extra_Fx_Size
	tst.l	d1
	bne.s	xtra_fx_in
	move.w	#OFF,xtra_fx
xtra_fx_in	
	add.l	d6,d1		; add sizes together
	move.l	d1,Sound_Fx_Buffer_Size	;store

	move.l	d6,-(sp)
	move.l	EXEC,a6
	move.l	#MEM_CHIP+MEMF_LARGEST,d1	;chip 
	jsr	-$d8(a6)	;avail mem
	move.l	(sp)+,d6
	
	cmp.l	Sound_Fx_Buffer_Size,d0
	bge.s	Xtra_Samples_Enabled
	move.w	#OFF,xtra_fx		;no extra sfx
	move.l	d6,Sound_Fx_Buffer_Size	
	move.l	#extra_fx,a0
clear_fx
	cmp.l	#$ffffffff,(a0)
	beq.s	done_clear
	clr.l	(a0)+		;set extra fx to 0 -i.e plays nothing
	bra.s	clear_fx
done_clear		
	move.l	#extra_fx_bonus,a0	;replace voice bonus for noise
	move.l	#collect_noise,(a0)+
	move.l	#collect_noise,(a0)+
	move.l	#collect_noise,(a0)+
	move.l	#Thud_Noise,Chink_Sound_Entry
Xtra_Samples_Enabled	
	move.l	EXEC,a6
	move.l	Sound_Fx_Buffer_Size,d0
	move.l	#MEM_CHIP+MEM_CLEAR,d1	;chip 
	jsr	-198(a6)	;alloc mem
	move.l	d0,sfx_mem
	rts

***********************************************
**    SET UP SOUND FX                        **
***********************************************
Set_Up_Sound_Fx

	move.l	#GunFire_Noise,a0	
set_up_fx_loop
	move.w	sound_pos(a0),d0	;position in lengths table
	move.l	#Sample_Lengths_Table,a2
	clr.l	d2			; hold offset
	clr.l	d3
add_lengths_loop
	move.w	(a2)+,d3
	subq.w	#1,d0
	bmi.s	got_fx_info
	add.l	d3,d2
	bra.s	add_lengths_loop
got_fx_info
	lsr.w	d3		; sample length in bytes to words
	move.w	d3,sound_length(a0)	;length in words
	move.l	sfx_mem,a1
	add.l	d2,a1
	move.l	a1,Sound_ptr(a0)	;sample pos	
	add.l	#Sound_Fx_Size,a0
	cmpa.l	#End_Of_Samples,a0
	bne.s	set_up_fx_loop		
	rts

Sound_Fx_Buffer_Size		dc.l	0
sfx_mem				dc.l	0
xtra_fx				dc.w	ON	;default

***********************************************
** SOUND EFFECTS                             **
***********************************************
Sound_Effects
	move.l	sound_effects_code,a0
	jsr	(A0)
	rts


***********************************************
** SOUND EFFECTS AGA                         **
***********************************************
Sound_Effects_Aga
*passes all sfx through only 2 channels

*do the sample as 3 chan job

	moveq.l	#0,d0
		
	move.l	#sound_table,a0

	move.w	sound_chan4,d0
	move.l	(a0,d0),a1

	move.w	sound_chan3,d0
	tst.l	(a0,d0)
	beq.s	skip_sound
	move.l	(a0,d0),a1
skip_sound
	move.w	sound_chan2,d0
	tst.l	(a0,d0)
	beq.s	use_other_fx
	move.l	(a0,d0),a0
	bra.s	skip_sound2
use_other_fx	
	move.w	sound_chan1,d0	
	move.l	(a0,d0),a0
skip_sound2
	bsr	Play_Sounds		;wont work as play sounds stops all 4 samples
	bsr	Clear_Sounds
	clr.l	Sound_chan1
	clr.l	Sound_Chan3
	rts

***********************************************
** SOUND EFFECTS NORMAL                      **
***********************************************
Sound_Effects_Normal
	moveq.l	#0,d0
	move.l	#sound_table,a0
	move.w	sound_chan4,d0
	move.l	(a0,d0),a3
	move.w	sound_chan3,d0
	move.l	(a0,d0),a2
	move.w	sound_chan2,d0
	move.l	(a0,d0),a1
	move.w	sound_chan1,d0	
	move.l	(a0,d0),a0

	bsr	Play_Sounds
	bsr	Clear_Sounds
	clr.l	Sound_chan1
	clr.l	Sound_Chan3
	rts

***********************************************
** SOUND EFFECTS 3 CHAN                      **
***********************************************
Sound_Effects_3_Chan
*This is used for when one channel needs to be free for a special
*effect
	clr.l	d0
	move.l	#sound_table,a0
	move.l	#0,a3
	move.w	sound_chan4,d0
	move.l	(a0,d0),d1	
	move.w	sound_chan3,d0
	move.l	(a0,d0),a2
	move.w	sound_chan2,d0
	move.l	(a0,d0),a1
	move.w	sound_chan1,d0	
	move.l	(a0,d0),a0

;now try and re-allocate channel 4

	tst.w	sound_chan3
	bne.s	try_chan2
	move.l	d1,a2
	bra.s	Play_The_Sounds
try_chan2	
	tst.w	sound_chan2
	bne.s	try_chan1
	move.l	d1,a1
	bra.s	Play_The_Sounds
try_chan1
	tst.w	sound_chan1
	bne.s	Play_The_Sounds
	move.l	d1,a0
Play_The_Sounds
	bsr	Play_Sounds
	bsr	Clear_3_Sounds
	clr.l	Sound_chan1
	clr.l	Sound_Chan3
	rts

**********************************
*** START LOOPING SAMPLE      ****
**********************************
Start_Looping_Sample
*Routine to be used in conjunction with sound effects 3 chan
	cmp.w	#OFF,xtra_fx
	beq.s	Dont_Start_Loop
	moveq.w	#1,d1		;equiv to bset #0
	move.l	#Rain_Noise,a4
	move.l	Sound_Ptr(a4),aud0+ac_ptr(a6)
	move.w	Sound_Length(a4),aud0+ac_len(a6)
	move.w	Sound_Period(a4),aud0+ac_per(a6)
	move.w	Sound_Volume(a4),aud0+ac_vol(a6)
	bsr	Enable_Disable_Sounds
Dont_Start_Loop	
	rts

**********************************
***  STOP LOOPING SAMPLE      ****
**********************************
Stop_Looping_Sample
	cmp.w	#OFF,xtra_fx
	beq.s	Quit_Stop_Loop
	moveq.w	#1,d1
	move.l	#Sound_Blank,aud0+ac_ptr(a6)	; blank sound data
	move.w	#4,aud0+ac_len(a6)		; 1 word 	
	bsr	Enable_Disable_Sounds
Quit_Stop_Loop	
	rts

**********************************
*** LOW PAS FILTER OFF        ****
**********************************
low_pas_filter_off
	bset #1,$bfe001
	rts

**********************************
***   CLEAR CHANNELS          ****
**********************************
Clear_Channels
	clr.l	Sound_chan1
	clr.l	Sound_Chan3
	rts
	
********************************************	
*             PLAY SOUNDS                  *
********************************************
Play_Sounds
	moveq	#0,d1
Channel4
	cmp.l	#0,a2				; channel 2
	beq.s	Channel3
	bset.l	#1,d1				; set for turn off
	move.l	Sound_Ptr(a2),aud1+ac_ptr(a6)
	move.w	Sound_Length(a2),aud1+ac_len(a6)
	move.w	Sound_Period(a2),aud1+ac_per(a6)
	move.w	Sound_Volume(a2),aud1+ac_vol(a6)
Channel3
	cmp.l	#0,a0				; channel 2
	beq.s	channel_3_done
	bset.l	#3,d1				; set for turn off
	move.l	Sound_Ptr(a0),aud3+ac_ptr(a6)
	move.w	Sound_Length(a0),aud3+ac_len(a6)
	move.w	Sound_Period(a0),aud3+ac_per(a6)
	move.w	Sound_Volume(a0),aud3+ac_vol(a6)
channel_3_done	
	cmp.l	#0,a1				; channel 2
	beq.s	channel_2_done
	bset.l	#2,d1				; set for turn off
	move.l	Sound_Ptr(a1),aud2+ac_ptr(a6)
	move.w	Sound_Length(a1),aud2+ac_len(a6)
	move.w	Sound_Period(a1),aud2+ac_per(a6)
	move.w	Sound_Volume(a1),aud2+ac_vol(a6)
channel_2_done	
	cmp.l	#0,a3				; channel 4
	beq.s	channel_4_done
	bset.l	#0,d1				; set for turn off
	move.l	Sound_Ptr(a3),aud0+ac_ptr(a6)
	move.w	Sound_Length(a3),aud0+ac_len(a6)
	move.w	Sound_Period(a3),aud0+ac_per(a6)
	move.w	Sound_Volume(a3),aud0+ac_vol(a6)
channel_4_done	
	bsr	Enable_Disable_Sounds
	rts

*****************************************
*** ENABLE DISABLE SOUNDS            ****
*****************************************
Enable_Disable_Sounds
*Send channels bits in d1
	move.w	d1,$96(a6)			; turn off channels
	bsr	Sound_Dma_Wait
	or.w	#$8000,d1
	move.w	d1,$96(a6)			; turn channels on
	bsr	Sound_Dma_Wait
	rts

*****************************************
*** CLEAR SOUNDS                     ****
*****************************************
Clear_Sounds

	move.l	#Sound_Blank,aud3+ac_ptr(a6)	; blank sound data
	move.w	#4,aud3+ac_len(a6)		; 1 word 	

	move.l	#Sound_Blank,aud2+ac_ptr(a6)	; blank sound data
	move.w	#4,aud2+ac_len(a6)		; 1 word 	

	move.l	#Sound_Blank,aud1+ac_ptr(a6)	; blank sound data
	move.w	#4,aud1+ac_len(a6)		; 1 word 	
	
	move.l	#Sound_Blank,aud0+ac_ptr(a6)	; blank sound data
	move.w	#4,aud0+ac_len(a6)		; 1 word 
	
	rts

*****************************************
*** CLEAR 3 SOUNDS                   ****
*****************************************
Clear_3_Sounds

	move.l	#Sound_Blank,aud3+ac_ptr(a6)	; blank sound data
	move.w	#4,aud3+ac_len(a6)		; 1 word 

	move.l	#Sound_Blank,aud2+ac_ptr(a6)	; blank sound data
	move.w	#4,aud2+ac_len(a6)		; 1 word 	

	move.l	#Sound_Blank,aud1+ac_ptr(a6)	; blank sound data
	move.w	#4,aud1+ac_len(a6)		; 1 word 	

	rts

*****************************************
*** SOUND DMA WAIT                   ****
*****************************************
Sound_Dma_Wait
*According to the handbook the sound hardware needs 2 horizontal
*raster lines to start/stop
	move.w	vhposr(a6),d6
	andi.w	#$ff00,d6
	lsr.w	#8,d6
Wait_2_Lines
	move.w	vhposr(a6),d7
	andi.w	#$ff00,d7
	lsr.w	#8,d7		;cos may need sign bit for test
	sub.w	d6,d7
	bpl.s	dont_neg_vl
	neg.w	d7
dont_neg_vl
	cmp.w	sound_wait,d7
	blt.s	Wait_2_Lines	
	rts


sound_wait			dc.w	0

sound_table
	dc.l	0
	dc.l	Gunfire_Noise
	dc.l	Pling_Noise
	dc.l	Rocket_Noise
	dc.l	Rocket_Explosion_Noise
	dc.l	Thud_Noise
	dc.l	Grenade_Noise
	dc.l	BlockExplo_Noise
	dc.l	CrapExplo_Noise
	dc.l	Drain_Noise
	dc.l	ShortExplo_Noise
	dc.l	Collect_Noise ;used to be beat
	dc.l	Collect_Noise
	dc.l	PigDie_Noise
	dc.l	Pling_NoiseV2
	dc.l	Pling_NoiseV3
	dc.l	Pling_Noisev4
	dc.l	PigShoot_Noise
	dc.l	Slide_Noise
	dc.l	Change_Noise
	dc.l	GunEmpty_Noise
	dc.l	Splat_Noise
	dc.l	ThrowSwitch_Noise
	dc.l	Splash_noise	
	dc.l	PigDie_Noise2
	dc.l	PigDie_Noise3
	dc.l	PigDie_Noise4
	dc.l	Swoosh_Noise
	dc.l	Bomb_Rocket_Noise
	dc.l	Thud_Noise2
	dc.l	Wood_Noise
	dc.l	Wood_Noise2
extra_fx
	dc.l	OverHere_Noise
	dc.l	GetReady_Noise
extra_fx_bonus	
	dc.l	ExtraEnergy_Noise
	dc.l	Grenades_Noise
	dc.l	Rockets_Noise
	dc.l	Appear_Noise
	dc.l	ManScream_Noise
	dc.l	Whistle_Noise
	dc.l	Thunder_Noise
	dc.l	Rain_Noise		
Chink_Sound_Entry	
	dc.l	Chink_Noise
	dc.l	$ffffffff		;end of list
	
sound_chan1
	dc.w	0
sound_chan2
	dc.w	0
sound_chan3
	dc.w	0		
sound_chan4
	dc.w	0
	
sound_effects_code
	dc.l	Sound_Effects_Normal

music_chans_2
	dc.w	OFF