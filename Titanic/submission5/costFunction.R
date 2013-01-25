costFunction <- function(theta, X, y) {
  
  m<-length(y)
  cost<-0
  grad<-numeric(length(theta))
  z<-X * theta
  h<-plogis(z)
  
  # grad = (1/m).*X' * (h-y); 
  grad <- (1/m)*Conj(t(X)) * (h-y)
  
  # J =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h));
  cost = (1/m)*sum(-y*log(h)) - (1-y)*log(1-h)
  
  return(data.frame(cost=cost,grad=grad))
}