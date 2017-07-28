#' Synthetic example data from INCA
#' 
#' A data set resembling the typical form of INCA data. Variable names are real
#' but all data has been carefully anonymised!
#' 
#' All data is random! There is no logical relation between any
#' variables, not even between \code{x_Beskrivning} and \code{x_Varde}!
#' 
#' @format A data frame (not an object of class \code{incadata} 
#' with 497 rows and 433
#'   variables
#'   
#' @examples 
#' # Inspect the data
#' dplyr::glimpse(ex_data)
#' 
#' # Coerce to incadata
#' as.incadata(ex_data)
"ex_data"
