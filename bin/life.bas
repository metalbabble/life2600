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
 
 rem x, y are used for loops. z used for bits
 def flipNeeded = z{0}

;---Define constants---
 def MAXX = 30        ; max x
 def MAXY = 20        ; max y
 def FILLVALUE = 50   ; higher value = more seed
 def RES = 32         ; playfield resolution
 def REDRAW_FRAME = 6 ; drawscreen every x frames

 goto Init bank2



;------------------------------
;START BANK 2 - program init
;------------------------------
 bank 2
 temp1=temp1

Init
 drawscreen
 pfclear
 AUDV0 = 0 : AUDV1 = 0

;---Cleanly init vars---
 a = 0 : b = 0 : c = 0 : d = 0 : e = 0 : f = 0 : g = 0 : h = 0 : i = 0
 j = 0 : k = 0 : l = 0 : m = 0 : n = 0 : o = 0 : p = 0 : q = 0 : r = 0
 s = 0 : t = 0 : u = 0 : v = 0 : w = 0 : x = 0 : y = 0 : z = 0
 var0 = 0 : var1 = 0 : var2 = 0 : var3 = 0 : var4 = 0
 var5 = 0 : var6 = 0 : var7 = 0 : var8 = 0

;---Set up Colors---
 scorecolors:
  $1E
  $1C
  $1A
  $1A
  $18
  $18
  $16
  $16
end

 ;--- Create initial generation ---
 gosub SeedRandom bank4

 goto MainLoop bank3

;--------------------------------
;START BANK 3 - main program loop
;--------------------------------
 bank 3
 temp1=temp1

;--- Start main cycle loop ---
MainLoop

 ;--- Reset stack position ---
 stackCounter = 0

 ;--- Scan loop ---
 for y = 1 to MAXY
    for x = 1 to MAXX

        ;--- First, count the neighbors ---
        neighbors = 0

        chkX = x - 1
        if pfread(chkX, y) then neighbors = neighbors + 1
        chkY = y - 1
        if pfread(x, chkY) then neighbors = neighbors + 1
        chkX = x + 1
        if pfread(chkX, y) then neighbors = neighbors + 1
        chkY = y + 1
        if pfread(x, chkY) then neighbors = neighbors + 1

        chkX = x - 1 : chkY = y - 1
        if pfread(chkX, chkY) then neighbors = neighbors + 1  
        chkX = x - 1 : chkY = y + 1
        if pfread(chkX, chkY) then neighbors = neighbors + 1  
        chkX = x + 1 : chkY = y - 1
        if pfread(chkX, chkY) then neighbors = neighbors + 1  
        chkX = x + 1 : chkY = y + 1
        if pfread(chkX, chkY) then neighbors = neighbors + 1           

        ;--- Next, determine what action should happen ---
        flipNeeded = 0 ;does this pixel need to flip?
        if !pfread(x,y) then goto __deadCellChecks

__livingCellChecks
        if neighbors < 2 then flipNeeded = 1
        if neighbors > 3 then flipNeeded = 1
        goto __doneChecking
__deadCellChecks
        if neighbors = 3 then flipNeeded = 1
__doneChecking

        ;-- if not flipping, skip saving it to stack --
        if !flipNeeded goto __doneStackPush

        ;-- save this coordinate on the stack -- 
        push x y
        stackCounter = stackCounter + 1
__doneStackPush

        gosub DrawUpdate
    next ;x
 next ;y

 ; --- perform stack operations ---
 for tmp = stackCounter to 1 step -1
        pull x y
        pfpixel x y flip

        gosub DrawUpdate
 next

;--- Count the generations ---
 score = score + 1
 goto MainLoop

;------------------------------------------------
; DrawUpdate: updates draw counter and then
;             draws screen if applicable. Also
;             sets pf resolution and colors.
;
;             TODO: gosub is expensive!
;             possibly refactor.
;------------------------------------------------
DrawUpdate
 ;--- only drawscreen every so many frames ---
 if drawCounter < REDRAW_FRAME then drawCounter = drawCounter + 1 else drawCounter = 0
 if drawCounter <> 0 then return

 ;---keep resolution set and draw---
 pfcolors:
  $3c
end
 bkcolors:
  $00
end

 DF6FRACINC = 1 : DF4FRACINC = 1
 DF0FRACINC = RES : DF1FRACINC = RES
 DF2FRACINC = RES : DF3FRACINC = RES

 drawscreen
 return

;---------------------------------
; START BANK 4 - extra subroutines
;---------------------------------
 bank 4
 temp1=temp1

;---------------------------------
; randomly creates initial generation
;---------------------------------
SeedRandom
 for y = 1 to MAXY
    for x = 1 to MAXX
        if rand < FILLVALUE then pfpixel x y on
    next ;x
    drawscreen
 next ;y
 return

;---------------------------------
; Draws a sample "glider"
;---------------------------------
SeedGlider
 playfield:
  ................................  
  ................................
  ................................  
  ............X...................
  .............X..................  
  ...........XXX..................
  ................................  
  ................................
  ................................  
  ................................
  ................................  
  ................................
  ................................  
  ................................
  ................................  
  ................................
  ................................  
end
 return

;---------------------------------
; Draws sample "exploders"
;---------------------------------
SeedExploders
 playfield:
  ................................  
  ................................
  ................................  
  ......X.........................
  .....XXX........................  
  .....X.X........................
  ......X.........................  
  ................................
  ................................  
  ................................
  ................................  
  ...................X.X.X........
  ...................X...X........  
  ...................X...X........
  ...................X...X........  
  ...................X.X.X........
  ................................ 
end
 return

;---------------------------------
; Draws a few sample objects
;---------------------------------
SeedMix
 playfield:
  ................................  
  ................................
  ................................  
  ............X...................
  .............X..................  
  ...........XXX..................
  ................................  
  ................................
  ................................  
  ................................
  ................................  
  ................................
  ....................X...........  
  ...................XXX..........
  ...................X.X..........  
  ....................X...........
  ................................ 
end
 return

;---------------------------------
; START BANK 5 AND 6 - not used
;---------------------------------

   bank 5
   temp1=temp1


   bank 6
   temp1=temp1