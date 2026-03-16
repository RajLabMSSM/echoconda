# Remove conda environment

Actually remove conda environments, unlike
`reticulate`::[conda_remove](https://rstudio.github.io/reticulate/reference/conda-tools.html).

## Usage

``` r
remove_env(
  conda_env,
  conda = "auto",
  method = c("basilisk", "reticulate"),
  verbose = TRUE
)
```

## Arguments

- conda_env:

  Name of the conda environment.

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

- verbose:

  Print messages.
