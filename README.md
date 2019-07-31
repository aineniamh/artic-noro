# artic-noro

Repository for a snakemake pipeline for running analysis for the artic-noro MinION sequencing project.

## background

This pipeline can be run independently as part of a stand-alone analysis or can be run as part of the RAMPART pipeline. 

The pipeline accepts basecalled fastq nanopore reads.

> *Recommendation:* Run the latest high-accuracy model of guppy

This pipeline is developed as part of a 'best-practices' protocol for clinical nanopore sequencing of norovirus. The complementary upstream protocol can be found in #Link url. A tiled amplicon approach is currently being tested with 2kb primers developed by Primal Scheme. Amplicons produced by the scheme, spanning the genome, are shown in the figure below. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. 

## background

RNA was extracted from stool samples and reverse transcribed into cDNA. A tiled amplicon approach was used to amplify any norovirus in the sample. Primal scheme was used to develop the scheme of primers, with an average size amplicon size of 2kb. Amplicons are shown in the figure below. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. Sequencing was performed using the MinION and the fast5 reads were basecalled with MinKNOW. 

<img src="https://github.com/aineniamh/artic-noro/blob/master/primer-schemes/noro2kb/V2/noro2kb.amplicons.poster.png">


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
## running the pipelines

```bash
snakemake --snakefile pipelines/master_demux/Snakefile.smk --config file_stem=your_file_here
```

```bash
snakemake --snakefile pipelines/master_consensus/Snakefile.smk 
```

