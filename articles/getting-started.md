# Getting Started with sleepwaker

## Introduction

This guide demonstrates how to use **`sleepwaker`** to process ActiGraph
batch sleep export data for behavioral research. The package provides
automated workflows for both sleep analysis and physical activity
research.

**What you’ll learn:**

- How to install and load the package
- Three common usage scenarios
- Complete workflow from ActiLife export to analysis-ready data
- When to use each approach

## Installation

Install the development version from GitHub:

``` r
# Install sleepwaker
devtools::install_github("rdazadda/sleepwaker")
```

Load the package:

``` r
library(sleepwaker)
```

## Understanding the Data Format

### Input Requirements

**`sleepwaker`** requires batch sleep export data from ActiGraph
ActiLife with three columns:

- **Subject Name**: Unique identifier for each participant
- **In Bed Time**: Datetime when participant went to bed (mm/dd/yyyy
  hh:mm:ss AM/PM)
- **Out Bed Time**: Datetime when participant got out of bed (mm/dd/yyyy
  hh:mm:ss AM/PM)

These columns are automatically included in ActiLife batch sleep
exports.

### Sample Data

Let’s load the real ActiGraph sample data included with the package:

``` r
# Load real sample data
data(sample.data)
```

``` r
# Dataset summary
cat("Dataset contains", nrow(sample.data), "sleep periods for",
    length(unique(sample.data$`Subject Name`)), "participants")
#> Dataset contains 15 sleep periods for 2 participants

# Showing all column names from ActiGraph export
cat("ActiGraph batch export includes these columns:\n")
#> ActiGraph batch export includes these columns:
cat(paste("-", names(sample.data), collapse = "\n"))
#> - Subject Name
#> - File Name
#> - Serial Number
#> - Epoch Length
#> - Weight
#> - Age
#> - Gender
#> - Sleep/Wake Algorithm
#> - Sleep Period Detection Algorithm
#> - In Bed Time
#> - Out Bed Time
#> - Efficiency
#> - Onset
#> - Latency
#> - Total Sleep Time
#> - WASO
#> - Number of Awakenings
#> - Length of Awakenings in Minutes
#> - Activity Counts
#> - Movement Index
#> - Fragmentation Index
#> - Sleep Fragmentation Index
```

This is actual ActiGraph ActiLife batch sleep export data containing
sleep periods detected by Cole-Kripke or Sadeh algorithms.

## Three Usage Scenarios

### Scenario 1: Format Sleep Periods for Sleep Analysis

Use case: You’re conducting sleep research and need formatted sleep
periods.

``` r
sleep.periods <- sleepwaker(sample.data, 
                            input.type = "raw", 
                            output.type = "sleep")

# Display first few formatted sleep periods
head(sleep.periods, 5)
#>   Subject Name    On Date     On Time   Off Date    Off Time Category
#> 1         A001 10/07/2025 10:45:00 PM 10/08/2025 07:09:00 AM         
#> 2         A001 10/08/2025 07:55:00 AM 10/08/2025 10:56:00 AM         
#> 3         A001 10/08/2025 11:34:00 PM 10/09/2025 07:50:00 AM         
#> 4         A001 10/09/2025 11:46:00 PM 10/10/2025 07:02:00 AM         
#> 5         A002 10/09/2025 12:46:00 AM 10/09/2025 06:07:00 AM
```

**What happened:**

- Batch export was reformatted into subject log diary format
- Timestamps split into separate date and time columns
- Data ready for sleep pattern analysis

### Scenario 2: Convert Sleep to Wake Periods for Activity Analysis

Use case: You’re studying physical activity or sedentary behavior and
need to exclude sleep.

``` r
wake.periods <- sleepwaker(sample.data, 
                           input.type = "raw", 
                           output.type = "wake")

# Display first few wake periods
head(wake.periods, 5)
#>   Subject Name    On Date     On Time   Off Date    Off Time Category
#> 1         A001 10/08/2025 07:09:00 AM 10/08/2025 07:55:00 AM         
#> 2         A001 10/08/2025 10:56:00 AM 10/08/2025 11:34:00 PM         
#> 3         A001 10/09/2025 07:50:00 AM 10/09/2025 11:46:00 PM         
#> 4         A002 10/09/2025 06:07:00 AM 10/09/2025 06:24:00 AM         
#> 5         A002 10/09/2025 09:07:00 AM 10/09/2025 10:53:00 PM
```

**What happened:**

- Sleep periods were inverted to create wake periods
- Each wake period represents time between consecutive sleep episodes
- Notice: Number of wake periods = number of sleep periods - 1 (n-1 per
  subject)

Why n-1 periods?: The final sleep period has no subsequent sleep to pair
with, so no wake period can be generated after it.

### Scenario 3: Generate Both Sleep and Wake Periods

Use case: You need both sleep periods (for sleep analysis) and wake
periods (for activity analysis).

``` r
# Step 1: Create formatted sleep periods
sleep.periods <- sleepwaker(sample.data, 
                            input.type = "raw", 
                            output.type = "sleep")

# Step 2: Convert sleep periods to wake periods
wake.periods <- sleepwaker(sleep.periods, 
                           input.type = "sleep", 
                           output.type = "wake")

# Both datasets
cat("Sleep periods:", nrow(sleep.periods), "records\n")
#> Sleep periods: 15 records
cat("Wake periods:", nrow(wake.periods), "records\n")
#> Wake periods: 13 records
```

**What happened:**

- First step: Formatted sleep periods for sleep analysis
- Second step: Generated wake periods from those sleep periods
- You now have both datasets for comprehensive analysis

## Saving Results to Files

All scenarios support direct export to CSV:

``` r
# Save sleep periods
sleep.periods <- sleepwaker(sample.data, 
                            input.type = "raw", 
                            output.type = "sleep",
                            output.file = "sleep_periods.csv")

# Save wake periods  
wake.periods <- sleepwaker(sample.data, 
                           input.type = "raw", 
                           output.type = "wake",
                           output.file = "wake_periods.csv")
```

The function displays a confirmation message when files are saved
successfully. \## Important Notes

**Supported:**

- Raw to Sleep (formatting)

- Raw to Wake (formatting + inversion)

- Sleep to Wake (inversion)

**Not supported:**

- Wake to Sleep (would cause data loss)

Why?: Once sleep periods are inverted to wake periods, the final sleep
period is lost. Attempting to reconstruct it would require guessing,
which would be scientifically invalid. \# Troubleshooting

### Common Issues

#### Issue 1: Datetime Format Problems

Error message:

    Error: Could not parse datetime

Solution: Check your data format first:

``` r
validate.sleep.data(your_data, verbose = TRUE)
```

If parsing fails, standardize the format:

``` r
your_data$`In Bed Time` <- standardize.datetime(your_data$`In Bed Time`)
your_data$`Out Bed Time` <- standardize.datetime(your_data$`Out Bed Time`)
```

The package handles these formats automatically:

- MM/DD/YYYY HH:MM:SS AM/PM (preferred)

- MM/DD/YYYY HH:MM:SS (24-hour)

- MM/DD/YYYY HH:MM AM/PM

- MM/DD/YYYY HH:MM

#### Issue 2: Missing Required Columns

Error message:

    Error: Missing required columns: In Bed Time

Solution: Check your column names match exactly:

- Subject Name

- In Bed Time

- Out Bed Time

Column names are case-sensitive.

#### Issue 3: Insufficient Data Warning

Warning message:

    Warning: Subject A001 has fewer than 2 periods. Skipping.

Explanation: Wake period calculation requires at least 2 sleep periods
per subject. Subjects with only 1 sleep period are skipped.

Action: Review why the subject has limited data (short monitoring
period, device removal, or algorithm failure).

## Getting Help

### Documentation

- **Function help**: Type
  [`?sleepwaker`](https://rdazadda.github.io/sleepwaker/reference/sleepwaker.md)
  in R console
- **Package overview**: Type
  [`help(package = "sleepwaker")`](https://rdazadda.github.io/sleepwaker/reference)
- **Online reference**: <https://rdazadda.github.io/sleepwaker/>

### Support

- **Report bugs**: [GitHub
  Issues](https://github.com/rdazadda/sleepwaker/issues)
- **Ask questions**: [GitHub
  Discussions](https://github.com/rdazadda/sleepwaker/discussions)
- **Email**: <rdazadda@alaska.edu>

### Citation

If you use **`sleepwaker`** in your research, please cite:

    Azadda, R.D., Grogan-Kaylor, A., & Lee, K. (2025). sleepwaker:
      Detect Sleep and Wake Periods from Accelerometry Data.
      R package version 0.1.0. https://github.com/rdazadda/sleepwaker

**Good luck with your research!**
