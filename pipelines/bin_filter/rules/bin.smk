rule binlorry:
    input:
    params:
        sample= "{barcode}",
        path_to_demuxed= config["path_to_demuxed"],
        min_length= config["min_length"],
        max_length= config["max_length"],
        outdir = config["output_dir"]+'/binned/barcode_{barcode}'
        # custom = config["custom_bin"]
    output:
        reads= temp(config["output_dir"] + "/binned/barcode_{barcode}/barcode_{barcode}.fastq")
    shell:
        "binlorry -i {params.path_to_demuxed}  "
        "-n {params.min_length} "
        "-x {params.max_length} "
        "--o {params.outdir}/barcode "
        "--bin-by barcode "
        "--filter-by barcode {params.sample}"

rule which_orf:
    input:
        reads= config["output_dir"] + "/binned/barcode_{barcode}/barcode_{barcode}.fastq",
        refs = config["reference_file"]
    params:
        sample = "{barcode}"
    output:
        summary= config["output_dir"] + "/binned/barcode_{barcode}/orf_annotated/barcode_{barcode}.genotype_report.csv",
        reads = config["output_dir"] + "/binned/barcode_{barcode}/orf_annotated/barcode_{barcode}.fastq",
        new_config =  config["output_dir"] + "/binned/barcode_{barcode}/config.yaml"
    shell:
        "python pipelines/bin_filter/scripts/parse_ref_and_depth.py "
        "--reads {input.reads} --orfs "
        "--reads_out {output.reads} "
        "--references {input.refs} "
        "--config_out {output.new_config} "
        "--csv_out {output.summary} "
        "--sample {params.sample}"

        



