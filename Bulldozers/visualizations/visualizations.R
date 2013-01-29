# exploratory

exploratoryData <- function () {
  # get just 10% of training data to more quickly explore data set
  library(caret)
  set.seed(100)
  train <- read.csv("../data/processed/training.csv")
  exploreIndex <- createDataPartition(train$SalePrice, list=FALSE, p = 0.1)
  write.csv(train[exploreIndex,],"explore.csv",row.names=F)
}

salePriceHistogram <- function() {
  training <- read.csv("..data/training.csv")
  hist(training$SalePrice,xlab="Sale Price ($)", ylab="Bulldozers Purchased",main="Bulldozer Auction Sale Prices")
}

salePriceByYearMade <- function() {
  data <- read.csv("explore.csv")
  subdata <- data[data$YearMade!=1000,]
  attach(subdata)
  plot(SalePrice ~ YearMade)
}


