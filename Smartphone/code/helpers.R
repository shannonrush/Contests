getAccuracy <- function(prediction,actual) {
  correct <- numCorrect(prediction,actual)
  percentCorrect = percentCorrect(correct,length(actual))
  print(paste0(correct,"/",length(actual)))
  print(paste0(percentCorrect,"%"))
  print(table(actual,prediction))
}

numCorrect <- function(p,a) {
  sum(p==a)
}

percentCorrect <- function(num_correct,num_actual) {
  round(((num_correct/num_actual) * 100),2)
}

# returns most occurring, ties broken at random
mostOccurring <- function(v) {
  most <- namesMost(v)
  ifelse(length(most)==1,most,sample(most,1))
}

numMost <- function(v) {
  sum(v==names(which.max(table(v))))
}

namesMost <- function(v) {
  names(which(table(v)==numMost(v)))
}