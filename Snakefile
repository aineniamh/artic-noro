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
        expand("pipeline_output/binned/{ref_name}/{barcode}_bin/{amplicon}/medaka/consensus.fasta",amplicon=config["amplicons"],ref_name=config["references"],barcode=config["barcodes"]),
        expand("pipeline_output/consensus_genomes/{ref_name}/{barcode}.fasta",ref_name=config["references"],barcode=config["barcodes"])


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
include: "rules/gen_ref_file.smk"

#onstart:
#    print("Setting up the artic package")
#    shell("cd fieldbioinformatics && python setup.py install")
#    shell("export PATH=$PATH:`pwd`/artic")
#    shell("cd .. ")
