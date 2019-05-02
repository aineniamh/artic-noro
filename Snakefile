import os
import collections
from Bio import SeqIO

configfile: "config.yaml"

##### Target rules #####

rule all:
    input:
        #expand("unmapped_reads/{barcode}.fastq",barcode=config["barcodes"]),
        expand("consensus/{barcode}.cns.fasta",barcode=config["barcodes"])


##### Modules #####
include: "rules/demultiplex_and_trim.smk"
include: "rules/mapping.smk"
include: "rules/sorting_calling_generate_cns.smk"
include: "rules/primer_detection.smk"
