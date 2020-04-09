context("is.inca")


test_that("is.inca", {
  expect_false(is.inca())
  expect_equal(is.inca(FALSE), "LOCAL")
})
