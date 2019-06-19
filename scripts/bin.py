import os
from Bio import SeqIO
import collections
import sys
import argparse

parser = argparse.ArgumentParser(description='Gathering and filtering files.')
parser.add_argument("--blast_file", action="store", type=str, dest="blast")
parser.add_argument("--reference_file", action="store", type=str, dest="reference_file")
parser.add_argument("--reads", action="store", type=str, dest="reads")
parser.add_argument("--amp_file", action="store", type=str, dest="amp_file")
parser.add_argument("--output_dir", action="store", type=str, dest="output_dir")
parser.add_argument("--summary", action="store", type=str, dest="summary")
parser.add_argument("--sample", action="store", type=str, dest="sample")

args = parser.parse_args()

blast_file = args.blast
refs=args.reference_file
reads = args.reads
amp_file=args.amp_file
outdir = args.output_dir

amp_len_range = {"Amp1":(1900,2400),"Amp2":(1900,2400),"Amp3":(1950,2500),"Amp4":(1900,2500),"Amp5":(1400,2100),"none":(1400,2600)}


barcode=args.sample
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
    if len(record.seq) in range(amp_len_range[amp][0],amp_len_range[amp][1]):
        records[amp].append(record)
    if not amp=="none":
        try: 
            genotype_counter[amp][top_amp[record.id]]+=1
        except:
            genotype_counter[amp][top_amp[record.id]]=1
        
seq_dict = {}
for record in SeqIO.parse(refs,"fasta"):
    seq_dict[record.id]=record.seq.upper()
summary_dict = collections.defaultdict(list)
print("Total number of reads for sample {}: {}\n".format(barcode, read_counter))
print("In file: {}\n".format(blast_file))
for amp in sorted(records):
    if amp != "none":
        summary_dict[amp].append(("Total",len(records[amp])))
        print("{} has {} reads.\n".format(amp, len(records[amp])))
        out_file = outdir + '/reads/' + amp + '.fastq'
        with open(out_file, "w") as fwseq:
            SeqIO.write(records[amp], fwseq, "fastq")

for amp in sorted(genotype_counter):
    top_genotype_per_amp = sorted(genotype_counter[amp], key = lambda x : genotype_counter[amp][x], reverse=True)[0]
    print(amp, top_genotype_per_amp)
    fwref = open(outdir+ "/primer-schemes/"+amp+".reference.fasta","w")
    sequence=seq_dict[top_genotype_per_amp]
    fwref.write(">{}\n{}\n".format(top_genotype_per_amp,sequence))
    fwref.close()

    fwbed = open(outdir+"/primer-schemes/"+amp+".scheme.bed","w")
    with open(amp_file,"r") as f:
        for l in f:
            if not l.startswith("ref"):
                tokens=l.rstrip().split(',')

                record_name = tokens[1] + '|' + tokens[0]
                if record_name == top_genotype_per_amp:
                    
                    # fsum.write("{},{},{},{},{}\n".format(barcode,amp,top_genotype_per_amp,tokens[2],tokens[3]))
                    lprimer = len(tokens[-4])

                    rprimer= len(tokens[-3])
                    fwbed.write("{}\t{}\t{}\t{}\t{}\n".format(top_genotype_per_amp,0,lprimer,tokens[4],1))
                    fwbed.write("{}\t{}\t{}\t{}\t{}\n".format(top_genotype_per_amp,len(sequence)-rprimer,len(sequence),tokens[5],1))
    fwbed.close()
    for genotype in sorted(genotype_counter[amp], key = lambda x : genotype_counter[amp][x], reverse=True):
        print("{}\t{}\t{}\n".format(amp, genotype, genotype_counter[amp][genotype]))
        summary_dict[amp].append((genotype,genotype_counter[amp][genotype]))

fsum = open(args.summary,"w")
fsum.write("Amplicon,Reference,Count\n")
for i in summary_dict:
    for j in summary_dict[i]:
        fsum.write("{},{},{}\n".format(i, j[0],j[1]))
fsum.close()

