# Create conda env

Create conda env using one of several methods.

## Usage

``` r
create_env(
  conda_env,
  yaml_path,
  method = c("basilisk", "reticulate", "cli"),
  conda = "auto",
  force_new = FALSE,
  verbose = TRUE,
  ...
)
```

## Arguments

- yaml_path:

  Path to local or remote yaml file with conda build specifications.

- method:

  Method to use to create the conda env:

  "basilisk" :

  :   Uses the R package basilisk.

  "reticulate" :

  :   Uses the R package reticulate.

  "cli" :

  :   Uses a custom wrapper for conda's command line interface.

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

- ...:

  Additional arguments passed to method-specific conda env build
  functions:

  - `basilisk`:
    [create_env_basilisk](https://rajlabmssm.github.io/echoconda/reference/create_env_basilisk.md)

  - `reticulate`:
    [conda_create](https://rstudio.github.io/reticulate/reference/conda-tools.html)

  - `cli`:
    [create_env_cli](https://rajlabmssm.github.io/echoconda/reference/create_env_cli.md)
