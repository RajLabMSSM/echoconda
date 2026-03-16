# Neatly print commands

Neatly print commands sent to the command line.

## Usage

``` r
cmd_print(
  cmd,
  raw = FALSE,
  basepath = TRUE,
  prefix = "...",
  wrap = "\n   ",
  verbose = TRUE
)
```

## Arguments

- cmd:

  Command string or list of strings.

- raw:

  Print the raw `cmd` text.

- basepath:

  For each component of `cmd` that is a path, shorten the path to just
  the basename.

- prefix:

  When `basepath=TRUE`, append a prefix to the path.

- wrap:

  If `wrap` is not `NULL`, use this to separate arguments with newlines.

- verbose:

  Print messages.

## Examples

``` r
cmd_print("fastqc -d ./fastqc_temp -o ${workdir}
          /fastqFileQC/${sample_name} -f fastq")
#> fastqc
#>     -d .../fastqc_temp
#>     -o ${workdir}
#>  .../${sample_name}
#>     -f fastq
```
