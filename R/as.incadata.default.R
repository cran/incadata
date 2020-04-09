#' @export 
#' @rdname as.incadata
as.incadata.default <- function(x, n_i = NULL, ...) {
    
  stopifnot(is.atomic(x))

  ## Take the name from x if not explicity specified
  if (is.null(n_i)) {
    n_i <- trimws(gsub("(=)|(<-).*$", "", as.character(match.call()[2])))
  }

  # Variables with these names are always character in INCA
  special_names <- paste(c(
    "(^pat_id$)", "(^kon_value$)", "(^region$)", "(^lan_value$)", 
    "(_beskrivning$)", "(_v\u00E4rde$)", "(_vaerde$)", 
    "(_gruppnamn$)", "(_id$)"), 
    collapse = "|"
  )
  
  as.chars <- function(x) specify_missing(trimws(as.character(x)))
  
  # A logical vector can only originate from tick marks. There is no potential 
  # for strange values there! We therefore do not need to use the usual 
  # checks with thresholds for these vectors.
  if (is.incalogical(x)) {
    return(incalogical2logical(x))
  }
  
  x_chr <- as.chars(x)
  mtch  <- function(pattern) 
    all(grepl(pattern, as.chars(stats::na.omit(x_chr))))
  
  x_new <- 
    if (is.object(x) && !is.factor(x)) {
      x
    } else if (tolower(n_i) %in% c("persnr", "pnr")) {
      sweidnumbr::as.pin(x)
    } else if (grepl(special_names, tolower(n_i))) {
      x_chr
    # If whole vector missing, its difficult to know what to do.
    # Boolean might be most logical but I do not want som many changes 
    # of vector type just dependent on data missing or not, 
    # therefore chr might be good to
    } else if (all(is.na(x))) {
      x_chr
    } else if (is_Date(x_chr)) {
      as.Dates(x_chr)
    # integer with non-leading 0 or 0 alone
    } else if (mtch("^([1-9]\\d*|0)$")) {
      as.integer(x_chr)
    # either _possible_ decimal number without leading 0, 
    # or decimal number starting with zero
    } else if (mtch("^([1-9]\\d?([.,]\\d*)?|0\\d*[.,]\\d*)$")) { 
      as.numeric(chartr(",", ".", x_chr))
    } else {
      x_chr
    } 
    
  ## We now let the exceed_threshold function decides the output
  suppressMessages(exceed_threshold(x, x_new, var_name = n_i, ...))
}
