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

Sound_HeadButt	EQU	0
Sound_Jump	EQU	1
Sound_Spangle	EQU	2
Sound_Coin	EQU	3

Sound_Effects

	moveq.l	#0,d0
	move.l	d0,a0
	move.l	d0,a1
	move.l	d0,a2
	move.l	d0,a3

	btst.b	#Sound_HeadButt,Sound_Flags
	beq.s	no_head_sound
	move.l	#HeadButt_Noise,a0
no_head_sound
	btst.b	#Sound_Jump,Sound_Flags
	beq.s	no_jump_sound
	move.l	#Jump_Noise,a0
no_jump_sound
	btst.b	#Sound_Spangle,Sound_Flags
	beq.s	no_spangle_sound
	move.l	#Spangle_Noise,a0
no_spangle_sound
	btst.b	#Sound_Coin,Sound_Flags
	beq.s	no_coin_sound
	move.l	#Coin_Noise,a0
no_coin_sound


	bsr.s	Play_Sounds
	clr.w	Sound_Flags
quit_sound_effects
	rts

	
********************************************	
* Custom Base in a6, Sound Structure in a0 *
********************************************
	
Play_Sounds

	moveq.w	#0,d0
Channel0
	cmp.l	#0,a0				; channel 0
	beq.s	Channel2
	bset.l	#0,d0				; set for turn off
	move.l	Sound_Ptr(a0),aud0+ac_ptr(a6)
	move.w	Sound_Length(a0),aud0+ac_len(a6)
	move.w	Sound_Period(a0),aud0+ac_per(a6)
	move.w	Sound_Volume(a0),aud0+ac_vol(a6)


Channel2
	cmp.l	#0,a2				; channel 2
	beq.s	Channel3
	bset.l	#2,d0				; set for turn off
	move.l	Sound_Ptr(a2),aud2+ac_ptr(a6)
	move.w	Sound_Length(a2),aud2+ac_len(a6)
	move.w	Sound_Period(a2),aud2+ac_per(a6)
	move.w	Sound_Volume(a2),aud2+ac_vol(a6)
Channel3
	cmp.l	#0,a3				; channel 3
	beq.s	Disable_Sound
	bset.l	#3,d0   				; set for turn off
	move.l	Sound_Ptr(a3),aud3+ac_ptr(a6)
	move.w	Sound_Length(a3),aud3+ac_len(a6)
	move.w	Sound_Period(a3),aud3+ac_per(a6)
	move.w	Sound_Volume(a3),aud3+ac_vol(a6)
	
Disable_Sound
	move.w	d0,$96(a6)			; turn of channels
	move.w	#1000,d7
RestSND	dbf	d7,RestSND			; give DMA time to stop

Enable_Sound
	bset.l	#15,d0
	move.w	d0,$96(a6)			; turn channels on
	move.w	#1000,d7
ClrSND	dbf	d7,ClrSND			; give DMA time to start

	move.l	#blank,aud0+ac_ptr(a6)		; blank sound data
	move.l	#blank,aud1+ac_ptr(a6)		; blank sound data
	move.l	#blank,aud2+ac_ptr(a6)		; blank sound data
	move.l	#blank,aud3+ac_ptr(a6)		; blank sound data
	move.w	#1,aud0+ac_len(a6)		; 1 word 
	move.w	#1,aud1+ac_len(a6)		; 1 word 
	move.w	#1,aud2+ac_len(a6)		; 1 word 
	move.w	#1,aud3+ac_len(a6)		; 1 word 	
	rts

Sound_Flags	dc.w	0

