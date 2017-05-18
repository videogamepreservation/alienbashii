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

Sound_HeadButt	 EQU	1
Sound_Jump	 EQU	2
Sound_Water	 EQU	3
Sound_Spangle	 EQU	4
Sound_Coin	 EQU	5
Sound_Alienhit	 EQU	6
Sound_BlockSplit EQU	7
Sound_Bumhit 	 EQU	8
Sound_SquizHurt	 EQU	9
Sound_Click	 EQU	10
Sound_Cowbell	 EQU	11
Sound_Spring	 EQU	12
Sound_Slide	 EQU	13
Sound_Swoosh	 EQU	14
Sound_Chuck	 EQU 	15
Sound_Slap	 EQU	16
Sound_Bat	 EQU	17
Sound_Wallhit	 EQU	18
Sound_Fruit	 EQU	19

Sound_Effects
	moveq.l	#0,d0
	moveq.l	#0,d1
	
	move.l	#sound_table,a0
	move.w	sound_chan1,d0
	move.l	(a0,d0.w*4),a0

	bsr.s	Play_Sounds
	clr.w	Sound_chan1
quit_sound_effects
	rts

	
********************************************	
* Custom Base in a6, Sound Structure in a0 *
********************************************
	
Play_Sounds


Channel3
	cmp.l	#0,a0				; channel 2
	beq.s	channel_done
	bset.l	#3,d1				; set for turn off
	move.l	Sound_Ptr(a0),aud3+ac_ptr(a6)
	move.w	Sound_Length(a0),aud3+ac_len(a6)
	move.w	Sound_Period(a0),aud3+ac_per(a6)
	move.w	Sound_Volume(a0),aud3+ac_vol(a6)
channel_done	
Disable_Sound
	move.w	d1,$96(a6)			; turn of channels
	move.w	#600,d7
RestSND	dbf	d7,RestSND			; give DMA time to stop

Enable_Sound
	bset.l	#15,d1
	move.w	d1,$96(a6)			; turn channels on
	move.w	#600,d7
ClrSND	dbf	d7,ClrSND			; give DMA time to start


	move.l	#blank,aud3+ac_ptr(a6)		; blank sound data
	move.w	#1,aud3+ac_len(a6)		; 1 word 	
	rts

Sound_Flags	dc.w	0

sound_table
	dc.l	0
	dc.l	HeadButt_Noise
	dc.l	Jump_Noise
	dc.l	Jump_Water_Noise
	dc.l	Spangle_Noise
	dc.l	Coin_Noise
	dc.l	Alienhit_Noise
	dc.l	Blocksplit_Noise
	dc.l	Bumhit_Noise	
	dc.l	SquizHurt_Noise
	dc.l	Click_Noise
	dc.l	Cowbell_Noise
	dc.l	Spring_Noise
	dc.l	Slide_Noise
	dc.l	Swoosh_Noise
	dc.l	Chuck_Noise
	dc.l	Slap_Noise
	dc.l	Bat_Noise
	dc.l	Wallhit_Noise
	dc.l	Fruit_Noise
		
sound_chan1
	dc.w	0
