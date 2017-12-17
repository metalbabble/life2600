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

