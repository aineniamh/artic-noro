rule makeblastdb:
    input:
        "references/initial_record_set.fasta"
    output:
        "references/initial_record_set.fasta.nhr"
    shell:
        "makeblastdb -in {input} -dbtype nucl"

rule whoami:
    input:
        consensus= output_dir + "/medaka/{barcode}/consensus.fasta",
        db="references/initial_record_set.fasta",
        db_hidden="references/initial_record_set.fasta.nhr"
    output:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.blast.csv"
    shell:
        "blastn -task blastn -db {input.db} "
        "-query {input.consensus} -out {output} "
        "-num_threads 1 -outfmt 10"

rule makeblastdb_detailed:
    input:
        "references/VP1_Database_DetailedPV.fasta"
    output:
        "references/VP1_Database_DetailedPV.fasta.nhr"
    shell:
        "makeblastdb -in {input} -dbtype nucl"

rule whoami_detailed:
    input:
        consensus= output_dir + "/medaka/{barcode}/consensus.fasta",
        db="references/VP1_Database_DetailedPV.fasta",
        db_hidden="references/VP1_Database_DetailedPV.fasta.nhr"
    output:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.detailed.blast.csv"
    shell:
        "blastn -task blastn -db {input.db} "
        "-query {input.consensus} -out {output} "
        "-num_threads 1 -outfmt 10"

rule top_reference:
    input:
        blast=output_dir +"/whoami/{barcode}/barcode_{barcode}.blast.csv",
        consensus= output_dir + "/medaka/{barcode}/consensus.fasta",
        db="references/VP1_Database_wt_and_sabin.fasta",
        blast_detailed=output_dir +"/whoami/{barcode}/barcode_{barcode}.detailed.blast.csv",
        db_detailed="references/VP1_Database_DetailedPV.fasta"
    params:
        barcode="{barcode}"
    output:
        report=output_dir +"/whoami/{barcode}/barcode_{barcode}.report.md",
        seqs=output_dir +"/whoami/{barcode}/barcode_{barcode}.fasta"
    shell:
        "python scripts/generate_report.py "
        "--blast_file {input.blast} --detailed_blast_file {input.blast_detailed} "
        "--blast_db {input.db} --detailed_blast_db {input.db_detailed} "
        "--consensus {input.consensus} "
        "--output_report {output.report} --output_seqs {output.seqs} "
        "--sample {params.barcode}"

rule mafft:
    input:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.fasta"
    output:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.aln.fasta"
    shell:
        "mafft {input} > {output}"

rule iqtree:
    input:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.aln.fasta"
    output:
        output_dir +"/whoami/{barcode}/barcode_{barcode}.aln.fasta.treefile"
    shell:
        "iqtree -s {input} -m HKY+G -nt 1 "
        