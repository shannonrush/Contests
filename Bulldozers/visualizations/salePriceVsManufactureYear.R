salePriceVsManufactureYear <- function() {
  library("ggplot2")
  data<-read.csv("../data/train.csv")
  attach(data)
  subdata<-data[YearMade!=1000,]
  ggplot(subdata, aes(x=YearMade, y=SalePrice)) + geom_point()+scale_y_continuous(limit=c(4750, 142000))
}