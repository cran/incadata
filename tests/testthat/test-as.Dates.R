ds <- c(1212121212, "20000101", "2014-10-15", 5806)
ds2 <- c(19121212, "20000101", "2014-10-15", 5806)

context("as.Dates.default")

test_that("input unchanged",{
  expect_identical(as.Dates("kjhg"), as.Date(NA))
  expect_identical(as.Dates(123), as.Date(NA))
   expect_warning(as.Dates("12121212"),
                 "< 1830! Not realistic for RCC data!")
  expect_equal(as.Dates(NA), as.Date(NA))
})

test_that("simple input", {
  expect_equivalent(as.Dates(19850504), as.Date("1985-05-04"))
  expect_equivalent(as.Dates(ds2),
    as.Date(c("1912-12-12", "2000-01-01", "2014-10-15", "1958-02-08")))
})


test_that("Mixed input", {
  expect_equivalent(suppressWarnings(as.Dates(ds)),
    structure(c(-276508, 10957, 16358, -4345), class = "Date"))
  expect_warning(as.Dates(ds))
})

test_that("SKAPAD_DATUM", {
  expect_is(as.Dates("2016-04-06 10:01:22.780"), "Date")
})

test_that("Future data", {
  expect_warning(as.Dates(as.character(Sys.Date() + 1)))
})
