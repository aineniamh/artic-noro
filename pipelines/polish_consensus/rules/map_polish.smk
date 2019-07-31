rule minimap2_racon0:
    input:
        reads=outputPath + "/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref=outputPath + "/binned/barcode_{barcode}/references/{analysis_stem}.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon1:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        fasta=outputPath + "/binned/barcode_{barcode}/references/{analysis_stem}.fasta",
        paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.paf"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon1.fasta"
    shell:
        "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon1:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon1.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon1.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon2:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        fasta= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon1.fasta",
        paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon1.paf"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon2.fasta"
    shell:
        "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon2:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon2.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon2.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon3:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        fasta= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon2.fasta",
        paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon2.paf"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon3.fasta"
    shell:
        "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"


rule minimap2_racon3:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon3.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon3.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

rule racon4:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        fasta= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon3.fasta",
        paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon3.paf"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon4.fasta"
    shell:
        "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"

rule minimap2_racon4:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon4.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon4.paf"
    shell:
        "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

# rule racon5:
#     input:
#         reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
#         fasta= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon4.fasta",
#         paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon4.paf"
#     output:
#         outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon5.fasta"
#     shell:
#         "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"

# rule minimap2_racon5:
#     input:
#         reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
#         ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon5.fasta"
#     output:
#         outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon5.paf"
#     shell:
#         "minimap2 -x map-ont {input.ref} {input.reads} > {output}"

# rule racon6:
#     input:
#         reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
#         fasta= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon5.fasta",
#         paf= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon5.paf"
#     output:
#         outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon6.fasta"
#     shell:
#         "racon -t 1 {input.reads} {input.paf} {input.fasta} > {output}"

# rule minimap2_racon6:
#     input:
#         reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
#         ref= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon6.fasta"
#     output:
#         outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/mapped.racon6.sam"
#     shell:
#         "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"

rule medaka:
    input:
        basecalls=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        draft= outputPath + "/binned/barcode_{barcode}/polishing/{analysis_stem}/racon4.fasta"
    params:
        outdir=outputPath + "/binned/barcode_{barcode}/medaka/{analysis_stem}"
    output:
        consensus= outputPath + "/binned/barcode_{barcode}/medaka/{analysis_stem}/consensus.fasta"
    threads:
        2
    shell:
        "medaka_consensus -i {input.basecalls} -d {input.draft} -o {params.outdir} -t 2"


rule minimap2_medaka:
    input:
        reads=outputPath+"/binned/barcode_{barcode}/orf_binned/barcode_{barcode}_{analysis_stem}.fastq",
        ref= outputPath + "/binned/barcode_{barcode}/{amplicon}/medaka/consensus.fasta"
    output:
        outputPath + "/binned/barcode_{barcode}/{amplicon}/medaka/consensus.mapped.sam"
    shell:
        "minimap2 -ax map-ont {input.ref} {input.reads} > {output}"

rule gather_sequences:
    input:
        expand(outputPath + "/binned/barcode_{{barcode}}/medaka/{analysis_stem}/consensus.fasta", analysis_stem=config["analysis_stem"])
    output:
        outputPath+"/consensus_sequences/{barcode}.fasta"
    shell:
        "cat {input} > {output}"