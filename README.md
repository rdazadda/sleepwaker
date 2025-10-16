
# sleepwaker

Automated processing of ActiGraph sleep data for behavioral/Physical
research

## Overview

**`Sleepwaker`** package processes batch sleep export data from
ActiGraph ActiLife software and converts it into formats suitable for
both sleep analysis and physical activity research. The package
addresses two critical needs:

1.  For Sleep Researchers: Automatically formats batch sleep exports
    into subject log diary format for sleep pattern analysis.
2.  For Activity Researchers: Inverts sleep periods to wake periods,
    enabling sedentary behavior and physical activity analysis
    constrained to waking hours only.

## The Problem We Solved

### Issue 1: Manual Data Formatting

ActiGraph ActiLife software exports sleep data detected by validated
algorithms (Cole-Kripke for adults, Sadeh for youth), but this batch
export format requires manual reformatting into subject log diary format
for most analyses. This manual process is time-consuming for large
datasets, error-prone, and not reproducible.

### Issue 2: Inflated Sedentary Time Estimates

When analyzing 24-hour accelerometry (Actigraph) data without excluding
sleep, sleep periods are misclassified as sedentary behavior, which
inflates sedentary time estimates. Standard ActiLife processing methods
cannot adequately handle populations with irregular sleep patterns,
making it hard for researchers to distinguish between sleep and true
waking sedentary behavior. This fundamental measurement problem leads to
invalid conclusions about sedentary patterns and their health
associations.

## The Solution

**`Sleepwaker`** provides two automated workflows:

### Workflow 1: Sleep Period Analysis

``` r
# Direct formatting for sleep research
sleep.periods <- sleepwaker(data, 
                            input.type = "raw", 
                            output.type = "sleep")
```

Converts batch sleep export → subject log diary format for sleep pattern
analysis

### Workflow 2: Wake Period Analysis

``` r
# Inversion for activity research
wake.periods <- sleepwaker(data, 
                           input.type = "raw", 
                           output.type = "wake")
```

Inverts sleep periods → wake periods, enabling analysis of waking
behavior only

## How It Works

**`Sleepwaker`** implements a three-step automated process:

1.  Extract: Reads batch sleep export data from ActiGraph ActiLife
    (Cole-Kripke or Sadeh algorithm output).
2.  Format: Converts to subject log diary format with separate date and
    time columns.
3.  Invert: Applies temporal inversion algorithm to generate wake
    periods from consecutive sleep episodes

**Key Innovation**: The inversion algorithm pairs consecutive sleep
periods chronologically, using the end time of sleep period *N* as the
start of the wake period, and the start time of sleep period *N+1* as
the end. This creates complement periods representing true waking hours.

## Why This Matters

### For Sleep Research

- Automates tedious data formatting, saving hours of manual work
- Ensures consistency and reproducibility across large studies
- Provides clean sleep period data ready for immediate analysis
- Maintains full compatibility with ActiLife sleep detection algorithms

### For Physical Activity Research

- Prevents sedentary time inflation by removing sleep from estimates
- Enables valid comparisons where sedentary behavior reflects only
  waking patterns
- Improves measurement validity by distinguishing true sedentary
  behavior from sleep
- Fills a critical methodological gap with no existing solutions

This methodology addresses a fundamental limitation in
accelerometry-based sedentary behavior assessment and has been validated
in our ongoing research at the Center for Alaska Native Health Research.

## Learn More

- [Getting Started
  Guide](https://rdazadda.github.io/sleepwaker/articles/getting-started.html) -
  Installation, examples, and complete workflows
- [Function
  Reference](https://rdazadda.github.io/sleepwaker/reference/index.html) -
  Detailed documentation for all functions

## Citation

If you use **`sleepwaker`** in your research, please cite:

    Azadda, R.D. (2025). sleepwaker: Invert Sleep and Wake Periods from 
      Accelerometry Data. R package version 0.1.0.
      https://github.com/rdazadda/sleepwaker

## Acknowledgments

This package was developed by the Numbers Team at the Center for Alaska
Native Health Research (CANHR), University of Alaska Fairbanks.

## Contact

- **Developer**: Raymond Dacosta Azadda  
- **Email**: <rdazadda@alaska.edu>
- **Report Issues**: [GitHub
  Issues](https://github.com/rdazadda/sleepwaker/issues)

------------------------------------------------------------------------

**Affiliation**: Center for Alaska Native Health Research (CANHR)  
**Institution**: University of Alaska Fairbanks
