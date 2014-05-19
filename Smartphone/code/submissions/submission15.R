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
    levels(t)<-levels(unique(t$activity)) # in case no samples for one or more outcomes are chosen
    print(table(t$activity))
    fit <- randomForest(formula,data=t,do.trace=trace,ntree=ntree,mtry=mtry)
    C[,i]<-as.character(predict(fit,test))
    h<-predict(fit,data)
    misses <- as.numeric(h!=y)
    print(paste("MISSES FOR FOREST:",i,sum(misses)))
    err <- error(w,misses)
    print(paste("ERROR FOR FOREST:",i,err))
    A[i] <- alpha(err,K) 
    print(paste("ALPHA FOR FOREST:",i,A[i]))      
    w <- weights(w,A[i],misses)
  }
  finalPrediction(C,A)
}

error <- function(w,misses) {
  sum(w * misses)
}

alpha <- function(err,K) {
  if (err>0.5) {
    1
  } else if (err<=0) {
    20
  } else {
    log((1-err)/err)+log(K-1)
  }
}

weights <- function(w,a,misses) {
  tmp_w <- w * exp(a*misses)
  renorm(tmp_w)
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



# SUBMISSION

load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)

p <- samme(activity~.,train,train$activity,test,100, trace=F)
write.table(p,file="submission15.csv",col.names=F,row.names=F)