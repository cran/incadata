context("exportr")

# file to use while testing
file.create("tmp")

test_that("misc", {
  skip_on_appveyor()
  
  # Need to call CRAN from available.packages . Don't want to do that!
  skip_if_not(interactive())
  expect_warning(
    expect_message(
      exportr(package = "base", force = TRUE), "R-script saved as: "
    )
  )
  
  expect_error(
    exportr(package = "base", force = TRUE), "file already exist!"
  )
  
  skip_if(interactive())
  expect_warning(
    exportr(package = "base"), "only works in interactive mode!")
})

# Remove temp files
if (file.exists("./inca_r_script.R")) unlink("./inca_r_script.R")
if (file.exists("tmp")) unlink("tmp")
