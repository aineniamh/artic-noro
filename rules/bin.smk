rule make_amplicon_files:
    input:
        bed="primer-schemes/noro2kb/V2/noro2kb.scheme.test.bed",
        ref="references/testing/{ref_name}.fasta"
    output:
        out_img="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.png",
        out_csv="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.csv",
        out_seq="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta"
    shell:
        "python scripts/make_amplicon_files.py --ref_out {output.out_seq} --bed {input.bed} --ref {input.ref}"

rule makeblastdb:
    input:
        "primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta"
    output:
        "primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta.nhr"
    shell:
        "makeblastdb -in {input} -dbtype nucl"

rule fastq_to_fasta:
    input:
         output_dir + "/demultiplexed/{barcode}.fastq"
    output:
         output_dir + "/demultiplexed/{barcode}.fasta"
    shell:
        "seqtk seq -A {input} > {output}"

rule blastn:
    input:
        db_hidden="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta.nhr",
        db="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta",
        reads= output_dir + "/demultiplexed/{barcode}.fasta" 
    output:
         output_dir + "/blast_results/{ref_name}/{barcode}.blast.csv"
    shell:
        "blastn -task blastn -db {input.db} "
        "-query {input.reads} -out {output} "
        "-num_threads 1 -outfmt 10"
            
rule bin:
    input:
        blast= output_dir + "/blast_results/{ref_name}/{barcode}.blast.csv",
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        refs="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.fasta",
        amps="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.csv"
    params:
        outdir= output_dir + "/binned/{ref_name}/{barcode}_bin",
        sample="{barcode}"
    output:
        summary= output_dir + "/binned/{ref_name}/{barcode}_bin/binning_report.txt",
        ref=expand(output_dir + "/binned/{{ref_name}}/{{barcode}}_bin/primer-schemes/{amplicon}.reference.fasta", amplicon=config["amplicons"]),
        bed=expand(output_dir + "/binned/{{ref_name}}/{{barcode}}_bin/primer-schemes/{amplicon}.scheme.bed", amplicon=config["amplicons"]),
        reads=expand(output_dir + "/binned/{{ref_name}}/{{barcode}}_bin/reads/{amplicon}.fastq", amplicon=config["amplicons"])
    shell:
        "python scripts/bin.py --blast_file {input.blast} "
        "--reference_file {input.refs} --reads {input.reads} "
        "--output_dir {params.outdir} --summary {output.summary} --amp_file {input.amps} "
        "--sample {params.sample}"
