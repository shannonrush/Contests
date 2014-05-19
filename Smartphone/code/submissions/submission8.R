load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
source("../exploratory/bagging.R")

p<-bagging("rf",7,train,test,ntree=500)
write.table(p,file="submission8.csv",col.names=F,row.names=F)