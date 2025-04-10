# NGS Pipeline - Individual Scripts

This folder contains various supplementary scripts to support different steps of the NGS pipeline. These scripts provide flexibility for specific tasks but are not required for the complete pipeline execution. The full pipeline execution should be managed through the `whole_pipeline.sh` script located in the root directory of this repository.

## Scripts Overview

1. **addreadgroups2.sh**  
   Script for adding read groups to BAM files. *(Not necessary as the read group is added during the BWA alignment step.)*

2. **fastqc.sh**  
   Runs quality control checks on raw reads using FastQC.

3. **mutation_calling2.sh**  
   Performs mutation calling on aligned reads with additional customization.

4. **somatic_calling.sh**  
   Calls somatic variants from tumor-normal pair data using GATK Mutect2 or Strelka.

5. **addreadgroups.sh**  
   Similar to `addreadgroups2.sh`, but not required as read group addition is handled during the alignment step.

6. **gatk_dict.sh**  
   Generates a sequence dictionary for the reference genome (required for GATK).

7. **mutation_calling.sh**  
   Calls mutations using `samtools mpileup` and `bcftools`.

8. **sorting2.sh**  
   Sorts BAM files using `samtools sort` with additional options.

9. **alignment2.sh**  
   Aligns reads to the reference genome using BWA (for paired-end data).

10. **indexbam2.sh**  
    Creates an index for the BAM file using `samtools index`.

11. **samtobam2.sh**  
    Converts SAM files to BAM format using `samtools view`.

12. **sorting.sh**  
    A general script for sorting BAM files with `samtools sort`.

13. **alignment.sh**  
    Aligns reads to the reference genome using BWA (for single-end data).

14. **indexbam.sh**  
    Creates an index for the BAM file using `samtools index`.

15. **fastp.sh**  
    Performs fast and high-quality trimming of raw reads with fastp.

16. **indexing.sh**  
    Generates the index files for the reference genome using `samtools faidx` and `bwa index`.

17. **somatic_calling2.sh**  
    Another script for somatic variant calling, specifically designed for tumor-normal pair data.

---

## How to Use

These scripts can be executed individually for specific tasks or used in combination depending on your needs. However, to run the full pipeline from start to finish, refer to the `whole_pipeline.sh` script located in the main directory.

The `whole_pipeline.sh` script will call all necessary steps sequentially, ensuring that the entire NGS analysis workflow is performed correctly.

---
