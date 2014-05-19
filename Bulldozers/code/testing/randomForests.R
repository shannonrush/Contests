randomForestAll <- function() {
  # Random forest with all variables, trained on 70% of train_clean
  train <- read.csv("../../data/processed/training.csv")
  library(randomForest)
  library(foreach)
  library(doMC)
  registerDoMC(cores=4)
  
  set.seed(2345)
  train$state <-NULL
  train$fiBaseModel <-NULL
  train$monthSold <- as.factor(train$monthSold)
  sp.rf <- foreach(ntree=rep(125, 4), .combine=combine, .packages='randomForest') %dopar%
    randomForest(SalePrice ~.,data=train,ntree=ntree,importance=T)
  
 }