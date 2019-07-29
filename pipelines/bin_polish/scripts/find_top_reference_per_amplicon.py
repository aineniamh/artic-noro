import os
from Bio import SeqIO
import collections
import sys
import pandas as pd
import argparse

parser = argparse.ArgumentParser(description='Gathering and filtering files.')
parser.add_argument("--paf", action="store", type=str, dest="paf")
parser.add_argument("--reference", action="store", type=str, dest="reference")
parser.add_argument("--bed_file", action="store", type=str, dest="bed")
parser.add_argument("--amplicon_file", action="store", type=str, dest="amp")
parser.add_argument("--output_dir", action="store", type=str, dest="output_dir")
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
amp_file=str(args.amp)
output_dir=str(args.output_dir)
sample=str(args.sample)
print("\n*\nFinding top reference for {}, based on mapping file {}\n*\n".format(sample, paf))
bed_out = output_dir + '/noro.scheme.bed'
ref_out = output_dir + '/noro.reference.fasta'
genotypes=collections.Counter()

#Get what amplicon is where for which ref
amplicons=collections.defaultdict(dict)
with open(amp_file,"r") as f:
    for l in f:
        if l.startswith("ref"):
            pass
        else:
            tokens=l.rstrip('\n').split(',')
            reference = tokens[1]
            amp_name = tokens[0]
            start = int(tokens[3])
            end = int(tokens[4])

            amplicons[reference][(start, end)] = amp_name
            # print(amplicons[reference])

amp_reads=collections.defaultdict(list)
c = 0
c_long=0
with open(paf,"r") as f:
    for l in f:
        c+=1
        tokens=l.rstrip('\n').split()
        
        hit=tokens[5]
        start=int(tokens[7])
        end=int(tokens[8])
    
        span = end-start

        if span > 1000:
            c_long +=1
            read_coords= set(range(start,end))
            genotypes[tokens[5]]+=1
            intersecting_amps = []
            for i in amplicons[hit]:
                amp_range = list(range(i[0],i[1]))
                if len(read_coords.intersection(amp_range)) > 1000:
                    # print("Amplicon: {} range is {}".format(amplicons[hit][i], i))
                    intersecting_amps.append((amplicons[hit][i], len(read_coords.intersection(amp_range))))

            # print("Hit name {}\nLength:{}\tStart:{}\tEnd:{}".format(hit, span, start, end))
            # print("Best hits:{}".format(sorted(intersecting_amps, key = lambda x : int(x[1]), reverse=True)))

            for i in intersecting_amps:
                key="{}|{}".format(hit, i[0])
                amp_reads[key].append(tokens[0])
            
for i in amp_reads:
    print(i, len(amp_reads[i]))

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

