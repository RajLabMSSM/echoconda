# List conda envs

Alternative method for finding packages without relying on the
(currently) internal function `reticulate::conda_list_packages`.

## Usage

``` r
list_packages(
  packages = NULL,
  conda_env,
  method = c("r", "reticulate", "basilisk"),
  conda = "auto",
  verbose = TRUE
)
```

## Arguments

- packages:

  A package (e.g. `"pandas"`) or a list of packages (e.g.
  `c("pandas","r-dplyr","bgzip")`). Will recognize R packages with or
  without the prefixes "r-" and "bioconductor-" (i.e. "r-dplyr" is
  equivalent to "dplyr").

- conda_env:

  Conda environments to search in. If `NULL` (default), will search all
  conda environments.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`

- conda:

  The path to a `conda` executable. Use `"auto"` to allow `reticulate`
  to automatically find an appropriate `conda` binary. See **Finding
  Conda** and
  [`conda_binary()`](https://rstudio.github.io/reticulate/reference/conda-tools.html)
  for more details.

- verbose:

  Print messages.
