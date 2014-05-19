load("../../data/processed/train_clean.rda")
load("../../original/data/test_with.rda")
source("bagging.R")

# RF

p5<-bagging("rf",5,train,test_with,percent=1,ntree=500)
getAccuracy(p5,test_with$activity)
91.06%

p7<-bagging("rf",7,train,test_with,percent=1,ntree=500)
getAccuracy(p7,test_with$activity)
90.63%

p9<-bagging("rf",9,train,test_with,percent=1,ntree=500)
getAccuracy(p9,test_with$activity)
90.79%

p11<-bagging("rf",11,train,test_with,ntree=500,percent=1)
getAccuracy(p11,test_with$activity)
90.75%

p13<-bagging("rf",13,train,test_with,ntree=500,percent=1)
getAccuracy(p13,test_with$activity)
90.65%

p15<-bagging("rf",15,train,test_with,ntree=500,percent=1)
getAccuracy(p15,test_with$activity)
90.65%

p17<-bagging("rf",17,train,test_with,ntree=500,percent=1)
getAccuracy(p17,test_with$activity)
90.44%

p19<-bagging("rf",19,train,test_with,ntree=500,percent=1)
getAccuracy(p19,test_with$activity)
90.48%

p21<-bagging("rf",21,train,test_with,ntree=500,percent=1)
getAccuracy(p21,test_with$activity)
90.65%

p23<-bagging("rf",23,train,test_with,ntree=500,percent=1)
getAccuracy(p23,test_with$activity)
90.32%

p25<-bagging("rf",25,train,test_with,ntree=500,percent=1)
getAccuracy(p25,test_with$activity)
90.48%

=== MLR

p5<-bagging("mlr",5,train,test_with,percent=1,ntree=500)
getAccuracy(p5,test_with$activity)
90.27%

p7<-bagging("mlr",7,train,test_with,percent=1,ntree=500)
getAccuracy(p7,test_with$activity)
90.32%

p9<-bagging("mlr",9,train,test_with,percent=1,ntree=500)
getAccuracy(p9,test_with$activity)
89.96%

p11<-bagging("mlr",11,train,test_with,ntree=500,percent=1)
getAccuracy(p11,test_with$activity)
89.43%

p13<-bagging("mlr",13,train,test_with,ntree=500,percent=1)
getAccuracy(p13,test_with$activity)
89.22%

p15<-bagging("mlr",15,train,test_with,ntree=500,percent=1)
getAccuracy(p15,test_with$activity)
88.58%

p17<-bagging("mlr",17,train,test_with,ntree=500,percent=1)
getAccuracy(p17,test_with$activity)
89.6%

p19<-bagging("mlr",19,train,test_with,ntree=500,percent=1)
getAccuracy(p19,test_with$activity)
88.89%

p21<-bagging("mlr",21,train,test_with,ntree=500,percent=1)
getAccuracy(p21,test_with$activity)
88.93%

p23<-bagging("mlr",23,train,test_with,ntree=500,percent=1)
getAccuracy(p23,test_with$activity)
88.7%

p25<-bagging("mlr",25,train,test_with,ntree=500,percent=1)
getAccuracy(p25,test_with$activity)
88.41%