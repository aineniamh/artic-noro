---
title: "Norovirus 2kb Nanopore sequencing protocol | amplicon, native barcoding"
keywords: protocol
layout: document
last_updated: July 31, 2019
tags: [protocol]
summary:
permalink: noro2kb/noro2kb-seq-sop.html
folder: noro2kb
title_text: "Norovirus 2kb sequencing protocol"
subtitle_text: "Nanopore | amplicon | native barcoding"
document_name: "ARTIC-noro2kb-seqSOP"
version: v1.0.0
creation_date: 2019-07-31
revision_date: 2019-07-31
forked_from: doi:10.1038/nprot.2017.066
author: Luke Meredith
citation: "Meredith, Quick *et al.* In Prep."
---


**Overview:** The following protocol is adapted from the methods of [Quick et al. (2017) *Nature Protocols* **12:** 1261–1276 doi:10.1038/nprot.2017.066](http://doi.org/10.1038/nprot.2017.066) and covers primers, amplicon preparation and clean-up, then uses a single-tube protocol to barcode and adaptor ligate the library, before running minION.

<br />

This document is part of the Norovirus 2kb Nanopore sequencing protocol package:
: [http://artic.network/noro](http://github.com/aineniamh/artic-noro.git)

#### Related documents:

Norovirus 2kb primer scheme:
https://github.com/aineniamh/artic-noro/blob/master/primer-schemes/noro2kb/V2/noro2kb.amplicons.csv

Norovirus 2kb Nanopore sequencing protocol:
http://artic.network/ebov/ebov-seq-sop.html

Ebola virus Nanopore sequencing kit-list:
[http://artic.network/ebov/ebov-seq-kit.html](http://artic.network/ebov/ebov-seq-kit.html)

-------

## Preparation

#### Equipment required:

| Number | Equipment                                            | Packed? |
| ------ | ---------------------------------------------------- | ------- |
| 2      | Portable nucleic acid preparation hood or equivalent |         |
| 1      | 12V Vortex                                           |         |
| 1      | 12V Centrifuge                                       |         |
| 1      | 1mL pipette                                          |         |
| 1      | 0.1mL pipette                                        |         |
| 1      | 0.01mL pipette                                       |         |
| 1      | 1.5mL/0.6mL convertible tube rack                    |         |
| 1      | Qubit4 Fluorometer (ThermoFisher)                    |         |
| 1      | mini16 PCR machine                                   |         |
| 1      | Heat block                                           |         |
| 1      | Magnetic rack                                        |         |

#### Consumables required:

| Number           | Reagents/Consumable                              | Packed? |
| ---------------- | ------------------------------------------------ | ------- |
| 1                | LunaScript RT 2x MasterMix                       |         |
| 1                | Q5 Hotstart HF polymerase 2x Mastermix           |         |
| 1                | Norovirus 2Kb Primers V2                         |         |
| 1                | NEBNext UltraII End-prep module                  |         |
| 1                | NEBNext UltraII Ligase module                    |         |
| 1                | AlineDX PCR Beads                                |         |
| 1                | Nanopore Ligation Sequencing Kit 1D (SQK-LSK109) |         |
| 1                | Nanopore Native Barcoding Expansion Kit          |         |
| 1 per 24 samples | Nanopore R9.4.1 Flow cells                       |         |
| 1                | 1.5mL eppendorf tubes                            |         |
| 1                | 0.2mL 8-strip tubes                              |         |
| 1                | 50mL transfer tubes                              |         |
| 1                | Qubit reaction tubes                             |         |
| 1                | Qubut 1x dsDNA HS Assay kit                      |         |
| 1                | Nuclease-free water                              |         |
| 1                | 70% Ethanol                                      |         |
| 1                | 1mL pipette tips                                 |         |
| 1                | 0.1mL pipette tips                               |         |
| 1                | 0.01mL pipette tips                              |         |
| 1                | Paper towelling                                  |         |
| 1                | Clinical waste sharps containers                 |         |

#### Safety, containment and contamination recommendations

| Number | Reagents/Consumable           | Packed? |
| ------ | ----------------------------- | ------- |
| 1      | Back-tie hydrophobic lab gown |         |
| 1      | Gloves                        |         |
| 1      | UV light sterilizers          |         |
| 1      | Medipal decontamination wipes |         |
| 1      | DNAway reagent                |         |
| 1      | RNAse Zap reagent             |         |

## Protocol

### Part 1: cDNA synthesis with Superscript IV Vilo cDNA kit

> **NOTE ON HOOD PREPARATION:** To prevent cross contamination of both the sample and other reagents, this should be carried out in the SAMPLE PREPARATION HOOD, which is pre-sterilised with UV and treated with MediPal wipes, DNAway and RNAseZap reagent. Wipe down the hood with each sequentially, allowing 5 minutes for drying between each. Pipettes should also be treated in the same way, and UV treated for 30 mins between library preparations. 

1. Recommend aliquoting the Vilo mastermix, to prevent cross contamination and to reduce potential freeze/thaw cycles.

2. Set up the following reaction:

    | Reagent          | Temperature (°C) |
    | ---------------- | ---------------- |
    | 5x Lunascript MM | 2µL              |
    | Viral RNA        | 5µL              |
    | Water            | 3µL              |
    | TOTAL            | 10µL             |
> **NOTE:** Viral RNA input from a clinical sample should be between Ct 18-35. If Ct is between 12-15, then dilute the sample 100-fold in water, if between 15-18 then dilute 10-fold in water. This will reduce the likelihood of PCR-inhibition. 

3. Gently mix (avoid vortexing) then pulse spin the tube to ensure maximum contact with the thermal cycler.

4. Incubate the reaction as follows:

    | Step             | Temperature (°C) | Time    |
    | ---------------- | ---------------- | ------- |
    | Primer annealing | 25°C             | 10 mins |
    | Extension        | 25°C             | 45 mins |
    | Inactivation     | 25°C             | 5 mins  |
    
5. cDNA is now ready for amplicon generation.

<div class="pagebreak"> </div>
### Part 2: Norovirus Amplicon Preparation

> **NOTE ON HOOD PREPARATION:** To prevent cross contamination of both the sample and other reagents, this should be carried out in the MASTERMIX HOOD, which is pre-sterilised with UV and treated with MediPal wipes, DNAway and RNAseZap reagent. Wipe down the hood with each sequentially, allowing 5 minutes for drying between each. Pipettes should also be treated in the same way, and UV treated for 30 mins between library preparations.

#### Primer dilution and preparation

1. Norovirus 2kb V2 primers for this protocol were designed using [Primal Scheme](http://primal.zibraproject.org) and generate ~2000nt amplicons with 500nt overlaps. Primer names and dilutions are listed in the table below. 

2. Primers should be prepped and aliquoted PRIOR TO DEPARTURE in a STERILE PCR CABINET. At NO stage should primers or PCR reagents be anywhere near the template or amplicons until use. 

3. Resuspend lyophilised primers at a concentration of 100&micro;M each

4. Generate primer pool stocks by adding 20&micro;L of each primer pair to a 1.5mL Eppendorf labelled “Pool 1, 100&micro;M” or “Pool 2, 100&micro;M”. Total volume should be 480&micro;L of Pool 1 and 460&micro;L of Pool 2. This is a 10x stock of each primer pool. 

5. Dilute this primer pool 1:10 in molecular grade water, to generate 10&micro;M primer stocks. Recommend that at least 1mL of each primer pool is taken in 100&micro;L aliquots, to account for any risks of degradation of contamination. 

<div class="pagebreak"> </div>
    |ref                      |amp_name|start|end |lprimer             |rprimer              |lseq                          |rseq                          |length|pool|
    |-------------------------|--------|-----|----|--------------------|---------------------|------------------------------|------------------------------|------|----|
    |LC209450.1&#124;GII.P16_GII.2 |Amp1    |29   |1990|gii2noro_1_LEFT     |gii2noro_5_RIGHT     |TGCTTGCAACAACAACAACGAC        |CATGTGGGGTGTTGCCATTCTT        |1961  |1   |
    |LC209450.1&#124;GII.P16_GII.2 |Amp2    |1540 |3690|gii2noro_5_LEFT     |gii2noro_10_RIGHT    |TCACAGGAGATCAAAGAGTTGGACT     |GTAGGCAGGCTCATATGTCCCT        |2150  |2   |
    |LC209450.1&#124;GII.P16_GII.2 |Amp3    |2900 |5104|gii2noro_9_LEFT     |gii2noro_14_RIGHT    |AGTGACTGGTTCGGAAATCAGAAA      |AGTAGATGGAGCGGCGTCATTC        |2204  |1   |
|LC209450.1&#124;GII.P16_GII.2 |Amp4    |4290 |6568|gii2noro_13_LEFT    |gii2noro_18_RIGHT    |TGGGACTCAACACAACAGAGGG        |TGTCATGAAACCAGCTCTGTGG        |2278  |2   |
|LC209450.1&#124;GII.P16_GII.2 |Amp5    |5697 |7494|gii2noro_17_LEFT    |gii2noro_21_RIGHT    |TGATTTCACATATCTGGTGCCACC      |TAAATTTTCACCTTTTCACTAAACCTGTGA|1797  |1   |
|KC597140.1&#124;GII.3         |Amp1    |0    |2258|gii3noro_1_LEFT     |gii3noro_5_RIGHT     |ACCGCAAAATCTTCAAGTGACAGA      |CCCTTGCCATCAGACTCAAGTG        |2258  |1   |
|KC597140.1&#124;GII.3         |Amp2    |1267 |3473|gii3noro_4_LEFT     |gii3noro_8_RIGHT     |AGGAGAAGGCCAGGAAACTCTC        |CATATGACAGTGTTTCCCCCGC        |2206  |2   |
|KC597140.1&#124;GII.3         |Amp3    |2918 |5028|gii3noro_8_LEFT     |gii3noro_12_RIGHT    |GGCTGATGATGACAGAAGTGTGG       |TTCATTCACAAAGCTGGGAGCC        |2110  |1   |
|KC597140.1&#124;GII.3         |Amp4    |4452 |6756|gii3noro_12_LEFT    |gii3noro_16_RIGHT    |CTTCTCACTCTCTGTGCGCTCT        |AGCATTAGCCCCTGCATTAACT        |2304  |2   |
|KC597140.1&#124;GII.3         |Amp5    |5725 |7192|gii3noro_15_LEFT    |gii3noro_17_RIGHT    |TCTGAAATGTCTAATTCTAGGTTTCCAGT |TAACTGTAGACCCGCTGGATCG        |1467  |1   |
|MG214988.1&#124;GII.4         |Amp1    |0    |2192|gii4noro_1_LEFT     |gii4noro_6_RIGHT     |GTGAATGAAAATGGCGTCTAACGA      |CTCTCATTGTGTCCATCAGCCC        |2192  |1   |
|MG214988.1&#124;GII.4         |Amp2    |1349 |3549|gii4noro_5_LEFT     |gii4noro_10_RIGHT    |CAACCAAATCTGCTTCACCCGA        |CTTCCCTGGGTGGCACATATGA        |2200  |2   |
|MG214988.1&#124;GII.4         |Amp3    |2728 |4887|gii4noro_9_LEFT     |gii4noro_14_RIGHT    |AGAGAAGAAAGGAATGGTAAGTACTCCA  |TGTATGGGTCTCTGGGAGTGTG        |2159  |1   |
|MG214988.1&#124;GII.4         |Amp4    |4392 |6603|gii4noro_14_LEFT    |gii4noro_19_RIGHT    |AGTTGCAGAAGACCTCCTCTCC        |AATCATGTTGGCCAGTGTGAGC        |2211  |2   |
|MG214988.1&#124;GII.4         |Amp5    |5768 |7493|gii4noro_18_LEFT    |gii4noro_22_RIGHT    |GTCCCAGTTTTGACTGTTGAGGA       |GCTTACGAATGTGAGCGAAGAGC       |1725  |1   |
|KY424344.1&#124;GII.6         |Amp1    |3    |1969|gii6noro_1_LEFT     |gii6noro_5_RIGHT     |TTGGCAGCCAAAACTCTGTCAA        |GGGGTGTTGCCATTCTTGTCAA        |1966  |1   |
|KY424344.1&#124;GII.6         |Amp2    |1501 |3718|gii6noro_5_LEFT     |gii6noro_10_RIGHT    |GGCTAAGAGTATCGCCAACACC        |CTCATGACTTGCTGCAGGGATG        |2217  |2   |
|KY424344.1&#124;GII.6         |Amp3    |2864 |5179|gii6noro_9_LEFT     |gii6noro_14_RIGHT    |CTTGGTTTGGTCACTGGCTCAG        |TATTTTGTTGGCCGACGACAGG        |2315  |1   |
|KY424344.1&#124;GII.6         |Amp4    |4341 |6683|gii6noro_13_LEFT    |gii6noro_18_RIGHT    |CACAAGTGGTTGCAGAGGACCT        |TATTGAACTCTTCTGCGCCCCT        |2342  |2   |
|KY424344.1&#124;GII.6         |Amp5    |5774 |7391|gii6noro_17_LEFT    |gii6noro_20_RIGHT    |AGACATGTTGTACACTGACCCCA       |AGTCCAGGAGTCCAAAACAGCT        |1617  |1   |
|KC464497.1&#124;GII.12        |Amp1    |3    |1999|gii12noro_1_LEFT    |gii12noro_5_RIGHT    |AAGATGGCCTCTAACGACGCTT        |GTGGGGTGTTGCCGTTCTTATC        |1996  |1   |
|KC464497.1&#124;GII.12        |Amp2    |1504 |3537|gii12noro_5_LEFT    |gii12noro_9_RIGHT    |GGAAGACCCATCTTGCCAGAGA        |ACAGATGACAGTGTTCCCTCCG        |2033  |2   |
|KC464497.1&#124;GII.12        |Amp3    |2998 |5025|gii12noro_9_LEFT    |gii12noro_13_RIGHT   |GTGTCGATTACAATGAAAAGCTCAGT    |CCATCGAAACATTGGCTCTTGC        |2027  |1   |
|KC464497.1&#124;GII.12        |Amp4    |4564 |6539|gii12noro_13_LEFT   |gii12noro_17_RIGHT   |TCATCCAAGCAAACTCACTCTTCT      |TTGCTTCAAATAGGACACGCCC        |1975  |2   |
|KC464497.1&#124;GII.12        |Amp5    |6011 |7471|gii12noro_17_LEFT   |gii12noro_20_RIGHT   |ACGGAACCCCTTTTGATCCAAC        |AAACTTGTGACTCCCCTCTCCG        |1460  |1   |
|KY947548.1&#124;GII.P16_GII.13|Amp1    |0    |2140|gii13noro_1_LEFT    |gii13noro_6_RIGHT    |TGAATGAAGATGGCGTCTAACGA       |CAGCGATTCTGTTCCGGTCAAA        |2140  |1   |
|KY947548.1&#124;GII.P16_GII.13|Amp2    |1309 |3533|gii13noro_5_LEFT    |gii13noro_10_RIGHT   |TGAAAACACTAGACATGGAGGAGGA     |GCACAGATGACGGTGTTTCCAC        |2224  |2   |
|KY947548.1&#124;GII.P16_GII.13|Amp3    |3006 |5175|gii13noro_10_LEFT   |gii13noro_15_RIGHT   |GAGAAACTGGACTTTGAGGCCC        |ACGGGTTCCAATGGCATAGTCT        |2169  |1   |
|KY947548.1&#124;GII.P16_GII.13|Amp4    |4378 |6490|gii13noro_14_LEFT   |gii13noro_19_RIGHT   |TGGCACAAATAGTCGCTGAGGA        |GGAGGGAGCAGCCTCTTGATAA        |2112  |2   |
|KY947548.1&#124;GII.P16_GII.13|Amp5    |5691 |7376|gii13noro_18_LEFT   |gii13noro_22_RIGHT   |TAGGCCAACCCCTGACTTTGAA        |ACAGGTGTCCAGGAGTCCAAAA        |1685  |1   |
|GU594162.1&#124;GII.14        |Amp1    |1    |1929|gii14noro_1_LEFT    |gii14noro_5_RIGHT    |TGAATGAAGATGGCGTCTAACCG       |TCTTTCCACATGTCAGGTTGGC        |1928  |1   |
|GU594162.1&#124;GII.14        |Amp2    |1421 |3421|gii14noro_5_LEFT    |gii14noro_9_RIGHT    |CTGCTGCCAGATCCCTTCTACA        |GCCAAGATCCATGTTCTTCGCA        |2000  |2   |
|GU594162.1&#124;GII.14        |Amp3    |2908 |5175|gii14noro_9_LEFT    |gii14noro_14_RIGHT   |TTAGTCACCGGCACAGACATCA        |CGACGGGTTCAAGAGCCATAAC        |2267  |1   |
|GU594162.1&#124;GII.14        |Amp4    |4350 |6585|gii14noro_13_LEFT   |gii14noro_18_RIGHT   |GGTGCGATTTTCTGCTGAACCA        |TAGGGTGATCTCCAGATGCTGC        |2235  |2   |
|GU594162.1&#124;GII.14        |Amp5    |5747 |7482|gii14noro_17_LEFT   |gii14noro_21_RIGHT   |ACTAAGAATTTCACCCTTCCCGTT      |TAAATCTGTGACTCCCCTCGCC        |1735  |1   |
|KP998539.1&#124;GII.17        |Amp1    |1    |2134|gii17noro_1_LEFT    |gii17noro_6_RIGHT    |TGAATGAAGATGGCGTCTAACGA       |GCGGTCAAAATTGAAGGTTGGC        |2133  |1   |
|KP998539.1&#124;GII.17        |Amp2    |1302 |3494|gii17noro_5_LEFT    |gii17noro_10_RIGHT   |CCTGGCCACATACATGAGGACT        |CCACAAGGTCATTGCCCCTTTT        |2192  |2   |
|KP998539.1&#124;GII.17        |Amp3    |3002 |5133|gii17noro_10_LEFT   |gii17noro_15_RIGHT   |GGAGCGTGGATTACAATGAGAGG       |CATCATTAGATGGAGCGGCGTC        |2131  |1   |
|KP998539.1&#124;GII.17        |Amp4    |4296 |6498|gii17noro_14_LEFT   |gii17noro_19_RIGHT   |TGATGCTGATTACTCCCGCTGG        |GGGAGGGTGCTGATTCCTGATA        |2202  |2   |
|KP998539.1&#124;GII.17        |Amp5    |6029 |7454|gii17noro_19_LEFT   |gii17noro_22_RIGHT   |GACCCAACTGATGATGTGCCAG        |GCGGCTGTCTGTGTGTGTTAAA        |1425  |1   |
|KX079488.1&#124;GII.21        |Amp1    |0    |1977|gii21noro_1_LEFT    |gii21noro_5_RIGHT    |GTGAATGAAGATGGCGTCTAACGA      |TCAAAACCTCCTTGTGGGGCTA        |1977  |1   |
|KX079488.1&#124;GII.21        |Amp2    |1462 |3704|gii21noro_5_LEFT    |gii21noro_10_RIGHT   |CGACCGGTCGTTGTGATGATTT        |AAGCTGGTTCATAGGTTCCGGG        |2242  |2   |
|KX079488.1&#124;GII.21        |Amp3    |2869 |5124|gii21noro_9_LEFT    |gii21noro_14_RIGHT   |AGACCAACAAGAAAGCAACGCA        |CATCATTAGATGGAGCGGCGTC        |2255  |1   |
|KX079488.1&#124;GII.21        |Amp4    |4268 |6564|gii21noro_13_LEFT   |gii21noro_18_RIGHT   |CCAGATACAGATACCATTATGATGCAGA  |GCCTATGCAGTTTGGCCTCAAA        |2296  |2   |
|KX079488.1&#124;GII.21        |Amp5    |5693 |7473|gii21noro_17_LEFT   |gii21noro_21_RIGHT   |ACCAGACCTACTCCGGACTTTG        |TCTTTTCACTAGGCTTGTGACTCC      |1780  |1   |
|KJ196292.1&#124;GI            |Amp1    |15   |2220|ginoro_31-40_1_LEFT |ginoro_31-40_7_RIGHT |GTCTAACGACGCTATTGCCGTT        |TTTCCAAATGGTGTGTTGCCCT        |2205  |1   |
|KJ196292.1&#124;GI            |Amp2    |1497 |3429|ginoro_31-40_6_LEFT |ginoro_31-40_11_RIGHT|AGATAAGAAATTGGCCAGAACTTACATG  |GGTGGTATGACATGGGTTGTGG        |1932  |2   |
|KJ196292.1&#124;GI            |Amp3    |2751 |5085|ginoro_31-40_10_LEFT|ginoro_31-40_17_RIGHT|CAAGCACAAAGAGCACAACTGC        |CCCTGGTATCCAATGGCATCCT        |2334  |1   |
|KJ196292.1&#124;GI            |Amp4    |4396 |6575|ginoro_31-40_16_LEFT|ginoro_31-40_22_RIGHT|GTGTACACAAAAATCAAAAAGAGACTGCT |TTTGTGTCCATCACTGACGGGT        |2179  |2   |
|KJ196292.1&#124;GI            |Amp5    |5905 |7668|ginoro_31-40_21_LEFT|ginoro_31-40_26_RIGHT|TGACAACACACCAACCATGAGG        |TTACCCCTGTTCGCGAATAAGG        |1763  |1   |
|KP407451.1&#124;GI            |Amp1    |16   |2118|ginoro_1-10_1_LEFT  |ginoro_1-10_7_RIGHT  |TCGAAAGACGTCGTTGCGACTA        |CAATCTTTCAGTGCCGACGTGT        |2102  |1   |
|KP407451.1&#124;GI            |Amp2    |1379 |3468|ginoro_1-10_6_LEFT  |ginoro_1-10_12_RIGHT |TCTTTGGTGGGGATCAGACTGA        |GTGAATTCTCCGGCCCTATGGA        |2089  |2   |
|KP407451.1&#124;GI            |Amp3    |2821 |4922|ginoro_1-10_11_LEFT |ginoro_1-10_17_RIGHT |GGACTATGTGAGACTGAGGAGGA       |CCTGTGTCAATTTTGCTGGGTC        |2101  |1   |
|KP407451.1&#124;GI            |Amp4    |4238 |6390|ginoro_1-10_16_LEFT |ginoro_1-10_22_RIGHT |GCACCGCCTTCATTAGAGAGTT        |ATGGGTCCCGATCTTGAGTCTG        |2152  |2   |
|KP407451.1&#124;GI            |Amp5    |5698 |7656|ginoro_1-10_21_LEFT |ginoro_1-10_27_RIGHT |CAACGCCTTCACAGCTGGAAAG        |ATTAAAACCAAATCTGAATATGGTGCCCA |1958  |1   |
|KF429774.1&#124;GI            |Amp1    |16   |2132|ginoro_11-20_1_LEFT |ginoro_11-20_7_RIGHT |AAAGACGTCGTTCCTACTGCTG        |GTGAGAAATCGGGCTTGAAGCA        |2116  |1   |
|KF429774.1&#124;GI            |Amp2    |1450 |3584|ginoro_11-20_6_LEFT |ginoro_11-20_12_RIGHT|ACATCAGTGACTCAGCTCGTGA        |GTAGTTCACCCGAATCCCGTTT        |2134  |2   |
|KF429774.1&#124;GI            |Amp3    |2860 |4974|ginoro_11-20_11_LEFT|ginoro_11-20_17_RIGHT|ATGGTACCAAGTGATGCCGTCC        |GGTCCTTCTGTTTTGTCAGGCC        |2114  |1   |
|KF429774.1&#124;GI            |Amp4    |4289 |6424|ginoro_11-20_16_LEFT|ginoro_11-20_22_RIGHT|TGTATGAGAATGCTAAACATATGAAACCCA|CCAAGATGGGGGACAAAAGTGT        |2135  |2   |
|KF429774.1&#124;GI            |Amp5    |5800 |7570|ginoro_11-20_21_LEFT|ginoro_11-20_26_RIGHT|TGCTGATGTTAGGACTCTAGACCC      |TGCGAATAATGGCAACCTGTCTG       |1770  |1   |
|KF039730.1&#124;GI            |Amp1    |18   |2213|ginoro_21-30_1_LEFT |ginoro_21-30_7_RIGHT |GACGTCGTTCCTACTGCTGCTA        |GTGGGCTTCATCACACCCTTAC        |2195  |1   |
|KF039730.1&#124;GI            |Amp2    |1547 |3660|ginoro_21-30_6_LEFT |ginoro_21-30_12_RIGHT|GAATGCCGACCCACACGTAGTA        |CATCCCTGATTGGCCATGGACA        |2113  |2   |
|KF039730.1&#124;GI            |Amp3    |2950 |5095|ginoro_21-30_11_LEFT|ginoro_21-30_17_RIGHT|GCCGTGGTCTGAGTGATGAAGA        |GGGTCCAGAAGATTTGGCGTTC        |2145  |1   |
|KF039730.1&#124;GI            |Amp4    |4431 |6709|ginoro_21-30_16_LEFT|ginoro_21-30_23_RIGHT|GCTTTTGGCCCATTTTGTGACG        |AGTAGGGGCTTGTTCACTAGCA        |2278  |2   |
|KF039730.1&#124;GI            |Amp5    |6048 |7569|ginoro_21-30_22_LEFT|ginoro_21-30_26_RIGHT|ACTCCCAAATCTGCCATTGAGTT       |TGCGAATAATGGCAACCTGTCT        |1521  |1   |

> **NOTE:** Primers need to be used at a final concentration of 0.015&micro;M per primer. In this case, Pool 1 has 78 primers in it so the requirement is 1.5&micro;L of 10&micro;M primer Pool 1 per 25&micro;L reaction. Pool 2 has 52 primers so needs 1&micro;L of primer Pool 2 per 25&micro;L reaction. For other schemes, adjust the volume added appropriately. 

6. Set up the amplicon PCR reactions as follows in 0.5mL thin-walled PCR or strip-tubes:

    |Reagent |POOL 1 |POOL 2 |
    |--------|-------|-------|
    |NEB Q5® Polymerase 2X MasterMix |12.5&micro;L |12.5&micro;L |
    |Primer Pool 1 or 2 (10&micro;M) |1.5&micro;L |1.0&micro;L |
    |Water |7.0&micro;L |7.5&micro;L |
    |TOTAL |21&micro;L |21&micro;L |
    
> **NOTE:** This should be carried out in the mastermix hood and cDNA should not be taken anywhere near the mastermix hood at any stage.

7. In the TEMPLATE HOOD add 4&micro;L of cDNA to each Pool1 and Pool2 reaction mix and mix well.

8. Pulse centrifuge the tubes to remove any contents from the lid.

9. Set up the cycling conditions as follows:

    |                |Temperature |Time        |Cycles |
    |----------------|------------|------------|-------|
    |Heat Activation |98&deg;C        |30 seconds  |1      |
    |Denaturation    |98&deg;C        |15 seconds  |.     |
    |Annealing       |52&deg;C        |30 seconds  |35      |
    |Extension       |72&deg;C        |480 seconds  |.      |
    |Hold            |4&deg;C         |Indefinite  |1      |

10. Clean-up the amplicons using the following protocol in the TEMPLATE HOOD:
  
    1. Combine the entire contents of “Pool1” and “Pool2” PCR reactions for each biological sample into to a single 1.5mL Eppendorf tube. 
     
    2. Mix sample gently, avoid vortexing.
      
    3. Ensure AlineDX beads are well resuspended by thoroughly mixing prior to addition to the sample. Mixture should be a homogenous brown colour. 
      
    4. Add an equal volume of AlineDX beads to the tube and mix gently by either flicking or pipetting. This should be approximately 50&micro;L, so add 50&micro;L of beads.
      
    5. Pulse centrifuge the tubes to remove any beads or solution from the lid or side of the tube. 
    
    6. Incubate for 2 mins at 25&deg;C.
    
    7. Place on magnetic rack and incubate for 2 mins or until the beads have pelleted against the magnet and the solution is completely clear. 
    
    8. Carefully remove and discard the solution, being careful not to displace the bead pellet. 
    
    9. Add 200&micro;L of room-temperature 70% ethanol to the pellet. 
      
    10. Remove from magnet and mix by gently flicking the tube. 
    
    11. Pulse centrifuge the tube to make sure all the mixture is out of the lid following flicking, then place back onto the magnet. 
    
    12. Incubate for 2 mins or until the beads have pelleted against the magnet and the solution is completely clear. 
    
    13. Carefully remove and discard ethanol, being careful not to displace the bead pellet.
      
    14. Repeat steps `9` to `14` to wash the pellet again. 
      
    15. Briefly pulse centrifuge the pellet and carefully remove as much ethanol as possible using a 10&micro;L tip. 
      
    16. Allow the pellet to dry for 2 mins, being careful not to overdry (if the pellet is cracking, then it is too dry).
      
    17. Resuspend pellet in 30&micro;L of water, and incubate for 2 mins. 
      
    18. Place on magnet and CAREFULLY remove water and transfer to a clean 1.5mL Eppendorf tube. MAKE SURE that no beads are transferred into this tube. In some cases a pulse centrifugation can be used to pellet residual beads.  
      
    19. Quantify the amplicon library using Quantus&trade; following the QuantifluorONE dsDNA protocol.
    
<div class="pagebreak"> </div>
### Part 3: Qubit Quantification of Nucleic Acid: dsDNA

1. Set up the required number of 0.5mL tubes for standards and samples. The Qubit&trade; 1X dsDNA HS Assay requires 2 standards. 

> **NOTE:** Use only thin-wall, clear, 0.5mL PCR tubes. Acceptable tubes include Qubit&trade; assay tubes (Cat. No. Q32856) 

2. Label the tube lids. Do not label the side of the tube as this could interfere with the sample read. Label the lid of each standard tube correctly. Calibration of the Qubit&trade; Fluorometer requires the standards to be inserted into the instrument in the right order

3. Add 10&micro;L of each Qubit&trade; standard to the appropriate tube. 

4. Add 1–20&micro;L of each user sample to the appropriate tube. 

> **NOTE:**  If you are adding 1–2&micro;L of sample, use a P-2 pipette for best results.  

5. Add the Qubit&trade; 1X dsDNA 1X buffer to each tube such that the final volume is 200&micro;L. 
  
> **NOTE:**  The final volume in each tube must be 200&micro;L. Each standard tube requires 190&micro;L of Qubit&trade; working solution, and each sample tube requires anywhere from 180–199&micro;L. Ensure that you have sufficient Qubit&trade; working solution to accommodate all standards and samples. 

> **NOTE:**  To avoid any cross-contamination, we recommend that you remove the total amount of working solution required for your samples and standards from the working solution bottle and then add the required volume to the appropriate tubes instead of pipetting directly from the bottle to each tube. 

6. Mix each sample vigorously by vortexing for 3–5 seconds. 

7. Allow all tubes to incubate at room temperature for 2 minutes, then proceed to “Read standards and samples”. 

8. On the Home screen of the Qubit&trade; 4 Fluorometer, press DNA, then select `1X dsDNA HS` as the assay type. The `Read standards` screen is displayed. Press `Read Standards` to proceed. 

> **NOTE:** If you have already performed a calibration for the selected assay, the instrument prompts you to choose between reading new standards and running samples using the previous calibration. **If you want to use the previous calibration, skip to step 11**. Otherwise, continue with step 9. 

9. Insert the tube containing Standard #1 into the sample chamber, close the lid, then press Read standard. When the reading is complete (~3 seconds), remove Standard #1. 

10. Insert the tube containing Standard #2 into the sample chamber, close the lid, then press Read standard. When the reading is complete, remove Standard #2. 

11. The instrument displays the results on the Read standard screen. For information on interpreting the calibration results, refer to the Qubit&trade; Fluorometer User Guide, available for download at thermofisher.com/qubit. 

12. Press `Run samples`. 

13. On the assay screen, select the sample volume and units: 

    - Press the `+` or `–` buttons on the wheel, or anywhere on the wheel itself, to select the sample volume added to the assay tube (from 1–20&micro;L). 
    
    - From the unit dropdown menu, select the units for the output sample concentration. 

14. Insert a sample tube into the sample chamber, close the lid, then press `Read tube`. When the reading is complete (~3 seconds), remove the sample tube. 

15. **The top value (in large font) is the concentration of the original sample and the bottom value is the dilution concentration**. For information on interpreting the sample results, refer to the Qubit&trade; Fluorometer User Guide. 

16. Repeat step 14 until all samples have been read.

17. Carefully **record all results** and store run file from the Qubit on a memory stick. 

<div class="pagebreak"> </div>
### Part 4: Barcoding and adaptor ligation: One-pot protocol.

> **NOTE:** This is a ‘one-pot ligation’ protocol for native barcoded ligation libraries. We have seen no reduction in performance compared to standard libraries, and is made faster by using the Ultra II® ligation module which is compatible with the Ultra II® end repair/dA-tailing module removing a clean-up step. If you have the time I would recommend using the double incubation times in <span style="color:blue">blue</span>, if you are in a hurry the times in <span style="color:red">red</span> are a good compromise between speed and efficiency.

1. Set up the following end-prep reaction for each biological sample:

   | Reagent                          | Temperature (°C) |
   | -------------------------------- | ---------------- |
   | DNA (100ng)                      | 25µL             |
   | UltraII End-prep reaction buffer | 3.5µL            |
   | UltraII End-prep enzyme mix      | 1.5µL            |
   | TOTAL                            | 30µL             |
> **NOTE:** Amount of RNA can vary from 30-300ng, less than this and the coverage and depth may be sub-optimal. 

2. Incubate at RT for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span> then 65&deg;C for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span>

3. Place on ice for 30 secs

4. Add the following directly to the previous reactions:

    | Reagent                     | Volume |
    | --------------------------- | ------ |
    | NBXX Barcode                | 2.5µL  |
    | UltraII ligation master mix | 20µL   |
    | UltraII ligation enhancer   | 1.0µL  |
    | TOTAL                       | 53.5µL |

> **NOTE:** Use a SINGLE barcode per biological sample. 

5. Incubate at RT for <span style="color:red">10 mins</span> or <span style="color:blue">20 mins</span>, 70&deg;C for 5 mins then place on ice.

6. Pool all barcoded fragments together into a clean 1.5 ml Eppendorf tube

7. Add 53&micro;L AlineDX beads per sample.

8. Incubate for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span>.

9. Place on a magnet rack until clear.

10. Remove solution. 

11. Add 200&micro;L 80% ethanol to the tube still on the magnetic rack.

12. Incubate 30 secs.

13. Remove solution.

14.	Repeat last three steps (11-13).

15.	Spin down and remove residual 70% ethanol and air dry for 1 min.

16.	Resuspend in 31&micro;L EB.

17.	Incubate off the magnetic rack for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span> mins.

18.	Replace on magnetic rack.

19. Incubate for 2 mins at room temperature and then carefully remove solution and transfer to a clean 1.5mL Eppendorf tube. 

20.	Remove 1&micro;L and assess concentration by Qubit as described in previous section. 

21. Set up the following adapter ligation reaction:

    | Reagent                              | Volume |
    | ------------------------------------ | ------ |
    | Cleaned-up barcode fragments (~50ng) | 30µL   |
    | AMII                                 | 1.0µL  |
    | UltraII ligation module              | 30µL   |
    | UltraII ligation enhancer            | 1.0µL  |
    | TOTAL                                | 62µL   |

22. Incubate at RT for <span style="color:red">10 mins</span> or <span style="color:blue">20 mins</span>.

23. Add 31.0&micro;L AlineDX beads

24. Incubate for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span> mins

25. Place on a magnetic rack until clear

26. Remove supernatant 

27. Add 150&micro;L SFB and resuspend by flicking 

> **CAUTION:** do not use 80% ethanol

28. Place on magnetic rack until clear

29. Remove supernatant

30. Repeat SFB wash

31. Spin down and remove residual SFB

32. Add 12&micro;L ELB and resuspend by flicking

33. Incubate at RT for <span style="color:red">5 mins</span> or <span style="color:blue">10 mins</span>

34. Place on magnetic rack

35. Carefully transfer solution to a clean 1.5mL Eppendorf tube. 

36. Remove 1&micro;L and assess concentration by Qubit (wait until beads have settled before measuring).

> **NOTE:** Library can be now be stored at -20oC if required, but for best results it would be best to proceed immediately to sequencing. 

<div class="pagebreak"> </div>
### Part 5: Priming and loading the SpotON flow cell 

1. Thaw the following:
   - Sequencing Buffer (SQB) on ice 
   - Flush Tether (FLT) on ice
   - Flush Buffer (FLB) on ice
   - Library loading beads (LLB) at RT   

2. Thoroughly mix the contents of the SQB, FLT, FLB and LLB tubes by pipetting or shaking.
3. Add 30&micro;L of FLT to 1 tube of FLB. Mix thoroughly as the flush tether significantly enhances the efficiency of adaptor binding to pores.
4. Flip back the MinION lid and slide the priming port cover clockwise so that the priming port is visible.

> **IMPORTANT:** Care must be taken when drawing back buffer from the flow cell. The array of pores must be covered by buffer at all times. Removing more than 20-30&micro;L risks damaging the pores in the array.

5. After opening the priming port, check for small bubble under the cover. Draw back a small volume to remove any bubble (a few&micro;Ls):   
   - Set a P1000 pipette to 200&micro;L   
   - Insert the tip into the priming port   
   - Turn the wheel until the dial shows 220-230&micro;L, or until you can see a small volume of buffer entering the pipette tip.  
   
6. Prepare the flow cell priming mix in a clean 1.5 ml Eppendorf tube. Avoid introducing bubbles at this stage to ease the next step. 

    | RBF | 576&micro;L 
    | Nuclease-free water | 624&micro;L 
   
7. Load 800&micro;L of the FLT/FLB priming mix into the flow cell via the priming port, using the dial-down method described in step 5, avoiding the introduction of air bubbles. 

8. Wait for 5 minutes.                                            

9. In a new tube prepare the library dilution for sequencing:

    | Reagent             | Volume |
    | ------------------- | ------ |
    | SQB                 | 35µL   |
    | Nuclease-free water | 3.5µL  |
    | LLB                 | 25.5µL |
    | Library             | 11.0µL |
    | TOTAL               | 75µL   |

10. Gently lift the SpotON sample port cover to make the SpotON sample port accessible.

11. Load 200&micro;L of the FLT/FLB mix into the flow cell via the priming port (**NOT** the SpotON sample port), avoiding the introduction of air bubbles.

12.  Mix the prepared library gently by pipetting up and down just prior to loading.

13. Add 75&micro;L of sample to the flow cell via the SpotON sample port in a dropwise fashion. Ensure each drop flows into the port before adding the next.

14. Gently replace the SpotON sample port cover, making sure the bung enters the SpotON port, close the priming port and replace the MinION lid.

15. Double–click the MinKNOW icon located on the desktop to open the MinKNOW GUI. 

16. If your MinION was disconnected from the computer, plug it back in.

17. Choose the flow cell type from the selector box:

    - `FLO-MIN106` : R9.4.1 flowcells
   
18. Then mark the flow cell as `Selected`. 

19. Click the `New Experiment` button at the bottom left of the GUI.

20. On the New experiment popup screen, select the running parameters for your experiment from the individual tabs:
  
    - `Output settings - FASTQ`
    : The number of basecalls that MinKNOW will write in a single file. By default this is set to 4000
    
    - `Output settings - FAST5`
    : The number of files that MinKNOW will write to a single folder. By default this is set to 4000
   
21. Click `Begin Experiment`.

22. Allow the script to run to completion.

23. The MinKNOW Experiment page will indicate the progression of the script; this can be accessed through the `Experiment` tab that will appear at the top right of the screen

24. Monitor messages in the Message panel in the MinKNOW GUI

```

```
