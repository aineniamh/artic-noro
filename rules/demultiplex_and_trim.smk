rule porechop:
    input:
        "reads/{run_name}.fastq"
    output:
        fastq=expand("demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
        report="demultiplex_report.txt"
    threads: 15
    shell:
        "porechop -i {input} --verbosity 2 --untrimmed --discard_middle "
        "--native_barcodes --barcode_threshold 80 "
        "--threads 15 --check_reads 10000 --barcode_diff 5 --barcode_labels --extended_labels "
        "-b demultiplexed > {output.report}"

rule porechop_trim:
    input:
        reads="demultiplexed/{barcode}.fastq"
    output:
        fastq="trimmed/{barcode}.fastq"
    threads: 15
    shell:
        "porechop -i {input} --verbosity 2 --discard_middle "
        "--native_barcodes --barcode_threshold 80 "
        "--threads 15 --check_reads 10000 --barcode_diff 5 "
        "-o {output.fastq}"
