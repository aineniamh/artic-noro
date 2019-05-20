import argparse
from Bio import SeqIO
from Bio import Seq
parser = argparse.ArgumentParser(description='Make amp file from bed file.')
parser.add_argument("--bed_file", action="store", type=str, dest="bed")
parser.add_argument("--amplicon_file", action="store", type=str, dest="amp")
parser.add_argument("--ref_file", action="store", type=str, dest="ref")
args = parser.parse_args()


ref_dict = {}
for record in SeqIO.parse(str(args.ref),"fasta"):
    ref_dict[record.id]=record.seq

fw=open(str(args.amp),"w")
c=0
with open(str(args.bed),"r") as f:
    for l in f:
        c+=1
        l = l.rstrip()
        tokens= l.split()
        ref = tokens[0]
        primer_name = tokens[3]
        coords = (int(tokens[1]), int(tokens[2]))
        pool = tokens[4]
        if primer_name.endswith("LEFT"):
            lseq = ref_dict[ref][coords[0]:coords[1]]
            lprimer = primer_name
            start = coords[0]
        else:
            rseq = Seq.reverse_complement(ref_dict[ref][coords[0]:coords[1]])
            rprimer = primer_name
            end = coords[1]
        if c%2==0:
            amp_name = "Amp_{}".format(int(c/2))
            fw.write("{},{},{},{},{},{},{},{},{}\n".format(ref, amp_name, start, end, lprimer, rprimer, lseq, rseq, pool))
fw.close()