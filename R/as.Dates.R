#' Converting potential date to Date vector
#'
#' The function recognises dates in formats used by INCA and Rockan.
#' 
#' @param x atomic vector
#' @return recognised date vector converted to date, 
#' otherwise \code{x} unchanged
#' @examples
#' as.Dates(c(1212121212, "20000101", "2014-10-15", 5806))
#' @seealso \link{as.Date}
#' @export
as.Dates <- function(x) {
  
  if (inherits(x, "Date")) return(x)
    x[x == ""] <- NA
  
  # Remove both dashes in ordinary dates but also times stamps for
  # POSIXct dates (such as SKAPAD_DATUM)
  x <- gsub("-| \\d{2}:\\d{2}:\\d{2}(.\\d{3})?( \\w{3})?$", "", as.character(x))
  
  # Add century 19 if missing
  x <- gsub("^([5-8]\\d{3}|\\d{6})$", "19\\1", x, perl = TRUE)
  # Change unknown month to 1 July and unknown day to 15
  x <- gsub("^(1[89]|20\\d{2})0000$", "\\10701", x, perl = TRUE)
  x <- gsub("^(1[89]|20\\d{4})00$",   "\\115", x, perl = TRUE)
  
  # change week number to estimated date
  x <- ifelse(grepl("^19\\d{4}$", x), format(yw2date(x), format = "%Y%m%d"), x)
  
  # Let the threshold function decide what to return
  x <- as.Date(x, format = "%Y%m%d")
  
  # warn for years before 1830
  if (inherits(x, "Date") && !all(is.na(x))) {
    if (any(x < as.Date("1830-01-01"), na.rm = TRUE))
      warning("year < 1830! Not realistic for RCC data!")
    if (any(x > Sys.Date(), na.rm = TRUE))
      warning("date(s) in the future! Not realistic for RCC data!")
  }
  x
}

# Estimated date from year and week number
yw2date <- function(x) {
  y <- substr(x, 1, 4)
  w <- as.numeric(substr(x, 5, 6))
  day <- function(day) as.Date(ifelse(is.na(y), NA, paste0(y, day)))
  day("-01-01") + 
    (as.integer(format(day("-01-03"), "%w")) + 6) %% 7 + 7 * (w - 1) - 1
}

# First check if date is at all possible
is_Date <- function(x) {
  # extract date part (if POSIXct)
  x <- substr(as.character(x), 1, 10)
  x <- gsub("-", "", x)
  all(grepl(paste0(
    # yyww or yyyyww
    "^((19)?[5-8]\\d([0-4]\\d|5[0-3])|", 
    # Ymd
    "((1[89]|20)\\d{2})(0\\d|1[0-2])([0-2]\\d|3[01]))$"), 
    stats::na.omit(x)), na.rm = TRUE)
}
