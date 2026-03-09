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
    conda_version <- NULL
    try({
        conda_version <- reticulate::conda_version(conda = conda)
    })
    if (is.null(conda_version)) {
        messager("echoconda:: Installing conda via reticulate.",
                 v=verbose)
        if(is.null(conda) || conda == "auto") {
            ## Use reticulate's default miniconda path,
            ## not the literal string "auto".
            reticulate::install_miniconda(...)
        } else {
            reticulate::install_miniconda(path = conda, ...)
        }
    } else {
        messager("echoconda:: conda already installed.",
                 v=verbose)
    }
}
