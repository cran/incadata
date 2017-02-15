## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(dplyr))
library(incadata)
dim(ex_data)

## ------------------------------------------------------------------------
x <- 
  ex_data %>% 
  select(
    a_lkf,
    a_inrappdatum,
    a_inrappsjh,
    a_inrappklk, 
    a_kompl,
    a_rappSjHemSj_Beskrivning
  )

## ------------------------------------------------------------------------
glimpse(x)

## ------------------------------------------------------------------------
x2 <- as.incadata(x)

## ------------------------------------------------------------------------
glimpse(x2)

## ------------------------------------------------------------------------
# Save data as csv2 in temp file
fl <- tempfile("ex_data", fileext = ".csv2")
write.csv2(incadata::ex_data, fl, row.names = FALSE)

## ---- warning=FALSE------------------------------------------------------
system.time(
  x <- use_incadata(fl)
)

## ------------------------------------------------------------------------
system.time(
  x <- use_incadata(fl)
)

