#' Download and possibly open INCA documentation
#'
#' @inheritDotParams find_documents
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
documents <- function(..., dir = ".", max_open = 3) {
  
  links    <- find_documents(...)
  
  # Remove special characters from file names
  dir <- file.path(dir, "doc")
  links$new_names <- paste0(file.path(dir, gsub("/", "_", links$names)), ".pdf")
 
  # Download documents that do not already exist
  dir.create(dir, showWarnings = FALSE)
  to_download <- !file.exists(links$new_name)
  if (any(to_download)) {
    apply(links[to_download, ], 1, 
      function(x) utils::download.file(x[1], x[3], quiet = TRUE))
    message(sum(to_download), " files downloaded to ", dir)
  }
  
  # Open file from Mac if less than 3 and function called by user
  if (nrow(links) <= max_open && 
      Sys.info()["sysname"] == "Darwin" && 
      interactive() && 
      identical(parent.frame(n = 1) , globalenv() )) {
    . <- lapply(paste0("open '", links$new_names, "'"), system)
  }
}


