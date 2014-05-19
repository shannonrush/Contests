load("../raw/training.rda")
training$activity <- as.factor(training$activity)
save(training,file="training_clean.rda")

load("../raw/validating.rda")
validating$activity <- as.factor(validating$activity)
save(validating,file="validating_clean.rda")

load("../raw/test.rda")
test$activity <- as.factor(test$activity)
save(test,file="test_clean.rda")