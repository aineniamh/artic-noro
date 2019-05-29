import os
from Bio import SeqIO
import collections
import sys
import argparse

parser = argparse.ArgumentParser(description='Gathering and filtering files.')
parser.add_argument("--blast_file", action="store", type=str, dest="blast")
parser.add_argument("--reference_file", action="store", type=str, dest="reference_file")
parser.add_argument("--reads", action="store", type=str, dest="reads")
parser.add_argument("--bed_file", action="store", type=str, dest="bed_file")
parser.add_argument("--output_dir", action="store", type=str, dest="output_dir")
parser.add_argument("--summary", action="store", type=str, dest="summary")
parser.add_argument("--sample", action="store", type=str, dest="sample")

args = parser.parse_args()

blast_file = str(args.blast)
refs=str(args.reference_file)
reads = str(args.reads)
bed_file=str(args.bed_file)

outdir = str(args.output_dir)

summary = str(args.summary)
fsum = open(summary,"w")

barcode=str(args.sample)
print("\nBinning the reads for {} into amplicons.\n".format(barcode))
hits = collections.defaultdict(list)
with open(blast_file, "r") as f:
    for l in f:
        tokens= l.rstrip('\n').split(',')
        read = tokens[0]
        hit = tokens[1]
        score= tokens[-1] 
        hits[read].append((hit,score))

top_amp = {}
for i in hits:
    top_hit = sorted(hits[i], key = lambda x : float(x[1]), reverse = True)[0]
    top_amp[i]=top_hit[0] # will look like AmpX|GenID|GII.X
hits.clear()

records = collections.defaultdict(list)
genotype_counter = collections.defaultdict(dict)
ref_counter = collections.Counter()
read_counter=0
for record in SeqIO.parse(reads,"fastq"):
    read_counter+=1
    try:
        amp,ref_id,genotype= top_amp[record.id].split('|')
        ref_counter[top_amp[record.id]]+=1
    except:
        amp="none"
        genotype="none"
        ref_counter["none"]+=1
    records[amp].append(record)
    if not amp=="none":
        try: 
            genotype_counter[amp][top_amp[record.id]]+=1
        except:
            genotype_counter[amp][top_amp[record.id]]=1
        
seq_dict = {}
for record in SeqIO.parse(refs,"fasta"):
    seq_dict[record.id]=record.seq.upper()

print("Total number of reads for sample {}: {}\n".format(barcode, read_counter))
print("In file: {}\n".format(blast_file))
for amp in sorted(records):
    if amp != "none":
        print("{} has {} reads.\n".format(amp, len(records[amp])))
        out_file = outdir + '/' + amp + '.fastq'
        with open(out_file, "w") as fwseq:
            SeqIO.write(records[amp], fwseq, "fastq")

for amp in sorted(genotype_counter):

    top_genotype_per_amp = sorted(genotype_counter[amp], key = lambda x : genotype_counter[amp][x], reverse=True)[0]
    print(amp, top_genotype_per_amp)
    fwref = open("pipeline_output/binned/"+barcode+"_bin/primer-schemes/minion/V_"+amp+"/minion.reference.fasta","w")
    sequence=seq_dict[top_genotype_per_amp]
    fwref.write(">{}\n{}\n".format(top_genotype_per_amp,sequence))
    fwref.close()

    fwbed = open("pipeline_output/binned/"+barcode+"_bin/primer-schemes/minion/V_"+amp+"/minion.scheme.bed","w")
    with open(bed_file,"r") as f:
        for l in f:
            if not l.startswith("ref"):
                tokens=l.rstrip().split(',')

                record_name = tokens[1] + '|' + tokens[0]
                if record_name == top_genotype_per_amp:
                    fsum.write("{},{},{},{},{}\n".format(barcode,amp,top_genotype_per_amp,tokens[2],tokens[3]))
                    lprimer = len(tokens[-4])
                    rprimer= len(tokens[-3])
                    fwbed.write("{}\t{}\t{}\t{}\t{}\n".format(top_genotype_per_amp,0,lprimer,tokens[4],1))
                    fwbed.write("{}\t{}\t{}\t{}\t{}\n".format(top_genotype_per_amp,len(sequence)-rprimer,len(sequence),tokens[5],1))
    fwbed.close()
    for genotype in sorted(genotype_counter[amp], key = lambda x : genotype_counter[amp][x], reverse=True):
        print("{}\t{}\t{}\n".format(amp, genotype, genotype_counter[amp][genotype]))
fsum.close()

