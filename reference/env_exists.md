# Check whether a conda env exists

An extension of the internal function `reticulate:::condaenv_exists()`.

## Usage

``` r
env_exists(
  conda_env = NULL,
  conda = "auto",
  method = c("basilisk", "reticulate")
)
```

## Source

<https://github.com/rstudio/reticulate/blob/577acd2dfd43b48720037eb0851f20e377dbb802/R/conda.R#L494>

## Arguments

- conda_env:

  Name of the conda environment.

- conda:

  Path to conda executable.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`

## Examples

``` r
if (FALSE) { # \dontrun{
does_exist <- env_exists(conda_env = "echoR")
} # }
```
