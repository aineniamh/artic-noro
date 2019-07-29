import os
from Bio import SeqIO
import pandas as pd
import matplotlib as mpl
from matplotlib import pyplot as plt
fig=plt.figure(figsize=(14,10))
for r,d,f in os.walk("pipeline_output/demultiplexed"):
    for fn in f:
        if fn.endswith("fastq"):
            barcode=fn.rstrip(".fastq")
            if barcode!='none':
                if barcode in ["barcode01","barcode02","barcode03","barcode04","barcode05","barcode06","barcode07","barcode08"]:
                    print("Getting read lengths for {}".format(fn))
                    lengths=[]
                    for record in SeqIO.parse(r+'/'+fn,"fastq"):
                        lengths.append(len(record))
                    
                    plt.hist(lengths,bins=200,alpha=0.5)
plt.ylabel("Count")
plt.xlabel("Read length")
plt.title("Read Length Histogram\nNoro 2kb scheme (BC01-08)")
fig.savefig("pipeline_output/info/2kb_read_length_dist.png")
