## About

A version of Conway's game of life for Atari 2600
(https://en.wikipedia.org/wiki/Conway's_Game_of_Life)

Truth be told I wrote this because I was bored on an airplane. I also wanted to demonstrate my source-splitting technique that I used on my larger 2600 games like "Bit Quest" and "Sand Castles"

Written by Brian Shea / metalbabble.com

## Rules of the game

Conway's game of life rules...
Taken from Wikipedia:

* Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
* Any live cell with two or three live neighbours lives on to the next generation.
* Any live cell with more than three live neighbours dies, as if by overpopulation.
* Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

## Building

To make the source more manageable, it is split by bank into seperate files. A build script is included to merge and compile these. For Windows: refer to build.bat - for Mac or Linux: build.sh

BEFORE BUILDING, be sure the paths in the build script are correct for your system. The paths refer to the batari compiler, the bb linter, and the emulator to run the program. 

## Explanation

The main program loop in bank 3 does two things per cycle:

* Scans every position and performs the rule checks
* If rule 1,3,4 are met and a change is required (dead to alive, or alvie to dead) the position is stored on the stack
* After scanning the playfield, the stack is read through and the flips are applied.
* To speed up the display, I have a draw counter that only calls DrawScreen as infrequently as possible. This allows as much calculation to occur between draws as possible.

## Notes

* Uses DPC+ kernel for additional memory and stack
* Recommend bB.1.1d.reveng40 for compilation, Stella for emulation, liniting is optional.