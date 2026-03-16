# Create yaml file from env

Export a yaml file from a conda environment.

## Usage

``` r
env_to_yaml(
  conda_env,
  yaml_path = file.path(tempdir(), "conda.yml"),
  conda = "auto",
  method = c("reticulate", "basilisk"),
  verbose = TRUE,
  ...
)
```

## Source

[GitHub Issue](https://github.com/rstudio/reticulate/issues/779)

[GitHub
Issue](https://github.com/datitran/object_detector_app/issues/41)

## Arguments

- conda_env:

  Name of the conda environment to export.

- yaml_path:

  Path to write yaml file to.

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

- ...:

  Additional arguments passed to
  [conda_create](https://rstudio.github.io/reticulate/reference/conda-tools.html).

## See also

Other conda:
[`activate_env()`](https://rajlabmssm.github.io/echoconda/reference/activate_env.md),
[`find_env_rlib()`](https://rajlabmssm.github.io/echoconda/reference/find_env_rlib.md),
[`yaml_to_env()`](https://rajlabmssm.github.io/echoconda/reference/yaml_to_env.md)

## Examples

``` r
if (FALSE) { # \dontrun{
path <- env_to_yaml(conda_env="base")
} # }
```
