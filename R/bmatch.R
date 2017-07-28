# Return index of values of x mathed by pattern
# The b in bmatch stands for "best", since this is supposed to be the best 
# available match
bmatch <- function(x, pattern) {
  if (is.null(pattern)) return(rep(TRUE, length(x)))
  
  # IN the URL:s thare are only lowcase, no "cancer" and no aao
  pattern <- tolower(pattern)
  pattern <- gsub("cancer", "", pattern)
  pattern <- gsub("\u00E4|\u00E5", "a", pattern)
  pattern <- gsub("\u00F6", "o", pattern)
  
  ind <- 
    if (any(equal <- x == pattern)) {
      equal
    } else if (any(exactb 
            <- grepl(paste0("\\b", pattern, "\\b"), x, perl = TRUE))) {
      exactb  
    } else if (any(exact  <- grepl(pattern, x))) {
      exact  
    } else if (any(approx <- agrepl(pattern, x))) {
      approx
    }
  
  # Stop if no match
  if (!any(ind)) {
    stop("No match. Choose one of:\n * ",
         paste0(x, collapse = "\n * "))
  }
  ind
}
