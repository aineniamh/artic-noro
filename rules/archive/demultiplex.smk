rule demultiplex_qcat:
    input:
        reads= output_dir+"/"+run_name + "_all.fastq"
    params:
        outdir= output_dir + "/demultiplexed"
    output:
        fastq=expand(output_dir+"/demultiplexed/{barcode}.fastq",barcode=config["barcodes"]),
    threads: 16
    shell:
        "qcat -f {input.reads} -b {params.outdir} -t {threads} -q 80"
