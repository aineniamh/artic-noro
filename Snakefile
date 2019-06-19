import os
import collections
from Bio import SeqIO

configfile: "config.yaml"
run_name = str(config["run_name"])
output_dir = str(config["output_dir"])
#path_to_primer_scheme= str(config["primer_scheme_dir"])+str(config["primer_scheme_version"])
#references=str(config["reference_file"])
##### Target rules #####

rule all:
    input:
        expand(output_dir+"/binned/{barcode}_bin/binning_report.txt",barcode=config["barcodes"]),
        #expand("pipeline_output/consensus_genomes/{barcode}.fasta",barcode=config["barcodes"]),
        #expand("pipeline_output/mapped_reads/{barcode}.paf",barcode=config["barcodes"])
        expand(output_dir + "/binned/{barcode}_bin/{amplicon}/mapped.racon6.sam",amplicon=config["amplicons"],barcode=config["barcodes"])


##### Modules #####
include: "rules/gather.smk"
#include: "rules/nanopolish_index.smk"
include: "rules/demultiplex.smk"
include: "rules/bin.smk"
#include: "rules/mapping.smk"
#include: "rules/sorting_calling_generate_cns.smk"
#include: "rules/minion.smk"
include: "rules/generate_consensus.smk"
include: "rules/map_polish.smk"

onstart:
    print("Setting up the artic package")
    shell("cd fieldbioinformatics && python setup.py install")
    shell("export PATH=$PATH:`pwd`/artic")
    shell("cd .. ")
