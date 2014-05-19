load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")
set.seed(335)
library(e1071)

mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                                 V539 + V167 + V452 + V303 + V201 + V103 + V10 + V457 + V183 + 
                                 V559 + V59 + V129 + subject + V127 + V373 + V136 + V169 + 
                                 V56 + V161 + V184 + V160, data = train,maxit=2000)

p <- predict(mlr,test)

write.table(p,file="submission2.csv",col.names=F,row.names=F)