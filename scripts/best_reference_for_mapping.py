import os
from Bio import SeqIO
import collections
# get this to output the best ref per orf, then check if there's a genotype that matches? 
# check coverage across genome of the best mapping one, sliding window? 
# if lots of reads are mapping to start of one ref or end of another ref etc. 
# get the best one for that location. do we run pipeline in parallel and get an orf1 and orf2/3 sequence? 
# then try to merge the overlap perhaps, after cns generation? 

for r,d,f in os.walk("./mapped_reads/"):
    for paf in f:
        if paf.endswith("paf"):
            fasta=str(paf.rstrip('q'))+'a'
            genotypes=collections.Counter()
            c = 0
            with open(r+'/'+paf,"r") as f:
                for l in f:
                    tokens=l.rstrip('\n').split()
                    genotypes[tokens[5]]+=1
            top=genotypes.most_common(1)[0][0]
            print(top)
            for record in SeqIO.parse('references/initial_record_set.fasta',"fasta"):
                if record.id==top:
                    with open(fasta,"w") as fw:
                        SeqIO.write(record,fw,"fasta")
