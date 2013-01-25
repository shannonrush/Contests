cleanData <- function(data, filename, test=F) {
  
  # survived 
  if (!test) {
    #remove rows where survived is NA 
    data <- data[!is.na(data$survived),]
  }
  
  # pclass no missing values in provided data, leaving for now
  # sex no missing values in provided data, leaving for now
  if (test) {
    sub<-data[,c(1,3,4,5,6,8,10)]
  } else {
    sub<-data[,c(1,2,4,5,6,7,9,11)]
  }

  # age - predict age with lm
  age.lm <- lm(age ~.,data=sub)
  p<-predict(age.lm,sub)
  data$age[which(is.na(data$age))]<-p[which(is.na(data$age))]
  
  #replace NA sibsp with 0 sibsp, assume no sibs/spouse
  data$sibsp[is.na(data$sibsp)]<-0
  
  #replace NA parch with 0 parch, assume no parent/child
  data$parch[is.na(data$parch)]<-0
  
  # but really what seems to be important is whether traveler was alone or not, 
  # so new column: with_fam, 0 if no sibsp/parch, 1 if either sibsp/parch
  data$with_fam <- apply(data,1,function(x) {if (x['sibsp']>0 | x['parch']>0) {1} else {0}})
  
  # try to get some usefulness out of cabin by just using the letter and M for missing
  # maybe there's more to be derived from ticket here
  
  data$cabin <-apply( data,1,function(x) {if (x['cabin']=="") {"M"} else {substring(x['cabin'],1,1)} } )
  
  # replace 0.00 for fare based on mean for pclass (maybe better to base on ticket?)
  data$fare[is.na(data$fare)]<-0
  data$fare <- apply(data,1,function(x) {replaceZeroFareByClass(data, x)})

  #convert sex and embarked to numeric
  data$sex <- as.numeric(data$sex)
  data$embarked <- as.numeric(data$embarked)
  
  write.csv(data,filename,row.names=F)
}

replaceZeroFareByClass <- function(data, passenger) {
  
  if (passenger['fare']!=0) {
    return(passenger['fare'])
  } 
  class <- passenger['pclass']
  
  if (is.na(class)) {
    return (mean(data$fare))
  } else {
    return (mean(data$fare[data$pclass==class]))
  }  
}

createData <- function() {
  train<-read.csv("train_orig.csv")
  cleanData(train,"train4_clean.csv",F)
  test<-read.csv("test_orig.csv")
  cleanData(test,"test4_clean.csv",T)
}
