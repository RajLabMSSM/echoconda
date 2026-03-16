# Create conda env from yaml: CLI

Original function for creating conda env from yaml before this was
implemented in
[conda_create](https://rstudio.github.io/reticulate/reference/conda-tools.html).

## Usage

``` r
create_env_cli(
  yaml_path = system.file(package = "echoconda", "conda/test.yml"),
  conda = "auto",
  force_new = FALSE,
  verbose = TRUE
)
```

## Source

[StackOverflow suggestions for cross-platform
troubleshooting](https://stackoverflow.com/questions/35802939/install-only-available-packages-using-conda-install-yes-file-requirements-t)

## Arguments

- yaml_path:

  Path to local or remote yaml file with conda build specifications.

- conda:

  The path to a `conda` executable. Use `"auto"` to allow `reticulate`
  to automatically find an appropriate `conda` binary. See **Finding
  Conda** and
  [`conda_binary()`](https://rstudio.github.io/reticulate/reference/conda-tools.html)
  for more details.

- force_new:

  If the conda env already exists, overwrite it with a new one
  (*DEFAULT*: `FALSE`).

- verbose:

  Print messages.
