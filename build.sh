#!/bin/bash

VASM_EXE=vasmm68k_mot
# -kick1hunks - use only those hunk types and external reference types which have been valid at the time of Kickstart 1.x for compatibility with old assembler sources and old linkers
KICK1=

UAE_EXE=fs-uae
UAE_CONFIGS="uae-configs"
UAE_CONFIG_COMMON=a_1200_common.fs-uae
UAE_CONFIG_BIN=a_1200_bin.fs-uae
UAE_CONFIG_DEB=a_1200_deb.fs-uae
UAE_CONFIG=${UAE_CONFIG_BIN}

EXE_PATH=src/prog
SRC_PATH=

DEBUG=false
NOSYM="-nosym"

# Get the options
while getopts "s:dkw" option; do
    case $option in
        s)
            SRC_PATH=$OPTARG
            ;;
        d)
            DEBUG=true
            ;;
    esac
done

if [ -z "${SRC_PATH}" ]; then
   echo "ERROR: source file not specified"
   exit 1
fi

if [ "$OSTYPE" = "msys" ]; then
    VASM_EXE=C:/Users/darko/Programs/vbcc/bin/vasmm68k_mot.exe
    
    UAE_CONFIG_BIN=a_1200_bin.uae
    UAE_CONFIG_DEB=a_1200_deb.uae
    UAE_CONFIG=${UAE_CONFIG_BIN}
    UAE_EXE=winuae64.exe
fi

if [ ${DEBUG} = true ]; then
    UAE_CONFIG=${UAE_CONFIG_DEB}
    NOSYM=
    KICK1="-kick1hunks"
fi

# -hunkexe generates executable object code
COMPILE_COM="${VASM_EXE} ${KICK1} -Fhunkexe -o ${EXE_PATH} ${NOSYM} ${SRC_PATH}"
printf "\nCOMPILE: $COMPILE_COM\n\n"
$COMPILE_COM

if [ $? -gt 0 ]; then
    exit 1
fi

# replace ../include with assembly-m68k:src/include so AsmPro can understand include path
sed "s/..\/include/\/include\//g" ${SRC_PATH} > ${SRC_PATH}.s

cd "${UAE_CONFIGS}"

RUN_COM=
if [ "$OSTYPE" = "msys" ]; then
    RUN_COM="${UAE_EXE} -f ${UAE_CONFIG} -G"
else
    cat ${UAE_CONFIG_COMMON} ${UAE_CONFIG} > tmp.fs-uae
    RUN_COM="${UAE_EXE} tmp.fs-uae"
fi
printf "\nRUN: $RUN_COM\n"
$RUN_COM
