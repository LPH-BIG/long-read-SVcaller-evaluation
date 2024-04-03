#!usr/bin/perl -w
use strict;
open IN,"$ARGV[0]";
open OUT,">$ARGV[1]";
my ($old_s,$old_e);
my $old_chr="";
my (@num_s,@num_e);
while(<IN>){
	my ($chr,$s,$e)=(split)[0,1,2];
	if($chr ne $old_chr){
		print OUT $old_chr,"\t",$old_s,"\t",$old_e,"\n" if($old_chr ne "");
		$old_chr=$chr;
		$old_s=$s;
		$old_e=$e;
	}
	else{
		if($s<=$old_e){
			if($e<=$old_e){
				next;
			}else{
				my $ovlp=$old_e-$s+1;
				if($ovlp/($old_e-$old_s+1)>=0.8 || $ovlp/($e-$s+1)>=0.8){
					$old_e=$e;
				}
				else{
					print OUT $old_chr,"\t",$old_s,"\t",$old_e,"\n";
					$old_chr=$chr;
					$old_s=$s;
					$old_e=$e;
				}
			}
		}
		else{
			print OUT $old_chr,"\t",$old_s,"\t",$old_e,"\n";
			$old_chr=$chr;
			$old_s=$s;
			$old_e=$e;
		}
	}
}
print OUT $old_chr,"\t",$old_s,"\t",$old_e,"\n";
close IN;
close OUT;
