import os
from Bio import SeqIO
import collections
import sys
import argparse

parser = argparse.ArgumentParser(description='Gathering and filtering files.')
parser.add_argument("--report", action="store", type=str, dest="report")
parser.add_argument("--amplicon_consensus", action="store", type=str, dest="amplicon_consensus")
parser.add_argument("--out", action="store", type=str, dest="out")
parser.add_argument("--sample", action="store", type=str, dest="sample")

args = parser.parse_args()

ambiguous_dna_values = {
    "AC": "M",
    "AG": "R",
    "AT": "W",
    "CG": "S",
    "CT": "Y",
    "GT": "K",
    "ACG": "V",
    "ACT": "H",
    "AGT": "D",
    "CGT": "B",
    "GATC": "X",
    "GATC": "N"
    }

amp_coords={}
amp_genotype={}
with open(str(args.report), "r") as f:
    for l in f:
        l=l.rstrip('\n')
        tokens=l.split(',')
        barcode,amp,genotype,l,r=tokens
        amp_coords[amp]=(l,r)
        amp_genotype[amp]=genotype
        
amp_dict = {}
for record in SeqIO.parse(str(args.amplicon_consensus),"fasta"):
    barcode,amp=record.id.rstrip(".primertrimmed.sorted.bam").split('_')
    amp_dict[amp]=record.seq
consensus = ''
print("Found the following ambiguities in your sequence at overlap points:\n")

for amp in sorted(amp_dict):
    last_amp="Amp{}".format(int(amp.lstrip("Amp"))-1)
    next_amp="Amp{}".format(int(amp.lstrip("Amp"))+1)
    try:
        next_seq=amp_dict[next_amp]
        
        next_overlap = int(amp_coords[amp][1])-int(amp_coords[next_amp][0])
        if not consensus:
            consensus+=amp_dict[amp][:-next_overlap]
        else:
            prev_overlap = int(amp_coords[last_amp][1])-int(amp_coords[amp][0])
            consensus+=amp_dict[amp][prev_overlap:-next_overlap]
            
        seq1 = amp_dict[amp][-next_overlap:]
        seq2 = amp_dict[next_amp][:next_overlap]
        c=0
        for bases in zip(seq1,seq2):
            c+=1
            if bases[0]!=bases[1]:
                if bases[0] == 'N':
                    consensus+= bases[1]
                elif bases[1]=='N':
                    consensus+= bases[0]
                else:
                    amb="".join(sorted(list(bases)))
                    consensus+=ambiguous_dna_values[amb]
                    print("Position {} of overlap between {} and {}\t\t{} mismatch\t\tInput as {} into consensus at position {}\n".format(c, amp, next_amp, amb, ambiguous_dna_values[amb],len(consensus)))
            else:
                consensus+=bases[0]
    except:
        prev_overlap = int(amp_coords[last_amp][1])-int(amp_coords[amp][0])
        consensus+=amp_dict[amp][prev_overlap:]

print(len(consensus),'\n',consensus)
with open(str(args.out),"w") as f:
    f.write(">{}\n{}\n".format(args.sample, consensus))