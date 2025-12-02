test_that("sleepwaker validates input.type parameter", {
  data(sample.data)

  expect_error(
    sleepwaker(sample.data, input.type = "invalid", output.type = "sleep"),
    "input.type must be 'raw', 'sleep', or 'wake'"
  )
})

test_that("sleepwaker validates output.type parameter", {
  data(sample.data)

  expect_error(
    sleepwaker(sample.data, input.type = "raw", output.type = "invalid"),
    "output.type must be 'sleep' or 'wake'"
  )
})

test_that("sleepwaker blocks wake to sleep conversion", {
  wake_data <- data.frame(
    "Subject Name" = c("S001", "S001"),
    "On Date" = c("09/20/2024", "09/21/2024"),
    "On Time" = c("07:00:00 AM", "06:45:00 AM"),
    "Off Date" = c("09/20/2024", "09/21/2024"),
    "Off Time" = c("11:00:00 PM", "10:30:00 PM"),
    "Category" = c("", ""),
    check.names = FALSE
  )

  expect_error(
    sleepwaker(wake_data, input.type = "wake", output.type = "sleep"),
    "Wake to sleep conversion is not supported"
  )
})

test_that("sleepwaker converts raw to sleep format", {
  data(sample.data)

  result <- sleepwaker(sample.data, input.type = "raw", output.type = "sleep")

  expect_s3_class(result, "data.frame")
  expect_true("Subject Name" %in% colnames(result))
  expect_true("On Date" %in% colnames(result))
  expect_true("On Time" %in% colnames(result))
  expect_true("Off Date" %in% colnames(result))
  expect_true("Off Time" %in% colnames(result))
  expect_true("Category" %in% colnames(result))
})

test_that("sleepwaker converts raw to wake format", {
  data(sample.data)

  result <- sleepwaker(sample.data, input.type = "raw", output.type = "wake")

  expect_s3_class(result, "data.frame")
  expect_true("Subject Name" %in% colnames(result))
  expect_true("Category" %in% colnames(result))
})

test_that("sleepwaker writes output file when specified", {
  data(sample.data)
  temp_file <- tempfile(fileext = ".csv")

  result <- sleepwaker(sample.data,
                       input.type = "raw",
                       output.type = "sleep",
                       output.file = temp_file)

 expect_true(file.exists(temp_file))

  # Clean up
  unlink(temp_file)
})

test_that("sleepwaker returns data unchanged for sleep to sleep", {
  sleep_data <- data.frame(
    "Subject Name" = c("S001"),
    "On Date" = c("09/19/2024"),
    "On Time" = c("11:00:00 PM"),
    "Off Date" = c("09/20/2024"),
    "Off Time" = c("07:00:00 AM"),
    "Category" = c(""),
    check.names = FALSE
  )

  result <- sleepwaker(sleep_data, input.type = "sleep", output.type = "sleep")

  expect_equal(result, sleep_data)
})
