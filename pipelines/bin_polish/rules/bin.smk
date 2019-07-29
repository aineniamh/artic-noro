rule binlorry:
    input:
    params:
        sample= "{barcode}",
        path_to_demuxed= config["path_to_demuxed"],
        min_length= config["min_length"],
        max_length= config["max_length"],
        outdir = output_dir+'/binned'
        # custom = config["custom_bin"]
    output:
        reads= output_dir + "/binned/barcode_{barcode}.fastq"
    shell:
        "binlorry -i {params.path_to_demuxed}  "
        "-n {params.min_length} "
        "-x {params.max_length} "
        "--o {params.outdir}/barcode "
        "--bin-by barcode "
        "--filter-by barcode {params.sample}"


#{params.path_to_demuxed}

