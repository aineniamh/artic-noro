import os
import collections
from Bio import SeqIO

configfile: "config.yaml"
run_name = str(config["run_name"])

##### Target rules #####

rule all:
    input:
        expand("pipeline_output/consensus/{barcode}.cns.fasta",barcode=config["barcodes"])


##### Modules #####
include: "rules/gather.smk"
include: "rules/demultiplex.smk"
include: "rules/mapping.smk"
include: "rules/sorting_calling_generate_cns.smk"
#include: "rules/primer_detection.smk"
