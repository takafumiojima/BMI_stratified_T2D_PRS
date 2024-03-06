#!/bin/bash

source ${Path_PRScs_Conda}/PRScs/bin/activate

python ${Path_PRScs}/PRScs.py \
    --ref_dir=${Path_ref}/Ref_PRScs/ldblk_1kg_eur \
    --bim_prefix=${Path_bim_prefix}/prefix \
    --sst_file=${sstPRScs} \
    --n_gwas=${n_sample} \
    --out_dir=${Path_out}/group${num_group}/BMIsep${n_sep}/PRScs/${SEX}.BMI${nn}_${n_sep}.PRScs
