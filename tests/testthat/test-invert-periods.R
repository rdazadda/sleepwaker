test_that("invert.periods returns n-1 periods per subject", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001", "S001", "S001"),
    "On Date" = c("09/19/2024", "09/20/2024", "09/21/2024"),
    "On Time" = c("11:00:00 PM", "10:30:00 PM", "11:15:00 PM"),
    "Off Date" = c("09/20/2024", "09/21/2024", "09/22/2024"),
    "Off Time" = c("07:00:00 AM", "06:45:00 AM", "07:30:00 AM"),
    "Category" = c("", "", ""),
    check.names = FALSE
  )

  result <- invert.periods(sleep_data, period.type = "sleep")

  # 3 sleep periods should produce 2 wake periods
 expect_equal(nrow(result), 2)
})

test_that("invert.periods creates correct wake periods", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001", "S001"),
    "On Date" = c("09/19/2024", "09/20/2024"),
    "On Time" = c("11:00:00 PM", "10:30:00 PM"),
    "Off Date" = c("09/20/2024", "09/21/2024"),
    "Off Time" = c("07:00:00 AM", "06:45:00 AM"),
    "Category" = c("", ""),
    check.names = FALSE
  )

  result <- invert.periods(sleep_data, period.type = "sleep")

  # Wake period should start when first sleep ends and end when second sleep starts
  expect_equal(result$`On Date`[1], "09/20/2024")
  expect_equal(result$`On Time`[1], "07:00:00 AM")
  expect_equal(result$`Off Date`[1], "09/20/2024")
  expect_equal(result$`Off Time`[1], "10:30:00 PM")
})

test_that("invert.periods warns for subjects with fewer than 2 periods", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001"),
    "On Date" = c("09/19/2024"),
    "On Time" = c("11:00:00 PM"),
    "Off Date" = c("09/20/2024"),
    "Off Time" = c("07:00:00 AM"),
    "Category" = c(""),
    check.names = FALSE
  )

  expect_warning(
    expect_error(invert.periods(sleep_data, period.type = "sleep")),
    "has fewer than 2 periods"
  )
})

test_that("invert.periods errors on missing columns", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "On Date" = c("09/19/2024"),
    check.names = FALSE
  )

  expect_error(
    invert.periods(bad_data, period.type = "sleep"),
    "Missing required columns"
  )
})

test_that("invert.periods errors on non-dataframe input", {
  expect_error(
    invert.periods("not a dataframe", period.type = "sleep"),
    "must be a data frame"
  )
})

test_that("invert.periods validates period.type parameter", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001", "S001"),
    "On Date" = c("09/19/2024", "09/20/2024"),
    "On Time" = c("11:00:00 PM", "10:30:00 PM"),
    "Off Date" = c("09/20/2024", "09/21/2024"),
    "Off Time" = c("07:00:00 AM", "06:45:00 AM"),
    "Category" = c("", ""),
    check.names = FALSE
  )

  expect_error(
    invert.periods(sleep_data, period.type = "invalid"),
    "period.type must be 'sleep' or 'wake'"
  )
})

test_that("invert.periods warns when converting wake to sleep", {
  wake_data <- data.frame(
    "Subject Name" = c("S001", "S001"),
    "On Date" = c("09/20/2024", "09/21/2024"),
    "On Time" = c("07:00:00 AM", "06:45:00 AM"),
    "Off Date" = c("09/20/2024", "09/21/2024"),
    "Off Time" = c("11:00:00 PM", "10:30:00 PM"),
    "Category" = c("", ""),
    check.names = FALSE
  )

  expect_warning(
    invert.periods(wake_data, period.type = "wake"),
    "Converting wake to sleep not recommended"
  )
})

test_that("invert.periods handles multiple subjects", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001", "S001", "S002", "S002", "S002"),
    "On Date" = c("09/19/2024", "09/20/2024", "09/19/2024", "09/20/2024", "09/21/2024"),
    "On Time" = c("11:00:00 PM", "10:30:00 PM", "10:00:00 PM", "09:30:00 PM", "10:15:00 PM"),
    "Off Date" = c("09/20/2024", "09/21/2024", "09/20/2024", "09/21/2024", "09/22/2024"),
    "Off Time" = c("07:00:00 AM", "06:45:00 AM", "06:00:00 AM", "05:45:00 AM", "06:30:00 AM"),
    "Category" = c("", "", "", "", ""),
    check.names = FALSE
  )

  result <- invert.periods(sleep_data, period.type = "sleep")

  # S001 has 2 periods -> 1 wake, S002 has 3 periods -> 2 wake = 3 total
  expect_equal(nrow(result), 3)
})
