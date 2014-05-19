source("bagging.R")
load("../../data/processed/train_clean.rda")
load("../../original/data/test_with.rda")

p5<-bagging("rf",5,train,test_with)
getAccuracy(p5,test_with$activity)
91.03%

p7<-bagging("rf",7,train,test_with)
getAccuracy(p7,test_with$activity)
91.18%

p9<-bagging("rf",9,train,test_with)
getAccuracy(p9,test_with$activity)
91.2%

p11<-bagging("rf",11,train,test_with)
getAccuracy(p11,test_with$activity)
91.2%

p13<-bagging("rf",13,train,test_with)
getAccuracy(p13,test_with$activity)
91.2%

p15<-bagging("rf",15,train,test_with)
getAccuracy(p15,test_with$activity)
90.98%

p17<-bagging("rf",17,train,test_with)
getAccuracy(p17,test_with$activity)
90.96%

p19<-bagging("rf",19,train,test_with)
getAccuracy(p19,test_with$activity)
91.25%

p21<-bagging("rf",21,train,test_with)
getAccuracy(p21,test_with$activity)
91.13%

p23<-bagging("rf",23,train,test_with)
getAccuracy(p23,test_with$activity)
91.08%

p25<-bagging("rf",25,train,test_with)
getAccuracy(p25,test_with$activity)
91.06%

=== MLR

p3<-bagging("mlr",3,train,test_with)
getAccuracy(p3,test_with$activity)
90.6%

p5<-bagging("mlr",5,train,test_with)
getAccuracy(p5,test_with$activity)
90.58%

p7<-bagging("mlr",7,train,test_with)
getAccuracy(p7,test_with$activity)
90.67%

p9<-bagging("mlr",9,train,test_with)
getAccuracy(p9,test_with$activity)
90.2%

p11<-bagging("mlr",11,train,test_with)
getAccuracy(p11,test_with$activity)
90.63%

p13<-bagging("mlr",13,train,test_with)
getAccuracy(p13,test_with$activity)
90.13%

p15<-bagging("mlr",15,train,test_with)
getAccuracy(p15,test_with$activity)
90.58%

p17<-bagging("mlr",17,train,test_with)
getAccuracy(p17,test_with$activity)
90.46%

p19<-bagging("mlr",19,train,test_with)
getAccuracy(p19,test_with$activity)
90.25%

p21<-bagging("mlr",21,train,test_with)
getAccuracy(p21,test_with$activity)
90.48%

p23<-bagging("mlr",23,train,test_with)
getAccuracy(p23,test_with$activity)
90.41%

p25<-bagging("mlr",25,train,test_with)
getAccuracy(p25,test_with$activity)
90.53%