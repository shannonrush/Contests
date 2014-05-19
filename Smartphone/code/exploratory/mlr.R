source("../helpers.R")
load("../../data/processed/training.rda")
load("../../data/processed/validating.rda")
set.seed(335)
library(nnet)

mlr <- multinom(activity~.,trace=T,data=training,MaxNWts=3400,maxit=2000)
p <- predict(mlr,validating)
getAccuracy(p,validating$activity)

96.55%

c <- cor(training[,-563], as.numeric(training[,563]))
inds <- arrayInd(which.max(c), dim(c))
var <- rownames(c)[inds[,1]]

minimal.lr <- multinom(activity~V185,data=training)
max.lr <- multinom(activity ~ .,data=training, MaxNWts=3400, maxit=200)
step <- step(minimal.lr, scope=list(lower=minimal.lr, upper=max.lr), direction="forward")

feature.mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                          V539 + V167 + V452 + V303 + V201 + V103 + V10 + V457 + V183 + 
                          V559 + V59 + V129 + subject + V127 + V373 + V136 + V169 + 
                          V56 + V161 + V184 + V160, data = training,maxit=2000)
p <- predict(feature.mlr,validating)
getAccuracy(p,validating$activity)
97.54%

load("../../data/processed/training_subject.rda")
load("../../data/processed/validating_subject.rda")
mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                          V539 + V167 + V452 + V303 + V201 + V103 + V10 + V457 + V183 + 
                          V559 + V59 + V129 + subject + V127 + V373 + V136 + V169 + 
                          V56 + V161 + V184 + V160, data = training_subject,maxit=2000)
p <- predict(mlr,validating_subject)
getAccuracy(p,validating_subject$activity)
94.97%

load("../../data/processed/train_clean.rda")

c <- cor(train[,-563], as.numeric(train[,563])) 
inds <- arrayInd(which.max(c), dim(c))
var <- rownames(c)[inds[,1]]

minimal.lr <- multinom(activity~V185,data=train)
max.lr <- multinom(activity ~ .,data=train, MaxNWts=3400, maxit=2000)
step <- step(minimal.lr, scope=list(lower=minimal.lr, upper=max.lr), direction="forward")
mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
           V452 + V457 + V4 + V167 + V435 + V103 + V127 + V137 + V373 + 
           V299 + V498 + V38 + V146 + V147 + V177 + V157 + V548 + V248 + 
           V55 + V56 + V59 + V116 + V36 + V552 + V197, data = training_subject,maxit=2000)
p <- predict(mlr,validating_subject)
getAccuracy(p,validating_subject$activity)
97.45%

load("../../original/data/test_with.rda")
mlr <- multinom(activity~.,trace=T,data=train,MaxNWts=3400,maxit=2000)
p<-predict(mlr,test_with)
getAccuracy(p,test_with$activity)
88.89%

