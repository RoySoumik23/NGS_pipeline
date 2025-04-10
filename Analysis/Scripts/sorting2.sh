#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
RESULTS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/samtools-1.21/samtools"

# Define input and output files
INPUT="$RESULTS_DIR/R1R2.bam"
OUTPUT="$RESULTS_DIR/R1R2_rg_sorted.bam"

# BAM_rg file sorted
"$SOFTWARE_DIR" sort "$INPUT" -o "$OUTPUT"

echo "Output saved in $OUTPUT"
