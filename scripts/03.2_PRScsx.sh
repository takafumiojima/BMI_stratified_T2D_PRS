#!/bin/bash

source ${Path_PRScs_Conda}/PRScs/bin/activate

python ${Path_PRScs}/PRScsx.py \
    --ref_dir=${Path_ref} \
    --bim_prefix=${Path_bim_prefix}/prefix \
    --sst_file=UKBB.sst.txt,BBJ.sst.txt \
    --n_gwas=${n_sample_UKBB},${n_sample_BBJ} \
    --pop=EUR,EAS \
    --meta=TRUE \
    --chrom=${num_chr}
    --out_dir=${Path_out} \
    --out_name=${SEX}.BMI${nn}_${n_sep}.PRScsx
