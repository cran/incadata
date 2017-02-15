context("misc")

test_that("print.incadata", {
  expect_output(
    suppressWarnings(print(as.incadata(incadata::ex_data))), "# incadata")
})
