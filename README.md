# artic-noro

Repository for a snakemake pipeline for running analysis for the artic-noro MinION sequencing project.

## background

RNA was extracted from stool samples and reverse transcribed into cDNA. A tiled amplicon approach was used to amplify any norovirus in the sample. Primal scheme was used to develop the scheme of primers, with an average size amplicon size of 2kb. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. Sequencing was performed using the MinION and the fast5 reads were basecalled with MinKNOW. 

This pipeline starts with the basecalled reads, gathers them together and applies a read length filter. It then demultiplexes them using ``qcat`` and maps them against a panel of references using ``minimap2``. A custom python script identifies the best reference for each barcode and, from there, the reads are mapped, sorted, indexed and variant called using a combination of ``samtools``, ``bcftools``, custom scripts and ``nanopolish``. Custom scripts then collect the information from the variant calls and output summary figures.

## setup

Although not a requirement, an install of conda will make the setup of this pipeline on your local machine much more streamlined. I have created an ``artic-noro`` conda environment which will allow you to access all the software required for the pipeline to run. To install conda, visit here https://conda.io/docs/user-guide/install/ in a browser. 

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

## customising the pipeline

To run the analysis using snakemake, you will want to customise the ``config.yaml`` file.

Inside the ``config.yaml`` file, you can change your MinION ``run_name`` and the barcode names. Ensure ```path_to_fast5``` and ```path_to_fastq``` point to where your data is.

## running the pipeline

To start the pipeline, in a terminal window in the artic-noro directory, simply enter:

```bash
snakemake
```

If you wish to run your pipeline using more than one core (**recommended**), enter:

```bash
snakemake --cores X
```

where X is the number of threads you wish to run.

