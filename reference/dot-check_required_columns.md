# Check Required Columns

Internal function to validate that required columns exist in a data
frame.

## Usage

``` r
.check_required_columns(data, required.cols, func.name = "function")
```

## Arguments

- data:

  Data frame to check

- required.cols:

  Character vector of required column names

- func.name:

  Character string naming the calling function (for error messages)

## Value

NULL (invisibly) on success, stops with error on failure
