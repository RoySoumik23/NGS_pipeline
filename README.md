# NGS_pipeline

# 🔬 Variant Calling Bioinformatics Pipeline

This repository contains a complete and modular **shell-scripted bioinformatics pipeline** to process raw NGS data (FASTQ) into interpretable mutation and somatic variant calls (VCF), and finally visualize them in **IGV**. The pipeline integrates industry-standard tools like **FastQC, BWA, Samtools, GATK**, and supports automated execution from start to finish.

---

## 📁 Overview

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

## 🛠️ Tools Used

| Tool      | Version Tested | Description |
|-----------|----------------|-------------|
| `FastQC`  | v0.12.1         | Quality control for raw reads |
| `BWA`     | v0.7.17         | Burrows-Wheeler Aligner for read mapping |
| `Samtools`| v1.21           | Tools for BAM/SAM file manipulation |
| `GATK`    | v4.6.1.0        | Genome Analysis Toolkit for somatic/mutation calling |
| `IGV`     | v2.19.2         | Integrative Genomics Viewer for visualizing variants |

---

## 📂 Input Requirements

| File Type     | Description                                  |
|---------------|----------------------------------------------|
| `sample_R1.fastq`, `sample_R2.fastq` | Paired-end raw reads |
| `hg38.fa`     | Reference genome in FASTA format              |
| `known sites` (optional) | For base recalibration (if extended) |

---

## 📤 Output Summary

| File            | Description                             |
|-----------------|-----------------------------------------|
| `*.bam`         | Aligned, sorted BAM files                |
| `*.bai`         | BAM Index                               |
| `raw.vcf`       | Raw variant calls (mutation calling)     |
| `somatic.vcf`   | Somatic variants (GATK Mutect2 output)   |
| `fastqc/`       | FastQC reports (HTML + zipped data)      |

---

## 🚀 How to Run


Clone this repository and edit your sample names and paths in the script.
```bash
git clone https://github.com/RoySoumik23/NGS_pipeline.git
cd variant-calling-pipeline
chmod +x variant_pipeline.sh
./variant_pipeline.sh
```

### Ensure all required tools are available in your PATH, or modify the script to set tool paths explicitly.

🧪 Script Highlights
Modular and well-commented: Each block is logically structured with informative headers.

Error-handling and file checks: Prevents overwriting and re-runs.

### IGV Integration: Automatically launches IGV with the aligned BAM and VCF files.

## 🧠 Notes & Best Practices
Use high-quality reference genomes (e.g., hg38.fa) and consistent annotation sources.

For somatic mutation calling in tumor/normal studies, consider matched controls.

Always visualize outputs in IGV to cross-check variant calls.

📌 Project Structure
```bash
variant-calling-pipeline/
│
├── variant_pipeline.sh     # Main pipeline script
├── README.md               # This file
├── samples/                # (Optional) FASTQ input data
├── output/                 # All output files
└── logs/                   # Pipeline logs (to be implemented)
```
## 👨‍💻 Author
```
Soumik Roy
M.Tech in Biology, IIT Hyderabad
Dissertation Focus: AI/ML in Cancer Genomics
Email: [bt23mtech11010.iith.ac.in]
GitHub: github.com/RoySoumik23
```
