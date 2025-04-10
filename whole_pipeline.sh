#!/bin/bash

###############################################################################
#               Full End-to-End Mutation & Somatic Variant Pipeline           #
#               Author: Soumik Roy | IIT Hyderabad | Apr 2025                 #
#               Description:                                                  #
#   This script performs complete variant analysis from raw FASTQ files       #
#   through alignment, mutation calling, somatic calling, and IGV launch.     #
#   It handles both normal and diseased sample pairs.                         #
###############################################################################

# ==== Set Directories and Tools ====
WORK_DIR="/home/shivalik2/Soumik/TA_duty"
GENOME_DIR="$WORK_DIR/Genome"
SOFTWARE_DIR="$WORK_DIR/Software"
FASTQ_DIR="$WORK_DIR/FastQC"
ANALYSIS_DIR="$WORK_DIR/Analysis"
BWA="$SOFTWARE_DIR/bwa-0.7.17/bwa/bwa"
SAMTOOLS="$SOFTWARE_DIR/samtools-1.21/samtools"
GATK="$SOFTWARE_DIR/gatk-4.6.1.0/gatk"
FASTQC="$SOFTWARE_DIR/FastQC/fastqc"
IGV_DIR="$SOFTWARE_DIR/IGV_Linux_2.19.2"

# ==== File Names ====
GENOME_FA="$GENOME_DIR/hg38.fa"
GENOME_PREFIX="$GENOME_DIR/hg38"

# Diseased sample
DIS_R1="$FASTQ_DIR/Dis.R1.fastq.gz"
DIS_R2="$FASTQ_DIR/Dis.R2.fastq.gz"
DIS_SAM="$ANALYSIS_DIR/Dis.sam"
DIS_BAM="$ANALYSIS_DIR/Dis.bam"
DIS_SORTED_BAM="$ANALYSIS_DIR/Dis_sorted.bam"
DIS_VCF="$ANALYSIS_DIR/Dis.vcf.gz"

# Normal sample
CTRL_R1="$FASTQ_DIR/R1.fastq.gz"
CTRL_R2="$FASTQ_DIR/R2.fastq.gz"
CTRL_SAM="$ANALYSIS_DIR/Ctrl.sam"
CTRL_BAM="$ANALYSIS_DIR/Ctrl.bam"
CTRL_SORTED_BAM="$ANALYSIS_DIR/Ctrl_sorted.bam"
CTRL_VCF="$ANALYSIS_DIR/Ctrl.vcf.gz"

# Somatic
SOMATIC_VCF="$ANALYSIS_DIR/somatic_calling.vcf.gz"

# ==== Step 0: Reference Genome Indexing (run once only) ====
echo "\n[Indexing Reference Genome if not already done]"
[ ! -f "$GENOME_FA.bwt" ] && $BWA index "$GENOME_FA" -p "$GENOME_PREFIX"
[ ! -f "$GENOME_FA.fai" ] && $SAMTOOLS faidx "$GENOME_FA"
[ ! -f "$GENOME_DIR/hg38.dict" ] && $GATK CreateSequenceDictionary -R "$GENOME_FA" -O "$GENOME_DIR/hg38.dict"

# ==== Step 1: FASTQC ====
echo "\n[Running FastQC on all FASTQ files]"
mkdir -p "$FASTQ_DIR/results"
$FASTQC "$FASTQ_DIR"/*.fastq.gz -o "$FASTQ_DIR/results"


################################################################################
#                              <fastp> if needed                               #

# Input and output files                                                       #
#inputR1="${WORK_DIR}folder1/sample1_read1.fastq.gz"                           #
#inputR2="${WORK_DIR}folder1/sample1_read2.fastq.gz"                           #
#outputR1="${WORK_DIR}folder1/sample1_read1_trimmed.fastq.gz"                  #
#outputR2="${WORK_DIR}folder1/sample1_read2_trimmed.fastq.gz"                  #
#fastp_report1="${WORK_DIR}folder1/fastp_report_sample1.html"                  #

# Run fastp for the first pair of files                                        #
#fastp -i "${inputR1}" -I "${inputR2}" -o "${outputR1}" \                      #
#    -O "${outputR2}" -q 20 -u 40 -h "${fastp_report1}"                        #

#echo "Fastp trimming completed successfully."                                 #

# Notes:
# -q 20 means quality filtering, phred quality <= 20 is filtered.
# -u 40 means 40% bases are allowed to be unqualified (phred quality <= 20)    #
################################################################################


# ==== Step 2: BWA Alignment ====
echo "\n[Aligning Diseased Sample]"
$BWA mem -t $(nproc) -R "@RG\tID:dis1\tSM:disease\tPL:ILLUMINA\tLB:lib1\tPU:unit1" \
    "$GENOME_PREFIX" "$DIS_R1" "$DIS_R2" > "$DIS_SAM"

echo "\n[Aligning Normal Sample]"
$BWA mem -t $(nproc) -R "@RG\tID:ctrl1\tSM:normal\tPL:ILLUMINA\tLB:lib1\tPU:unit1" \
    "$GENOME_PREFIX" "$CTRL_R1" "$CTRL_R2" > "$CTRL_SAM"

# ==== Step 3: Convert SAM to BAM ====
echo "\n[Converting SAM to BAM]"
$SAMTOOLS view -S -b "$DIS_SAM" -o "$DIS_BAM"
$SAMTOOLS view -S -b "$CTRL_SAM" -o "$CTRL_BAM"

# ==== Step 4: Sort BAM files ====
echo "\n[Sorting BAM Files]"
$SAMTOOLS sort "$DIS_BAM" -o "$DIS_SORTED_BAM"
$SAMTOOLS sort "$CTRL_BAM" -o "$CTRL_SORTED_BAM"

# ==== Step 5: Index BAM files ====
echo "\n[Indexing BAM Files]"
$SAMTOOLS index "$DIS_SORTED_BAM"
$SAMTOOLS index "$CTRL_SORTED_BAM"

# ==== Step 6: Variant Calling (Germline) ====
echo "\n[Calling Variants for Diseased and Normal]"
$GATK HaplotypeCaller -R "$GENOME_FA" -I "$DIS_SORTED_BAM" -O "$DIS_VCF"
$GATK HaplotypeCaller -R "$GENOME_FA" -I "$CTRL_SORTED_BAM" -O "$CTRL_VCF"

# ==== Step 7: Somatic Variant Calling ====
echo "\n[Running Somatic Variant Calling with Mutect2]"
$GATK Mutect2 \
    -R "$GENOME_FA" \
    -I "$DIS_SORTED_BAM" --tumor-sample "disease" \
    -I "$CTRL_SORTED_BAM" --normal-sample "normal" \
    --native-pair-hmm-threads $(nproc) \
    -O "$SOMATIC_VCF"

# ==== Step 8: Launch IGV ====
echo "\n[Launching IGV for Visualization]"
cd "$IGV_DIR" && bash igv.sh &

echo "\nPipeline execution complete. All results saved in $ANALYSIS_DIR"

