getAccuracy <- function(prediction,actual) {
  numCorrect = sum(prediction==actual)
  percentCorrect = round(((numCorrect/length(actual)) * 100),2)
  print(paste0(numCorrect,"/",length(actual)))
  print(paste0(percentCorrect,"%"))
  print(table(actual,prediction))
}