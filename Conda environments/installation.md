### seqtk
```git clone https://github.com/lh3/seqtk.git; cd seqtk; make```

### pbmm2
```conda install -c bioconda pbmm2```

### minimap2
```curl -L https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2 | tar -jxvf -```

### cuteSV
```conda install -c bioconda cutesv```

### pbsv
```conda install -c bioconda pbsv```

### Sniffles2
```conda install sniffles=2.0```

### Nanovar
```conda create -n myenv -c bioconda python=3.11 samtools bedtools minimap2 -y;conda activate myenv;pip install nanovar```

### NanoSV
```conda install -c bioconda nanosv```

### SVIM
```conda create -n svim_env --channel bioconda svim```

### PBHoney
```source <path to>/setup.sh```

### Delly
```git clone --recursive https://github.com/dellytools/delly.git;cd delly/;make all```
