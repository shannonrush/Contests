source("../helpers.R")
load("../../data/processed/train_clean.rda")
load("../../data/processed/test_clean.rda")

# Random Forest
library(randomForest)
rf <- randomForest(activity~.,data=train,do.trace=T,ntree=350,keep.forest=T)
predict.rf <- predict(rf,test,predict.all=T)
p.rf <- predict.rf$aggregate
conf.rf <- apply(predict.rf$individual,1,function(x) max(table(x)/length(x)))

# MLR
library(nnet)
mlr <- multinom(formula = activity ~ fBodyAccJerk.entropy...X + tGravityAcc.min...X + 
                             tGravityAcc.mean...Y + fBodyAccMag.std.. + tGravityAcc.arCoeff...Y.2 + 
                             tBodyAcc.correlation...X.Y + fBodyGyro.meanFreq...X + tBodyGyroJerk.correlation...X.Z + 
                             fBodyGyro.kurtosis...Z + fBodyGyro.max...Y + tBodyAccJerkMag.iqr.. + 
                             tBodyGyroJerk.mad...X + tBodyAcc.std...X + tBodyAccJerk.entropy...Z + 
                             tBodyGyro.arCoeff...Y.1 + tGravityAcc.energy...Y + fBodyAcc.bandsEnergy...17.24.2 + 
                             tBodyGyro.mad...Z + tBodyAccJerk.correlation...X.Z + tBodyGyro.arCoeff...X.1 + 
                             tBodyGyro.arCoeff...X.2 + tBodyGyro.arCoeff...Y.2 + tBodyGyroJerk.correlation...Y.Z + 
                             tBodyGyroMag.mean.. + tBodyGyro.mean...Y + tBodyAcc.mean...Y + 
                             tGravityAcc.sma.. + fBodyAcc.skewness...Y + tBodyAccJerk.arCoeff...Z.1 + 
                             tBodyGyroJerk.entropy...X + tBodyAcc.entropy...Y + tBodyGyroJerk.arCoeff...X.3 + 
                             tBodyAccMag.arCoeff..4 + tBodyAcc.mean...Z, data = train, maxit=2000)
p.mlr <- predict(mlr,test)
conf.mlr <- apply(predict(mlr,test,type="probs"),1,max)

# SVM
library(e1071)
svm <- svm(activity~.,data=train,probability=T)
predict.svm <-predict(svm,test,probability=T)
p.svm <- predict.svm[1:nrow(test)]
conf.svm <- apply(attr(predict.svm,"probabilities"),1,max)

pr <- as.matrix(data.frame(rf=p.rf,mlr=p.mlr,svm=p.svm))
conf <- as.matrix(data.frame(rf=conf.rf,mlr=conf.mlr,svm=conf.svm))

# simplest blend
p <- apply(pr,1,function (x) ifelse(any(duplicated(x)),max(x),x["mlr"]))
getAccuracy(p,test$activity)
95.76%

# blend using confidence matrix
p<- sapply(1:nrow(test),function (i) {
  if (any(duplicated(pr[i,]))) {
    max(pr[i,])
  } else {
    pr[i,names(which.max(conf[i,]))]
  }
})
getAccuracy(p,test$activity)
95.76%