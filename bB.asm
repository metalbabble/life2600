game
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L00 ;  set kernel DPC + 

.L01 ;  set tv ntsc

.L02 ;  set smartbranching on

.
 ; 

.
 ; 

.L03 ;  dim stackCounter  =  a

.L04 ;  dim neighbors  =  b

.L05 ;  dim chkX  =  c

.L06 ;  dim chkY  =  d

.L07 ;  dim tmp  =  e

.L08 ;  dim drawCounter  =  f

.L09 ;  dim startingSeed  =  g

.
 ; 

.L010 ;  rem x, y are used for loops. z used for bits

;.flipNeeded.  z{0}.
.L011 ;  def flipNeeded  =  z{0}

.
 ; 

.
 ; 

;.MAXX.  30.
.L012 ;  def MAXX  =  30

;.MAXY.  20.
.L013 ;  def MAXY  =  20

;.FILLVALUE.  50.
.L014 ;  def FILLVALUE  =  50

;.RES.  32.
.L015 ;  def RES  =  32

;.REDRAW_FRAME.  4.
.L016 ;  def REDRAW_FRAME  =  4

.
 ; 

.L017 ;  goto Init bank2

 sta temp7
 lda #>(.Init-1)
 pha
 lda #<(.Init-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L018 ;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $1FF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $1FFC
 .word start_bank1
 .word start_bank1
 ORG $2000
 RORG $3000
HMdiv
  .byte 0, 0, 0, 0, 0, 0, 0
  .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2
  .byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3
  .byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4
  .byte 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5
  .byte 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6
  .byte 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7
  .byte 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8
  .byte 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9
  .byte 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10
  .byte 10,10,10,10,10,10,0,0,0
.L019 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.Init
 ; Init

.L020 ;  drawscreen

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point1
.L021 ;  pfclear

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	ldx #28
	stx DF0WRITE
	LDA #0
	sta DF0WRITE
	lda #255
	sta CALLFUNCTION
.L022 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.
 ; 

.L023 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

	LDA #0
	STA a
	STA b
	STA c
	STA d
	STA e
	STA f
	STA g
	STA h
	STA i
.L024 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

	LDA #0
	STA j
	STA k
	STA l
	STA m
	STA n
	STA o
	STA p
	STA q
	STA r
.L025 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
	STA z
.L026 ;  var0  =  0  :  var1  =  0  :  var2  =  0  :  var3  =  0  :  var4  =  0

	LDA #0
	STA var0
	STA var1
	STA var2
	STA var3
	STA var4
.L027 ;  var5  =  0  :  var6  =  0  :  var7  =  0  :  var8  =  0

	LDA #0
	STA var5
	STA var6
	STA var7
	STA var8
.
 ; 

.
 ; 

.L028 ;  scorecolors:

	lda #<scoredata
	STA DF0LOW
	lda #((>scoredata) & $0f)
	STA DF0HI
	lda #$1E

	sta DF0WRITE
	lda #$1C

	sta DF0WRITE
	lda #$1A

	sta DF0WRITE
	lda #$1A

	sta DF0WRITE
	lda #$18

	sta DF0WRITE
	lda #$18

	sta DF0WRITE
	lda #$16

	sta DF0WRITE
	lda #$16

	sta DF0WRITE
.
 ; 

.
 ; 

.L029 ;  gosub SelectSeed bank4

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(.SelectSeed-1)
 pha
 lda #<(.SelectSeed-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point2
.
 ; 

.L030 ;  goto MainLoop bank3

 sta temp7
 lda #>(.MainLoop-1)
 pha
 lda #<(.MainLoop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L031 ;  bank 3

 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $3FF4-bscode_length
start_bank2 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $2FFC
 RORG $3FFC
 .word start_bank2
 .word start_bank2
 ORG $3000
 RORG $5000
 repeat 129
 .byte 0
 repend
.L032 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.
 ; 

.MainLoop
 ; MainLoop

.
 ; 

.
 ; 

.L033 ;  stackCounter  =  0

	LDA #0
	STA stackCounter
.
 ; 

.
 ; 

.L034 ;  for y  =  1 to MAXY

	LDA #1
	STA y
.L034fory
.L035 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L035forx
.
 ; 

.
 ; 

.L036 ;  neighbors  =  0

	LDA #0
	STA neighbors
.
 ; 

.L037 ;  chkX  =  x  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
.L038 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY y
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL038
.condpart0
	INC neighbors
.skipL038
.L039 ;  chkY  =  y  -  1

	LDA y
	SEC
	SBC #1
	STA chkY
.L040 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA x
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL040
.condpart1
	INC neighbors
.skipL040
.L041 ;  chkX  =  x  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
.L042 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY y
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL042
.condpart2
	INC neighbors
.skipL042
.L043 ;  chkY  =  y  +  1

	LDA y
	CLC
	ADC #1
	STA chkY
.L044 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA x
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL044
.condpart3
	INC neighbors
.skipL044
.
 ; 

.L045 ;  chkX  =  x  -  1  :  chkY  =  y  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	SEC
	SBC #1
	STA chkY
.L046 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL046
.condpart4
	INC neighbors
.skipL046
.L047 ;  chkX  =  x  -  1  :  chkY  =  y  +  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	CLC
	ADC #1
	STA chkY
.L048 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL048
.condpart5
	INC neighbors
.skipL048
.L049 ;  chkX  =  x  +  1  :  chkY  =  y  -  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	SEC
	SBC #1
	STA chkY
.L050 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL050
.condpart6
	INC neighbors
.skipL050
.L051 ;  chkX  =  x  +  1  :  chkY  =  y  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	CLC
	ADC #1
	STA chkY
.L052 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA chkX
	STA DF0WRITE
	LDY chkY
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BNE .skipL052
.condpart7
	INC neighbors
.skipL052
.
 ; 

.
 ; 

.L053 ;  flipNeeded  =  0

	LDA z
	AND #254
	STA z
.L054 ;  if !pfread ( x , y )  then goto __deadCellChecks

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
    lda #24
    sta DF0WRITE
	LDA x
	STA DF0WRITE
	LDY y
	STY DF0WRITE
	lda #255
	sta CALLFUNCTION
    LDA DF0DATA
	BEQ .skipL054
.condpart8
 jmp .__deadCellChecks

.skipL054
.
 ; 

.__livingCellChecks
 ; __livingCellChecks

.L055 ;  if neighbors  <  2 then flipNeeded  =  1

	LDA neighbors
	CMP #2
     BCS .skipL055
.condpart9
	LDA z
	ORA #1
	STA z
.skipL055
.L056 ;  if neighbors  >  3 then flipNeeded  =  1

	LDA #3
	CMP neighbors
     BCS .skipL056
.condpart10
	LDA z
	ORA #1
	STA z
.skipL056
.L057 ;  goto __doneChecking

 jmp .__doneChecking

.__deadCellChecks
 ; __deadCellChecks

.L058 ;  if neighbors  =  3 then flipNeeded  =  1

	LDA neighbors
	CMP #3
     BNE .skipL058
.condpart11
	LDA z
	ORA #1
	STA z
.skipL058
.__doneChecking
 ; __doneChecking

.
 ; 

.
 ; 

.L059 ;  if !flipNeeded goto __doneStackPush

	LDA z
	LSR
 if ((* - .__doneStackPush) < 127) && ((* - .__doneStackPush) > -128)
	bcc .__doneStackPush
 else
	bcs .0skip__doneStackPush
	jmp .__doneStackPush
.0skip__doneStackPush
 endif
.
 ; 

.
 ; 

.L060 ;  push x y

	lda x
	sta DF7PUSH
	lda y
	sta DF7PUSH
.L061 ;  stackCounter  =  stackCounter  +  1

	INC stackCounter
.__doneStackPush
 ; __doneStackPush

.
 ; 

.L062 ;  gosub DrawUpdate

 jsr .DrawUpdate

.L063 ;  next

	LDA x
	CMP #30

	INC x
 if ((* - .L035forx) < 127) && ((* - .L035forx) > -128)
	bcc .L035forx
 else
	bcs .1skipL035forx
	jmp .L035forx
.1skipL035forx
 endif
.L064 ;  next

	LDA y
	CMP #20

	INC y
 if ((* - .L034fory) < 127) && ((* - .L034fory) > -128)
	bcc .L034fory
 else
	bcs .2skipL034fory
	jmp .L034fory
.2skipL034fory
 endif
.
 ; 

.
 ; 

.L065 ;  for tmp  =  stackCounter to 1 step -1

	LDA stackCounter
	STA tmp
.L065fortmp
.L066 ;  pull x y

	lda DF7DATA
	sta y
	lda DF7DATA
	sta x
.L067 ;  pfpixel x y flip

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #14
	STX DF0WRITE
	STX DF0WRITE
	LDY y
	STY DF0WRITE
	LDA x
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.
 ; 

.L068 ;  gosub DrawUpdate

 jsr .DrawUpdate

.L069 ;  next

	LDA tmp
	CLC
	ADC #-1

 if ((* - .L065fortmp_failsafe) < 127) && ((* - .L065fortmp_failsafe) > -128)
	bcc .L065fortmp_failsafe
 else
	bcs .3skipL065fortmp_failsafe
	jmp .L065fortmp_failsafe
.3skipL065fortmp_failsafe
 endif
	STA tmp
	CMP #1
 if ((* - .L065fortmp) < 127) && ((* - .L065fortmp) > -128)
	bcs .L065fortmp
 else
	bcc .4skipL065fortmp
	jmp .L065fortmp
.4skipL065fortmp
 endif
.L065fortmp_failsafe
.
 ; 

.
 ; 

.L070 ;  score  =  score  +  1

	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.L071 ;  goto MainLoop

 jmp .MainLoop

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.DrawUpdate
 ; DrawUpdate

.
 ; 

.L072 ;  if switchreset then goto ChangeGameAndReset bank4

 lda #1
 bit SWCHB
	BNE .skipL072
.condpart12
 sta temp7
 lda #>(.ChangeGameAndReset-1)
 pha
 lda #<(.ChangeGameAndReset-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL072
.
 ; 

.
 ; 

.L073 ;  if drawCounter  <  REDRAW_FRAME then drawCounter  =  drawCounter  +  1 else drawCounter  =  0

	LDA drawCounter
	CMP #4
     BCS .skipL073
.condpart13
	INC drawCounter
 jmp .skipelse0
.skipL073
	LDA #0
	STA drawCounter
.skipelse0
.L074 ;  if drawCounter  <>  0 then return

	LDA drawCounter
	CMP #0
     BEQ .skipL074
.condpart14
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skipL074
.
 ; 

.
 ; 

.L075 ;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL075
	STA PARAMETER
	LDA #((>playfieldcolorL075) & $0f) | (((>playfieldcolorL075) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.L076 ;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL076
	STA PARAMETER
	LDA #((>backgroundcolorL076) & $0f) | (((>backgroundcolorL076) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ; 

.L077 ;  DF6FRACINC  =  1  :  DF4FRACINC  =  1

	LDA #1
	STA DF6FRACINC
	STA DF4FRACINC
.L078 ;  DF0FRACINC  =  RES  :  DF1FRACINC  =  RES

	LDA #32
	STA DF0FRACINC
	STA DF1FRACINC
.L079 ;  DF2FRACINC  =  RES  :  DF3FRACINC  =  RES

	LDA #32
	STA DF2FRACINC
	STA DF3FRACINC
.
 ; 

.L080 ;  drawscreen

 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point3
.L081 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L082 ;  bank 4

 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $5FF4-bscode_length
start_bank3 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $3FFC
 RORG $5FFC
 .word start_bank3
 .word start_bank3
 ORG $4000
 RORG $7000
 repeat 129
 .byte 0
 repend
.L083 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.SelectSeed
 ; SelectSeed

.L084 ;  on startingSeed gosub SeedRandom SeedGlider SeedExploders SeedMix

	lda #>(ongosub0-1)
	PHA
	lda #<(ongosub0-1)
	PHA
	LDX startingSeed
	LDA .L084jumptablehi,x
	PHA
	LDA .L084jumptablelo,x
	PHA
	RTS
.L084jumptablehi
	.byte >(.SeedRandom-1)
	.byte >(.SeedGlider-1)
	.byte >(.SeedExploders-1)
	.byte >(.SeedMix-1)
.L084jumptablelo
	.byte <(.SeedRandom-1)
	.byte <(.SeedGlider-1)
	.byte <(.SeedExploders-1)
	.byte <(.SeedMix-1)
ongosub0
.L085 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.SeedRandom
 ; SeedRandom

.L086 ;  for y  =  1 to MAXY

	LDA #1
	STA y
.L086fory
.L087 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L087forx
.L088 ;  if rand  <  FILLVALUE then pfpixel x y on

	LDA rand
	CMP #50
     BCS .skipL088
.condpart15
	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	LDX #12
	STX DF0WRITE
	STX DF0WRITE
	LDY y
	STY DF0WRITE
	LDA x
	STA DF0WRITE
	lda #255
	sta CALLFUNCTION
.skipL088
.L089 ;  next

	LDA x
	CMP #30

	INC x
 if ((* - .L087forx) < 127) && ((* - .L087forx) > -128)
	bcc .L087forx
 else
	bcs .5skipL087forx
	jmp .L087forx
.5skipL087forx
 endif
.L090 ;  drawscreen

 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point4
.L091 ;  next

	LDA y
	CMP #20

	INC y
 if ((* - .L086fory) < 127) && ((* - .L086fory) > -128)
	bcc .L086fory
 else
	bcs .6skipL086fory
	jmp .L086fory
.6skipL086fory
 endif
.L092 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.SeedGlider
 ; SeedGlider

.L093 ;  playfield:

 ldy #17
	LDA #<PF_data1
	LDX #((>PF_data1) & $0f) | (((>PF_data1) / 2) & $70)
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(pfsetup-1)
 pha
 lda #<(pfsetup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point5
.L094 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.SeedExploders
 ; SeedExploders

.L095 ;  playfield:

 ldy #17
	LDA #<PF_data2
	LDX #((>PF_data2) & $0f) | (((>PF_data2) / 2) & $70)
 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(pfsetup-1)
 pha
 lda #<(pfsetup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point6
.L096 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.SeedMix
 ; SeedMix

.L097 ;  playfield:

 ldy #17
	LDA #<PF_data3
	LDX #((>PF_data3) & $0f) | (((>PF_data3) / 2) & $70)
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
 pha
 lda #>(pfsetup-1)
 pha
 lda #<(pfsetup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point7
.L098 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.ChangeGameAndReset
 ; ChangeGameAndReset

.L099 ;  if startingSeed  <  3 then startingSeed  =  startingSeed  +  1 else startingSeed  =  0

	LDA startingSeed
	CMP #3
     BCS .skipL099
.condpart16
	INC startingSeed
 jmp .skipelse1
.skipL099
	LDA #0
	STA startingSeed
.skipelse1
.L0100 ;  pfclear

	lda #<C_function
	sta DF0LOW
	lda #(>C_function) & $0F
	sta DF0HI
	ldx #28
	stx DF0WRITE
	LDA #0
	sta DF0WRITE
	lda #255
	sta CALLFUNCTION
.L0101 ;  drawscreen

 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point8
.L0102 ;  score  =  0

	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.L0103 ;  gosub SelectSeed

 jsr .SelectSeed

.L0104 ;  goto MainLoop bank3

 sta temp7
 lda #>(.MainLoop-1)
 pha
 lda #<(.MainLoop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.L0105 ;  bank 5

 if ECHO4
 echo "    ",[(start_bank4 - *)]d , "bytes of ROM space left in bank 4")
 endif
ECHO4 = 1
 ORG $4FF4-bscode_length
 RORG $7FF4-bscode_length
start_bank4 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $4FFC
 RORG $7FFC
 .word start_bank4
 .word start_bank4
 ORG $5000
 RORG $9000
 repeat 129
 .byte 0
 repend
.L0106 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.
 ; 

.L0107 ;  bank 6

 if ECHO5
 echo "    ",[(start_bank5 - *)]d , "bytes of ROM space left in bank 5")
 endif
ECHO5 = 1
 ORG $5FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank5 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $5FFC
 RORG $9FFC
 .word start_bank5
 .word start_bank5
 ORG $6000
 RORG $B000
 repeat 129
 .byte 0
 repend
.L0108 ;  temp1 = temp1
	LDA temp1
	STA temp1
 if ECHO6
 echo "    ",[(start_bank6 - *)]d , "bytes of ROM space left in bank 6")
 endif
ECHO6 = 1
 ORG $6FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank6 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $6FFC
 RORG $BFFC
 .word start_bank6
 .word start_bank6
 ORG $7000
 RORG $D000
 repeat 129
 .byte 0
 repend
; bB.asm file is split here
playfieldcolorL075
	.byte  $3c
backgroundcolorL076
	.byte  $00
PF_data1
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00010000
	.byte %00100000
	.byte %00111000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
PF_data2
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00010101
	.byte %00010001
	.byte %00010001
	.byte %00010001
	.byte %00010101
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000010
	.byte %00000111
	.byte %00000101
	.byte %00000010
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
PF_data3
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00001000
	.byte %00011100
	.byte %00010100
	.byte %00001000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00010000
	.byte %00100000
	.byte %00111000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
 if ECHOFIRST
       echo "    ",[(DPC_graphics_end - *)]d , "bytes of ROM space left in graphics bank")
 endif 
ECHOFIRST = 1
 
 
 
