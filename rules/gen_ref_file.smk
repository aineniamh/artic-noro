rule generate_ref_files:
    input:
        refs="references/gii6_seqgen_references.fasta"
    output:
        expand("references/testing/{ref_name}.fasta", ref_name=config["references"])
    run:
    
        for record in SeqIO.parse(str(input.refs),"fasta"):
            fw = open("references/testing/"+record.id+".fasta","w")
            fw.write(">{}\n{}\n".format("KY424344.1|GII.6", record.seq))
            fw.close()
            print(record.id)


