#' Dump script together with functions from required packages
#'
#' If a package is not installed on the computer/server intended to run a
#' final script, this function can take the script and export it together with all
#' objects (functions, methods et cetera) from specified R packages. It might
#' thereafter be possible to transfer the script and to run it even if all
#' packages are not installed by the host. 
#' 
#' Some packages use
#' external dependencies and/or compiled code. This is not handled by the
#' function. Hence, there is no guarantee that the script will actually work!
#'
#' @param script connection with script (file) to append to function definitions
#' @param packages name of packages (as character) to be explicitly included.
#' @param recursive argument passed to \code{\link{package_dependencies}}
#' @param outfile filename for dump file
#' @param force this function works only in interactive mode by default but
#'   output can be forced by this argument set to \code{TRUE}
#'
#' @return nothing (function called for its side effects)
#' @export
exportr <- function(script = NULL, packages, recursive = TRUE, 
                          outfile = "./generated_r_script.R", force = FALSE) {
  
  if (file.exists(outfile)) stop(outfile, " file already exist!")
    
  dep_pkgs <- 
    unname(unlist(tools::package_dependencies(packages, recursive = recursive)))
  packages <- c(packages, dep_pkgs)
  
  if (interactive() | force) {
    con <- file(outfile, "w", encoding = "UTF-8")
    writeLines(paste("# Script created: ", Sys.Date()), con)
    writeLines(
      "\n\n# PACKAGES ----------------------------------------------- \n\n\n", 
      con
    )

    for (p in packages) {
      writeLines(paste0(
        "\n\n\n# PACKAGE: ", p, " ---------------------------------------\n\n\n"
        ), con)
      e <- getNamespace(p)
      dump(ls(e), con, envir = e, append = TRUE)
    }
    
    if (!is.null(script)) {
      writeLines(
        "\n\n\n# SCRIPT ---------------------------------------------- \n\n\n", 
        con)
      writeLines(readLines(script), con)
    }
    close(con)
    message("R-script saved as: ", outfile)
    warning(
      "There is no guarantee that the generated script should work! ",
      "An R package might have external dependencies!"
    )
  } else {
    warning(
      "make_r_script works only in interactive mode! ", 
      "Use 'force' to override!"
    )
  }
}
