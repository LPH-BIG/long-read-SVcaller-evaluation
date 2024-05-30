#!/usr/bin/perl -w
use strict;
open IN,"$ARGV[0]";
open OUT,">$ARGV[1]";
my %info=();
my $n=0;
while(<IN>){
	my @F=split;
	%info=();
	for(my $i=3;$i<=$#F-1;$i+=4){$info{$F[$i]}=1 unless(defined $info{$F[$i]})};
	my $len=keys%info;
	if($len>2){$n++};
}
print OUT $n,"\n";

close IN;
close OUT;