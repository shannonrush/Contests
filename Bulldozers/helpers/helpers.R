findRMSLE <- function(prediction, actual) {
  lses <- sapply(1:length(prediction),function(x) (log(prediction[x] + 1) - log(actual[x] + 1))^2)
  rmsle <- sqrt(mean(lses))
  print(rmsle)
}

writePrediction <- function(salesids,predictions,filename) {
  myPrediction <- data.frame(SalesID=salesids,SalePrice=predictions)
  write.csv(myPrediction,row.names=F,file=filename)
}

showMissing <- function(data) {
  print(apply(data,2,function(x)sum(is.na(x))))
}