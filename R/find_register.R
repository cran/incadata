#' Find register by name
#' 
#' The specified name does not need to be exact since a search algorithm is
#' applied to match existing registers. Names of the registers 
#'
#' @param reg name of register to look for
#'
#' @return Named character vector with URL to specified register
#' @export
#'
#' @examples
#' find_register("all")
#' \dontrun{
#' find_register("kronisk") # More than one possible alternative
#' }
find_register <- function(reg = NULL) {
  url     <-                 "http://www.cancercentrum.se/"
  url_dia <- paste0(url,     "samverkan/cancerdiagnoser")
  links   <- find_links(url, '/kvalitetsregister/dokument/')
  
  names(links) <- 
    gsub("(.*\\/)([\\w\\-]+)(\\/kvalitetsregister\\/dokument\\/)", "\\2", 
         links, perl = TRUE)
  
  if (is.null(reg)) return(links)
  mtch <- bmatch(names(links), reg)
  if (sum(mtch) > 1)
    stop("Muliple diagnoses found. Choose one one:\n* ", 
         paste(names(links)[mtch], collapse = "\n* "))  
  links[mtch]
}
