#' @importFrom utils head
NULL

#' Parse Datetime with Multiple Format Support
#'
#' Internal function to parse datetime strings with automatic format detection.
#'
#' @param datetime.string Character vector of datetime strings
#' @return POSIXct datetime object
#' @keywords internal
parse.datetime.flexible <- function(datetime.string) {

  # Normalize spaces
  datetime.string <- trimws(gsub("\\s+", " ",
                                 chartr("\u00A0", " ",
                                        as.character(datetime.string))))

  # multiple formats
  formats <- c(
    "%m/%d/%Y %I:%M:%S %p",   # 10/7/2025 10:45:00 PM
    "%m/%d/%Y %H:%M:%S",      # 10/7/2025 22:45:00
    "%m/%d/%Y %I:%M %p",      # 10/7/2025 10:45 PM
    "%m/%d/%Y %H:%M"          # 10/7/2025 22:45
  )

  for (fmt in formats) {
    parsed <- suppressWarnings(as.POSIXct(datetime.string, format = fmt, tz = "UTC"))
    success.rate <- sum(!is.na(parsed)) / length(parsed)
    # Require 100% success for a format to be used
    if (success.rate == 1.0) return(parsed)
    # Accept >90% as best candidate if no perfect match found
    if (success.rate > 0.9) {
      best.parsed <- parsed
      best.rate <- success.rate
    }
  }

  # Return best partial match if found (will trigger validation in calling functions)
  if (exists("best.parsed")) return(best.parsed)

  return(rep(as.POSIXct(NA), length(datetime.string)))
}

#' Validate Sleep Data Format
#'
#' Check if sleep data has correct columns and parseable datetime formats.
#'
#' @param sleep.data Data frame to validate
#' @param verbose Logical; if TRUE, print detailed diagnostics
#' @return Logical; TRUE if valid, FALSE otherwise
#' @export
#'
#' @examples
#' data(sample.data)
#' validate.sleep.data(sample.data)
#'
validate.sleep.data <- function(sleep.data, verbose = TRUE) {

  if (!is.data.frame(sleep.data)) {
    if (verbose) cat("Data must be a data frame\n")
    return(FALSE)
  }

  required.cols <- c("Subject Name", "In Bed Time", "Out Bed Time")
  missing.cols <- setdiff(required.cols, colnames(sleep.data))

  if (length(missing.cols) > 0) {
    if (verbose) cat("Missing columns:", paste(missing.cols, collapse = ", "), "\n")
    return(FALSE)
  }

  if (verbose) cat("Required columns present\n")

  in.bed.parsed <- parse.datetime.flexible(sleep.data$`In Bed Time`)
  out.bed.parsed <- parse.datetime.flexible(sleep.data$`Out Bed Time`)

  in.success <- sum(!is.na(in.bed.parsed)) / length(in.bed.parsed)
  out.success <- sum(!is.na(out.bed.parsed)) / length(out.bed.parsed)

  if (verbose) {
    cat("In Bed Time parsed:", round(in.success * 100, 1), "%\n")
    cat("Out Bed Time parsed:", round(out.success * 100, 1), "%\n")
  }

  if (in.success < 0.9 || out.success < 0.9) {
    if (verbose) {
      cat("\nSample values:\n")
      print(head(sleep.data[, c("In Bed Time", "Out Bed Time")], 3))
    }
    return(FALSE)
  }

  if (verbose) cat("\nAll checks passed\n")
  return(TRUE)
}

#' Standardize Datetime Format
#'
#' Convert any parseable datetime to package standard format.
#'
#' @param datetime.string Character vector of datetime strings
#' @return Character vector in format "MM/DD/YYYY HH:MM:SS AM/PM"
#' @export
#'
#' @examples
#' standardize.datetime("10/7/2025 22:45")
#'
standardize.datetime <- function(datetime.string) {
  parsed <- parse.datetime.flexible(datetime.string)

  if (all(is.na(parsed))) {
    sample.val <- if (length(datetime.string) > 0) datetime.string[1] else "(empty)"
    stop("Unable to parse datetime: '", sample.val,
         "'. Use validate.sleep.data() for diagnostics.", call. = FALSE)
  }

  format(parsed, "%m/%d/%Y %I:%M:%S %p")
}
