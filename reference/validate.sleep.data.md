# Validate Sleep Data Format

Check if sleep data has correct columns and parseable datetime formats.

## Usage

``` r
validate.sleep.data(sleep.data, verbose = TRUE)
```

## Arguments

- sleep.data:

  Data frame to validate

- verbose:

  Logical; if TRUE, print detailed diagnostics

## Value

Logical; TRUE if valid, FALSE otherwise

## Examples

``` r
data(sample.data)
validate.sleep.data(sample.data)
#> Required columns present
#> In Bed Time parsed: 100 %
#> Out Bed Time parsed: 100 %
#> 
#> All checks passed
#> [1] TRUE
```
