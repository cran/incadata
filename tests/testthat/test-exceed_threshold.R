context("exceed_threshold")

x <- c(rep("2012-01-01", 9), "foo")

test_that("exced_threshold", {
  expect_message(exceed_threshold(x, as.Date(x)))
  expect_message(expect_equal(exceed_threshold(x, as.Date(x)), x))
  
  expect_warning(exceed_threshold(x, as.Date(x), force = TRUE),
    "the input vector coerced to Date with foo set to NA!")
  
  expect_equal(exceed_threshold(x, as.Date(x), threshold = 1), x)
               
  expect_warning(
    exceed_threshold(x, as.Date(x), var_name = "bar", force = TRUE), "bar")
  
  expect_message(
    exceed_threshold(1:10, as.numeric(1:10)), 
    "the input vector coerced to numeric")
  
  expect_message(
    exceed_threshold(1:10, 1:10), "the input vector coerced to integer")
  expect_equal(exceed_threshold(1:10, 1:10), 1:10)

  # Require user input  
  skip_if_not(interactive())
  expect_message(exceed_threshold(x, as.Date(x), ask = TRUE))

})
