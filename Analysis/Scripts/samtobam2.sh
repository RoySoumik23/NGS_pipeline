#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
RESULTS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/samtools-1.21/samtools"

# Define input and output files
INPUT_SAM="$RESULTS_DIR/R1R2.sam"
OUTPUT_BAM="$RESULTS_DIR/R1R2.bam"

# Run samtools to convert SAM to BAM
"$SOFTWARE_DIR" view -S -b "$INPUT_SAM" -o "$OUTPUT_BAM"

echo "SAM to BAM conversion complete. Output saved in $OUTPUT_BAM"
