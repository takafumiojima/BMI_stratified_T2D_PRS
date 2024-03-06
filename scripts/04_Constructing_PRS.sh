#!/bin/bash

plink2 \
  --memory 4000 \
  --threads 1 \
  --pfile ${prefix_pgen} \
  --score chrpos.A1.PRScs.${POP}.${SEX}.BMI${num_s}_${n_sep}.txt 1 2 3 cols=scoresums \
  --pheno ${DIR_Target}/T2Dpheno.${BioBank}.${SEX}.BMI${num_t}_${n_sep}.t1.txt --pheno-name T2Dpheno \
  --allow-no-sex \
  --out ./sscore/${BioBank}.${POP}.${SEX}.BMI${num_s}to${num_t}_sep${n_sep}.t1.chr${num_chr}


