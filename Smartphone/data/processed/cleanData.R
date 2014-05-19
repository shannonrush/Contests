train <- read.csv("../raw/train.csv")
train$activity <- as.factor(train$activity)
save(train,file="train_clean.rda")

library(caret)
set.seed(335)
trainIndex <- createDataPartition(train$activity, list=FALSE, p = 0.8)
training <- train[trainIndex,]
validating <- train[-trainIndex,]
save(training,file="training.rda")
save(validating,file="validating.rda")

# dividing training and validating by subject

load("train_clean.rda")
table(train$subject)

1   2   3   4   6   9  10  12  13  15  16  19  20  21  22  24  29  30 
347 302 341 317 325 288 294 320 327 328 366 360 354 408 321 381 344 383 

# subjects 9, 22, 24 and 30 make up about 22% of the training data, sep those out for validating

validating_subject <- train[train$subject %in% c(9,22,24,30),]
training_subject <- train[!train$subject %in% c(9,22,24,30),]
save(training_subject,file="training_subject.rda")
save(validating_subject,file="validating_subject.rda")

test <- read.csv("../raw/test.csv")
save(test,file="test.rda")