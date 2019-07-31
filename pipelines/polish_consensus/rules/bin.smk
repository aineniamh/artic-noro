rule write_ref_file:
    input:
        refs = config["referencePanelPath"],
        new_config = outputPath + "/binned/barcode_{barcode}/config.yaml"
    params:
        analysis_stem = config["analysis_stem"],
        outdir = outputPath + "/binned/barcode_{barcode}/references/"
    output:
        expand(outputPath + "/binned/barcode_{{barcode}}/references/{analysis_stem}.fasta", analysis_stem = config["analysis_stem"])
    run:
        refs = {}
        for record in SeqIO.parse(str(input.refs), "fasta"):
            refs[record.id]=record.seq
        for i in params.analysis_stem:
            ref = i.split('_')[1]+'_'+i.split('_')[2]
            print(ref)
            with open(str(params.outdir)+'/' + i + ".fasta","w") as fw:
                fw.write(">{}\n{}\n".format(ref, refs[ref]))

rule bin_by_analysis:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_annotated/barcode_{barcode}.fastq"
    params:
        sample= "{barcode}",
        outdir = outputPath+'/binned/barcode_{barcode}/orf_binned'
        # custom = config["custom_bin"]
    output:
        expand(outputPath+"/binned/barcode_{{barcode}}/orf_binned/barcode_{{barcode}}_{analysis_stem}.fastq", analysis_stem=config["analysis_stem"])
    shell:
        "binlorry -i {input.reads}  "
        "--o {params.outdir}/barcode_{params.sample} "
        "--bin-by orf reference_hit "
        "-n 800 -x 3000"
    
