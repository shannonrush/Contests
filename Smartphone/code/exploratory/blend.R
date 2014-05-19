blend <- function(train_set,test_set) {
  # Random Forest
  library(randomForest)
  rf <- randomForest(activity~.,data=train_set,do.trace=T,ntree=750,mtry=92,keep.forest=T)
  predict.rf <- predict(rf,test_set,predict.all=T)
  p.rf <- predict.rf$aggregate
  conf.rf <- apply(predict.rf$individual,1,function(x) max(table(x)/length(x)))
  
  # MLR
  library(nnet)
  mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                    V452 + V457 + V4 + V167 + V435 + V103 + V127 + V137 + V373 + 
                    V299 + V498 + V38 + V146 + V147 + V177 + V157 + V548 + V248 + 
                    V55 + V56 + V59 + V116 + V36 + V552 + V197, data = train_set,maxit=2000)
  p.mlr <- predict(mlr,test_set)
  conf.mlr <- apply(predict(mlr,test_set,type="probs"),1,max)
  
  # SVM
  library(e1071)
  svm <- svm(activity~.,data=train_set,probability=T)
  predict.svm <-predict(svm,test_set,probability=T)
  p.svm <- predict.svm[1:nrow(test_set)]
  conf.svm <- apply(attr(predict.svm,"probabilities"),1,max)
  
  pr <- as.matrix(data.frame(rf=p.rf,mlr=p.mlr,svm=p.svm))
  conf <- as.matrix(data.frame(rf=conf.rf,mlr=conf.mlr,svm=conf.svm))
  
  p<- sapply(1:nrow(test_set),function (i) {
    if (any(duplicated(pr[i,]))) {
      max(pr[i,])
    } else {
      pr[i,names(which.max(conf[i,]))]
    }
  })
}


# validating_subject: 96.58%