# Find package across all conda envs

Search for a package (or list of packages) across all available conda
environments. By default, returns all packages from all conda
environments.

## Usage

``` r
find_packages(
  packages = NULL,
  conda_env = NULL,
  conda = "auto",
  method = c("r", "reticulate", "basilisk"),
  types = c("r", "python", "binary"),
  return_path = FALSE,
  robust = FALSE,
  filter_paths = FALSE,
  sort_names = FALSE,
  nThread = 1,
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

- conda:

  The path to a `conda` executable. Use `"auto"` to allow `reticulate`
  to automatically find an appropriate `conda` binary. See **Finding
  Conda** and
  [`conda_binary()`](https://rstudio.github.io/reticulate/reference/conda-tools.html)
  for more details.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`

- types:

  Path type to search for and include in the table.

- return_path:

  Return only the path to each package.

- robust:

  Uses a more robust (but slower) method for identifying paths to conda
  environments and package executables (default: `FALSE`). When
  `robust=FALSE`, only executables in the main "bin" directory will be
  detected. When `robust=TRUE`, additional executables to R packages,
  Python packages, and executables in nested subdirectories will be
  detected.

- filter_paths:

  Filter out packages without callable executable paths from the table.

- sort_names:

  Sort packages alphanumerically by their name.

- nThread:

  Number of threads to use when parallelizing searches across multiple
  conda envs.

- verbose:

  Print messages.

## Value

Merged data.table with all packages installed in each conda environment.

## Examples

``` r
if (FALSE) { # \dontrun{
pkgs <- echoconda::find_packages(conda_env="base")
} # }
```
