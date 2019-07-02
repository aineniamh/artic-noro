rule binlorry:
    input:
    params:
        sample= "{barcode}",
        path_to_demuxed= lambda wildcards : {config["path_to_demuxed"]},
        min_length= lambda wildcards : {config["min_length"]},
        max_length= lambda wildcards : {config["max_length"]},
        outdir = output_dir+'/binned'
    output:
        reads= output_dir + "/binned/barcode_{barcode}.fastq"
    shell:
        "binlorry -i {params.path_to_demuxed} -n {params.min_length} "
        "-x {params.max_length} --o {params.outdir}/binned "
        "--bin-by barcode --filter-by barcode {params.sample}"


