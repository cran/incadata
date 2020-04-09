
context("specify_missing")

test_that("specify_missing", {
  expect_equal(specify_missing(1:8), 1:8)
  expect_equal(specify_missing(1:8, 5), c(1:4, NA, 6:8))
  expect_equal(specify_missing(c(NA, "", "apa    ", "        ", "hej")), 
              c(NA, NA, "apa    ", NA, "hej"))
})

test_that("methods", {
  expect_equal(specify_missing.factor(factor(letters[1:10]), "a", "b", "c"),
    structure(c(NA, NA, NA, 1L, 2L, 3L, 4L, 5L, 6L, 7L), 
      .Label = c("d", "e", "f", "g", "h", "i", "j"), class = "factor"))
  expect_equal(
    specify_missing.list(list(a = c(1, 2, 99), b = c("apa", "hej")), 99, "apa"),
    list(a = c(1, 2, NA), b = c(NA, "hej")))
  expect_equal(specify_missing.data.frame(
    data.frame(a = c(1, 2, 99), b = c("apa", "bepa", "hej")), 99, "apa"),
    data.frame(a = c(1:2, NA), b = c(NA, "bepa", "hej")))
  expect_equal(specify_missing.matrix(diag(1:2), 2), matrix(c(1, 0, 0, NA), 2))
})
