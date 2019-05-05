---
output: github_document
---



[![Build status](https://ci.appveyor.com/api/projects/status/16otxht7x1aojrcy?svg=true)](https://ci.appveyor.com/project/eribul/incadata)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/incadata)](https://cran.r-project.org/package=incadata/)
![Monthly downloads](http://cranlogs.r-pkg.org/badges/incadata)
![Total downloads](http://cranlogs.r-pkg.org/badges/grand-total/incadata)


# incadata <img src = "https://bitbucket.org/cancercentrum/incadata/raw/master/man/figures/hexsticker.png" align = "right" width="175" height="200" />

The goal of incadata is to provide basic functionality to handle data from INCA and the Regional cancer centers in Sweden. 



## Installation

You can install the released version of incadata from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("incadata")
```

And the development version from [BitBucket](https://bitbucket.org/) with:

``` r
# install.packages("devtools")
devtools::install_bitbucket("cancercentrum/incadata")
```

## Standardised data sets

The function `as.incadata` standardize data from INCA and Rockan:

* All date formats used by Rockan are recognized as dates and coerced to such (for example: `1985-05-04`, `""`, `19850504`, `19850500`
, `19850000` and `8513`).
* Booleans are numeric vectors in INCA: `c(0, 1, 0, 1, 0, 0)`, but coerced to character when exported: `c(NA, "True", NA, "True", NA, NA)`. The package recognise this 
peculiarity and coerce to Boolean.
* Personal identity numbers are recognised even if they end with "X" etcetera (used in Rockan).
* Standard numerical codes from Rockan are decoded (using the [decoder](https://bitbucket.org/cancercentrum/decoder) package).
* Column names are always coerced to lower case, since these are generally easier to work with.
* Data frames are coerced to [tibbles](https://tibble.tidyverse.org/) .
* An `id` column is always added to data frames in order to always have an identification variable at hand (regardless if the data has none or one of "PERSNR", "PNR" or "PAT_ID")


## Register documentation

The package also provides functionality for easier access and archiving of register documentation (se vignette "incadoc") and function `documents`.


## Additional functionality

The package also lets you ...

* ... cache your data sets between work sessions in on order to speed up the data loading and munging process
* ... use a single data reading/munging function regardless if you work on INCA or locally
* ... interactively engage in the coercing process of variable formats. This is handy for example if a variable is almost a date but has some additional entries that are not recognised as such.


# Code of conduct

Please note that the 'incadata' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
