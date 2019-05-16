rule artic_minion:
    input:
        read_file = "pipeline_output/demultiplexed/{barcode}.fastq",
        nano_read_file = "pipeline_output/"+run_name + "_all.fastq",
        index="pipeline_output/"+run_name+"_all.fastq.index"
    params:
        primer_scheme = lambda wildcards : config["primer_scheme_dir"],
        primer_version = "V_{barcode}"
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

