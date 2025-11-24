# ldscore
LD Score regression analysis.<br />
ref: Bulik-Sullivan, et al. LD Score Regression Distinguishes Confounding from Polygenicity in Genome-Wide Association Studies. Nature Genetics, 2015.

## Getting started

* git clone https://github.com/ht-diva/pqtl_ldscore.git
* cd pqtl_ldscore
* adapt the [submit.sbatch](submit.sbatch) and [config/config.yaml](config/config.yaml) files to your environment
* sbatch submit.sbatch

## LDSC Heritability Pipeline

This repository contains a Snakemake workflow for performing LD Score Regression (LDSC) on GWAS summary statistics.
The pipeline generates LD scores, processes summary statistics, runs heritability analyses, and merges results into a final summary file.

1. LD Score Generation
    * Compute LD scores for each chromosome using reference genotype data (BED/BIM/FAM files).
    * These LD scores quantify the amount of linkage disequilibrium around each SNP and are essential for LDSC.
2. Append P‑values
    * Since LDSC requires the actual p‑value, you need to reconstruct it from the –log10(p) column.
3. Munge Summary Statistics
    * Standardize the GWAS summary statistics using LDSC’s munge_sumstats.py.
    * This step ensures consistent column names and formats (alleles, frequencies, SNP IDs, sample size, and the new P column).
    * Produces a cleaned .sumstats.gz file ready for LDSC analysis.
4. LDSC Heritability Estimation
    * Run LDSC regression using the munged summary statistics and the LD scores.
    * Estimates SNP‑heritability (h²), genomic inflation (λGC), mean chi‑square, and intercept values.
    * Outputs a log file (*_h2.log) with these key metrics for each dataset.
5. Merge Heritability Outputs
    * Collect all individual heritability log files across datasets.
    * Extract relevant statistics (h², λGC, mean χ², intercept).
    * Combine them into a single summary table (heritability_info.txt) for easy comparison and downstream interpretation.
