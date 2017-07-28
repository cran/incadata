#' Converting potential date to Date vector
#'
#' The function recognises dates in formats used by INCA and Rockan.
#' 
#' Regular expressions are used to match any of the following date formats:
#' \itemize{
#'   \item \code{Y-m-d}: The ISO 8601 standard such as "2017-02-16" as used by INCA.
#'   \item \code{Ymd}: such as "20160216" as used by the Rockan registers
#'   \item Any of the above with missing day such as "2017-02-00" or "20170200" as used if the exact date is unknown.
#'   \item Any of the above with missing month such as "2017-00-00" or "20170000" as sometimes used if the exact date is unknown.
#'   \item Dates between 1950 and 1980 can have missing century prefix, such as "67-01-01", "670101", "670100", "670000" etcetera as earlier used for some dates in the Rockan registers.
#'   \item Dates from the 20th century can also have month and day changed to week number such as "6723" or "196723" as sometimes used for death dates in the cancer register (originating from the population register).
#'   \item The special INCA variable \code{SKAPAD_DATUM} is also recognised as data but is originally a date and time object (\code{\link{POSIXct}}
#' }
#' 
#' All dates are coerced to \code{Y-m-d} (ISO 8601):
#' \itemize{
#'   \item a missing day is set to 15
#'   \item a missing month is set to July
#'   \item a week number is translated to the "median day" of that week
#'   \item \code{SKAPAD_DATUM} has its time stamp dropped
#' }
#' An alternative would be to use random assignments of dates within specified periods. This would have some benefits but does not conform to behavior used elsewhere by INCA.
#' 
#' @section Possible date range:
#' 
#' All potential dates are accepted as such. RCC data should however only contain historic data. Dates from the future does therefore raise warnings. The same is true for dates before 1830. The Swedish cancer register was initiated in 1958. The earliest possible dates found in the register should therefore originate from birth date of really old people diagnosed with cancer during that year.
#' 
#' @param x atomic vector
#' @return vector of class "Date"
#' @examples
#'
#' as.Dates(c(1212121212, "20000101", "2014-10-15", 5806))
#' 
#' \dontrun{
#' # Note that the as.Date (as oppose to as.Dates) 
#' # does not handle missing dates as empty strings 
#' as.Date(c("", "2017-02-16")) # Error
#' as.Dates(c("", "2017-02-16")) # NA "2017-02-16"
#' }
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
