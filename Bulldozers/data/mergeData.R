mergeData <- function() {
  # merges train and valid data sets with the machine appendix data
  ma <- read.csv("original/Machine_Appendix.csv")
  t <- read.csv("original/train.csv")
  v <- read.csv("original/valid.csv")
  merged_train <- merge(ma,t,by=Reduce(intersect,list(names(ma),names(t))))
  write.csv(merged_train,"processed/merged_train.csv",row.names=F)
  merged_valid <- merge(ma,v,by=Reduce(intersect,list(names(ma),names(t))))
  write.csv(merged_valid,"processed/merged_valid.csv",row.names=F)
}