source("../../code/helpers.R")
load("../../data/processed/train_clean.rda")
load("../data/test_with.rda")

submission3
rf <- randomForest(activity~.,data=train,do.trace=T,ntree=750)
p<-predict(rf,test_with)
getAccuracy(p,test_with$activity)
91.25%

submission4
mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                  V452 + V457 + V4 + V167 + V435 + V103 + V127 + V137 + V373 + 
                  V299 + V498 + V38 + V146 + V147 + V177 + V157 + V548 + V248 + 
                  V55 + V56 + V59 + V116 + V36 + V552 + V197, data = train,maxit=2000)
p <- predict(mlr,test_with)
getAccuracy(p,test_with$activity)
90.22%

submission5
source("../../code/exploratory/blend.R")
p <- blend(train,test_with)
getAccuracy(p,test_with$activity)
89.86%

submission6
rf <- randomForest(activity~.,data=train,do.trace=T,ntree=750,mtry=92)
p<-predict(rf,test_with)
getAccuracy(p,test_with$activity)
90.44%
