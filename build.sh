#!/bin/bash
SRC_DIR=$1
DST_DIR=~/Programs/Amiga/DH1/build
vasmm68k_mot -kick1hunks -Fhunkexe -o $DST_DIR/o -nosym $SRC_DIR/source.asm


