#!/bin/bash

VASM_EXE=vasmm68k_mot
# -kick1hunks will produce binary that is compatible with kickstart 1.x systems.
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
WIN=false

# Get the options
while getopts "s:dkw" option; do
    case $option in
        s)
            SRC_PATH=$OPTARG
            ;;
        d)
            DEBUG=true
            ;;
        k)  KICK1="-kick1hunks"
            ;;
        w)  WIN=true
            ;;
    esac
done

if [ -z "${SRC_PATH}" ]; then
   echo "ERROR: source file not specified"
   exit 1
fi

if [ ${WIN} = true ]; then
    VASM_EXE=C:/Users/darko/Programs/vbcc/bin/vasmm68k_mot.exe
    
    UAE_CONFIG_BIN=a_1200_bin.uae
    UAE_CONFIG_DEB=a_1200_deb.uae
    UAE_CONFIG=${UAE_CONFIG_BIN}
    UAE_EXE=winuae64.exe
fi

if [ ${DEBUG} = true ]; then
    UAE_CONFIG=${UAE_CONFIG_DEB}
fi

# -hunkexe generates executable object code
${VASM_EXE} ${KICK1} -Fhunkexe -o ${EXE_PATH} -nosym ${SRC_PATH}
if [ $? -gt 0 ]; then
    exit 1
fi

# replace ../include with assembly-m68k:src/include so AsmPro can understand include path
sed "s/..\/include/assembly-m68k:src\/include\//g" ${SRC_PATH} > ${SRC_PATH}.s

cd "${UAE_CONFIGS}"

if [ ${WIN} = true ]; then
    ${UAE_EXE} -f ${UAE_CONFIG} -G
else
    cat ${UAE_CONFIG_COMMON} ${UAE_CONFIG} > tmp.fs-uae
    ${UAE_EXE} tmp.fs-uae
fi
