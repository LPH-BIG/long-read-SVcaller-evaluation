#!/bin/bash

for i in $(cat 7_clr.lst);do 
cd "$i"/CLR/SVIM || exit
sh /xtdisk/liufan_group/yuanna/cnv/CHM13/CCS/cuteSV/t.sh SVIM "$i"
cd ../NanoVar || exit
sh /xtdisk/liufan_group/yuanna/cnv/CHM13/CCS/cuteSV/t.sh NanoVar "$i"
cd ../Sniffles || exit
sh /xtdisk/liufan_group/yuanna/cnv/CHM13/CCS/cuteSV/t.sh Sniffles "$i"
cd ../Delly || exit
sh /xtdisk/liufan_group/yuanna/cnv/CHM13/CCS/cuteSV/t.sh Delly "$i"
cd ../cuteSV || exit
sh /xtdisk/liufan_group/yuanna/cnv/CHM13/CCS/cuteSV/t.sh cuteSV "$i"
cd ../../../ || exit
done

