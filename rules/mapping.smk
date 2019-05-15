rule minimap2_index:
    input:
        "primer-schemes/noro2kb/V1/noro2kb.reference.fasta"
    output:
        "primer-schemes/noro2kb/V1/noro2kb.reference.fasta.mmi"
    shell:
        "minimap2 -d {output} {input}"

rule minimap2:
    input:
        fastq="pipeline_output/demultiplexed/{barcode}.fastq",
        index="primer-schemes/noro2kb/V1/noro2kb.reference.fasta.mmi"
    output:
        "pipeline_output/mapped_reads/{barcode}.paf"
    threads: 4
    shell:
        "minimap2 -x map-ont --max-qlen 1000 --secondary=no {input.index} {input.fastq} > {output}"

#Per orf, need to mod, Could also do this with blast- more accurate?
#Do we want to do this per orf or with a sliding window? Best for recombination?
rule find_top_reference: 
    input:
        paf="pipeline_output/mapped_reads/{barcode}.paf",
        ref="primer-schemes/noro2kb/V1/noro2kb.reference.fasta",
        bed='primer-schemes/noro2kb/V1/noro2kb.scheme.bed'
    output:
        fasta="primer-schemes/noro2kb/V_{barcode}/{barcode}.reference.fasta",
        bed='primer-schemes/noro2kb/V_{barcode}/{barcode}.scheme.bed'
    run:
        paf=str(input.paf)
        ref=str(input.ref)
        bed=str(input.bed)

        fasta=str(output.fasta)
        bed_out=str(output.bed)

        genotypes=collections.Counter()
        c = 0
        with open(paf,"r") as f:
            for l in f:
                c+=1
                tokens=l.rstrip('\n').split()
                genotypes[tokens[5]]+=1
        top=genotypes.most_common(1)[0][0]
        top_count=genotypes.most_common(1)[0][1]
        print("The top reference hitting for file {} is {} with {} reads mapped ({} pcent of reads).".format(paf, top, top_count, 100*(top_count/c)))

        with open(bed_out, "w") as fw:
            print(bed_out)
            with open(bed, "r") as f:
                for l in f:
                    tokens=l.rstrip('\n').split()
                    print(tokens[0], top)
                    if top==tokens[0]:
                        fw.write(l.rstrip('\n')+ '\n')

        for record in SeqIO.parse(ref,"fasta"):
            if record.id==top:
                with open(fasta,"w") as fw:
                    SeqIO.write(record,fw,"fasta")


rule minimap_to_top_reference:
    input:
        fastq="pipeline_output/demultiplexed/{barcode}.fastq",
        ref="primer-schemes/noro2kb/Vsep/{barcode}.fasta"
    output:
        "pipeline_output/best_ref_mapped_reads/{barcode}.sam"
    threads: 4
    shell:
        "minimap2 -ax map-ont --max-qlen 1000 {input.ref} {input.fastq} > {output}"       



