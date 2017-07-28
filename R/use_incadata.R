#' Use incadata from file or dataframe df
#' 
#' Read in a file (locally) or use global object named \code{df} (on INCA) 
#' and coerce to \code{incadata}-object.
#'   
#' @section Cache: To process all data through \code{\link{as.incadata}} can be
#'   time consuming for large data sets. It is therefore advised to use caching 
#'   (argument \code{cache = TRUE}) to avoid unnecessary processing of already
#'   formatted data. If \code{cache = TRUE}, the function will read and process
#'   the data only the first time (or if the original data is later changed). A
#'   processed and cached version of the data is saved with suffix ".rds". The
#'   cached version is always compared to the original file by its MD5 sum and 
#'   is always updated if needed.
#'
#' @param file file name as character (ignored if called from INCA)
#' @param cache use cache to speed up the loading (see section: "Cache" below)
#' @param ... arguments passed to \code{\link{as.incadata}}.
#' @param sep,dec arguments passed to \code{\link{read.csv2}}
#' 
#' @return object returned by \code{\link{as.incadata}} 
#' 
#' @export
#' @examples 
#' \dontrun{
#' # Create a csv file with example data in a temporary directory
#' fl <- tempfile("ex_data", fileext = ".csv2")
#' write.csv2(incadata::ex_data, fl)
#' 
#' # First time the file is read from csv2
#' use_incadata(fl)
#' dir(tempdir) # a cache file is saved along the original csv2-file
#' use_incadata(fl) # Next time file loaded from cache
#' }
use_incadata <- 
  function(file, cache = TRUE, sep = ";", dec = ",", ...) {
  
  get_data <- function() {
    utils::read.csv2(file, sep = sep, dec = dec, 
      colClasses = "character", fileEncoding = "UTF-8")
  }
  
  fresh <- function(x) {
    attr(x, "cache_md5") == tools::md5sum(file)
  }
  
  file.rds    <- paste0(file, ".rds")
  file_exists <- file.exists(file.rds)

  if (rccmisc::is.inca()) { 
    suppressMessages(as.incadata(get0("df", .GlobalEnv), ...))
  } else if (cache && file_exists && fresh(x <- readRDS(file.rds))) {
    message("Use cached file created ", attr(x, "cache_date"))
    x
  } else {
    x <- as.incadata(get_data(), ...)
    if (cache) {
      saveRDS(structure(x, cache_date = Sys.time(), 
        cache_md5 = tools::md5sum(file)), file.rds)
      message("Cache file saved: ", file.rds)
    }
    x
  }
}
