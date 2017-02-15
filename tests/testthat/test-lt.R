context("lt")

test_that("misc", {
  expect_is(lt(from = Sys.Date(), Sys.Date() + 10), "numeric")
  expect_equal(lt(from = Sys.Date(), Sys.Date() + 10), 10)
})
