source("../helpers.R")
load("../../data/processed/training.rda")
load("../../data/processed/validating.rda")
set.seed(335)
library(e1071)

svm <- svm(activity~.,data=training)
p <- predict(svm,validating)
getAccuracy(p,validating$activity)

98.2%

load("../../data/processed/training_subject.rda")
load("../../data/processed/validating_subject.rda")

svm <- svm(activity~.,data=training_subject)
p <- predict(svm,validating_subject)
getAccuracy(p,validating_subject$activity)

95.56%