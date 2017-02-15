#' @importFrom dplyr %>% 
#' @export
dplyr::`%>%`

#' @export
print.incadata <- function(x, ...) {
  cat("# incadata\n")
  x <- as.data.frame(x)
  removeAsIs <- function(x) {
    cl <- class(x)
    class(x) <- cl[cl != "AsIs"]
    x
  }
  x <- as.data.frame(lapply(x, removeAsIs), stringsAsFactors = FALSE)
  suppressWarnings(print(dplyr::as.tbl(x)))
}


