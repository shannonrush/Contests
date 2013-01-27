survivalVsFare <- function () {
  library("ggplot2")
  data <- read.csv("train5_clean.csv")
  data$fare_bins <- as.factor(apply(data,1,function(x) {
    fare<-as.numeric(x['fare'])
    if (fare<=10.5) {
      1
    } else if (fare > 10.5 & fare <= 20) {
      2
    } else if (fare > 20 & fare <= 40) {
      3
    } else {
      4
    }}))
  lived<-data[data$survived==1,]
  died<-data[data$survived==0,]
  df1 <- data.frame(survived=factor(c(0,0,0,0,1,1,1,1)),
                    bins=factor(c(1,2,3,4,1,2,3,4)),
                    counts=c(nrow(died[died$fare_bin==1,]),
                             nrow(died[died$fare_bin==2,]),
                             nrow(died[died$fare_bin==3,]),
                             nrow(died[died$fare_bin==4,]),
                             nrow(lived[lived$fare_bin==1,]),
                             nrow(lived[lived$fare_bin==2,]),
                             nrow(lived[lived$fare_bin==3,]),
                             nrow(lived[lived$fare_bin==4,])))
  ggplot(data=df1, 
         aes(x=bins, y=counts, fill=survived)) + labs(y="Survival Count", x="Fare") + scale_x_discrete(labels=c("<= $10.50","$10.51 - $20","$20.01 - $40","> $40")) + geom_bar(stat="identity", 
         position=position_dodge(),colour="black")
}