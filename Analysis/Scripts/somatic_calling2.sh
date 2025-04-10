#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
GENOME_DIR="$WORK_DIR/Genome"
ANALYSIS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/gatk-4.6.1.0"

# Define input files
REFERENCE_GENOME="$GENOME_DIR/hg38.fa"
TUMOR_BAM="$ANALYSIS_DIR/DisR1R2_rg_sorted.bam"
NORMAL_BAM="$ANALYSIS_DIR/R1R2_rg_sorted.bam"

# Sample names (must match @RG SM fields in BAM files)
TUMOR_SAMPLE="disease"
NORMAL_SAMPLE="normal"

# Define output file
OUTPUT_VCF="$ANALYSIS_DIR/somatic_calling.vcf.gz"

# Run Mutect2 for somatic variant calling (tumor-normal mode)
"$SOFTWARE_DIR/gatk" Mutect2 \
    -R "$REFERENCE_GENOME" \
    -I "$TUMOR_BAM" --tumor-sample "$TUMOR_SAMPLE" \
    -I "$NORMAL_BAM" --normal-sample "$NORMAL_SAMPLE" \
    --native-pair-hmm-threads $(nproc) \
    -O "$OUTPUT_VCF"

echo "Somatic variant calling complete. Output saved in $OUTPUT_VCF"
