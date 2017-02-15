#' Coerce to object of class "incadata"
#' 
#' Functions to check if an object is of class \code{incadata}, or coerce it if
#' possible.
#' 
#' If the function is called on a "big" data set, it might be time consuming and
#' it might be quite verbose about performed class transformation. It would
#' probably be worth the time when run locally for a specified task but if run
#' as production code on INCA, some caution might be advised! Use
#' \code{\link{suppressMessages}} to avoid the verbose output. 
#' 
#' @param x vector or data frame with data from INCA or Rockan.
#' @param decode Should \code{\link{decode}} be applied to variables with 
#'   identified variable names? (\code{TRUE} by default).
#' @param id Should an id-column be added? This is based on PERSNR/PNR/PAT_ID if
#'   available (in that order) but is not set to \code{NA} for non valid pins
#'   (see \code{\link{as.pin}}).
#' @param n_i used internally 
#' @param ask ask for input if unsure how to coerce variables 
#' @param ... arguments passed to \code{\link{exceed_threshold}}
#'    
#' @return 
#' \describe{
#'  \item{\code{as.incadata.data.frame}}{object of class
#'     \code{incadata} based on the "tibble"-class used within the "tidyverse"}
#'   \item{\code{as.incadata.default}}{
#'     input coerced to relevant class} 
#'   \item{\code{is.incadata}}{\code{TRUE} if its argument is of class 
#'     \code{incadata} and \code{FALSE} otherwise.}
#' }    
#' @import backports
#' @export
as.incadata <- function(x, ...) UseMethod("as.incadata")

#' @export 
as.incadata.incadata <- function(x, ...) x

#' @rdname as.incadata
#' @export
is.incadata <- function(x) inherits(x, "incadata")
