# Find the python file for a specific env

Find the python file for a specific env

## Usage

``` r
find_python_path(
  conda_env = "echoR_mini",
  method = c("basilisk", "reticulate"),
  verbose = TRUE
)
```

## Arguments

- conda_env:

  Conda environment name.

- method:

  Method to use:

  - `"basilisk"`

  - `"reticulate"`

- verbose:

  Print messages.

## Examples

``` r
if (FALSE) { # \dontrun{
# importFrom reticulate conda_list
python <- find_python_path(conda_env = "echoR")
} # }
```
