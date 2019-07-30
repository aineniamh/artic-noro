# artic-noro

Repository for a snakemake pipeline for running analysis for the artic-noro MinION sequencing project.

## background

This pipeline can be run independently as part of a stand-alone analysis or can be run as part of the RAMPART pipeline. The two branches of this repository provide the alternative implementations.

The pipeline accepts basecalled fastq nanopore reads.

> *Recommendation:* Run the latest high-accuracy model of guppy

This pipeline is developed as part of a 'best-practices' protocol for clinical nanopore sequencing of norovirus. The complementary upstream protocol can be found in #Link url. A tiled amplicon approach is currently being tested with 2kb primers developed by Primal Scheme. Amplicons produced by the scheme, spanning the genome, are shown in the figure below. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. 


## setup

Although not a requirement, an install of conda will make the setup of this pipeline on your local machine much easier. I have created an ``artic-noro`` conda environment which will allow you to access all the software required for the pipeline to run. To install conda, visit here https://conda.io/docs/user-guide/install/ in a browser. 

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

Temporary running, will change again tomorrow:
1.
```bash
snakemake --snakefile pipelines/rampart_demux_map/Snakefile --config file_stem={file_stem} outputPath=pipeline_output referencePanelPath=rampart_config/norovirus/initial_record_set.fasta referenceConfigPath=rampart_config/norovirus/coordinate_reference.fasta basecalledPath=rampart_config/norovirus/data/basecalled
```
2.

```bash
snakemake --snakefile pipelines/bin_filter/Snakefile --config barcode={your_barcode}
```

3.

```bash
snakemake --snakefile pipelines/polish_consensus/Snakefile --configfile pipeline_output/binned/barcode_{your_barcode}/config.yaml 

```
