context("dplyr methods")

testdata <- 
  suppressMessages(
    as.incadata(
      data.frame(
        persnr = sweidnumbr::as.pin(c(191212121212, 192301011212))
      )
    )
  )

test_that("filter", {
  expect_is(dplyr::filter(testdata, persnr == 191212121212)$persnr, "pin")
  expect_is(dplyr::filter(testdata, persnr == 191212121212), "incadata")
  expect_is(next_method(), "function")
})
