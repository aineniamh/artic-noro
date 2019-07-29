import os
from Bio import SeqIO
import collections
import sys
import pandas as pd
import argparse

parser = argparse.ArgumentParser(description='Gathering and filtering files.')
parser.add_argument("--paf", action="store", type=str, dest="paf")
parser.add_argument("--reference", action="store", type=str, dest="reference")
parser.add_argument("--bed", action="store", type=str, dest="bed")
parser.add_argument("--output-dir", action="store", type=str, dest="output_dir")
parser.add_argument("--sample", action="store", type=str, dest="sample")

args = parser.parse_args()

# get this to output the best ref per orf, then check if there's a genotype that matches? 
# check coverage across genome of the best mapping one, sliding window? 
# if lots of reads are mapping to start of one ref or end of another ref etc. 
# get the best one for that location. do we run pipeline in parallel and get an orf1 and orf2/3 sequence? 
# then try to merge the overlap perhaps, after cns generation? 

paf=str(args.paf)
ref=str(args.reference)
bed=str(args.bed)
output_dir=str(args.output_dir)
sample=str(args.sample)
print("\n*\nFinding top reference for {}, based on mapping file {}\n*\n".format(sample, paf))
bed_out = output_dir + '/noro_quick_cns.scheme.bed'
ref_out = output_dir + '/noro.reference.top.fasta'
genotypes=collections.Counter()

c = 0
with open(paf,"r") as f:
    for l in f:
        c+=1
        tokens=l.rstrip('\n').split()
        genotypes[tokens[5]]+=1
top=genotypes.most_common(1)[0][0]
top_count=genotypes.most_common(1)[0][1]
print("\n*\nThe top reference is {} with {} reads mapped ({} pcent of reads).\n*\n".format(top, top_count, round(100*(top_count/c), 2)))

with open(bed_out, "w") as fw:
    with open(bed, "r") as f:
        for l in f:
            tokens=l.rstrip('\n').split()
            if top==tokens[0]:
                fw.write(l.rstrip('\n')+ '\n')

for record in SeqIO.parse(ref,"fasta"):
    if record.id==top:
        with open(ref_out,"w") as fw:
            SeqIO.write(record,fw,"fasta")

print("\n*\nMade bed file and reference file, both found in {}.\n*\n".format(output_dir))

