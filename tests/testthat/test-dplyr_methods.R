context("dplyr methods")

testdata <- 
  suppressMessages(
    incadata::as.incadata(
      data.frame(
        persnr = sweidnumbr::as.pin(c(198505043334, 191212121212, 192301011212))
      )
    )
  )


test_that("filter", {
  expect_is(dplyr::filter(testdata, persnr == 198505043334)$persnr, "pin")
  expect_is(dplyr::filter(testdata, persnr == 198505043334), "incadata")
  expect_is(next_method(), "function")
})
