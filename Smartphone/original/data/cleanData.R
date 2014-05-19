load("../../data/processed/test.rda")
load("../../data/processed/train_clean.rda")

# read test x, subject and y from txt files
# add subject and y to x

test2 <- read.table("X_test.txt",row.names=NULL)
testy <- read.table("y_test.txt",row.names=NULL)
test2_subject <- read.table("subject_test.txt",row.names=NULL)
names(test2_subject) <- "subject"
test2$subject <- test2_subject

names(testy) <- "activity"
test2$activity <- testy

# read train x, subject and y from txt files
# add subject and y to x

train2 <- read.table("X_train.txt",row.names=NULL)
trainy <- read.table("y_train.txt",row.names=NULL)
train2_subject <- read.table("subject_train.txt",row.names=NULL)
names(train2_subject) <- "subject"
train2$subject <- train2_subject

names(trainy) <- "activity"
train2$activity <- trainy

# combine test and train

test2$subject <- unlist(test2$subject)
test2$activity <- unlist(test2$activity)
train2$subject <- unlist(train2$subject)
train2$activity <- unlist(train2$activity)
data <- rbind(test2,train2)

# change activity to strings
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

data$activity <- sapply(data$activity,function(x) {
  x <- as.numeric(x)
  if (x==1) {
    "walking"
  } else if (x==2) {
    "walking_upstairs"
  } else if (x==3) {
    "walking_downstairs"
  } else if (x==4) {
    "sitting"
  } else if (x==5) {
    "standing"
  } else if (x==6) {
    "laying"
  }
})

# pull out subjects from test
test_subjects <- as.integer(levels(as.factor(test$subject)))
test_only <- data[data$subject %in% test_subjects,]
test_with <- test_only
save(test_with,file="test_with.rda")