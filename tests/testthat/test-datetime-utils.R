test_that("validate.sleep.data returns TRUE for valid data", {
  valid_data <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("09/19/2024 11:00:00 PM"),
    "Out Bed Time" = c("09/20/2024 07:00:00 AM"),
    check.names = FALSE
  )

  expect_true(validate.sleep.data(valid_data))
})

test_that("validate.sleep.data returns FALSE for missing columns", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "Wrong Column" = c("test"),
    check.names = FALSE
  )

  expect_false(validate.sleep.data(bad_data))
})

test_that("validate.sleep.data returns FALSE for unparseable datetimes", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("not a datetime"),
    "Out Bed Time" = c("also not a datetime"),
    check.names = FALSE
  )

  expect_false(validate.sleep.data(bad_data))
})

test_that("standardize.datetime handles MM/DD/YYYY HH:MM:SS AM/PM format", {
  input <- "09/19/2024 11:00:00 PM"
  result <- standardize.datetime(input)

  expect_type(result, "character")
  expect_match(result, "^\\d{2}/\\d{2}/\\d{4} \\d{2}:\\d{2}:\\d{2} [AP]M$")
})

test_that("standardize.datetime handles 24-hour format", {
  input <- "09/19/2024 23:00:00"
  result <- standardize.datetime(input)

  expect_type(result, "character")
})

test_that("standardize.datetime handles format without seconds", {
  input <- "09/19/2024 11:00 PM"
  result <- standardize.datetime(input)

  expect_type(result, "character")
})

test_that("standardize.datetime errors on invalid input", {
  expect_error(
    standardize.datetime("not a datetime"),
    "Unable to parse datetime"
  )
})

test_that("validate.sleep.data handles multiple datetime formats", {
  # Test with 24-hour format
  data_24hr <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("09/19/2024 23:00:00"),
    "Out Bed Time" = c("09/20/2024 07:00:00"),
    check.names = FALSE
  )

  expect_true(validate.sleep.data(data_24hr))
})
