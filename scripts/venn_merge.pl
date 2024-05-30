#!usr/bin/perl -w
use strict;
open IN,"$ARGV[0]";
open OUT,">$ARGV[1]";
my @tmp=();
my $line=<IN>;
my ($old_chr,$old_s,$old_e)=(split/\t/,$line)[0,1,2];
my $n=1;
push @tmp,$line;
while($line=<IN>){
	my ($chr,$s,$e)=(split/\t/,$line)[0,1,2];
	if($chr ne $old_chr){
		for my $j(0..$#tmp){
			if($tmp[$j]=~/(.*?)\n/){
				print OUT $1,"\t";
			}
		}
		print OUT "Merge",$n,"\n"; 
		@tmp=();
		push @tmp,$line;
		$n++;
		$old_chr=$chr;
		$old_s=$s;
		$old_e=$e;
	}
	else{
		if($s<=$old_e){
			if($e<=$old_e){
				push @tmp,$line;
				next;
			}else{
				my $ovlp=$old_e-$s+1;
				if($ovlp/($old_e-$old_s)>=0.8 || $ovlp/($e-$s)>=0.8){
					push @tmp,$line;
					$old_e=$e;
				}
				else{
					for my $i(0..$#tmp){
						if($tmp[$i]=~/(.*?)\n/){
							print OUT $1,"\t";
						}
					}
					print OUT "Merge",$n,"\n"; 
					@tmp=();
					push @tmp,$line;
					$n++;
					$old_chr=$chr;
					$old_s=$s;
					$old_e=$e;
				}
			}
		}
		else{
			for my $k(0..$#tmp){
				if($tmp[$k]=~/(.*?)\n/){
					print OUT $1,"\t";
				}
			}
			print OUT "Merge",$n,"\n"; 
			@tmp=();
			push @tmp,$line;
			$n++;
			$old_chr=$chr;
			$old_s=$s;
			$old_e=$e;
		}
	}
}
for my $m(0..$#tmp){
	if($tmp[$m]=~/(.*?)\n/){
		print OUT $1,"\t";
	}
}
print OUT "Merge",$n,"\n"; 
@tmp=();
close IN;
close OUT;
