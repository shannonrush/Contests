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
  training <- read.csv("../data/processed/training.csv")
  hist(training$SalePrice,xlab="Sale Price ($)", ylab="Bulldozers Purchased",main="Bulldozer Auction Sale Prices")
}

salePriceByYearMade <- function() {
  explore <- read.csv("explore.csv")
  subdata <- explore[explore$YearMade!=1000,]
  attach(subdata)
  plot(SalePrice ~ YearMade)
}

salePriceByYearMadeMean <- function() {
  explore <- read.csv("explore.csv")
  sub <- explore[explore$YearMade!=1000,]
  years<-unique(YearMade)
  means<-sapply(sort(years),function(x)mean(sub[sub$YearMade==x,"SalePrice"]))
  means_list <- as.list(means)
  names(means_list)<-sort(years)
  plot(names(means_list),sapply(names(means_list),function(x)means_list[x]),ylab="Mean Sale Price",xlab="Year Made",main="Mean Sale Price By Year")
}

salePriceByMonthSoldMean <- function() {
  explore <- read.csv("explore.csv")
  explore$monthSold <- apply(explore,1,function(x) {
    browser()
    date <- as.Date(x['saledate'])
    as.numeric(format(date,format="%m"))
    })
}


