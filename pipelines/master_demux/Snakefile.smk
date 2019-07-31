import os
import collections
from Bio import SeqIO

configfile: "pipelines/master_demux/config.yaml"

##### Subworkflows #####

rule rampart_demux_map:
    input:
        ref= config["referencePanelPath"],
        coord="rampart_config/norovirus/coordinate_reference.fasta"
    params:
        basecalled_path= config["basecalledPath"],
        file_stem = config["file_stem"],
        pipeline_output= config["outputPath"]
    output:
        expand(config["outputPath"]+ "/annotated_reads/{file_stem}.fastq", file_stem=config["file_stem"])
    shell:
        "snakemake --nolock --snakefile pipelines/rampart_demux_map/Snakefile "
        "--config file_stem={params.file_stem} "
        "outputPath={params.pipeline_output} "
        "referencePanelPath={input.ref} "
        "referenceConfigPath={input.coord} "
        "basecalledPath={params.basecalled_path}"
