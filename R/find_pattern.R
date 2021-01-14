#' Find a pattern in files from a directory
#'
#' \code{find_pattern} search a pattern in all files from a directory and \code{is_on_file} search
#' for a pattern in one file.
#'
#' @name find_pattern
#'
#' @param pattern the pattern to find. Can be regex
#' @param where the path to the directory where you want to search
#' @param full_names a logical value as in \code{\link[base]{list.files}}. If TRUE, the directory path is prepended to the file names to give a relative file path. If FALSE, the file names (rather than paths) are returned.
#' @param file the path to the file where you want to search
#'
#' @return a vector with all the files where the pattern was found for \code{find_pattern} or a logical value for \code{is_on_file}
#'
#' @importFrom here here
#'
#'
#' @examples
#' find_pattern(pattern = "usethis::", where = system.file(package = "benutils"))
#'
#' \dontrun{
#' # if you are in a R project you can just specify the pattern
#' find_pattern("my_pattern")
#' }
NULL

#' @rdname find_pattern
#' @export
find_pattern <- function(
  pattern,
  where = here(),
  full_names = FALSE
) {

  # List all files
  all_files <- list.files(path = where, recursive = TRUE, full.names = full_names)

  # Conditional to full_names
  fu <- function(x, path = where) { normalizePath(paste(path, x, sep = "/"), mustWork = FALSE, winslash = "/") }
  if (full_names) {
    path_to_files <- all_files
  } else {
    path_to_files <- vapply(
      X = all_files,
      FUN = fu,
      FUN.VALUE = NA_character_
    )
  }

  # check in which file the pattern is found
  wh <- vapply(
    path_to_files,
    is_in_file,
    pattern = pattern,
    FUN.VALUE = NA
  )

  # result
  return(all_files[wh])

}

#' @rdname find_pattern
#' @export
is_in_file <- function(
  pattern,
  file
) {

  # Read lines in file
  text_lines <- readLines(con = file, warn = FALSE)

  # check for pattern
  any(grepl(pattern = pattern, x = text_lines, perl = TRUE))

}
