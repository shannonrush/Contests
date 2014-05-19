load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
library(randomForest)

rf <- randomForest(activity~.,data=train,do.trace=T,ntree=750)
p<-predict(rf,test)

write.table(p,file="submission3.csv",col.names=F,row.names=F)