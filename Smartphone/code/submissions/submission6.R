load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
library(randomForest)

rf <- randomForest(activity~.,data=train,do.trace=T,ntree=750,mtry=92)
pr<-predict(rf,test)

write.table(pr,file="submission6.csv",col.names=F,row.names=F)