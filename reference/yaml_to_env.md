# Create conda env from yaml file

Create a conda environment from a yaml file. By default, creates the
"echoR" conda env to support echolocatoR.

## Usage

``` r
yaml_to_env(
  yaml_path = system.file(package = "echoconda", "conda", "echoR_mini.yml"),
  method = c("basilisk", "reticulate"),
  conda = "auto",
  force_new = FALSE,
  show_contents = FALSE,
  verbose = TRUE,
  ...
)
```

## Source

[GitHub Issue](https://github.com/rstudio/reticulate/issues/779)

[StackOverflow suggestions for cross-platform
troubleshooting](https://stackoverflow.com/questions/35802939/install-only-available-packages-using-conda-install-yes-file-requirements-t)

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

- show_contents:

  Show the contents of the yaml file (if used).

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

## See also

Other conda:
[`activate_env()`](https://rajlabmssm.github.io/echoconda/reference/activate_env.md),
[`env_to_yaml()`](https://rajlabmssm.github.io/echoconda/reference/env_to_yaml.md),
[`find_env_rlib()`](https://rajlabmssm.github.io/echoconda/reference/find_env_rlib.md)

## Examples

``` r
if (FALSE) { # \dontrun{
conda_env <- yaml_to_env()
} # }
```
