splitDataByRandom <- function() {
  library(caret)
  set.seed(10)
  load("processed/train_clean.rda")
  trainIndex <- createDataPartition(train_clean$SalePrice, list=FALSE, p = 0.7)
  write.csv(train_clean[trainIndex,],"processed/training.csv",row.names=F)
  write.csv(train_clean[-trainIndex,],"processed/validating.csv",row.names=F)
}