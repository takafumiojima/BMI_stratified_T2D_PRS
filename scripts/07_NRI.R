# Net reclassification index analysis

library(tidyverse)
library(PredictABEL)

####################################################
# define functions

PredNRI_ta = function (data, cOutcome, predrisk1, predrisk2, cutoff){
  c1 <- cut(predrisk1, breaks = cutoff, include.lowest = TRUE,
            right = FALSE)
  c2 <- cut(predrisk2, breaks = cutoff, include.lowest = TRUE,
            right = FALSE)
  tabReclas <- table(`Initial Model` = c1, `Updated Model` = c2)
  cat(" _________________________________________\n")
  cat(" \n     Reclassification table    \n")
  cat(" _________________________________________\n")
  ta <- table(c1, c2, data[, cOutcome])
  cat("\n Outcome: absent \n  \n")
  TabAbs <- ta[, , 1]
  tab1 <- cbind(TabAbs, ` % reclassified` = round((rowSums(TabAbs) -
                                                     diag(TabAbs))/rowSums(TabAbs), 2) * 100)
  names(dimnames(tab1)) <- c("Initial Model", "Updated Model")
  print(tab1)
  cat("\n \n Outcome: present \n  \n")
  TabPre <- ta[, , 2]
  tab2 <- cbind(TabPre, ` % reclassified` = round((rowSums(TabPre) -
                                                     diag(TabPre))/rowSums(TabPre), 2) * 100)
  names(dimnames(tab2)) <- c("Initial Model", "Updated Model")
  print(tab2)
  cat("\n \n Combined Data \n  \n")
  Tab <- tabReclas
  tab <- cbind(Tab, ` % reclassified` = round((rowSums(Tab) -
                                                 diag(Tab))/rowSums(Tab), 2) * 100)
  names(dimnames(tab)) <- c("Initial Model", "Updated Model")
  print(tab)
  cat(" _________________________________________\n")
  c11 <- factor(c1, levels = levels(c1), labels = c(1:length(levels(c1))))
  c22 <- factor(c2, levels = levels(c2), labels = c(1:length(levels(c2))))
  x <- improveProb(x1 = as.numeric(c11) * (1/(length(levels(c11)))),
                   x2 = as.numeric(c22) * (1/(length(levels(c22)))), y = data[,
                                                                              cOutcome])
  y <- improveProb(x1 = predrisk1, x2 = predrisk2, y = data[,
                                                            cOutcome])
  cat("\n NRI(Categorical) [95% CI]:", round(x$nri, 4), "[",
      round(x$nri - 1.96 * x$se.nri, 4), "-", round(x$nri +
                                                      1.96 * x$se.nri, 4), "]", "; p-value:", round(2 *
                                                                                                      pnorm(-abs(x$z.nri)), 5), "\n")
  cat(" NRI(Continuous) [95% CI]:", round(y$nri, 4), "[", round(y$nri -
                                                                  1.96 * y$se.nri, 4), "-", round(y$nri + 1.96 * y$se.nri,
                                                                                                  4), "]", "; p-value:", round(2 * pnorm(-abs(y$z.nri)),
                                                                                                                               5), "\n")
  cat(" IDI [95% CI]:", round(y$idi, 4), "[", round(y$idi -
                                                      1.96 * y$se.idi, 4), "-", round(y$idi + 1.96 * y$se.idi,
                                                                                      4), "]", "; p-value:", round(2 * pnorm(-abs(y$z.idi)),
                                                                                                                   5), "\n")
  (out = data.frame(NRI = x$nri, NRI_SE = x$se.nri,
                    contNRI = y$nri, contNRI_SE = y$se.nri,
                    N_all = x$n, N_case = x$na, N_ctrl = x$nb))
  ta
}
environment(PredNRI_ta) = environment(PredictABEL::reclassification)

PredNRI = function (data, cOutcome, predrisk1, predrisk2, cutoff){
  c1 <- cut(predrisk1, breaks = cutoff, include.lowest = TRUE,
            right = FALSE)
  c2 <- cut(predrisk2, breaks = cutoff, include.lowest = TRUE,
            right = FALSE)
  tabReclas <- table(`Initial Model` = c1, `Updated Model` = c2)
  cat(" _________________________________________\n")
  cat(" \n     Reclassification table    \n")
  cat(" _________________________________________\n")
  ta <- table(c1, c2, data[, cOutcome])
  cat("\n Outcome: absent \n  \n")
  TabAbs <- ta[, , 1]
  tab1 <- cbind(TabAbs, ` % reclassified` = round((rowSums(TabAbs) -
                                                     diag(TabAbs))/rowSums(TabAbs), 2) * 100)
  names(dimnames(tab1)) <- c("Initial Model", "Updated Model")
  print(tab1)
  cat("\n \n Outcome: present \n  \n")
  TabPre <- ta[, , 2]
  tab2 <- cbind(TabPre, ` % reclassified` = round((rowSums(TabPre) -
                                                     diag(TabPre))/rowSums(TabPre), 2) * 100)
  names(dimnames(tab2)) <- c("Initial Model", "Updated Model")
  print(tab2)
  cat("\n \n Combined Data \n  \n")
  Tab <- tabReclas
  tab <- cbind(Tab, ` % reclassified` = round((rowSums(Tab) -
                                                 diag(Tab))/rowSums(Tab), 2) * 100)
  names(dimnames(tab)) <- c("Initial Model", "Updated Model")
  print(tab)
  cat(" _________________________________________\n")
  c11 <- factor(c1, levels = levels(c1), labels = c(1:length(levels(c1))))
  c22 <- factor(c2, levels = levels(c2), labels = c(1:length(levels(c2))))
  x <- improveProb(x1 = as.numeric(c11) * (1/(length(levels(c11)))),
                   x2 = as.numeric(c22) * (1/(length(levels(c22)))), y = data[,
                                                                              cOutcome])
  y <- improveProb(x1 = predrisk1, x2 = predrisk2, y = data[,
                                                            cOutcome])
  cat("\n NRI(Categorical) [95% CI]:", round(x$nri, 4), "[",
      round(x$nri - 1.96 * x$se.nri, 4), "-", round(x$nri +
                                                      1.96 * x$se.nri, 4), "]", "; p-value:", round(2 *
                                                                                                      pnorm(-abs(x$z.nri)), 5), "\n")
  cat(" NRI(Continuous) [95% CI]:", round(y$nri, 4), "[", round(y$nri -
                                                                  1.96 * y$se.nri, 4), "-", round(y$nri + 1.96 * y$se.nri,
                                                                                                  4), "]", "; p-value:", round(2 * pnorm(-abs(y$z.nri)),
                                                                                                                               5), "\n")
  cat(" IDI [95% CI]:", round(y$idi, 4), "[", round(y$idi -
                                                      1.96 * y$se.idi, 4), "-", round(y$idi + 1.96 * y$se.idi,
                                                                                      4), "]", "; p-value:", round(2 * pnorm(-abs(y$z.idi)),
                                                                                                                   5), "\n")
  (out = data.frame(NRI = x$nri, NRI_SE = x$se.nri,
                    contNRI = y$nri, contNRI_SE = y$se.nri,
                    N_all = x$n, N_case = x$na, N_ctrl = x$nb))
  out
}
environment(PredNRI) = environment(PredictABEL::reclassification)

####################################################
# calcculate P value of NRI

# preparing
(merge_high = read_tsv("merge_high.txt"))
(merge_low = read_tsv("merge_low.txt"))

(full_data_h_all = data.frame(IID=NA,pheno=NA,pred_full=NA,pred_null=NA))
(full_data_l_all = data.frame(IID=NA,pheno=NA,pred_full=NA,pred_null=NA))

sex = "BothSEX"

# high BMI target
(full_data_h = merge_high %>% select(IID,pheno=T2D,SCORE1_SUM=PRS,everything()))
(model_h <- glm(pheno~., data=full_data_h[,!colnames(full_data_h)%in%c("IID")],family = binomial(logit),maxit=100))
(null_model_h <- glm(pheno~., data=full_data_h[,!colnames(full_data_h)%in%c("IID","SCORE1_SUM")],family = binomial(logit),maxit=100))
(full_data_h_2 = full_data_h %>% select(IID,pheno))
(full_data_h_2$pred_full = rank(model_h$fitted.values)/dim(full_data_h_2)[1])
(full_data_h_2$pred_null = rank(null_model_h$fitted.values)/dim(full_data_h_2)[1])
(full_data_h_all = bind_rows(full_data_h_all,full_data_h_2))
# low BMI target
(full_data_l = merge_low %>% select(IID,pheno=T2D,SCORE1_SUM=PRS,everything()))
(model_l <- glm(pheno~., data=full_data_l[,!colnames(full_data_l)%in%c("IID")],family = binomial(logit),maxit=100))
(null_model_l <- glm(pheno~., data=full_data_l[,!colnames(full_data_l)%in%c("IID","SCORE1_SUM")],family = binomial(logit),maxit=100))
(full_data_l_2 = full_data_l %>% select(IID,pheno))
(full_data_l_2$pred_full = rank(model_l$fitted.values)/dim(full_data_l_2)[1])
(full_data_l_2$pred_null = rank(null_model_l$fitted.values)/dim(full_data_l_2)[1])
(full_data_l_all = bind_rows(full_data_l_all,full_data_l_2))


# calculate NRI
(cutoff = c(0,0.7692308,1))

(result_l = PredNRI(data=as.data.frame(full_data_l_all),cOutcome=2,
                    predrisk1=full_data_l_all$pred_null,predrisk2=full_data_l_all$pred_full,
                    cutoff=cutoff))
(result_h = PredNRI(data=as.data.frame(full_data_h_all),cOutcome=2,
                    predrisk1=full_data_h_all$pred_null,predrisk2=full_data_h_all$pred_full,
                    cutoff=cutoff))

# Z test
(Z_NRI = (result_l$NRI - result_h$NRI)/sqrt(result_l$NRI_SE^2 + result_h$NRI_SE^2) )
(P_NRI = 2*pnorm(Z_NRI,lower.tail = F))
(Z_contNRI = (result_l$contNRI - result_h$contNRI)/sqrt(result_l$contNRI_SE^2 + result_h$contNRI_SE^2) )
(P_contNRI = 2*pnorm(Z_contNRI,lower.tail = F))
(P_out = data.frame(P_NRI=P_NRI,P_contNRI=P_contNRI))
write_tsv(P_out,"P_NRI.txt")



####################################################
# output NRI results

(ta_l = PredNRI_ta(data=as.data.frame(full_data_l_all),cOutcome=2,
                   predrisk1=full_data_l_all$pred_null,predrisk2=full_data_l_all$pred_full,
                   cutoff=cutoff))
(ta_h = PredNRI_ta(data=as.data.frame(full_data_h_all),cOutcome=2,
                   predrisk1=full_data_h_all$pred_null,predrisk2=full_data_h_all$pred_full,
                   cutoff=cutoff))
# low BMI
(ta_l_ctrl = ta_l[,,1])
(rownames(ta_l_ctrl) = c("TN","FP"))
(colnames(ta_l_ctrl) = c("TN","FP"))
(tibble_l_ctrl = as.data.frame(ta_l_ctrl) %>% 
    rownames_to_column())
(ta_l_case = ta_l[,,2])
(rownames(ta_l_case) = c("FN","TP"))
(colnames(ta_l_case) = c("FN","TP"))
(tibble_l_case = as.data.frame(ta_l_case) %>% 
    rownames_to_column())

(Num_l = bind_rows(tibble_l_ctrl,tibble_l_case) %>% 
    mutate(BMIsep = "low") %>% 
    select(BMIsep,Null_Model=c1,Full_Model=c2,value=Freq))
# high BMI
(ta_h_ctrl = ta_h[,,1])
(rownames(ta_h_ctrl) = c("TN","FP"))
(colnames(ta_h_ctrl) = c("TN","FP"))
(tibble_h_ctrl = as.data.frame(ta_h_ctrl) %>% 
    rownames_to_column())
(ta_h_case = ta_h[,,2])
(rownames(ta_h_case) = c("FN","TP"))
(colnames(ta_h_case) = c("FN","TP"))
(tibble_h_case = as.data.frame(ta_h_case) %>% 
    rownames_to_column())

(Num_h = bind_rows(tibble_h_ctrl,tibble_h_case) %>% 
    mutate(BMIsep = "high") %>% 
    select(BMIsep,Null_Model=c1,Full_Model=c2,value=Freq))

# bind & output
(out_table = bind_rows(Num_l,Num_h))
write_tsv(out_table,"NRI_num_hl.txt")

# make result tables
sink("NRI_hl_table.txt")
print("c1=null, c2=full")
print("----------------------")
print("BMI_L")
ta_l_ctrl
ta_l_case
print("----------------------")
print("BMI_H")
ta_h_ctrl
ta_h_case
sink()
