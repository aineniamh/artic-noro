import argparse
from Bio import SeqIO
from Bio import Seq
import pandas as pd
import matplotlib as mpl
from matplotlib import pyplot as plt
import collections

parser = argparse.ArgumentParser(description='Make amp file from bed file.')
parser.add_argument("--bed", action="store", type=str, dest="bed")
parser.add_argument("--ref", action="store", type=str, dest="ref")
args = parser.parse_args()

file_stem=str(args.ref).rstrip(".reference.fasta")+".amplicons"
amp_file=file_stem + ".csv"
amp_seq_file=file_stem + ".fasta"
amp_img=file_stem + ".png"
fw=open(amp_file,"w")
fw.write("ref,amp_name,start,end,lprimer,rprimer,lseq,rseq,length,pool\n")
c = 0
start, end = (0,0)
ref_dict = {}
ref=''

for record in SeqIO.parse(str(args.ref),"fasta"):
    ref_dict[record.id]=record.seq

with open(str(args.bed),"r") as f:
    ref_c = 0.5
    for l in f:
        c+=1
        l = l.rstrip()
        tokens= l.split()
        if tokens[0]!=ref:
            ref = tokens[0]
            ref_c =0.5
        else:
            ref_c +=0.5
        primer_name = tokens[3]
        coords = (int(tokens[1]), int(tokens[2]))
        pool = tokens[4]
        if primer_name.endswith("LEFT"):
            lseq = ref_dict[ref][coords[0]:coords[1]]
            lprimer = primer_name
            start = coords[0]
        else:
            rseq = Seq.reverse_complement(ref_dict[ref][coords[0]:coords[1]])
            rprimer = primer_name
            end = coords[1]
        if c%2==0:
            amp_name = "Amp{}".format(int(ref_c))
            print(ref, amp_name)
            length=end-start
            fw.write("{},{},{},{},{},{},{},{},{},{}\n".format(ref, amp_name, start, end, lprimer, rprimer, lseq, rseq,length, pool))
fw.close()
refs = sorted(ref_dict)
amps = pd.read_csv(amp_file)
plt.rcParams.update({'font.size': 18})
locations = []
c = 0
for i in refs:
    c +=1
    locations.append(c)
    
fig, ax = plt.subplots(figsize=(26,14))
fig.canvas.draw()
patch = mpl.patches.Rectangle(xy=(0,0), width=7650, height=4.5, facecolor="white", alpha=0.1, edgecolor='none')
labels = [item.get_text() for item in ax.get_yticklabels()]
labels = [i for i in refs]
# locations = [i for i in range(len(refs))]
ax.add_patch(patch)
ax.set_yticklabels(labels)
ax.set_yticks(locations)
ax.set_xlim(0,7660)
ax.set_ylim(0,locations[-1]+1)

c=0
colour_palatte = ["#66023c","#9c6eb2","#c61857","#ffbb33","#1b8aa4","#000066"]

for i in refs:
    c+=1
    colour_index = 0
    ref_specific = amps[amps["ref"]==i]
#     print(ref_specific)
    amp_count=0
    for j in ref_specific.iterrows():
        amp_count += 1
        text_text= "Amp{}".format(amp_count)
        if j[1][-1]==1:
            x = [j[1][2],j[1][3]]
            y = [c+0.1,c+0.1]
            plt.plot(x,y,linewidth=4.0,color=colour_palatte[colour_index])
            text_place = ((j[1][2]+0.1),c+0.2)
            ax.annotate(text_text, xy=text_place)
        elif j[1][-1]==2:
            x = [j[1][2],j[1][3]]
            y = [c-0.1,c-0.1]
            plt.plot(x,y,linewidth=4.0,color=colour_palatte[colour_index])
            text_place = ((j[1][2]+0.1),c-0.4)
            ax.annotate(text_text, xy=text_place)

        colour_index +=1
positions=[1500,2000,3000,3500,4500,5000,6000,6500]
for i in positions:
    plt.axvline(x=i, color='lightgrey', linestyle='--')
# plt.show()
fig.savefig(amp_img)

seq_dict={}
for record in SeqIO.parse(str(args.ref),"fasta"):
    seq_dict[record.id]=record.seq
fw = open(amp_seq_file,"w")
with open(amp_file,"r") as f:
    for l in f:
        l = l.rstrip('\n')
        if not l.startswith("ref"):
            tokens = l.split(',')
            print(tokens[0], tokens[1], tokens[2], tokens[3])
            amp_seq=seq_dict[tokens[0]][int(tokens[2]):int(tokens[3])]
            print("{}...{}".format(amp_seq[:25],amp_seq[-22:]))
            print("{}...{}".format(tokens[6], Seq.reverse_complement(tokens[7])))
            fw.write(">{}|{} left_primer={} right_primer={} pool={} coordinates=({},{})\n{}\n".format(tokens[1], tokens[0], tokens[4], tokens[5], tokens[-1], tokens[2], tokens[3], amp_seq))   
fw.close()