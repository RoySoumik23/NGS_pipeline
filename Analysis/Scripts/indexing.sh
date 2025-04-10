#!/bin/bash

# Define constants for file paths
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
BWA_BINARY="$WORK_DIR/Software/bwa-0.7.17/bwa/bwa"

# Define I/O files
INPUT="$WORK_DIR/Genome/hg38.fa"
OUTPUT="$WORK_DIR/Genome"


# Index the reference genome
"$BWA_BINARY" index "$INPUT" -p "$OUTPUT"

echo "Output saved in $OUTPUT"
