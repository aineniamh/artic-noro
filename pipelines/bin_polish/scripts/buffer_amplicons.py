from Bio import SeqIO
fw=open("pipeline_output/consensus_amplicons/buffered_barcode07.fasta","w")
amp_buffer_dict={"Amp1" : (0,2000),"Amp2" : (1500,3500),"Amp3" : (3000,4500),"Amp4" : (4500,6500),"Amp5" : (6000,7500)}
for record in SeqIO.parse("pipeline_output/consensus_amplicons/barcode07.fasta","fasta"):
    amp=record.id.rstrip(".primertrimmed.sorted.bam").split("_")[1]
    buffered_seq = amp_buffer_dict[amp][0]*'N'+record.seq + (7500-amp_buffer_dict[amp][1])*'N'
    fw.write(">{}\n{}\n".format(amp, buffered_seq))