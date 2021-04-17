## Vasm

### Build Vasm

```
git clone https://github.com/mbitsnbites/vasm-mirror
cd vasm-mirror
make CPU=m68k SYNTAX=mot
sudo mv vasmm68k_mot /usr/local/bin/
```

### Build exe

```
cd asm/00/
vasmm68k_mot -kick1hunks -Fhunkexe -o example -nosym source.asm
```

-kick1hunks will produce binary that is compatible with kickstart 1.x systems. -hunkexe generates executable object code. -nosym strips local symbols from the binary. More information about vasm and its features can be found in the [documentation](http://sun.hasenbraten.de/vasm/release/vasm.html).

## FS-UAE

Install with `sudo apt-get install fs-uae*` and run

```
fs-uae configuration.fs-ua
```

## Emulation

### Install Classic Workbench

Install Classic Workbench 68K Versions from http://classicwb.abime.net/classicweb/68k.htm while following the setup described in `configuration.fs-uae` file.

### Execute

Once you have the emulator up and running, double click on the Workbench icon on the desktop. Double click the Shell icon. You are now in AmigaDOS. 

```
1.SYS:> cd DH1:build
1.DH1:build> o
```

### FS-UAE Debug

*NB: do this before `1.DH1:build> o` (see above)

Activate FS-UAE console debugger by holding F12 and pressing `d`. You can type `?` <Enter> to list debugger commands. Run `fp "o"` <Enter> to tell the debugger to break execution when process called "example" is being run. Run

```
1.DH1:build> o
```

Once you execute the binary, the breakpoint will trigger and and the control will be returned to debugger. Type `d` <Enter> in the debugger for disassembly. Type `g` <Enter> for "go" so that emulator will kick back alive.

### MonAm Debug

Put `MonAm` directory in `DH1` directory. In Shell, run 

```
1.SYS:> cd DH1:
1.DH1:> MonAm/MonAm build/o
```
