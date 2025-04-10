#!/bin/bash

# Define constants for directories
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
GENOME_DIR="$WORK_DIR/Genome"
SOFTWARE_DIR="$WORK_DIR/Software"

# Define software paths
SAMTOOLS="$SOFTWARE_DIR/samtools-1.12/samtools"
GATK="$SOFTWARE_DIR/gatk-4.6.1.0/gatk"

# Define input genome file
GENOME_FASTA="$GENOME_DIR/hg38.fa"

# Generate FASTA index using Samtools
$SAMTOOLS faidx "$GENOME_FASTA"

# Create sequence dictionary using GATK
$GATK CreateSequenceDictionary -R "$GENOME_FASTA" -O "$GENOME_DIR/hg38.dict"

echo "FASTA index and sequence dictionary creation complete."
