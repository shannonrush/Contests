source("boosting.R")
load("../../data/processed/train_clean.rda")
load("../../original/data/test_with.rda")

p3 <- boosting(3,train,test_with)
getAccuracy(p3,test_with$activity)
91.32%

p3 <- boosting(activity~.,train,train$activity,test_with,3)
getAccuracy(p3,test_with$activity)
91.39%

p5 <- boosting(5,train,test_with)
getAccuracy(p5,test_with$activity)
91.34%

p7 <- boosting(7,train,test_with)
getAccuracy(p7,test_with$activity)
91.27%

p9 <- boosting(9,train,test_with)
getAccuracy(p9,test_with$activity)
91.41%

p11 <- boosting(11,train,test_with)
getAccuracy(p11,test_with$activity)
91.18%

p13 <- boosting(13,train,test_with)
getAccuracy(p13,test_with$activity)
91.32%

p15 <- boosting(15,train,test_with)
getAccuracy(p15,test_with$activity)
91.7%

p17 <- boosting(17,train,test_with)
getAccuracy(p17,test_with$activity)
91.37%

p19 <- boosting(19,train,test_with)
getAccuracy(p19,test_with$activity)
91.44%

p21 <- boosting(21,train,test_with)
getAccuracy(p21,test_with$activity)
91.44%

p23 <- boosting(23,train,test_with)
getAccuracy(p23,test_with$activity)
91.58%

p25 <- boosting(25,train,test_with)
getAccuracy(p25,test_with$activity)
91.87%

p27 <- boosting(27,train,test_with)
getAccuracy(p27,test_with$activity)
91.87%

p29 <- boosting(29,train,test_with)
getAccuracy(p29,test_with$activity)
91.7%

p31 <- boosting(31,train,test_with)
getAccuracy(p31,test_with$activity)
91.58%

p33 <- boosting(activity~.,train,train$activity,test_with,33,trace=F)
getAccuracy(p33,test_with$activity)
91.7%

p35 <- boosting(activity~.,train,train$activity,test_with,35,trace=F)
getAccuracy(p35,test_with$activity)
91.84%

p37 <- boosting(activity~.,train,train$activity,test_with,37,trace=F)
getAccuracy(p37,test_with$activity)
91.7%

p39 <- boosting(activity~.,train,train$activity,test_with,39,trace=F)
getAccuracy(p39,test_with$activity)
91.75%

==== RF ETC
  
p27 <- boosting(27,train,test_with,ntree=750)
getAccuracy(p27,test_with$activity)
91.68%

p27 <- boosting(27,train,test_with,ntree=350)
getAccuracy(p27,test_with$activity)
91.63%


