# Activate conda env

[use_condaenv](https://rstudio.github.io/reticulate/reference/use_python.html)
often [doesn't work in
practice](https://github.com/rstudio/reticulate/issues/292), especially
within RStudio. activate_env ensures the env is actually activated and
used.

## Usage

``` r
activate_env(
  conda_env = "echoR_mini",
  method = c("basilisk", "reticulate"),
  verbose = TRUE
)
```

## Source

[GH Issues](https://github.com/rstudio/reticulate/issues/1147)

[GH Issues](https://github.com/rstudio/reticulate/issues/1044)

[GH Issues](https://github.com/rstudio/reticulate/issues/292)

## Arguments

- conda_env:

  Conda environment to use.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`

- verbose:

  Print messages.

## See also

Other conda:
[`env_to_yaml()`](https://rajlabmssm.github.io/echoconda/reference/env_to_yaml.md),
[`find_env_rlib()`](https://rajlabmssm.github.io/echoconda/reference/find_env_rlib.md),
[`yaml_to_env()`](https://rajlabmssm.github.io/echoconda/reference/yaml_to_env.md)

## Examples

``` r
if (FALSE) { # \dontrun{
conda_env <- echoconda::activate_env(conda_env = "echoR_mini")
} # }
```
