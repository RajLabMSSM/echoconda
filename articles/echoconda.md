# echoconda: Getting Started

``` r

library(echoconda)
```

## Introduction

`echoconda` provides robust utilities to find, build, use, and export
conda environments from within R. It wraps `reticulate` and `basilisk`
to give a consistent, cross-platform interface for managing Python
dependencies needed by the echoverse tool suite.

## Conda

### Install conda

If conda is not yet available on your system, `echoconda` can install
Miniconda for you:

``` r

echoconda::install_conda()
```

### Build an environment from YAML

Will build the “echoR_mini” conda environment by default.

``` r

conda_env <- echoconda::yaml_to_env("echoR_mini")
```

### Export an environment to YAML

``` r

yaml_path <- echoconda::env_to_yaml(conda_env = "echoR_mini")
```

### Activate a conda environment

``` r

echoconda::activate_env(conda_env = "echoR_mini")
```

### List available environments

``` r

envs <- echoconda::list_envs()
print(envs)
```

### Find packages in an environment

``` r

pkgs <- echoconda::find_packages(
  packages = c("python", "tabix", "axel"),
  conda_env = "echoR_mini"
)
knitr::kable(pkgs)
```

### Find the Python path

``` r

python <- echoconda::find_python_path(conda_env = "echoR_mini")
print(python)
```

## Import CLI tools

In addition, `echoconda` can automatically convert command-line
interface (CLI) tools into R functions.

### Example: tabix

Here we use a conda-installed version of `tabix` as an example.

``` r

#### Import tool ####
tabix <- echoconda::import_cli(
  path = "tabix",
  conda_env = "echoR_mini"
)

#### Use function to query a file ####
target_path <- system.file("extdata", "BST1.1KGphase3.vcf.bgz",
                           package = "echodata")
query <- "4:5000-100000000"

res <- tabix(D = TRUE,
             h = TRUE,
             ... = paste(target_path, query))
dat <- data.table::fread(text = res, skip = "#CHROM")
```

## Session Info

``` r

utils::sessionInfo()
#> R Under development (unstable) (2026-03-12 r89607)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.4 LTS
#> 
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
#> LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
#> 
#> time zone: UTC
#> tzcode source: system (glibc)
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] echoconda_1.0.0  BiocStyle_2.39.0
#> 
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.3.2           sass_0.4.10           generics_0.1.4       
#>  [4] stringi_1.8.7         lattice_0.22-9        hms_1.1.4            
#>  [7] digest_0.6.39         magrittr_2.0.4        evaluate_1.0.5       
#> [10] grid_4.6.0            bookdown_0.46         fastmap_1.2.0        
#> [13] R.oo_1.27.1           jsonlite_2.0.0        Matrix_1.7-4         
#> [16] zip_2.3.3             R.utils_2.13.0        BiocManager_1.30.27  
#> [19] purrr_1.2.1           textshaping_1.0.5     jquerylib_0.1.4      
#> [22] cli_3.6.5             rlang_1.1.7           basilisk.utils_1.23.1
#> [25] R.methodsS3_1.8.2     cachem_1.1.0          yaml_2.3.12          
#> [28] otel_0.2.0            tools_4.6.0           dir.expiry_1.19.0    
#> [31] parallel_4.6.0        tzdb_0.5.0            memoise_2.0.1        
#> [34] dplyr_1.2.0           DT_0.34.0             filelock_1.0.3       
#> [37] basilisk_1.23.0       reticulate_1.45.0     vctrs_0.7.1          
#> [40] R6_2.6.1              echodata_1.0.0        png_0.1-8            
#> [43] lifecycle_1.0.5       stringr_1.6.0         fs_1.6.7             
#> [46] htmlwidgets_1.6.4     ragg_1.5.1            pkgconfig_2.0.3      
#> [49] desc_1.4.3            pkgdown_2.2.0         bslib_0.10.0         
#> [52] pillar_1.11.1         openxlsx_4.2.8.1      data.table_1.18.2.1  
#> [55] glue_1.8.0            Rcpp_1.1.1            systemfonts_1.3.2    
#> [58] xfun_0.56             tibble_3.3.1          tidyselect_1.2.1     
#> [61] knitr_1.51            htmltools_0.5.9       piggyback_0.1.5      
#> [64] rmarkdown_2.30        readr_2.2.0           compiler_4.6.0
```

\
