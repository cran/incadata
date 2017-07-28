#' Add id variables to data frame
#' 
#' Construct id variable for patient data. 
#'
#' @param x data frame
#' @param id names of a possible id variable found in \code{x}
#' @param ignore.case should name matching be done regardless of character case?
#' @return Character variable with either the first name from \code{id} found in 
#' \code{x} or \code{rownames(x)} if no named column found. 
#' @export

id <- function(
  x, 
  id = c("persnr", "pnr", "pat_id", "pn", "id"), 
  ignore.case = TRUE) {
  
  if (ignore.case) {
    x  <- rccmisc::lownames(x)
    id <- tolower(id)
  }
  
  # If there is exactly one pin vector, return its name (otherwise NULL)
  is_pin     <- vapply(x, sweidnumbr::is.pin, logical(1))
  pin        <- if (sum(is_pin) == 1) names(x)[is_pin]
  ids        <- c(id, pin)
  
  # extract columns with names from ids (if any)
  candidates <- x[, ids[ids %in% names(x)], drop = FALSE]

  # Use first column with name matching id, otherwise row names
  y <- ncol(candidates)
  message(if (y) names(candidates)[1] else "rownames", " used as id!")
  if (y) candidates[[1]] else rownames(x)
}
