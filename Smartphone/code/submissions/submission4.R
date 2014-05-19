load("../../data/processed/train_clean.rda")
load("../../data/processed/test.rda")

mlr <- multinom(formula = activity ~ V185 + V53 + V505 + V96 + V42 + 
                  V452 + V457 + V4 + V167 + V435 + V103 + V127 + V137 + V373 + 
                  V299 + V498 + V38 + V146 + V147 + V177 + V157 + V548 + V248 + 
                  V55 + V56 + V59 + V116 + V36 + V552 + V197, data = train,maxit=2000)
p <- predict(mlr,test)

write.table(p,file="submission4.csv",col.names=F,row.names=F)