# Softwares/Tools

This folder contains the software tools required for the NGS pipeline. The tools mentioned here are critical for aligning reads, performing variant calling, and other essential tasks. Below is the list of tools, along with installation and usage instructions.

## Tools Overview

1. **BWA (Burrows-Wheeler Aligner)**  
   BWA is used for aligning sequencing reads against a reference genome.  
   - **Version**: 0.7.17  
   - **Installation**:
     ```bash
     sudo apt-get update
     sudo apt-get install bwa
     ```

2. **Samtools**  
   A suite of utilities for interacting with SAM/BAM files, including sorting, indexing, and variant calling.  
   - **Version**: 1.21  
   - **Installation**:
     ```bash
     sudo apt-get install samtools
     ```

3. **GATK (Genome Analysis Toolkit)**  
   GATK is used for variant discovery and analysis. It offers various tools for variant calling, quality control, and data preprocessing.  
   - **Version**: 4.6.1.0  
   - **Installation**:
     Download the latest GATK release from [GATK official site](https://gatk.broadinstitute.org/hc/en-us/articles/360035531132).  
     Follow the installation guide for your operating system.

4. **Strelka (Alternative to GATK)**  
   Strelka is used for somatic variant calling, particularly with tumor-normal data.  
   - **Version**: 2.9.10  
   - **Installation**:
     ```bash
     wget https://github.com/Illumina/strelka/releases/download/v2.9.10/strelka-2.9.10.centos6_x86_64.tar.gz
     tar -xvzf strelka-2.9.10.centos6_x86_64.tar.gz
     cd strelka-2.9.10.centos6_x86_64
     ```
     Since Strelka requires Python 2, you need to install Python 2 first.  
     To configure Strelka, use the following command:
     ```bash
     python2 /home3/workshop/strelka-2.9.10.centos6_x86_64/bin/configureStrelkaSomaticWorkflow.py
     ```
5. **BWA Index**  
   BWA Index is used to index reference genomes, enabling fast read alignment.  
   - **Installation**:  
     BWA is installed as part of the BWA package, so once you install BWA, the index tool will be available.

---

## Recommended Environment

- **Operating System**: Linux (Ubuntu, CentOS, or similar)
- **Dependencies**:
  - Python 2 (for Strelka)
  - Java (for GATK and Picard)
  - SAMtools and BWA
  - Required environment paths must be set correctly for tools like GATK and Strelka to work.

---

## Usage

Each tool is called within the pipeline scripts according to the sequence of operations required for NGS data processing. Typically, tools such as BWA and FastQC will be executed in the early stages of the pipeline for read alignment and quality assessment, while tools like GATK and Strelka will be used later for variant calling.

For complete execution, refer to the `whole_pipeline.sh` script, which coordinates the execution of the tools in the correct sequence.

---

## Troubleshooting

- **Missing dependencies**: Ensure that the correct versions of Python, Java, and other required libraries are installed.
- **Environment variables**: Ensure that all tool paths are correctly set in your environment, especially for Java and Python-based tools like GATK and Strelka.

---
