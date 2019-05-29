rule artic_minion:
    input:
        read_file = "pipeline_output/binned/{barcode}_bin/reads/{amplicon}.fastq",
        nano_read_file = "pipeline_output/"+run_name + "_all.fastq",
        index="pipeline_output/"+run_name+"_all.fastq.index",
        fasta="pipeline_output/binned/{barcode}_bin/primer-schemes/minion/V_{amplicon}/minion.reference.fasta",
        bed="pipeline_output/binned/{barcode}_bin/primer-schemes/minion/V_{amplicon}/minion.scheme.bed"
    params:
        primer_scheme = "pipeline_output/binned/{barcode}_bin/primer-schemes/",
        primer_version = "minion/V_{amplicon}",
        sample = "{barcode}_{amplicon}",
        outdir = "pipeline_output/minion_output/{barcode}_bin"
    threads:
        2
    output:
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.er",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.txt",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.consensus.fasta",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.minion.log.txt",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.vcf",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.variants.tab",
        "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.vcf"
    shell:
        "artic minion --normalise 200 --threads 2 "
        "--scheme-directory {params.primer_scheme} "
        "--read-file {input.read_file} "
        "--nanopolish-read-file {input.nano_read_file} "
        "{params.primer_version} {params.sample} && "
        "mv {params.sample}.* {params.outdir}"

# rule organise_minion_output:
#     input:
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.er",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.txt",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.consensus.fasta",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.minion.log.txt",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.vcf",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.variants.tab",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.vcf"
#     params:
#         output_dir="pipeline_output/minion_output/{barcode}_bin"
#     output:
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.er",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.alignreport.txt",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.consensus.fasta",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.minion.log.txt",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.primertrimmed.vcf",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.trimmed.sorted.bam.bai",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.variants.tab",
#         "pipeline_output/minion_output/{barcode}_bin/{barcode}_{amplicon}.vcf"
#     shell:
#         "mv {input} {params.output_dir}"
