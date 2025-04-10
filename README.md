# NGS_pipeline

## 🔬 Variant Calling Bioinformatics Pipeline

This repository contains a complete and modular **shell-scripted bioinformatics pipeline** to process raw NGS data (FASTQ) into interpretable mutation and somatic variant calls (VCF), and finally visualize them in **IGV**. The pipeline integrates industry-standard tools like **FastQC, BWA, Samtools, GATK**, and supports automated execution from start to finish.

---

## Overview

**Pipeline Steps:**
1. **Quality Control** – Assess reads with FastQC  
2. **Reference Genome Preparation** – Indexing and Dictionary generation  
3. **Read Alignment** – Map reads to reference using BWA  
4. **File Conversion** – Convert SAM to BAM (compressed)  
5. **Sorting and Indexing** – Prepare BAM for analysis  
6. **Mutation Calling** – Call variants using `samtools mpileup` + `bcftools`  
7. **Somatic Variant Calling** – Use GATK HaplotypeCaller or Mutect2  
8. **Visualization** – Open results in IGV  

---

Project Directory Structure
```
NGS_pipeline/
├── Analysis/               # Final outputs and analysis results
│   └── Scripts/            # All pipeline and shell scripts
│
├── FastQ/                  # Input FASTQ files
│   └── Results/            # Output of FastQC analysis
│
├── Software/               # All required tools and software (local installations)
│   ├── bwa-0.7.17/
│   ├── gatk-4.6.1.0/
│   ├── samtools-1.21/
│   └── fastqc_v0.12.1/
│
├── Genome/                 # Reference genome files and related indexes
│   ├── hg38.fa             # Reference FASTA (GRCh38/hg38)
│   ├── hg38.fa.fai         # FASTA index (samtools)
│   ├── hg38.dict           # Sequence dictionary (GATK)
│   ├── hg38.fa.bwt         # BWA index files (.bwt, .pac, .ann, etc.)
│   └── ...                 # Other index files (.amb, .sa, etc.)
│
└── README.md               # Project overview and usage instructions
```
---

## Tools Used

| Tool      | Version Tested | Description |
|-----------|----------------|-------------|
| `FastQC`  | v0.12.1         | Quality control for raw reads |
| `BWA`     | v0.7.17         | Burrows-Wheeler Aligner for read mapping |
| `Samtools`| v1.21           | Tools for BAM/SAM file manipulation |
| `GATK`    | v4.6.1.0        | Genome Analysis Toolkit for somatic/mutation calling |
| `IGV`     | v2.19.2         | Integrative Genomics Viewer for visualizing variants |

---

## Installation Guide  
To replicate and run this pipeline successfully, ensure the following bioinformatics tools are installed on your system. Below are the step-by-step instructions for downloading, extracting, and setting up each tool.

1. FastQC v0.12.1
```bash
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
unzip fastqc_v0.12.1.zip
chmod +x FastQC/fastqc
./FastQC/fastqc --help
```

2. Samtools v1.21
```bash
wget https://github.com/samtools/samtools/releases/download/1.21/samtools-1.21.tar.bz2
tar -xvjf samtools-1.21.tar.bz2
cd samtools-1.21
./configure
make
./samtools --version
```
Note: You may need to install dependencies. Use the following command:
```bash
sudo apt install libncurses-dev liblzma-dev libbz2-dev libcurl4-openssl-dev
```

3. GATK v4.6.1.0
```bash
wget https://github.com/broadinstitute/gatk/releases/download/4.6.1.0/gatk-4.6.1.0.zip
unzip gatk-4.6.1.0.zip
./gatk-4.6.1.0/gatk --help
```
Java 17 is required:
```bash
sudo apt update
sudo apt install openjdk-17-jdk
```
Optional (if Python issues arise):
```bash
sudo ln -s /usr/bin/python3 /usr/bin/python
```

4. BWA v0.7.17
```bash
wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2
tar -xvjf bwa-0.7.17.tar.bz2
cd bwa-0.7.17
make
./bwa
```

5. IGV v2.19.2
```bash
wget https://data.broadinstitute.org/igv/projects/downloads/2.19/IGV_Linux_2.19.2_WithJava.zip
unzip IGV_Linux_2.19.2_WithJava.zip
chmod +x IGV_2.19.2/igv.sh
./IGV_2.19.2/igv.sh
```

6. Reference Genome (hg38)
```bash
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip hg38.fa.gz
```
Make sure the reference genome is indexed using bwa, samtools, and gatk as per the pipeline steps.

If any file requires executable permissions:
```bash
chmod +x <file_name>
```
---

## Input Requirements

| File Type     | Description                                  |
|---------------|----------------------------------------------|
| `sample_R1.fastq`, `sample_R2.fastq` | Paired-end raw reads |
| `hg38.fa`     | Reference genome in FASTA format              |
| `known sites` (optional) | For base recalibration (if extended) |

---

## Output Summary

| File            | Description                             |
|-----------------|-----------------------------------------|
| `*.bam`         | Aligned, sorted BAM files                |
| `*.bai`         | BAM Index                               |
| `raw.vcf`       | Raw variant calls (mutation calling)     |
| `somatic.vcf`   | Somatic variants (GATK Mutect2 output)   |
| `fastqc/`       | FastQC reports (HTML + zipped data)      |

---

## How to Run

Clone this repository and edit your sample names and paths in the script.
```bash
git clone https://github.com/RoySoumik23/NGS_pipeline.git
cd variant-calling-pipeline
chmod +x variant_pipeline.sh
./variant_pipeline.sh
```

Ensure all required tools are available in your PATH, or modify the script to set tool paths explicitly.

Script Highlights  
Modular and well-commented: Each block is logically structured with informative headers.  
Error-handling and file checks: Prevents overwriting and re-runs.  

IGV Integration: Automatically launches IGV with the aligned BAM and VCF files.

---

## Notes & Best Practices

- Use high-quality reference genomes (e.g., hg38.fa) and consistent annotation sources.  
- For somatic mutation calling in tumor/normal studies, consider matched controls.  
- Always visualize outputs in IGV to cross-check variant calls.

---

## Author

```
Project Context:
This pipeline was developed and delivered as part of my Teaching Assistant (TA) duties for the MTech course on Cancer Genomics and AI/ML applications. The primary objective was to guide postgraduate students through a complete, hands-on bioinformatics workflow — from raw sequencing reads to variant identification — using industry-standard tools and reference datasets.

For a detailed walkthrough of the entire teaching session and pipeline, check out the [presentation here] (https://www.canva.com/design/DAGiDpisKuw/cWGQ3FZ0061D96Ligi2svg/edit?utm_content=DAGiDpisKuw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

Soumik Roy  
M.Tech in Medical BioTech  
Email: [bt23mtech11010.iith.ac.in]  
Computational Genomics And Transcriptomics (CGnT) Lab  
Indian Institute of Technology Hyderabad (IIT H)  
```
