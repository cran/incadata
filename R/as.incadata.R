#' Identify data formats used by INCA and Rockan
#'
#' Coerce data of any form to its relevant type as identified either by 
#' column/vector names or by variable content and convert all variable names to 
#' lower case.
#'
#' Vectors are coerced to identified formats in the following order: 
#' \itemize{
#'   \item vectors recognized as Boolean by \code{\link{is.incalogical}} are
#' coerced to logical (this is a strict format than can not be contaminated with 
#' any unwanted values, section "interactive use" below does therefore not apply 
#' to these values)
#'   \item vectors with an already specified class attribute
#' (except the common "factor" class) remains as members of that class \item
#' columns or vectors names 'persnr' or 'pnr' will be coerced to the 'pin' class
#' by \code{\link{as.pin}} 
#'   \item columns or vectors with names ending in
#' '_Beskrivning', '_Varde', '_Gruppnamn' or '_id' are always treated as
#' character (not factors; see section "factors" below)
#'   \item column or vectors named "PAT_ID", "KON_VALUE" and "LAN_VALUE"
#' are also always treated as character. These could also be thought of as
#' numerics but are treated as character internally by INCA. To stay with that
#' format ensures the assumption of a stable format. 
#'   \item If all values of a
#' vector are NA, it is coerced from logical to character. This might be a
#' faulty assumption but it is in fact more likely that an empty vector is a
#' character variable (since most INCA variables are of type character) than 
#' that it is a Boolean vector (that has its own format in INCA). 
#'   \item Dates in formats
#' recognized by \code{\link{as.Dates}} are coerced to such. 
#'   \item Integers (even
#' if stored as characters or factors) without leading zeros (except when the
#' zero is the only digit) are coerced to integers 
#'   \item Numerics (even if
#' stored as characters or factors) containing either a Swedish decimal comma or
#' an English decimal point are coerced to numeric (with possible commas changed
#' to points). 
#' \item all other formats are coerced to character. This includes
#' integers with leading zeroes (since these might be unit codes where a leading  
#' zero might bear meaning). 
#' }
#'
#' @section factors: Note that the \code{incadata} format does not include
#'   factors. Factors can be really useful for some applications but our
#'   philosophy is that they should be explicitly stated as such when needed. It
#'   is otherwise common that factor levels are created just by the responses
#'   present in a certain data set. These might or might not contain a complete 
#'   list of possible alternatives from a INCA variable with a fixed value set.
#'
#'
#' @section interactive use:
#'
#'   Some vectors can be undoubtedly recognized according to specifications 
#'   above.
#'   It is however possible that a vector of an intended format might have been
#'   "contaminated" with data of some other form. This might happen for example
#'   when a numeric variable is technically a character in INCA. For example a
#'   hospital unit code like \code{c(111, 123, "?")} might suddenly occur (if
#'   someone use a question mark as placeholder for an unknown code). Ordinary
#'   coercing rules of R would treat this vector as a character (see
#'   \code{\link{c}}), although it might be more correct to treat it as a
#'   numeric with "?" set to \code{NA}.
#'
#'   The \code{as.incadata} function relies on \code{\link{exceed_threshold}} 
#'   to ignore such contaminated values if they represent only a 
#'   (preferably small) proportion of the values.  
#'   
#'   By default, if contaminated values exist but only to a proportion of less 
#'   than 10 percent, the function will stop and ask the user for input on how 
#'   to handle this variable. If the proportion exceeds 10 percent, ordinary 
#'   coercing principles will apply. 
#'   
#' The 10 percent limit can be modified by argument \code{threshold} and it is  
#' possible to force vectors with contaminated values to the otherwise potential 
#' format (without the need of individual confirmation) by setting argument 
#' \code{force = TRUE} (passed to \code{\link{exceed_threshold}}).
#
#'
#' @param x data
#' @param decode Should \code{\link{decode}} be applied to variables with
#'   identified variable names? (\code{TRUE} by default).
#' @param id Should an id-column be added (see \code{\link{id}})?
#' @param n_i used internally between methods (should not be set by the user)
#' @param ask ask for input if unsure how to coerce variables (see the 
#' "interactive use" section below)
#' @param ... arguments passed to \code{\link{exceed_threshold}} (of most use is
#'   probably "threshold" and "force", see the "interactive use" section below)
#'
#' @return \describe{ \item{\code{as.incadata.data.frame}}{ object of class
#' \code{incadata} based on the "tibble"-class used within the "tidyverse" with
#' all variables possibly coerced as described above. }
#' \item{\code{as.incadata.default}}{ input vector coerced to relevant class }
#' \item{\code{is.incadata}}{ \code{TRUE} for objects of class \code{incadata},
#' otherwise \code{FALSE} } }
#' @export
as.incadata <- function(x, ...)
  UseMethod("as.incadata")

#' @export
as.incadata.incadata <- function(x, ...)
  x

#' @rdname as.incadata
#' @export
is.incadata <- function(x)
  inherits(x, "incadata")
