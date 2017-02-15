context("as.incadata.data.frame")

suppressWarnings(
  suppressMessages(inc <- as.incadata(incadata::ex_data))
)

test_that("is.incadata", {
  expect_false(is.incadata(iris))
  expect_true(is.incadata(inc))
})

test_that("as.incadata.dataframe", {
  expect_identical(as.incadata(inc), inc)
})
