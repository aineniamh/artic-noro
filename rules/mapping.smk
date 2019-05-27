#These rules correspond to doing a per-sample analysis. If non-recombinant will work and will be much quicker.

rule minimap2_index:
    input:
        "references/noro.references.bed.fasta"
    output:
        "references/noro.references.bed.fasta.mmi"
    shell:
        "minimap2 -d {output} {input}"

rule minimap2:
    input:
        fastq="pipeline_output/demultiplexed/{barcode}.fastq",
        index="references/noro.references.bed.fasta.mmi"
    output:
        "pipeline_output/mapped_reads/{barcode}.paf"
    threads: 4
    shell:
        "minimap2 -x map-ont --secondary=no {input.index} {input.fastq} > {output}"

#Per orf, need to mod, Could also do this with blast- more accurate?
#Do we want to do this per orf or with a sliding window? Best for recombination?
rule find_top_reference: 
    input:
        paf="pipeline_output/mapped_reads/{barcode}.paf",
        ref="references/noro.references.bed.fasta",
        bed='primer-schemes/noro2kb/V1/noro2kb.scheme.bed'
    params:
        output_dir="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}"
    output:
        fasta="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/noro.reference.top.fasta",
        bed='pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/noro_quick_cns.scheme.bed'
    shell:
        "python scripts/find_top_reference.py --paf {input.paf} "
        "--reference {input.ref} --bed {input.bed} "
        "--output-dir {params.output_dir} --sample {wildcards.barcode} "

rule find_top_reference_per_amplicon:
    input:
        paf="pipeline_output/mapped_reads/{barcode}.paf",
        ref="references/noro.references.bed.fasta",
        bed='primer-schemes/noro2kb/noro2kb.scheme.bed',
        amp='primer-schemes/noro2kb/noro_amplicons.2kb.scheme.csv'
    params:
        output_dir="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}"
    output:
        fasta="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/amp.references.fasta",
        bed='pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/amp.schemes.bed'
    shell:
        "python scripts/find_top_reference_per_amplicon.py --paf {input.paf} "
        "--reference {input.ref} --bed_file {input.bed} --amplicon_file {input.amp} "
        "--output_dir {params.output_dir} --sample {wildcards.barcode} "

rule minimap_to_top_reference:
    input:
        fastq="pipeline_output/demultiplexed/{barcode}.fastq",
        ref="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/noro.reference.top.fasta"
    output:
        "pipeline_output/top_ref_mapped_reads/{barcode}.sam"
    threads: 4
    shell:
        "minimap2 -ax map-ont --max-qlen 1000 {input.ref} {input.fastq} > {output}"       



