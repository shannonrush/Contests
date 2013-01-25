sub5 <- function() {
  train <- read.csv("train4_clean.csv")
  train$name <- NULL
  train$ticket <- NULL
  train$cabin <- as.numeric(train$cabin)
  x <- cbind(int=rep(1, nrow(train)), train[,c(2:10)])
  x <- as.matrix(x)
  y <- train[,1]
 
  source("logisticRegression.R")
  theta <- rep(0, ncol(x))
  j <- rep(0,10)
  for (i in 1:10) {
    theta <- theta - solve(Hessian(theta,x)) %*% grad(theta,x,y)
    j[i] <- J(theta,x,y)
  }
  
  p<-prediction(theta,x)
  accuracy<-(length(which(p == y)) / length(y)) * 100
  
  test<-read.csv("test4_clean.csv")
  test$name<-NULL
  test$ticket<-NULL
  test$cabin<-as.numeric(test$cabin)
  testx <- cbind(int=rep(1, nrow(test)), test)
  test <-as.matrix(test)
  testp<-prediction(theta,testx)
  write.table(testp,"sub5.csv",row.names=F,col.names=F,quote=F)
}