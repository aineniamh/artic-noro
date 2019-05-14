# def get_input(wildcards):
#     barcode= lambda wildcards : config["barcodes"]
#     return run_name + "-{barcode}.fastq"

rule minion:
    input:
        read_file = run_name + "_all-{barcode}.fastq",
        nano_read_file = run_name + "_all.fastq",
        fai= run_name+"_all.fastq.index.fai",
        gzi= run_name+"_all.fastq.index.gzi",
        readdb= run_name+"_all.fastq.index.readdb",
        index=run_name+"_all.fastq.index"
    params:
        primer_scheme = lambda wildcards : config["primer_scheme_dir"],
        primer_version = lambda wildcards : config["primer_scheme_version"]
    threads:
        8
    output:
        "{barcode}.primertrimmed.sorted.bam",
        "{barcode}.primertrimmed.vcf",
        "{barcode}.alignreport.txt",
        "{barcode}.consensus.fasta"
    shell:
        "artic minion --normalise 200 --threads 16 "
        "--scheme-directory {params.primer_scheme} "
        "--read-file {input.read_file} "
        "--nanopolish-read-file {input.nano_read_file} "
        "{params.primer_version} {wildcards.barcode}"

