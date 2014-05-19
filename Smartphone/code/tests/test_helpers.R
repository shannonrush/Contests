library(testthat)

context("helper functions")
test_that("numCorrect returns the number from predicted that match actual", {
  expect_equal(numCorrect(c(1,1),c(1,2)),1)
  expect_equal(numCorrect(c("standing","sitting"),c("sitting","standing")),0)
})

test_that("percentCorrect returns correct / actual * 100 rounded to 2 decimals", {
  expect_equal(percentCorrect(8,10),80.00)
  expect_equal(percentCorrect(457,1800),25.39)
})

test_that("mostOccurring returns the most often element in a vector with ties broken at random",{
  v<-c("standing","standing","standing")
  expect_equal(mostOccurring(v),"standing")
  v<-c("standing","standing","sitting")
  expect_equal(mostOccurring(v),"standing")
  v<-c("standing","sitting","sitting")
  expect_equal(mostOccurring(v),"sitting")
  v<-c("standing","sitting","sitting","standing")
  expect_true(mostOccurring(v) %in% c("sitting","standing"))
  v<-c("standing","sitting","sitting","sitting")
  expect_equal(mostOccurring(v),"sitting")
  v<-c("standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(mostOccurring(v),"sitting")
  v<-c("a","a","a","b","b")
  expect_equal(mostOccurring(v),"a")
})

test_that("numMost returns the count of the element(s) occurring the most times in vector",{
  v<-c("standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(numMost(v),3)
  v<-c("standing","standing","standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(numMost(v),3)
  v<-c("sitting","standing","standing","standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(numMost(v),4)
  v<-c("sitting","standing","laying","walking downstairs")
  expect_equal(numMost(v),1)
})

test_that("namesMost returns the names of the element(s) occurring the most times in vector",{
  v<-c("standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(namesMost(v),"sitting")
  v<-c("standing","standing","standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(setdiff(namesMost(v),c("sitting","standing")),character(0)) 
  v<-c("sitting","standing","standing","standing","sitting","sitting","sitting","laying","walking downstairs")
  expect_equal(namesMost(v),"sitting")
  v<-c("sitting","standing","laying","walking downstairs")
  expect_equal(setdiff(namesMost(v),c("sitting","standing","laying","walking downstairs")),character(0))
})



