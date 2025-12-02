# Validate Data Frame Input

Internal function to check if input is a valid data frame.

## Usage

``` r
.validate_dataframe(data, arg.name = "data", func.name = "function")
```

## Arguments

- data:

  Object to check

- arg.name:

  Character string naming the argument (for error messages)

- func.name:

  Character string naming the calling function (for error messages)

## Value

NULL (invisibly) on success, stops with error on failure
