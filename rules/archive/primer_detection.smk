rule porechop_custom_barcodes:
    input:
        reads="pipeline_output/demultiplexed/{barcode}.fastq",
        custom_barcodes="primer-schemes/noro2kb/V1/noro2kb.scheme.bed"
    params:
        output_dir = "pipeline_output/binned"
    output:
        fastq="pipeline_output/binned/{barcode}_bin/reads/",
        report="pipeline_output/binned/{barcode}_bin/primer_report.txt"
    threads: 4
    shell:
        "python ../../Porechop/porechop-runner.py -i {input} --verbosity 2 --require_two_barcodes "
        "--custom_primers --barcode_threshold 60 "
        "--threads 4 --check_reads 10000 --barcode_labels --barcode_diff 5 "
        "--extended_labels --untrimmed -o {output.fastq} > {output.report}"


