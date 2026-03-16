# List conda envs

List all available conda environments.

## Usage

``` r
list_envs(
  conda = "auto",
  conda_env = NULL,
  method = c("basilisk", "reticulate")
)
```

## Arguments

- conda:

  The path to a `conda` executable. Use `"auto"` to allow `reticulate`
  to automatically find an appropriate `conda` binary. See **Finding
  Conda** and
  [`conda_binary()`](https://rstudio.github.io/reticulate/reference/conda-tools.html)
  for more details.

- conda_env:

  \[Optional\] A specific conda environment to search for.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`
