#' Coerce to logical if value is logical according to INCA
#' 
#' Boolean vectors in INCA are stored internally as 0/1 and are changed to 
#' "True"/blank when exported. These functions identify such a variable as 
#' Boolean and can coerce it to such.
#' 
#' It is common that check boxes are blanks by default but that this should 
#' be interpreted as \code{TRUE}. There are however some uncommon cases
#' were the boxes are marked with "False" for \code{FALSE}. 
#' We can therefore not be certain of the meaning of a blank value. 
#' These will therefore be treated as \code{NA}.
#' 
#' @param x vector (potentially logical)
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
  } else if (is.inca()) {
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
