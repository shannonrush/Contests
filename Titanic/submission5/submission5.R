sub5 <- function() {
  train <- read.csv("train4_clean.csv")
  train$name <- NULL
  train$ticket <- NULL
  train$cabin <- as.numeric(train$cabin)
  train_m <- data.matrix(train)
  X <- train_m[,c(2:10)]
  y <- train_m[,1]
  
  m<-nrow(X)
  n<-ncol(X)
  
  intercept = numeric(m)
  intercept[1:length(intercept)]<-1
  cbind(intercept,X)
  
  # Initialize fitting parameters
  initial_theta <- numeric(n+1)
  
  # Compute and display initial cost and gradient
  #[cost, grad] = costFunction(initial_theta, X, y);
  source("costFunction.R")
  r <- costFunction(initial_theta, X, y)
  cost <- r$cost
  grad <- r$grad
  
}