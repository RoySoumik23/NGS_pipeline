#!/bin/bash

# Define working directory
WORK_DIR="/path/to/your/working_directory/"

# Input and output files
inputR1="${WORK_DIR}folder1/sample1_read1.fastq.gz"
inputR2="${WORK_DIR}folder1/sample1_read2.fastq.gz"
outputR1="${WORK_DIR}folder1/sample1_read1_trimmed.fastq.gz"
outputR2="${WORK_DIR}folder1/sample1_read2_trimmed.fastq.gz"
fastp_report1="${WORK_DIR}folder1/fastp_report_sample1.html"

# Run fastp for the first pair of files
fastp -i "${inputR1}" -I "${inputR2}" -o "${outputR1}" -O "${outputR2}" -q 20 -u 40 -h "${fastp_report1}"

echo "Fastp trimming completed successfully."

# Notes:
# -q 20 means quality filtering, phred quality <= 20 is filtered.
# -u 40 means 40% bases are allowed to be unqualified (phred quality <= 20)

