dataPrep <- function(train) {
  library(caret)
  set.seed(10)
  trainIndex <- createDataPartition(train$survived, list=FALSE, p = 0.8)
  write.csv(train[trainIndex,],"training.csv",row.names=F)
  write.csv(train[-trainIndex,],"testing.csv",row.names=F)
}