
rule gather_amplicons:
    input:
        amplicons=expand(output_dir + "/binned/{{ref_name}}/{{barcode}}_bin/{amplicon}/medaka/consensus.fasta", amplicon=config["amplicons"]),
    output:
        all_amps=output_dir+"/consensus_amplicons/{ref_name}/{barcode}.fasta"
    run:
        shell("cat {input} > {output.all_amps}")

rule generate_genome:
    input:
        report=output_dir+"/binned/{ref_name}/{barcode}_bin/binning_report.txt",
        amps=output_dir+"/consensus_amplicons/{ref_name}/{barcode}.fasta",
        amp_info="primer-schemes/noro2kb/V2/{ref_name}/noro2kb.amplicons.csv"
    output:
        output_dir + "/consensus_genomes/{ref_name}/{barcode}.fasta"
    shell:
        "python scripts/generate_consensus.py --report {input.report} --amplicon_consensus {input.amps} "
        "--out {output} --sample {wildcards.barcode} --amplicon_info {input.amp_info}"