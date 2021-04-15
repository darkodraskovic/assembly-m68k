#!/bin/bash
cd $1
if [ -f "o" ]; then
    rm o
fi
vasmm68k_mot -kick1hunks -Fhunkexe -o o -nosym source.asm


