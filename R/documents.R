#' Download and possibly open INCA documentation
#'
#' @inheritParams find_register
#' @param doc (part of) document name to look for
#' @param dir directory where to save files
#' @param max_open maximum number of files to open automatically 
#' (only on Mac OS X). Set to 0 to avoid any opening of files.
#'
#' @return Nothing. The function is called for its side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' documents("lunga", "uppfoljning")
#' }
documents <- function(reg, doc = NULL, dir = ".", max_open = 3) {
  
  reg   <- find_register(reg)
  links <- find_documents(reg, doc)
  
  # Remove special characters from file names
  dir <- file.path(dir, "doc")
  filename <- function(x) paste0(file.path(dir, gsub("/", "_", x)), ".pdf")
 
  # Download documents that do not already exist
  dir.create(dir, showWarnings = FALSE)
  to_download <- links[!file.exists(filename(names(links)))]
  if (length(to_download)) {
    for (i in seq_along(to_download)) {
      utils::download.file(to_download[i], 
        filename(names(to_download[i])), quiet = TRUE)
    }
    message(i, " file(s) downloaded to ", dir)
  }
  
  # Open file from Mac if less than 3 and function called by user
  if (length(links) <= max_open && 
      Sys.info()["sysname"] == "Darwin" && 
      interactive() && 
      identical(parent.frame(n = 1) , globalenv() )) {
    for (file in filename(names(links))) {
      system(paste0("open '", file, "'"))
    }
  }
}


