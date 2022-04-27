prep_pkg_names <- function(x){
    gsub("^r-*|^bioconductor-*|_|-|[.]","",tolower(x))
}