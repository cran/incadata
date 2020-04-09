context("incadoc")

test_that("find_register", {
  skip_on_cran()
  skip_on_appveyor()
  
  expect_equal(names(find_register("all")), "akut-lymfatiskt-leukemi-all") %>% 
  expect_silent()
  expect_error(find_register("hejsansvejsan"), 
    "No match. Choose one of")
  expect_error(find_register("akut"),
    "Muliple diagnoses found")
})


test_that("find_documents", {
  skip_on_cran()
  skip_on_appveyor()
  
  expect_gte(length(find_documents(find_register("all"))), 6)
  expect_gte(
    length(find_documents(find_register("peniscancer"), "uppfoljning")), 1)
})


test_that("documents", {
  skip_on_cran()
  skip_on_appveyor()
  
  expect_message(
    documents("lunga", "uppfoljning", dir = tempdir(), max_open = 0),
    "1 file\\(s\\) downloaded"
  )
  expect_silent(
    documents("lunga", "uppfoljning", dir = tempdir(), max_open = 0))
  
})
