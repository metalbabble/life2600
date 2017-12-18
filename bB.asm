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

;.resetFlag.  z{1}.
.L012 ;  def resetFlag  =  z{1}

.
 ; 

.
 ; 

;.MAXX.  32.
.L013 ;  def MAXX  =  32

;.MAXY.  21.
.L014 ;  def MAXY  =  21

;.FILLVALUE.  50.
.L015 ;  def FILLVALUE  =  50

;.RES.  32.
.L016 ;  def RES  =  32

;.REDRAW_FRAME.  4.
.L017 ;  def REDRAW_FRAME  =  4

.
 ; 

.L018 ;  goto Init bank2

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

.L019 ;  bank 2

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
.L020 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.Init
 ; Init

.L021 ;  drawscreen

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
.L022 ;  pfclear

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
.L023 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.
 ; 

.L024 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L025 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L026 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
	STA z
.L027 ;  var0  =  0  :  var1  =  0  :  var2  =  0  :  var3  =  0  :  var4  =  0

	LDA #0
	STA var0
	STA var1
	STA var2
	STA var3
	STA var4
.L028 ;  var5  =  0  :  var6  =  0  :  var7  =  0  :  var8  =  0

	LDA #0
	STA var5
	STA var6
	STA var7
	STA var8
.
 ; 

.
 ; 

.L029 ;  scorecolors:

	lda #<scoredata
	STA DF0LOW
	lda #((>scoredata) & $0f)
	STA DF0HI
	lda #$9E

	sta DF0WRITE
	lda #$9C

	sta DF0WRITE
	lda #$9A

	sta DF0WRITE
	lda #$9A

	sta DF0WRITE
	lda #$98

	sta DF0WRITE
	lda #$98

	sta DF0WRITE
	lda #$96

	sta DF0WRITE
	lda #$96

	sta DF0WRITE
.
 ; 

.
 ; 

.L030 ;  gosub SelectSeed bank4

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

.L031 ;  goto MainLoop bank3

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

.L032 ;  bank 3

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
.L033 ;  temp1 = temp1

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

.L034 ;  stack 0  :  stackCounter  =  0

	lda #<(STACKbegin+0)
	STA DF7LOW
	lda #(>(STACKbegin+0)) & $0F
	STA DF7HI
	LDA #0
	STA stackCounter
.
 ; 

.
 ; 

.L035 ;  for y  =  0 to MAXY

	LDA #0
	STA y
.L035fory
.L036 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L036forx
.
 ; 

.
 ; 

.L037 ;  neighbors  =  0

	LDA #0
	STA neighbors
.
 ; 

.L038 ;  chkX  =  x  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
.L039 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

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
	BNE .skipL039
.condpart0
	INC neighbors
.skipL039
.L040 ;  chkY  =  y  -  1

	LDA y
	SEC
	SBC #1
	STA chkY
.L041 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL041
.condpart1
	INC neighbors
.skipL041
.L042 ;  chkX  =  x  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
.L043 ;  if pfread ( chkX ,  y )  then neighbors  =  neighbors  +  1

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
	BNE .skipL043
.condpart2
	INC neighbors
.skipL043
.L044 ;  chkY  =  y  +  1

	LDA y
	CLC
	ADC #1
	STA chkY
.L045 ;  if pfread ( x ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL045
.condpart3
	INC neighbors
.skipL045
.
 ; 

.L046 ;  chkX  =  x  -  1  :  chkY  =  y  -  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	SEC
	SBC #1
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
.condpart4
	INC neighbors
.skipL047
.L048 ;  chkX  =  x  -  1  :  chkY  =  y  +  1

	LDA x
	SEC
	SBC #1
	STA chkX
	LDA y
	CLC
	ADC #1
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
.condpart5
	INC neighbors
.skipL049
.L050 ;  chkX  =  x  +  1  :  chkY  =  y  -  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	SEC
	SBC #1
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
.condpart6
	INC neighbors
.skipL051
.L052 ;  chkX  =  x  +  1  :  chkY  =  y  +  1

	LDA x
	CLC
	ADC #1
	STA chkX
	LDA y
	CLC
	ADC #1
	STA chkY
.L053 ;  if pfread ( chkX ,  chkY )  then neighbors  =  neighbors  +  1

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
	BNE .skipL053
.condpart7
	INC neighbors
.skipL053
.
 ; 

.
 ; 

.L054 ;  flipNeeded  =  0

	LDA z
	AND #254
	STA z
.L055 ;  if !pfread ( x , y )  then goto __deadCellChecks

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
	BEQ .skipL055
.condpart8
 jmp .__deadCellChecks

.skipL055
.
 ; 

.__livingCellChecks
 ; __livingCellChecks

.L056 ;  if neighbors  <  2 then flipNeeded  =  1

	LDA neighbors
	CMP #2
     BCS .skipL056
.condpart9
	LDA z
	ORA #1
	STA z
.skipL056
.L057 ;  if neighbors  >  3 then flipNeeded  =  1

	LDA #3
	CMP neighbors
     BCS .skipL057
.condpart10
	LDA z
	ORA #1
	STA z
.skipL057
.L058 ;  goto __doneChecking

 jmp .__doneChecking

.__deadCellChecks
 ; __deadCellChecks

.L059 ;  if neighbors  =  3 then flipNeeded  =  1

	LDA neighbors
	CMP #3
     BNE .skipL059
.condpart11
	LDA z
	ORA #1
	STA z
.skipL059
.__doneChecking
 ; __doneChecking

.
 ; 

.
 ; 

.L060 ;  if !flipNeeded goto __doneStackPush

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

.L061 ;  push x y

	lda x
	sta DF7PUSH
	lda y
	sta DF7PUSH
.L062 ;  stackCounter  =  stackCounter  +  1

	INC stackCounter
.__doneStackPush
 ; __doneStackPush

.
 ; 

.L063 ;  gosub DrawUpdate

 jsr .DrawUpdate

.L064 ;  next

	LDA x
	CMP #32

	INC x
 if ((* - .L036forx) < 127) && ((* - .L036forx) > -128)
	bcc .L036forx
 else
	bcs .1skipL036forx
	jmp .L036forx
.1skipL036forx
 endif
.L065 ;  next

	LDA y
	CMP #21

	INC y
 if ((* - .L035fory) < 127) && ((* - .L035fory) > -128)
	bcc .L035fory
 else
	bcs .2skipL035fory
	jmp .L035fory
.2skipL035fory
 endif
.
 ; 

.
 ; 

.L066 ;  for tmp  =  1 to stackCounter

	LDA #1
	STA tmp
.L066fortmp
.L067 ;  pull x y

	lda DF7DATA
	sta y
	lda DF7DATA
	sta x
.L068 ;  pfpixel x y flip

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L069 ;  if drawCounter  <  REDRAW_FRAME then drawCounter  =  drawCounter  +  1 else drawCounter  =  0

	LDA drawCounter
	CMP #4
     BCS .skipL069
.condpart12
	INC drawCounter
 jmp .skipelse0
.skipL069
	LDA #0
	STA drawCounter
.skipelse0
.L070 ;  if drawCounter  <>  0 then goto __endStackLoop

	LDA drawCounter
	CMP #0
     BEQ .skipL070
.condpart13
 jmp .__endStackLoop

.skipL070
.L071 ;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL071
	STA PARAMETER
	LDA #((>playfieldcolorL071) & $0f) | (((>playfieldcolorL071) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.L072 ;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL072
	STA PARAMETER
	LDA #((>backgroundcolorL072) & $0f) | (((>backgroundcolorL072) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.L073 ;  DF6FRACINC  =  1  :  DF4FRACINC  =  1

	LDA #1
	STA DF6FRACINC
	STA DF4FRACINC
.L074 ;  DF0FRACINC  =  RES  :  DF1FRACINC  =  RES

	LDA #32
	STA DF0FRACINC
	STA DF1FRACINC
.L075 ;  DF2FRACINC  =  RES  :  DF3FRACINC  =  RES

	LDA #32
	STA DF2FRACINC
	STA DF3FRACINC
.L076 ;  drawscreen

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
.__endStackLoop
 ; __endStackLoop

.L077 ;  next

	LDA tmp
	CMP stackCounter

	INC tmp
 if ((* - .L066fortmp) < 127) && ((* - .L066fortmp) > -128)
	bcc .L066fortmp
 else
	bcs .3skipL066fortmp
	jmp .L066fortmp
.3skipL066fortmp
 endif
.
 ; 

.
 ; 

.L078 ;  score  =  score  +  1

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
.L079 ;  goto MainLoop

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

.L080 ;  if !switchreset  &&  resetFlag then resetFlag  =  0

 lda #1
 bit SWCHB
	BEQ .skipL080
.condpart14
	LDA z
	AND #2
	BEQ .skip14then
.condpart15
	LDA z
	AND #253
	STA z
.skip14then
.skipL080
.L081 ;  if switchreset  &&  !resetFlag then goto ChangeGameAndReset bank4

 lda #1
 bit SWCHB
	BNE .skipL081
.condpart16
	LDA z
	AND #2
	BNE .skip16then
.condpart17
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
.skip16then
.skipL081
.
 ; 

.
 ; 

.L082 ;  if drawCounter  <  REDRAW_FRAME then drawCounter  =  drawCounter  +  1 else drawCounter  =  0

	LDA drawCounter
	CMP #4
     BCS .skipL082
.condpart18
	INC drawCounter
 jmp .skipelse1
.skipL082
	LDA #0
	STA drawCounter
.skipelse1
.L083 ;  if drawCounter  <>  0 then return

	LDA drawCounter
	CMP #0
     BEQ .skipL083
.condpart19
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skipL083
.
 ; 

.
 ; 

.L084 ;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL084
	STA PARAMETER
	LDA #((>playfieldcolorL084) & $0f) | (((>playfieldcolorL084) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.L085 ;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL085
	STA PARAMETER
	LDA #((>backgroundcolorL085) & $0f) | (((>backgroundcolorL085) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #1
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ; 

.L086 ;  DF6FRACINC  =  1  :  DF4FRACINC  =  1

	LDA #1
	STA DF6FRACINC
	STA DF4FRACINC
.L087 ;  DF0FRACINC  =  RES  :  DF1FRACINC  =  RES

	LDA #32
	STA DF0FRACINC
	STA DF1FRACINC
.L088 ;  DF2FRACINC  =  RES  :  DF3FRACINC  =  RES

	LDA #32
	STA DF2FRACINC
	STA DF3FRACINC
.
 ; 

.L089 ;  drawscreen

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

.L091 ;  bank 4

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
.L092 ;  temp1 = temp1

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

.L093 ;  on startingSeed gosub SeedRandom SeedGlider SeedExploders SeedMix SeedShip

	lda #>(ongosub0-1)
	PHA
	lda #<(ongosub0-1)
	PHA
	LDX startingSeed
	LDA .L093jumptablehi,x
	PHA
	LDA .L093jumptablelo,x
	PHA
	RTS
.L093jumptablehi
	.byte >(.SeedRandom-1)
	.byte >(.SeedGlider-1)
	.byte >(.SeedExploders-1)
	.byte >(.SeedMix-1)
	.byte >(.SeedShip-1)
.L093jumptablelo
	.byte <(.SeedRandom-1)
	.byte <(.SeedGlider-1)
	.byte <(.SeedExploders-1)
	.byte <(.SeedMix-1)
	.byte <(.SeedShip-1)
ongosub0
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

.SeedRandom
 ; SeedRandom

.L095 ;  for y  =  1 to MAXY

	LDA #1
	STA y
.L095fory
.L096 ;  for x  =  1 to MAXX

	LDA #1
	STA x
.L096forx
.L097 ;  if rand  <  FILLVALUE then pfpixel x y on

	LDA rand
	CMP #50
     BCS .skipL097
.condpart20
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
.skipL097
.L098 ;  next

	LDA x
	CMP #32

	INC x
 if ((* - .L096forx) < 127) && ((* - .L096forx) > -128)
	bcc .L096forx
 else
	bcs .4skipL096forx
	jmp .L096forx
.4skipL096forx
 endif
.L099 ;  drawscreen

 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
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
ret_point5
.L0100 ;  next

	LDA y
	CMP #21

	INC y
 if ((* - .L095fory) < 127) && ((* - .L095fory) > -128)
	bcc .L095fory
 else
	bcs .5skipL095fory
	jmp .L095fory
.5skipL095fory
 endif
.L0101 ;  return

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

.L0102 ;  playfield:

 ldy #17
	LDA #<PF_data1
	LDX #((>PF_data1) & $0f) | (((>PF_data1) / 2) & $70)
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
.L0103 ;  return

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

.L0104 ;  playfield:

 ldy #17
	LDA #<PF_data2
	LDX #((>PF_data2) & $0f) | (((>PF_data2) / 2) & $70)
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
.L0105 ;  return

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

.L0106 ;  playfield:

 ldy #17
	LDA #<PF_data3
	LDX #((>PF_data3) & $0f) | (((>PF_data3) / 2) & $70)
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
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
ret_point8
.L0107 ;  return

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

.SeedShip
 ; SeedShip

.L0108 ;  playfield:

 ldy #17
	LDA #<PF_data4
	LDX #((>PF_data4) & $0f) | (((>PF_data4) / 2) & $70)
 sta temp7
 lda #>(ret_point9-1)
 pha
 lda #<(ret_point9-1)
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
ret_point9
.L0109 ;  return

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

.L0110 ;  resetFlag  =  1

	LDA z
	ORA #2
	STA z
.L0111 ;  pop

	pla
	pla
.L0112 ;  startingSeed  =  startingSeed  +  1

	INC startingSeed
.L0113 ;  if startingSeed  >  4 then startingSeed  =  0

	LDA #4
	CMP startingSeed
     BCS .skipL0113
.condpart21
	LDA #0
	STA startingSeed
.skipL0113
.L0114 ;  pfclear

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
.L0115 ;  drawscreen

 sta temp7
 lda #>(ret_point10-1)
 pha
 lda #<(ret_point10-1)
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
ret_point10
.L0116 ;  score  =  0

	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.L0117 ;  stack 0  :  stackCounter  =  0

	lda #<(STACKbegin+0)
	STA DF7LOW
	lda #(>(STACKbegin+0)) & $0F
	STA DF7HI
	LDA #0
	STA stackCounter
.L0118 ;  gosub SelectSeed

 jsr .SelectSeed

.L0119 ;  goto MainLoop bank3

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

.L0120 ;  bank 5

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
.L0121 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.
 ; 

.L0122 ;  bank 6

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
.L0123 ;  temp1 = temp1
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
playfieldcolorL071
	.byte  $3c
backgroundcolorL072
	.byte  $00
playfieldcolorL084
	.byte  $3c
backgroundcolorL085
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
PF_data4
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
	.byte %00111100
	.byte %01000100
	.byte %00000100
	.byte %01001000
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
 
 
 
