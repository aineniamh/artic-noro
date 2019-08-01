# artic-noro

Resources to aid in sequencing norovirus in a clinical or field setting using nanopore technology. The bioinformatic pipeline was developed using [snakemake](https://snakemake.readthedocs.io/en/stable/). 

## Table of contents

  * [Background](#background)
  * [Protocol](protocol/Norovirus-2kb-Nanopore-sequencing-protocol.md)
  * [Pipeline details](#pipeline)
  * [Setup](#setup)
  * [Usage](#usage)
  * [References](#references)

## background

Norovirus is a leading cause of acute gastroenteritis worldwide, directly costing health-care systems $4.2 billion annually (Bartsch et al., 2016). Infections are normally self-limiting, with symptoms resolving within 2-4 days, however viral shedding and infectivity may continue for weeks following ceasing of symptoms. Complications and chronic infection are common in the young, elderly and immunocompromised.

Current surveillance methods are qualitative and do not provide genetic-level information about the virus. The resolution provided by genomic data will describe the variety of strains circulating and whether we have a single outbreak or multiple outbreaks. It may identify infection sources and will complement epidemiological data to help infer transmission. Implementing routine nanopore sequencing in a clinical setting will minimise time-to decision, providing actionable information regarding circulating strains and nosocomial transmission within hours.

We aim to produce an end-to-end system that can provide real-time access to genomic information within hours, informing infection-control decision making.

This pipeline is developed as part of a 'best-practices' protocol for clinical nanopore sequencing of norovirus. The complementary upstream extraction, amplification, library prep and sequencing protocol can be found [here](protocol/Norovirus-2kb-Nanopore-sequencing-protocol.md) (Luke Meredith). A tiled amplicon approach is currently being tested by Paola Resende with 2kb primers developed using [Primal Scheme](http://primal.zibraproject.org/) (Luke Meredith). Amplicons produced by the scheme, spanning the genome, are shown in the figure below. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. 


<img src="https://github.com/aineniamh/artic-noro/blob/master/primer-schemes/noro2kb/V2/noro2kb.amplicons.poster.png">

## pipeline

This pipeline can be run independently as part of a stand-alone analysis or can be run as part of the RAMPART pipeline. 

The pipeline accepts basecalled (fastq) nanopore reads.

> *Recommendation:* Run the latest high-accuracy model of guppy.


1. Start the sequencing run with ``MinKnow``, use live basecalling with ``guppy``.
2. Start ``RAMPART``. In the future, there will have a desktop application to do this, currently it is launched in the terminal, instructions can be found [here](https://github.com/artic-network/rampart).
3. The server process of ``RAMPART`` watches the directory where the reads will be produced.
4. This snakemake takes each file produced in real-time, demultiplexes (i.e. separates out the barcodes), and trims the fastq reads using [``porechop``](https://github.com/rambaut/Porechop), barcode labels are written to the header of each read. 
5. Reads are mapped against a panel of references using [``minimap2``](https://github.com/lh3/minimap2) and the identity of the best hit is added to the read header or to a csv report. Other information, such as mapping coordinates and reference length are also reported (either in the read header or in a a csv report).
6. This information is parsed by an internal ``RAMPART`` script and pushed to the front-end for vizualisation. For each sample, the depth of coverage is shown in real-time as the reads are being produced. 
7. Once sufficient depth is achieved, the anaysis pipeline can be started by clicking in ``RAMPART``'s GUI or by calling ``snakemake`` on the command line (instructions below). 
8. [``binlorry``](https://github.com/rambaut/binlorry) parses through the fastq files with barcode labels, pulling out the relevant reads and binning them into a single fastq file for that sample. It also applies a read-length filter, that you can customise in the GUI, and can filter by reference match, in cases of mixed-samples.
9. Specifically for norovirus, a process determines how many analyses to run per sample. Based on mapping coordinates, each read is designated as likely 'orf1' or 'orf2/3', which is the most common recombination point. The process checks whether there are multiple different virus genotypes within that sample and determines the number of parallel analyses that will be needed (one per type of virus). 
10. The barcode fastq is then subsetted (binned again using ``binlorry``) by genotype and open reading frame ('orf1' or 'orf2/3'). 
11. [``racon``](https://github.com/isovic/racon) and [``minimap2``](https://github.com/lh3/minimap2) are run iteratively four times against the fastq reads and then a final polishing consensus-generation step is performed using [``medaka``](https://github.com/nanoporetech/medaka). 
12. A markdown report is generated, summarising the viral profile of each sample. 

<img src="https://github.com/aineniamh/artic-noro/blob/master/rampart_config/rampart_screenshot.png">
Screenshot of RAMPART's front end showing norovirus data. 


## setup

Although not a requirement, an install of conda will make the setup of this pipeline on your local machine much easier. I have created an ``artic-noro`` conda environment which will allow you to access all the software required for the pipeline to run. To install conda, visit here https://conda.io/docs/user-guide/install/ in a browser. If you choose not to, you will need to ensure access to all the dependencies required (list of dependencies found in envs/artic-noro.yaml).

> *Recommendation:* Install the `64-bit Python 3.6` version of Miniconda

Once you have a version of conda installed on your machine, clone this repository by typing into the command line:

```bash
git clone https://github.com/aineniamh/artic-noro.git
```

Build the conda environment by typing:

```bash
conda env create -f artic-noro/envs/artic-noro.yaml
```

To activate the environment, type:

```bash
source activate artic-noro
```

To deactivate the environment, enter:

```bash
conda deactivate
```
## usage

```bash
snakemake --snakefile pipelines/master_demux/Snakefile.smk --config file_stem=your_file_here
```

```bash
snakemake --snakefile pipelines/master_consensus/Snakefile.smk 
```

## references

Bartsch, S. M., Lopman, B. A., Ozawa, S., Hall, A. J. and Lee, B. Y. (2016) Global Economic Burden of Norovirus Gastroenteritis. PloS one.

Köster, Johannes and Rahmann, Sven. (2012) Snakemake - A scalable bioinformatics workflow engine. Bioinformatics.

Quick et al. (2017) Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. Nature Protocols.
