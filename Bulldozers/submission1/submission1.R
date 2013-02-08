sub1 <- function() {
  library("party")
  t <- read.csv("../data/processed/training.csv")
  fit <- rpart(SalePrice ~MfgYear+fiManufacturerID+MachineHoursCurrentMeter,data=t,method="anova")
  p<-predict(fit,t)

}