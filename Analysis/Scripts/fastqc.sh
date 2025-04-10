#!/bin/bash

# Define constants for file paths
FASTQ_DIR="/home/shivalik2/Soumik/TA_duty/FastQC"
RESULTS_DIR="$FASTQ_DIR/results"
FASTQC_BINARY="/home/shivalik2/Soumik/TA_duty/Software/FastQC/fastqc"

# Run FastQC on all FASTQ files
"$FASTQC_BINARY" "$FASTQ_DIR"/*.fastq.gz -o "$RESULTS_DIR"

echo "FastQC analysis complete. Results saved in $RESULTS_DIR"
