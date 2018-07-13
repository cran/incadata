#' Lead time from one date to another
#'
#' @param from,to start and stop dates (in formats that can be recognized as RCC dates).
#' @param neg except negative lead times (set to \code{NA} if \code{neg = FALSE})?
#' @return Numeric vector
#' @export
#' @examples
#' lt("2017-02-10", "2017-02-16") # 6
#' lt("2017-02-16", "2017-02-10") # negative lead times ignored by default
#' lt("2017-02-16", "2017-02-10", TRUE) # -6
lt <- function(from, to, neg = FALSE){
  x <- as.Dates(to) - as.Dates(from)
  if (!neg) x[x < 0] <- NA
  as.numeric(x)
}
