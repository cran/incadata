context("id")

df <- ex_data
df$pnr <- df$PAT_ID
df$Persnr <- 1

ids <- 
  data.frame(
    bad_name = sweidnumbr::as.pin(c(
      189001019802, 189001029819, 189001039800, 189001049817, 189001059808, 
      189001069815, 189001079806, 189001089813, 189001109819, 
      189001119800, 189001129817, 189001139808, 189001149815, 189001159806, 
      189001169813, 189001179804
    ))
  )


test_that("id works", {
  expect_warning(expect_message(id(df), "persnr used as id!"))
  expect_message(id(df, ignore.case = FALSE), "pnr used as id!")
  expect_warning(id(df), "persnr, pnr, pat_id, pn, id")
  expect_message(id(ids), "bad_name used as id!")
  expect_message(id(mtcars), "rownames used as id!")
})
