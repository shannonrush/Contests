sub2 <- function() {
  library(randomForest)
  training <<- read.csv("data/test.csv")

  #remove name, ticket and cabin
  training$name <<- NULL
  training$ticket <<- NULL
  training$cabin <<- NULL
  
  #convert sex and embarked to numeric
  training$sex <<- as.numeric(training$sex)
  training$embarked <<- as.numeric(training$embarked)
  
  #remove rows where survived is NA and set to factor
  #training <<- training[!is.na(training$survived),]
  #training$survived <<- as.factor(training$survived)
  
  # replace NA sex with random 1 or 2
  training$sex[is.na(training$sex)]<<- sample(c(1,2),1)
  
  # replace NA age with mean age (this might be a good place to improve)
  training$age[is.na(training$age)]<<- mean(training$age,na.rm=T)
  
  #replace NA sibsp with mean sibsp
  training$sibsp[is.na(training$sibsp)]<<- mean(training$sibsp,na.rm=T)
  
  #replace NA parch with mean parch
  training$parch[is.na(training$parch)]<<- mean(training$parch,na.rm=T)
  
  # fill in 0.00 for fare based on mean for pclass 
  training$fare <<- apply(training,1,function(x) {replaceZeroFareByClass(x)})
  
  # fill in NA for pclass based on fare
  training$pclass <<- apply(training,1,function(x) {replaceNAPClassByFare(x)})
  
  return (training)
}

replaceZeroFareByClass <- function(passenger) {

  if (passenger[7]!=0) {
    return(passenger[7])
  } 
  class <- passenger[2]
  
  if (is.na(class)) {
    return (mean(training$fare))
  } else {
    return (mean(training$fare[training$pclass==class]))
  }  
}

replaceNAPClassByFare <- function(passenger) {
  if (!is.na(passenger[2])) {
    return(passenger[2])
  }
  
  fare <- passenger[7]
  if (fare<11) {
    return (3)
  } else if (fare>=11 & fare<=29) {
    return (2)
  } else if (fare > 29) {
    sibs <- passenger[5]
    if(sibs>=4) {
      return (3)
    } else {
      return (1)
    }
  }
}

prediction <- function() {
  library(randomForest)
  library(plyr)
  training <- read.csv("sub2train.csv")
  training$survived <- as.factor(training$survived)
  testing <- read.csv("sub2test.csv")
  testing$survived <- 0
  rf <- randomForest(survived ~.,data=training)
  p<-predict(rf,testing)
}