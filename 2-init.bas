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
 gosub SelectSeed bank4

 goto MainLoop bank3

