sub1 <- function() {
  library("randomForest")
  training <- read.csv("../data/training.csv")
  training.rf <- randomForest(SalePrice ~.,data=training, importance=T,na.action=na.omit)
}