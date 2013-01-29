getAppendixData <- function() {
  download.file("http://www.kaggle.com/c/bluebook-for-bulldozers/download/Machine_Appendix.csv","original/Machine_Appendix.csv")
  dateMachineAppendixDownloaded <- date()
  save(dateDownloaded,file="original/dateDownloaded.rda")
}