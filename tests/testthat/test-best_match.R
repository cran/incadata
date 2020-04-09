
context("best_match")

test_that("misc", {
  
  expect_warning(
    best_match("petal", names(iris)) %>%
    expect_equivalent("Petal.Length")
  )
  
  expect_warning(best_match("petal", names(iris)))
    
  best_match("petal", names(iris), all = TRUE) %>%
    expect_equivalent(list(c("Petal.Length", "Petal.Width")))
  
  best_match(c("Hej_apa!", "erik", "babian"), 
             c("hej apa", "hej bepa", "kungen", "Erik")) %>% 
    expect_equal(c("hej apa", "Erik", NA))
  
  best_match(c("Hej_apa!", "erik", "babian"), 
    c("hej apa", "hej bepa", "kungen", "Erik"), clean_text = FALSE) %>% 
    expect_equal(c(NA, "Erik", NA))
  
  best_match(c("Hej_apa", "erik", "babian"),
     c("hej apa", "hej bepa", "kungen", "Erik"), no_match = "nothing") %>% 
    expect_equal(c("hej apa", "Erik", "nothing"))
  
  expect_warning(best_match("he", "hej"), "x is to short")
  expect_warning(expect_equal(best_match("he", "hej"), NA))
  expect_equal(best_match("he", "he"), "he")
  
  # No match
  expect_identical(best_match("foo", "bar", no_match = NULL), "foo")  # itself
  expect_identical(best_match("foo", "bar", no_match = "apa"), "apa") # apa
})
