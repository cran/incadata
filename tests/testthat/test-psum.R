context("psum")

## TODO: Rename context
## TODO: Add more tests

test_that("multiplication works", {
  expect_equal(psum(1:10, 1:10, 1:10), c(3, 6, 9, 12, 15, 18, 21, 24, 27, 30))  
})
