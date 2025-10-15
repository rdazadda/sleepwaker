
# sleepwaker

Invert sleep periods to wake periods from accelerometry data in
particular Actigraph Data.

## Why?

When analyzing 24-hour accelerometry data, sleep periods inflate
sedentary time estimates and using others measures by Actilife software
did not prove real good. **sleepwaker** solves this by converting sleep
periods to wake periods, enabling analysis of waking behavior only by
using this in the subject log diary to restrict the analysis on wake
periods.

## Installation

``` r
# Install from GitHub
devtools::install_github("rdazadda/sleepwaker")
```

## Quick Example

``` r
library(sleepwaker)
library(readr)

# Load ActiGraph batch sleep export
data <- read_csv("BatchSleepExportDetails.csv")

# Convert sleep to wake periods
wake_periods <- sleepwaker(data, 
                           input.type = "raw", 
                           output.type = "wake")
```

## Features

- **One-step processing** from batch export to wake periods
- **Works with** Cole-Kripke and Sadeh algorithms
- **Handles multiple subjects** automatically
- **Export directly** to CSV for analysis

## Learn More

- [Getting Started
  Guide](https://rdazadda.github.io/sleepwaker/articles/getting-started.html)
- [Function
  Reference](https://rdazadda.github.io/sleepwaker/reference/index.html)

## Citation

    Azadda, R.D. (2025). sleepwaker: Invert Sleep and Wake Periods 
      from Accelerometry Data. R package version 0.1.0.
      https://github.com/rdazadda/sleepwaker

## Contact

- **Report issues**: [GitHub
  Issues](https://github.com/rdazadda/sleepwaker/issues)
- **Email**: <rdazadda@alaska.edu>

------------------------------------------------------------------------

## Acknowledgments

This package was developed at the **Center for Alaska Native Health
Research (CANHR)**, University of Alaska Fairbanks.

**Principal Advisor:** Andrew (Andy) Grogan-Kaylor

**Developer:** Raymond Dacosta Azadda

This work was supported by research conducted at CANHR. I acknowledge
the Numbers Team in particluar Prof. Andrew (Andy) Grogan-Kaylor and
KyungSook Lee, PhD for their guidance, mentorship, and contributions to
the development of this package.

## Contact

- **Developer**: Raymond Dacosta Azadda (<rdazadda@alaska.edu>)
- **Report Issues**: [GitHub
  Issues](https://github.com/rdazadda/sleepwaker/issues)

------------------------------------------------------------------------

**Affiliation:** Center for Alaska Native Health Research (CANHR)  
**Institution:** University of Alaska Fairbanks
