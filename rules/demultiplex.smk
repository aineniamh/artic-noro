rule demultiplex_qcat:
    input:
        reads="pipeline_output/"+run_name + "_all.fastq"
    output:
        fastq=expand("pipeline_output/demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
        report="pipeline_output/demultiplexed/demultiplex_report.txt"
    threads: 16
    shell:
        "qcat -f {input.reads} -b pipeline_output/demultiplexed -t 4 -q 80 > {output.report}"

# rule demultiplex_porechop:
#     input:
#         reads=expand(run_name + "_all.fastq")
#     output:
#         fastq=expand("demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
#         report="demultiplexed/demultiplex_report.txt"
#     threads: 15
#     shell:
#         "porechop -i {input.reads} --verbosity 2 --untrimmed --discard_middle "
#         "--native_barcodes --barcode_threshold 80 "
#         "--threads 16 --check_reads 10000 --barcode_diff 5 "
#         "-b data/demultiplexed > {output.report}"


# WORK IN PROGRESS
# rule porechop_demultiplex:
#     input:
#         reads=expand("data/{run_name}_all.fastq",run_name=config["run_name"])
#     output:
#         fastq=expand("data/demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
#         report="data/demultiplex_report.txt"
#     threads: 15
#     shell:
#         "porechop -i {input.reads} --verbosity 2 --untrimmed --discard_middle "
#         "--native_barcodes --barcode_threshold 80 "
#         "--threads 16 --check_reads 10000 --barcode_diff 5 "
#         "-b data/demultiplexed > {output.report}"

# rule porechop_trim:
#     input:
#         reads="data/demultiplexed/{barcode}.fastq"
#     output:
#         fastq="data/trimmed/{barcode}.fastq"
#     threads: 15
#     shell:
#         "porechop -i {input.reads} --verbosity 2 --discard_middle "
#         "--native_barcodes --barcode_threshold 80 "
#         "--threads 15 --check_reads 10000 --barcode_diff 5 "
#         "-o {output.fastq}"