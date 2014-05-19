load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
source("../exploratory/boosting.R")

p<-boosting(27,train,test)
write.table(p,file="submission12.csv",col.names=F,row.names=F)

# CODE 

boosting <- function(n,train_set,test_set) {
  N <- nrow(train_set)
  misclassified <- rep(0,N)
  m <- matrix(nrow=nrow(test_set),ncol=n)
  probs <- rep(1/N,N) 
  for (i in 1:n) {
    t <- train_set[sample(N, N,replace=T,prob=probs), ]
    fit <- randomForest(activity~.,data=t,do.trace=T,ntree=500)
    m[,i] <- as.character(predict(fit,test_set))
    p<-predict(fit,train_set)
    misses <- p!=train_set$activity
    #epsilon <- sum(probs[misses])
    misclassified <- misclassified + (misses*1)
    probs <- probabilities(N,epsilon,misclassified)
  }
  apply(m,1,mostOccurring)
}

probabilities <- function(N,eps,mc) {
  d <- denom(mc)
  sapply(mc,function(m) prob(m,d)) 
  
}

denom <- function(mc) {
  sum(sapply(mc,function(m)1+m^4))
}

prob <- function(m,d) {
  (1+m^4)/d 
}