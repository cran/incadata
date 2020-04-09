#' Clean/standardize text
#'
#' Removes punctuation and spaces from character string. Also makes it lower case.
#' @param x a character string to "clean"
#' @return the cleaned character string (no punctuation, spaces or capital letters)
#' @examples
#' clean_text("HELLO_World!!!")
#' @export
#' @seealso \link{best_match}
clean_text <- function(x) {
  x <- tolower(gsub("[^[:alnum:]]", "", x))
  x <- gsub("\u00E4|\u00E5", "a", x)
  gsub("\u00F6", "o", x)
}

