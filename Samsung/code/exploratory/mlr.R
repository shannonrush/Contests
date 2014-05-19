source("../../helpers.R")
load("../../../data/processed/train_clean.rda")
load("../../../data/processed/test_clean.rda")
library(nnet)
set.seed(335)

mlr <- multinom(activity~.,trace=T,data=train,MaxNWts=3400,maxit=2000)
p<-predict(mlr,test)
getAccuracy(p,test$activity)

88.89%

Forward step:
c <- cor(train[,-563], as.numeric(train[,563]))
# Highest correlation: fBodyAccJerk.entropy...X 
minimal.lr <- multinom(activity~fBodyAccJerk.entropy...X ,data=train)
max.lr <- multinom(activity ~ .,data=train, MaxNWts=3400, maxit=200)
step <- step(minimal.lr, scope=list(lower=minimal.lr, upper=max.lr), direction="forward")
step.lr <- multinom(formula = activity ~ fBodyAccJerk.entropy...X + tGravityAcc.min...X + 
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
p<-predict(step.lr,test)
getAccuracy(p,test$activity)
96.09%