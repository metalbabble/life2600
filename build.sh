#!/bin/sh

cat *.bas > bin/life.bas

#confirm this path is correct....
export bB="/Applications/bB"
export PATH=$PATH:$bB

#set this to the correct locaiton....
/Applications/bB/2600basic.sh bin/life.bas

echo LAUNCHING $PWD/bin/life.bas.bin
#set this to the stella path
/Applications/Stella.app/Contents/MacOS/Stella $PWD/bin/life.bas.bin