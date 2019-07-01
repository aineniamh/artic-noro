import os
import collections
from Bio import SeqIO

configfile: "config.yaml"
run_name = str(config["run_name"])
output_dir = str(config["output_dir"])

##### Target rules #####

rule all:
    input:
        expand(output_dir+"/binned/{barcode}_bin/binning_report.txt",barcode=config["barcodes"]),
        expand(output_dir + "/binned/{barcode}_bin/{amplicon}/medaka/consensus.mapped.sam",amplicon=config["amplicons"],barcode=config["barcodes"])


##### Modules #####
include: "rules/bin.smk"
include: "rules/bin_amplicons.smk"
include: "rules/generate_consensus.smk"
include: "rules/map_polish.smk"

onstart:
    print("Setting up binlorry")
    shell("cd binlorry && python setup.py install")
    shell("export PATH=$PATH:`pwd`/binlorry")
    shell("cd .. ")
