#!/bin/bash

plink2 --memory 3500 --threads 1 \
  --pfile ${Path_UKBB}/ukb_imp_${Chr_519}_v3.maf0.001.chrpos \
  --keep ID_Y_${SEX}_DMCC.BMI${num}_${n_sep}_t1.txt \
  --pheno T2Dpheno.UKBB.${SEX}.BMI${num}_${n_sep}.t1.txt --pheno-name T2Dpheno \
  --logistic cols=chrom,pos,ref,alt,ax,a1freq,a1freqcc,firth,test,nobs,beta,orbeta,se,ci,tz,p,err hide-covar \
  --ci 0.95 --allow-no-sex \
  --covar cover.${SEX}.BMI${num}_${n_sep}.t1.txt \
  --covar-col-nums 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 \
  --covar-variance-standardize \
  --vif 10000 \
  --extract ${Path_variant_QC} \
  --out ./GWAS/t1/${Chr_519}.logi.UKBB_test_DM.${SEX}.BMI${num}_${n_sep}

