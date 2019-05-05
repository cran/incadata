#' List URLS to documents for a register
#'  
#' @param url url to web page where to look for documents
#' @param doc (part of) document name to look for
#'
#' @return names character vector with urls to documents
#' @export
#'
#' @examples
#' \dontrun{
#' find_documents(find_register("all"))
#' find_documents(find_register("peniscancer"), "uppfoljning")
#' }
find_documents <- function(url, doc = NULL) {
  links <- find_links(url, '.pdf')  
  links[bmatch(names(links), doc)]
}
