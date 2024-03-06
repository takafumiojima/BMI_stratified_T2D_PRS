
# Lee SH et al. Genet Epidemiol 2012 
# Peyrot WJ et al. Mol Psych 2015
# P: case fraction, K: population-level prevalance

library(tidyverse)

P = ncase / nt
thd = -qnorm(K,0,1)
zv = dnorm(thd)
mv = zv/K
theta = mv*(P-K)/(1-K)*(mv*(P-K)/(1-K)-thd)
cv = K*(1-K)/zv^2*K*(1-K)/(P*(1-P))

null.model <- glm(T2D~., data=merge_all[,!colnames(merge_all)%in%c("PRS")], family = binomial(logit),maxit=100)
model <- glm(T2D~., data=merge_all,family = binomial(logit),maxit=100)
Lm.null = null.model$deviance/(-2)
Lm = model$deviance/(-2)

R2O = 1-(exp((2/nt)*(Lm.null[1]-Lm[1])))
(liabilityR2 = R2O*cv/(1+R2O*theta*cv))
