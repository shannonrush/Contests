source("../helpers.R")
set.seed(335)
library(randomForest)

boosting <- function(formula,data,y,test,n=5,ntree=500,mtry=NULL,trace=T) {
  N <- nrow(data)
  misclassified <- rep(0,N)
  m <- matrix(nrow=nrow(test),ncol=n)
  mtry <- ifelse(is.null(mtry),floor(sqrt(ncol(data))),mtry)
  probs <- rep(1/N,N) 
  for (i in 1:n) {
    t <- data[sample(N, N,replace=T,prob=probs), ]
    fit <- randomForest(formula,data=t,do.trace=trace,ntree=ntree,mtry=mtry)
    m[,i] <- as.character(predict(fit,test))
    p<-predict(fit,data)
    misses <- p!=y
    epsilon <- sum(probs[misses])
    browser()
    #ind<-as.numeric(vardep != flearn) #crear un vector indicador
    #err<- sum(pesos*ind)         #Calcula el error ponderado en esa iteracion
    print(paste("EPSILON FOR FOREST",i,epsilon))
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

