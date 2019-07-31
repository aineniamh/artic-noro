import os
import collections
from Bio import SeqIO

configfile: "pipelines/master_consensus/config.yaml"

##### Subworkflows #####
rule all:
    input:
        expand(config["outputPath"] + "/binned/barcode_{barcode}/config.yaml", barcode=config["barcodes"]),
        expand(config["outputPath"] + "/consensus_sequences/{barcode}.fasta",  barcode=config["barcodes"])

rule bin_filter:
    input:
        ref= config["referencePanelPath"]
    params:
        barcode = "{barcode}",
        pipeline_output= config["outputPath"]
    output:
        config["outputPath"] + "/binned/barcode_{barcode}/config.yaml"
    shell:
        "snakemake --nolock --snakefile pipelines/bin_filter/Snakefile "
        # "--configfile {input.config}"
        "--config barcode={params.barcode} outputPath={params.pipeline_output}"

rule polish_consensus:
    input:
        config=config["outputPath"] + "/binned/barcode_{barcode}/config.yaml"
    params:
        barcode = "{barcode}",
        pipeline_output= config["outputPath"]
    output:
        config["outputPath"] + "/consensus_sequences/{barcode}.fasta"
    shell:
        "snakemake --nolock --snakefile pipelines/polish_consensus/Snakefile "
        "--configfile {input.config} "
        "--config outputPath={params.pipeline_output}"



