#' Extracting Sleep Period Columns from Batch Sleep Export
#'
#' Extracts essential columns required for sleep period inversion from batch
#' sleep export data: Subject Name, In Bed Time, and Out Bed Time.
#'
#' @param data Data frame contain batch sleep export data with columns
#'   'Subject Name', 'In Bed Time', and 'Out Bed Time'
#'
#' @return Data frame with three columns: 'Subject Name', 'In Bed Time',
#'   and 'Out Bed Time'
#'
#' @examples
#' sample_data <- data.frame(
#'   "Subject Name" = c("S001", "S001", "S002"),
#'   "In Bed Time" = c("09/19/2024 11:00:00 PM", "09/20/2024 10:30:00 PM",
#'                     "09/19/2024 11:15:00 PM"),
#'   "Out Bed Time" = c("09/20/2024 07:00:00 AM", "09/21/2024 06:45:00 AM",
#'                      "09/20/2024 07:30:00 AM"),
#'   "Other Column" = c(1, 2, 3),
#'   check.names = FALSE
#' )
#'
#' result <- extract.sleep.columns(sample_data)
#'
#' @export
extract.sleep.columns <- function(data) {

  if (!is.data.frame(data)) {
    stop("'data' must be a data frame")
  }

  required.cols <- c("Subject Name", "In Bed Time", "Out Bed Time")
  missing.cols <- setdiff(required.cols, colnames(data))

  if (length(missing.cols) > 0) {
    stop(paste("Missing required columns:", paste(missing.cols, collapse = ", ")))
  }

  return(data[, required.cols, drop = FALSE])
}
