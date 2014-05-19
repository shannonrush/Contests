library(testthat)
source("../exploratory/boosting.R")
context("boosting as specified by Breiman Arcing-x4")

test_that("denom returns the sum of misclassifications ^4 + 1",{
  mc <- c(1,0,1)
  expect_equal(denom(mc),5)
  mc <- c(0,0,2)
  expect_equal(denom(mc),19)
})

test_that("prob returns the misclassification ^4 + 1 divided by denom",{
  expect_equal(prob(1,5),0.4)
})


