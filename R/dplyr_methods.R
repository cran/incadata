#' dplyr methods for INCA data
#' 
#' Verbs from the dplyr package can be used for incadata directly, but the
#' incadata object will then loose its class. These methods will preserve the
#' class.
#' 
#' These methods should not be used directly. They are just documented for
#' clarification of underlying data structure.
#' 
#' @param .data,... arguments passed to dplyr-methods
#' @return Object as return from corresponding dplyr functions but with
#'   additional class attribute \code{incadata}.
#'
#' @examples 
#' x <- dplyr::slice(as.incadata(incadata::ex_data), 1:10)
#' class(x) # "incadata"   "tbl_df"     "tbl"        "data.frame"
#' 
#' @name dplyr_methods
#' @keywords internal
NULL


#' Function to create methods for generics
next_method <- function() {
  function(.data, ...) {
    x <- NextMethod()
    class(x) <- unique(c("incadata", class(x)))
    x
  }
}

#' @importFrom dplyr filter
#' @export
dplyr::filter

#' @rdname dplyr_methods
#' @export
filter.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr mutate
#' @export
mutate.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr arrange
#' @export
arrange.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr rename
#' @export
rename.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr select
#' @export
select.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr slice
#' @export
slice.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr summarise
#' @export
summarise.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr summarize
#' @export
summarize.incadata <- next_method()

#' @rdname dplyr_methods
#' @importFrom dplyr group_by
#' @export
group_by.incadata <- next_method()
