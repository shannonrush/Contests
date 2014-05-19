load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
source("../exploratory/bagging.R")

p<-bagging("rf",11,train,test)
write.table(p,file="submission10.csv",col.names=F,row.names=F)
