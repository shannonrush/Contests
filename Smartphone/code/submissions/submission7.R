load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
source("../exploratory/bagging.R")

p<-bagging(5,train,test,0.8,750)
write.table(p,file="submission7.csv",col.names=F,row.names=F)