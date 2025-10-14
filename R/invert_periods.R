#' Invert Sleep and Wake Periods
#'
#' Converts sleep periods to wake periods or vice versa by pairing consecutive
#' periods. The end time of period N becomes the start time of the inverted period,
#' and the start time of period N+1 becomes the end time, creating complement
#' periods between consecutive sleep or wake episodes.
#'
#' @param subject.log Data frame with columns 'Subject Name', 'On Date', 'On Time',
#'   'Off Date', 'Off Time', and 'Category'
#' @param period.type Character string: "sleep" or "wake" indicating input data type
#'
#' @return Data frame with inverted periods in same format as input. Output contains
#'   one fewer period per subject as the final period cannot be inverted without a
#'   subsequent period
#'
#' @details
#' The inversion algorithm or method processes each subject independently, sorting periods
#' chronologically before pairing consecutive entries. Subjects with fewer than
#' 2 periods are skipped with a warning.
#'
#' Converting wake to sleep is permitted but generates a warning as it results in
#' compounded data loss.
#'
#' @examples
#' sleep_data <- data.frame(
#'   "Subject Name" = c("S001", "S001", "S001"),
#'   "On Date" = c("09/19/2024", "09/20/2024", "09/21/2024"),
#'   "On Time" = c("11:00:00 PM", "10:30:00 PM", "11:15:00 PM"),
#'   "Off Date" = c("09/20/2024", "09/21/2024", "09/22/2024"),
#'   "Off Time" = c("07:00:00 AM", "06:45:00 AM", "07:30:00 AM"),
#'   "Category" = c("", "", ""),
#'   check.names = FALSE
#' )
#'
#' wake_data <- invert.periods(sleep_data, period.type = "sleep")
#'
#' @export
invert.periods <- function(subject.log, period.type = "sleep") {

  if (!is.data.frame(subject.log)) {
    stop("'subject.log' must be a data frame")
  }

  required.cols <- c("Subject Name", "On Date", "On Time", "Off Date", "Off Time", "Category")
  missing.cols <- setdiff(required.cols, colnames(subject.log))

  if (length(missing.cols) > 0) {
    stop(paste("Missing required columns:", paste(missing.cols, collapse = ", ")))
  }

  if (!period.type %in% c("sleep", "wake")) {
    stop("period.type must be 'sleep' or 'wake'")
  }

  if (period.type == "wake") {
    warning("Converting wake to sleep not recommended. Information loss will occur.")
  }

  subject.log$on.datetime <- as.POSIXct(
    paste(subject.log$`On Date`, subject.log$`On Time`),
    format = "%m/%d/%Y %I:%M:%S %p"
  )
  subject.log$off.datetime <- as.POSIXct(
    paste(subject.log$`Off Date`, subject.log$`Off Time`),
    format = "%m/%d/%Y %I:%M:%S %p"
  )

  subjects <- unique(subject.log$`Subject Name`)
  inverted.list <- list()

  for (subj in subjects) {
    subj.data <- subject.log[subject.log$`Subject Name` == subj, ]
    subj.data <- subj.data[order(subj.data$on.datetime), ]
    n <- nrow(subj.data)

    if (n < 2) {
      warning(paste("Subject", subj, "has fewer than 2 periods. Skipping."))
      next
    }

    inverted.periods <- data.frame(
      `Subject Name` = character(),
      `On Date` = character(),
      `On Time` = character(),
      `Off Date` = character(),
      `Off Time` = character(),
      `Category` = character(),
      check.names = FALSE,
      stringsAsFactors = FALSE
    )

    for (i in 1:(n - 1)) {
      inverted.periods <- rbind(inverted.periods, data.frame(
        `Subject Name` = subj,
        `On Date` = subj.data$`Off Date`[i],
        `On Time` = subj.data$`Off Time`[i],
        `Off Date` = subj.data$`On Date`[i + 1],
        `Off Time` = subj.data$`On Time`[i + 1],
        `Category` = "",
        check.names = FALSE,
        stringsAsFactors = FALSE
      ))
    }

    inverted.list[[subj]] <- inverted.periods
  }

  if (length(inverted.list) == 0) {
    stop("No subjects had enough periods to invert")
  }

  result <- do.call(rbind, inverted.list)
  rownames(result) <- NULL

  return(result)
}
