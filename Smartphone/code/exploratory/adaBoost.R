source("../helpers.R")
source("adaBoosting.R")
load("../../data/processed/train_clean.rda")
load("../../original/data/test_with.rda")

p3 <- samme(activity~.,train,train$activity,test_with,3)
getAccuracy(p3,test_with$activity)
91.32%

p5 <- samme(activity~.,train,train$activity,test_with,5)
getAccuracy(p5,test_with$activity)
91.39%

p7 <- samme(activity~.,train,train$activity,test_with,7)
getAccuracy(p7,test_with$activity)
91.65%

p9 <- samme(activity~.,train,train$activity,test_with,9)
getAccuracy(p9,test_with$activity)
91.44%

p11 <- samme(activity~.,train,train$activity,test_with,11)
getAccuracy(p11,test_with$activity)
91.94%

p13 <- samme(activity~.,train,train$activity,test_with,13)
getAccuracy(p13,test_with$activity)
92.08%

p15 <- samme(activity~.,train,train$activity,test_with,15)
getAccuracy(p15,test_with$activity)
91.58%

p17 <- samme(activity~.,train,train$activity,test_with,17)
getAccuracy(p17,test_with$activity)
91.89%

p19 <- samme(activity~.,train,train$activity,test_with,19)
getAccuracy(p19,test_with$activity)
92.58%

p21 <- samme(activity~.,train,train$activity,test_with,21)
getAccuracy(p21,test_with$activity)
91.82%

p23 <- samme(activity~.,train,train$activity,test_with,23)
getAccuracy(p23,test_with$activity)
92.58%

p25 <- samme(activity~.,train,train$activity,test_with,25)
getAccuracy(p25,test_with$activity)
92.08%

p27 <- samme(activity~.,train,train$activity,test_with,27)
getAccuracy(p27,test_with$activity)
92.42%

p29 <- samme(activity~.,train,train$activity,test_with,29)
getAccuracy(p29,test_with$activity)
92.25%

p31 <- samme(activity~.,train,train$activity,test_with,31)
getAccuracy(p31,test_with$activity)
91.82%

p33 <- samme(activity~.,train,train$activity,test_with,33)
getAccuracy(p33,test_with$activity)
92.44%

p35 <- samme(activity~.,train,train$activity,test_with,35)
getAccuracy(p35,test_with$activity)
92.58%

p37 <- samme(activity~.,train,train$activity,test_with,37)
getAccuracy(p37,test_with$activity)
92.89%

p39 <- samme(activity~.,train,train$activity,test_with,39)
getAccuracy(p39,test_with$activity)
92.54%