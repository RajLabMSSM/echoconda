# Import Command Line Interface tool

Import a Command Line Interface (CLI) tool into R as a function.

## Usage

``` r
import_cli(path, fix_names = TRUE, conda_env = NULL, verbose = TRUE)
```

## Source

[Stack Overflow](https://stackoverflow.com/a/12983961/13214824)

[Function factories](https://adv-r.hadley.nz/function-factories.html)

[Dynamic roxygen notes](https://github.com/r-lib/roxygen2/issues/798)

[match.call](https://stackoverflow.com/q/29327423/13214824)

## Arguments

- path:

  Path to CLI tool executable file (preferred), or simply the tool name.

- fix_names:

  Map argument names to R-friendly versions.

- conda_env:

  Conda environments to search in. If `NULL` (default), will search all
  conda environments.

- verbose:

  Print messages.

## Examples

``` r
if (FALSE) { # \dontrun{
mycurl <- import_cli(path="curl")
mycurl(h = TRUE)
mycurl(url= file.path("http://hgdownload.soe.ucsc.edu/goldenPath",
                           "hg38/multiz100way/md5sum.txt"),
       o="~/Downloads/tmp.txt")
} # }
```
