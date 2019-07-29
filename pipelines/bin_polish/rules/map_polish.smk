rule minimap2_racon0:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref=output_dir+"/binned/{barcode}_bin/primer-schemes/{amplicon}.reference.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon1:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta=output_dir+"/binned/{barcode}_bin/primer-schemes/{amplicon}.reference.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon1.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon1:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon1.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon1.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon2:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta= output_dir + "/polishing/{barcode}/{amplicon}/racon1.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon1.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon2.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon2:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon2.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon2.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon3:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta= output_dir + "/polishing/{barcode}/{amplicon}/racon2.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon2.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon3.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon3:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon3.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon3.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon4:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta= output_dir + "/polishing/{barcode}/{amplicon}/racon3.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon3.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon4.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon4:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon4.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon4.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon5:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta= output_dir + "/polishing/{barcode}/{amplicon}/racon4.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon4.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon5.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon5:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon5.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon5.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon6:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        fasta= output_dir + "/polishing/{barcode}/{amplicon}/racon5.fasta",
        paf= output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon5.paf"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/racon6.fasta"
    shell:
        "racon -t 10 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon6:
    input:
        reads=output_dir+"/binned/{{barcode}}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/polishing/{barcode}/{amplicon}/racon6.fasta"
    output:
        output_dir + "/polishing/{barcode}/{amplicon}/mapped.racon6.sam"
    shell:
        "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"

rule medaka:
    input:
        basecalls=output_dir+"/binned/barcode_{barcode}.fastq",
        draft= output_dir + "/polishing/{barcode}/{amplicon}/racon6.fasta"
    params:
        outdir=output_dir + "/medaka/{barcode}"
    output:
        consensus= output_dir + "/medaka/{barcode}/{amplicon}/consensus.fasta"
    threads:
        2
    shell:
        "medaka_consensus -i {input.basecalls} -d {input.draft} -o {params.outdir} -t 2"


rule minimap2_medaka:
    input:
        reads= output_dir + "/binned/{barcode}_bin/reads/{amplicon}.fastq",
        ref= output_dir + "/binned/{barcode}_bin/{amplicon}/medaka/consensus.fasta"
    output:
        output_dir + "/binned/{barcode}_bin/{amplicon}/medaka/consensus.mapped.sam"
    shell:
        "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"