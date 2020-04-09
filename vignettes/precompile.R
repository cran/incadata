# Vignettes that needs internet connection have been precompiled:
# We change wd to ease of use with caching

knitr::knit("vignettes/incadoc.Rmd.orig", "vignettes/incadoc.Rmd")
rmarkdown::render("vignettes/incadoc.Rmd", output_file = "incadoc.html")

file.copy("vignettes/incadoc.html", "inst/doc/incadoc.html", overwrite = TRUE)
