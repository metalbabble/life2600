
@echo off
cls
echo **************** STARTING ATARI BUILD SCRIPT ***********************

rem ***** SET YOUR PROJECT NAME HERE *****
set projectName=life

rem ***** MAKE SURE ENVIRONMENT VARS ARE PRESENT *****
set bB=C:\Atari2600\bB.1.1d.reveng40
path=%path%;C:\Atari2600\bB.1.1d.reveng40

rem ***** COMBINE SOURCES *****
md bin
del /q bin\*
for %%f in (*.bas) do type %%f >> bin\%projectName%.bas

rem ***** LINT ****
echo Performing Lint
C:\Atari2600\bblint_v0.12\bblint.win32.exe bin\%projectName%.bas 

rem ***** BUILD ****
call 2600bas bin\%projectName%.bas

rem ***** RUN IN EMULATOR *****
C:\Atari2600\Stella-5.0.2\64-bit\Stella.exe bin\%projectName%.bas.bin

echo DONE!