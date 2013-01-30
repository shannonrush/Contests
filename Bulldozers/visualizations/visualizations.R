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
    date <- as.Date(x['saledate'], format="%m/%d/%Y")
    as.numeric(format(date,format="%m"))
    })
  means<-sapply(1:12,function(x)mean(explore[explore$monthSold==x,"SalePrice"]))
  means_list <- as.list(means)
  names(means_list) <- 1:12
  plot(1:12,sapply(1:12,function(x)means_list[x]),xlab="Months",ylab="Mean Sale Price",main="Sale Price by Monthly Mean")
}

salePriceBySeasonalMean <- function() {
  explore <- read.csv("explore.csv")
  seasons<-c("Winter","Spring","Summer","Autumn")
  explore$season <- apply(explore,1,function(x) {
    date <- as.Date(x['saledate'], format="%m/%d/%Y")
    month <- as.numeric(format(date,format="%m"))
    if (month %in% c(1,2,3)) {
      seasons[1]
    } else if (month %in% c(4,5,6)) {
      seasons[2]
    } else if (month %in% c(7,8,9)) {
      seasons[3]
    } else {
      seasons[4]
    }
  })
  means<-sapply(seasons,function(x)mean(explore[explore$season==x,"SalePrice"]))
  means_list<- as.list(means)
  names(means_list)<-seasons
  plot(1:4,sapply(seasons,function(x)means_list[x]),xlab="Seasons",ylab="Mean Sale Price",main="Sale Price Mean By Season",xaxp=c(1,4,3))
}

salePriceByManufacturerMean <- function() {
  explore <- read.csv("explore.csv")
  mans <- levels(explore$fiManufacturerDesc)
  means<-sapply(mans,function(x)mean(explore[explore$fiManufacturerDesc==x,"SalePrice"]))
  means_list <-as.list(means)
  names(means_list)<-mans
  library("calibrate")
  textxy(1:length(mans),sapply(mans,function(x)means_list[x]),mans)
}

manufacturerMeanSalesPriceByQty <- function() {
  explore <- read.csv("explore.csv")
  library("calibrate")
  mans <- levels(explore$fiManufacturerDesc)
  means<-sapply(mans,function(x)mean(explore[explore$fiManufacturerDesc==x,"SalePrice"]))
  qtys <- sapply(mans,function(x){nrow(explore[explore$fiManufacturerDesc==x,])})
  plot(log(qtys),means,xlab="Relative Quantity Sold",ylab="Sales Price Mean ($)",main="Manufacturer Mean Sales Price By Qty Sold")
  textxy(log(qtys),means,mans)
}


