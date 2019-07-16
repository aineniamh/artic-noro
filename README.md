# artic-noro

Repository for a snakemake pipeline for running analysis for the artic-noro MinION sequencing project.

## background

This pipeline can be run independently as part of a stand-alone analysis or can be run as part of the RAMPART pipeline. The two branches of this repository provide the alternative implementations.

The pipeline accepts basecalled fastq nanopore reads.

> *Recommendation:* Run the latest high-accuracy model of guppy

This pipeline is developed as part of a 'best-practices' protocol for clinical nanopore sequencing of norovirus. The complementary upstream protocol can be found in #Link url. A tiled amplicon approach is currently being tested with 2kb primers developed by Primal Scheme. Amplicons produced by the scheme, spanning the genome, are shown in the figure below. To cover the diversity of norovirus, multiple primer schemes were created with different sets of reference sequences from GenBank. 

<img src="https://github.com/aineniamh/artic-noro/blob/master/primer-schemes/noro2kb/V2/noro2kb.amplicons.png">


## realtime pipeline

This pipeline will be integrated into ``RAMPART``. The pipeline is visualised in the figure below.

1. Start the sequencing run with ``MinKnow``, use live basecalling with ``guppy``.
2. Start ``RAMPART``. In the future, there will have a desktop application to do this, currently it is launched in the terminal, instructions can be found here #Link url.
3. The server process of ``RAMPART`` watches the directory where the reads will be produced and demultiplexes and trims the fastq reads using ``porechop``, barcode labels are written to the header of each read. Reads are mapped against a panel of references using ``minimap2`` and results are pushed to the front-end visualisation. For each sample, the depth of coverage is shown in real-time as the reads are being produced. 
4. Once sufficient depth is achieved, the anaysis pipeline can be started by clicking in RAMPART's GUI. 
5. ``binlorry`` parses through the fastq files with barcode labels, pulling out the relevant reads and binning them into a single fastq file. It also applies a read-length filter, that you can customise in the GUI, and can filter by reference match, in cases of mixed-samples.
6. ``racon`` and ``minimap2`` are run iteratively six times against the fastq reads and then a final polishing consensus-generation step is performed using ``medaka``. 
7. Variants are called on the reads (currently in testing), and phasing is performed to provide information on closly related mixed infections. 
8. The consensus sequence(s) from the sample are aligned with concurrent samples in the context of the reference genomes using ``mafft`` and ``iqtree`` is used to construct a phylogeny. 
9. Future: a time-tree will be generated and epidemiological metadata used with Trans-phylo to infer transmission events. Both genetic and epidemiological data will be visualised in an interactive report that will include the floor plan of the hospital, or local map if outbreak is community based. 

## standalone pipeline

This pipeline starts with the basecalled fastq files. It demultiplexes the reads using ``porechop`` and filters by length using ``binlorry``. ``minimap2`` is used to identify the closest major strains present in each sample 

<img src="https://github.com/aineniamh/artic-noro/blob/master/dag_one_sample.svg">

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

## customising the pipeline

To run the analysis using snakemake, you will want to customise the ``config.yaml`` file.

Inside the ``config.yaml`` file, you can change your MinION ``run_name`` and the barcode names. Ensure ```path_to_fastq``` point to where your data is.

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
<!-- 
## pipeline description

1. setup ``artic fieldbioinformatics`` package \
Automatic setup of this on startup of the pipeline. Gives the user access to ``artic minion`` script for step below.
2. gather \
Parses all of the basecalled fastq files from ``guppy``, applies a length filter that can be customised in the ``config.yaml`` file and writes the reads to a single file ``run_name_all.fastq``. This script also searches the fastq directories for ``sequencing_summary`` files and combines them into a single file: ``run_name_sequencing_summary.txt``. These files will be output in the ``pipeline_output`` directory.
3. demultiplex_qcat \
For each read in the ``run_name_all.fastq`` file, identifies barcodes and outputs reads into respective files, binned by barcode. These files appear in the ``demultiplexed`` directory, in ``pipeline_output``.
4. make_amplicon_files \
Using the primer-scheme bed file, amplicon summary files are generated using a custom python script. The script produces a figure showing the amplicon span over the reference genomes, a csv file with amplicon information and a fasta file with extracted amplicon sequences.
5. fastq_to_fasta \
Fastq files are converted to fasta files using ``seqtk`` for the purposes of blasting.
6. blastn \
For each ``barcode.fastq`` file, each read is blasted against a sequence database containing all amplicon sequences.
7. bin \
This step parses each blast output and assesses for each read what the best blast hit is. The reads are then binned by amplicon and, for each amplicon, the best reference sequence is calculated. This determines which reference is most suited to take forward into nanopolish for each amplicon for each barcode. It also creates the respective bed file for the ``artic minion`` pipeline to use.

<!-- 4. minimap2_index \
Indexes a panel of reference sequences for minimap2.
5. minimap2 \
For each barcode, maps the reads against the panel of reference sequences and produces a ``.paf`` file.
6. find_top_reference \
For each ``barcode``, identifies the reference with the greatest number of reads mapping to it and creates a new reference file ``primer-schemes/noro2kb/V_barcode/barcode.reference.fasta`` and a new bed file ``primer-schemes/noro2kb/V_barcode/barcode.scheme.bed``.
7. minimap_to_top_reference \
Re-maps the reads for each demultiplexed file against their respective top reference and outputs a sam file in ``pipeline_output/best_ref_mapped_reads/``.
8. Quick reference generation \
``samtools`` is used to sort the reads and ``bcftools`` is then used to call variants, normalise for indels and call a quick consensus sequence ``pipeline_output/consensus/{barcode}.cns.fasta``. This consensus sequence is then renamed and saved in ``primer-schemes/noro2kb/V_barcode/`` as ``barcode.reference.fasta``. -->
<!-- 8. nanopolish_index \
Creates the nanopolish index necessary for running nanopolish in the next step. It accesses the gathered fastq and sequencing summary files from step 2 and also the signal-level fast5 data.
9. artic_minion \
The ``artic minion`` pipeline, written by Nick Loman, is then run for each barcode in order to generate a high-quality consensus sequence, using an approach informed by signal-level data. This pipeline performs the following steps:
    * Maps against a given reference and sorts reads using ``bwa`` and ``samtools`` respectively.
    * Runs the ``artic align_trim`` script. This script takes in a bed file and your alignment and assesses whether the primers are correctly paired according to the bed file, discarding reads that are not, and normalises the read coverage across the genome. It is run twice, first to trim off the barcodes and the primers and second to just trim off the barcodes.
    * Loads the ``nanopolish index`` created in step 8.
    * Runs ``nanopolish variants`` twice, on the barcode-and-primer-trimmed bam and on the barcode-trimmed bam.
    * Generates a variant frequency plot.
    * Runs ``margin_cons``, a custom script that filters the variants, masking sites that do not reach the depth threshold of 20 and do not reach a quality threshold of 200, and produces a consensus sequence with 'N' masking on the relevant sites. It uses the vcf from nanopolish without primer-trimming but the primer-trimmed bam file so that primer sequences do not count towards depth calculation. A report is also generated.
10. organise_minion_output \
Moves artic_minion output files into respective ``pipeline_output/minion_output/barcode`` directories on completion of the pipeline.
11. generate_genome (Not done yet) \
Overlays the consensus sequences for each amplicon and creates a whole-genome reference sequence.  --> -->
