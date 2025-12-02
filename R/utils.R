#' Internal Validation Utilities
#'
#' Internal helper functions for data validation used across the package.
#'
#' @name utils
#' @keywords internal
NULL

#' Check Required Columns
#'
#' Internal function to validate that required columns exist in a data frame.
#'
#' @param data Data frame to check
#' @param required.cols Character vector of required column names
#' @param func.name Character string naming the calling function (for error messages)
#' @return NULL (invisibly) on success, stops with error on failure
#' @keywords internal
.check_required_columns <- function(data, required.cols, func.name = "function") {
  missing.cols <- setdiff(required.cols, colnames(data))

  if (length(missing.cols) > 0) {
    stop(func.name, ": Missing required columns: ",
         paste(missing.cols, collapse = ", "),
         call. = FALSE)
  }

  invisible(NULL)
}

#' Validate Data Frame Input
#'
#' Internal function to check if input is a valid data frame.
#'
#' @param data Object to check
#' @param arg.name Character string naming the argument (for error messages)
#' @param func.name Character string naming the calling function (for error messages)
#' @return NULL (invisibly) on success, stops with error on failure
#' @keywords internal
.validate_dataframe <- function(data, arg.name = "data", func.name = "function") {
  if (!is.data.frame(data)) {
    stop(func.name, ": '", arg.name, "' must be a data frame",
         call. = FALSE)
  }

  invisible(NULL)
}
