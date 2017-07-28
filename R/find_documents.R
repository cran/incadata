#' List all documents for a register
#'  
#' @inheritParams find_register
#' @param pattern part of document name to look for
#'
#' @return data frame with names of documents and corresponding URL:s for 
#' specified register
#' @export
#'
#' @examples
#' \dontrun{
#' find_documents("all")
#' find_documents("peniscancer", "uppfoljning")
#' }
find_documents <- function(x, pattern = NULL) {
  
  url     <- urls$url[urls$diagnos == find_register(x)]
  webpage <- rvest::html_nodes(xml2::read_html(url), "a")
  
  # Make a data.frame with the pdf files link adress and 
  # their descriptive text from the webpage
  links <-
    data.frame(
      links = rvest::html_attr(webpage, name = "href"),
      names = rvest::html_text(webpage, TRUE),
      stringsAsFactors = FALSE
    )
  links <- links[grepl('.pdf', links$links) & links$names != "", ]
  
  # Make relative paths absolute
  links$links <- gsub("^/", "http://www.cancercentrum.se/", links$links)
  
  links <- links[!duplicated(links$links), ]
  links[bmatch(links$names, pattern), ]
}
