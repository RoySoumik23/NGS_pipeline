#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
RESULTS_DIR="$WORK_DIR/Analysis"
SOFTWARE_DIR="$WORK_DIR/Software/samtools-1.21/samtools"

# Define I/O files
INPUT="$RESULTS_DIR/DisR1R2.bam"
OUTPUT="$RESULTS_DIR/DisR1R2_rg.bam"

# Add Readgroups to bam files
"$SOFTWARE_DIR" addreplacerg -r "@RG\tID:tumor_rg\tSM:disease\tPL:ILLUMINA\tLB:lib1\tPU:unit1" "$INPUT" -o "$OUTPUT"

echo "Output saved in $OUTPUT"
