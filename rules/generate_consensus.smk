
rule generate_genome:
    input:
        expand("pipeline_output/minion_output/{{barcode}}_bin/{{barcode}}_{amplicon}.consensus.fasta", amplicon=config["amplicons"])
    output:
        all_amps="pipeline_output/consensus_amplicons/{barcode}.fasta",
        cns="pipeline_output/genome_consensus/{barcode}.genome.fasta"
    shell:
        "cat {input} > {output.all_amps} && "
        "mafft {output.all_amps} > {output.cns}"