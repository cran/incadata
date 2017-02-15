#' Coerce to logical if value is logical according to INCA
#' 
#' It is common that check boxes are blanks by default but that this should 
#' be interpreted as \code{TRUE}. There are however some uncommon cases
#' were the boxes are instead marked with "False" if \code{FALSE}, 
#' but otherwise left blank. 
#' We can therefore not be certain of a blank value and will therefore treat 
#' it as \code{NA}.
#' 
#' Note that logical vectors in INCA will behave differently when used 
#' internally in INCA. This is handled by the functions.
#' or w
#' 
#' @param x vector
#'
#' @return \code{is.incalogical} returns \code{TRUE} if the vector 
#' is logical according to INCA:s internal rules, \code{FALSE} otherwise.
#' \code{incalogical2logical} returns a logical vector if \code{x} 
#' can be coerced to such.
#' @export
#'
#' @examples
#' is.incalogical(c("", "", "True", ""))  # TRUE
#' is.incalogical(c("", "False", "", "")) # TRUE
#' is.incalogical(c("", "FALSE", "", "")) # FALSE
#' is.incalogical(logical(2)) # will be recognised as well
is.incalogical <- function(x) {
  if (is.logical(x) && !all(is.na(x))) {
    TRUE
  } else if (rccmisc::is.inca()) {
    is.numeric(x) & 
      (0 %in% x | 1 %in% x) & 
      all(x %in% c(0:1, NA))
  } else {
    x <- as.character(x)
    ("True" %in% x | "False" %in% x) & 
      all(x %in% c("True", "False", "", NA))
  }
}

#' @rdname is.incalogical
#' @export
incalogical2logical <- function(x) {
  stopifnot(is.incalogical(x))
  x <- as.character(x)
  ifelse(x %in% c(1, "True"),  TRUE, 
  ifelse(x %in% c(0, "False"), FALSE, NA))
}
