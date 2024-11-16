# Evaluation of long-read SV Callers

Evaluation of the performance of structural variant callers on long reads generated from PacBio SMRT sequencing and Oxford Nanopore Technologies is crucial in genomics research. This evaluation entails conducting tests on publicly available samples with diverse types of datasets, encompassing raw sequencing reads and simulated long read datasets from various platforms.

## 1.Collection of the public samples datasets

 **（1）Long-read datasets from 9 public samples include HG002, NA12878, CHM13 and CHM1 from EUR, HG00514, HX1 and HG005 from EAS, HG00733 from AMR and NA19240 from AFR.**

<table>
<tr>
<th>Sample</th>
<th>Data type</th>
<th>Sequcing reads</th>
</tr>

<tr>
<td rowspan="3">HG002</td>
<td>PacBio CCS</td>
<td>ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_CCS_15kb_20kb_chemistry2/reads/</td>
</tr>
<tr>
<td>PacBio CLR</td>
<td>ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/PacBio_MtSinai_NIST/PacBio_fasta/</td>
</tr>
<tr>
<td>Ultra-long ONT</td>
<td>ftp:://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/UCSC_Ultralong_OxfordNanopore_Promethion/</td>
</tr>

<tr>
<td rowspan="3">NA12878</td>
<td>PacBio CCS</td>
<td>ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/HudsonAlpha_PacBio_CCS/PBmixSequel846_1_A01_PCCL_30hours_15kbV2PD_70pM_HumanHG001_CCS
;PBmixSequel846_2_B01_PCCM_30hours_21kbV2PD_70pM_HumanHG001_CCS</td>
</tr>
<tr>
<td>PacBio CLR</td>
<td>ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NA12878_PacBio_MtSinai/</td>
</tr>
<tr>
<td>Ultra-long ONT</td>
<td>http://s3.amazonaws.com/nanopore-human-wgs/rel7/rel_7.fastq.gz</td>
</tr>

<tr>
<td rowspan="3">CHM13</td>
<td>PacBio CCS</td>
<td>https://www.ncbi.nlm.nih.gov/bioproject/PRJNA530776</td>
</tr>
<tr>
<td>PacBio CLR</td>
<td>SRX818607, SRX825542, and SRX825575-SRX825579</td>
</tr>
<tr>
<td>Ultra-long ONT</td>
<td>https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/nanopore/rel8-guppy-5.0.7/reads.fastq.gz</td>
</tr>

<tr>
<td rowspan="3">HG00514;HG00733;NA19240</td>
<td>PacBio CCS</td>
<td>http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/HGSVC2/working/</td>
</tr>
<tr>
<td>PacBio CLR</td>
<td>ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/smrt.sequence.index</td>
</tr>
<tr>
<td>ONT</td>
<td>ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/hgsv_sv_discovery/working/20181210_ONT_rebasecalled/</td>
</tr>

<tr>
<td >CHM1</td>
<td>PacBio CCS</td>
<td>SRX533609</td>
</tr>

<tr>
<td rowspan="2">HX1</td>
<td>PacBio CLR</td>
<td>SRX1424851</td>
</tr>
<tr>
<td>ONT</td>
<td>SRX5780136-SRX5780155</td>
</tr>

<tr>
<td >HG005</td>
<td>PacBio CCS</td>
<td>https://www.ncbi.nlm.nih.gov/bioproject/PRJNA540706</td>
</tr>

</table>

**（2）Generation datasets of the same sequencing depth with the maximum depth for all samples on different sequencing platform.**

For raw data (bas.h5 type) convert to fasta type and filter with minLength  and  minReadScore parameters:

```sh
for i in ` cat pb/f_lst `;do python ../../software/pbh5tools/bin/bash5tools.py --minLength 1000 --readType subreads   --minReadScore 0.8 --outType fasta  --outFilePrefix ./fasta/"$i"   pb/"$i"*.bas.h5;done
```

For raw data (fastq type) convert to fasta type and filter with --min_length  and  --min_mean_q parameters:

```sh
for i in ` cat pb/fq_lst `;do filtlong --min_length 1000 --min_mean_q 7 SRR/$i.fastq.gz |gzip > filfq/$i.fastq.gz
```

For convert fastq to fasta format:

```sh
for i in `cat 3idsra.ids`;do  zcat  filfq/"$i".fq.gz|  sed -n '1~4s/^@/>/p;2~4p'  >fasta/$i.fasta;done
```

For sampling using seqtk tool:

```sh
seqtk seq -s 11 -f 0.4268981  pb.fa.1k  > 20x.fa
```

**（3）Generation of simulated long-read sequencing datasets.**

For sim-it to simulate long-read datasets:

```sh
perl Sim-it1.3.3.pl -c config_Sim-it.txt -o output/directory/path
```

For pbsim3 to generate a gradient of error rates simulated long-read datasets:

```sh
./pbsim/bin/pbsim  --prefix e2/e2_h1  --strategy wgs --accuracy-mean  0.998 --method errhmm --errhmm ../pbsim3-3.0.0/data/ERRHMM-RSII.model --depth 25 --genome ccs_h1.fasta
./pbsim/bin/pbsim  --prefix e2/e2_h2  --strategy wgs --accuracy-mean  0.998 --method errhmm --errhmm ../pbsim3-3.0.0/data/ERRHMM-RSII.model --depth 25 --genome ccs_h2.fasta
```

## 2. Alignment

All dataset were aligned to the reference genome using minimap2 and pbmm2  methods respectively. samtools was used to sort mapping and sampling to the BAM files

For sample NA12878 20X PacBio CLR dataset align to reference genome:

```sh
pbmm2 align $refdir/human.fa  $inputdir/20x.fa  $outputdir/ NA12878.bam  --sample NA12878 -j 8 -J 8 --sort --rg   '@RG\tID: NA12878'
```

```sh
minimap2  -ax map-pb --MD -Y  -t 20  $ refdir/human.fa   $inputdir/20x.fa  -o  $outputdir/ NA12878.sam
```

Sort mapping:

```sh
samtools view -Sbh NA12878.sam | samtools sort  -o NA12878.bam
```

```sh
samtools index NA12878.bam
```

Down-Sampling:

```sh
samtools view -s 0.1 -b -@10 -o 5x.bam  NA12878.bam
```

```sh
samtools index 5x.bam
```

## 3.Long-read SV detection pipeline

- **pbsv**

```sh
 pbsv discover  $inputdir/pbmm2/pbmm2.bam  ref.svsig.gz
```

```sh
 pbsv call $refdir/human.fa   ref.svsig.gz  call.vcf
```

- **cuteSV**

```sh
 cuteSV   -s  3   -t 10  -l 1000 -S NA12878  $inputdir/minimap2/NA12878.bam  $refdir/human.fa  call.vcf  ./
```

- **PBHoney**

```sh
Honey.py tails -o NA12878.tails -b 2 -z 2   $inputdir/ngmlr/NA12878.bam
```

```sh
Honey.py spots  -e 2 -E 2  --consensus None -o NA12878.spot --reference $refdir/human.fa  $inputdir/ngmlr/NA12878.bam
```

- **NanoSV**

```sh
NanoSV -t 10  -s  /software/sambamba  -b hg19.bed  -c config.ini  -o call.vcf $inputdir/minimap2/NA12878.bam
```

- **NanoVar**

```sh
nanovar  -t 10 -l 50  -x pacbio-ccs   $inputdir/minimap2/NA12878.bam  $refdir/human.fa  ./  --hsb  /software/nanovar/bin/hs-blastn
```

- **Delly**

```sh
delly_v0.9.1_linux_x86_64bit lr -y pb -g $refdir/human.fa $inputdir/minimap2/NA12878.bam
```

- **Sniffles2**

```sh
sniffles -i $inputdir/minimap2/NA12878.bam   -t 10  --minsvlen 1000  -v call.vcf
```

- **SVIM**

```sh
svim alignment   --min_sv_size 50 ./   $inputdir/minimap2/NA12878.bam  $refdir/human.fa
```

## Installation

### Sampling

- **[seqtk](https://github.com/lh3/seqtk.git) (v1.2-r94)**

```sh
git clone https://github.com/lh3/seqtk.git; cd seqtk; make
```

- **[samtools](https://github.com/samtools/samtools) (v1.9)**

```sh
./configure;make;make install
```

### Simulation

- **[Sim-it](https://github.com/ndierckx/Sim-it/) (v1.3.3)**

```sh
cpan Parallel::ForkManager
```

- **[pbsim3](https://github.com/yukiteruono/pbsim3) (v3.0.0)**

```sh
./configure;make;make install
```

### Alignment

- **[minimap2](https://github.com/lh3/minimap2) (v2.20-r1061)**

```sh
curl -L https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2 | tar -jxvf -
```

- **[pbmm2](https://github.com/PacificBiosciences/pbmm2) (v1.7.0)**

```sh
conda install -c bioconda pbmm2
```
  
### SV callers

- **[PBHoney](http://sourceforge.net/projects/pb-jelly/) (2.20-r1061)**

```sh
source <path to>/setup.sh
```

- **[pbsv](https://github.com/PacificBiosciences/pbsv) (v2.4.0)**

```sh
conda install -c bioconda pbsv
```

- **[NanoSV](https://github.com/mroosmalen/nanosv) (v1.2.4)**

```sh
source <path to>/setup.sh
```

- **[NanoVar](https://github.com/cytham/nanovar) (v1.4.1)**

```sh
conda create -n myenv -c bioconda python=3.11 samtools bedtools minimap2 -y;conda activate myenv;pip install nanovar
```

- **[Sniffles2](https://github.com/fritzsedlazeck/Sniffles)  (v2.2)**

```sh
conda install sniffles=2.0
```

- **[SVIM](https://github.com/eldariont/svim)  (v1.4.2)**

```sh
conda create -n svim_env --channel bioconda svim
```

- **[cuteSV](https://github.com/tjiangHIT/cuteSV)  (v1.0.13)**

```sh
conda install -c bioconda cutesv
```

- **[Delly](https://github.com/dellytools/delly)  (v0.8.5)**

```sh
git clone --recursive https://github.com/dellytools/delly.git;cd delly/;make all
```

## Interpreters

- Perl (v5.26.2)
- Python (version - please refer to the YAML files in the Conda environments directory)

Note: scripts/addCoulmns.py used Python 2.7.15.


## Citation

Na Yuan, Peilin Jia, Comprehensive assessment of long-read sequencing platforms and calling algorithms for detection of copy number variation, Briefings in Bioinformatics, Volume 25, Issue 5, September 2024, bbae441, https://doi.org/10.1093/bib/bbae441
