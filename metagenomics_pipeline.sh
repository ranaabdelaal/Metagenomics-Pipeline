# 1. Fastp: quality control and trimming
fastp \
-i R1_subset.fastq.gz \
-I R2_subset.fastq.gz \
-o R1_subset_clean.fastq.gz \
-O R2_subset_clean.fastq.gz \
--thread 2 \
--html fastp_subset.html \
--json fastp_subset.json

# 2. MEGAHIT: metagenomic assembly
megahit \
-1 R1_subset_clean.fastq.gz \
-2 R2_subset_clean.fastq.gz \
-o megahit_subset_output \
-t 2 \
--memory 0.8

# 3. MetaQUAST: assembly quality assessment
metaquast.py \
megahit_subset_output/final.contigs.fa \
-o quast_results \
-t 2

# 4. Bowtie2: build contig index
bowtie2-build \
megahit_subset_output/final.contigs.fa \
contigs_index

# 5. Bowtie2: map reads to contigs
bowtie2 \
-x contigs_index \
-1 R1_subset_clean.fastq.gz \
-2 R2_subset_clean.fastq.gz \
-p 2 \
-S mapped_reads.sam

# 6. SAMtools: convert, sort and index BAM
samtools view -bS mapped_reads.sam > mapped_reads.bam

samtools sort \
-o mapped_reads.sorted.bam \
mapped_reads.bam

samtools index mapped_reads.sorted.bam

# 7. SemiBin2: metagenomic binning
SemiBin2 single_easy_bin \
-i megahit_subset_output/final.contigs.fa \
-b mapped_reads.sorted.bam \
-o semibin2_output \
-p 2
