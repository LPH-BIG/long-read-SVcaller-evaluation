#!/usr/bin/env python
import sys,re

print "input:addfile file outfile columnOfGoInFile"

ADD=open(sys.argv[1],'r')
IN=open(sys.argv[2],'r')
OUT=open(sys.argv[3],'w')
c=int(sys.argv[4])-1

columns=[]

cnum=0
pad=[]
idx={}
for line in ADD:
    columns=line.strip().split('\t')
    idx[columns[0]]=columns[1:]
    cnum=len(columns)-1
pad=['---' for i in range(cnum)]

for line in IN:
    OUT.write(line.strip('\n'))
    columns=line.strip().split('\t')
    if len(columns)>c:
        id=columns[c]
    else:
        print len(columns)
        print line

    if idx.has_key(id):
        OUT.write('\t')
        OUT.write("\t".join(idx[id]))
    else:
        OUT.write('\t')
        OUT.write("\t".join(pad))
        
    OUT.write("\n")




