splitDataByRandom <- function() {
  library(caret)
  set.seed(10)
  train <- read.csv("processed/merged_train.csv")
  trainIndex <- createDataPartition(train$SalePrice, list=FALSE, p = 0.7)
  write.csv(train[trainIndex,],"processed/training.csv",row.names=F)
  write.csv(train[-trainIndex,],"processed/validating.csv",row.names=F)
}