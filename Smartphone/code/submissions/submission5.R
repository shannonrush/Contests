source("../../code/exploratory/blend.R")
load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
p <- blend(train,test)

write.table(p,file="submission5.csv",col.names=F,row.names=F)