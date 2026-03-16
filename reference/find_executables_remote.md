# Find remotely stored executable(s)

Find the path to one or more executable binary for each given software.

## Usage

``` r
find_executables_remote(
  path = NULL,
  tool = c("bcftools", "gcta", "plink"),
  verbose = TRUE
)
```

## Arguments

- path:

  User-provided path to executable. Is `NULL` (default), an executable
  will be downloaded and stored automatically.

- verbose:

  Print messages.

## Value

Path to executable.

## Examples

``` r
if (FALSE) { # \dontrun{
paths <- find_executables_remote()
} # }
```
