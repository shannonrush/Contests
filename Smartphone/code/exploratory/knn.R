load("../../data/processed/training_subject.rda")
load("../../data/processed/validating_subject.rda")
source("../helpers.R")

p <- knn(training_subject[,-563],validating_subject[,-563],training_subject[,563],k=3,l=1)
getAccuracy(p,validating_subject$activity)

84.27%