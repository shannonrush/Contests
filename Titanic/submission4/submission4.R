sub4 <- function() {
  library(randomForest)
  train <- read.csv("train4_clean.csv")
  test <- read.csv("test4_clean.csv")
  train$survived<-as.factor(train$survived)
  train$name<-NULL
  train$ticket<-NULL
  train.rf <- randomForest(survived ~pclass+sex+age+sibsp+parch+fare+cabin+embarked+with_fam,data=train)
  p<-predict(train.rf,train)
  accuracy<-((length(which(p == train$survived))) / length(train$survived)) * 100
  test$survived<-factor(0,levels=c(0,1))
  test$cabin<-factor(test$cabin,levels=levels(train$cabin))
  test$name<-NULL
  test$ticket<-NULL
  ptest<-predict(train.rf,test)
  write.table(ptest,"sub4.csv",row.names=F,col.names=F,quote=F)
}