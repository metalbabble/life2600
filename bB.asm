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

.
 ; 

.L09 ;  rem x, y are used for loops. z used for bits

;.flipNeeded.  z{0}.
.L010 ;  def flipNeeded  =  z{0}

.
 ; 

.
 ; 

;.MAXX.  30.
.L011 ;  def MAXX  =  30

;.MAXY.  20.
.L012 ;  def MAXY  =  20

;.FILLVALUE.  50.
.L013 ;  def FILLVALUE  =  50

;.RES.  32.
.L014 ;  def RES  =  32

;.REDRAW_FRAME.  6.
.L015 ;  def REDRAW_FRAME  =  6

.
 ; 

.L016 ;  goto Init bank2

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

.L017 ;  bank 2

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
.L018 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.Init
 ; Init

.L019 ;  drawscreen

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
.L020 ;  pfclear

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
.L021 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.
 ; 

.L022 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L023 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L024 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
	STA z
.L025 ;  var0  =  0  :  var1  =  0  :  var2  =  0  :  var3  =  0  :  var4  =  0

	LDA #0
	STA var0
	STA var1
	STA var2
	STA var3
	STA var4
.L026 ;  var5  =  0  :  var6  =  0  :  var7  =  0  :  var8  =  0

	LDA #0
	STA var5
	STA var6
	STA var7
	STA var8
.
 ; 

.
 ; 

.L027 ;  scorecolors:

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

.L028 ;  gosub SeedRandom bank4

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(.SeedRandom-1)
 pha
 lda #<(.SeedRandom-1)
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

.L029 ;  goto MainLoop bank3

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

.L030 ;  bank 3

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
.L031 ;  temp1 = temp1

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

.L032 ;  stackCounter  =  0

	LDA #0
	STA stackCounter
.
 ; 

.
 ; 

.L033 ;  for y  =  1 to MAXY

	LDA #1
	STA y
.L033fory
.L034 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L034forx
.
 ; 

.
 ; 

.L035 ;  neighbors  =  0

	LDA #0
	STA neighbors
.
 ; 

.L036 ;  chkX  =  x  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
.L037 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

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
	BNE .skipL037
.condpart0
	INC neighbors
.skipL037
.L038 ;  chkY  =  y  -  1

	LDA y
	SEC
	SBC #1
	STA chkY
.L039 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL039
.condpart1
	INC neighbors
.skipL039
.L040 ;  chkX  =  x  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
.L041 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

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
	BNE .skipL041
.condpart2
	INC neighbors
.skipL041
.L042 ;  chkY  =  y  +  1

	LDA y
	CLC
	ADC #1
	STA chkY
.L043 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL043
.condpart3
	INC neighbors
.skipL043
.
 ; 

.L044 ;  chkX  =  x  -  1  :  chkY  =  y  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	SEC
	SBC #1
	STA chkY
.L045 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL045
.condpart4
	INC neighbors
.skipL045
.L046 ;  chkX  =  x  -  1  :  chkY  =  y  +  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	CLC
	ADC #1
	STA chkY
.L047 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL047
.condpart5
	INC neighbors
.skipL047
.L048 ;  chkX  =  x  +  1  :  chkY  =  y  -  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	SEC
	SBC #1
	STA chkY
.L049 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL049
.condpart6
	INC neighbors
.skipL049
.L050 ;  chkX  =  x  +  1  :  chkY  =  y  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	CLC
	ADC #1
	STA chkY
.L051 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL051
.condpart7
	INC neighbors
.skipL051
.
 ; 

.
 ; 

.L052 ;  flipNeeded  =  0

	LDA z
	AND #254
	STA z
.L053 ;  if !pfread ( x , y )  then goto __deadCellChecks

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
	BEQ .skipL053
.condpart8
 jmp .__deadCellChecks

.skipL053
.
 ; 

.__livingCellChecks
 ; __livingCellChecks

.L054 ;  if neighbors  <  2 then flipNeeded  =  1

	LDA neighbors
	CMP #2
     BCS .skipL054
.condpart9
	LDA z
	ORA #1
	STA z
.skipL054
.L055 ;  if neighbors  >  3 then flipNeeded  =  1

	LDA #3
	CMP neighbors
     BCS .skipL055
.condpart10
	LDA z
	ORA #1
	STA z
.skipL055
.L056 ;  goto __doneChecking

 jmp .__doneChecking

.__deadCellChecks
 ; __deadCellChecks

.L057 ;  if neighbors  =  3 then flipNeeded  =  1

	LDA neighbors
	CMP #3
     BNE .skipL057
.condpart11
	LDA z
	ORA #1
	STA z
.skipL057
.__doneChecking
 ; __doneChecking

.
 ; 

.
 ; 

.L058 ;  if !flipNeeded goto __doneStackPush

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

.L059 ;  push x y

	lda x
	sta DF7PUSH
	lda y
	sta DF7PUSH
.L060 ;  stackCounter  =  stackCounter  +  1

	INC stackCounter
.__doneStackPush
 ; __doneStackPush

.
 ; 

.L061 ;  gosub DrawUpdate

 jsr .DrawUpdate

.L062 ;  next

	LDA x
	CMP #30

	INC x
 if ((* - .L034forx) < 127) && ((* - .L034forx) > -128)
	bcc .L034forx
 else
	bcs .1skipL034forx
	jmp .L034forx
.1skipL034forx
 endif
.L063 ;  next

	LDA y
	CMP #20

	INC y
 if ((* - .L033fory) < 127) && ((* - .L033fory) > -128)
	bcc .L033fory
 else
	bcs .2skipL033fory
	jmp .L033fory
.2skipL033fory
 endif
.
 ; 

.
 ; 

.L064 ;  for tmp  =  stackCounter to 1 step -1

	LDA stackCounter
	STA tmp
.L064fortmp
.L065 ;  pull x y

	lda DF7DATA
	sta y
	lda DF7DATA
	sta x
.L066 ;  pfpixel x y flip

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

.L067 ;  gosub DrawUpdate

 jsr .DrawUpdate

.L068 ;  next

	LDA tmp
	CLC
	ADC #-1

 if ((* - .L064fortmp_failsafe) < 127) && ((* - .L064fortmp_failsafe) > -128)
	bcc .L064fortmp_failsafe
 else
	bcs .3skipL064fortmp_failsafe
	jmp .L064fortmp_failsafe
.3skipL064fortmp_failsafe
 endif
	STA tmp
	CMP #1
 if ((* - .L064fortmp) < 127) && ((* - .L064fortmp) > -128)
	bcs .L064fortmp
 else
	bcc .4skipL064fortmp
	jmp .L064fortmp
.4skipL064fortmp
 endif
.L064fortmp_failsafe
.
 ; 

.
 ; 

.L069 ;  score  =  score  +  1

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
.L070 ;  goto MainLoop

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

.L071 ;  if drawCounter  <  REDRAW_FRAME then drawCounter  =  drawCounter  +  1 else drawCounter  =  0

	LDA drawCounter
	CMP #6
     BCS .skipL071
.condpart12
	INC drawCounter
 jmp .skipelse0
.skipL071
	LDA #0
	STA drawCounter
.skipelse0
.L072 ;  if drawCounter  <>  0 then return

	LDA drawCounter
	CMP #0
     BEQ .skipL072
.condpart13
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skipL072
.
 ; 

.
 ; 

.L073 ;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL073
	STA PARAMETER
	LDA #((>playfieldcolorL073) & $0f) | (((>playfieldcolorL073) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.L074 ;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL074
	STA PARAMETER
	LDA #((>backgroundcolorL074) & $0f) | (((>backgroundcolorL074) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ; 

.L075 ;  DF6FRACINC  =  1  :  DF4FRACINC  =  1

	LDA #1
	STA DF6FRACINC
	STA DF4FRACINC
.L076 ;  DF0FRACINC  =  RES  :  DF1FRACINC  =  RES

	LDA #32
	STA DF0FRACINC
	STA DF1FRACINC
.L077 ;  DF2FRACINC  =  RES  :  DF3FRACINC  =  RES

	LDA #32
	STA DF2FRACINC
	STA DF3FRACINC
.
 ; 

.L078 ;  drawscreen

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
.L079 ;  return

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

.L080 ;  bank 4

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
.L081 ;  temp1 = temp1

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

.SeedRandom
 ; SeedRandom

.L082 ;  for y  =  1 to MAXY

	LDA #1
	STA y
.L082fory
.L083 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L083forx
.L084 ;  if rand  <  FILLVALUE then pfpixel x y on

	LDA rand
	CMP #50
     BCS .skipL084
.condpart14
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
.skipL084
.L085 ;  next

	LDA x
	CMP #30

	INC x
 if ((* - .L083forx) < 127) && ((* - .L083forx) > -128)
	bcc .L083forx
 else
	bcs .5skipL083forx
	jmp .L083forx
.5skipL083forx
 endif
.L086 ;  drawscreen

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
.L087 ;  next

	LDA y
	CMP #20

	INC y
 if ((* - .L082fory) < 127) && ((* - .L082fory) > -128)
	bcc .L082fory
 else
	bcs .6skipL082fory
	jmp .L082fory
.6skipL082fory
 endif
.L088 ;  return

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

.SeedGlider
 ; SeedGlider

.L089 ;  playfield:

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
.L090 ;  return

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

.SeedExploders
 ; SeedExploders

.L091 ;  playfield:

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

.SeedMix
 ; SeedMix

.L093 ;  playfield:

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

.L095 ;  bank 5

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
.L096 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.
 ; 

.L097 ;  bank 6

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
.L098 ;  temp1 = temp1
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
playfieldcolorL073
	.byte  $3c
backgroundcolorL074
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
 
 
 
