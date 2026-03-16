# List included yaml files

List the yaml files included within `echconda`. These are provided to
make different conda environments that are useful for specific
workflows.

## Usage

``` r
list_yamls(verbose = TRUE)
```

## Arguments

- verbose:

  Print messages.

## Examples

``` r
yamls <- echoconda::list_yamls()
#> 34 conda yamls available:
#>  - cellblast
#>  - cellxgene
#>  - echoR
#>  - echoR_mini
#>  - echoR
#>  - epiprepare
#>  - ewce_suite
#>  - gcae
#>  - goshifter
#>  - nfcore
#>  - onclass
#>  - ontogpt
#>  - pegasus
#>  - plotly
#>  - polyfun
#>  - pumap
#>  - pyre
#>  - pytorch
#>  - bioc
#>  - saturn
#>  - scanpy
#>  - scgpt
#>  - scvi
#>  - seurat1
#>  - seurat2
#>  - seurat3
#>  - seurat4
#>  - tensorflow_metal
#>  - test
#>  - test_bad
#>  - uce
#>  - uce
#>  - ukb
#>  - vep
```
