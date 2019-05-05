
context("width")

test_that("misc", {
  expect_equal(width(list(1)), 1)
  expect_error(width("lkjh"))
  expect_equal(width(1:10), 10)
  expect_error(width(.5))
})
