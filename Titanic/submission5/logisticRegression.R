### Newton's Method
## sigmoid function
g <- function(z) {
  1/(1+exp(-z))
}

## hypothesis function
h <- function(theta, x) {
  g(x %*% theta)
}

## cost function
J <- function(theta, x, y) {
  m <- length(y)
  s <- sapply(1:m, function(i)
    y[i]*log(h(theta,x[i,])) + (1-y[i])*log(1-h(theta,x[i,]))
  )
  j <- -1/m * sum(s)
  return(j)
}

## gradient
grad <- function(theta, x, y) {
  m <- length(y)
  g <- 1/m * t(x) %*% (h(theta,x)-y)
  return(g)
}

## Hessian
Hessian <- function(theta, x) {
  m <- nrow(x)
  H <- 1/m * t(x) %*% x * diag(h(theta,x)) * diag(1-h(theta,x))
  return(H)
}

## prediction
prediction <- function(theta, x) {
  p <- apply(x,1, function(i)
      if(h(theta,i)>0.5) {1} else {0}
    )
  return(p)
}