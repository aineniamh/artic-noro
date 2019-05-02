rule samtools_sort:
    input:
        "best_ref_mapped_reads/{barcode}.sam"
    output:
        "sorted_reads/{barcode}.bam"
    shell:
        "samtools sort -T sorted_reads/{wildcards.barcode} "
        "-O bam {input} > {output}"

rule samtools_index:
    input:
        "sorted_reads/{barcode}.bam"
    output:
        "sorted_reads/{barcode}.bam.bai"
    shell:
        "samtools index {input}"

rule bcftools_call:
    input:
        fasta="contigs/{barcode}.fasta",
        bam="sorted_reads/{barcode}.bam",
        bai="sorted_reads/{barcode}.bam.bai"
    output:
        "calls/{barcode}.bcf.gz"
    shell:
        "bcftools mpileup --max-depth 10000 -Ou -f {input.fasta} {input.bam} | "
        "bcftools call -mv --ploidy 1 -Ob -o {output} "

rule index_calls:
    input:
        "calls/{barcode}.bcf.gz"
    output:
        "calls/{barcode}.bcf.gz.csi"
    shell:
        "bcftools index {input}"

rule normalise_indels:
    input:
        fasta="contigs/{barcode}.fasta",
        csi="calls/{barcode}.bcf.gz.csi",
        bcf="calls/{barcode}.bcf.gz"
    output:
        "indel_normalised/{barcode}.norm.bcf.gz"
    shell:
        "bcftools norm -f {input.fasta} {input.bcf} -Ob -o {output}"

rule index_norm:
    input:
        "indel_normalised/{barcode}.norm.bcf.gz"
    output:
        "indel_normalised/{barcode}.norm.bcf.gz.csi"
    shell:
        "bcftools index {input}"

rule generate_consensus:
    input:
        fasta="contigs/{barcode}.fasta",
        bcf="indel_normalised/{barcode}.norm.bcf.gz",
        csi="indel_normalised/{barcode}.norm.bcf.gz.csi"
    output:
        "temp_consensus/{barcode}.cns.fasta"
    shell:
        "cat {input.fasta} | bcftools consensus {input.bcf} > {output}"

rule rename_consensus:
    input:
        "temp_consensus/{barcode}.cns.fasta"
    output:
        "consensus/{barcode}.cns.fasta"
    run:
        for input_fasta in input:
            with open(str(output),"w") as fw:
                for record in SeqIO.parse(input_fasta,"fasta"):
                    new_id = input_fasta.rstrip(".cns.fasta").lstrip("temp_consensus/") + "|" + record.id
                    fw.write(">{}\n{}\n".format(new_id, record.seq))
