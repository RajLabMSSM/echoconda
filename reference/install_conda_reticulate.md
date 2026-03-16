# Install conda: reticulate

Install conda if it has not already been installed.

## Usage

``` r
install_conda_reticulate(conda, verbose = TRUE, ...)
```

## Source

[reticulate GitHub
Issue.](https://github.com/rstudio/reticulate/issues/1055) [conda GitHub
Issue.](https://github.com/conda/conda/issues/5388)

## Arguments

- conda:

  The path to a `conda` executable. Use `"auto"` to allow `reticulate`
  to automatically find an appropriate `conda` binary. See **Finding
  Conda** and
  [`conda_binary()`](https://rstudio.github.io/reticulate/reference/conda-tools.html)
  for more details.

- verbose:

  Print messages.

- ...:

  Additional arguments to be passed to
  [install_miniconda](https://rstudio.github.io/reticulate/reference/install_miniconda.html).
