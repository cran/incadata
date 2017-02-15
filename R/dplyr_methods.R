#' dplyr methods for INCA data
#' 
#' Verbs from the dplyr package can be used for incadata directly, but 
#' the incadata object will then loose its class. 
#' These methods will preserve the class.
#' 
#' @param .data,... arguments passed to original dplyr-methods
#' 
#' @name dplyr_methods
#' @keywords internal
NULL

# Function to create methods for generics
next_method <- function() {
  function(.data, ...) {
    x <- NextMethod()
    class(x) <- unique(c("incadata", class(x)))
    x
  }
}

#' @rdname dplyr_methods
#' @export
mutate_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
arrange_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
filter_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
rename_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
select_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
slice_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
summarise_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
summarize_.incadata <- next_method()
#' @rdname dplyr_methods
#' @export
group_by_.incadata <- next_method()
