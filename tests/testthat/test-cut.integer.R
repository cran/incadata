context("cut.integer")

test_that("multiplication works", {
  
  levels(cut(1:100, seq(0, 100, 20))) %>% 
    expect_equal(c("1-20", "21-40", "41-60", "61-80", "81-100"))
  
  expect_is(cut(1:100, seq(0, 100, 20)), "ordered")
  expect_is(cut(1:10, 3), "factor")
  
})
