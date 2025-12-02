# Standardize Datetime Format

Convert any parseable datetime to package standard format.

## Usage

``` r
standardize.datetime(datetime.string)
```

## Arguments

- datetime.string:

  Character vector of datetime strings

## Value

Character vector in format "MM/DD/YYYY HH:MM:SS AM/PM"

## Examples

``` r
standardize.datetime("10/7/2025 22:45")
#> [1] "10/07/2025 10:45:00 PM"
```
