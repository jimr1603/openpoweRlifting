
# openpoweRlifting

<!-- badges: start -->
<!-- badges: end -->

The goal of openpoweRlifting is to simplify downloading and caching the [Open Powerlifting](https://www.openpowerlifting.org/) daily datasets. 

## Installation

You can install the development version of openpoweRlifting from [GitHub](https://github.com/jimr1603/openpoweRlifting) with

``` r
remotes::install_github("jimr1603/openpoweRlifting")
```

## Example

Currently the package provides 1 function: `pin_opl` which will download either the IPF-affiliates data (default), or all meets. 

``` r
library(openpoweRlifting)
## basic example code

# Download & "pin" latest data for IPF-affiliates:
pin_opl()

# Read the data
opl = pin_read(board_local(), "opl-ipf")

## Do some analysis:
...
```

