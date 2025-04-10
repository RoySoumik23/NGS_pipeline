#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
GENOME_DIR="$WORK_DIR/Genome"
ANALYSIS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/gatk-4.6.1.0"

# Define input files
REFERENCE_GENOME="$GENOME_DIR/hg38.fa"
TUMOR_BAM1="$ANALYSIS_DIR/DisR1R2_rg_sorted.bam"
TUMOR_BAM2="$ANALYSIS_DIR/R1R2_rg_sorted.bam"

# Define output file
OUTPUT_VCF="$ANALYSIS_DIR/Somatic_calling.vcf.gz"

# Run Mutect2 for somatic variant calling
"$SOFTWARE_DIR/gatk" Mutect2 -R "$REFERENCE_GENOME" -I "$TUMOR_BAM1" -I "$TUMOR_BAM2" -O "$OUTPUT_VCF"

echo "Somatic variant calling complete. Output saved in $OUTPUT_VCF"
