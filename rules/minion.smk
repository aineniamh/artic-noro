rule artic_minion:
    input:
        read_file = "pipeline_output/demultiplexed/{barcode}.fastq",
        nano_read_file = "pipeline_output/"+run_name + "_all.fastq",
        index="pipeline_output/"+run_name+"_all.fastq.index",
        bed="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/noro_quick_cns.scheme.bed",
        fasta="pipeline_output/primer-schemes/noro_quick_cns/V_{barcode}/noro_quick_cns.reference.fasta"
    params:
        primer_scheme = "pipeline_output/primer-schemes",
        primer_version = "noro_quick_cns/V_{barcode}"
    threads:
        8
    output:
        "{barcode}.alignreport.er",
        "{barcode}.alignreport.txt",
        "{barcode}.consensus.fasta",
        "{barcode}.minion.log.txt",
        "{barcode}.primertrimmed.sorted.bam",
        "{barcode}.primertrimmed.sorted.bam.bai",
        "{barcode}.primertrimmed.vcf",
        "{barcode}.sorted.bam",
        "{barcode}.sorted.bam.bai",
        "{barcode}.trimmed.sorted.bam",
        "{barcode}.trimmed.sorted.bam.bai",
        "{barcode}.variants.tab",
        "{barcode}.vcf"
    shell:
        "artic minion --normalise 200 --threads 16 "
        "--scheme-directory {params.primer_scheme} "
        "--read-file {input.read_file} "
        "--nanopolish-read-file {input.nano_read_file} "
        "{params.primer_version} {wildcards.barcode}"


rule organise_minion_output:
    input:
        "{barcode}.alignreport.er",
        "{barcode}.alignreport.txt",
        "{barcode}.consensus.fasta",
        "{barcode}.minion.log.txt",
        "{barcode}.primertrimmed.sorted.bam",
        "{barcode}.primertrimmed.sorted.bam.bai",
        "{barcode}.primertrimmed.vcf",
        "{barcode}.sorted.bam",
        "{barcode}.sorted.bam.bai",
        "{barcode}.trimmed.sorted.bam",
        "{barcode}.trimmed.sorted.bam.bai",
        "{barcode}.variants.tab",
        "{barcode}.vcf"
    params:
        output_dir="pipeline_output/minion_output/{barcode}"
    output:
        "pipeline_output/minion_output/{barcode}/{barcode}.alignreport.er",
        "pipeline_output/minion_output/{barcode}/{barcode}.alignreport.txt",
        "pipeline_output/minion_output/{barcode}/{barcode}.consensus.fasta",
        "pipeline_output/minion_output/{barcode}/{barcode}.minion.log.txt",
        "pipeline_output/minion_output/{barcode}/{barcode}.primertrimmed.sorted.bam",
        "pipeline_output/minion_output/{barcode}/{barcode}.primertrimmed.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}/{barcode}.primertrimmed.vcf",
        "pipeline_output/minion_output/{barcode}/{barcode}.sorted.bam",
        "pipeline_output/minion_output/{barcode}/{barcode}.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}/{barcode}.trimmed.sorted.bam",
        "pipeline_output/minion_output/{barcode}/{barcode}.trimmed.sorted.bam.bai",
        "pipeline_output/minion_output/{barcode}/{barcode}.variants.tab",
        "pipeline_output/minion_output/{barcode}/{barcode}.vcf"
    shell:
        "mv {input} {params.output_dir}"