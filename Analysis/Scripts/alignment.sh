#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
FASTQ_DIR="$WORK_DIR/FastQC"
RESULTS_DIR="$WORK_DIR/Analysis"
GENOME_REF="$WORK_DIR/Genome/hg38"
BWA_BINARY="$WORK_DIR/Software/bwa-0.7.17/bwa/bwa"

# Define input files
READ1="$FASTQ_DIR/Dis.R1.fastq.gz"
READ2="$FASTQ_DIR/Dis.R2.fastq.gz"

# Define output files
OUTPUT_SAM="$RESULTS_DIR/DisR1R2.sam"

# Aligning the FastQC seq to Ref. genome (hg38)
"$BWA_BINARY" mem -t $(nproc) -R "@RG\tID:dis1\tSM:disease\tPL:ILLUMINA\tLB:lib1\tPU:unit1" "$GENOME_REF" "$READ1" "$READ2" > "$OUTPUT_SAM"

echo "BWA mem alignment complete. Output saved in $OUTPUT_SAM"
