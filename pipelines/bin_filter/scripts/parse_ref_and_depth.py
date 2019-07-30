import argparse
from Bio import SeqIO
import collections

parser = argparse.ArgumentParser(description='Parse mappings, add to headings and create report.')

#Script can accept a csv report with information or a set of annotated reads
# parser.add_argument("--report", action="store", type=str, dest="report")
parser.add_argument("--reads", action="store", type=str, dest="reads")
parser.add_argument("--sample", action="store", type=str, dest="sample")

parser.add_argument("--orfs", action="store_true", dest="orfs")
# parser.add_argument("--bed_file", action="store", type=str, dest="bed_file")
parser.add_argument("--references", action="store", type=str, dest="references")

parser.add_argument("--reads_out", action="store", type=str, dest="reads_out")
parser.add_argument("--config_out", action="store", type=str, dest="config_out")
parser.add_argument("--csv_out", action="store", type=str, dest="csv_out")


args = parser.parse_args()

def make_ref_dict(references):
    refs = {}
    for record in SeqIO.parse(references,"fasta"):
        refs[record.id]=record.seq
    return refs

refs = make_ref_dict(str(args.references))

def make_orf_dict():
    orfs = {
            "orf1":(1,5370),
            "orf2":(5354,7600)
            }
    return orfs

if args.orfs:
    orfs = make_orf_dict()

unknown=False
unmapped_count=0
coord_unmapped = 0
record_count=0

#The following code parses through the input files 
#Currently the barcode information is taken from the header of the 
#demuxed reads (future: porechop to produce a barcode report).
# This script anticipates that and can take the barcode information 
# from a report either.
# But there is an optional argument to produce a csv report 
# rather than writing the annotated reads

def parse_header(header):
    tokens= header.split(' ')
    header_info = {}
    for i in tokens:
        try:
            info = i.split('=')
            header_info[info[0]]=info[1]
        except:
            pass
    return header_info

def which_orf(coords,orfs):
    start,end = [int(i) for i in coords.split(':')]
    if end < orfs["orf2"][0]: # if read mapped before overlap, it's orf1
        return "orf1"
    elif start > orfs["orf1"][1]: # if read mapped after overlap it's orf2/3
        return "orf2"
    else:
        # find out which one has the most overlap and that's the orf
        read_coords = set(range(start,end))
        orf1_range = list(range(orfs["orf1"][0], orfs["orf1"][1]))
        orf2_range  = list(range(orfs["orf2"][0], orfs["orf2"][1]))
        orf1_overlap = len(read_coords.intersection(orf1_range))
        orf2_overlap = len(read_coords.intersection(orf2_range))
        if orf1_overlap > orf2_overlap:
            return "orf1"
        elif orf1_overlap < orf2_overlap:
            return "orf2"
        else:
             return "unknown"

with open(str(args.reads_out),"w") as fw: #file to write reads

    genotypes = {
                "orf1":collections.Counter(),
                "orf2":collections.Counter(),
                "unknown":collections.Counter()
                }
    records = []
    ids = []
    for record in SeqIO.parse(str(args.reads),"fastq"):

        record_count+=1
        header = str(record.description)
        header_info = parse_header(header)
        try:
            genotype = header_info["reference_hit"]
            coords = header_info["coords"]
        except:
            genotype = "none"
            coords = "0:0"
        
        orf = which_orf(coords,orfs)
        header += " orf={}".format(orf)
        record.description = header
        genotypes[orf][genotype]+=1
        if record.id not in ids:
            ids.append(record.id)
            records.append(record)

    with open(str(args.config_out),"w") as freport: #file to write genotype information
        fcsv = open(str(args.csv_out),"w")

        freport.write("reference_file: rampart_config/norovirus/initial_record_set.fasta\n")
        freport.write("barcode: {}\nanalysis_stem:\n".format(str(args.sample)))
        
        for orf in genotypes:
            if orf != "unknown":
                for ref in genotypes[orf]:
                    if genotypes[orf][ref] > 50:
                        freport.write("  - {}_{}\n".format(orf,ref))
                        fcsv.write("{},{},{}\n".format(orf,ref,genotypes[orf][ref]))

        freport.write("references:\n")
        for orf in genotypes:
            if orf != "unknown":
                for ref in genotypes[orf]:
                    if genotypes[orf][ref] > 50:
                        freport.write("  - {}\n".format(ref))

    if args.reads_out:
        SeqIO.write(records, fw, "fastq")
fcsv.close()
