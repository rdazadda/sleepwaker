#' Creating Subject Log from Raw Sleep Data
#'
#' Convert batch export format to subject log diary format by splitting datetime
#' into separate date and time columns. Optionally inverts sleep periods to wake
#' periods in a single step.
#'
#' @param sleep.data Data frame with columns 'Subject Name', 'In Bed Time',
#'   and 'Out Bed Time'. Multiple datetime formats supported.
#' @param output.type Character string: "sleep" for sleep periods (default)
#'   or "wake" for wake periods
#'
#' @return Data frame with columns 'Subject Name', 'On Date', 'On Time',
#'   'Off Date', 'Off Time', and 'Category'
#'
#' @examples
#' data(sample.data)
#' sleep.log <- create.subject.log(sample.data, output.type = "sleep")
#' wake.log <- create.subject.log(sample.data, output.type = "wake")
#'
#' @export
create.subject.log <- function(sleep.data, output.type = "sleep") {

  if (!is.data.frame(sleep.data)) {
    stop("'sleep.data' must be a data frame")
  }

  required.cols <- c("Subject Name", "In Bed Time", "Out Bed Time")
  missing.cols <- setdiff(required.cols, colnames(sleep.data))

  if (length(missing.cols) > 0) {
    stop("Missing required columns: ", paste(missing.cols, collapse = ", "))
  }

  if (!output.type %in% c("sleep", "wake")) {
    stop("output.type must be 'sleep' or 'wake'")
  }

  # Use flexible parsing
  in.bed.dt  <- parse.datetime.flexible(sleep.data$`In Bed Time`)
  out.bed.dt <- parse.datetime.flexible(sleep.data$`Out Bed Time`)

  # Check for parsing failures
  if (any(is.na(in.bed.dt)) || any(is.na(out.bed.dt))) {
    stop("Could not parse datetime. Run validate.sleep.data(your_data, verbose = TRUE)")
  }

  # Create subject log
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
