rule make_amplicon_files:
    input:
        bed="primer-schemes/noro2kb/V2/noro2kb.scheme.alt.bed",
        ref="primer-schemes/noro2kb/V2/noro2kb.reference.fasta"
    output:
        out_img="primer-schemes/noro2kb/V2/noro2kb.amplicons.png",
        out_csv="primer-schemes/noro2kb/V2/noro2kb.amplicons.csv",
        out_seq="primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta"
    shell:
        "python scripts/make_amplicon_files.py --bed {input.bed} --ref {input.ref}"

rule makeblastdb:
    input:
        "primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta"
    output:
        "primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta.nhr"
    shell:
        "makeblastdb -in {input} -dbtype nucl"

rule fastq_to_fasta:
    input:
         output_dir + "/binned/barcode_{barcode}.fastq"
    output:
         output_dir + "/binned/barcode_{barcode}.fasta"
    shell:
        "seqtk seq -A {input} > {output}"

rule blastn:
    input:
        db_hidden="primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta.nhr",
        db="primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta",
        reads= output_dir + "/binned/barcode_{barcode}.fasta" 
    output:
         output_dir + "/blast_results/barcode_{barcode}.blast.csv"
    shell:
        "blastn -task blastn -db {input.db} "
        "-query {input.reads} -out {output} "
        "-num_threads 1 -outfmt 10"

rule minimap2_detailed:
    input:
        db="references/initial_record_set.fasta",
        reads= output_dir + "/binned/barcode_{barcode}.fastq" 
    output:
         output_dir + "/minimap_results/barcode_{barcode}.map.paf"
    shell:
        "minimap2 -x map-ont --secondary=no {input.db} {input.reads} > {output}"

rule bin:
    input:
        blast= output_dir + "/blast_results/barcode_{barcode}.blast.csv",
        reads= output_dir + "/binned/barcode_{barcode}.fastq",
        refs="primer-schemes/noro2kb/V2/noro2kb.amplicons.fasta",
        amps="primer-schemes/noro2kb/V2/noro2kb.amplicons.csv",
        paf=output_dir + "/minimap_results/barcode_{barcode}.map.paf"
    params:
        outdir= output_dir + "/binned/{barcode}_bin",
        sample="{barcode}"
    output:
        summary= output_dir + "/binned/{barcode}_bin/binning_report.txt",
        ref=expand(output_dir + "/binned/{{barcode}}_bin/primer-schemes/{amplicon}.reference.fasta", amplicon=config["amplicons"]),
        bed=expand(output_dir + "/binned/{{barcode}}_bin/primer-schemes/{amplicon}.scheme.bed", amplicon=config["amplicons"]),
        reads=expand(output_dir + "/binned/{{barcode}}_bin/reads/{amplicon}.fastq", amplicon=config["amplicons"])
    shell:
        "python scripts/bin.py --blast_file {input.blast} "
        "--reference_file {input.refs} --reads {input.reads} "
        "--output_dir {params.outdir} --summary {output.summary} --paf_file {input.paf} --amp_file {input.amps} "
        "--sample {params.sample}"
