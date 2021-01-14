#' Make template documentation for each internal dataset durong a package development
#'
#' BEWARE : this will overwrite existing documentation (I need to work on that)
#'
#' @param where path to the directory where tha package is developped
#' @param file path to the file (.rda) of the dataset to document
#'
#' @importFrom here here
#' @importFrom utils tail
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # In a R project where you develop the package
#' make_data_documentation()
#' }
make_data_documentation <- function(
  where = here()
) {

  # Path to data directory
  dir <- normalizePath(
    paste(where, "data", sep = "/"),
    winslash = "/",
    mustWork = FALSE
  )
  # Is data directory exists ?
  dir_exist <- dir.exists(dir)


  if (dir_exist) {

    # List available data
    all_data <- list.files(path = dir, full.names = TRUE)

    # Is there available data (stop if not)
    if (length(all_data) == 0) {
      stop("No data available in this package (data directory is empty)")
    }

    # Path to documentatoin file
    dir_r <- normalizePath(
      paste(where, "R", sep = "/"),
      winslash = "/",
      mustWork = FALSE
    )
    if (!dir.exists(dir_r)) {
      dir.create(dir_r)
    }

    # Make file for all data set
    for (i in all_data) {
      doc_content <- document_data(file = i)
      data_name <- gsub('\\"', "", tail(doc_content, 1))
      doc_path <- normalizePath(
        paste(where, "R", paste0(data_name, ".R"), sep = "/"),
        winslash = "/",
        mustWork = FALSE
      )
      writeLines(doc_content, doc_path)
    }

  } else {
    stop("No data available in this package (data directory doesn't exist)")
  }

}

#' @rdname make_data_documentation
document_data <- function(
  file
) {

  # normalize path if needed
  file <- normalizePath(file, winslash = "/", mustWork = TRUE)

  # info about the dataset
  data_name <- tail(unlist(strsplit(file, "/")), 1)
  data_name <- gsub("\\..+$", "", data_name, perl = TRUE)
  load(file)
  the_data <- get(data_name)
  data_dim <- dim(the_data)
  data_colnames <- colnames(the_data)

  # make description of columns
  col_descr <- vapply(
    data_colnames,
    FUN = function(x) { paste0("#'    \\item{", x, "}{}") },
    FUN.VALUE = NA_character_,
    USE.NAMES = FALSE
  )

  # return
  c(
    "#' Title.",
    "#' ",
    "#' Description.",
    "#' ",
    paste0("#' @format A data frame with ", data_dim[1], " rows and ", data_dim[2], " variables:"),
    "#' \\describe{",
    col_descr,
    "#' }",
    paste0("\"", data_name, "\"")
  )

}


