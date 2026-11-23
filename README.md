# Metagenomics Assembly & Binning Pipeline

A straightforward, single-sample Bash pipeline (`metagenomics_pipeline.sh`) that processes paired-end Illumina metagenomic reads from raw FASTQ files into metagenome-assembled genomes (MAGs).

## Pipeline Overview

The script executes seven sequential bioinformatics steps using 2 CPU threads by default:

1. **Quality Control & Trimming (`fastp`)**: Filters low-quality reads, trims adapters, and generates HTML/JSON QC reports.
2. **Metagenomic Assembly (`MEGAHIT`)**: Assembles cleaned paired-end reads into contigs.
3. **Assembly Assessment (`MetaQUAST`)**: Evaluates contig metrics and assembly quality.
4. **Contig Indexing (`Bowtie2`)**: Builds an index from the assembled contigs.
5. **Read Mapping (`Bowtie2`)**: Aligns cleaned reads back to the assembled contigs to calculate coverage.
6. **Alignment Processing (`SAMtools`)**: Converts SAM alignments to BAM format, sorts, and indexes the resulting file.
7. **Metagenomic Binning (`SemiBin2`)**: Clusters contigs into genomic bins (MAGs) using sequence composition and coverage depth.

## Prerequisites

Ensure the following tools are installed and available in your `$PATH`:

* [fastp](https://github.com/OpenGene/fastp)
* [MEGAHIT](https://github.com/voutcn/megahit)
* [QUAST / MetaQUAST](https://github.com/ablab/quast)
* [Bowtie2](https://github.com/BenLangmead/bowtie2)
* [SAMtools](https://github.com/samtools/samtools)
* [SemiBin2](https://github.com/BigDataBiology/SemiBin)

## Input Requirements

Place your paired-end compressed FASTQ files in the working directory named as follows:
* `R1_subset.fastq.gz` (Forward reads)
* `R2_subset.fastq.gz` (Reverse reads)

## Usage

Make the script executable and run it in the directory containing your input FASTQ files:

```bash
chmod +x metagenomics_pipeline.sh
./metagenomics_pipeline.sh
