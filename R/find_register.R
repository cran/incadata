#' Find register by name
#'
#' @param x name of register to look for
#'
#' @return Name of existing register according to <www.incanet.se>
#' @export
#'
#' @examples
#' find_register("all") # "akut lymfatiskt leukemi all"
#' \dontrun{
#' find_register("kronisk") # More than one possible alternative
#' }
find_register <- function(x = NULL) {
  if (is.null(x)) return(urls$diagnos)
  mtch <- bmatch(urls$diagnos_clean, x)
  if (sum(mtch) > 1)
    stop("Muliple diagnoses found. Choose one one:\n* ", 
         paste(urls$diagnos[mtch], collapse = "\n* "))  
  urls$diagnos[mtch]
}
