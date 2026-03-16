# Find conda

Find conda executable from multiple installations: reticulate, basilisk

## Usage

``` r
find_conda(conda = "auto", method = c("basilisk", "reticulate"))
```

## Arguments

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
