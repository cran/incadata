#' Find links from web page
#'  
#' @param url URL to web page with links (must be under 'www.cancercentrum.se')
#' @param select select only links matching specified pattern
#' 
#' @return Named character vector with absolute URLs to links found 
#' on 'www.cancercentrum.se'
#' 
#' @examples 
#' \dontrun{
#' # Find e-mailadresses to spam
#'  find_links(
#'    "https://cancercentrum.se/vast/om-oss/kontakta-oss/", 
#'    "mailto:"
#'  )
#' }
find_links <- function(url, select = NULL) {
  
  webpage <- rvest::html_nodes(xml2::read_html(url), "a")
  
  # Character vector with link adress and 
  # their descriptive text from the webpage as names
  links <- stats::setNames(
    rvest::html_attr(webpage, name = "href"),
    rvest::html_text(webpage, TRUE)
  )
  if (!is.null(select)) links <- links[grepl(select, links)]
  
  # Make relative paths absolute
  links <- gsub("^/", "http://www.cancercentrum.se/", links)
  
  links[!duplicated(links)]
}
