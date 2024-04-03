n_del=`wc del.col3.merge | perl -lane 'print $F[0]'`
n_dup=`wc dup.col3.merge | perl -lane 'print $F[0]'`
n=$[$n_del+$n_dup];
echo -n -e "$2\t$1\t$n\t" >> ../bench/comb_p_stat

base_del=`wc ../../comb_p_bench/del.merge |perl -lane 'print $F[0]'`
bedtools intersect -wo -a del.col3.merge -b ../../comb_p_bench/del.merge  > del_overlap
perl -lane '$len1=$F[2]-$F[1];$len2=$F[5]-$F[4];print if($F[-1]/$len1>=0.5 || $F[-1]/$len2>=0.5)'  del_overlap > del_overlap_pct50
tp_del=`cut -f 1,2,3 del_overlap_pct50|sort|uniq |wc |perl -lane 'print $F[0]'`
tpb_del=`cut -f 4,5,6 del_overlap_pct50|sort|uniq |wc |perl -lane 'print $F[0]'`
echo "tp_del:$tp_del\ntpb_del:$tpb_del";

base_dup=`wc ../../comb_p_bench/dup.merge |perl -lane 'print $F[0]'`
bedtools intersect -wo -a  dup.col3.merge -b ../../comb_p_bench/dup.merge  > dup_overlap
perl -lane '$len1=$F[2]-$F[1];$len2=$F[5]-$F[4];print if($F[-1]/$len1>=0.5 || $F[-1]/$len2>=0.5)'  dup_overlap > dup_overlap_pct50
tp_dup=`cut -f 1,2,3 dup_overlap_pct50|sort|uniq |wc |perl -lane 'print $F[0]'`
tpb_dup=`cut -f 4,5,6 dup_overlap_pct50|sort|uniq |wc |perl -lane 'print $F[0]'`
echo "tp_dup:$tp_dup\ntpb_dup:$tpb_dup";
tpn=$[$tp_del+$tp_dup];
tpb=$[$tpb_del+$tpb_dup];


pre=`echo -e "scale=3;$tpn/$n"|bc `;
echo -n -e "$pre\t" >> ../bench/comb_p_stat;
base=$[$base_del+$base_dup];
echo "base:$base";
rec=`echo -e "scale=3;$tpb/$base"|bc `;
echo -n -e "$rec\t" >> ../bench/comb_p_stat;
f1=`echo -e "scale=3;2*$pre*$rec/($rec+$pre)"|bc `;
echo "$f1" >> ../bench/comb_p_stat;
