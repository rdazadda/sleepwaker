#' Inverting Sleep and Wake Periods from Accelerometry Data
#'
#' Converts between sleep and wake periods from accelerometry batch export data.
#' Uses output from validated sleep detection algorithms (Cole-Kripke (Adult), Sadeh (Youth))
#' to invert sleep periods into wake periods, which enables analysis constrained to
#' waking hours and prevents artificial inflation of sedentary time estimates.
#'
#' @param data Data frame contains either batch sleep export data with columns
#'   'Subject Name', 'In Bed Time', 'Out Bed Time', or already formatted sleep/wake
#'   periods with columns 'Subject Name', 'On Date', 'On Time', 'Off Date',
#'   'Off Time', 'Category'.
#'
#' @param input.type Character string which specify the input data type: "raw" for batch
#'   export, "sleep" for formatted sleep periods, or "wake" for formatted wake periods.
#'
#' @param output.type Character string which specify desired output: "sleep" for sleep
#'   periods or "wake" for wake periods.
#'
#' @param output.file This is Optional character string which specify CSV file path for saving
#'   results. If NULL (default), results are returned but not saved to file.
#'
#' @return Data frame with columns 'Subject Name', 'On Date', 'On Time', 'Off Date',
#'   'Off Time', and 'Category', representing either sleep or wake periods as specified.
#'
#' @details
#' The inversion algorithm or let me say  pairs consecutive periods, using the end time of period N
#' as the start of the inverted period, and the start time of period N+1 as the end.
#' This creates complement periods between consecutive sleep or wake episodes.
#' Note that the output contains one fewer period per subject than the input, as the
#' final period cannot be inverted without a subsequent period.
#'
#' Wake to sleep conversion is blocked as it results in compounded data loss and
#' cannot recover original sleep periods.
#'
#' @examples
#' # Load real sample data
#' data(sample.data)
#'
#' # Convert raw data to sleep periods
#' sleep_periods <- sleepwaker(sample.data,
#'                             input.type = "raw",
#'                             output.type = "sleep")
#'
#' # Convert raw data to wake periods
#' wake_periods <- sleepwaker(sample.data,
#'                            input.type = "raw",
#'                            output.type = "wake")
#'
#' # Convert sleep periods to wake periods
#' wake_from_sleep <- sleepwaker(sleep_periods,
#'                               input.type = "sleep",
#'                               output.type = "wake")
#'
#' \donttest{
#'   # Save results to CSV file
#'   wake_periods <- sleepwaker(sample.data,
#'                              input.type = "raw",
#'                              output.type = "wake",
#'                              output.file = "wake_periods.csv")
#' }
#'
#' @references
#' Cole, R. J., Kripke, D. F., Gruen, W., Mullaney, D. J., & Gillin, J. C. (1992). Automatic sleep/wake identification from wrist activity. Sleep, 15(5), 461–469. https://doi.org/10.1093/sleep/15.5.461
#'
#'
#'
#' @export
sleepwaker <- function(data, input.type = "raw", output.type = "sleep",
                       output.file = NULL) {

  if (!input.type %in% c("raw", "sleep", "wake")) {
    stop("input.type must be 'raw', 'sleep', or 'wake'")
  }

  if (!output.type %in% c("sleep", "wake")) {
    stop("output.type must be 'sleep' or 'wake'")
  }

  if (input.type == "wake" && output.type == "sleep") {
    stop("Wake to sleep conversion is not supported.")
  }

  if (input.type == "raw") {
    clean_data <- extract.sleep.columns(data)
    result <- create.subject.log(clean_data, output.type = output.type)
  } else if (input.type == "sleep") {
    result <- if (output.type == "sleep") {
      data
    } else {
      invert.periods(data, period.type = "sleep")
    }
  } else {
    result <- data
  }

  if (!is.null(output.file)) {
    write.csv(result, file = output.file, row.names = FALSE)
    message("Results saved to: ", output.file)
  }

  return(result)
}
