
rule gather_amplicons:
    input:
        amplicons=expand("pipeline_output/minion_output/{{barcode}}_bin/{{barcode}}_{amplicon}.consensus.fasta", amplicon=config["amplicons"]),
    output:
        all_amps="pipeline_output/consensus_amplicons/{barcode}.fasta"
    run:
        shell("cat {input} > {output.all_amps}")

rule generate_genome:
    input:
        report="pipeline_output/binned/{barcode}_bin/binning_report.txt",
        amps="pipeline_output/consensus_amplicons/{barcode}.fasta"
    output:
        "pipeline_output/consensus_genomes/{barcode}.fasta"
    shell:
        "python scripts/generate_consensus.py --report {input.report} --amplicon_consensus {input.amps} "
        "--out {output} --sample {wildcards.barcode}"