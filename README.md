[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/d2qnwrw56lb9varl/branch/master?svg=true)](https://ci.appveyor.com/project/erik_bulow/incadata)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)



incadata
============

Package to handle datasets in INCA format

The package is primarly used to create a new data object of 
class "incadata" (inharating from class "tbl" in dplyr). All variables are 
coerced to suitable classes based on their format. Dates are recognised as 
dates (through the rccdates package), logical variables (with values "" 
and "True" in INCA) will be boolean, variablev with names ending in 
"_Beskrivning" and "_Varde" will be factors, variable with name "PERSNR" will 
be coerced to "pin" (by the "sweidnumbr" package) etcetera.


# Install
The package is primarly intended for use as a part of the `rcc2` package but can also be installed independently:
```
devtools::install_bitbucket("cancercentrum/incadata")
```
# Introduction

The package contains two vignettes. Find them after installation by 
`browseVignettes("incadata")`.
