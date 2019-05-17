rule porechop_custom_barcodes:
    input:
        reads="pipeline_output/demultiplexed/{barcode}.fastq",
        custom_barcodes="primer-schemes/noro2kb/V1/noro2kb.scheme.bed"
    output:
        fastq="primer_annotated/{barcode}.fastq",
        report="primer_report.txt"
    threads: 15
    shell:
        "porechop -i {input} --verbosity 2 --discard_middle "
        "--custom_barcodes --barcode_threshold 80 "
        "--threads 15 --check_reads 10000 --barcode_labels --barcode_diff 5 "
        "--extended_labels -o {output.fastq} > {output.report}"


