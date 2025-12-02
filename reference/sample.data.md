# Real ActiGraph Batch Sleep Export Data

Complete, unprocessed ActiGraph ActiLife batch sleep export data showing
the actual format users receive from ActiLife software. Contains all
columns from the standard batch export. The sleepwaker package
automatically extracts the three required columns (Subject Name, In Bed
Time, Out Bed Time).

## Usage

``` r
sample.data
```

## Format

A data frame with sleep period data from ActiGraph ActiLife. Contains
standard ActiGraph batch sleep export columns including subject
identifiers, sleep/wake times, sleep efficiency metrics, and demographic
information. See ActiLife documentation for complete column
descriptions.

## Source

Real ActiGraph ActiLife batch sleep export (de-identified)

## Examples

``` r
# Load real raw data
data(sample.data)

# View structure
str(sample.data)
#> spc_tbl_ [15 × 22] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
#>  $ Subject Name                    : chr [1:15] "A001" "A001" "A001" "A001" ...
#>  $ File Name                       : chr [1:15] "MOS2E39230594 (2025-10-14)60sec.agd" "MOS2E39230594 (2025-10-14)60sec.agd" "MOS2E39230594 (2025-10-14)60sec.agd" "MOS2E39230594 (2025-10-14)60sec.agd" ...
#>  $ Serial Number                   : chr [1:15] "MOS2E39230594" "MOS2E39230594" "MOS2E39230594" "MOS2E39230594" ...
#>  $ Epoch Length                    : num [1:15] 60 60 60 60 60 60 60 60 60 60 ...
#>  $ Weight                          : num [1:15] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ Age                             : num [1:15] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ Gender                          : chr [1:15] "Female" "Female" "Female" "Female" ...
#>  $ Sleep/Wake Algorithm            : chr [1:15] "Cole-Kripke" "Cole-Kripke" "Cole-Kripke" "Cole-Kripke" ...
#>  $ Sleep Period Detection Algorithm: chr [1:15] "Tudor-Locke Default" "Tudor-Locke Default" "Tudor-Locke Default" "Tudor-Locke Default" ...
#>  $ In Bed Time                     : chr [1:15] "10/07/2025 10:45:00 PM" "10/08/2025 07:55:00 AM" "10/08/2025 11:34:00 PM" "10/09/2025 11:46:00 PM" ...
#>  $ Out Bed Time                    : chr [1:15] "10/08/2025 07:09:00 AM" "10/08/2025 10:56:00 AM" "10/09/2025 07:50:00 AM" "10/10/2025 07:02:00 AM" ...
#>  $ Efficiency                      : num [1:15] 92.7 84.5 96.2 95.2 88.2 ...
#>  $ Onset                           : chr [1:15] "10/7/2025 22:45" "10/8/2025 7:55" "10/8/2025 23:34" "10/9/2025 23:46" ...
#>  $ Latency                         : num [1:15] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ Total Sleep Time                : num [1:15] 504 181 496 436 321 163 436 165 261 356 ...
#>  $ WASO                            : num [1:15] 37 28 19 21 38 49 91 36 31 54 ...
#>  $ Number of Awakenings            : num [1:15] 10 12 10 9 15 21 21 9 9 15 ...
#>  $ Length of Awakenings in Minutes : num [1:15] 3.7 2.33 1.9 2.33 2.53 2.33 4.33 4 3.44 3.6 ...
#>  $ Activity Counts                 : num [1:15] 18264 22565 11943 12260 17537 ...
#>  $ Movement Index                  : num [1:15] 11.11 56.91 8.27 8.72 13.08 ...
#>  $ Fragmentation Index             : num [1:15] 0 23.1 18.2 0 12.5 ...
#>  $ Sleep Fragmentation Index       : num [1:15] 11.11 79.98 26.45 8.72 25.58 ...
#>  - attr(*, "spec")=List of 3
#>   ..$ cols   :List of 22
#>   .. ..$ Subject Name                    : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ File Name                       : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Serial Number                   : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Epoch Length                    : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Weight                          : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Age                             : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Gender                          : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Sleep/Wake Algorithm            : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Sleep Period Detection Algorithm: list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ In Bed Time                     : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Out Bed Time                    : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Efficiency                      : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Onset                           : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
#>   .. ..$ Latency                         : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Total Sleep Time                : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ WASO                            : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Number of Awakenings            : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Length of Awakenings in Minutes : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Activity Counts                 : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Movement Index                  : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Fragmentation Index             : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   .. ..$ Sleep Fragmentation Index       : list()
#>   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
#>   ..$ default: list()
#>   .. ..- attr(*, "class")= chr [1:2] "collector_guess" "collector"
#>   ..$ delim  : chr ","
#>   ..- attr(*, "class")= chr "col_spec"
#>  - attr(*, "problems")=<externalptr> 

# Convert to sleep periods
sleep_periods <- sleepwaker(sample.data,
                            input.type = "raw",
                            output.type = "sleep")

# Convert to wake periods
wake_periods <- sleepwaker(sample.data,
                           input.type = "raw",
                           output.type = "wake")
```
