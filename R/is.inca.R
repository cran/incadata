#' Check if R is running from INCA
#'
#' @param logical Should the return value be a simple boolean whether we
#' are running from INCA or not?
#'
#' @return Either \code{TRUE}\code{FALSE} if \code{logical = TRUE} or one of
#' "PROD", "TEST" or "LOCAL" depending on were R is running
#' (if \code{logical = FALSE})
#'
#' @export
#' @examples
#' is.inca()
is.inca <- function(logical = TRUE) {
  x <-
    switch(
      Sys.info()["nodename"],
      "EXT-R27-PROD" = "PROD",
      "EXT-R37-TEST" = "TEST",
      "LOCAL"
    )
  if (logical)
    x %in% c("PROD", "TEST")
  else x
}
