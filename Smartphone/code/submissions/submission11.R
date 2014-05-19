load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
source("../exploratory/boosting.R")

p<-boosting(15,train,test)
write.table(p,file="submission11.csv",col.names=F,row.names=F)