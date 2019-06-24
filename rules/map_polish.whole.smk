rule minimap2:
    input:
        reads= output_dir+"/demultiplexed/{barcode}.fastq",
        ref= "references/testing/{ref_name}.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon1:
    input:
        reads= output_dir+"/demultiplexed/{barcode}.fastq",
        fasta= "references/testing/{ref_name}.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon1.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon1:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon1.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon1.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon2:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        fasta= output_dir + "/testing/{ref_name}/{barcode}/racon1.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.racon1.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon2.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon2:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon2.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon2.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon3:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        fasta= output_dir + "/testing/{ref_name}/{barcode}/racon2.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.racon2.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon3.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon3:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon3.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon3.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon4:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        fasta= output_dir + "/testing/{ref_name}/{barcode}/racon3.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.racon3.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon4.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon4:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon4.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon4.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon5:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        fasta= output_dir + "/testing/{ref_name}/{barcode}/racon4.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.racon4.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon5.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon5:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon5.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon5.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"


rule racon6:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        fasta= output_dir + "/testing/{ref_name}/{barcode}/racon5.fasta",
        paf= output_dir + "/testing/{ref_name}/{barcode}/mapped.racon5.paf"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/racon6.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon6:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}/racon6.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}/mapped.racon6.sam"
    shell:
        "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"

rule medaka:
    input:
        basecalls= output_dir + "/demultiplexed/{barcode}.fastq",
        draft= output_dir + "/testing/{ref_name}/{barcode}/racon6.fasta"
    params:
        outdir=output_dir + "/testing/{ref_name}/{barcode}_medaka/"
    output:
        consensus= output_dir + "/testing/{ref_name}/{barcode}_medaka/consensus.fasta"
    threads:
        2
    shell:
        "medaka_consensus -i {input.basecalls} -d {input.draft} -o {params.outdir} -t 2"

rule minimap2_medaka:
    input:
        reads= output_dir + "/demultiplexed/{barcode}.fastq",
        ref= output_dir + "/testing/{ref_name}/{barcode}_medaka/consensus.fasta"
    output:
        output_dir + "/testing/{ref_name}/{barcode}_medaka/consensus.mapped.sam"
    shell:
        "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"