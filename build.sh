#!/bin/bash
SRC_DIR=$1
DST_DIR=~/Programs/Amiga/DH1/build/sources
# -kick1hunks will produce binary that is compatible with kickstart 1.x systems.
# -hunkexe generates executable object code
# vasmm68k_mot -kick1hunks -Fhunkexe -o $DST_DIR/o -nosym $SRC_DIR/source.asm
vasmm68k_mot -Fhunkexe -o $DST_DIR/o -nosym $SRC_DIR/source.asm
# cp $SRC_DIR/source.asm $DST_DIR/s
sed "s/..\/include/DH1:build\/include\//g" $SRC_DIR/source.asm > $DST_DIR/s
