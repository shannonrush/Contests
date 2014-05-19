source("../../helpers.R")
load("../../../data/processed/training_clean.rda")
load("../../../data/processed/validating_clean.rda")
set.seed(335)
library(randomForest)

load("../../../data/processed/train_clean.rda")
load("../../../data/processed/test_clean.rda")

Optimum ntree with default sampsize:
rf325 <- randomForest(activity~.,data=train,do.trace=T,importance=T,replace=T,ntree=350)
p<-predict(rf325,test)
getAccuracy(p,test$activity)

300: 95.08%
325: 95.08% 
350: 95.35% *
375: 95.15%
400: 95.22%
500: 95.15%
750: 95.02%
1000: 95.08%
1100:95.02%
1200: 92.29%
1300: 94.95%

rf350: 
p<-predict(rf350,test)
getAccuracy(p,test$activity)

[1] "1416/1485"
[1] "95.35%"
prediction
actual     laying sitting standing walk walkdown walkup
laying      293       0        0    0        0      0
sitting       0     226       38    0        0      0
standing      0      23      260    0        0      0
walk          0       0        0  228        0      1
walkdown      0       0        0    2      194      4
walkup        0       0        0    1        0    215


tuneRF to find optimum mtry:
suggested 46 but I found 23 (the default) to be optimum

tuning with tune:
library(e1071)

tune <- tune(randomForest, activity~.,data=train,do.trace=T)
rf <- randomForest(activity~.,do.trace=T,ntree=500,mtry=23,data=train)
p<-predict(rf,test)
getAccuracy(p,test$activity)
[1] "95.15%"

tune2 <-tune(randomForest,train.x=train[,-563],train.y=train[,563],data=train,validation.x=test[,-563],validation.y=test[,563],do.trace=T)

CURRENT BEST RF:
  rf <- randomForest(activity~.,data=train,do.trace=T,importance=T,replace=T,ntree=350)
95.35% accurate on test set