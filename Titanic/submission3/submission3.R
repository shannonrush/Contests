sub3<-function() {
  train<-read.csv("train_clean.csv")
  test<-read.csv("test_clean.csv")
  titanic.glm<-glm(survived ~.,data=train)
  survived_pred<-round(predict(titanic.glm,train))
  ((length(which(survived_pred == train$survived))) / length(train$survived)) * 100
  p<-round(predict(titanic.glm,test))
  write.table(p,"sub3.csv",row.names=F,col.names=F,quote=F)
}