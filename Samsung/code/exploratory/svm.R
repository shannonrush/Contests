source("../helpers.R")
load("../../data/processed/train_clean.rda")
load("../../data/processed/test_clean.rda")
set.seed(335)
library(e1071)

svm <- svm(activity~.,data=train)
p<-predict(svm,test)
getAccuracy(p,test$activity)
95.82%

tune <- tune.svm(activity~.,data=train)
tune.svm <- svm(activity~.,data=train,gamma=0.001779359)
p<-predict(tune.svm,test)
getAccuracy(p,test$activity)
95.82%
           
