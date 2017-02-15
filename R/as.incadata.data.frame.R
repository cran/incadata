#' @export
#' @rdname as.incadata
as.incadata.data.frame <- function(x, decode = TRUE, id = TRUE, ask = TRUE, ...) 
{
  
  ## Use lower case variable names
  x <- rccmisc::lownames(x)
  
  ## Store original classes for later message
  oc <- vapply(x, function(x) class(x)[1], character(1))
  
  # as.incadata for each column of x
  x <- mapply(as.incadata, x, names(x), SIMPLIFY = FALSE,
        MoreArgs = list(ask = ask, ...))
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  
  ## Print a message if any class changed
  nc          <- vapply(x, function(x) class(x)[1], character(1))
  fac2char    <- oc == "factor" & nc == "character"
  otherchange <- oc != nc & !fac2char
  if (any(fac2char)) {
    message("Factors coerced to character: ", 
      paste(names(x)[fac2char], collapse = ", ")
    )
  }
  if (any(otherchange)) {
    message(
      "The following variables have new formats: \n* ",
      paste(paste0(format(names(x)[otherchange]), " (", 
        oc[otherchange], " -> ", nc[otherchange], ")"), collapse = "\n* ")
    )
  }
  
  if (decode) {
    x <- decoder::decode(x)
  }
  if (id) {
    x$id <- id(x)
  }
  
  x <- dplyr::as.tbl(x)
  structure(x, class  = unique(c("incadata", class(x))))
}
