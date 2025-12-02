test_that("create.subject.log produces correct output format", {
  input_data <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("09/19/2024 11:00:00 PM"),
    "Out Bed Time" = c("09/20/2024 07:00:00 AM"),
    check.names = FALSE
  )

  result <- create.subject.log(input_data, output.type = "sleep")

  expect_s3_class(result, "data.frame")
  expect_equal(ncol(result), 6)
  expect_true("Subject Name" %in% colnames(result))
  expect_true("On Date" %in% colnames(result))
  expect_true("On Time" %in% colnames(result))
  expect_true("Off Date" %in% colnames(result))
  expect_true("Off Time" %in% colnames(result))
  expect_true("Category" %in% colnames(result))
})

test_that("create.subject.log correctly splits datetime into date and time", {
  input_data <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("09/19/2024 11:00:00 PM"),
    "Out Bed Time" = c("09/20/2024 07:00:00 AM"),
    check.names = FALSE
  )

  result <- create.subject.log(input_data, output.type = "sleep")

  expect_equal(result$`On Date`[1], "09/19/2024")
  expect_equal(result$`On Time`[1], "11:00:00 PM")
  expect_equal(result$`Off Date`[1], "09/20/2024")
  expect_equal(result$`Off Time`[1], "07:00:00 AM")
})

test_that("create.subject.log inverts periods when output.type is wake", {
  input_data <- data.frame(
    "Subject Name" = c("S001", "S001"),
    "In Bed Time" = c("09/19/2024 11:00:00 PM", "09/20/2024 10:30:00 PM"),
    "Out Bed Time" = c("09/20/2024 07:00:00 AM", "09/21/2024 06:45:00 AM"),
    check.names = FALSE
  )

  result <- create.subject.log(input_data, output.type = "wake")

  # Should have n-1 periods after inversion
  expect_equal(nrow(result), 1)
})

test_that("create.subject.log errors on missing columns", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "Wrong Column" = c("test"),
    check.names = FALSE
  )

  expect_error(
    create.subject.log(bad_data, output.type = "sleep"),
    "Missing required columns"
  )
})

test_that("create.subject.log errors on unparseable datetimes", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "In Bed Time" = c("not a datetime"),
    "Out Bed Time" = c("also not a datetime"),
    check.names = FALSE
  )

  expect_error(
    create.subject.log(bad_data, output.type = "sleep"),
    "Could not parse datetime"
  )
})

test_that("create.subject.log preserves row count for sleep output", {
  input_data <- data.frame(
    "Subject Name" = c("S001", "S001", "S002"),
    "In Bed Time" = c("09/19/2024 11:00:00 PM", "09/20/2024 10:30:00 PM", "09/19/2024 10:00:00 PM"),
    "Out Bed Time" = c("09/20/2024 07:00:00 AM", "09/21/2024 06:45:00 AM", "09/20/2024 06:00:00 AM"),
    check.names = FALSE
  )

  result <- create.subject.log(input_data, output.type = "sleep")

  expect_equal(nrow(result), 3)
})
