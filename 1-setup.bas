;----------------------------------------
;Life2600: based on Conway's Game of Life
;Written by Brian Shea / metalbabble.com
;----------------------------------------
;START BANK 1 - kernel options and defs
;----------------------------------------

 set kernel DPC+
 set tv ntsc
 set smartbranching on

;---Define vars---
 dim stackCounter = a
 dim neighbors = b
 dim chkX = c
 dim chkY = d
 dim tmp = e
 dim drawCounter = f
 dim startingSeed = g
 
 rem x, y are used for loops. z used for bits
 def flipNeeded = z{0}

;---Define constants---
 def MAXX = 30        ; max x
 def MAXY = 20        ; max y
 def FILLVALUE = 50   ; higher value = more seed
 def RES = 32         ; playfield resolution
 def REDRAW_FRAME = 4 ; drawscreen every x frames

 goto Init bank2



