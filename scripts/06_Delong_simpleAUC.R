# Delong's unpaired test of simple model AUC
# Robin, X. et al. pROC: An open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics 12, (2011).
# Delong, E. R., Delong, D. M. & Clarke-Pearson, D. L. Comparing the Areas under Two or More Correlated Receiver Operating Characteristic Curves: A Nonparametric Approach. Biometrics 44, 837–845 (1988).

library(tidyverse)
library(pROC)

(merge_low = rerad_tsv("merge_low.txt"))
(merge_high = rerad_tsv("merge_high.txt"))

(model_l = glm(T2D~., data=merge_low %>% select(PRS,T2D),family = binomial(logit),maxit=100))
(model_h = glm(T2D~., data=merge_high %>% select(PRS,T2D),family = binomial(logit),maxit=100))
(ROC_l = roc(model_l$y,model_l$fitted.values) )
(ROC_h = roc(model_h$y,model_h$fitted.values) )
(res_test = roc.test(ROC_l,ROC_h))
(p_val = res_test$p.value)
