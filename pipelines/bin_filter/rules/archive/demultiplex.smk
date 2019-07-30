rule demultiplex_qcat:
    input:
        reads= output_dir+"/"+run_name + "_all.fastq"
    output:
        fastq=expand(output_dir+"/demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
    threads: 16
    shell:
        "qcat -f {input.reads} -o {output.fastq} --detect-middle --trim -t {threads} -q 80"
