#' Real ActiGraph Batch Sleep Export Data
#'
#' Complete, unprocessed ActiGraph ActiLife batch sleep export data showing
#' the actual format users receive from ActiLife software. Contains all
#' columns from the standard batch export. The sleepwaker package
#' automatically extracts the three required columns (Subject Name,
#' In Bed Time, Out Bed Time).
#'
#' @format A data frame with sleep period data from ActiGraph ActiLife.
#' Contains standard ActiGraph batch sleep export columns including
#' subject identifiers, sleep/wake times, sleep efficiency metrics,
#' and demographic information. See ActiLife documentation for complete
#' column descriptions.
#'
#' @examples
#' # Load real raw data
#' data(sample.data)
#'
#' # View structure
#' str(sample.data)
#'
#' # Convert to sleep periods
#' sleep_periods <- sleepwaker(sample.data,
#'                             input.type = "raw",
#'                             output.type = "sleep")
#'
#' # Convert to wake periods
#' wake_periods <- sleepwaker(sample.data,
#'                            input.type = "raw",
#'                            output.type = "wake")
#'
#' @source Real ActiGraph ActiLife batch sleep export (de-identified)
"sample.data"
