#' Install conda: reticulate
#'
#' Install conda if it has not already been installed.
#' @param verbose Print messages.
#' @param ... Additional arguments to be passed to 
#' \link[reticulate]{install_miniconda}.
#' @inheritParams reticulate::conda_version
#' 
#' @source 
#' \href{https://github.com/rstudio/reticulate/issues/1055}{
#' reticulate GitHub Issue.}
#' \href{https://github.com/conda/conda/issues/5388}{
#' conda GitHub Issue.}
#' 
#' @keywords internal
#' @importFrom reticulate install_miniconda conda_version
install_conda_reticulate <- function(conda,
                                     verbose=TRUE,
                                     ...){
    try({
        conda_version <- reticulate::conda_version(conda = conda)
    })
    if (is.null(conda_version) || conda=="auto") {
        messager("echoconda:: Installing conda via reticulate.",
                 v=verbose)
        if(is.null(conda)) conda <- "auto"
        reticulate::install_miniconda(path = conda,
                                      ...)
    } else {
        messager("echoconda:: conda already installed.",
                 v=verbose)
    }
}
