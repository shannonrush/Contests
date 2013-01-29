# exploratory

exploratoryData <- function () {
  # get just 10% of training data to more quickly explore data set
  library(caret)
  set.seed(100)
  train <- read.csv("../data/original/train.csv")
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

clustering <- function () {
  data <- read.csv("../data/training.csv")
  
  hc <- hclust(dist(t(data[,1:ncol(data)])))
  plot(hc)
}


# visualizations

salePriceVsYearMade <- function() {
  library("ggplot2")
  data<-read.csv("../data/train.csv")
  attach(data)
  subdata<-data[YearMade!=1000,]
  ggplot(subdata, aes(x=YearMade, y=SalePrice)) + geom_point()+scale_y_continuous(limit=c(4750, 142000))
}
