sub1 <- function() {
  train <- read.csv("data/train.csv")
  survived <- train[train$survived==1,]
  proportion_survived <- nrow(survived)/nrow(train)
  
  proportion_women_survived <- nrow(survived[survived$sex=="female",])/nrow(train[train$sex=="female",])
  proportion_men_survived <- nrow(survived[survived$sex=="male",])/nrow(train[train$sex=="male",])
  
  test <- read.csv("data/test.csv")
  sub1 <- apply(test,1,function(x) {if (x[3]=="male") {0} else {1}})
  write.table(sub1,"sub1.csv",row.names=F,col.names=F)
}
