#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
SOFTWARE_DIR="$WORK_DIR/Software/samtools-1.21/samtools"

# Define input and output files
INPUT_SAM="$WORK_DIR/Analysis/R1R2_rg_sorted.bam"

# Run samtools to convert SAM to BAM
"$SOFTWARE_DIR" index "$INPUT_SAM"

echo "Done"
