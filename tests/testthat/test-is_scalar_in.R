context("is_scalar_in")

test_that("is.scalar_in", {
  expect_is(is.scalar_in(0, 1), "function")
  expect_false(is.scalar_in(0, 1)(3))
  expect_true(is.scalar_in(0, 1)(.5))
})


test_that("is.scalar_in01", {
  expect_true(is.scalar_in01(1))
  expect_false(is.scalar_in01(2))
})
