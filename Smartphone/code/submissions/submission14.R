# SUBMISSION

load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)

p <- samme(activity~.,train,train$activity,test,37)
write.table(p,file="submission14.csv",col.names=F,row.names=F)

# CODE

library(randomForest)

samme <- function(formula,data,y,test,m=5,trace=T,ntree=500,mtry=NULL) {
  mtry <- ifelse(is.null(mtry),floor(sqrt(ncol(data))),mtry)
  C <- matrix(nrow=nrow(test),ncol=m)
  n <- nrow(data)
  w <- rep(1/n,n)
  A <- numeric(m)
  K <- nlevels(y)
  
  for (i in 1:m) {
    t <- data[sample(n, n,replace=T,prob=w), ]
    fit <- randomForest(formula,data=t,do.trace=trace,ntree=ntree,mtry=mtry)
    C[,i]<-as.character(predict(fit,test))
    h<-predict(fit,data)
    misses <- as.numeric(h!=y)
    err <- error(w,misses)
    print(err)
    A[i] <- alpha(err,K) 
    w <- weights(err,w,A[i],misses)
  }
  finalPrediction(C,A)
}

error <- function(w,misses) {
  sum(w[misses])/sum(w)
}

alpha <- function(err,K) {
  if (err<0.0001) {
    10
  } else if (err>0.5) {
    1.5
  } else {
    log((1-err)/err)+log(K-1)
  }
}

weights <- function(err,w,a,misses) {
  if (err<0.0001) {
    rep(1/length(w),length(w))
  } else {
    tmp_w <- w * exp(a*misses)
    renorm(tmp_w)
  }
}

renorm <- function(tmp_w) {
  tmp_w/(sum(tmp_w))
}

finalPrediction <- function(C,A) {
  apply(C,1,function(sample) samplePrediction(sample,A))
}

samplePrediction <- function(sample,A) {
  classes <- unique(sample)
  class.table <- sapply(classes,function(k) sum(A * (sample==k)))
  names <- names(which(class.table==max(class.table)))
  ifelse(length(names)==1,names,sample(names,1))
}