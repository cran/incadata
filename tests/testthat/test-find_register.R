context("incadoc")

test_that("bmatch", {
  expect_equal(bmatch(c("hej", "pa", "dig"), "hej"), c(TRUE, FALSE, FALSE))
  expect_error(bmatch(c("hej", "pa", "dig"), "hejsan"), 
    "No match. Choose one of")
})

test_that("find_register", {
  expect_equal(find_register("all"), "akut lymfatiskt leukemi all") %>% 
  expect_silent()
  expect_error(find_register("hejsansvejsan"), 
    "No match. Choose one of")
  expect_error(find_register("akut"),
    "Muliple diagnoses found")
})


test_that("find_documents", {
  skip_on_cran()
  skip_on_appveyor()
  
  expect_gte(nrow(find_documents("all")), 5)
  expect_gte(nrow(find_documents("peniscancer", "uppfoljning")), 2)
})


test_that("documents", {
  skip_on_cran()
  skip_on_appveyor()
  
  expect_message(
    documents("lunga", "uppfoljning", dir = tempdir(), max_open = 0),
    "2 files downloaded to"
  )
  expect_silent(
    documents("lunga", "uppfoljning", dir = tempdir(), max_open = 0))
  
})
