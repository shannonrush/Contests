splitData <- function() {
  library(caret)
  set.seed(10)
  train <- read.csv("train.csv")
  trainIndex <- createDataPartition(train$SalePrice, list=FALSE, p = 0.7)
  write.csv(train[trainIndex,],"training.csv"),row.names=F)
  write.csv(train[-trainIndex,],"validating.csv"),row.names=F)
}