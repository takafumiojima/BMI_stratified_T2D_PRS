#!/bin/bash

# Making METAL script

echo "# Meta-analysis weighted by standard error does not work well
# because different studies used very different transformations
SCHEME   STDERR
# Not sure if genomic control is a good idea, given the large
# number of true associations in these three regions ...
GENOMICCONTROL OFF
# To help identify allele flips, it can be useful to track
# allele frequencies in the meta-analysis.
AVERAGEFREQ ON
MINMAXFREQ ON
MARKER   	ID_chr_pos
WEIGHT   	OBS_CT
ALLELE   	A1 AX
FREQLABEL     	A1_FREQ
EFFECT   	BETA
STDERRLABEL   	SE
PVALUE     	P
PROCESS group1/BMIsep${n_sep}/GWAS/t1/ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD.chrpos.txt
PROCESS group2/BMIsep${n_sep}/GWAS/t1/ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD.chrpos.txt
PROCESS group3/BMIsep${n_sep}/GWAS/t1/ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD.chrpos.txt
PROCESS group4/BMIsep${n_sep}/GWAS/t1/ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD.chrpos.txt
PROCESS group5/BMIsep${n_sep}/GWAS/t1/ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD.chrpos.txt
OUTFILE META/BMIsep${n_sep}/Meta.Study${n_target}.ChrAll.${SEX}.BMI${num}_${n_sep}.T2D.logistic.ADD. txt
ANALYZE HETEROGENEITY " \
> tmp.${n_target}.${SEX}.BMI${num}_${n_sep}.txt

# Leave-One-Group-Out
grep -v group${n_target} tmp.${n_target}.${SEX}.BMI${num}_${n_sep}.txt \
> metal.target${n_target}.${SEX}.BMI${num}_${n_sep}.txt
rm tmp.${n_target}.${SEX}.BMI${num}_${n_sep}.txt

# perform METAL
generic-metal/metal metal.target${n_target}.${SEX}.BMI${num}_${n_sep}.txt

