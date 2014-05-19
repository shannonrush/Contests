source("../helpers.R")

load("~/Contests/Smartphone/data/processed/train_clean.rda")
load("~/Contests/Smartphone/original/data/test_with.rda")
set.seed(335)

p <- samme(activity~.,train,test_with,3,ntree=5)

p3 <- samme(activity~.,train,train$activity,test_with,3,trace=F)
getAccuracy(p3,test_with$activity)

p5 <- samme(activity~.,train,train$activity,test_with,5,trace=F)
getAccuracy(p5,test_with$activity)

p7 <- samme(activity~.,train,train$activity,test_with,7,trace=F)
getAccuracy(p7,test_with$activity)

p9 <- samme(activity~.,train,train$activity,test_with,9,trace=F)
getAccuracy(p9,test_with$activity)

p11 <- samme(activity~.,train,train$activity,test_with,11,trace=F)
getAccuracy(p11,test_with$activity)

p13 <- samme(activity~.,train,train$activity,test_with,13,trace=F)
getAccuracy(p13,test_with$activity)

p15 <- samme(activity~.,train,train$activity,test_with,15,trace=F)
getAccuracy(p15,test_with$activity)

p17 <- samme(activity~.,train,train$activity,test_with,17)
getAccuracy(p17,test_with$activity)

p19 <- samme(activity~.,train,train$activity,test_with,19)
getAccuracy(p19,test_with$activity)

p21 <- samme(activity~.,train,train$activity,test_with,21)
getAccuracy(p21,test_with$activity)

p23 <- samme(activity~.,train,train$activity,test_with,23)
getAccuracy(p23,test_with$activity)

p25 <- samme(activity~.,train,train$activity,test_with,25)
getAccuracy(p25,test_with$activity)

p27 <- samme(activity~.,train,train$activity,test_with,27)
getAccuracy(p27,test_with$activity)

p29 <- samme(activity~.,train,train$activity,test_with,29)
getAccuracy(p29,test_with$activity)

p31 <- samme(activity~.,train,train$activity,test_with,31)
getAccuracy(p31,test_with$activity)

p33 <- samme(activity~.,train,train$activity,test_with,33)
getAccuracy(p33,test_with$activity)

p35 <- samme(activity~.,train,train$activity,test_with,35)
getAccuracy(p35,test_with$activity)

p37 <- samme(activity~.,train,train$activity,test_with,37)
getAccuracy(p37,test_with$activity)

p39 <- samme(activity~.,train,train$activity,test_with,39, trace=F)
getAccuracy(p39,test_with$activity)

p59 <- samme(activity~.,train,train$activity,test_with,59, trace=F)
getAccuracy(p59,test_with$activity)