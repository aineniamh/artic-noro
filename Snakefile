import os
import collections
from Bio import SeqIO

configfile: "config.yaml"
run_name = str(config["run_name"])

#todo - customise output directory from config 

##### Target rules #####

rule all:
    input:
        #expand("pipeline_output/consensus/{barcode}.cns.fasta",barcode=config["barcodes"]),
        #expand('primer-schemes/noro2kb/Vsep/{barcode}.scheme.bed',barcode=config["barcodes"]),
        expand("pipeline_output/minion_output/{barcode}/{barcode}.consensus.fasta",barcode=config["barcodes"])


##### Modules #####
include: "rules/gather.smk"
include: "rules/nanopolish_index.smk"
include: "rules/demultiplex.smk"
include: "rules/mapping.smk"
include: "rules/sorting_calling_generate_cns.smk"
include: "rules/minion.smk"
#include: "rules/primer_detection.smk"

onstart:
    print("Setting up the artic package")
    shell("cd fieldbioinformatics && python setup.py install")
    shell("export PATH=$PATH:`pwd`/artic")
    shell("cd .. ")
