
start, end = (0,0)
ref_dict = {}
for record in SeqIO.parse("../primer-schemes/references_for_bed.fasta","fasta"):
    ref_dict[record.id.split('|')[0]]=record.seq

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