[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/d2qnwrw56lb9varl/branch/master?svg=true)](https://ci.appveyor.com/project/erik_bulow/incadata)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/incadata)](https://cran.r-project.org/package=incadata/)
![Monthly downloads](http://cranlogs.r-pkg.org/badges/incadata)
![Total downloads](http://cranlogs.r-pkg.org/badges/grand-total/incadata)


**NOTE: This package is still in beta! Please report any issue!**

incadata
============

## Motivating example

Some INCA formats are strange!

1. All of these are valid dates: `1985-05-04`, `""`, `19850504`, `19850500`
, `19850000`, `8513`
2. This is an INCA internal Boolean: `c(0, 1, 0, 1, 0, 0)`
3. This is an INCA exported Boolean: `c(NA, "True", NA, "True", NA, NA)`
4. This is a valid personal identification number: `19470101000X` (note the last "X")

The workflow of INCA today requires that you use a data frame "df" online but that you instead read in your data from disk offline. This force you to work either with different prescripts based on development stage, or to include an "if else"" clause identifying the current environment. 

To work with register data often require good knowledge about form structure and access to register documentation, which must be found online. 


## What can "incadata" do for you?

The `incadata` package will recognize all peculiarities above and will coerce all formats into reasonable ones. It will also:

* Always use lower case names since these are generally easier to work with
* Treat data frames as "tibbles" since these have some advantages over regular data frames.
* Add an `id` column to data frames in order to always have an identification variable at hand (regardless if the data has none or one of PERSNR, PNR or PAT_ID)
* Enhance the data with some automatically decoded variables (relying on the decoder package)
* Let you cache your data sets between work sessions in on order to speed up the data loading and munging process
* Let you use a single data reading/munging function regardless if you work on INCA or locally
* The package also contains a mechanism for you to interactively engage in the coercing process of variable formats. This is handy for example if a variable is almost a date but has some additional entries that are not recognised as such.
* Finally, there is also a mechanis for project documentation for easu acces and storage of INCA register documentation (see vignette "incadoc").


## Introduction

Some learning resources in their recommended order. Note that these refer to the published CRAN version of the documentation. Please also confirm any uncertenties with the current development versions after installing the package from Bitbucket (documentation might differ heavily during the initial development and evaluation phase of the package).

1. [Vignette: incadata](https://CRAN.R-project.org/package=incadata/vignettes/incadata.html)
2. [Vignette: rccdates](https://CRAN.R-project.org/package=incadata/vignettes/rccdates.html)
3. [Vignette: incadoc](http://rpubs.com/eribul/incadoc)
4. [function documentation](https://www.rdocumentation.org/packages/incadata/versions/0.5.3)
5. [PDF Reference manual](https://CRAN.R-project.org/package=incadata/incadata.pdf)


## Install
```
# A stable version of the package can be installed from CRAN:
install.packages("incadata")

# The lates development version can be installed from Bitbucket:
Set argument `build_vignettes = TRUE` to also build the vignettes linked above
devtools::install_bitbucket("cancercentrum/incadata")
```
