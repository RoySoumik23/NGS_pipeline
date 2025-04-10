#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
GENOME_DIR="$WORK_DIR/Genome"
ANALYSIS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/gatk-4.6.1.0"

# Define input files
REFERENCE_GENOME="$GENOME_DIR/hg38.fa"
INPUT_BAM="$ANALYSIS_DIR/R1R2_rg_sorted.bam"

# Define output file
OUTPUT_VCF="$ANALYSIS_DIR/R1R2_rg_sorted.vcf.gz"

# Run HaplotypeCaller
"$SOFTWARE_DIR/gatk" HaplotypeCaller \
    -R "$REFERENCE_GENOME" \
    -I "$INPUT_BAM" \
    -O "$OUTPUT_VCF"

echo "Haplotype calling complete. Output saved in $OUTPUT_VCF"
