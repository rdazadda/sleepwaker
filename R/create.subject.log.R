#' Creating Subject Log from Raw Sleep Data
#'
#' Convert batch export format to subject log diary format by splitting datetime
#' into separate date and time columns. Optionally inverts sleep periods to wake
#' periods in a single step.
#'
#' @param sleep.data Data frame with columns 'Subject Name', 'In Bed Time',
#'   and 'Out Bed Time'. Datetime format must be MM/DD/YYYY HH:MM:SS AM/PM
#' @param output.type Character string: "sleep" for sleep periods (default)
#'   or "wake" for wake periods
#'
#' @return Data frame with columns 'Subject Name', 'On Date', 'On Time',
#'   'Off Date', 'Off Time', and 'Category'
#'
#' @examples
#' sample_data <- data.frame(
#'   "Subject Name" = c("S001", "S001"),
#'   "In Bed Time" = c("09/19/2024 11:00:00 PM", "09/20/2024 10:30:00 PM"),
#'   "Out Bed Time" = c("09/20/2024 07:00:00 AM", "09/21/2024 06:45:00 AM"),
#'   check.names = FALSE
#' )
#'
#' sleep_log <- create.subject.log(sample_data, output.type = "sleep")
#' wake_log <- create.subject.log(sample_data, output.type = "wake")
#'
#' @export
create.subject.log <- function(sleep.data, output.type = "sleep") {

  if (!is.data.frame(sleep.data)) {
    stop("'sleep.data' must be a data frame")
  }

  required.cols <- c("Subject Name", "In Bed Time", "Out Bed Time")
  missing.cols <- setdiff(required.cols, colnames(sleep.data))

  if (length(missing.cols) > 0) {
    stop(paste("Missing required columns:", paste(missing.cols, collapse = ", ")))
  }

  if (!output.type %in% c("sleep", "wake")) {
    stop("output.type must be 'sleep' or 'wake'")
  }

  # NEW: normalize spaces so "10/7/2025  10:45:00 PM" parses
  .normalize <- function(x) trimws(gsub("\\s+", " ", chartr("\u00A0"," ", as.character(x))))

  in.bed.dt  <- as.POSIXct(.normalize(sleep.data$`In Bed Time`),  format = "%m/%d/%Y %I:%M:%S %p")
  out.bed.dt <- as.POSIXct(.normalize(sleep.data$`Out Bed Time`), format = "%m/%d/%Y %I:%M:%S %p")

  if (all(is.na(in.bed.dt)) || all(is.na(out.bed.dt))) {
    stop("Could not parse datetime. Check format is MM/DD/YYYY HH:MM:SS AM/PM")
  }

  subject.log <- data.frame(
    `Subject Name` = sleep.data$`Subject Name`,
    `On Date` = format(in.bed.dt, "%m/%d/%Y"),
    `On Time` = format(in.bed.dt, "%I:%M:%S %p"),
    `Off Date` = format(out.bed.dt, "%m/%d/%Y"),
    `Off Time` = format(out.bed.dt, "%I:%M:%S %p"),
    `Category` = "",
    check.names = FALSE,
    stringsAsFactors = FALSE
  )

  if (output.type == "wake") {
    subject.log <- invert.periods(subject.log, period.type = "sleep")
  }

  return(subject.log)
}
