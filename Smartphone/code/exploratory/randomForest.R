source("../helpers.R")
load("../../data/processed/training.rda")
load("../../data/processed/validating.rda")
set.seed(335)
library(randomForest)

rf <- randomForest(activity~.,data=training,do.trace=T)
p<-predict(rf,validating)
getAccuracy(p,validating$activity)

350: 98.03%
500: 98.2%
750: 98.44% 
1000: 98.36%

rf <- randomForest(activity~.,data=training,do.trace=T,ntree=1000)
p<-predict(rf,validating)
getAccuracy(p,validating$activity)

load("../../data/processed/training_subject.rda")
load("../../data/processed/validating_subject.rda")

rf <- randomForest(activity~.,data=training_subject,do.trace=T,ntree=1000)
p<-predict(rf,validating_subject)
getAccuracy(p,validating_subject$activity)

ntree:
350: 94.76% 
500: 94.54%
750: 94.9%
1000: 94.68% 

tune <- tuneRF(training_subject[,-563],training_subject[,563])

rf <- randomForest(activity~.,data=training_subject,do.trace=T,ntree=750,mtry=115)
p<-predict(rf,validating_subject)
getAccuracy(p,validating_subject$activity)
mtry:
23:94.9%
46:94.68%
69:94.9%
92:94.97%
115:94.9%

# removing subject
load("../../data/processed/train_clean.rda")
load("../../original/data/test_with.rda")
train$subject <- NULL
test_with$subject <- NULL
rf <- randomForest(activity~.,data=train,do.trace=T,ntree=750)
p <- predict(rf,test_with)
getAccuracy(p,test_with$ac)
91.18%

