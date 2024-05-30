#!/bin/bash

for i in $(cat 8_ccs.lst)
do
	cd "$i/CCS/SVIM" || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tSVIM\t$n" >../bench/num_stat
	perl -lane 'chomp;print $_,"\tSVIM"' dup.col3.merge >../bench/SVIM.dup.col4
	perl -lane 'chomp;print $_,"\tSVIM"' del.col3.merge >../bench/SVIM.del.col4
	cd ../pbsv || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl all.dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl all.del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tpbsv\t$n" >>../bench/num_stat
	perl -lane 'chomp;print $_,"\tpbsv"' dup.col3.merge >../bench/pbsv.dup.col4
	perl -lane 'chomp;print $_,"\tpbsv"' del.col3.merge >../bench/pbsv.del.col4
	cd ../NanoVar || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tNanoVar\t$n" >>../bench/num_stat
	perl -lane 'chomp;print $_,"\tNanoVar"' dup.col3.merge >../bench/NanoVar.dup.col4
	perl -lane 'chomp;print $_,"\tNanoVar"' del.col3.merge >../bench/NanoVar.del.col4
	cd ../Sniffles2 || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tSniffles2\t$n" >>../bench/num_stat
	perl -lane 'chomp;print $_,"\tSniffles"' dup.col3.merge >../bench/Sniffles.dup.col4
	perl -lane 'chomp;print $_,"\tSniffles"' del.col3.merge >../bench/Sniffles.del.col4
	cd ../Delly || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tDelly\t$n" >>../bench/num_stat
	perl -lane 'chomp;print $_,"\tDelly"' dup.col3.merge >../bench/Delly.dup.col4
	perl -lane 'chomp;print $_,"\tDelly"' del.col3.merge >../bench/Delly.del.col4
	cd ../cuteSV || exit
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl dup.col3 dup.col3.merge
	perl /xtdisk/liufan_group/yuanna/cnv/NA12878/cnv_bench/merge.pl del.col3 del.col3.merge
	n_del=$(wc del.col3.merge | perl -lane 'print $F[0]')
	n_dup=$(wc dup.col3.merge | perl -lane 'print $F[0]')
	n=$(($((n_del)) + $((n_dup))))
	echo -e "$i\tcuteSV\t$n" >>../bench/num_stat
	perl -lane 'chomp;print $_,"\tcuteSV"' dup.col3.merge >../bench/cuteSV.dup.col4
	perl -lane 'chomp;print $_,"\tcuteSV"' del.col3.merge >../bench/cuteSV.del.col4

	cd ../bench/ || exit
	cat ./*dup.col4 >all.dup
	cat ./*del.col4 >all.del
	perl ../../../NA12878/cnv_bench/map_sort.pl all.dup all.dup.sort
	perl ../../../NA12878/cnv_bench/map_sort.pl all.del all.del.sort
	perl ../../../NA12878/cnv_bench/venn_merge.pl all.dup.sort dup.merge
	perl ../../../NA12878/cnv_bench/venn_merge.pl all.del.sort del.merge

	perl true_num_stat.pl del.merge del.true.num
	perl true_num_stat.pl dup.merge dup.true.num
	base_del=$(cat del.true.num)
	base_dup=$(cat dup.true.num)
	base_n=$(($((base_del)) + $((base_dup))))
	echo -e "SVIM\t$base_n\npbsv\t$base_n\nNanoVar\t$base_n\nSniffles\t$base_n\nDelly\t$base_n\ncuteSV\t$base_n" >base_stat

	perl tools_num_stat.pl del.merge del_stat
	perl tools_num_stat.pl dup.merge dup_stat

	python /pnas/pmod/yuann/bin/addColumns.py base_stat num_stat num_base 2
	python /pnas/pmod/yuann/bin/addColumns.py del_stat num_base num_base_del 2
	python /pnas/pmod/yuann/bin/addColumns.py dup_stat num_base_del num_base_del_dup 2
	cat num_base_del_dup >>../../../ccs_bench.stat

	cd ../../../
done
