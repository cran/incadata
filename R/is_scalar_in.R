
#' Test if scalar is in interval
#' 
#' @param x R object to be tested, most likely a numeric vector of length one 
#' (other formats are allowed but will always return \code{FALSE}).
#' @param left,right lower and upper bound
#' @return
#' \code{is.scalar_in01} returns \code{TRUE} if \code{x} is an atomic vector of 
#' length one and \code{0 <= as_numeric(x) <= 1}.
#' \code{is.scalar_in} return a function similar to \code{is.scalar_in01} but with 
#' specified boundaries.
#' @export
#' @name is.scalar_in
#' @examples
#' is.scalar_in01(.5) # TRUE
#' is.scalar_in01(5) # FALSE
#' 
#' is_scalar_in09 <- is.scalar_in(0,9)
#' is_scalar_in09(5) # TRUE
is.scalar_in  <- function(left, right){
  function(x){
    length(x) == 1 && 
    is_numeric(x) && 
    as_numeric(x) >= left && 
    as_numeric(x) <= right
  }
}

#' @export
#' @rdname is.scalar_in
is.scalar_in01 <- is.scalar_in(0, 1)
