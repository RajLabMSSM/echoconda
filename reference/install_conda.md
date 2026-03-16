# Install conda

Install conda if it has not already been installed.

## Usage

``` r
install_conda(
  method = c("basilisk", "reticulate"),
  conda = "auto",
  verbose = TRUE,
  ...
)
```

## Arguments

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

- ...:

  Additional arguments to be passed to
  [install_miniconda](https://rstudio.github.io/reticulate/reference/install_miniconda.html).

## Examples

``` r
if (FALSE) { # \dontrun{
echoconda::install_conda()
} # }
```
