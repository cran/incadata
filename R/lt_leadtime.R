#' Lead time from one date to another
#'
#' @param from,to start and stop dates (in formats that can be coerced by
#'   \code{\link{as.Dates}}).
#' @param neg.na should negative lead times be set to \code{NA}?
#' @return Numeric vector
#' @export
#' @examples
#' lt(from = Sys.Date(), to = Sys.Date() + 10)
lt <- function(from, to, neg.na = TRUE){
  x <- as.Dates(to) - as.Dates(from)
  if (neg.na) x[x < 0] <- NA
  as.numeric(x)
}
