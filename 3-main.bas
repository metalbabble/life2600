;--------------------------------
;START BANK 3 - main program loop
;--------------------------------
 bank 3
 temp1=temp1

;--- Start main cycle loop ---
MainLoop

 ;--- Reset stack position ---
 stack 0 : stackCounter = 0

 ;--- Scan loop ---
 for y = 0 to MAXY
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
 for tmp = 1 to stackCounter
        pull x y
        pfpixel x y flip
        
        ;--- Hack to fix harmony crash ---
        ;TODO: this should just be "gosub DrawUpdate" but either the call
        ;      or the switch read is causing a crash on the harmony hardware
        ;      this is redundant, but it works!
        if drawCounter < REDRAW_FRAME then drawCounter = drawCounter + 1 else drawCounter = 0
        if drawCounter <> 0 then goto __endStackLoop
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
__endStackLoop
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
 ;--- check for any reset switch ---
 if !switchreset && resetFlag then resetFlag = 0 ; clears flag when switch released
 if switchreset && !resetFlag then goto ChangeGameAndReset bank4

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

