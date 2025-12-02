test_that("extract.sleep.columns extracts required columns", {
  data(sample.data)

  result <- extract.sleep.columns(sample.data)

  expect_s3_class(result, "data.frame")
  expect_equal(ncol(result), 3)
  expect_true("Subject Name" %in% colnames(result))
  expect_true("In Bed Time" %in% colnames(result))
  expect_true("Out Bed Time" %in% colnames(result))
})

test_that("extract.sleep.columns errors on missing columns", {
  bad_data <- data.frame(
    "Subject Name" = c("S001"),
    "Wrong Column" = c("test"),
    check.names = FALSE
  )

  expect_error(
    extract.sleep.columns(bad_data),
    "Missing required columns"
  )
})

test_that("extract.sleep.columns errors on non-dataframe input", {
  expect_error(
    extract.sleep.columns("not a dataframe"),
    "must be a data frame"
  )

  expect_error(
    extract.sleep.columns(NULL),
    "must be a data frame"
  )
})

test_that("extract.sleep.columns preserves row count", {
  data(sample.data)

  result <- extract.sleep.columns(sample.data)

  expect_equal(nrow(result), nrow(sample.data))
})
