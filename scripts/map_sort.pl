#!/usr/bin/perl -w
use strict;
open IN,"$ARGV[0]";
open OUT,">$ARGV[1]";
my @input1 = map{[$_,(split(/\t/))[0],(split(/\t/))[1]]} <IN>;
my @input2 = sort{$a->[1] cmp $b->[1]||$a->[2] <=> $b->[2]} @input1;
my @sorted = map{$_->[0]} @input2;
for(@sorted)
{
    print OUT $_;
}
close IN;
close OUT;
