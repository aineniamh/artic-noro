# rule double_check_length:
#     input:
#         "pipeline_output/binned/{barcode}_bin/reads/{amplicon}.fastq"
#     output:
#         "pipeline_output/binned/{barcode}_bin/filtered/{amplicon}.fastq"
#     run:
#         filtered=[]
#         for record in SeqIO.parse(str(input), "fastq"):
#             if len(record)>1000:
#                 filtered.append(record)
#         SeqIO.write(filtered,str(output),"fastq")

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
        sample = "{barcode}_{amplicon}"
    threads:
        2
    output:
        "{barcode}_{amplicon}.alignreport.er",
        "{barcode}_{amplicon}.alignreport.txt",
        "{barcode}_{amplicon}.consensus.fasta",
        "{barcode}_{amplicon}.minion.log.txt",
        "{barcode}_{amplicon}.primertrimmed.sorted.bam",
        "{barcode}_{amplicon}.primertrimmed.sorted.bam.bai",
        "{barcode}_{amplicon}.primertrimmed.vcf",
        "{barcode}_{amplicon}.sorted.bam",
        "{barcode}_{amplicon}.sorted.bam.bai",
        "{barcode}_{amplicon}.trimmed.sorted.bam",
        "{barcode}_{amplicon}.trimmed.sorted.bam.bai",
        "{barcode}_{amplicon}.variants.tab",
        "{barcode}_{amplicon}.vcf"
    shell:
        "artic minion --normalise 200 --threads 16 "
        "--scheme-directory {params.primer_scheme} "
        "--read-file {input.read_file} "
        "--nanopolish-read-file {input.nano_read_file} "
        "{params.primer_version} {params.sample}"

rule organise_minion_output:
    input:
        "{barcode}_{amplicon}.alignreport.er",
        "{barcode}_{amplicon}.alignreport.txt",
        "{barcode}_{amplicon}.consensus.fasta",
        "{barcode}_{amplicon}.minion.log.txt",
        "{barcode}_{amplicon}.primertrimmed.sorted.bam",
        "{barcode}_{amplicon}.primertrimmed.sorted.bam.bai",
        "{barcode}_{amplicon}.primertrimmed.vcf",
        "{barcode}_{amplicon}.sorted.bam",
        "{barcode}_{amplicon}.sorted.bam.bai",
        "{barcode}_{amplicon}.trimmed.sorted.bam",
        "{barcode}_{amplicon}.trimmed.sorted.bam.bai",
        "{barcode}_{amplicon}.variants.tab",
        "{barcode}_{amplicon}.vcf"
    params:
        output_dir="pipeline_output/minion_output/{barcode}_bin"
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
        "mv {input} {params.output_dir}"
