context("incalogical")

test_that("is.incalogical", {
  expect_true(is.incalogical(c("", "", "True", "")))
  expect_true(is.incalogical(c("", "False", "", "")))
  expect_false(is.incalogical(c("", "FALSE", "", "")))
  expect_true(is.incalogical(logical(2)))
})


test_that("incaogical2logical", {
  expect_equivalent(incalogical2logical(c("", "", "True", "False")),
    c(NA, NA, TRUE, FALSE))
})
