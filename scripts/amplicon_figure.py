fw=open("../primer-schemes/noro_amplicons.2kb.scheme.csv","w")
fw.write("ref,amp_name,start,end,lprimer,rprimer,lseq,rseq,pool\n")
c = 0
start, end = (0,0)
ref_dict = {}
for record in SeqIO.parse("../primer-schemes/references_for_bed.fasta","fasta"):
    ref_dict[record.id.split('|')[0]]=record.seq
print(ref_dict.keys())
with open("../primer-schemes/noro.2kb.scheme.bed","r") as f:
    for l in f:
        c+=1
        l = l.rstrip()
        tokens= l.split()
        ref = tokens[0]
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
            amp_name = "Amp_{}".format(int(c/2))
            fw.write("{},{},{},{},{},{},{},{},{}\n".format(ref, amp_name, start, end, lprimer, rprimer, lseq, rseq, pool))
fw.close()
refs = sorted(ref_dict)
amps = pd.read_csv("../primer-schemes/noro_amplicons.2kb.scheme.csv")
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
    for j in ref_specific.iterrows():
        
        if j[1][-1]==1:
            x = [j[1][2],j[1][3]]
            y = [c+0.1,c+0.1]
            plt.plot(x,y,linewidth=4.0,color=colour_palatte[colour_index])
        elif j[1][-1]==2:
            x = [j[1][2],j[1][3]]
            y = [c-0.1,c-0.1]
            plt.plot(x,y,linewidth=4.0,color=colour_palatte[colour_index])
        colour_index +=1

fig.savefig("../primer-schemes/amplicons.2kb.pdf")