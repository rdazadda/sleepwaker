# Creating Subject Log from Raw Sleep Data

Convert batch export format to subject log diary format by splitting
datetime into separate date and time columns. Optionally inverts sleep
periods to wake periods in a single step.

## Usage

``` r
create.subject.log(sleep.data, output.type = "sleep")
```

## Arguments

- sleep.data:

  Data frame with columns 'Subject Name', 'In Bed Time', and 'Out Bed
  Time'. Multiple datetime formats supported.

- output.type:

  Character string: "sleep" for sleep periods (default) or "wake" for
  wake periods

## Value

Data frame with columns 'Subject Name', 'On Date', 'On Time', 'Off
Date', 'Off Time', and 'Category'

## Examples

``` r
data(sample.data)
sleep.log <- create.subject.log(sample.data, output.type = "sleep")
wake.log <- create.subject.log(sample.data, output.type = "wake")
```
