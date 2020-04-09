context("use_incadata")

suppressMessages(
  suppressWarnings(
  inc <- as.incadata(incadata::ex_data)
))

fl <- tempfile("ex_data", fileext = ".csv2")
write.csv2(incadata::ex_data, fl, row.names = FALSE)

# Some debugging info on Windows for R-hub
if (Sys.info()['sysname'] != "Darwin") {
  message("Using tempfile: ", fl)
  print(dir(tempdir(), "ex_data"))
  message("file size: ", round(file.size(fl) / 1024), " kb")
}


test_that("use_incadata", {
  skip_on_os("windows")
  expect_identical(suppressWarnings(use_incadata(fl)), inc)
  expect_message(suppressWarnings(use_incadata(fl)), "Use cached file created")
})

