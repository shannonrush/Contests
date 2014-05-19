load("../../data/processed/training.rda")
load("../../data/processed/test.rda")
set.seed(335)
library(e1071)

svm <- svm(activity~.,data=training)
p <- predict(svm,test)

write.table(p,file="submission1.csv",col.names=F,row.names=F)
