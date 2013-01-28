splitData <- function(subInt, seed) {
  library(caret)
  set.seed(seed)
  train <- read.csv("data/train.csv")
  trainIndex <- createDataPartition(train$SalePrice, list=FALSE, p = 0.7)
  write.csv(train[trainIndex,],paste0("submission",subInt,"/training.csv"),row.names=F)
  write.csv(train[-trainIndex,],paste0("submission",subInt,"/validating.csv"),row.names=F)
}