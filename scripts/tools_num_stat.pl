#!/usr/bin/perl -w
use strict;
open IN,"$ARGV[0]";
open OUT,">$ARGV[1]";
my %info=();
my $n=0;
my $i;
my ($p,$d,$c,$s1,$s2,$n1);
my ($pb,$de,$cu,$sv,$sn,$na)=(0,0,0,0,0,0);
while(<IN>){
	my @F=split;
	%info=();
	($p,$d,$c,$s1,$s2,$n1)=(0,0,0,0,0,0);
	for($i=3;$i<=$#F-1;$i+=4){$info{$F[$i]}=1 unless(defined $info{$F[$i]})};
	my $len=keys%info;
	if($len>2){
		for($i=3;$i<=$#F-1;$i+=4){
			if($F[$i] eq "pbsv" && $p==0){$pb++;$p=1};
			if($F[$i] eq "Delly" && $d==0){$de++;$d=1};
			if($F[$i] eq "cuteSV" && $c==0 ){$cu++;$c=1};
			if($F[$i] eq "SVIM" && $s1==0 ){$sv++;$s1=1};
			if($F[$i] eq "Sniffles2" && $s2==0 ){$sn++;$s2=1};
			if($F[$i] eq "NanoVar" && $n1==0){$na++;$n1=1};
		}
	}
}
print OUT "SVIM\t$sv\npbsv\t$pb\nNanoVar\t$na\nSniffles2\t$sn\nDelly\t$de\ncuteSV\t$cu\n";


close IN;
close OUT;