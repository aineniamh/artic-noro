
rule generate_genome:
    input:
        expand("pipeline_output/minion_output/{{barcode}}_bin/{{barcode}}_{amplicon}.consensus.fasta", amplicon=config["amplicons"])
    output:
        "pipeline_output/genome_consensus/{barcode}.genome.fasta"
    run:
        "mafft {input} > {output}"