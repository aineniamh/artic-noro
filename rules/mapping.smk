rule minimap2_index:
    input:
        "references/initial_record_set.fasta"
    output:
        "references/initial_record_set.mmi"
    shell:
        "minimap2 -d {output} {input}"

rule minimap2:
    input:
        fastq="trimmed/{barcode}.fastq",
        index="references/initial_record_set.mmi"
    output:
        "mapped_reads/{barcode}.paf"
    threads: 4
    shell:
        "minimap2 -x map-ont --max-qlen 1000 {input.index} {input.fastq} > {output}"

rule find_best_genotype: #Per orf, need to mod
    input:
        paf="mapped_reads/{barcode}.paf",
        ref="references/initial_record_set.fasta"
    output:
        fasta="references/{barcode}.fasta"
    run:
        paf=str(input.paf)
        ref=str(input.ref)
        fasta=str(output.fasta)
        genotypes=collections.Counter()
        c = 0
        with open(paf,"r") as f:
            for l in f:
                tokens=l.rstrip('\n').split()
                genotypes[tokens[5]]+=1
        top=genotypes.most_common(1)[0][0]
        print(top)
        for record in SeqIO.parse(ref,"fasta"):
            if record.id==top:
                with open(fasta,"w") as fw:
                    SeqIO.write(record,fw,"fasta")
                
rule minimap_to_genotype:
    input:
        fastq="trimmed/{barcode}.fastq",
        ref="references/{barcode}.fasta"
    output:
        "best_ref_mapped_reads/{barcode}.sam"
    threads: 4
    shell:
        "minimap2 -ax map-ont --max-qlen 1000 {input.ref} {input.fastq} > {output}"       



