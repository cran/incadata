context("bmatch")


test_that("bmatch", {
  expect_equal(bmatch(c("hej", "pa", "dig"), "hej"), c(TRUE, FALSE, FALSE))
  expect_error(bmatch(c("hej", "pa", "dig"), "hejsan"), 
    "No match. Choose one of")
  expect_equal(bmatch(names(iris), NULL), !logical(5))
  expect_equal(bmatch("hejapabanan", "aba"), TRUE)
  expect_equal(bmatch("1 lazy 2", "lasy"), TRUE)
  expect_equal(bmatch("foo", c("foobar", "foo")), c(FALSE, TRUE))
})
